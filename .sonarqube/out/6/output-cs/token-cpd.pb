É
ÄC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\UpdateWorkspaceSettingsRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class 3
'UpdateWorkspaceSettingsRequestValidator ;
:< =
AbstractValidator> O
<O P*
UpdateWorkspaceSettingsRequestP n
>n o
{ 
public 
3
'UpdateWorkspaceSettingsRequestValidator 2
(2 3
)3 4
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
Name

 
)

 
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ A
)A B
. 
MaximumLength 
( 
$num 
) 
.  
WithMessage  +
(+ ,
$str, ]
)] ^
;^ _
RuleFor 
( 
x 
=> 
x 
. 
Description "
)" #
. 
MaximumLength 
( 
$num 
) 
.  
WithMessage  +
(+ ,
$str, Z
)Z [
. 
When 
( 
x 
=> 
x 
. 
Description $
is% '
not( +
null, 0
)0 1
;1 2
RuleFor 
( 
x 
=> 
x 
. 
HighRiskThreshold (
)( )
. 
InclusiveBetween 
( 
$num  
,  !
$num" $
)$ %
.% &
WithMessage& 1
(1 2
$str2 `
)` a
;a b
RuleFor 
( 
x 
=> 
x 
. 
MediumRiskThreshold *
)* +
. 
InclusiveBetween 
( 
$num  
,  !
$num" $
)$ %
.% &
WithMessage& 1
(1 2
$str2 b
)b c
. 
LessThan 
( 
x 
=> 
x 
. 
HighRiskThreshold .
). /
./ 0
WithMessage0 ;
(; <
$str< z
)z {
;{ |
} 
} ó
xC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\UpdateWorkspaceRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class +
UpdateWorkspaceRequestValidator 3
:4 5
AbstractValidator6 G
<G H"
UpdateWorkspaceRequestH ^
>^ _
{ 
public 
+
UpdateWorkspaceRequestValidator *
(* +
)+ ,
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
Name

 
)

 
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ A
)A B
. 
MaximumLength 
( 
$num 
) 
;  
} 
} ∫
}C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\UpdateOrgUserProfileRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class 0
$UpdateOrgUserProfileRequestValidator 8
:9 :
AbstractValidator; L
<L M'
UpdateOrgUserProfileRequestM h
>h i
{ 
public 
0
$UpdateOrgUserProfileRequestValidator /
(/ 0
)0 1
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
	FirstName

  
)

  !
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ =
)= >
. 
MaximumLength 
( 
$num 
) 
;  
RuleFor 
( 
x 
=> 
x 
. 
LastName 
)  
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ <
)< =
. 
MaximumLength 
( 
$num 
) 
;  
} 
} ¶
vC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\UpdateOrgRoleRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class )
UpdateOrgRoleRequestValidator 1
:2 3
AbstractValidator4 E
<E F 
UpdateOrgRoleRequestF Z
>Z [
{ 
public 
)
UpdateOrgRoleRequestValidator (
(( )
)) *
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
Name

 
)

 
. 
MaximumLength 
( 
$num 
) 
. 
When 
( 
x 
=> 
x 
. 
Name 
is  
not! $
null% )
)) *
;* +
RuleFor 
( 
x 
=> 
x 
. 
Priority 
)  
. 
Must 
( 
p 
=> 
! 
p 
. 
HasValue "
||# %
p& '
.' (
Value( -
>=. 0
$num1 2
)2 3
. 
WithMessage 
( 
$str @
)@ A
;A B
} 
} ñ
ÉC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\UpdateOrganizationSettingsRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class 6
*UpdateOrganizationSettingsRequestValidator >
:? @
AbstractValidatorA R
<R S-
!UpdateOrganizationSettingsRequestS t
>t u
{ 
private 
static 
readonly 
string "
[" #
]# $
AllowedJoinPolicies% 8
=9 :
[; <
$str< B
,B C
$strD Q
]Q R
;R S
public

 
6
*UpdateOrganizationSettingsRequestValidator

 5
(

5 6
)

6 7
{ 
RuleFor 
( 
x 
=> 
x 
. 
Name 
) 
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ D
)D E
. 
MaximumLength 
( 
$num 
) 
.  
WithMessage  +
(+ ,
$str, `
)` a
;a b
RuleFor 
( 
x 
=> 
x 
. 
Description "
)" #
. 
MaximumLength 
( 
$num 
) 
.  
WithMessage  +
(+ ,
$str, Z
)Z [
. 
When 
( 
x 
=> 
x 
. 
Description $
is% '
not( +
null, 0
)0 1
;1 2
RuleFor 
( 
x 
=> 
x 
. 

JoinPolicy !
)! "
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ >
)> ?
. 
Must 
( 
v 
=> 
AllowedJoinPolicies *
.* +
Contains+ 3
(3 4
v4 5
)5 6
)6 7
.7 8
WithMessage8 C
(C D
$strD r
)r s
;s t
RuleFor 
( 
x 
=> 
x 
. 
DefaultOrgRoleId '
)' (
. 
GreaterThan 
( 
$num 
) 
. 
WithMessage '
(' (
$str( Y
)Y Z
. 
When 
( 
x 
=> 
x 
. 
DefaultOrgRoleId )
.) *
HasValue* 2
)2 3
;3 4
} 
} £
{C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\UpdateOrganizationRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class .
"UpdateOrganizationRequestValidator 6
:7 8
AbstractValidator9 J
<J K%
UpdateOrganizationRequestK d
>d e
{ 
public 
.
"UpdateOrganizationRequestValidator -
(- .
). /
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
Name

 
)

 
.

 
NotEmpty

 %
(

% &
)

& '
.

' (
WithMessage

( 3
(

3 4
$str

4 T
)

T U
.

U V
MaximumLength

V c
(

c d
$num

d g
)

g h
;

h i
} 
} ÿ
yC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\UpdateMemberRoleRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class ,
 UpdateMemberRoleRequestValidator 4
:5 6
AbstractValidator7 H
<H I#
UpdateMemberRoleRequestI `
>` a
{ 
public 
,
 UpdateMemberRoleRequestValidator +
(+ ,
), -
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
RoleId

 
)

 
. 
GreaterThan 
( 
$num 
) 
. 
WithMessage '
(' (
$str( M
)M N
;N O
} 
} ∫
uC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\UpdateEntityRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class (
UpdateEntityRequestValidator 0
:1 2
AbstractValidator3 D
<D E
UpdateEntityRequestE X
>X Y
{ 
public 
(
UpdateEntityRequestValidator '
(' (
)( )
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 

Properties

 !
)

! "
. 
NotNull 
( 
) 
. 
WithMessage "
(" #
$str# A
)A B
;B C
RuleForEach 
( 
x 
=> 
x 
. 

Properties %
)% &
. 

ChildRules 
( 
pv 
=> 
{ 
pv 
. 
RuleFor 
( 
p 
=> 
p  !
.! "

PropertyId" ,
), -
. 
GreaterThan  
(  !
$num! "
)" #
.# $
WithMessage$ /
(/ 0
$str0 ]
)] ^
;^ _
} 
) 
; 
} 
} û	
zC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\ReviewJoinRequestRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class -
!ReviewJoinRequestRequestValidator 5
:6 7
AbstractValidator8 I
<I J$
ReviewJoinRequestRequestJ b
>b c
{ 
public 
-
!ReviewJoinRequestRequestValidator ,
(, -
)- .
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
Decision

 
)

  
.

  !
NotEmpty

! )
(

) *
)

* +
.

+ ,
Must

, 0
(

0 1
d

1 2
=>

3 5
d

6 7
==

8 :
$str

; E
||

F H
d

I J
==

K M
$str

N X
)

X Y
.

Y Z
WithMessage

Z e
(

e f
$str	

f í
)


í ì
;


ì î
} 
} À
tC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\InviteToOrgRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class '
InviteToOrgRequestValidator /
:0 1
AbstractValidator2 C
<C D
InviteToOrgRequestD V
>V W
{ 
public 
'
InviteToOrgRequestValidator &
(& '
)' (
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
Email

 
)

 
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ 8
)8 9
. 
EmailAddress 
( 
) 
. 
WithMessage '
(' (
$str( L
)L M
;M N
RuleFor 
( 
x 
=> 
x 
. 
	OrgRoleId  
)  !
. 
GreaterThan 
( 
$num 
) 
. 
WithMessage '
(' (
$str( M
)M N
. 
When 
( 
x 
=> 
x 
. 
	OrgRoleId "
." #
HasValue# +
)+ ,
;, -
} 
} ó
xC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\CreateWorkspaceRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class +
CreateWorkspaceRequestValidator 3
:4 5
AbstractValidator6 G
<G H"
CreateWorkspaceRequestH ^
>^ _
{ 
public 
+
CreateWorkspaceRequestValidator *
(* +
)+ ,
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
Name

 
)

 
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ A
)A B
. 
MaximumLength 
( 
$num 
) 
;  
} 
} ∏

sC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\CreateRoleRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class &
CreateRoleRequestValidator .
:/ 0
AbstractValidator1 B
<B C
CreateRoleRequestC T
>T U
{ 
public 
&
CreateRoleRequestValidator %
(% &
)& '
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
Name

 
)

 
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ <
)< =
. 
MaximumLength 
( 
$num 
) 
;  
RuleFor 
( 
x 
=> 
x 
. 
PermissionIds $
)$ %
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ J
)J K
;K L
} 
} í
vC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\CreateOrgRoleRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class )
CreateOrgRoleRequestValidator 1
:2 3
AbstractValidator4 E
<E F 
CreateOrgRoleRequestF Z
>Z [
{ 
public 
)
CreateOrgRoleRequestValidator (
(( )
)) *
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
Name

 
)

 
.

 
NotEmpty

 %
(

% &
)

& '
.

' (
WithMessage

( 3
(

3 4
$str

4 L
)

L M
.

M N
MaximumLength

N [
(

[ \
$num

\ _
)

_ `
;

` a
RuleFor 
( 
x 
=> 
x 
. 
PermissionIds $
)$ %
.% &
NotEmpty& .
(. /
)/ 0
.0 1
WithMessage1 <
(< =
$str= c
)c d
;d e
RuleFor 
( 
x 
=> 
x 
. 
Priority 
)  
.  
GreaterThanOrEqualTo !
(! "
$num" #
)# $
. 
WithMessage 
( 
$str h
)h i
;i j
} 
} £
{C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\CreateOrganizationRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class .
"CreateOrganizationRequestValidator 6
:7 8
AbstractValidator9 J
<J K%
CreateOrganizationRequestK d
>d e
{ 
public 
.
"CreateOrganizationRequestValidator -
(- .
). /
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
Name

 
)

 
.

 
NotEmpty

 %
(

% &
)

& '
.

' (
WithMessage

( 3
(

3 4
$str

4 T
)

T U
.

U V
MaximumLength

V c
(

c d
$num

d g
)

g h
;

h i
} 
} ™
uC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\CreateEntityRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class (
CreateEntityRequestValidator 0
:1 2
AbstractValidator3 D
<D E
CreateEntityRequestE X
>X Y
{ 
public 
(
CreateEntityRequestValidator '
(' (
)( )
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
EntityTypeId

 #
)

# $
. 
GreaterThan 
( 
$num 
) 
. 
WithMessage '
(' (
$str( R
)R S
;S T
RuleFor 
( 
x 
=> 
x 
. 

Properties !
)! "
. 
NotNull 
( 
) 
. 
WithMessage "
(" #
$str# A
)A B
;B C
RuleForEach 
( 
x 
=> 
x 
. 

Properties %
)% &
. 

ChildRules 
( 
pv 
=> 
{ 
pv 
. 
RuleFor 
( 
p 
=> 
p  !
.! "

PropertyId" ,
), -
. 
GreaterThan  
(  !
$num! "
)" #
.# $
WithMessage$ /
(/ 0
$str0 ]
)] ^
;^ _
} 
) 
; 
When 
( 
x 
=> 
x 
. 
Links 
is 
not  
null! %
&&& (
x) *
.* +
Links+ 0
.0 1
Count1 6
>7 8
$num9 :
,: ;
(< =
)= >
=>? A
{ 	
RuleForEach 
( 
x 
=> 
x 
. 
Links $
!$ %
)% &
. 

ChildRules 
( 
link  
=>! #
{ 
link 
. 
RuleFor  
(  !
l! "
=># %
l& '
.' (
RelationshipTypeId( :
): ;
. 
GreaterThan $
($ %
$num% &
)& '
.' (
WithMessage( 3
(3 4
$str4 i
)i j
;j k
link 
. 
RuleFor  
(  !
l! "
=># %
l& '
.' (
TargetEntityId( 6
)6 7
. 
GreaterThan $
($ %
$num% &
)& '
.' (
WithMessage( 3
(3 4
$str4 e
)e f
;f g
}   
)   
;   
}!! 	
)!!	 

;!!
 
}"" 
}## ‰
|C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\ChangeOrgMemberRoleRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class /
#ChangeOrgMemberRoleRequestValidator 7
:8 9
AbstractValidator: K
<K L&
ChangeOrgMemberRoleRequestL f
>f g
{ 
public 
/
#ChangeOrgMemberRoleRequestValidator .
(. /
)/ 0
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
RoleId

 
)

 
.

 
GreaterThan

 *
(

* +
$num

+ ,
)

, -
.

- .
WithMessage

. 9
(

9 :
$str

: _
)

_ `
;

` a
} 
} £

{C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Validators\AddWorkspaceMemberRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Validators$ .
;. /
public 
sealed 
class .
"AddWorkspaceMemberRequestValidator 6
:7 8
AbstractValidator9 J
<J K%
AddWorkspaceMemberRequestK d
>d e
{ 
public 
.
"AddWorkspaceMemberRequestValidator -
(- .
). /
{		 
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
UserId

 
)

 
.

 
GreaterThan

 *
(

* +
$num

+ ,
)

, -
.

- .
WithMessage

. 9
(

9 :
$str

: _
)

_ `
;

` a
RuleFor 
( 
x 
=> 
x 
. 
RoleId 
) 
. 
GreaterThan *
(* +
$num+ ,
), -
.- .
WithMessage. 9
(9 :
$str: _
)_ `
;` a
} 
} ó
iC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Utilities\DisplayNameHelper.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
	Utilities$ -
;- .
internal 
static	 
class 
DisplayNameHelper '
{ 
internal 
static 
string 
Humanize #
(# $
string$ *
name+ /
)/ 0
{ 
if 

( 
string 
. 
IsNullOrEmpty  
(  !
name! %
)% &
)& '
return( .
name/ 3
;3 4
return		 
string		 
.		 
Join		 
(		 
$str		 
,		 
name		  $
.		$ %
Split		% *
(		* +
$char		+ .
)		. /
.

 
Where

 
(

 
w

 
=>

 
w

 
.

 
Length

  
>

! "
$num

# $
)

$ %
. 
Select 
( 
w 
=> 
char 
. 
ToUpperInvariant .
(. /
w/ 0
[0 1
$num1 2
]2 3
)3 4
+5 6
w7 8
[8 9
$num9 :
..: <
]< =
)= >
)> ?
;? @
} 
} ô›
gC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Services\WorkspaceService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
Services$ ,
;, -
public 
sealed 
class 
WorkspaceService $
($ % 
IWorkspaceRepository 
workspaceRepository ,
,, -(
IUserRoleWorkspaceRepository  
memberRepository! 1
,1 2$
IWorkspaceRoleRepository 
roleRepository +
,+ ,+
IUserRoleOrganizationRepository #
orgMemberRepository$ 7
,7 8%
IWorkspaceAccessEvaluator 
workspaceAccess -
,- .(
IWorkspaceSettingsRepository  '
workspaceSettingsRepository! <
,< =

IValidator 
< "
CreateWorkspaceRequest %
>% &
createValidator' 6
,6 7

IValidator 
< "
UpdateWorkspaceRequest %
>% &
updateValidator' 6
,6 7

IValidator 
< *
UpdateWorkspaceSettingsRequest -
>- .#
updateSettingsValidator/ F
,F G
IOutboxWriter 
? 
auditOutboxWriter $
=% &
null' +
)+ ,
:- .
IWorkspaceService/ @
{ 
public 

async 
Task 
< 
WorkspaceDto "
>" #
CreateAsync$ /
(/ 0
int0 3
userId4 :
,: ;"
CreateWorkspaceRequest< R
requestS Z
,Z [
CancellationToken\ m
ctn p
=q r
defaults z
)z {
{ 
await 
createValidator 
. !
ValidateAndThrowAsync 3
(3 4
request4 ;
,; <
ct= ?
)? @
;@ A
var 
orgMembership 
= 
await !
orgMemberRepository" 5
.5 6
GetAsync6 >
(> ?
userId? E
,E F
requestG N
.N O
OrganizationIdO ]
,] ^
ct_ a
)a b
?? 
throw 
new 
AppException %
(% &
$str& 6
,6 7
$num8 ;
,; <
$str= i
)i j
;j k
var!! 
hasPermission!! 
=!! 
orgMembership!! )
.!!) *
Role!!* .
?!!. /
.!!/ 0
RolePermissions!!0 ?
."" 
Any"" 
("" 
rp"" 
=>"" 
rp"" 
."" 

Permission"" $
?""$ %
.""% &
Name""& *
==""+ -#
OrganizationPermissions"". E
.""E F
CreateWorkspaces""F V
)""V W
??""X Z
false""[ `
;""` a
if## 

(## 
!## 
hasPermission## 
)## 
throw$$ 
new$$ 
AppException$$ "
($$" #
$str$$# 6
,$$6 7
$num$$8 ;
,$$; <
$"$$= ?
$str$$? T
{$$T U#
OrganizationPermissions$$U l
.$$l m
CreateWorkspaces$$m }
}$$} ~
$str	$$~ †
"
$$† °
)
$$° ¢
;
$$¢ £
var&& 
	adminRole&& 
=&& 
await&& 
roleRepository&& ,
.&&, -5
)GetSystemRoleWithPermissionsSupersetAsync&&- V
(&&V W 
WorkspacePermissions'' $
.''$ %"
FullWorkspaceAuthority''% ;
,''; <
ct(( 
)(( 
??)) 
await)) 
roleRepository)) #
.))# $$
GetSystemRoleByNameAsync))$ <
())< =
$str))= G
,))G H
ct))I K
)))K L
??** 
throw** 
new** 
AppException** %
(**% &
$str**& F
,**F G
$num**H K
,**K L
$str**M n
)**n o
;**o p
var,, 
	workspace,, 
=,, 
new,, 
	Workspace,, %
{-- 	
Name.. 
=.. 
request.. 
... 
Name.. 
,..  
OrganizationId// 
=// 
request// $
.//$ %
OrganizationId//% 3
,//3 4
CreatedByUserId00 
=00 
userId00 $
,00$ %

IsArchived11 
=11 
false11 
}22 	
;22	 

await44 
workspaceRepository44 !
.44! "
AddAsync44" *
(44* +
	workspace44+ 4
,444 5
ct446 8
)448 9
;449 :
await66 '
workspaceSettingsRepository66 )
.66) *
AddAsync66* 2
(662 3
new663 6
WorkspaceSettings667 H
{77 	
WorkspaceId88 
=88 
	workspace88 #
.88# $
Id88$ &
,88& '
HighRiskThreshold99 
=99 
$num99  $
,99$ %
MediumRiskThreshold:: 
=::  !
$num::" &
};; 	
,;;	 

ct;; 
);; 
;;; 
var== 
member== 
=== 
new== 
UserRoleWorkspace== *
{>> 	
UserId?? 
=?? 
userId?? 
,?? 
WorkspaceId@@ 
=@@ 
	workspace@@ #
.@@# $
Id@@$ &
,@@& '
WsRoleIdAA 
=AA 
	adminRoleAA  
.AA  !
IdAA! #
,AA# $
JoinedAtBB 
=BB 
DateTimeBB 
.BB  
UtcNowBB  &
,BB& '

IsArchivedCC 
=CC 
falseCC 
}DD 	
;DD	 

awaitFF 
memberRepositoryFF 
.FF 
AddAsyncFF '
(FF' (
memberFF( .
,FF. /
ctFF0 2
)FF2 3
;FF3 4
varHH 
membershipLoadedHH 
=HH 
awaitHH $
memberRepositoryHH% 5
.HH5 6
GetAsyncHH6 >
(HH> ?
userIdHH? E
,HHE F
	workspaceHHG P
.HHP Q
IdHHQ S
,HHS T
ctHHU W
)HHW X
;HHX Y
varII 
myPermissionsII 
=II 
awaitII !
workspaceAccessII" 1
.II1 25
)GetEffectiveWorkspacePermissionNamesAsyncII2 [
(II[ \
userIdII\ b
,IIb c
	workspaceIId m
.IIm n
IdIIn p
,IIp q
ctIIr t
)IIt u
;IIu v
ifKK 

(KK 
auditOutboxWriterKK 
isKK  
notKK! $
nullKK% )
)KK) *
{LL 	
awaitMM 
auditOutboxWriterMM #
.MM# $
EnqueueAuditAsyncMM$ 5
(MM5 6
newNN 
AuditEventContractNN "
(NN" #
EventIdOO 
:OO 
GuidOO 
.OO 
NewGuidOO %
(OO% &
)OO& '
,OO' (
SchemaVersionPP 
:PP 
$numPP  
,PP  !
OccurredAtUtcQQ 
:QQ 
DateTimeOffsetQQ -
.QQ- .
UtcNowQQ. 4
,QQ4 5
SourceServiceRR 
:RR 
$strRR %
,RR% &
ActorUserIdSS 
:SS 
userIdSS #
,SS# $

AuditScopeTT 
:TT 
AuditRoutingTT (
.TT( )
ScopeWorkspaceTT) 7
,TT7 8
TargetIdUU 
:UU 
	workspaceUU #
.UU# $
IdUU$ &
,UU& '
ActionVV 
:VV 
$strVV +
,VV+ ,
	FieldNameWW 
:WW 
nullWW 
,WW  

EntityTypeXX 
:XX 
nullXX  
,XX  !
OldValueJsonYY 
:YY 
nullYY "
,YY" #
NewValueJsonZZ 
:ZZ 
JsonSerializerZZ ,
.ZZ, -
	SerializeZZ- 6
(ZZ6 7
newZZ7 :
{ZZ; <
	workspaceZZ= F
.ZZF G
IdZZG I
,ZZI J
	workspaceZZK T
.ZZT U
NameZZU Y
,ZZY Z
	workspaceZZ[ d
.ZZd e
OrganizationIdZZe s
}ZZt u
)ZZu v
)ZZv w
,ZZw x
ct[[ 
)[[ 
;[[ 
await\\ '
PublishWorkspaceDomainAsync\\ -
(\\- .
auditOutboxWriter]] !
,]]! "
DomainRouting^^ 
.^^ $
CoreWorkspaceVerbCreated^^ 6
,^^6 7
$str__ 
,__ 
	workspace`` 
.`` 
Id`` 
,`` 
	workspaceaa 
.aa 
OrganizationIdaa (
,aa( )
userIdbb 
,bb 
	workspacecc 
.cc 
Namecc 
,cc 
ctdd 
)dd 
;dd 
}ee 	
returngg 
newgg 
WorkspaceDtogg 
(gg  
	workspacegg  )
.gg) *
Idgg* ,
,gg, -
	workspacegg. 7
.gg7 8
OrganizationIdgg8 F
,ggF G
	workspaceggH Q
.ggQ R
NameggR V
,ggV W
$numggX Y
,ggY Z
	adminRolegg[ d
.ggd e
Namegge i
,ggi j
	adminRoleggk t
.ggt u
DisplayName	ggu Ä
??
ggÅ É
DisplayNameHelper
ggÑ ï
.
ggï ñ
Humanize
ggñ û
(
ggû ü
	adminRole
ggü ®
.
gg® ©
Name
gg© ≠
)
gg≠ Æ
,
ggÆ Ø
myPermissions
gg∞ Ω
)
ggΩ æ
;
ggæ ø
}hh 
publicjj 

asyncjj 
Taskjj 
<jj 
Listjj 
<jj 
WorkspaceDtojj '
>jj' (
>jj( )
GetByUserAsyncjj* 8
(jj8 9
intjj9 <
userIdjj= C
,jjC D
intjjE H
?jjH I
organizationIdjjJ X
,jjX Y
CancellationTokenjjZ k
ctjjl n
=jjo p
defaultjjq x
)jjx y
{kk 
Listll 
<ll 
	Workspacell 
>ll 

workspacesll "
;ll" #
ifmm 

(mm 
organizationIdmm 
.mm 
HasValuemm #
)mm# $
{nn 	
varoo 
orgMembershipoo 
=oo 
awaitoo  %
orgMemberRepositoryoo& 9
.oo9 :
GetAsyncoo: B
(ooB C
userIdooC I
,ooI J
organizationIdooK Y
.ooY Z
ValueooZ _
,oo_ `
ctooa c
)ooc d
;ood e
ifpp 
(pp 
orgMembershippp 
ispp  
nullpp! %
)pp% &
{qq 
throwrr 
newrr 
AppExceptionrr &
(rr& '
$strrr' 7
,rr7 8
$numrr9 <
,rr< =
$strrr> j
)rrj k
;rrk l
}ss 

workspacesuu 
=uu 
awaituu 
workspaceRepositoryuu 2
.uu2 3-
!GetByUserIdAndOrganizationIdAsyncuu3 T
(uuT U
userIdvv 
,vv 
organizationIdww 
.ww 
Valueww $
,ww$ %
ctxx 
)xx 
;xx 
}yy 	
elsezz 
{{{ 	

workspaces|| 
=|| 
await|| 
workspaceRepository|| 2
.||2 3
GetByUserIdAsync||3 C
(||C D
userId||D J
,||J K
ct||L N
)||N O
;||O P
}}} 	
var 
result 
= 
new 
List 
< 
WorkspaceDto *
>* +
(+ ,
), -
;- .
foreach
ÅÅ 
(
ÅÅ 
var
ÅÅ 
ws
ÅÅ 
in
ÅÅ 

workspaces
ÅÅ %
)
ÅÅ% &
{
ÇÇ 	
var
ÉÉ 

membership
ÉÉ 
=
ÉÉ 
await
ÉÉ "
memberRepository
ÉÉ# 3
.
ÉÉ3 4
GetAsync
ÉÉ4 <
(
ÉÉ< =
userId
ÉÉ= C
,
ÉÉC D
ws
ÉÉE G
.
ÉÉG H
Id
ÉÉH J
,
ÉÉJ K
ct
ÉÉL N
)
ÉÉN O
;
ÉÉO P
var
ÑÑ 
members
ÑÑ 
=
ÑÑ 
await
ÑÑ 
memberRepository
ÑÑ  0
.
ÑÑ0 1#
GetByWorkspaceIdAsync
ÑÑ1 F
(
ÑÑF G
ws
ÑÑG I
.
ÑÑI J
Id
ÑÑJ L
,
ÑÑL M
ct
ÑÑN P
)
ÑÑP Q
;
ÑÑQ R
var
ÖÖ 
memberCount
ÖÖ 
=
ÖÖ 
members
ÖÖ %
.
ÖÖ% &
Count
ÖÖ& +
(
ÖÖ+ ,
m
ÖÖ, -
=>
ÖÖ. 0
!
ÖÖ1 2
m
ÖÖ2 3
.
ÖÖ3 4

IsArchived
ÖÖ4 >
)
ÖÖ> ?
;
ÖÖ? @
var
ÜÜ 
myPermissions
ÜÜ 
=
ÜÜ 
await
ÜÜ  %
workspaceAccess
ÜÜ& 5
.
ÜÜ5 67
)GetEffectiveWorkspacePermissionNamesAsync
ÜÜ6 _
(
ÜÜ_ `
userId
ÜÜ` f
,
ÜÜf g
ws
ÜÜh j
.
ÜÜj k
Id
ÜÜk m
,
ÜÜm n
ct
ÜÜo q
)
ÜÜq r
;
ÜÜr s
result
áá 
.
áá 
Add
áá 
(
áá 
new
áá 
WorkspaceDto
áá '
(
áá' (
ws
àà 
.
àà 
Id
àà 
,
àà 
ws
ââ 
.
ââ 
OrganizationId
ââ !
,
ââ! "
ws
ää 
.
ää 
Name
ää 
,
ää 
memberCount
ãã 
,
ãã 

membership
åå 
?
åå 
.
åå 
Role
åå  
?
åå  !
.
åå! "
Name
åå" &
,
åå& '

membership
çç 
?
çç 
.
çç 
Role
çç  
is
çç! #
{
çç$ %
}
çç& '
r
çç( )
?
çç* +
(
çç, -
r
çç- .
.
çç. /
DisplayName
çç/ :
??
çç; =
DisplayNameHelper
çç> O
.
ççO P
Humanize
ççP X
(
ççX Y
r
ççY Z
.
ççZ [
Name
çç[ _
)
çç_ `
)
çç` a
:
ççb c
null
ççd h
,
ççh i
myPermissions
éé 
)
éé 
)
éé 
;
éé  
}
èè 	
return
ëë 
result
ëë 
;
ëë 
}
íí 
public
îî 

async
îî 
Task
îî 
<
îî 
WorkspaceDto
îî "
>
îî" #
GetByIdAsync
îî$ 0
(
îî0 1
int
îî1 4
workspaceId
îî5 @
,
îî@ A
int
îîB E
userId
îîF L
,
îîL M
CancellationToken
îîN _
ct
îî` b
=
îîc d
default
îîe l
)
îîl m
{
ïï 
await
ññ 
workspaceAccess
ññ 
.
ññ +
EnsureCanAccessWorkspaceAsync
ññ ;
(
ññ; <
userId
ññ< B
,
ññB C
workspaceId
ññD O
,
ññO P
ct
ññQ S
)
ññS T
;
ññT U
var
òò 
	workspace
òò 
=
òò 
await
òò !
workspaceRepository
òò 1
.
òò1 2
GetByIdAsync
òò2 >
(
òò> ?
workspaceId
òò? J
,
òòJ K
ct
òòL N
)
òòN O
??
ôô 
throw
ôô 
new
ôô 
AppException
ôô %
(
ôô% &
$str
ôô& ;
,
ôô; <
$num
ôô= @
,
ôô@ A
$str
ôôB X
)
ôôX Y
;
ôôY Z
var
õõ 

membership
õõ 
=
õõ 
await
õõ 
memberRepository
õõ /
.
õõ/ 0
GetAsync
õõ0 8
(
õõ8 9
userId
õõ9 ?
,
õõ? @
workspaceId
õõA L
,
õõL M
ct
õõN P
)
õõP Q
;
õõQ R
var
úú 
members
úú 
=
úú 
await
úú 
memberRepository
úú ,
.
úú, -#
GetByWorkspaceIdAsync
úú- B
(
úúB C
workspaceId
úúC N
,
úúN O
ct
úúP R
)
úúR S
;
úúS T
var
ùù 
myPermissions
ùù 
=
ùù 
await
ùù !
workspaceAccess
ùù" 1
.
ùù1 27
)GetEffectiveWorkspacePermissionNamesAsync
ùù2 [
(
ùù[ \
userId
ùù\ b
,
ùùb c
workspaceId
ùùd o
,
ùùo p
ct
ùùq s
)
ùùs t
;
ùùt u
return
üü 
new
üü 
WorkspaceDto
üü 
(
üü  
	workspace
†† 
.
†† 
Id
†† 
,
†† 
	workspace
°° 
.
°° 
OrganizationId
°° $
,
°°$ %
	workspace
¢¢ 
.
¢¢ 
Name
¢¢ 
,
¢¢ 
members
££ 
.
££ 
Count
££ 
(
££ 
m
££ 
=>
££ 
!
££  
m
££  !
.
££! "

IsArchived
££" ,
)
££, -
,
££- .

membership
§§ 
?
§§ 
.
§§ 
Role
§§ 
?
§§ 
.
§§ 
Name
§§ "
,
§§" #

membership
•• 
?
•• 
.
•• 
Role
•• 
is
•• 
{
••  !
}
••" #
r
••$ %
?
••& '
(
••( )
r
••) *
.
••* +
DisplayName
••+ 6
??
••7 9
DisplayNameHelper
••: K
.
••K L
Humanize
••L T
(
••T U
r
••U V
.
••V W
Name
••W [
)
••[ \
)
••\ ]
:
••^ _
null
••` d
,
••d e
myPermissions
¶¶ 
)
¶¶ 
;
¶¶ 
}
ßß 
public
©© 

async
©© 
Task
©© 
UpdateAsync
©© !
(
©©! "
int
©©" %
workspaceId
©©& 1
,
©©1 2
int
©©3 6
userId
©©7 =
,
©©= >$
UpdateWorkspaceRequest
©©? U
request
©©V ]
,
©©] ^
CancellationToken
©©_ p
ct
©©q s
=
©©t u
default
©©v }
)
©©} ~
{
™™ 
await
´´ 
updateValidator
´´ 
.
´´ #
ValidateAndThrowAsync
´´ 3
(
´´3 4
request
´´4 ;
,
´´; <
ct
´´= ?
)
´´? @
;
´´@ A
if
¨¨ 

(
¨¨ 
!
¨¨ 
await
¨¨ 
workspaceAccess
¨¨ "
.
¨¨" #)
HasWorkspacePermissionAsync
¨¨# >
(
¨¨> ?
userId
¨¨? E
,
¨¨E F
workspaceId
¨¨G R
,
¨¨R S"
WorkspacePermissions
¨¨T h
.
¨¨h i
ManageWsSettings
¨¨i y
,
¨¨y z
ct
¨¨{ }
)
¨¨} ~
)
¨¨~ 
throw
≠≠ 
new
≠≠ 
AppException
≠≠ "
(
≠≠" #
$str
≠≠# 6
,
≠≠6 7
$num
≠≠8 ;
,
≠≠; <
$"
≠≠= ?
$str
≠≠? T
{
≠≠T U"
WorkspacePermissions
≠≠U i
.
≠≠i j
ManageWsSettings
≠≠j z
}
≠≠z {
$str≠≠{ ö
"≠≠ö õ
)≠≠õ ú
;≠≠ú ù
var
ØØ 
	workspace
ØØ 
=
ØØ 
await
ØØ !
workspaceRepository
ØØ 1
.
ØØ1 2
GetByIdAsync
ØØ2 >
(
ØØ> ?
workspaceId
ØØ? J
,
ØØJ K
ct
ØØL N
)
ØØN O
??
∞∞ 
throw
∞∞ 
new
∞∞ 
AppException
∞∞ %
(
∞∞% &
$str
∞∞& ;
,
∞∞; <
$num
∞∞= @
,
∞∞@ A
$str
∞∞B X
)
∞∞X Y
;
∞∞Y Z
var
≤≤ 
previousName
≤≤ 
=
≤≤ 
	workspace
≤≤ $
.
≤≤$ %
Name
≤≤% )
;
≤≤) *
	workspace
≥≥ 
.
≥≥ 
Name
≥≥ 
=
≥≥ 
request
≥≥  
.
≥≥  !
Name
≥≥! %
;
≥≥% &
await
¥¥ !
workspaceRepository
¥¥ !
.
¥¥! "
UpdateAsync
¥¥" -
(
¥¥- .
	workspace
¥¥. 7
,
¥¥7 8
ct
¥¥9 ;
)
¥¥; <
;
¥¥< =
if
∂∂ 

(
∂∂ 
auditOutboxWriter
∂∂ 
is
∂∂  
not
∂∂! $
null
∂∂% )
)
∂∂) *
{
∑∑ 	
await
∏∏ 
auditOutboxWriter
∏∏ #
.
∏∏# $
EnqueueAuditAsync
∏∏$ 5
(
∏∏5 6
new
ππ  
AuditEventContract
ππ "
(
ππ" #
EventId
∫∫ 
:
∫∫ 
Guid
∫∫ 
.
∫∫ 
NewGuid
∫∫ %
(
∫∫% &
)
∫∫& '
,
∫∫' (
SchemaVersion
ªª 
:
ªª 
$num
ªª  
,
ªª  !
OccurredAtUtc
ºº 
:
ºº 
DateTimeOffset
ºº -
.
ºº- .
UtcNow
ºº. 4
,
ºº4 5
SourceService
ΩΩ 
:
ΩΩ 
$str
ΩΩ %
,
ΩΩ% &
ActorUserId
ææ 
:
ææ 
userId
ææ #
,
ææ# $

AuditScope
øø 
:
øø 
AuditRouting
øø (
.
øø( )
ScopeWorkspace
øø) 7
,
øø7 8
TargetId
¿¿ 
:
¿¿ 
workspaceId
¿¿ %
,
¿¿% &
Action
¡¡ 
:
¡¡ 
$str
¡¡ +
,
¡¡+ ,
	FieldName
¬¬ 
:
¬¬ 
$str
¬¬ !
,
¬¬! "

EntityType
√√ 
:
√√ 
null
√√  
,
√√  !
OldValueJson
ƒƒ 
:
ƒƒ 
JsonSerializer
ƒƒ ,
.
ƒƒ, -
	Serialize
ƒƒ- 6
(
ƒƒ6 7
new
ƒƒ7 :
{
ƒƒ; <
Name
ƒƒ= A
=
ƒƒB C
previousName
ƒƒD P
}
ƒƒQ R
)
ƒƒR S
,
ƒƒS T
NewValueJson
≈≈ 
:
≈≈ 
JsonSerializer
≈≈ ,
.
≈≈, -
	Serialize
≈≈- 6
(
≈≈6 7
new
≈≈7 :
{
≈≈; <
Name
≈≈= A
=
≈≈B C
request
≈≈D K
.
≈≈K L
Name
≈≈L P
}
≈≈Q R
)
≈≈R S
)
≈≈S T
,
≈≈T U
ct
∆∆ 
)
∆∆ 
;
∆∆ 
await
«« )
PublishWorkspaceDomainAsync
«« -
(
««- .
auditOutboxWriter
»» !
,
»»! "
DomainRouting
…… 
.
…… &
CoreWorkspaceVerbUpdated
…… 6
,
……6 7
$str
   
,
   
	workspace
ÀÀ 
.
ÀÀ 
Id
ÀÀ 
,
ÀÀ 
	workspace
ÃÃ 
.
ÃÃ 
OrganizationId
ÃÃ (
,
ÃÃ( )
userId
ÕÕ 
,
ÕÕ 
	workspace
ŒŒ 
.
ŒŒ 
Name
ŒŒ 
,
ŒŒ 
ct
œœ 
)
œœ 
;
œœ 
}
–– 	
}
—— 
public
”” 

async
”” 
Task
”” 
ArchiveAsync
”” "
(
””" #
int
””# &
workspaceId
””' 2
,
””2 3
int
””4 7
userId
””8 >
,
””> ?
CancellationToken
””@ Q
ct
””R T
=
””U V
default
””W ^
)
””^ _
{
‘‘ 
await
’’ 
workspaceAccess
’’ 
.
’’ +
EnsureCanAccessWorkspaceAsync
’’ ;
(
’’; <
userId
’’< B
,
’’B C
workspaceId
’’D O
,
’’O P
ct
’’Q S
)
’’S T
;
’’T U
var
◊◊ 

membership
◊◊ 
=
◊◊ 
await
◊◊ 
memberRepository
◊◊ /
.
◊◊/ 0
GetAsync
◊◊0 8
(
◊◊8 9
userId
◊◊9 ?
,
◊◊? @
workspaceId
◊◊A L
,
◊◊L M
ct
◊◊N P
)
◊◊P Q
;
◊◊Q R
var
ÿÿ 
isWsAdminFallback
ÿÿ 
=
ÿÿ 
string
ÿÿ  &
.
ÿÿ& '
Equals
ÿÿ' -
(
ÿÿ- .

membership
ÿÿ. 8
?
ÿÿ8 9
.
ÿÿ9 :
Role
ÿÿ: >
?
ÿÿ> ?
.
ÿÿ? @
Name
ÿÿ@ D
,
ÿÿD E
$str
ÿÿF P
,
ÿÿP Q
StringComparison
ÿÿR b
.
ÿÿb c
Ordinal
ÿÿc j
)
ÿÿj k
;
ÿÿk l
var
ŸŸ 

isOrgOwner
ŸŸ 
=
ŸŸ 
await
ŸŸ 
workspaceAccess
ŸŸ .
.
ŸŸ. /(
IsOrgOwnerOfWorkspaceAsync
ŸŸ/ I
(
ŸŸI J
userId
ŸŸJ P
,
ŸŸP Q
workspaceId
ŸŸR ]
,
ŸŸ] ^
ct
ŸŸ_ a
)
ŸŸa b
;
ŸŸb c
var
⁄⁄  
canDeleteWorkspace
⁄⁄ 
=
⁄⁄  
await
⁄⁄! &
workspaceAccess
⁄⁄' 6
.
⁄⁄6 7)
HasWorkspacePermissionAsync
⁄⁄7 R
(
⁄⁄R S
userId
€€ 
,
€€ 
workspaceId
‹‹ 
,
‹‹ "
WorkspacePermissions
››  
.
››  !
DeleteWorkspace
››! 0
,
››0 1
ct
ﬁﬁ 
)
ﬁﬁ 
;
ﬁﬁ 
if
ﬂﬂ 

(
ﬂﬂ 
!
ﬂﬂ  
canDeleteWorkspace
ﬂﬂ 
&&
ﬂﬂ  "
!
ﬂﬂ# $

isOrgOwner
ﬂﬂ$ .
&&
ﬂﬂ/ 1
!
ﬂﬂ2 3
isWsAdminFallback
ﬂﬂ3 D
)
ﬂﬂD E
throw
‡‡ 
new
‡‡ 
AppException
‡‡ "
(
‡‡" #
$str
‡‡# B
,
‡‡B C
$num
‡‡D G
,
‡‡G H
$str
·· W
)
··W X
;
··X Y
var
„„ 
	workspace
„„ 
=
„„ 
await
„„ !
workspaceRepository
„„ 1
.
„„1 2
GetByIdAsync
„„2 >
(
„„> ?
workspaceId
„„? J
,
„„J K
ct
„„L N
)
„„N O
??
‰‰ 
throw
‰‰ 
new
‰‰ 
AppException
‰‰ %
(
‰‰% &
$str
‰‰& ;
,
‰‰; <
$num
‰‰= @
,
‰‰@ A
$str
‰‰B X
)
‰‰X Y
;
‰‰Y Z
	workspace
ÊÊ 
.
ÊÊ 

IsArchived
ÊÊ 
=
ÊÊ 
true
ÊÊ #
;
ÊÊ# $
await
ÁÁ !
workspaceRepository
ÁÁ !
.
ÁÁ! "
UpdateAsync
ÁÁ" -
(
ÁÁ- .
	workspace
ÁÁ. 7
,
ÁÁ7 8
ct
ÁÁ9 ;
)
ÁÁ; <
;
ÁÁ< =
if
ÈÈ 

(
ÈÈ 
auditOutboxWriter
ÈÈ 
is
ÈÈ  
not
ÈÈ! $
null
ÈÈ% )
)
ÈÈ) *
{
ÍÍ 	
await
ÎÎ 
auditOutboxWriter
ÎÎ #
.
ÎÎ# $
EnqueueAuditAsync
ÎÎ$ 5
(
ÎÎ5 6
new
ÏÏ  
AuditEventContract
ÏÏ "
(
ÏÏ" #
EventId
ÌÌ 
:
ÌÌ 
Guid
ÌÌ 
.
ÌÌ 
NewGuid
ÌÌ %
(
ÌÌ% &
)
ÌÌ& '
,
ÌÌ' (
SchemaVersion
ÓÓ 
:
ÓÓ 
$num
ÓÓ  
,
ÓÓ  !
OccurredAtUtc
ÔÔ 
:
ÔÔ 
DateTimeOffset
ÔÔ -
.
ÔÔ- .
UtcNow
ÔÔ. 4
,
ÔÔ4 5
SourceService
 
:
 
$str
 %
,
% &
ActorUserId
ÒÒ 
:
ÒÒ 
userId
ÒÒ #
,
ÒÒ# $

AuditScope
ÚÚ 
:
ÚÚ 
AuditRouting
ÚÚ (
.
ÚÚ( )
ScopeWorkspace
ÚÚ) 7
,
ÚÚ7 8
TargetId
ÛÛ 
:
ÛÛ 
workspaceId
ÛÛ %
,
ÛÛ% &
Action
ÙÙ 
:
ÙÙ 
$str
ÙÙ ,
,
ÙÙ, -
	FieldName
ıı 
:
ıı 
$str
ıı (
,
ıı( )

EntityType
ˆˆ 
:
ˆˆ 
null
ˆˆ  
,
ˆˆ  !
OldValueJson
˜˜ 
:
˜˜ 
JsonSerializer
˜˜ ,
.
˜˜, -
	Serialize
˜˜- 6
(
˜˜6 7
new
˜˜7 :
{
˜˜; <

IsArchived
˜˜= G
=
˜˜H I
false
˜˜J O
}
˜˜P Q
)
˜˜Q R
,
˜˜R S
NewValueJson
¯¯ 
:
¯¯ 
JsonSerializer
¯¯ ,
.
¯¯, -
	Serialize
¯¯- 6
(
¯¯6 7
new
¯¯7 :
{
¯¯; <

IsArchived
¯¯= G
=
¯¯H I
true
¯¯J N
}
¯¯O P
)
¯¯P Q
)
¯¯Q R
,
¯¯R S
ct
˘˘ 
)
˘˘ 
;
˘˘ 
await
˙˙ )
PublishWorkspaceDomainAsync
˙˙ -
(
˙˙- .
auditOutboxWriter
˚˚ !
,
˚˚! "
DomainRouting
¸¸ 
.
¸¸ '
CoreWorkspaceVerbArchived
¸¸ 7
,
¸¸7 8
$str
˝˝ 
,
˝˝ 
	workspace
˛˛ 
.
˛˛ 
Id
˛˛ 
,
˛˛ 
	workspace
ˇˇ 
.
ˇˇ 
OrganizationId
ˇˇ (
,
ˇˇ( )
userId
ÄÄ 
,
ÄÄ 
	workspace
ÅÅ 
.
ÅÅ 
Name
ÅÅ 
,
ÅÅ 
ct
ÇÇ 
)
ÇÇ 
;
ÇÇ 
}
ÉÉ 	
}
ÑÑ 
public
ÜÜ 

async
ÜÜ 
Task
ÜÜ 
<
ÜÜ "
WorkspaceSettingsDto
ÜÜ *
>
ÜÜ* +
GetSettingsAsync
ÜÜ, <
(
ÜÜ< =
int
ÜÜ= @
workspaceId
ÜÜA L
,
ÜÜL M
int
ÜÜN Q
userId
ÜÜR X
,
ÜÜX Y
CancellationToken
ÜÜZ k
ct
ÜÜl n
=
ÜÜo p
default
ÜÜq x
)
ÜÜx y
{
áá 
await
àà 
workspaceAccess
àà 
.
àà +
EnsureCanAccessWorkspaceAsync
àà ;
(
àà; <
userId
àà< B
,
ààB C
workspaceId
ààD O
,
ààO P
ct
ààQ S
)
ààS T
;
ààT U
var
ää 
settings
ää 
=
ää 
await
ää )
workspaceSettingsRepository
ää 8
.
ää8 9#
GetByWorkspaceIdAsync
ää9 N
(
ääN O
workspaceId
ääO Z
,
ääZ [
ct
ää\ ^
)
ää^ _
??
ãã 
throw
ãã 
new
ãã 
AppException
ãã %
(
ãã% &
$str
ãã& D
,
ããD E
$num
ããF I
,
ããI J
$str
ããK j
)
ããj k
;
ããk l
var
çç 
	workspace
çç 
=
çç 
await
çç !
workspaceRepository
çç 1
.
çç1 2
GetByIdAsync
çç2 >
(
çç> ?
workspaceId
çç? J
,
ççJ K
ct
ççL N
)
ççN O
??
éé 
throw
éé 
new
éé 
AppException
éé %
(
éé% &
$str
éé& ;
,
éé; <
$num
éé= @
,
éé@ A
$str
ééB X
)
ééX Y
;
ééY Z
if
êê 

(
êê 
auditOutboxWriter
êê 
is
êê  
not
êê! $
null
êê% )
)
êê) *
{
ëë 	
await
íí 
auditOutboxWriter
íí #
.
íí# $
EnqueueAuditAsync
íí$ 5
(
íí5 6
new
ìì  
AuditEventContract
ìì &
(
ìì& '
EventId
îî 
:
îî 
Guid
îî !
.
îî! "
NewGuid
îî" )
(
îî) *
)
îî* +
,
îî+ ,
SchemaVersion
ïï !
:
ïï! "
$num
ïï# $
,
ïï$ %
OccurredAtUtc
ññ !
:
ññ! "
DateTimeOffset
ññ# 1
.
ññ1 2
UtcNow
ññ2 8
,
ññ8 9
SourceService
óó !
:
óó! "
$str
óó# )
,
óó) *
ActorUserId
òò 
:
òò  
userId
òò! '
,
òò' (

AuditScope
ôô 
:
ôô 
AuditRouting
ôô  ,
.
ôô, -
ScopeWorkspace
ôô- ;
,
ôô; <
TargetId
öö 
:
öö 
workspaceId
öö )
,
öö) *
Action
õõ 
:
õõ 
$str
õõ 5
,
õõ5 6
	FieldName
úú 
:
úú 
null
úú #
,
úú# $

EntityType
ùù 
:
ùù 
null
ùù  $
,
ùù$ %
OldValueJson
ûû  
:
ûû  !
null
ûû" &
,
ûû& '
NewValueJson
üü  
:
üü  !
null
üü" &
)
üü& '
,
üü' (
ct
†† 
)
†† 
;
†† 
}
°° 	
return
££ 
new
££ "
WorkspaceSettingsDto
££ '
(
££' (
settings
§§ 
.
§§ 
WorkspaceId
§§  
,
§§  !
	workspace
•• 
.
•• 
Name
•• 
,
•• 
settings
¶¶ 
.
¶¶ 
Description
¶¶  
,
¶¶  !
settings
ßß 
.
ßß 
HighRiskThreshold
ßß &
,
ßß& '
settings
®® 
.
®® !
MediumRiskThreshold
®® (
,
®®( )
settings
©© 
.
©©  
RiskScoringEnabled
©© '
)
©©' (
;
©©( )
}
™™ 
public
¨¨ 

async
¨¨ 
Task
¨¨ !
UpdateSettingsAsync
¨¨ )
(
¨¨) *
int
¨¨* -
workspaceId
¨¨. 9
,
¨¨9 :
int
¨¨; >
userId
¨¨? E
,
¨¨E F,
UpdateWorkspaceSettingsRequest
¨¨G e
request
¨¨f m
,
¨¨m n 
CancellationToken¨¨o Ä
ct¨¨Å É
=¨¨Ñ Ö
default¨¨Ü ç
)¨¨ç é
{
≠≠ 
await
ÆÆ %
updateSettingsValidator
ÆÆ %
.
ÆÆ% &#
ValidateAndThrowAsync
ÆÆ& ;
(
ÆÆ; <
request
ÆÆ< C
,
ÆÆC D
ct
ÆÆE G
)
ÆÆG H
;
ÆÆH I
if
∞∞ 

(
∞∞ 
!
∞∞ 
await
∞∞ 
workspaceAccess
∞∞ "
.
∞∞" #)
HasWorkspacePermissionAsync
∞∞# >
(
∞∞> ?
userId
∞∞? E
,
∞∞E F
workspaceId
∞∞G R
,
∞∞R S"
WorkspacePermissions
∞∞T h
.
∞∞h i
ManageWsSettings
∞∞i y
,
∞∞y z
ct
∞∞{ }
)
∞∞} ~
)
∞∞~ 
throw
±± 
new
±± 
AppException
±± "
(
±±" #
$str
±±# 6
,
±±6 7
$num
±±8 ;
,
±±; <
$"
±±= ?
$str
±±? T
{
±±T U"
WorkspacePermissions
±±U i
.
±±i j
ManageWsSettings
±±j z
}
±±z {
$str±±{ ö
"±±ö õ
)±±õ ú
;±±ú ù
var
≥≥ 
settings
≥≥ 
=
≥≥ 
await
≥≥ )
workspaceSettingsRepository
≥≥ 8
.
≥≥8 9#
GetByWorkspaceIdAsync
≥≥9 N
(
≥≥N O
workspaceId
≥≥O Z
,
≥≥Z [
ct
≥≥\ ^
)
≥≥^ _
??
¥¥ 
throw
¥¥ 
new
¥¥ 
AppException
¥¥ %
(
¥¥% &
$str
¥¥& D
,
¥¥D E
$num
¥¥F I
,
¥¥I J
$str
¥¥K j
)
¥¥j k
;
¥¥k l
var
∂∂ 
	workspace
∂∂ 
=
∂∂ 
await
∂∂ !
workspaceRepository
∂∂ 1
.
∂∂1 2
GetByIdAsync
∂∂2 >
(
∂∂> ?
workspaceId
∂∂? J
,
∂∂J K
ct
∂∂L N
)
∂∂N O
??
∑∑ 
throw
∑∑ 
new
∑∑ 
AppException
∑∑ %
(
∑∑% &
$str
∑∑& ;
,
∑∑; <
$num
∑∑= @
,
∑∑@ A
$str
∑∑B X
)
∑∑X Y
;
∑∑Y Z
var
ππ 
oldJson
ππ 
=
ππ 
JsonSerializer
ππ $
.
ππ$ %
	Serialize
ππ% .
(
ππ. /
new
ππ/ 2
{
∫∫ 	
	workspace
ªª 
.
ªª 
Name
ªª 
,
ªª 
settings
ºº 
.
ºº 
Description
ºº  
,
ºº  !
settings
ΩΩ 
.
ΩΩ 
HighRiskThreshold
ΩΩ &
,
ΩΩ& '
settings
ææ 
.
ææ !
MediumRiskThreshold
ææ (
,
ææ( )
settings
øø 
.
øø  
RiskScoringEnabled
øø '
}
¿¿ 	
)
¿¿	 

;
¿¿
 
	workspace
¬¬ 
.
¬¬ 
Name
¬¬ 
=
¬¬ 
request
¬¬  
.
¬¬  !
Name
¬¬! %
;
¬¬% &
settings
√√ 
.
√√ 
Description
√√ 
=
√√ 
request
√√ &
.
√√& '
Description
√√' 2
;
√√2 3
settings
ƒƒ 
.
ƒƒ 
HighRiskThreshold
ƒƒ "
=
ƒƒ# $
request
ƒƒ% ,
.
ƒƒ, -
HighRiskThreshold
ƒƒ- >
;
ƒƒ> ?
settings
≈≈ 
.
≈≈ !
MediumRiskThreshold
≈≈ $
=
≈≈% &
request
≈≈' .
.
≈≈. /!
MediumRiskThreshold
≈≈/ B
;
≈≈B C
settings
∆∆ 
.
∆∆  
RiskScoringEnabled
∆∆ #
=
∆∆$ %
request
∆∆& -
.
∆∆- . 
RiskScoringEnabled
∆∆. @
;
∆∆@ A
await
»» !
workspaceRepository
»» !
.
»»! "
UpdateAsync
»»" -
(
»»- .
	workspace
»». 7
,
»»7 8
ct
»»9 ;
)
»»; <
;
»»< =
await
…… )
workspaceSettingsRepository
…… )
.
……) *
UpdateAsync
……* 5
(
……5 6
settings
……6 >
,
……> ?
ct
……@ B
)
……B C
;
……C D
if
ÀÀ 

(
ÀÀ 
auditOutboxWriter
ÀÀ 
is
ÀÀ  
not
ÀÀ! $
null
ÀÀ% )
)
ÀÀ) *
{
ÃÃ 	
await
ÕÕ 
auditOutboxWriter
ÕÕ #
.
ÕÕ# $
EnqueueAuditAsync
ÕÕ$ 5
(
ÕÕ5 6
new
ŒŒ  
AuditEventContract
ŒŒ &
(
ŒŒ& '
EventId
œœ 
:
œœ 
Guid
œœ !
.
œœ! "
NewGuid
œœ" )
(
œœ) *
)
œœ* +
,
œœ+ ,
SchemaVersion
–– !
:
––! "
$num
––# $
,
––$ %
OccurredAtUtc
—— !
:
——! "
DateTimeOffset
——# 1
.
——1 2
UtcNow
——2 8
,
——8 9
SourceService
““ !
:
““! "
$str
““# )
,
““) *
ActorUserId
”” 
:
””  
userId
””! '
,
””' (

AuditScope
‘‘ 
:
‘‘ 
AuditRouting
‘‘  ,
.
‘‘, -
ScopeWorkspace
‘‘- ;
,
‘‘; <
TargetId
’’ 
:
’’ 
workspaceId
’’ )
,
’’) *
Action
÷÷ 
:
÷÷ 
$str
÷÷ 8
,
÷÷8 9
	FieldName
◊◊ 
:
◊◊ 
null
◊◊ #
,
◊◊# $

EntityType
ÿÿ 
:
ÿÿ 
null
ÿÿ  $
,
ÿÿ$ %
OldValueJson
ŸŸ  
:
ŸŸ  !
oldJson
ŸŸ" )
,
ŸŸ) *
NewValueJson
⁄⁄  
:
⁄⁄  !
JsonSerializer
⁄⁄" 0
.
⁄⁄0 1
	Serialize
⁄⁄1 :
(
⁄⁄: ;
new
⁄⁄; >
{
€€ 
request
‹‹ 
.
‹‹  
Name
‹‹  $
,
‹‹$ %
request
›› 
.
››  
Description
››  +
,
››+ ,
request
ﬁﬁ 
.
ﬁﬁ  
HighRiskThreshold
ﬁﬁ  1
,
ﬁﬁ1 2
request
ﬂﬂ 
.
ﬂﬂ  !
MediumRiskThreshold
ﬂﬂ  3
,
ﬂﬂ3 4
request
‡‡ 
.
‡‡   
RiskScoringEnabled
‡‡  2
}
·· 
)
·· 
)
·· 
,
·· 
ct
‚‚ 
)
‚‚ 
;
‚‚ 
var
‰‰ 
sagaId
‰‰ 
=
‰‰ 
Guid
‰‰ 
.
‰‰ 
NewGuid
‰‰ %
(
‰‰% &
)
‰‰& '
;
‰‰' (
await
ÂÂ 
auditOutboxWriter
ÂÂ #
.
ÂÂ# $ 
EnqueueDomainAsync
ÂÂ$ 6
(
ÂÂ6 7
DomainRouting
ÊÊ 
.
ÊÊ %
RoutingKeyCoreWorkspace
ÊÊ 5
(
ÊÊ5 6
DomainRouting
ÊÊ6 C
.
ÊÊC D.
 CoreWorkspaceVerbSettingsUpdated
ÊÊD d
)
ÊÊd e
,
ÊÊe f
new
ÁÁ #
DomainMessageEnvelope
ÁÁ )
(
ÁÁ) *
SchemaVersion
ËË !
:
ËË! "%
MessagingSchemaVersions
ËË# :
.
ËË: ;
V1
ËË; =
,
ËË= >
	MessageId
ÈÈ 
:
ÈÈ 
Guid
ÈÈ #
.
ÈÈ# $
NewGuid
ÈÈ$ +
(
ÈÈ+ ,
)
ÈÈ, -
,
ÈÈ- .
CorrelationId
ÍÍ !
:
ÍÍ! "
sagaId
ÍÍ# )
,
ÍÍ) *
SagaInstanceId
ÎÎ "
:
ÎÎ" #
sagaId
ÎÎ$ *
,
ÎÎ* +
CausationId
ÏÏ 
:
ÏÏ  
null
ÏÏ! %
,
ÏÏ% &
OccurredAtUtc
ÌÌ !
:
ÌÌ! "
DateTimeOffset
ÌÌ# 1
.
ÌÌ1 2
UtcNow
ÌÌ2 8
,
ÌÌ8 9
SourceService
ÓÓ !
:
ÓÓ! "
$str
ÓÓ# )
,
ÓÓ) *
PayloadTypeName
ÔÔ #
:
ÔÔ# $ 
DomainPayloadTypes
ÔÔ% 7
.
ÔÔ7 8(
WorkspaceSettingsUpdatedV1
ÔÔ8 R
,
ÔÔR S
PayloadJson
 
:
  
JsonSerializer
! /
.
/ 0
	Serialize
0 9
(
9 :
new
: =/
!WorkspaceSettingsUpdatedPayloadV1
> _
(
_ `
workspaceId
ÒÒ #
,
ÒÒ# $
	workspace
ÚÚ !
.
ÚÚ! "
OrganizationId
ÚÚ" 0
,
ÚÚ0 1
userId
ÛÛ 
)
ÛÛ 
)
ÛÛ  
)
ÛÛ  !
,
ÛÛ! "
ct
ÙÙ 
)
ÙÙ 
;
ÙÙ 
}
ıı 	
}
ˆˆ 
private
¯¯ 
static
¯¯ 
Task
¯¯ )
PublishWorkspaceDomainAsync
¯¯ 3
(
¯¯3 4
IOutboxWriter
˘˘ 
outboxWriter
˘˘ "
,
˘˘" #
string
˙˙ 
routingVerb
˙˙ 
,
˙˙ 
string
˚˚ 
lifecycleAction
˚˚ 
,
˚˚ 
int
¸¸ 
workspaceId
¸¸ 
,
¸¸ 
int
˝˝ 
organizationId
˝˝ 
,
˝˝ 
int
˛˛ 
actorUserId
˛˛ 
,
˛˛ 
string
ˇˇ 
?
ˇˇ 
workspaceName
ˇˇ 
,
ˇˇ 
CancellationToken
ÄÄ 
ct
ÄÄ 
)
ÄÄ 
{
ÅÅ 
var
ÇÇ 
sagaInstanceId
ÇÇ 
=
ÇÇ 
Guid
ÇÇ !
.
ÇÇ! "
NewGuid
ÇÇ" )
(
ÇÇ) *
)
ÇÇ* +
;
ÇÇ+ ,
var
ÉÉ 
envelope
ÉÉ 
=
ÉÉ 
new
ÉÉ #
DomainMessageEnvelope
ÉÉ 0
(
ÉÉ0 1
SchemaVersion
ÑÑ 
:
ÑÑ %
MessagingSchemaVersions
ÑÑ 2
.
ÑÑ2 3
V1
ÑÑ3 5
,
ÑÑ5 6
	MessageId
ÖÖ 
:
ÖÖ 
Guid
ÖÖ 
.
ÖÖ 
NewGuid
ÖÖ #
(
ÖÖ# $
)
ÖÖ$ %
,
ÖÖ% &
CorrelationId
ÜÜ 
:
ÜÜ 
sagaInstanceId
ÜÜ )
,
ÜÜ) *
SagaInstanceId
áá 
:
áá 
sagaInstanceId
áá *
,
áá* +
CausationId
àà 
:
àà 
null
àà 
,
àà 
OccurredAtUtc
ââ 
:
ââ 
DateTimeOffset
ââ )
.
ââ) *
UtcNow
ââ* 0
,
ââ0 1
SourceService
ää 
:
ää 
$str
ää !
,
ää! "
PayloadTypeName
ãã 
:
ãã  
DomainPayloadTypes
ãã /
.
ãã/ 0"
WorkspaceLifecycleV1
ãã0 D
,
ããD E
PayloadJson
åå 
:
åå 
JsonSerializer
åå '
.
åå' (
	Serialize
åå( 1
(
åå1 2
new
åå2 5)
WorkspaceLifecyclePayloadV1
åå6 Q
(
ååQ R
lifecycleAction
çç 
,
çç  
workspaceId
éé 
,
éé 
organizationId
èè 
,
èè 
actorUserId
êê 
,
êê 
workspaceName
ëë 
)
ëë 
)
ëë 
)
ëë  
;
ëë  !
return
ìì 
outboxWriter
ìì 
.
ìì  
EnqueueDomainAsync
ìì .
(
ìì. /
DomainRouting
îî 
.
îî %
RoutingKeyCoreWorkspace
îî 1
(
îî1 2
routingVerb
îî2 =
)
îî= >
,
îî> ?
envelope
ïï 
,
ïï 
ct
ññ 
)
ññ 
;
ññ 
}
óó 
}ôô —Ú
mC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Services\WorkspaceMemberService.cs
	namespace

 	
Relativa


 
.

 
Core

 
.

 
Application

 #
.

# $
Services

$ ,
;

, -
public 
sealed 
class "
WorkspaceMemberService *
(* +(
IUserRoleWorkspaceRepository  
memberRepository! 1
,1 2$
IWorkspaceRoleRepository 
roleRepository +
,+ ,+
IUserRoleOrganizationRepository #
orgMemberRepository$ 7
,7 8 
IWorkspaceRepository 
workspaceRepository ,
,, -%
IWorkspaceAccessEvaluator 
workspaceAccess -
,- .
IOutboxWriter 
? 
auditOutboxWriter $
=% &
null' +
)+ ,
:- .#
IWorkspaceMemberService/ F
{ 
private 
const 
string %
ManageOrgWorkspaceMembers 2
=3 4
$str5 S
;S T
public 

async 
Task 
< 
List 
< 
WorkspaceMemberDto -
>- .
>. /
GetMembersAsync0 ?
(? @
int@ C
workspaceIdD O
,O P
intQ T
userIdU [
,[ \
CancellationToken] n
cto q
=r s
defaultt {
){ |
{ 
await 
workspaceAccess 
. )
EnsureCanAccessWorkspaceAsync ;
(; <
userId< B
,B C
workspaceIdD O
,O P
ctQ S
)S T
;T U
var 
members 
= 
await 
memberRepository ,
., -!
GetByWorkspaceIdAsync- B
(B C
workspaceIdC N
,N O
ctP R
)R S
;S T
return 
members 
. 
Where 
( 
m 
=> 
! 
m 
. 

IsArchived %
)% &
. 
Select 
( 
m 
=> 
new 
WorkspaceMemberDto /
(/ 0
m 
. 
UserId 
, 
m 
. 
User 
. 
	FirstName  
,  !
m 
. 
User 
. 
LastName 
,  
m   
.   
User   
.   
Email   
,   
m!! 
.!! 
Role!! 
.!! 
Name!! 
,!! 
m"" 
."" 
Role"" 
."" 
DisplayName"" "
??""# %
DisplayNameHelper""& 7
.""7 8
Humanize""8 @
(""@ A
m""A B
.""B C
Role""C G
.""G H
Name""H L
)""L M
,""M N
m## 
.## 
JoinedAt## 
)## 
)## 
.$$ 
ToList$$ 
($$ 
)$$ 
;$$ 
}%% 
public'' 

async'' 
Task'' 
UpdateRoleAsync'' %
(''% &
int''& )
workspaceId''* 5
,''5 6
int''7 :
targetUserId''; G
,''G H
int''I L
callerUserId''M Y
,''Y Z#
UpdateMemberRoleRequest''[ r
request''s z
,''z {
CancellationToken	''| ç
ct
''é ê
=
''ë í
default
''ì ö
)
''ö õ
{(( 
await)) 
RequirePermission)) 
())  
callerUserId))  ,
,)), -
workspaceId)). 9
,))9 :
$str)); L
,))L M
ct))N P
)))P Q
;))Q R
var++ 
targetMember++ 
=++ 
await++  
memberRepository++! 1
.++1 2
GetAsync++2 :
(++: ;
targetUserId++; G
,++G H
workspaceId++I T
,++T U
ct++V X
)++X Y
??,, 
throw,, 
new,, 
AppException,, %
(,,% &
$str,,& <
,,,< =
$num,,> A
,,,A B
$str,,C s
),,s t
;,,t u
var.. 
role.. 
=.. 
await.. 
roleRepository.. '
...' (
GetByIdAsync..( 4
(..4 5
request..5 <
...< =
RoleId..= C
,..C D
ct..E G
)..G H
??// 
throw// 
new// 
AppException// %
(//% &
$str//& 6
,//6 7
$num//8 ;
,//; <
$str//= a
)//a b
;//b c
if11 

(11 
role11 
.11 
WorkspaceId11 
.11 
HasValue11 %
&&11& (
role11) -
.11- .
WorkspaceId11. 9
.119 :
Value11: ?
!=11@ B
workspaceId11C N
)11N O
throw22 
new22 
AppException22 "
(22" #
$str22# :
,22: ;
$num22< ?
,22? @
$str22A x
)22x y
;22y z
var44 "
targetHasFullAuthority44 "
=44# $#
RolePermissionEvaluator44% <
.44< =
HasAllPermissions44= N
(44N O
targetMember55 
.55 
Role55 
,55  
WorkspacePermissions66  
.66  !"
FullWorkspaceAuthority66! 7
)667 8
;668 9
var77 #
targetIsWsAdminFallback77 #
=77$ %
string77& ,
.77, -
Equals77- 3
(773 4
targetMember774 @
.77@ A
Role77A E
?77E F
.77F G
Name77G K
,77K L
$str77M W
,77W X
StringComparison77Y i
.77i j
Ordinal77j q
)77q r
;77r s
var88 #
newRoleHasFullAuthority88 #
=88$ %#
RolePermissionEvaluator88& =
.88= >
HasAllPermissions88> O
(88O P
role99 
,99  
WorkspacePermissions::  
.::  !"
FullWorkspaceAuthority::! 7
)::7 8
;::8 9
var;; $
newRoleIsWsAdminFallback;; $
=;;% &
string;;' -
.;;- .
Equals;;. 4
(;;4 5
role;;5 9
.;;9 :
Name;;: >
,;;> ?
$str;;@ J
,;;J K
StringComparison;;L \
.;;\ ]
Ordinal;;] d
);;d e
;;;e f
if<< 

(<< 
(<< "
targetHasFullAuthority<< #
||<<$ &#
targetIsWsAdminFallback<<' >
)<<> ?
&&<<@ B
!== 
(== #
newRoleHasFullAuthority== %
||==& ($
newRoleIsWsAdminFallback==) A
)==A B
)==B C
{>> 	
var?? 

allMembers?? 
=?? 
await?? "
memberRepository??# 3
.??3 4!
GetByWorkspaceIdAsync??4 I
(??I J
workspaceId??J U
,??U V
ct??W Y
)??Y Z
;??Z [
var@@ 
fullAuthorityCount@@ "
=@@# $

allMembers@@% /
.@@/ 0
Count@@0 5
(@@5 6
m@@6 7
=>@@8 :
!AA 
mAA 
.AA 

IsArchivedAA 
&&AA  #
RolePermissionEvaluatorBB '
.BB' (
HasAllPermissionsBB( 9
(BB9 :
mBB: ;
.BB; <
RoleBB< @
,BB@ A 
WorkspacePermissionsBBB V
.BBV W"
FullWorkspaceAuthorityBBW m
)BBm n
)BBn o
;BBo p
ifCC 
(CC 
fullAuthorityCountCC "
==CC# %
$numCC& '
)CC' (
{DD 
fullAuthorityCountEE "
=EE# $

allMembersEE% /
.EE/ 0
CountEE0 5
(EE5 6
mEE6 7
=>EE8 :
!FF 
mFF 
.FF 

IsArchivedFF !
&&FF" $
stringGG 
.GG 
EqualsGG !
(GG! "
mGG" #
.GG# $
RoleGG$ (
?GG( )
.GG) *
NameGG* .
,GG. /
$strGG0 :
,GG: ;
StringComparisonGG< L
.GGL M
OrdinalGGM T
)GGT U
)GGU V
;GGV W
}HH 
ifII 
(II 
fullAuthorityCountII "
<=II# %
$numII& '
)II' (
{JJ 
throwKK 
newKK 
AppExceptionKK &
(KK& '
$strKK' A
,KKA B
$numKKC F
,KKF G
$strKKH q
)KKq r
;KKr s
}LL 
}MM 	
targetMemberOO 
.OO 
WsRoleIdOO 
=OO 
roleOO  $
.OO$ %
IdOO% '
;OO' (
awaitPP 
memberRepositoryPP 
.PP 
UpdateAsyncPP *
(PP* +
targetMemberPP+ 7
,PP7 8
ctPP9 ;
)PP; <
;PP< =
ifQQ 

(QQ 
auditOutboxWriterQQ 
isQQ  
notQQ! $
nullQQ% )
)QQ) *
{RR 	
awaitSS 
auditOutboxWriterSS #
.SS# $
EnqueueAuditAsyncSS$ 5
(SS5 6
newTT 
AuditEventContractTT &
(TT& '
EventIdUU 
:UU 
GuidUU !
.UU! "
NewGuidUU" )
(UU) *
)UU* +
,UU+ ,
SchemaVersionVV !
:VV! "
$numVV# $
,VV$ %
OccurredAtUtcWW !
:WW! "
DateTimeOffsetWW# 1
.WW1 2
UtcNowWW2 8
,WW8 9
SourceServiceXX !
:XX! "
$strXX# )
,XX) *
ActorUserIdYY 
:YY  
callerUserIdYY! -
,YY- .

AuditScopeZZ 
:ZZ 
AuditRoutingZZ  ,
.ZZ, -
ScopeWorkspaceZZ- ;
,ZZ; <
TargetId[[ 
:[[ 
workspaceId[[ )
,[[) *
Action\\ 
:\\ 
$str\\ ;
,\\; <
	FieldName]] 
:]] 
$str]] ?
,]]? @

EntityType^^ 
:^^ 
null^^  $
,^^$ %
OldValueJson__  
:__  !
null__" &
,__& '
NewValueJson``  
:``  !
System``" (
.``( )
Text``) -
.``- .
Json``. 2
.``2 3
JsonSerializer``3 A
.``A B
	Serialize``B K
(``K L
new``L O
{``P Q
targetUserId``R ^
,``^ _
RoleId``` f
=``g h
role``i m
.``m n
Id``n p
}``q r
)``r s
)``s t
,``t u
ctaa 
)aa 
;aa 
}bb 	
}cc 
publicee 

asyncee 
Taskee 
RemoveAsyncee !
(ee! "
intee" %
workspaceIdee& 1
,ee1 2
intee3 6
targetUserIdee7 C
,eeC D
inteeE H
callerUserIdeeI U
,eeU V
CancellationTokeneeW h
cteei k
=eel m
defaulteen u
)eeu v
{ff 
ifgg 

(gg 
targetUserIdgg 
!=gg 
callerUserIdgg (
)gg( )
awaithh .
"RequireRemoveMemberPermissionAsynchh 4
(hh4 5
callerUserIdhh5 A
,hhA B
workspaceIdhhC N
,hhN O
cthhP R
)hhR S
;hhS T
varjj 
memberjj 
=jj 
awaitjj 
memberRepositoryjj +
.jj+ ,
GetAsyncjj, 4
(jj4 5
targetUserIdjj5 A
,jjA B
workspaceIdjjC N
,jjN O
ctjjP R
)jjR S
??kk 
throwkk 
newkk 
AppExceptionkk %
(kk% &
$strkk& <
,kk< =
$numkk> A
,kkA B
$strkkC s
)kks t
;kkt u
awaitmm 
memberRepositorymm 
.mm 
RemoveAsyncmm *
(mm* +
membermm+ 1
,mm1 2
ctmm3 5
)mm5 6
;mm6 7
ifnn 

(nn 
auditOutboxWriternn 
isnn  
notnn! $
nullnn% )
)nn) *
{oo 	
awaitpp 
auditOutboxWriterpp #
.pp# $
EnqueueAuditAsyncpp$ 5
(pp5 6
newqq 
AuditEventContractqq &
(qq& '
EventIdrr 
:rr 
Guidrr !
.rr! "
NewGuidrr" )
(rr) *
)rr* +
,rr+ ,
SchemaVersionss !
:ss! "
$numss# $
,ss$ %
OccurredAtUtctt !
:tt! "
DateTimeOffsettt# 1
.tt1 2
UtcNowtt2 8
,tt8 9
SourceServiceuu !
:uu! "
$struu# )
,uu) *
ActorUserIdvv 
:vv  
callerUserIdvv! -
,vv- .

AuditScopeww 
:ww 
AuditRoutingww  ,
.ww, -
ScopeWorkspaceww- ;
,ww; <
TargetIdxx 
:xx 
workspaceIdxx )
,xx) *
Actionyy 
:yy 
$stryy 6
,yy6 7
	FieldNamezz 
:zz 
$strzz 4
,zz4 5

EntityType{{ 
:{{ 
null{{  $
,{{$ %
OldValueJson||  
:||  !
System||" (
.||( )
Text||) -
.||- .
Json||. 2
.||2 3
JsonSerializer||3 A
.||A B
	Serialize||B K
(||K L
new||L O
{||P Q
targetUserId||R ^
}||_ `
)||` a
,||a b
NewValueJson}}  
:}}  !
null}}" &
)}}& '
,}}' (
ct~~ 
)~~ 
;~~ 
} 	
}
ÄÄ 
public
ÇÇ 

async
ÇÇ 
Task
ÇÇ 
<
ÇÇ  
WorkspaceMemberDto
ÇÇ (
>
ÇÇ( )
AddMemberAsync
ÇÇ* 8
(
ÇÇ8 9
int
ÇÇ9 <
workspaceId
ÇÇ= H
,
ÇÇH I
int
ÇÇJ M
callerUserId
ÇÇN Z
,
ÇÇZ ['
AddWorkspaceMemberRequest
ÇÇ\ u
request
ÇÇv }
,
ÇÇ} ~ 
CancellationTokenÇÇ ê
ctÇÇë ì
=ÇÇî ï
defaultÇÇñ ù
)ÇÇù û
{
ÉÉ 
await
ÑÑ -
RequireAddMemberPermissionAsync
ÑÑ -
(
ÑÑ- .
callerUserId
ÑÑ. :
,
ÑÑ: ;
workspaceId
ÑÑ< G
,
ÑÑG H
ct
ÑÑI K
)
ÑÑK L
;
ÑÑL M
var
ÜÜ 
	workspace
ÜÜ 
=
ÜÜ 
await
ÜÜ !
workspaceRepository
ÜÜ 1
.
ÜÜ1 2
GetByIdAsync
ÜÜ2 >
(
ÜÜ> ?
workspaceId
ÜÜ? J
,
ÜÜJ K
ct
ÜÜL N
)
ÜÜN O
??
áá 
throw
áá 
new
áá 
AppException
áá %
(
áá% &
$str
áá& ;
,
áá; <
$num
áá= @
,
áá@ A
$str
ááB X
)
ááX Y
;
ááY Z
var
ââ !
targetOrgMembership
ââ 
=
ââ  !
await
ââ" '!
orgMemberRepository
ââ( ;
.
ââ; <
GetAsync
ââ< D
(
ââD E
request
ââE L
.
ââL M
UserId
ââM S
,
ââS T
	workspace
ââU ^
.
ââ^ _
OrganizationId
ââ_ m
,
ââm n
ct
ââo q
)
ââq r
??
ää 
throw
ää 
new
ää 
AppException
ää %
(
ää% &
$str
ää& =
,
ää= >
$num
ää? B
,
ääB C
$str
ääD {
)
ää{ |
;
ää| }
var
åå  
existingMembership
åå 
=
åå  
await
åå! &
memberRepository
åå' 7
.
åå7 8
GetAsync
åå8 @
(
åå@ A
request
ååA H
.
ååH I
UserId
ååI O
,
ååO P
workspaceId
ååQ \
,
åå\ ]
ct
åå^ `
)
åå` a
;
ååa b
if
çç 

(
çç  
existingMembership
çç 
is
çç !
not
çç" %
null
çç& *
)
çç* +
throw
éé 
new
éé 
AppException
éé "
(
éé" #
$str
éé# 6
,
éé6 7
$num
éé8 ;
,
éé; <
$str
éé= j
)
ééj k
;
éék l
var
êê 
role
êê 
=
êê 
await
êê 
roleRepository
êê '
.
êê' (
GetByIdAsync
êê( 4
(
êê4 5
request
êê5 <
.
êê< =
RoleId
êê= C
,
êêC D
ct
êêE G
)
êêG H
??
ëë 
throw
ëë 
new
ëë 
AppException
ëë %
(
ëë% &
$str
ëë& 6
,
ëë6 7
$num
ëë8 ;
,
ëë; <
$str
ëë= a
)
ëëa b
;
ëëb c
if
ìì 

(
ìì 
role
ìì 
.
ìì 
WorkspaceId
ìì 
.
ìì 
HasValue
ìì %
&&
ìì& (
role
ìì) -
.
ìì- .
WorkspaceId
ìì. 9
.
ìì9 :
Value
ìì: ?
!=
ìì@ B
workspaceId
ììC N
)
ììN O
throw
îî 
new
îî 
AppException
îî "
(
îî" #
$str
îî# :
,
îî: ;
$num
îî< ?
,
îî? @
$str
îîA x
)
îîx y
;
îîy z
var
ññ 
member
ññ 
=
ññ 
new
ññ 
UserRoleWorkspace
ññ *
{
óó 	
UserId
òò 
=
òò 
request
òò 
.
òò 
UserId
òò #
,
òò# $
WorkspaceId
ôô 
=
ôô 
workspaceId
ôô %
,
ôô% &
WsRoleId
öö 
=
öö 
role
öö 
.
öö 
Id
öö 
,
öö 
JoinedAt
õõ 
=
õõ 
DateTime
õõ 
.
õõ  
UtcNow
õõ  &
,
õõ& '

IsArchived
úú 
=
úú 
false
úú 
}
ùù 	
;
ùù	 

await
üü 
memberRepository
üü 
.
üü 
AddAsync
üü '
(
üü' (
member
üü( .
,
üü. /
ct
üü0 2
)
üü2 3
;
üü3 4
if
†† 

(
†† 
auditOutboxWriter
†† 
is
††  
not
††! $
null
††% )
)
††) *
{
°° 	
await
¢¢ 
auditOutboxWriter
¢¢ #
.
¢¢# $
EnqueueAuditAsync
¢¢$ 5
(
¢¢5 6
new
££  
AuditEventContract
££ &
(
££& '
EventId
§§ 
:
§§ 
Guid
§§ !
.
§§! "
NewGuid
§§" )
(
§§) *
)
§§* +
,
§§+ ,
SchemaVersion
•• !
:
••! "
$num
••# $
,
••$ %
OccurredAtUtc
¶¶ !
:
¶¶! "
DateTimeOffset
¶¶# 1
.
¶¶1 2
UtcNow
¶¶2 8
,
¶¶8 9
SourceService
ßß !
:
ßß! "
$str
ßß# )
,
ßß) *
ActorUserId
®® 
:
®®  
callerUserId
®®! -
,
®®- .

AuditScope
©© 
:
©© 
AuditRouting
©©  ,
.
©©, -
ScopeWorkspace
©©- ;
,
©©; <
TargetId
™™ 
:
™™ 
workspaceId
™™ )
,
™™) *
Action
´´ 
:
´´ 
$str
´´ 4
,
´´4 5
	FieldName
¨¨ 
:
¨¨ 
$str
¨¨ 4
,
¨¨4 5

EntityType
≠≠ 
:
≠≠ 
null
≠≠  $
,
≠≠$ %
OldValueJson
ÆÆ  
:
ÆÆ  !
null
ÆÆ" &
,
ÆÆ& '
NewValueJson
ØØ  
:
ØØ  !
System
ØØ" (
.
ØØ( )
Text
ØØ) -
.
ØØ- .
Json
ØØ. 2
.
ØØ2 3
JsonSerializer
ØØ3 A
.
ØØA B
	Serialize
ØØB K
(
ØØK L
new
ØØL O
{
ØØP Q
member
ØØR X
.
ØØX Y
UserId
ØØY _
,
ØØ_ `
member
ØØa g
.
ØØg h
WsRoleId
ØØh p
}
ØØq r
)
ØØr s
)
ØØs t
,
ØØt u
ct
∞∞ 
)
∞∞ 
;
∞∞ 
}
±± 	
var
≥≥ 
user
≥≥ 
=
≥≥ !
targetOrgMembership
≥≥ &
.
≥≥& '
User
≥≥' +
;
≥≥+ ,
return
¥¥ 
new
¥¥  
WorkspaceMemberDto
¥¥ %
(
¥¥% &
user
µµ 
.
µµ 
Id
µµ 
,
µµ 
user
∂∂ 
.
∂∂ 
	FirstName
∂∂ 
,
∂∂ 
user
∑∑ 
.
∑∑ 
LastName
∑∑ 
,
∑∑ 
user
∏∏ 
.
∏∏ 
Email
∏∏ 
,
∏∏ 
role
ππ 
.
ππ 
Name
ππ 
,
ππ 
role
∫∫ 
.
∫∫ 
DisplayName
∫∫ 
??
∫∫ 
DisplayNameHelper
∫∫  1
.
∫∫1 2
Humanize
∫∫2 :
(
∫∫: ;
role
∫∫; ?
.
∫∫? @
Name
∫∫@ D
)
∫∫D E
,
∫∫E F
member
ªª 
.
ªª 
JoinedAt
ªª 
)
ªª 
;
ªª 
}
ºº 
private
ææ 
async
ææ 
Task
ææ 
RequirePermission
ææ (
(
ææ( )
int
ææ) ,
userId
ææ- 3
,
ææ3 4
int
ææ5 8
workspaceId
ææ9 D
,
ææD E
string
ææF L

permission
ææM W
,
ææW X
CancellationToken
ææY j
ct
ææk m
)
ææm n
{
øø 
if
¿¿ 

(
¿¿ 
!
¿¿ 
await
¿¿ 
workspaceAccess
¿¿ "
.
¿¿" #)
HasWorkspacePermissionAsync
¿¿# >
(
¿¿> ?
userId
¿¿? E
,
¿¿E F
workspaceId
¿¿G R
,
¿¿R S

permission
¿¿T ^
,
¿¿^ _
ct
¿¿` b
)
¿¿b c
)
¿¿c d
throw
¡¡ 
new
¡¡ 
AppException
¡¡ "
(
¡¡" #
$str
¡¡# 6
,
¡¡6 7
$num
¡¡8 ;
,
¡¡; <
$"
¡¡= ?
$str
¡¡? T
{
¡¡T U

permission
¡¡U _
}
¡¡_ `
$str
¡¡` 
"¡¡ Ä
)¡¡Ä Å
;¡¡Å Ç
}
¬¬ 
private
ƒƒ 
async
ƒƒ 
Task
ƒƒ 
<
ƒƒ 
bool
ƒƒ 
>
ƒƒ 9
+WorkspaceMemberHasOrOrgOwnerPermissionAsync
ƒƒ H
(
ƒƒH I
int
ƒƒI L
userId
ƒƒM S
,
ƒƒS T
int
ƒƒU X
workspaceId
ƒƒY d
,
ƒƒd e
string
ƒƒf l

permission
ƒƒm w
,
ƒƒw x
CancellationToken
≈≈ 
ct
≈≈ 
)
≈≈ 
{
∆∆ 
if
«« 

(
«« 
await
«« 
workspaceAccess
«« !
.
««! "(
IsOrgOwnerOfWorkspaceAsync
««" <
(
««< =
userId
««= C
,
««C D
workspaceId
««E P
,
««P Q
ct
««R T
)
««T U
)
««U V
return
»» 
true
»» 
;
»» 
var
   
m
   
=
   
await
   
memberRepository
   &
.
  & '
GetAsync
  ' /
(
  / 0
userId
  0 6
,
  6 7
workspaceId
  8 C
,
  C D
ct
  E G
)
  G H
;
  H I
return
ÀÀ 
m
ÀÀ 
?
ÀÀ 
.
ÀÀ 
Role
ÀÀ 
?
ÀÀ 
.
ÀÀ 
RolePermissions
ÀÀ '
.
ÃÃ 
Any
ÃÃ 
(
ÃÃ 
rp
ÃÃ 
=>
ÃÃ 
string
ÃÃ 
.
ÃÃ 
Equals
ÃÃ $
(
ÃÃ$ %
rp
ÃÃ% '
.
ÃÃ' (

Permission
ÃÃ( 2
?
ÃÃ2 3
.
ÃÃ3 4
Name
ÃÃ4 8
,
ÃÃ8 9

permission
ÃÃ: D
,
ÃÃD E
StringComparison
ÃÃF V
.
ÃÃV W
Ordinal
ÃÃW ^
)
ÃÃ^ _
)
ÃÃ_ `
==
ÃÃa c
true
ÃÃd h
;
ÃÃh i
}
ÕÕ 
private
œœ 
async
œœ 
Task
œœ 
<
œœ 
bool
œœ 
>
œœ /
!IsOrgWorkspaceMembersManagerAsync
œœ >
(
œœ> ?
int
œœ? B
userId
œœC I
,
œœI J
int
œœK N
workspaceId
œœO Z
,
œœZ [
CancellationToken
œœ\ m
ct
œœn p
)
œœp q
{
–– 
var
—— 
	workspace
—— 
=
—— 
await
—— !
workspaceRepository
—— 1
.
——1 2
GetByIdAsync
——2 >
(
——> ?
workspaceId
——? J
,
——J K
ct
——L N
)
——N O
;
——O P
if
““ 

(
““ 
	workspace
““ 
is
““ 
null
““ 
)
““ 
return
”” 
false
”” 
;
”” 
var
’’ 
orgMembership
’’ 
=
’’ 
await
’’ !!
orgMemberRepository
’’" 5
.
’’5 6
GetAsync
’’6 >
(
’’> ?
userId
’’? E
,
’’E F
	workspace
’’G P
.
’’P Q
OrganizationId
’’Q _
,
’’_ `
ct
’’a c
)
’’c d
;
’’d e
return
÷÷ 
orgMembership
÷÷ 
?
÷÷ 
.
÷÷ 
Role
÷÷ "
?
÷÷" #
.
÷÷# $
RolePermissions
÷÷$ 3
.
◊◊ 
Any
◊◊ 
(
◊◊ 
rp
◊◊ 
=>
◊◊ 
string
◊◊ 
.
◊◊ 
Equals
◊◊ $
(
◊◊$ %
rp
◊◊% '
.
◊◊' (

Permission
◊◊( 2
?
◊◊2 3
.
◊◊3 4
Name
◊◊4 8
,
◊◊8 9'
ManageOrgWorkspaceMembers
◊◊: S
,
◊◊S T
StringComparison
◊◊U e
.
◊◊e f
Ordinal
◊◊f m
)
◊◊m n
)
◊◊n o
==
◊◊p r
true
◊◊s w
;
◊◊w x
}
ÿÿ 
private
⁄⁄ 
async
⁄⁄ 
Task
⁄⁄ -
RequireAddMemberPermissionAsync
⁄⁄ 6
(
⁄⁄6 7
int
⁄⁄7 :
callerUserId
⁄⁄; G
,
⁄⁄G H
int
⁄⁄I L
workspaceId
⁄⁄M X
,
⁄⁄X Y
CancellationToken
⁄⁄Z k
ct
⁄⁄l n
)
⁄⁄n o
{
€€ 
if
‹‹ 

(
‹‹ 
await
‹‹ 9
+WorkspaceMemberHasOrOrgOwnerPermissionAsync
‹‹ =
(
‹‹= >
callerUserId
‹‹> J
,
‹‹J K
workspaceId
‹‹L W
,
‹‹W X
$str
‹‹Y i
,
‹‹i j
ct
‹‹k m
)
‹‹m n
)
‹‹n o
return
›› 
;
›› 
if
ﬂﬂ 

(
ﬂﬂ 
await
ﬂﬂ /
!IsOrgWorkspaceMembersManagerAsync
ﬂﬂ 3
(
ﬂﬂ3 4
callerUserId
ﬂﬂ4 @
,
ﬂﬂ@ A
workspaceId
ﬂﬂB M
,
ﬂﬂM N
ct
ﬂﬂO Q
)
ﬂﬂQ R
)
ﬂﬂR S
return
‡‡ 
;
‡‡ 
var
‚‚ 
	workspace
‚‚ 
=
‚‚ 
await
‚‚ !
workspaceRepository
‚‚ 1
.
‚‚1 2
GetByIdAsync
‚‚2 >
(
‚‚> ?
workspaceId
‚‚? J
,
‚‚J K
ct
‚‚L N
)
‚‚N O
??
„„ 
throw
„„ 
new
„„ 
AppException
„„ %
(
„„% &
$str
„„& ;
,
„„; <
$num
„„= @
,
„„@ A
$str
„„B X
)
„„X Y
;
„„Y Z
_
ÂÂ 	
=
ÂÂ
 
await
ÂÂ !
orgMemberRepository
ÂÂ %
.
ÂÂ% &
GetAsync
ÂÂ& .
(
ÂÂ. /
callerUserId
ÂÂ/ ;
,
ÂÂ; <
	workspace
ÂÂ= F
.
ÂÂF G
OrganizationId
ÂÂG U
,
ÂÂU V
ct
ÂÂW Y
)
ÂÂY Z
??
ÊÊ 
throw
ÊÊ 
new
ÊÊ 
AppException
ÊÊ %
(
ÊÊ% &
$str
ÊÊ& 6
,
ÊÊ6 7
$num
ÊÊ8 ;
,
ÊÊ; <
$str
ÊÊ= i
)
ÊÊi j
;
ÊÊj k
throw
ËË 
new
ËË 
AppException
ËË 
(
ËË 
$str
ËË 2
,
ËË2 3
$num
ËË4 7
,
ËË7 8
$str
ËË9 }
)
ËË} ~
;
ËË~ 
}
ÈÈ 
private
ÎÎ 
async
ÎÎ 
Task
ÎÎ 0
"RequireRemoveMemberPermissionAsync
ÎÎ 9
(
ÎÎ9 :
int
ÎÎ: =
callerUserId
ÎÎ> J
,
ÎÎJ K
int
ÎÎL O
workspaceId
ÎÎP [
,
ÎÎ[ \
CancellationToken
ÎÎ] n
ct
ÎÎo q
)
ÎÎq r
{
ÏÏ 
if
ÌÌ 

(
ÌÌ 
await
ÌÌ 9
+WorkspaceMemberHasOrOrgOwnerPermissionAsync
ÌÌ =
(
ÌÌ= >
callerUserId
ÌÌ> J
,
ÌÌJ K
workspaceId
ÌÌL W
,
ÌÌW X
$str
ÌÌY l
,
ÌÌl m
ct
ÌÌn p
)
ÌÌp q
)
ÌÌq r
return
ÓÓ 
;
ÓÓ 
if
 

(
 
await
 /
!IsOrgWorkspaceMembersManagerAsync
 3
(
3 4
callerUserId
4 @
,
@ A
workspaceId
B M
,
M N
ct
O Q
)
Q R
)
R S
return
ÒÒ 
;
ÒÒ 
var
ÛÛ 
	workspace
ÛÛ 
=
ÛÛ 
await
ÛÛ !
workspaceRepository
ÛÛ 1
.
ÛÛ1 2
GetByIdAsync
ÛÛ2 >
(
ÛÛ> ?
workspaceId
ÛÛ? J
,
ÛÛJ K
ct
ÛÛL N
)
ÛÛN O
??
ÙÙ 
throw
ÙÙ 
new
ÙÙ 
AppException
ÙÙ %
(
ÙÙ% &
$str
ÙÙ& ;
,
ÙÙ; <
$num
ÙÙ= @
,
ÙÙ@ A
$str
ÙÙB X
)
ÙÙX Y
;
ÙÙY Z
_
ˆˆ 	
=
ˆˆ
 
await
ˆˆ !
orgMemberRepository
ˆˆ %
.
ˆˆ% &
GetAsync
ˆˆ& .
(
ˆˆ. /
callerUserId
ˆˆ/ ;
,
ˆˆ; <
	workspace
ˆˆ= F
.
ˆˆF G
OrganizationId
ˆˆG U
,
ˆˆU V
ct
ˆˆW Y
)
ˆˆY Z
??
˜˜ 
throw
˜˜ 
new
˜˜ 
AppException
˜˜ %
(
˜˜% &
$str
˜˜& 6
,
˜˜6 7
$num
˜˜8 ;
,
˜˜; <
$str
˜˜= i
)
˜˜i j
;
˜˜j k
throw
˘˘ 
new
˘˘ 
AppException
˘˘ 
(
˘˘ 
$str
˘˘ 2
,
˘˘2 3
$num
˘˘4 7
,
˘˘7 8
$str˘˘9 Ä
)˘˘Ä Å
;˘˘Å Ç
}
˙˙ 
}˚˚ åb
oC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Services\WorkspaceAccessEvaluator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
Services$ ,
;, -
public		 
sealed		 
class		 $
WorkspaceAccessEvaluator		 ,
(		, -(
IUserRoleWorkspaceRepository

  
memberRepository

! 1
,

1 2+
IUserRoleOrganizationRepository #
orgMemberRepository$ 7
,7 8 
IWorkspaceRepository 
workspaceRepository ,
,, -!
IPermissionRepository 
?  
permissionRepository /
=0 1
null2 6
)6 7
:8 9%
IWorkspaceAccessEvaluator: S
{ 
public 

const 
string 
OrgOwnerRoleName (
=) *
$str+ 6
;6 7
public 

async 
Task 
< 
bool 
> &
IsOrgOwnerOfWorkspaceAsync 6
(6 7
int7 :
userId; A
,A B
intC F
workspaceIdG R
,R S
CancellationTokenT e
ctf h
=i j
defaultk r
)r s
{ 
var 
	workspace 
= 
await 
workspaceRepository 1
.1 2
GetByIdAsync2 >
(> ?
workspaceId? J
,J K
ctL N
)N O
;O P
if 

( 
	workspace 
is 
null 
) 
return 
false 
; 
var 
orgM 
= 
await 
orgMemberRepository ,
., -
GetAsync- 5
(5 6
userId6 <
,< =
	workspace> G
.G H
OrganizationIdH V
,V W
ctX Z
)Z [
;[ \
if 

( 
orgM 
? 
. 
Role 
is 
null 
) 
return 
false 
; 
if 

( 
string 
. 
Equals 
( 
orgM 
. 
Role #
.# $
Name$ (
,( )
OrgOwnerRoleName* :
,: ;
StringComparison< L
.L M
OrdinalM T
)T U
)U V
return 
true 
; 
var 
allPermissionNames 
=  
await! &,
 GetAllActivePermissionNamesAsync' G
(G H
ctH J
)J K
;K L
return #
RolePermissionEvaluator &
.& '
HasAllPermissions' 8
(8 9
orgM9 =
.= >
Role> B
,B C
allPermissionNamesD V
)V W
;W X
}   
public"" 

async"" 
Task"" )
EnsureCanAccessWorkspaceAsync"" 3
(""3 4
int""4 7
userId""8 >
,""> ?
int""@ C
workspaceId""D O
,""O P
CancellationToken""Q b
ct""c e
=""f g
default""h o
)""o p
{## 
var$$ 
m$$ 
=$$ 
await$$ 
memberRepository$$ &
.$$& '
GetAsync$$' /
($$/ 0
userId$$0 6
,$$6 7
workspaceId$$8 C
,$$C D
ct$$E G
)$$G H
;$$H I
if%% 

(%% 
m%% 
is%% 
not%% 
null%% 
)%% 
return&& 
;&& 
if'' 

('' 
await'' &
IsOrgOwnerOfWorkspaceAsync'' ,
('', -
userId''- 3
,''3 4
workspaceId''5 @
,''@ A
ct''B D
)''D E
)''E F
return(( 
;(( 
throw)) 
new)) 
AppException)) 
()) 
$str)) .
,)). /
$num))0 3
,))3 4
$str))5 ^
)))^ _
;))_ `
}** 
public,, 

async,, 
Task,, 
<,, 
bool,, 
>,, '
HasWorkspacePermissionAsync,, 7
(,,7 8
int-- 
userId-- 
,-- 
int.. 
workspaceId.. 
,.. 
string// 
permissionName// 
,// 
CancellationToken00 
ct00 
=00 
default00 &
)00& '
{11 
await22 )
EnsureCanAccessWorkspaceAsync22 +
(22+ ,
userId22, 2
,222 3
workspaceId224 ?
,22? @
ct22A C
)22C D
;22D E
if44 

(44 
await44 &
IsOrgOwnerOfWorkspaceAsync44 ,
(44, -
userId44- 3
,443 4
workspaceId445 @
,44@ A
ct44B D
)44D E
)44E F
return55 
true55 
;55 
var77 
m77 
=77 
await77 
memberRepository77 &
.77& '
GetAsync77' /
(77/ 0
userId770 6
,776 7
workspaceId778 C
,77C D
ct77E G
)77G H
;77H I
return88 
m88 
?88 
.88 
Role88 
?88 
.88 
RolePermissions88 '
.99 
Any99 
(99 
rp99 
=>99 
string99 
.99 
Equals99 $
(99$ %
rp99% '
.99' (

Permission99( 2
?992 3
.993 4
Name994 8
,998 9
permissionName99: H
,99H I
StringComparison99J Z
.99Z [
Ordinal99[ b
)99b c
)99c d
==99e g
true99h l
;99l m
}:: 
public<< 

async<< 
Task<< 
<<< 
IReadOnlyList<< #
<<<# $
string<<$ *
><<* +
><<+ ,5
)GetEffectiveWorkspacePermissionNamesAsync<<- V
(<<V W
int== 
userId== 
,== 
int>> 
workspaceId>> 
,>> 
CancellationToken?? 
ct?? 
=?? 
default?? &
)??& '
{@@ 
awaitAA )
EnsureCanAccessWorkspaceAsyncAA +
(AA+ ,
userIdAA, 2
,AA2 3
workspaceIdAA4 ?
,AA? @
ctAAA C
)AAC D
;AAD E
ifCC 

(CC 
awaitCC &
IsOrgOwnerOfWorkspaceAsyncCC ,
(CC, -
userIdCC- 3
,CC3 4
workspaceIdCC5 @
,CC@ A
ctCCB D
)CCD E
)CCE F
returnDD  
WorkspacePermissionsDD '
.DD' ("
FullWorkspaceAuthorityDD( >
.EE 
OrderByEE 
(EE 
pEE 
=>EE 
pEE 
,EE  
StringComparerEE! /
.EE/ 0
OrdinalEE0 7
)EE7 8
.FF 
ToListFF 
(FF 
)FF 
;FF 
varHH 
mHH 
=HH 
awaitHH 
memberRepositoryHH &
.HH& '
GetAsyncHH' /
(HH/ 0
userIdHH0 6
,HH6 7
workspaceIdHH8 C
,HHC D
ctHHE G
)HHG H
;HHH I
returnII "
MapRolePermissionNamesII %
(II% &
mII& '
)II' (
;II( )
}JJ 
privateLL 
asyncLL 
TaskLL 
<LL 
IReadOnlySetLL #
<LL# $
stringLL$ *
>LL* +
>LL+ ,,
 GetAllActivePermissionNamesAsyncLL- M
(LLM N
CancellationTokenLLN _
ctLL` b
)LLb c
{MM 
ifNN 

(NN  
permissionRepositoryNN  
isNN! #
nullNN$ (
)NN( )
{OO 	
varPP 
fallbackPP 
=PP 
newPP 
HashSetPP &
<PP& '
stringPP' -
>PP- .
(PP. /
StringComparerPP/ =
.PP= >
OrdinalPP> E
)PPE F
{QQ #
OrganizationPermissionsRR '
.RR' (
ManageOrgSettingsRR( 9
,RR9 :#
OrganizationPermissionsSS '
.SS' (
InviteToOrgSS( 3
,SS3 4#
OrganizationPermissionsTT '
.TT' (
ManageJoinRequestsTT( :
,TT: ;#
OrganizationPermissionsUU '
.UU' (
RemoveOrgMembersUU( 8
,UU8 9#
OrganizationPermissionsVV '
.VV' (
AssignOrgRolesVV( 6
,VV6 7#
OrganizationPermissionsWW '
.WW' (
ManageOrgRolesWW( 6
,WW6 7#
OrganizationPermissionsXX '
.XX' (
CreateWorkspacesXX( 8
,XX8 9#
OrganizationPermissionsYY '
.YY' (%
ManageOrgWorkspaceMembersYY( A
,YYA B#
OrganizationPermissionsZZ '
.ZZ' (
CreateOrgUsersZZ( 6
,ZZ6 7#
OrganizationPermissions[[ '
.[[' ($
EditOtherOrgUsersProfile[[( @
,[[@ A#
OrganizationPermissions\\ '
.\\' (
DeleteOrgUsers\\( 6
}]] 
;]] 
foreach^^ 
(^^ 
var^^ 
permissionName^^ '
in^^( * 
WorkspacePermissions^^+ ?
.^^? @"
FullWorkspaceAuthority^^@ V
)^^V W
fallback__ 
.__ 
Add__ 
(__ 
permissionName__ +
)__+ ,
;__, -
return`` 
fallback`` 
;`` 
}aa 	
varcc 
allPermissionscc 
=cc 
awaitcc " 
permissionRepositorycc# 7
.cc7 8
GetAllAsynccc8 C
(ccC D
ctccD F
)ccF G
;ccG H
returndd 
allPermissionsdd 
.ee 
Whereee 
(ee 
pee 
=>ee 
!ee 
pee 
.ee 

IsArchivedee %
)ee% &
.ff 
Selectff 
(ff 
pff 
=>ff 
pff 
.ff 
Nameff 
)ff  
.gg 
Wheregg 
(gg 
ngg 
=>gg 
!gg 
stringgg 
.gg  
IsNullOrWhiteSpacegg  2
(gg2 3
ngg3 4
)gg4 5
)gg5 6
.hh 
	ToHashSethh 
(hh 
StringComparerhh %
.hh% &
Ordinalhh& -
)hh- .
;hh. /
}ii 
privatekk 
statickk 
Listkk 
<kk 
stringkk 
>kk "
MapRolePermissionNameskk  6
(kk6 7
UserRoleWorkspacekk7 H
?kkH I

membershipkkJ T
)kkT U
{ll 
ifmm 

(mm 

membershipmm 
?mm 
.mm 
Rolemm 
?mm 
.mm 
RolePermissionsmm -
ismm. 0
nullmm1 5
)mm5 6
returnnn 
[nn 
]nn 
;nn 
returnpp 

membershippp 
.pp 
Rolepp 
.pp 
RolePermissionspp .
.qq 
Selectqq 
(qq 
rpqq 
=>qq 
rpqq 
.qq 

Permissionqq '
?qq' (
.qq( )
Nameqq) -
)qq- .
.rr 
Whererr 
(rr 
nrr 
=>rr 
!rr 
stringrr 
.rr  
IsNullOrEmptyrr  -
(rr- .
nrr. /
)rr/ 0
)rr0 1
.ss 
Distinctss 
(ss 
StringComparerss $
.ss$ %
Ordinalss% ,
)ss, -
.tt 
OrderBytt 
(tt 
ntt 
=>tt 
ntt 
,tt 
StringComparertt +
.tt+ ,
Ordinaltt, 3
)tt3 4
.uu 
Castuu 
<uu 
stringuu 
>uu 
(uu 
)uu 
.vv 
ToListvv 
(vv 
)vv 
;vv 
}ww 
}xx ¨Æ
bC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Services\RoleService.cs
	namespace

 	
Relativa


 
.

 
Core

 
.

 
Application

 #
.

# $
Services

$ ,
;

, -
public 
sealed 
class 
RoleService 
(  $
IWorkspaceRoleRepository 
roleRepository +
,+ ,!
IPermissionRepository  
permissionRepository .
,. /%
IWorkspaceAccessEvaluator 
workspaceAccess -
,- .

IValidator 
< 
CreateRoleRequest  
>  !
createValidator" 1
,1 2
IOutboxWriter 
? 
auditOutboxWriter $
=% &
null' +
)+ ,
:- .
IRoleService/ ;
{ 
public 

async 
Task 
< 
List 
< 
RoleDto "
>" #
># $
GetByWorkspaceAsync% 8
(8 9
int9 <
workspaceId= H
,H I
intJ M
userIdN T
,T U
CancellationTokenV g
cth j
=k l
defaultm t
)t u
{ 
await 
workspaceAccess 
. )
EnsureCanAccessWorkspaceAsync ;
(; <
userId< B
,B C
workspaceIdD O
,O P
ctQ S
)S T
;T U
var 
roles 
= 
await 
roleRepository (
.( )!
GetByWorkspaceIdAsync) >
(> ?
workspaceId? J
,J K
ctL N
)N O
;O P
return 
roles 
. 
Where 
( 
r 
=> 
! 
r 
. 

IsArchived %
)% &
. 
Select 
( 
r 
=> 
new 
RoleDto $
($ %
r 
. 
Id 
, 
r 
. 
Name 
, 
r 
. 
DisplayName 
??  
DisplayNameHelper! 2
.2 3
Humanize3 ;
(; <
r< =
.= >
Name> B
)B C
,C D
r 
. 
WorkspaceId 
is  
null! %
,% &
r 
. 
RolePermissions !
.! "
Select" (
(( )
rp) +
=>, .
new/ 2
PermissionDto3 @
(@ A
rp   
.   

Permission   !
.  ! "
Id  " $
,  $ %
rp!! 
.!! 

Permission!! !
.!!! "
Name!!" &
,!!& '
rp"" 
."" 

Permission"" !
.""! "
DisplayName""" -
??"". 0
DisplayNameHelper""1 B
.""B C
Humanize""C K
(""K L
rp""L N
.""N O

Permission""O Y
.""Y Z
Name""Z ^
)""^ _
)""_ `
)""` a
.""a b
ToList""b h
(""h i
)""i j
)""j k
)""k l
.## 
ToList## 
(## 
)## 
;## 
}$$ 
public&& 

async&& 
Task&& 
<&& 
RoleDto&& 
>&& 
CreateAsync&& *
(&&* +
int&&+ .
workspaceId&&/ :
,&&: ;
int&&< ?
userId&&@ F
,&&F G
CreateRoleRequest&&H Y
request&&Z a
,&&a b
CancellationToken&&c t
ct&&u w
=&&x y
default	&&z Å
)
&&Å Ç
{'' 
await(( 
createValidator(( 
.(( !
ValidateAndThrowAsync(( 3
(((3 4
request((4 ;
,((; <
ct((= ?
)((? @
;((@ A
if)) 

()) 
!)) 
await)) 
workspaceAccess)) "
.))" #'
HasWorkspacePermissionAsync))# >
())> ?
userId))? E
,))E F
workspaceId))G R
,))R S
$str))T e
,))e f
ct))g i
)))i j
)))j k
throw** 
new** 
AppException** "
(**" #
$str**# 6
,**6 7
$num**8 ;
,**; <
$str	**= Ç
)
**Ç É
;
**É Ñ
var,, 
permissions,, 
=,, 
await,,  
permissionRepository,,  4
.,,4 5
GetByIdsAsync,,5 B
(,,B C
request,,C J
.,,J K
PermissionIds,,K X
,,,X Y
ct,,Z \
),,\ ]
;,,] ^
if-- 

(-- 
permissions-- 
.-- 
Count-- 
!=--  
request--! (
.--( )
PermissionIds--) 6
.--6 7
Count--7 <
)--< =
throw.. 
new.. 
AppException.. "
(.." #
$str..# ;
,..; <
$num..= @
,..@ A
$str..B k
)..k l
;..l m
var00 
role00 
=00 
new00 
WorkspaceRole00 $
{11 	
Name22 
=22 
request22 
.22 
Name22 
,22  
WorkspaceId33 
=33 
workspaceId33 %
,33% &

IsArchived44 
=44 
false44 
}55 	
;55	 

await77 
roleRepository77 
.77 
AddAsync77 %
(77% &
role77& *
,77* +
ct77, .
)77. /
;77/ 0
foreach99 
(99 
var99 
perm99 
in99 
permissions99 (
)99( )
{:: 	
role;; 
.;; 
RolePermissions;;  
.;;  !
Add;;! $
(;;$ %
new;;% (#
WorkspaceRolePermission;;) @
{<< 
WsRoleId== 
=== 
role== 
.==  
Id==  "
,==" #
PermissionId>> 
=>> 
perm>> #
.>># $
Id>>$ &
}?? 
)?? 
;?? 
}@@ 	
awaitBB 
roleRepositoryBB 
.BB 
UpdateAsyncBB (
(BB( )
roleBB) -
,BB- .
ctBB/ 1
)BB1 2
;BB2 3
ifCC 

(CC 
auditOutboxWriterCC 
isCC  
notCC! $
nullCC% )
)CC) *
{DD 	
awaitEE 
auditOutboxWriterEE #
.EE# $
EnqueueAuditAsyncEE$ 5
(EE5 6
newFF 
AuditEventContractFF &
(FF& '
EventIdGG 
:GG 
GuidGG !
.GG! "
NewGuidGG" )
(GG) *
)GG* +
,GG+ ,
SchemaVersionHH !
:HH! "
$numHH# $
,HH$ %
OccurredAtUtcII !
:II! "
DateTimeOffsetII# 1
.II1 2
UtcNowII2 8
,II8 9
SourceServiceJJ !
:JJ! "
$strJJ# )
,JJ) *
ActorUserIdKK 
:KK  
userIdKK! '
,KK' (

AuditScopeLL 
:LL 
AuditRoutingLL  ,
.LL, -
ScopeWorkspaceLL- ;
,LL; <
TargetIdMM 
:MM 
workspaceIdMM )
,MM) *
ActionNN 
:NN 
$strNN 4
,NN4 5
	FieldNameOO 
:OO 
$strOO 0
,OO0 1

EntityTypePP 
:PP 
nullPP  $
,PP$ %
OldValueJsonQQ  
:QQ  !
nullQQ" &
,QQ& '
NewValueJsonRR  
:RR  !
SystemRR" (
.RR( )
TextRR) -
.RR- .
JsonRR. 2
.RR2 3
JsonSerializerRR3 A
.RRA B
	SerializeRRB K
(RRK L
newRRL O
{RRP Q
roleRRR V
.RRV W
IdRRW Y
,RRY Z
roleRR[ _
.RR_ `
NameRR` d
,RRd e
requestRRf m
.RRm n
PermissionIdsRRn {
}RR| }
)RR} ~
)RR~ 
,	RR Ä
ctSS 
)SS 
;SS 
}TT 	
returnVV 
newVV 
RoleDtoVV 
(VV 
roleWW 
.WW 
IdWW 
,WW 
roleXX 
.XX 
NameXX 
,XX 
roleYY 
.YY 
DisplayNameYY 
??YY 
DisplayNameHelperYY  1
.YY1 2
HumanizeYY2 :
(YY: ;
roleYY; ?
.YY? @
NameYY@ D
)YYD E
,YYE F
falseZZ 
,ZZ 
permissions[[ 
.[[ 
Select[[ 
([[ 
p[[  
=>[[! #
new[[$ '
PermissionDto[[( 5
([[5 6
p[[6 7
.[[7 8
Id[[8 :
,[[: ;
p[[< =
.[[= >
Name[[> B
,[[B C
p[[D E
.[[E F
DisplayName[[F Q
??[[R T
DisplayNameHelper[[U f
.[[f g
Humanize[[g o
([[o p
p[[p q
.[[q r
Name[[r v
)[[v w
)[[w x
)[[x y
.[[y z
ToList	[[z Ä
(
[[Ä Å
)
[[Å Ç
)
[[Ç É
;
[[É Ñ
}\\ 
public^^ 

async^^ 
Task^^ 
UpdateAsync^^ !
(^^! "
int^^" %
workspaceId^^& 1
,^^1 2
int^^3 6
roleId^^7 =
,^^= >
int^^? B
userId^^C I
,^^I J
UpdateRoleRequest^^K \
request^^] d
,^^d e
CancellationToken^^f w
ct^^x z
=^^{ |
default	^^} Ñ
)
^^Ñ Ö
{__ 
if`` 

(`` 
!`` 
await`` 
workspaceAccess`` "
.``" #'
HasWorkspacePermissionAsync``# >
(``> ?
userId``? E
,``E F
workspaceId``G R
,``R S
$str``T e
,``e f
ct``g i
)``i j
)``j k
throwaa 
newaa 
AppExceptionaa "
(aa" #
$straa# 6
,aa6 7
$numaa8 ;
,aa; <
$str	aa= Ç
)
aaÇ É
;
aaÉ Ñ
varcc 
rolecc 
=cc 
awaitcc 
roleRepositorycc '
.cc' (
GetByIdAsynccc( 4
(cc4 5
roleIdcc5 ;
,cc; <
ctcc= ?
)cc? @
??dd 
throwdd 
newdd 
AppExceptiondd %
(dd% &
$strdd& 6
,dd6 7
$numdd8 ;
,dd; <
$strdd= N
)ddN O
;ddO P
ifff 

(ff 
roleff 
.ff 
WorkspaceIdff 
isff 
nullff  $
)ff$ %
throwgg 
newgg 
AppExceptiongg "
(gg" #
$strgg# :
,gg: ;
$numgg< ?
,gg? @
$strggA c
)ggc d
;ggd e
ifii 

(ii 
roleii 
.ii 
WorkspaceIdii 
!=ii 
workspaceIdii  +
)ii+ ,
throwjj 
newjj 
AppExceptionjj "
(jj" #
$strjj# :
,jj: ;
$numjj< ?
,jj? @
$strjjA d
)jjd e
;jje f
ifll 

(ll 
requestll 
.ll 
Namell 
isll 
notll 
nullll  $
)ll$ %
rolemm 
.mm 
Namemm 
=mm 
requestmm 
.mm  
Namemm  $
;mm$ %
ifoo 

(oo 
requestoo 
.oo 
PermissionIdsoo !
isoo" $
notoo% (
nulloo) -
)oo- .
{pp 	
varqq 
permissionsqq 
=qq 
awaitqq # 
permissionRepositoryqq$ 8
.qq8 9
GetByIdsAsyncqq9 F
(qqF G
requestqqG N
.qqN O
PermissionIdsqqO \
,qq\ ]
ctqq^ `
)qq` a
;qqa b
ifrr 
(rr 
permissionsrr 
.rr 
Countrr !
!=rr" $
requestrr% ,
.rr, -
PermissionIdsrr- :
.rr: ;
Countrr; @
)rr@ A
throwss 
newss 
AppExceptionss &
(ss& '
$strss' ?
,ss? @
$numssA D
,ssD E
$strssF o
)sso p
;ssp q
roleuu 
.uu 
RolePermissionsuu  
.uu  !
Clearuu! &
(uu& '
)uu' (
;uu( )
foreachvv 
(vv 
varvv 
permvv 
invv  
permissionsvv! ,
)vv, -
{ww 
rolexx 
.xx 
RolePermissionsxx $
.xx$ %
Addxx% (
(xx( )
newxx) ,#
WorkspaceRolePermissionxx- D
{yy 
WsRoleIdzz 
=zz 
rolezz #
.zz# $
Idzz$ &
,zz& '
PermissionId{{  
={{! "
perm{{# '
.{{' (
Id{{( *
}|| 
)|| 
;|| 
}}} 
}~~ 	
await
ÄÄ 
roleRepository
ÄÄ 
.
ÄÄ 
UpdateAsync
ÄÄ (
(
ÄÄ( )
role
ÄÄ) -
,
ÄÄ- .
ct
ÄÄ/ 1
)
ÄÄ1 2
;
ÄÄ2 3
if
ÅÅ 

(
ÅÅ 
auditOutboxWriter
ÅÅ 
is
ÅÅ  
not
ÅÅ! $
null
ÅÅ% )
)
ÅÅ) *
{
ÇÇ 	
await
ÉÉ 
auditOutboxWriter
ÉÉ #
.
ÉÉ# $
EnqueueAuditAsync
ÉÉ$ 5
(
ÉÉ5 6
new
ÑÑ  
AuditEventContract
ÑÑ &
(
ÑÑ& '
EventId
ÖÖ 
:
ÖÖ 
Guid
ÖÖ !
.
ÖÖ! "
NewGuid
ÖÖ" )
(
ÖÖ) *
)
ÖÖ* +
,
ÖÖ+ ,
SchemaVersion
ÜÜ !
:
ÜÜ! "
$num
ÜÜ# $
,
ÜÜ$ %
OccurredAtUtc
áá !
:
áá! "
DateTimeOffset
áá# 1
.
áá1 2
UtcNow
áá2 8
,
áá8 9
SourceService
àà !
:
àà! "
$str
àà# )
,
àà) *
ActorUserId
ââ 
:
ââ  
userId
ââ! '
,
ââ' (

AuditScope
ää 
:
ää 
AuditRouting
ää  ,
.
ää, -
ScopeWorkspace
ää- ;
,
ää; <
TargetId
ãã 
:
ãã 
workspaceId
ãã )
,
ãã) *
Action
åå 
:
åå 
$str
åå 4
,
åå4 5
	FieldName
çç 
:
çç 
$str
çç 0
,
çç0 1

EntityType
éé 
:
éé 
null
éé  $
,
éé$ %
OldValueJson
èè  
:
èè  !
null
èè" &
,
èè& '
NewValueJson
êê  
:
êê  !
System
êê" (
.
êê( )
Text
êê) -
.
êê- .
Json
êê. 2
.
êê2 3
JsonSerializer
êê3 A
.
êêA B
	Serialize
êêB K
(
êêK L
new
êêL O
{
êêP Q
role
êêR V
.
êêV W
Id
êêW Y
,
êêY Z
role
êê[ _
.
êê_ `
Name
êê` d
,
êêd e
request
êêf m
.
êêm n
PermissionIds
êên {
}
êê| }
)
êê} ~
)
êê~ 
,êê Ä
ct
ëë 
)
ëë 
;
ëë 
}
íí 	
}
ìì 
public
ïï 

async
ïï 
Task
ïï 
ArchiveAsync
ïï "
(
ïï" #
int
ïï# &
workspaceId
ïï' 2
,
ïï2 3
int
ïï4 7
roleId
ïï8 >
,
ïï> ?
int
ïï@ C
userId
ïïD J
,
ïïJ K
CancellationToken
ïïL ]
ct
ïï^ `
=
ïïa b
default
ïïc j
)
ïïj k
{
ññ 
if
óó 

(
óó 
!
óó 
await
óó 
workspaceAccess
óó "
.
óó" #)
HasWorkspacePermissionAsync
óó# >
(
óó> ?
userId
óó? E
,
óóE F
workspaceId
óóG R
,
óóR S
$str
óóT e
,
óóe f
ct
óóg i
)
óói j
)
óój k
throw
òò 
new
òò 
AppException
òò "
(
òò" #
$str
òò# 6
,
òò6 7
$num
òò8 ;
,
òò; <
$stròò= Ç
)òòÇ É
;òòÉ Ñ
var
öö 
role
öö 
=
öö 
await
öö 
roleRepository
öö '
.
öö' (
GetByIdAsync
öö( 4
(
öö4 5
roleId
öö5 ;
,
öö; <
ct
öö= ?
)
öö? @
??
õõ 
throw
õõ 
new
õõ 
AppException
õõ %
(
õõ% &
$str
õõ& 6
,
õõ6 7
$num
õõ8 ;
,
õõ; <
$str
õõ= N
)
õõN O
;
õõO P
if
ùù 

(
ùù 
role
ùù 
.
ùù 
WorkspaceId
ùù 
is
ùù 
null
ùù  $
)
ùù$ %
throw
ûû 
new
ûû 
AppException
ûû "
(
ûû" #
$str
ûû# <
,
ûû< =
$num
ûû> A
,
ûûA B
$str
ûûC d
)
ûûd e
;
ûûe f
if
†† 

(
†† 
role
†† 
.
†† 
WorkspaceId
†† 
!=
†† 
workspaceId
††  +
)
††+ ,
throw
°° 
new
°° 
AppException
°° "
(
°°" #
$str
°°# :
,
°°: ;
$num
°°< ?
,
°°? @
$str
°°A d
)
°°d e
;
°°e f
role
££ 
.
££ 

IsArchived
££ 
=
££ 
true
££ 
;
££ 
await
§§ 
roleRepository
§§ 
.
§§ 
UpdateAsync
§§ (
(
§§( )
role
§§) -
,
§§- .
ct
§§/ 1
)
§§1 2
;
§§2 3
if
•• 

(
•• 
auditOutboxWriter
•• 
is
••  
not
••! $
null
••% )
)
••) *
{
¶¶ 	
await
ßß 
auditOutboxWriter
ßß #
.
ßß# $
EnqueueAuditAsync
ßß$ 5
(
ßß5 6
new
®®  
AuditEventContract
®® &
(
®®& '
EventId
©© 
:
©© 
Guid
©© !
.
©©! "
NewGuid
©©" )
(
©©) *
)
©©* +
,
©©+ ,
SchemaVersion
™™ !
:
™™! "
$num
™™# $
,
™™$ %
OccurredAtUtc
´´ !
:
´´! "
DateTimeOffset
´´# 1
.
´´1 2
UtcNow
´´2 8
,
´´8 9
SourceService
¨¨ !
:
¨¨! "
$str
¨¨# )
,
¨¨) *
ActorUserId
≠≠ 
:
≠≠  
userId
≠≠! '
,
≠≠' (

AuditScope
ÆÆ 
:
ÆÆ 
AuditRouting
ÆÆ  ,
.
ÆÆ, -
ScopeWorkspace
ÆÆ- ;
,
ÆÆ; <
TargetId
ØØ 
:
ØØ 
workspaceId
ØØ )
,
ØØ) *
Action
∞∞ 
:
∞∞ 
$str
∞∞ 5
,
∞∞5 6
	FieldName
±± 
:
±± 
$str
±± <
,
±±< =

EntityType
≤≤ 
:
≤≤ 
null
≤≤  $
,
≤≤$ %
OldValueJson
≥≥  
:
≥≥  !
System
≥≥" (
.
≥≥( )
Text
≥≥) -
.
≥≥- .
Json
≥≥. 2
.
≥≥2 3
JsonSerializer
≥≥3 A
.
≥≥A B
	Serialize
≥≥B K
(
≥≥K L
new
≥≥L O
{
≥≥P Q

IsArchived
≥≥R \
=
≥≥] ^
false
≥≥_ d
,
≥≥d e
role
≥≥f j
.
≥≥j k
Id
≥≥k m
}
≥≥n o
)
≥≥o p
,
≥≥p q
NewValueJson
¥¥  
:
¥¥  !
System
¥¥" (
.
¥¥( )
Text
¥¥) -
.
¥¥- .
Json
¥¥. 2
.
¥¥2 3
JsonSerializer
¥¥3 A
.
¥¥A B
	Serialize
¥¥B K
(
¥¥K L
new
¥¥L O
{
¥¥P Q

IsArchived
¥¥R \
=
¥¥] ^
true
¥¥_ c
,
¥¥c d
role
¥¥e i
.
¥¥i j
Id
¥¥j l
}
¥¥m n
)
¥¥n o
)
¥¥o p
,
¥¥p q
ct
µµ 
)
µµ 
;
µµ 
}
∂∂ 	
}
∑∑ 
public
ππ 

async
ππ 
Task
ππ 
<
ππ 
List
ππ 
<
ππ 
PermissionDto
ππ (
>
ππ( )
>
ππ) *$
GetAllPermissionsAsync
ππ+ A
(
ππA B
CancellationToken
ππB S
ct
ππT V
=
ππW X
default
ππY `
)
ππ` a
{
∫∫ 
var
ªª 
permissions
ªª 
=
ªª 
await
ªª "
permissionRepository
ªª  4
.
ªª4 5
GetAllAsync
ªª5 @
(
ªª@ A
ct
ªªA C
)
ªªC D
;
ªªD E
return
ºº 
permissions
ºº 
.
ΩΩ 
Where
ΩΩ 
(
ΩΩ 
p
ΩΩ 
=>
ΩΩ 
!
ΩΩ 
p
ΩΩ 
.
ΩΩ 

IsArchived
ΩΩ %
)
ΩΩ% &
.
ææ 
Select
ææ 
(
ææ 
p
ææ 
=>
ææ 
new
ææ 
PermissionDto
ææ *
(
ææ* +
p
ææ+ ,
.
ææ, -
Id
ææ- /
,
ææ/ 0
p
ææ1 2
.
ææ2 3
Name
ææ3 7
,
ææ7 8
p
ææ9 :
.
ææ: ;
DisplayName
ææ; F
??
ææG I
DisplayNameHelper
ææJ [
.
ææ[ \
Humanize
ææ\ d
(
ææd e
p
ææe f
.
ææf g
Name
ææg k
)
ææk l
)
ææl m
)
ææm n
.
øø 
ToList
øø 
(
øø 
)
øø 
;
øø 
}
¿¿ 
}¬¬ ø®
eC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Services\OrgRoleService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
Services$ ,
;, -
public 
sealed 
class 
OrgRoleService "
(" #'
IOrganizationRoleRepository 
orgRoleRepository  1
,1 2!
IPermissionRepository  
permissionRepository .
,. /+
IUserRoleOrganizationRepository #
orgMemberRepository$ 7
,7 8

IValidator 
<  
CreateOrgRoleRequest #
># $
createValidator% 4
,4 5

IValidator 
<  
UpdateOrgRoleRequest #
># $
updateValidator% 4
,4 5
IOutboxWriter 
? 
auditOutboxWriter $
=% &
null' +
)+ ,
:- .
IOrgRoleService/ >
{ 
public 

async 
Task 
< 
List 
< 

OrgRoleDto %
>% &
>& '"
GetByOrganizationAsync( >
(> ?
int? B
organizationIdC Q
,Q R
intS V
userIdW ]
,] ^
CancellationToken_ p
ctq s
=t u
defaultv }
)} ~
{ 
await 
	OrgAccess 
. 
RequireMembership )
() *
orgMemberRepository* =
,= >
userId? E
,E F
organizationIdG U
,U V
ctW Y
)Y Z
;Z [
var 
roles 
= 
await 
orgRoleRepository +
.+ ,$
GetByOrganizationIdAsync, D
(D E
organizationIdE S
,S T
ctU W
)W X
;X Y
return 
roles 
. 
Where 
( 
r 
=> 
! 
r 
. 

IsArchived %
)% &
. 
Select 
( 
r 
=> 
new 

OrgRoleDto '
(' (
r 
. 
Id 
, 
r 
. 
Name 
, 
r 
. 
DisplayName 
??  
DisplayNameHelper! 2
.2 3
Humanize3 ;
(; <
r< =
.= >
Name> B
)B C
,C D
r   
.   
OrganizationId    
is  ! #
null  $ (
,  ( )
r!! 
.!! 
Priority!! 
,!! 
r"" 
."" 
RolePermissions"" !
.""! "
Select""" (
(""( )
rp"") +
=>"", .
new""/ 2
PermissionDto""3 @
(""@ A
rp## 
.## 

Permission## !
.##! "
Id##" $
,##$ %
rp$$ 
.$$ 

Permission$$ !
.$$! "
Name$$" &
,$$& '
rp%% 
.%% 

Permission%% !
.%%! "
DisplayName%%" -
??%%. 0
DisplayNameHelper%%1 B
.%%B C
Humanize%%C K
(%%K L
rp%%L N
.%%N O

Permission%%O Y
.%%Y Z
Name%%Z ^
)%%^ _
)%%_ `
)%%` a
.%%a b
ToList%%b h
(%%h i
)%%i j
)%%j k
)%%k l
.&& 
ToList&& 
(&& 
)&& 
;&& 
}'' 
public)) 

async)) 
Task)) 
<)) 

OrgRoleDto))  
>))  !
CreateAsync))" -
())- .
int)). 1
organizationId))2 @
,))@ A
int))B E
userId))F L
,))L M 
CreateOrgRoleRequest))N b
request))c j
,))j k
CancellationToken))l }
ct	))~ Ä
=
))Å Ç
default
))É ä
)
))ä ã
{** 
await++ 
createValidator++ 
.++ !
ValidateAndThrowAsync++ 3
(++3 4
request++4 ;
,++; <
ct++= ?
)++? @
;++@ A
await,, 
	OrgAccess,, 
.,, 
RequirePermission,, )
(,,) *
orgMemberRepository,,* =
,,,= >
userId,,? E
,,,E F
organizationId,,G U
,,,U V
$str,,W i
,,,i j
ct,,k m
),,m n
;,,n o
var.. 
permissions.. 
=.. 
await..  
permissionRepository..  4
...4 5
GetByIdsAsync..5 B
(..B C
request..C J
...J K
PermissionIds..K X
,..X Y
ct..Z \
)..\ ]
;..] ^
if// 

(// 
permissions// 
.// 
Count// 
!=//  
request//! (
.//( )
PermissionIds//) 6
.//6 7
Count//7 <
)//< =
throw00 
new00 
AppException00 "
(00" #
$str00# ;
,00; <
$num00= @
,00@ A
$str00B k
)00k l
;00l m
var22 
role22 
=22 
new22 
OrganizationRole22 '
{33 	
Name44 
=44 
request44 
.44 
Name44 
,44  
OrganizationId55 
=55 
organizationId55 +
,55+ ,
Priority66 
=66 
request66 
.66 
Priority66 '
,66' (

IsArchived77 
=77 
false77 
}88 	
;88	 

await:: 
orgRoleRepository:: 
.::  
AddAsync::  (
(::( )
role::) -
,::- .
ct::/ 1
)::1 2
;::2 3
foreach<< 
(<< 
var<< 
perm<< 
in<< 
permissions<< (
)<<( )
{== 	
role>> 
.>> 
RolePermissions>>  
.>>  !
Add>>! $
(>>$ %
new>>% (&
OrganizationRolePermission>>) C
{?? 
	OrgRoleId@@ 
=@@ 
role@@  
.@@  !
Id@@! #
,@@# $
PermissionIdAA 
=AA 
permAA #
.AA# $
IdAA$ &
}BB 
)BB 
;BB 
}CC 	
awaitEE 
orgRoleRepositoryEE 
.EE  
UpdateAsyncEE  +
(EE+ ,
roleEE, 0
,EE0 1
ctEE2 4
)EE4 5
;EE5 6
ifFF 

(FF 
auditOutboxWriterFF 
isFF  
notFF! $
nullFF% )
)FF) *
{GG 	
awaitHH 
auditOutboxWriterHH #
.HH# $
EnqueueAuditAsyncHH$ 5
(HH5 6
newII 
AuditEventContractII &
(II& '
EventIdJJ 
:JJ 
GuidJJ !
.JJ! "
NewGuidJJ" )
(JJ) *
)JJ* +
,JJ+ ,
SchemaVersionKK !
:KK! "
$numKK# $
,KK$ %
OccurredAtUtcLL !
:LL! "
DateTimeOffsetLL# 1
.LL1 2
UtcNowLL2 8
,LL8 9
SourceServiceMM !
:MM! "
$strMM# )
,MM) *
ActorUserIdNN 
:NN  
userIdNN! '
,NN' (

AuditScopeOO 
:OO 
AuditRoutingOO  ,
.OO, -
ScopeOrganizationOO- >
,OO> ?
TargetIdPP 
:PP 
organizationIdPP ,
,PP, -
ActionQQ 
:QQ 
$strQQ 7
,QQ7 8
	FieldNameRR 
:RR 
$strRR 3
,RR3 4

EntityTypeSS 
:SS 
nullSS  $
,SS$ %
OldValueJsonTT  
:TT  !
nullTT" &
,TT& '
NewValueJsonUU  
:UU  !
SystemUU" (
.UU( )
TextUU) -
.UU- .
JsonUU. 2
.UU2 3
JsonSerializerUU3 A
.UUA B
	SerializeUUB K
(UUK L
newUUL O
{UUP Q
roleUUR V
.UUV W
IdUUW Y
,UUY Z
roleUU[ _
.UU_ `
NameUU` d
,UUd e
requestUUf m
.UUm n
PermissionIdsUUn {
,UU{ |
request	UU} Ñ
.
UUÑ Ö
Priority
UUÖ ç
}
UUé è
)
UUè ê
)
UUê ë
,
UUë í
ctVV 
)VV 
;VV 
}WW 	
returnYY 
newYY 

OrgRoleDtoYY 
(YY 
roleZZ 
.ZZ 
IdZZ 
,ZZ 
role[[ 
.[[ 
Name[[ 
,[[ 
role\\ 
.\\ 
DisplayName\\ 
??\\ 
DisplayNameHelper\\  1
.\\1 2
Humanize\\2 :
(\\: ;
role\\; ?
.\\? @
Name\\@ D
)\\D E
,\\E F
false]] 
,]] 
role^^ 
.^^ 
Priority^^ 
,^^ 
permissions__ 
.__ 
Select__ 
(__ 
p__  
=>__! #
new__$ '
PermissionDto__( 5
(__5 6
p__6 7
.__7 8
Id__8 :
,__: ;
p__< =
.__= >
Name__> B
,__B C
p__D E
.__E F
DisplayName__F Q
??__R T
DisplayNameHelper__U f
.__f g
Humanize__g o
(__o p
p__p q
.__q r
Name__r v
)__v w
)__w x
)__x y
.__y z
ToList	__z Ä
(
__Ä Å
)
__Å Ç
)
__Ç É
;
__É Ñ
}`` 
publicbb 

asyncbb 
Taskbb 
UpdateAsyncbb !
(bb! "
intbb" %
organizationIdbb& 4
,bb4 5
intbb6 9
roleIdbb: @
,bb@ A
intbbB E
userIdbbF L
,bbL M 
UpdateOrgRoleRequestbbN b
requestbbc j
,bbj k
CancellationTokenbbl }
ct	bb~ Ä
=
bbÅ Ç
default
bbÉ ä
)
bbä ã
{cc 
awaitdd 
updateValidatordd 
.dd !
ValidateAndThrowAsyncdd 3
(dd3 4
requestdd4 ;
,dd; <
ctdd= ?
)dd? @
;dd@ A
awaitee 
	OrgAccessee 
.ee 
RequirePermissionee )
(ee) *
orgMemberRepositoryee* =
,ee= >
userIdee? E
,eeE F
organizationIdeeG U
,eeU V
$streeW i
,eei j
cteek m
)eem n
;een o
vargg 
rolegg 
=gg 
awaitgg 
orgRoleRepositorygg *
.gg* +
GetByIdAsyncgg+ 7
(gg7 8
roleIdgg8 >
,gg> ?
ctgg@ B
)ggB C
??hh 
throwhh 
newhh 
AppExceptionhh %
(hh% &
$strhh& 6
,hh6 7
$numhh8 ;
,hh; <
$strhh= N
)hhN O
;hhO P
ifjj 

(jj 
rolejj 
.jj 
OrganizationIdjj 
isjj  "
nulljj# '
)jj' (
throwkk 
newkk 
AppExceptionkk "
(kk" #
$strkk# :
,kk: ;
$numkk< ?
,kk? @
$strkkA c
)kkc d
;kkd e
ifmm 

(mm 
rolemm 
.mm 
OrganizationIdmm 
!=mm  "
organizationIdmm# 1
)mm1 2
thrownn 
newnn 
AppExceptionnn "
(nn" #
$strnn# =
,nn= >
$numnn? B
,nnB C
$strnnD j
)nnj k
;nnk l
ifpp 

(pp 
requestpp 
.pp 
Namepp 
ispp 
notpp 
nullpp  $
)pp$ %
roleqq 
.qq 
Nameqq 
=qq 
requestqq 
.qq  
Nameqq  $
;qq$ %
ifss 

(ss 
requestss 
.ss 
Priorityss 
.ss 
HasValuess %
)ss% &
rolett 
.tt 
Prioritytt 
=tt 
requesttt #
.tt# $
Prioritytt$ ,
.tt, -
Valuett- 2
;tt2 3
ifvv 

(vv 
requestvv 
.vv 
PermissionIdsvv !
isvv" $
notvv% (
nullvv) -
)vv- .
{ww 	
varxx 
permissionsxx 
=xx 
awaitxx # 
permissionRepositoryxx$ 8
.xx8 9
GetByIdsAsyncxx9 F
(xxF G
requestxxG N
.xxN O
PermissionIdsxxO \
,xx\ ]
ctxx^ `
)xx` a
;xxa b
ifyy 
(yy 
permissionsyy 
.yy 
Countyy !
!=yy" $
requestyy% ,
.yy, -
PermissionIdsyy- :
.yy: ;
Countyy; @
)yy@ A
throwzz 
newzz 
AppExceptionzz &
(zz& '
$strzz' ?
,zz? @
$numzzA D
,zzD E
$strzzF o
)zzo p
;zzp q
role|| 
.|| 
RolePermissions||  
.||  !
Clear||! &
(||& '
)||' (
;||( )
foreach}} 
(}} 
var}} 
perm}} 
in}}  
permissions}}! ,
)}}, -
{~~ 
role 
. 
RolePermissions $
.$ %
Add% (
(( )
new) ,&
OrganizationRolePermission- G
{
ÄÄ 
	OrgRoleId
ÅÅ 
=
ÅÅ 
role
ÅÅ  $
.
ÅÅ$ %
Id
ÅÅ% '
,
ÅÅ' (
PermissionId
ÇÇ  
=
ÇÇ! "
perm
ÇÇ# '
.
ÇÇ' (
Id
ÇÇ( *
}
ÉÉ 
)
ÉÉ 
;
ÉÉ 
}
ÑÑ 
}
ÖÖ 	
await
áá 
orgRoleRepository
áá 
.
áá  
UpdateAsync
áá  +
(
áá+ ,
role
áá, 0
,
áá0 1
ct
áá2 4
)
áá4 5
;
áá5 6
if
àà 

(
àà 
auditOutboxWriter
àà 
is
àà  
not
àà! $
null
àà% )
)
àà) *
{
ââ 	
await
ää 
auditOutboxWriter
ää #
.
ää# $
EnqueueAuditAsync
ää$ 5
(
ää5 6
new
ãã  
AuditEventContract
ãã &
(
ãã& '
EventId
åå 
:
åå 
Guid
åå !
.
åå! "
NewGuid
åå" )
(
åå) *
)
åå* +
,
åå+ ,
SchemaVersion
çç !
:
çç! "
$num
çç# $
,
çç$ %
OccurredAtUtc
éé !
:
éé! "
DateTimeOffset
éé# 1
.
éé1 2
UtcNow
éé2 8
,
éé8 9
SourceService
èè !
:
èè! "
$str
èè# )
,
èè) *
ActorUserId
êê 
:
êê  
userId
êê! '
,
êê' (

AuditScope
ëë 
:
ëë 
AuditRouting
ëë  ,
.
ëë, -
ScopeOrganization
ëë- >
,
ëë> ?
TargetId
íí 
:
íí 
organizationId
íí ,
,
íí, -
Action
ìì 
:
ìì 
$str
ìì 7
,
ìì7 8
	FieldName
îî 
:
îî 
$str
îî 3
,
îî3 4

EntityType
ïï 
:
ïï 
null
ïï  $
,
ïï$ %
OldValueJson
ññ  
:
ññ  !
null
ññ" &
,
ññ& '
NewValueJson
óó  
:
óó  !
System
óó" (
.
óó( )
Text
óó) -
.
óó- .
Json
óó. 2
.
óó2 3
JsonSerializer
óó3 A
.
óóA B
	Serialize
óóB K
(
óóK L
new
óóL O
{
òò 
role
ôô 
.
ôô 
Id
ôô 
,
ôô  
role
öö 
.
öö 
Name
öö !
,
öö! "
request
õõ 
.
õõ  
PermissionIds
õõ  -
,
õõ- .
request
úú 
.
úú  
Priority
úú  (
,
úú( )
FinalPriority
ùù %
=
ùù& '
role
ùù( ,
.
ùù, -
Priority
ùù- 5
}
ûû 
)
ûû 
)
ûû 
,
ûû 
ct
üü 
)
üü 
;
üü 
}
†† 	
}
°° 
public
££ 

async
££ 
Task
££ 
ArchiveAsync
££ "
(
££" #
int
££# &
organizationId
££' 5
,
££5 6
int
££7 :
roleId
££; A
,
££A B
int
££C F
userId
££G M
,
££M N
CancellationToken
££O `
ct
££a c
=
££d e
default
££f m
)
££m n
{
§§ 
await
•• 
	OrgAccess
•• 
.
•• 
RequirePermission
•• )
(
••) *!
orgMemberRepository
••* =
,
••= >
userId
••? E
,
••E F
organizationId
••G U
,
••U V
$str
••W i
,
••i j
ct
••k m
)
••m n
;
••n o
var
ßß 
role
ßß 
=
ßß 
await
ßß 
orgRoleRepository
ßß *
.
ßß* +
GetByIdAsync
ßß+ 7
(
ßß7 8
roleId
ßß8 >
,
ßß> ?
ct
ßß@ B
)
ßßB C
??
®® 
throw
®® 
new
®® 
AppException
®® %
(
®®% &
$str
®®& 6
,
®®6 7
$num
®®8 ;
,
®®; <
$str
®®= N
)
®®N O
;
®®O P
if
™™ 

(
™™ 
role
™™ 
.
™™ 
OrganizationId
™™ 
is
™™  "
null
™™# '
)
™™' (
throw
´´ 
new
´´ 
AppException
´´ "
(
´´" #
$str
´´# <
,
´´< =
$num
´´> A
,
´´A B
$str
´´C d
)
´´d e
;
´´e f
if
≠≠ 

(
≠≠ 
role
≠≠ 
.
≠≠ 
OrganizationId
≠≠ 
!=
≠≠  "
organizationId
≠≠# 1
)
≠≠1 2
throw
ÆÆ 
new
ÆÆ 
AppException
ÆÆ "
(
ÆÆ" #
$str
ÆÆ# =
,
ÆÆ= >
$num
ÆÆ? B
,
ÆÆB C
$str
ÆÆD j
)
ÆÆj k
;
ÆÆk l
role
∞∞ 
.
∞∞ 

IsArchived
∞∞ 
=
∞∞ 
true
∞∞ 
;
∞∞ 
await
±± 
orgRoleRepository
±± 
.
±±  
UpdateAsync
±±  +
(
±±+ ,
role
±±, 0
,
±±0 1
ct
±±2 4
)
±±4 5
;
±±5 6
if
≤≤ 

(
≤≤ 
auditOutboxWriter
≤≤ 
is
≤≤  
not
≤≤! $
null
≤≤% )
)
≤≤) *
{
≥≥ 	
await
¥¥ 
auditOutboxWriter
¥¥ #
.
¥¥# $
EnqueueAuditAsync
¥¥$ 5
(
¥¥5 6
new
µµ  
AuditEventContract
µµ &
(
µµ& '
EventId
∂∂ 
:
∂∂ 
Guid
∂∂ !
.
∂∂! "
NewGuid
∂∂" )
(
∂∂) *
)
∂∂* +
,
∂∂+ ,
SchemaVersion
∑∑ !
:
∑∑! "
$num
∑∑# $
,
∑∑$ %
OccurredAtUtc
∏∏ !
:
∏∏! "
DateTimeOffset
∏∏# 1
.
∏∏1 2
UtcNow
∏∏2 8
,
∏∏8 9
SourceService
ππ !
:
ππ! "
$str
ππ# )
,
ππ) *
ActorUserId
∫∫ 
:
∫∫  
userId
∫∫! '
,
∫∫' (

AuditScope
ªª 
:
ªª 
AuditRouting
ªª  ,
.
ªª, -
ScopeOrganization
ªª- >
,
ªª> ?
TargetId
ºº 
:
ºº 
organizationId
ºº ,
,
ºº, -
Action
ΩΩ 
:
ΩΩ 
$str
ΩΩ 8
,
ΩΩ8 9
	FieldName
ææ 
:
ææ 
$str
ææ ?
,
ææ? @

EntityType
øø 
:
øø 
null
øø  $
,
øø$ %
OldValueJson
¿¿  
:
¿¿  !
System
¿¿" (
.
¿¿( )
Text
¿¿) -
.
¿¿- .
Json
¿¿. 2
.
¿¿2 3
JsonSerializer
¿¿3 A
.
¿¿A B
	Serialize
¿¿B K
(
¿¿K L
new
¿¿L O
{
¿¿P Q

IsArchived
¿¿R \
=
¿¿] ^
false
¿¿_ d
,
¿¿d e
role
¿¿f j
.
¿¿j k
Id
¿¿k m
}
¿¿n o
)
¿¿o p
,
¿¿p q
NewValueJson
¡¡  
:
¡¡  !
System
¡¡" (
.
¡¡( )
Text
¡¡) -
.
¡¡- .
Json
¡¡. 2
.
¡¡2 3
JsonSerializer
¡¡3 A
.
¡¡A B
	Serialize
¡¡B K
(
¡¡K L
new
¡¡L O
{
¡¡P Q

IsArchived
¡¡R \
=
¡¡] ^
true
¡¡_ c
,
¡¡c d
role
¡¡e i
.
¡¡i j
Id
¡¡j l
}
¡¡m n
)
¡¡n o
)
¡¡o p
,
¡¡p q
ct
¬¬ 
)
¬¬ 
;
¬¬ 
}
√√ 	
}
ƒƒ 
}∆∆ é¿
kC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Services\OrgInvitationService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
Services$ ,
;, -
public 
sealed 
class  
OrgInvitationService (
(( )$
IOrgInvitationRepository  
invitationRepository 1
,1 2+
IUserRoleOrganizationRepository #
orgMemberRepository$ 7
,7 8'
IOrganizationRoleRepository 
orgRoleRepository  1
,1 2
IUserRepository 
userRepository "
," #

IValidator 
< 
InviteToOrgRequest !
>! "
inviteValidator# 2
,2 3
IOutboxWriter 
? 
auditOutboxWriter $
=% &
null' +
)+ ,
:- .!
IOrgInvitationService/ D
{ 
private 
static 
readonly 
TimeSpan $
InvitationLifetime% 7
=8 9
TimeSpan: B
.B C
FromDaysC K
(K L
$numL M
)M N
;N O
public 

async 
Task 
< 
OrgInvitationDto &
>& '
InviteAsync( 3
(3 4
int4 7
organizationId8 F
,F G
intH K
callerUserIdL X
,X Y
InviteToOrgRequestZ l
requestm t
,t u
CancellationToken	v á
ct
à ä
=
ã å
default
ç î
)
î ï
{ 
await 
inviteValidator 
. !
ValidateAndThrowAsync 3
(3 4
request4 ;
,; <
ct= ?
)? @
;@ A
await 
	OrgAccess 
. 
RequirePermission )
() *
orgMemberRepository* =
,= >
callerUserId? K
,K L
organizationIdM [
,[ \
$str] l
,l m
ctn p
)p q
;q r
var 
role 
= 
await "
ResolveInviteRoleAsync /
(/ 0
organizationId0 >
,> ?
callerUserId@ L
,L M
requestN U
.U V
	OrgRoleIdV _
,_ `
cta c
)c d
;d e
var 
normalizedEmail 
= 
request %
.% &
Email& +
.+ ,
Trim, 0
(0 1
)1 2
.2 3
ToLowerInvariant3 C
(C D
)D E
;E F
await (
EnsureNotExistingMemberAsync *
(* +
organizationId+ 9
,9 :
normalizedEmail; J
,J K
ctL N
)N O
;O P
await   *
EnsureNoPendingInvitationAsync   ,
(  , -
organizationId  - ;
,  ; <
normalizedEmail  = L
,  L M
ct  N P
)  P Q
;  Q R
var"" 

invitation"" 
="" 
new"" "
OrganizationInvitation"" 3
{## 	
OrganizationId$$ 
=$$ 
organizationId$$ +
,$$+ ,
Email%% 
=%% 
normalizedEmail%% #
,%%# $
	OrgRoleId&& 
=&& 
role&& 
.&& 
Id&& 
,&&  
InvitedByUserId'' 
='' 
callerUserId'' *
,''* +
Token(( 
=(( 
Guid(( 
.(( 
NewGuid((  
(((  !
)((! "
.((" #
ToString((# +
(((+ ,
$str((, /
)((/ 0
,((0 1
Status)) 
=)) 
$str)) 
,)) 
	CreatedAt** 
=** 
DateTime**  
.**  !
UtcNow**! '
,**' (
	ExpiresAt++ 
=++ 
DateTime++  
.++  !
UtcNow++! '
.++' (
Add++( +
(+++ ,
InvitationLifetime++, >
)++> ?
},, 	
;,,	 

await..  
invitationRepository.. "
..." #
AddAsync..# +
(..+ ,

invitation.., 6
,..6 7
ct..8 :
)..: ;
;..; <
await// 
EnqueueAuditAsync// 
(//  
callerUserId00 
,00 
organizationId11 
,11 
action22 
:22 
$str22 5
,225 6
field33 
:33 
$str33 -
,33- .
oldJson44 
:44 
null44 
,44 
newJson55 
:55 
new55 
{55 

invitation55 %
.55% &
Id55& (
,55( )

invitation55* 4
.554 5
Email555 :
,55: ;
RoleId55< B
=55C D
role55E I
.55I J
Id55J L
,55L M
RoleName55N V
=55W X
role55Y ]
.55] ^
Name55^ b
,55b c

invitation55d n
.55n o
Status55o u
}55v w
,55w x
ct66 
)66 
;66 
return88 
new88 
OrgInvitationDto88 #
(88# $

invitation99 
.99 
Id99 
,99 

invitation:: 
.:: 
OrganizationId:: %
,::% &

invitation;; 
.;; 
Email;; 
,;; 

invitation<< 
.<< 
Organization<< #
?<<# $
.<<$ %
Name<<% )
??<<* ,
string<<- 3
.<<3 4
Empty<<4 9
,<<9 :
role== 
.== 
Name== 
,== 
role>> 
.>> 
DisplayName>> 
??>> 
DisplayNameHelper>>  1
.>>1 2
Humanize>>2 :
(>>: ;
role>>; ?
.>>? @
Name>>@ D
)>>D E
,>>E F

invitation?? 
.?? 
Status?? 
,?? 

invitation@@ 
.@@ 
Token@@ 
,@@ 

invitationAA 
.AA 
	ExpiresAtAA  
)AA  !
;AA! "
}BB 
publicDD 

asyncDD 
TaskDD 
<DD 
ListDD 
<DD 
OrgInvitationDtoDD +
>DD+ ,
>DD, -"
GetByOrganizationAsyncDD. D
(DDD E
intDDE H
organizationIdDDI W
,DDW X
intDDY \
callerUserIdDD] i
,DDi j
CancellationTokenDDk |
ctDD} 
=
DDÄ Å
default
DDÇ â
)
DDâ ä
{EE 
awaitFF 
	OrgAccessFF 
.FF 
RequirePermissionFF )
(FF) *
orgMemberRepositoryFF* =
,FF= >
callerUserIdFF? K
,FFK L
organizationIdFFM [
,FF[ \
$strFF] l
,FFl m
ctFFn p
)FFp q
;FFq r
varHH 
nowHH 
=HH 
DateTimeHH 
.HH 
UtcNowHH !
;HH! "
varII 
invitationsII 
=II 
awaitII  
invitationRepositoryII  4
.II4 5$
GetByOrganizationIdAsyncII5 M
(IIM N
organizationIdIIN \
,II\ ]
ctII^ `
)II` a
;IIa b
returnJJ 
invitationsJJ 
.KK 
WhereKK 
(KK 
iKK 
=>KK 
iKK 
.KK 
StatusKK  
==KK! #
$strKK$ -
&&KK. 0
iKK1 2
.KK2 3
	ExpiresAtKK3 <
>KK= >
nowKK? B
)KKB C
.LL 
SelectLL 
(LL 
iLL 
=>LL 
newLL 
OrgInvitationDtoLL -
(LL- .
iMM 
.MM 
IdMM 
,MM 
iNN 
.NN 
OrganizationIdNN  
,NN  !
iOO 
.OO 
EmailOO 
,OO 
iPP 
.PP 
OrganizationPP 
?PP 
.PP  
NamePP  $
??PP% '
stringPP( .
.PP. /
EmptyPP/ 4
,PP4 5
iQQ 
.QQ 
RoleQQ 
?QQ 
.QQ 
NameQQ 
??QQ 
stringQQ  &
.QQ& '
EmptyQQ' ,
,QQ, -
iRR 
.RR 
RoleRR 
isRR 
{RR 
}RR 
ir1RR !
?RR" #
(RR$ %
ir1RR% (
.RR( )
DisplayNameRR) 4
??RR5 7
DisplayNameHelperRR8 I
.RRI J
HumanizeRRJ R
(RRR S
ir1RRS V
.RRV W
NameRRW [
)RR[ \
)RR\ ]
:RR^ _
stringRR` f
.RRf g
EmptyRRg l
,RRl m
iSS 
.SS 
StatusSS 
,SS 
iTT 
.TT 
TokenTT 
,TT 
iUU 
.UU 
	ExpiresAtUU 
)UU 
)UU 
.VV 
ToListVV 
(VV 
)VV 
;VV 
}WW 
publicYY 

asyncYY 
TaskYY 
CancelAsyncYY !
(YY! "
intYY" %
organizationIdYY& 4
,YY4 5
intYY6 9
invitationIdYY: F
,YYF G
intYYH K
callerUserIdYYL X
,YYX Y
CancellationTokenYYZ k
ctYYl n
=YYo p
defaultYYq x
)YYx y
{ZZ 
await[[ 
	OrgAccess[[ 
.[[ 
RequirePermission[[ )
([[) *
orgMemberRepository[[* =
,[[= >
callerUserId[[? K
,[[K L
organizationId[[M [
,[[[ \
$str[[] l
,[[l m
ct[[n p
)[[p q
;[[q r
var]] 

invitation]] 
=]] 
await]]  
invitationRepository]] 3
.]]3 4
GetByIdAsync]]4 @
(]]@ A
invitationId]]A M
,]]M N
ct]]O Q
)]]Q R
??^^ 
throw^^ 
new^^ 
AppException^^ %
(^^% &
$str^^& <
,^^< =
$num^^> A
,^^A B
$str^^C Z
)^^Z [
;^^[ \
if`` 

(`` 

invitation`` 
.`` 
OrganizationId`` %
!=``& (
organizationId``) 7
)``7 8
throwaa 
newaa 
AppExceptionaa "
(aa" #
$straa# 9
,aa9 :
$numaa; >
,aa> ?
$straa@ W
)aaW X
;aaX Y
ifcc 

(cc 

invitationcc 
.cc 
Statuscc 
!=cc  
$strcc! *
)cc* +
throwdd 
newdd 
AppExceptiondd "
(dd" #
$strdd# ;
,dd; <
$numdd= @
,dd@ A
$"ddB D
$strddD m
{ddm n

invitationddn x
.ddx y
Statusddy 
}	dd Ä
$str
ddÄ Ç
"
ddÇ É
)
ddÉ Ñ
;
ddÑ Ö

invitationff 
.ff 
Statusff 
=ff 
$strff '
;ff' (
awaitgg  
invitationRepositorygg "
.gg" #
UpdateAsyncgg# .
(gg. /

invitationgg/ 9
,gg9 :
ctgg; =
)gg= >
;gg> ?
awaithh 
EnqueueAuditAsynchh 
(hh  
callerUserIdii 
,ii 
organizationIdjj 
,jj 
actionkk 
:kk 
$strkk 7
,kk7 8
fieldll 
:ll 
$strll 4
,ll4 5
oldJsonmm 
:mm 
newmm 
{mm 
Statusmm !
=mm" #
$strmm$ -
,mm- .

invitationmm/ 9
.mm9 :
Emailmm: ?
}mm@ A
,mmA B
newJsonnn 
:nn 
newnn 
{nn 
Statusnn !
=nn" #
$strnn$ /
,nn/ 0

invitationnn1 ;
.nn; <
Emailnn< A
}nnB C
,nnC D
ctoo 
)oo 
;oo 
}pp 
publicrr 

asyncrr 
Taskrr 
<rr 
OrgInvitationDtorr &
>rr& '
ResendAsyncrr( 3
(rr3 4
intrr4 7
organizationIdrr8 F
,rrF G
intrrH K
invitationIdrrL X
,rrX Y
intrrZ ]
callerUserIdrr^ j
,rrj k
CancellationTokenrrl }
ct	rr~ Ä
=
rrÅ Ç
default
rrÉ ä
)
rrä ã
{ss 
awaittt 
	OrgAccesstt 
.tt 
RequirePermissiontt )
(tt) *
orgMemberRepositorytt* =
,tt= >
callerUserIdtt? K
,ttK L
organizationIdttM [
,tt[ \
$strtt] l
,ttl m
ctttn p
)ttp q
;ttq r
varvv 

invitationvv 
=vv 
awaitvv  
invitationRepositoryvv 3
.vv3 4
GetByIdAsyncvv4 @
(vv@ A
invitationIdvvA M
,vvM N
ctvvO Q
)vvQ R
??ww 
throwww 
newww 
AppExceptionww %
(ww% &
$strww& <
,ww< =
$numww> A
,wwA B
$strwwC Z
)wwZ [
;ww[ \
ifyy 

(yy 

invitationyy 
.yy 
OrganizationIdyy %
!=yy& (
organizationIdyy) 7
)yy7 8
throwzz 
newzz 
AppExceptionzz "
(zz" #
$strzz# 9
,zz9 :
$numzz; >
,zz> ?
$strzz@ W
)zzW X
;zzX Y
if|| 

(|| 

invitation|| 
.|| 
Status|| 
!=||  
$str||! *
)||* +
throw}} 
new}} 
AppException}} "
(}}" #
$str}}# =
,}}= >
$num}}? B
,}}B C
$"}}D F
$str}}F j
{}}j k

invitation}}k u
.}}u v
Status}}v |
}}}| }
$str}}} 
"	}} Ä
)
}}Ä Å
;
}}Å Ç
var 
previousToken 
= 

invitation &
.& '
Token' ,
;, -
var
ÄÄ 
previousExpiresAt
ÄÄ 
=
ÄÄ 

invitation
ÄÄ  *
.
ÄÄ* +
	ExpiresAt
ÄÄ+ 4
;
ÄÄ4 5

invitation
ÇÇ 
.
ÇÇ 
Token
ÇÇ 
=
ÇÇ 
Guid
ÇÇ 
.
ÇÇ  
NewGuid
ÇÇ  '
(
ÇÇ' (
)
ÇÇ( )
.
ÇÇ) *
ToString
ÇÇ* 2
(
ÇÇ2 3
$str
ÇÇ3 6
)
ÇÇ6 7
;
ÇÇ7 8

invitation
ÉÉ 
.
ÉÉ 
	ExpiresAt
ÉÉ 
=
ÉÉ 
DateTime
ÉÉ '
.
ÉÉ' (
UtcNow
ÉÉ( .
.
ÉÉ. /
Add
ÉÉ/ 2
(
ÉÉ2 3 
InvitationLifetime
ÉÉ3 E
)
ÉÉE F
;
ÉÉF G
await
ÖÖ "
invitationRepository
ÖÖ "
.
ÖÖ" #
UpdateAsync
ÖÖ# .
(
ÖÖ. /

invitation
ÖÖ/ 9
,
ÖÖ9 :
ct
ÖÖ; =
)
ÖÖ= >
;
ÖÖ> ?
await
ÜÜ 
EnqueueAuditAsync
ÜÜ 
(
ÜÜ  
callerUserId
áá 
,
áá 
organizationId
àà 
,
àà 
action
ââ 
:
ââ 
$str
ââ 4
,
ââ4 5
field
ää 
:
ää 
$str
ää 3
,
ää3 4
oldJson
ãã 
:
ãã 
new
ãã 
{
ãã 
Token
ãã  
=
ãã! "
previousToken
ãã# 0
,
ãã0 1
	ExpiresAt
ãã2 ;
=
ãã< =
previousExpiresAt
ãã> O
,
ããO P

invitation
ããQ [
.
ãã[ \
Email
ãã\ a
}
ããb c
,
ããc d
newJson
åå 
:
åå 
new
åå 
{
åå 

invitation
åå %
.
åå% &
Token
åå& +
,
åå+ ,

invitation
åå- 7
.
åå7 8
	ExpiresAt
åå8 A
,
ååA B

invitation
ååC M
.
ååM N
Email
ååN S
}
ååT U
,
ååU V
ct
çç 
)
çç 
;
çç 
return
èè 
new
èè 
OrgInvitationDto
èè #
(
èè# $

invitation
êê 
.
êê 
Id
êê 
,
êê 

invitation
ëë 
.
ëë 
OrganizationId
ëë %
,
ëë% &

invitation
íí 
.
íí 
Email
íí 
,
íí 

invitation
ìì 
.
ìì 
Organization
ìì #
?
ìì# $
.
ìì$ %
Name
ìì% )
??
ìì* ,
string
ìì- 3
.
ìì3 4
Empty
ìì4 9
,
ìì9 :

invitation
îî 
.
îî 
Role
îî 
?
îî 
.
îî 
Name
îî !
??
îî" $
string
îî% +
.
îî+ ,
Empty
îî, 1
,
îî1 2

invitation
ïï 
.
ïï 
Role
ïï 
is
ïï 
{
ïï  
}
ïï! "
ir2
ïï# &
?
ïï' (
(
ïï) *
ir2
ïï* -
.
ïï- .
DisplayName
ïï. 9
??
ïï: <
DisplayNameHelper
ïï= N
.
ïïN O
Humanize
ïïO W
(
ïïW X
ir2
ïïX [
.
ïï[ \
Name
ïï\ `
)
ïï` a
)
ïïa b
:
ïïc d
string
ïïe k
.
ïïk l
Empty
ïïl q
,
ïïq r

invitation
ññ 
.
ññ 
Status
ññ 
,
ññ 

invitation
óó 
.
óó 
Token
óó 
,
óó 

invitation
òò 
.
òò 
	ExpiresAt
òò  
)
òò  !
;
òò! "
}
ôô 
public
õõ 

async
õõ 
Task
õõ 
AcceptAsync
õõ !
(
õõ! "
int
õõ" %
userId
õõ& ,
,
õõ, -
string
õõ. 4
	userEmail
õõ5 >
,
õõ> ?
string
õõ@ F
token
õõG L
,
õõL M
CancellationToken
õõN _
ct
õõ` b
=
õõc d
default
õõe l
)
õõl m
{
úú 
var
ùù 

invitation
ùù 
=
ùù 
await
ùù "
invitationRepository
ùù 3
.
ùù3 4
GetByTokenAsync
ùù4 C
(
ùùC D
token
ùùD I
,
ùùI J
ct
ùùK M
)
ùùM N
??
ûû 
throw
ûû 
new
ûû 
AppException
ûû %
(
ûû% &
$str
ûû& G
,
ûûG H
$num
ûûI L
,
ûûL M
$str
ûûN t
)
ûût u
;
ûûu v
if
†† 

(
†† 
!
†† 
string
†† 
.
†† 
Equals
†† 
(
†† 

invitation
†† %
.
††% &
Email
††& +
,
††+ ,
	userEmail
††- 6
,
††6 7
StringComparison
††8 H
.
††H I
OrdinalIgnoreCase
††I Z
)
††Z [
)
††[ \
throw
°° 
new
°° 
AppException
°° "
(
°°" #
$str
°°# >
,
°°> ?
$num
°°@ C
,
°°C D
$str
°°E }
)
°°} ~
;
°°~ 
if
££ 

(
££ 

invitation
££ 
.
££ 
Status
££ 
!=
££  
$str
££! *
)
££* +
throw
§§ 
new
§§ 
AppException
§§ "
(
§§" #
$str
§§# ;
,
§§; <
$num
§§= @
,
§§@ A
$"
§§B D
$str
§§D m
{
§§m n

invitation
§§n x
.
§§x y
Status
§§y 
}§§ Ä
$str§§Ä Ç
"§§Ç É
)§§É Ñ
;§§Ñ Ö
if
¶¶ 

(
¶¶ 

invitation
¶¶ 
.
¶¶ 
	ExpiresAt
¶¶  
<
¶¶! "
DateTime
¶¶# +
.
¶¶+ ,
UtcNow
¶¶, 2
)
¶¶2 3
{
ßß 	

invitation
®® 
.
®® 
Status
®® 
=
®® 
$str
®®  )
;
®®) *
await
©© "
invitationRepository
©© &
.
©©& '
UpdateAsync
©©' 2
(
©©2 3

invitation
©©3 =
,
©©= >
ct
©©? A
)
©©A B
;
©©B C
throw
™™ 
new
™™ 
AppException
™™ "
(
™™" #
$str
™™# 7
,
™™7 8
$num
™™9 <
,
™™< =
$str
™™> W
)
™™W X
;
™™X Y
}
´´ 	
var
≠≠  
existingMembership
≠≠ 
=
≠≠  
await
≠≠! &!
orgMemberRepository
≠≠' :
.
≠≠: ;
GetAsync
≠≠; C
(
≠≠C D
userId
≠≠D J
,
≠≠J K

invitation
≠≠L V
.
≠≠V W
OrganizationId
≠≠W e
,
≠≠e f
ct
≠≠g i
)
≠≠i j
;
≠≠j k
if
ÆÆ 

(
ÆÆ  
existingMembership
ÆÆ 
is
ÆÆ !
not
ÆÆ" %
null
ÆÆ& *
)
ÆÆ* +
throw
ØØ 
new
ØØ 
AppException
ØØ "
(
ØØ" #
$str
ØØ# 7
,
ØØ7 8
$num
ØØ9 <
,
ØØ< =
$str
ØØ> n
)
ØØn o
;
ØØo p
var
±± 

membership
±± 
=
±± 
new
±± "
UserRoleOrganization
±± 1
{
≤≤ 	
UserId
≥≥ 
=
≥≥ 
userId
≥≥ 
,
≥≥ 
OrganizationId
¥¥ 
=
¥¥ 

invitation
¥¥ '
.
¥¥' (
OrganizationId
¥¥( 6
,
¥¥6 7
	OrgRoleId
µµ 
=
µµ 

invitation
µµ "
.
µµ" #
	OrgRoleId
µµ# ,
,
µµ, -
JoinedAt
∂∂ 
=
∂∂ 
DateTime
∂∂ 
.
∂∂  
UtcNow
∂∂  &
,
∂∂& '

IsArchived
∑∑ 
=
∑∑ 
false
∑∑ 
}
∏∏ 	
;
∏∏	 

await
∫∫ !
orgMemberRepository
∫∫ !
.
∫∫! "
AddAsync
∫∫" *
(
∫∫* +

membership
∫∫+ 5
,
∫∫5 6
ct
∫∫7 9
)
∫∫9 :
;
∫∫: ;
await
ªª 
EnqueueAuditAsync
ªª 
(
ªª  
userId
ºº 
,
ºº 

invitation
ΩΩ 
.
ΩΩ 
OrganizationId
ΩΩ %
,
ΩΩ% &
action
ææ 
:
ææ 
$str
ææ >
,
ææ> ?
field
øø 
:
øø 
$str
øø +
,
øø+ ,
oldJson
¿¿ 
:
¿¿ 
null
¿¿ 
,
¿¿ 
newJson
¡¡ 
:
¡¡ 
new
¡¡ 
{
¡¡ 

membership
¡¡ %
.
¡¡% &
UserId
¡¡& ,
,
¡¡, -

membership
¡¡. 8
.
¡¡8 9
	OrgRoleId
¡¡9 B
}
¡¡C D
,
¡¡D E
ct
¬¬ 
)
¬¬ 
;
¬¬ 

invitation
ƒƒ 
.
ƒƒ 
Status
ƒƒ 
=
ƒƒ 
$str
ƒƒ &
;
ƒƒ& '
await
≈≈ "
invitationRepository
≈≈ "
.
≈≈" #
UpdateAsync
≈≈# .
(
≈≈. /

invitation
≈≈/ 9
,
≈≈9 :
ct
≈≈; =
)
≈≈= >
;
≈≈> ?
await
∆∆ 
EnqueueAuditAsync
∆∆ 
(
∆∆  
userId
«« 
,
«« 

invitation
»» 
.
»» 
OrganizationId
»» %
,
»»% &
action
…… 
:
…… 
$str
…… 6
,
……6 7
field
   
:
   
$str
   4
,
  4 5
oldJson
ÀÀ 
:
ÀÀ 
new
ÀÀ 
{
ÀÀ 
Status
ÀÀ !
=
ÀÀ" #
$str
ÀÀ$ -
,
ÀÀ- .

invitation
ÀÀ/ 9
.
ÀÀ9 :
Email
ÀÀ: ?
}
ÀÀ@ A
,
ÀÀA B
newJson
ÃÃ 
:
ÃÃ 
new
ÃÃ 
{
ÃÃ 
Status
ÃÃ !
=
ÃÃ" #
$str
ÃÃ$ .
,
ÃÃ. /

invitation
ÃÃ0 :
.
ÃÃ: ;
Email
ÃÃ; @
}
ÃÃA B
,
ÃÃB C
ct
ÕÕ 
)
ÕÕ 
;
ÕÕ 
}
ŒŒ 
public
–– 

async
–– 
Task
–– 
DeclineAsync
–– "
(
––" #
int
––# &
userId
––' -
,
––- .
string
––/ 5
	userEmail
––6 ?
,
––? @
string
––A G
token
––H M
,
––M N
CancellationToken
––O `
ct
––a c
=
––d e
default
––f m
)
––m n
{
—— 
var
““ 

invitation
““ 
=
““ 
await
““ "
invitationRepository
““ 3
.
““3 4
GetByTokenAsync
““4 C
(
““C D
token
““D I
,
““I J
ct
““K M
)
““M N
??
”” 
throw
”” 
new
”” 
AppException
”” %
(
””% &
$str
””& G
,
””G H
$num
””I L
,
””L M
$str
””N t
)
””t u
;
””u v
if
’’ 

(
’’ 
!
’’ 
string
’’ 
.
’’ 
Equals
’’ 
(
’’ 

invitation
’’ %
.
’’% &
Email
’’& +
,
’’+ ,
	userEmail
’’- 6
,
’’6 7
StringComparison
’’8 H
.
’’H I
OrdinalIgnoreCase
’’I Z
)
’’Z [
)
’’[ \
throw
÷÷ 
new
÷÷ 
AppException
÷÷ "
(
÷÷" #
$str
÷÷# >
,
÷÷> ?
$num
÷÷@ C
,
÷÷C D
$str
÷÷E }
)
÷÷} ~
;
÷÷~ 
if
ÿÿ 

(
ÿÿ 

invitation
ÿÿ 
.
ÿÿ 
Status
ÿÿ 
!=
ÿÿ  
$str
ÿÿ! *
)
ÿÿ* +
throw
ŸŸ 
new
ŸŸ 
AppException
ŸŸ "
(
ŸŸ" #
$str
ŸŸ# ;
,
ŸŸ; <
$num
ŸŸ= @
,
ŸŸ@ A
$"
ŸŸB D
$str
ŸŸD m
{
ŸŸm n

invitation
ŸŸn x
.
ŸŸx y
Status
ŸŸy 
}ŸŸ Ä
$strŸŸÄ Ç
"ŸŸÇ É
)ŸŸÉ Ñ
;ŸŸÑ Ö

invitation
€€ 
.
€€ 
Status
€€ 
=
€€ 
$str
€€ &
;
€€& '
await
‹‹ "
invitationRepository
‹‹ "
.
‹‹" #
UpdateAsync
‹‹# .
(
‹‹. /

invitation
‹‹/ 9
,
‹‹9 :
ct
‹‹; =
)
‹‹= >
;
‹‹> ?
await
›› 
EnqueueAuditAsync
›› 
(
››  
userId
ﬁﬁ 
,
ﬁﬁ 

invitation
ﬂﬂ 
.
ﬂﬂ 
OrganizationId
ﬂﬂ %
,
ﬂﬂ% &
action
‡‡ 
:
‡‡ 
$str
‡‡ 6
,
‡‡6 7
field
·· 
:
·· 
$str
·· 4
,
··4 5
oldJson
‚‚ 
:
‚‚ 
new
‚‚ 
{
‚‚ 
Status
‚‚ !
=
‚‚" #
$str
‚‚$ -
,
‚‚- .

invitation
‚‚/ 9
.
‚‚9 :
Email
‚‚: ?
}
‚‚@ A
,
‚‚A B
newJson
„„ 
:
„„ 
new
„„ 
{
„„ 
Status
„„ !
=
„„" #
$str
„„$ .
,
„„. /

invitation
„„0 :
.
„„: ;
Email
„„; @
}
„„A B
,
„„B C
ct
‰‰ 
)
‰‰ 
;
‰‰ 
}
ÂÂ 
public
ÁÁ 

async
ÁÁ 
Task
ÁÁ 
<
ÁÁ 
List
ÁÁ 
<
ÁÁ 
OrgInvitationDto
ÁÁ +
>
ÁÁ+ ,
>
ÁÁ, -*
GetMyPendingInvitationsAsync
ÁÁ. J
(
ÁÁJ K
string
ÁÁK Q
	userEmail
ÁÁR [
,
ÁÁ[ \
CancellationToken
ÁÁ] n
ct
ÁÁo q
=
ÁÁr s
default
ÁÁt {
)
ÁÁ{ |
{
ËË 
if
ÈÈ 

(
ÈÈ 
string
ÈÈ 
.
ÈÈ  
IsNullOrWhiteSpace
ÈÈ %
(
ÈÈ% &
	userEmail
ÈÈ& /
)
ÈÈ/ 0
)
ÈÈ0 1
return
ÍÍ 
[
ÍÍ 
]
ÍÍ 
;
ÍÍ 
var
ÏÏ 
now
ÏÏ 
=
ÏÏ 
DateTime
ÏÏ 
.
ÏÏ 
UtcNow
ÏÏ !
;
ÏÏ! "
var
ÌÌ 
orgInvitations
ÌÌ 
=
ÌÌ 
await
ÌÌ ""
invitationRepository
ÌÌ# 7
.
ÌÌ7 8
GetByEmailAsync
ÌÌ8 G
(
ÌÌG H
	userEmail
ÌÌH Q
,
ÌÌQ R
ct
ÌÌS U
)
ÌÌU V
;
ÌÌV W
return
ÓÓ 
orgInvitations
ÓÓ 
.
ÔÔ 
Where
ÔÔ 
(
ÔÔ 
i
ÔÔ 
=>
ÔÔ 
i
ÔÔ 
.
ÔÔ 
Status
ÔÔ  
==
ÔÔ! #
$str
ÔÔ$ -
&&
ÔÔ. 0
i
ÔÔ1 2
.
ÔÔ2 3
	ExpiresAt
ÔÔ3 <
>
ÔÔ= >
now
ÔÔ? B
)
ÔÔB C
.
 
Select
 
(
 
i
 
=>
 
new
 
OrgInvitationDto
 -
(
- .
i
ÒÒ 
.
ÒÒ 
Id
ÒÒ 
,
ÒÒ 
i
ÚÚ 
.
ÚÚ 
OrganizationId
ÚÚ  
,
ÚÚ  !
i
ÛÛ 
.
ÛÛ 
Email
ÛÛ 
??
ÛÛ 
string
ÛÛ !
.
ÛÛ! "
Empty
ÛÛ" '
,
ÛÛ' (
i
ÙÙ 
.
ÙÙ 
Organization
ÙÙ 
?
ÙÙ 
.
ÙÙ  
Name
ÙÙ  $
??
ÙÙ% '
string
ÙÙ( .
.
ÙÙ. /
Empty
ÙÙ/ 4
,
ÙÙ4 5
i
ıı 
.
ıı 
Role
ıı 
?
ıı 
.
ıı 
Name
ıı 
??
ıı 
string
ıı  &
.
ıı& '
Empty
ıı' ,
,
ıı, -
i
ˆˆ 
.
ˆˆ 
Role
ˆˆ 
is
ˆˆ 
{
ˆˆ 
}
ˆˆ 
ir3
ˆˆ !
?
ˆˆ" #
(
ˆˆ$ %
ir3
ˆˆ% (
.
ˆˆ( )
DisplayName
ˆˆ) 4
??
ˆˆ5 7
DisplayNameHelper
ˆˆ8 I
.
ˆˆI J
Humanize
ˆˆJ R
(
ˆˆR S
ir3
ˆˆS V
.
ˆˆV W
Name
ˆˆW [
)
ˆˆ[ \
)
ˆˆ\ ]
:
ˆˆ^ _
string
ˆˆ` f
.
ˆˆf g
Empty
ˆˆg l
,
ˆˆl m
i
˜˜ 
.
˜˜ 
Status
˜˜ 
??
˜˜ 
string
˜˜ "
.
˜˜" #
Empty
˜˜# (
,
˜˜( )
i
¯¯ 
.
¯¯ 
Token
¯¯ 
??
¯¯ 
string
¯¯ !
.
¯¯! "
Empty
¯¯" '
,
¯¯' (
i
˘˘ 
.
˘˘ 
	ExpiresAt
˘˘ 
)
˘˘ 
)
˘˘ 
.
˙˙ 
ToList
˙˙ 
(
˙˙ 
)
˙˙ 
;
˙˙ 
}
˚˚ 
private
˝˝ 
async
˝˝ 
Task
˝˝ 
<
˝˝ 
OrganizationRole
˝˝ '
>
˝˝' ($
ResolveInviteRoleAsync
˝˝) ?
(
˝˝? @
int
˝˝@ C
organizationId
˝˝D R
,
˝˝R S
int
˝˝T W
callerUserId
˝˝X d
,
˝˝d e
int
˝˝f i
?
˝˝i j
requestedRoleId
˝˝k z
,
˝˝z { 
CancellationToken˝˝| ç
ct˝˝é ê
)˝˝ê ë
{
˛˛ 
var
ˇˇ 
systemRoles
ˇˇ 
=
ˇˇ 
(
ˇˇ 
await
ˇˇ  
orgRoleRepository
ˇˇ! 2
.
ˇˇ2 3!
GetSystemRolesAsync
ˇˇ3 F
(
ˇˇF G
ct
ˇˇG I
)
ˇˇI J
)
ˇˇJ K
??
ˇˇL N
[
ˇˇO P
]
ˇˇP Q
;
ˇˇQ R
var
ÄÄ 
defaultRole
ÄÄ 
=
ÄÄ 
systemRoles
ÄÄ %
.
ÅÅ 
OrderByDescending
ÅÅ 
(
ÅÅ 
r
ÅÅ  
=>
ÅÅ! #
r
ÅÅ$ %
.
ÅÅ% &
Priority
ÅÅ& .
)
ÅÅ. /
.
ÇÇ 
ThenBy
ÇÇ 
(
ÇÇ 
r
ÇÇ 
=>
ÇÇ 
r
ÇÇ 
.
ÇÇ 
Id
ÇÇ 
)
ÇÇ 
.
ÉÉ 
FirstOrDefault
ÉÉ 
(
ÉÉ 
)
ÉÉ 
;
ÉÉ 
if
ÖÖ 

(
ÖÖ 
!
ÖÖ 
requestedRoleId
ÖÖ 
.
ÖÖ 
HasValue
ÖÖ %
)
ÖÖ% &
{
ÜÜ 	
return
áá 
defaultRole
áá 
??
áá !
throw
áá" '
new
áá( +
AppException
áá, 8
(
áá8 9
$str
áá9 U
,
ááU V
$num
ááW Z
,
ááZ [
$stráá\ â
)ááâ ä
;ááä ã
}
àà 	
var
ää 
role
ää 
=
ää 
await
ää 
orgRoleRepository
ää *
.
ää* +
GetByIdAsync
ää+ 7
(
ää7 8
requestedRoleId
ää8 G
.
ääG H
Value
ääH M
,
ääM N
ct
ääO Q
)
ääQ R
??
ãã 
throw
ãã 
new
ãã 
AppException
ãã %
(
ãã% &
$str
ãã& 6
,
ãã6 7
$num
ãã8 ;
,
ãã; <
$str
ãã= a
)
ããa b
;
ããb c
if
çç 

(
çç 
role
çç 
.
çç 
OrganizationId
çç 
.
çç  
HasValue
çç  (
&&
çç) +
role
çç, 0
.
çç0 1
OrganizationId
çç1 ?
.
çç? @
Value
çç@ E
!=
ççF H
organizationId
ççI W
)
ççW X
throw
éé 
new
éé 
AppException
éé "
(
éé" #
$str
éé# =
,
éé= >
$num
éé? B
,
ééB C
$str
ééD ~
)
éé~ 
;éé Ä
if
êê 

(
êê 
defaultRole
êê 
is
êê 
null
êê 
||
êê  "
role
êê# '
.
êê' (
Id
êê( *
!=
êê+ -
defaultRole
êê. 9
.
êê9 :
Id
êê: <
)
êê< =
{
ëë 	
await
íí 
	OrgAccess
íí 
.
íí 
RequirePermission
íí -
(
íí- .!
orgMemberRepository
íí. A
,
ííA B
callerUserId
ííC O
,
ííO P
organizationId
ííQ _
,
íí_ `
$str
íía s
,
íís t
ct
ííu w
)
ííw x
;
ííx y
}
ìì 	
return
ïï 
role
ïï 
;
ïï 
}
ññ 
private
òò 
async
òò 
Task
òò *
EnsureNotExistingMemberAsync
òò 3
(
òò3 4
int
òò4 7
organizationId
òò8 F
,
òòF G
string
òòH N
normalizedEmail
òòO ^
,
òò^ _
CancellationToken
òò` q
ct
òòr t
)
òòt u
{
ôô 
var
öö 
user
öö 
=
öö 
await
öö 
userRepository
öö '
.
öö' (
GetByEmailAsync
öö( 7
(
öö7 8
normalizedEmail
öö8 G
,
ööG H
ct
ööI K
)
ööK L
;
ööL M
if
õõ 

(
õõ 
user
õõ 
is
õõ 
null
õõ 
)
õõ 
return
õõ  
;
õõ  !
var
ùù 
existing
ùù 
=
ùù 
await
ùù !
orgMemberRepository
ùù 0
.
ùù0 1
GetAsync
ùù1 9
(
ùù9 :
user
ùù: >
.
ùù> ?
Id
ùù? A
,
ùùA B
organizationId
ùùC Q
,
ùùQ R
ct
ùùS U
)
ùùU V
;
ùùV W
if
ûû 

(
ûû 
existing
ûû 
is
ûû 
not
ûû 
null
ûû  
)
ûû  !
throw
üü 
new
üü 
AppException
üü "
(
üü" #
$str
üü# 7
,
üü7 8
$num
üü9 <
,
üü< =
$str
üü> r
)
üür s
;
üüs t
}
†† 
private
¢¢ 
async
¢¢ 
Task
¢¢ ,
EnsureNoPendingInvitationAsync
¢¢ 5
(
¢¢5 6
int
¢¢6 9
organizationId
¢¢: H
,
¢¢H I
string
¢¢J P
normalizedEmail
¢¢Q `
,
¢¢` a
CancellationToken
¢¢b s
ct
¢¢t v
)
¢¢v w
{
££ 
var
§§ 
existing
§§ 
=
§§ 
await
§§ "
invitationRepository
§§ 1
.
§§1 2*
GetPendingByOrgAndEmailAsync
§§2 N
(
§§N O
organizationId
§§O ]
,
§§] ^
normalizedEmail
§§_ n
,
§§n o
ct
§§p r
)
§§r s
;
§§s t
if
•• 

(
•• 
existing
•• 
is
•• 
null
•• 
)
•• 
return
•• $
;
••$ %
if
¶¶ 

(
¶¶ 
existing
¶¶ 
.
¶¶ 
	ExpiresAt
¶¶ 
<=
¶¶ !
DateTime
¶¶" *
.
¶¶* +
UtcNow
¶¶+ 1
)
¶¶1 2
{
ßß 	
existing
®® 
.
®® 
Status
®® 
=
®® 
$str
®® '
;
®®' (
await
©© "
invitationRepository
©© &
.
©©& '
UpdateAsync
©©' 2
(
©©2 3
existing
©©3 ;
,
©©; <
ct
©©= ?
)
©©? @
;
©©@ A
return
™™ 
;
™™ 
}
´´ 	
throw
¨¨ 
new
¨¨ 
AppException
¨¨ 
(
¨¨ 
$str
¨¨ ;
,
¨¨; <
$num
¨¨= @
,
¨¨@ A
$str
¨¨B w
)
¨¨w x
;
¨¨x y
}
≠≠ 
private
ØØ 
async
ØØ 
Task
ØØ 
EnqueueAuditAsync
ØØ (
(
ØØ( )
int
ØØ) ,
actorUserId
ØØ- 8
,
ØØ8 9
int
ØØ: =
organizationId
ØØ> L
,
ØØL M
string
ØØN T
action
ØØU [
,
ØØ[ \
string
ØØ] c
?
ØØc d
field
ØØe j
,
ØØj k
object
ØØl r
?
ØØr s
oldJson
ØØt {
,
ØØ{ |
objectØØ} É
?ØØÉ Ñ
newJsonØØÖ å
,ØØå ç!
CancellationTokenØØé ü
ctØØ† ¢
)ØØ¢ £
{
∞∞ 
if
±± 

(
±± 
auditOutboxWriter
±± 
is
±±  
null
±±! %
)
±±% &
return
±±' -
;
±±- .
await
≥≥ 
auditOutboxWriter
≥≥ 
.
≥≥  
EnqueueAuditAsync
≥≥  1
(
≥≥1 2
new
¥¥  
AuditEventContract
¥¥ "
(
¥¥" #
EventId
µµ 
:
µµ 
Guid
µµ 
.
µµ 
NewGuid
µµ %
(
µµ% &
)
µµ& '
,
µµ' (
SchemaVersion
∂∂ 
:
∂∂ 
$num
∂∂  
,
∂∂  !
OccurredAtUtc
∑∑ 
:
∑∑ 
DateTimeOffset
∑∑ -
.
∑∑- .
UtcNow
∑∑. 4
,
∑∑4 5
SourceService
∏∏ 
:
∏∏ 
$str
∏∏ %
,
∏∏% &
ActorUserId
ππ 
:
ππ 
actorUserId
ππ (
,
ππ( )

AuditScope
∫∫ 
:
∫∫ 
AuditRouting
∫∫ (
.
∫∫( )
ScopeOrganization
∫∫) :
,
∫∫: ;
TargetId
ªª 
:
ªª 
organizationId
ªª (
,
ªª( )
Action
ºº 
:
ºº 
action
ºº 
,
ºº 
	FieldName
ΩΩ 
:
ΩΩ 
field
ΩΩ  
,
ΩΩ  !

EntityType
ææ 
:
ææ 
null
ææ  
,
ææ  !
OldValueJson
øø 
:
øø 
oldJson
øø %
is
øø& (
null
øø) -
?
øø. /
null
øø0 4
:
øø5 6
System
øø7 =
.
øø= >
Text
øø> B
.
øøB C
Json
øøC G
.
øøG H
JsonSerializer
øøH V
.
øøV W
	Serialize
øøW `
(
øø` a
oldJson
øøa h
)
øøh i
,
øøi j
NewValueJson
¿¿ 
:
¿¿ 
newJson
¿¿ %
is
¿¿& (
null
¿¿) -
?
¿¿. /
null
¿¿0 4
:
¿¿5 6
System
¿¿7 =
.
¿¿= >
Text
¿¿> B
.
¿¿B C
Json
¿¿C G
.
¿¿G H
JsonSerializer
¿¿H V
.
¿¿V W
	Serialize
¿¿W `
(
¿¿` a
newJson
¿¿a h
)
¿¿h i
)
¿¿i j
,
¿¿j k
ct
¡¡ 
)
¡¡ 
;
¡¡ 
}
¬¬ 
}ƒƒ Àü
sC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Services\OrganizationUserAdminService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
Services$ ,
;, -
public 
sealed 
class (
OrganizationUserAdminService 0
(0 1$
IUserProvisioningService 
userProvisioning -
,- .
IUserRepository 
userRepository "
," #+
IUserRoleOrganizationRepository #
orgMemberRepository$ 7
,7 8'
IOrganizationRoleRepository 
orgRoleRepository  1
,1 2

IValidator 
<  
CreateOrgUserRequest #
># $"
createOrgUserValidator% ;
,; <

IValidator 
< '
UpdateOrgUserProfileRequest *
>* +"
updateOrgUserValidator, B
,B C
IOutboxWriter 
? 
auditOutboxWriter $
=% &
null' +
)+ ,
:- .)
IOrganizationUserAdminService/ L
{ 
public 

async 
Task 
< 
RegisterResponseDto )
>) *
CreateOrgUserAsync+ =
(= >
int> A
organizationIdB P
,P Q
intR U
callerUserIdV b
,b c 
CreateOrgUserRequestd x
request	y Ä
,
Ä Å
CancellationToken
Ç ì
ct
î ñ
=
ó ò
default
ô †
)
† °
{ 
await "
createOrgUserValidator $
.$ %!
ValidateAndThrowAsync% :
(: ;
request; B
,B C
ctD F
)F G
;G H
await 
	OrgAccess 
. 
RequirePermission )
() *
orgMemberRepository* =
,= >
callerUserId? K
,K L
organizationIdM [
,[ \#
OrganizationPermissions] t
.t u
CreateOrgUsers	u É
,
É Ñ
ct
Ö á
)
á à
;
à â
var 
registerRequest 
= 
new !
RegisterRequestDto" 4
(4 5
request 
. 
	FirstName 
, 
request   
.   
LastName   
,   
request!! 
.!! 
Email!! 
,!! 
request"" 
."" 
Password"" 
)"" 
;"" 
var## 
created## 
=## 
await## 
userProvisioning## ,
.##, -
CreateUserAsync##- <
(##< =
registerRequest##= L
,##L M
callerUserId##N Z
,##Z [
ct##\ ^
)##^ _
;##_ `
var%% 

memberRole%% 
=%% 
await%% "
ResolveTargetRoleAsync%% 5
(%%5 6
organizationId%%6 D
,%%D E
callerUserId%%F R
,%%R S
request%%T [
.%%[ \
	OrgRoleId%%\ e
,%%e f
ct%%g i
)%%i j
;%%j k
var&& 

membership&& 
=&& 
new&&  
UserRoleOrganization&& 1
{'' 	
UserId(( 
=(( 
created(( 
.(( 
Id(( 
,((  
OrganizationId)) 
=)) 
organizationId)) +
,))+ ,
	OrgRoleId** 
=** 

memberRole** "
.**" #
Id**# %
,**% &
JoinedAt++ 
=++ 
DateTime++ 
.++  
UtcNow++  &
,++& '

IsArchived,, 
=,, 
false,, 
}-- 	
;--	 

await// 
orgMemberRepository// !
.//! "
AddAsync//" *
(//* +

membership//+ 5
,//5 6
ct//7 9
)//9 :
;//: ;
if11 

(11 
auditOutboxWriter11 
is11  
not11! $
null11% )
)11) *
{22 	
await33 
auditOutboxWriter33 #
.33# $
EnqueueAuditAsync33$ 5
(335 6
new44 
AuditEventContract44 &
(44& '
EventId55 
:55 
Guid55 !
.55! "
NewGuid55" )
(55) *
)55* +
,55+ ,
SchemaVersion66 !
:66! "
$num66# $
,66$ %
OccurredAtUtc77 !
:77! "
DateTimeOffset77# 1
.771 2
UtcNow772 8
,778 9
SourceService88 !
:88! "
$str88# )
,88) *
ActorUserId99 
:99  
callerUserId99! -
,99- .

AuditScope:: 
::: 
AuditRouting::  ,
.::, -
ScopeOrganization::- >
,::> ?
TargetId;; 
:;; 
organizationId;; ,
,;;, -
Action<< 
:<< 
$str<< M
,<<M N
	FieldName== 
:== 
null== #
,==# $

EntityType>> 
:>> 
null>>  $
,>>$ %
OldValueJson??  
:??  !
null??" &
,??& '
NewValueJson@@  
:@@  !
System@@" (
.@@( )
Text@@) -
.@@- .
Json@@. 2
.@@2 3
JsonSerializer@@3 A
.@@A B
	Serialize@@B K
(@@K L
new@@L O
{@@P Q
UserId@@R X
=@@Y Z
created@@[ b
.@@b c
Id@@c e
,@@e f
RoleId@@g m
=@@n o

memberRole@@p z
.@@z {
Id@@{ }
}@@~ 
)	@@ Ä
)
@@Ä Å
,
@@Å Ç
ctAA 
)AA 
;AA 
}BB 	
returnDD 
createdDD 
;DD 
}EE 
publicGG 

asyncGG 
TaskGG 
<GG 
UserProfileDtoGG $
>GG$ %'
UpdateOtherUserProfileAsyncGG& A
(GGA B
intGGB E
organizationIdGGF T
,GGT U
intGGV Y
targetUserIdGGZ f
,GGf g
intGGh k
callerUserIdGGl x
,GGx y(
UpdateOrgUserProfileRequest	GGz ï
request
GGñ ù
,
GGù û
CancellationToken
GGü ∞
ct
GG± ≥
=
GG¥ µ
default
GG∂ Ω
)
GGΩ æ
{HH 
awaitII "
updateOrgUserValidatorII $
.II$ %!
ValidateAndThrowAsyncII% :
(II: ;
requestII; B
,IIB C
ctIID F
)IIF G
;IIG H
awaitJJ 
	OrgAccessJJ 
.JJ 
RequirePermissionJJ )
(JJ) *
orgMemberRepositoryJJ* =
,JJ= >
callerUserIdJJ? K
,JJK L
organizationIdJJM [
,JJ[ \#
OrganizationPermissionsJJ] t
.JJt u%
EditOtherOrgUsersProfile	JJu ç
,
JJç é
ct
JJè ë
)
JJë í
;
JJí ì
ifLL 

(LL 
targetUserIdLL 
==LL 
callerUserIdLL (
)LL( )
throwMM 
newMM 
AppExceptionMM "
(MM" #
$strMM# A
,MMA B
$numMMC F
,MMF G
$str	MMH Ç
)
MMÇ É
;
MMÉ Ñ
_OO 	
=OO
 
awaitOO 
orgMemberRepositoryOO %
.OO% &
GetAsyncOO& .
(OO. /
targetUserIdOO/ ;
,OO; <
organizationIdOO= K
,OOK L
ctOOM O
)OOO P
??PP 
throwPP 
newPP 
AppExceptionPP %
(PP% &
$strPP& =
,PP= >
$numPP? B
,PPB C
$strPPD w
)PPw x
;PPx y
returnRR 
awaitRR 
userProvisioningRR %
.RR% &"
UpdateUserProfileAsyncRR& <
(RR< =
targetUserIdRR= I
,RRI J
requestRRK R
.RRR S
	FirstNameRRS \
,RR\ ]
requestRR^ e
.RRe f
LastNameRRf n
,RRn o
callerUserIdRRp |
,RR| }
ct	RR~ Ä
)
RRÄ Å
;
RRÅ Ç
}SS 
publicUU 

asyncUU 
TaskUU 
DeleteOrgUserAsyncUU (
(UU( )
intUU) ,
organizationIdUU- ;
,UU; <
intUU= @
targetUserIdUUA M
,UUM N
intUUO R
callerUserIdUUS _
,UU_ `
CancellationTokenUUa r
ctUUs u
=UUv w
defaultUUx 
)	UU Ä
{VV 
ifWW 

(WW 
targetUserIdWW 
==WW 
callerUserIdWW (
)WW( )
throwXX 
newXX 
AppExceptionXX "
(XX" #
$strXX# D
,XXD E
$numXXF I
,XXI J
$str	XXK à
)
XXà â
;
XXâ ä
awaitZZ 
	OrgAccessZZ 
.ZZ 
RequirePermissionZZ )
(ZZ) *
orgMemberRepositoryZZ* =
,ZZ= >
callerUserIdZZ? K
,ZZK L
organizationIdZZM [
,ZZ[ \#
OrganizationPermissionsZZ] t
.ZZt u
DeleteOrgUsers	ZZu É
,
ZZÉ Ñ
ct
ZZÖ á
)
ZZá à
;
ZZà â
var\\ 
targetMembership\\ 
=\\ 
await\\ $
orgMemberRepository\\% 8
.\\8 9
GetAsync\\9 A
(\\A B
targetUserId\\B N
,\\N O
organizationId\\P ^
,\\^ _
ct\\` b
)\\b c
??]] 
throw]] 
new]] 
AppException]] %
(]]% &
$str]]& =
,]]= >
$num]]? B
,]]B C
$str]]D w
)]]w x
;]]x y
var__ 
caller__ 
=__ 
await__ 
userRepository__ )
.__) *
GetByIdAsync__* 6
(__6 7
callerUserId__7 C
,__C D
ct__E G
)__G H
??`` 
throw`` 
new`` 
AppException`` %
(``% &
$str``& =
,``= >
$num``? B
,``B C
$str``D \
)``\ ]
;``] ^
varaa 
targetaa 
=aa 
awaitaa 
userRepositoryaa )
.aa) *
GetByIdAsyncaa* 6
(aa6 7
targetUserIdaa7 C
,aaC D
ctaaE G
)aaG H
??bb 
throwbb 
newbb 
AppExceptionbb %
(bb% &
$strbb& =
,bb= >
$numbb? B
,bbB C
$strbbD \
)bb\ ]
;bb] ^
ifcc 

(cc 
!cc 
EmailDomainMatchescc 
(cc  
callercc  &
.cc& '
Emailcc' ,
,cc, -
targetcc. 4
.cc4 5
Emailcc5 :
)cc: ;
)cc; <
throwdd 
newdd 
AppExceptiondd "
(dd" #
$strdd# =
,dd= >
$numdd? B
,ddB C
$strddD |
)dd| }
;dd} ~
varff 
callerMembershipff 
=ff 
awaitff $
orgMemberRepositoryff% 8
.ff8 9
GetAsyncff9 A
(ffA B
callerUserIdffB N
,ffN O
organizationIdffP ^
,ff^ _
ctff` b
)ffb c
??gg 
throwgg 
newgg 
AppExceptiongg %
(gg% &
$strgg& 6
,gg6 7
$numgg8 ;
,gg; <
$strgg= i
)ggi j
;ggj k
ifhh 

(hh 
callerMembershiphh 
.hh 
Rolehh !
!hh! "
.hh" #
Priorityhh# +
>=hh, .
targetMembershiphh/ ?
.hh? @
Rolehh@ D
!hhD E
.hhE F
PriorityhhF N
)hhN O
{ii 	
throwjj 
newjj 
AppExceptionjj "
(jj" #
$strjj# @
,jj@ A
$numjjB E
,jjE F
$strkk ~
)kk~ 
;	kk Ä
}ll 	
awaitnn 
userProvisioningnn 
.nn 
ArchiveUserAsyncnn /
(nn/ 0
targetUserIdnn0 <
,nn< =
callerUserIdnn> J
,nnJ K
ctnnL N
)nnN O
;nnO P
ifpp 

(pp 
auditOutboxWriterpp 
ispp  
notpp! $
nullpp% )
)pp) *
{qq 	
awaitrr 
auditOutboxWriterrr #
.rr# $
EnqueueAuditAsyncrr$ 5
(rr5 6
newss 
AuditEventContractss &
(ss& '
EventIdtt 
:tt 
Guidtt !
.tt! "
NewGuidtt" )
(tt) *
)tt* +
,tt+ ,
SchemaVersionuu !
:uu! "
$numuu# $
,uu$ %
OccurredAtUtcvv !
:vv! "
DateTimeOffsetvv# 1
.vv1 2
UtcNowvv2 8
,vv8 9
SourceServiceww !
:ww! "
$strww# )
,ww) *
ActorUserIdxx 
:xx  
callerUserIdxx! -
,xx- .

AuditScopeyy 
:yy 
AuditRoutingyy  ,
.yy, -
ScopeOrganizationyy- >
,yy> ?
TargetIdzz 
:zz 
organizationIdzz ,
,zz, -
Action{{ 
:{{ 
$str{{ B
,{{B C
	FieldName|| 
:|| 
$str|| 2
,||2 3

EntityType}} 
:}} 
null}}  $
,}}$ %
OldValueJson~~  
:~~  !
System~~" (
.~~( )
Text~~) -
.~~- .
Json~~. 2
.~~2 3
JsonSerializer~~3 A
.~~A B
	Serialize~~B K
(~~K L
new~~L O
{ 
targetUserId
ÄÄ $
,
ÄÄ$ %
	OrgRoleId
ÅÅ !
=
ÅÅ" #
targetMembership
ÅÅ$ 4
.
ÅÅ4 5
	OrgRoleId
ÅÅ5 >
,
ÅÅ> ?
RoleName
ÇÇ  
=
ÇÇ! "
targetMembership
ÇÇ# 3
.
ÇÇ3 4
Role
ÇÇ4 8
?
ÇÇ8 9
.
ÇÇ9 :
Name
ÇÇ: >
}
ÉÉ 
)
ÉÉ 
,
ÉÉ 
NewValueJson
ÑÑ  
:
ÑÑ  !
System
ÑÑ" (
.
ÑÑ( )
Text
ÑÑ) -
.
ÑÑ- .
Json
ÑÑ. 2
.
ÑÑ2 3
JsonSerializer
ÑÑ3 A
.
ÑÑA B
	Serialize
ÑÑB K
(
ÑÑK L
new
ÑÑL O
{
ÑÑP Q
targetUserId
ÑÑR ^
,
ÑÑ^ _
Archived
ÑÑ` h
=
ÑÑi j
true
ÑÑk o
}
ÑÑp q
)
ÑÑq r
)
ÑÑr s
,
ÑÑs t
ct
ÖÖ 
)
ÖÖ 
;
ÖÖ 
}
ÜÜ 	
}
áá 
private
ââ 
async
ââ 
Task
ââ 
<
ââ 
OrganizationRole
ââ '
>
ââ' ($
ResolveTargetRoleAsync
ââ) ?
(
ââ? @
int
ââ@ C
organizationId
ââD R
,
ââR S
int
ââT W
callerUserId
ââX d
,
ââd e
int
ââf i
?
ââi j
requestedRoleId
ââk z
,
ââz { 
CancellationTokenââ| ç
ctââé ê
)ââê ë
{
ää 
var
ãã 
defaultRole
ãã 
=
ãã 
(
ãã 
(
ãã 
await
ãã !
orgRoleRepository
ãã" 3
.
ãã3 4!
GetSystemRolesAsync
ãã4 G
(
ããG H
ct
ããH J
)
ããJ K
)
ããK L
??
ããM O
[
ããP Q
]
ããQ R
)
ããR S
.
åå 
OrderByDescending
åå 
(
åå 
r
åå  
=>
åå! #
r
åå$ %
.
åå% &
Priority
åå& .
)
åå. /
.
çç 
ThenBy
çç 
(
çç 
r
çç 
=>
çç 
r
çç 
.
çç 
Id
çç 
)
çç 
.
éé 
FirstOrDefault
éé 
(
éé 
)
éé 
??
èè 
throw
èè 
new
èè 
AppException
èè %
(
èè% &
$str
èè& B
,
èèB C
$num
èèD G
,
èèG H
$str
èèI v
)
èèv w
;
èèw x
if
ëë 

(
ëë 
!
ëë 
requestedRoleId
ëë 
.
ëë 
HasValue
ëë %
||
ëë& (
requestedRoleId
ëë) 8
.
ëë8 9
Value
ëë9 >
==
ëë? A
defaultRole
ëëB M
.
ëëM N
Id
ëëN P
)
ëëP Q
return
íí 
defaultRole
íí 
;
íí 
await
îî 
	OrgAccess
îî 
.
îî 
RequirePermission
îî )
(
îî) *!
orgMemberRepository
îî* =
,
îî= >
callerUserId
îî? K
,
îîK L
organizationId
îîM [
,
îî[ \%
OrganizationPermissions
îî] t
.
îît u
AssignOrgRolesîîu É
,îîÉ Ñ
ctîîÖ á
)îîá à
;îîà â
var
ïï 
requestedRole
ïï 
=
ïï 
await
ïï !
orgRoleRepository
ïï" 3
.
ïï3 4
GetByIdAsync
ïï4 @
(
ïï@ A
requestedRoleId
ïïA P
.
ïïP Q
Value
ïïQ V
,
ïïV W
ct
ïïX Z
)
ïïZ [
??
ññ 
throw
ññ 
new
ññ 
AppException
ññ %
(
ññ% &
$str
ññ& 6
,
ññ6 7
$num
ññ8 ;
,
ññ; <
$str
ññ= a
)
ñña b
;
ññb c
if
óó 

(
óó 
requestedRole
óó 
.
óó 

IsArchived
óó $
)
óó$ %
throw
òò 
new
òò 
AppException
òò "
(
òò" #
$str
òò# 2
,
òò2 3
$num
òò4 7
,
òò7 8
$str
òò9 Z
)
òòZ [
;
òò[ \
if
ôô 

(
ôô 
requestedRole
ôô 
.
ôô 
OrganizationId
ôô (
.
ôô( )
HasValue
ôô) 1
&&
ôô2 4
requestedRole
ôô5 B
.
ôôB C
OrganizationId
ôôC Q
.
ôôQ R
Value
ôôR W
!=
ôôX Z
organizationId
ôô[ i
)
ôôi j
throw
öö 
new
öö 
AppException
öö "
(
öö" #
$str
öö# =
,
öö= >
$num
öö? B
,
ööB C
$str
ööD ~
)
öö~ 
;öö Ä
return
õõ 
requestedRole
õõ 
;
õõ 
}
úú 
private
ûû 
static
ûû 
bool
ûû  
EmailDomainMatches
ûû *
(
ûû* +
string
ûû+ 1
	leftEmail
ûû2 ;
,
ûû; <
string
ûû= C

rightEmail
ûûD N
)
ûûN O
{
üü 
static
†† 
string
†† 
ExtractDomain
†† #
(
††# $
string
††$ *
value
††+ 0
)
††0 1
{
°° 	
var
¢¢ 

normalized
¢¢ 
=
¢¢ 
EmailNormalizer
¢¢ ,
.
¢¢, -
	Normalize
¢¢- 6
(
¢¢6 7
value
¢¢7 <
)
¢¢< =
;
¢¢= >
var
££ 
at
££ 
=
££ 

normalized
££ 
.
££  
LastIndexOf
££  +
(
££+ ,
$char
££, /
)
££/ 0
;
££0 1
if
§§ 
(
§§ 
at
§§ 
<
§§ 
$num
§§ 
||
§§ 
at
§§ 
==
§§ 

normalized
§§  *
.
§§* +
Length
§§+ 1
-
§§2 3
$num
§§4 5
)
§§5 6
return
•• 
string
•• 
.
•• 
Empty
•• #
;
••# $
return
¶¶ 

normalized
¶¶ 
[
¶¶ 
(
¶¶ 
at
¶¶ !
+
¶¶" #
$num
¶¶$ %
)
¶¶% &
..
¶¶& (
]
¶¶( )
;
¶¶) *
}
ßß 	
return
©© 
ExtractDomain
©© 
(
©© 
	leftEmail
©© &
)
©©& '
==
©©( *
ExtractDomain
©©+ 8
(
©©8 9

rightEmail
©©9 C
)
©©C D
;
©©D E
}
™™ 
}¨¨ «¸
jC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Services\OrganizationService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
Services$ ,
;, -
public 
sealed 
class 
OrganizationService '
(' (#
IOrganizationRepository "
organizationRepository 2
,2 3+
IUserRoleOrganizationRepository #
orgMemberRepository$ 7
,7 8'
IOrganizationRoleRepository 
orgRoleRepository  1
,1 2+
IOrganizationSettingsRepository #*
organizationSettingsRepository$ B
,B C

IValidator 
< %
CreateOrganizationRequest (
>( )
createValidator* 9
,9 :

IValidator 
< %
UpdateOrganizationRequest (
>( )
updateValidator* 9
,9 :

IValidator 
< -
!UpdateOrganizationSettingsRequest 0
>0 1#
updateSettingsValidator2 I
,I J
IOutboxWriter 
? 
auditOutboxWriter $
=% &
null' +
)+ ,
:- . 
IOrganizationService/ C
{ 
public 

async 
Task 
< 
OrganizationDto %
>% &
CreateAsync' 2
(2 3
int3 6
userId7 =
,= >%
CreateOrganizationRequest? X
requestY `
,` a
CancellationTokenb s
ctt v
=w x
default	y Ä
)
Ä Å
{ 
await 
createValidator 
. !
ValidateAndThrowAsync 3
(3 4
request4 ;
,; <
ct= ?
)? @
;@ A
var 
	ownerRole 
= 
( 
await 
orgRoleRepository 0
.0 1
GetSystemRolesAsync1 D
(D E
ctE G
)G H
)H I
. 
OrderBy 
( 
r 
=> 
r 
. 
Priority $
)$ %
. 
FirstOrDefault 
( 
) 
?? 
throw 
new 
AppException %
(% &
$str& :
,: ;
$num< ?
,? @
$strA m
)m n
;n o
var!! 
organization!! 
=!! 
new!! 
Organization!! +
{"" 	
Name## 
=## 
request## 
.## 
Name## 
,##  

IsArchived$$ 
=$$ 
false$$ 
}%% 	
;%%	 

await'' "
organizationRepository'' $
.''$ %
AddAsync''% -
(''- .
organization''. :
,'': ;
ct''< >
)''> ?
;''? @
var)) 

membership)) 
=)) 
new))  
UserRoleOrganization)) 1
{** 	
UserId++ 
=++ 
userId++ 
,++ 
OrganizationId,, 
=,, 
organization,, )
.,,) *
Id,,* ,
,,,, -
	OrgRoleId-- 
=-- 
	ownerRole-- !
.--! "
Id--" $
,--$ %
JoinedAt.. 
=.. 
DateTime.. 
...  
UtcNow..  &
,..& '

IsArchived// 
=// 
false// 
}00 	
;00	 

await22 
orgMemberRepository22 !
.22! "
AddAsync22" *
(22* +

membership22+ 5
,225 6
ct227 9
)229 :
;22: ;
await44 *
organizationSettingsRepository44 ,
.44, -
AddAsync44- 5
(445 6
new446 9 
OrganizationSettings44: N
{55 	
OrganizationId66 
=66 
organization66 )
.66) *
Id66* ,
,66, -

JoinPolicy77 
=77 
$str77 
}88 	
,88	 

ct88 
)88 
;88 
if:: 

(:: 
auditOutboxWriter:: 
is::  
not::! $
null::% )
)::) *
{;; 	
await<< 
auditOutboxWriter<< #
.<<# $
EnqueueAuditAsync<<$ 5
(<<5 6
new== 
AuditEventContract== "
(==" #
EventId>> 
:>> 
Guid>> 
.>> 
NewGuid>> %
(>>% &
)>>& '
,>>' (
SchemaVersion?? 
:?? 
$num??  
,??  !
OccurredAtUtc@@ 
:@@ 
DateTimeOffset@@ -
.@@- .
UtcNow@@. 4
,@@4 5
SourceServiceAA 
:AA 
$strAA %
,AA% &
ActorUserIdBB 
:BB 
userIdBB #
,BB# $

AuditScopeCC 
:CC 
AuditRoutingCC (
.CC( )
ScopeOrganizationCC) :
,CC: ;
TargetIdDD 
:DD 
organizationDD &
.DD& '
IdDD' )
,DD) *
ActionEE 
:EE 
$strEE .
,EE. /
	FieldNameFF 
:FF 
nullFF 
,FF  

EntityTypeGG 
:GG 
nullGG  
,GG  !
OldValueJsonHH 
:HH 
nullHH "
,HH" #
NewValueJsonII 
:II 
JsonSerializerII ,
.II, -
	SerializeII- 6
(II6 7
newII7 :
{II; <
organizationII= I
.III J
IdIIJ L
,IIL M
organizationIIN Z
.IIZ [
NameII[ _
,II_ `
settingsIIa i
=IIj k
newIIl o
{IIp q

joinPolicyIIr |
=II} ~
$str	II Ö
}
IIÜ á
}
IIà â
)
IIâ ä
)
IIä ã
,
IIã å
ctJJ 
)JJ 
;JJ 
}KK 	
returnMM 
newMM 
OrganizationDtoMM "
(MM" #
organizationNN 
.NN 
IdNN 
,NN 
organizationOO 
.OO 
NameOO 
,OO 
$numPP 
,PP 
	ownerRoleQQ 
.QQ 
NameQQ 
,QQ 
	ownerRoleRR 
.RR 
DisplayNameRR !
??RR" $
DisplayNameHelperRR% 6
.RR6 7
HumanizeRR7 ?
(RR? @
	ownerRoleRR@ I
.RRI J
NameRRJ N
)RRN O
,RRO P
	ownerRoleSS 
.SS 
RolePermissionsSS %
.TT 
SelectTT 
(TT 
rpTT 
=>TT 
rpTT  
.TT  !

PermissionTT! +
?TT+ ,
.TT, -
NameTT- 1
)TT1 2
.UU 
WhereUU 
(UU 
nUU 
=>UU 
!UU 
stringUU #
.UU# $
IsNullOrWhiteSpaceUU$ 6
(UU6 7
nUU7 8
)UU8 9
)UU9 :
.VV 
CastVV 
<VV 
stringVV 
>VV 
(VV 
)VV 
.WW 
OrderByWW 
(WW 
xWW 
=>WW 
xWW 
,WW  
StringComparerWW! /
.WW/ 0
OrdinalWW0 7
)WW7 8
.XX 
ToListXX 
(XX 
)XX 
)XX 
;XX 
}YY 
public[[ 

async[[ 
Task[[ 
<[[ 
List[[ 
<[[ 
OrganizationDto[[ *
>[[* +
>[[+ ,
GetByUserAsync[[- ;
([[; <
int[[< ?
userId[[@ F
,[[F G
CancellationToken[[H Y
ct[[Z \
=[[] ^
default[[_ f
)[[f g
{\\ 
var]] 
organizations]] 
=]] 
await]] !"
organizationRepository]]" 8
.]]8 9
GetByUserIdAsync]]9 I
(]]I J
userId]]J P
,]]P Q
ct]]R T
)]]T U
;]]U V
var^^ 
result^^ 
=^^ 
new^^ 
List^^ 
<^^ 
OrganizationDto^^ -
>^^- .
(^^. /
)^^/ 0
;^^0 1
foreach`` 
(`` 
var`` 
org`` 
in`` 
organizations`` )
)``) *
{aa 	
varbb 

membershipbb 
=bb 
awaitbb "
orgMemberRepositorybb# 6
.bb6 7
GetAsyncbb7 ?
(bb? @
userIdbb@ F
,bbF G
orgbbH K
.bbK L
IdbbL N
,bbN O
ctbbP R
)bbR S
;bbS T
varcc 
memberCountcc 
=cc 
(cc 
awaitcc $
orgMemberRepositorycc% 8
.cc8 9$
GetByOrganizationIdAsynccc9 Q
(ccQ R
orgccR U
.ccU V
IdccV X
,ccX Y
ctccZ \
)cc\ ]
)cc] ^
.cc^ _
Countcc_ d
;ccd e
resultdd 
.dd 
Adddd 
(dd 
newdd 
OrganizationDtodd *
(dd* +
orgee 
.ee 
Idee 
,ee 
orgff 
.ff 
Nameff 
,ff 
memberCountgg 
,gg 

membershiphh 
?hh 
.hh 
Rolehh  
?hh  !
.hh! "
Namehh" &
,hh& '

membershipii 
?ii 
.ii 
Roleii  
isii! #
{ii$ %
}ii& '
mrii( *
?ii+ ,
(ii- .
mrii. 0
.ii0 1
DisplayNameii1 <
??ii= ?
DisplayNameHelperii@ Q
.iiQ R
HumanizeiiR Z
(iiZ [
mrii[ ]
.ii] ^
Nameii^ b
)iib c
)iic d
:iie f
nulliig k
,iik l

membershipjj 
?jj 
.jj 
Rolejj  
?jj  !
.jj! "
RolePermissionsjj" 1
.kk 
Selectkk 
(kk 
rpkk 
=>kk !
rpkk" $
.kk$ %

Permissionkk% /
?kk/ 0
.kk0 1
Namekk1 5
)kk5 6
.ll 
Wherell 
(ll 
nll 
=>ll 
!ll  !
stringll! '
.ll' (
IsNullOrWhiteSpacell( :
(ll: ;
nll; <
)ll< =
)ll= >
.mm 
Castmm 
<mm 
stringmm  
>mm  !
(mm! "
)mm" #
.nn 
OrderBynn 
(nn 
xnn 
=>nn !
xnn" #
,nn# $
StringComparernn% 3
.nn3 4
Ordinalnn4 ;
)nn; <
.oo 
ToListoo 
(oo 
)oo 
??oo  
[oo! "
]oo" #
)oo# $
)oo$ %
;oo% &
}pp 	
returnrr 
resultrr 
;rr 
}ss 
publicuu 

asyncuu 
Taskuu 
<uu 
OrganizationDtouu %
>uu% &
GetByIdAsyncuu' 3
(uu3 4
intuu4 7
organizationIduu8 F
,uuF G
intuuH K
userIduuL R
,uuR S
CancellationTokenuuT e
ctuuf h
=uui j
defaultuuk r
)uur s
{vv 
awaitww 
	OrgAccessww 
.ww 
RequireMembershipww )
(ww) *
orgMemberRepositoryww* =
,ww= >
userIdww? E
,wwE F
organizationIdwwG U
,wwU V
ctwwW Y
)wwY Z
;wwZ [
varyy 
organizationyy 
=yy 
awaityy  "
organizationRepositoryyy! 7
.yy7 8
GetByIdAsyncyy8 D
(yyD E
organizationIdyyE S
,yyS T
ctyyU W
)yyW X
??zz 
throwzz 
newzz 
AppExceptionzz %
(zz% &
$strzz& >
,zz> ?
$numzz@ C
,zzC D
$strzzE ^
)zz^ _
;zz_ `
var|| 

membership|| 
=|| 
await|| 
orgMemberRepository|| 2
.||2 3
GetAsync||3 ;
(||; <
userId||< B
,||B C
organizationId||D R
,||R S
ct||T V
)||V W
;||W X
var}} 
members}} 
=}} 
await}} 
orgMemberRepository}} /
.}}/ 0$
GetByOrganizationIdAsync}}0 H
(}}H I
organizationId}}I W
,}}W X
ct}}Y [
)}}[ \
;}}\ ]
return 
new 
OrganizationDto "
(" #
organization
ÄÄ 
.
ÄÄ 
Id
ÄÄ 
,
ÄÄ 
organization
ÅÅ 
.
ÅÅ 
Name
ÅÅ 
,
ÅÅ 
members
ÇÇ 
.
ÇÇ 
Count
ÇÇ 
,
ÇÇ 

membership
ÉÉ 
?
ÉÉ 
.
ÉÉ 
Role
ÉÉ 
?
ÉÉ 
.
ÉÉ 
Name
ÉÉ "
,
ÉÉ" #

membership
ÑÑ 
?
ÑÑ 
.
ÑÑ 
Role
ÑÑ 
is
ÑÑ 
{
ÑÑ  !
}
ÑÑ" #
mr2
ÑÑ$ '
?
ÑÑ( )
(
ÑÑ* +
mr2
ÑÑ+ .
.
ÑÑ. /
DisplayName
ÑÑ/ :
??
ÑÑ; =
DisplayNameHelper
ÑÑ> O
.
ÑÑO P
Humanize
ÑÑP X
(
ÑÑX Y
mr2
ÑÑY \
.
ÑÑ\ ]
Name
ÑÑ] a
)
ÑÑa b
)
ÑÑb c
:
ÑÑd e
null
ÑÑf j
,
ÑÑj k

membership
ÖÖ 
?
ÖÖ 
.
ÖÖ 
Role
ÖÖ 
?
ÖÖ 
.
ÖÖ 
RolePermissions
ÖÖ -
.
ÜÜ 
Select
ÜÜ 
(
ÜÜ 
rp
ÜÜ 
=>
ÜÜ 
rp
ÜÜ  
.
ÜÜ  !

Permission
ÜÜ! +
?
ÜÜ+ ,
.
ÜÜ, -
Name
ÜÜ- 1
)
ÜÜ1 2
.
áá 
Where
áá 
(
áá 
n
áá 
=>
áá 
!
áá 
string
áá #
.
áá# $ 
IsNullOrWhiteSpace
áá$ 6
(
áá6 7
n
áá7 8
)
áá8 9
)
áá9 :
.
àà 
Cast
àà 
<
àà 
string
àà 
>
àà 
(
àà 
)
àà 
.
ââ 
OrderBy
ââ 
(
ââ 
x
ââ 
=>
ââ 
x
ââ 
,
ââ  
StringComparer
ââ! /
.
ââ/ 0
Ordinal
ââ0 7
)
ââ7 8
.
ää 
ToList
ää 
(
ää 
)
ää 
??
ää 
[
ää 
]
ää 
)
ää  
;
ää  !
}
ãã 
public
çç 

async
çç 
Task
çç 
UpdateAsync
çç !
(
çç! "
int
çç" %
organizationId
çç& 4
,
çç4 5
int
çç6 9
userId
çç: @
,
çç@ A'
UpdateOrganizationRequest
ççB [
request
çç\ c
,
ççc d
CancellationToken
ççe v
ct
ççw y
=
ççz {
defaultçç| É
)ççÉ Ñ
{
éé 
await
èè 
updateValidator
èè 
.
èè #
ValidateAndThrowAsync
èè 3
(
èè3 4
request
èè4 ;
,
èè; <
ct
èè= ?
)
èè? @
;
èè@ A
await
êê 
	OrgAccess
êê 
.
êê 
RequirePermission
êê )
(
êê) *!
orgMemberRepository
êê* =
,
êê= >
userId
êê? E
,
êêE F
organizationId
êêG U
,
êêU V
$str
êêW l
,
êêl m
ct
êên p
)
êêp q
;
êêq r
var
íí 
organization
íí 
=
íí 
await
íí  $
organizationRepository
íí! 7
.
íí7 8
GetByIdAsync
íí8 D
(
ííD E
organizationId
ííE S
,
ííS T
ct
ííU W
)
ííW X
??
ìì 
throw
ìì 
new
ìì 
AppException
ìì %
(
ìì% &
$str
ìì& >
,
ìì> ?
$num
ìì@ C
,
ììC D
$str
ììE ^
)
ìì^ _
;
ìì_ `
var
ïï 
previousName
ïï 
=
ïï 
organization
ïï '
.
ïï' (
Name
ïï( ,
;
ïï, -
organization
ññ 
.
ññ 
Name
ññ 
=
ññ 
request
ññ #
.
ññ# $
Name
ññ$ (
;
ññ( )
await
óó $
organizationRepository
óó $
.
óó$ %
UpdateAsync
óó% 0
(
óó0 1
organization
óó1 =
,
óó= >
ct
óó? A
)
óóA B
;
óóB C
if
ôô 

(
ôô 
auditOutboxWriter
ôô 
is
ôô  
not
ôô! $
null
ôô% )
)
ôô) *
{
öö 	
await
õõ 
auditOutboxWriter
õõ #
.
õõ# $
EnqueueAuditAsync
õõ$ 5
(
õõ5 6
new
úú  
AuditEventContract
úú "
(
úú" #
EventId
ùù 
:
ùù 
Guid
ùù 
.
ùù 
NewGuid
ùù %
(
ùù% &
)
ùù& '
,
ùù' (
SchemaVersion
ûû 
:
ûû 
$num
ûû  
,
ûû  !
OccurredAtUtc
üü 
:
üü 
DateTimeOffset
üü -
.
üü- .
UtcNow
üü. 4
,
üü4 5
SourceService
†† 
:
†† 
$str
†† %
,
††% &
ActorUserId
°° 
:
°° 
userId
°° #
,
°°# $

AuditScope
¢¢ 
:
¢¢ 
AuditRouting
¢¢ (
.
¢¢( )
ScopeOrganization
¢¢) :
,
¢¢: ;
TargetId
££ 
:
££ 
organizationId
££ (
,
££( )
Action
§§ 
:
§§ 
$str
§§ .
,
§§. /
	FieldName
•• 
:
•• 
$str
•• !
,
••! "

EntityType
¶¶ 
:
¶¶ 
null
¶¶  
,
¶¶  !
OldValueJson
ßß 
:
ßß 
System
ßß $
.
ßß$ %
Text
ßß% )
.
ßß) *
Json
ßß* .
.
ßß. /
JsonSerializer
ßß/ =
.
ßß= >
	Serialize
ßß> G
(
ßßG H
new
ßßH K
{
ßßL M
Name
ßßN R
=
ßßS T
previousName
ßßU a
}
ßßb c
)
ßßc d
,
ßßd e
NewValueJson
®® 
:
®® 
System
®® $
.
®®$ %
Text
®®% )
.
®®) *
Json
®®* .
.
®®. /
JsonSerializer
®®/ =
.
®®= >
	Serialize
®®> G
(
®®G H
new
®®H K
{
®®L M
Name
®®N R
=
®®S T
request
®®U \
.
®®\ ]
Name
®®] a
}
®®b c
)
®®c d
)
®®d e
,
®®e f
ct
©© 
)
©© 
;
©© 
}
™™ 	
}
´´ 
public
≠≠ 

async
≠≠ 
Task
≠≠ 
<
≠≠ 
List
≠≠ 
<
≠≠ )
OrganizationSearchResultDto
≠≠ 6
>
≠≠6 7
>
≠≠7 8
SearchAsync
≠≠9 D
(
≠≠D E
string
≠≠E K
query
≠≠L Q
,
≠≠Q R
CancellationToken
≠≠S d
ct
≠≠e g
=
≠≠h i
default
≠≠j q
)
≠≠q r
{
ÆÆ 
var
ØØ 
hits
ØØ 
=
ØØ 
await
ØØ $
organizationRepository
ØØ /
.
ØØ/ 0
SearchAsync
ØØ0 ;
(
ØØ; <
query
ØØ< A
,
ØØA B
ct
ØØC E
)
ØØE F
;
ØØF G
return
∞∞ 
hits
∞∞ 
.
±± 
Select
±± 
(
±± 
h
±± 
=>
±± 
new
±± )
OrganizationSearchResultDto
±± 8
(
±±8 9
h
±±9 :
.
±±: ;
Id
±±; =
,
±±= >
h
±±? @
.
±±@ A
Name
±±A E
,
±±E F
h
±±G H
.
±±H I
MemberCount
±±I T
,
±±T U
h
±±V W
.
±±W X

JoinPolicy
±±X b
)
±±b c
)
±±c d
.
≤≤ 
ToList
≤≤ 
(
≤≤ 
)
≤≤ 
;
≤≤ 
}
≥≥ 
public
µµ 

async
µµ 
Task
µµ 
<
µµ 
List
µµ 
<
µµ 
OrgMemberDto
µµ '
>
µµ' (
>
µµ( )
GetMembersAsync
µµ* 9
(
µµ9 :
int
µµ: =
organizationId
µµ> L
,
µµL M
int
µµN Q
userId
µµR X
,
µµX Y
CancellationToken
µµZ k
ct
µµl n
=
µµo p
default
µµq x
)
µµx y
{
∂∂ 
await
∑∑ 
	OrgAccess
∑∑ 
.
∑∑ 
RequireMembership
∑∑ )
(
∑∑) *!
orgMemberRepository
∑∑* =
,
∑∑= >
userId
∑∑? E
,
∑∑E F
organizationId
∑∑G U
,
∑∑U V
ct
∑∑W Y
)
∑∑Y Z
;
∑∑Z [
var
ππ 
members
ππ 
=
ππ 
await
ππ !
orgMemberRepository
ππ /
.
ππ/ 0&
GetByOrganizationIdAsync
ππ0 H
(
ππH I
organizationId
ππI W
,
ππW X
ct
ππY [
)
ππ[ \
;
ππ\ ]
return
∫∫ 
members
∫∫ 
.
ªª 
Where
ªª 
(
ªª 
m
ªª 
=>
ªª 
!
ªª 
m
ªª 
.
ªª 

IsArchived
ªª %
)
ªª% &
.
ºº 
Select
ºº 
(
ºº 
m
ºº 
=>
ºº 
new
ºº 
OrgMemberDto
ºº )
(
ºº) *
m
ΩΩ 
.
ΩΩ 
UserId
ΩΩ 
,
ΩΩ 
m
ææ 
.
ææ 
User
ææ 
.
ææ 
	FirstName
ææ  
,
ææ  !
m
øø 
.
øø 
User
øø 
.
øø 
LastName
øø 
,
øø  
m
¿¿ 
.
¿¿ 
User
¿¿ 
.
¿¿ 
Email
¿¿ 
,
¿¿ 
m
¡¡ 
.
¡¡ 
Role
¡¡ 
.
¡¡ 
Name
¡¡ 
,
¡¡ 
m
¬¬ 
.
¬¬ 
Role
¬¬ 
.
¬¬ 
DisplayName
¬¬ "
??
¬¬# %
DisplayNameHelper
¬¬& 7
.
¬¬7 8
Humanize
¬¬8 @
(
¬¬@ A
m
¬¬A B
.
¬¬B C
Role
¬¬C G
.
¬¬G H
Name
¬¬H L
)
¬¬L M
,
¬¬M N
m
√√ 
.
√√ 
JoinedAt
√√ 
)
√√ 
)
√√ 
.
ƒƒ 
ToList
ƒƒ 
(
ƒƒ 
)
ƒƒ 
;
ƒƒ 
}
≈≈ 
public
«« 

async
«« 
Task
«« 
RemoveMemberAsync
«« '
(
««' (
int
««( +
organizationId
««, :
,
««: ;
int
««< ?
targetUserId
««@ L
,
««L M
int
««N Q
callerUserId
««R ^
,
««^ _
CancellationToken
««` q
ct
««r t
=
««u v
default
««w ~
)
««~ 
{
»» 
if
…… 

(
…… 
targetUserId
…… 
==
…… 
callerUserId
…… (
)
……( )
{
   	
var
ÀÀ 

selfMember
ÀÀ 
=
ÀÀ 
await
ÀÀ "!
orgMemberRepository
ÀÀ# 6
.
ÀÀ6 7
GetAsync
ÀÀ7 ?
(
ÀÀ? @
targetUserId
ÀÀ@ L
,
ÀÀL M
organizationId
ÀÀN \
,
ÀÀ\ ]
ct
ÀÀ^ `
)
ÀÀ` a
??
ÃÃ 
throw
ÃÃ 
new
ÃÃ 
AppException
ÃÃ )
(
ÃÃ) *
$str
ÃÃ* A
,
ÃÃA B
$num
ÃÃC F
,
ÃÃF G
$str
ÃÃH {
)
ÃÃ{ |
;
ÃÃ| }
await
ŒŒ !
orgMemberRepository
ŒŒ %
.
ŒŒ% &
RemoveAsync
ŒŒ& 1
(
ŒŒ1 2

selfMember
ŒŒ2 <
,
ŒŒ< =
ct
ŒŒ> @
)
ŒŒ@ A
;
ŒŒA B
if
–– 
(
–– 
auditOutboxWriter
–– !
is
––" $
not
––% (
null
––) -
)
––- .
{
—— 
await
““ 
auditOutboxWriter
““ '
.
““' (
EnqueueAuditAsync
““( 9
(
““9 :
new
””  
AuditEventContract
”” &
(
””& '
EventId
‘‘ 
:
‘‘ 
Guid
‘‘ !
.
‘‘! "
NewGuid
‘‘" )
(
‘‘) *
)
‘‘* +
,
‘‘+ ,
SchemaVersion
’’ !
:
’’! "
$num
’’# $
,
’’$ %
OccurredAtUtc
÷÷ !
:
÷÷! "
DateTimeOffset
÷÷# 1
.
÷÷1 2
UtcNow
÷÷2 8
,
÷÷8 9
SourceService
◊◊ !
:
◊◊! "
$str
◊◊# )
,
◊◊) *
ActorUserId
ÿÿ 
:
ÿÿ  
callerUserId
ÿÿ! -
,
ÿÿ- .

AuditScope
ŸŸ 
:
ŸŸ 
AuditRouting
ŸŸ  ,
.
ŸŸ, -
ScopeOrganization
ŸŸ- >
,
ŸŸ> ?
TargetId
⁄⁄ 
:
⁄⁄ 
organizationId
⁄⁄ ,
,
⁄⁄, -
Action
€€ 
:
€€ 
$str
€€ 9
,
€€9 :
	FieldName
‹‹ 
:
‹‹ 
$str
‹‹ '
,
‹‹' (

EntityType
›› 
:
›› 
null
››  $
,
››$ %
OldValueJson
ﬁﬁ  
:
ﬁﬁ  !
System
ﬁﬁ" (
.
ﬁﬁ( )
Text
ﬁﬁ) -
.
ﬁﬁ- .
Json
ﬁﬁ. 2
.
ﬁﬁ2 3
JsonSerializer
ﬁﬁ3 A
.
ﬁﬁA B
	Serialize
ﬁﬁB K
(
ﬁﬁK L
new
ﬁﬁL O
{
ﬁﬁP Q
UserId
ﬁﬁR X
=
ﬁﬁY Z
targetUserId
ﬁﬁ[ g
}
ﬁﬁh i
)
ﬁﬁi j
,
ﬁﬁj k
NewValueJson
ﬂﬂ  
:
ﬂﬂ  !
null
ﬂﬂ" &
)
ﬂﬂ& '
,
ﬂﬂ' (
ct
‡‡ 
)
‡‡ 
;
‡‡ 
}
·· 
return
„„ 
;
„„ 
}
‰‰ 	
await
ÊÊ 
	OrgAccess
ÊÊ 
.
ÊÊ 
RequirePermission
ÊÊ )
(
ÊÊ) *!
orgMemberRepository
ÊÊ* =
,
ÊÊ= >
callerUserId
ÊÊ? K
,
ÊÊK L
organizationId
ÊÊM [
,
ÊÊ[ \
$str
ÊÊ] q
,
ÊÊq r
ct
ÊÊs u
)
ÊÊu v
;
ÊÊv w
var
ËË 
callerMembership
ËË 
=
ËË 
await
ËË $!
orgMemberRepository
ËË% 8
.
ËË8 9
GetAsync
ËË9 A
(
ËËA B
callerUserId
ËËB N
,
ËËN O
organizationId
ËËP ^
,
ËË^ _
ct
ËË` b
)
ËËb c
??
ÈÈ 
throw
ÈÈ 
new
ÈÈ 
AppException
ÈÈ %
(
ÈÈ% &
$str
ÈÈ& 6
,
ÈÈ6 7
$num
ÈÈ8 ;
,
ÈÈ; <
$str
ÈÈ= i
)
ÈÈi j
;
ÈÈj k
var
ÍÍ 
targetMember
ÍÍ 
=
ÍÍ 
await
ÍÍ  !
orgMemberRepository
ÍÍ! 4
.
ÍÍ4 5
GetAsync
ÍÍ5 =
(
ÍÍ= >
targetUserId
ÍÍ> J
,
ÍÍJ K
organizationId
ÍÍL Z
,
ÍÍZ [
ct
ÍÍ\ ^
)
ÍÍ^ _
??
ÎÎ 
throw
ÎÎ 
new
ÎÎ 
AppException
ÎÎ %
(
ÎÎ% &
$str
ÎÎ& =
,
ÎÎ= >
$num
ÎÎ? B
,
ÎÎB C
$str
ÎÎD w
)
ÎÎw x
;
ÎÎx y
if
ÌÌ 

(
ÌÌ 
callerMembership
ÌÌ 
.
ÌÌ 
Role
ÌÌ !
!
ÌÌ! "
.
ÌÌ" #
Priority
ÌÌ# +
>=
ÌÌ, .
targetMember
ÌÌ/ ;
.
ÌÌ; <
Role
ÌÌ< @
!
ÌÌ@ A
.
ÌÌA B
Priority
ÌÌB J
)
ÌÌJ K
{
ÓÓ 	
throw
ÔÔ 
new
ÔÔ 
AppException
ÔÔ "
(
ÔÔ" #
$str
ÔÔ# @
,
ÔÔ@ A
$num
ÔÔB E
,
ÔÔE F
$str
 ~
)
~ 
; Ä
}
ÒÒ 	
await
ÛÛ !
orgMemberRepository
ÛÛ !
.
ÛÛ! "
RemoveAsync
ÛÛ" -
(
ÛÛ- .
targetMember
ÛÛ. :
,
ÛÛ: ;
ct
ÛÛ< >
)
ÛÛ> ?
;
ÛÛ? @
if
ıı 

(
ıı 
auditOutboxWriter
ıı 
is
ıı  
not
ıı! $
null
ıı% )
)
ıı) *
{
ˆˆ 	
await
˜˜ 
auditOutboxWriter
˜˜ #
.
˜˜# $
EnqueueAuditAsync
˜˜$ 5
(
˜˜5 6
new
¯¯  
AuditEventContract
¯¯ "
(
¯¯" #
EventId
˘˘ 
:
˘˘ 
Guid
˘˘ 
.
˘˘ 
NewGuid
˘˘ %
(
˘˘% &
)
˘˘& '
,
˘˘' (
SchemaVersion
˙˙ 
:
˙˙ 
$num
˙˙  
,
˙˙  !
OccurredAtUtc
˚˚ 
:
˚˚ 
DateTimeOffset
˚˚ -
.
˚˚- .
UtcNow
˚˚. 4
,
˚˚4 5
SourceService
¸¸ 
:
¸¸ 
$str
¸¸ %
,
¸¸% &
ActorUserId
˝˝ 
:
˝˝ 
callerUserId
˝˝ )
,
˝˝) *

AuditScope
˛˛ 
:
˛˛ 
AuditRouting
˛˛ (
.
˛˛( )
ScopeOrganization
˛˛) :
,
˛˛: ;
TargetId
ˇˇ 
:
ˇˇ 
organizationId
ˇˇ (
,
ˇˇ( )
Action
ÄÄ 
:
ÄÄ 
$str
ÄÄ 5
,
ÄÄ5 6
	FieldName
ÅÅ 
:
ÅÅ 
$str
ÅÅ #
,
ÅÅ# $

EntityType
ÇÇ 
:
ÇÇ 
null
ÇÇ  
,
ÇÇ  !
OldValueJson
ÉÉ 
:
ÉÉ 
System
ÉÉ $
.
ÉÉ$ %
Text
ÉÉ% )
.
ÉÉ) *
Json
ÉÉ* .
.
ÉÉ. /
JsonSerializer
ÉÉ/ =
.
ÉÉ= >
	Serialize
ÉÉ> G
(
ÉÉG H
new
ÉÉH K
{
ÉÉL M
UserId
ÉÉN T
=
ÉÉU V
targetUserId
ÉÉW c
}
ÉÉd e
)
ÉÉe f
,
ÉÉf g
NewValueJson
ÑÑ 
:
ÑÑ 
null
ÑÑ "
)
ÑÑ" #
,
ÑÑ# $
ct
ÖÖ 
)
ÖÖ 
;
ÖÖ 
}
ÜÜ 	
}
áá 
public
ââ 

async
ââ 
Task
ââ #
ChangeMemberRoleAsync
ââ +
(
ââ+ ,
int
ââ, /
organizationId
ââ0 >
,
ââ> ?
int
ââ@ C
targetUserId
ââD P
,
ââP Q
int
ââR U
callerUserId
ââV b
,
ââb c(
ChangeOrgMemberRoleRequest
ââd ~
requestââ Ü
,ââÜ á!
CancellationTokenââà ô
ctââö ú
=ââù û
defaultââü ¶
)ââ¶ ß
{
ää 
await
ãã 
	OrgAccess
ãã 
.
ãã 
RequirePermission
ãã )
(
ãã) *!
orgMemberRepository
ãã* =
,
ãã= >
callerUserId
ãã? K
,
ããK L
organizationId
ããM [
,
ãã[ \
$str
ãã] o
,
ãão p
ct
ããq s
)
ããs t
;
ããt u
var
çç 
targetMember
çç 
=
çç 
await
çç  !
orgMemberRepository
çç! 4
.
çç4 5
GetAsync
çç5 =
(
çç= >
targetUserId
çç> J
,
ççJ K
organizationId
ççL Z
,
ççZ [
ct
çç\ ^
)
çç^ _
??
éé 
throw
éé 
new
éé 
AppException
éé %
(
éé% &
$str
éé& =
,
éé= >
$num
éé? B
,
ééB C
$str
ééD w
)
ééw x
;
ééx y
var
êê 
role
êê 
=
êê 
await
êê 
orgRoleRepository
êê *
.
êê* +
GetByIdAsync
êê+ 7
(
êê7 8
request
êê8 ?
.
êê? @
RoleId
êê@ F
,
êêF G
ct
êêH J
)
êêJ K
??
ëë 
throw
ëë 
new
ëë 
AppException
ëë %
(
ëë% &
$str
ëë& 6
,
ëë6 7
$num
ëë8 ;
,
ëë; <
$str
ëë= a
)
ëëa b
;
ëëb c
if
ìì 

(
ìì 
role
ìì 
.
ìì 
OrganizationId
ìì 
.
ìì  
HasValue
ìì  (
&&
ìì) +
role
ìì, 0
.
ìì0 1
OrganizationId
ìì1 ?
.
ìì? @
Value
ìì@ E
!=
ììF H
organizationId
ììI W
)
ììW X
throw
îî 
new
îî 
AppException
îî "
(
îî" #
$str
îî# =
,
îî= >
$num
îî? B
,
îîB C
$str
îîD ~
)
îî~ 
;îî Ä
targetMember
ññ 
.
ññ 
	OrgRoleId
ññ 
=
ññ  
role
ññ! %
.
ññ% &
Id
ññ& (
;
ññ( )
await
óó !
orgMemberRepository
óó !
.
óó! "
UpdateAsync
óó" -
(
óó- .
targetMember
óó. :
,
óó: ;
ct
óó< >
)
óó> ?
;
óó? @
if
ôô 

(
ôô 
auditOutboxWriter
ôô 
is
ôô  
not
ôô! $
null
ôô% )
)
ôô) *
{
öö 	
await
õõ 
auditOutboxWriter
õõ #
.
õõ# $
EnqueueAuditAsync
õõ$ 5
(
õõ5 6
new
úú  
AuditEventContract
úú "
(
úú" #
EventId
ùù 
:
ùù 
Guid
ùù 
.
ùù 
NewGuid
ùù %
(
ùù% &
)
ùù& '
,
ùù' (
SchemaVersion
ûû 
:
ûû 
$num
ûû  
,
ûû  !
OccurredAtUtc
üü 
:
üü 
DateTimeOffset
üü -
.
üü- .
UtcNow
üü. 4
,
üü4 5
SourceService
†† 
:
†† 
$str
†† %
,
††% &
ActorUserId
°° 
:
°° 
callerUserId
°° )
,
°°) *

AuditScope
¢¢ 
:
¢¢ 
AuditRouting
¢¢ (
.
¢¢( )
ScopeOrganization
¢¢) :
,
¢¢: ;
TargetId
££ 
:
££ 
organizationId
££ (
,
££( )
Action
§§ 
:
§§ 
$str
§§ :
,
§§: ;
	FieldName
•• 
:
•• 
$str
•• (
,
••( )

EntityType
¶¶ 
:
¶¶ 
null
¶¶  
,
¶¶  !
OldValueJson
ßß 
:
ßß 
null
ßß "
,
ßß" #
NewValueJson
®® 
:
®® 
System
®® $
.
®®$ %
Text
®®% )
.
®®) *
Json
®®* .
.
®®. /
JsonSerializer
®®/ =
.
®®= >
	Serialize
®®> G
(
®®G H
new
®®H K
{
®®L M
UserId
®®N T
=
®®U V
targetUserId
®®W c
,
®®c d
RoleId
®®e k
=
®®l m
role
®®n r
.
®®r s
Id
®®s u
}
®®v w
)
®®w x
)
®®x y
,
®®y z
ct
©© 
)
©© 
;
©© 
}
™™ 	
}
´´ 
public
≠≠ 

async
≠≠ 
Task
≠≠ 
<
≠≠ %
OrganizationSettingsDto
≠≠ -
>
≠≠- .
GetSettingsAsync
≠≠/ ?
(
≠≠? @
int
≠≠@ C
organizationId
≠≠D R
,
≠≠R S
int
≠≠T W
userId
≠≠X ^
,
≠≠^ _
CancellationToken
≠≠` q
ct
≠≠r t
=
≠≠u v
default
≠≠w ~
)
≠≠~ 
{
ÆÆ 
await
ØØ 
	OrgAccess
ØØ 
.
ØØ 
RequireMembership
ØØ )
(
ØØ) *!
orgMemberRepository
ØØ* =
,
ØØ= >
userId
ØØ? E
,
ØØE F
organizationId
ØØG U
,
ØØU V
ct
ØØW Y
)
ØØY Z
;
ØØZ [
var
±± 
settings
±± 
=
±± 
await
±± ,
organizationSettingsRepository
±± ;
.
±±; <&
GetByOrganizationIdAsync
±±< T
(
±±T U
organizationId
±±U c
,
±±c d
ct
±±e g
)
±±g h
??
≤≤ 
throw
≤≤ 
new
≤≤ 
AppException
≤≤ %
(
≤≤% &
$str
≤≤& G
,
≤≤G H
$num
≤≤I L
,
≤≤L M
$str
≤≤N p
)
≤≤p q
;
≤≤q r
var
¥¥ 
org
¥¥ 
=
¥¥ 
await
¥¥ $
organizationRepository
¥¥ .
.
¥¥. /
GetByIdAsync
¥¥/ ;
(
¥¥; <
organizationId
¥¥< J
,
¥¥J K
ct
¥¥L N
)
¥¥N O
??
µµ 
throw
µµ 
new
µµ 
AppException
µµ %
(
µµ% &
$str
µµ& >
,
µµ> ?
$num
µµ@ C
,
µµC D
$str
µµE ^
)
µµ^ _
;
µµ_ `
if
∑∑ 

(
∑∑ 
auditOutboxWriter
∑∑ 
is
∑∑  
not
∑∑! $
null
∑∑% )
)
∑∑) *
{
∏∏ 	
await
ππ 
auditOutboxWriter
ππ #
.
ππ# $
EnqueueAuditAsync
ππ$ 5
(
ππ5 6
new
∫∫  
AuditEventContract
∫∫ &
(
∫∫& '
EventId
ªª 
:
ªª 
Guid
ªª !
.
ªª! "
NewGuid
ªª" )
(
ªª) *
)
ªª* +
,
ªª+ ,
SchemaVersion
ºº !
:
ºº! "
$num
ºº# $
,
ºº$ %
OccurredAtUtc
ΩΩ !
:
ΩΩ! "
DateTimeOffset
ΩΩ# 1
.
ΩΩ1 2
UtcNow
ΩΩ2 8
,
ΩΩ8 9
SourceService
ææ !
:
ææ! "
$str
ææ# )
,
ææ) *
ActorUserId
øø 
:
øø  
userId
øø! '
,
øø' (

AuditScope
¿¿ 
:
¿¿ 
AuditRouting
¿¿  ,
.
¿¿, -
ScopeOrganization
¿¿- >
,
¿¿> ?
TargetId
¡¡ 
:
¡¡ 
organizationId
¡¡ ,
,
¡¡, -
Action
¬¬ 
:
¬¬ 
$str
¬¬ 8
,
¬¬8 9
	FieldName
√√ 
:
√√ 
null
√√ #
,
√√# $

EntityType
ƒƒ 
:
ƒƒ 
null
ƒƒ  $
,
ƒƒ$ %
OldValueJson
≈≈  
:
≈≈  !
null
≈≈" &
,
≈≈& '
NewValueJson
∆∆  
:
∆∆  !
null
∆∆" &
)
∆∆& '
,
∆∆' (
ct
«« 
)
«« 
;
«« 
}
»» 	
return
   
new
   %
OrganizationSettingsDto
   *
(
  * +
settings
ÀÀ 
.
ÀÀ 
OrganizationId
ÀÀ #
,
ÀÀ# $
org
ÃÃ 
.
ÃÃ 
Name
ÃÃ 
,
ÃÃ 
settings
ÕÕ 
.
ÕÕ 
Description
ÕÕ  
,
ÕÕ  !
settings
ŒŒ 
.
ŒŒ 

JoinPolicy
ŒŒ 
,
ŒŒ  
settings
œœ 
.
œœ 
DefaultOrgRoleId
œœ %
,
œœ% &
settings
–– 
.
–– 
DefaultOrgRole
–– #
?
––# $
.
––$ %
Name
––% )
)
––) *
;
––* +
}
—— 
public
”” 

async
”” 
Task
”” !
UpdateSettingsAsync
”” )
(
””) *
int
””* -
organizationId
””. <
,
””< =
int
””> A
userId
””B H
,
””H I/
!UpdateOrganizationSettingsRequest
””J k
request
””l s
,
””s t 
CancellationToken””u Ü
ct””á â
=””ä ã
default””å ì
)””ì î
{
‘‘ 
await
’’ %
updateSettingsValidator
’’ %
.
’’% &#
ValidateAndThrowAsync
’’& ;
(
’’; <
request
’’< C
,
’’C D
ct
’’E G
)
’’G H
;
’’H I
await
÷÷ 
	OrgAccess
÷÷ 
.
÷÷ 
RequirePermission
÷÷ )
(
÷÷) *!
orgMemberRepository
÷÷* =
,
÷÷= >
userId
÷÷? E
,
÷÷E F
organizationId
÷÷G U
,
÷÷U V%
OrganizationPermissions
÷÷W n
.
÷÷n o 
ManageOrgSettings÷÷o Ä
,÷÷Ä Å
ct÷÷Ç Ñ
)÷÷Ñ Ö
;÷÷Ö Ü
var
ÿÿ 
settings
ÿÿ 
=
ÿÿ 
await
ÿÿ ,
organizationSettingsRepository
ÿÿ ;
.
ÿÿ; <&
GetByOrganizationIdAsync
ÿÿ< T
(
ÿÿT U
organizationId
ÿÿU c
,
ÿÿc d
ct
ÿÿe g
)
ÿÿg h
??
ŸŸ 
throw
ŸŸ 
new
ŸŸ 
AppException
ŸŸ %
(
ŸŸ% &
$str
ŸŸ& G
,
ŸŸG H
$num
ŸŸI L
,
ŸŸL M
$str
ŸŸN p
)
ŸŸp q
;
ŸŸq r
var
€€ 
org
€€ 
=
€€ 
await
€€ $
organizationRepository
€€ .
.
€€. /
GetByIdAsync
€€/ ;
(
€€; <
organizationId
€€< J
,
€€J K
ct
€€L N
)
€€N O
??
‹‹ 
throw
‹‹ 
new
‹‹ 
AppException
‹‹ %
(
‹‹% &
$str
‹‹& >
,
‹‹> ?
$num
‹‹@ C
,
‹‹C D
$str
‹‹E ^
)
‹‹^ _
;
‹‹_ `
if
ﬁﬁ 

(
ﬁﬁ 
request
ﬁﬁ 
.
ﬁﬁ 
DefaultOrgRoleId
ﬁﬁ $
.
ﬁﬁ$ %
HasValue
ﬁﬁ% -
)
ﬁﬁ- .
{
ﬂﬂ 	
var
‡‡ 
role
‡‡ 
=
‡‡ 
await
‡‡ 
orgRoleRepository
‡‡ .
.
‡‡. /
GetByIdAsync
‡‡/ ;
(
‡‡; <
request
‡‡< C
.
‡‡C D
DefaultOrgRoleId
‡‡D T
.
‡‡T U
Value
‡‡U Z
,
‡‡Z [
ct
‡‡\ ^
)
‡‡^ _
;
‡‡_ `
if
·· 
(
·· 
role
·· 
is
·· 
null
·· 
)
·· 
throw
‚‚ 
new
‚‚ 
AppException
‚‚ &
(
‚‚& '
$str
‚‚' C
,
‚‚C D
$num
‚‚E H
,
‚‚H I
$str
‚‚J z
)
‚‚z {
;
‚‚{ |
if
„„ 
(
„„ 
role
„„ 
.
„„ 
OrganizationId
„„ #
.
„„# $
HasValue
„„$ ,
&&
„„- /
role
„„0 4
.
„„4 5
OrganizationId
„„5 C
.
„„C D
Value
„„D I
!=
„„J L
organizationId
„„M [
)
„„[ \
throw
‰‰ 
new
‰‰ 
AppException
‰‰ &
(
‰‰& '
$str
‰‰' D
,
‰‰D E
$num
‰‰F I
,
‰‰I J
$str‰‰K ë
)‰‰ë í
;‰‰í ì
}
ÂÂ 	
var
ÁÁ 
oldJson
ÁÁ 
=
ÁÁ 
JsonSerializer
ÁÁ $
.
ÁÁ$ %
	Serialize
ÁÁ% .
(
ÁÁ. /
new
ÁÁ/ 2
{
ËË 	
org
ÈÈ 
.
ÈÈ 
Name
ÈÈ 
,
ÈÈ 
settings
ÍÍ 
.
ÍÍ 
Description
ÍÍ  
,
ÍÍ  !
settings
ÎÎ 
.
ÎÎ 

JoinPolicy
ÎÎ 
,
ÎÎ  
settings
ÏÏ 
.
ÏÏ 
DefaultOrgRoleId
ÏÏ %
}
ÌÌ 	
)
ÌÌ	 

;
ÌÌ
 
org
ÔÔ 
.
ÔÔ 
Name
ÔÔ 
=
ÔÔ 
request
ÔÔ 
.
ÔÔ 
Name
ÔÔ 
;
ÔÔ  
settings
 
.
 
Description
 
=
 
request
 &
.
& '
Description
' 2
;
2 3
settings
ÒÒ 
.
ÒÒ 

JoinPolicy
ÒÒ 
=
ÒÒ 
request
ÒÒ %
.
ÒÒ% &

JoinPolicy
ÒÒ& 0
;
ÒÒ0 1
settings
ÚÚ 
.
ÚÚ 
DefaultOrgRoleId
ÚÚ !
=
ÚÚ" #
request
ÚÚ$ +
.
ÚÚ+ ,
DefaultOrgRoleId
ÚÚ, <
;
ÚÚ< =
await
ÙÙ $
organizationRepository
ÙÙ $
.
ÙÙ$ %
UpdateAsync
ÙÙ% 0
(
ÙÙ0 1
org
ÙÙ1 4
,
ÙÙ4 5
ct
ÙÙ6 8
)
ÙÙ8 9
;
ÙÙ9 :
await
ıı ,
organizationSettingsRepository
ıı ,
.
ıı, -
UpdateAsync
ıı- 8
(
ıı8 9
settings
ıı9 A
,
ııA B
ct
ııC E
)
ııE F
;
ııF G
if
˜˜ 

(
˜˜ 
auditOutboxWriter
˜˜ 
is
˜˜  
not
˜˜! $
null
˜˜% )
)
˜˜) *
{
¯¯ 	
await
˘˘ 
auditOutboxWriter
˘˘ #
.
˘˘# $
EnqueueAuditAsync
˘˘$ 5
(
˘˘5 6
new
˙˙  
AuditEventContract
˙˙ &
(
˙˙& '
EventId
˚˚ 
:
˚˚ 
Guid
˚˚ !
.
˚˚! "
NewGuid
˚˚" )
(
˚˚) *
)
˚˚* +
,
˚˚+ ,
SchemaVersion
¸¸ !
:
¸¸! "
$num
¸¸# $
,
¸¸$ %
OccurredAtUtc
˝˝ !
:
˝˝! "
DateTimeOffset
˝˝# 1
.
˝˝1 2
UtcNow
˝˝2 8
,
˝˝8 9
SourceService
˛˛ !
:
˛˛! "
$str
˛˛# )
,
˛˛) *
ActorUserId
ˇˇ 
:
ˇˇ  
userId
ˇˇ! '
,
ˇˇ' (

AuditScope
ÄÄ 
:
ÄÄ 
AuditRouting
ÄÄ  ,
.
ÄÄ, -
ScopeOrganization
ÄÄ- >
,
ÄÄ> ?
TargetId
ÅÅ 
:
ÅÅ 
organizationId
ÅÅ ,
,
ÅÅ, -
Action
ÇÇ 
:
ÇÇ 
$str
ÇÇ ;
,
ÇÇ; <
	FieldName
ÉÉ 
:
ÉÉ 
null
ÉÉ #
,
ÉÉ# $

EntityType
ÑÑ 
:
ÑÑ 
null
ÑÑ  $
,
ÑÑ$ %
OldValueJson
ÖÖ  
:
ÖÖ  !
oldJson
ÖÖ" )
,
ÖÖ) *
NewValueJson
ÜÜ  
:
ÜÜ  !
JsonSerializer
ÜÜ" 0
.
ÜÜ0 1
	Serialize
ÜÜ1 :
(
ÜÜ: ;
new
ÜÜ; >
{
áá 
request
àà 
.
àà  
Name
àà  $
,
àà$ %
request
ââ 
.
ââ  
Description
ââ  +
,
ââ+ ,
request
ää 
.
ää  

JoinPolicy
ää  *
,
ää* +
request
ãã 
.
ãã  
DefaultOrgRoleId
ãã  0
}
åå 
)
åå 
)
åå 
,
åå 
ct
çç 
)
çç 
;
çç 
var
èè 
sagaId
èè 
=
èè 
Guid
èè 
.
èè 
NewGuid
èè %
(
èè% &
)
èè& '
;
èè' (
await
êê 
auditOutboxWriter
êê #
.
êê# $ 
EnqueueDomainAsync
êê$ 6
(
êê6 7
DomainRouting
ëë 
.
ëë (
RoutingKeyCoreOrganization
ëë 8
(
ëë8 9
DomainRouting
ëë9 F
.
ëëF G1
#CoreOrganizationVerbSettingsUpdated
ëëG j
)
ëëj k
,
ëëk l
new
íí #
DomainMessageEnvelope
íí )
(
íí) *
SchemaVersion
ìì !
:
ìì! "%
MessagingSchemaVersions
ìì# :
.
ìì: ;
V1
ìì; =
,
ìì= >
	MessageId
îî 
:
îî 
Guid
îî #
.
îî# $
NewGuid
îî$ +
(
îî+ ,
)
îî, -
,
îî- .
CorrelationId
ïï !
:
ïï! "
sagaId
ïï# )
,
ïï) *
SagaInstanceId
ññ "
:
ññ" #
sagaId
ññ$ *
,
ññ* +
CausationId
óó 
:
óó  
null
óó! %
,
óó% &
OccurredAtUtc
òò !
:
òò! "
DateTimeOffset
òò# 1
.
òò1 2
UtcNow
òò2 8
,
òò8 9
SourceService
ôô !
:
ôô! "
$str
ôô# )
,
ôô) *
PayloadTypeName
öö #
:
öö# $ 
DomainPayloadTypes
öö% 7
.
öö7 8+
OrganizationSettingsUpdatedV1
öö8 U
,
ööU V
PayloadJson
õõ 
:
õõ  
JsonSerializer
õõ! /
.
õõ/ 0
	Serialize
õõ0 9
(
õõ9 :
new
õõ: =2
$OrganizationSettingsUpdatedPayloadV1
õõ> b
(
õõb c
organizationId
õõc q
,
õõq r
userId
õõs y
)
õõy z
)
õõz {
)
õõ{ |
,
õõ| }
ct
úú 
)
úú 
;
úú 
}
ùù 	
}
ûû 
}†† ü
`C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Services\OrgAccess.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
Services$ ,
;, -
public 
static 
class 
	OrgAccess 
{ 
public		 

static		 
async		 
Task		 
<		  
UserRoleOrganization		 1
>		1 2
RequireMembership		3 D
(		D E+
IUserRoleOrganizationRepository

 '

repository

( 2
,

2 3
int 
userId 
, 
int 
orgId 
, 
CancellationToken 
ct 
) 
{ 
return 
await 

repository 
.  
GetAsync  (
(( )
userId) /
,/ 0
orgId1 6
,6 7
ct8 :
): ;
?? 
throw 
new 
AppException %
(% &
$str& 6
,6 7
$num8 ;
,; <
$str= i
)i j
;j k
} 
public 

static 
async 
Task 
RequirePermission .
(. /+
IUserRoleOrganizationRepository '

repository( 2
,2 3
int 
userId 
, 
int 
orgId 
, 
string 

permission 
, 
CancellationToken 
ct 
) 
{ 
var 

membership 
= 
await 
RequireMembership 0
(0 1

repository1 ;
,; <
userId= C
,C D
orgIdE J
,J K
ctL N
)N O
;O P
var 
hasPermission 
= 

membership &
.& '
Role' +
?+ ,
., -
RolePermissions- <
. 
Any 
( 
rp 
=> 
rp 
. 

Permission $
?$ %
.% &
Name& *
==+ -

permission. 8
)8 9
??: <
false= B
;B C
if 

( 
! 
hasPermission 
) 
throw 
new 
AppException "
(" #
$str# 6
,6 7
$num8 ;
,; <
$"= ?
$str? T
{T U

permissionU _
}_ `
$str	` Ç
"
Ç É
)
É Ñ
;
Ñ Ö
} 
}   «Ì
iC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Services\JoinRequestService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
Services$ ,
;, -
public

 
sealed

 
class

 
JoinRequestService

 &
(

& '"
IJoinRequestRepository !
joinRequestRepository 0
,0 1+
IUserRoleOrganizationRepository #
orgMemberRepository$ 7
,7 8'
IOrganizationRoleRepository 
orgRoleRepository  1
,1 2#
IOrganizationRepository "
organizationRepository 2
,2 3+
IOrganizationSettingsRepository #*
organizationSettingsRepository$ B
,B C
IOutboxWriter 
? 
auditOutboxWriter $
=% &
null' +
)+ ,
:- .
IJoinRequestService/ B
{ 
public 

async 
Task 
< 
JoinRequestDto $
>$ %
SubmitAsync& 1
(1 2
int2 5
organizationId6 D
,D E
intF I
userIdJ P
,P Q$
CreateJoinRequestRequestR j
requestk r
,r s
CancellationToken	t Ö
ct
Ü à
=
â ä
default
ã í
)
í ì
{ 
var 
organization 
= 
await  "
organizationRepository! 7
.7 8
GetByIdAsync8 D
(D E
organizationIdE S
,S T
ctU W
)W X
?? 
throw 
new 
AppException %
(% &
$str& >
,> ?
$num@ C
,C D
$strE ^
)^ _
;_ `
if 

( 
organization 
. 

IsArchived #
)# $
throw 
new 
AppException "
(" #
$str# :
,: ;
$num< ?
,? @
$strA a
)a b
;b c
var 
orgSettings 
= 
await *
organizationSettingsRepository  >
.> ?$
GetByOrganizationIdAsync? W
(W X
organizationIdX f
,f g
cth j
)j k
;k l
if 

( 
orgSettings 
? 
. 

JoinPolicy #
==$ &
$str' 4
)4 5
throw 
new 
AppException "
(" #
$str# <
,< =
$num> A
,A B
$strC v
)v w
;w x
var 
existingMembership 
=  
await! &
orgMemberRepository' :
.: ;
GetAsync; C
(C D
userIdD J
,J K
organizationIdL Z
,Z [
ct\ ^
)^ _
;_ `
if 

( 
existingMembership 
is !
not" %
null& *
)* +
throw   
new   
AppException   "
(  " #
$str  # 7
,  7 8
$num  9 <
,  < =
$str  > n
)  n o
;  o p
var"" 
existingRequest"" 
="" 
await"" #!
joinRequestRepository""$ 9
.""9 :
GetPendingAsync"": I
(""I J
userId""J P
,""P Q
organizationId""R `
,""` a
ct""b d
)""d e
;""e f
if## 

(## 
existingRequest## 
is## 
not## "
null### '
)##' (
throw$$ 
new$$ 
AppException$$ "
($$" #
$str$$# 9
,$$9 :
$num$$; >
,$$> ?
$str	$$@ Ä
)
$$Ä Å
;
$$Å Ç
var&& 
joinRequest&& 
=&& 
new&& #
OrganizationJoinRequest&& 5
{'' 	
UserId(( 
=(( 
userId(( 
,(( 
OrganizationId)) 
=)) 
organizationId)) +
,))+ ,
Message** 
=** 
request** 
.** 
Message** %
,**% &
Status++ 
=++ 
$str++ 
,++ 
	CreatedAt,, 
=,, 
DateTime,,  
.,,  !
UtcNow,,! '
}-- 	
;--	 

await// !
joinRequestRepository// #
.//# $
AddAsync//$ ,
(//, -
joinRequest//- 8
,//8 9
ct//: <
)//< =
;//= >
if00 

(00 
auditOutboxWriter00 
is00  
not00! $
null00% )
)00) *
{11 	
await22 
auditOutboxWriter22 #
.22# $
EnqueueAuditAsync22$ 5
(225 6
new33 
AuditEventContract33 &
(33& '
EventId44 
:44 
Guid44 !
.44! "
NewGuid44" )
(44) *
)44* +
,44+ ,
SchemaVersion55 !
:55! "
$num55# $
,55$ %
OccurredAtUtc66 !
:66! "
DateTimeOffset66# 1
.661 2
UtcNow662 8
,668 9
SourceService77 !
:77! "
$str77# )
,77) *
ActorUserId88 
:88  
userId88! '
,88' (

AuditScope99 
:99 
AuditRouting99  ,
.99, -
ScopeOrganization99- >
,99> ?
TargetId:: 
::: 
organizationId:: ,
,::, -
Action;; 
:;; 
$str;; A
,;;A B
	FieldName<< 
:<< 
$str<< ;
,<<; <

EntityType== 
:== 
null==  $
,==$ %
OldValueJson>>  
:>>  !
null>>" &
,>>& '
NewValueJson??  
:??  !
System??" (
.??( )
Text??) -
.??- .
Json??. 2
.??2 3
JsonSerializer??3 A
.??A B
	Serialize??B K
(??K L
new??L O
{??P Q
joinRequest??R ]
.??] ^
Id??^ `
,??` a
joinRequest??b m
.??m n
Message??n u
}??v w
)??w x
)??x y
,??y z
ct@@ 
)@@ 
;@@ 
}AA 	
returnCC 
newCC 
JoinRequestDtoCC !
(CC! "
joinRequestDD 
.DD 
IdDD 
,DD 
joinRequestEE 
.EE 
UserIdEE 
,EE 
joinRequestFF 
.FF 
UserFF 
isFF 
notFF  #
nullFF$ (
?FF) *
$"FF+ -
{FF- .
joinRequestFF. 9
.FF9 :
UserFF: >
.FF> ?
	FirstNameFF? H
}FFH I
$strFFI J
{FFJ K
joinRequestFFK V
.FFV W
UserFFW [
.FF[ \
LastNameFF\ d
}FFd e
"FFe f
.FFf g
TrimFFg k
(FFk l
)FFl m
:FFn o
stringFFp v
.FFv w
EmptyFFw |
,FF| }
joinRequestGG 
.GG 
UserGG 
?GG 
.GG 
EmailGG #
??GG$ &
stringGG' -
.GG- .
EmptyGG. 3
,GG3 4
joinRequestHH 
.HH 
MessageHH 
,HH  
joinRequestII 
.II 
StatusII 
,II 
joinRequestJJ 
.JJ 
	CreatedAtJJ !
,JJ! "
nullKK 
,KK 
nullLL 
,LL 
organizationIdMM 
,MM 
organizationNN 
.NN 
NameNN 
)NN 
;NN 
}OO 
publicQQ 

asyncQQ 
TaskQQ 
<QQ 
ListQQ 
<QQ 
JoinRequestDtoQQ )
>QQ) *
>QQ* +"
GetByOrganizationAsyncQQ, B
(QQB C
intQQC F
organizationIdQQG U
,QQU V
intQQW Z
callerUserIdQQ[ g
,QQg h
CancellationTokenQQi z
ctQQ{ }
=QQ~ 
default
QQÄ á
)
QQá à
{RR 
awaitSS 
	OrgAccessSS 
.SS 
RequirePermissionSS )
(SS) *
orgMemberRepositorySS* =
,SS= >
callerUserIdSS? K
,SSK L
organizationIdSSM [
,SS[ \
$strSS] s
,SSs t
ctSSu w
)SSw x
;SSx y
varUU 
requestsUU 
=UU 
awaitUU !
joinRequestRepositoryUU 2
.UU2 3$
GetByOrganizationIdAsyncUU3 K
(UUK L
organizationIdUUL Z
,UUZ [
ctUU\ ^
)UU^ _
;UU_ `
returnVV 
requestsVV 
.WW 
WhereWW 
(WW 
rWW 
=>WW 
rWW 
.WW 
StatusWW  
==WW! #
$strWW$ -
)WW- .
.XX 
SelectXX 
(XX 
rXX 
=>XX 
newXX 
JoinRequestDtoXX +
(XX+ ,
rYY 
.YY 
IdYY 
,YY 
rZZ 
.ZZ 
UserIdZZ 
,ZZ 
r[[ 
.[[ 
User[[ 
is[[ 
not[[ 
null[[ "
?[[# $
$"[[% '
{[[' (
r[[( )
.[[) *
User[[* .
.[[. /
	FirstName[[/ 8
}[[8 9
$str[[9 :
{[[: ;
r[[; <
.[[< =
User[[= A
.[[A B
LastName[[B J
}[[J K
"[[K L
.[[L M
Trim[[M Q
([[Q R
)[[R S
:[[T U
string[[V \
.[[\ ]
Empty[[] b
,[[b c
r\\ 
.\\ 
User\\ 
?\\ 
.\\ 
Email\\ 
??\\  
string\\! '
.\\' (
Empty\\( -
,\\- .
r]] 
.]] 
Message]] 
,]] 
r^^ 
.^^ 
Status^^ 
,^^ 
r__ 
.__ 
	CreatedAt__ 
,__ 
r`` 
.`` 

ReviewedBy`` 
is`` 
not``  #
null``$ (
?``) *
$"``+ -
{``- .
r``. /
.``/ 0

ReviewedBy``0 :
.``: ;
	FirstName``; D
}``D E
$str``E F
{``F G
r``G H
.``H I

ReviewedBy``I S
.``S T
LastName``T \
}``\ ]
"``] ^
.``^ _
Trim``_ c
(``c d
)``d e
:``f g
null``h l
,``l m
raa 
.aa 

ReviewedAtaa 
,aa 
rbb 
.bb 
OrganizationIdbb  
,bb  !
rcc 
.cc 
Organizationcc 
?cc 
.cc  
Namecc  $
??cc% '
stringcc( .
.cc. /
Emptycc/ 4
)cc4 5
)cc5 6
.dd 
ToListdd 
(dd 
)dd 
;dd 
}ee 
publicgg 

asyncgg 
Taskgg 
ReviewAsyncgg !
(gg! "
intgg" %
organizationIdgg& 4
,gg4 5
intgg6 9
	requestIdgg: C
,ggC D
intggE H
callerUserIdggI U
,ggU V$
ReviewJoinRequestRequestggW o
requestggp w
,ggw x
CancellationToken	ggy ä
ct
ggã ç
=
ggé è
default
ggê ó
)
ggó ò
{hh 
awaitii 
	OrgAccessii 
.ii 
RequirePermissionii )
(ii) *
orgMemberRepositoryii* =
,ii= >
callerUserIdii? K
,iiK L
organizationIdiiM [
,ii[ \
$strii] s
,iis t
ctiiu w
)iiw x
;iix y
varkk 
joinRequestkk 
=kk 
awaitkk !
joinRequestRepositorykk  5
.kk5 6
GetByIdAsynckk6 B
(kkB C
	requestIdkkC L
,kkL M
ctkkN P
)kkP Q
??ll 
throwll 
newll 
AppExceptionll %
(ll% &
$strll& >
,ll> ?
$numll@ C
,llC D
$strllE ^
)ll^ _
;ll_ `
ifnn 

(nn 
joinRequestnn 
.nn 
OrganizationIdnn &
!=nn' )
organizationIdnn* 8
)nn8 9
throwoo 
newoo 
AppExceptionoo "
(oo" #
$stroo# ;
,oo; <
$numoo= @
,oo@ A
$strooB p
)oop q
;ooq r
ifqq 

(qq 
joinRequestqq 
.qq 
Statusqq 
!=qq !
$strqq" +
)qq+ ,
throwrr 
newrr 
AppExceptionrr "
(rr" #
$strrr# =
,rr= >
$numrr? B
,rrB C
$"rrD F
$strrrF q
{rrq r
joinRequestrrr }
.rr} ~
Status	rr~ Ñ
}
rrÑ Ö
$str
rrÖ á
"
rrá à
)
rrà â
;
rrâ ä
iftt 

(tt 
requesttt 
.tt 
Decisiontt 
==tt 
$strtt  *
)tt* +
{uu 	
varvv 
existingMembershipvv "
=vv# $
awaitvv% *
orgMemberRepositoryvv+ >
.vv> ?
GetAsyncvv? G
(vvG H
joinRequestvvH S
.vvS T
UserIdvvT Z
,vvZ [
organizationIdvv\ j
,vvj k
ctvvl n
)vvn o
;vvo p
ifww 
(ww 
existingMembershipww "
isww# %
notww& )
nullww* .
)ww. /
throwxx 
newxx 
AppExceptionxx &
(xx& '
$strxx' ;
,xx; <
$numxx= @
,xx@ A
$strxxB {
)xx{ |
;xx| }
varzz 
settingszz 
=zz 
awaitzz  *
organizationSettingsRepositoryzz! ?
.zz? @$
GetByOrganizationIdAsynczz@ X
(zzX Y
organizationIdzzY g
,zzg h
ctzzi k
)zzk l
;zzl m
var{{ 

memberRole{{ 
={{ 
settings{{ %
?{{% &
.{{& '
DefaultOrgRoleId{{' 7
.{{7 8
HasValue{{8 @
=={{A C
true{{D H
?|| 
await|| 
orgRoleRepository|| )
.||) *
GetByIdAsync||* 6
(||6 7
settings||7 ?
.||? @
DefaultOrgRoleId||@ P
.||P Q
Value||Q V
,||V W
ct||X Z
)||Z [
??}} 
throw}} 
new}}  
AppException}}! -
(}}- .
$str}}. J
,}}J K
$num}}L O
,}}O P
$str}}Q y
)}}y z
:~~ 
(~~ 
(~~ 
await~~ 
orgRoleRepository~~ +
.~~+ ,
GetSystemRolesAsync~~, ?
(~~? @
ct~~@ B
)~~B C
)~~C D
??~~E G
[~~H I
]~~I J
)~~J K
. 
OrderByDescending &
(& '
r' (
=>) +
r, -
.- .
Priority. 6
)6 7
.
ÄÄ 
ThenBy
ÄÄ 
(
ÄÄ 
r
ÄÄ 
=>
ÄÄ  
r
ÄÄ! "
.
ÄÄ" #
Id
ÄÄ# %
)
ÄÄ% &
.
ÅÅ 
FirstOrDefault
ÅÅ #
(
ÅÅ# $
)
ÅÅ$ %
??
ÇÇ 
throw
ÇÇ 
new
ÇÇ  
AppException
ÇÇ! -
(
ÇÇ- .
$str
ÇÇ. J
,
ÇÇJ K
$num
ÇÇL O
,
ÇÇO P
$str
ÇÇQ ~
)
ÇÇ~ 
;ÇÇ Ä
var
ÑÑ 

membership
ÑÑ 
=
ÑÑ 
new
ÑÑ  "
UserRoleOrganization
ÑÑ! 5
{
ÖÖ 
UserId
ÜÜ 
=
ÜÜ 
joinRequest
ÜÜ $
.
ÜÜ$ %
UserId
ÜÜ% +
,
ÜÜ+ ,
OrganizationId
áá 
=
áá  
organizationId
áá! /
,
áá/ 0
	OrgRoleId
àà 
=
àà 

memberRole
àà &
.
àà& '
Id
àà' )
,
àà) *
JoinedAt
ââ 
=
ââ 
DateTime
ââ #
.
ââ# $
UtcNow
ââ$ *
,
ââ* +

IsArchived
ää 
=
ää 
false
ää "
}
ãã 
;
ãã 
await
çç !
orgMemberRepository
çç %
.
çç% &
AddAsync
çç& .
(
çç. /

membership
çç/ 9
,
çç9 :
ct
çç; =
)
çç= >
;
çç> ?
if
éé 
(
éé 
auditOutboxWriter
éé !
is
éé" $
not
éé% (
null
éé) -
)
éé- .
{
èè 
await
êê 
auditOutboxWriter
êê '
.
êê' (
EnqueueAuditAsync
êê( 9
(
êê9 :
new
ëë  
AuditEventContract
ëë *
(
ëë* +
EventId
íí 
:
íí  
Guid
íí! %
.
íí% &
NewGuid
íí& -
(
íí- .
)
íí. /
,
íí/ 0
SchemaVersion
ìì %
:
ìì% &
$num
ìì' (
,
ìì( )
OccurredAtUtc
îî %
:
îî% &
DateTimeOffset
îî' 5
.
îî5 6
UtcNow
îî6 <
,
îî< =
SourceService
ïï %
:
ïï% &
$str
ïï' -
,
ïï- .
ActorUserId
ññ #
:
ññ# $
callerUserId
ññ% 1
,
ññ1 2

AuditScope
óó "
:
óó" #
AuditRouting
óó$ 0
.
óó0 1
ScopeOrganization
óó1 B
,
óóB C
TargetId
òò  
:
òò  !
organizationId
òò" 0
,
òò0 1
Action
ôô 
:
ôô 
$str
ôô  L
,
ôôL M
	FieldName
öö !
:
öö! "
$str
öö# ;
,
öö; <

EntityType
õõ "
:
õõ" #
null
õõ$ (
,
õõ( )
OldValueJson
úú $
:
úú$ %
null
úú& *
,
úú* +
NewValueJson
ùù $
:
ùù$ %
System
ùù& ,
.
ùù, -
Text
ùù- 1
.
ùù1 2
Json
ùù2 6
.
ùù6 7
JsonSerializer
ùù7 E
.
ùùE F
	Serialize
ùùF O
(
ùùO P
new
ùùP S
{
ùùT U
joinRequest
ùùV a
.
ùùa b
UserId
ùùb h
,
ùùh i
RoleId
ùùj p
=
ùùq r

memberRole
ùùs }
.
ùù} ~
Idùù~ Ä
}ùùÅ Ç
)ùùÇ É
)ùùÉ Ñ
,ùùÑ Ö
ct
ûû 
)
ûû 
;
ûû 
}
üü 
}
†† 	
else
°° 
if
°° 
(
°° 
request
°° 
.
°° 
Decision
°° !
!=
°°" $
$str
°°% /
)
°°/ 0
{
¢¢ 	
throw
££ 
new
££ 
AppException
££ "
(
££" #
$str
££# 5
,
££5 6
$num
££7 :
,
££: ;
$str
££< h
)
££h i
;
££i j
}
§§ 	
joinRequest
¶¶ 
.
¶¶ 
Status
¶¶ 
=
¶¶ 
request
¶¶ $
.
¶¶$ %
Decision
¶¶% -
;
¶¶- .
joinRequest
ßß 
.
ßß 
ReviewedByUserId
ßß $
=
ßß% &
callerUserId
ßß' 3
;
ßß3 4
joinRequest
®® 
.
®® 

ReviewedAt
®® 
=
®®  
DateTime
®®! )
.
®®) *
UtcNow
®®* 0
;
®®0 1
await
©© #
joinRequestRepository
©© #
.
©©# $
UpdateAsync
©©$ /
(
©©/ 0
joinRequest
©©0 ;
,
©©; <
ct
©©= ?
)
©©? @
;
©©@ A
if
™™ 

(
™™ 
auditOutboxWriter
™™ 
is
™™  
not
™™! $
null
™™% )
)
™™) *
{
´´ 	
await
¨¨ 
auditOutboxWriter
¨¨ #
.
¨¨# $
EnqueueAuditAsync
¨¨$ 5
(
¨¨5 6
new
≠≠  
AuditEventContract
≠≠ &
(
≠≠& '
EventId
ÆÆ 
:
ÆÆ 
Guid
ÆÆ !
.
ÆÆ! "
NewGuid
ÆÆ" )
(
ÆÆ) *
)
ÆÆ* +
,
ÆÆ+ ,
SchemaVersion
ØØ !
:
ØØ! "
$num
ØØ# $
,
ØØ$ %
OccurredAtUtc
∞∞ !
:
∞∞! "
DateTimeOffset
∞∞# 1
.
∞∞1 2
UtcNow
∞∞2 8
,
∞∞8 9
SourceService
±± !
:
±±! "
$str
±±# )
,
±±) *
ActorUserId
≤≤ 
:
≤≤  
callerUserId
≤≤! -
,
≤≤- .

AuditScope
≥≥ 
:
≥≥ 
AuditRouting
≥≥  ,
.
≥≥, -
ScopeOrganization
≥≥- >
,
≥≥> ?
TargetId
¥¥ 
:
¥¥ 
organizationId
¥¥ ,
,
¥¥, -
Action
µµ 
:
µµ 
$str
µµ @
,
µµ@ A
	FieldName
∂∂ 
:
∂∂ 
$str
∂∂ B
,
∂∂B C

EntityType
∑∑ 
:
∑∑ 
null
∑∑  $
,
∑∑$ %
OldValueJson
∏∏  
:
∏∏  !
System
∏∏" (
.
∏∏( )
Text
∏∏) -
.
∏∏- .
Json
∏∏. 2
.
∏∏2 3
JsonSerializer
∏∏3 A
.
∏∏A B
	Serialize
∏∏B K
(
∏∏K L
new
∏∏L O
{
∏∏P Q
Status
∏∏R X
=
∏∏Y Z
$str
∏∏[ d
}
∏∏e f
)
∏∏f g
,
∏∏g h
NewValueJson
ππ  
:
ππ  !
System
ππ" (
.
ππ( )
Text
ππ) -
.
ππ- .
Json
ππ. 2
.
ππ2 3
JsonSerializer
ππ3 A
.
ππA B
	Serialize
ππB K
(
ππK L
new
ππL O
{
ππP Q
Status
ππR X
=
ππY Z
request
ππ[ b
.
ππb c
Decision
ππc k
,
ππk l
joinRequest
ππm x
.
ππx y
UserId
ππy 
}ππÄ Å
)ππÅ Ç
)ππÇ É
,ππÉ Ñ
ct
∫∫ 
)
∫∫ 
;
∫∫ 
}
ªª 	
}
ºº 
public
ææ 

async
ææ 
Task
ææ 
<
ææ 
List
ææ 
<
ææ 
JoinRequestDto
ææ )
>
ææ) *
>
ææ* + 
GetMyRequestsAsync
ææ, >
(
ææ> ?
int
ææ? B
userId
ææC I
,
ææI J
CancellationToken
ææK \
ct
ææ] _
=
ææ` a
default
ææb i
)
ææi j
{
øø 
var
¿¿ 
requests
¿¿ 
=
¿¿ 
await
¿¿ #
joinRequestRepository
¿¿ 2
.
¿¿2 3
GetByUserIdAsync
¿¿3 C
(
¿¿C D
userId
¿¿D J
,
¿¿J K
ct
¿¿L N
)
¿¿N O
;
¿¿O P
return
¡¡ 
requests
¡¡ 
.
¬¬ 
Select
¬¬ 
(
¬¬ 
r
¬¬ 
=>
¬¬ 
new
¬¬ 
JoinRequestDto
¬¬ +
(
¬¬+ ,
r
√√ 
.
√√ 
Id
√√ 
,
√√ 
r
ƒƒ 
.
ƒƒ 
UserId
ƒƒ 
,
ƒƒ 
r
≈≈ 
.
≈≈ 
User
≈≈ 
is
≈≈ 
not
≈≈ 
null
≈≈ "
?
≈≈# $
$"
≈≈% '
{
≈≈' (
r
≈≈( )
.
≈≈) *
User
≈≈* .
.
≈≈. /
	FirstName
≈≈/ 8
}
≈≈8 9
$str
≈≈9 :
{
≈≈: ;
r
≈≈; <
.
≈≈< =
User
≈≈= A
.
≈≈A B
LastName
≈≈B J
}
≈≈J K
"
≈≈K L
.
≈≈L M
Trim
≈≈M Q
(
≈≈Q R
)
≈≈R S
:
≈≈T U
string
≈≈V \
.
≈≈\ ]
Empty
≈≈] b
,
≈≈b c
r
∆∆ 
.
∆∆ 
User
∆∆ 
?
∆∆ 
.
∆∆ 
Email
∆∆ 
??
∆∆  
string
∆∆! '
.
∆∆' (
Empty
∆∆( -
,
∆∆- .
r
«« 
.
«« 
Message
«« 
,
«« 
r
»» 
.
»» 
Status
»» 
,
»» 
r
…… 
.
…… 
	CreatedAt
…… 
,
…… 
r
   
.
   

ReviewedBy
   
is
   
not
    #
null
  $ (
?
  ) *
$"
  + -
{
  - .
r
  . /
.
  / 0

ReviewedBy
  0 :
.
  : ;
	FirstName
  ; D
}
  D E
$str
  E F
{
  F G
r
  G H
.
  H I

ReviewedBy
  I S
.
  S T
LastName
  T \
}
  \ ]
"
  ] ^
.
  ^ _
Trim
  _ c
(
  c d
)
  d e
:
  f g
null
  h l
,
  l m
r
ÀÀ 
.
ÀÀ 

ReviewedAt
ÀÀ 
,
ÀÀ 
r
ÃÃ 
.
ÃÃ 
OrganizationId
ÃÃ  
,
ÃÃ  !
r
ÕÕ 
.
ÕÕ 
Organization
ÕÕ 
?
ÕÕ 
.
ÕÕ  
Name
ÕÕ  $
??
ÕÕ% '
string
ÕÕ( .
.
ÕÕ. /
Empty
ÕÕ/ 4
)
ÕÕ4 5
)
ÕÕ5 6
.
ŒŒ 
ToList
ŒŒ 
(
ŒŒ 
)
ŒŒ 
;
ŒŒ 
}
œœ 
public
—— 

async
—— 
Task
—— 
CancelMineAsync
—— %
(
——% &
int
——& )
	requestId
——* 3
,
——3 4
int
——5 8
userId
——9 ?
,
——? @
CancellationToken
——A R
ct
——S U
=
——V W
default
——X _
)
——_ `
{
““ 
var
”” 
joinRequest
”” 
=
”” 
await
”” #
joinRequestRepository
””  5
.
””5 6
GetByIdAsync
””6 B
(
””B C
	requestId
””C L
,
””L M
ct
””N P
)
””P Q
??
‘‘ 
throw
‘‘ 
new
‘‘ 
AppException
‘‘ %
(
‘‘% &
$str
‘‘& >
,
‘‘> ?
$num
‘‘@ C
,
‘‘C D
$str
‘‘E ^
)
‘‘^ _
;
‘‘_ `
if
÷÷ 

(
÷÷ 
joinRequest
÷÷ 
.
÷÷ 
UserId
÷÷ 
!=
÷÷ !
userId
÷÷" (
)
÷÷( )
throw
◊◊ 
new
◊◊ 
AppException
◊◊ "
(
◊◊" #
$str
◊◊# 9
,
◊◊9 :
$num
◊◊; >
,
◊◊> ?
$str
◊◊@ m
)
◊◊m n
;
◊◊n o
if
ŸŸ 

(
ŸŸ 
joinRequest
ŸŸ 
.
ŸŸ 
Status
ŸŸ 
!=
ŸŸ !
$str
ŸŸ" +
)
ŸŸ+ ,
throw
⁄⁄ 
new
⁄⁄ 
AppException
⁄⁄ "
(
⁄⁄" #
$str
⁄⁄# =
,
⁄⁄= >
$num
⁄⁄? B
,
⁄⁄B C
$"
⁄⁄D F
$str
⁄⁄F q
{
⁄⁄q r
joinRequest
⁄⁄r }
.
⁄⁄} ~
Status⁄⁄~ Ñ
}⁄⁄Ñ Ö
$str⁄⁄Ö á
"⁄⁄á à
)⁄⁄à â
;⁄⁄â ä
joinRequest
‹‹ 
.
‹‹ 
Status
‹‹ 
=
‹‹ 
$str
‹‹ (
;
‹‹( )
joinRequest
›› 
.
›› 

ReviewedAt
›› 
=
››  
DateTime
››! )
.
››) *
UtcNow
››* 0
;
››0 1
await
ﬁﬁ #
joinRequestRepository
ﬁﬁ #
.
ﬁﬁ# $
UpdateAsync
ﬁﬁ$ /
(
ﬁﬁ/ 0
joinRequest
ﬁﬁ0 ;
,
ﬁﬁ; <
ct
ﬁﬁ= ?
)
ﬁﬁ? @
;
ﬁﬁ@ A
if
‡‡ 

(
‡‡ 
auditOutboxWriter
‡‡ 
is
‡‡  
not
‡‡! $
null
‡‡% )
)
‡‡) *
{
·· 	
await
‚‚ 
auditOutboxWriter
‚‚ #
.
‚‚# $
EnqueueAuditAsync
‚‚$ 5
(
‚‚5 6
new
„„  
AuditEventContract
„„ &
(
„„& '
EventId
‰‰ 
:
‰‰ 
Guid
‰‰ !
.
‰‰! "
NewGuid
‰‰" )
(
‰‰) *
)
‰‰* +
,
‰‰+ ,
SchemaVersion
ÂÂ !
:
ÂÂ! "
$num
ÂÂ# $
,
ÂÂ$ %
OccurredAtUtc
ÊÊ !
:
ÊÊ! "
DateTimeOffset
ÊÊ# 1
.
ÊÊ1 2
UtcNow
ÊÊ2 8
,
ÊÊ8 9
SourceService
ÁÁ !
:
ÁÁ! "
$str
ÁÁ# )
,
ÁÁ) *
ActorUserId
ËË 
:
ËË  
userId
ËË! '
,
ËË' (

AuditScope
ÈÈ 
:
ÈÈ 
AuditRouting
ÈÈ  ,
.
ÈÈ, -
ScopeOrganization
ÈÈ- >
,
ÈÈ> ?
TargetId
ÍÍ 
:
ÍÍ 
joinRequest
ÍÍ )
.
ÍÍ) *
OrganizationId
ÍÍ* 8
,
ÍÍ8 9
Action
ÎÎ 
:
ÎÎ 
$str
ÎÎ A
,
ÎÎA B
	FieldName
ÏÏ 
:
ÏÏ 
$str
ÏÏ B
,
ÏÏB C

EntityType
ÌÌ 
:
ÌÌ 
null
ÌÌ  $
,
ÌÌ$ %
OldValueJson
ÓÓ  
:
ÓÓ  !
System
ÓÓ" (
.
ÓÓ( )
Text
ÓÓ) -
.
ÓÓ- .
Json
ÓÓ. 2
.
ÓÓ2 3
JsonSerializer
ÓÓ3 A
.
ÓÓA B
	Serialize
ÓÓB K
(
ÓÓK L
new
ÓÓL O
{
ÓÓP Q
Status
ÓÓR X
=
ÓÓY Z
$str
ÓÓ[ d
}
ÓÓe f
)
ÓÓf g
,
ÓÓg h
NewValueJson
ÔÔ  
:
ÔÔ  !
System
ÔÔ" (
.
ÔÔ( )
Text
ÔÔ) -
.
ÔÔ- .
Json
ÔÔ. 2
.
ÔÔ2 3
JsonSerializer
ÔÔ3 A
.
ÔÔA B
	Serialize
ÔÔB K
(
ÔÔK L
new
ÔÔL O
{
ÔÔP Q
Status
ÔÔR X
=
ÔÔY Z
$str
ÔÔ[ f
,
ÔÔf g
joinRequest
ÔÔh s
.
ÔÔs t
UserId
ÔÔt z
}
ÔÔ{ |
)
ÔÔ| }
)
ÔÔ} ~
,
ÔÔ~ 
ct
 
)
 
;
 
}
ÒÒ 	
}
ÚÚ 
}ÙÙ ö=
hC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Services\EntityTypeService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
Services$ ,
;, -
public

 
sealed

 
class

 
EntityTypeService

 %
(

% &!
IEntityTypeRepository

& ; 
entityTypeRepository

< P
,

P Q
IMemoryCache

R ^
cache

_ d
)

d e
:

f g
IEntityTypeService

h z
{ 
private 
const 
string 
CacheKey !
=" #
$str$ 2
;2 3
public 

async 
Task 
< 
List 
< 
EntityTypeDto (
>( )
>) *
GetAllAsync+ 6
(6 7
CancellationToken7 H
ctI K
=L M
defaultN U
)U V
{ 
if 

( 
cache 
. 
TryGetValue 
( 
CacheKey &
,& '
out( +
List, 0
<0 1
EntityTypeDto1 >
>> ?
?? @
cachedA G
)G H
&&I K
cachedL R
isS U
notV Y
nullZ ^
)^ _
return 
cached 
; 
var 
types 
= 
await  
entityTypeRepository .
.. /%
GetAllWithPropertiesAsync/ H
(H I
ctI K
)K L
;L M
var 
result 
= 
types 
. 
Select !
(! "
et" $
=>% '
new( +
EntityTypeDto, 9
(9 :
et 
. 
Id 
, 
et 
. 
Name 
, 
et 
. 
DisplayName 
?? 
DisplayNameHelper /
./ 0
Humanize0 8
(8 9
et9 ;
.; <
Name< @
)@ A
,A B
et 
. 
IsStandalone 
, 
et 
. #
SourceRelationshipTypes &
. 
OrderBy 
( 
rt 
=> 
rt !
.! "
Id" $
)$ %
. 
Select 
( 
rt 
=> 
new !#
OutgoingRelationshipDto" 9
(9 :
rt 
. 
Id 
, 
rt 
. 
Name 
, 
rt 
. 
DisplayName "
??# %
DisplayNameHelper& 7
.7 8
Humanize8 @
(@ A
rtA C
.C D
NameD H
)H I
,I J
rt   
.   
TargetEntityTypeId   )
,  ) *
rt!! 
.!! 
TargetEntityType!! '
.!!' (
Name!!( ,
,!!, -
rt"" 
."" 
TargetEntityType"" '
.""' (
DisplayName""( 3
??""4 6
DisplayNameHelper""7 H
.""H I
Humanize""I Q
(""Q R
rt""R T
.""T U
TargetEntityType""U e
.""e f
Name""f j
)""j k
,""k l
rt## 
.## 

IsRequired## !
,##! "
rt$$ 
.$$ #
RelationshipCardinality$$ .
.$$. /
ToDatabaseValue$$/ >
($$> ?
)$$? @
)$$@ A
)$$A B
.%% 
ToList%% 
(%% 
)%% 
,%% 
et&& 
.&& #
TargetRelationshipTypes&& &
.'' 
OrderBy'' 
('' 
rt'' 
=>'' 
rt'' !
.''! "
Id''" $
)''$ %
.(( 
Select(( 
((( 
rt(( 
=>(( 
new(( !#
IncomingRelationshipDto((" 9
(((9 :
rt)) 
.)) 
Id)) 
,)) 
rt** 
.** 
Name** 
,** 
rt++ 
.++ 
DisplayName++ "
??++# %
DisplayNameHelper++& 7
.++7 8
Humanize++8 @
(++@ A
rt++A C
.++C D
Name++D H
)++H I
,++I J
rt,, 
.,, 
SourceEntityTypeId,, )
,,,) *
rt-- 
.-- 
SourceEntityType-- '
.--' (
Name--( ,
,--, -
rt.. 
... 
SourceEntityType.. '
...' (
DisplayName..( 3
??..4 6
DisplayNameHelper..7 H
...H I
Humanize..I Q
(..Q R
rt..R T
...T U
SourceEntityType..U e
...e f
Name..f j
)..j k
,..k l
rt// 
.// 

IsRequired// !
,//! "
rt00 
.00 #
RelationshipCardinality00 .
.00. /
ToDatabaseValue00/ >
(00> ?
)00? @
)00@ A
)00A B
.11 
ToList11 
(11 
)11 
,11 
et22 
.22  
EntityTypeProperties22 #
.33 
OrderBy33 
(33 
etp33 
=>33 
etp33  #
.33# $

PropertyId33$ .
)33. /
.44 
Select44 
(44 
etp44 
=>44 
new44 "!
EntityTypePropertyDto44# 8
(448 9
etp55 
.55 

PropertyId55 "
,55" #
etp66 
.66 
Property66  
.66  !
Name66! %
,66% &
etp77 
.77 
Property77  
.77  !
DisplayName77! ,
??77- /
DisplayNameHelper770 A
.77A B
Humanize77B J
(77J K
etp77K N
.77N O
Property77O W
.77W X
Name77X \
)77\ ]
,77] ^
etp88 
.88 
Property88  
.88  !
DataType88! )
.88) *
ToString88* 2
(882 3
)883 4
,884 5
etp99 
.99 

IsRequired99 "
,99" #
etp:: 
.:: 
Property::  
.::  !

IsReadonly::! +
,::+ ,
etp;; 
.;; 
Property;;  
.;;  !
AllowedValues;;! .
.<< 
Select<< 
(<<  
av<<  "
=><<# %
new<<& )
AllowedValueDto<<* 9
(<<9 :
av<<: <
.<<< =
Value<<= B
,<<B C
av<<D F
.<<F G
DisplayName<<G R
??<<S U
DisplayNameHelper<<V g
.<<g h
Humanize<<h p
(<<p q
av<<q s
.<<s t
Value<<t y
)<<y z
)<<z {
)<<{ |
.== 
ToList== 
(==  
)==  !
)==! "
)==" #
.>> 
ToList>> 
(>> 
)>> 
)>> 
)>> 
.?? 
ToList?? 
(?? 
)?? 
;?? 
cacheAA 
.AA 
SetAA 
(AA 
CacheKeyAA 
,AA 
resultAA "
,AA" #
TimeSpanAA$ ,
.AA, -
FromMinutesAA- 8
(AA8 9
$numAA9 ;
)AA; <
)AA< =
;AA= >
returnBB 
resultBB 
;BB 
}CC 
}DD Ëè
dC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Services\EntityService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
Services$ ,
;, -
public 
sealed 
class 
EntityService !
(! "
IEntityRepository 
entityRepository &
,& '%
IWorkspaceAccessEvaluator 
workspaceAccess -
,- .(
IUserRoleWorkspaceRepository  
memberRepository! 1
,1 2

IValidator 
< 
CreateEntityRequest "
>" #
createValidator$ 3
,3 4

IValidator 
< 
UpdateEntityRequest "
>" #
updateValidator$ 3
,3 4
IOutboxWriter 
? 
auditOutboxWriter $
=% &
null' +
,+ ,'
IEntityRelationshipNotifier 
?   
relationshipNotifier! 5
=6 7
null8 <
)< =
:> ?
IEntityService@ N
{ 
public 

async 
Task 
< 
EntityPagedResult '
>' (
GetByWorkspaceAsync) <
(< =
int 
workspaceId 
, 
int 
userId 
, 
int 
? 
entityTypeId 
, 
string 
? 
searchQuery 
, 
int 
skip 
, 
int 
take 
, 
IReadOnlyList 
< !
EntityFilterCondition +
>+ ,
?, -
filters. 5
=6 7
null8 <
,< =
IReadOnlyList 
< 
EntitySortField %
>% &
?& '
sort( ,
=- .
null/ 3
,3 4
int   
?   (
excludeLinkedSourceRelTypeId   )
=  * +
null  , 0
,  0 1
int!! 
?!! (
excludeLinkedTargetRelTypeId!! )
=!!* +
null!!, 0
,!!0 1
CancellationToken"" 
ct"" 
="" 
default"" &
)""& '
{## 
await$$ 
RequirePermission$$ 
($$  
userId$$  &
,$$& '
workspaceId$$( 3
,$$3 4
$str$$5 D
,$$D E
ct$$F H
)$$H I
;$$I J
var%% 
callerMembership%% 
=%% 
await%% $%
GetMembershipOrThrowAsync%%% >
(%%> ?
userId%%? E
,%%E F
workspaceId%%G R
,%%R S
ct%%T V
)%%V W
;%%W X
var'' 
resolved'' 
='' 
await'' 
ResolveFiltersAsync'' 0
(''0 1
filters''1 8
,''8 9
entityTypeId'': F
,''F G
userId''H N
,''N O
workspaceId''P [
,''[ \
ct''] _
)''_ `
;''` a
var)) 
()) 
items)) 
,)) 
total)) 
))) 
=)) 
await)) "
entityRepository))# 3
.))3 4
GetByWorkspaceAsync))4 G
())G H
workspaceId** 
,** 
userId++ 
,++ 
callerMembership,, 
.,, 
Role,, !
.,,! "
Priority,," *
,,,* +
entityTypeId-- 
,-- 
searchQuery.. 
,.. 
skip// 
,// 
take00 
,00 
resolved11 
,11 
sort22 
??22 
[22 
]22 
,22 (
excludeLinkedSourceRelTypeId33 (
,33( )(
excludeLinkedTargetRelTypeId44 (
,44( )
ct55 
)55 
;55 
return77 
new77 
EntityPagedResult77 $
(77$ %
items77% *
.77* +
Select77+ 1
(771 2
MapToListItem772 ?
)77? @
.77@ A
ToList77A G
(77G H
)77H I
,77I J
total77K P
,77P Q
skip77R V
,77V W
take77X \
)77\ ]
;77] ^
}88 
public:: 

async:: 
Task:: 
<:: 
EntityDetailDto:: %
>::% &
GetByIdAsync::' 3
(::3 4
int::4 7
entityId::8 @
,::@ A
int::B E
workspaceId::F Q
,::Q R
int::S V
userId::W ]
,::] ^
CancellationToken::_ p
ct::q s
=::t u
default::v }
)::} ~
{;; 
await<< 
RequirePermission<< 
(<<  
userId<<  &
,<<& '
workspaceId<<( 3
,<<3 4
$str<<5 D
,<<D E
ct<<F H
)<<H I
;<<I J
var>> 
entity>> 
=>> 
await>> 
entityRepository>> +
.>>+ ,#
GetByIdInWorkspaceAsync>>, C
(>>C D
entityId>>D L
,>>L M
workspaceId>>N Y
,>>Y Z
ct>>[ ]
)>>] ^
???? 
throw?? 
new?? #
EntityNotFoundException?? 0
(??0 1
entityId??1 9
,??9 :
workspaceId??; F
)??F G
;??G H
await@@ &
EnsureCanAccessEntityAsync@@ (
(@@( )
userId@@) /
,@@/ 0
workspaceId@@1 <
,@@< =
entity@@> D
,@@D E
ct@@F H
)@@H I
;@@I J
returnBB 
MapToDetailBB 
(BB 
entityBB !
)BB! "
;BB" #
}CC 
publicEE 

asyncEE 
TaskEE 
<EE 
EntityDetailDtoEE %
>EE% &
CreateAsyncEE' 2
(EE2 3
intEE3 6
workspaceIdEE7 B
,EEB C
intEED G
userIdEEH N
,EEN O
CreateEntityRequestEEP c
requestEEd k
,EEk l
CancellationTokenEEm ~
ct	EE Å
=
EEÇ É
default
EEÑ ã
)
EEã å
{FF 
awaitGG 
RequirePermissionGG 
(GG  
userIdGG  &
,GG& '
workspaceIdGG( 3
,GG3 4
$strGG5 F
,GGF G
ctGGH J
)GGJ K
;GGK L
awaitHH 
createValidatorHH 
.HH !
ValidateAndThrowAsyncHH 3
(HH3 4
requestHH4 ;
,HH; <
ctHH= ?
)HH? @
;HH@ A
varJJ 
typePropertiesJJ 
=JJ 
awaitJJ "
entityRepositoryJJ# 3
.JJ3 4"
GetTypePropertiesAsyncJJ4 J
(JJJ K
requestJJK R
.JJR S
EntityTypeIdJJS _
,JJ_ `
ctJJa c
)JJc d
;JJd e
ifKK 

(KK 
typePropertiesKK 
.KK 
CountKK  
==KK! #
$numKK$ %
)KK% &
throwLL 
newLL 
AppExceptionLL "
(LL" #
$strLL# :
,LL: ;
$numLL< ?
,LL? @
$"LLA C
$strLLC O
{LLO P
requestLLP W
.LLW X
EntityTypeIdLLX d
}LLd e
$str	LLe í
"
LLí ì
)
LLì î
;
LLî ï
ifNN 

(NN 
typePropertiesNN 
.NN 
AllNN 
(NN 
tpNN !
=>NN" $
tpNN% '
.NN' (
PropertyNN( 0
.NN0 1

IsReadonlyNN1 ;
)NN; <
)NN< =
throwOO 
newOO 
AppExceptionOO "
(OO" #
$strOO# =
,OO= >
$numOO? B
,OOB C
$"OOD F
$strOOF R
{OOR S
requestOOS Z
.OOZ [
EntityTypeIdOO[ g
}OOg h
$str	OOh ô
"
OOô ö
)
OOö õ
;
OOõ ú#
ValidatePropertyPayloadQQ 
(QQ  
requestQQ  '
.QQ' (

PropertiesQQ( 2
,QQ2 3
typePropertiesQQ4 B
)QQB C
;QQC D
varSS 
outgoingTypesSS 
=SS 
awaitSS !
entityRepositorySS" 2
.SS2 3-
!GetOutgoingRelationshipTypesAsyncSS3 T
(SST U
requestSSU \
.SS\ ]
EntityTypeIdSS] i
,SSi j
ctSSk m
)SSm n
;SSn o
ListTT 
<TT 
EntityRelationshipTT 
>TT  
?TT  !
relationshipRowsTT" 2
=TT3 4
nullTT5 9
;TT9 :
ifUU 

(UU 
requestUU 
.UU 
LinksUU 
isUU 
{UU 
CountUU $
:UU$ %
>UU& '
$numUU( )
}UU* +
)UU+ ,
{VV 	
relationshipRowsWW 
=WW 
[WW  
]WW  !
;WW! "
varXX 

seenByTypeXX 
=XX 
newXX  

DictionaryXX! +
<XX+ ,
intXX, /
,XX/ 0
HashSetXX1 8
<XX8 9
intXX9 <
>XX< =
>XX= >
(XX> ?
)XX? @
;XX@ A
foreachYY 
(YY 
varYY 
linkYY 
inYY  
requestYY! (
.YY( )
LinksYY) .
)YY. /
{ZZ 
var[[ 
rt[[ 
=[[ 
outgoingTypes[[ &
.[[& '
FirstOrDefault[[' 5
([[5 6
o[[6 7
=>[[8 :
o[[; <
.[[< =
Id[[= ?
==[[@ B
link[[C G
.[[G H
RelationshipTypeId[[H Z
)[[Z [
??\\ 
throw\\ 
new\\  
AppException\\! -
(\\- .
$str\\. T
,\\T U
$num\\V Y
,\\Y Z
$"\\[ ]
$str\\] o
{\\o p
link\\p t
.\\t u
RelationshipTypeId	\\u á
}
\\á à
$str
\\à ´
"
\\´ ¨
)
\\¨ ≠
;
\\≠ Æ
var^^ 
target^^ 
=^^ 
await^^ "
entityRepository^^# 3
.^^3 4#
GetByIdInWorkspaceAsync^^4 K
(^^K L
link^^L P
.^^P Q
TargetEntityId^^Q _
,^^_ `
workspaceId^^a l
,^^l m
ct^^n p
)^^p q
??__ 
throw__ 
new__  
AppException__! -
(__- .
$str__. G
,__G H
$num__I L
,__L M
$"__N P
$str__P ^
{__^ _
link___ c
.__c d
TargetEntityId__d r
}__r s
$str	__s î
"
__î ï
)
__ï ñ
;
__ñ ó
ifaa 
(aa 
targetaa 
.aa 
EntityTypeIdaa '
!=aa( *
rtaa+ -
.aa- .
TargetEntityTypeIdaa. @
)aa@ A
throwbb 
newbb 
AppExceptionbb *
(bb* +
$strbb+ E
,bbE F
$numbbG J
,bbJ K
$"bbL N
$strbbN \
{bb\ ]
linkbb] a
.bba b
TargetEntityIdbbb p
}bbp q
$str	bbq û
{
bbû ü
rt
bbü °
.
bb° ¢
Name
bb¢ ¶
}
bb¶ ß
$str
bbß ©
"
bb© ™
)
bb™ ´
;
bb´ ¨
ifdd 
(dd 
!dd 

seenByTypedd 
.dd  
TryGetValuedd  +
(dd+ ,
rtdd, .
.dd. /
Iddd/ 1
,dd1 2
outdd3 6
vardd7 :
seenTargetsdd; F
)ddF G
)ddG H
{ee 
seenTargetsff 
=ff  !
[ff" #
]ff# $
;ff$ %

seenByTypegg 
[gg 
rtgg !
.gg! "
Idgg" $
]gg$ %
=gg& '
seenTargetsgg( 3
;gg3 4
}hh 
elseii 
ifii 
(ii 
rtii 
.ii #
RelationshipCardinalityii 3
isii4 6#
RelationshipCardinalityii7 N
.iiN O
	ManyToOneiiO X
oriiY [#
RelationshipCardinalityii\ s
.iis t
OneToOneiit |
)ii| }
{jj 
throwkk 
newkk 
AppExceptionkk *
(kk* +
$strkk+ I
,kkI J
$numkkK N
,kkN O
$"kkP R
$strkkR `
{kk` a
rtkka c
.kkc d
Namekkd h
}kkh i
$str	kki ´
"
kk´ ¨
)
kk¨ ≠
;
kk≠ Æ
}ll 
ifnn 
(nn 
!nn 
seenTargetsnn  
.nn  !
Addnn! $
(nn$ %
targetnn% +
.nn+ ,
Idnn, .
)nn. /
)nn/ 0
throwoo 
newoo 
AppExceptionoo *
(oo* +
$stroo+ H
,ooH I
$numooJ M
,ooM N
$"ooO Q
$strooQ h
{ooh i
targetooi o
.ooo p
Idoop r
}oor s
$stroos y
{ooy z
rtooz |
.oo| }
Name	oo} Å
}
ooÅ Ç
$str
ooÇ ™
"
oo™ ´
)
oo´ ¨
;
oo¨ ≠
relationshipRowsqq  
.qq  !
Addqq! $
(qq$ %
newqq% (
EntityRelationshipqq) ;
{rr 
RelationshipTypeIdss &
=ss' (
rtss) +
.ss+ ,
Idss, .
,ss. /
SourceEntityIdtt "
=tt# $
$numtt% &
,tt& '
TargetEntityIduu "
=uu# $
targetuu% +
.uu+ ,
Iduu, .
,uu. /
}vv 
)vv 
;vv 
}ww 
}xx 	
varzz 
linkTypeIdszz 
=zz 
newzz 
HashSetzz %
<zz% &
intzz& )
>zz) *
(zz* +
relationshipRowszz+ ;
?zz; <
.zz< =
Selectzz= C
(zzC D
rzzD E
=>zzF H
rzzI J
.zzJ K
RelationshipTypeIdzzK ]
)zz] ^
??zz_ a
[zzb c
]zzc d
)zzd e
;zze f
foreach{{ 
({{ 
var{{ 
req{{ 
in{{ 
outgoingTypes{{ )
.{{) *
Where{{* /
({{/ 0
t{{0 1
=>{{2 4
t{{5 6
.{{6 7

IsRequired{{7 A
){{A B
){{B C
{|| 	
if}} 
(}} 
!}} 
linkTypeIds}} 
.}} 
Contains}} %
(}}% &
req}}& )
.}}) *
Id}}* ,
)}}, -
)}}- .
throw~~ 
new~~ 
AppException~~ &
(~~& '
$str~~' F
,~~F G
$num~~H K
,~~K L
$"~~M O
$str~~O f
{~~f g
req~~g j
.~~j k
Name~~k o
}~~o p
$str~~p }
"~~} ~
)~~~ 
;	~~ Ä
} 	
var
ÅÅ 
entity
ÅÅ 
=
ÅÅ 
new
ÅÅ 
Entity
ÅÅ 
{
ÅÅ  !
EntityTypeId
ÅÅ" .
=
ÅÅ/ 0
request
ÅÅ1 8
.
ÅÅ8 9
EntityTypeId
ÅÅ9 E
,
ÅÅE F
CreatedByUserId
ÅÅG V
=
ÅÅW X
userId
ÅÅY _
,
ÅÅ_ `

IsArchived
ÅÅa k
=
ÅÅl m
false
ÅÅn s
}
ÅÅt u
;
ÅÅu v
var
ÇÇ 
propertyValues
ÇÇ 
=
ÇÇ !
BuildPropertyValues
ÇÇ 0
(
ÇÇ0 1
request
ÇÇ1 8
.
ÇÇ8 9

Properties
ÇÇ9 C
,
ÇÇC D
typeProperties
ÇÇE S
)
ÇÇS T
;
ÇÇT U
var
ÑÑ 
created
ÑÑ 
=
ÑÑ 
await
ÑÑ 
entityRepository
ÑÑ ,
.
ÑÑ, -
CreateAsync
ÑÑ- 8
(
ÑÑ8 9
entity
ÑÑ9 ?
,
ÑÑ? @
propertyValues
ÑÑA O
,
ÑÑO P
workspaceId
ÑÑQ \
,
ÑÑ\ ]
relationshipRows
ÑÑ^ n
,
ÑÑn o
ct
ÑÑp r
)
ÑÑr s
;
ÑÑs t
if
ÜÜ 

(
ÜÜ 
auditOutboxWriter
ÜÜ 
is
ÜÜ  
not
ÜÜ! $
null
ÜÜ% )
)
ÜÜ) *
{
áá 	
await
àà 
auditOutboxWriter
àà #
.
àà# $
EnqueueAuditAsync
àà$ 5
(
àà5 6
new
ââ  
AuditEventContract
ââ "
(
ââ" #
EventId
ää 
:
ää 
Guid
ää 
.
ää 
NewGuid
ää %
(
ää% &
)
ää& '
,
ää' (
SchemaVersion
ãã 
:
ãã 
$num
ãã  
,
ãã  !
OccurredAtUtc
åå 
:
åå 
DateTimeOffset
åå -
.
åå- .
UtcNow
åå. 4
,
åå4 5
SourceService
çç 
:
çç 
$str
çç %
,
çç% &
ActorUserId
éé 
:
éé 
userId
éé #
,
éé# $

AuditScope
èè 
:
èè 
AuditRouting
èè (
.
èè( )
ScopeEntity
èè) 4
,
èè4 5
TargetId
êê 
:
êê 
created
êê !
.
êê! "
Id
êê" $
,
êê$ %
Action
ëë 
:
ëë 
$str
ëë (
,
ëë( )
	FieldName
íí 
:
íí 
null
íí 
,
íí  

EntityType
ìì 
:
ìì 
request
ìì #
.
ìì# $
EntityTypeId
ìì$ 0
.
ìì0 1
ToString
ìì1 9
(
ìì9 :
CultureInfo
ìì: E
.
ììE F
InvariantCulture
ììF V
)
ììV W
,
ììW X
OldValueJson
îî 
:
îî 
null
îî "
,
îî" #
NewValueJson
ïï 
:
ïï 
System
ïï $
.
ïï$ %
Text
ïï% )
.
ïï) *
Json
ïï* .
.
ïï. /
JsonSerializer
ïï/ =
.
ïï= >
	Serialize
ïï> G
(
ïïG H
request
ïïH O
.
ïïO P

Properties
ïïP Z
)
ïïZ [
)
ïï[ \
,
ïï\ ]
ct
ññ 
)
ññ 
;
ññ 
await
óó -
PublishEntityRefreshDomainAsync
óó 1
(
óó1 2
auditOutboxWriter
òò !
,
òò! "
created
ôô 
.
ôô 
Id
ôô 
,
ôô 
created
öö 
.
öö 
EntityTypeId
öö $
,
öö$ %
workspaceId
õõ 
,
õõ 
userId
úú 
,
úú 
$str
ùù 
,
ùù 
ct
ûû 
)
ûû 
;
ûû 
}
üü 	
var
°° 
detail
°° 
=
°° 
await
°° 
entityRepository
°° +
.
°°+ ,%
GetByIdInWorkspaceAsync
°°, C
(
°°C D
created
°°D K
.
°°K L
Id
°°L N
,
°°N O
workspaceId
°°P [
,
°°[ \
ct
°°] _
)
°°_ `
;
°°` a
return
¢¢ 
MapToDetail
¢¢ 
(
¢¢ 
detail
¢¢ !
!
¢¢! "
)
¢¢" #
;
¢¢# $
}
££ 
public
•• 

async
•• 
Task
•• 
<
•• 
EntityDetailDto
•• %
>
••% &
UpdateAsync
••' 2
(
••2 3
int
••3 6
entityId
••7 ?
,
••? @
int
••A D
workspaceId
••E P
,
••P Q
int
••R U
userId
••V \
,
••\ ]!
UpdateEntityRequest
••^ q
request
••r y
,
••y z 
CancellationToken••{ å
ct••ç è
=••ê ë
default••í ô
)••ô ö
{
¶¶ 
await
ßß 
RequirePermission
ßß 
(
ßß  
userId
ßß  &
,
ßß& '
workspaceId
ßß( 3
,
ßß3 4
$str
ßß5 D
,
ßßD E
ct
ßßF H
)
ßßH I
;
ßßI J
await
®® 
updateValidator
®® 
.
®® #
ValidateAndThrowAsync
®® 3
(
®®3 4
request
®®4 ;
,
®®; <
ct
®®= ?
)
®®? @
;
®®@ A
var
™™ 
entity
™™ 
=
™™ 
await
™™ 
entityRepository
™™ +
.
™™+ ,%
GetByIdInWorkspaceAsync
™™, C
(
™™C D
entityId
™™D L
,
™™L M
workspaceId
™™N Y
,
™™Y Z
ct
™™[ ]
)
™™] ^
??
´´ 
throw
´´ 
new
´´ %
EntityNotFoundException
´´ 0
(
´´0 1
entityId
´´1 9
,
´´9 :
workspaceId
´´; F
)
´´F G
;
´´G H
await
¨¨ (
EnsureCanAccessEntityAsync
¨¨ (
(
¨¨( )
userId
¨¨) /
,
¨¨/ 0
workspaceId
¨¨1 <
,
¨¨< =
entity
¨¨> D
,
¨¨D E
ct
¨¨F H
)
¨¨H I
;
¨¨I J
if
ÆÆ 

(
ÆÆ 
entity
ÆÆ 
.
ÆÆ 

IsArchived
ÆÆ 
)
ÆÆ 
{
ØØ 	
await
∞∞ 
RequirePermission
∞∞ #
(
∞∞# $
userId
∞∞$ *
,
∞∞* +
workspaceId
∞∞, 7
,
∞∞7 8
$str
∞∞9 Q
,
∞∞Q R
ct
∞∞S U
)
∞∞U V
;
∞∞V W
}
±± 	
var
≥≥ 
typeProperties
≥≥ 
=
≥≥ 
await
≥≥ "
entityRepository
≥≥# 3
.
≥≥3 4$
GetTypePropertiesAsync
≥≥4 J
(
≥≥J K
entity
≥≥K Q
.
≥≥Q R
EntityTypeId
≥≥R ^
,
≥≥^ _
ct
≥≥` b
)
≥≥b c
;
≥≥c d(
ValidateRequestPropertyIds
¥¥ "
(
¥¥" #
request
¥¥# *
.
¥¥* +

Properties
¥¥+ 5
,
¥¥5 6
typeProperties
¥¥7 E
)
¥¥E F
;
¥¥F G
var
µµ 
merged
µµ 
=
µµ "
MergePropertyPayload
µµ )
(
µµ) *
entity
µµ* 0
,
µµ0 1
request
µµ2 9
.
µµ9 :

Properties
µµ: D
)
µµD E
;
µµE F'
ValidateReadonlyPreserved
∂∂ !
(
∂∂! "
entity
∂∂" (
,
∂∂( )
merged
∂∂* 0
,
∂∂0 1
typeProperties
∂∂2 @
)
∂∂@ A
;
∂∂A B
var
∑∑ 
readonlyIds
∑∑ 
=
∑∑ 
typeProperties
∑∑ (
.
∏∏ 
Where
∏∏ 
(
∏∏ 
tp
∏∏ 
=>
∏∏ 
tp
∏∏ 
.
∏∏ 
Property
∏∏ $
.
∏∏$ %

IsReadonly
∏∏% /
)
∏∏/ 0
.
ππ 
Select
ππ 
(
ππ 
tp
ππ 
=>
ππ 
tp
ππ 
.
ππ 

PropertyId
ππ '
)
ππ' (
.
∫∫ 
	ToHashSet
∫∫ 
(
∫∫ 
)
∫∫ 
;
∫∫ %
ValidatePropertyPayload
ªª 
(
ªª  
merged
ºº 
.
ºº 
Where
ºº 
(
ºº 
p
ºº 
=>
ºº 
!
ºº 
readonlyIds
ºº *
.
ºº* +
Contains
ºº+ 3
(
ºº3 4
p
ºº4 5
.
ºº5 6

PropertyId
ºº6 @
)
ºº@ A
)
ººA B
.
ººB C
ToList
ººC I
(
ººI J
)
ººJ K
,
ººK L
typeProperties
ΩΩ 
)
ΩΩ 
;
ΩΩ 
var
øø 
propertyValues
øø 
=
øø !
BuildPropertyValues
øø 0
(
øø0 1
merged
øø1 7
,
øø7 8
typeProperties
øø9 G
)
øøG H
;
øøH I
await
¿¿ 
entityRepository
¿¿ 
.
¿¿ 
UpdateAsync
¿¿ *
(
¿¿* +
entity
¿¿+ 1
,
¿¿1 2
propertyValues
¿¿3 A
,
¿¿A B
ct
¿¿C E
)
¿¿E F
;
¿¿F G
if
¬¬ 

(
¬¬ 
auditOutboxWriter
¬¬ 
is
¬¬  
not
¬¬! $
null
¬¬% )
)
¬¬) *
{
√√ 	
await
ƒƒ 
auditOutboxWriter
ƒƒ #
.
ƒƒ# $
EnqueueAuditAsync
ƒƒ$ 5
(
ƒƒ5 6
new
≈≈  
AuditEventContract
≈≈ "
(
≈≈" #
EventId
∆∆ 
:
∆∆ 
Guid
∆∆ 
.
∆∆ 
NewGuid
∆∆ %
(
∆∆% &
)
∆∆& '
,
∆∆' (
SchemaVersion
«« 
:
«« 
$num
««  
,
««  !
OccurredAtUtc
»» 
:
»» 
DateTimeOffset
»» -
.
»»- .
UtcNow
»». 4
,
»»4 5
SourceService
…… 
:
…… 
$str
…… %
,
……% &
ActorUserId
   
:
   
userId
   #
,
  # $

AuditScope
ÀÀ 
:
ÀÀ 
AuditRouting
ÀÀ (
.
ÀÀ( )
ScopeEntity
ÀÀ) 4
,
ÀÀ4 5
TargetId
ÃÃ 
:
ÃÃ 
entityId
ÃÃ "
,
ÃÃ" #
Action
ÕÕ 
:
ÕÕ 
$str
ÕÕ (
,
ÕÕ( )
	FieldName
ŒŒ 
:
ŒŒ 
$str
ŒŒ '
,
ŒŒ' (

EntityType
œœ 
:
œœ 
entity
œœ "
.
œœ" #
EntityTypeId
œœ# /
.
œœ/ 0
ToString
œœ0 8
(
œœ8 9
CultureInfo
œœ9 D
.
œœD E
InvariantCulture
œœE U
)
œœU V
,
œœV W
OldValueJson
–– 
:
–– 
null
–– "
,
––" #
NewValueJson
—— 
:
—— 
System
—— $
.
——$ %
Text
——% )
.
——) *
Json
——* .
.
——. /
JsonSerializer
——/ =
.
——= >
	Serialize
——> G
(
——G H
merged
——H N
)
——N O
)
——O P
,
——P Q
ct
““ 
)
““ 
;
““ 
await
”” -
PublishEntityRefreshDomainAsync
”” 1
(
””1 2
auditOutboxWriter
‘‘ !
,
‘‘! "
entityId
’’ 
,
’’ 
entity
÷÷ 
.
÷÷ 
EntityTypeId
÷÷ #
,
÷÷# $
workspaceId
◊◊ 
,
◊◊ 
userId
ÿÿ 
,
ÿÿ 
$str
ŸŸ 
,
ŸŸ 
ct
⁄⁄ 
)
⁄⁄ 
;
⁄⁄ 
}
€€ 	
var
›› 
updated
›› 
=
›› 
await
›› 
entityRepository
›› ,
.
››, -%
GetByIdInWorkspaceAsync
››- D
(
››D E
entityId
››E M
,
››M N
workspaceId
››O Z
,
››Z [
ct
››\ ^
)
››^ _
;
››_ `
return
ﬁﬁ 
MapToDetail
ﬁﬁ 
(
ﬁﬁ 
updated
ﬁﬁ "
!
ﬁﬁ" #
)
ﬁﬁ# $
;
ﬁﬁ$ %
}
ﬂﬂ 
public
·· 

async
·· 
Task
·· 
ArchiveAsync
·· "
(
··" #
int
··# &
entityId
··' /
,
··/ 0
int
··1 4
workspaceId
··5 @
,
··@ A
int
··B E
userId
··F L
,
··L M
CancellationToken
··N _
ct
··` b
=
··c d
default
··e l
)
··l m
{
‚‚ 
await
„„ 
RequirePermission
„„ 
(
„„  
userId
„„  &
,
„„& '
workspaceId
„„( 3
,
„„3 4
$str
„„5 F
,
„„F G
ct
„„H J
)
„„J K
;
„„K L
var
ÂÂ 
entity
ÂÂ 
=
ÂÂ 
await
ÂÂ 
entityRepository
ÂÂ +
.
ÂÂ+ ,%
GetByIdInWorkspaceAsync
ÂÂ, C
(
ÂÂC D
entityId
ÂÂD L
,
ÂÂL M
workspaceId
ÂÂN Y
,
ÂÂY Z
ct
ÂÂ[ ]
)
ÂÂ] ^
??
ÊÊ 
throw
ÊÊ 
new
ÊÊ %
EntityNotFoundException
ÊÊ 0
(
ÊÊ0 1
entityId
ÊÊ1 9
,
ÊÊ9 :
workspaceId
ÊÊ; F
)
ÊÊF G
;
ÊÊG H
await
ÁÁ (
EnsureCanAccessEntityAsync
ÁÁ (
(
ÁÁ( )
userId
ÁÁ) /
,
ÁÁ/ 0
workspaceId
ÁÁ1 <
,
ÁÁ< =
entity
ÁÁ> D
,
ÁÁD E
ct
ÁÁF H
)
ÁÁH I
;
ÁÁI J
var
ÈÈ 
	typeProps
ÈÈ 
=
ÈÈ 
await
ÈÈ 
entityRepository
ÈÈ .
.
ÈÈ. /$
GetTypePropertiesAsync
ÈÈ/ E
(
ÈÈE F
entity
ÈÈF L
.
ÈÈL M
EntityTypeId
ÈÈM Y
,
ÈÈY Z
ct
ÈÈ[ ]
)
ÈÈ] ^
;
ÈÈ^ _
if
ÍÍ 

(
ÍÍ 
	typeProps
ÍÍ 
.
ÍÍ 
Count
ÍÍ 
>
ÍÍ 
$num
ÍÍ 
&&
ÍÍ  "
	typeProps
ÍÍ# ,
.
ÍÍ, -
All
ÍÍ- 0
(
ÍÍ0 1
tp
ÍÍ1 3
=>
ÍÍ4 6
tp
ÍÍ7 9
.
ÍÍ9 :
Property
ÍÍ: B
.
ÍÍB C

IsReadonly
ÍÍC M
)
ÍÍM N
)
ÍÍN O
throw
ÎÎ 
new
ÎÎ 
AppException
ÎÎ "
(
ÎÎ" #
$str
ÎÎ# ?
,
ÎÎ? @
$num
ÎÎA D
,
ÎÎD E
$strÎÎF É
)ÎÎÉ Ñ
;ÎÎÑ Ö
await
ÌÌ 
entityRepository
ÌÌ 
.
ÌÌ 
ArchiveAsync
ÌÌ +
(
ÌÌ+ ,
entity
ÌÌ, 2
.
ÌÌ2 3
Id
ÌÌ3 5
,
ÌÌ5 6
ct
ÌÌ7 9
)
ÌÌ9 :
;
ÌÌ: ;
if
ÔÔ 

(
ÔÔ 
auditOutboxWriter
ÔÔ 
is
ÔÔ  
not
ÔÔ! $
null
ÔÔ% )
)
ÔÔ) *
{
 	
await
ÒÒ 
auditOutboxWriter
ÒÒ #
.
ÒÒ# $
EnqueueAuditAsync
ÒÒ$ 5
(
ÒÒ5 6
new
ÚÚ  
AuditEventContract
ÚÚ "
(
ÚÚ" #
EventId
ÛÛ 
:
ÛÛ 
Guid
ÛÛ 
.
ÛÛ 
NewGuid
ÛÛ %
(
ÛÛ% &
)
ÛÛ& '
,
ÛÛ' (
SchemaVersion
ÙÙ 
:
ÙÙ 
$num
ÙÙ  
,
ÙÙ  !
OccurredAtUtc
ıı 
:
ıı 
DateTimeOffset
ıı -
.
ıı- .
UtcNow
ıı. 4
,
ıı4 5
SourceService
ˆˆ 
:
ˆˆ 
$str
ˆˆ %
,
ˆˆ% &
ActorUserId
˜˜ 
:
˜˜ 
userId
˜˜ #
,
˜˜# $

AuditScope
¯¯ 
:
¯¯ 
AuditRouting
¯¯ (
.
¯¯( )
ScopeEntity
¯¯) 4
,
¯¯4 5
TargetId
˘˘ 
:
˘˘ 
entityId
˘˘ "
,
˘˘" #
Action
˙˙ 
:
˙˙ 
$str
˙˙ )
,
˙˙) *
	FieldName
˚˚ 
:
˚˚ 
$str
˚˚ (
,
˚˚( )

EntityType
¸¸ 
:
¸¸ 
entity
¸¸ "
.
¸¸" #
EntityTypeId
¸¸# /
.
¸¸/ 0
ToString
¸¸0 8
(
¸¸8 9
CultureInfo
¸¸9 D
.
¸¸D E
InvariantCulture
¸¸E U
)
¸¸U V
,
¸¸V W
OldValueJson
˝˝ 
:
˝˝ 
System
˝˝ $
.
˝˝$ %
Text
˝˝% )
.
˝˝) *
Json
˝˝* .
.
˝˝. /
JsonSerializer
˝˝/ =
.
˝˝= >
	Serialize
˝˝> G
(
˝˝G H
new
˝˝H K
{
˝˝L M

IsArchived
˝˝N X
=
˝˝Y Z
false
˝˝[ `
}
˝˝a b
)
˝˝b c
,
˝˝c d
NewValueJson
˛˛ 
:
˛˛ 
System
˛˛ $
.
˛˛$ %
Text
˛˛% )
.
˛˛) *
Json
˛˛* .
.
˛˛. /
JsonSerializer
˛˛/ =
.
˛˛= >
	Serialize
˛˛> G
(
˛˛G H
new
˛˛H K
{
˛˛L M

IsArchived
˛˛N X
=
˛˛Y Z
true
˛˛[ _
}
˛˛` a
)
˛˛a b
)
˛˛b c
,
˛˛c d
ct
ˇˇ 
)
ˇˇ 
;
ˇˇ 
await
ÄÄ -
PublishEntityRefreshDomainAsync
ÄÄ 1
(
ÄÄ1 2
auditOutboxWriter
ÅÅ !
,
ÅÅ! "
entityId
ÇÇ 
,
ÇÇ 
entity
ÉÉ 
.
ÉÉ 
EntityTypeId
ÉÉ #
,
ÉÉ# $
workspaceId
ÑÑ 
,
ÑÑ 
userId
ÖÖ 
,
ÖÖ 
$str
ÜÜ 
,
ÜÜ 
ct
áá 
)
áá 
;
áá 
}
àà 	
}
ââ 
private
èè 
async
èè 
Task
èè 
RequirePermission
èè (
(
èè( )
int
èè) ,
userId
èè- 3
,
èè3 4
int
èè5 8
workspaceId
èè9 D
,
èèD E
string
èèF L

permission
èèM W
,
èèW X
CancellationToken
èèY j
ct
èèk m
)
èèm n
{
êê 
if
ëë 

(
ëë 
!
ëë 
await
ëë 
workspaceAccess
ëë "
.
ëë" #)
HasWorkspacePermissionAsync
ëë# >
(
ëë> ?
userId
ëë? E
,
ëëE F
workspaceId
ëëG R
,
ëëR S

permission
ëëT ^
,
ëë^ _
ct
ëë` b
)
ëëb c
)
ëëc d
throw
íí 
new
íí 
AppException
íí "
(
íí" #
$str
íí# 6
,
íí6 7
$num
íí8 ;
,
íí; <
$"
íí= ?
$str
íí? T
{
ííT U

permission
ííU _
}
íí_ `
$str
íí` 
"íí Ä
)ííÄ Å
;ííÅ Ç
}
ìì 
private
ïï 
async
ïï 
Task
ïï 
<
ïï 
UserRoleWorkspace
ïï (
>
ïï( )'
GetMembershipOrThrowAsync
ïï* C
(
ïïC D
int
ïïD G
userId
ïïH N
,
ïïN O
int
ïïP S
workspaceId
ïïT _
,
ïï_ `
CancellationToken
ïïa r
ct
ïïs u
)
ïïu v
{
ññ 
var
óó 

membership
óó 
=
óó 
await
óó 
memberRepository
óó /
.
óó/ 0
GetAsync
óó0 8
(
óó8 9
userId
óó9 ?
,
óó? @
workspaceId
óóA L
,
óóL M
ct
óóN P
)
óóP Q
;
óóQ R
if
òò 

(
òò 

membership
òò 
?
òò 
.
òò 
Role
òò 
is
òò 
null
òò  $
)
òò$ %
throw
ôô 
new
ôô 
AppException
ôô "
(
ôô" #
$str
ôô# 2
,
ôô2 3
$num
ôô4 7
,
ôô7 8
$str
ôô9 H
)
ôôH I
;
ôôI J
return
öö 

membership
öö 
;
öö 
}
õõ 
private
ùù 
async
ùù 
Task
ùù 
<
ùù 
IReadOnlyList
ùù $
<
ùù$ %%
ResolvedFilterCondition
ùù% <
>
ùù< =
>
ùù= >!
ResolveFiltersAsync
ùù? R
(
ùùR S
IReadOnlyList
ûû 
<
ûû #
EntityFilterCondition
ûû +
>
ûû+ ,
?
ûû, -
raw
ûû. 1
,
ûû1 2
int
üü 
?
üü 
entityTypeId
üü 
,
üü 
int
†† 
userId
†† 
,
†† 
int
°° 
workspaceId
°° 
,
°° 
CancellationToken
¢¢ 
ct
¢¢ 
)
¢¢ 
{
££ 
if
§§ 

(
§§ 
raw
§§ 
is
§§ 
null
§§ 
or
§§ 
{
§§ 
Count
§§ "
:
§§" #
$num
§§$ %
}
§§& '
)
§§' (
return
§§) /
[
§§0 1
]
§§1 2
;
§§2 3
if
¶¶ 

(
¶¶ 
entityTypeId
¶¶ 
is
¶¶ 
null
¶¶  
)
¶¶  !
throw
ßß 
new
ßß 
AppException
ßß "
(
ßß" #
$str
ßß# E
,
ßßE F
$num
ßßG J
,
ßßJ K
$strßßL Ç
)ßßÇ É
;ßßÉ Ñ
var
©© 
	typeProps
©© 
=
©© 
await
©© 
entityRepository
©© .
.
©©. /$
GetTypePropertiesAsync
©©/ E
(
©©E F
entityTypeId
©©F R
.
©©R S
Value
©©S X
,
©©X Y
ct
©©Z \
)
©©\ ]
;
©©] ^
if
™™ 

(
™™ 
	typeProps
™™ 
.
™™ 
Count
™™ 
==
™™ 
$num
™™  
)
™™  !
throw
´´ 
new
´´ 
AppException
´´ "
(
´´" #
$str
´´# :
,
´´: ;
$num
´´< ?
,
´´? @
$"
´´A C
$str
´´C O
{
´´O P
entityTypeId
´´P \
}
´´\ ]
$str´´] ä
"´´ä ã
)´´ã å
;´´å ç
var
≠≠ 
propMap
≠≠ 
=
≠≠ 
	typeProps
≠≠ 
.
≠≠  
ToDictionary
≠≠  ,
(
≠≠, -
tp
≠≠- /
=>
≠≠0 2
tp
≠≠3 5
.
≠≠5 6

PropertyId
≠≠6 @
,
≠≠@ A
tp
≠≠B D
=>
≠≠E G
tp
≠≠H J
.
≠≠J K
Property
≠≠K S
)
≠≠S T
;
≠≠T U
var
ÆÆ 
hasViewAnalytics
ÆÆ 
=
ÆÆ 
await
ÆÆ $
workspaceAccess
ÆÆ% 4
.
ÆÆ4 5)
HasWorkspacePermissionAsync
ÆÆ5 P
(
ÆÆP Q
userId
ÆÆQ W
,
ÆÆW X
workspaceId
ÆÆY d
,
ÆÆd e
$str
ÆÆf v
,
ÆÆv w
ct
ÆÆx z
)
ÆÆz {
;
ÆÆ{ |
var
∞∞ 
resolved
∞∞ 
=
∞∞ 
new
∞∞ 
List
∞∞ 
<
∞∞  %
ResolvedFilterCondition
∞∞  7
>
∞∞7 8
(
∞∞8 9
)
∞∞9 :
;
∞∞: ;
foreach
±± 
(
±± 
var
±± 
f
±± 
in
±± 
raw
±± 
)
±± 
{
≤≤ 	
if
≥≥ 
(
≥≥ 
!
≥≥ 
propMap
≥≥ 
.
≥≥ 
TryGetValue
≥≥ $
(
≥≥$ %
f
≥≥% &
.
≥≥& '

PropertyId
≥≥' 1
,
≥≥1 2
out
≥≥3 6
var
≥≥7 :
prop
≥≥; ?
)
≥≥? @
)
≥≥@ A
throw
¥¥ 
new
¥¥ 
AppException
¥¥ &
(
¥¥& '
$str
¥¥' D
,
¥¥D E
$num
¥¥F I
,
¥¥I J
$"
¥¥K M
$str
¥¥M V
{
¥¥V W
f
¥¥W X
.
¥¥X Y

PropertyId
¥¥Y c
}
¥¥c d
$str¥¥d Ñ
{¥¥Ñ Ö
entityTypeId¥¥Ö ë
}¥¥ë í
$str¥¥í ì
"¥¥ì î
)¥¥î ï
;¥¥ï ñ
if
∂∂ 
(
∂∂ 
prop
∂∂ 
.
∂∂ 

IsReadonly
∂∂ 
&&
∂∂  "
!
∂∂# $
hasViewAnalytics
∂∂$ 4
)
∂∂4 5
continue
∑∑ 
;
∑∑ 
resolved
ππ 
.
ππ 
Add
ππ 
(
ππ 
ResolveFilter
ππ &
(
ππ& '
f
ππ' (
,
ππ( )
prop
ππ* .
)
ππ. /
)
ππ/ 0
;
ππ0 1
}
∫∫ 	
return
ªª 
resolved
ªª 
;
ªª 
}
ºº 
private
ææ 
static
ææ %
ResolvedFilterCondition
ææ *
ResolveFilter
ææ+ 8
(
ææ8 9#
EntityFilterCondition
ææ9 N
f
ææO P
,
ææP Q
Property
ææR Z
prop
ææ[ _
)
ææ_ `
=>
ææa c
prop
ææd h
.
ææh i
DataType
ææi q
switch
æær x
{
øø 
PropertyDataType
¿¿ 
.
¿¿ 
String
¿¿ 
=>
¿¿! #
new
¿¿$ '%
ResolvedFilterCondition
¿¿( ?
(
¿¿? @
f
¿¿@ A
.
¿¿A B

PropertyId
¿¿B L
,
¿¿L M
prop
¿¿N R
.
¿¿R S
DataType
¿¿S [
,
¿¿[ \
f
¿¿] ^
.
¿¿^ _
Op
¿¿_ a
,
¿¿a b
f
¿¿c d
.
¿¿d e
Value
¿¿e j
,
¿¿j k
null
¿¿l p
,
¿¿p q
null
¿¿r v
,
¿¿v w
null
¿¿x |
,
¿¿| }
null¿¿~ Ç
)¿¿Ç É
,¿¿É Ñ
PropertyDataType
¡¡ 
.
¡¡ 
Int
¡¡ 
=>
¡¡! #
new
¡¡$ '%
ResolvedFilterCondition
¡¡( ?
(
¡¡? @
f
¡¡@ A
.
¡¡A B

PropertyId
¡¡B L
,
¡¡L M
prop
¡¡N R
.
¡¡R S
DataType
¡¡S [
,
¡¡[ \
f
¡¡] ^
.
¡¡^ _
Op
¡¡_ a
,
¡¡a b
null
¡¡c g
,
¡¡g h
int
¬¬ 
.
¬¬ 
TryParse
¬¬ 
(
¬¬ 
f
¬¬ 
.
¬¬ 
Value
¬¬  
,
¬¬  !
out
¬¬" %
var
¬¬& )
i
¬¬* +
)
¬¬+ ,
?
¬¬- .
i
¬¬/ 0
:
¬¬1 2
throw
¬¬3 8
new
¬¬9 <
AppException
¬¬= I
(
¬¬I J
$str
¬¬J d
,
¬¬d e
$num
¬¬f i
,
¬¬i j
$"
¬¬k m
$str
¬¬m w
{
¬¬w x
prop
¬¬x |
.
¬¬| }
Name¬¬} Å
}¬¬Å Ç
$str¬¬Ç §
"¬¬§ •
)¬¬• ¶
,¬¬¶ ß
null¬¬® ¨
,¬¬¨ ≠
null¬¬Æ ≤
,¬¬≤ ≥
null¬¬¥ ∏
)¬¬∏ π
,¬¬π ∫
PropertyDataType
√√ 
.
√√ 
Decimal
√√  
=>
√√! #
new
√√$ '%
ResolvedFilterCondition
√√( ?
(
√√? @
f
√√@ A
.
√√A B

PropertyId
√√B L
,
√√L M
prop
√√N R
.
√√R S
DataType
√√S [
,
√√[ \
f
√√] ^
.
√√^ _
Op
√√_ a
,
√√a b
null
√√c g
,
√√g h
null
√√i m
,
√√m n
decimal
ƒƒ 
.
ƒƒ 
TryParse
ƒƒ 
(
ƒƒ 
f
ƒƒ 
.
ƒƒ 
Value
ƒƒ $
,
ƒƒ$ %
NumberStyles
ƒƒ& 2
.
ƒƒ2 3
Number
ƒƒ3 9
,
ƒƒ9 :
CultureInfo
ƒƒ; F
.
ƒƒF G
InvariantCulture
ƒƒG W
,
ƒƒW X
out
ƒƒY \
var
ƒƒ] `
d
ƒƒa b
)
ƒƒb c
?
ƒƒd e
d
ƒƒf g
:
ƒƒh i
throw
ƒƒj o
new
ƒƒp s
AppExceptionƒƒt Ä
(ƒƒÄ Å
$strƒƒÅ õ
,ƒƒõ ú
$numƒƒù †
,ƒƒ† °
$"ƒƒ¢ §
$strƒƒ§ Æ
{ƒƒÆ Ø
propƒƒØ ≥
.ƒƒ≥ ¥
Nameƒƒ¥ ∏
}ƒƒ∏ π
$strƒƒπ ⁄
"ƒƒ⁄ €
)ƒƒ€ ‹
,ƒƒ‹ ›
nullƒƒﬁ ‚
,ƒƒ‚ „
nullƒƒ‰ Ë
)ƒƒË È
,ƒƒÈ Í
PropertyDataType
≈≈ 
.
≈≈ 
Bool
≈≈ 
=>
≈≈! #
new
≈≈$ '%
ResolvedFilterCondition
≈≈( ?
(
≈≈? @
f
≈≈@ A
.
≈≈A B

PropertyId
≈≈B L
,
≈≈L M
prop
≈≈N R
.
≈≈R S
DataType
≈≈S [
,
≈≈[ \
f
≈≈] ^
.
≈≈^ _
Op
≈≈_ a
,
≈≈a b
null
≈≈c g
,
≈≈g h
null
≈≈i m
,
≈≈m n
null
≈≈o s
,
≈≈s t
bool
∆∆ 
.
∆∆ 
TryParse
∆∆ 
(
∆∆ 
f
∆∆ 
.
∆∆ 
Value
∆∆ !
,
∆∆! "
out
∆∆# &
var
∆∆' *
b
∆∆+ ,
)
∆∆, -
?
∆∆. /
b
∆∆0 1
:
∆∆2 3
throw
∆∆4 9
new
∆∆: =
AppException
∆∆> J
(
∆∆J K
$str
∆∆K e
,
∆∆e f
$num
∆∆g j
,
∆∆j k
$"
∆∆l n
$str
∆∆n x
{
∆∆x y
prop
∆∆y }
.
∆∆} ~
Name∆∆~ Ç
}∆∆Ç É
$str∆∆É ±
"∆∆± ≤
)∆∆≤ ≥
,∆∆≥ ¥
null∆∆µ π
)∆∆π ∫
,∆∆∫ ª
PropertyDataType
«« 
.
«« 
Date
«« 
=>
««! #
new
««$ '%
ResolvedFilterCondition
««( ?
(
««? @
f
««@ A
.
««A B

PropertyId
««B L
,
««L M
prop
««N R
.
««R S
DataType
««S [
,
««[ \
f
««] ^
.
««^ _
Op
««_ a
,
««a b
null
««c g
,
««g h
null
««i m
,
««m n
null
««o s
,
««s t
null
««u y
,
««y z
DateOnly
»» 
.
»» 
TryParseExact
»» "
(
»»" #
f
»»# $
.
»»$ %
Value
»»% *
,
»»* +
$str
»», 8
,
»»8 9
CultureInfo
»»: E
.
»»E F
InvariantCulture
»»F V
,
»»V W
DateTimeStyles
»»X f
.
»»f g
None
»»g k
,
»»k l
out
»»m p
var
»»q t
dt
»»u w
)
»»w x
?
»»y z
dt
»»{ }
:
»»~ 
throw»»Ä Ö
new»»Ü â
AppException»»ä ñ
(»»ñ ó
$str»»ó Æ
,»»Æ Ø
$num»»∞ ≥
,»»≥ ¥
$"»»µ ∑
$str»»∑ ¡
{»»¡ ¬
prop»»¬ ∆
.»»∆ «
Name»»« À
}»»À Ã
$str»»Ã ˇ
"»»ˇ Ä
)»»Ä Å
)»»Å Ç
,»»Ç É
_
…… 	
=>
……
 
throw
…… 
new
…… 
AppException
…… #
(
……# $
$str
……$ B
,
……B C
$num
……D G
,
……G H
$"
……I K
$str
……K b
{
……b c
prop
……c g
.
……g h
DataType
……h p
}
……p q
$str……q ã
{……ã å
prop……å ê
.……ê ë
Name……ë ï
}……ï ñ
$str……ñ ò
"……ò ô
)……ô ö
}
   
;
   
private
ÃÃ 
async
ÃÃ 
Task
ÃÃ (
EnsureCanAccessEntityAsync
ÃÃ 1
(
ÃÃ1 2
int
ÃÃ2 5
userId
ÃÃ6 <
,
ÃÃ< =
int
ÃÃ> A
workspaceId
ÃÃB M
,
ÃÃM N
Entity
ÃÃO U
entity
ÃÃV \
,
ÃÃ\ ]
CancellationToken
ÃÃ^ o
ct
ÃÃp r
)
ÃÃr s
{
ÕÕ 
if
ŒŒ 

(
ŒŒ 
entity
ŒŒ 
.
ŒŒ 
CreatedByUserId
ŒŒ "
==
ŒŒ# %
userId
ŒŒ& ,
)
ŒŒ, -
return
œœ 
;
œœ 
var
—— 
userIds
—— 
=
—— 
new
—— 
[
—— 
]
—— 
{
—— 
userId
—— $
,
——$ %
entity
——& ,
.
——, -
CreatedByUserId
——- <
}
——= >
;
——> ?
var
““ 

priorities
““ 
=
““ 
await
““ 
memberRepository
““ /
.
““/ 0-
GetRolePrioritiesByUserIdsAsync
““0 O
(
““O P
workspaceId
““P [
,
““[ \
userIds
““] d
,
““d e
ct
““f h
)
““h i
;
““i j
if
”” 

(
”” 
!
”” 

priorities
”” 
.
”” 
TryGetValue
”” #
(
””# $
userId
””$ *
,
””* +
out
””, /
var
””0 3
callerPriority
””4 B
)
””B C
||
””D F
!
‘‘ 

priorities
‘‘ 
.
‘‘ 
TryGetValue
‘‘ #
(
‘‘# $
entity
‘‘$ *
.
‘‘* +
CreatedByUserId
‘‘+ :
,
‘‘: ;
out
‘‘< ?
var
‘‘@ C
creatorPriority
‘‘D S
)
‘‘S T
)
‘‘T U
{
’’ 	
throw
÷÷ 
new
÷÷ 
AppException
÷÷ "
(
÷÷" #
$str
÷÷# 2
,
÷÷2 3
$num
÷÷4 7
,
÷÷7 8
$str
÷÷9 H
)
÷÷H I
;
÷÷I J
}
◊◊ 	
if
⁄⁄ 

(
⁄⁄ 
callerPriority
⁄⁄ 
>=
⁄⁄ 
creatorPriority
⁄⁄ -
)
⁄⁄- .
throw
€€ 
new
€€ 
AppException
€€ "
(
€€" #
$str
€€# 2
,
€€2 3
$num
€€4 7
,
€€7 8
$str
€€9 H
)
€€H I
;
€€I J
}
‹‹ 
private
·· 
static
·· 
void
·· (
ValidateRequestPropertyIds
·· 2
(
··2 3
List
‚‚ 
<
‚‚  
PropertyValueInput
‚‚ 
>
‚‚  
request
‚‚! (
,
‚‚( )
List
„„ 
<
„„  
EntityTypeProperty
„„ 
>
„„  
typeProperties
„„! /
)
„„/ 0
{
‰‰ 
var
ÂÂ 

allowedIds
ÂÂ 
=
ÂÂ 
typeProperties
ÂÂ '
.
ÂÂ' (
Select
ÂÂ( .
(
ÂÂ. /
tp
ÂÂ/ 1
=>
ÂÂ2 4
tp
ÂÂ5 7
.
ÂÂ7 8

PropertyId
ÂÂ8 B
)
ÂÂB C
.
ÂÂC D
	ToHashSet
ÂÂD M
(
ÂÂM N
)
ÂÂN O
;
ÂÂO P
var
ÁÁ 

duplicates
ÁÁ 
=
ÁÁ 
request
ÁÁ  
.
ÁÁ  !
GroupBy
ÁÁ! (
(
ÁÁ( )
p
ÁÁ) *
=>
ÁÁ+ -
p
ÁÁ. /
.
ÁÁ/ 0

PropertyId
ÁÁ0 :
)
ÁÁ: ;
.
ÁÁ; <
Where
ÁÁ< A
(
ÁÁA B
g
ÁÁB C
=>
ÁÁD F
g
ÁÁG H
.
ÁÁH I
Count
ÁÁI N
(
ÁÁN O
)
ÁÁO P
>
ÁÁQ R
$num
ÁÁS T
)
ÁÁT U
.
ÁÁU V
Select
ÁÁV \
(
ÁÁ\ ]
g
ÁÁ] ^
=>
ÁÁ_ a
g
ÁÁb c
.
ÁÁc d
Key
ÁÁd g
)
ÁÁg h
.
ÁÁh i
ToList
ÁÁi o
(
ÁÁo p
)
ÁÁp q
;
ÁÁq r
if
ËË 

(
ËË 

duplicates
ËË 
.
ËË 
Count
ËË 
>
ËË 
$num
ËË  
)
ËË  !
throw
ÈÈ 
new
ÈÈ 
AppException
ÈÈ "
(
ÈÈ" #
$str
ÈÈ# ;
,
ÈÈ; <
$num
ÈÈ= @
,
ÈÈ@ A
$"
ÈÈB D
$str
ÈÈD g
{
ÈÈg h
string
ÈÈh n
.
ÈÈn o
Join
ÈÈo s
(
ÈÈs t
$str
ÈÈt x
,
ÈÈx y

duplicatesÈÈz Ñ
)ÈÈÑ Ö
}ÈÈÖ Ü
$strÈÈÜ á
"ÈÈá à
)ÈÈà â
;ÈÈâ ä
var
ÎÎ 
unknown
ÎÎ 
=
ÎÎ 
request
ÎÎ 
.
ÎÎ 
Select
ÎÎ $
(
ÎÎ$ %
p
ÎÎ% &
=>
ÎÎ' )
p
ÎÎ* +
.
ÎÎ+ ,

PropertyId
ÎÎ, 6
)
ÎÎ6 7
.
ÎÎ7 8
Except
ÎÎ8 >
(
ÎÎ> ?

allowedIds
ÎÎ? I
)
ÎÎI J
.
ÎÎJ K
ToList
ÎÎK Q
(
ÎÎQ R
)
ÎÎR S
;
ÎÎS T
if
ÏÏ 

(
ÏÏ 
unknown
ÏÏ 
.
ÏÏ 
Count
ÏÏ 
>
ÏÏ 
$num
ÏÏ 
)
ÏÏ 
throw
ÌÌ 
new
ÌÌ 
AppException
ÌÌ "
(
ÌÌ" #
$str
ÌÌ# B
,
ÌÌB C
$num
ÌÌD G
,
ÌÌG H
$"
ÌÌI K
$str
ÌÌK V
{
ÌÌV W
string
ÌÌW ]
.
ÌÌ] ^
Join
ÌÌ^ b
(
ÌÌb c
$str
ÌÌc g
,
ÌÌg h
unknown
ÌÌi p
)
ÌÌp q
}
ÌÌq r
$strÌÌr ï
"ÌÌï ñ
)ÌÌñ ó
;ÌÌó ò
}
ÓÓ 
private
ÙÙ 
static
ÙÙ 
List
ÙÙ 
<
ÙÙ  
PropertyValueInput
ÙÙ *
>
ÙÙ* +"
MergePropertyPayload
ÙÙ, @
(
ÙÙ@ A
Entity
ÙÙA G
entity
ÙÙH N
,
ÙÙN O
List
ÙÙP T
<
ÙÙT U 
PropertyValueInput
ÙÙU g
>
ÙÙg h
request
ÙÙi p
)
ÙÙp q
{
ıı 
var
ˆˆ 
reqById
ˆˆ 
=
ˆˆ 
request
ˆˆ 
.
ˆˆ 
ToDictionary
ˆˆ *
(
ˆˆ* +
p
ˆˆ+ ,
=>
ˆˆ- /
p
ˆˆ0 1
.
ˆˆ1 2

PropertyId
ˆˆ2 <
,
ˆˆ< =
p
ˆˆ> ?
=>
ˆˆ@ B
p
ˆˆC D
.
ˆˆD E
Value
ˆˆE J
)
ˆˆJ K
;
ˆˆK L
var
˜˜ 
existingStrings
˜˜ 
=
˜˜ 
entity
˜˜ $
.
˜˜$ %"
EntityPropertyValues
˜˜% 9
.
˜˜9 :
ToDictionary
˜˜: F
(
˜˜F G
epv
¯¯ 
=>
¯¯ 
epv
¯¯ 
.
¯¯ 

PropertyId
¯¯ !
,
¯¯! "
epv
˘˘ 
=>
˘˘  
ValueToInputString
˘˘ %
(
˘˘% &
epv
˘˘& )
)
˘˘) *
)
˘˘* +
;
˘˘+ ,
var
˚˚ 
	mergedIds
˚˚ 
=
˚˚ 
existingStrings
˚˚ '
.
˚˚' (
Keys
˚˚( ,
.
˚˚, -
Union
˚˚- 2
(
˚˚2 3
reqById
˚˚3 :
.
˚˚: ;
Keys
˚˚; ?
)
˚˚? @
.
˚˚@ A
OrderBy
˚˚A H
(
˚˚H I
id
˚˚I K
=>
˚˚L N
id
˚˚O Q
)
˚˚Q R
.
˚˚R S
ToList
˚˚S Y
(
˚˚Y Z
)
˚˚Z [
;
˚˚[ \
var
¸¸ 
result
¸¸ 
=
¸¸ 
new
¸¸ 
List
¸¸ 
<
¸¸  
PropertyValueInput
¸¸ 0
>
¸¸0 1
(
¸¸1 2
	mergedIds
¸¸2 ;
.
¸¸; <
Count
¸¸< A
)
¸¸A B
;
¸¸B C
foreach
˝˝ 
(
˝˝ 
var
˝˝ 
id
˝˝ 
in
˝˝ 
	mergedIds
˝˝ $
)
˝˝$ %
{
˛˛ 	
if
ˇˇ 
(
ˇˇ 
reqById
ˇˇ 
.
ˇˇ 
TryGetValue
ˇˇ #
(
ˇˇ# $
id
ˇˇ$ &
,
ˇˇ& '
out
ˇˇ( +
var
ˇˇ, /
	requested
ˇˇ0 9
)
ˇˇ9 :
)
ˇˇ: ;
result
ÄÄ 
.
ÄÄ 
Add
ÄÄ 
(
ÄÄ 
new
ÄÄ  
PropertyValueInput
ÄÄ 1
(
ÄÄ1 2
id
ÄÄ2 4
,
ÄÄ4 5
	requested
ÄÄ6 ?
)
ÄÄ? @
)
ÄÄ@ A
;
ÄÄA B
else
ÅÅ 
if
ÅÅ 
(
ÅÅ 
existingStrings
ÅÅ $
.
ÅÅ$ %
TryGetValue
ÅÅ% 0
(
ÅÅ0 1
id
ÅÅ1 3
,
ÅÅ3 4
out
ÅÅ5 8
var
ÅÅ9 <
kept
ÅÅ= A
)
ÅÅA B
)
ÅÅB C
result
ÇÇ 
.
ÇÇ 
Add
ÇÇ 
(
ÇÇ 
new
ÇÇ  
PropertyValueInput
ÇÇ 1
(
ÇÇ1 2
id
ÇÇ2 4
,
ÇÇ4 5
kept
ÇÇ6 :
)
ÇÇ: ;
)
ÇÇ; <
;
ÇÇ< =
}
ÉÉ 	
return
ÖÖ 
result
ÖÖ 
;
ÖÖ 
}
ÜÜ 
private
àà 
static
àà 
string
àà 
?
àà  
ValueToInputString
àà -
(
àà- .!
EntityPropertyValue
àà. A
pv
ààB D
)
ààD E
=>
ààF H
pv
ààI K
.
ààK L
Property
ààL T
.
ààT U
DataType
ààU ]
switch
àà^ d
{
ââ 
PropertyDataType
ää 
.
ää 
String
ää 
=>
ää! #
pv
ää$ &
.
ää& '
ValueString
ää' 2
,
ää2 3
PropertyDataType
ãã 
.
ãã 
Int
ãã 
=>
ãã! #
pv
ãã$ &
.
ãã& '
ValueInt
ãã' /
?
ãã/ 0
.
ãã0 1
ToString
ãã1 9
(
ãã9 :
CultureInfo
ãã: E
.
ããE F
InvariantCulture
ããF V
)
ããV W
,
ããW X
PropertyDataType
åå 
.
åå 
Decimal
åå  
=>
åå! #
pv
åå$ &
.
åå& '
ValueDecimal
åå' 3
?
åå3 4
.
åå4 5
ToString
åå5 =
(
åå= >
CultureInfo
åå> I
.
ååI J
InvariantCulture
ååJ Z
)
ååZ [
,
åå[ \
PropertyDataType
çç 
.
çç 
Bool
çç 
=>
çç! #
pv
çç$ &
.
çç& '
	ValueBool
çç' 0
?
çç0 1
.
çç1 2
ToString
çç2 :
(
çç: ;
)
çç; <
,
çç< =
PropertyDataType
éé 
.
éé 
Date
éé 
=>
éé! #
pv
éé$ &
.
éé& '
	ValueDate
éé' 0
?
éé0 1
.
éé1 2
ToString
éé2 :
(
éé: ;
$str
éé; G
,
ééG H
CultureInfo
ééI T
.
ééT U
InvariantCulture
ééU e
)
éée f
,
ééf g
_
èè 	
=>
èè! #
null
èè$ (
}
êê 
;
êê 
private
íí 
static
íí 
void
íí '
ValidateReadonlyPreserved
íí 1
(
íí1 2
Entity
ìì 
entity
ìì 
,
ìì 
List
îî 
<
îî  
PropertyValueInput
îî 
>
îî  
merged
îî! '
,
îî' (
List
ïï 
<
ïï  
EntityTypeProperty
ïï 
>
ïï  
typeProperties
ïï! /
)
ïï/ 0
{
ññ 
foreach
óó 
(
óó 
var
óó 
tp
óó 
in
óó 
typeProperties
óó )
.
óó) *
Where
óó* /
(
óó/ 0
tp
óó0 2
=>
óó3 5
tp
óó6 8
.
óó8 9
Property
óó9 A
.
óóA B

IsReadonly
óóB L
)
óóL M
)
óóM N
{
òò 	
var
ôô 
mergedEntry
ôô 
=
ôô 
merged
ôô $
.
ôô$ %
FirstOrDefault
ôô% 3
(
ôô3 4
m
ôô4 5
=>
ôô6 8
m
ôô9 :
.
ôô: ;

PropertyId
ôô; E
==
ôôF H
tp
ôôI K
.
ôôK L

PropertyId
ôôL V
)
ôôV W
;
ôôW X
if
öö 
(
öö 
mergedEntry
öö 
is
öö 
null
öö #
)
öö# $
continue
õõ 
;
õõ 
var
ùù 
	mergedVal
ùù 
=
ùù 
mergedEntry
ùù '
.
ùù' (
Value
ùù( -
;
ùù- .
var
ûû 
existing
ûû 
=
ûû 
entity
ûû !
.
ûû! ""
EntityPropertyValues
ûû" 6
.
ûû6 7
FirstOrDefault
ûû7 E
(
ûûE F
e
ûûF G
=>
ûûH J
e
ûûK L
.
ûûL M

PropertyId
ûûM W
==
ûûX Z
tp
ûû[ ]
.
ûû] ^

PropertyId
ûû^ h
)
ûûh i
;
ûûi j
var
üü 
existingStr
üü 
=
üü 
existing
üü &
is
üü' )
null
üü* .
?
üü/ 0
null
üü1 5
:
üü6 7 
ValueToInputString
üü8 J
(
üüJ K
existing
üüK S
)
üüS T
;
üüT U
if
†† 
(
†† 
!
†† 
string
†† 
.
†† 
Equals
†† 
(
†† 
	mergedVal
†† (
,
††( )
existingStr
††* 5
,
††5 6
StringComparison
††7 G
.
††G H
Ordinal
††H O
)
††O P
)
††P Q
throw
°° 
new
°° 
AppException
°° &
(
°°& '
$str
°°' ;
,
°°; <
$num
°°= @
,
°°@ A
$"
°°B D
$str
°°D N
{
°°N O
tp
°°O Q
.
°°Q R
Property
°°R Z
.
°°Z [
Name
°°[ _
}
°°_ `
$str
°°` o
"
°°o p
)
°°p q
;
°°q r
}
¢¢ 	
}
££ 
private
¨¨ 
static
¨¨ 
void
¨¨ %
ValidatePropertyPayload
¨¨ /
(
¨¨/ 0
List
≠≠ 
<
≠≠  
PropertyValueInput
≠≠ 
>
≠≠  
	submitted
≠≠! *
,
≠≠* +
List
ÆÆ 
<
ÆÆ  
EntityTypeProperty
ÆÆ 
>
ÆÆ  
typeProperties
ÆÆ! /
)
ÆÆ/ 0
{
ØØ 
var
∞∞ 

allowedIds
∞∞ 
=
∞∞ 
typeProperties
∞∞ '
.
∞∞' (
Select
∞∞( .
(
∞∞. /
tp
∞∞/ 1
=>
∞∞2 4
tp
∞∞5 7
.
∞∞7 8

PropertyId
∞∞8 B
)
∞∞B C
.
∞∞C D
	ToHashSet
∞∞D M
(
∞∞M N
)
∞∞N O
;
∞∞O P
var
±± 
requiredIds
±± 
=
±± 
typeProperties
±± (
.
±±( )
Where
±±) .
(
±±. /
tp
±±/ 1
=>
±±2 4
tp
±±5 7
.
±±7 8

IsRequired
±±8 B
)
±±B C
.
±±C D
Select
±±D J
(
±±J K
tp
±±K M
=>
±±N P
tp
±±Q S
.
±±S T

PropertyId
±±T ^
)
±±^ _
.
±±_ `
	ToHashSet
±±` i
(
±±i j
)
±±j k
;
±±k l
var
≥≥ 

duplicates
≥≥ 
=
≥≥ 
	submitted
≥≥ "
.
≥≥" #
GroupBy
≥≥# *
(
≥≥* +
p
≥≥+ ,
=>
≥≥- /
p
≥≥0 1
.
≥≥1 2

PropertyId
≥≥2 <
)
≥≥< =
.
≥≥= >
Where
≥≥> C
(
≥≥C D
g
≥≥D E
=>
≥≥F H
g
≥≥I J
.
≥≥J K
Count
≥≥K P
(
≥≥P Q
)
≥≥Q R
>
≥≥S T
$num
≥≥U V
)
≥≥V W
.
≥≥W X
Select
≥≥X ^
(
≥≥^ _
g
≥≥_ `
=>
≥≥a c
g
≥≥d e
.
≥≥e f
Key
≥≥f i
)
≥≥i j
.
≥≥j k
ToList
≥≥k q
(
≥≥q r
)
≥≥r s
;
≥≥s t
if
¥¥ 

(
¥¥ 

duplicates
¥¥ 
.
¥¥ 
Count
¥¥ 
>
¥¥ 
$num
¥¥  
)
¥¥  !
throw
µµ 
new
µµ 
AppException
µµ "
(
µµ" #
$str
µµ# ;
,
µµ; <
$num
µµ= @
,
µµ@ A
$"
µµB D
$str
µµD f
{
µµf g
string
µµg m
.
µµm n
Join
µµn r
(
µµr s
$str
µµs w
,
µµw x

duplicatesµµy É
)µµÉ Ñ
}µµÑ Ö
$strµµÖ Ü
"µµÜ á
)µµá à
;µµà â
var
∑∑ 
unknown
∑∑ 
=
∑∑ 
	submitted
∑∑ 
.
∑∑  
Select
∑∑  &
(
∑∑& '
p
∑∑' (
=>
∑∑) +
p
∑∑, -
.
∑∑- .

PropertyId
∑∑. 8
)
∑∑8 9
.
∑∑9 :
Except
∑∑: @
(
∑∑@ A

allowedIds
∑∑A K
)
∑∑K L
.
∑∑L M
ToList
∑∑M S
(
∑∑S T
)
∑∑T U
;
∑∑U V
if
∏∏ 

(
∏∏ 
unknown
∏∏ 
.
∏∏ 
Count
∏∏ 
>
∏∏ 
$num
∏∏ 
)
∏∏ 
throw
ππ 
new
ππ 
AppException
ππ "
(
ππ" #
$str
ππ# B
,
ππB C
$num
ππD G
,
ππG H
$"
ππI K
$str
ππK V
{
ππV W
string
ππW ]
.
ππ] ^
Join
ππ^ b
(
ππb c
$str
ππc g
,
ππg h
unknown
ππi p
)
ππp q
}
ππq r
$strππr ï
"ππï ñ
)ππñ ó
;ππó ò
var
ªª 
submittedIds
ªª 
=
ªª 
	submitted
ªª $
.
ªª$ %
Where
ªª% *
(
ªª* +
p
ªª+ ,
=>
ªª- /
p
ªª0 1
.
ªª1 2
Value
ªª2 7
is
ªª8 :
not
ªª; >
null
ªª? C
)
ªªC D
.
ªªD E
Select
ªªE K
(
ªªK L
p
ªªL M
=>
ªªN P
p
ªªQ R
.
ªªR S

PropertyId
ªªS ]
)
ªª] ^
.
ªª^ _
	ToHashSet
ªª_ h
(
ªªh i
)
ªªi j
;
ªªj k
var
ºº 
missingRequired
ºº 
=
ºº 
requiredIds
ºº )
.
ºº) *
Except
ºº* 0
(
ºº0 1
submittedIds
ºº1 =
)
ºº= >
.
ºº> ?
ToList
ºº? E
(
ººE F
)
ººF G
;
ººG H
if
ΩΩ 

(
ΩΩ 
missingRequired
ΩΩ 
.
ΩΩ 
Count
ΩΩ !
>
ΩΩ" #
$num
ΩΩ$ %
)
ΩΩ% &
{
ææ 	
var
øø 
details
øø 
=
øø 
typeProperties
øø (
.
¿¿ 
Where
¿¿ 
(
¿¿ 
tp
¿¿ 
=>
¿¿ 
missingRequired
¿¿ ,
.
¿¿, -
Contains
¿¿- 5
(
¿¿5 6
tp
¿¿6 8
.
¿¿8 9

PropertyId
¿¿9 C
)
¿¿C D
)
¿¿D E
.
¡¡ 
Select
¡¡ 
(
¡¡ 
tp
¡¡ 
=>
¡¡ 
$"
¡¡  
{
¡¡  !
tp
¡¡! #
.
¡¡# $
Property
¡¡$ ,
.
¡¡, -
Name
¡¡- 1
}
¡¡1 2
$str
¡¡2 ?
{
¡¡? @
tp
¡¡@ B
.
¡¡B C

PropertyId
¡¡C M
}
¡¡M N
$str
¡¡N O
"
¡¡O P
)
¡¡P Q
;
¡¡Q R
throw
¬¬ 
new
¬¬ 
AppException
¬¬ "
(
¬¬" #
$str
¬¬# @
,
¬¬@ A
$num
¬¬B E
,
¬¬E F
$"
¬¬G I
$str
¬¬I j
{
¬¬j k
string
¬¬k q
.
¬¬q r
Join
¬¬r v
(
¬¬v w
$str
¬¬w {
,
¬¬{ |
details¬¬} Ñ
)¬¬Ñ Ö
}¬¬Ö Ü
$str¬¬Ü á
"¬¬á à
)¬¬à â
;¬¬â ä
}
√√ 	
var
≈≈ 
emptyStringIds
≈≈ 
=
≈≈ 
typeProperties
≈≈ +
.
∆∆ 
Where
∆∆ 
(
∆∆ 
tp
∆∆ 
=>
∆∆ 
tp
∆∆ 
.
∆∆ 

IsRequired
∆∆ &
&&
∆∆' )
tp
∆∆* ,
.
∆∆, -
Property
∆∆- 5
.
∆∆5 6
DataType
∆∆6 >
==
∆∆? A
PropertyDataType
∆∆B R
.
∆∆R S
String
∆∆S Y
)
∆∆Y Z
.
«« 
Where
«« 
(
«« 
tp
«« 
=>
«« 
	submitted
«« "
.
««" #
Any
««# &
(
««& '
p
««' (
=>
««) +
p
««, -
.
««- .

PropertyId
««. 8
==
««9 ;
tp
««< >
.
««> ?

PropertyId
««? I
&&
««J L
string
««M S
.
««S T 
IsNullOrWhiteSpace
««T f
(
««f g
p
««g h
.
««h i
Value
««i n
)
««n o
)
««o p
)
««p q
.
»» 
Select
»» 
(
»» 
tp
»» 
=>
»» 
tp
»» 
.
»» 

PropertyId
»» '
)
»»' (
.
…… 
ToList
…… 
(
…… 
)
…… 
;
…… 
if
ÀÀ 

(
ÀÀ 
emptyStringIds
ÀÀ 
.
ÀÀ 
Count
ÀÀ  
>
ÀÀ! "
$num
ÀÀ# $
)
ÀÀ$ %
{
ÃÃ 	
var
ÕÕ 
emptyDetails
ÕÕ 
=
ÕÕ 
typeProperties
ÕÕ -
.
ŒŒ 
Where
ŒŒ 
(
ŒŒ 
tp
ŒŒ 
=>
ŒŒ 
emptyStringIds
ŒŒ +
.
ŒŒ+ ,
Contains
ŒŒ, 4
(
ŒŒ4 5
tp
ŒŒ5 7
.
ŒŒ7 8

PropertyId
ŒŒ8 B
)
ŒŒB C
)
ŒŒC D
.
œœ 
Select
œœ 
(
œœ 
tp
œœ 
=>
œœ 
$"
œœ  
{
œœ  !
tp
œœ! #
.
œœ# $
Property
œœ$ ,
.
œœ, -
Name
œœ- 1
}
œœ1 2
$str
œœ2 ?
{
œœ? @
tp
œœ@ B
.
œœB C

PropertyId
œœC M
}
œœM N
$str
œœN O
"
œœO P
)
œœP Q
;
œœQ R
throw
–– 
new
–– 
AppException
–– "
(
––" #
$str
––# :
,
––: ;
$num
––< ?
,
––? @
$"
––A C
$str
––C }
{
––} ~
string––~ Ñ
.––Ñ Ö
Join––Ö â
(––â ä
$str––ä é
,––é è
emptyDetails––ê ú
)––ú ù
}––ù û
$str––û ü
"––ü †
)––† °
;––° ¢
}
—— 	
foreach
”” 
(
”” 
var
”” 
tp
”” 
in
”” 
typeProperties
”” )
.
””) *
Where
””* /
(
””/ 0
tp
””0 2
=>
””3 5
tp
””6 8
.
””8 9
Property
””9 A
.
””A B

IsReadonly
””B L
)
””L M
)
””M N
{
‘‘ 	
var
’’ 
s
’’ 
=
’’ 
	submitted
’’ 
.
’’ 
FirstOrDefault
’’ ,
(
’’, -
x
’’- .
=>
’’/ 1
x
’’2 3
.
’’3 4

PropertyId
’’4 >
==
’’? A
tp
’’B D
.
’’D E

PropertyId
’’E O
)
’’O P
;
’’P Q
if
÷÷ 
(
÷÷ 
s
÷÷ 
?
÷÷ 
.
÷÷ 
Value
÷÷ 
is
÷÷ 
not
÷÷ 
null
÷÷  $
)
÷÷$ %
throw
◊◊ 
new
◊◊ 
AppException
◊◊ &
(
◊◊& '
$str
◊◊' ;
,
◊◊; <
$num
◊◊= @
,
◊◊@ A
$"
◊◊B D
$str
◊◊D N
{
◊◊N O
tp
◊◊O Q
.
◊◊Q R
Property
◊◊R Z
.
◊◊Z [
Name
◊◊[ _
}
◊◊_ `
$str
◊◊` o
"
◊◊o p
)
◊◊p q
;
◊◊q r
}
ÿÿ 	
}
ŸŸ 
private
ﬂﬂ 
static
ﬂﬂ 
List
ﬂﬂ 
<
ﬂﬂ !
EntityPropertyValue
ﬂﬂ +
>
ﬂﬂ+ ,!
BuildPropertyValues
ﬂﬂ- @
(
ﬂﬂ@ A
List
‡‡ 
<
‡‡  
PropertyValueInput
‡‡ 
>
‡‡  
	submitted
‡‡! *
,
‡‡* +
List
·· 
<
··  
EntityTypeProperty
·· 
>
··  
typeProperties
··! /
)
··/ 0
{
‚‚ 
var
„„ 
propertyMap
„„ 
=
„„ 
typeProperties
„„ (
.
„„( )
ToDictionary
„„) 5
(
„„5 6
tp
„„6 8
=>
„„9 ;
tp
„„< >
.
„„> ?

PropertyId
„„? I
,
„„I J
tp
„„K M
=>
„„N P
tp
„„Q S
.
„„S T
Property
„„T \
)
„„\ ]
;
„„] ^
var
‰‰ 
result
‰‰ 
=
‰‰ 
new
‰‰ 
List
‰‰ 
<
‰‰ !
EntityPropertyValue
‰‰ 1
>
‰‰1 2
(
‰‰2 3
)
‰‰3 4
;
‰‰4 5
foreach
ÊÊ 
(
ÊÊ 
var
ÊÊ 
input
ÊÊ 
in
ÊÊ 
	submitted
ÊÊ '
.
ÊÊ' (
Where
ÊÊ( -
(
ÊÊ- .
p
ÊÊ. /
=>
ÊÊ0 2
p
ÊÊ3 4
.
ÊÊ4 5
Value
ÊÊ5 :
is
ÊÊ; =
not
ÊÊ> A
null
ÊÊB F
)
ÊÊF G
)
ÊÊG H
{
ÁÁ 	
if
ËË 
(
ËË 
!
ËË 
propertyMap
ËË 
.
ËË 
TryGetValue
ËË (
(
ËË( )
input
ËË) .
.
ËË. /

PropertyId
ËË/ 9
,
ËË9 :
out
ËË; >
var
ËË? B
prop
ËËC G
)
ËËG H
)
ËËH I
continue
ÈÈ 
;
ÈÈ 
var
ÎÎ 
pv
ÎÎ 
=
ÎÎ 
new
ÎÎ !
EntityPropertyValue
ÎÎ ,
{
ÎÎ- .

PropertyId
ÎÎ/ 9
=
ÎÎ: ;
input
ÎÎ< A
.
ÎÎA B

PropertyId
ÎÎB L
}
ÎÎM N
;
ÎÎN O
switch
ÌÌ 
(
ÌÌ 
prop
ÌÌ 
.
ÌÌ 
DataType
ÌÌ !
)
ÌÌ! "
{
ÓÓ 
case
ÔÔ 
PropertyDataType
ÔÔ %
.
ÔÔ% &
String
ÔÔ& ,
:
ÔÔ, -
if
 
(
 
prop
 
.
 
AllowedValues
 *
.
* +
Count
+ 0
>
1 2
$num
3 4
&&
ÒÒ 
!
ÒÒ 
prop
ÒÒ  
.
ÒÒ  !
AllowedValues
ÒÒ! .
.
ÒÒ. /
Any
ÒÒ/ 2
(
ÒÒ2 3
av
ÒÒ3 5
=>
ÒÒ6 8
string
ÒÒ9 ?
.
ÒÒ? @
Equals
ÒÒ@ F
(
ÒÒF G
av
ÒÒG I
.
ÒÒI J
Value
ÒÒJ O
,
ÒÒO P
input
ÒÒQ V
.
ÒÒV W
Value
ÒÒW \
,
ÒÒ\ ]
StringComparison
ÒÒ^ n
.
ÒÒn o 
OrdinalIgnoreCaseÒÒo Ä
)ÒÒÄ Å
)ÒÒÅ Ç
)ÒÒÇ É
{
ÚÚ 
throw
ÛÛ 
new
ÛÛ !
AppException
ÛÛ" .
(
ÛÛ. /
$str
ÛÛ/ F
,
ÛÛF G
$num
ÛÛH K
,
ÛÛK L
$"
ÙÙ 
$str
ÙÙ 
{
ÙÙ  
input
ÙÙ  %
.
ÙÙ% &
Value
ÙÙ& +
}
ÙÙ+ ,
$str
ÙÙ, H
{
ÙÙH I
prop
ÙÙI M
.
ÙÙM N
Name
ÙÙN R
}
ÙÙR S
$str
ÙÙS V
"
ÙÙV W
+
ÙÙX Y
$"
ıı 
$str
ıı '
{
ıı' (
string
ıı( .
.
ıı. /
Join
ıı/ 3
(
ıı3 4
$str
ıı4 8
,
ıı8 9
prop
ıı: >
.
ıı> ?
AllowedValues
ıı? L
.
ııL M
Select
ııM S
(
ııS T
av
ııT V
=>
ııW Y
av
ııZ \
.
ıı\ ]
Value
ıı] b
)
ııb c
)
ııc d
}
ııd e
$str
ııe f
"
ııf g
)
ııg h
;
ııh i
}
ˆˆ 
pv
˜˜ 
.
˜˜ 
ValueString
˜˜ "
=
˜˜# $
input
˜˜% *
.
˜˜* +
Value
˜˜+ 0
;
˜˜0 1
break
¯¯ 
;
¯¯ 
case
˙˙ 
PropertyDataType
˙˙ %
.
˙˙% &
Int
˙˙& )
:
˙˙) *
if
˚˚ 
(
˚˚ 
!
˚˚ 
int
˚˚ 
.
˚˚ 
TryParse
˚˚ %
(
˚˚% &
input
˚˚& +
.
˚˚+ ,
Value
˚˚, 1
,
˚˚1 2
out
˚˚3 6
var
˚˚7 :
intVal
˚˚; A
)
˚˚A B
)
˚˚B C
throw
¸¸ 
new
¸¸ !
AppException
¸¸" .
(
¸¸. /
$str
¸¸/ I
,
¸¸I J
$num
¸¸K N
,
¸¸N O
$"
¸¸P R
$str
¸¸R \
{
¸¸\ ]
prop
¸¸] a
.
¸¸a b
Name
¸¸b f
}
¸¸f g
$str¸¸g Ç
"¸¸Ç É
)¸¸É Ñ
;¸¸Ñ Ö
pv
˝˝ 
.
˝˝ 
ValueInt
˝˝ 
=
˝˝  !
intVal
˝˝" (
;
˝˝( )
break
˛˛ 
;
˛˛ 
case
ÄÄ 
PropertyDataType
ÄÄ %
.
ÄÄ% &
Decimal
ÄÄ& -
:
ÄÄ- .
if
ÅÅ 
(
ÅÅ 
!
ÅÅ 
decimal
ÅÅ  
.
ÅÅ  !
TryParse
ÅÅ! )
(
ÅÅ) *
input
ÅÅ* /
.
ÅÅ/ 0
Value
ÅÅ0 5
,
ÅÅ5 6
System
ÇÇ "
.
ÇÇ" #
Globalization
ÇÇ# 0
.
ÇÇ0 1
NumberStyles
ÇÇ1 =
.
ÇÇ= >
Number
ÇÇ> D
,
ÇÇD E
System
ÉÉ "
.
ÉÉ" #
Globalization
ÉÉ# 0
.
ÉÉ0 1
CultureInfo
ÉÉ1 <
.
ÉÉ< =
InvariantCulture
ÉÉ= M
,
ÉÉM N
out
ÑÑ 
var
ÑÑ  #
decVal
ÑÑ$ *
)
ÑÑ* +
)
ÑÑ+ ,
throw
ÖÖ 
new
ÖÖ !
AppException
ÖÖ" .
(
ÖÖ. /
$str
ÖÖ/ I
,
ÖÖI J
$num
ÖÖK N
,
ÖÖN O
$"
ÖÖP R
$str
ÖÖR \
{
ÖÖ\ ]
prop
ÖÖ] a
.
ÖÖa b
Name
ÖÖb f
}
ÖÖf g
$strÖÖg Å
"ÖÖÅ Ç
)ÖÖÇ É
;ÖÖÉ Ñ
pv
ÜÜ 
.
ÜÜ 
ValueDecimal
ÜÜ #
=
ÜÜ$ %
decVal
ÜÜ& ,
;
ÜÜ, -
break
áá 
;
áá 
case
ââ 
PropertyDataType
ââ %
.
ââ% &
Bool
ââ& *
:
ââ* +
if
ää 
(
ää 
!
ää 
bool
ää 
.
ää 
TryParse
ää &
(
ää& '
input
ää' ,
.
ää, -
Value
ää- 2
,
ää2 3
out
ää4 7
var
ää8 ;
boolVal
ää< C
)
ääC D
)
ääD E
throw
ãã 
new
ãã !
AppException
ãã" .
(
ãã. /
$str
ãã/ I
,
ããI J
$num
ããK N
,
ããN O
$"
ããP R
$str
ããR \
{
ãã\ ]
prop
ãã] a
.
ããa b
Name
ããb f
}
ããf g
$strããg é
"ããé è
)ããè ê
;ããê ë
pv
åå 
.
åå 
	ValueBool
åå  
=
åå! "
boolVal
åå# *
;
åå* +
break
çç 
;
çç 
case
èè 
PropertyDataType
èè %
.
èè% &
Date
èè& *
:
èè* +
if
êê 
(
êê 
!
êê 
DateOnly
êê !
.
êê! "
TryParseExact
êê" /
(
êê/ 0
input
êê0 5
.
êê5 6
Value
êê6 ;
,
êê; <
$str
êê= I
,
êêI J
System
ëë "
.
ëë" #
Globalization
ëë# 0
.
ëë0 1
CultureInfo
ëë1 <
.
ëë< =
InvariantCulture
ëë= M
,
ëëM N
System
íí "
.
íí" #
Globalization
íí# 0
.
íí0 1
DateTimeStyles
íí1 ?
.
íí? @
None
íí@ D
,
ííD E
out
ìì 
var
ìì  #
dateVal
ìì$ +
)
ìì+ ,
)
ìì, -
throw
îî 
new
îî !
AppException
îî" .
(
îî. /
$str
îî/ F
,
îîF G
$num
îîH K
,
îîK L
$"
îîM O
$str
îîO Y
{
îîY Z
prop
îîZ ^
.
îî^ _
Name
îî_ c
}
îîc d
$strîîd ä
"îîä ã
)îîã å
;îîå ç
pv
ïï 
.
ïï 
	ValueDate
ïï  
=
ïï! "
dateVal
ïï# *
;
ïï* +
break
ññ 
;
ññ 
}
óó 
result
ôô 
.
ôô 
Add
ôô 
(
ôô 
pv
ôô 
)
ôô 
;
ôô 
}
öö 	
return
úú 
result
úú 
;
úú 
}
ùù 
private
üü 
static
üü 
EntityListItemDto
üü $
MapToListItem
üü% 2
(
üü2 3
Entity
üü3 9
e
üü: ;
)
üü; <
=>
üü= ?
new
üü@ C
(
üüC D
e
†† 	
.
††	 

Id
††
 
,
†† 
e
°° 	
.
°°	 

EntityTypeId
°°
 
,
°° 
e
¢¢ 	
.
¢¢	 


EntityType
¢¢
 
.
¢¢ 
Name
¢¢ 
,
¢¢ 
e
££ 	
.
££	 


EntityType
££
 
.
££ 
DisplayName
££  
??
££! #
DisplayNameHelper
££$ 5
.
££5 6
Humanize
££6 >
(
££> ?
e
££? @
.
££@ A

EntityType
££A K
.
££K L
Name
££L P
)
££P Q
,
££Q R
MapPropertyValues
§§ 
(
§§ 
e
§§ 
)
§§ 
)
§§ 
;
§§ 
private
¶¶ 
static
¶¶ 
EntityDetailDto
¶¶ "
MapToDetail
¶¶# .
(
¶¶. /
Entity
¶¶/ 5
e
¶¶6 7
)
¶¶7 8
{
ßß 
const
®® 
int
®® 

previewCap
®® 
=
®® 
$num
®® !
;
®®! "
return
©© 
new
©© 
EntityDetailDto
©© "
(
©©" #
e
™™ 
.
™™ 
Id
™™ 
,
™™ 
e
´´ 
.
´´ 
EntityTypeId
´´ 
,
´´ 
e
¨¨ 
.
¨¨ 

EntityType
¨¨ 
.
¨¨ 
Name
¨¨ 
,
¨¨ 
e
≠≠ 
.
≠≠ 

EntityType
≠≠ 
.
≠≠ 
DisplayName
≠≠ $
??
≠≠% '
DisplayNameHelper
≠≠( 9
.
≠≠9 :
Humanize
≠≠: B
(
≠≠B C
e
≠≠C D
.
≠≠D E

EntityType
≠≠E O
.
≠≠O P
Name
≠≠P T
)
≠≠T U
,
≠≠U V
e
ÆÆ 
.
ÆÆ 

IsArchived
ÆÆ 
,
ÆÆ 
MapPropertyValues
ØØ 
(
ØØ 
e
ØØ 
)
ØØ  
,
ØØ  !
MapOutbound
∞∞ 
(
∞∞ 
e
∞∞ 
,
∞∞ 

previewCap
∞∞ %
)
∞∞% &
,
∞∞& '

MapInbound
±± 
(
±± 
e
±± 
,
±± 

previewCap
±± $
)
±±$ %
)
±±% &
;
±±& '
}
≤≤ 
private
¥¥ 
static
¥¥ 
List
¥¥ 
<
¥¥ &
EntityRelationshipRefDto
¥¥ 0
>
¥¥0 1
MapOutbound
¥¥2 =
(
¥¥= >
Entity
¥¥> D
e
¥¥E F
,
¥¥F G
int
¥¥H K

previewCap
¥¥L V
)
¥¥V W
=>
¥¥X Z
e
µµ 	
.
µµ	 
!
SourceRelationships
µµ
 
.
∂∂ 
OrderBy
∂∂ 
(
∂∂ 
r
∂∂ 
=>
∂∂ 
r
∂∂ 
.
∂∂ 
Id
∂∂ 
)
∂∂ 
.
∑∑ 
Select
∑∑ 
(
∑∑ 
r
∑∑ 
=>
∑∑ 
new
∑∑ &
EntityRelationshipRefDto
∑∑ 5
(
∑∑5 6
r
∏∏ 
.
∏∏ 
Id
∏∏ 
,
∏∏ 
r
ππ 
.
ππ  
RelationshipTypeId
ππ $
,
ππ$ %
r
∫∫ 
.
∫∫ 
RelationshipType
∫∫ "
.
∫∫" #
Name
∫∫# '
,
∫∫' (
r
ªª 
.
ªª 
RelationshipType
ªª "
.
ªª" #
DisplayName
ªª# .
??
ªª/ 1
DisplayNameHelper
ªª2 C
.
ªªC D
Humanize
ªªD L
(
ªªL M
r
ªªM N
.
ªªN O
RelationshipType
ªªO _
.
ªª_ `
Name
ªª` d
)
ªªd e
,
ªªe f
r
ºº 
.
ºº 
TargetEntityId
ºº  
,
ºº  !
r
ΩΩ 
.
ΩΩ 
TargetEntity
ΩΩ 
.
ΩΩ 

EntityType
ΩΩ )
.
ΩΩ) *
Name
ΩΩ* .
,
ΩΩ. /
r
ææ 
.
ææ 
TargetEntity
ææ 
.
ææ 

EntityType
ææ )
.
ææ) *
DisplayName
ææ* 5
??
ææ6 8
DisplayNameHelper
ææ9 J
.
ææJ K
Humanize
ææK S
(
ææS T
r
ææT U
.
ææU V
TargetEntity
ææV b
.
ææb c

EntityType
ææc m
.
ææm n
Name
ææn r
)
æær s
,
ææs t

MapPreview
øø 
(
øø 
r
øø 
.
øø 
TargetEntity
øø )
,
øø) *

previewCap
øø+ 5
)
øø5 6
)
øø6 7
)
øø7 8
.
¿¿ 
ToList
¿¿ 
(
¿¿ 
)
¿¿ 
;
¿¿ 
private
¬¬ 
static
¬¬ 
List
¬¬ 
<
¬¬ &
EntityRelationshipRefDto
¬¬ 0
>
¬¬0 1

MapInbound
¬¬2 <
(
¬¬< =
Entity
¬¬= C
e
¬¬D E
,
¬¬E F
int
¬¬G J

previewCap
¬¬K U
)
¬¬U V
=>
¬¬W Y
e
√√ 	
.
√√	 
!
TargetRelationships
√√
 
.
ƒƒ 
OrderBy
ƒƒ 
(
ƒƒ 
r
ƒƒ 
=>
ƒƒ 
r
ƒƒ 
.
ƒƒ 
Id
ƒƒ 
)
ƒƒ 
.
≈≈ 
Select
≈≈ 
(
≈≈ 
r
≈≈ 
=>
≈≈ 
new
≈≈ &
EntityRelationshipRefDto
≈≈ 5
(
≈≈5 6
r
∆∆ 
.
∆∆ 
Id
∆∆ 
,
∆∆ 
r
«« 
.
««  
RelationshipTypeId
«« $
,
««$ %
r
»» 
.
»» 
RelationshipType
»» "
.
»»" #
Name
»»# '
,
»»' (
r
…… 
.
…… 
RelationshipType
…… "
.
……" #
DisplayName
……# .
??
……/ 1
DisplayNameHelper
……2 C
.
……C D
Humanize
……D L
(
……L M
r
……M N
.
……N O
RelationshipType
……O _
.
……_ `
Name
……` d
)
……d e
,
……e f
r
   
.
   
SourceEntityId
    
,
    !
r
ÀÀ 
.
ÀÀ 
SourceEntity
ÀÀ 
.
ÀÀ 

EntityType
ÀÀ )
.
ÀÀ) *
Name
ÀÀ* .
,
ÀÀ. /
r
ÃÃ 
.
ÃÃ 
SourceEntity
ÃÃ 
.
ÃÃ 

EntityType
ÃÃ )
.
ÃÃ) *
DisplayName
ÃÃ* 5
??
ÃÃ6 8
DisplayNameHelper
ÃÃ9 J
.
ÃÃJ K
Humanize
ÃÃK S
(
ÃÃS T
r
ÃÃT U
.
ÃÃU V
SourceEntity
ÃÃV b
.
ÃÃb c

EntityType
ÃÃc m
.
ÃÃm n
Name
ÃÃn r
)
ÃÃr s
,
ÃÃs t

MapPreview
ÕÕ 
(
ÕÕ 
r
ÕÕ 
.
ÕÕ 
SourceEntity
ÕÕ )
,
ÕÕ) *

previewCap
ÕÕ+ 5
)
ÕÕ5 6
)
ÕÕ6 7
)
ÕÕ7 8
.
ŒŒ 
ToList
ŒŒ 
(
ŒŒ 
)
ŒŒ 
;
ŒŒ 
private
–– 
static
–– 
List
–– 
<
–– $
EntityPropertyValueDto
–– .
>
––. /

MapPreview
––0 :
(
––: ;
Entity
––; A
related
––B I
,
––I J
int
––K N
cap
––O R
)
––R S
=>
––T V
related
—— 
.
—— "
EntityPropertyValues
—— $
.
““ 
OrderBy
““ 
(
““ 
pv
““ 
=>
““ 
pv
““ 
.
““ 

PropertyId
““ (
)
““( )
.
”” 
Take
”” 
(
”” 
cap
”” 
)
”” 
.
‘‘ 
Select
‘‘ 
(
‘‘ 
pv
‘‘ 
=>
‘‘ 
new
‘‘ $
EntityPropertyValueDto
‘‘ 4
(
‘‘4 5
pv
’’ 
.
’’ 

PropertyId
’’ 
,
’’ 
pv
÷÷ 
.
÷÷ 
Property
÷÷ 
.
÷÷ 
Name
÷÷  
,
÷÷  !
pv
◊◊ 
.
◊◊ 
Property
◊◊ 
.
◊◊ 
DisplayName
◊◊ '
??
◊◊( *
DisplayNameHelper
◊◊+ <
.
◊◊< =
Humanize
◊◊= E
(
◊◊E F
pv
◊◊F H
.
◊◊H I
Property
◊◊I Q
.
◊◊Q R
Name
◊◊R V
)
◊◊V W
,
◊◊W X
pv
ÿÿ 
.
ÿÿ 
Property
ÿÿ 
.
ÿÿ 
DataType
ÿÿ $
.
ÿÿ$ %
ToString
ÿÿ% -
(
ÿÿ- .
)
ÿÿ. /
,
ÿÿ/ 0
ResolveValue
ŸŸ 
(
ŸŸ 
pv
ŸŸ 
)
ŸŸ  
,
ŸŸ  !
pv
⁄⁄ 
.
⁄⁄ 
Property
⁄⁄ 
.
⁄⁄ 

IsReadonly
⁄⁄ &
)
⁄⁄& '
)
⁄⁄' (
.
€€ 
ToList
€€ 
(
€€ 
)
€€ 
;
€€ 
private
›› 
static
›› 
List
›› 
<
›› $
EntityPropertyValueDto
›› .
>
››. /
MapPropertyValues
››0 A
(
››A B
Entity
››B H
e
››I J
)
››J K
=>
››L N
e
ﬁﬁ 	
.
ﬁﬁ	 
"
EntityPropertyValues
ﬁﬁ
 
.
ﬂﬂ 
OrderBy
ﬂﬂ 
(
ﬂﬂ 
pv
ﬂﬂ 
=>
ﬂﬂ 
pv
ﬂﬂ 
.
ﬂﬂ 

PropertyId
ﬂﬂ (
)
ﬂﬂ( )
.
‡‡ 
Select
‡‡ 
(
‡‡ 
pv
‡‡ 
=>
‡‡ 
new
‡‡ $
EntityPropertyValueDto
‡‡ 4
(
‡‡4 5
pv
·· 
.
·· 

PropertyId
·· 
,
·· 
pv
‚‚ 
.
‚‚ 
Property
‚‚ 
.
‚‚ 
Name
‚‚  
,
‚‚  !
pv
„„ 
.
„„ 
Property
„„ 
.
„„ 
DisplayName
„„ '
??
„„( *
DisplayNameHelper
„„+ <
.
„„< =
Humanize
„„= E
(
„„E F
pv
„„F H
.
„„H I
Property
„„I Q
.
„„Q R
Name
„„R V
)
„„V W
,
„„W X
pv
‰‰ 
.
‰‰ 
Property
‰‰ 
.
‰‰ 
DataType
‰‰ $
.
‰‰$ %
ToString
‰‰% -
(
‰‰- .
)
‰‰. /
,
‰‰/ 0
ResolveValue
ÂÂ 
(
ÂÂ 
pv
ÂÂ 
)
ÂÂ  
,
ÂÂ  !
pv
ÊÊ 
.
ÊÊ 
Property
ÊÊ 
.
ÊÊ 

IsReadonly
ÊÊ &
)
ÊÊ& '
)
ÊÊ' (
.
ÁÁ 
ToList
ÁÁ 
(
ÁÁ 
)
ÁÁ 
;
ÁÁ 
private
ÈÈ 
static
ÈÈ 
object
ÈÈ 
?
ÈÈ 
ResolveValue
ÈÈ '
(
ÈÈ' (!
EntityPropertyValue
ÈÈ( ;
pv
ÈÈ< >
)
ÈÈ> ?
=>
ÈÈ@ B
pv
ÈÈC E
.
ÈÈE F
Property
ÈÈF N
.
ÈÈN O
DataType
ÈÈO W
switch
ÈÈX ^
{
ÍÍ 
PropertyDataType
ÎÎ 
.
ÎÎ 
String
ÎÎ 
=>
ÎÎ! #
pv
ÎÎ$ &
.
ÎÎ& '
ValueString
ÎÎ' 2
,
ÎÎ2 3
PropertyDataType
ÏÏ 
.
ÏÏ 
Int
ÏÏ 
=>
ÏÏ! #
(
ÏÏ$ %
object
ÏÏ% +
?
ÏÏ+ ,
)
ÏÏ, -
pv
ÏÏ- /
.
ÏÏ/ 0
ValueInt
ÏÏ0 8
,
ÏÏ8 9
PropertyDataType
ÌÌ 
.
ÌÌ 
Decimal
ÌÌ  
=>
ÌÌ! #
pv
ÌÌ$ &
.
ÌÌ& '
ValueDecimal
ÌÌ' 3
,
ÌÌ3 4
PropertyDataType
ÓÓ 
.
ÓÓ 
Bool
ÓÓ 
=>
ÓÓ! #
pv
ÓÓ$ &
.
ÓÓ& '
	ValueBool
ÓÓ' 0
,
ÓÓ0 1
PropertyDataType
ÔÔ 
.
ÔÔ 
Date
ÔÔ 
=>
ÔÔ! #
pv
ÔÔ$ &
.
ÔÔ& '
	ValueDate
ÔÔ' 0
?
ÔÔ0 1
.
ÔÔ1 2
ToString
ÔÔ2 :
(
ÔÔ: ;
$str
ÔÔ; G
)
ÔÔG H
,
ÔÔH I
_
 	
=>
! #
null
$ (
}
ÒÒ 
;
ÒÒ 
public
ÛÛ 

async
ÛÛ 
Task
ÛÛ 
<
ÛÛ &
EntityRelationshipRefDto
ÛÛ .
>
ÛÛ. /%
CreateRelationshipAsync
ÛÛ0 G
(
ÛÛG H
int
ÛÛH K
workspaceId
ÛÛL W
,
ÛÛW X
int
ÛÛY \
userId
ÛÛ] c
,
ÛÛc d.
CreateEntityRelationshipRequestÛÛe Ñ
requestÛÛÖ å
,ÛÛå ç!
CancellationTokenÛÛé ü
ctÛÛ† ¢
=ÛÛ£ §
defaultÛÛ• ¨
)ÛÛ¨ ≠
{
ÙÙ 
await
ıı 
RequirePermission
ıı 
(
ıı  
userId
ıı  &
,
ıı& '
workspaceId
ıı( 3
,
ıı3 4
$str
ıı5 D
,
ııD E
ct
ııF H
)
ııH I
;
ııI J
var
˜˜ 
relType
˜˜ 
=
˜˜ 
await
˜˜ 
entityRepository
˜˜ ,
.
˜˜, -*
GetRelationshipTypeByIdAsync
˜˜- I
(
˜˜I J
request
˜˜J Q
.
˜˜Q R 
RelationshipTypeId
˜˜R d
,
˜˜d e
ct
˜˜f h
)
˜˜h i
??
¯¯ 
throw
¯¯ 
new
¯¯ 
AppException
¯¯ %
(
¯¯% &
$str
¯¯& C
,
¯¯C D
$num
¯¯E H
,
¯¯H I
$"
¯¯J L
$str
¯¯L ^
{
¯¯^ _
request
¯¯_ f
.
¯¯f g 
RelationshipTypeId
¯¯g y
}
¯¯y z
$str¯¯z ä
"¯¯ä ã
)¯¯ã å
;¯¯å ç
var
˙˙ 
source
˙˙ 
=
˙˙ 
await
˙˙ 
entityRepository
˙˙ +
.
˙˙+ ,%
GetByIdInWorkspaceAsync
˙˙, C
(
˙˙C D
request
˙˙D K
.
˙˙K L
SourceEntityId
˙˙L Z
,
˙˙Z [
workspaceId
˙˙\ g
,
˙˙g h
ct
˙˙i k
)
˙˙k l
??
˚˚ 
throw
˚˚ 
new
˚˚ 
AppException
˚˚ %
(
˚˚% &
$str
˚˚& ?
,
˚˚? @
$num
˚˚A D
,
˚˚D E
$"
˚˚F H
$str
˚˚H V
{
˚˚V W
request
˚˚W ^
.
˚˚^ _
SourceEntityId
˚˚_ m
}
˚˚m n
$str˚˚n Ü
{˚˚Ü á
workspaceId˚˚á í
}˚˚í ì
$str˚˚ì î
"˚˚î ï
)˚˚ï ñ
;˚˚ñ ó
var
˝˝ 
target
˝˝ 
=
˝˝ 
await
˝˝ 
entityRepository
˝˝ +
.
˝˝+ ,%
GetByIdInWorkspaceAsync
˝˝, C
(
˝˝C D
request
˝˝D K
.
˝˝K L
TargetEntityId
˝˝L Z
,
˝˝Z [
workspaceId
˝˝\ g
,
˝˝g h
ct
˝˝i k
)
˝˝k l
??
˛˛ 
throw
˛˛ 
new
˛˛ 
AppException
˛˛ %
(
˛˛% &
$str
˛˛& ?
,
˛˛? @
$num
˛˛A D
,
˛˛D E
$"
˛˛F H
$str
˛˛H V
{
˛˛V W
request
˛˛W ^
.
˛˛^ _
TargetEntityId
˛˛_ m
}
˛˛m n
$str˛˛n Ü
{˛˛Ü á
workspaceId˛˛á í
}˛˛í ì
$str˛˛ì î
"˛˛î ï
)˛˛ï ñ
;˛˛ñ ó
if
ÄÄ 

(
ÄÄ 
source
ÄÄ 
.
ÄÄ 

IsArchived
ÄÄ 
||
ÄÄ  
target
ÄÄ! '
.
ÄÄ' (

IsArchived
ÄÄ( 2
)
ÄÄ2 3
throw
ÅÅ 
new
ÅÅ 
AppException
ÅÅ "
(
ÅÅ" #
$str
ÅÅ# A
,
ÅÅA B
$num
ÅÅC F
,
ÅÅF G
$strÅÅH Ñ
)ÅÅÑ Ö
;ÅÅÖ Ü
var
ÉÉ 
targetTypeProps
ÉÉ 
=
ÉÉ 
await
ÉÉ #
entityRepository
ÉÉ$ 4
.
ÉÉ4 5$
GetTypePropertiesAsync
ÉÉ5 K
(
ÉÉK L
target
ÉÉL R
.
ÉÉR S
EntityTypeId
ÉÉS _
,
ÉÉ_ `
ct
ÉÉa c
)
ÉÉc d
;
ÉÉd e
if
ÑÑ 

(
ÑÑ 
targetTypeProps
ÑÑ 
.
ÑÑ 
Count
ÑÑ !
>
ÑÑ" #
$num
ÑÑ$ %
&&
ÑÑ& (
targetTypeProps
ÑÑ) 8
.
ÑÑ8 9
All
ÑÑ9 <
(
ÑÑ< =
tp
ÑÑ= ?
=>
ÑÑ@ B
tp
ÑÑC E
.
ÑÑE F
Property
ÑÑF N
.
ÑÑN O

IsReadonly
ÑÑO Y
)
ÑÑY Z
)
ÑÑZ [
throw
ÖÖ 
new
ÖÖ 
AppException
ÖÖ "
(
ÖÖ" #
$str
ÖÖ# =
,
ÖÖ= >
$num
ÖÖ? B
,
ÖÖB C
$str
ÖÖD 
)ÖÖ Ä
;ÖÖÄ Å
if
áá 

(
áá 
source
áá 
.
áá 
EntityTypeId
áá 
!=
áá  "
relType
áá# *
.
áá* + 
SourceEntityTypeId
áá+ =
)
áá= >
throw
àà 
new
àà 
AppException
àà "
(
àà" #
$str
àà# =
,
àà= >
$num
àà? B
,
ààB C
$"
ààD F
$str
ààF {
{
àà{ |
relTypeàà| É
.ààÉ Ñ
NameààÑ à
}ààà â
$strààâ ã
"ààã å
)ààå ç
;ààç é
if
ää 

(
ää 
target
ää 
.
ää 
EntityTypeId
ää 
!=
ää  "
relType
ää# *
.
ää* + 
TargetEntityTypeId
ää+ =
)
ää= >
throw
ãã 
new
ãã 
AppException
ãã "
(
ãã" #
$str
ãã# =
,
ãã= >
$num
ãã? B
,
ããB C
$"
ããD F
$str
ããF {
{
ãã{ |
relTypeãã| É
.ããÉ Ñ
NameããÑ à
}ããà â
$strããâ ã
"ããã å
)ããå ç
;ããç é
if
çç 

(
çç 
relType
çç 
.
çç %
RelationshipCardinality
çç +
==
çç, .
Persistence
çç/ :
.
çç: ;
Entities
çç; C
.
ççC D%
RelationshipCardinality
ççD [
.
çç[ \
	ManyToOne
çç\ e
||
éé 
relType
éé 
.
éé %
RelationshipCardinality
éé .
==
éé/ 1
Persistence
éé2 =
.
éé= >
Entities
éé> F
.
ééF G%
RelationshipCardinality
ééG ^
.
éé^ _
OneToOne
éé_ g
)
éég h
{
èè 	
if
êê 
(
êê 
await
êê 
entityRepository
êê &
.
êê& '-
CountRelationshipsBySourceAsync
êê' F
(
êêF G
source
êêG M
.
êêM N
Id
êêN P
,
êêP Q
relType
êêR Y
.
êêY Z
Id
êêZ \
,
êê\ ]
ct
êê^ `
)
êê` a
>
êêb c
$num
êêd e
)
êêe f
throw
ëë 
new
ëë 
AppException
ëë &
(
ëë& '
$str
ëë' E
,
ëëE F
$num
ëëG J
,
ëëJ K
$"
ëëL N
$str
ëëN k
{
ëëk l
relType
ëël s
.
ëës t
Name
ëët x
}
ëëx y
$strëëy ô
"ëëô ö
)ëëö õ
;ëëõ ú
}
íí 	
if
îî 

(
îî 
relType
îî 
.
îî %
RelationshipCardinality
îî +
==
îî, .
Persistence
îî/ :
.
îî: ;
Entities
îî; C
.
îîC D%
RelationshipCardinality
îîD [
.
îî[ \
OneToOne
îî\ d
)
îîd e
{
ïï 	
if
ññ 
(
ññ 
await
ññ 
entityRepository
ññ &
.
ññ& '-
CountRelationshipsByTargetAsync
ññ' F
(
ññF G
target
ññG M
.
ññM N
Id
ññN P
,
ññP Q
relType
ññR Y
.
ññY Z
Id
ññZ \
,
ññ\ ]
ct
ññ^ `
)
ññ` a
>
ññb c
$num
ññd e
)
ññe f
throw
óó 
new
óó 
AppException
óó &
(
óó& '
$str
óó' E
,
óóE F
$num
óóG J
,
óóJ K
$"
óóL N
$str
óóN k
{
óók l
relType
óól s
.
óós t
Name
óót x
}
óóx y
$stróóy ô
"óóô ö
)óóö õ
;óóõ ú
}
òò 	
var
öö 
rel
öö 
=
öö 
await
öö 
entityRepository
öö (
.
öö( )"
AddRelationshipAsync
öö) =
(
öö= >
new
öö> A
Persistence
ööB M
.
ööM N
Entities
ööN V
.
ööV W 
EntityRelationship
ööW i
{
õõ 	
SourceEntityId
úú 
=
úú 
source
úú #
.
úú# $
Id
úú$ &
,
úú& '
TargetEntityId
ùù 
=
ùù 
target
ùù #
.
ùù# $
Id
ùù$ &
,
ùù& ' 
RelationshipTypeId
ûû 
=
ûû  
relType
ûû! (
.
ûû( )
Id
ûû) +
,
ûû+ ,
}
üü 	
,
üü	 

ct
üü 
)
üü 
;
üü 
if
°° 

(
°° "
relationshipNotifier
°°  
is
°°! #
not
°°$ '
null
°°( ,
)
°°, -
await
¢¢ "
relationshipNotifier
¢¢ &
.
¢¢& ' 
NotifyChangedAsync
¢¢' 9
(
¢¢9 :
workspaceId
¢¢: E
,
¢¢E F
ct
¢¢G I
,
¢¢I J
source
¢¢K Q
.
¢¢Q R
Id
¢¢R T
,
¢¢T U
target
¢¢V \
.
¢¢\ ]
Id
¢¢] _
)
¢¢_ `
;
¢¢` a
const
§§ 
int
§§ 

previewCap
§§ 
=
§§ 
$num
§§ !
;
§§! "
return
•• 
new
•• &
EntityRelationshipRefDto
•• +
(
••+ ,
rel
¶¶ 
.
¶¶ 
Id
¶¶ 
,
¶¶ 
relType
ßß 
.
ßß 
Id
ßß 
,
ßß 
relType
®® 
.
®® 
Name
®® 
,
®® 
relType
©© 
.
©© 
DisplayName
©© 
??
©©  "
DisplayNameHelper
©©# 4
.
©©4 5
Humanize
©©5 =
(
©©= >
relType
©©> E
.
©©E F
Name
©©F J
)
©©J K
,
©©K L
target
™™ 
.
™™ 
Id
™™ 
,
™™ 
relType
´´ 
.
´´ 
TargetEntityType
´´ $
.
´´$ %
Name
´´% )
,
´´) *
relType
¨¨ 
.
¨¨ 
TargetEntityType
¨¨ $
.
¨¨$ %
DisplayName
¨¨% 0
??
¨¨1 3
DisplayNameHelper
¨¨4 E
.
¨¨E F
Humanize
¨¨F N
(
¨¨N O
relType
¨¨O V
.
¨¨V W
TargetEntityType
¨¨W g
.
¨¨g h
Name
¨¨h l
)
¨¨l m
,
¨¨m n

MapPreview
≠≠ 
(
≠≠ 
target
≠≠ 
,
≠≠ 

previewCap
≠≠ )
)
≠≠) *
)
≠≠* +
;
≠≠+ ,
}
ÆÆ 
public
∞∞ 

async
∞∞ 
Task
∞∞ %
DeleteRelationshipAsync
∞∞ -
(
∞∞- .
int
∞∞. 1
workspaceId
∞∞2 =
,
∞∞= >
int
∞∞? B
userId
∞∞C I
,
∞∞I J
int
∞∞K N
relationshipId
∞∞O ]
,
∞∞] ^
CancellationToken
∞∞_ p
ct
∞∞q s
=
∞∞t u
default
∞∞v }
)
∞∞} ~
{
±± 
await
≤≤ 
RequirePermission
≤≤ 
(
≤≤  
userId
≤≤  &
,
≤≤& '
workspaceId
≤≤( 3
,
≤≤3 4
$str
≤≤5 D
,
≤≤D E
ct
≤≤F H
)
≤≤H I
;
≤≤I J
var
¥¥ 
rel
¥¥ 
=
¥¥ 
await
¥¥ 
entityRepository
¥¥ (
.
¥¥( )&
GetRelationshipByIdAsync
¥¥) A
(
¥¥A B
relationshipId
¥¥B P
,
¥¥P Q
ct
¥¥R T
)
¥¥T U
??
µµ 
throw
µµ 
new
µµ 
AppException
µµ %
(
µµ% &
$str
µµ& >
,
µµ> ?
$num
µµ@ C
,
µµC D
$"
µµE G
$str
µµG T
{
µµT U
relationshipId
µµU c
}
µµc d
$str
µµd o
"
µµo p
)
µµp q
;
µµq r
if
∑∑ 

(
∑∑ 
!
∑∑ 
rel
∑∑ 
.
∑∑ 
SourceEntity
∑∑ 
.
∑∑ 
EntityWorkspaces
∑∑ .
.
∑∑. /
Any
∑∑/ 2
(
∑∑2 3
ew
∑∑3 5
=>
∑∑6 8
ew
∑∑9 ;
.
∑∑; <
WorkspaceId
∑∑< G
==
∑∑H J
workspaceId
∑∑K V
)
∑∑V W
)
∑∑W X
throw
∏∏ 
new
∏∏ 
AppException
∏∏ "
(
∏∏" #
$str
∏∏# B
,
∏∏B C
$num
∏∏D G
,
∏∏G H
$str∏∏I á
)∏∏á à
;∏∏à â
if
∫∫ 

(
∫∫ 
rel
∫∫ 
.
∫∫ 
RelationshipType
∫∫  
.
∫∫  !

IsRequired
∫∫! +
)
∫∫+ ,
{
ªª 	
var
ºº 
	remaining
ºº 
=
ºº 
await
ºº !
entityRepository
ºº" 2
.
ºº2 3-
CountRelationshipsBySourceAsync
ºº3 R
(
ººR S
rel
ΩΩ 
.
ΩΩ 
SourceEntityId
ΩΩ "
,
ΩΩ" #
rel
ΩΩ$ '
.
ΩΩ' ( 
RelationshipTypeId
ΩΩ( :
,
ΩΩ: ;
ct
ΩΩ< >
)
ΩΩ> ?
;
ΩΩ? @
if
ææ 
(
ææ 
	remaining
ææ 
<=
ææ 
$num
ææ 
)
ææ 
throw
øø 
new
øø 
AppException
øø &
(
øø& '
$str
øø' L
,
øøL M
$num
øøN Q
,
øøQ R
$"
¿¿ 
$str
¿¿ G
{
¿¿G H
rel
¿¿H K
.
¿¿K L
RelationshipType
¿¿L \
.
¿¿\ ]
Name
¿¿] a
}
¿¿a b
$str
¿¿b i
"
¿¿i j
)
¿¿j k
;
¿¿k l
}
¡¡ 	
var
√√ 
targetTypeProps
√√ 
=
√√ 
await
√√ #
entityRepository
√√$ 4
.
√√4 5$
GetTypePropertiesAsync
√√5 K
(
√√K L
rel
√√L O
.
√√O P
TargetEntity
√√P \
.
√√\ ]
EntityTypeId
√√] i
,
√√i j
ct
√√k m
)
√√m n
;
√√n o
if
ƒƒ 

(
ƒƒ 
targetTypeProps
ƒƒ 
.
ƒƒ 
Count
ƒƒ !
>
ƒƒ" #
$num
ƒƒ$ %
&&
ƒƒ& (
targetTypeProps
ƒƒ) 8
.
ƒƒ8 9
All
ƒƒ9 <
(
ƒƒ< =
tp
ƒƒ= ?
=>
ƒƒ@ B
tp
ƒƒC E
.
ƒƒE F
Property
ƒƒF N
.
ƒƒN O

IsReadonly
ƒƒO Y
)
ƒƒY Z
)
ƒƒZ [
throw
≈≈ 
new
≈≈ 
AppException
≈≈ "
(
≈≈" #
$str
≈≈# ?
,
≈≈? @
$num
≈≈A D
,
≈≈D E
$str≈≈F É
)≈≈É Ñ
;≈≈Ñ Ö
var
«« 
sourceId
«« 
=
«« 
rel
«« 
.
«« 
SourceEntityId
«« )
;
««) *
var
»» 
targetId
»» 
=
»» 
rel
»» 
.
»» 
TargetEntityId
»» )
;
»») *
await
…… 
entityRepository
…… 
.
…… %
RemoveRelationshipAsync
…… 6
(
……6 7
relationshipId
……7 E
,
……E F
ct
……G I
)
……I J
;
……J K
if
ÀÀ 

(
ÀÀ "
relationshipNotifier
ÀÀ  
is
ÀÀ! #
not
ÀÀ$ '
null
ÀÀ( ,
)
ÀÀ, -
await
ÃÃ "
relationshipNotifier
ÃÃ &
.
ÃÃ& ' 
NotifyChangedAsync
ÃÃ' 9
(
ÃÃ9 :
workspaceId
ÃÃ: E
,
ÃÃE F
ct
ÃÃG I
,
ÃÃI J
sourceId
ÃÃK S
,
ÃÃS T
targetId
ÃÃU ]
)
ÃÃ] ^
;
ÃÃ^ _
}
ÕÕ 
public
œœ 

async
œœ 
Task
œœ 
<
œœ &
EntityRelationshipRefDto
œœ .
>
œœ. /'
ReassignRelationshipAsync
œœ0 I
(
œœI J
int
–– 
workspaceId
–– 
,
–– 
int
–– 
userId
–– #
,
––# $
int
––% (
relationshipId
––) 7
,
––7 8/
!ReassignEntityRelationshipRequest
—— )
request
——* 1
,
——1 2
CancellationToken
——3 D
ct
——E G
=
——H I
default
——J Q
)
——Q R
{
““ 
await
”” 
RequirePermission
”” 
(
””  
userId
””  &
,
””& '
workspaceId
””( 3
,
””3 4
$str
””5 D
,
””D E
ct
””F H
)
””H I
;
””I J
if
’’ 

(
’’ 
(
’’ 
request
’’ 
.
’’ 
NewSourceEntityId
’’ &
==
’’' )
null
’’* .
)
’’. /
==
’’0 2
(
’’3 4
request
’’4 ;
.
’’; <
NewTargetEntityId
’’< M
==
’’N P
null
’’Q U
)
’’U V
)
’’V W
throw
÷÷ 
new
÷÷ 
AppException
÷÷ "
(
÷÷" #
$str
÷÷# @
,
÷÷@ A
$num
÷÷B E
,
÷÷E F
$str÷÷G ê
)÷÷ê ë
;÷÷ë í
var
ÿÿ 
rel
ÿÿ 
=
ÿÿ 
await
ÿÿ 
entityRepository
ÿÿ (
.
ÿÿ( )&
GetRelationshipByIdAsync
ÿÿ) A
(
ÿÿA B
relationshipId
ÿÿB P
,
ÿÿP Q
ct
ÿÿR T
)
ÿÿT U
??
ŸŸ 
throw
ŸŸ 
new
ŸŸ 
AppException
ŸŸ %
(
ŸŸ% &
$str
ŸŸ& >
,
ŸŸ> ?
$num
ŸŸ@ C
,
ŸŸC D
$"
ŸŸE G
$str
ŸŸG T
{
ŸŸT U
relationshipId
ŸŸU c
}
ŸŸc d
$str
ŸŸd o
"
ŸŸo p
)
ŸŸp q
;
ŸŸq r
var
€€ 
relType
€€ 
=
€€ 
rel
€€ 
.
€€ 
RelationshipType
€€ *
;
€€* +&
EntityRelationshipRefDto
‹‹  
result
‹‹! '
;
‹‹' (
if
ﬁﬁ 

(
ﬁﬁ 
request
ﬁﬁ 
.
ﬁﬁ 
NewTargetEntityId
ﬁﬁ %
.
ﬁﬁ% &
HasValue
ﬁﬁ& .
)
ﬁﬁ. /
{
ﬂﬂ 	
if
‡‡ 
(
‡‡ 
!
‡‡ 
rel
‡‡ 
.
‡‡ 
SourceEntity
‡‡ !
.
‡‡! "
EntityWorkspaces
‡‡" 2
.
‡‡2 3
Any
‡‡3 6
(
‡‡6 7
ew
‡‡7 9
=>
‡‡: <
ew
‡‡= ?
.
‡‡? @
WorkspaceId
‡‡@ K
==
‡‡L N
workspaceId
‡‡O Z
)
‡‡Z [
)
‡‡[ \
throw
·· 
new
·· 
AppException
·· &
(
··& '
$str
··' F
,
··F G
$num
··H K
,
··K L
$str··M ã
)··ã å
;··å ç
var
„„ 
	newTarget
„„ 
=
„„ 
await
„„ !
entityRepository
„„" 2
.
„„2 3%
GetByIdInWorkspaceAsync
„„3 J
(
„„J K
request
„„K R
.
„„R S
NewTargetEntityId
„„S d
.
„„d e
Value
„„e j
,
„„j k
workspaceId
„„l w
,
„„w x
ct
„„y {
)
„„{ |
??
‰‰ 
throw
‰‰ 
new
‰‰ 
AppException
‰‰ )
(
‰‰) *
$str
‰‰* C
,
‰‰C D
$num
‰‰E H
,
‰‰H I
$"
‰‰J L
$str
‰‰L Z
{
‰‰Z [
request
‰‰[ b
.
‰‰b c
NewTargetEntityId
‰‰c t
.
‰‰t u
Value
‰‰u z
}
‰‰z {
$str‰‰{ ì
"‰‰ì î
)‰‰î ï
;‰‰ï ñ
if
ÂÂ 
(
ÂÂ 
	newTarget
ÂÂ 
.
ÂÂ 

IsArchived
ÂÂ $
)
ÂÂ$ %
throw
ÊÊ 
new
ÊÊ 
AppException
ÊÊ &
(
ÊÊ& '
$str
ÊÊ' D
,
ÊÊD E
$num
ÊÊF I
,
ÊÊI J
$str
ÊÊK l
)
ÊÊl m
;
ÊÊm n
if
ÁÁ 
(
ÁÁ 
	newTarget
ÁÁ 
.
ÁÁ 
EntityTypeId
ÁÁ &
!=
ÁÁ' )
relType
ÁÁ* 1
.
ÁÁ1 2 
TargetEntityTypeId
ÁÁ2 D
)
ÁÁD E
throw
ËË 
new
ËË 
AppException
ËË &
(
ËË& '
$str
ËË' K
,
ËËK L
$num
ËËM P
,
ËËP Q
$"
ËËR T
$strËËT Ç
{ËËÇ É
relTypeËËÉ ä
.ËËä ã
NameËËã è
}ËËè ê
$strËËê í
"ËËí ì
)ËËì î
;ËËî ï
var
ÈÈ 
targetTypeProps
ÈÈ 
=
ÈÈ  !
await
ÈÈ" '
entityRepository
ÈÈ( 8
.
ÈÈ8 9$
GetTypePropertiesAsync
ÈÈ9 O
(
ÈÈO P
	newTarget
ÈÈP Y
.
ÈÈY Z
EntityTypeId
ÈÈZ f
,
ÈÈf g
ct
ÈÈh j
)
ÈÈj k
;
ÈÈk l
if
ÍÍ 
(
ÍÍ 
targetTypeProps
ÍÍ 
.
ÍÍ  
Count
ÍÍ  %
>
ÍÍ& '
$num
ÍÍ( )
&&
ÍÍ* ,
targetTypeProps
ÍÍ- <
.
ÍÍ< =
All
ÍÍ= @
(
ÍÍ@ A
tp
ÍÍA C
=>
ÍÍD F
tp
ÍÍG I
.
ÍÍI J
Property
ÍÍJ R
.
ÍÍR S

IsReadonly
ÍÍS ]
)
ÍÍ] ^
)
ÍÍ^ _
throw
ÎÎ 
new
ÎÎ 
AppException
ÎÎ &
(
ÎÎ& '
$str
ÎÎ' A
,
ÎÎA B
$num
ÎÎC F
,
ÎÎF G
$strÎÎH É
)ÎÎÉ Ñ
;ÎÎÑ Ö
if
ÏÏ 
(
ÏÏ 
relType
ÏÏ 
.
ÏÏ %
RelationshipCardinality
ÏÏ /
==
ÏÏ0 2
Persistence
ÏÏ3 >
.
ÏÏ> ?
Entities
ÏÏ? G
.
ÏÏG H%
RelationshipCardinality
ÏÏH _
.
ÏÏ_ `
OneToOne
ÏÏ` h
)
ÏÏh i
{
ÌÌ 
if
ÓÓ 
(
ÓÓ 
await
ÓÓ 
entityRepository
ÓÓ *
.
ÓÓ* +-
CountRelationshipsByTargetAsync
ÓÓ+ J
(
ÓÓJ K
	newTarget
ÓÓK T
.
ÓÓT U
Id
ÓÓU W
,
ÓÓW X
relType
ÓÓY `
.
ÓÓ` a
Id
ÓÓa c
,
ÓÓc d
ct
ÓÓe g
)
ÓÓg h
>
ÓÓi j
$num
ÓÓk l
)
ÓÓl m
throw
ÔÔ 
new
ÔÔ 
AppException
ÔÔ *
(
ÔÔ* +
$str
ÔÔ+ I
,
ÔÔI J
$num
ÔÔK N
,
ÔÔN O
$"
ÔÔP R
$str
ÔÔR o
{
ÔÔo p
relType
ÔÔp w
.
ÔÔw x
Name
ÔÔx |
}
ÔÔ| }
$strÔÔ} ù
"ÔÔù û
)ÔÔû ü
;ÔÔü †
}
 
result
ÚÚ 
=
ÚÚ 
await
ÚÚ 
entityRepository
ÚÚ +
.
ÚÚ+ ,'
ExecuteInTransactionAsync
ÚÚ, E
(
ÚÚE F
async
ÚÚF K
(
ÚÚL M
)
ÚÚM N
=>
ÚÚO Q
{
ÛÛ 
await
ÙÙ 
entityRepository
ÙÙ &
.
ÙÙ& '+
UpdateRelationshipTargetAsync
ÙÙ' D
(
ÙÙD E
relationshipId
ÙÙE S
,
ÙÙS T
	newTarget
ÙÙU ^
.
ÙÙ^ _
Id
ÙÙ_ a
,
ÙÙa b
ct
ÙÙc e
)
ÙÙe f
;
ÙÙf g
if
ˆˆ 
(
ˆˆ 
auditOutboxWriter
ˆˆ %
is
ˆˆ& (
not
ˆˆ) ,
null
ˆˆ- 1
)
ˆˆ1 2
{
˜˜ 
await
¯¯ 
auditOutboxWriter
¯¯ +
.
¯¯+ ,
EnqueueAuditAsync
¯¯, =
(
¯¯= >
new
¯¯> A 
AuditEventContract
¯¯B T
(
¯¯T U
EventId
˘˘ 
:
˘˘  
Guid
˘˘! %
.
˘˘% &
NewGuid
˘˘& -
(
˘˘- .
)
˘˘. /
,
˘˘/ 0
SchemaVersion
˙˙ %
:
˙˙% &
$num
˙˙' (
,
˙˙( )
OccurredAtUtc
˚˚ %
:
˚˚% &
DateTimeOffset
˚˚' 5
.
˚˚5 6
UtcNow
˚˚6 <
,
˚˚< =
SourceService
¸¸ %
:
¸¸% &
$str
¸¸' -
,
¸¸- .
ActorUserId
˝˝ #
:
˝˝# $
userId
˝˝% +
,
˝˝+ ,

AuditScope
˛˛ "
:
˛˛" #
AuditRouting
˛˛$ 0
.
˛˛0 1
ScopeEntity
˛˛1 <
,
˛˛< =
TargetId
ˇˇ  
:
ˇˇ  !
rel
ˇˇ" %
.
ˇˇ% &
SourceEntityId
ˇˇ& 4
,
ˇˇ4 5
Action
ÄÄ 
:
ÄÄ 
$str
ÄÄ  9
,
ÄÄ9 :
	FieldName
ÅÅ !
:
ÅÅ! "
relType
ÅÅ# *
.
ÅÅ* +
Name
ÅÅ+ /
,
ÅÅ/ 0

EntityType
ÇÇ "
:
ÇÇ" #
relType
ÇÇ$ +
.
ÇÇ+ , 
SourceEntityTypeId
ÇÇ, >
.
ÇÇ> ?
ToString
ÇÇ? G
(
ÇÇG H
CultureInfo
ÇÇH S
.
ÇÇS T
InvariantCulture
ÇÇT d
)
ÇÇd e
,
ÇÇe f
OldValueJson
ÉÉ $
:
ÉÉ$ %
System
ÉÉ& ,
.
ÉÉ, -
Text
ÉÉ- 1
.
ÉÉ1 2
Json
ÉÉ2 6
.
ÉÉ6 7
JsonSerializer
ÉÉ7 E
.
ÉÉE F
	Serialize
ÉÉF O
(
ÉÉO P
rel
ÉÉP S
.
ÉÉS T
TargetEntityId
ÉÉT b
)
ÉÉb c
,
ÉÉc d
NewValueJson
ÑÑ $
:
ÑÑ$ %
System
ÑÑ& ,
.
ÑÑ, -
Text
ÑÑ- 1
.
ÑÑ1 2
Json
ÑÑ2 6
.
ÑÑ6 7
JsonSerializer
ÑÑ7 E
.
ÑÑE F
	Serialize
ÑÑF O
(
ÑÑO P
	newTarget
ÑÑP Y
.
ÑÑY Z
Id
ÑÑZ \
)
ÑÑ\ ]
)
ÑÑ] ^
,
ÑÑ^ _
ct
ÑÑ` b
)
ÑÑb c
;
ÑÑc d
await
ÜÜ -
PublishEntityRefreshDomainAsync
ÜÜ 9
(
ÜÜ9 :
auditOutboxWriter
áá )
,
áá) *
rel
áá+ .
.
áá. /
SourceEntityId
áá/ =
,
áá= >
relType
áá? F
.
ááF G 
SourceEntityTypeId
ááG Y
,
ááY Z
workspaceId
àà #
,
àà# $
userId
àà% +
,
àà+ ,
$str
àà- 6
,
àà6 7
ct
àà8 :
)
àà: ;
;
àà; <
}
ââ 
const
ãã 
int
ãã 

previewCap
ãã $
=
ãã% &
$num
ãã' )
;
ãã) *
return
åå 
new
åå &
EntityRelationshipRefDto
åå 3
(
åå3 4
rel
åå4 7
.
åå7 8
Id
åå8 :
,
åå: ;
relType
åå< C
.
ååC D
Id
ååD F
,
ååF G
relType
ååH O
.
ååO P
Name
ååP T
,
ååT U
relType
çç 
.
çç 
DisplayName
çç '
??
çç( *
DisplayNameHelper
çç+ <
.
çç< =
Humanize
çç= E
(
ççE F
relType
ççF M
.
ççM N
Name
ççN R
)
ççR S
,
ççS T
	newTarget
éé 
.
éé 
Id
éé  
,
éé  !
relType
éé" )
.
éé) *
TargetEntityType
éé* :
.
éé: ;
Name
éé; ?
,
éé? @
relType
èè 
.
èè 
TargetEntityType
èè ,
.
èè, -
DisplayName
èè- 8
??
èè9 ;
DisplayNameHelper
èè< M
.
èèM N
Humanize
èèN V
(
èèV W
relType
èèW ^
.
èè^ _
TargetEntityType
èè_ o
.
èèo p
Name
èèp t
)
èèt u
,
èèu v

MapPreview
êê 
(
êê 
	newTarget
êê (
,
êê( )

previewCap
êê* 4
)
êê4 5
)
êê5 6
;
êê6 7
}
ëë 
,
ëë 
ct
ëë 
)
ëë 
;
ëë 
if
ìì 
(
ìì "
relationshipNotifier
ìì $
is
ìì% '
not
ìì( +
null
ìì, 0
)
ìì0 1
await
îî "
relationshipNotifier
îî *
.
îî* + 
NotifyChangedAsync
îî+ =
(
îî= >
workspaceId
îî> I
,
îîI J
ct
îîK M
,
îîM N
rel
îîO R
.
îîR S
SourceEntityId
îîS a
,
îîa b
rel
îîc f
.
îîf g
TargetEntityId
îîg u
,
îîu v
	newTargetîîw Ä
.îîÄ Å
IdîîÅ É
)îîÉ Ñ
;îîÑ Ö
}
ïï 	
else
ññ 
{
óó 	
if
òò 
(
òò 
!
òò 
rel
òò 
.
òò 
TargetEntity
òò !
.
òò! "
EntityWorkspaces
òò" 2
.
òò2 3
Any
òò3 6
(
òò6 7
ew
òò7 9
=>
òò: <
ew
òò= ?
.
òò? @
WorkspaceId
òò@ K
==
òòL N
workspaceId
òòO Z
)
òòZ [
)
òò[ \
throw
ôô 
new
ôô 
AppException
ôô &
(
ôô& '
$str
ôô' F
,
ôôF G
$num
ôôH K
,
ôôK L
$strôôM ã
)ôôã å
;ôôå ç
var
õõ 
	newSource
õõ 
=
õõ 
await
õõ !
entityRepository
õõ" 2
.
õõ2 3%
GetByIdInWorkspaceAsync
õõ3 J
(
õõJ K
request
õõK R
.
õõR S
NewSourceEntityId
õõS d
!
õõd e
.
õõe f
Value
õõf k
,
õõk l
workspaceId
õõm x
,
õõx y
ct
õõz |
)
õõ| }
??
úú 
throw
úú 
new
úú 
AppException
úú )
(
úú) *
$str
úú* C
,
úúC D
$num
úúE H
,
úúH I
$"
úúJ L
$str
úúL Z
{
úúZ [
request
úú[ b
.
úúb c
NewSourceEntityId
úúc t
.
úút u
Value
úúu z
}
úúz {
$strúú{ ì
"úúì î
)úúî ï
;úúï ñ
if
ùù 
(
ùù 
	newSource
ùù 
.
ùù 

IsArchived
ùù $
)
ùù$ %
throw
ûû 
new
ûû 
AppException
ûû &
(
ûû& '
$str
ûû' D
,
ûûD E
$num
ûûF I
,
ûûI J
$str
ûûK l
)
ûûl m
;
ûûm n
if
üü 
(
üü 
	newSource
üü 
.
üü 
EntityTypeId
üü &
!=
üü' )
relType
üü* 1
.
üü1 2 
SourceEntityTypeId
üü2 D
)
üüD E
throw
†† 
new
†† 
AppException
†† &
(
††& '
$str
††' K
,
††K L
$num
††M P
,
††P Q
$"
††R T
$str††T Ç
{††Ç É
relType††É ä
.††ä ã
Name††ã è
}††è ê
$str††ê í
"††í ì
)††ì î
;††î ï
var
°° 
sourceTypeProps
°° 
=
°°  !
await
°°" '
entityRepository
°°( 8
.
°°8 9$
GetTypePropertiesAsync
°°9 O
(
°°O P
	newSource
°°P Y
.
°°Y Z
EntityTypeId
°°Z f
,
°°f g
ct
°°h j
)
°°j k
;
°°k l
if
¢¢ 
(
¢¢ 
sourceTypeProps
¢¢ 
.
¢¢  
Count
¢¢  %
>
¢¢& '
$num
¢¢( )
&&
¢¢* ,
sourceTypeProps
¢¢- <
.
¢¢< =
All
¢¢= @
(
¢¢@ A
tp
¢¢A C
=>
¢¢D F
tp
¢¢G I
.
¢¢I J
Property
¢¢J R
.
¢¢R S

IsReadonly
¢¢S ]
)
¢¢] ^
)
¢¢^ _
throw
££ 
new
££ 
AppException
££ &
(
££& '
$str
££' A
,
££A B
$num
££C F
,
££F G
$str££H É
)££É Ñ
;££Ñ Ö
if
§§ 
(
§§ 
relType
§§ 
.
§§ %
RelationshipCardinality
§§ /
==
§§0 2
Persistence
§§3 >
.
§§> ?
Entities
§§? G
.
§§G H%
RelationshipCardinality
§§H _
.
§§_ `
	ManyToOne
§§` i
||
•• 
relType
•• 
.
•• %
RelationshipCardinality
•• 2
==
••3 5
Persistence
••6 A
.
••A B
Entities
••B J
.
••J K%
RelationshipCardinality
••K b
.
••b c
OneToOne
••c k
)
••k l
{
¶¶ 
if
ßß 
(
ßß 
await
ßß 
entityRepository
ßß *
.
ßß* +-
CountRelationshipsBySourceAsync
ßß+ J
(
ßßJ K
	newSource
ßßK T
.
ßßT U
Id
ßßU W
,
ßßW X
relType
ßßY `
.
ßß` a
Id
ßßa c
,
ßßc d
ct
ßße g
)
ßßg h
>
ßßi j
$num
ßßk l
)
ßßl m
throw
®® 
new
®® 
AppException
®® *
(
®®* +
$str
®®+ I
,
®®I J
$num
®®K N
,
®®N O
$"
®®P R
$str
®®R o
{
®®o p
relType
®®p w
.
®®w x
Name
®®x |
}
®®| }
$str®®} ù
"®®ù û
)®®û ü
;®®ü †
}
©© 
result
´´ 
=
´´ 
await
´´ 
entityRepository
´´ +
.
´´+ ,'
ExecuteInTransactionAsync
´´, E
(
´´E F
async
´´F K
(
´´L M
)
´´M N
=>
´´O Q
{
¨¨ 
await
≠≠ 
entityRepository
≠≠ &
.
≠≠& '+
UpdateRelationshipSourceAsync
≠≠' D
(
≠≠D E
relationshipId
≠≠E S
,
≠≠S T
	newSource
≠≠U ^
.
≠≠^ _
Id
≠≠_ a
,
≠≠a b
ct
≠≠c e
)
≠≠e f
;
≠≠f g
if
ØØ 
(
ØØ 
auditOutboxWriter
ØØ %
is
ØØ& (
not
ØØ) ,
null
ØØ- 1
)
ØØ1 2
{
∞∞ 
await
±± 
auditOutboxWriter
±± +
.
±±+ ,
EnqueueAuditAsync
±±, =
(
±±= >
new
±±> A 
AuditEventContract
±±B T
(
±±T U
EventId
≤≤ 
:
≤≤  
Guid
≤≤! %
.
≤≤% &
NewGuid
≤≤& -
(
≤≤- .
)
≤≤. /
,
≤≤/ 0
SchemaVersion
≥≥ %
:
≥≥% &
$num
≥≥' (
,
≥≥( )
OccurredAtUtc
¥¥ %
:
¥¥% &
DateTimeOffset
¥¥' 5
.
¥¥5 6
UtcNow
¥¥6 <
,
¥¥< =
SourceService
µµ %
:
µµ% &
$str
µµ' -
,
µµ- .
ActorUserId
∂∂ #
:
∂∂# $
userId
∂∂% +
,
∂∂+ ,

AuditScope
∑∑ "
:
∑∑" #
AuditRouting
∑∑$ 0
.
∑∑0 1
ScopeEntity
∑∑1 <
,
∑∑< =
TargetId
∏∏  
:
∏∏  !
rel
∏∏" %
.
∏∏% &
TargetEntityId
∏∏& 4
,
∏∏4 5
Action
ππ 
:
ππ 
$str
ππ  9
,
ππ9 :
	FieldName
∫∫ !
:
∫∫! "
relType
∫∫# *
.
∫∫* +
Name
∫∫+ /
,
∫∫/ 0

EntityType
ªª "
:
ªª" #
relType
ªª$ +
.
ªª+ , 
TargetEntityTypeId
ªª, >
.
ªª> ?
ToString
ªª? G
(
ªªG H
CultureInfo
ªªH S
.
ªªS T
InvariantCulture
ªªT d
)
ªªd e
,
ªªe f
OldValueJson
ºº $
:
ºº$ %
System
ºº& ,
.
ºº, -
Text
ºº- 1
.
ºº1 2
Json
ºº2 6
.
ºº6 7
JsonSerializer
ºº7 E
.
ººE F
	Serialize
ººF O
(
ººO P
rel
ººP S
.
ººS T
SourceEntityId
ººT b
)
ººb c
,
ººc d
NewValueJson
ΩΩ $
:
ΩΩ$ %
System
ΩΩ& ,
.
ΩΩ, -
Text
ΩΩ- 1
.
ΩΩ1 2
Json
ΩΩ2 6
.
ΩΩ6 7
JsonSerializer
ΩΩ7 E
.
ΩΩE F
	Serialize
ΩΩF O
(
ΩΩO P
	newSource
ΩΩP Y
.
ΩΩY Z
Id
ΩΩZ \
)
ΩΩ\ ]
)
ΩΩ] ^
,
ΩΩ^ _
ct
ΩΩ` b
)
ΩΩb c
;
ΩΩc d
await
øø -
PublishEntityRefreshDomainAsync
øø 9
(
øø9 :
auditOutboxWriter
¿¿ )
,
¿¿) *
rel
¿¿+ .
.
¿¿. /
TargetEntityId
¿¿/ =
,
¿¿= >
relType
¿¿? F
.
¿¿F G 
TargetEntityTypeId
¿¿G Y
,
¿¿Y Z
workspaceId
¡¡ #
,
¡¡# $
userId
¡¡% +
,
¡¡+ ,
$str
¡¡- 6
,
¡¡6 7
ct
¡¡8 :
)
¡¡: ;
;
¡¡; <
}
¬¬ 
const
ƒƒ 
int
ƒƒ 

previewCap
ƒƒ $
=
ƒƒ% &
$num
ƒƒ' )
;
ƒƒ) *
return
≈≈ 
new
≈≈ &
EntityRelationshipRefDto
≈≈ 3
(
≈≈3 4
rel
≈≈4 7
.
≈≈7 8
Id
≈≈8 :
,
≈≈: ;
relType
≈≈< C
.
≈≈C D
Id
≈≈D F
,
≈≈F G
relType
≈≈H O
.
≈≈O P
Name
≈≈P T
,
≈≈T U
relType
∆∆ 
.
∆∆ 
DisplayName
∆∆ '
??
∆∆( *
DisplayNameHelper
∆∆+ <
.
∆∆< =
Humanize
∆∆= E
(
∆∆E F
relType
∆∆F M
.
∆∆M N
Name
∆∆N R
)
∆∆R S
,
∆∆S T
	newSource
«« 
.
«« 
Id
««  
,
««  !
relType
««" )
.
««) *
SourceEntityType
««* :
.
««: ;
Name
««; ?
,
««? @
relType
»» 
.
»» 
SourceEntityType
»» ,
.
»», -
DisplayName
»»- 8
??
»»9 ;
DisplayNameHelper
»»< M
.
»»M N
Humanize
»»N V
(
»»V W
relType
»»W ^
.
»»^ _
SourceEntityType
»»_ o
.
»»o p
Name
»»p t
)
»»t u
,
»»u v

MapPreview
…… 
(
…… 
	newSource
…… (
,
……( )

previewCap
……* 4
)
……4 5
)
……5 6
;
……6 7
}
   
,
   
ct
   
)
   
;
   
if
ÃÃ 
(
ÃÃ "
relationshipNotifier
ÃÃ $
is
ÃÃ% '
not
ÃÃ( +
null
ÃÃ, 0
)
ÃÃ0 1
await
ÕÕ "
relationshipNotifier
ÕÕ *
.
ÕÕ* + 
NotifyChangedAsync
ÕÕ+ =
(
ÕÕ= >
workspaceId
ÕÕ> I
,
ÕÕI J
ct
ÕÕK M
,
ÕÕM N
rel
ÕÕO R
.
ÕÕR S
SourceEntityId
ÕÕS a
,
ÕÕa b
rel
ÕÕc f
.
ÕÕf g
TargetEntityId
ÕÕg u
,
ÕÕu v
	newSourceÕÕw Ä
.ÕÕÄ Å
IdÕÕÅ É
)ÕÕÉ Ñ
;ÕÕÑ Ö
}
ŒŒ 	
return
–– 
result
–– 
;
–– 
}
—— 
private
”” 
static
”” 
Task
”” -
PublishEntityRefreshDomainAsync
”” 7
(
””7 8
IOutboxWriter
‘‘ 
outboxWriter
‘‘ "
,
‘‘" #
int
’’ 
entityId
’’ 
,
’’ 
int
÷÷ 
entityTypeId
÷÷ 
,
÷÷ 
int
◊◊ 
workspaceId
◊◊ 
,
◊◊ 
int
ÿÿ 
actorUserId
ÿÿ 
,
ÿÿ 
string
ŸŸ 
action
ŸŸ 
,
ŸŸ 
CancellationToken
⁄⁄ 
ct
⁄⁄ 
)
⁄⁄ 
{
€€ 
var
‹‹ 
sagaInstanceId
‹‹ 
=
‹‹ 
Guid
‹‹ !
.
‹‹! "
NewGuid
‹‹" )
(
‹‹) *
)
‹‹* +
;
‹‹+ ,
var
›› 
envelope
›› 
=
›› 
new
›› #
DomainMessageEnvelope
›› 0
(
››0 1
SchemaVersion
ﬁﬁ 
:
ﬁﬁ %
MessagingSchemaVersions
ﬁﬁ 2
.
ﬁﬁ2 3
V1
ﬁﬁ3 5
,
ﬁﬁ5 6
	MessageId
ﬂﬂ 
:
ﬂﬂ 
Guid
ﬂﬂ 
.
ﬂﬂ 
NewGuid
ﬂﬂ #
(
ﬂﬂ# $
)
ﬂﬂ$ %
,
ﬂﬂ% &
CorrelationId
‡‡ 
:
‡‡ 
sagaInstanceId
‡‡ )
,
‡‡) *
SagaInstanceId
·· 
:
·· 
sagaInstanceId
·· *
,
··* +
CausationId
‚‚ 
:
‚‚ 
null
‚‚ 
,
‚‚ 
OccurredAtUtc
„„ 
:
„„ 
DateTimeOffset
„„ )
.
„„) *
UtcNow
„„* 0
,
„„0 1
SourceService
‰‰ 
:
‰‰ 
$str
‰‰ !
,
‰‰! "
PayloadTypeName
ÂÂ 
:
ÂÂ  
DomainPayloadTypes
ÂÂ /
.
ÂÂ/ 0%
EntityAnalysisRefreshV1
ÂÂ0 G
,
ÂÂG H
PayloadJson
ÊÊ 
:
ÊÊ 
JsonSerializer
ÊÊ '
.
ÊÊ' (
	Serialize
ÊÊ( 1
(
ÊÊ1 2
new
ÊÊ2 5,
EntityAnalysisRefreshPayloadV1
ÊÊ6 T
(
ÊÊT U
EntityId
ÁÁ 
:
ÁÁ 
entityId
ÁÁ "
,
ÁÁ" #
EntityTypeId
ËË 
:
ËË 
entityTypeId
ËË *
,
ËË* +
WorkspaceId
ÈÈ 
:
ÈÈ 
workspaceId
ÈÈ (
,
ÈÈ( )
ActorUserId
ÍÍ 
:
ÍÍ 
actorUserId
ÍÍ (
,
ÍÍ( )
Action
ÎÎ 
:
ÎÎ 
action
ÎÎ 
,
ÎÎ  
SourceUpdatedAtUtc
ÏÏ "
:
ÏÏ" #
DateTimeOffset
ÏÏ$ 2
.
ÏÏ2 3
UtcNow
ÏÏ3 9
)
ÏÏ9 :
)
ÏÏ: ;
)
ÏÏ; <
;
ÏÏ< =
return
ÓÓ 
outboxWriter
ÓÓ 
.
ÓÓ  
EnqueueDomainAsync
ÓÓ .
(
ÓÓ. /
DomainRouting
ÔÔ 
.
ÔÔ "
RoutingKeyCoreEntity
ÔÔ .
(
ÔÔ. /
DomainRouting
ÔÔ/ <
.
ÔÔ< =#
CoreEntityVerbChanged
ÔÔ= R
)
ÔÔR S
,
ÔÔS T
envelope
 
,
 
ct
ÒÒ 
)
ÒÒ 
;
ÒÒ 
}
ÚÚ 
}ÛÛ à
jC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Interfaces\IWorkspaceService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Interfaces$ .
;. /
public 
	interface 
IWorkspaceService "
{ 
Task 
< 	
WorkspaceDto	 
> 
CreateAsync "
(" #
int# &
userId' -
,- ."
CreateWorkspaceRequest/ E
requestF M
,M N
CancellationTokenO `
cta c
=d e
defaultf m
)m n
;n o
Task 
< 	
List	 
< 
WorkspaceDto 
> 
> 
GetByUserAsync +
(+ ,
int, /
userId0 6
,6 7
int8 ;
?; <
organizationId= K
,K L
CancellationTokenM ^
ct_ a
=b c
defaultd k
)k l
;l m
Task		 
<		 	
WorkspaceDto			 
>		 
GetByIdAsync		 #
(		# $
int		$ '
workspaceId		( 3
,		3 4
int		5 8
userId		9 ?
,		? @
CancellationToken		A R
ct		S U
=		V W
default		X _
)		_ `
;		` a
Task

 
UpdateAsync

	 
(

 
int

 
workspaceId

 $
,

$ %
int

& )
userId

* 0
,

0 1"
UpdateWorkspaceRequest

2 H
request

I P
,

P Q
CancellationToken

R c
ct

d f
=

g h
default

i p
)

p q
;

q r
Task 
ArchiveAsync	 
( 
int 
workspaceId %
,% &
int' *
userId+ 1
,1 2
CancellationToken3 D
ctE G
=H I
defaultJ Q
)Q R
;R S
Task 
< 	 
WorkspaceSettingsDto	 
> 
GetSettingsAsync /
(/ 0
int0 3
workspaceId4 ?
,? @
intA D
userIdE K
,K L
CancellationTokenM ^
ct_ a
=b c
defaultd k
)k l
;l m
Task 
UpdateSettingsAsync	 
( 
int  
workspaceId! ,
,, -
int. 1
userId2 8
,8 9*
UpdateWorkspaceSettingsRequest: X
requestY `
,` a
CancellationTokenb s
ctt v
=w x
default	y Ä
)
Ä Å
;
Å Ç
} À
pC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Interfaces\IWorkspaceMemberService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Interfaces$ .
;. /
public 
	interface #
IWorkspaceMemberService (
{ 
Task 
< 	
List	 
< 
WorkspaceMemberDto  
>  !
>! "
GetMembersAsync# 2
(2 3
int3 6
workspaceId7 B
,B C
intD G
userIdH N
,N O
CancellationTokenP a
ctb d
=e f
defaultg n
)n o
;o p
Task 
UpdateRoleAsync	 
( 
int 
workspaceId (
,( )
int* -
targetUserId. :
,: ;
int< ?
callerUserId@ L
,L M#
UpdateMemberRoleRequestN e
requestf m
,m n
CancellationToken	o Ä
ct
Å É
=
Ñ Ö
default
Ü ç
)
ç é
;
é è
Task		 
RemoveAsync			 
(		 
int		 
workspaceId		 $
,		$ %
int		& )
targetUserId		* 6
,		6 7
int		8 ;
callerUserId		< H
,		H I
CancellationToken		J [
ct		\ ^
=		_ `
default		a h
)		h i
;		i j
Task

 
<

 	
WorkspaceMemberDto

	 
>

 
AddMemberAsync

 +
(

+ ,
int

, /
workspaceId

0 ;
,

; <
int

= @
callerUserId

A M
,

M N%
AddWorkspaceMemberRequest

O h
request

i p
,

p q
CancellationToken	

r É
ct


Ñ Ü
=


á à
default


â ê
)


ê ë
;


ë í
} ≤
nC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Interfaces\IOrgInvitationService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Interfaces$ .
;. /
public 
	interface !
IOrgInvitationService &
{ 
Task 
< 	
OrgInvitationDto	 
> 
InviteAsync &
(& '
int' *
organizationId+ 9
,9 :
int; >
callerUserId? K
,K L
InviteToOrgRequestM _
request` g
,g h
CancellationTokeni z
ct{ }
=~ 
default
Ä á
)
á à
;
à â
Task 
< 	
List	 
< 
OrgInvitationDto 
> 
>  "
GetByOrganizationAsync! 7
(7 8
int8 ;
organizationId< J
,J K
intL O
callerUserIdP \
,\ ]
CancellationToken^ o
ctp r
=s t
defaultu |
)| }
;} ~
Task		 
CancelAsync			 
(		 
int		 
organizationId		 '
,		' (
int		) ,
invitationId		- 9
,		9 :
int		; >
callerUserId		? K
,		K L
CancellationToken		M ^
ct		_ a
=		b c
default		d k
)		k l
;		l m
Task

 
<

 	
OrgInvitationDto

	 
>

 
ResendAsync

 &
(

& '
int

' *
organizationId

+ 9
,

9 :
int

; >
invitationId

? K
,

K L
int

M P
callerUserId

Q ]
,

] ^
CancellationToken

_ p
ct

q s
=

t u
default

v }
)

} ~
;

~ 
Task 
AcceptAsync	 
( 
int 
userId 
,  
string! '
	userEmail( 1
,1 2
string3 9
token: ?
,? @
CancellationTokenA R
ctS U
=V W
defaultX _
)_ `
;` a
Task 
DeclineAsync	 
( 
int 
userId  
,  !
string" (
	userEmail) 2
,2 3
string4 :
token; @
,@ A
CancellationTokenB S
ctT V
=W X
defaultY `
)` a
;a b
Task 
< 	
List	 
< 
OrgInvitationDto 
> 
>  (
GetMyPendingInvitationsAsync! =
(= >
string> D
	userEmailE N
,N O
CancellationTokenP a
ctb d
=e f
defaultg n
)n o
;o p
} ∆
rC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Interfaces\IWorkspaceAccessEvaluator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Interfaces$ .
;. /
public 
	interface %
IWorkspaceAccessEvaluator *
{ 
Task		 
<		 	
bool			 
>		 &
IsOrgOwnerOfWorkspaceAsync		 )
(		) *
int		* -
userId		. 4
,		4 5
int		6 9
workspaceId		: E
,		E F
CancellationToken		G X
ct		Y [
=		\ ]
default		^ e
)		e f
;		f g
Task 
< 	
bool	 
> '
HasWorkspacePermissionAsync *
(* +
int+ .
userId/ 5
,5 6
int7 :
workspaceId; F
,F G
stringH N
permissionNameO ]
,] ^
CancellationToken_ p
ctq s
=t u
defaultv }
)} ~
;~ 
Task )
EnsureCanAccessWorkspaceAsync	 &
(& '
int' *
userId+ 1
,1 2
int3 6
workspaceId7 B
,B C
CancellationTokenD U
ctV X
=Y Z
default[ b
)b c
;c d
Task 
< 	
IReadOnlyList	 
< 
string 
> 
> 5
)GetEffectiveWorkspacePermissionNamesAsync  I
(I J
intJ M
userIdN T
,T U
intV Y
workspaceIdZ e
,e f
CancellationTokeng x
cty {
=| }
default	~ Ö
)
Ö Ü
;
Ü á
} ˙
eC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Interfaces\IRoleService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Interfaces$ .
;. /
public 
	interface 
IRoleService 
{ 
Task 
< 	
List	 
< 
RoleDto 
> 
> 
GetByWorkspaceAsync +
(+ ,
int, /
workspaceId0 ;
,; <
int= @
userIdA G
,G H
CancellationTokenI Z
ct[ ]
=^ _
default` g
)g h
;h i
Task 
< 	
RoleDto	 
> 
CreateAsync 
( 
int !
workspaceId" -
,- .
int/ 2
userId3 9
,9 :
CreateRoleRequest; L
requestM T
,T U
CancellationTokenV g
cth j
=k l
defaultm t
)t u
;u v
Task		 
UpdateAsync			 
(		 
int		 
workspaceId		 $
,		$ %
int		& )
roleId		* 0
,		0 1
int		2 5
userId		6 <
,		< =
UpdateRoleRequest		> O
request		P W
,		W X
CancellationToken		Y j
ct		k m
=		n o
default		p w
)		w x
;		x y
Task

 
ArchiveAsync

	 
(

 
int

 
workspaceId

 %
,

% &
int

' *
roleId

+ 1
,

1 2
int

3 6
userId

7 =
,

= >
CancellationToken

? P
ct

Q S
=

T U
default

V ]
)

] ^
;

^ _
Task 
< 	
List	 
< 
PermissionDto 
> 
> "
GetAllPermissionsAsync 4
(4 5
CancellationToken5 F
ctG I
=J K
defaultL S
)S T
;T U
} ¸
hC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Interfaces\IOrgRoleService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Interfaces$ .
;. /
public 
	interface 
IOrgRoleService  
{ 
Task 
< 	
List	 
< 

OrgRoleDto 
> 
> "
GetByOrganizationAsync 1
(1 2
int2 5
organizationId6 D
,D E
intF I
userIdJ P
,P Q
CancellationTokenR c
ctd f
=g h
defaulti p
)p q
;q r
Task		 
<		 	

OrgRoleDto			 
>		 
CreateAsync		  
(		  !
int		! $
organizationId		% 3
,		3 4
int		5 8
userId		9 ?
,		? @ 
CreateOrgRoleRequest		A U
request		V ]
,		] ^
CancellationToken		_ p
ct		q s
=		t u
default		v }
)		} ~
;		~ 
Task

 
UpdateAsync

	 
(

 
int

 
organizationId

 '
,

' (
int

) ,
roleId

- 3
,

3 4
int

5 8
userId

9 ?
,

? @ 
UpdateOrgRoleRequest

A U
request

V ]
,

] ^
CancellationToken

_ p
ct

q s
=

t u
default

v }
)

} ~
;

~ 
Task 
ArchiveAsync	 
( 
int 
organizationId (
,( )
int* -
roleId. 4
,4 5
int6 9
userId: @
,@ A
CancellationTokenB S
ctT V
=W X
defaultY `
)` a
;a b
} ≠
vC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Interfaces\IOrganizationUserAdminService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Interfaces$ .
;. /
public 
	interface )
IOrganizationUserAdminService .
{ 
Task 
< 	
RegisterResponseDto	 
> 
CreateOrgUserAsync 0
(0 1
int1 4
organizationId5 C
,C D
intE H
callerUserIdI U
,U V 
CreateOrgUserRequestW k
requestl s
,s t
CancellationToken	u Ü
ct
á â
=
ä ã
default
å ì
)
ì î
;
î ï
Task

 
<

 	
UserProfileDto

	 
>

 '
UpdateOtherUserProfileAsync

 4
(

4 5
int

5 8
organizationId

9 G
,

G H
int

I L
targetUserId

M Y
,

Y Z
int

[ ^
callerUserId

_ k
,

k l(
UpdateOrgUserProfileRequest	

m à
request


â ê
,


ê ë
CancellationToken


í £
ct


§ ¶
=


ß ®
default


© ∞
)


∞ ±
;


± ≤
Task 
DeleteOrgUserAsync	 
( 
int 
organizationId  .
,. /
int0 3
targetUserId4 @
,@ A
intB E
callerUserIdF R
,R S
CancellationTokenT e
ctf h
=i j
defaultk r
)r s
;s t
} «
mC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Interfaces\IOrganizationService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Interfaces$ .
;. /
public 
	interface  
IOrganizationService %
{ 
Task 
< 	
OrganizationDto	 
> 
CreateAsync %
(% &
int& )
userId* 0
,0 1%
CreateOrganizationRequest2 K
requestL S
,S T
CancellationTokenU f
ctg i
=j k
defaultl s
)s t
;t u
Task 
< 	
List	 
< 
OrganizationDto 
> 
> 
GetByUserAsync  .
(. /
int/ 2
userId3 9
,9 :
CancellationToken; L
ctM O
=P Q
defaultR Y
)Y Z
;Z [
Task		 
<		 	
OrganizationDto			 
>		 
GetByIdAsync		 &
(		& '
int		' *
organizationId		+ 9
,		9 :
int		; >
userId		? E
,		E F
CancellationToken		G X
ct		Y [
=		\ ]
default		^ e
)		e f
;		f g
Task

 
UpdateAsync

	 
(

 
int

 
organizationId

 '
,

' (
int

) ,
userId

- 3
,

3 4%
UpdateOrganizationRequest

5 N
request

O V
,

V W
CancellationToken

X i
ct

j l
=

m n
default

o v
)

v w
;

w x
Task 
< 	
List	 
< '
OrganizationSearchResultDto )
>) *
>* +
SearchAsync, 7
(7 8
string8 >
query? D
,D E
CancellationTokenF W
ctX Z
=[ \
default] d
)d e
;e f
Task 
< 	
List	 
< 
OrgMemberDto 
> 
> 
GetMembersAsync ,
(, -
int- 0
organizationId1 ?
,? @
intA D
userIdE K
,K L
CancellationTokenM ^
ct_ a
=b c
defaultd k
)k l
;l m
Task 
RemoveMemberAsync	 
( 
int 
organizationId -
,- .
int/ 2
targetUserId3 ?
,? @
intA D
callerUserIdE Q
,Q R
CancellationTokenS d
cte g
=h i
defaultj q
)q r
;r s
Task !
ChangeMemberRoleAsync	 
( 
int "
organizationId# 1
,1 2
int3 6
targetUserId7 C
,C D
intE H
callerUserIdI U
,U V&
ChangeOrgMemberRoleRequestW q
requestr y
,y z
CancellationToken	{ å
ct
ç è
=
ê ë
default
í ô
)
ô ö
;
ö õ
Task 
< 	#
OrganizationSettingsDto	  
>  !
GetSettingsAsync" 2
(2 3
int3 6
organizationId7 E
,E F
intG J
userIdK Q
,Q R
CancellationTokenS d
cte g
=h i
defaultj q
)q r
;r s
Task 
UpdateSettingsAsync	 
( 
int  
organizationId! /
,/ 0
int1 4
userId5 ;
,; <-
!UpdateOrganizationSettingsRequest= ^
request_ f
,f g
CancellationTokenh y
ctz |
=} ~
default	 Ü
)
Ü á
;
á à
} À
lC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Interfaces\IJoinRequestService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Interfaces$ .
;. /
public 
	interface 
IJoinRequestService $
{ 
Task 
< 	
JoinRequestDto	 
> 
SubmitAsync $
($ %
int% (
organizationId) 7
,7 8
int9 <
userId= C
,C D$
CreateJoinRequestRequestE ]
request^ e
,e f
CancellationTokeng x
cty {
=| }
default	~ Ö
)
Ö Ü
;
Ü á
Task 
< 	
List	 
< 
JoinRequestDto 
> 
> "
GetByOrganizationAsync 5
(5 6
int6 9
organizationId: H
,H I
intJ M
callerUserIdN Z
,Z [
CancellationToken\ m
ctn p
=q r
defaults z
)z {
;{ |
Task		 
ReviewAsync			 
(		 
int		 
organizationId		 '
,		' (
int		) ,
	requestId		- 6
,		6 7
int		8 ;
callerUserId		< H
,		H I$
ReviewJoinRequestRequest		J b
request		c j
,		j k
CancellationToken		l }
ct			~ Ä
=
		Å Ç
default
		É ä
)
		ä ã
;
		ã å
Task

 
<

 	
List

	 
<

 
JoinRequestDto

 
>

 
>

 
GetMyRequestsAsync

 1
(

1 2
int

2 5
userId

6 <
,

< =
CancellationToken

> O
ct

P R
=

S T
default

U \
)

\ ]
;

] ^
Task 
CancelMineAsync	 
( 
int 
	requestId &
,& '
int( +
userId, 2
,2 3
CancellationToken4 E
ctF H
=I J
defaultK R
)R S
;S T
} é
kC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Interfaces\IEntityTypeService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Interfaces$ .
;. /
public 
	interface 
IEntityTypeService #
{ 
Task 
< 	
List	 
< 
EntityTypeDto 
> 
> 
GetAllAsync )
() *
CancellationToken* ;
ct< >
=? @
defaultA H
)H I
;I J
} å#
gC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Interfaces\IEntityService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Interfaces$ .
;. /
public 
	interface 
IEntityService 
{ 
Task 
< 	
EntityPagedResult	 
> 
GetByWorkspaceAsync /
(/ 0
int		 
workspaceId		 
,		 
int

 
userId

 
,

 
int 
? 
entityTypeId 
, 
string 
? 
searchQuery 
, 
int 
skip 
, 
int 
take 
, 
IReadOnlyList 
< !
EntityFilterCondition +
>+ ,
?, -
filters. 5
=6 7
null8 <
,< =
IReadOnlyList 
< 
EntitySortField %
>% &
?& '
sort( ,
=- .
null/ 3
,3 4
int 
? (
excludeLinkedSourceRelTypeId )
=* +
null, 0
,0 1
int 
? (
excludeLinkedTargetRelTypeId )
=* +
null, 0
,0 1
CancellationToken 
ct 
= 
default &
)& '
;' (
Task 
< 	
EntityDetailDto	 
> 
GetByIdAsync &
(& '
int' *
entityId+ 3
,3 4
int5 8
workspaceId9 D
,D E
intF I
userIdJ P
,P Q
CancellationTokenR c
ctd f
=g h
defaulti p
)p q
;q r
Task 
< 	
EntityDetailDto	 
> 
CreateAsync %
(% &
int& )
workspaceId* 5
,5 6
int7 :
userId; A
,A B
CreateEntityRequestC V
requestW ^
,^ _
CancellationToken` q
ctr t
=u v
defaultw ~
)~ 
;	 Ä
Task 
< 	
EntityDetailDto	 
> 
UpdateAsync %
(% &
int& )
entityId* 2
,2 3
int4 7
workspaceId8 C
,C D
intE H
userIdI O
,O P
UpdateEntityRequestQ d
requeste l
,l m
CancellationTokenn 
ct
Ä Ç
=
É Ñ
default
Ö å
)
å ç
;
ç é
Task 
ArchiveAsync	 
( 
int 
entityId "
," #
int$ '
workspaceId( 3
,3 4
int5 8
userId9 ?
,? @
CancellationTokenA R
ctS U
=V W
defaultX _
)_ `
;` a
Task 
< 	$
EntityRelationshipRefDto	 !
>! "#
CreateRelationshipAsync# :
(: ;
int; >
workspaceId? J
,J K
intL O
userIdP V
,V W+
CreateEntityRelationshipRequestX w
requestx 
,	 Ä
CancellationToken
Å í
ct
ì ï
=
ñ ó
default
ò ü
)
ü †
;
† °
Task #
DeleteRelationshipAsync	  
(  !
int! $
workspaceId% 0
,0 1
int2 5
userId6 <
,< =
int> A
relationshipIdB P
,P Q
CancellationTokenR c
ctd f
=g h
defaulti p
)p q
;q r
Task 
< 	$
EntityRelationshipRefDto	 !
>! "%
ReassignRelationshipAsync# <
(< =
int= @
workspaceIdA L
,L M
intN Q
userIdR X
,X Y
intZ ]
relationshipId^ l
,l m.
!ReassignEntityRelationshipRequest	n è
request
ê ó
,
ó ò
CancellationToken
ô ™
ct
´ ≠
=
Æ Ø
default
∞ ∑
)
∑ ∏
;
∏ π
} º
tC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Interfaces\IEntityRelationshipNotifier.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Interfaces$ .
;. /
public 
	interface '
IEntityRelationshipNotifier ,
{ 
Task 
NotifyChangedAsync	 
( 
int 
workspaceId  +
,+ ,
CancellationToken- >
ct? A
,A B
paramsC I
intJ M
[M N
]N O
	entityIdsP Y
)Y Z
;Z [
} ´
qC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Exceptions\ForbiddenAccessException.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Exceptions$ .
;. /
public 
sealed 
class $
ForbiddenAccessException ,
(, -
string- 3
message4 ;
); <
:= >
	Exception? H
(H I
messageI P
)P Q
;Q Rñ
pC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Exceptions\EntityNotFoundException.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Exceptions$ .
;. /
public 
sealed 
class #
EntityNotFoundException +
(+ ,
int, /
entityId0 8
,8 9
int: =
workspaceId> I
)I J
:  
KeyNotFoundException 
( 
$" 
$str $
{$ %
entityId% -
}- .
$str. F
{F G
workspaceIdG R
}R S
$strS T
"T U
)U V
;V W∂
eC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Exceptions\AppException.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $

Exceptions$ .
;. /
public 
sealed 
class 
AppException  
(  !
string! '
code( ,
,, -
int. 1

statusCode2 <
,< =
string> D
?D E
messageF M
=N O
nullP T
)T U
: 
	Exception 
( 
message 
?? 
code 
)  
{ 
public 

string 
Code 
{ 
get 
; 
} 
=  !
code" &
;& '
public 

int 

StatusCode 
{ 
get 
;  
}! "
=# $

statusCode% /
;/ 0
} π
qC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Workspace\WorkspaceSettingsDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
	Workspace) 2
;2 3
public 
sealed 
record  
WorkspaceSettingsDto )
() *
int 
WorkspaceId 
, 
string 

Name 
, 
string 

?
 
Description 
, 
decimal 
HighRiskThreshold 
, 
decimal 
MediumRiskThreshold 
,  
bool		 
RiskScoringEnabled			 
)		 
;		 ì
iC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Workspace\WorkspaceDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
	Workspace) 2
;2 3
public 
sealed 
record 
WorkspaceDto !
(! "
int 
Id 

,
 
int 
OrganizationId 
, 
string 

Name 
, 
int 
MemberCount 
, 
string 

?
 
UserRole 
, 
string		 

?		
 
UserRoleDisplayName		 
,		  
IReadOnlyList

 
<

 
string

 
>

 
MyPermissions

 '
)

' (
;

( )î
{C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Workspace\UpdateWorkspaceSettingsRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
	Workspace) 2
;2 3
public 
sealed 
record *
UpdateWorkspaceSettingsRequest 3
(3 4
string 

Name 
, 
string 

?
 
Description 
, 
decimal 
HighRiskThreshold 
, 
decimal 
MediumRiskThreshold 
,  
bool 
RiskScoringEnabled	 
) 
; 
sC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Workspace\UpdateWorkspaceRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
	Workspace) 2
;2 3
public 
sealed 
record "
UpdateWorkspaceRequest +
(+ ,
string, 2
Name3 7
)7 8
;8 9¨
sC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Workspace\CreateWorkspaceRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
	Workspace) 2
;2 3
public 
sealed 
record "
CreateWorkspaceRequest +
(+ ,
string, 2
Name3 7
,7 8
int9 <
OrganizationId= K
)K L
;L MÂ
iC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Role\UpdateRoleRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Role) -
;- .
public 
sealed 
record 
UpdateRoleRequest &
(& '
string' -
?- .
Name/ 3
,3 4
List5 9
<9 :
int: =
>= >
?> ?
PermissionIds@ M
)M N
;N Oﬁ
_C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Role\RoleDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Role) -
;- .
public 
sealed 
record 
RoleDto 
( 
int 
Id 

,
 
string 

Name 
, 
string 

DisplayName 
, 
bool 
IsSystem	 
, 
List 
< 	
PermissionDto	 
> 
Permissions #
)# $
;$ %¿
eC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Role\PermissionDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Role) -
;- .
public 
sealed 
record 
PermissionDto "
(" #
int# &
Id' )
,) *
string+ 1
Name2 6
,6 7
string8 >
DisplayName? J
)J K
;K L«
iC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Role\CreateRoleRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Role) -
;- .
public 
sealed 
record 
CreateRoleRequest &
(& '
string' -
Name. 2
,2 3
List4 8
<8 9
int9 <
>< =
PermissionIds> K
)K L
;L M∂
oC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\OrgRole\UpdateOrgRoleRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
OrgRole) 0
;0 1
public 
sealed 
record  
UpdateOrgRoleRequest )
() *
string* 0
?0 1
Name2 6
,6 7
List8 <
<< =
int= @
>@ A
?A B
PermissionIdsC P
,P Q
intR U
?U V
PriorityW _
)_ `
;` a•
eC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\OrgRole\OrgRoleDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
OrgRole) 0
;0 1
public 
sealed 
record 

OrgRoleDto 
(  
int  #
Id$ &
,& '
string( .
Name/ 3
,3 4
string5 ;
DisplayName< G
,G H
boolI M
IsSystemN V
,V W
intX [
Priority\ d
,d e
Listf j
<j k
PermissionDtok x
>x y
Permissions	z Ö
)
Ö Ü
;
Ü áâ
oC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\OrgRole\CreateOrgRoleRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
OrgRole) 0
;0 1
public 
sealed 
record  
CreateOrgRoleRequest )
() *
string* 0
Name1 5
,5 6
List7 ;
<; <
int< ?
>? @
PermissionIdsA N
,N O
intP S
PriorityT \
)\ ]
;] ^º
qC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\OrgInvitation\OrgInvitationDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
OrgInvitation) 6
;6 7
public 
sealed 
record 
OrgInvitationDto %
(% &
int 
Id 

,
 
int 
OrganizationId 
, 
string 

Email 
, 
string 

OrganizationName 
, 
string 

RoleName 
, 
string		 

RoleDisplayName		 
,		 
string

 

Status

 
,

 
string 

Token 
, 
DateTime 
	ExpiresAt 
) 
; ÿ
sC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\OrgInvitation\InviteToOrgRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
OrgInvitation) 6
;6 7
public 
sealed 
record 
InviteToOrgRequest '
(' (
string( .
Email/ 4
,4 5
int6 9
?9 :
	OrgRoleId; D
=E F
nullG K
)K L
;L MÅ
{C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\OrgInvitation\AcceptOrgInvitationRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
OrgInvitation) 6
;6 7
public 
sealed 
record &
AcceptOrgInvitationRequest /
(/ 0
string0 6
Token7 <
)< =
;= >æ
{C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Organization\UpdateOrgUserProfileRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Organization) 5
;5 6
public 
sealed 
record '
UpdateOrgUserProfileRequest 0
(0 1
string1 7
	FirstName8 A
,A B
stringC I
LastNameJ R
)R S
;S T‡
ÅC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Organization\UpdateOrganizationSettingsRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Organization) 5
;5 6
public 
sealed 
record -
!UpdateOrganizationSettingsRequest 6
(6 7
string 

Name 
, 
string 

?
 
Description 
, 
string 


JoinPolicy 
, 
int 
? 
DefaultOrgRoleId	 
) 
; ¸
yC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Organization\UpdateOrganizationRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Organization) 5
;5 6
public 
sealed 
record %
UpdateOrganizationRequest .
(. /
string/ 5
Name6 :
): ;
;; <…
lC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Organization\OrgMemberDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Organization) 5
;5 6
public 
sealed 
record 
OrgMemberDto !
(! "
int" %
UserId& ,
,, -
string. 4
	FirstName5 >
,> ?
string@ F
LastNameG O
,O P
stringQ W
EmailX ]
,] ^
string_ e
RoleNamef n
,n o
stringp v
RoleDisplayName	w Ü
,
Ü á
DateTime
à ê
JoinedAt
ë ô
)
ô ö
;
ö õŸ
wC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Organization\OrganizationSettingsDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Organization) 5
;5 6
public 
sealed 
record #
OrganizationSettingsDto ,
(, -
int 
OrganizationId 
, 
string 

Name 
, 
string 

?
 
Description 
, 
string 


JoinPolicy 
, 
int 
? 
DefaultOrgRoleId	 
, 
string		 

?		
 
DefaultOrgRoleName		 
)		 
;		  ≈
{C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Organization\OrganizationSearchResultDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Organization) 5
;5 6
public 
sealed 
record '
OrganizationSearchResultDto 0
(0 1
int1 4
Id5 7
,7 8
string9 ?
Name@ D
,D E
intF I
MemberCountJ U
,U V
stringW ]

JoinPolicy^ h
=i j
$strk q
)q r
;r s„
oC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Organization\OrganizationDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Organization) 5
;5 6
public 
sealed 
record 
OrganizationDto $
($ %
int 
Id 

,
 
string 

Name 
, 
int 
MemberCount 
, 
string 

?
 
UserRole 
, 
string 

?
 
UserRoleDisplayName 
,  
IReadOnlyList		 
<		 
string		 
>		 
MyPermissions		 '
)		' (
;		( )Ù
}C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Organization\CreateOrgUserRequestValidator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Organization) 5
;5 6
public 
sealed 
class )
CreateOrgUserRequestValidator 1
:2 3
AbstractValidator4 E
<E F 
CreateOrgUserRequestF Z
>Z [
{ 
public 
)
CreateOrgUserRequestValidator (
(( )
)) *
{ 
RuleFor		 
(		 
x		 
=>		 
x		 
.		 
	FirstName		  
)		  !
.

 
NotEmpty

 
(

 
)

 
.

 
WithMessage

 #
(

# $
$str

$ =
)

= >
. 
MaximumLength 
( 
$num 
) 
;  
RuleFor 
( 
x 
=> 
x 
. 
LastName 
)  
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ <
)< =
. 
MaximumLength 
( 
$num 
) 
;  
RuleFor 
( 
x 
=> 
x 
. 
Email 
) 
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ 8
)8 9
. 
EmailAddress 
( 
) 
. 
WithMessage '
(' (
$str( L
)L M
;M N
RuleFor 
( 
x 
=> 
x 
. 
Password 
)  
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ ;
); <
. 
MinimumLength 
( 
$num 
) 
. 
WithMessage )
() *
$str* S
)S T
;T U
RuleFor 
( 
x 
=> 
x 
. 
	OrgRoleId  
)  !
. 
GreaterThan 
( 
$num 
) 
. 
When 
( 
x 
=> 
x 
. 
	OrgRoleId "
." #
HasValue# +
)+ ,
. 
WithMessage 
( 
$str ?
)? @
;@ A
} 
} Â
tC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Organization\CreateOrgUserRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Organization) 5
;5 6
public 
sealed 
record  
CreateOrgUserRequest )
() *
string 

	FirstName 
, 
string 

LastName 
, 
string 

Email 
, 
string 

Password 
, 
int 
? 
	OrgRoleId	 
) 
; ¸
yC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Organization\CreateOrganizationRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Organization) 5
;5 6
public 
sealed 
record %
CreateOrganizationRequest .
(. /
string/ 5
Name6 :
): ;
;; <˝
zC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Organization\ChangeOrgMemberRoleRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Organization) 5
;5 6
public 
sealed 
record &
ChangeOrgMemberRoleRequest /
(/ 0
int0 3
RoleId4 :
): ;
;; <æ
lC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Member\WorkspaceMemberDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Member) /
;/ 0
public 
sealed 
record 
WorkspaceMemberDto '
(' (
int 
UserId 
, 
string 

	FirstName 
, 
string 

LastName 
, 
string 

Email 
, 
string 

RoleName 
, 
string		 

RoleDisplayName		 
,		 
DateTime

 
JoinedAt

 
)

 
;

 Î
qC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Member\UpdateMemberRoleRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Member) /
;/ 0
public 
sealed 
record #
UpdateMemberRoleRequest ,
(, -
int- 0
RoleId1 7
)7 8
;8 9£
sC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Member\AddWorkspaceMemberRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Member) /
;/ 0
public 
sealed 
record %
AddWorkspaceMemberRequest .
(. /
int/ 2
UserId3 9
,9 :
int; >
RoleId? E
)E F
;F G¸
wC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\JoinRequest\ReviewJoinRequestRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
JoinRequest) 4
;4 5
public 
sealed 
record $
ReviewJoinRequestRequest -
(- .
string. 4
Decision5 =
)= >
;> ?˙
mC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\JoinRequest\JoinRequestDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
JoinRequest) 4
;4 5
public 
sealed 
record 
JoinRequestDto #
(# $
int$ '
Id( *
,* +
int, /
UserId0 6
,6 7
string8 >
UserName? G
,G H
stringI O
	UserEmailP Y
,Y Z
string[ a
?a b
Messagec j
,j k
stringl r
Statuss y
,y z
DateTime	{ É
	CreatedAt
Ñ ç
,
ç é
string
è ï
?
ï ñ
ReviewedByName
ó •
,
• ¶
DateTime
ß Ø
?
Ø ∞

ReviewedAt
± ª
,
ª º
int
Ω ¿
OrganizationId
¡ œ
,
œ –
string
— ◊
OrganizationName
ÿ Ë
)
Ë È
;
È Íä
wC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\JoinRequest\CreateJoinRequestRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
JoinRequest) 4
;4 5
public 
sealed 
record $
CreateJoinRequestRequest -
(- .
string. 4
?4 5
Message6 =
)= >
;> ?≥
nC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Invitation\MyInvitationsDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )

Invitation) 3
;3 4
public 
sealed 
record 
MyInvitationsDto %
(% &
List& *
<* +
OrgInvitationDto+ ;
>; <#
OrganizationInvitations= T
)T U
;U V¶
mC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Entity\UpdateEntityRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Entity) /
;/ 0
public 
sealed 
record 
UpdateEntityRequest (
(( )
List) -
<- .
PropertyValueInput. @
>@ A

PropertiesB L
)L M
;M Ns
qC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Entity\ResolvedFilterCondition.csÁ
{C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Entity\ReassignEntityRelationshipRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Entity) /
;/ 0
public 
sealed 
record -
!ReassignEntityRelationshipRequest 6
(6 7
int 
? 
NewSourceEntityId	 
, 
int		 
?		 
NewTargetEntityId			 
)		 
;		 ™
lC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Entity\PropertyValueInput.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Entity) /
;/ 0
public 
sealed 
record 
PropertyValueInput '
(' (
int( +

PropertyId, 6
,6 7
string8 >
?> ?
Value@ E
)E F
;F Gk
iC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Entity\EntitySortField.csù
rC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Entity\EntityRelationshipRefDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Entity) /
;/ 0
public 
sealed 
record $
EntityRelationshipRefDto -
(- .
int 
RelationshipId 
, 
int 
RelationshipTypeId 
, 
string 

RelationshipName 
, 
string 
#
RelationshipDisplayName "
," #
int 
RelatedEntityId 
, 
string		 
!
RelatedEntityTypeName		  
,		  !
string

 
(
RelatedEntityTypeDisplayName

 '
,

' (
IReadOnlyList 
< "
EntityPropertyValueDto (
>( )!
PreviewPropertyValues* ?
)? @
;@ Aª
uC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Entity\EntityRelationshipLinkInput.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Entity) /
;/ 0
public 
sealed 
record '
EntityRelationshipLinkInput 0
(0 1
int1 4
RelationshipTypeId5 G
,G H
intI L
TargetEntityIdM [
)[ \
;\ ]ù
pC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Entity\EntityPropertyValueDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Entity) /
;/ 0
public 
sealed 
record "
EntityPropertyValueDto +
(+ ,
int 

PropertyId 
, 
string 

PropertyName 
, 
string 

DisplayName 
, 
string 

DataType 
, 
object 

?
 
Value 
, 
bool		 

IsReadonly			 
)		 
;		 ≥
kC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Entity\EntityPagedResult.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Entity) /
;/ 0
public 
sealed 
record 
EntityPagedResult &
(& '
List 
< 	
EntityListItemDto	 
> 
Items !
,! "
int 
Total 
, 
int 
Skip 
, 
int 
Take 
) 
; ô
kC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Entity\EntityListItemDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Entity) /
;/ 0
public 
sealed 
record 
EntityListItemDto &
(& '
int 
Id 

,
 
int 
EntityTypeId 
, 
string 

EntityTypeName 
, 
string 
!
EntityTypeDisplayName  
,  !
List 
< 	"
EntityPropertyValueDto	 
>  
PropertyValues! /
)/ 0
;0 1„
oC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Entity\EntityFilterCondition.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Entity) /
;/ 0
public		 
sealed		 
record		 !
EntityFilterCondition		 *
(		* +
int		+ .

PropertyId		/ 9
,		9 :
string		; A
Op		B D
,		D E
string		F L
?		L M
Value		N S
)		S T
;		T U›
iC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Entity\EntityDetailDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Entity) /
;/ 0
public 
sealed 
record 
EntityDetailDto $
($ %
int 
Id 

,
 
int 
EntityTypeId 
, 
string 

EntityTypeName 
, 
string 
!
EntityTypeDisplayName  
,  !
bool 

IsArchived	 
, 
List		 
<		 	"
EntityPropertyValueDto			 
>		  
PropertyValues		! /
,		/ 0
List

 
<

 	$
EntityRelationshipRefDto

	 !
>

! "!
OutboundRelationships

# 8
,

8 9
List 
< 	$
EntityRelationshipRefDto	 !
>! " 
InboundRelationships# 7
)7 8
;8 9î
mC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Entity\CreateEntityRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Entity) /
;/ 0
public 
sealed 
record 
CreateEntityRequest (
(( )
int 
EntityTypeId 
, 
List 
< 	
PropertyValueInput	 
> 

Properties '
,' (
IReadOnlyList 
< '
EntityRelationshipLinkInput -
>- .
?. /
Links0 5
=6 7
null8 <
)< =
;= >ˇ
yC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\Entity\CreateEntityRelationshipRequest.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )
Entity) /
;/ 0
public 
sealed 
record +
CreateEntityRelationshipRequest 4
(4 5
int 
SourceEntityId 
, 
int 
TargetEntityId 
, 
int 
RelationshipTypeId 
) 
; ¬
uC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\EntityType\OutgoingRelationshipDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )

EntityType) 3
;3 4
public 
sealed 
record #
OutgoingRelationshipDto ,
(, -
int 
RelationshipTypeId 
, 
string 

Name 
, 
string 

DisplayName 
, 
int 
TargetEntityTypeId 
, 
string 
 
TargetEntityTypeName 
,  
string		 
'
TargetEntityTypeDisplayName		 &
,		& '
bool

 

IsRequired

	 
,

 
string 
#
RelationshipCardinality "
)" #
;# $¬
uC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\EntityType\IncomingRelationshipDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )

EntityType) 3
;3 4
public 
sealed 
record #
IncomingRelationshipDto ,
(, -
int 
RelationshipTypeId 
, 
string 

Name 
, 
string 

DisplayName 
, 
int 
SourceEntityTypeId 
, 
string		 
 
SourceEntityTypeName		 
,		  
string

 
'
SourceEntityTypeDisplayName

 &
,

& '
bool 

IsRequired	 
, 
string 
#
RelationshipCardinality "
)" #
;# $è
sC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\EntityType\EntityTypePropertyDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )

EntityType) 3
;3 4
public 
sealed 
record !
EntityTypePropertyDto *
(* +
int 

PropertyId 
, 
string 

Name 
, 
string 

DisplayName 
, 
string 

DataType 
, 
bool 

IsRequired	 
, 
bool		 

IsReadonly			 
,		 
IReadOnlyList

 
<

 
AllowedValueDto

 !
>

! "
AllowedValues

# 0
)

0 1
;

1 2è
kC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\EntityType\EntityTypeDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )

EntityType) 3
;3 4
public 
sealed 
record 
EntityTypeDto "
(" #
int 
Id 

,
 
string 

Name 
, 
string 

DisplayName 
, 
bool 
IsStandalone	 
, 
List 
< 	#
OutgoingRelationshipDto	  
>  !!
OutgoingRelationships" 7
,7 8
List		 
<		 	#
IncomingRelationshipDto			  
>		  !!
IncomingRelationships		" 7
,		7 8
List

 
<

 	!
EntityTypePropertyDto

	 
>

 

Properties

  *
)

* +
;

+ ,°
mC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\DTOs\EntityType\AllowedValueDto.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
DTOs$ (
.( )

EntityType) 3
;3 4
public 
sealed 
record 
AllowedValueDto $
($ %
string% +
Value, 1
,1 2
string3 9
DisplayName: E
)E F
;F G 
pC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Authorization\WorkspacePermissions.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
Authorization$ 1
;1 2
public 
static 
class  
WorkspacePermissions (
{ 
public 

const 
string 
ManageWsSettings (
=) *
$str+ ?
;? @
public 

const 
string 
AddWsMembers $
=% &
$str' 7
;7 8
public 

const 
string 
RemoveWsMembers '
=( )
$str* =
;= >
public 

const 
string 
AssignWsRoles %
=& '
$str( 9
;9 :
public		 

const		 
string		 
ManageWsRoles		 %
=		& '
$str		( 9
;		9 :
public

 

const

 
string

 
CreateEntities

 &
=

' (
$str

) :
;

: ;
public 

const 
string 
EditEntities $
=% &
$str' 6
;6 7
public 

const 
string  
EditArchivedEntities ,
=- .
$str/ G
;G H
public 

const 
string 
DeleteEntities &
=' (
$str) :
;: ;
public 

const 
string 
ViewEntities $
=% &
$str' 6
;6 7
public 

const 
string 
ViewAnalytics %
=& '
$str( 8
;8 9
public 

const 
string 
DeleteWorkspace '
=( )
$str* <
;< =
public 

static 
readonly 
IReadOnlyList (
<( )
string) /
>/ 0"
FullWorkspaceAuthority1 G
=H I
[ 
ManageWsSettings 
, 
AddWsMembers 
, 
RemoveWsMembers 
, 
AssignWsRoles 
, 
ManageWsRoles 
, 
CreateEntities 
, 
EditEntities 
,  
EditArchivedEntities 
, 
DeleteEntities 
, 
ViewEntities 
, 
ViewAnalytics 
, 
DeleteWorkspace 
]   
;   
}!! ‘)
sC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Authorization\RolePermissionEvaluator.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
Authorization$ 1
;1 2
public 
static 
class #
RolePermissionEvaluator +
{ 
public 

static 
bool 
HasPermission $
($ %
WorkspaceRole% 2
?2 3
role4 8
,8 9
string: @
permissionNameA O
)O P
=> 

role 
? 
. 
RolePermissions  
.  !
Any! $
($ %
rp% '
=>( *
string+ 1
.1 2
Equals2 8
(8 9
rp9 ;
.; <

Permission< F
?F G
.G H
NameH L
,L M
permissionNameN \
,\ ]
StringComparison^ n
.n o
Ordinalo v
)v w
)w x
==y {
true	| Ä
;
Ä Å
public

 

static

 
bool

 
HasPermission

 $
(

$ %
OrganizationRole

% 5
?

5 6
role

7 ;
,

; <
string

= C
permissionName

D R
)

R S
=> 

role 
? 
. 
RolePermissions  
.  !
Any! $
($ %
rp% '
=>( *
string+ 1
.1 2
Equals2 8
(8 9
rp9 ;
.; <

Permission< F
?F G
.G H
NameH L
,L M
permissionNameN \
,\ ]
StringComparison^ n
.n o
Ordinalo v
)v w
)w x
==y {
true	| Ä
;
Ä Å
public 

static 
bool 
HasAllPermissions (
(( )
WorkspaceRole) 6
?6 7
role8 <
,< =
IReadOnlyCollection> Q
<Q R
stringR X
>X Y
requiredPermissionsZ m
)m n
{ 
if 

( 
role 
? 
. 
RolePermissions !
is" $
null% )
||* ,
requiredPermissions- @
.@ A
CountA F
==G I
$numJ K
)K L
return 
false 
; 
var 
rolePermissions 
= 
role "
." #
RolePermissions# 2
. 
Select 
( 
rp 
=> 
rp 
. 

Permission '
?' (
.( )
Name) -
)- .
. 
Where 
( 
n 
=> 
! 
string 
.  
IsNullOrWhiteSpace  2
(2 3
n3 4
)4 5
)5 6
. 
Cast 
< 
string 
> 
( 
) 
. 
	ToHashSet 
( 
StringComparer %
.% &
Ordinal& -
)- .
;. /
return 
requiredPermissions "
." #
All# &
(& '
rolePermissions' 6
.6 7
Contains7 ?
)? @
;@ A
} 
public 

static 
bool 
HasAllPermissions (
(( )
OrganizationRole) 9
?9 :
role; ?
,? @
IReadOnlyCollectionA T
<T U
stringU [
>[ \
requiredPermissions] p
)p q
{ 
if 

( 
role 
? 
. 
RolePermissions !
is" $
null% )
||* ,
requiredPermissions- @
.@ A
CountA F
==G I
$numJ K
)K L
return 
false 
; 
var   
rolePermissions   
=   
role   "
.  " #
RolePermissions  # 2
.!! 
Select!! 
(!! 
rp!! 
=>!! 
rp!! 
.!! 

Permission!! '
?!!' (
.!!( )
Name!!) -
)!!- .
."" 
Where"" 
("" 
n"" 
=>"" 
!"" 
string"" 
.""  
IsNullOrWhiteSpace""  2
(""2 3
n""3 4
)""4 5
)""5 6
.## 
Cast## 
<## 
string## 
>## 
(## 
)## 
.$$ 
	ToHashSet$$ 
($$ 
StringComparer$$ %
.$$% &
Ordinal$$& -
)$$- .
;$$. /
return&& 
requiredPermissions&& "
.&&" #
All&&# &
(&&& '
rolePermissions&&' 6
.&&6 7
Contains&&7 ?
)&&? @
;&&@ A
}'' 
}(( Ñ
sC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Application\Authorization\OrganizationPermissions.cs
	namespace 	
Relativa
 
. 
Core 
. 
Application #
.# $
Authorization$ 1
;1 2
public 
static 
class #
OrganizationPermissions +
{ 
public 

const 
string 
ManageOrgSettings )
=* +
$str, A
;A B
public 

const 
string 
InviteToOrg #
=$ %
$str& 5
;5 6
public 

const 
string 
ManageJoinRequests *
=+ ,
$str- C
;C D
public 

const 
string 
RemoveOrgMembers (
=) *
$str+ ?
;? @
public		 

const		 
string		 
AssignOrgRoles		 &
=		' (
$str		) ;
;		; <
public

 

const

 
string

 
ManageOrgRoles

 &
=

' (
$str

) ;
;

; <
public 

const 
string 
CreateWorkspaces (
=) *
$str+ >
;> ?
public 

const 
string %
ManageOrgWorkspaceMembers 1
=2 3
$str4 R
;R S
public 

const 
string 
CreateOrgUsers &
=' (
$str) ;
;; <
public 

const 
string $
EditOtherOrgUsersProfile 0
=1 2
$str3 Q
;Q R
public 

const 
string 
DeleteOrgUsers &
=' (
$str) ;
;; <
} 