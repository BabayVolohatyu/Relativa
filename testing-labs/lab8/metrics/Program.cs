using System.Text.Json;
using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp;
using Microsoft.CodeAnalysis.CSharp.Syntax;

var repo = ".";
var outDir = "lab8/evidence";
var snapshot = "baseline";
for (var i = 0; i < args.Length; i++)
{
    switch (args[i])
    {
        case "--repo":
            repo = args[++i];
            break;
        case "--out":
            outDir = args[++i];
            break;
        case "--snapshot":
            snapshot = args[++i];
            break;
        default:
            Console.Error.WriteLine($"Unknown argument: {args[i]}");
            return 1;
    }
}

repo = Path.GetFullPath(repo);
Directory.CreateDirectory(outDir);

var files = SourceFiles(repo).ToList();
var units = files.Select(path =>
{
    var text = File.ReadAllText(path);
    var relative = Path.GetRelativePath(repo, path).Replace('\\', '/');
    return (Relative: relative, Tree: CSharpSyntaxTree.ParseText(text, path: relative));
}).ToList();

var parsed = new List<TypeModel>();
foreach (var unit in units)
{
    var root = unit.Tree.GetRoot();
    foreach (var declaration in root.DescendantNodes().OfType<TypeDeclarationSyntax>())
        parsed.Add(ReadType(declaration, unit.Relative));
}

var types = MergePartials(parsed);
var byId = types.ToDictionary(type => type.Id);
var bySimple = types.GroupBy(type => type.SimpleName).ToDictionary(group => group.Key, group => group.ToList());

foreach (var type in types)
    Finish(type, byId, bySimple);

ApplyLizard(repo, types);

var mood = ComputeMood(types);
var jsonOptions = new JsonSerializerOptions { WriteIndented = true };

WriteSnapshot(snapshot, types, mood, outDir, jsonOptions);
PrintSummary(snapshot, types, mood);
return AssertSnapshot(snapshot, types);

static IEnumerable<string> SourceFiles(string repo)
{
    var skip = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
    {
        "bin", "obj", "node_modules", ".git", ".sonarqube", ".vs", "TestResults",
    };

    IEnumerable<string> Walk(string dir)
    {
        if (skip.Contains(Path.GetFileName(dir)))
            yield break;

        IEnumerable<string> files;
        try
        {
            files = Directory.EnumerateFiles(dir, "*.cs");
        }
        catch (UnauthorizedAccessException)
        {
            yield break;
        }

        foreach (var file in files)
        {
            var relative = Path.GetRelativePath(repo, file).Replace('\\', '/');
            if (relative.Contains("/src/", StringComparison.Ordinal) &&
                !relative.Contains("/Migrations/", StringComparison.Ordinal) &&
                !relative.Contains("/tests/", StringComparison.Ordinal) &&
                !relative.EndsWith(".Designer.cs", StringComparison.Ordinal))
                yield return file;
        }

        IEnumerable<string> children;
        try
        {
            children = Directory.EnumerateDirectories(dir);
        }
        catch (UnauthorizedAccessException)
        {
            yield break;
        }

        foreach (var child in children)
        {
            foreach (var file in Walk(child))
                yield return file;
        }
    }

    return Walk(repo);
}

static TypeModel ReadType(TypeDeclarationSyntax declaration, string file)
{
    var simple = declaration.Identifier.ValueText;
    var arity = declaration.TypeParameterList?.Parameters.Count ?? 0;
    var ns = declaration.Ancestors().OfType<BaseNamespaceDeclarationSyntax>().FirstOrDefault()?.Name.ToString() ?? "";
    var model = new TypeModel
    {
        SimpleName = simple,
        Arity = arity,
        Namespace = ns,
        File = file,
        Kind = KindOf(declaration),
        Bases = declaration.BaseList?.Types.Select(type => SimpleNameOf(type.Type)).Where(name => name.Length > 0).Distinct().ToList()
            ?? [],
    };

    AddPrimaryFields(declaration, model);
    AddMembers(declaration, model);

    model.TypeNames = declaration.DescendantNodes()
        .OfType<TypeSyntax>()
        .Where(type => BelongsTo(type, declaration) && IsTypePosition(type))
        .SelectMany(NamesOf)
        .Distinct()
        .ToList();
    return model;
}

static void AddPrimaryFields(TypeDeclarationSyntax declaration, TypeModel model)
{
    if (declaration.ParameterList is null)
        return;
    foreach (var parameter in declaration.ParameterList.Parameters)
        AddPrimaryField(parameter, model);
}

static void AddPrimaryField(ParameterSyntax parameter, TypeModel model)
{
    if (parameter.Type is null || parameter.Identifier.ValueText.Length == 0)
        return;
    model.Fields.Add(new FieldModel
    {
        Name = parameter.Identifier.ValueText,
        Accessibility = "private",
        IsStatic = false,
        TypeNames = NamesOf(parameter.Type).ToList(),
    });
}

static void AddMembers(TypeDeclarationSyntax declaration, TypeModel model)
{
    var defaultPublic = declaration is InterfaceDeclarationSyntax;
    foreach (var member in declaration.Members)
        AddMember(member, model, defaultPublic);
}

static void AddMember(MemberDeclarationSyntax member, TypeModel model, bool defaultPublic)
{
    if (member is FieldDeclarationSyntax field)
    {
        AddField(field, model);
        return;
    }
    if (member is MethodDeclarationSyntax method)
    {
        model.Methods.Add(ReadMethod(method, defaultPublic));
        return;
    }
    if (member is ConstructorDeclarationSyntax constructor)
        model.Methods.Add(ReadConstructor(constructor));
}

static void AddField(FieldDeclarationSyntax field, TypeModel model)
{
    var access = Accessibility(field.Modifiers, defaultPublic: false);
    var isStatic = field.Modifiers.Any(SyntaxKind.StaticKeyword);
    foreach (var variable in field.Declaration.Variables)
    {
        model.Fields.Add(new FieldModel
        {
            Name = variable.Identifier.ValueText,
            Accessibility = access,
            IsStatic = isStatic,
            TypeNames = NamesOf(field.Declaration.Type).ToList(),
        });
    }
}

static MethodModel ReadMethod(MethodDeclarationSyntax method, bool defaultPublic)
{
    var body = (SyntaxNode?)method.Body ?? method.ExpressionBody;
    return new MethodModel
    {
        Name = method.Identifier.ValueText,
        Accessibility = method.ExplicitInterfaceSpecifier is not null
            ? "public"
            : Accessibility(method.Modifiers, defaultPublic),
        IsStatic = method.Modifiers.Any(SyntaxKind.StaticKeyword),
        IsOverride = method.Modifiers.Any(SyntaxKind.OverrideKeyword),
        Ccn = 1 + DecisionCount(body),
        Reads = ReadsIn(body),
    };
}

static MethodModel ReadConstructor(ConstructorDeclarationSyntax constructor)
{
    var body = (SyntaxNode?)constructor.Body ?? constructor.ExpressionBody;
    return new MethodModel
    {
        Name = ".ctor",
        Accessibility = Accessibility(constructor.Modifiers, defaultPublic: false),
        IsConstructor = true,
        Ccn = 1 + DecisionCount(body),
        Reads = ReadsIn(body),
    };
}

static HashSet<string> ReadsIn(SyntaxNode? body)
{
    var reads = new HashSet<string>();
    if (body is null)
        return reads;
    foreach (var name in body.DescendantNodes().OfType<IdentifierNameSyntax>())
        reads.Add(name.Identifier.ValueText);
    return reads;
}

static int DecisionCount(SyntaxNode? node)
{
    if (node is null)
        return 0;
    var decisions = 0;
    foreach (var descendant in node.DescendantNodesAndSelf())
    {
        if (CountsAsDecision(descendant))
            decisions++;
    }
    return decisions;
}

static bool CountsAsDecision(SyntaxNode node)
{
    if (IsLoop(node))
        return true;
    if (IsSelection(node))
        return true;
    return IsBooleanOp(node);
}

static bool IsLoop(SyntaxNode node) =>
    node is WhileStatementSyntax
    || node is ForStatementSyntax
    || node is ForEachStatementSyntax
    || node is DoStatementSyntax;

static bool IsSelection(SyntaxNode node) =>
    node is IfStatementSyntax
    || node is CatchClauseSyntax
    || node is ConditionalExpressionSyntax
    || node is CaseSwitchLabelSyntax
    || node is CasePatternSwitchLabelSyntax
    || node is SwitchExpressionArmSyntax;

static bool IsBooleanOp(SyntaxNode node)
{
    if (node.IsKind(SyntaxKind.CoalesceExpression))
        return true;
    if (node is not BinaryExpressionSyntax binary)
        return false;
    if (binary.IsKind(SyntaxKind.LogicalAndExpression))
        return true;
    return binary.IsKind(SyntaxKind.LogicalOrExpression);
}

static bool BelongsTo(SyntaxNode node, TypeDeclarationSyntax owner)
{
    for (var current = node.Parent; current is not null && current != owner; current = current.Parent)
    {
        if (current is BaseTypeDeclarationSyntax)
            return false;
    }
    return true;
}

static bool IsTypePosition(SyntaxNode type)
{
    var parent = type.Parent;
    if (parent is BaseTypeSyntax)
        return true;
    if (parent is TypeArgumentListSyntax)
        return true;
    if (parent is VariableDeclarationSyntax)
        return true;
    if (parent is ParameterSyntax)
        return true;
    if (parent is MethodDeclarationSyntax)
        return true;
    if (parent is LocalFunctionStatementSyntax)
        return true;
    if (parent is ExplicitInterfaceSpecifierSyntax)
        return true;
    if (IsDeclaredType(parent))
        return true;
    return IsTypeOperator(parent);
}

static bool IsDeclaredType(SyntaxNode? parent)
{
    if (parent is PropertyDeclarationSyntax)
        return true;
    if (parent is EventDeclarationSyntax)
        return true;
    if (parent is IndexerDeclarationSyntax)
        return true;
    if (parent is ForEachStatementSyntax)
        return true;
    if (parent is ArrayTypeSyntax)
        return true;
    if (parent is NullableTypeSyntax)
        return true;
    if (parent is AttributeSyntax)
        return true;
    return parent is CatchDeclarationSyntax;
}

static bool IsTypeOperator(SyntaxNode? parent)
{
    if (parent is CastExpressionSyntax)
        return true;
    if (parent is ObjectCreationExpressionSyntax)
        return true;
    if (parent is TypeOfExpressionSyntax)
        return true;
    if (parent is not BinaryExpressionSyntax binary)
        return false;
    if (binary.IsKind(SyntaxKind.IsExpression))
        return true;
    return binary.IsKind(SyntaxKind.AsExpression);
}

static string KindOf(TypeDeclarationSyntax declaration) => declaration switch
{
    InterfaceDeclarationSyntax => "interface",
    StructDeclarationSyntax => "struct",
    RecordDeclarationSyntax record when record.ClassOrStructKeyword.IsKind(SyntaxKind.StructKeyword) => "record-struct",
    RecordDeclarationSyntax => "record",
    _ => "class",
};

static string Accessibility(SyntaxTokenList modifiers, bool defaultPublic)
{
    var isPrivate = modifiers.Any(SyntaxKind.PrivateKeyword);
    var isPublic = modifiers.Any(SyntaxKind.PublicKeyword);
    var isProtected = modifiers.Any(SyntaxKind.ProtectedKeyword);
    var isInternal = modifiers.Any(SyntaxKind.InternalKeyword);
    if (isPrivate && !isProtected)
        return "private";
    if (isProtected)
        return "protected";
    if (isInternal)
        return "internal";
    if (isPublic)
        return "public";
    return defaultPublic ? "public" : "private";
}

static IEnumerable<string> NamesOf(TypeSyntax type)
{
    switch (type)
    {
        case IdentifierNameSyntax identifier:
            yield return identifier.Identifier.ValueText;
            break;
        case GenericNameSyntax generic:
            yield return generic.Identifier.ValueText;
            foreach (var argument in generic.TypeArgumentList.Arguments)
            {
                foreach (var name in NamesOf(argument))
                    yield return name;
            }
            break;
        case QualifiedNameSyntax qualified:
            foreach (var name in NamesOf(qualified.Right))
                yield return name;
            break;
        case AliasQualifiedNameSyntax alias:
            foreach (var name in NamesOf(alias.Name))
                yield return name;
            break;
        case NullableTypeSyntax nullable:
            foreach (var name in NamesOf(nullable.ElementType))
                yield return name;
            break;
        case ArrayTypeSyntax array:
            foreach (var name in NamesOf(array.ElementType))
                yield return name;
            break;
        case TupleTypeSyntax tuple:
            foreach (var element in tuple.Elements)
            {
                foreach (var name in NamesOf(element.Type))
                    yield return name;
            }
            break;
        case RefTypeSyntax reference:
            foreach (var name in NamesOf(reference.Type))
                yield return name;
            break;
        case PointerTypeSyntax pointer:
            foreach (var name in NamesOf(pointer.ElementType))
                yield return name;
            break;
    }
}

static string SimpleNameOf(TypeSyntax type) => NamesOf(type).FirstOrDefault() ?? "";

static List<TypeModel> MergePartials(List<TypeModel> parsed)
{
    return parsed
        .GroupBy(type => type.Id)
        .Select(group =>
        {
            var first = group.First();
            if (group.Count() == 1)
                return first;
            first.File = string.Join(";", group.Select(type => type.File).Distinct().OrderBy(path => path));
            first.Bases = group.SelectMany(type => type.Bases).Distinct().ToList();
            first.Fields = group.SelectMany(type => type.Fields).ToList();
            first.Methods = group.SelectMany(type => type.Methods).ToList();
            first.TypeNames = group.SelectMany(type => type.TypeNames).Distinct().ToList();
            return first;
        })
        .OrderBy(type => type.Id)
        .ToList();
}

static void Finish(TypeModel type, Dictionary<string, TypeModel> byId, Dictionary<string, List<TypeModel>> bySimple)
{
    string? Resolve(string simple)
    {
        if (simple is "object" or "string" or "decimal" or "int" or "bool" or "DateTime" or "Guid" or "CancellationToken")
            return null;
        if (!bySimple.TryGetValue(simple, out var candidates))
            return null;
        var others = candidates.Where(candidate => candidate.Id != type.Id).ToList();
        if (others.Count == 0)
            return null;
        if (others.Count == 1)
            return others[0].Id;
        var sameNamespace = others.Where(candidate => candidate.Namespace == type.Namespace).ToList();
        return sameNamespace.Count == 1 ? sameNamespace[0].Id : null;
    }

    type.Coupled = type.TypeNames
        .Select(Resolve)
        .Where(id => id is not null)
        .Select(id => id!)
        .Distinct()
        .OrderBy(id => id)
        .ToList();

    var instanceFields = type.Fields.Where(field => !field.IsStatic).ToList();
    var instanceMethods = type.Methods.Where(method => !method.IsStatic && !method.IsConstructor).ToList();
    var fieldNames = instanceFields.Select(field => field.Name).ToHashSet();
    type.Wmc = type.Methods.Sum(method => method.Ccn);
    type.Cbo = type.Coupled.Count;
    type.Lcom = Lcom(instanceMethods, instanceFields, fieldNames);
    type.Dit = Dit(type, byId, bySimple, []);
    type.Pim = Pim(type, byId, bySimple);
    type.Overridden = type.Methods.Count(method => method.IsOverride);
}

static double Lcom(List<MethodModel> methods, List<FieldModel> fields, HashSet<string> fieldNames)
{
    if (methods.Count < 2 || fields.Count == 0)
        return 0;
    double sum = 0;
    foreach (var field in fields)
        sum += methods.Count(method => method.Reads.Contains(field.Name) && fieldNames.Contains(field.Name));
    var mean = sum / fields.Count;
    return Math.Round((methods.Count - mean) / (methods.Count - 1), 3);
}

static int Dit(TypeModel type, Dictionary<string, TypeModel> byId, Dictionary<string, List<TypeModel>> bySimple, HashSet<string> stack)
{
    if (!stack.Add(type.Id))
        return 1;
    var baseId = ClassBase(type, byId, bySimple);
    if (baseId is null)
        return type.HasExternalClassBase ? 2 : 1;
    if (!byId.TryGetValue(baseId, out var parent))
        return 2;
    return 1 + Dit(parent, byId, bySimple, stack);
}

static string? ClassBase(TypeModel type, Dictionary<string, TypeModel> byId, Dictionary<string, List<TypeModel>> bySimple)
{
    type.HasExternalClassBase = false;
    foreach (var name in type.Bases)
    {
        if (name == "object")
            continue;
        if (!bySimple.TryGetValue(name, out var candidates))
        {
            if (!LooksLikeInterface(name))
            {
                type.HasExternalClassBase = true;
                return null;
            }
            continue;
        }
        var match = candidates.Count == 1
            ? candidates[0]
            : candidates.FirstOrDefault(candidate => candidate.Namespace == type.Namespace);
        if (match is null)
            continue;
        if (match.Kind is "class" or "record")
            return match.Id;
    }
    return null;
}

static bool LooksLikeInterface(string name) =>
    name.Length > 1 && name[0] == 'I' && char.IsUpper(name[1]);

static int Pim(TypeModel type, Dictionary<string, TypeModel> byId, Dictionary<string, List<TypeModel>> bySimple)
{
    var names = new HashSet<string>();
    var cursor = type;
    var guard = new HashSet<string>();
    while (guard.Add(cursor.Id))
    {
        foreach (var method in cursor.Methods)
        {
            if (!method.IsStatic && !method.IsConstructor && method.Accessibility == "public")
                names.Add(method.Name);
        }
        var baseId = ClassBase(cursor, byId, bySimple);
        if (baseId is null || !byId.TryGetValue(baseId, out var parent))
            break;
        cursor = parent;
    }
    return names.Count;
}

static void ApplyLizard(string repo, List<TypeModel> types)
{
    var roots = SourceRoots(repo, types);
    if (roots.Count == 0)
        return;
    var stdout = RunLizard(roots);
    if (stdout is null)
        return;
    var sums = new Dictionary<string, int>(StringComparer.Ordinal);
    foreach (var line in stdout.Split('\n', StringSplitOptions.RemoveEmptyEntries))
        AddLizardRow(repo, line.Trim(), sums);
    AssignLizard(types, sums);
}

static List<string> SourceRoots(string repo, List<TypeModel> types)
{
    return types
        .SelectMany(type => type.File.Split(';'))
        .Select(path => RootFor(repo, path))
        .Where(path => path is not null)
        .Select(path => path!)
        .Distinct()
        .ToList();
}

static string? RootFor(string repo, string path)
{
    const string marker = "/src/";
    var index = path.IndexOf(marker, StringComparison.Ordinal);
    if (index < 0)
        return null;
    var relative = path[..(index + marker.Length - 1)].Replace('/', Path.DirectorySeparatorChar);
    return Path.Combine(repo, relative);
}

static string? RunLizard(List<string> roots)
{
    var start = new System.Diagnostics.ProcessStartInfo
    {
        FileName = PythonExecutable(),
        RedirectStandardOutput = true,
        RedirectStandardError = true,
        UseShellExecute = false,
        CreateNoWindow = true,
    };
    start.ArgumentList.Add("-m");
    start.ArgumentList.Add("lizard");
    start.ArgumentList.Add("-l");
    start.ArgumentList.Add("csharp");
    start.ArgumentList.Add("--csv");
    foreach (var root in roots)
        start.ArgumentList.Add(root);

    using var process = System.Diagnostics.Process.Start(start);
    if (process is null)
        return null;
    var stdout = process.StandardOutput.ReadToEnd();
    process.WaitForExit();
    if (process.ExitCode == 0)
        return stdout;
    Console.Error.WriteLine("lizard did not produce a CSV cross-check; WMC stays on the syntax count");
    return null;
}

static void AddLizardRow(string repo, string line, Dictionary<string, int> sums)
{
    var fields = SplitCsv(line);
    if (fields.Count < 6)
        return;
    if (!int.TryParse(fields[1], out var ccn))
        return;
    var key = LizardKey(repo, fields[5]);
    if (key is null)
        return;
    sums[key] = sums.GetValueOrDefault(key) + ccn;
}

static string? LizardKey(string repo, string location)
{
    var split = location.IndexOf("::", StringComparison.Ordinal);
    var at = location.LastIndexOf('@');
    if (split <= 0 || at <= split)
        return null;
    var className = location[..split];
    var file = location[(at + 1)..].Replace('\\', '/');
    if (Path.IsPathRooted(file))
        file = Path.GetRelativePath(repo, file).Replace('\\', '/');
    if (file.Contains("/Migrations/", StringComparison.Ordinal))
        return null;
    if (file.EndsWith(".Designer.cs", StringComparison.Ordinal))
        return null;
    return file + "|" + className;
}

static void AssignLizard(List<TypeModel> types, Dictionary<string, int> sums)
{
    foreach (var type in types)
    {
        var wmc = LizardWmc(type, sums);
        if (wmc is not null)
            type.Wmc = wmc.Value;
    }
}

static int? LizardWmc(TypeModel type, Dictionary<string, int> sums)
{
    var sum = 0;
    var found = false;
    foreach (var file in type.File.Split(';'))
    {
        if (!sums.TryGetValue(file + "|" + type.SimpleName, out var wmc))
            continue;
        sum += wmc;
        found = true;
    }
    return found ? sum : null;
}

static string PythonExecutable()
{
    var local = Environment.GetEnvironmentVariable("LOCALAPPDATA");
    if (!string.IsNullOrEmpty(local))
    {
        var candidate = Path.Combine(local, "Programs", "Python", "Python312", "python.exe");
        if (File.Exists(candidate))
            return candidate;
    }
    return OperatingSystem.IsWindows() ? "python" : "python3";
}

static List<string> SplitCsv(string line)
{
    var fields = new List<string>();
    var current = new System.Text.StringBuilder();
    var quoted = false;
    for (var i = 0; i < line.Length; i++)
    {
        var ch = line[i];
        if (quoted)
        {
            if (ch == '"')
            {
                if (i + 1 < line.Length && line[i + 1] == '"')
                {
                    current.Append('"');
                    i++;
                }
                else
                    quoted = false;
            }
            else
                current.Append(ch);
        }
        else if (ch == '"')
            quoted = true;
        else if (ch == ',')
        {
            fields.Add(current.ToString());
            current.Clear();
        }
        else
            current.Append(ch);
    }
    fields.Add(current.ToString());
    return fields;
}

static MoodModel ComputeMood(List<TypeModel> types)
{
    var methods = types.SelectMany(type => type.Methods).Where(method => !method.IsConstructor).ToList();
    var fields = types.SelectMany(type => type.Fields).ToList();
    var couplings = types.Sum(type => type.Coupled.Count);
    var pairs = types.Count * (types.Count - 1);
    return new MoodModel
    {
        Tc = types.Count,
        MethodCount = methods.Count,
        HiddenMethods = methods.Count(method => method.Accessibility == "private"),
        FieldCount = fields.Count,
        HiddenFields = fields.Count(field => field.Accessibility == "private"),
        Couplings = couplings,
        Mhf = methods.Count == 0 ? 0 : Math.Round(100.0 * methods.Count(method => method.Accessibility == "private") / methods.Count, 3),
        Ahf = fields.Count == 0 ? 0 : Math.Round(100.0 * fields.Count(field => field.Accessibility == "private") / fields.Count, 3),
        Cof = pairs == 0 ? 0 : Math.Round((double)couplings / pairs, 6),
    };
}

static void WriteSnapshot(string snapshot, List<TypeModel> types, MoodModel mood, string outDir, JsonSerializerOptions options)
{
    if (snapshot == "baseline")
        WriteBaseline(types, mood, outDir, options);
    var designFile = DesignFileName(snapshot);
    if (designFile is null)
        return;
    WriteJson(Path.Combine(outDir, designFile), new
    {
        definitions = Definitions(),
        types = DesignTypes(types),
    }, options);
}

static void WriteBaseline(List<TypeModel> types, MoodModel mood, string outDir, JsonSerializerOptions options)
{
    var targets = new (string Role, string Path, string Type)[]
    {
        ("core-domain", "Graph/src/Relativa.Graph/Dashboard/DashboardService.cs", "DashboardService"),
        ("infrastructure", "Graph/src/Relativa.Graph/ML/ResilientMlScoringClient.cs", "ResilientMlScoringClient"),
        ("utility", "Core/src/Relativa.Core.Application/Validators/CreateEntityRequestValidator.cs", "CreateEntityRequestValidator"),
    };
    WriteJson(Path.Combine(outDir, "ck-mood-baseline.json"), new
    {
        definitions = Definitions(),
        files = targets.Select(target => FilePayload(types, target.Role, target.Path, target.Type)).ToList(),
        mood = MoodPayload(mood),
    }, options);

    var desk = types.FirstOrDefault(type => type.SimpleName == "DealDesk");
    WriteJson(Path.Combine(outDir, "coupling-matrix.json"), new
    {
        source = "DealDesk",
        cbo = desk?.Cbo ?? 0,
        lcom = desk?.Lcom ?? 0,
        wmc = desk?.Wmc ?? 0,
        edges = desk?.Coupled.Select(id => new { from = "DealDesk", to = id.Split('.').Last() }).ToList(),
    }, options);
}

static string? DesignFileName(string snapshot)
{
    if (snapshot == "god-pass")
        return "ck-god-pass.json";
    if (snapshot == "inherit-baseline")
        return "ck-inherit-baseline.json";
    if (snapshot == "inherit-pass")
        return "ck-inherit-pass.json";
    return null;
}

static List<object> DesignTypes(List<TypeModel> types)
{
    return types
        .Where(type => type.Namespace == "Relativa.Graph.DesignAudit" || type.Namespace.StartsWith("Relativa.Graph.DesignAudit.", StringComparison.Ordinal))
        .OrderBy(type => type.SimpleName)
        .Select(TypePayload)
        .ToList();
}

static object FilePayload(List<TypeModel> types, string role, string path, string typeName)
{
    var matches = types.Where(type => type.File.Split(';').Contains(path) || type.SimpleName == typeName && type.File.EndsWith(path, StringComparison.Ordinal)).ToList();
    var main = matches.FirstOrDefault(type => type.SimpleName == typeName);
    return new
    {
        role,
        path,
        type = main is null ? null : TypePayload(main),
        declared = matches.Select(TypePayload).ToList(),
    };
}

static object TypePayload(TypeModel type) => new
{
    name = type.SimpleName,
    file = type.File,
    kind = type.Kind,
    wmc = type.Wmc,
    cbo = type.Cbo,
    lcom = type.Lcom,
    dit = type.Dit,
    pim = type.Pim,
    overridden = type.Overridden,
    methods = type.Methods.Count,
    fields = type.Fields.Count,
    coupled = type.Coupled.Select(id => id.Split('.').Last()).ToList(),
};

static object MoodPayload(MoodModel mood) => new
{
    tc = mood.Tc,
    mhf = mood.Mhf,
    ahf = mood.Ahf,
    cof = mood.Cof,
    methodCount = mood.MethodCount,
    hiddenMethods = mood.HiddenMethods,
    fieldCount = mood.FieldCount,
    hiddenFields = mood.HiddenFields,
    couplings = mood.Couplings,
};

static object Definitions() => new
{
    wmc = "Sum of Lizard CCN for the type, including the constructor. The syntax walker is the fallback when lizard is absent.",
    cbo = "Distinct user-declared types in type positions: bases, fields, parameters, returns, creation, casts. A member name that collides with a type is not counted. Self, primitives, string, decimal, int, bool, DateTime, Guid, and CancellationToken are excluded. An ambiguous simple name is dropped.",
    lcom = "Henderson-Sellers LCOM, (M - mean field use) / (M - 1), on instance methods and instance fields. 0 when M < 2 or F = 0. 1 means the methods do not share fields. This is not Sonar LCOM4.",
    dit = "1 when the type does not extend another class. Each resolved class base adds 1. An unresolved external class base yields 2. Interfaces do not add depth.",
    pim = "Distinct public instance method names declared on the type or inherited from a resolved class base.",
    overridden = "Methods on this type declared with override.",
    mhf = "100 * private methods / all methods, constructors excluded.",
    ahf = "100 * private fields / all fields, including primary-constructor parameters.",
    cof = "Directed user-type references / (TC * (TC - 1)). TC counts classes, records, structs, and interfaces under src.",
};

static void WriteJson(string path, object payload, JsonSerializerOptions options)
{
    File.WriteAllText(path, JsonSerializer.Serialize(payload, options) + Environment.NewLine);
}

static void PrintSummary(string snapshot, List<TypeModel> types, MoodModel mood)
{
    Console.WriteLine($"snapshot={snapshot} tc={mood.Tc} mhf={mood.Mhf} ahf={mood.Ahf} cof={mood.Cof}");
    foreach (var name in new[] { "DealDesk", "StatusDesk", "StageDesk", "RiskDesk", "QuoteDesk", "QuoteRule", "StageQuoteRule", "DeskQuoteRule", "DeskQuote", "DashboardService", "ResilientMlScoringClient", "CreateEntityRequestValidator" })
    {
        var type = types.FirstOrDefault(candidate => candidate.SimpleName == name);
        if (type is null)
            continue;
        Console.WriteLine($"{name} wmc={type.Wmc} cbo={type.Cbo} lcom={type.Lcom} dit={type.Dit} pim={type.Pim} overridden={type.Overridden}");
    }
}

static int AssertSnapshot(string snapshot, List<TypeModel> types)
{
    if (snapshot == "baseline")
        return AssertBaseline(types);
    if (snapshot == "god-pass")
        return AssertGodPass(types);
    if (snapshot == "inherit-baseline")
        return AssertInheritBaseline(types);
    if (snapshot == "inherit-pass")
        return AssertInheritPass(types);
    Console.Error.WriteLine($"Unknown snapshot '{snapshot}'");
    return 1;
}

static TypeModel? FindType(List<TypeModel> types, string name) =>
    types.FirstOrDefault(type => type.SimpleName == name);

static int Fail(string message)
{
    Console.Error.WriteLine(message);
    return 1;
}

static int AssertBaseline(List<TypeModel> types)
{
    var desk = FindType(types, "DealDesk");
    if (desk is null || desk.Cbo <= 15 || desk.Lcom < 0.999)
        return Fail("baseline gate failed: DealDesk needs CBO > 15 and LCOM = 1");
    return 0;
}

static int AssertGodPass(List<TypeModel> types)
{
    foreach (var name in new[] { "StatusDesk", "StageDesk", "RiskDesk", "QuoteDesk" })
    {
        var type = FindType(types, name);
        if (type is null || type.Cbo > 8 || type.Lcom > 0.2)
            return Fail($"god-pass gate failed for {name}");
    }
    if (FindType(types, "DealDesk") is not null)
        return Fail("god-pass gate failed: DealDesk is still declared");
    return 0;
}

static int AssertInheritBaseline(List<TypeModel> types)
{
    var leaf = FindType(types, "DeskQuoteRule");
    if (leaf is null || leaf.Dit < 3 || leaf.Pim <= 20 || leaf.Overridden < 11)
        return Fail("inherit-baseline gate failed: DeskQuoteRule needs DIT >= 3, PIM > 20, overrides >= 11");
    return 0;
}

static int AssertInheritPass(List<TypeModel> types)
{
    var composed = FindType(types, "DeskQuote");
    if (composed is null || composed.Dit != 1 || composed.Overridden != 0)
        return Fail("inherit-pass gate failed: DeskQuote needs DIT = 1 and overridden = 0");
    if (FindType(types, "DeskQuoteRule") is not null)
        return Fail("inherit-pass gate failed: inheritance types are still declared");
    if (FindType(types, "StageQuoteRule") is not null)
        return Fail("inherit-pass gate failed: inheritance types are still declared");
    if (FindType(types, "QuoteRule") is not null)
        return Fail("inherit-pass gate failed: inheritance types are still declared");
    return 0;
}

sealed class TypeModel
{
    public string SimpleName { get; set; } = "";
    public int Arity { get; set; }
    public string Namespace { get; set; } = "";
    public string File { get; set; } = "";
    public string Kind { get; set; } = "";
    public string Id => Arity == 0 ? $"{Namespace}.{SimpleName}" : $"{Namespace}.{SimpleName}`{Arity}";
    public List<string> Bases { get; set; } = [];
    public List<FieldModel> Fields { get; set; } = [];
    public List<MethodModel> Methods { get; set; } = [];
    public List<string> TypeNames { get; set; } = [];
    public List<string> Coupled { get; set; } = [];
    public bool HasExternalClassBase { get; set; }
    public int Wmc { get; set; }
    public int Cbo { get; set; }
    public double Lcom { get; set; }
    public int Dit { get; set; }
    public int Pim { get; set; }
    public int Overridden { get; set; }
}

sealed class FieldModel
{
    public string Name { get; set; } = "";
    public string Accessibility { get; set; } = "";
    public bool IsStatic { get; set; }
    public List<string> TypeNames { get; set; } = [];
}

sealed class MethodModel
{
    public string Name { get; set; } = "";
    public string Accessibility { get; set; } = "";
    public bool IsStatic { get; set; }
    public bool IsOverride { get; set; }
    public bool IsConstructor { get; set; }
    public int Ccn { get; set; }
    public HashSet<string> Reads { get; set; } = [];
}

sealed class MoodModel
{
    public int Tc { get; set; }
    public int MethodCount { get; set; }
    public int HiddenMethods { get; set; }
    public int FieldCount { get; set; }
    public int HiddenFields { get; set; }
    public int Couplings { get; set; }
    public double Mhf { get; set; }
    public double Ahf { get; set; }
    public double Cof { get; set; }
}
