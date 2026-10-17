ô
[C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\QualityGateFailureWebDemo.cs
	namespace 	
Relativa
 
. 
Core 
; 
public 
static 
class %
QualityGateFailureWebDemo -
{ 
public 

static 
void 
	Configure  
(  !!
WebApplicationBuilder! 6
builder7 >
)> ?
{		 
builder

 
.

 
WebHost

 
.

 
ConfigureKestrel

 (
(

( )
options

) 0
=>

1 3
{ 	
options 
. 
Limits 
. 
MaxRequestBodySize -
=. /
$num0 ;
;; <
} 	
)	 

;
 
builder 
. 
Services 
. 
AddCors  
(  !
options! (
=>) +
{ 	
options 
. 
	AddPolicy 
( 
$str /
,/ 0
policy1 7
=>8 :
{ 
policy 
. 
AllowAnyOrigin %
(% &
)& '
.' (
AllowAnyHeader( 6
(6 7
)7 8
.8 9
AllowAnyMethod9 G
(G H
)H I
;I J
} 
) 
; 
} 	
)	 

;
 
} 
public 

static 
void 
UseInsecurePipeline *
(* +
WebApplication+ 9
app: =
)= >
{ 
app 
. %
UseDeveloperExceptionPage %
(% &
)& '
;' (
app 
. 
UseCors 
( 
$str %
)% &
;& '
} 
public 

static 
void 
WriteSessionCookie )
() *
HttpContext* 5
context6 =
)= >
{ 
context   
.   
Response   
.   
Cookies    
.    !
Append  ! '
(  ' (
$str  ( 1
,  1 2
$str  3 G
,  G H
new  I L
CookieOptions  M Z
{!! 	
HttpOnly"" 
="" 
false"" 
,"" 
Secure## 
=## 
false## 
,## 
}$$ 	
)$$	 

;$$
 
}%% 
}&& 
[(( "
IgnoreAntiforgeryToken(( 
](( 
public)) 
sealed)) 
class)) (
QualityGateFailureController)) 0
:))1 2
ControllerBase))3 A
{** 
}++ ê}
IC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Program.cs
Log 
. 
Logger 

= 
new 
LoggerConfiguration $
($ %
)% &
. 
MinimumLevel 
. 
Information 
( 
) 
. 
MinimumLevel 
. 
Override 
( 
$str 1
,1 2
Serilog3 :
.: ;
Events; A
.A B
LogEventLevelB O
.O P
WarningP W
)W X
. 
MinimumLevel 
. 
Override 
( 
$str :
,: ;
Serilog< C
.C D
EventsD J
.J K
LogEventLevelK X
.X Y
WarningY `
)` a
. 
WriteTo 
. 
Console 
( 
) 
. 
WriteTo 
. 
File 
( 
$str "
," #
rollingInterval$ 3
:3 4
RollingInterval5 D
.D E
DayE H
)H I
. 
CreateLogger 
( 
) 
; 
try!! 
{"" 
var## 
builder## 
=## 
WebApplication##  
.##  !
CreateBuilder##! .
(##. /
args##/ 3
)##3 4
;##4 5
builder$$ 
.$$ 
Host$$ 
.$$ 

UseSerilog$$ 
($$ 
)$$ 
;$$ 
builder&& 
.&& 
Services&& 
.&& 

AddOpenApi&& 
(&&  
)&&  !
;&&! "
builder(( 
.(( 
Services(( 
.(( 
AddDbContext(( !
<((! "
RelativaDbContext((" 3
>((3 4
(((4 5
options((5 <
=>((= ?
options)) 
.)) 
	UseNpgsql)) 
()) 
builder)) !
.))! "
Configuration))" /
.))/ 0
GetConnectionString))0 C
())C D
$str))D M
)))M N
)))N O
)))O P
;))P Q
builder** 
.** 
Services** 
.** 
	Configure** 
<** %
RabbitMqPublishingOptions** 8
>**8 9
(**9 :
builder++ 
.++ 
Configuration++ 
.++ 

GetSection++ (
(++( )%
RabbitMqPublishingOptions++) B
.++B C#
ConfigurationSectionKey++C Z
)++Z [
)++[ \
;++\ ]
builder,, 
.,, 
Services,, 
.,, 
	Configure,, 
<,, $
EntityGraphRabbitOptions,, 7
>,,7 8
(,,8 9
builder-- 
.-- 
Configuration-- 
.-- 

GetSection-- (
(--( )$
EntityGraphRabbitOptions--) A
.--A B

SectionKey--B L
)--L M
)--M N
;--N O
builder// 
.// 
Services// 
.// 
AddHealthChecks// $
(//$ %
)//% &
.00 	
AddDbContextCheck00	 
<00 
RelativaDbContext00 ,
>00, -
(00- .
)00. /
;00/ 0
builder22 
.22 
Services22 
.22 /
#AddValidatorsFromAssemblyContaining22 8
<228 9
IWorkspaceService229 J
>22J K
(22K L
)22L M
;22M N
builder33 
.33 
Services33 
.33 /
#AddValidatorsFromAssemblyContaining33 8
<338 9
RegisterRequestDto339 K
>33K L
(33L M
)33M N
;33N O
builder44 
.44 
Services44 
.44 /
#AddValidatorsFromAssemblyContaining44 8
<448 9)
IOrganizationUserAdminService449 V
>44V W
(44W X
)44X Y
;44Y Z
builder66 
.66 
Services66 
.66 
AddDbContext66 !
<66! "
AuthDbContext66" /
>66/ 0
(660 1
options661 8
=>669 ;
options77 
.77 
	UseNpgsql77 
(77 
builder77 !
.77! "
Configuration77" /
.77/ 0
GetConnectionString770 C
(77C D
$str77D M
)77M N
)77N O
)77O P
;77P Q
builder88 
.88 
Services88 
.88 
	AddScoped88 
<88 
IUserRepository88 .
,88. /
UserRepository880 >
>88> ?
(88? @
)88@ A
;88A B
builder99 
.99 
Services99 
.99 
AddSingleton99 !
<99! "
IPasswordHasher99" 1
,991 2 
BcryptPasswordHasher993 G
>99G H
(99H I
)99I J
;99J K
builder:: 
.:: 
Services:: 
.:: 
	AddScoped:: 
<:: $
IUserProvisioningService:: 7
,::7 8#
UserProvisioningService::9 P
>::P Q
(::Q R
)::R S
;::S T
builder<< 
.<< 
Services<< 
.<< 
	AddScoped<< 
<<< +
IOrganizationSettingsRepository<< >
,<<> ?*
OrganizationSettingsRepository<<@ ^
><<^ _
(<<_ `
)<<` a
;<<a b
builder== 
.== 
Services== 
.== 
	AddScoped== 
<==  
IWorkspaceRepository== 3
,==3 4
WorkspaceRepository==5 H
>==H I
(==I J
)==J K
;==K L
builder>> 
.>> 
Services>> 
.>> 
	AddScoped>> 
<>> (
IWorkspaceSettingsRepository>> ;
,>>; <'
WorkspaceSettingsRepository>>= X
>>>X Y
(>>Y Z
)>>Z [
;>>[ \
builder?? 
.?? 
Services?? 
.?? 
	AddScoped?? 
<?? (
IUserRoleWorkspaceRepository?? ;
,??; <'
UserRoleWorkspaceRepository??= X
>??X Y
(??Y Z
)??Z [
;??[ \
builder@@ 
.@@ 
Services@@ 
.@@ 
	AddScoped@@ 
<@@ $
IWorkspaceRoleRepository@@ 7
,@@7 8#
WorkspaceRoleRepository@@9 P
>@@P Q
(@@Q R
)@@R S
;@@S T
builderAA 
.AA 
ServicesAA 
.AA 
	AddScopedAA 
<AA !
IPermissionRepositoryAA 4
,AA4 5 
PermissionRepositoryAA6 J
>AAJ K
(AAK L
)AAL M
;AAM N
builderBB 
.BB 
ServicesBB 
.BB 
	AddScopedBB 
<BB +
IUserRoleOrganizationRepositoryBB >
,BB> ?*
UserRoleOrganizationRepositoryBB@ ^
>BB^ _
(BB_ `
)BB` a
;BBa b
builderCC 
.CC 
ServicesCC 
.CC 
	AddScopedCC 
<CC #
IOrganizationRepositoryCC 6
,CC6 7"
OrganizationRepositoryCC8 N
>CCN O
(CCO P
)CCP Q
;CCQ R
builderDD 
.DD 
ServicesDD 
.DD 
	AddScopedDD 
<DD '
IOrganizationRoleRepositoryDD :
,DD: ;&
OrganizationRoleRepositoryDD< V
>DDV W
(DDW X
)DDX Y
;DDY Z
builderEE 
.EE 
ServicesEE 
.EE 
	AddScopedEE 
<EE "
IJoinRequestRepositoryEE 5
,EE5 6!
JoinRequestRepositoryEE7 L
>EEL M
(EEM N
)EEN O
;EEO P
builderFF 
.FF 
ServicesFF 
.FF 
	AddScopedFF 
<FF $
IOrgInvitationRepositoryFF 7
,FF7 8#
OrgInvitationRepositoryFF9 P
>FFP Q
(FFQ R
)FFR S
;FFS T
builderGG 
.GG 
ServicesGG 
.GG 
	AddScopedGG 
<GG !
IEntityTypeRepositoryGG 4
,GG4 5 
EntityTypeRepositoryGG6 J
>GGJ K
(GGK L
)GGL M
;GGM N
builderHH 
.HH 
ServicesHH 
.HH 
	AddScopedHH 
<HH 
IEntityRepositoryHH 0
,HH0 1
EntityRepositoryHH2 B
>HHB C
(HHC D
)HHD E
;HHE F
builderJJ 
.JJ 
ServicesJJ 
.JJ 
	AddScopedJJ 
<JJ 
IEntityTypeServiceJJ 1
,JJ1 2
EntityTypeServiceJJ3 D
>JJD E
(JJE F
)JJF G
;JJG H
builderKK 
.KK 
ServicesKK 
.KK 
	AddScopedKK 
<KK %
IWorkspaceAccessEvaluatorKK 8
,KK8 9$
WorkspaceAccessEvaluatorKK: R
>KKR S
(KKS T
)KKT U
;KKU V
builderLL 
.LL 
ServicesLL 
.LL 
	AddScopedLL 
<LL 
IEntityServiceLL -
,LL- .
EntityServiceLL/ <
>LL< =
(LL= >
)LL> ?
;LL? @
builderMM 
.MM 
ServicesMM 
.MM 
	AddScopedMM 
<MM 
IOutboxWriterMM ,
,MM, -
OutboxWriterMM. :
>MM: ;
(MM; <
)MM< =
;MM= >
builderNN 
.NN 
ServicesNN 
.NN 
AddHostedServiceNN %
<NN% &!
AuditOutboxDispatcherNN& ;
>NN; <
(NN< =
)NN= >
;NN> ?
builderOO 
.OO 
ServicesOO 
.OO 
AddHostedServiceOO %
<OO% &3
'EntityGraphCommandConsumerHostedServiceOO& M
>OOM N
(OON O
)OOO P
;OOP Q
builderQQ 
.QQ 
ServicesQQ 
.QQ 
	AddScopedQQ 
<QQ 
IWorkspaceServiceQQ 0
,QQ0 1
WorkspaceServiceQQ2 B
>QQB C
(QQC D
)QQD E
;QQE F
builderRR 
.RR 
ServicesRR 
.RR 
	AddScopedRR 
<RR #
IWorkspaceMemberServiceRR 6
,RR6 7"
WorkspaceMemberServiceRR8 N
>RRN O
(RRO P
)RRP Q
;RRQ R
builderSS 
.SS 
ServicesSS 
.SS 
	AddScopedSS 
<SS 
IRoleServiceSS +
,SS+ ,
RoleServiceSS- 8
>SS8 9
(SS9 :
)SS: ;
;SS; <
builderTT 
.TT 
ServicesTT 
.TT 
	AddScopedTT 
<TT  
IOrganizationServiceTT 3
,TT3 4
OrganizationServiceTT5 H
>TTH I
(TTI J
)TTJ K
;TTK L
builderUU 
.UU 
ServicesUU 
.UU 
	AddScopedUU 
<UU 
IOrgRoleServiceUU .
,UU. /
OrgRoleServiceUU0 >
>UU> ?
(UU? @
)UU@ A
;UUA B
builderVV 
.VV 
ServicesVV 
.VV 
	AddScopedVV 
<VV !
IOrgInvitationServiceVV 4
,VV4 5 
OrgInvitationServiceVV6 J
>VVJ K
(VVK L
)VVL M
;VVM N
builderWW 
.WW 
ServicesWW 
.WW 
	AddScopedWW 
<WW 
IJoinRequestServiceWW 2
,WW2 3
JoinRequestServiceWW4 F
>WWF G
(WWG H
)WWH I
;WWI J
builderXX 
.XX 
ServicesXX 
.XX 
	AddScopedXX 
<XX )
IOrganizationUserAdminServiceXX <
,XX< =(
OrganizationUserAdminServiceXX> Z
>XXZ [
(XX[ \
)XX\ ]
;XX] ^
builderZZ 
.ZZ 
ServicesZZ 
.ZZ 
AddMemoryCacheZZ #
(ZZ# $
)ZZ$ %
;ZZ% &
builder[[ 
.[[ 
Services[[ 
.[[ 

AddSignalR[[ 
([[  
)[[  !
;[[! "
builder\\ 
.\\ 
Services\\ 
.\\ 
	AddScoped\\ 
<\\ '
IEntityRelationshipNotifier\\ :
,\\: ;&
EntityRelationshipNotifier\\< V
>\\V W
(\\W X
)\\X Y
;\\Y Z
builder^^ 
.^^ 
Services^^ 
.^^ 
AddExceptionHandler^^ (
<^^( )"
GlobalExceptionHandler^^) ?
>^^? @
(^^@ A
)^^A B
;^^B C
builder__ 
.__ 
Services__ 
.__ 
AddProblemDetails__ &
(__& '
)__' (
;__( )
varaa 
appaa 
=aa 
builderaa 
.aa 
Buildaa 
(aa 
)aa 
;aa 
appcc 
.cc 
UseExceptionHandlercc 
(cc 
)cc 
;cc 
appdd 
.dd $
UseSerilogRequestLoggingdd  
(dd  !
)dd! "
;dd" #
appff 
.ff 

MapOpenApiff 
(ff 
)ff 
;ff 
appgg 
.gg !
MapScalarApiReferencegg 
(gg 
)gg 
;gg  
appii 
.ii 
MapHealthChecksii 
(ii 
$strii !
)ii! "
;ii" #
appjj 
.jj 
MapHubjj 
<jj 
CoreHubjj 
>jj 
(jj 
$strjj $
)jj$ %
;jj% &
appkk 
.kk "
MapEntityTypeEndpointskk 
(kk 
)kk  
;kk  !
appll 
.ll 
MapEntityEndpointsll 
(ll 
)ll 
;ll 
appmm 
.mm *
MapEntityRelationshipEndpointsmm &
(mm& '
)mm' (
;mm( )
appnn 
.nn !
MapWorkspaceEndpointsnn 
(nn 
)nn 
;nn  
appoo 
.oo 
MapMemberEndpointsoo 
(oo 
)oo 
;oo 
apppp 
.pp "
MapInvitationEndpointspp 
(pp 
)pp  
;pp  !
appqq 
.qq 
MapRoleEndpointsqq 
(qq 
)qq 
;qq 
apprr 
.rr $
MapOrganizationEndpointsrr  
(rr  !
)rr! "
;rr" #
appss 
.ss !
MapOrgMemberEndpointsss 
(ss 
)ss 
;ss  
apptt 
.tt #
MapJoinRequestEndpointstt 
(tt  
)tt  !
;tt! "
appuu 
.uu %
MapOrgInvitationEndpointsuu !
(uu! "
)uu" #
;uu# $
appvv 
.vv 
MapOrgRoleEndpointsvv 
(vv 
)vv 
;vv 
appww 
.ww (
MapOrganizationUserEndpointsww $
(ww$ %
)ww% &
;ww& '
appyy 
.yy 
Runyy 
(yy 
)yy 
;yy 
}zz 
catch{{ 
({{ 
	Exception{{ 
ex{{ 
){{ 
{|| 
Log}} 
.}} 
Fatal}} 
(}} 
ex}} 
,}} 
$str}} 8
)}}8 9
;}}9 :
}~~ 
finally 
{ÄÄ 
Log
ÅÅ 
.
ÅÅ 
CloseAndFlush
ÅÅ 
(
ÅÅ 
)
ÅÅ 
;
ÅÅ 
}ÇÇ ùG
cC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Middleware\GlobalExceptionHandler.cs
	namespace 	
Relativa
 
. 
Core 
. 

Middleware "
;" #
public		 
sealed		 
class		 "
GlobalExceptionHandler		 *
(		* +
ILogger		+ 2
<		2 3"
GlobalExceptionHandler		3 I
>		I J
logger		K Q
)		Q R
:		S T
IExceptionHandler		U f
{

 
public 

async 
	ValueTask 
< 
bool 
>  
TryHandleAsync! /
(/ 0
HttpContext 
httpContext 
,  
	Exception 
	exception 
, 
CancellationToken 
cancellationToken +
)+ ,
{ 
var 
( 

statusCode 
, 
title 
, 
detail  &
,& '
code( ,
), -
=. /
	exception0 9
switch: @
{ 	
AppException 
ax 
=>* ,
(- .
ax. 0
.0 1

StatusCode1 ;
,; <
TitleForStatus= K
(K L
axL N
.N O

StatusCodeO Y
)Y Z
,Z [
ax\ ^
.^ _
Message_ f
==g i
axj l
.l m
Codem q
?r s
nullt x
:y z
ax{ }
.} ~
Message	~ Ö
,
Ö Ü
ax
á â
.
â ä
Code
ä é
)
é è
,
è ê
ValidationException 
ve  "
=>* ,
(- .
StatusCodes. 9
.9 :
Status400BadRequest: M
,M N
$strP c
,c d!
BuildValidationDetailh }
(} ~
ve	~ Ä
)
Ä Å
,
Å Ç
(
É Ñ
string
Ñ ä
?
ä ã
)
ã å
null
å ê
)
ê ë
,
ë í
ArgumentException 
ae  
=>* ,
(- .
StatusCodes. 9
.9 :
Status400BadRequest: M
,M N
$strP ]
,] ^
aeh j
.j k
Messagek r
,r s
(t u
stringu {
?{ |
)| }
null	} Å
)
Å Ç
,
Ç É 
KeyNotFoundException  
ke! #
=>* ,
(- .
StatusCodes. 9
.9 :
Status404NotFound: K
,K L
$strP [
,[ \
keh j
.j k
Messagek r
,r s
(t u
stringu {
?{ |
)| }
null	} Å
)
Å Ç
,
Ç É'
UnauthorizedAccessException '
ue( *
=>+ -
(. /
StatusCodes/ :
.: ;
Status403Forbidden; M
,M N
$strQ \
,\ ]
uei k
.k l
Messagel s
,s t
(u v
stringv |
?| }
)} ~
null	~ Ç
)
Ç É
,
É Ñ$
ForbiddenAccessException $
fe% '
=>* ,
(- .
StatusCodes. 9
.9 :
Status403Forbidden: L
,L M
$strR ]
,] ^
feh j
.j k
Messagek r
,r s
(t u
stringu {
?{ |
)| }
null	} Å
)
Å Ç
,
Ç É%
InvalidOperationException %
ioe& )
=>* ,
(- .
StatusCodes. 9
.9 :
Status409Conflict: K
,K L
$strP Z
,Z [
ioeh k
.k l
Messagel s
,s t
(u v
stringv |
?| }
)} ~
null	~ Ç
)
Ç É
,
É Ñ
DbUpdateException 
{ 
InnerException  .
:. /
PostgresException0 A
{B C
SqlStateD L
:L M
$strN U
}V W
}X Y
=>* ,
(- .
StatusCodes. 9
.9 :
Status409Conflict: K
,K L
$strP Z
,Z [
$str	h í
,
í ì
(
î ï
string
ï õ
?
õ ú
)
ú ù
null
ù °
)
° ¢
,
¢ £
_ 
=>* ,
(- .
StatusCodes. 9
.9 :(
Status500InternalServerError: V
,V W
$strX o
,o p
$str	q ê
,
ê ë
(
í ì
string
ì ô
?
ô ö
)
ö õ
null
õ ü
)
ü †
} 	
;	 

if 

( 

statusCode 
== 
StatusCodes %
.% &(
Status500InternalServerError& B
)B C
logger 
. 
LogError 
( 
	exception %
,% &
$str' <
)< =
;= >
else   
logger!! 
.!! 

LogWarning!! 
(!! 
	exception!! '
,!!' (
$str!!) E
,!!E F
title!!G L
)!!L M
;!!M N
object## 
?## 
errors## 
=## 
	exception## "
is### %
ValidationException##& 9
vex##: =
?$$ 
vex$$ 
.$$ 
Errors$$ 
.%% 
GroupBy%% 
(%% 
e%% 
=>%% 
e%% 
.%%  
PropertyName%%  ,
)%%, -
.&& 
ToDictionary&& 
(&& 
g'' 
=>'' 
g'' 
.'' 
Key'' 
,'' 
g(( 
=>(( 
g(( 
.(( 
Select(( !
(((! "
e((" #
=>(($ &
new((' *
{((+ ,
code((- 1
=((2 3
e((4 5
.((5 6
	ErrorCode((6 ?
,((? @
message((A H
=((I J
e((K L
.((L M
ErrorMessage((M Y
}((Z [
)(([ \
)((\ ]
:)) 
null)) 
;)) 
httpContext++ 
.++ 
Response++ 
.++ 

StatusCode++ '
=++( )

statusCode++* 4
;++4 5
await,, 
httpContext,, 
.,, 
Response,, "
.,," #
WriteAsJsonAsync,,# 3
(,,3 4
new,,4 7
{-- 	
status.. 
=.. 

statusCode.. 
,..  
code// 
,// 
title00 
,00 
detail11 
,11 
errors22 
}33 	
,33	 

cancellationToken33 
)33 
;33 
return55 
true55 
;55 
}66 
private88 
static88 
string88 
TitleForStatus88 (
(88( )
int88) ,
status88- 3
)883 4
=>885 7
status888 >
switch88? E
{99 
StatusCodes:: 
.:: 
Status400BadRequest:: '
=>::1 3
$str::4 A
,::A B
StatusCodes;; 
.;; !
Status401Unauthorized;; )
=>;;1 3
$str;;4 B
,;;B C
StatusCodes<< 
.<< 
Status403Forbidden<< &
=><<1 3
$str<<4 ?
,<<? @
StatusCodes== 
.== 
Status404NotFound== %
=>==1 3
$str==4 ?
,==? @
StatusCodes>> 
.>> 
Status409Conflict>> %
=>>>1 3
$str>>4 >
,>>> ?
StatusCodes?? 
.?? (
Status422UnprocessableEntity?? 0
=>??1 3
$str??4 J
,??J K
_@@ 	
=>@@1 3
$str@@4 ;
}AA 
;AA 
privateCC 
staticCC 
stringCC !
BuildValidationDetailCC /
(CC/ 0
ValidationExceptionCC0 C
veCCD F
)CCF G
{DD 
varEE 
errorsEE 
=EE 
veEE 
.EE 
ErrorsEE 
.FF 
SelectFF 
(FF 
eFF 
=>FF 
$"FF 
{FF 
eFF 
.FF 
PropertyNameFF *
}FF* +
$strFF+ -
{FF- .
eFF. /
.FF/ 0
ErrorMessageFF0 <
}FF< =
"FF= >
)FF> ?
.GG 
ToListGG 
(GG 
)GG 
;GG 
returnHH 
stringHH 
.HH 
JoinHH 
(HH 
$strHH 
,HH  
errorsHH! '
)HH' (
;HH( )
}II 
}JJ ˜
aC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Hubs\EntityRelationshipNotifier.cs
	namespace 	
Relativa
 
. 
Core 
. 
Hubs 
; 
public 
sealed 
class &
EntityRelationshipNotifier .
(. /
IHubContext/ :
<: ;
CoreHub; B
>B C

hubContextD N
)N O
:P Q'
IEntityRelationshipNotifierR m
{ 
public 

Task 
NotifyChangedAsync "
(" #
int# &
workspaceId' 2
,2 3
CancellationToken4 E
ctF H
,H I
paramsJ P
intQ T
[T U
]U V
	entityIdsW `
)` a
{		 
var

 
tasks

 
=

 
	entityIds

 
.

 
Distinct

 &
(

& '
)

' (
.

( )
Select

) /
(

/ 0
id

0 2
=>

3 5

hubContext 
. 
Clients 
. 
Group 
( 
CoreHub 
. 
	GroupName (
(( )
workspaceId) 4
,4 5
id6 8
)8 9
)9 :
. 
	SendAsync 
( 
CoreSignalREvents ,
., -&
EntityRelationshipsChanged- G
,G H
new 
{ 
WorkspaceId %
=& '
workspaceId( 3
,3 4
EntityId5 =
=> ?
id@ B
}C D
,D E
ct 
) 
) 
; 
return 
Task 
. 
WhenAll 
( 
tasks !
)! "
;" #
} 
} €
XC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Hubs\CoreSignalREvents.cs
	namespace 	
Relativa
 
. 
Core 
. 
Hubs 
; 
public 
static 
class 
CoreSignalREvents %
{ 
public 

const 
string &
EntityRelationshipsChanged 2
=3 4
$str5 V
;V W
} Í
NC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Hubs\CoreHub.cs
	namespace 	
Relativa
 
. 
Core 
. 
Hubs 
; 
public 
sealed 
class 
CoreHub 
: 
Hub !
{ 
public 

Task 

JoinEntity 
( 
int 
workspaceId *
,* +
int, /
entityId0 8
)8 9
=>: <
Groups 
. 
AddToGroupAsync 
( 
Context &
.& '
ConnectionId' 3
,3 4
	GroupName5 >
(> ?
workspaceId? J
,J K
entityIdL T
)T U
)U V
;V W
public

 

Task

 
LeaveEntity

 
(

 
int

 
workspaceId

  +
,

+ ,
int

- 0
entityId

1 9
)

9 :
=>

; =
Groups 
.  
RemoveFromGroupAsync #
(# $
Context$ +
.+ ,
ConnectionId, 8
,8 9
	GroupName: C
(C D
workspaceIdD O
,O P
entityIdQ Y
)Y Z
)Z [
;[ \
public 

static 
string 
	GroupName "
(" #
int# &
workspaceId' 2
,2 3
int4 7
entityId8 @
)@ A
=>B D
$" 

$str
 
{ 
workspaceId 
} 
$str 
{  
entityId  (
}( )
") *
;* +
} ’i
^C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Endpoints\WorkspaceEndpoints.cs
	namespace 	
Relativa
 
. 
Core 
. 
	Endpoints !
;! "
public 
static 
class 
WorkspaceEndpoints &
{ 
public 

static 
RouteGroupBuilder #!
MapWorkspaceEndpoints$ 9
(9 :
this: >!
IEndpointRouteBuilder? T
routesU [
)[ \
{		 
var

 
group

 
=

 
routes

 
.

 
MapGroup

 #
(

# $
$str

$ 8
)

8 9
. 
WithTags 
( 
$str "
)" #
;# $
group 
. 
MapPost 
( 
$str 
, 
async  
(! ""
CreateWorkspaceRequest" 8
request9 @
,@ A
IWorkspaceServiceB S
serviceT [
,[ \
HttpContext] h
httpContexti t
,t u
CancellationToken	v á
ct
à ä
)
ä ã
=>
å é
{ 	
var 
userId 
= 
	GetUserId "
(" #
httpContext# .
). /
;/ 0
var 
result 
= 
await 
service &
.& '
CreateAsync' 2
(2 3
userId3 9
,9 :
request; B
,B C
ctD F
)F G
;G H
return 
Results 
. 
Created "
(" #
$"# %
$str% 8
{8 9
result9 ?
.? @
Id@ B
}B C
"C D
,D E
resultF L
)L M
;M N
} 	
)	 

. 	
WithName	 
( 
$str #
)# $
. 	
WithSummary	 
( 
$str -
)- .
. 	
Produces	 
< 
WorkspaceDto 
> 
(  
StatusCodes  +
.+ ,
Status201Created, <
)< =
. 	%
ProducesValidationProblem	 "
(" #
)# $
;$ %
group 
. 
MapGet 
( 
$str 
, 
async 
(  !
int! $
?$ %
organizationId& 4
,4 5
IWorkspaceService6 G
serviceH O
,O P
HttpContextQ \
httpContext] h
,h i
CancellationTokenj {
ct| ~
)~ 
=>
Ä Ç
{ 	
var 
userId 
= 
	GetUserId "
(" #
httpContext# .
). /
;/ 0
var 
result 
= 
await 
service &
.& '
GetByUserAsync' 5
(5 6
userId6 <
,< =
organizationId> L
,L M
ctN P
)P Q
;Q R
return 
Results 
. 
Ok 
( 
result $
)$ %
;% &
} 	
)	 

. 	
WithName	 
( 
$str "
)" #
. 	
WithSummary	 
( 
$str	 å
)
å ç
.   	
Produces  	 
<   
List   
<   
WorkspaceDto   #
>  # $
>  $ %
(  % &
)  & '
.!! 	
Produces!!	 
(!! 
StatusCodes!! 
.!! 
Status403Forbidden!! 0
)!!0 1
;!!1 2
group## 
.## 
MapGet## 
(## 
$str##  
,##  !
async##" '
(##( )
int##) ,
id##- /
,##/ 0
IWorkspaceService##1 B
service##C J
,##J K
HttpContext##L W
httpContext##X c
,##c d
CancellationToken##e v
ct##w y
)##y z
=>##{ }
{$$ 	
var%% 
userId%% 
=%% 
	GetUserId%% "
(%%" #
httpContext%%# .
)%%. /
;%%/ 0
var&& 
result&& 
=&& 
await&& 
service&& &
.&&& '
GetByIdAsync&&' 3
(&&3 4
id&&4 6
,&&6 7
userId&&8 >
,&&> ?
ct&&@ B
)&&B C
;&&C D
return'' 
Results'' 
.'' 
Ok'' 
('' 
result'' $
)''$ %
;''% &
}(( 	
)((	 

.)) 	
WithName))	 
()) 
$str))  
)))  !
.** 	
WithSummary**	 
(** 
$str** ,
)**, -
.++ 	
Produces++	 
<++ 
WorkspaceDto++ 
>++ 
(++  
)++  !
;++! "
group-- 
.-- 
MapPut-- 
(-- 
$str--  
,--  !
async--" '
(--( )
int--) ,
id--- /
,--/ 0"
UpdateWorkspaceRequest--1 G
request--H O
,--O P
IWorkspaceService--Q b
service--c j
,--j k
HttpContext--l w
httpContext	--x É
,
--É Ñ
CancellationToken
--Ö ñ
ct
--ó ô
)
--ô ö
=>
--õ ù
{.. 	
var// 
userId// 
=// 
	GetUserId// "
(//" #
httpContext//# .
)//. /
;/// 0
await00 
service00 
.00 
UpdateAsync00 %
(00% &
id00& (
,00( )
userId00* 0
,000 1
request002 9
,009 :
ct00; =
)00= >
;00> ?
return11 
Results11 
.11 
	NoContent11 $
(11$ %
)11% &
;11& '
}22 	
)22	 

.33 	
WithName33	 
(33 
$str33 #
)33# $
.44 	
WithSummary44	 
(44 
$str44 /
)44/ 0
.55 	
Produces55	 
(55 
StatusCodes55 
.55 
Status204NoContent55 0
)550 1
.66 	%
ProducesValidationProblem66	 "
(66" #
)66# $
;66$ %
group88 
.88 
	MapDelete88 
(88 
$str88 #
,88# $
async88% *
(88+ ,
int88, /
id880 2
,882 3
IWorkspaceService884 E
service88F M
,88M N
HttpContext88O Z
httpContext88[ f
,88f g
CancellationToken88h y
ct88z |
)88| }
=>	88~ Ä
{99 	
var:: 
userId:: 
=:: 
	GetUserId:: "
(::" #
httpContext::# .
)::. /
;::/ 0
await;; 
service;; 
.;; 
ArchiveAsync;; &
(;;& '
id;;' )
,;;) *
userId;;+ 1
,;;1 2
ct;;3 5
);;5 6
;;;6 7
return<< 
Results<< 
.<< 
	NoContent<< $
(<<$ %
)<<% &
;<<& '
}== 	
)==	 

.>> 	
WithName>>	 
(>> 
$str>> $
)>>$ %
.?? 	
WithSummary??	 
(?? 
$str?? *
)??* +
.@@ 	
Produces@@	 
(@@ 
StatusCodes@@ 
.@@ 
Status204NoContent@@ 0
)@@0 1
;@@1 2
groupBB 
.BB 
MapGetBB 
(BB 
$strBB )
,BB) *
asyncBB+ 0
(BB1 2
intBB2 5
idBB6 8
,BB8 9
IWorkspaceServiceBB: K
serviceBBL S
,BBS T
HttpContextBBU `
httpContextBBa l
,BBl m
CancellationTokenBBn 
ct
BBÄ Ç
)
BBÇ É
=>
BBÑ Ü
{CC 	
varDD 
userIdDD 
=DD 
	GetUserIdDD "
(DD" #
httpContextDD# .
)DD. /
;DD/ 0
varEE 
resultEE 
=EE 
awaitEE 
serviceEE &
.EE& '
GetSettingsAsyncEE' 7
(EE7 8
idEE8 :
,EE: ;
userIdEE< B
,EEB C
ctEED F
)EEF G
;EEG H
returnFF 
ResultsFF 
.FF 
OkFF 
(FF 
resultFF $
)FF$ %
;FF% &
}GG 	
)GG	 

.HH 	
WithNameHH	 
(HH 
$strHH (
)HH( )
.II 	
WithSummaryII	 
(II 
$strII J
)IIJ K
.JJ 	
ProducesJJ	 
<JJ  
WorkspaceSettingsDtoJJ &
>JJ& '
(JJ' (
)JJ( )
;JJ) *
groupLL 
.LL 
MapPutLL 
(LL 
$strLL )
,LL) *
asyncLL+ 0
(LL1 2
intLL2 5
idLL6 8
,LL8 9*
UpdateWorkspaceSettingsRequestLL: X
requestLLY `
,LL` a
IWorkspaceServiceLLb s
serviceLLt {
,LL{ |
HttpContext	LL} à
httpContext
LLâ î
,
LLî ï
CancellationToken
LLñ ß
ct
LL® ™
)
LL™ ´
=>
LL¨ Æ
{MM 	
varNN 
userIdNN 
=NN 
	GetUserIdNN "
(NN" #
httpContextNN# .
)NN. /
;NN/ 0
awaitOO 
serviceOO 
.OO 
UpdateSettingsAsyncOO -
(OO- .
idOO. 0
,OO0 1
userIdOO2 8
,OO8 9
requestOO: A
,OOA B
ctOOC E
)OOE F
;OOF G
returnPP 
ResultsPP 
.PP 
	NoContentPP $
(PP$ %
)PP% &
;PP& '
}QQ 	
)QQ	 

.RR 	
WithNameRR	 
(RR 
$strRR +
)RR+ ,
.SS 	
WithSummarySS	 
(SS 
$strSS T
)SST U
.TT 	
ProducesTT	 
(TT 
StatusCodesTT 
.TT 
Status204NoContentTT 0
)TT0 1
.UU 	%
ProducesValidationProblemUU	 "
(UU" #
)UU# $
;UU$ %
returnWW 
groupWW 
;WW 
}XX 
internal^^ 
const^^ 
string^^ 
UserIdHeader^^ &
=^^' (
$str^^) 4
;^^4 5
internal__ 
const__ 
string__ 
UserEmailHeader__ )
=__* +
$str__, :
;__: ;
internalaa 
staticaa 
intaa 
	GetUserIdaa !
(aa! "
HttpContextaa" -
httpContextaa. 9
)aa9 :
{bb 
varcc 
valuecc 
=cc 
httpContextcc 
.cc  
Requestcc  '
.cc' (
Headerscc( /
[cc/ 0
UserIdHeadercc0 <
]cc< =
.cc= >
ToStringcc> F
(ccF G
)ccG H
;ccH I
ifdd 

(dd 
stringdd 
.dd 
IsNullOrEmptydd  
(dd  !
valuedd! &
)dd& '
)dd' (
{ee 	
throwff 
newff '
UnauthorizedAccessExceptionff 1
(ff1 2
$"ff2 4
$strff4 <
{ff< =
UserIdHeaderff= I
}ffI J
$strffJ R
"ffR S
)ffS T
;ffT U
}gg 	
ifii 

(ii 
!ii 
intii 
.ii 
TryParseii 
(ii 
valueii 
,ii  
outii! $
varii% (
userIdii) /
)ii/ 0
)ii0 1
{jj 	
throwkk 
newkk '
UnauthorizedAccessExceptionkk 1
(kk1 2
$"kk2 4
$strkk4 <
{kk< =
UserIdHeaderkk= I
}kkI J
$strkkJ R
"kkR S
)kkS T
;kkT U
}ll 	
returnnn 
userIdnn 
;nn 
}oo 
internalqq 
staticqq 
stringqq 
GetUserEmailqq '
(qq' (
HttpContextqq( 3
httpContextqq4 ?
)qq? @
{rr 
varss 
valuess 
=ss 
httpContextss 
.ss  
Requestss  '
.ss' (
Headersss( /
[ss/ 0
UserEmailHeaderss0 ?
]ss? @
.ss@ A
ToStringssA I
(ssI J
)ssJ K
;ssK L
iftt 

(tt 
stringtt 
.tt 
IsNullOrEmptytt  
(tt  !
valuett! &
)tt& '
)tt' (
{uu 	
throwvv 
newvv '
UnauthorizedAccessExceptionvv 1
(vv1 2
$"vv2 4
$strvv4 <
{vv< =
UserEmailHeadervv= L
}vvL M
$strvvM U
"vvU V
)vvV W
;vvW X
}ww 	
returnyy 
valueyy 
;yy 
}zz 
}{{ ˘@
YC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Endpoints\RoleEndpoints.cs
	namespace 	
Relativa
 
. 
Core 
. 
	Endpoints !
;! "
public 
static 
class 
RoleEndpoints !
{ 
public 

static 
RouteGroupBuilder #
MapRoleEndpoints$ 4
(4 5
this5 9!
IEndpointRouteBuilder: O
routesP V
)V W
{		 
var

 
wsGroup

 
=

 
routes

 
.

 
MapGroup

 %
(

% &
$str

& R
)

R S
. 
WithTags 
( 
$str 
) 
; 
wsGroup 
. 
MapGet 
( 
$str 
, 
async !
(" #
int# &
workspaceId' 2
,2 3
IRoleService4 @
serviceA H
,H I
HttpContextJ U
httpContextV a
,a b
CancellationTokenc t
ctu w
)w x
=>y {
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var 
result 
= 
await 
service &
.& '
GetByWorkspaceAsync' :
(: ;
workspaceId; F
,F G
userIdH N
,N O
ctP R
)R S
;S T
return 
Results 
. 
Ok 
( 
result $
)$ %
;% &
} 	
)	 

. 	
WithName	 
( 
$str 
) 
. 	
WithSummary	 
( 
$str :
): ;
. 	
Produces	 
< 
List 
< 
RoleDto 
> 
>  
(  !
)! "
;" #
wsGroup 
. 
MapPost 
( 
$str 
, 
async "
(# $
int$ '
workspaceId( 3
,3 4
CreateRoleRequest5 F
requestG N
,N O
IRoleServiceP \
service] d
,d e
HttpContextf q
httpContextr }
,} ~
CancellationToken	 ê
ct
ë ì
)
ì î
=>
ï ó
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var 
result 
= 
await 
service &
.& '
CreateAsync' 2
(2 3
workspaceId3 >
,> ?
userId@ F
,F G
requestH O
,O P
ctQ S
)S T
;T U
return 
Results 
. 
Created "
(" #
$"# %
$str% 8
{8 9
workspaceId9 D
}D E
$strE L
{L M
resultM S
.S T
IdT V
}V W
"W X
,X Y
resultZ `
)` a
;a b
} 	
)	 

. 	
WithName	 
( 
$str 
) 
. 	
WithSummary	 
( 
$str <
)< =
. 	
Produces	 
< 
RoleDto 
> 
( 
StatusCodes &
.& '
Status201Created' 7
)7 8
.   	%
ProducesValidationProblem  	 "
(  " #
)  # $
;  $ %
wsGroup"" 
."" 
MapPut"" 
("" 
$str"" &
,""& '
async""( -
("". /
int""/ 2
workspaceId""3 >
,""> ?
int""@ C
roleId""D J
,""J K
UpdateRoleRequest""L ]
request""^ e
,""e f
IRoleService""g s
service""t {
,""{ |
HttpContext	""} à
httpContext
""â î
,
""î ï
CancellationToken
""ñ ß
ct
""® ™
)
""™ ´
=>
""¨ Æ
{## 	
var$$ 
userId$$ 
=$$ 
WorkspaceEndpoints$$ +
.$$+ ,
	GetUserId$$, 5
($$5 6
httpContext$$6 A
)$$A B
;$$B C
await%% 
service%% 
.%% 
UpdateAsync%% %
(%%% &
workspaceId%%& 1
,%%1 2
roleId%%3 9
,%%9 :
userId%%; A
,%%A B
request%%C J
,%%J K
ct%%L N
)%%N O
;%%O P
return&& 
Results&& 
.&& 
	NoContent&& $
(&&$ %
)&&% &
;&&& '
}'' 	
)''	 

.(( 	
WithName((	 
((( 
$str(( 
)(( 
.)) 	
WithSummary))	 
()) 
$str)) A
)))A B
.** 	
Produces**	 
(** 
StatusCodes** 
.** 
Status204NoContent** 0
)**0 1
;**1 2
wsGroup,, 
.,, 
	MapDelete,, 
(,, 
$str,, )
,,,) *
async,,+ 0
(,,1 2
int,,2 5
workspaceId,,6 A
,,,A B
int,,C F
roleId,,G M
,,,M N
IRoleService,,O [
service,,\ c
,,,c d
HttpContext,,e p
httpContext,,q |
,,,| }
CancellationToken	,,~ è
ct
,,ê í
)
,,í ì
=>
,,î ñ
{-- 	
var.. 
userId.. 
=.. 
WorkspaceEndpoints.. +
...+ ,
	GetUserId.., 5
(..5 6
httpContext..6 A
)..A B
;..B C
await// 
service// 
.// 
ArchiveAsync// &
(//& '
workspaceId//' 2
,//2 3
roleId//4 :
,//: ;
userId//< B
,//B C
ct//D F
)//F G
;//G H
return00 
Results00 
.00 
	NoContent00 $
(00$ %
)00% &
;00& '
}11 	
)11	 

.22 	
WithName22	 
(22 
$str22 
)22  
.33 	
WithSummary33	 
(33 
$str33 ,
)33, -
.44 	
Produces44	 
(44 
StatusCodes44 
.44 
Status204NoContent44 0
)440 1
;441 2
var66 
	permGroup66 
=66 
routes66 
.66 
MapGroup66 '
(66' (
$str66( =
)66= >
.77 
WithTags77 
(77 
$str77 #
)77# $
;77$ %
	permGroup99 
.99 
MapGet99 
(99 
$str99 
,99 
async99 #
(99$ %
IRoleService99% 1
service992 9
,999 :
CancellationToken99; L
ct99M O
)99O P
=>99Q S
{:: 	
var;; 
result;; 
=;; 
await;; 
service;; &
.;;& '"
GetAllPermissionsAsync;;' =
(;;= >
ct;;> @
);;@ A
;;;A B
return<< 
Results<< 
.<< 
Ok<< 
(<< 
result<< $
)<<$ %
;<<% &
}== 	
)==	 

.>> 	
WithName>>	 
(>> 
$str>> #
)>># $
.?? 	
WithSummary??	 
(?? 
$str?? 5
)??5 6
.@@ 	
Produces@@	 
<@@ 
List@@ 
<@@ 
PermissionDto@@ $
>@@$ %
>@@% &
(@@& '
)@@' (
;@@( )
returnBB 
wsGroupBB 
;BB 
}CC 
}DD ≤7
\C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Endpoints\OrgRoleEndpoints.cs
	namespace 	
Relativa
 
. 
Core 
. 
	Endpoints !
;! "
public 
static 
class 
OrgRoleEndpoints $
{ 
public		 

static		 
RouteGroupBuilder		 #
MapOrgRoleEndpoints		$ 7
(		7 8
this		8 <!
IEndpointRouteBuilder		= R
routes		S Y
)		Y Z
{

 
var 
group 
= 
routes 
. 
MapGroup #
(# $
$str$ V
)V W
. 
WithTags 
( 
$str *
)* +
;+ ,
group 
. 
MapGet 
( 
$str 
, 
async 
(  !
int! $
organizationId% 3
,3 4
IOrgRoleService5 D
serviceE L
,L M
HttpContextN Y
httpContextZ e
,e f
CancellationTokeng x
cty {
){ |
=>} 
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var 
result 
= 
await 
service &
.& '"
GetByOrganizationAsync' =
(= >
organizationId> L
,L M
userIdN T
,T U
ctV X
)X Y
;Y Z
return 
Results 
. 
Ok 
( 
result $
)$ %
;% &
} 	
)	 

. 	
WithName	 
( 
$str  
)  !
. 	
WithSummary	 
( 
$str ?
)? @
. 	
Produces	 
< 
List 
< 

OrgRoleDto !
>! "
>" #
(# $
)$ %
;% &
group 
. 
MapPost 
( 
$str 
, 
async  
(! "
int" %
organizationId& 4
,4 5 
CreateOrgRoleRequest6 J
requestK R
,R S
IOrgRoleServiceT c
serviced k
,k l
HttpContextm x
httpContext	y Ñ
,
Ñ Ö
CancellationToken
Ü ó
ct
ò ö
)
ö õ
=>
ú û
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var 
result 
= 
await 
service &
.& '
CreateAsync' 2
(2 3
organizationId3 A
,A B
userIdC I
,I J
requestK R
,R S
ctT V
)V W
;W X
return 
Results 
. 
Created "
(" #
$"# %
$str% ;
{; <
organizationId< J
}J K
$strK R
{R S
resultS Y
.Y Z
IdZ \
}\ ]
"] ^
,^ _
result` f
)f g
;g h
} 	
)	 

. 	
WithName	 
( 
$str !
)! "
. 	
WithSummary	 
( 
$str ?
)? @
.   	
Produces  	 
<   

OrgRoleDto   
>   
(   
StatusCodes   )
.  ) *
Status201Created  * :
)  : ;
.!! 	%
ProducesValidationProblem!!	 "
(!!" #
)!!# $
;!!$ %
group## 
.## 
MapPut## 
(## 
$str## $
,##$ %
async##& +
(##, -
int##- 0
organizationId##1 ?
,##? @
int##A D
roleId##E K
,##K L 
UpdateOrgRoleRequest##M a
request##b i
,##i j
IOrgRoleService##k z
service	##{ Ç
,
##Ç É
HttpContext
##Ñ è
httpContext
##ê õ
,
##õ ú
CancellationToken
##ù Æ
ct
##Ø ±
)
##± ≤
=>
##≥ µ
{$$ 	
var%% 
userId%% 
=%% 
WorkspaceEndpoints%% +
.%%+ ,
	GetUserId%%, 5
(%%5 6
httpContext%%6 A
)%%A B
;%%B C
await&& 
service&& 
.&& 
UpdateAsync&& %
(&&% &
organizationId&&& 4
,&&4 5
roleId&&6 <
,&&< =
userId&&> D
,&&D E
request&&F M
,&&M N
ct&&O Q
)&&Q R
;&&R S
return'' 
Results'' 
.'' 
	NoContent'' $
(''$ %
)''% &
;''& '
}(( 	
)((	 

.)) 	
WithName))	 
()) 
$str)) !
)))! "
.** 	
WithSummary**	 
(** 
$str** 8
)**8 9
.++ 	
Produces++	 
(++ 
StatusCodes++ 
.++ 
Status204NoContent++ 0
)++0 1
;++1 2
group-- 
.-- 
	MapDelete-- 
(-- 
$str-- '
,--' (
async--) .
(--/ 0
int--0 3
organizationId--4 B
,--B C
int--D G
roleId--H N
,--N O
IOrgRoleService--P _
service--` g
,--g h
HttpContext--i t
httpContext	--u Ä
,
--Ä Å
CancellationToken
--Ç ì
ct
--î ñ
)
--ñ ó
=>
--ò ö
{.. 	
var// 
userId// 
=// 
WorkspaceEndpoints// +
.//+ ,
	GetUserId//, 5
(//5 6
httpContext//6 A
)//A B
;//B C
await00 
service00 
.00 
ArchiveAsync00 &
(00& '
organizationId00' 5
,005 6
roleId007 =
,00= >
userId00? E
,00E F
ct00G I
)00I J
;00J K
return11 
Results11 
.11 
	NoContent11 $
(11$ %
)11% &
;11& '
}22 	
)22	 

.33 	
WithName33	 
(33 
$str33 "
)33" #
.44 	
WithSummary44	 
(44 
$str44 9
)449 :
.55 	
Produces55	 
(55 
StatusCodes55 
.55 
Status204NoContent55 0
)550 1
;551 2
return77 
group77 
;77 
}88 
}99 ∂)
^C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Endpoints\OrgMemberEndpoints.cs
	namespace 	
Relativa
 
. 
Core 
. 
	Endpoints !
;! "
public 
static 
class 
OrgMemberEndpoints &
{ 
public 

static 
RouteGroupBuilder #!
MapOrgMemberEndpoints$ 9
(9 :
this: >!
IEndpointRouteBuilder? T
routesU [
)[ \
{		 
var

 
group

 
=

 
routes

 
.

 
MapGroup

 #
(

# $
$str

$ X
)

X Y
. 
WithTags 
( 
$str ,
), -
;- .
group 
. 
MapGet 
( 
$str 
, 
async 
(  !
int! $
organizationId% 3
,3 4 
IOrganizationService5 I
serviceJ Q
,Q R
HttpContextS ^
httpContext_ j
,j k
CancellationTokenl }
ct	~ Ä
)
Ä Å
=>
Ç Ñ
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var 
result 
= 
await 
service &
.& '
GetMembersAsync' 6
(6 7
organizationId7 E
,E F
userIdG M
,M N
ctO Q
)Q R
;R S
return 
Results 
. 
Ok 
( 
result $
)$ %
;% &
} 	
)	 

. 	
WithName	 
( 
$str "
)" #
. 	
WithSummary	 
( 
$str 0
)0 1
. 	
Produces	 
< 
List 
< 
OrgMemberDto #
># $
>$ %
(% &
)& '
;' (
group 
. 
	MapDelete 
( 
$str '
,' (
async) .
(/ 0
int0 3
organizationId4 B
,B C
intD G
userIdH N
,N O 
IOrganizationServiceP d
servicee l
,l m
HttpContextn y
httpContext	z Ö
,
Ö Ü
CancellationToken
á ò
ct
ô õ
)
õ ú
=>
ù ü
{ 	
var 
callerUserId 
= 
WorkspaceEndpoints 1
.1 2
	GetUserId2 ;
(; <
httpContext< G
)G H
;H I
await 
service 
. 
RemoveMemberAsync +
(+ ,
organizationId, :
,: ;
userId< B
,B C
callerUserIdD P
,P Q
ctR T
)T U
;U V
return 
Results 
. 
	NoContent $
($ %
)% &
;& '
} 	
)	 

. 	
WithName	 
( 
$str #
)# $
. 	
WithSummary	 
( 
$str <
)< =
. 	
Produces	 
( 
StatusCodes 
. 
Status204NoContent 0
)0 1
;1 2
group!! 
.!! 
MapPut!! 
(!! 
$str!! )
,!!) *
async!!+ 0
(!!1 2
int!!2 5
organizationId!!6 D
,!!D E
int!!F I
userId!!J P
,!!P Q&
ChangeOrgMemberRoleRequest!!R l
request!!m t
,!!t u!
IOrganizationService	!!v ä
service
!!ã í
,
!!í ì
HttpContext
!!î ü
httpContext
!!† ´
,
!!´ ¨
CancellationToken
!!≠ æ
ct
!!ø ¡
)
!!¡ ¬
=>
!!√ ≈
{"" 	
var## 
callerUserId## 
=## 
WorkspaceEndpoints## 1
.##1 2
	GetUserId##2 ;
(##; <
httpContext##< G
)##G H
;##H I
await$$ 
service$$ 
.$$ !
ChangeMemberRoleAsync$$ /
($$/ 0
organizationId$$0 >
,$$> ?
userId$$@ F
,$$F G
callerUserId$$H T
,$$T U
request$$V ]
,$$] ^
ct$$_ a
)$$a b
;$$b c
return%% 
Results%% 
.%% 
	NoContent%% $
(%%$ %
)%%% &
;%%& '
}&& 	
)&&	 

.'' 	
WithName''	 
('' 
$str'' '
)''' (
.(( 	
WithSummary((	 
((( 
$str(( ;
)((; <
.)) 	
Produces))	 
()) 
StatusCodes)) 
.)) 
Status204NoContent)) 0
)))0 1
;))1 2
return++ 
group++ 
;++ 
},, 
}-- ¶8
bC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Endpoints\OrgInvitationEndpoints.cs
	namespace 	
Relativa
 
. 
Core 
. 
	Endpoints !
;! "
public 
static 
class "
OrgInvitationEndpoints *
{ 
public 

static 
RouteGroupBuilder #%
MapOrgInvitationEndpoints$ =
(= >
this> B!
IEndpointRouteBuilderC X
routesY _
)_ `
{		 
var

 
orgGroup

 
=

 
routes

 
.

 
MapGroup

 &
(

& '
$str

' _
)

_ `
. 
WithTags 
( 
$str 0
)0 1
;1 2
orgGroup 
. 
MapPost 
( 
$str 
, 
async #
($ %
int% (
organizationId) 7
,7 8
InviteToOrgRequest9 K
requestL S
,S T!
IOrgInvitationServiceU j
servicek r
,r s
HttpContextt 
httpContext
Ä ã
,
ã å
CancellationToken
ç û
ct
ü °
)
° ¢
=>
£ •
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var 
result 
= 
await 
service &
.& '
InviteAsync' 2
(2 3
organizationId3 A
,A B
userIdC I
,I J
requestK R
,R S
ctT V
)V W
;W X
return 
Results 
. 
Created "
(" #
$"# %
$str% ;
{; <
organizationId< J
}J K
$strK X
{X Y
resultY _
._ `
Id` b
}b c
"c d
,d e
resultf l
)l m
;m n
} 	
)	 

. 	
WithName	 
( 
$str 
)  
. 	
WithSummary	 
( 
$str A
)A B
. 	
Produces	 
< 
OrgInvitationDto "
>" #
(# $
StatusCodes$ /
./ 0
Status201Created0 @
)@ A
. 	%
ProducesValidationProblem	 "
(" #
)# $
;$ %
orgGroup 
. 
MapGet 
( 
$str 
, 
async "
(# $
int$ '
organizationId( 6
,6 7!
IOrgInvitationService8 M
serviceN U
,U V
HttpContextW b
httpContextc n
,n o
CancellationToken	p Å
ct
Ç Ñ
)
Ñ Ö
=>
Ü à
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var 
result 
= 
await 
service &
.& '"
GetByOrganizationAsync' =
(= >
organizationId> L
,L M
userIdN T
,T U
ctV X
)X Y
;Y Z
return 
Results 
. 
Ok 
( 
result $
)$ %
;% &
} 	
)	 

. 	
WithName	 
( 
$str &
)& '
. 	
WithSummary	 
( 
$str D
)D E
.   	
Produces  	 
<   
List   
<   
OrgInvitationDto   '
>  ' (
>  ( )
(  ) *
)  * +
;  + ,
orgGroup"" 
."" 
	MapDelete"" 
("" 
$str"" 0
,""0 1
async""2 7
(""8 9
int""9 <
organizationId""= K
,""K L
int""M P
invitationId""Q ]
,""] ^!
IOrgInvitationService""_ t
service""u |
,""| }
HttpContext	""~ â
httpContext
""ä ï
,
""ï ñ
CancellationToken
""ó ®
ct
""© ´
)
""´ ¨
=>
""≠ Ø
{## 	
var$$ 
userId$$ 
=$$ 
WorkspaceEndpoints$$ +
.$$+ ,
	GetUserId$$, 5
($$5 6
httpContext$$6 A
)$$A B
;$$B C
await%% 
service%% 
.%% 
CancelAsync%% %
(%%% &
organizationId%%& 4
,%%4 5
invitationId%%6 B
,%%B C
userId%%D J
,%%J K
ct%%L N
)%%N O
;%%O P
return&& 
Results&& 
.&& 
	NoContent&& $
(&&$ %
)&&% &
;&&& '
}'' 	
)''	 

.(( 	
WithName((	 
((( 
$str(( '
)((' (
.)) 	
WithSummary))	 
()) 
$str)) ?
)))? @
.** 	
Produces**	 
(** 
StatusCodes** 
.** 
Status204NoContent** 0
)**0 1
;**1 2
orgGroup,, 
.,, 
MapPost,, 
(,, 
$str,, 5
,,,5 6
async,,7 <
(,,= >
int,,> A
organizationId,,B P
,,,P Q
int,,R U
invitationId,,V b
,,,b c!
IOrgInvitationService,,d y
service	,,z Å
,
,,Å Ç
HttpContext
,,É é
httpContext
,,è ö
,
,,ö õ
CancellationToken
,,ú ≠
ct
,,Æ ∞
)
,,∞ ±
=>
,,≤ ¥
{-- 	
var.. 
userId.. 
=.. 
WorkspaceEndpoints.. +
...+ ,
	GetUserId.., 5
(..5 6
httpContext..6 A
)..A B
;..B C
var// 
result// 
=// 
await// 
service// &
.//& '
ResendAsync//' 2
(//2 3
organizationId//3 A
,//A B
invitationId//C O
,//O P
userId//Q W
,//W X
ct//Y [
)//[ \
;//\ ]
return00 
Results00 
.00 
Ok00 
(00 
result00 $
)00$ %
;00% &
}11 	
)11	 

.22 	
WithName22	 
(22 
$str22 '
)22' (
.33 	
WithSummary33	 
(33 
$str33 b
)33b c
.44 	
Produces44	 
<44 
OrgInvitationDto44 "
>44" #
(44# $
StatusCodes44$ /
.44/ 0
Status200OK440 ;
)44; <
;44< =
return66 
orgGroup66 
;66 
}77 
}88 ÿ/
eC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Endpoints\OrganizationUserEndpoints.cs
	namespace 	
Relativa
 
. 
Core 
. 
	Endpoints !
;! "
public 
static 
class %
OrganizationUserEndpoints -
{		 
public

 

static

 
RouteGroupBuilder

 #(
MapOrganizationUserEndpoints

$ @
(

@ A
this

A E!
IEndpointRouteBuilder

F [
routes

\ b
)

b c
{ 
var 
group 
= 
routes 
. 
MapGroup #
(# $
$str$ V
)V W
. 
WithTags 
( 
$str *
)* +
;+ ,
group 
. 
MapPost 
( 
$str 
, 
async  
(! "
int" %
organizationId& 4
,4 5 
CreateOrgUserRequest6 J
requestK R
,R S)
IOrganizationUserAdminServiceT q
servicer y
,y z
HttpContext	{ Ü
httpContext
á í
,
í ì
CancellationToken
î •
ct
¶ ®
)
® ©
=>
™ ¨
{ 	
var 
callerUserId 
= 
WorkspaceEndpoints 1
.1 2
	GetUserId2 ;
(; <
httpContext< G
)G H
;H I
var 
result 
= 
await 
service &
.& '
CreateOrgUserAsync' 9
(9 :
organizationId: H
,H I
callerUserIdJ V
,V W
requestX _
,_ `
cta c
)c d
;d e
return 
Results 
. 
Created "
(" #
$"# %
$str% ;
{; <
organizationId< J
}J K
$strK R
{R S
resultS Y
.Y Z
IdZ \
}\ ]
"] ^
,^ _
result` f
)f g
;g h
} 	
)	 

. 	
WithName	 
( 
$str !
)! "
. 	
WithSummary	 
( 
$str w
)w x
. 	
Produces	 
< 
RegisterResponseDto %
>% &
(& '
StatusCodes' 2
.2 3
Status201Created3 C
)C D
. 	%
ProducesValidationProblem	 "
(" #
)# $
. 	
Produces	 
( 
StatusCodes 
. 
Status409Conflict /
)/ 0
;0 1
group 
. 
MapPatch 
( 
$str &
,& '
async( -
(. /
int/ 2
organizationId3 A
,A B
intC F
userIdG M
,M N'
UpdateOrgUserProfileRequestO j
requestk r
,r s*
IOrganizationUserAdminService	t ë
service
í ô
,
ô ö
HttpContext
õ ¶
httpContext
ß ≤
,
≤ ≥
CancellationToken
¥ ≈
ct
∆ »
)
» …
=>
  Ã
{ 	
var 
callerUserId 
= 
WorkspaceEndpoints 1
.1 2
	GetUserId2 ;
(; <
httpContext< G
)G H
;H I
var 
result 
= 
await 
service &
.& ''
UpdateOtherUserProfileAsync' B
(B C
organizationIdC Q
,Q R
userIdS Y
,Y Z
callerUserId[ g
,g h
requesti p
,p q
ctr t
)t u
;u v
return 
Results 
. 
Ok 
( 
result $
)$ %
;% &
}   	
)  	 

.!! 	
WithName!!	 
(!! 
$str!! (
)!!( )
."" 	
WithSummary""	 
("" 
$str"" Y
)""Y Z
.## 	
Produces##	 
<## 
UserProfileDto##  
>##  !
(##! "
)##" #
.$$ 	%
ProducesValidationProblem$$	 "
($$" #
)$$# $
;$$$ %
group&& 
.&& 
	MapDelete&& 
(&& 
$str&& '
,&&' (
async&&) .
(&&/ 0
int&&0 3
organizationId&&4 B
,&&B C
int&&D G
userId&&H N
,&&N O)
IOrganizationUserAdminService&&P m
service&&n u
,&&u v
HttpContext	&&w Ç
httpContext
&&É é
,
&&é è
CancellationToken
&&ê °
ct
&&¢ §
)
&&§ •
=>
&&¶ ®
{'' 	
var(( 
callerUserId(( 
=(( 
WorkspaceEndpoints(( 1
.((1 2
	GetUserId((2 ;
(((; <
httpContext((< G
)((G H
;((H I
await)) 
service)) 
.)) 
DeleteOrgUserAsync)) ,
()), -
organizationId))- ;
,)); <
userId))= C
,))C D
callerUserId))E Q
,))Q R
ct))S U
)))U V
;))V W
return** 
Results** 
.** 
	NoContent** $
(**$ %
)**% &
;**& '
}++ 	
)++	 

.,, 	
WithName,,	 
(,, 
$str,, !
),,! "
.-- 	
WithSummary--	 
(-- 
$str-- N
)--N O
... 	
Produces..	 
(.. 
StatusCodes.. 
... 
Status204NoContent.. 0
)..0 1
;..1 2
return00 
group00 
;00 
}11 
}22 ÃT
aC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Endpoints\OrganizationEndpoints.cs
	namespace 	
Relativa
 
. 
Core 
. 
	Endpoints !
;! "
public 
static 
class !
OrganizationEndpoints )
{ 
public 

static 
RouteGroupBuilder #$
MapOrganizationEndpoints$ <
(< =
this= A!
IEndpointRouteBuilderB W
routesX ^
)^ _
{		 
var

 
group

 
=

 
routes

 
.

 
MapGroup

 #
(

# $
$str

$ ;
)

; <
. 
WithTags 
( 
$str %
)% &
;& '
group 
. 
MapPost 
( 
$str 
, 
async  
(! "%
CreateOrganizationRequest" ;
request< C
,C D 
IOrganizationServiceE Y
serviceZ a
,a b
HttpContextc n
httpContexto z
,z {
CancellationToken	| ç
ct
é ê
)
ê ë
=>
í î
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var 
result 
= 
await 
service &
.& '
CreateAsync' 2
(2 3
userId3 9
,9 :
request; B
,B C
ctD F
)F G
;G H
return 
Results 
. 
Created "
(" #
$"# %
$str% ;
{; <
result< B
.B C
IdC E
}E F
"F G
,G H
resultI O
)O P
;P Q
} 	
)	 

. 	
WithName	 
( 
$str &
)& '
. 	
WithSummary	 
( 
$str 0
)0 1
. 	
Produces	 
< 
OrganizationDto !
>! "
(" #
StatusCodes# .
.. /
Status201Created/ ?
)? @
. 	%
ProducesValidationProblem	 "
(" #
)# $
;$ %
group 
. 
MapGet 
( 
$str 
, 
async 
(  ! 
IOrganizationService! 5
service6 =
,= >
HttpContext? J
httpContextK V
,V W
CancellationTokenX i
ctj l
)l m
=>n p
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var 
result 
= 
await 
service &
.& '
GetByUserAsync' 5
(5 6
userId6 <
,< =
ct> @
)@ A
;A B
return 
Results 
. 
Ok 
( 
result $
)$ %
;% &
} 	
)	 

. 	
WithName	 
( 
$str %
)% &
. 	
WithSummary	 
( 
$str D
)D E
.   	
Produces  	 
<   
List   
<   
OrganizationDto   &
>  & '
>  ' (
(  ( )
)  ) *
;  * +
group"" 
."" 
MapGet"" 
("" 
$str"" 
,"" 
async""  %
(""& '
string""' -
?""- .
q""/ 0
,""0 1 
IOrganizationService""2 F
service""G N
,""N O
CancellationToken""P a
ct""b d
)""d e
=>""f h
{## 	
var$$ 
result$$ 
=$$ 
await$$ 
service$$ &
.$$& '
SearchAsync$$' 2
($$2 3
q$$3 4
??$$5 7
string$$8 >
.$$> ?
Empty$$? D
,$$D E
ct$$F H
)$$H I
;$$I J
return%% 
Results%% 
.%% 
Ok%% 
(%% 
result%% $
)%%$ %
;%%% &
}&& 	
)&&	 

.'' 	
WithName''	 
('' 
$str'' '
)''' (
.(( 	
WithSummary((	 
((( 
$str(( U
)((U V
.)) 	
Produces))	 
<)) 
List)) 
<)) '
OrganizationSearchResultDto)) 2
>))2 3
>))3 4
())4 5
)))5 6
;))6 7
group++ 
.++ 
MapGet++ 
(++ 
$str++  
,++  !
async++" '
(++( )
int++) ,
id++- /
,++/ 0 
IOrganizationService++1 E
service++F M
,++M N
HttpContext++O Z
httpContext++[ f
,++f g
CancellationToken++h y
ct++z |
)++| }
=>	++~ Ä
{,, 	
var-- 
userId-- 
=-- 
WorkspaceEndpoints-- +
.--+ ,
	GetUserId--, 5
(--5 6
httpContext--6 A
)--A B
;--B C
var.. 
result.. 
=.. 
await.. 
service.. &
...& '
GetByIdAsync..' 3
(..3 4
id..4 6
,..6 7
userId..8 >
,..> ?
ct..@ B
)..B C
;..C D
return// 
Results// 
.// 
Ok// 
(// 
result// $
)//$ %
;//% &
}00 	
)00	 

.11 	
WithName11	 
(11 
$str11 #
)11# $
.22 	
WithSummary22	 
(22 
$str22 /
)22/ 0
.33 	
Produces33	 
<33 
OrganizationDto33 !
>33! "
(33" #
)33# $
;33$ %
group55 
.55 
MapPut55 
(55 
$str55  
,55  !
async55" '
(55( )
int55) ,
id55- /
,55/ 0%
UpdateOrganizationRequest551 J
request55K R
,55R S 
IOrganizationService55T h
service55i p
,55p q
HttpContext55r }
httpContext	55~ â
,
55â ä
CancellationToken
55ã ú
ct
55ù ü
)
55ü †
=>
55° £
{66 	
var77 
userId77 
=77 
WorkspaceEndpoints77 +
.77+ ,
	GetUserId77, 5
(775 6
httpContext776 A
)77A B
;77B C
await88 
service88 
.88 
UpdateAsync88 %
(88% &
id88& (
,88( )
userId88* 0
,880 1
request882 9
,889 :
ct88; =
)88= >
;88> ?
return99 
Results99 
.99 
	NoContent99 $
(99$ %
)99% &
;99& '
}:: 	
)::	 

.;; 	
WithName;;	 
(;; 
$str;; &
);;& '
.<< 	
WithSummary<<	 
(<< 
$str<< 2
)<<2 3
.== 	
Produces==	 
(== 
StatusCodes== 
.== 
Status204NoContent== 0
)==0 1
.>> 	%
ProducesValidationProblem>>	 "
(>>" #
)>># $
;>>$ %
group@@ 
.@@ 
MapGet@@ 
(@@ 
$str@@ )
,@@) *
async@@+ 0
(@@1 2
int@@2 5
id@@6 8
,@@8 9 
IOrganizationService@@: N
service@@O V
,@@V W
HttpContext@@X c
httpContext@@d o
,@@o p
CancellationToken	@@q Ç
ct
@@É Ö
)
@@Ö Ü
=>
@@á â
{AA 	
varBB 
userIdBB 
=BB 
WorkspaceEndpointsBB +
.BB+ ,
	GetUserIdBB, 5
(BB5 6
httpContextBB6 A
)BBA B
;BBB C
varCC 
resultCC 
=CC 
awaitCC 
serviceCC &
.CC& '
GetSettingsAsyncCC' 7
(CC7 8
idCC8 :
,CC: ;
userIdCC< B
,CCB C
ctCCD F
)CCF G
;CCG H
returnDD 
ResultsDD 
.DD 
OkDD 
(DD 
resultDD $
)DD$ %
;DD% &
}EE 	
)EE	 

.FF 	
WithNameFF	 
(FF 
$strFF +
)FF+ ,
.GG 	
WithSummaryGG	 
(GG 
$strGG H
)GGH I
.HH 	
ProducesHH	 
<HH #
OrganizationSettingsDtoHH )
>HH) *
(HH* +
)HH+ ,
;HH, -
groupJJ 
.JJ 
MapPutJJ 
(JJ 
$strJJ )
,JJ) *
asyncJJ+ 0
(JJ1 2
intJJ2 5
idJJ6 8
,JJ8 9-
!UpdateOrganizationSettingsRequestJJ: [
requestJJ\ c
,JJc d 
IOrganizationServiceJJe y
service	JJz Å
,
JJÅ Ç
HttpContext
JJÉ é
httpContext
JJè ö
,
JJö õ
CancellationToken
JJú ≠
ct
JJÆ ∞
)
JJ∞ ±
=>
JJ≤ ¥
{KK 	
varLL 
userIdLL 
=LL 
WorkspaceEndpointsLL +
.LL+ ,
	GetUserIdLL, 5
(LL5 6
httpContextLL6 A
)LLA B
;LLB C
awaitMM 
serviceMM 
.MM 
UpdateSettingsAsyncMM -
(MM- .
idMM. 0
,MM0 1
userIdMM2 8
,MM8 9
requestMM: A
,MMA B
ctMMC E
)MME F
;MMF G
returnNN 
ResultsNN 
.NN 
	NoContentNN $
(NN$ %
)NN% &
;NN& '
}OO 	
)OO	 

.PP 	
WithNamePP	 
(PP 
$strPP .
)PP. /
.QQ 	
WithSummaryQQ	 
(QQ 
$strQQ Y
)QQY Z
.RR 	
ProducesRR	 
(RR 
StatusCodesRR 
.RR 
Status204NoContentRR 0
)RR0 1
.SS 	%
ProducesValidationProblemSS	 "
(SS" #
)SS# $
;SS$ %
returnUU 
groupUU 
;UU 
}VV 
}WW ¬7
[C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Endpoints\MemberEndpoints.cs
	namespace 	
Relativa
 
. 
Core 
. 
	Endpoints !
;! "
public 
static 
class 
MemberEndpoints #
{ 
public 

static 
RouteGroupBuilder #
MapMemberEndpoints$ 6
(6 7
this7 ;!
IEndpointRouteBuilder< Q
routesR X
)X Y
{		 
var

 
group

 
=

 
routes

 
.

 
MapGroup

 #
(

# $
$str

$ R
)

R S
. 
WithTags 
( 
$str 
)  
;  !
group 
. 
MapGet 
( 
$str 
, 
async 
(  !
int! $
workspaceId% 0
,0 1#
IWorkspaceMemberService2 I
serviceJ Q
,Q R
HttpContextS ^
httpContext_ j
,j k
CancellationTokenl }
ct	~ Ä
)
Ä Å
=>
Ç Ñ
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var 
result 
= 
await 
service &
.& '
GetMembersAsync' 6
(6 7
workspaceId7 B
,B C
userIdD J
,J K
ctL N
)N O
;O P
return 
Results 
. 
Ok 
( 
result $
)$ %
;% &
} 	
)	 

. 	
WithName	 
( 
$str 
)  
. 	
WithSummary	 
( 
$str -
)- .
. 	
Produces	 
< 
List 
< 
WorkspaceMemberDto )
>) *
>* +
(+ ,
), -
;- .
group 
. 
MapPost 
( 
$str 
, 
async  
(! "
int" %
workspaceId& 1
,1 2%
AddWorkspaceMemberRequest3 L
requestM T
,T U#
IWorkspaceMemberServiceV m
servicen u
,u v
HttpContext	w Ç
httpContext
É é
,
é è
CancellationToken
ê °
ct
¢ §
)
§ •
=>
¶ ®
{ 	
var 
callerUserId 
= 
WorkspaceEndpoints 1
.1 2
	GetUserId2 ;
(; <
httpContext< G
)G H
;H I
var 
result 
= 
await 
service &
.& '
AddMemberAsync' 5
(5 6
workspaceId6 A
,A B
callerUserIdC O
,O P
requestQ X
,X Y
ctZ \
)\ ]
;] ^
return 
Results 
. 
Created "
(" #
$"# %
$str% 8
{8 9
workspaceId9 D
}D E
$strE N
{N O
resultO U
.U V
UserIdV \
}\ ]
"] ^
,^ _
result` f
)f g
;g h
} 	
)	 

. 	
WithName	 
( 
$str 
) 
. 	
WithSummary	 
( 
$str =
)= >
. 	
Produces	 
< 
WorkspaceMemberDto $
>$ %
(% &
StatusCodes& 1
.1 2
Status201Created2 B
)B C
;C D
group!! 
.!! 
MapPut!! 
(!! 
$str!! /
,!!/ 0
async!!1 6
(!!7 8
int!!8 ;
workspaceId!!< G
,!!G H
int!!I L
targetUserId!!M Y
,!!Y Z#
UpdateMemberRoleRequest!![ r
request!!s z
,!!z {$
IWorkspaceMemberService	!!| ì
service
!!î õ
,
!!õ ú
HttpContext
!!ù ®
httpContext
!!© ¥
,
!!¥ µ
CancellationToken
!!∂ «
ct
!!»  
)
!!  À
=>
!!Ã Œ
{"" 	
var## 
callerUserId## 
=## 
WorkspaceEndpoints## 1
.##1 2
	GetUserId##2 ;
(##; <
httpContext##< G
)##G H
;##H I
await$$ 
service$$ 
.$$ 
UpdateRoleAsync$$ )
($$) *
workspaceId$$* 5
,$$5 6
targetUserId$$7 C
,$$C D
callerUserId$$E Q
,$$Q R
request$$S Z
,$$Z [
ct$$\ ^
)$$^ _
;$$_ `
return%% 
Results%% 
.%% 
	NoContent%% $
(%%$ %
)%%% &
;%%& '
}&& 	
)&&	 

.'' 	
WithName''	 
('' 
$str'' $
)''$ %
.(( 	
WithSummary((	 
((( 
$str(( -
)((- .
.)) 	
Produces))	 
()) 
StatusCodes)) 
.)) 
Status204NoContent)) 0
)))0 1
;))1 2
group++ 
.++ 
	MapDelete++ 
(++ 
$str++ -
,++- .
async++/ 4
(++5 6
int++6 9
workspaceId++: E
,++E F
int++G J
targetUserId++K W
,++W X#
IWorkspaceMemberService++Y p
service++q x
,++x y
HttpContext	++z Ö
httpContext
++Ü ë
,
++ë í
CancellationToken
++ì §
ct
++• ß
)
++ß ®
=>
++© ´
{,, 	
var-- 
callerUserId-- 
=-- 
WorkspaceEndpoints-- 1
.--1 2
	GetUserId--2 ;
(--; <
httpContext--< G
)--G H
;--H I
await.. 
service.. 
... 
RemoveAsync.. %
(..% &
workspaceId..& 1
,..1 2
targetUserId..3 ?
,..? @
callerUserId..A M
,..M N
ct..O Q
)..Q R
;..R S
return// 
Results// 
.// 
	NoContent// $
(//$ %
)//% &
;//& '
}00 	
)00	 

.11 	
WithName11	 
(11 
$str11  
)11  !
.22 	
WithSummary22	 
(22 
$str22 9
)229 :
.33 	
Produces33	 
(33 
StatusCodes33 
.33 
Status204NoContent33 0
)330 1
;331 2
return55 
group55 
;55 
}66 
}77 «C
`C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Endpoints\JoinRequestEndpoints.cs
	namespace 	
Relativa
 
. 
Core 
. 
	Endpoints !
;! "
public 
static 
class  
JoinRequestEndpoints (
{ 
public 

static 
RouteGroupBuilder ##
MapJoinRequestEndpoints$ ;
(; <
this< @!
IEndpointRouteBuilderA V
routesW ]
)] ^
{		 
var

 
orgGroup

 
=

 
routes

 
.

 
MapGroup

 &
(

& '
$str

' a
)

a b
. 
WithTags 
( 
$str %
)% &
;& '
orgGroup 
. 
MapPost 
( 
$str 
, 
async #
($ %
int% (
organizationId) 7
,7 8$
CreateJoinRequestRequest9 Q
requestR Y
,Y Z
IJoinRequestService[ n
serviceo v
,v w
HttpContext	x É
httpContext
Ñ è
,
è ê
CancellationToken
ë ¢
ct
£ •
)
• ¶
=>
ß ©
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var 
result 
= 
await 
service &
.& '
SubmitAsync' 2
(2 3
organizationId3 A
,A B
userIdC I
,I J
requestK R
,R S
ctT V
)V W
;W X
return 
Results 
. 
Created "
(" #
$"# %
$str% ;
{; <
organizationId< J
}J K
$strK Z
{Z [
result[ a
.a b
Idb d
}d e
"e f
,f g
resulth n
)n o
;o p
} 	
)	 

. 	
WithName	 
( 
$str %
)% &
. 	
WithSummary	 
( 
$str @
)@ A
. 	
Produces	 
< 
JoinRequestDto  
>  !
(! "
StatusCodes" -
.- .
Status201Created. >
)> ?
;? @
orgGroup 
. 
MapGet 
( 
$str 
, 
async "
(# $
int$ '
organizationId( 6
,6 7
IJoinRequestService8 K
serviceL S
,S T
HttpContextU `
httpContexta l
,l m
CancellationTokenn 
ct
Ä Ç
)
Ç É
=>
Ñ Ü
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var 
result 
= 
await 
service &
.& '"
GetByOrganizationAsync' =
(= >
organizationId> L
,L M
userIdN T
,T U
ctV X
)X Y
;Y Z
return 
Results 
. 
Ok 
( 
result $
)$ %
;% &
} 	
)	 

. 	
WithName	 
( 
$str $
)$ %
. 	
WithSummary	 
( 
$str F
)F G
. 	
Produces	 
< 
List 
< 
JoinRequestDto %
>% &
>& '
(' (
)( )
;) *
orgGroup!! 
.!! 
MapPut!! 
(!! 
$str!! *
,!!* +
async!!, 1
(!!2 3
int!!3 6
organizationId!!7 E
,!!E F
int!!G J
	requestId!!K T
,!!T U$
ReviewJoinRequestRequest!!V n
request!!o v
,!!v w 
IJoinRequestService	!!x ã
service
!!å ì
,
!!ì î
HttpContext
!!ï †
httpContext
!!° ¨
,
!!¨ ≠
CancellationToken
!!Æ ø
ct
!!¿ ¬
)
!!¬ √
=>
!!ƒ ∆
{"" 	
var## 
userId## 
=## 
WorkspaceEndpoints## +
.##+ ,
	GetUserId##, 5
(##5 6
httpContext##6 A
)##A B
;##B C
await$$ 
service$$ 
.$$ 
ReviewAsync$$ %
($$% &
organizationId$$& 4
,$$4 5
	requestId$$6 ?
,$$? @
userId$$A G
,$$G H
request$$I P
,$$P Q
ct$$R T
)$$T U
;$$U V
return%% 
Results%% 
.%% 
	NoContent%% $
(%%$ %
)%%% &
;%%& '
}&& 	
)&&	 

.'' 	
WithName''	 
('' 
$str'' %
)''% &
.(( 	
WithSummary((	 
((( 
$str(( 7
)((7 8
.)) 	
Produces))	 
()) 
StatusCodes)) 
.)) 
Status204NoContent)) 0
)))0 1
.** 	%
ProducesValidationProblem**	 "
(**" #
)**# $
;**$ %
var,, 
myGroup,, 
=,, 
routes,, 
.,, 
MapGroup,, %
(,,% &
$str,,& =
),,= >
.-- 
WithTags-- 
(-- 
$str-- %
)--% &
;--& '
myGroup// 
.// 
MapGet// 
(// 
$str// 
,// 
async//  %
(//& '
IJoinRequestService//' :
service//; B
,//B C
HttpContext//D O
httpContext//P [
,//[ \
CancellationToken//] n
ct//o q
)//q r
=>//s u
{00 	
var11 
userId11 
=11 
WorkspaceEndpoints11 +
.11+ ,
	GetUserId11, 5
(115 6
httpContext116 A
)11A B
;11B C
var22 
result22 
=22 
await22 
service22 &
.22& '
GetMyRequestsAsync22' 9
(229 :
userId22: @
,22@ A
ct22B D
)22D E
;22E F
return33 
Results33 
.33 
Ok33 
(33 
result33 $
)33$ %
;33% &
}44 	
)44	 

.55 	
WithName55	 
(55 
$str55 %
)55% &
.66 	
WithSummary66	 
(66 
$str66 P
)66P Q
.77 	
Produces77	 
<77 
List77 
<77 
JoinRequestDto77 %
>77% &
>77& '
(77' (
)77( )
;77) *
myGroup99 
.99 
	MapDelete99 
(99 
$str99 1
,991 2
async993 8
(999 :
int99: =
	requestId99> G
,99G H
IJoinRequestService99I \
service99] d
,99d e
HttpContext99f q
httpContext99r }
,99} ~
CancellationToken	99 ê
ct
99ë ì
)
99ì î
=>
99ï ó
{:: 	
var;; 
userId;; 
=;; 
WorkspaceEndpoints;; +
.;;+ ,
	GetUserId;;, 5
(;;5 6
httpContext;;6 A
);;A B
;;;B C
await<< 
service<< 
.<< 
CancelMineAsync<< )
(<<) *
	requestId<<* 3
,<<3 4
userId<<5 ;
,<<; <
ct<<= ?
)<<? @
;<<@ A
return== 
Results== 
.== 
	NoContent== $
(==$ %
)==% &
;==& '
}>> 	
)>>	 

.?? 	
WithName??	 
(?? 
$str?? '
)??' (
.@@ 	
WithSummary@@	 
(@@ 
$str@@ X
)@@X Y
.AA 	
ProducesAA	 
(AA 
StatusCodesAA 
.AA 
Status204NoContentAA 0
)AA0 1
;AA1 2
returnCC 
orgGroupCC 
;CC 
}DD 
}EE „6
_C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Endpoints\InvitationEndpoints.cs
	namespace 	
Relativa
 
. 
Core 
. 
	Endpoints !
;! "
public 
static 
class 
InvitationEndpoints '
{ 
public		 

static		 
RouteGroupBuilder		 #"
MapInvitationEndpoints		$ :
(		: ;
this		; ?!
IEndpointRouteBuilder		@ U
routes		V \
)		\ ]
{

 
var 
invGroup 
= 
routes 
. 
MapGroup &
(& '
$str' <
)< =
. 
WithTags 
( 
$str #
)# $
;$ %
invGroup 
. 
MapPost 
( 
$str &
,& '
async( -
(. /&
AcceptOrgInvitationRequest/ I
requestJ Q
,Q R!
IOrgInvitationServiceS h

orgServicei s
,s t
HttpContext	u Ä
httpContext
Å å
,
å ç
CancellationToken
é ü
ct
† ¢
)
¢ £
=>
§ ¶
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var 
email 
= 
WorkspaceEndpoints *
.* +
GetUserEmail+ 7
(7 8
httpContext8 C
)C D
;D E
await 

orgService 
. 
AcceptAsync (
(( )
userId) /
,/ 0
email1 6
,6 7
request8 ?
.? @
Token@ E
,E F
ctG I
)I J
;J K
return 
Results 
. 
Ok 
( 
new !
{" #
message$ +
=, -
$str. Q
}R S
)S T
;T U
} 	
)	 

. 	
WithName	 
( 
$str '
)' (
. 	
WithSummary	 
( 
$str A
)A B
. 	
Produces	 
( 
StatusCodes 
. 
Status200OK )
)) *
;* +
invGroup 
. 
MapPost 
( 
$str '
,' (
async) .
(/ 0&
AcceptOrgInvitationRequest0 J
requestK R
,R S!
IOrgInvitationServiceT i

orgServicej t
,t u
HttpContext	v Å
httpContext
Ç ç
,
ç é
CancellationToken
è †
ct
° £
)
£ §
=>
• ß
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var 
email 
= 
WorkspaceEndpoints *
.* +
GetUserEmail+ 7
(7 8
httpContext8 C
)C D
;D E
await 

orgService 
. 
DeclineAsync )
() *
userId* 0
,0 1
email2 7
,7 8
request9 @
.@ A
TokenA F
,F G
ctH J
)J K
;K L
return 
Results 
. 
Ok 
( 
new !
{" #
message$ +
=, -
$str. Q
}R S
)S T
;T U
} 	
)	 

.   	
WithName  	 
(   
$str   (
)  ( )
.!! 	
WithSummary!!	 
(!! 
$str!! B
)!!B C
."" 	
Produces""	 
("" 
StatusCodes"" 
."" 
Status200OK"" )
)"") *
;""* +
invGroup$$ 
.$$ 
MapGet$$ 
($$ 
$str$$ 
,$$  
async$$! &
($$' (!
IOrgInvitationService$$( =

orgService$$> H
,$$H I
HttpContext$$J U
httpContext$$V a
,$$a b
CancellationToken$$c t
ct$$u w
)$$w x
=>$$y {
{%% 	
var&& 
email&& 
=&& 
WorkspaceEndpoints&& *
.&&* +
GetUserEmail&&+ 7
(&&7 8
httpContext&&8 C
)&&C D
;&&D E
var'' 
list'' 
='' 
await'' 

orgService'' '
.''' ((
GetMyPendingInvitationsAsync''( D
(''D E
email''E J
,''J K
ct''L N
)''N O
;''O P
return(( 
Results(( 
.(( 
Ok(( 
((( 
new(( !
MyInvitationsDto((" 2
(((2 3
list((3 7
)((7 8
)((8 9
;((9 :
})) 	
)))	 

.** 	
WithName**	 
(** 
$str** $
)**$ %
.++ 	
WithSummary++	 
(++ 
$str++ V
)++V W
.,, 	
Produces,,	 
<,, 
MyInvitationsDto,, "
>,," #
(,,# $
),,$ %
;,,% &
invGroup.. 
... 
MapGet.. 
(.. 
$str.. ,
,.., -
async... 3
(..4 5!
IOrgInvitationService..5 J

orgService..K U
,..U V
HttpContext..W b
httpContext..c n
,..n o
CancellationToken	..p Å
ct
..Ç Ñ
)
..Ñ Ö
=>
..Ü à
{// 	
var00 
email00 
=00 
WorkspaceEndpoints00 *
.00* +
GetUserEmail00+ 7
(007 8
httpContext008 C
)00C D
;00D E
var11 
result11 
=11 
await11 

orgService11 )
.11) *(
GetMyPendingInvitationsAsync11* F
(11F G
email11G L
,11L M
ct11N P
)11P Q
;11Q R
return22 
Results22 
.22 
Ok22 
(22 
result22 $
)22$ %
;22% &
}33 	
)33	 

.44 	
WithName44	 
(44 
$str44 0
)440 1
.55 	
WithSummary55	 
(55 
$str55 V
)55V W
.66 	
Produces66	 
<66 
List66 
<66 
OrgInvitationDto66 '
>66' (
>66( )
(66) *
)66* +
;66+ ,
return88 
invGroup88 
;88 
}99 
}:: ˙
_C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Endpoints\EntityTypeEndpoints.cs
	namespace 	
Relativa
 
. 
Core 
. 
	Endpoints !
;! "
public 
static 
class 
EntityTypeEndpoints '
{ 
public 

static !
IEndpointRouteBuilder '"
MapEntityTypeEndpoints( >
(> ?
this? C!
IEndpointRouteBuilderD Y
routesZ `
)` a
{		 
var

 
group

 
=

 
routes

 
.

 
MapGroup

 #
(

# $
$str

$ :
)

: ;
. 
WithTags 
( 
$str #
)# $
;$ %
group 
. 
MapGet 
( 
$str 
, 
async 
(  !
IEntityTypeService! 3
service4 ;
,; <
CancellationToken= N
ctO Q
)Q R
=>S U
{ 	
var 
result 
= 
await 
service &
.& '
GetAllAsync' 2
(2 3
ct3 5
)5 6
;6 7
return 
Results 
. 
Ok 
( 
result $
)$ %
;% &
} 	
)	 

. 	
WithName	 
( 
$str #
)# $
. 	
WithSummary	 
( 
$str L
)L M
. 	
Produces	 
< 
List 
< 
EntityTypeDto $
>$ %
>% &
(& '
)' (
;( )
return 
routes 
; 
} 
} ±-
gC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Endpoints\EntityRelationshipEndpoints.cs
	namespace 	
Relativa
 
. 
Core 
. 
	Endpoints !
;! "
public 
static 
class '
EntityRelationshipEndpoints /
{ 
public 

static !
IEndpointRouteBuilder '*
MapEntityRelationshipEndpoints( F
(F G
thisG K!
IEndpointRouteBuilderL a
routesb h
)h i
{		 
var

 
group

 
=

 
routes

 
.

 
MapGroup

 #
(

# $
$str

$ _
)

_ `
. 
WithTags 
( 
$str ,
), -
;- .
group 
. 
MapPost 
( 
$str 
, 
async  
(! "
int 
workspaceId 
, +
CreateEntityRelationshipRequest +
request, 3
,3 4
IEntityService 
service "
," #
HttpContext 
httpContext #
,# $
CancellationToken 
ct  
)  !
=>" $
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var 
result 
= 
await 
service &
.& '#
CreateRelationshipAsync' >
(> ?
workspaceId? J
,J K
userIdL R
,R S
requestT [
,[ \
ct] _
)_ `
;` a
return 
Results 
. 
Created "
(" #
$" 
$str %
{% &
workspaceId& 1
}1 2
$str2 H
{H I
resultI O
.O P
RelationshipIdP ^
}^ _
"_ `
,` a
result 
) 
; 
} 	
)	 

. 	
WithName	 
( 
$str ,
), -
. 	
WithSummary	 
( 
$str I
)I J
. 	
Produces	 
< $
EntityRelationshipRefDto *
>* +
(+ ,
StatusCodes, 7
.7 8
Status201Created8 H
)H I
;I J
group 
. 
	MapDelete 
( 
$str /
,/ 0
async1 6
(7 8
int 
workspaceId 
, 
int   
relationshipId   
,   
IEntityService!! 
service!! "
,!!" #
HttpContext"" 
httpContext"" #
,""# $
CancellationToken## 
ct##  
)##  !
=>##" $
{$$ 	
var%% 
userId%% 
=%% 
WorkspaceEndpoints%% +
.%%+ ,
	GetUserId%%, 5
(%%5 6
httpContext%%6 A
)%%A B
;%%B C
await&& 
service&& 
.&& #
DeleteRelationshipAsync&& 1
(&&1 2
workspaceId&&2 =
,&&= >
userId&&? E
,&&E F
relationshipId&&G U
,&&U V
ct&&W Y
)&&Y Z
;&&Z [
return'' 
Results'' 
.'' 
	NoContent'' $
(''$ %
)''% &
;''& '
}(( 	
)((	 

.)) 	
WithName))	 
()) 
$str)) ,
))), -
.** 	
WithSummary**	 
(** 
$str** f
)**f g
.++ 	
Produces++	 
(++ 
StatusCodes++ 
.++ 
Status204NoContent++ 0
)++0 1
;++1 2
group-- 
.-- 
MapPut-- 
(-- 
$str-- ,
,--, -
async--. 3
(--4 5
int.. 
workspaceId.. 
,.. 
int// 
relationshipId// 
,// -
!ReassignEntityRelationshipRequest00 -
request00. 5
,005 6
IEntityService11 
service11 "
,11" #
HttpContext22 
httpContext22 #
,22# $
CancellationToken33 
ct33  
)33  !
=>33" $
{44 	
var55 
userId55 
=55 
WorkspaceEndpoints55 +
.55+ ,
	GetUserId55, 5
(555 6
httpContext556 A
)55A B
;55B C
var66 
result66 
=66 
await66 
service66 &
.66& '%
ReassignRelationshipAsync66' @
(66@ A
workspaceId66A L
,66L M
userId66N T
,66T U
relationshipId66V d
,66d e
request66f m
,66m n
ct66o q
)66q r
;66r s
return77 
Results77 
.77 
Ok77 
(77 
result77 $
)77$ %
;77% &
}88 	
)88	 

.99 	
WithName99	 
(99 
$str99 .
)99. /
.:: 	
WithSummary::	 
(:: 
$str:: n
)::n o
.;; 	
Produces;;	 
<;; $
EntityRelationshipRefDto;; *
>;;* +
(;;+ ,
StatusCodes;;, 7
.;;7 8
Status200OK;;8 C
);;C D
;;;D E
return== 
routes== 
;== 
}>> 
}?? Úï
[C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core\Endpoints\EntityEndpoints.cs
	namespace 	
Relativa
 
. 
Core 
. 
	Endpoints !
;! "
public

 
static

 
class

 
EntityEndpoints

 #
{ 
public 

static !
IEndpointRouteBuilder '
MapEntityEndpoints( :
(: ;
this; ?!
IEndpointRouteBuilder@ U
routesV \
)\ ]
{ 
var 
group 
= 
routes 
. 
MapGroup #
(# $
$str$ S
)S T
. 
WithTags 
( 
$str  
)  !
;! "
group 
. 
MapGet 
( 
$str 
, 
async 
(  !
int 
workspaceId 
, 
int 
? 
entityTypeId 
, 
string 
? 
q 
, 
int 
? 
skip 
, 
int 
? 
take 
, 
[ 
	FromQuery 
( 
Name 
= 
$str !
)! "
]" #
string$ *
[* +
]+ ,
?, -
f. /
,/ 0
[ 
	FromQuery 
( 
Name 
= 
$str $
)$ %
]% &
string' -
[- .
]. /
?/ 0
sort1 5
,5 6
int 
? (
excludeLinkedSourceRelTypeId -
,- .
int 
? (
excludeLinkedTargetRelTypeId -
,- .
IEntityService 
service "
," #
HttpContext 
httpContext #
,# $
CancellationToken 
ct  
)  !
=>" $
{ 	
var 
userId 
= 
WorkspaceEndpoints +
.+ ,
	GetUserId, 5
(5 6
httpContext6 A
)A B
;B C
var   
filters   
=   
ParseFilters   &
(  & '
f  ' (
)  ( )
;  ) *
var!! 

sortFields!! 
=!! 
	ParseSort!! &
(!!& '
sort!!' +
)!!+ ,
;!!, -
var"" 
result"" 
="" 
await"" 
service"" &
.""& '
GetByWorkspaceAsync""' :
("": ;
workspaceId## 
,## 
userId## #
,### $
entityTypeId##% 1
,##1 2
q##3 4
,##4 5
skip$$ 
??$$ 
$num$$ 
,$$ 
take$$ 
??$$  "
$num$$# %
,$$% &
filters%% 
,%% 

sortFields%% #
,%%# $(
excludeLinkedSourceRelTypeId&& ,
,&&, -(
excludeLinkedTargetRelTypeId&&. J
,&&J K
ct&&L N
)&&N O
;&&O P
return'' 
Results'' 
.'' 
Ok'' 
('' 
result'' $
)''$ %
;''% &
}(( 	
)((	 

.)) 	
WithName))	 
()) 
$str))  
)))  !
.** 	
Produces**	 
<** 
EntityPagedResult** #
>**# $
(**$ %
)**% &
.++ 	
WithOpenApi++	 
(++ 
op++ 
=>++ 
{,, 	
op-- 
.-- 
Summary-- 
=-- 
$str-- V
;--V W
op.. 
... 
Description.. 
=.. 
$str.T 
;TT 
foreachVV 
(VV 
varVV 
pVV 
inVV 
opVV  
.VV  !

ParametersVV! +
)VV+ ,
{WW 
pXX 
.XX 
DescriptionXX 
=XX 
pXX  !
.XX! "
NameXX" &
switchXX' -
{YY 
$strZZ !
=>ZZ" $
$str[[ F
,[[F G
$str\\ "
=>\\# %
$str]] w
,]]w x
$str^^ 
=>^^ 
$str__ }
,__} ~
$str`` 
=>`` 
$straa p
,aap q
$strbb 
=>bb 
$strcc T
,ccT U
$strdd 
=>dd 
$stree _
+ee` a
$strff @
+ffA B
$strgg N
+ggO P
$strhh U
+hhV W
$strii 2
+ii3 4
$strjj [
+jj\ ]
$strkk v
+kkw x
$strll 
,	ll Ä
$strmm 
=>mm 
$strnn {
+nn| }
$stroo h
+ooi j
$strpp c
,ppc d
$strqq 2
=>qq3 5
$str	rr ï
,
rrï ñ
$strss 2
=>ss3 5
$strtt u
,ttu v
_uu 
=>uu 
puu 
.uu 
Descriptionuu &
}vv 
;vv 
}ww 
ifyy 
(yy 
opyy 
.yy 
	Responsesyy 
.yy 
TryGetValueyy (
(yy( )
$stryy) .
,yy. /
outyy0 3
varyy4 7
ok200yy8 =
)yy= >
)yy> ?
{zz 
ok200{{ 
.{{ 
Description{{ !
={{" #
$str	{{$ Å
;
{{Å Ç
if|| 
(|| 
ok200|| 
.|| 
Content|| !
.||! "
TryGetValue||" -
(||- .
$str||. @
,||@ A
out||B E
var||F I
media||J O
)||O P
)||P Q
{}} 
media~~ 
.~~ 
Example~~ !
=~~" #
JsonNode~~$ ,
.~~, -
Parse~~- 2
(~~2 3
$str	~ú3 
)
úú 
;
úú 
}
ùù 
}
ûû 
return
†† 
op
†† 
;
†† 
}
°° 	
)
°°	 

;
°°
 
group
££ 
.
££ 
MapGet
££ 
(
££ 
$str
££ &
,
££& '
async
££( -
(
££. /
int
££/ 2
workspaceId
££3 >
,
££> ?
int
££@ C
entityId
££D L
,
££L M
IEntityService
££N \
service
££] d
,
££d e
HttpContext
££f q
httpContext
££r }
,
££} ~ 
CancellationToken££ ê
ct££ë ì
)££ì î
=>££ï ó
{
§§ 	
var
•• 
userId
•• 
=
••  
WorkspaceEndpoints
•• +
.
••+ ,
	GetUserId
••, 5
(
••5 6
httpContext
••6 A
)
••A B
;
••B C
var
¶¶ 
result
¶¶ 
=
¶¶ 
await
¶¶ 
service
¶¶ &
.
¶¶& '
GetByIdAsync
¶¶' 3
(
¶¶3 4
entityId
¶¶4 <
,
¶¶< =
workspaceId
¶¶> I
,
¶¶I J
userId
¶¶K Q
,
¶¶Q R
ct
¶¶S U
)
¶¶U V
;
¶¶V W
return
ßß 
Results
ßß 
.
ßß 
Ok
ßß 
(
ßß 
result
ßß $
)
ßß$ %
;
ßß% &
}
®® 	
)
®®	 

.
©© 	
WithName
©©	 
(
©© 
$str
©© 
)
©© 
.
™™ 	
WithSummary
™™	 
(
™™ 
$str
™™ O
)
™™O P
.
´´ 	
Produces
´´	 
<
´´ 
EntityDetailDto
´´ !
>
´´! "
(
´´" #
)
´´# $
;
´´$ %
group
≠≠ 
.
≠≠ 
MapPost
≠≠ 
(
≠≠ 
$str
≠≠ 
,
≠≠ 
async
≠≠  
(
≠≠! "
int
≠≠" %
workspaceId
≠≠& 1
,
≠≠1 2!
CreateEntityRequest
≠≠3 F
request
≠≠G N
,
≠≠N O
IEntityService
≠≠P ^
service
≠≠_ f
,
≠≠f g
HttpContext
≠≠h s
httpContext
≠≠t 
,≠≠ Ä!
CancellationToken≠≠Å í
ct≠≠ì ï
)≠≠ï ñ
=>≠≠ó ô
{
ÆÆ 	
var
ØØ 
userId
ØØ 
=
ØØ  
WorkspaceEndpoints
ØØ +
.
ØØ+ ,
	GetUserId
ØØ, 5
(
ØØ5 6
httpContext
ØØ6 A
)
ØØA B
;
ØØB C
var
∞∞ 
result
∞∞ 
=
∞∞ 
await
∞∞ 
service
∞∞ &
.
∞∞& '
CreateAsync
∞∞' 2
(
∞∞2 3
workspaceId
∞∞3 >
,
∞∞> ?
userId
∞∞@ F
,
∞∞F G
request
∞∞H O
,
∞∞O P
ct
∞∞Q S
)
∞∞S T
;
∞∞T U
return
±± 
Results
±± 
.
±± 
Created
±± "
(
±±" #
$"
±±# %
$str
±±% 8
{
±±8 9
workspaceId
±±9 D
}
±±D E
$str
±±E O
{
±±O P
result
±±P V
.
±±V W
Id
±±W Y
}
±±Y Z
"
±±Z [
,
±±[ \
result
±±] c
)
±±c d
;
±±d e
}
≤≤ 	
)
≤≤	 

.
≥≥ 	
WithName
≥≥	 
(
≥≥ 
$str
≥≥  
)
≥≥  !
.
¥¥ 	
WithSummary
¥¥	 
(
¥¥ 
$str
¥¥ T
)
¥¥T U
.
µµ 	
Produces
µµ	 
<
µµ 
EntityDetailDto
µµ !
>
µµ! "
(
µµ" #
StatusCodes
µµ# .
.
µµ. /
Status201Created
µµ/ ?
)
µµ? @
.
∂∂ 	'
ProducesValidationProblem
∂∂	 "
(
∂∂" #
)
∂∂# $
;
∂∂$ %
group
∏∏ 
.
∏∏ 
MapPatch
∏∏ 
(
∏∏ 
$str
∏∏ (
,
∏∏( )
async
∏∏* /
(
∏∏0 1
int
∏∏1 4
workspaceId
∏∏5 @
,
∏∏@ A
int
∏∏B E
entityId
∏∏F N
,
∏∏N O!
UpdateEntityRequest
∏∏P c
request
∏∏d k
,
∏∏k l
IEntityService
∏∏m {
service∏∏| É
,∏∏É Ñ
HttpContext∏∏Ö ê
httpContext∏∏ë ú
,∏∏ú ù!
CancellationToken∏∏û Ø
ct∏∏∞ ≤
)∏∏≤ ≥
=>∏∏¥ ∂
{
ππ 	
var
∫∫ 
userId
∫∫ 
=
∫∫  
WorkspaceEndpoints
∫∫ +
.
∫∫+ ,
	GetUserId
∫∫, 5
(
∫∫5 6
httpContext
∫∫6 A
)
∫∫A B
;
∫∫B C
var
ªª 
result
ªª 
=
ªª 
await
ªª 
service
ªª &
.
ªª& '
UpdateAsync
ªª' 2
(
ªª2 3
entityId
ªª3 ;
,
ªª; <
workspaceId
ªª= H
,
ªªH I
userId
ªªJ P
,
ªªP Q
request
ªªR Y
,
ªªY Z
ct
ªª[ ]
)
ªª] ^
;
ªª^ _
return
ºº 
Results
ºº 
.
ºº 
Ok
ºº 
(
ºº 
result
ºº $
)
ºº$ %
;
ºº% &
}
ΩΩ 	
)
ΩΩ	 

.
ææ 	
WithName
ææ	 
(
ææ 
$str
ææ  
)
ææ  !
.
øø 	
WithSummary
øø	 
(
øø 
$strøø ∏
)øø∏ π
.
¿¿ 	
Produces
¿¿	 
<
¿¿ 
EntityDetailDto
¿¿ !
>
¿¿! "
(
¿¿" #
)
¿¿# $
.
¡¡ 	'
ProducesValidationProblem
¡¡	 "
(
¡¡" #
)
¡¡# $
;
¡¡$ %
group
√√ 
.
√√ 
	MapDelete
√√ 
(
√√ 
$str
√√ )
,
√√) *
async
√√+ 0
(
√√1 2
int
√√2 5
workspaceId
√√6 A
,
√√A B
int
√√C F
entityId
√√G O
,
√√O P
IEntityService
√√Q _
service
√√` g
,
√√g h
HttpContext
√√i t
httpContext√√u Ä
,√√Ä Å!
CancellationToken√√Ç ì
ct√√î ñ
)√√ñ ó
=>√√ò ö
{
ƒƒ 	
var
≈≈ 
userId
≈≈ 
=
≈≈  
WorkspaceEndpoints
≈≈ +
.
≈≈+ ,
	GetUserId
≈≈, 5
(
≈≈5 6
httpContext
≈≈6 A
)
≈≈A B
;
≈≈B C
await
∆∆ 
service
∆∆ 
.
∆∆ 
ArchiveAsync
∆∆ &
(
∆∆& '
entityId
∆∆' /
,
∆∆/ 0
workspaceId
∆∆1 <
,
∆∆< =
userId
∆∆> D
,
∆∆D E
ct
∆∆F H
)
∆∆H I
;
∆∆I J
return
«« 
Results
«« 
.
«« 
	NoContent
«« $
(
««$ %
)
««% &
;
««& '
}
»» 	
)
»»	 

.
…… 	
WithName
……	 
(
…… 
$str
…… !
)
……! "
.
   	
WithSummary
  	 
(
   
$str
   6
)
  6 7
.
ÀÀ 	
Produces
ÀÀ	 
(
ÀÀ 
StatusCodes
ÀÀ 
.
ÀÀ  
Status204NoContent
ÀÀ 0
)
ÀÀ0 1
;
ÀÀ1 2
return
ÕÕ 
routes
ÕÕ 
;
ÕÕ 
}
ŒŒ 
private
–– 
static
–– 
List
–– 
<
–– #
EntityFilterCondition
–– -
>
––- .
ParseFilters
––/ ;
(
––; <
string
––< B
[
––B C
]
––C D
?
––D E
raw
––F I
)
––I J
{
—— 
if
““ 

(
““ 
raw
““ 
is
““ 
null
““ 
or
““ 
{
““ 
Length
““ #
:
““# $
$num
““% &
}
““' (
)
““( )
return
““* 0
[
““1 2
]
““2 3
;
““3 4
var
”” 
result
”” 
=
”” 
new
”” 
List
”” 
<
”” #
EntityFilterCondition
”” 3
>
””3 4
(
””4 5
raw
””5 8
.
””8 9
Length
””9 ?
)
””? @
;
””@ A
foreach
‘‘ 
(
‘‘ 
var
‘‘ 
s
‘‘ 
in
‘‘ 
raw
‘‘ 
)
‘‘ 
{
’’ 	
var
÷÷ 
parts
÷÷ 
=
÷÷ 
s
÷÷ 
.
÷÷ 
Split
÷÷ 
(
÷÷  
$char
÷÷  #
,
÷÷# $
$num
÷÷% &
)
÷÷& '
;
÷÷' (
if
◊◊ 
(
◊◊ 
parts
◊◊ 
.
◊◊ 
Length
◊◊ 
<
◊◊ 
$num
◊◊  
||
◊◊! #
!
◊◊$ %
int
◊◊% (
.
◊◊( )
TryParse
◊◊) 1
(
◊◊1 2
parts
◊◊2 7
[
◊◊7 8
$num
◊◊8 9
]
◊◊9 :
,
◊◊: ;
out
◊◊< ?
var
◊◊@ C
pid
◊◊D G
)
◊◊G H
)
◊◊H I
throw
ÿÿ 
new
ÿÿ 
AppException
ÿÿ &
(
ÿÿ& '
$str
ÿÿ' >
,
ÿÿ> ?
$num
ÿÿ@ C
,
ÿÿC D
$"
ŸŸ 
$str
ŸŸ -
{
ŸŸ- .
s
ŸŸ. /
}
ŸŸ/ 0
$str
ŸŸ0 a
"
ŸŸa b
)
ŸŸb c
;
ŸŸc d
result
⁄⁄ 
.
⁄⁄ 
Add
⁄⁄ 
(
⁄⁄ 
new
⁄⁄ #
EntityFilterCondition
⁄⁄ 0
(
⁄⁄0 1
pid
⁄⁄1 4
,
⁄⁄4 5
parts
⁄⁄6 ;
[
⁄⁄; <
$num
⁄⁄< =
]
⁄⁄= >
,
⁄⁄> ?
parts
⁄⁄@ E
.
⁄⁄E F
Length
⁄⁄F L
==
⁄⁄M O
$num
⁄⁄P Q
?
⁄⁄R S
parts
⁄⁄T Y
[
⁄⁄Y Z
$num
⁄⁄Z [
]
⁄⁄[ \
:
⁄⁄] ^
null
⁄⁄_ c
)
⁄⁄c d
)
⁄⁄d e
;
⁄⁄e f
}
€€ 	
return
‹‹ 
result
‹‹ 
;
‹‹ 
}
›› 
private
ﬂﬂ 
static
ﬂﬂ 
List
ﬂﬂ 
<
ﬂﬂ 
EntitySortField
ﬂﬂ '
>
ﬂﬂ' (
	ParseSort
ﬂﬂ) 2
(
ﬂﬂ2 3
string
ﬂﬂ3 9
[
ﬂﬂ9 :
]
ﬂﬂ: ;
?
ﬂﬂ; <
raw
ﬂﬂ= @
)
ﬂﬂ@ A
{
‡‡ 
if
·· 

(
·· 
raw
·· 
is
·· 
null
·· 
or
·· 
{
·· 
Length
·· #
:
··# $
$num
··% &
}
··' (
)
··( )
return
··* 0
[
··1 2
]
··2 3
;
··3 4
var
‚‚ 
result
‚‚ 
=
‚‚ 
new
‚‚ 
List
‚‚ 
<
‚‚ 
EntitySortField
‚‚ -
>
‚‚- .
(
‚‚. /
raw
‚‚/ 2
.
‚‚2 3
Length
‚‚3 9
)
‚‚9 :
;
‚‚: ;
foreach
„„ 
(
„„ 
var
„„ 
s
„„ 
in
„„ 
raw
„„ 
)
„„ 
{
‰‰ 	
var
ÂÂ 
parts
ÂÂ 
=
ÂÂ 
s
ÂÂ 
.
ÂÂ 
Split
ÂÂ 
(
ÂÂ  
$char
ÂÂ  #
,
ÂÂ# $
$num
ÂÂ% &
)
ÂÂ& '
;
ÂÂ' (
if
ÊÊ 
(
ÊÊ 
!
ÊÊ 
int
ÊÊ 
.
ÊÊ 
TryParse
ÊÊ 
(
ÊÊ 
parts
ÊÊ #
[
ÊÊ# $
$num
ÊÊ$ %
]
ÊÊ% &
,
ÊÊ& '
out
ÊÊ( +
var
ÊÊ, /
pid
ÊÊ0 3
)
ÊÊ3 4
)
ÊÊ4 5
throw
ÁÁ 
new
ÁÁ 
AppException
ÁÁ &
(
ÁÁ& '
$str
ÁÁ' <
,
ÁÁ< =
$num
ÁÁ> A
,
ÁÁA B
$"
ËË 
$str
ËË +
{
ËË+ ,
s
ËË, -
}
ËË- .
$str
ËË. \
"
ËË\ ]
)
ËË] ^
;
ËË^ _
var
ÈÈ 
dir
ÈÈ 
=
ÈÈ 
parts
ÈÈ 
.
ÈÈ 
Length
ÈÈ "
==
ÈÈ# %
$num
ÈÈ& '
?
ÈÈ( )
parts
ÈÈ* /
[
ÈÈ/ 0
$num
ÈÈ0 1
]
ÈÈ1 2
.
ÈÈ2 3
ToLowerInvariant
ÈÈ3 C
(
ÈÈC D
)
ÈÈD E
:
ÈÈF G
$str
ÈÈH M
;
ÈÈM N
if
ÍÍ 
(
ÍÍ 
dir
ÍÍ 
is
ÍÍ 
not
ÍÍ 
$str
ÍÍ  
and
ÍÍ! $
not
ÍÍ% (
$str
ÍÍ) /
)
ÍÍ/ 0
throw
ÎÎ 
new
ÎÎ 
AppException
ÎÎ &
(
ÎÎ& '
$str
ÎÎ' ?
,
ÎÎ? @
$num
ÎÎA D
,
ÎÎD E
$"
ÎÎF H
$str
ÎÎH `
{
ÎÎ` a
dir
ÎÎa d
}
ÎÎd e
$str
ÎÎe |
"
ÎÎ| }
)
ÎÎ} ~
;
ÎÎ~ 
result
ÏÏ 
.
ÏÏ 
Add
ÏÏ 
(
ÏÏ 
new
ÏÏ 
EntitySortField
ÏÏ *
(
ÏÏ* +
pid
ÏÏ+ .
,
ÏÏ. /
dir
ÏÏ0 3
)
ÏÏ3 4
)
ÏÏ4 5
;
ÏÏ5 6
}
ÌÌ 	
return
ÓÓ 
result
ÓÓ 
;
ÓÓ 
}
ÔÔ 
} 