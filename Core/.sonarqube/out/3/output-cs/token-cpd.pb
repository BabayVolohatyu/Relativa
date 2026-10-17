¬
èC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Validators\UpdateUserSettingsRequestValidator.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Validators. 8
;8 9
public 
sealed 
partial 
class .
"UpdateUserSettingsRequestValidator >
:? @
AbstractValidatorA R
<R S%
UpdateUserSettingsRequestS l
>l m
{ 
public		 
.
"UpdateUserSettingsRequestValidator		 -
(		- .
)		. /
{

 
RuleFor 
( 
x 
=> 
x 
. 
Locale 
) 
. 
Cascade 
( 
CascadeMode  
.  !
Stop! %
)% &
. 
NotEmpty 
( 
) 
. 
WithErrorCode %
(% &
$str& @
)@ A
. 
Must 
( 
value 
=> 
	LocaleTag $
($ %
)% &
.& '
IsMatch' .
(. /
value/ 4
)4 5
)5 6
.6 7
WithErrorCode7 D
(D E
$strE ^
)^ _
;_ `
} 
[ 
GeneratedRegex 
( 
$str .
). /
]/ 0
private 
static 
partial 
Regex  
	LocaleTag! *
(* +
)+ ,
;, -
} «
åC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Validators\UpdateMyProfileRequestValidator.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Validators. 8
;8 9
public 
sealed 
class +
UpdateMyProfileRequestValidator 3
:4 5
AbstractValidator6 G
<G H"
UpdateMyProfileRequestH ^
>^ _
{ 
public 
+
UpdateMyProfileRequestValidator *
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
;  
RuleFor 
( 
x 
=> 
x 
. 
Phone 
) 
. 
Matches 
( 
$str )
)) *
. 
WithMessage 
( 
$str <
)< =
. 
WithErrorCode 
( 
$str *
)* +
. 
When 
( 
x 
=> 
! 
string 
. 
IsNullOrWhiteSpace 1
(1 2
x2 3
.3 4
Phone4 9
)9 :
): ;
;; <
RuleFor 
( 
x 
=> 
x 
. 
DateOfBirth "
)" #
. 
Must 
( 
d 
=> 
d 
! 
. 
Value 
.  
Year  $
>% &
$num' +
&&, .
d/ 0
.0 1
Value1 6
<7 8
DateOnly9 A
.A B
FromDateTimeB N
(N O
DateTimeO W
.W X
UtcNowX ^
.^ _
Date_ c
)c d
)d e
. 
WithMessage 
( 
$str =
)= >
. 
WithErrorCode 
( 
$str .
). /
. 
When 
( 
x 
=> 
x 
. 
DateOfBirth $
.$ %
HasValue% -
)- .
;. /
} 
} ‡
ãC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Validators\SupportContactRequestValidator.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Validators. 8
;8 9
public 
sealed 
class *
SupportContactRequestValidator 2
:3 4
AbstractValidator5 F
<F G!
SupportContactRequestG \
>\ ]
{ 
public 
*
SupportContactRequestValidator )
() *
)* +
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
. 
Matches 
( 
EmailValidation $
.$ %
Pattern% ,
), -
.- .
WithMessage. 9
(9 :
EmailValidation: I
.I J
MessageJ Q
)Q R
;R S
RuleFor 
( 
x 
=> 
x 
. 
Subject 
) 
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ :
): ;
. 
MaximumLength 
( 
$num 
) 
;  
RuleFor 
( 
x 
=> 
x 
. 
Message 
) 
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ :
): ;
. 
MaximumLength 
( 
$num 
)  
;  !
RuleFor 
( 
x 
=> 
x 
. 
Name 
) 
. 
MaximumLength 
( 
$num 
) 
;  
} 
} »
äC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Validators\ResetPasswordRequestValidator.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Validators. 8
;8 9
public 
sealed 
class )
ResetPasswordRequestValidator 1
:2 3
AbstractValidator4 E
<E F 
ResetPasswordRequestF Z
>Z [
{ 
public 
)
ResetPasswordRequestValidator (
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
 
Token
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
.9 :
WithErrorCode: G
(G H
$strH X
)X Y
;Y Z
RuleFor 
( 
x 
=> 
x 
. 
NewPassword "
)" #
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ ?
)? @
.@ A
WithErrorCodeA N
(N O
$strO b
)b c
. 
MinimumLength 
( 
$num 
) 
. 
WithMessage )
() *
$str* S
)S T
.T U
WithErrorCodeU b
(b c
$strc w
)w x
;x y
} 
} ï
ÖC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Validators\RegisterRequestValidator.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Validators. 8
;8 9
public 
sealed 
class $
RegisterRequestValidator ,
:- .
AbstractValidator/ @
<@ A
RegisterRequestDtoA S
>S T
{ 
public 
$
RegisterRequestValidator #
(# $
)$ %
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
.> ?
WithErrorCode? L
(L M
$strM b
)b c
. 
MaximumLength 
( 
$num 
) 
.  
WithErrorCode  -
(- .
$str. C
)C D
;D E
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
.= >
WithErrorCode> K
(K L
$strL `
)` a
. 
MaximumLength 
( 
$num 
) 
.  
WithErrorCode  -
(- .
$str. B
)B C
;C D
RuleFor 
( 
x 
=> 
x 
. 
Email 
) 
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ 8
)8 9
.9 :
WithErrorCode: G
(G H
$strH X
)X Y
. 
Matches 
( 
EmailValidation $
.$ %
Pattern% ,
), -
.- .
WithMessage. 9
(9 :
EmailValidation: I
.I J
MessageJ Q
)Q R
.R S
WithErrorCodeS `
(` a
$stra p
)p q
;q r
RuleFor 
( 
x 
=> 
x 
. 
Password 
)  
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ ;
); <
.< =
WithErrorCode= J
(J K
$strK ^
)^ _
. 
MinimumLength 
( 
$num 
) 
. 
WithMessage )
() *
$str* S
)S T
.T U
WithErrorCodeU b
(b c
$strc w
)w x
;x y
} 
} ï
ÇC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Validators\LoginRequestValidator.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Validators. 8
;8 9
public 
sealed 
class !
LoginRequestValidator )
:* +
AbstractValidator, =
<= >
LoginRequestDto> M
>M N
{ 
public 
!
LoginRequestValidator  
(  !
)! "
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
.9 :
WithErrorCode: G
(G H
$strH X
)X Y
. 
EmailAddress 
( 
) 
. 
WithMessage '
(' (
$str( L
)L M
.M N
WithErrorCodeN [
([ \
$str\ k
)k l
;l m
RuleFor 
( 
x 
=> 
x 
. 
Password 
)  
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ ;
); <
.< =
WithErrorCode= J
(J K
$strK ^
)^ _
;_ `
} 
} ¨

ãC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Validators\ForgotPasswordRequestValidator.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Validators. 8
;8 9
public 
sealed 
class *
ForgotPasswordRequestValidator 2
:3 4
AbstractValidator5 F
<F G!
ForgotPasswordRequestG \
>\ ]
{ 
public 
*
ForgotPasswordRequestValidator )
() *
)* +
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
.9 :
WithErrorCode: G
(G H
$strH X
)X Y
. 
EmailAddress 
( 
) 
. 
WithMessage '
(' (
$str( L
)L M
.M N
WithErrorCodeN [
([ \
$str\ k
)k l
;l m
} 
} ¢
|C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Validators\EmailValidation.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Validators. 8
;8 9
public 
static 
class 
EmailValidation #
{ 
public 

const 
string 
Pattern 
=  !
$str" f
;f g
public 

const 
string 
Message 
=  !
$str" F
;F G
} Á
~C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Services\UserSettingsService.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
Services. 6
;6 7
public		 
sealed		 
class		 
UserSettingsService		 '
(		' (#
IUserSettingsRepository

 "
userSettingsRepository

 2
,

2 3

IValidator 
< %
UpdateUserSettingsRequest (
>( )#
updateSettingsValidator* A
)A B
:C D 
IUserSettingsServiceE Y
{ 
public 

async 
Task 
< 
UserSettingsDto %
>% &
GetMySettingsAsync' 9
(9 :
int: =
userId> D
,D E
CancellationTokenF W
ctX Z
=[ \
default] d
)d e
{ 
var 
settings 
= 
await $
GetOrCreateSettingsAsync 5
(5 6
userId6 <
,< =
ct> @
)@ A
;A B
return 
new 
UserSettingsDto "
(" #
settings# +
.+ ,
Locale, 2
)2 3
;3 4
} 
public 

async 
Task 
< 
UserSettingsDto %
>% &!
UpdateMySettingsAsync' <
(< =
int= @
userIdA G
,G H%
UpdateUserSettingsRequestI b
requestc j
,j k
CancellationTokenl }
ct	~ Ä
=
Å Ç
default
É ä
)
ä ã
{ 
await #
updateSettingsValidator %
.% &!
ValidateAndThrowAsync& ;
(; <
request< C
,C D
ctE G
)G H
;H I
var 
settings 
= 
await $
GetOrCreateSettingsAsync 5
(5 6
userId6 <
,< =
ct> @
)@ A
;A B
settings 
. 
Locale 
= 
request !
.! "
Locale" (
;( )
await "
userSettingsRepository $
.$ %
UpdateAsync% 0
(0 1
settings1 9
,9 :
ct; =
)= >
;> ?
return 
new 
UserSettingsDto "
(" #
settings# +
.+ ,
Locale, 2
)2 3
;3 4
} 
private 
async 
Task 
< 
UserSettings #
># $$
GetOrCreateSettingsAsync% =
(= >
int> A
userIdB H
,H I
CancellationTokenJ [
ct\ ^
)^ _
{ 
var   
settings   
=   
await   "
userSettingsRepository   3
.  3 4
GetByUserIdAsync  4 D
(  D E
userId  E K
,  K L
ct  M O
)  O P
;  P Q
if!! 

(!! 
settings!! 
is!! 
not!! 
null!!  
)!!  !
return!!" (
settings!!) 1
;!!1 2
settings## 
=## 
new## 
UserSettings## #
{##$ %
UserId##& ,
=##- .
userId##/ 5
}##6 7
;##7 8
await$$ "
userSettingsRepository$$ $
.$$$ %
AddAsync$$% -
($$- .
settings$$. 6
,$$6 7
ct$$8 :
)$$: ;
;$$; <
return%% 
settings%% 
;%% 
}&& 
}'' ˚°
ÇC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Services\UserProvisioningService.cs
	namespace		 	
Relativa		
 
.		 
Authentication		 !
.		! "
Application		" -
.		- .
Services		. 6
;		6 7
public 
sealed 
class #
UserProvisioningService +
(+ ,
IUserRepository 
userRepository "
," #
IPasswordHasher 
passwordHasher "
," #

IValidator 
< 
RegisterRequestDto !
>! "
registerValidator# 4
,4 5
IOutboxWriter 
? 
auditOutboxWriter $
=% &
null' +
)+ ,
:- .$
IUserProvisioningService/ G
{ 
public 

async 
Task 
< 
RegisterResponseDto )
>) *
CreateUserAsync+ :
(: ;
RegisterRequestDto; M
requestN U
,U V
intW Z
?Z [
auditActorUserId\ l
,l m
CancellationTokenn 
ct
Ä Ç
)
Ç É
{ 
await 
registerValidator 
.  !
ValidateAndThrowAsync  5
(5 6
request6 =
,= >
ct? A
)A B
;B C
var 
email 
= 
EmailNormalizer #
.# $
	Normalize$ -
(- .
request. 5
.5 6
Email6 ;
); <
;< =
if 

( 
await 
userRepository  
.  !
ExistsAsync! ,
(, -
email- 2
,2 3
ct4 6
)6 7
)7 8
throw 
new 
AuthException #
(# $
$str$ :
,: ;
$num< ?
,? @
$strA i
)i j
;j k
var 
user 
= 
new 
User 
{ 	
	FirstName 
= 
request 
.  
	FirstName  )
,) *
LastName 
= 
request 
. 
LastName '
,' (
Email 
= 
email 
, 
Phone 
= 
string 
. 
IsNullOrWhiteSpace -
(- .
request. 5
.5 6
Phone6 ;
); <
?= >
null? C
:D E
requestF M
.M N
PhoneN S
.S T
TrimT X
(X Y
)Y Z
,Z [
DateOfBirth 
= 
request !
.! "
DateOfBirth" -
,- .
Password   
=   
passwordHasher   %
.  % &
Hash  & *
(  * +
request  + 2
.  2 3
Password  3 ;
)  ; <
,  < =
	CreatedAt!! 
=!! 
DateTime!!  
.!!  !
UtcNow!!! '
,!!' (

IsArchived"" 
="" 
false"" 
,"" 
EmailVerified## 
=## 
auditActorUserId## ,
.##, -
HasValue##- 5
,##5 6
Settings$$ 
=$$ 
new$$ 
UserSettings$$ '
{%% 
Locale&& 
=&& 
string&& 
.&&  
IsNullOrWhiteSpace&&  2
(&&2 3
request&&3 :
.&&: ;
Locale&&; A
)&&A B
?&&C D
$str&&E I
:&&J K
request&&L S
.&&S T
Locale&&T Z
}'' 
}(( 	
;((	 

await** 
userRepository** 
.** 
AddAsync** %
(**% &
user**& *
,*** +
ct**, .
)**. /
;**/ 0
var,, 
actorId,, 
=,, 
auditActorUserId,, &
??,,' )
user,,* .
.,,. /
Id,,/ 1
;,,1 2
var-- 
action-- 
=-- 
auditActorUserId-- %
.--% &
HasValue--& .
?--/ 0
$str--1 C
:--D E
$str--F W
;--W X
if// 

(// 
auditOutboxWriter// 
is//  
not//! $
null//% )
)//) *
{00 	
await11 
auditOutboxWriter11 #
.11# $
EnqueueAuditAsync11$ 5
(115 6
new22 
AuditEventContract22 &
(22& '
EventId33 
:33 
Guid33 !
.33! "
NewGuid33" )
(33) *
)33* +
,33+ ,
SchemaVersion44 !
:44! "
$num44# $
,44$ %
OccurredAtUtc55 !
:55! "
DateTimeOffset55# 1
.551 2
UtcNow552 8
,558 9
SourceService66 !
:66! "
$str66# 3
,663 4
ActorUserId77 
:77  
actorId77! (
,77( )

AuditScope88 
:88 
AuditRouting88  ,
.88, -
	ScopeUser88- 6
,886 7
TargetId99 
:99 
user99 "
.99" #
Id99# %
,99% &
Action:: 
::: 
action:: "
,::" #
	FieldName;; 
:;; 
null;; #
,;;# $

EntityType<< 
:<< 
null<<  $
,<<$ %
OldValueJson==  
:==  !
null==" &
,==& '
NewValueJson>>  
:>>  !
System>>" (
.>>( )
Text>>) -
.>>- .
Json>>. 2
.>>2 3
JsonSerializer>>3 A
.>>A B
	Serialize>>B K
(>>K L
new>>L O
{?? 
user@@ 
.@@ 
Id@@ 
,@@  
userAA 
.AA 
EmailAA "
,AA" #
userBB 
.BB 
	FirstNameBB &
,BB& '
userCC 
.CC 
LastNameCC %
}DD 
)DD 
)DD 
,DD 
ctEE 
)EE 
;EE 
}FF 	
returnHH 
newHH 
RegisterResponseDtoHH &
(HH& '
userII 
.II 
IdII 
,II 
userJJ 
.JJ 
EmailJJ 
,JJ 
userKK 
.KK 
	FirstNameKK 
,KK 
userLL 
.LL 
LastNameLL 
)LL 
;LL 
}MM 
publicOO 

asyncOO 
TaskOO 
<OO 
UserOO 
>OO #
CreateExternalUserAsyncOO 3
(OO3 4
ExternalIdentityOO4 D
identityOOE M
,OOM N
CancellationTokenOOO `
ctOOa c
)OOc d
{PP 
varQQ 
nowQQ 
=QQ 
DateTimeQQ 
.QQ 
UtcNowQQ !
;QQ! "
varRR 
emailRR 
=RR 
EmailNormalizerRR #
.RR# $
	NormalizeRR$ -
(RR- .
identityRR. 6
.RR6 7
EmailRR7 <
)RR< =
;RR= >
varTT 
	localPartTT 
=TT 
emailTT 
.TT 
SplitTT #
(TT# $
$charTT$ '
)TT' (
[TT( )
$numTT) *
]TT* +
;TT+ ,
varUU 
	firstNameUU 
=UU 
stringUU 
.UU 
IsNullOrWhiteSpaceUU 1
(UU1 2
identityUU2 :
.UU: ;
	FirstNameUU; D
)UUD E
?VV 
(VV 
stringVV 
.VV 
IsNullOrEmptyVV #
(VV# $
	localPartVV$ -
)VV- .
?VV/ 0
$strVV1 7
:VV8 9
	localPartVV: C
)VVC D
:WW 
identityWW 
.WW 
	FirstNameWW  
.WW  !
TrimWW! %
(WW% &
)WW& '
;WW' (
varXX 
lastNameXX 
=XX 
stringXX 
.XX 
IsNullOrWhiteSpaceXX 0
(XX0 1
identityXX1 9
.XX9 :
LastNameXX: B
)XXB C
?YY 
stringYY 
.YY 
EmptyYY 
:ZZ 
identityZZ 
.ZZ 
LastNameZZ 
.ZZ  
TrimZZ  $
(ZZ$ %
)ZZ% &
;ZZ& '
var\\ 
user\\ 
=\\ 
new\\ 
User\\ 
{]] 	
	FirstName^^ 
=^^ 
	firstName^^ !
,^^! "
LastName__ 
=__ 
lastName__ 
,__  
Email`` 
=`` 
email`` 
,`` 
Passwordaa 
=aa 
nullaa 
,aa 
	CreatedAtbb 
=bb 
nowbb 
,bb 

IsArchivedcc 
=cc 
falsecc 
,cc 
EmailVerifieddd 
=dd 
truedd  
,dd  !
Settingsee 
=ee 
newee 
UserSettingsee '
(ee' (
)ee( )
,ee) *
ExternalLoginsff 
=ff 
{gg 
newhh 
UserExternalLoginhh %
{ii 
Providerjj 
=jj 
identityjj '
.jj' (
Providerjj( 0
,jj0 1
Subjectkk 
=kk 
identitykk &
.kk& '
Subjectkk' .
,kk. /
	CreatedAtll 
=ll 
nowll  #
}mm 
}nn 
}oo 	
;oo	 

awaitqq 
userRepositoryqq 
.qq 
AddAsyncqq %
(qq% &
userqq& *
,qq* +
ctqq, .
)qq. /
;qq/ 0
ifss 

(ss 
auditOutboxWriterss 
isss  
notss! $
nullss% )
)ss) *
{tt 	
awaituu 
auditOutboxWriteruu #
.uu# $
EnqueueAuditAsyncuu$ 5
(uu5 6
newvv 
AuditEventContractvv &
(vv& '
EventIdww 
:ww 
Guidww !
.ww! "
NewGuidww" )
(ww) *
)ww* +
,ww+ ,
SchemaVersionxx !
:xx! "
$numxx# $
,xx$ %
OccurredAtUtcyy !
:yy! "
DateTimeOffsetyy# 1
.yy1 2
UtcNowyy2 8
,yy8 9
SourceServicezz !
:zz! "
$strzz# 3
,zz3 4
ActorUserId{{ 
:{{  
user{{! %
.{{% &
Id{{& (
,{{( )

AuditScope|| 
:|| 
AuditRouting||  ,
.||, -
	ScopeUser||- 6
,||6 7
TargetId}} 
:}} 
user}} "
.}}" #
Id}}# %
,}}% &
Action~~ 
:~~ 
$str~~ -
,~~- .
	FieldName 
: 
null #
,# $

EntityType
ÄÄ 
:
ÄÄ 
null
ÄÄ  $
,
ÄÄ$ %
OldValueJson
ÅÅ  
:
ÅÅ  !
null
ÅÅ" &
,
ÅÅ& '
NewValueJson
ÇÇ  
:
ÇÇ  !
System
ÇÇ" (
.
ÇÇ( )
Text
ÇÇ) -
.
ÇÇ- .
Json
ÇÇ. 2
.
ÇÇ2 3
JsonSerializer
ÇÇ3 A
.
ÇÇA B
	Serialize
ÇÇB K
(
ÇÇK L
new
ÇÇL O
{
ÉÉ 
user
ÑÑ 
.
ÑÑ 
Id
ÑÑ 
,
ÑÑ  
user
ÖÖ 
.
ÖÖ 
Email
ÖÖ "
,
ÖÖ" #
user
ÜÜ 
.
ÜÜ 
	FirstName
ÜÜ &
,
ÜÜ& '
user
áá 
.
áá 
LastName
áá %
,
áá% &
identity
àà  
.
àà  !
Provider
àà! )
}
ââ 
)
ââ 
)
ââ 
,
ââ 
ct
ää 
)
ää 
;
ää 
}
ãã 	
return
çç 
user
çç 
;
çç 
}
éé 
public
êê 

async
êê 
Task
êê 
<
êê 
UserProfileDto
êê $
>
êê$ %$
UpdateUserProfileAsync
êê& <
(
êê< =
int
êê= @
targetUserId
êêA M
,
êêM N
string
êêO U
	firstName
êêV _
,
êê_ `
string
êêa g
lastName
êêh p
,
êêp q
int
êêr u
auditActorUserIdêêv Ü
,êêÜ á!
CancellationTokenêêà ô
ctêêö ú
)êêú ù
{
ëë 
var
íí 
user
íí 
=
íí 
await
íí 
userRepository
íí '
.
íí' (
GetByIdAsync
íí( 4
(
íí4 5
targetUserId
íí5 A
,
ííA B
ct
ííC E
)
ííE F
??
ìì 
throw
ìì 
new
ìì 
AuthException
ìì &
(
ìì& '
$str
ìì' 7
,
ìì7 8
$num
ìì9 <
,
ìì< =
$str
ìì> O
)
ììO P
;
ììP Q
var
ïï 
oldSnapshot
ïï 
=
ïï 
new
ïï 
{
ïï 
user
ïï  $
.
ïï$ %
	FirstName
ïï% .
,
ïï. /
user
ïï0 4
.
ïï4 5
LastName
ïï5 =
}
ïï> ?
;
ïï? @
user
ññ 
.
ññ 
	FirstName
ññ 
=
ññ 
	firstName
ññ "
;
ññ" #
user
óó 
.
óó 
LastName
óó 
=
óó 
lastName
óó  
;
óó  !
await
òò 
userRepository
òò 
.
òò 
UpdateAsync
òò (
(
òò( )
user
òò) -
,
òò- .
ct
òò/ 1
)
òò1 2
;
òò2 3
if
öö 

(
öö 
auditOutboxWriter
öö 
is
öö  
not
öö! $
null
öö% )
)
öö) *
{
õõ 	
await
úú 
auditOutboxWriter
úú #
.
úú# $
EnqueueAuditAsync
úú$ 5
(
úú5 6
new
ùù  
AuditEventContract
ùù &
(
ùù& '
EventId
ûû 
:
ûû 
Guid
ûû !
.
ûû! "
NewGuid
ûû" )
(
ûû) *
)
ûû* +
,
ûû+ ,
SchemaVersion
üü !
:
üü! "
$num
üü# $
,
üü$ %
OccurredAtUtc
†† !
:
††! "
DateTimeOffset
††# 1
.
††1 2
UtcNow
††2 8
,
††8 9
SourceService
°° !
:
°°! "
$str
°°# 3
,
°°3 4
ActorUserId
¢¢ 
:
¢¢  
auditActorUserId
¢¢! 1
,
¢¢1 2

AuditScope
££ 
:
££ 
AuditRouting
££  ,
.
££, -
	ScopeUser
££- 6
,
££6 7
TargetId
§§ 
:
§§ 
targetUserId
§§ *
,
§§* +
Action
•• 
:
•• 
$str
•• 2
,
••2 3
	FieldName
¶¶ 
:
¶¶ 
null
¶¶ #
,
¶¶# $

EntityType
ßß 
:
ßß 
null
ßß  $
,
ßß$ %
OldValueJson
®®  
:
®®  !
System
®®" (
.
®®( )
Text
®®) -
.
®®- .
Json
®®. 2
.
®®2 3
JsonSerializer
®®3 A
.
®®A B
	Serialize
®®B K
(
®®K L
oldSnapshot
®®L W
)
®®W X
,
®®X Y
NewValueJson
©©  
:
©©  !
System
©©" (
.
©©( )
Text
©©) -
.
©©- .
Json
©©. 2
.
©©2 3
JsonSerializer
©©3 A
.
©©A B
	Serialize
©©B K
(
©©K L
new
©©L O
{
©©P Q
	firstName
©©R [
,
©©[ \
lastName
©©] e
}
©©f g
)
©©g h
)
©©h i
,
©©i j
ct
™™ 
)
™™ 
;
™™ 
}
´´ 	
return
≠≠ 
new
≠≠ 
UserProfileDto
≠≠ !
(
≠≠! "
user
ÆÆ 
.
ÆÆ 
Id
ÆÆ 
,
ÆÆ 
user
ÆÆ 
.
ÆÆ 
Email
ÆÆ 
,
ÆÆ  
user
ÆÆ! %
.
ÆÆ% &
	FirstName
ÆÆ& /
,
ÆÆ/ 0
user
ÆÆ1 5
.
ÆÆ5 6
LastName
ÆÆ6 >
,
ÆÆ> ?
user
ÆÆ@ D
.
ÆÆD E
TwoFactorEnabled
ÆÆE U
,
ÆÆU V
user
ØØ 
.
ØØ 
Phone
ØØ 
,
ØØ 
user
ØØ 
.
ØØ 
DateOfBirth
ØØ (
,
ØØ( )
user
∞∞ 
.
∞∞ 
ExternalLogins
∞∞ 
.
∞∞  
Select
∞∞  &
(
∞∞& '
l
∞∞' (
=>
∞∞) +
l
∞∞, -
.
∞∞- .
Provider
∞∞. 6
)
∞∞6 7
.
∞∞7 8
Distinct
∞∞8 @
(
∞∞@ A
)
∞∞A B
.
∞∞B C
ToList
∞∞C I
(
∞∞I J
)
∞∞J K
,
∞∞K L
!
±± 
string
±± 
.
±± 
IsNullOrEmpty
±± !
(
±±! "
user
±±" &
.
±±& '
Password
±±' /
)
±±/ 0
)
±±0 1
;
±±1 2
}
≤≤ 
public
¥¥ 

async
¥¥ 
Task
¥¥ 
ArchiveUserAsync
¥¥ &
(
¥¥& '
int
¥¥' *
targetUserId
¥¥+ 7
,
¥¥7 8
int
¥¥9 <
auditActorUserId
¥¥= M
,
¥¥M N
CancellationToken
¥¥O `
ct
¥¥a c
)
¥¥c d
{
µµ 
var
∂∂ 
user
∂∂ 
=
∂∂ 
await
∂∂ 
userRepository
∂∂ '
.
∂∂' (
GetByIdAsync
∂∂( 4
(
∂∂4 5
targetUserId
∂∂5 A
,
∂∂A B
ct
∂∂C E
)
∂∂E F
??
∑∑ 
throw
∑∑ 
new
∑∑ 
AuthException
∑∑ &
(
∑∑& '
$str
∑∑' 7
,
∑∑7 8
$num
∑∑9 <
,
∑∑< =
$str
∑∑> O
)
∑∑O P
;
∑∑P Q
user
ππ 
.
ππ 

IsArchived
ππ 
=
ππ 
true
ππ 
;
ππ 
await
∫∫ 
userRepository
∫∫ 
.
∫∫ 
UpdateAsync
∫∫ (
(
∫∫( )
user
∫∫) -
,
∫∫- .
ct
∫∫/ 1
)
∫∫1 2
;
∫∫2 3
await
ªª 
userRepository
ªª 
.
ªª -
ReleaseExternalIdentifiersAsync
ªª <
(
ªª< =
targetUserId
ªª= I
,
ªªI J
ct
ªªK M
)
ªªM N
;
ªªN O
if
ΩΩ 

(
ΩΩ 
auditOutboxWriter
ΩΩ 
is
ΩΩ  
not
ΩΩ! $
null
ΩΩ% )
)
ΩΩ) *
{
ææ 	
await
øø 
auditOutboxWriter
øø #
.
øø# $
EnqueueAuditAsync
øø$ 5
(
øø5 6
new
¿¿  
AuditEventContract
¿¿ &
(
¿¿& '
EventId
¡¡ 
:
¡¡ 
Guid
¡¡ !
.
¡¡! "
NewGuid
¡¡" )
(
¡¡) *
)
¡¡* +
,
¡¡+ ,
SchemaVersion
¬¬ !
:
¬¬! "
$num
¬¬# $
,
¬¬$ %
OccurredAtUtc
√√ !
:
√√! "
DateTimeOffset
√√# 1
.
√√1 2
UtcNow
√√2 8
,
√√8 9
SourceService
ƒƒ !
:
ƒƒ! "
$str
ƒƒ# 3
,
ƒƒ3 4
ActorUserId
≈≈ 
:
≈≈  
auditActorUserId
≈≈! 1
,
≈≈1 2

AuditScope
∆∆ 
:
∆∆ 
AuditRouting
∆∆  ,
.
∆∆, -
	ScopeUser
∆∆- 6
,
∆∆6 7
TargetId
«« 
:
«« 
targetUserId
«« *
,
««* +
Action
»» 
:
»» 
$str
»» +
,
»»+ ,
	FieldName
…… 
:
…… 
null
…… #
,
……# $

EntityType
   
:
   
null
    $
,
  $ %
OldValueJson
ÀÀ  
:
ÀÀ  !
null
ÀÀ" &
,
ÀÀ& '
NewValueJson
ÃÃ  
:
ÃÃ  !
System
ÃÃ" (
.
ÃÃ( )
Text
ÃÃ) -
.
ÃÃ- .
Json
ÃÃ. 2
.
ÃÃ2 3
JsonSerializer
ÃÃ3 A
.
ÃÃA B
	Serialize
ÃÃB K
(
ÃÃK L
new
ÃÃL O
{
ÃÃP Q
user
ÃÃR V
.
ÃÃV W
Id
ÃÃW Y
,
ÃÃY Z
user
ÃÃ[ _
.
ÃÃ_ `
Email
ÃÃ` e
}
ÃÃf g
)
ÃÃg h
)
ÃÃh i
,
ÃÃi j
ct
ÕÕ 
)
ÕÕ 
;
ÕÕ 
}
ŒŒ 	
}
œœ 
}–– ¨•
{C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Services\TwoFactorService.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
Services. 6
;6 7
public 
sealed 
class 
TwoFactorService $
($ %
IUserRepository 
userRepository "
," #
ITotpProvider 
totp 
, 
IOptions 
< 
TwoFactorOptions 
> 
options &
)& '
:( )
ITwoFactorService* ;
{ 
private 
readonly 
TwoFactorOptions %
_opts& +
=, -
options. 5
.5 6
Value6 ;
;; <
public 

async 
Task 
< 
TwoFactorStatusDto (
>( )
GetStatusAsync* 8
(8 9
int9 <
userId= C
,C D
CancellationTokenE V
ctW Y
=Z [
default\ c
)c d
{ 
var 
user 
= 
await 
Require  
(  !
userId! '
,' (
ct) +
)+ ,
;, -
return 
new 
TwoFactorStatusDto %
(% &
user& *
.* +
TwoFactorEnabled+ ;
); <
;< =
} 
public 

async 
Task 
< 
TwoFactorSetupDto '
>' (
StartSetupAsync) 8
(8 9
int9 <
userId= C
,C D
CancellationTokenE V
ctW Y
=Z [
default\ c
)c d
{ 
var 
user 
= 
await 
Require  
(  !
userId! '
,' (
ct) +
)+ ,
;, -
if 

( 
user 
. 
TwoFactorEnabled !
)! "
{ 	
throw 
new 
AuthException #
(# $
$str$ @
,@ A
$numB E
,E F
$strG v
)v w
;w x
}   	
var"" 
secret"" 
="" 
totp"" 
."" 
GenerateSecret"" (
(""( )
)"") *
;""* +
user## 
.## 
TwoFactorSecret## 
=## 
secret## %
;##% &
await$$ 
userRepository$$ 
.$$ 
UpdateAsync$$ (
($$( )
user$$) -
,$$- .
ct$$/ 1
)$$1 2
;$$2 3
return&& 
new&& 
TwoFactorSetupDto&& $
(&&$ %
secret&&% +
,&&+ ,
totp&&- 1
.&&1 2
BuildOtpAuthUri&&2 A
(&&A B
secret&&B H
,&&H I
user&&J N
.&&N O
Email&&O T
,&&T U
_opts&&V [
.&&[ \
Issuer&&\ b
)&&b c
)&&c d
;&&d e
}'' 
public)) 

async)) 
Task)) 
<)) $
TwoFactorEnableResultDto)) .
>)). /
EnableAsync))0 ;
()); <
int))< ?
userId))@ F
,))F G
string))H N
code))O S
,))S T
CancellationToken))U f
ct))g i
=))j k
default))l s
)))s t
{** 
var++ 
user++ 
=++ 
await++ 
Require++  
(++  !
userId++! '
,++' (
ct++) +
)+++ ,
;++, -
if,, 

(,, 
user,, 
.,, 
TwoFactorEnabled,, !
),,! "
{-- 	
throw.. 
new.. 
AuthException.. #
(..# $
$str..$ @
,..@ A
$num..B E
,..E F
$str..G v
)..v w
;..w x
}// 	
if11 

(11 
string11 
.11 
IsNullOrWhiteSpace11 %
(11% &
user11& *
.11* +
TwoFactorSecret11+ :
)11: ;
||11< >
!11? @
totp11@ D
.11D E

VerifyCode11E O
(11O P
user11P T
.11T U
TwoFactorSecret11U d
,11d e
code11f j
)11j k
)11k l
{22 	
throw33 
new33 )
InvalidTwoFactorCodeException33 3
(333 4
)334 5
;335 6
}44 	
var66 

masterCode66 
=66 
GenerateCode66 %
(66% &
_opts66& +
.66+ ,
MasterCodeLength66, <
)66< =
;66= >
user77 
.77 
TwoFactorEnabled77 
=77 
true77  $
;77$ %
user88 
.88 #
TwoFactorMasterCodeHash88 $
=88% &
Hash88' +
(88+ ,

masterCode88, 6
)886 7
;887 8
await99 
userRepository99 
.99 
UpdateAsync99 (
(99( )
user99) -
,99- .
ct99/ 1
)991 2
;992 3
return;; 
new;; $
TwoFactorEnableResultDto;; +
(;;+ ,
await;;, 1'
GenerateAndStoreBackupCodes;;2 M
(;;M N
userId;;N T
,;;T U
ct;;V X
);;X Y
,;;Y Z

masterCode;;[ e
);;e f
;;;f g
}<< 
public>> 

async>> 
Task>> 
DisableAsync>> "
(>>" #
int>># &
userId>>' -
,>>- .
string>>/ 5
code>>6 :
,>>: ;
CancellationToken>>< M
ct>>N P
=>>Q R
default>>S Z
)>>Z [
{?? 
var@@ 
user@@ 
=@@ 
await@@ 
Require@@  
(@@  !
userId@@! '
,@@' (
ct@@) +
)@@+ ,
;@@, -
ifAA 

(AA 
!AA 
userAA 
.AA 
TwoFactorEnabledAA "
)AA" #
{BB 	
returnCC 
;CC 
}DD 	
ifFF 

(FF 
!FF 
awaitFF 
VerifyAsyncFF 
(FF 
userFF #
,FF# $
codeFF% )
,FF) *
ctFF+ -
)FF- .
)FF. /
{GG 	
throwHH 
newHH )
InvalidTwoFactorCodeExceptionHH 3
(HH3 4
)HH4 5
;HH5 6
}II 	
userKK 
.KK 
TwoFactorEnabledKK 
=KK 
falseKK  %
;KK% &
userLL 
.LL 
TwoFactorSecretLL 
=LL 
nullLL #
;LL# $
userMM 
.MM #
TwoFactorMasterCodeHashMM $
=MM% &
nullMM' +
;MM+ ,
awaitNN 
userRepositoryNN 
.NN 
UpdateAsyncNN (
(NN( )
userNN) -
,NN- .
ctNN/ 1
)NN1 2
;NN2 3
awaitOO 
userRepositoryOO 
.OO #
ReplaceBackupCodesAsyncOO 4
(OO4 5
userIdOO5 ;
,OO; <
[OO= >
]OO> ?
,OO? @
ctOOA C
)OOC D
;OOD E
}PP 
publicRR 

asyncRR 
TaskRR 
<RR #
TwoFactorBackupCodesDtoRR -
>RR- .&
RegenerateBackupCodesAsyncRR/ I
(RRI J
intRRJ M
userIdRRN T
,RRT U
stringRRV \
codeRR] a
,RRa b
CancellationTokenRRc t
ctRRu w
=RRx y
default	RRz Å
)
RRÅ Ç
{SS 
varTT 
userTT 
=TT 
awaitTT 
RequireTT  
(TT  !
userIdTT! '
,TT' (
ctTT) +
)TT+ ,
;TT, -
ifUU 

(UU 
!UU 
userUU 
.UU 
TwoFactorEnabledUU "
)UU" #
{VV 	
throwWW 
newWW 
AuthExceptionWW #
(WW# $
$strWW$ <
,WW< =
$numWW> A
,WWA B
$strWWC n
)WWn o
;WWo p
}XX 	
ifZZ 

(ZZ 
!ZZ 
awaitZZ 
VerifyAsyncZZ 
(ZZ 
userZZ #
,ZZ# $
codeZZ% )
,ZZ) *
ctZZ+ -
)ZZ- .
)ZZ. /
{[[ 	
throw\\ 
new\\ )
InvalidTwoFactorCodeException\\ 3
(\\3 4
)\\4 5
;\\5 6
}]] 	
return__ 
new__ #
TwoFactorBackupCodesDto__ *
(__* +
await__+ 0'
GenerateAndStoreBackupCodes__1 L
(__L M
userId__M S
,__S T
ct__U W
)__W X
)__X Y
;__Y Z
}`` 
publicbb 

asyncbb 
Taskbb 
<bb "
TwoFactorMasterCodeDtobb ,
>bb, -%
RegenerateMasterCodeAsyncbb. G
(bbG H
intbbH K
userIdbbL R
,bbR S
stringbbT Z
codebb[ _
,bb_ `
CancellationTokenbba r
ctbbs u
=bbv w
defaultbbx 
)	bb Ä
{cc 
vardd 
userdd 
=dd 
awaitdd 
Requiredd  
(dd  !
userIddd! '
,dd' (
ctdd) +
)dd+ ,
;dd, -
ifee 

(ee 
!ee 
useree 
.ee 
TwoFactorEnabledee "
)ee" #
{ff 	
throwgg 
newgg 
AuthExceptiongg #
(gg# $
$strgg$ <
,gg< =
$numgg> A
,ggA B
$strggC n
)ggn o
;ggo p
}hh 	
ifjj 

(jj 
!jj 
awaitjj 
VerifyAsyncjj 
(jj 
userjj #
,jj# $
codejj% )
,jj) *
ctjj+ -
)jj- .
)jj. /
{kk 	
throwll 
newll )
InvalidTwoFactorCodeExceptionll 3
(ll3 4
)ll4 5
;ll5 6
}mm 	
varoo 

masterCodeoo 
=oo 
GenerateCodeoo %
(oo% &
_optsoo& +
.oo+ ,
MasterCodeLengthoo, <
)oo< =
;oo= >
userpp 
.pp #
TwoFactorMasterCodeHashpp $
=pp% &
Hashpp' +
(pp+ ,

masterCodepp, 6
)pp6 7
;pp7 8
awaitqq 
userRepositoryqq 
.qq 
UpdateAsyncqq (
(qq( )
userqq) -
,qq- .
ctqq/ 1
)qq1 2
;qq2 3
returnss 
newss "
TwoFactorMasterCodeDtoss )
(ss) *

masterCodess* 4
)ss4 5
;ss5 6
}tt 
publicvv 

asyncvv 
Taskvv 
<vv 
boolvv 
>vv 
VerifyAsyncvv '
(vv' (
Uservv( ,
uservv- 1
,vv1 2
stringvv3 9
codevv: >
,vv> ?
CancellationTokenvv@ Q
ctvvR T
=vvU V
defaultvvW ^
)vv^ _
{ww 
ifxx 

(xx 
!xx 
stringxx 
.xx 
IsNullOrEmptyxx !
(xx! "
userxx" &
.xx& '
TwoFactorSecretxx' 6
)xx6 7
&&xx8 :
totpxx; ?
.xx? @

VerifyCodexx@ J
(xxJ K
userxxK O
.xxO P
TwoFactorSecretxxP _
,xx_ `
codexxa e
)xxe f
)xxf g
{yy 	
returnzz 
truezz 
;zz 
}{{ 	
var}} 
hash}} 
=}} 
Hash}} 
(}} 
NormalizeBackupCode}} +
(}}+ ,
code}}, 0
)}}0 1
)}}1 2
;}}2 3
if 

( 
! 
string 
. 
IsNullOrEmpty !
(! "
user" &
.& '#
TwoFactorMasterCodeHash' >
)> ?
&&@ B#
CryptographicOperationsC Z
.Z [
FixedTimeEquals[ j
(j k
Encoding
ÄÄ 
.
ÄÄ 
UTF8
ÄÄ 
.
ÄÄ 
GetBytes
ÄÄ "
(
ÄÄ" #
user
ÄÄ# '
.
ÄÄ' (%
TwoFactorMasterCodeHash
ÄÄ( ?
)
ÄÄ? @
,
ÄÄ@ A
Encoding
ÄÄB J
.
ÄÄJ K
UTF8
ÄÄK O
.
ÄÄO P
GetBytes
ÄÄP X
(
ÄÄX Y
hash
ÄÄY ]
)
ÄÄ] ^
)
ÄÄ^ _
)
ÄÄ_ `
{
ÅÅ 	
return
ÇÇ 
true
ÇÇ 
;
ÇÇ 
}
ÉÉ 	
var
ÖÖ 
active
ÖÖ 
=
ÖÖ 
await
ÖÖ 
userRepository
ÖÖ )
.
ÖÖ) *'
GetActiveBackupCodesAsync
ÖÖ* C
(
ÖÖC D
user
ÖÖD H
.
ÖÖH I
Id
ÖÖI K
,
ÖÖK L
ct
ÖÖM O
)
ÖÖO P
;
ÖÖP Q
var
ÜÜ 
match
ÜÜ 
=
ÜÜ 
active
ÜÜ 
.
ÜÜ 
FirstOrDefault
ÜÜ )
(
ÜÜ) *
c
ÜÜ* +
=>
ÜÜ, .%
CryptographicOperations
ÜÜ/ F
.
ÜÜF G
FixedTimeEquals
ÜÜG V
(
ÜÜV W
Encoding
áá 
.
áá 
UTF8
áá 
.
áá 
GetBytes
áá "
(
áá" #
c
áá# $
.
áá$ %
CodeHash
áá% -
)
áá- .
,
áá. /
Encoding
áá0 8
.
áá8 9
UTF8
áá9 =
.
áá= >
GetBytes
áá> F
(
ááF G
hash
ááG K
)
ááK L
)
ááL M
)
ááM N
;
ááN O
if
àà 

(
àà 
match
àà 
is
àà 
null
àà 
)
àà 
{
ââ 	
return
ää 
false
ää 
;
ää 
}
ãã 	
await
çç 
userRepository
çç 
.
çç $
ConsumeBackupCodeAsync
çç 3
(
çç3 4
match
çç4 9
,
çç9 :
ct
çç; =
)
çç= >
;
çç> ?
return
éé 
true
éé 
;
éé 
}
èè 
private
ëë 
async
ëë 
Task
ëë 
<
ëë 
IReadOnlyList
ëë $
<
ëë$ %
string
ëë% +
>
ëë+ ,
>
ëë, -)
GenerateAndStoreBackupCodes
ëë. I
(
ëëI J
int
ëëJ M
userId
ëëN T
,
ëëT U
CancellationToken
ëëV g
ct
ëëh j
)
ëëj k
{
íí 
var
ìì 
plain
ìì 
=
ìì 
new
ìì 
List
ìì 
<
ìì 
string
ìì #
>
ìì# $
(
ìì$ %
_opts
ìì% *
.
ìì* +
BackupCodeCount
ìì+ :
)
ìì: ;
;
ìì; <
var
îî 
entities
îî 
=
îî 
new
îî 
List
îî 
<
îî  
UserBackupCode
îî  .
>
îî. /
(
îî/ 0
_opts
îî0 5
.
îî5 6
BackupCodeCount
îî6 E
)
îîE F
;
îîF G
for
ïï 
(
ïï 
var
ïï 
i
ïï 
=
ïï 
$num
ïï 
;
ïï 
i
ïï 
<
ïï 
_opts
ïï !
.
ïï! "
BackupCodeCount
ïï" 1
;
ïï1 2
i
ïï3 4
++
ïï4 6
)
ïï6 7
{
ññ 	
var
óó 
raw
óó 
=
óó 
GenerateCode
óó "
(
óó" #
_opts
óó# (
.
óó( )
BackupCodeLength
óó) 9
)
óó9 :
;
óó: ;
plain
òò 
.
òò 
Add
òò 
(
òò 
Format
òò 
(
òò 
raw
òò  
)
òò  !
)
òò! "
;
òò" #
entities
ôô 
.
ôô 
Add
ôô 
(
ôô 
new
ôô 
UserBackupCode
ôô +
{
öö 
UserId
õõ 
=
õõ 
userId
õõ 
,
õõ  
CodeHash
úú 
=
úú 
Hash
úú 
(
úú  
raw
úú  #
)
úú# $
,
úú$ %
	CreatedAt
ùù 
=
ùù 
DateTime
ùù $
.
ùù$ %
UtcNow
ùù% +
,
ùù+ ,
}
ûû 
)
ûû 
;
ûû 
}
üü 	
await
°° 
userRepository
°° 
.
°° %
ReplaceBackupCodesAsync
°° 4
(
°°4 5
userId
°°5 ;
,
°°; <
entities
°°= E
,
°°E F
ct
°°G I
)
°°I J
;
°°J K
return
¢¢ 
plain
¢¢ 
;
¢¢ 
}
££ 
private
•• 
string
•• 
GenerateCode
•• 
(
••  
int
••  #
length
••$ *
)
••* +
{
¶¶ 
var
ßß 
alphabet
ßß 
=
ßß 
_opts
ßß 
.
ßß  
BackupCodeAlphabet
ßß /
;
ßß/ 0
var
®® 
chars
®® 
=
®® 
new
®® 
char
®® 
[
®® 
length
®® #
]
®®# $
;
®®$ %
for
©© 
(
©© 
var
©© 
i
©© 
=
©© 
$num
©© 
;
©© 
i
©© 
<
©© 
chars
©© !
.
©©! "
Length
©©" (
;
©©( )
i
©©* +
++
©©+ -
)
©©- .
{
™™ 	
chars
´´ 
[
´´ 
i
´´ 
]
´´ 
=
´´ 
alphabet
´´ 
[
´´  #
RandomNumberGenerator
´´  5
.
´´5 6
GetInt32
´´6 >
(
´´> ?
alphabet
´´? G
.
´´G H
Length
´´H N
)
´´N O
]
´´O P
;
´´P Q
}
¨¨ 	
return
ÆÆ 
new
ÆÆ 
string
ÆÆ 
(
ÆÆ 
chars
ÆÆ 
)
ÆÆ  
;
ÆÆ  !
}
ØØ 
private
±± 
static
±± 
string
±± 
Format
±±  
(
±±  !
string
±±! '
raw
±±( +
)
±±+ ,
=>
±±- /
raw
≤≤ 
.
≤≤ 
Length
≤≤ 
>=
≤≤ 
$num
≤≤ 
?
≤≤ 
$"
≤≤ 
{
≤≤ 
raw
≤≤  
[
≤≤  !
..
≤≤! #
(
≤≤# $
raw
≤≤$ '
.
≤≤' (
Length
≤≤( .
/
≤≤/ 0
$num
≤≤1 2
)
≤≤2 3
]
≤≤3 4
}
≤≤4 5
$str
≤≤5 6
{
≤≤6 7
raw
≤≤7 :
[
≤≤: ;
(
≤≤; <
raw
≤≤< ?
.
≤≤? @
Length
≤≤@ F
/
≤≤G H
$num
≤≤I J
)
≤≤J K
..
≤≤K M
]
≤≤M N
}
≤≤N O
"
≤≤O P
:
≤≤Q R
raw
≤≤S V
;
≤≤V W
private
¥¥ 
static
¥¥ 
string
¥¥ !
NormalizeBackupCode
¥¥ -
(
¥¥- .
string
¥¥. 4
code
¥¥5 9
)
¥¥9 :
=>
¥¥; =
new
µµ 
(
µµ 
code
µµ 
.
µµ 
Where
µµ 
(
µµ 
char
µµ 
.
µµ 
IsLetterOrDigit
µµ +
)
µµ+ ,
.
µµ, -
Select
µµ- 3
(
µµ3 4
char
µµ4 8
.
µµ8 9
ToUpperInvariant
µµ9 I
)
µµI J
.
µµJ K
ToArray
µµK R
(
µµR S
)
µµS T
)
µµT U
;
µµU V
private
∑∑ 
async
∑∑ 
Task
∑∑ 
<
∑∑ 
User
∑∑ 
>
∑∑ 
Require
∑∑ $
(
∑∑$ %
int
∑∑% (
userId
∑∑) /
,
∑∑/ 0
CancellationToken
∑∑1 B
ct
∑∑C E
)
∑∑E F
=>
∑∑G I
await
∏∏ 
userRepository
∏∏ 
.
∏∏ 
GetByIdAsync
∏∏ )
(
∏∏) *
userId
∏∏* 0
,
∏∏0 1
ct
∏∏2 4
)
∏∏4 5
??
ππ 

throw
ππ 
new
ππ 
AuthException
ππ "
(
ππ" #
$str
ππ# 3
,
ππ3 4
$num
ππ5 8
,
ππ8 9
$str
ππ: K
)
ππK L
;
ππL M
private
ªª 
static
ªª 
string
ªª 
Hash
ªª 
(
ªª 
string
ªª %
value
ªª& +
)
ªª+ ,
=>
ªª- /
Convert
ºº 
.
ºº 
ToHexString
ºº 
(
ºº 
SHA256
ºº "
.
ºº" #
HashData
ºº# +
(
ºº+ ,
Encoding
ºº, 4
.
ºº4 5
UTF8
ºº5 9
.
ºº9 :
GetBytes
ºº: B
(
ººB C
value
ººC H
)
ººH I
)
ººI J
)
ººJ K
;
ººK L
}ΩΩ ¢)
yC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Services\SupportService.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
Services. 6
;6 7
public 
sealed 
class 
SupportService "
(" #
IEmailSender 
emailSender 
, 
IEmailLocalizer 
emailLocalizer "
," #
IEmailRateLimiter 
rateLimiter !
,! "

IValidator 
< !
SupportContactRequest $
>$ %
	validator& /
,/ 0
IOptions 
< 
SupportOptions 
> 
options $
)$ %
:& '
ISupportService( 7
{ 
private 
readonly 
SupportOptions #
_opts$ )
=* +
options, 3
.3 4
Value4 9
;9 :
public 

async 
Task 
SendContactAsync &
(& '!
SupportContactRequest' <
request= D
,D E
stringF L
?L M
clientIpN V
=W X
nullY ]
,] ^
CancellationToken_ p
ctq s
=t u
defaultv }
)} ~
{ 
await 
	validator 
. !
ValidateAndThrowAsync -
(- .
request. 5
,5 6
ct7 9
)9 :
;: ;
if 

( 
string 
. 
IsNullOrWhiteSpace %
(% &
_opts& +
.+ ,
DevEmail, 4
)4 5
||6 8
!9 :
Regex: ?
.? @
IsMatch@ G
(G H
_optsH M
.M N
DevEmailN V
,V W
EmailValidationX g
.g h
Patternh o
)o p
)p q
{ 	
throw 
new "
ConfigurationException ,
(, -
$str- m
)m n
;n o
} 	
if   

(   
!   
string   
.   
IsNullOrWhiteSpace   &
(  & '
clientIp  ' /
)  / 0
&&!! 
!!! 
rateLimiter!! 
.!! 

TryConsume!! &
(!!& '
$"!!' )
$str!!) 4
{!!4 5
clientIp!!5 =
}!!= >
"!!> ?
,!!? @
_opts!!A F
.!!F G
MaxPerIpPerHour!!G V
,!!V W
TimeSpan!!X `
.!!` a
	FromHours!!a j
(!!j k
$num!!k l
)!!l m
)!!m n
)!!n o
{"" 	
throw## 
new## &
RateLimitExceededException## 0
(##0 1
$str##1 e
)##e f
;##f g
}$$ 	
var&& 
sender&& 
=&& 
string&& 
.&& 
IsNullOrWhiteSpace&& .
(&&. /
request&&/ 6
.&&6 7
Name&&7 ;
)&&; <
?'' 
request'' 
.'' 
Email'' 
:(( 
$"(( 
{(( 
request(( 
.(( 
Name(( 
}(( 
$str((  
{((  !
request((! (
.((( )
Email(() .
}((. /
$str((/ 0
"((0 1
;((1 2
var** 
subject** 
=** 
emailLocalizer** $
.**$ %
Get**% (
(**( )
request**) 0
.**0 1
Locale**1 7
,**7 8
$str**9 J
,**J K
request**L S
.**S T
Subject**T [
)**[ \
;**\ ]
var++ 
fromLine++ 
=++ 
emailLocalizer++ %
.++% &
Get++& )
(++) *
request++* 1
.++1 2
Locale++2 8
,++8 9
$str++: H
,++H I
sender++J P
)++P Q
;++Q R
var-- 
html-- 
=-- 
$"""
-.
$str.. P
{..P Q

WebUtility..Q [
...[ \

HtmlEncode..\ f
(..f g
fromLine..g o
)..o p
}..p q
$str./q ]
{//] ^

WebUtility//^ h
.//h i

HtmlEncode//i s
(//s t
request//t {
.//{ |
Message	//| É
)
//É Ñ
}
//Ñ Ö
$str
//Ö â

"""	/0â 
;00 
var11 
text11 
=11 
$"11 
{11 
fromLine11 
}11 
$str11 #
{11# $
request11$ +
.11+ ,
Message11, 3
}113 4
"114 5
;115 6
await33 
emailSender33 
.33 
	SendAsync33 #
(33# $
_opts33$ )
.33) *
DevEmail33* 2
,332 3
subject334 ;
,33; <
html33= A
,33A B
text33C G
,33G H
ct33I K
)33K L
;33L M
}44 
}55 ∂x
ÉC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Services\EmailVerificationService.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
Services. 6
;6 7
public 
sealed 
class $
EmailVerificationService ,
(, -
IUserRepository 
userRepository "
," #
IEmailSender 
emailSender 
, 

ISmsSender 
	smsSender 
, 
IEmailLocalizer 
emailLocalizer "
," #
IEmailRateLimiter 
rateLimiter !
,! "
IOptions 
< $
EmailVerificationOptions %
>% &
options' .
,. /
ILogger 
< $
EmailVerificationService $
>$ %
logger& ,
), -
:. /%
IEmailVerificationService0 I
{ 
private 
readonly $
EmailVerificationOptions -
_opts. 3
=4 5
options6 =
.= >
Value> C
;C D
public 

async 
Task 
ResendAsync !
(! "
string" (
email) .
,. /
VerificationChannel0 C
channelD K
,K L
stringM S
?S T
clientIpU ]
,] ^
CancellationToken_ p
ctq s
=t u
defaultv }
)} ~
{ 
if 

( 
! 
AllowIp 
( 
clientIp 
) 
) 
{ 	
return 
; 
} 	
var   

normalized   
=   
EmailNormalizer   (
.  ( )
	Normalize  ) 2
(  2 3
email  3 8
)  8 9
;  9 :
var!! 
user!! 
=!! 
await!! 
userRepository!! '
.!!' (
GetByEmailAsync!!( 7
(!!7 8

normalized!!8 B
,!!B C
ct!!D F
)!!F G
;!!G H
if"" 

("" 
user"" 
is"" 
null"" 
||"" 
user""  
.""  !
EmailVerified""! .
)"". /
{## 	
return$$ 
;$$ 
}%% 	
var'' 
resolved'' 
='' 
channel'' 
=='' !
VerificationChannel''" 5
.''5 6
Sms''6 9
&&'': <
string''= C
.''C D
IsNullOrWhiteSpace''D V
(''V W
user''W [
.''[ \
Phone''\ a
)''a b
?(( 
VerificationChannel(( !
.((! "
Email((" '
:)) 
channel)) 
;)) 
await** 
	SendAsync** 
(** 
user** 
,** 
resolved** &
,**& '
ct**( *
)*** +
;**+ ,
}++ 
public-- 

async-- 
Task-- 
<-- 
bool-- 
>-- 
SmsAvailableAsync-- -
(--- .
string--. 4
email--5 :
,--: ;
CancellationToken--< M
ct--N P
=--Q R
default--S Z
)--Z [
{.. 
var// 

normalized// 
=// 
EmailNormalizer// (
.//( )
	Normalize//) 2
(//2 3
email//3 8
)//8 9
;//9 :
var00 
user00 
=00 
await00 
userRepository00 '
.00' (
GetByEmailAsync00( 7
(007 8

normalized008 B
,00B C
ct00D F
)00F G
;00G H
return11 
user11 
is11 
not11 
null11 
&&11  "
!11# $
user11$ (
.11( )
EmailVerified11) 6
&&117 9
!11: ;
string11; A
.11A B
IsNullOrWhiteSpace11B T
(11T U
user11U Y
.11Y Z
Phone11Z _
)11_ `
;11` a
}22 
public44 

async44 
Task44 
VerifyAsync44 !
(44! "
string44" (
email44) .
,44. /
string440 6
code447 ;
,44; <
string44= C
?44C D
clientIp44E M
,44M N
CancellationToken44O `
ct44a c
=44d e
default44f m
)44m n
{55 
if66 

(66 
!66 
AllowIp66 
(66 
clientIp66 
)66 
)66 
{77 	
throw88 
new88 &
RateLimitExceededException88 0
(880 1
$str881 j
)88j k
;88k l
}99 	
var;; 

normalized;; 
=;; 
EmailNormalizer;; (
.;;( )
	Normalize;;) 2
(;;2 3
email;;3 8
);;8 9
;;;9 :
if<< 

(<< 
!<< 
rateLimiter<< 
.<< 

TryConsume<< #
(<<# $
$"<<$ &
$str<<& 5
{<<5 6

normalized<<6 @
}<<@ A
"<<A B
,<<B C
_opts<<D I
.<<I J$
MaxVerifyAttemptsPerHour<<J b
,<<b c
TimeSpan<<d l
.<<l m
	FromHours<<m v
(<<v w
$num<<w x
)<<x y
)<<y z
)<<z {
{== 	
throw>> 
new>> &
RateLimitExceededException>> 0
(>>0 1
$str>>1 j
)>>j k
;>>k l
}?? 	
varAA 
userAA 
=AA 
awaitAA 
userRepositoryAA '
.AA' (
GetByEmailAsyncAA( 7
(AA7 8

normalizedAA8 B
,AAB C
ctAAD F
)AAF G
;AAG H
ifBB 

(BB 
userBB 
isBB 
nullBB 
||CC 
userCC 
.CC "
EmailVerificationTokenCC *
isCC+ -
nullCC. 2
||DD 
userDD 
.DD +
EmailVerificationTokenExpiresAtDD 3
<=DD4 6
DateTimeDD7 ?
.DD? @
UtcNowDD@ F
||EE 
userEE 
.EE "
EmailVerificationTokenEE *
!=EE+ -
HashEE. 2
(EE2 3
NormalizeCodeEE3 @
(EE@ A
codeEEA E
)EEE F
)EEF G
)EEG H
{FF 	
throwGG 
newGG ,
 InvalidVerificationCodeExceptionGG 6
(GG6 7
)GG7 8
;GG8 9
}HH 	
userJJ 
.JJ 
EmailVerifiedJJ 
=JJ 
trueJJ !
;JJ! "
userKK 
.KK "
EmailVerificationTokenKK #
=KK$ %
nullKK& *
;KK* +
userLL 
.LL +
EmailVerificationTokenExpiresAtLL ,
=LL- .
nullLL/ 3
;LL3 4
awaitMM 
userRepositoryMM 
.MM 
UpdateAsyncMM (
(MM( )
userMM) -
,MM- .
ctMM/ 1
)MM1 2
;MM2 3
}NN 
privatePP 
asyncPP 
TaskPP 
	SendAsyncPP  
(PP  !
UserPP! %
userPP& *
,PP* +
VerificationChannelPP, ?
channelPP@ G
,PPG H
CancellationTokenPPI Z
ctPP[ ]
)PP] ^
{QQ 
ifRR 

(RR 
!RR 
rateLimiterRR 
.RR 

TryConsumeRR #
(RR# $
$"RR$ &
$strRR& 6
{RR6 7
channelRR7 >
}RR> ?
$strRR? @
{RR@ A
userRRA E
.RRE F
IdRRF H
}RRH I
"RRI J
,RRJ K
$numRRL M
,RRM N
TimeSpanRRO W
.RRW X
FromSecondsRRX c
(RRc d
_optsRRd i
.RRi j!
ResendCooldownSecondsRRj 
)	RR Ä
)
RRÄ Å
)
RRÅ Ç
{SS 	
returnTT 
;TT 
}UU 	
varWW 
rateKeyWW 
=WW 
channelWW 
==WW  
VerificationChannelWW! 4
.WW4 5
SmsWW5 8
?XX 
$"XX 
$strXX 
{XX 
userXX  
.XX  !
PhoneXX! &
}XX& '
"XX' (
:YY 
$"YY 
$strYY 
{YY 
userYY "
.YY" #
EmailYY# (
}YY( )
"YY) *
;YY* +
ifZZ 

(ZZ 
!ZZ 
rateLimiterZZ 
.ZZ 

TryConsumeZZ #
(ZZ# $
rateKeyZZ$ +
,ZZ+ ,
_optsZZ- 2
.ZZ2 3
MaxPerEmailPerHourZZ3 E
,ZZE F
TimeSpanZZG O
.ZZO P
	FromHoursZZP Y
(ZZY Z
$numZZZ [
)ZZ[ \
)ZZ\ ]
)ZZ] ^
{[[ 	
return\\ 
;\\ 
}]] 	
var__ 
code__ 
=__ 
GenerateCode__ 
(__  
)__  !
;__! "
user`` 
.`` "
EmailVerificationToken`` #
=``$ %
Hash``& *
(``* +
code``+ /
)``/ 0
;``0 1
useraa 
.aa +
EmailVerificationTokenExpiresAtaa ,
=aa- .
DateTimeaa/ 7
.aa7 8
UtcNowaa8 >
.aa> ?

AddMinutesaa? I
(aaI J
_optsaaJ O
.aaO P
CodeLifetimeMinutesaaP c
)aac d
;aad e
awaitbb 
userRepositorybb 
.bb 
UpdateAsyncbb (
(bb( )
userbb) -
,bb- .
ctbb/ 1
)bb1 2
;bb2 3
vardd 
localedd 
=dd 
userdd 
.dd 
Settingsdd "
?dd" #
.dd# $
Localedd$ *
;dd* +
ifff 

(ff 
channelff 
==ff 
VerificationChannelff *
.ff* +
Smsff+ .
)ff. /
{gg 	
varhh 
smshh 
=hh 
emailLocalizerhh $
.hh$ %
Gethh% (
(hh( )
localehh) /
,hh/ 0
$strhh1 G
,hhG H
codehhI M
)hhM N
;hhN O
tryii 
{jj 
awaitkk 
	smsSenderkk 
.kk  
	SendAsynckk  )
(kk) *
userkk* .
.kk. /
Phonekk/ 4
!kk4 5
,kk5 6
smskk7 :
,kk: ;
ctkk< >
)kk> ?
;kk? @
}ll 
catchmm 
(mm 
	Exceptionmm 
exmm 
)mm  
{nn 
loggeroo 
.oo 
LogErroroo 
(oo  
exoo  "
,oo" #
$stroo$ V
,ooV W
userooX \
.oo\ ]
Idoo] _
)oo_ `
;oo` a
}pp 
returnrr 
;rr 
}ss 	
varuu 
(uu 
subjectuu 
,uu 
htmluu 
,uu 
textuu  
)uu  !
=uu" #"
EmailVerificationEmailuu$ :
.uu: ;
Builduu; @
(uu@ A
emailLocalizeruuA O
,uuO P
localeuuQ W
,uuW X
useruuY ]
.uu] ^
	FirstNameuu^ g
,uug h
codeuui m
)uum n
;uun o
tryvv 
{ww 	
awaitxx 
emailSenderxx 
.xx 
	SendAsyncxx '
(xx' (
userxx( ,
.xx, -
Emailxx- 2
,xx2 3
subjectxx4 ;
,xx; <
htmlxx= A
,xxA B
textxxC G
,xxG H
ctxxI K
)xxK L
;xxL M
}yy 	
catchzz 
(zz 
	Exceptionzz 
exzz 
)zz 
{{{ 	
logger|| 
.|| 
LogError|| 
(|| 
ex|| 
,|| 
$str||  N
,||N O
user||P T
.||T U
Email||U Z
)||Z [
;||[ \
}}} 	
}~~ 
private
ÄÄ 
bool
ÄÄ 
AllowIp
ÄÄ 
(
ÄÄ 
string
ÄÄ 
?
ÄÄ  
clientIp
ÄÄ! )
)
ÄÄ) *
=>
ÄÄ+ -
string
ÅÅ 
.
ÅÅ  
IsNullOrWhiteSpace
ÅÅ !
(
ÅÅ! "
clientIp
ÅÅ" *
)
ÅÅ* +
||
ÇÇ 

rateLimiter
ÇÇ 
.
ÇÇ 

TryConsume
ÇÇ !
(
ÇÇ! "
$"
ÇÇ" $
$str
ÇÇ$ .
{
ÇÇ. /
clientIp
ÇÇ/ 7
}
ÇÇ7 8
"
ÇÇ8 9
,
ÇÇ9 :
_opts
ÇÇ; @
.
ÇÇ@ A
MaxPerIpPerHour
ÇÇA P
,
ÇÇP Q
TimeSpan
ÇÇR Z
.
ÇÇZ [
	FromHours
ÇÇ[ d
(
ÇÇd e
$num
ÇÇe f
)
ÇÇf g
)
ÇÇg h
;
ÇÇh i
private
ÑÑ 
string
ÑÑ 
GenerateCode
ÑÑ 
(
ÑÑ  
)
ÑÑ  !
{
ÖÖ 
var
ÜÜ 
alphabet
ÜÜ 
=
ÜÜ 
_opts
ÜÜ 
.
ÜÜ 
CodeAlphabet
ÜÜ )
;
ÜÜ) *
var
áá 
chars
áá 
=
áá 
new
áá 
char
áá 
[
áá 
_opts
áá "
.
áá" #

CodeLength
áá# -
]
áá- .
;
áá. /
for
àà 
(
àà 
var
àà 
i
àà 
=
àà 
$num
àà 
;
àà 
i
àà 
<
àà 
chars
àà !
.
àà! "
Length
àà" (
;
àà( )
i
àà* +
++
àà+ -
)
àà- .
{
ââ 	
chars
ää 
[
ää 
i
ää 
]
ää 
=
ää 
alphabet
ää 
[
ää  #
RandomNumberGenerator
ää  5
.
ää5 6
GetInt32
ää6 >
(
ää> ?
alphabet
ää? G
.
ääG H
Length
ääH N
)
ääN O
]
ääO P
;
ääP Q
}
ãã 	
return
çç 
new
çç 
string
çç 
(
çç 
chars
çç 
)
çç  
;
çç  !
}
éé 
private
êê 
static
êê 
string
êê 
NormalizeCode
êê '
(
êê' (
string
êê( .
code
êê/ 3
)
êê3 4
=>
êê5 7
code
ëë 
.
ëë 
Trim
ëë 
(
ëë 
)
ëë 
.
ëë 
ToUpperInvariant
ëë $
(
ëë$ %
)
ëë% &
;
ëë& '
private
ìì 
static
ìì 
string
ìì 
Hash
ìì 
(
ìì 
string
ìì %
token
ìì& +
)
ìì+ ,
=>
ìì- /
Convert
îî 
.
îî 
ToHexString
îî 
(
îî 
SHA256
îî "
.
îî" #
HashData
îî# +
(
îî+ ,
Encoding
îî, 4
.
îî4 5
UTF8
îî5 9
.
îî9 :
GetBytes
îî: B
(
îîB C
token
îîC H
)
îîH I
)
îîI J
)
îîJ K
;
îîK L
}ïï ‘≥
~C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Services\EmailAddressService.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
Services. 6
;6 7
public 
sealed 
class 
EmailAddressService '
(' (
IUserRepository 
userRepository "
," #
IEmailSender 
emailSender 
, 
IEmailLocalizer 
emailLocalizer "
," #
IEmailRateLimiter 
rateLimiter !
,! "
IOptions 
< $
EmailVerificationOptions %
>% &
options' .
,. /
ILogger 
< 
EmailAddressService 
>  
logger! '
)' (
:) * 
IEmailAddressService+ ?
{ 
private 
readonly $
EmailVerificationOptions -
_opts. 3
=4 5
options6 =
.= >
Value> C
;C D
public 

async 
Task 
< 
IReadOnlyList #
<# $
UserEmailDto$ 0
>0 1
>1 2
	ListAsync3 <
(< =
int= @
userIdA G
,G H
CancellationTokenI Z
ct[ ]
=^ _
default` g
)g h
{ 
var 
user 
= 
await 
Require  
(  !
userId! '
,' (
ct) +
)+ ,
;, -
var 
result 
= 
new 
List 
< 
UserEmailDto *
>* +
{, -
new. 1
(1 2
user2 6
.6 7
Email7 <
,< =
true> B
,B C
trueD H
,H I
$strJ S
)S T
}U V
;V W
var 
extras 
= 
await 
userRepository )
.) *
GetEmailsAsync* 8
(8 9
userId9 ?
,? @
ctA C
)C D
;D E
result   
.   
AddRange   
(   
extras   
.   
Select   %
(  % &
e  & '
=>  ( *
new  + .
UserEmailDto  / ;
(  ; <
e  < =
.  = >
Address  > E
,  E F
false  G L
,  L M
e  N O
.  O P

IsVerified  P Z
,  Z [
e  \ ]
.  ] ^
Source  ^ d
)  d e
)  e f
)  f g
;  g h
return!! 
result!! 
;!! 
}"" 
public$$ 

async$$ 
Task$$ 
AddAsync$$ 
($$ 
int$$ "
userId$$# )
,$$) *
string$$+ 1
address$$2 9
,$$9 :
CancellationToken$$; L
ct$$M O
=$$P Q
default$$R Y
)$$Y Z
{%% 
var&& 

normalized&& 
=&& 
EmailNormalizer&& (
.&&( )
	Normalize&&) 2
(&&2 3
address&&3 :
)&&: ;
;&&; <
if'' 

('' 
!'' 
Regex'' 
.'' 
IsMatch'' 
('' 

normalized'' %
,''% &
EmailValidation''' 6
.''6 7
Pattern''7 >
)''> ?
)''? @
{(( 	
throw)) 
new)) 
AuthException)) #
())# $
$str))$ 3
,))3 4
$num))5 8
,))8 9
EmailValidation)): I
.))I J
Message))J Q
)))Q R
;))R S
}** 	
var,, 
user,, 
=,, 
await,, 
Require,,  
(,,  !
userId,,! '
,,,' (
ct,,) +
),,+ ,
;,,, -
if-- 

(-- 
await-- 
userRepository--  
.--  !$
EmailExistsAnywhereAsync--! 9
(--9 :

normalized--: D
,--D E
ct--F H
)--H I
)--I J
{.. 	
throw// 
new// &
EmailAddressTakenException// 0
(//0 1
)//1 2
;//2 3
}00 	
if22 

(22 
!22 
rateLimiter22 
.22 

TryConsume22 #
(22# $
$"22$ &
$str22& 0
{220 1
userId221 7
}227 8
"228 9
,229 :
_opts22; @
.22@ A
MaxPerEmailPerHour22A S
,22S T
TimeSpan22U ]
.22] ^
	FromHours22^ g
(22g h
$num22h i
)22i j
)22j k
)22k l
{33 	
throw44 
new44 &
RateLimitExceededException44 0
(440 1
$str441 c
)44c d
;44d e
}55 	
var77 
code77 
=77 
GenerateCode77 
(77  
)77  !
;77! "
var88 
email88 
=88 
new88 
	UserEmail88 !
{99 	
UserId:: 
=:: 
userId:: 
,:: 
Address;; 
=;; 

normalized;;  
,;;  !

IsVerified<< 
=<< 
false<< 
,<< 
Source== 
=== 
$str== 
,== 
VerificationToken>> 
=>> 
Hash>>  $
(>>$ %
code>>% )
)>>) *
,>>* +&
VerificationTokenExpiresAt?? &
=??' (
DateTime??) 1
.??1 2
UtcNow??2 8
.??8 9

AddMinutes??9 C
(??C D
_opts??D I
.??I J
CodeLifetimeMinutes??J ]
)??] ^
,??^ _
	CreatedAt@@ 
=@@ 
DateTime@@  
.@@  !
UtcNow@@! '
,@@' (
}AA 	
;AA	 

awaitBB 
userRepositoryBB 
.BB 
AddEmailAsyncBB *
(BB* +
emailBB+ 0
,BB0 1
ctBB2 4
)BB4 5
;BB5 6
awaitCC 
SendCodeCC 
(CC 
userCC 
,CC 

normalizedCC '
,CC' (
codeCC) -
,CC- .
ctCC/ 1
)CC1 2
;CC2 3
}DD 
publicFF 

asyncFF 
TaskFF 
VerifyAsyncFF !
(FF! "
intFF" %
userIdFF& ,
,FF, -
stringFF. 4
addressFF5 <
,FF< =
stringFF> D
codeFFE I
,FFI J
CancellationTokenFFK \
ctFF] _
=FF` a
defaultFFb i
)FFi j
{GG 
varHH 

normalizedHH 
=HH 
EmailNormalizerHH (
.HH( )
	NormalizeHH) 2
(HH2 3
addressHH3 :
)HH: ;
;HH; <
varII 
emailII 
=II 
awaitII 
userRepositoryII (
.II( )
GetEmailAsyncII) 6
(II6 7
userIdII7 =
,II= >

normalizedII? I
,III J
ctIIK M
)IIM N
??JJ 
throwJJ 
newJJ 
AuthExceptionJJ &
(JJ& '
$strJJ' @
,JJ@ A
$numJJB E
,JJE F
$strJJG a
)JJa b
;JJb c
ifKK 

(KK 
emailKK 
.KK 

IsVerifiedKK 
)KK 
{LL 	
returnMM 
;MM 
}NN 	
ifPP 

(PP 
emailPP 
.PP 
VerificationTokenPP #
isPP$ &
nullPP' +
||QQ 
emailQQ 
.QQ &
VerificationTokenExpiresAtQQ /
<=QQ0 2
DateTimeQQ3 ;
.QQ; <
UtcNowQQ< B
||RR 
emailRR 
.RR 
VerificationTokenRR &
!=RR' )
HashRR* .
(RR. /
codeRR/ 3
.RR3 4
TrimRR4 8
(RR8 9
)RR9 :
.RR: ;
ToUpperInvariantRR; K
(RRK L
)RRL M
)RRM N
)RRN O
{SS 	
throwTT 
newTT ,
 InvalidVerificationCodeExceptionTT 6
(TT6 7
)TT7 8
;TT8 9
}UU 	
emailWW 
.WW 

IsVerifiedWW 
=WW 
trueWW 
;WW  
emailXX 
.XX 
VerificationTokenXX 
=XX  !
nullXX" &
;XX& '
emailYY 
.YY &
VerificationTokenExpiresAtYY (
=YY) *
nullYY+ /
;YY/ 0
awaitZZ 
userRepositoryZZ 
.ZZ 
UpdateEmailAsyncZZ -
(ZZ- .
emailZZ. 3
,ZZ3 4
ctZZ5 7
)ZZ7 8
;ZZ8 9
}[[ 
public]] 

async]] 
Task]] 
ResendAsync]] !
(]]! "
int]]" %
userId]]& ,
,]], -
string]]. 4
address]]5 <
,]]< =
CancellationToken]]> O
ct]]P R
=]]S T
default]]U \
)]]\ ]
{^^ 
var__ 

normalized__ 
=__ 
EmailNormalizer__ (
.__( )
	Normalize__) 2
(__2 3
address__3 :
)__: ;
;__; <
var`` 
user`` 
=`` 
await`` 
Require``  
(``  !
userId``! '
,``' (
ct``) +
)``+ ,
;``, -
varaa 
emailaa 
=aa 
awaitaa 
userRepositoryaa (
.aa( )
GetEmailAsyncaa) 6
(aa6 7
userIdaa7 =
,aa= >

normalizedaa? I
,aaI J
ctaaK M
)aaM N
??bb 
throwbb 
newbb 
AuthExceptionbb &
(bb& '
$strbb' @
,bb@ A
$numbbB E
,bbE F
$strbbG a
)bba b
;bbb c
ifcc 

(cc 
emailcc 
.cc 

IsVerifiedcc 
)cc 
{dd 	
returnee 
;ee 
}ff 	
ifhh 

(hh 
!hh 
rateLimiterhh 
.hh 

TryConsumehh #
(hh# $
$"hh$ &
$strhh& 0
{hh0 1
userIdhh1 7
}hh7 8
"hh8 9
,hh9 :
_optshh; @
.hh@ A
MaxPerEmailPerHourhhA S
,hhS T
TimeSpanhhU ]
.hh] ^
	FromHourshh^ g
(hhg h
$numhhh i
)hhi j
)hhj k
)hhk l
{ii 	
returnjj 
;jj 
}kk 	
varmm 
codemm 
=mm 
GenerateCodemm 
(mm  
)mm  !
;mm! "
emailnn 
.nn 
VerificationTokennn 
=nn  !
Hashnn" &
(nn& '
codenn' +
)nn+ ,
;nn, -
emailoo 
.oo &
VerificationTokenExpiresAtoo (
=oo) *
DateTimeoo+ 3
.oo3 4
UtcNowoo4 :
.oo: ;

AddMinutesoo; E
(ooE F
_optsooF K
.ooK L
CodeLifetimeMinutesooL _
)oo_ `
;oo` a
awaitpp 
userRepositorypp 
.pp 
UpdateEmailAsyncpp -
(pp- .
emailpp. 3
,pp3 4
ctpp5 7
)pp7 8
;pp8 9
awaitqq 
SendCodeqq 
(qq 
userqq 
,qq 

normalizedqq '
,qq' (
codeqq) -
,qq- .
ctqq/ 1
)qq1 2
;qq2 3
}rr 
publictt 

asynctt 
Tasktt 
SetPrimaryAsynctt %
(tt% &
inttt& )
userIdtt* 0
,tt0 1
stringtt2 8
addresstt9 @
,tt@ A
CancellationTokenttB S
ctttT V
=ttW X
defaultttY `
)tt` a
{uu 
varvv 

normalizedvv 
=vv 
EmailNormalizervv (
.vv( )
	Normalizevv) 2
(vv2 3
addressvv3 :
)vv: ;
;vv; <
varww 
userww 
=ww 
awaitww 
Requireww  
(ww  !
userIdww! '
,ww' (
ctww) +
)ww+ ,
;ww, -
ifxx 

(xx 
stringxx 
.xx 
IsNullOrEmptyxx  
(xx  !
userxx! %
.xx% &
Passwordxx& .
)xx. /
)xx/ 0
{yy 	
throwzz 
newzz 
AuthExceptionzz #
(zz# $
$strzz$ A
,zzA B
$numzzC F
,zzF G
$str	zzH ñ
)
zzñ ó
;
zzó ò
}{{ 	
if}} 

(}} 
user}} 
.}} 
Email}} 
==}} 

normalized}} $
)}}$ %
{~~ 	
return 
; 
}
ÄÄ 	
var
ÇÇ 
email
ÇÇ 
=
ÇÇ 
await
ÇÇ 
userRepository
ÇÇ (
.
ÇÇ( )
GetEmailAsync
ÇÇ) 6
(
ÇÇ6 7
userId
ÇÇ7 =
,
ÇÇ= >

normalized
ÇÇ? I
,
ÇÇI J
ct
ÇÇK M
)
ÇÇM N
??
ÉÉ 
throw
ÉÉ 
new
ÉÉ 
AuthException
ÉÉ &
(
ÉÉ& '
$str
ÉÉ' @
,
ÉÉ@ A
$num
ÉÉB E
,
ÉÉE F
$str
ÉÉG a
)
ÉÉa b
;
ÉÉb c
if
ÑÑ 

(
ÑÑ 
!
ÑÑ 
email
ÑÑ 
.
ÑÑ 

IsVerified
ÑÑ 
)
ÑÑ 
{
ÖÖ 	
throw
ÜÜ 
new
ÜÜ 
AuthException
ÜÜ #
(
ÜÜ# $
$str
ÜÜ$ D
,
ÜÜD E
$num
ÜÜF I
,
ÜÜI J
$strÜÜK Ü
)ÜÜÜ á
;ÜÜá à
}
áá 	
var
ââ 
previousPrimary
ââ 
=
ââ 
user
ââ "
.
ââ" #
Email
ââ# (
;
ââ( )
await
ää 
userRepository
ää 
.
ää 
RemoveEmailAsync
ää -
(
ää- .
email
ää. 3
,
ää3 4
ct
ää5 7
)
ää7 8
;
ää8 9
user
ãã 
.
ãã 
Email
ãã 
=
ãã 

normalized
ãã 
;
ãã  
await
åå 
userRepository
åå 
.
åå 
UpdateAsync
åå (
(
åå( )
user
åå) -
,
åå- .
ct
åå/ 1
)
åå1 2
;
åå2 3
await
çç 
userRepository
çç 
.
çç 
AddEmailAsync
çç *
(
çç* +
new
éé 
	UserEmail
éé 
{
èè 
UserId
êê 
=
êê 
userId
êê 
,
êê  
Address
ëë 
=
ëë 
previousPrimary
ëë )
,
ëë) *

IsVerified
íí 
=
íí 
true
íí !
,
íí! "
Source
ìì 
=
ìì 
$str
ìì !
,
ìì! "
	CreatedAt
îî 
=
îî 
DateTime
îî $
.
îî$ %
UtcNow
îî% +
,
îî+ ,
}
ïï 
,
ïï 
ct
ññ 
)
ññ 
;
ññ 
}
óó 
public
ôô 

async
ôô 
Task
ôô 
RemoveAsync
ôô !
(
ôô! "
int
ôô" %
userId
ôô& ,
,
ôô, -
string
ôô. 4
address
ôô5 <
,
ôô< =
CancellationToken
ôô> O
ct
ôôP R
=
ôôS T
default
ôôU \
)
ôô\ ]
{
öö 
var
õõ 

normalized
õõ 
=
õõ 
EmailNormalizer
õõ (
.
õõ( )
	Normalize
õõ) 2
(
õõ2 3
address
õõ3 :
)
õõ: ;
;
õõ; <
var
úú 
user
úú 
=
úú 
await
úú 
Require
úú  
(
úú  !
userId
úú! '
,
úú' (
ct
úú) +
)
úú+ ,
;
úú, -
if
ùù 

(
ùù 
user
ùù 
.
ùù 
Email
ùù 
==
ùù 

normalized
ùù $
)
ùù$ %
{
ûû 	
throw
üü 
new
üü 
AuthException
üü #
(
üü# $
$str
üü$ A
,
üüA B
$num
üüC F
,
üüF G
$str
üüH n
)
üün o
;
üüo p
}
†† 	
var
¢¢ 
email
¢¢ 
=
¢¢ 
await
¢¢ 
userRepository
¢¢ (
.
¢¢( )
GetEmailAsync
¢¢) 6
(
¢¢6 7
userId
¢¢7 =
,
¢¢= >

normalized
¢¢? I
,
¢¢I J
ct
¢¢K M
)
¢¢M N
??
££ 
throw
££ 
new
££ 
AuthException
££ &
(
££& '
$str
££' @
,
££@ A
$num
££B E
,
££E F
$str
££G a
)
££a b
;
££b c
await
§§ 
userRepository
§§ 
.
§§ 
RemoveEmailAsync
§§ -
(
§§- .
email
§§. 3
,
§§3 4
ct
§§5 7
)
§§7 8
;
§§8 9
}
•• 
private
ßß 
async
ßß 
Task
ßß 
SendCode
ßß 
(
ßß  
User
ßß  $
user
ßß% )
,
ßß) *
string
ßß+ 1
address
ßß2 9
,
ßß9 :
string
ßß; A
code
ßßB F
,
ßßF G
CancellationToken
ßßH Y
ct
ßßZ \
)
ßß\ ]
{
®® 
var
©© 
locale
©© 
=
©© 
user
©© 
.
©© 
Settings
©© "
?
©©" #
.
©©# $
Locale
©©$ *
;
©©* +
var
™™ 
subject
™™ 
=
™™ 
emailLocalizer
™™ $
.
™™$ %
Get
™™% (
(
™™( )
locale
™™) /
,
™™/ 0
$str
™™1 C
)
™™C D
;
™™D E
var
´´ 
title
´´ 
=
´´ 
emailLocalizer
´´ "
.
´´" #
Get
´´# &
(
´´& '
locale
´´' -
,
´´- .
$str
´´/ ?
)
´´? @
;
´´@ A
var
¨¨ 
body
¨¨ 
=
¨¨ 
emailLocalizer
¨¨ !
.
¨¨! "
Get
¨¨" %
(
¨¨% &
locale
¨¨& ,
,
¨¨, -
$str
¨¨. =
,
¨¨= >
user
¨¨? C
.
¨¨C D
	FirstName
¨¨D M
)
¨¨M N
;
¨¨N O
var
≠≠ 
footer
≠≠ 
=
≠≠ 
emailLocalizer
≠≠ #
.
≠≠# $
Get
≠≠$ '
(
≠≠' (
locale
≠≠( .
,
≠≠. /
$str
≠≠0 A
)
≠≠A B
;
≠≠B C
var
ÆÆ 
html
ÆÆ 
=
ÆÆ 
EmailLayout
ÆÆ 
.
ÆÆ 

RenderCode
ÆÆ )
(
ÆÆ) *
title
ÆÆ* /
,
ÆÆ/ 0
body
ÆÆ1 5
,
ÆÆ5 6
code
ÆÆ7 ;
,
ÆÆ; <
footer
ÆÆ= C
)
ÆÆC D
;
ÆÆD E
var
ØØ 
text
ØØ 
=
ØØ 
$"
ØØ 
{
ØØ 
body
ØØ 
}
ØØ 
$str
ØØ 
{
ØØ  
code
ØØ  $
}
ØØ$ %
$str
ØØ% )
{
ØØ) *
footer
ØØ* 0
}
ØØ0 1
"
ØØ1 2
;
ØØ2 3
try
±± 
{
≤≤ 	
await
≥≥ 
emailSender
≥≥ 
.
≥≥ 
	SendAsync
≥≥ '
(
≥≥' (
address
≥≥( /
,
≥≥/ 0
subject
≥≥1 8
,
≥≥8 9
html
≥≥: >
,
≥≥> ?
text
≥≥@ D
,
≥≥D E
ct
≥≥F H
)
≥≥H I
;
≥≥I J
}
¥¥ 	
catch
µµ 
(
µµ 
	Exception
µµ 
ex
µµ 
)
µµ 
{
∂∂ 	
logger
∑∑ 
.
∑∑ 
LogError
∑∑ 
(
∑∑ 
ex
∑∑ 
,
∑∑ 
$str
∑∑  U
,
∑∑U V
address
∑∑W ^
)
∑∑^ _
;
∑∑_ `
}
∏∏ 	
}
ππ 
private
ªª 
string
ªª 
GenerateCode
ªª 
(
ªª  
)
ªª  !
{
ºº 
var
ΩΩ 
alphabet
ΩΩ 
=
ΩΩ 
_opts
ΩΩ 
.
ΩΩ 
CodeAlphabet
ΩΩ )
;
ΩΩ) *
var
ææ 
chars
ææ 
=
ææ 
new
ææ 
char
ææ 
[
ææ 
_opts
ææ "
.
ææ" #

CodeLength
ææ# -
]
ææ- .
;
ææ. /
for
øø 
(
øø 
var
øø 
i
øø 
=
øø 
$num
øø 
;
øø 
i
øø 
<
øø 
chars
øø !
.
øø! "
Length
øø" (
;
øø( )
i
øø* +
++
øø+ -
)
øø- .
{
¿¿ 	
chars
¡¡ 
[
¡¡ 
i
¡¡ 
]
¡¡ 
=
¡¡ 
alphabet
¡¡ 
[
¡¡  #
RandomNumberGenerator
¡¡  5
.
¡¡5 6
GetInt32
¡¡6 >
(
¡¡> ?
alphabet
¡¡? G
.
¡¡G H
Length
¡¡H N
)
¡¡N O
]
¡¡O P
;
¡¡P Q
}
¬¬ 	
return
ƒƒ 
new
ƒƒ 
string
ƒƒ 
(
ƒƒ 
chars
ƒƒ 
)
ƒƒ  
;
ƒƒ  !
}
≈≈ 
private
«« 
async
«« 
Task
«« 
<
«« 
User
«« 
>
«« 
Require
«« $
(
««$ %
int
««% (
userId
««) /
,
««/ 0
CancellationToken
««1 B
ct
««C E
)
««E F
=>
««G I
await
»» 
userRepository
»» 
.
»» 
GetByIdAsync
»» )
(
»») *
userId
»»* 0
,
»»0 1
ct
»»2 4
)
»»4 5
??
…… 

throw
…… 
new
…… 
AuthException
…… "
(
……" #
$str
……# 3
,
……3 4
$num
……5 8
,
……8 9
$str
……: K
)
……K L
;
……L M
private
ÀÀ 
static
ÀÀ 
string
ÀÀ 
Hash
ÀÀ 
(
ÀÀ 
string
ÀÀ %
value
ÀÀ& +
)
ÀÀ+ ,
=>
ÀÀ- /
Convert
ÃÃ 
.
ÃÃ 
ToHexString
ÃÃ 
(
ÃÃ 
SHA256
ÃÃ "
.
ÃÃ" #
HashData
ÃÃ# +
(
ÃÃ+ ,
Encoding
ÃÃ, 4
.
ÃÃ4 5
UTF8
ÃÃ5 9
.
ÃÃ9 :
GetBytes
ÃÃ: B
(
ÃÃB C
value
ÃÃC H
)
ÃÃH I
)
ÃÃI J
)
ÃÃJ K
;
ÃÃK L
}ÕÕ ∫Ñ
vC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Services\AuthService.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
Services. 6
;6 7
public 
sealed 
class 
AuthService 
(  
IUserRepository 
userRepository "
," #$
IUserProvisioningService 
userProvisioning -
,- .
ITokenService 
tokenService 
, 
IPasswordHasher 
passwordHasher "
," #%
IExternalIdentityVerifier $
externalIdentityVerifier 6
,6 7
ITwoFactorService 
twoFactorService &
,& '
IEmailSender 
emailSender 
, 
IEmailLocalizer 
emailLocalizer "
," #
IConfiguration 
configuration  
,  !

IValidator 
< 
LoginRequestDto 
> 
loginValidator  .
,. /

IValidator 
< "
UpdateMyProfileRequest %
>% &"
updateProfileValidator' =
,= >

IValidator 
< !
ForgotPasswordRequest $
>$ %#
forgotPasswordValidator& =
,= >

IValidator 
<  
ResetPasswordRequest #
># $"
resetPasswordValidator% ;
); <
:= >
IAuthService? K
{ 
public 

async 
Task 
< 
LoginResponseDto &
>& '

LoginAsync( 2
(2 3
LoginRequestDto3 B
requestC J
,J K
CancellationTokenL ]
ct^ `
=a b
defaultc j
)j k
{ 
await 
loginValidator 
. !
ValidateAndThrowAsync 2
(2 3
request3 :
,: ;
ct< >
)> ?
;? @
var!! 
email!! 
=!! 
EmailNormalizer!! #
.!!# $
	Normalize!!$ -
(!!- .
request!!. 5
.!!5 6
Email!!6 ;
)!!; <
;!!< =
var"" 
user"" 
="" 
await"" 
userRepository"" '
.""' (
GetByEmailAsync""( 7
(""7 8
email""8 =
,""= >
ct""? A
)""A B
??## 
throw## 
new## 
AuthException## &
(##& '
$str##' <
,##< =
$num##> A
,##A B
$str##C _
)##_ `
;##` a
if%% 

(%% 
string%% 
.%% 
IsNullOrEmpty%%  
(%%  !
user%%! %
.%%% &
Password%%& .
)%%. /
||%%0 2
!%%3 4
passwordHasher%%4 B
.%%B C
Verify%%C I
(%%I J
request%%J Q
.%%Q R
Password%%R Z
,%%Z [
user%%\ `
.%%` a
Password%%a i
)%%i j
)%%j k
throw&& 
new&& 
AuthException&& #
(&&# $
$str&&$ 9
,&&9 :
$num&&; >
,&&> ?
$str&&@ \
)&&\ ]
;&&] ^
if(( 

((( 
!(( 
user(( 
.(( 
EmailVerified(( 
)((  
throw)) 
new)) %
EmailNotVerifiedException)) /
())/ 0
user))0 4
.))4 5
Email))5 :
))): ;
;)); <
if++ 

(++ 
user++ 
.++ 
TwoFactorEnabled++ !
)++! "
{,, 	
if-- 
(-- 
string-- 
.-- 
IsNullOrWhiteSpace-- )
(--) *
request--* 1
.--1 2
TwoFactorCode--2 ?
)--? @
)--@ A
throw.. 
new.. &
TwoFactorRequiredException.. 4
(..4 5
)..5 6
;..6 7
if00 
(00 
!00 
await00 
twoFactorService00 '
.00' (
VerifyAsync00( 3
(003 4
user004 8
,008 9
request00: A
.00A B
TwoFactorCode00B O
,00O P
ct00Q S
)00S T
)00T U
throw11 
new11 )
InvalidTwoFactorCodeException11 7
(117 8
)118 9
;119 :
}22 	
var44 
(44 
token44 
,44 
	expiresAt44 
)44 
=44  
tokenService44! -
.44- .
GenerateAccessToken44. A
(44A B
user44B F
)44F G
;44G H
return66 
new66 
LoginResponseDto66 #
(66# $
token66$ )
,66) *
	expiresAt66+ 4
)664 5
;665 6
}77 
public99 

async99 
Task99 
<99 
LoginResponseDto99 &
>99& '
OAuthLoginAsync99( 7
(997 8
string998 >
provider99? G
,99G H 
OAuthLoginRequestDto99I ]
request99^ e
,99e f
CancellationToken99g x
ct99y {
=99| }
default	99~ Ö
)
99Ö Ü
{:: 
var;; 
identity;; 
=;; 
await;; $
externalIdentityVerifier;; 5
.;;5 6
VerifyAsync;;6 A
(;;A B
provider;;B J
,;;J K
request;;L S
.;;S T
Token;;T Y
,;;Y Z
ct;;[ ]
);;] ^
;;;^ _
var== 
user== 
=== 
await== 
userRepository== '
.==' (#
GetByExternalLoginAsync==( ?
(==? @
identity==@ H
.==H I
Provider==I Q
,==Q R
identity==S [
.==[ \
Subject==\ c
,==c d
ct==e g
)==g h
;==h i
if>> 

(>> 
user>> 
is>> 
null>> 
)>> 
{?? 	
var@@ 
email@@ 
=@@ 
EmailNormalizer@@ '
.@@' (
	Normalize@@( 1
(@@1 2
identity@@2 :
.@@: ;
Email@@; @
)@@@ A
;@@A B
userAA 
=AA 
awaitAA 
userRepositoryAA '
.AA' (
GetByEmailAsyncAA( 7
(AA7 8
emailAA8 =
,AA= >
ctAA? A
)AAA B
;AAB C
ifBB 
(BB 
userBB 
isBB 
notBB 
nullBB  
)BB  !
{CC 
awaitDD 
userRepositoryDD $
.DD$ %!
AddExternalLoginAsyncDD% :
(DD: ;
newEE 
PersistenceEE #
.EE# $
EntitiesEE$ ,
.EE, -
UserExternalLoginEE- >
{FF 
UserIdGG 
=GG  
userGG! %
.GG% &
IdGG& (
,GG( )
ProviderHH  
=HH! "
identityHH# +
.HH+ ,
ProviderHH, 4
,HH4 5
SubjectII 
=II  !
identityII" *
.II* +
SubjectII+ 2
,II2 3
	CreatedAtJJ !
=JJ" #
DateTimeJJ$ ,
.JJ, -
UtcNowJJ- 3
}KK 
,KK 
ctLL 
)LL 
;LL 
}MM 
elseNN 
{OO 
userPP 
=PP 
awaitPP 
userProvisioningPP -
.PP- .#
CreateExternalUserAsyncPP. E
(PPE F
identityPPF N
,PPN O
ctPPP R
)PPR S
;PPS T
}QQ 
}RR 	
awaitTT "
AssociateProviderEmailTT $
(TT$ %
userTT% )
,TT) *
identityTT+ 3
,TT3 4
ctTT5 7
)TT7 8
;TT8 9
varVV 
(VV 
tokenVV 
,VV 
	expiresAtVV 
)VV 
=VV  
tokenServiceVV! -
.VV- .
GenerateAccessTokenVV. A
(VVA B
userVVB F
)VVF G
;VVG H
returnXX 
newXX 
LoginResponseDtoXX #
(XX# $
tokenXX$ )
,XX) *
	expiresAtXX+ 4
)XX4 5
;XX5 6
}YY 
public[[ 

async[[ 
Task[[ 
LinkProviderAsync[[ '
([[' (
int[[( +
userId[[, 2
,[[2 3
string[[4 :
provider[[; C
,[[C D 
OAuthLoginRequestDto[[E Y
request[[Z a
,[[a b
CancellationToken[[c t
ct[[u w
=[[x y
default	[[z Å
)
[[Å Ç
{\\ 
var]] 
identity]] 
=]] 
await]] $
externalIdentityVerifier]] 5
.]]5 6
VerifyAsync]]6 A
(]]A B
provider]]B J
,]]J K
request]]L S
.]]S T
Token]]T Y
,]]Y Z
ct]][ ]
)]]] ^
;]]^ _
var__ 
existing__ 
=__ 
await__ 
userRepository__ +
.__+ ,#
GetByExternalLoginAsync__, C
(__C D
identity__D L
.__L M
Provider__M U
,__U V
identity__W _
.___ `
Subject__` g
,__g h
ct__i k
)__k l
;__l m
if`` 

(`` 
existing`` 
is`` 
not`` 
null``  
&&``! #
existing``$ ,
.``, -
Id``- /
!=``0 2
userId``3 9
)``9 :
{aa 	
throwbb 
newbb 
AuthExceptionbb #
(bb# $
$strbb$ =
,bb= >
$numbb? B
,bbB C
$str	bbD Ç
)
bbÇ É
;
bbÉ Ñ
}cc 	
varee 
useree 
=ee 
awaitee 
userRepositoryee '
.ee' (
GetByIdAsyncee( 4
(ee4 5
userIdee5 ;
,ee; <
ctee= ?
)ee? @
??ff 
throwff 
newff 
AuthExceptionff &
(ff& '
$strff' 7
,ff7 8
$numff9 <
,ff< =
$strff> O
)ffO P
;ffP Q
ifhh 

(hh 
existinghh 
ishh 
nullhh 
)hh 
{ii 	
awaitjj 
userRepositoryjj  
.jj  !!
AddExternalLoginAsyncjj! 6
(jj6 7
newkk 
Persistencekk 
.kk  
Entitieskk  (
.kk( )
UserExternalLoginkk) :
{ll 
UserIdmm 
=mm 
userIdmm #
,mm# $
Providernn 
=nn 
identitynn '
.nn' (
Providernn( 0
,nn0 1
Subjectoo 
=oo 
identityoo &
.oo& '
Subjectoo' .
,oo. /
	CreatedAtpp 
=pp 
DateTimepp  (
.pp( )
UtcNowpp) /
,pp/ 0
}qq 
,qq 
ctrr 
)rr 
;rr 
}ss 	
awaituu "
AssociateProviderEmailuu $
(uu$ %
useruu% )
,uu) *
identityuu+ 3
,uu3 4
ctuu5 7
)uu7 8
;uu8 9
}vv 
privatexx 
asyncxx 
Taskxx "
AssociateProviderEmailxx -
(xx- .
Persistencexx. 9
.xx9 :
Entitiesxx: B
.xxB C
UserxxC G
userxxH L
,xxL M
ExternalIdentityxxN ^
identityxx_ g
,xxg h
CancellationTokenxxi z
ctxx{ }
)xx} ~
{yy 
varzz 
providerEmailzz 
=zz 
EmailNormalizerzz +
.zz+ ,
	Normalizezz, 5
(zz5 6
identityzz6 >
.zz> ?
Emailzz? D
)zzD E
;zzE F
if{{ 

({{ 
string{{ 
.{{ 
IsNullOrWhiteSpace{{ %
({{% &
providerEmail{{& 3
){{3 4
||{{5 7
providerEmail{{8 E
=={{F H
user{{I M
.{{M N
Email{{N S
){{S T
{|| 	
return}} 
;}} 
}~~ 	
try
ÄÄ 
{
ÅÅ 	
var
ÇÇ 
existing
ÇÇ 
=
ÇÇ 
await
ÇÇ  
userRepository
ÇÇ! /
.
ÇÇ/ 0
GetEmailAsync
ÇÇ0 =
(
ÇÇ= >
user
ÇÇ> B
.
ÇÇB C
Id
ÇÇC E
,
ÇÇE F
providerEmail
ÇÇG T
,
ÇÇT U
ct
ÇÇV X
)
ÇÇX Y
;
ÇÇY Z
if
ÉÉ 
(
ÉÉ 
existing
ÉÉ 
is
ÉÉ 
null
ÉÉ  
&&
ÉÉ! #
!
ÉÉ$ %
await
ÉÉ% *
userRepository
ÉÉ+ 9
.
ÉÉ9 :&
EmailExistsAnywhereAsync
ÉÉ: R
(
ÉÉR S
providerEmail
ÉÉS `
,
ÉÉ` a
ct
ÉÉb d
)
ÉÉd e
)
ÉÉe f
{
ÑÑ 
await
ÖÖ 
userRepository
ÖÖ $
.
ÖÖ$ %
AddEmailAsync
ÖÖ% 2
(
ÖÖ2 3
new
ÜÜ 
Persistence
ÜÜ #
.
ÜÜ# $
Entities
ÜÜ$ ,
.
ÜÜ, -
	UserEmail
ÜÜ- 6
{
áá 
UserId
àà 
=
àà  
user
àà! %
.
àà% &
Id
àà& (
,
àà( )
Address
ââ 
=
ââ  !
providerEmail
ââ" /
,
ââ/ 0

IsVerified
ää "
=
ää# $
true
ää% )
,
ää) *
Source
ãã 
=
ãã  
identity
ãã! )
.
ãã) *
Provider
ãã* 2
,
ãã2 3
	CreatedAt
åå !
=
åå" #
DateTime
åå$ ,
.
åå, -
UtcNow
åå- 3
,
åå3 4
}
çç 
,
çç 
ct
éé 
)
éé 
;
éé 
}
èè 
}
êê 	
catch
ëë 
{
íí 	
return
ìì 
;
ìì 
}
îî 	
}
ïï 
public
óó 

async
óó 
Task
óó 
<
óó 
bool
óó 
>
óó 
EmailExistsAsync
óó ,
(
óó, -
string
óó- 3
email
óó4 9
,
óó9 :
CancellationToken
óó; L
ct
óóM O
=
óóP Q
default
óóR Y
)
óóY Z
{
òò 
if
ôô 

(
ôô 
string
ôô 
.
ôô  
IsNullOrWhiteSpace
ôô %
(
ôô% &
email
ôô& +
)
ôô+ ,
)
ôô, -
return
ôô. 4
false
ôô5 :
;
ôô: ;
var
öö 

normalized
öö 
=
öö 
EmailNormalizer
öö (
.
öö( )
	Normalize
öö) 2
(
öö2 3
email
öö3 8
)
öö8 9
;
öö9 :
return
õõ 
await
õõ 
userRepository
õõ #
.
õõ# $
ExistsAsync
õõ$ /
(
õõ/ 0

normalized
õõ0 :
,
õõ: ;
ct
õõ< >
)
õõ> ?
;
õõ? @
}
úú 
public
ûû 

Task
ûû 
<
ûû !
RegisterResponseDto
ûû #
>
ûû# $
RegisterAsync
ûû% 2
(
ûû2 3 
RegisterRequestDto
ûû3 E
request
ûûF M
,
ûûM N
CancellationToken
ûûO `
ct
ûûa c
=
ûûd e
default
ûûf m
)
ûûm n
{
üü &
ValidateSelfRegistration
††  
(
††  !
request
††! (
)
††( )
;
††) *
return
°° 
userProvisioning
°° 
.
°°  
CreateUserAsync
°°  /
(
°°/ 0
request
°°0 7
,
°°7 8
auditActorUserId
°°9 I
:
°°I J
null
°°K O
,
°°O P
ct
°°Q S
)
°°S T
;
°°T U
}
¢¢ 
private
§§ 
static
§§ 
readonly
§§ 
Regex
§§ !

PhoneRegex
§§" ,
=
§§- .
new
§§/ 2
(
§§2 3
$str
§§3 G
,
§§G H
RegexOptions
§§I U
.
§§U V
Compiled
§§V ^
)
§§^ _
;
§§_ `
private
¶¶ 
static
¶¶ 
void
¶¶ &
ValidateSelfRegistration
¶¶ 0
(
¶¶0 1 
RegisterRequestDto
¶¶1 C
request
¶¶D K
)
¶¶K L
{
ßß 
var
®® 
failures
®® 
=
®® 
new
®® 
List
®® 
<
®®  
ValidationFailure
®®  1
>
®®1 2
(
®®2 3
)
®®3 4
;
®®4 5
if
™™ 

(
™™ 
string
™™ 
.
™™  
IsNullOrWhiteSpace
™™ %
(
™™% &
request
™™& -
.
™™- .
Phone
™™. 3
)
™™3 4
)
™™4 5
{
´´ 	
failures
¨¨ 
.
¨¨ 
Add
¨¨ 
(
¨¨ 
new
¨¨ 
ValidationFailure
¨¨ .
(
¨¨. /
nameof
¨¨/ 5
(
¨¨5 6
request
¨¨6 =
.
¨¨= >
Phone
¨¨> C
)
¨¨C D
,
¨¨D E
$str
¨¨F a
)
¨¨a b
{
¨¨c d
	ErrorCode
¨¨e n
=
¨¨o p
$str¨¨q Å
}¨¨Ç É
)¨¨É Ñ
;¨¨Ñ Ö
}
≠≠ 	
else
ÆÆ 
if
ÆÆ 
(
ÆÆ 
!
ÆÆ 

PhoneRegex
ÆÆ 
.
ÆÆ 
IsMatch
ÆÆ $
(
ÆÆ$ %
request
ÆÆ% ,
.
ÆÆ, -
Phone
ÆÆ- 2
)
ÆÆ2 3
)
ÆÆ3 4
{
ØØ 	
failures
∞∞ 
.
∞∞ 
Add
∞∞ 
(
∞∞ 
new
∞∞ 
ValidationFailure
∞∞ .
(
∞∞. /
nameof
∞∞/ 5
(
∞∞5 6
request
∞∞6 =
.
∞∞= >
Phone
∞∞> C
)
∞∞C D
,
∞∞D E
$str
∞∞F i
)
∞∞i j
{
∞∞k l
	ErrorCode
∞∞m v
=
∞∞w x
$str∞∞y à
}∞∞â ä
)∞∞ä ã
;∞∞ã å
}
±± 	
if
≥≥ 

(
≥≥ 
request
≥≥ 
.
≥≥ 
DateOfBirth
≥≥ 
is
≥≥  "
null
≥≥# '
||
¥¥ 
request
¥¥ 
.
¥¥ 
DateOfBirth
¥¥ "
<=
¥¥# %
new
¥¥& )
DateOnly
¥¥* 2
(
¥¥2 3
$num
¥¥3 7
,
¥¥7 8
$num
¥¥9 :
,
¥¥: ;
$num
¥¥< =
)
¥¥= >
||
µµ 
request
µµ 
.
µµ 
DateOfBirth
µµ "
>=
µµ# %
DateOnly
µµ& .
.
µµ. /
FromDateTime
µµ/ ;
(
µµ; <
DateTime
µµ< D
.
µµD E
UtcNow
µµE K
)
µµK L
)
µµL M
{
∂∂ 	
failures
∑∑ 
.
∑∑ 
Add
∑∑ 
(
∑∑ 
new
∑∑ 
ValidationFailure
∑∑ .
(
∑∑. /
nameof
∑∑/ 5
(
∑∑5 6
request
∑∑6 =
.
∑∑= >
DateOfBirth
∑∑> I
)
∑∑I J
,
∑∑J K
$str
∑∑L p
)
∑∑p q
{
∑∑r s
	ErrorCode
∑∑t }
=
∑∑~ 
$str∑∑Ä ì
}∑∑î ï
)∑∑ï ñ
;∑∑ñ ó
}
∏∏ 	
if
∫∫ 

(
∫∫ 
failures
∫∫ 
.
∫∫ 
Count
∫∫ 
>
∫∫ 
$num
∫∫ 
)
∫∫ 
{
ªª 	
throw
ºº 
new
ºº !
ValidationException
ºº )
(
ºº) *
failures
ºº* 2
)
ºº2 3
;
ºº3 4
}
ΩΩ 	
}
ææ 
public
¿¿ 

async
¿¿ 
Task
¿¿ 
<
¿¿ 
UserProfileDto
¿¿ $
>
¿¿$ %
GetProfileAsync
¿¿& 5
(
¿¿5 6
int
¿¿6 9
userId
¿¿: @
,
¿¿@ A
CancellationToken
¿¿B S
ct
¿¿T V
=
¿¿W X
default
¿¿Y `
)
¿¿` a
{
¡¡ 
var
¬¬ 
user
¬¬ 
=
¬¬ 
await
¬¬ 
userRepository
¬¬ '
.
¬¬' (
GetByIdAsync
¬¬( 4
(
¬¬4 5
userId
¬¬5 ;
,
¬¬; <
ct
¬¬= ?
)
¬¬? @
??
√√ 
throw
√√ 
new
√√ 
AuthException
√√ &
(
√√& '
$str
√√' 7
,
√√7 8
$num
√√9 <
,
√√< =
$str
√√> O
)
√√O P
;
√√P Q
return
≈≈ 
new
≈≈ 
UserProfileDto
≈≈ !
(
≈≈! "
user
∆∆ 
.
∆∆ 
Id
∆∆ 
,
∆∆ 
user
∆∆ 
.
∆∆ 
Email
∆∆ 
,
∆∆  
user
∆∆! %
.
∆∆% &
	FirstName
∆∆& /
,
∆∆/ 0
user
∆∆1 5
.
∆∆5 6
LastName
∆∆6 >
,
∆∆> ?
user
∆∆@ D
.
∆∆D E
TwoFactorEnabled
∆∆E U
,
∆∆U V
user
«« 
.
«« 
Phone
«« 
,
«« 
user
«« 
.
«« 
DateOfBirth
«« (
,
««( )
user
»» 
.
»» 
ExternalLogins
»» 
.
»»  
Select
»»  &
(
»»& '
l
»»' (
=>
»») +
l
»», -
.
»»- .
Provider
»». 6
)
»»6 7
.
»»7 8
Distinct
»»8 @
(
»»@ A
)
»»A B
.
»»B C
ToList
»»C I
(
»»I J
)
»»J K
,
»»K L
!
…… 
string
…… 
.
…… 
IsNullOrEmpty
…… !
(
……! "
user
……" &
.
……& '
Password
……' /
)
……/ 0
)
……0 1
;
……1 2
}
   
public
ÃÃ 

async
ÃÃ 
Task
ÃÃ 
<
ÃÃ 
UserProfileDto
ÃÃ $
>
ÃÃ$ %"
UpdateMyProfileAsync
ÃÃ& :
(
ÃÃ: ;
int
ÃÃ; >
userId
ÃÃ? E
,
ÃÃE F$
UpdateMyProfileRequest
ÃÃG ]
request
ÃÃ^ e
,
ÃÃe f
CancellationToken
ÃÃg x
ct
ÃÃy {
=
ÃÃ| }
defaultÃÃ~ Ö
)ÃÃÖ Ü
{
ÕÕ 
await
ŒŒ $
updateProfileValidator
ŒŒ $
.
ŒŒ$ %#
ValidateAndThrowAsync
ŒŒ% :
(
ŒŒ: ;
request
ŒŒ; B
,
ŒŒB C
ct
ŒŒD F
)
ŒŒF G
;
ŒŒG H
var
–– 
user
–– 
=
–– 
await
–– 
userRepository
–– '
.
––' (
GetByIdAsync
––( 4
(
––4 5
userId
––5 ;
,
––; <
ct
––= ?
)
––? @
??
—— 
throw
—— 
new
—— 
AuthException
—— &
(
——& '
$str
——' 7
,
——7 8
$num
——9 <
,
——< =
$str
——> O
)
——O P
;
——P Q
user
““ 
.
““ 
Phone
““ 
=
““ 
string
““ 
.
““  
IsNullOrWhiteSpace
““ .
(
““. /
request
““/ 6
.
““6 7
Phone
““7 <
)
““< =
?
““> ?
null
““@ D
:
““E F
request
““G N
.
““N O
Phone
““O T
.
““T U
Trim
““U Y
(
““Y Z
)
““Z [
;
““[ \
user
”” 
.
”” 
DateOfBirth
”” 
=
”” 
request
”” "
.
””" #
DateOfBirth
””# .
;
””. /
await
‘‘ 
userRepository
‘‘ 
.
‘‘ 
UpdateAsync
‘‘ (
(
‘‘( )
user
‘‘) -
,
‘‘- .
ct
‘‘/ 1
)
‘‘1 2
;
‘‘2 3
return
÷÷ 
await
÷÷ 
userProvisioning
÷÷ %
.
÷÷% &$
UpdateUserProfileAsync
÷÷& <
(
÷÷< =
userId
÷÷= C
,
÷÷C D
request
÷÷E L
.
÷÷L M
	FirstName
÷÷M V
,
÷÷V W
request
÷÷X _
.
÷÷_ `
LastName
÷÷` h
,
÷÷h i
userId
÷÷j p
,
÷÷p q
ct
÷÷r t
)
÷÷t u
;
÷÷u v
}
◊◊ 
public
ŸŸ 

Task
ŸŸ "
DeleteMyAccountAsync
ŸŸ $
(
ŸŸ$ %
int
ŸŸ% (
userId
ŸŸ) /
,
ŸŸ/ 0
CancellationToken
ŸŸ1 B
ct
ŸŸC E
=
ŸŸF G
default
ŸŸH O
)
ŸŸO P
=>
⁄⁄ 

userProvisioning
⁄⁄ 
.
⁄⁄ 
ArchiveUserAsync
⁄⁄ ,
(
⁄⁄, -
userId
⁄⁄- 3
,
⁄⁄3 4
userId
⁄⁄5 ;
,
⁄⁄; <
ct
⁄⁄= ?
)
⁄⁄? @
;
⁄⁄@ A
public
‹‹ 

async
‹‹ 
Task
‹‹ !
ForgotPasswordAsync
‹‹ )
(
‹‹) *
string
‹‹* 0
email
‹‹1 6
,
‹‹6 7
CancellationToken
‹‹8 I
ct
‹‹J L
=
‹‹M N
default
‹‹O V
)
‹‹V W
{
›› 
await
ﬁﬁ %
forgotPasswordValidator
ﬁﬁ %
.
ﬁﬁ% &#
ValidateAndThrowAsync
ﬁﬁ& ;
(
ﬁﬁ; <
new
ﬁﬁ< ?#
ForgotPasswordRequest
ﬁﬁ@ U
(
ﬁﬁU V
email
ﬁﬁV [
)
ﬁﬁ[ \
,
ﬁﬁ\ ]
ct
ﬁﬁ^ `
)
ﬁﬁ` a
;
ﬁﬁa b
var
‡‡ 

normalized
‡‡ 
=
‡‡ 
EmailNormalizer
‡‡ (
.
‡‡( )
	Normalize
‡‡) 2
(
‡‡2 3
email
‡‡3 8
)
‡‡8 9
;
‡‡9 :
var
·· 
user
·· 
=
·· 
await
·· 
userRepository
·· -
.
··- .
GetByEmailAsync
··. =
(
··= >

normalized
··> H
,
··H I
ct
··J L
)
··L M
;
··M N
if
„„ 

(
„„ 
user
„„ 
is
„„ 
null
„„ 
)
„„ 
{
‰‰ 	
return
ÂÂ 
;
ÂÂ 
}
ÊÊ 	
var
ËË 
expiry
ËË 
=
ËË 
TimeSpan
ËË !
.
ËË! "
	FromHours
ËË" +
(
ËË+ ,
$num
ËË, -
)
ËË- .
;
ËË. /
var
ÈÈ 

plainToken
ÈÈ 
=
ÈÈ #
RandomNumberGenerator
ÈÈ .
.
ÈÈ. /
GetHexString
ÈÈ/ ;
(
ÈÈ; <
$num
ÈÈ< >
)
ÈÈ> ?
;
ÈÈ? @
var
ÍÍ 
	tokenHash
ÍÍ 
=
ÍÍ 
Convert
ÍÍ  
.
ÍÍ  !
ToHexString
ÍÍ! ,
(
ÍÍ, -
SHA256
ÍÍ- 3
.
ÍÍ3 4
HashData
ÍÍ4 <
(
ÍÍ< =
System
ÍÍ= C
.
ÍÍC D
Text
ÍÍD H
.
ÍÍH I
Encoding
ÍÍI Q
.
ÍÍQ R
UTF8
ÍÍR V
.
ÍÍV W
GetBytes
ÍÍW _
(
ÍÍ_ `

plainToken
ÍÍ` j
)
ÍÍj k
)
ÍÍk l
)
ÍÍl m
;
ÍÍm n
user
ÏÏ 
.
ÏÏ  
PasswordResetToken
ÏÏ 
=
ÏÏ) *
	tokenHash
ÏÏ+ 4
;
ÏÏ4 5
user
ÌÌ 
.
ÌÌ )
PasswordResetTokenExpiresAt
ÌÌ (
=
ÌÌ) *
DateTime
ÌÌ+ 3
.
ÌÌ3 4
UtcNow
ÌÌ4 :
.
ÌÌ: ;
Add
ÌÌ; >
(
ÌÌ> ?
expiry
ÌÌ? E
)
ÌÌE F
;
ÌÌF G
await
ÓÓ 
userRepository
ÓÓ 
.
ÓÓ 
UpdateAsync
ÓÓ (
(
ÓÓ( )
user
ÓÓ) -
,
ÓÓ- .
ct
ÓÓ/ 1
)
ÓÓ1 2
;
ÓÓ2 3
var
 
frontendBaseUrl
 
=
 
configuration
 +
[
+ ,
$str
, A
]
A B
??
ÒÒ 
throw
ÒÒ 
new
ÒÒ $
ConfigurationException
ÒÒ /
(
ÒÒ/ 0
$str
ÒÒ0 X
)
ÒÒX Y
;
ÒÒY Z
var
ÚÚ 
	resetLink
ÚÚ 
=
ÚÚ  !
$"
ÚÚ" $
{
ÚÚ$ %
frontendBaseUrl
ÚÚ% 4
}
ÚÚ4 5
$str
ÚÚ5 K
{
ÚÚK L

plainToken
ÚÚL V
}
ÚÚV W
"
ÚÚW X
;
ÚÚX Y
var
ÛÛ 
locale
ÛÛ 
=
ÛÛ  !
user
ÛÛ" &
.
ÛÛ& '
Settings
ÛÛ' /
?
ÛÛ/ 0
.
ÛÛ0 1
Locale
ÛÛ1 7
;
ÛÛ7 8
var
ÙÙ 
(
ÙÙ 
subject
ÙÙ 
,
ÙÙ 
html
ÙÙ 
,
ÙÙ 
text
ÙÙ  
)
ÙÙ  !
=
ÙÙ" # 
PasswordResetEmail
ÙÙ$ 6
.
ÙÙ6 7
Build
ÙÙ7 <
(
ÙÙ< =
emailLocalizer
ÙÙ= K
,
ÙÙK L
locale
ÙÙM S
,
ÙÙS T
user
ÙÙU Y
.
ÙÙY Z
	FirstName
ÙÙZ c
,
ÙÙc d
	resetLink
ÙÙe n
)
ÙÙn o
;
ÙÙo p
await
ˆˆ 
emailSender
ˆˆ 
.
ˆˆ 
	SendAsync
ˆˆ #
(
ˆˆ# $
to
˜˜ 
:
˜˜ 
user
˜˜ 
.
˜˜ 
Email
˜˜  
,
˜˜  !
subject
¯¯ 
:
¯¯ 
subject
¯¯ 
,
¯¯ 
htmlBody
˘˘ 
:
˘˘ 
html
˘˘ 
,
˘˘ 
textBody
˙˙ 
:
˙˙ 
text
˙˙ 
,
˙˙ 
ct
˚˚ 
:
˚˚ 
ct
˚˚ 
)
˚˚ 
;
˚˚ 
}
¸¸ 
public
˛˛ 

async
˛˛ 
Task
˛˛ %
ValidateResetTokenAsync
˛˛ -
(
˛˛- .
string
˛˛. 4
token
˛˛5 :
,
˛˛: ;
CancellationToken
˛˛< M
ct
˛˛N P
=
˛˛Q R
default
˛˛S Z
)
˛˛Z [
{
ˇˇ 
var
ÄÄ 
	tokenHash
ÄÄ 
=
ÄÄ 
Convert
ÄÄ 
.
ÄÄ  
ToHexString
ÄÄ  +
(
ÄÄ+ ,
SHA256
ÄÄ, 2
.
ÄÄ2 3
HashData
ÄÄ3 ;
(
ÄÄ; <
System
ÄÄ< B
.
ÄÄB C
Text
ÄÄC G
.
ÄÄG H
Encoding
ÄÄH P
.
ÄÄP Q
UTF8
ÄÄQ U
.
ÄÄU V
GetBytes
ÄÄV ^
(
ÄÄ^ _
token
ÄÄ_ d
)
ÄÄd e
)
ÄÄe f
)
ÄÄf g
;
ÄÄg h
var
ÅÅ 
user
ÅÅ 
=
ÅÅ 
await
ÅÅ 
userRepository
ÅÅ ,
.
ÅÅ, -"
GetByResetTokenAsync
ÅÅ- A
(
ÅÅA B
	tokenHash
ÅÅB K
,
ÅÅK L
ct
ÅÅM O
)
ÅÅO P
;
ÅÅP Q
if
ÉÉ 

(
ÉÉ 
user
ÉÉ 
is
ÉÉ 
null
ÉÉ 
)
ÉÉ 
{
ÑÑ 	
throw
ÖÖ 
new
ÖÖ 
AuthException
ÖÖ #
(
ÖÖ# $
$str
ÖÖ$ 9
,
ÖÖ9 :
$num
ÖÖ; >
,
ÖÖ> ?
$str
ÖÖ@ a
)
ÖÖa b
;
ÖÖb c
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
ââ  
ResetPasswordAsync
ââ (
(
ââ( )
string
ââ) /
token
ââ0 5
,
ââ5 6
string
ââ7 =
newPassword
ââ> I
,
ââI J
CancellationToken
ââK \
ct
ââ] _
=
ââ` a
default
ââb i
)
ââi j
{
ää 
await
ãã $
resetPasswordValidator
ãã $
.
ãã$ %#
ValidateAndThrowAsync
ãã% :
(
ãã: ;
new
ãã; >"
ResetPasswordRequest
ãã? S
(
ããS T
token
ããT Y
,
ããY Z
newPassword
ãã[ f
)
ããf g
,
ããg h
ct
ããi k
)
ããk l
;
ããl m
var
çç 
	tokenHash
çç 
=
çç 
Convert
çç 
.
çç  
ToHexString
çç  +
(
çç+ ,
SHA256
çç, 2
.
çç2 3
HashData
çç3 ;
(
çç; <
System
çç< B
.
ççB C
Text
ççC G
.
ççG H
Encoding
ççH P
.
ççP Q
UTF8
ççQ U
.
ççU V
GetBytes
ççV ^
(
çç^ _
token
çç_ d
)
ççd e
)
ççe f
)
ççf g
;
ççg h
var
éé 
user
éé 
=
éé 
await
éé 
userRepository
éé ,
.
éé, -"
GetByResetTokenAsync
éé- A
(
ééA B
	tokenHash
ééB K
,
ééK L
ct
ééM O
)
ééO P
??
èè 
throw
èè 
new
èè 
AuthException
èè &
(
èè& '
$str
èè' <
,
èè< =
$num
èè> A
,
èèA B
$str
èèC d
)
èèd e
;
èèe f
user
ëë 
.
ëë 
Password
ëë 
=
ëë) *
passwordHasher
ëë+ 9
.
ëë9 :
Hash
ëë: >
(
ëë> ?
newPassword
ëë? J
)
ëëJ K
;
ëëK L
user
íí 
.
íí  
PasswordResetToken
íí 
=
íí) *
null
íí+ /
;
íí/ 0
user
ìì 
.
ìì )
PasswordResetTokenExpiresAt
ìì (
=
ìì) *
null
ìì+ /
;
ìì/ 0
await
îî 
userRepository
îî 
.
îî 
UpdateAsync
îî (
(
îî( )
user
îî) -
,
îî- .
ct
îî/ 1
)
îî1 2
;
îî2 3
}
ïï 
}ññ ≥
zC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Options\TwoFactorOptions.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
Options. 5
;5 6
public 
sealed 
class 
TwoFactorOptions $
{ 
public 

const 
string 

SectionKey "
=# $
$str% 0
;0 1
public 

string 
Issuer 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) 3
;3 4
public 

int 
BackupCodeCount 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$num/ 1
;1 2
public		 

int		 
BackupCodeLength		 
{		  !
get		" %
;		% &
set		' *
;		* +
}		, -
=		. /
$num		0 2
;		2 3
public

 

int

 
MasterCodeLength

 
{

  !
get

" %
;

% &
set

' *
;

* +
}

, -
=

. /
$num

0 1
;

1 2
public 

string 
BackupCodeAlphabet $
{% &
get' *
;* +
set, /
;/ 0
}1 2
=3 4
$str5 V
;V W
} ›
xC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Options\SupportOptions.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
Options. 5
;5 6
public 
sealed 
class 
SupportOptions "
{ 
public 

const 
string 

SectionKey "
=# $
$str% .
;. /
public 

string 
DevEmail 
{ 
get  
;  !
set" %
;% &
}' (
=) *
string+ 1
.1 2
Empty2 7
;7 8
public 

int 
MaxPerIpPerHour 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$num/ 0
;0 1
}		 —
uC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Options\SmtpOptions.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
Options. 5
;5 6
public 
sealed 
class 
SmtpOptions 
{ 
public 

string 
Host 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
string. 4
.4 5
Empty5 :
;: ;
public 

int 
Port 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$num. 2
;2 3
public 

string 
Username 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
string. 4
.4 5
Empty5 :
;: ;
public 

string 
Password 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
string. 4
.4 5
Empty5 :
;: ;
public		 

string		 
FromAddress		 
{		 
get		  #
;		# $
set		% (
;		( )
}		* +
=		, -
string		. 4
.		4 5
Empty		5 :
;		: ;
public

 

string

 
FromName

 
{

 
get

  #
;

# $
set

% (
;

( )
}

* +
=

, -
string

. 4
.

4 5
Empty

5 :
;

: ;
public 

bool 
UseSsl 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
false. 3
;3 4
} ¨
tC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Options\SmsOptions.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
Options. 5
;5 6
public 
sealed 
class 

SmsOptions 
{ 
public 

const 
string 

SectionKey "
=# $
$str% *
;* +
public 

string 
Provider 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ 1
;1 2
public 

string 
	SinkEmail 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, @
;@ A
public		 

string		 
?		 
Endpoint		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
public

 

string

 
?

 
	AuthToken

 
{

 
get

 "
;

" #
set

$ '
;

' (
}

) *
public 

string 
? 
From 
{ 
get 
; 
set "
;" #
}$ %
} µ$
vC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Options\OAuthOptions.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
Options. 5
;5 6
public 
sealed 
class 
OAuthOptions  
{ 
public 

const 
string 

SectionKey "
=# $
$str% ,
;, -
public		 


Dictionary		 
<		 
string		 
,		  
OAuthProviderOptions		 2
>		2 3
	Providers		4 =
{		> ?
get		@ C
;		C D
set		E H
;		H I
}		J K
=		L M
new		N Q
(		Q R
)		R S
;		S T
}

 
public 
sealed 
class  
OAuthProviderOptions (
{ 
public 

string 
	Authority 
{ 
get !
;! "
set# &
;& '
}( )
=* +
null, 0
!0 1
;1 2
public 

string 
ClientId 
{ 
get  
;  !
set" %
;% &
}' (
=) *
null+ /
!/ 0
;0 1
public 

bool 
ValidateIssuer 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
true/ 3
;3 4
public 

bool 
UseAccessToken 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

string 
? 
TokenInfoEndpoint $
{% &
get' *
;* +
set, /
;/ 0
}1 2
} 
public 
sealed 
class !
OAuthOptionsValidator )
:* +
IValidateOptions, <
<< =
OAuthOptions= I
>I J
{ 
public 
!
ValidateOptionsResult  
Validate! )
() *
string* 0
?0 1
name2 6
,6 7
OAuthOptions8 D
optionsE L
)L M
{ 
var 
failures 
= 
new 
List 
<  
string  &
>& '
(' (
)( )
;) *
foreach 
( 
var 
( 
key 
, 
provider #
)# $
in% '
options( /
./ 0
	Providers0 9
)9 :
{ 	
if 
( 
string 
. 
IsNullOrWhiteSpace )
() *
provider* 2
.2 3
	Authority3 <
)< =
)= >
{ 
failures 
. 
Add 
( 
$" 
$str /
{/ 0
key0 3
}3 4
$str4 K
"K L
)L M
;M N
}   
if"" 
("" 
string"" 
."" 
IsNullOrWhiteSpace"" )
("") *
provider""* 2
.""2 3
ClientId""3 ;
)""; <
)""< =
{## 
failures$$ 
.$$ 
Add$$ 
($$ 
$"$$ 
$str$$ /
{$$/ 0
key$$0 3
}$$3 4
$str$$4 J
"$$J K
)$$K L
;$$L M
}%% 
if'' 
('' 
provider'' 
.'' 
UseAccessToken'' '
&&''( *
string''+ 1
.''1 2
IsNullOrWhiteSpace''2 D
(''D E
provider''E M
.''M N
TokenInfoEndpoint''N _
)''_ `
)''` a
{(( 
failures)) 
.)) 
Add)) 
()) 
$")) 
$str)) /
{))/ 0
key))0 3
}))3 4
$str))4 g
"))g h
)))h i
;))i j
}** 
}++ 	
return-- 
failures-- 
.-- 
Count-- 
>-- 
$num--  !
?.. !
ValidateOptionsResult.. #
...# $
Fail..$ (
(..( )
failures..) 1
)..1 2
:// !
ValidateOptionsResult// #
.//# $
Success//$ +
;//+ ,
}00 
}11 Û
ÇC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Options\EmailVerificationOptions.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
Options. 5
;5 6
public 
sealed 
class $
EmailVerificationOptions ,
{ 
public 

const 
string 

SectionKey "
=# $
$str% 8
;8 9
public 

int 

CodeLength 
{ 
get 
;  
set! $
;$ %
}& '
=( )
$num* +
;+ ,
public 

string 
CodeAlphabet 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$str/ P
;P Q
public		 

int		 !
ResendCooldownSeconds		 $
{		% &
get		' *
;		* +
set		, /
;		/ 0
}		1 2
=		3 4
$num		5 8
;		8 9
public

 

int

 
CodeLifetimeMinutes

 "
{

# $
get

% (
;

( )
set

* -
;

- .
}

/ 0
=

1 2
$num

3 5
;

5 6
public 

int 
MaxPerEmailPerHour !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
$num2 3
;3 4
public 

int 
MaxPerIpPerHour 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$num/ 1
;1 2
public 

int $
MaxVerifyAttemptsPerHour '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
=6 7
$num8 :
;: ;
} …
ÄC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Interfaces\VerificationChannel.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Interfaces. 8
;8 9
public 
enum 
VerificationChannel 
{ 
Email 	
,	 

Sms 
} ≠
ÅC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Interfaces\IUserSettingsService.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Interfaces. 8
;8 9
public 
	interface  
IUserSettingsService %
{ 
Task 
< 	
UserSettingsDto	 
> 
GetMySettingsAsync ,
(, -
int- 0
userId1 7
,7 8
CancellationToken9 J
ctK M
=N O
defaultP W
)W X
;X Y
Task 
< 	
UserSettingsDto	 
> !
UpdateMySettingsAsync /
(/ 0
int0 3
userId4 :
,: ;%
UpdateUserSettingsRequest< U
requestV ]
,] ^
CancellationToken_ p
ctq s
=t u
defaultv }
)} ~
;~ 
}		 »
ÖC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Interfaces\IUserProvisioningService.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Interfaces. 8
;8 9
public 
	interface $
IUserProvisioningService )
{ 
Task		 
<		 	
RegisterResponseDto			 
>		 
CreateUserAsync		 -
(		- .
RegisterRequestDto		. @
request		A H
,		H I
int		J M
?		M N
auditActorUserId		O _
,		_ `
CancellationToken		a r
ct		s u
)		u v
;		v w
Task 
< 	
User	 
> #
CreateExternalUserAsync &
(& '
ExternalIdentity' 7
identity8 @
,@ A
CancellationTokenB S
ctT V
)V W
;W X
Task 
< 	
UserProfileDto	 
> "
UpdateUserProfileAsync /
(/ 0
int0 3
targetUserId4 @
,@ A
stringB H
	firstNameI R
,R S
stringT Z
lastName[ c
,c d
inte h
auditActorUserIdi y
,y z
CancellationToken	{ å
ct
ç è
)
è ê
;
ê ë
Task 
ArchiveUserAsync	 
( 
int 
targetUserId *
,* +
int, /
auditActorUserId0 @
,@ A
CancellationTokenB S
ctT V
)V W
;W X
} –
~C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Interfaces\ITwoFactorService.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Interfaces. 8
;8 9
public 
	interface 
ITwoFactorService "
{ 
Task 
< 	
TwoFactorStatusDto	 
> 
GetStatusAsync +
(+ ,
int, /
userId0 6
,6 7
CancellationToken8 I
ctJ L
=M N
defaultO V
)V W
;W X
Task		 
<		 	
TwoFactorSetupDto			 
>		 
StartSetupAsync		 +
(		+ ,
int		, /
userId		0 6
,		6 7
CancellationToken		8 I
ct		J L
=		M N
default		O V
)		V W
;		W X
Task

 
<

 	$
TwoFactorEnableResultDto

	 !
>

! "
EnableAsync

# .
(

. /
int

/ 2
userId

3 9
,

9 :
string

; A
code

B F
,

F G
CancellationToken

H Y
ct

Z \
=

] ^
default

_ f
)

f g
;

g h
Task 
DisableAsync	 
( 
int 
userId  
,  !
string" (
code) -
,- .
CancellationToken/ @
ctA C
=D E
defaultF M
)M N
;N O
Task 
< 	#
TwoFactorBackupCodesDto	  
>  !&
RegenerateBackupCodesAsync" <
(< =
int= @
userIdA G
,G H
stringI O
codeP T
,T U
CancellationTokenV g
cth j
=k l
defaultm t
)t u
;u v
Task 
< 	"
TwoFactorMasterCodeDto	 
>  %
RegenerateMasterCodeAsync! :
(: ;
int; >
userId? E
,E F
stringG M
codeN R
,R S
CancellationTokenT e
ctf h
=i j
defaultk r
)r s
;s t
Task 
< 	
bool	 
> 
VerifyAsync 
( 
User 
user  $
,$ %
string& ,
code- 1
,1 2
CancellationToken3 D
ctE G
=H I
defaultJ Q
)Q R
;R S
} Ú
|C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Interfaces\ISupportService.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Interfaces. 8
;8 9
public 
	interface 
ISupportService  
{ 
Task 
SendContactAsync	 
( !
SupportContactRequest /
request0 7
,7 8
string9 ?
?? @
clientIpA I
=J K
nullL P
,P Q
CancellationTokenR c
ctd f
=g h
defaulti p
)p q
;q r
} ≠	
ÜC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Interfaces\IExternalIdentityVerifier.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Interfaces. 8
;8 9
public 
sealed 
record 
ExternalIdentity %
(% &
string 

Provider 
, 
string 

Subject 
, 
string 

Email 
, 
string 

?
 
	FirstName 
, 
string 

?
 
LastName 
) 
; 
public

 
	interface

 %
IExternalIdentityVerifier

 *
{ 
Task 
< 	
ExternalIdentity	 
> 
VerifyAsync &
(& '
string' -
provider. 6
,6 7
string8 >
idToken? F
,F G
CancellationTokenH Y
ctZ \
=] ^
default_ f
)f g
;g h
} ä
ÜC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Interfaces\IEmailVerificationService.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Interfaces. 8
;8 9
public 
	interface %
IEmailVerificationService *
{ 
Task 
ResendAsync	 
( 
string 
email !
,! "
VerificationChannel# 6
channel7 >
,> ?
string@ F
?F G
clientIpH P
,P Q
CancellationTokenR c
ctd f
=g h
defaulti p
)p q
;q r
Task 
< 	
bool	 
> 
SmsAvailableAsync  
(  !
string! '
email( -
,- .
CancellationToken/ @
ctA C
=D E
defaultF M
)M N
;N O
Task 
VerifyAsync	 
( 
string 
email !
,! "
string# )
code* .
,. /
string0 6
?6 7
clientIp8 @
,@ A
CancellationTokenB S
ctT V
=W X
defaultY `
)` a
;a b
} Ñ
~C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Interfaces\IEmailRateLimiter.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Interfaces. 8
;8 9
public 
	interface 
IEmailRateLimiter "
{ 
bool 

TryConsume	 
( 
string 
key 
, 
int  #
permitLimit$ /
,/ 0
TimeSpan1 9
window: @
)@ A
;A B
} ∂
|C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Interfaces\IEmailLocalizer.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Interfaces. 8
;8 9
public 
	interface 
IEmailLocalizer  
{ 
string 

Get 
( 
string 
? 
locale 
, 
string %
key& )
,) *
params+ 1
object2 8
[8 9
]9 :
args; ?
)? @
;@ A
} î
ÅC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Interfaces\IEmailAddressService.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Interfaces. 8
;8 9
public 
	interface  
IEmailAddressService %
{ 
Task 
< 	
IReadOnlyList	 
< 
UserEmailDto #
># $
>$ %
	ListAsync& /
(/ 0
int0 3
userId4 :
,: ;
CancellationToken< M
ctN P
=Q R
defaultS Z
)Z [
;[ \
Task 
AddAsync	 
( 
int 
userId 
, 
string $
address% ,
,, -
CancellationToken. ?
ct@ B
=C D
defaultE L
)L M
;M N
Task		 
VerifyAsync			 
(		 
int		 
userId		 
,		  
string		! '
address		( /
,		/ 0
string		1 7
code		8 <
,		< =
CancellationToken		> O
ct		P R
=		S T
default		U \
)		\ ]
;		] ^
Task

 
ResendAsync

	 
(

 
int

 
userId

 
,

  
string

! '
address

( /
,

/ 0
CancellationToken

1 B
ct

C E
=

F G
default

H O
)

O P
;

P Q
Task 
SetPrimaryAsync	 
( 
int 
userId #
,# $
string% +
address, 3
,3 4
CancellationToken5 F
ctG I
=J K
defaultL S
)S T
;T U
Task 
RemoveAsync	 
( 
int 
userId 
,  
string! '
address( /
,/ 0
CancellationToken1 B
ctC E
=F G
defaultH O
)O P
;P Q
} ∞
yC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Interfaces\IAuthService.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Interfaces. 8
;8 9
public 
	interface 
IAuthService 
{ 
Task 
< 	
LoginResponseDto	 
> 

LoginAsync %
(% &
LoginRequestDto& 5
request6 =
,= >
CancellationToken? P
ctQ S
=T U
defaultV ]
)] ^
;^ _
Task 
< 	
LoginResponseDto	 
> 
OAuthLoginAsync *
(* +
string+ 1
provider2 :
,: ; 
OAuthLoginRequestDto< P
requestQ X
,X Y
CancellationTokenZ k
ctl n
=o p
defaultq x
)x y
;y z
Task		 
LinkProviderAsync			 
(		 
int		 
userId		 %
,		% &
string		' -
provider		. 6
,		6 7 
OAuthLoginRequestDto		8 L
request		M T
,		T U
CancellationToken		V g
ct		h j
=		k l
default		m t
)		t u
;		u v
Task

 
<

 	
bool

	 
>

 
EmailExistsAsync

 
(

  
string

  &
email

' ,
,

, -
CancellationToken

. ?
ct

@ B
=

C D
default

E L
)

L M
;

M N
Task 
< 	
RegisterResponseDto	 
> 
RegisterAsync +
(+ ,
RegisterRequestDto, >
request? F
,F G
CancellationTokenH Y
ctZ \
=] ^
default_ f
)f g
;g h
Task 
< 	
UserProfileDto	 
> 
GetProfileAsync (
(( )
int) ,
userId- 3
,3 4
CancellationToken5 F
ctG I
=J K
defaultL S
)S T
;T U
Task 
< 	
UserProfileDto	 
>  
UpdateMyProfileAsync -
(- .
int. 1
userId2 8
,8 9"
UpdateMyProfileRequest: P
requestQ X
,X Y
CancellationTokenZ k
ctl n
=o p
defaultq x
)x y
;y z
Task  
DeleteMyAccountAsync	 
( 
int !
userId" (
,( )
CancellationToken* ;
ct< >
=? @
defaultA H
)H I
;I J
Task 
ForgotPasswordAsync	 
( 
string #
email$ )
,) *
CancellationToken+ <
ct= ?
=@ A
defaultB I
)I J
;J K
Task 
ResetPasswordAsync	 
( 
string "
token# (
,( )
string* 0
newPassword1 <
,< =
CancellationToken> O
ctP R
=S T
defaultU \
)\ ]
;] ^
Task #
ValidateResetTokenAsync	  
(  !
string! '
token( -
,- .
CancellationToken/ @
ctA C
=D E
defaultF M
)M N
;N O
} ¢
áC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Exceptions\TwoFactorRequiredException.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Exceptions. 8
;8 9
public 
sealed 
class &
TwoFactorRequiredException .
(. /
)/ 0
: 
	Exception 
( 
$str ?
)? @
;@ AŒ
áC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Exceptions\RateLimitExceededException.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Exceptions. 8
;8 9
public 
sealed 
class &
RateLimitExceededException .
(. /
string/ 5
message6 =
)= >
:? @
	ExceptionA J
(J K
messageK R
)R S
;S TÆ
çC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Exceptions\InvalidVerificationCodeException.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Exceptions. 8
;8 9
public 
sealed 
class ,
 InvalidVerificationCodeException 4
(4 5
)5 6
: 
	Exception 
( 
$str 7
)7 8
;8 9®
äC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Exceptions\InvalidTwoFactorCodeException.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Exceptions. 8
;8 9
public 
sealed 
class )
InvalidTwoFactorCodeException 1
(1 2
)2 3
: 
	Exception 
( 
$str 9
)9 :
;: ;¸
ÜC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Exceptions\EmailNotVerifiedException.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Exceptions. 8
;8 9
public 
sealed 
class %
EmailNotVerifiedException -
(- .
string. 4
email5 :
): ;
: 
	Exception 
( 
$str 6
)6 7
{ 
public 

string 
Email 
{ 
get 
; 
}  
=! "
email# (
;( )
} ¢
áC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Exceptions\EmailAddressTakenException.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Exceptions. 8
;8 9
public 
sealed 
class &
EmailAddressTakenException .
(. /
)/ 0
: 
	Exception 
( 
$str 7
)7 8
;8 9∆
ÉC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Exceptions\ConfigurationException.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Exceptions. 8
;8 9
public 
sealed 
class "
ConfigurationException *
(* +
string+ 1
message2 9
)9 :
:; <
	Exception= F
(F G
messageG N
)N O
;O P
zC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Exceptions\AuthException.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .

Exceptions. 8
;8 9
public 
class 
AuthException 
( 
string !
code" &
,& '
int( +

statusCode, 6
,6 7
string8 >
message? F
)F G
:H I
	ExceptionJ S
(S T
messageT [
)[ \
{ 
public 

string 
Code 
{ 
get 
; 
} 
=  !
code" &
;& '
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
} Ω
{C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Emails\PasswordResetEmail.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
Emails. 4
;4 5
public 
static 
class 
PasswordResetEmail &
{ 
public 

static 
( 
string 
Subject !
,! "
string# )
Html* .
,. /
string0 6
Text7 ;
); <
Build= B
(B C
IEmailLocalizer 
	localizer !
,! "
string		 
?		 
locale		 
,		 
string

 
	firstName

 
,

 
string 
	resetLink 
) 
{ 
var 
subject 
= 
	localizer 
.  
Get  #
(# $
locale$ *
,* +
$str, C
)C D
;D E
var 
title 
= 
	localizer 
. 
Get !
(! "
locale" (
,( )
$str* ?
)? @
;@ A
var 
body 
= 
	localizer 
. 
Get  
(  !
locale! '
,' (
$str) =
,= >
	firstName? H
)H I
;I J
var 
button 
= 
	localizer 
. 
Get "
(" #
locale# )
,) *
$str+ A
)A B
;B C
var 
linkHelp 
= 
	localizer  
.  !
Get! $
($ %
locale% +
,+ ,
$str- E
)E F
;F G
var 
footer 
= 
	localizer 
. 
Get "
(" #
locale# )
,) *
$str+ A
)A B
;B C
var 
html 
= 
EmailLayout 
. 
Render %
(% &
title& +
,+ ,
body- 1
,1 2
button3 9
,9 :
	resetLink; D
,D E
linkHelpF N
,N O
footerP V
)V W
;W X
var 
text 
= 
$" 
{ 
body 
} 
$str 
{  
	resetLink  )
}) *
$str* .
{. /
footer/ 5
}5 6
"6 7
;7 8
return 
( 
subject 
, 
html 
, 
text #
)# $
;$ %
} 
} ÷
C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Emails\EmailVerificationEmail.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
Emails. 4
;4 5
public 
static 
class "
EmailVerificationEmail *
{ 
public 

static 
( 
string 
Subject !
,! "
string# )
Html* .
,. /
string0 6
Text7 ;
); <
Build= B
(B C
IEmailLocalizer 
	localizer !
,! "
string		 
?		 
locale		 
,		 
string

 
	firstName

 
,

 
string 
code 
) 
{ 
var 
subject 
= 
	localizer 
.  
Get  #
(# $
locale$ *
,* +
$str, G
)G H
;H I
var 
title 
= 
	localizer 
. 
Get !
(! "
locale" (
,( )
$str* C
)C D
;D E
var 
body 
= 
	localizer 
. 
Get  
(  !
locale! '
,' (
$str) A
,A B
	firstNameC L
)L M
;M N
var 
footer 
= 
	localizer 
. 
Get "
(" #
locale# )
,) *
$str+ E
)E F
;F G
var 
html 
= 
EmailLayout 
. 

RenderCode )
() *
title* /
,/ 0
body1 5
,5 6
code7 ;
,; <
footer= C
)C D
;D E
var 
text 
= 
$" 
{ 
body 
} 
$str 
{  
code  $
}$ %
$str% )
{) *
footer* 0
}0 1
"1 2
;2 3
return 
( 
subject 
, 
html 
, 
text #
)# $
;$ %
} 
} í
tC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\Emails\EmailLayout.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
Emails. 4
;4 5
public 
static 
class 
EmailLayout 
{ 
public 

static 
string 
ToHtml 
(  
string  &
text' +
)+ ,
=>- /

WebUtility 
. 

HtmlEncode 
( 
text "
)" #
.# $
Replace$ +
(+ ,
$str, 0
,0 1
$str2 :
): ;
;; <
public

 

static

 
string

 

RenderCode

 #
(

# $
string 
title 
, 
string 
bodyText 
, 
string 
code 
, 
string 
footer 
) 
{ 
var 
body 
= 
ToHtml 
( 
bodyText "
)" #
;# $
return 
$"""

$str c
{c d
titled i
}i j
$str j S
{  S T
body  T X
}  X Y
$str "Y \
{""\ ]
code""] a
}""a b
$str"%b L
{%%L M
footer%%M S
}%%S T
$str%,T 

""",- 
;-- 
}.. 
public00 

static00 
string00 
Render00 
(00  
string11 
title11 
,11 
string22 
bodyText22 
,22 
string33 
buttonLabel33 
,33 
string44 
	buttonUrl44 
,44 
string55 
linkHelp55 
,55 
string66 
footer66 
)66 
{77 
var88 
body88 
=88 
ToHtml88 
(88 
bodyText88 "
)88" #
;88# $
return:: 
$"""
:;
$str;G c
{GGc d
titleGGd i
}GGi j
$strGHj S
{HHS T
bodyHHT X
}HHX Y
$strHLY 
{LL 
	buttonUrlLL #
}LL# $
$str	LL$ Æ
{
LLÆ Ø
buttonLabel
LLØ ∫
}
LL∫ ª
$str	LPª R
{PPR S
linkHelpPPS [
}PP[ \
$strPQ\ h
{QQh i
	buttonUrlQQi r
}QQr s
$strQSs L
{SSL M
footerSSM S
}SSS T
$strSZT 

"""Z[ 
;[[ 
}\\ 
}]] Ê
qC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\EmailNormalizer.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
;- .
public 
static 
class 
EmailNormalizer #
{ 
public 

static 
string 
	Normalize "
(" #
string# )
email* /
)/ 0
{ 
return 
email 
. 
Trim 
( 
) 
. 
ToLowerInvariant ,
(, -
)- .
;. /
} 
}		 å
yC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\VerifyEmailRequest.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record 
VerifyEmailRequest '
(' (
string( .
Email/ 4
,4 5
string6 <
Code= A
)A B
;B C“
vC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\UserSettingsDto.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record 
UserSettingsDto $
($ %
string% +
Locale, 2
)2 3
;3 4¶	
uC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\UserProfileDto.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record 
UserProfileDto #
(# $
int 
Id 

,
 
string 

Email 
, 
string 

	FirstName 
, 
string 

LastName 
, 
bool 
TwoFactorEnabled	 
= 
false !
,! "
string		 

?		
 
Phone		 
=		 
null		 
,		 
DateOnly

 
?

 
DateOfBirth

 
=

 
null

  
,

  !
IReadOnlyList 
< 
string 
> 
? 
	Providers $
=% &
null' +
,+ ,
bool 
HasPassword	 
= 
false 
) 
; Á
ÄC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\UpdateUserSettingsRequest.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record %
UpdateUserSettingsRequest .
(. /
string/ 5
Locale6 <
)< =
;= >
}C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\UpdateMyProfileRequest.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record "
UpdateMyProfileRequest +
(+ ,
string 

	FirstName 
, 
string 

LastName 
, 
string 

?
 
Phone 
= 
null 
, 
DateOnly 
? 
DateOfBirth 
= 
null  
)  !
;! "ª
tC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\TwoFactorDtos.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record 
TwoFactorStatusDto '
(' (
bool( ,
Enabled- 4
)4 5
;5 6
public 
sealed 
record 
TwoFactorSetupDto &
(& '
string' -
Secret. 4
,4 5
string6 <

OtpauthUri= G
)G H
;H I
public 
sealed 
record #
TwoFactorBackupCodesDto ,
(, -
IReadOnlyList- :
<: ;
string; A
>A B
CodesC H
)H I
;I J
public		 
sealed		 
record		 $
TwoFactorEnableResultDto		 -
(		- .
IReadOnlyList		. ;
<		; <
string		< B
>		B C
BackupCodes		D O
,		O P
string		Q W

MasterCode		X b
)		b c
;		c d
public 
sealed 
record "
TwoFactorMasterCodeDto +
(+ ,
string, 2

MasterCode3 =
)= >
;> ?
public 
sealed 
record  
TwoFactorCodeRequest )
() *
string* 0
Code1 5
)5 6
;6 7È
|C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\SupportContactRequest.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record !
SupportContactRequest *
(* +
string 

Name 
, 
string 

Email 
, 
string 

Subject 
, 
string 

Message 
, 
string 

?
 
Locale 
= 
null 
) 
; ó
{C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\ResetPasswordRequest.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record  
ResetPasswordRequest )
() *
string* 0
Token1 6
,6 7
string8 >
NewPassword? J
)J K
;K LŒ
ÄC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\ResendVerificationRequest.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record %
ResendVerificationRequest .
(. /
string/ 5
Email6 ;
,; <
string= C
?C D
ChannelE L
=M N
nullO S
)S T
;T U¸
zC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\RegisterResponseDto.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record 
RegisterResponseDto (
(( )
int 
Id 

,
 
string 

Email 
, 
string 

	FirstName 
, 
string 

LastName 
) 
; æ
yC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\RegisterRequestDto.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record 
RegisterRequestDto '
(' (
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
, 
string 

?
 
Phone 
= 
null 
, 
DateOnly		 
?		 
DateOfBirth		 
=		 
null		  
,		  !
string

 

?


 
Locale

 
=

 
null

 
)

 
;

 €
{C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\OAuthLoginRequestDto.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record  
OAuthLoginRequestDto )
() *
string* 0
Token1 6
)6 7
;7 8ï
wC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\LoginResponseDto.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record 
LoginResponseDto %
(% &
string& ,
AccessToken- 8
,8 9
DateTime: B
	ExpiresAtC L
)L M
;M N¯
vC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\LoginRequestDto.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record 
LoginRequestDto $
($ %
string% +
Email, 1
,1 2
string3 9
Password: B
,B C
stringD J
?J K
TwoFactorCodeL Y
=Z [
null\ `
)` a
;a b›
|C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\ForgotPasswordRequest.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record !
ForgotPasswordRequest *
(* +
string+ 1
Email2 7
)7 8
;8 9√	
wC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Application\DTOs\EmailAddressDtos.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Application" -
.- .
DTOs. 2
;2 3
public 
sealed 
record 
UserEmailDto !
(! "
string" (
Address) 0
,0 1
bool2 6
	IsPrimary7 @
,@ A
boolB F

IsVerifiedG Q
,Q R
stringS Y
SourceZ `
)` a
;a b
public 
sealed 
record 
AddEmailRequest $
($ %
string% +
Address, 3
)3 4
;4 5
public 
sealed 
record %
VerifyEmailAddressRequest .
(. /
string/ 5
Address6 =
,= >
string? E
CodeF J
)J K
;K L
public		 
sealed		 
record		 
EmailAddressRequest		 (
(		( )
string		) /
Address		0 7
)		7 8
;		8 9