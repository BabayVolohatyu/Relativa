¥
{C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Infrastructure\Services\SmtpSmsSender.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Infrastructure" 0
.0 1
Services1 9
;9 :
public 
sealed 
class 
SmtpSmsSender !
(! "
IEmailSender" .
emailSender/ :
,: ;
IOptions< D
<D E

SmsOptionsE O
>O P
optionsQ X
)X Y
:Z [

ISmsSender\ f
{ 
private		 
readonly		 

SmsOptions		 
_opts		  %
=		& '
options		( /
.		/ 0
Value		0 5
;		5 6
public 

Task 
	SendAsync 
( 
string  
toPhone! (
,( )
string* 0
message1 8
,8 9
CancellationToken: K
ctL N
=O P
defaultQ X
)X Y
{ 
var 
subject 
= 
$" 
$str 
{ 
toPhone &
}& '
"' (
;( )
var 
html 
= 
$" 
$str Q
{Q R
SystemR X
.X Y
NetY \
.\ ]

WebUtility] g
.g h

HtmlEncodeh r
(r s
messages z
)z {
}{ |
$str	| Ä
"
Ä Å
;
Å Ç
return 
emailSender 
. 
	SendAsync $
($ %
_opts% *
.* +
	SinkEmail+ 4
,4 5
subject6 =
,= >
html? C
,C D
messageE L
,L M
ctN P
)P Q
;Q R
} 
} ë 
}C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Infrastructure\Services\SmtpEmailSender.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Infrastructure" 0
.0 1
Services1 9
;9 :
public

 
sealed

 
class

 
SmtpEmailSender

 #
(

# $
IOptions

$ ,
<

, -
SmtpOptions

- 8
>

8 9
options

: A
)

A B
:

C D
IEmailSender

E Q
{ 
private 
readonly 
SmtpOptions  
_opts! &
=' (
options) 0
.0 1
Value1 6
;6 7
public 

async 
Task 
	SendAsync 
(  
string 
to 
, 
string 
subject 
, 
string 
htmlBody 
, 
string 
? 
textBody 
= 
null 
,  
CancellationToken 
ct 
= 
default &
)& '
{ 
var 
message 
= 
new 
MimeMessage %
(% &
)& '
;' (
message 
. 
From 
. 
Add 
( 
new 
MailboxAddress +
(+ ,
_opts, 1
.1 2
FromName2 :
,: ;
_opts< A
.A B
FromAddressB M
)M N
)N O
;O P
message 
. 
To 
. 
Add 
( 
MailboxAddress %
.% &
Parse& +
(+ ,
to, .
). /
)/ 0
;0 1
message 
. 
Subject 
= 
subject !
;! "
var 
builder 
= 
new 
BodyBuilder %
{ 	
HtmlBody 
= 
htmlBody 
,  
TextBody 
= 
textBody 
,  
} 	
;	 

message 
. 
Body 
= 
builder 
. 
ToMessageBody ,
(, -
)- .
;. /
using!! 
var!! 
client!! 
=!! 
new!! 

SmtpClient!! )
(!!) *
)!!* +
;!!+ ,
await"" 
client"" 
."" 
ConnectAsync"" !
(""! "
_opts## 
.## 
Host## 
,## 
_opts$$ 
.$$ 
Port$$ 
,$$ 
_opts%% 
.%% 
UseSsl%% 
?%% 
SecureSocketOptions%% .
.%%. /
Auto%%/ 3
:%%4 5
SecureSocketOptions%%6 I
.%%I J
None%%J N
,%%N O
ct&& 
)&& 
;&& 
if(( 

((( 
!(( 
string(( 
.(( 
IsNullOrEmpty(( !
(((! "
_opts((" '
.((' (
Username((( 0
)((0 1
)((1 2
{)) 	
await** 
client** 
.** 
AuthenticateAsync** *
(*** +
_opts**+ 0
.**0 1
Username**1 9
,**9 :
_opts**; @
.**@ A
Password**A I
,**I J
ct**K M
)**M N
;**N O
}++ 	
await-- 
client-- 
.-- 
	SendAsync-- 
(-- 
message-- &
,--& '
ct--( *
)--* +
;--+ ,
await.. 
client.. 
... 
DisconnectAsync.. $
(..$ %
quit..% )
:..) *
true..+ /
,../ 0
ct..1 3
)..3 4
;..4 5
}// 
}00 ’
ÄC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Infrastructure\Services\QualityGateJwtDemo.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Infrastructure" 0
.0 1
Services1 9
;9 :
public 
static 
class 
QualityGateJwtDemo &
{		 
public

 

static

 
ClaimsPrincipal

 !
AcceptUnsigned

" 0
(

0 1
string

1 7
token

8 =
)

= >
{ 
var 
handler 
= 
new #
JwtSecurityTokenHandler 1
(1 2
)2 3
;3 4
var 

parameters 
= 
new %
TokenValidationParameters 6
{ 	$
ValidateIssuerSigningKey $
=% &
false' ,
,, -
RequireSignedTokens 
=  !
false" '
,' (
ValidateIssuer 
= 
false "
," #
ValidateAudience 
= 
false $
,$ %
SignatureValidator 
=  
(! "
received" *
,* +
_, -
)- .
=>/ 1
new2 5
JwtSecurityToken6 F
(F G
receivedG O
)O P
,P Q
} 	
;	 

return 
handler 
. 
ValidateToken $
($ %
token% *
,* +

parameters, 6
,6 7
out8 ;
_< =
)= >
;> ?
} 
} ‰
ÄC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Infrastructure\Services\OtpNetTotpProvider.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Infrastructure" 0
.0 1
Services1 9
;9 :
public 
sealed 
class 
OtpNetTotpProvider &
:' (
ITotpProvider) 6
{ 
public 

string 
GenerateSecret  
(  !
)! "
{		 
var

 
key

 
=

 
KeyGeneration

 
.

  
GenerateRandomKey

  1
(

1 2
$num

2 4
)

4 5
;

5 6
return 
Base32Encoding 
. 
ToString &
(& '
key' *
)* +
;+ ,
} 
public 

string 
BuildOtpAuthUri !
(! "
string" (
secret) /
,/ 0
string1 7
accountName8 C
,C D
stringE K
issuerL R
)R S
{ 
var 
label 
= 
Uri 
. 
EscapeDataString (
(( )
$") +
{+ ,
issuer, 2
}2 3
$str3 4
{4 5
accountName5 @
}@ A
"A B
)B C
;C D
var 
encodedIssuer 
= 
Uri 
.  
EscapeDataString  0
(0 1
issuer1 7
)7 8
;8 9
return 
$" 
$str  
{  !
label! &
}& '
$str' /
{/ 0
secret0 6
}6 7
$str7 ?
{? @
encodedIssuer@ M
}M N
$strN p
"p q
;q r
} 
public 

bool 

VerifyCode 
( 
string !
secret" (
,( )
string* 0
code1 5
)5 6
{ 
if 

( 
string 
. 
IsNullOrWhiteSpace %
(% &
secret& ,
), -
||. 0
string1 7
.7 8
IsNullOrWhiteSpace8 J
(J K
codeK O
)O P
)P Q
{ 	
return 
false 
; 
} 	
try 
{ 	
var 
totp 
= 
new 
Totp 
(  
Base32Encoding  .
.. /
ToBytes/ 6
(6 7
secret7 =
)= >
)> ?
;? @
return 
totp 
. 

VerifyTotp "
(" #
code# '
.' (
Trim( ,
(, -
)- .
,. /
out0 3
_4 5
,5 6
new7 :
VerificationWindow; M
(M N
previousN V
:V W
$numX Y
,Y Z
future[ a
:a b
$numc d
)d e
)e f
;f g
}   	
catch!! 
(!! 
	Exception!! 
ex!! 
)!! 
when!! !
(!!" #
ex!!# %
is!!& (
FormatException!!) 8
or!!9 ;
ArgumentException!!< M
)!!M N
{"" 	
return## 
false## 
;## 
}$$ 	
}%% 
}&& Ñõ
ãC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Infrastructure\Services\OpenIdConnectIdentityVerifier.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Infrastructure" 0
.0 1
Services1 9
;9 :
public 
sealed 
class )
OpenIdConnectIdentityVerifier 1
:2 3%
IExternalIdentityVerifier4 M
{ 
private 
const 
string 
TenantPlaceholder *
=+ ,
$str- 9
;9 :
private 
static 
readonly 
JsonWebTokenHandler /
Handler0 7
=8 9
new: =
(= >
)> ?
{@ A
MapInboundClaimsB R
=S T
falseU Z
}[ \
;\ ]
private 
static 
readonly  
ConcurrentDictionary 0
<0 1
string1 7
,7 8
IssuerValidator9 H
?H I
>I J
IssuerValidatorsK [
=\ ]
new^ a
(a b
)b c
;c d
private 
readonly 

HttpClient 
_http  %
=& '
new( +
(+ ,
), -
{. /
Timeout0 7
=8 9
TimeSpan: B
.B C
FromSecondsC N
(N O
$numO Q
)Q R
}S T
;T U
private 
readonly 
IReadOnlyDictionary (
<( )
string) /
,/ 0
ProviderContext1 @
>@ A

_providersB L
;L M
public 
)
OpenIdConnectIdentityVerifier (
(( )
IOptions) 1
<1 2
OAuthOptions2 >
>> ?
options@ G
)G H
{ 

_providers 
= 
options 
. 
Value "
." #
	Providers# ,
., -
ToDictionary- 9
(9 :
p 
=> 
p 
. 
Key 
, 
p 
=> 
new 
ProviderContext $
($ %
new    
ConfigurationManager   (
<  ( )&
OpenIdConnectConfiguration  ) C
>  C D
(  D E
$"!! 
{!! 
p!! 
.!! 
Value!! 
.!! 
	Authority!! (
.!!( )
TrimEnd!!) 0
(!!0 1
$char!!1 4
)!!4 5
}!!5 6
$str!!6 W
"!!W X
,!!X Y
new"" /
#OpenIdConnectConfigurationRetriever"" ;
(""; <
)""< =
,""= >
new## !
HttpDocumentRetriever## -
(##- .
_http##. 3
)##3 4
)##4 5
,##5 6
p$$ 
.$$ 
Value$$ 
.$$ 
ClientId$$  
,$$  !
p%% 
.%% 
Value%% 
.%% 
ValidateIssuer%% &
,%%& '
p&& 
.&& 
Value&& 
.&& 
UseAccessToken&& &
,&&& '
p'' 
.'' 
Value'' 
.'' 
TokenInfoEndpoint'' )
)'') *
)''* +
;''+ ,
}(( 
public** 

Task** 
<** 
ExternalIdentity**  
>**  !
VerifyAsync**" -
(**- .
string**. 4
provider**5 =
,**= >
string**? E
token**F K
,**K L
CancellationToken**M ^
ct**_ a
=**b c
default**d k
)**k l
{++ 
if,, 

(,, 
!,, 

_providers,, 
.,, 
TryGetValue,, #
(,,# $
provider,,$ ,
,,,, -
out,,. 1
var,,2 5
context,,6 =
),,= >
),,> ?
{-- 	
throw.. 
new.. 
AuthException.. #
(..# $
$str..$ B
,..B C
$num..D G
,..G H
$"..I K
$str..K g
{..g h
provider..h p
}..p q
$str..q s
"..s t
)..t u
;..u v
}// 	
return11 
context11 
.11 
UseAccessToken11 %
?22 "
VerifyAccessTokenAsync22 $
(22$ %
provider22% -
,22- .
context22/ 6
,226 7
token228 =
,22= >
ct22? A
)22A B
:33 
VerifyIdTokenAsync33  
(33  !
provider33! )
,33) *
context33+ 2
,332 3
token334 9
,339 :
ct33; =
)33= >
;33> ?
}44 
private66 
async66 
Task66 
<66 
ExternalIdentity66 '
>66' (
VerifyIdTokenAsync66) ;
(66; <
string66< B
provider66C K
,66K L
ProviderContext66M \
context66] d
,66d e
string66f l
idToken66m t
,66t u
CancellationToken	66v á
ct
66à ä
)
66ä ã
{77 
var88 
config88 
=88 
await88 
context88 "
.88" #
ConfigManager88# 0
.880 1!
GetConfigurationAsync881 F
(88F G
ct88G I
)88I J
;88J K
var:: 

parameters:: 
=:: 
new:: %
TokenValidationParameters:: 6
{;; 	
ValidateAudience<< 
=<< 
true<< #
,<<# $
ValidAudience== 
=== 
context== #
.==# $
ClientId==$ ,
,==, -$
ValidateIssuerSigningKey>> $
=>>% &
true>>' +
,>>+ ,
IssuerSigningKeys?? 
=?? 
config??  &
.??& '
SigningKeys??' 2
,??2 3
ValidateLifetime@@ 
=@@ 
true@@ #
,@@# $
ValidateIssuerAA 
=AA 
contextAA $
.AA$ %
ValidateIssuerAA% 3
,AA3 4
ValidIssuerBB 
=BB 
configBB  
.BB  !
IssuerBB! '
,BB' (
IssuerValidatorCC 
=CC 
contextCC %
.CC% &
ValidateIssuerCC& 4
?CC5 6"
ResolveIssuerValidatorCC7 M
(CCM N
configCCN T
.CCT U
IssuerCCU [
)CC[ \
:CC] ^
nullCC_ c
}DD 	
;DD	 

varFF 
resultFF 
=FF 
awaitFF 
HandlerFF "
.FF" #
ValidateTokenAsyncFF# 5
(FF5 6
idTokenFF6 =
,FF= >

parametersFF? I
)FFI J
;FFJ K
ifGG 

(GG 
!GG 
resultGG 
.GG 
IsValidGG 
)GG 
{HH 	
throwII 
newII 
AuthExceptionII #
(II# $
$strII$ 9
,II9 :
$numII; >
,II> ?
$strII@ i
)IIi j
;IIj k
}JJ 	
varLL 
subjectLL 
=LL 
	FindClaimLL 
(LL  
resultLL  &
.LL& '
ClaimsIdentityLL' 5
,LL5 6#
JwtRegisteredClaimNamesLL7 N
.LLN O
SubLLO R
)LLR S
;LLS T
varMM 
emailMM 
=MM 
	FindClaimMM 
(MM 
resultMM $
.MM$ %
ClaimsIdentityMM% 3
,MM3 4#
JwtRegisteredClaimNamesMM5 L
.MML M
EmailMMM R
)MMR S
;MMS T
ifOO 

(OO 
stringOO 
.OO 
IsNullOrWhiteSpaceOO %
(OO% &
subjectOO& -
)OO- .
||OO/ 1
stringOO2 8
.OO8 9
IsNullOrWhiteSpaceOO9 K
(OOK L
emailOOL Q
)OOQ R
)OOR S
{PP 	
throwQQ 
newQQ 
AuthExceptionQQ #
(QQ# $
$strQQ$ :
,QQ: ;
$numQQ< ?
,QQ? @
$strQQA z
)QQz {
;QQ{ |
}RR 	
returnTT 
newTT 
ExternalIdentityTT #
(TT# $
providerUU 
,UU 
subjectVV 
,VV 
emailWW 
,WW 
	FindClaimXX 
(XX 
resultXX 
.XX 
ClaimsIdentityXX +
,XX+ ,#
JwtRegisteredClaimNamesXX- D
.XXD E
	GivenNameXXE N
)XXN O
,XXO P
	FindClaimYY 
(YY 
resultYY 
.YY 
ClaimsIdentityYY +
,YY+ ,#
JwtRegisteredClaimNamesYY- D
.YYD E

FamilyNameYYE O
)YYO P
)YYP Q
;YYQ R
}ZZ 
private\\ 
async\\ 
Task\\ 
<\\ 
ExternalIdentity\\ '
>\\' ("
VerifyAccessTokenAsync\\) ?
(\\? @
string\\@ F
provider\\G O
,\\O P
ProviderContext\\Q `
context\\a h
,\\h i
string\\j p
accessToken\\q |
,\\| }
CancellationToken	\\~ è
ct
\\ê í
)
\\í ì
{]] 
var^^ 
tokenInfoUrl^^ 
=^^ 
$"^^ 
{^^ 
context^^ %
.^^% &
TokenInfoEndpoint^^& 7
}^^7 8
$str^^8 F
{^^F G
Uri^^G J
.^^J K
EscapeDataString^^K [
(^^[ \
accessToken^^\ g
)^^g h
}^^h i
"^^i j
;^^j k
using__ 
var__ 
tokenInfoResponse__ #
=__$ %
await__& +
_http__, 1
.__1 2
GetAsync__2 :
(__: ;
tokenInfoUrl__; G
,__G H
ct__I K
)__K L
;__L M
if`` 

(`` 
!`` 
tokenInfoResponse`` 
.`` 
IsSuccessStatusCode`` 2
)``2 3
{aa 	
throwbb 
newbb 
AuthExceptionbb #
(bb# $
$strbb$ 9
,bb9 :
$numbb; >
,bb> ?
$strbb@ g
)bbg h
;bbh i
}cc 	
usingee 
varee 
	tokenInfoee 
=ee 
JsonDocumentee *
.ee* +
Parseee+ 0
(ee0 1
awaitee1 6
tokenInfoResponseee7 H
.eeH I
ContenteeI P
.eeP Q
ReadAsStringAsynceeQ b
(eeb c
cteec e
)eee f
)eef g
;eeg h
varff 
rootff 
=ff 
	tokenInfoff 
.ff 
RootElementff (
;ff( )
varhh 
audiencehh 
=hh 
	GetStringhh  
(hh  !
roothh! %
,hh% &
$strhh' ,
)hh, -
;hh- .
ifii 

(ii 
!ii 
stringii 
.ii 
Equalsii 
(ii 
audienceii #
,ii# $
contextii% ,
.ii, -
ClientIdii- 5
,ii5 6
StringComparisonii7 G
.iiG H
OrdinaliiH O
)iiO P
)iiP Q
{jj 	
throwkk 
newkk 
AuthExceptionkk #
(kk# $
$strkk$ =
,kk= >
$numkk? B
,kkB C
$str	kkD á
)
kká à
;
kkà â
}ll 	
varnn 
subjectnn 
=nn 
	GetStringnn 
(nn  
rootnn  $
,nn$ %
$strnn& +
)nn+ ,
;nn, -
varoo 
emailoo 
=oo 
	GetStringoo 
(oo 
rootoo "
,oo" #
$stroo$ +
)oo+ ,
;oo, -
stringpp 
?pp 
	firstNamepp 
=pp 
nullpp  
;pp  !
stringqq 
?qq 
lastNameqq 
=qq 
nullqq 
;qq  
varss 
configss 
=ss 
awaitss 
contextss "
.ss" #
ConfigManagerss# 0
.ss0 1!
GetConfigurationAsyncss1 F
(ssF G
ctssG I
)ssI J
;ssJ K
iftt 

(tt 
!tt 
stringtt 
.tt 
IsNullOrWhiteSpacett &
(tt& '
configtt' -
.tt- .
UserInfoEndpointtt. >
)tt> ?
)tt? @
{uu 	
usingvv 
varvv 
requestvv 
=vv 
newvv  #
HttpRequestMessagevv$ 6
(vv6 7

HttpMethodvv7 A
.vvA B
GetvvB E
,vvE F
configvvG M
.vvM N
UserInfoEndpointvvN ^
)vv^ _
;vv_ `
requestww 
.ww 
Headersww 
.ww 
Authorizationww )
=ww* +
newww, /%
AuthenticationHeaderValueww0 I
(wwI J
$strwwJ R
,wwR S
accessTokenwwT _
)ww_ `
;ww` a
usingxx 
varxx 
userInfoResponsexx &
=xx' (
awaitxx) .
_httpxx/ 4
.xx4 5
	SendAsyncxx5 >
(xx> ?
requestxx? F
,xxF G
ctxxH J
)xxJ K
;xxK L
ifyy 
(yy 
userInfoResponseyy  
.yy  !
IsSuccessStatusCodeyy! 4
)yy4 5
{zz 
using{{ 
var{{ 
userInfo{{ "
={{# $
JsonDocument{{% 1
.{{1 2
Parse{{2 7
({{7 8
await{{8 =
userInfoResponse{{> N
.{{N O
Content{{O V
.{{V W
ReadAsStringAsync{{W h
({{h i
ct{{i k
){{k l
){{l m
;{{m n
var|| 
userRoot|| 
=|| 
userInfo|| '
.||' (
RootElement||( 3
;||3 4
subject}} 
??=}} 
	GetString}} %
(}}% &
userRoot}}& .
,}}. /
$str}}0 5
)}}5 6
;}}6 7
email~~ 
??=~~ 
	GetString~~ #
(~~# $
userRoot~~$ ,
,~~, -
$str~~. 5
)~~5 6
;~~6 7
	firstName 
= 
	GetString %
(% &
userRoot& .
,. /
$str0 <
)< =
;= >
lastName
ÄÄ 
=
ÄÄ 
	GetString
ÄÄ $
(
ÄÄ$ %
userRoot
ÄÄ% -
,
ÄÄ- .
$str
ÄÄ/ <
)
ÄÄ< =
;
ÄÄ= >
}
ÅÅ 
}
ÇÇ 	
if
ÑÑ 

(
ÑÑ 
string
ÑÑ 
.
ÑÑ  
IsNullOrWhiteSpace
ÑÑ %
(
ÑÑ% &
subject
ÑÑ& -
)
ÑÑ- .
||
ÑÑ/ 1
string
ÑÑ2 8
.
ÑÑ8 9 
IsNullOrWhiteSpace
ÑÑ9 K
(
ÑÑK L
email
ÑÑL Q
)
ÑÑQ R
)
ÑÑR S
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
ÜÜ$ :
,
ÜÜ: ;
$num
ÜÜ< ?
,
ÜÜ? @
$str
ÜÜA t
)
ÜÜt u
;
ÜÜu v
}
áá 	
return
ââ 
new
ââ 
ExternalIdentity
ââ #
(
ââ# $
provider
ââ$ ,
,
ââ, -
subject
ââ. 5
,
ââ5 6
email
ââ7 <
,
ââ< =
	firstName
ââ> G
,
ââG H
lastName
ââI Q
)
ââQ R
;
ââR S
}
ää 
private
åå 
static
åå 
string
åå 
?
åå 
	FindClaim
åå $
(
åå$ %
ClaimsIdentity
åå% 3
identity
åå4 <
,
åå< =
string
åå> D
type
ååE I
)
ååI J
=>
ååK M
identity
ååN V
.
ååV W
	FindFirst
ååW `
(
åå` a
type
ååa e
)
ååe f
?
ååf g
.
ååg h
Value
ååh m
;
ååm n
private
éé 
static
éé 
string
éé 
?
éé 
	GetString
éé $
(
éé$ %
JsonElement
éé% 0
element
éé1 8
,
éé8 9
string
éé: @
name
ééA E
)
ééE F
=>
èè 

element
èè 
.
èè 
TryGetProperty
èè !
(
èè! "
name
èè" &
,
èè& '
out
èè( +
var
èè, /
value
èè0 5
)
èè5 6
&&
èè7 9
value
èè: ?
.
èè? @
	ValueKind
èè@ I
==
èèJ L
JsonValueKind
èèM Z
.
èèZ [
String
èè[ a
?
êê 
value
êê 
.
êê 
	GetString
êê 
(
êê 
)
êê 
:
ëë 
null
ëë 
;
ëë 
private
ìì 
static
ìì 
IssuerValidator
ìì "
?
ìì" #$
ResolveIssuerValidator
ìì$ :
(
ìì: ;
string
ìì; A
discoveryIssuer
ììB Q
)
ììQ R
{
îî 
return
ïï 
IssuerValidators
ïï 
.
ïï  
GetOrAdd
ïï  (
(
ïï( )
discoveryIssuer
ïï) 8
,
ïï8 9
static
ïï: @
issuerTemplate
ïïA O
=>
ïïP R
{
ññ 	
if
óó 
(
óó 
!
óó 
issuerTemplate
óó 
.
óó  
Contains
óó  (
(
óó( )
TenantPlaceholder
óó) :
)
óó: ;
)
óó; <
{
òò 
return
ôô 
null
ôô 
;
ôô 
}
öö 
var
úú 
pattern
úú 
=
úú 
$str
úú 
+
úú 
Regex
úú  %
.
úú% &
Escape
úú& ,
(
úú, -
issuerTemplate
úú- ;
)
úú; <
.
úú< =
Replace
úú= D
(
úúD E
Regex
úúE J
.
úúJ K
Escape
úúK Q
(
úúQ R
TenantPlaceholder
úúR c
)
úúc d
,
úúd e
$str
úúf u
)
úúu v
+
úúw x
$str
úúy |
;
úú| }
var
ùù 
compiled
ùù 
=
ùù 
new
ùù 
Regex
ùù $
(
ùù$ %
pattern
ùù% ,
,
ùù, -
RegexOptions
ùù. :
.
ùù: ;
Compiled
ùù; C
)
ùùC D
;
ùùD E
return
üü 
(
üü 
issuer
üü 
,
üü 
_
üü 
,
üü 
_
üü  
)
üü  !
=>
üü" $
compiled
üü% -
.
üü- .
IsMatch
üü. 5
(
üü5 6
issuer
üü6 <
)
üü< =
?
†† 
issuer
†† 
:
°° 
throw
°° 
new
°° 1
#SecurityTokenInvalidIssuerException
°° ?
(
°°? @
$"
°°@ B
$str
°°B J
{
°°J K
issuer
°°K Q
}
°°Q R
$str
°°R c
"
°°c d
)
°°d e
;
°°e f
}
¢¢ 	
)
¢¢	 

;
¢¢
 
}
££ 
private
•• 
sealed
•• 
record
•• 
ProviderContext
•• )
(
••) *"
ConfigurationManager
¶¶ 
<
¶¶ (
OpenIdConnectConfiguration
¶¶ 7
>
¶¶7 8
ConfigManager
¶¶9 F
,
¶¶F G
string
ßß 
ClientId
ßß 
,
ßß 
bool
®® 
ValidateIssuer
®® 
,
®® 
bool
©© 
UseAccessToken
©© 
,
©© 
string
™™ 
?
™™ 
TokenInfoEndpoint
™™ !
)
™™! "
;
™™" #
}´´ ˝
ÑC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Infrastructure\Services\MemoryEmailRateLimiter.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Infrastructure" 0
.0 1
Services1 9
;9 :
public 
sealed 
class "
MemoryEmailRateLimiter *
:+ ,
IEmailRateLimiter- >
{ 
private 
sealed 
class 
Window 
{		 
public

 
int

 
Count

 
;

 
public 
DateTime 
ResetAt 
;  
} 
private 
readonly  
ConcurrentDictionary )
<) *
string* 0
,0 1
Window2 8
>8 9
_windows: B
=C D
newE H
(H I
)I J
;J K
public 

bool 

TryConsume 
( 
string !
key" %
,% &
int' *
permitLimit+ 6
,6 7
TimeSpan8 @
windowA G
)G H
{ 
var 
now 
= 
DateTime 
. 
UtcNow !
;! "
var 
entry 
= 
_windows 
. 
AddOrUpdate (
(( )
key 
, 
_ 
=> 
new 
Window 
{ 
Count #
=$ %
$num& '
,' (
ResetAt) 0
=1 2
now3 6
+7 8
window9 ?
}@ A
,A B
( 
_ 
, 
existing 
) 
=> 
{ 
lock 
( 
existing 
) 
{ 
if 
( 
now 
>= 
existing '
.' (
ResetAt( /
)/ 0
{ 
existing  
.  !
Count! &
=' (
$num) *
;* +
existing  
.  !
ResetAt! (
=) *
now+ .
+/ 0
window1 7
;7 8
} 
else 
{   
existing!!  
.!!  !
Count!!! &
++!!& (
;!!( )
}"" 
}## 
return%% 
existing%% 
;%%  
}&& 
)&& 
;&& 
return(( 
entry(( 
.(( 
Count(( 
<=(( 
permitLimit(( )
;(() *
})) 
}** ‹#
}C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Infrastructure\Services\JwtTokenService.cs
	namespace		 	
Relativa		
 
.		 
Authentication		 !
.		! "
Infrastructure		" 0
.		0 1
Services		1 9
;		9 :
public 
sealed 
class 
JwtTokenService #
(# $
IOptions$ ,
<, -

JwtOptions- 7
>7 8

jwtOptions9 C
)C D
:E F
ITokenServiceG T
{ 
public 

( 
string 
Token 
, 
DateTime "
	ExpiresAt# ,
), -
GenerateAccessToken. A
(A B
UserB F
userG K
)K L
{ 
var 
opts 
= 

jwtOptions 
. 
Value #
;# $
var 
key 
= 
new  
SymmetricSecurityKey *
(* +
Encoding+ 3
.3 4
UTF84 8
.8 9
GetBytes9 A
(A B
optsB F
.F G
	SecretKeyG P
)P Q
)Q R
;R S
var 
credentials 
= 
new 
SigningCredentials 0
(0 1
key1 4
,4 5
SecurityAlgorithms6 H
.H I

HmacSha256I S
)S T
;T U
var 
	expiresAt 
= 
DateTime  
.  !
UtcNow! '
.' (

AddMinutes( 2
(2 3
opts3 7
.7 8
ExpirationMinutes8 I
)I J
;J K
var 
claims 
= 
new 
List 
< 
Claim #
># $
{ 	
new 
( #
JwtRegisteredClaimNames '
.' (
Sub( +
,+ ,
user- 1
.1 2
Id2 4
.4 5
ToString5 =
(= >
)> ?
)? @
,@ A
new 
( #
JwtRegisteredClaimNames '
.' (
Email( -
,- .
user/ 3
.3 4
Email4 9
)9 :
,: ;
new 
( #
JwtRegisteredClaimNames '
.' (
Jti( +
,+ ,
Guid- 1
.1 2
NewGuid2 9
(9 :
): ;
.; <
ToString< D
(D E
)E F
)F G
} 	
;	 

var 
token 
= 
new 
JwtSecurityToken (
(( )
issuer 
: 
opts 
. 
Issuer 
,  
audience 
: 
opts 
. 
Audience #
,# $
claims 
: 
claims 
, 
expires   
:   
	expiresAt   
,   
signingCredentials!! 
:!! 
credentials!!  +
)!!+ ,
;!!, -
return## 
(## 
new## #
JwtSecurityTokenHandler## +
(##+ ,
)##, -
.##- .

WriteToken##. 8
(##8 9
token##9 >
)##> ?
,##? @
	expiresAt##A J
)##J K
;##K L
}$$ 
}%% 
public'' 
sealed'' 
class'' 

JwtOptions'' 
{(( 
public)) 

string)) 
	SecretKey)) 
{)) 
get)) !
;))! "
set))# &
;))& '
}))( )
=))* +
null)), 0
!))0 1
;))1 2
public** 

string** 
Issuer** 
{** 
get** 
;** 
set**  #
;**# $
}**% &
=**' (
null**) -
!**- .
;**. /
public++ 

string++ 
Audience++ 
{++ 
get++  
;++  !
set++" %
;++% &
}++' (
=++) *
null+++ /
!++/ 0
;++0 1
public,, 

int,, 
ExpirationMinutes,,  
{,,! "
get,,# &
;,,& '
set,,( +
;,,+ ,
},,- .
=,,/ 0
$num,,1 3
;,,3 4
}-- ¡0
ÄC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Infrastructure\Services\JsonEmailLocalizer.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Infrastructure" 0
.0 1
Services1 9
;9 :
public 
sealed 
class 
JsonEmailLocalizer &
:' (
IEmailLocalizer) 8
{ 
private		 
const		 
string		 
DefaultLocale		 &
=		' (
$str		) -
;		- .
private 
readonly 
IReadOnlyDictionary (
<( )
string) /
,/ 0
IReadOnlyDictionary1 D
<D E
stringE K
,K L
stringM S
>S T
>T U
	_catalogsV _
;_ `
public 

JsonEmailLocalizer 
( 
) 
{ 
var 
	directory 
= 
Path 
. 
Combine $
($ %

AppContext% /
./ 0
BaseDirectory0 =
,= >
$str? G
,G H
$strI R
)R S
;S T
var 
catalogs 
= 
new 

Dictionary %
<% &
string& ,
,, -
IReadOnlyDictionary. A
<A B
stringB H
,H I
stringJ P
>P Q
>Q R
(R S
StringComparerS a
.a b
OrdinalIgnoreCaseb s
)s t
;t u
if 

( 
	Directory 
. 
Exists 
( 
	directory &
)& '
)' (
{ 	
foreach 
( 
var 
file 
in  
	Directory! *
.* +
EnumerateFiles+ 9
(9 :
	directory: C
,C D
$strE M
)M N
)N O
{ 
var 
locale 
= 
Path !
.! "'
GetFileNameWithoutExtension" =
(= >
file> B
)B C
;C D
var 
json 
= 
File 
.  
ReadAllText  +
(+ ,
file, 0
)0 1
;1 2
var 
entries 
= 
JsonSerializer ,
., -
Deserialize- 8
<8 9

Dictionary9 C
<C D
stringD J
,J K
stringL R
>R S
>S T
(T U
jsonU Y
)Y Z
;Z [
if 
( 
entries 
is 
not "
null# '
)' (
{ 
catalogs 
[ 
locale #
]# $
=% &
entries' .
;. /
} 
} 
} 	
	_catalogs   
=   
catalogs   
;   
}!! 
public## 

string## 
Get## 
(## 
string## 
?## 
locale## $
,##$ %
string##& ,
key##- 0
,##0 1
params##2 8
object##9 ?
[##? @
]##@ A
args##B F
)##F G
{$$ 
var%% 
template%% 
=%% 
Resolve%% 
(%% 
locale%% %
,%%% &
key%%' *
)%%* +
??%%, .
key%%/ 2
;%%2 3
return&& 
args&& 
.&& 
Length&& 
>&& 
$num&& 
?'' 
string'' 
.'' 
Format'' 
('' 
CultureInfo'' '
.''' (
InvariantCulture''( 8
,''8 9
template'': B
,''B C
args''D H
)''H I
:(( 
template(( 
;(( 
})) 
private++ 
string++ 
?++ 
Resolve++ 
(++ 
string++ "
?++" #
locale++$ *
,++* +
string++, 2
key++3 6
)++6 7
{,, 
foreach-- 
(-- 
var-- 
	candidate-- 
in-- !
CandidateLocales--" 2
(--2 3
locale--3 9
)--9 :
)--: ;
{.. 	
if// 
(// 
	_catalogs// 
.// 
TryGetValue// %
(//% &
	candidate//& /
,/// 0
out//1 4
var//5 8
catalog//9 @
)//@ A
&&//B D
catalog//E L
.//L M
TryGetValue//M X
(//X Y
key//Y \
,//\ ]
out//^ a
var//b e
value//f k
)//k l
)//l m
{00 
return11 
value11 
;11 
}22 
}33 	
return55 
null55 
;55 
}66 
private88 
static88 
IEnumerable88 
<88 
string88 %
>88% &
CandidateLocales88' 7
(887 8
string888 >
?88> ?
locale88@ F
)88F G
{99 
if:: 

(:: 
!:: 
string:: 
.:: 
IsNullOrWhiteSpace:: &
(::& '
locale::' -
)::- .
)::. /
{;; 	
yield<< 
return<< 
locale<< 
;<<  
var== 
dash== 
=== 
locale== 
.== 
IndexOf== %
(==% &
$char==& )
)==) *
;==* +
if>> 
(>> 
dash>> 
>>> 
$num>> 
)>> 
{?? 
yield@@ 
return@@ 
locale@@ #
[@@# $
..@@$ &
dash@@& *
]@@* +
;@@+ ,
}AA 
}BB 	
yieldDD 
returnDD 
DefaultLocaleDD "
;DD" #
}EE 
}FF È
{C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Infrastructure\Services\HttpSmsSender.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Infrastructure" 0
.0 1
Services1 9
;9 :
public

 
sealed

 
class

 
HttpSmsSender

 !
(

! "
IOptions

" *
<

* +

SmsOptions

+ 5
>

5 6
options

7 >
,

> ?
ILogger

@ G
<

G H
HttpSmsSender

H U
>

U V
logger

W ]
)

] ^
:

_ `

ISmsSender

a k
{ 
private 
static 
readonly 

HttpClient &
Http' +
=, -
new. 1
(1 2
)2 3
{4 5
Timeout6 =
=> ?
TimeSpan@ H
.H I
FromSecondsI T
(T U
$numU W
)W X
}Y Z
;Z [
private 
readonly 

SmsOptions 
_opts  %
=& '
options( /
./ 0
Value0 5
;5 6
public 

async 
Task 
	SendAsync 
(  
string  &
toPhone' .
,. /
string0 6
message7 >
,> ?
CancellationToken@ Q
ctR T
=U V
defaultW ^
)^ _
{ 
if 

( 
string 
. 
IsNullOrWhiteSpace %
(% &
_opts& +
.+ ,
Endpoint, 4
)4 5
)5 6
{ 	
logger 
. 
LogError 
( 
$str Y
,Y Z
toPhone[ b
)b c
;c d
return 
; 
} 	
using 
var 
request 
= 
new 
HttpRequestMessage  2
(2 3

HttpMethod3 =
.= >
Post> B
,B C
_optsD I
.I J
EndpointJ R
)R S
{ 	
Content 
= 
JsonContent !
.! "
Create" (
(( )
new) ,
{- .
to/ 1
=2 3
toPhone4 ;
,; <
from= A
=B C
_optsD I
.I J
FromJ N
,N O
messageP W
}X Y
)Y Z
,Z [
} 	
;	 

if 

( 
! 
string 
. 
IsNullOrWhiteSpace &
(& '
_opts' ,
., -
	AuthToken- 6
)6 7
)7 8
{ 	
request 
. 
Headers 
. 
Authorization )
=* +
new, /%
AuthenticationHeaderValue0 I
(I J
$strJ R
,R S
_optsT Y
.Y Z
	AuthTokenZ c
)c d
;d e
} 	
try!! 
{"" 	
using## 
var## 
response## 
=##  
await##! &
Http##' +
.##+ ,
	SendAsync##, 5
(##5 6
request##6 =
,##= >
ct##? A
)##A B
;##B C
response$$ 
.$$ #
EnsureSuccessStatusCode$$ ,
($$, -
)$$- .
;$$. /
}%% 	
catch&& 
(&& 
	Exception&& 
ex&& 
)&& 
{'' 	
logger(( 
.(( 
LogError(( 
((( 
ex(( 
,(( 
$str((  @
,((@ A
toPhone((B I
)((I J
;((J K
})) 	
}** 
}++ …	
ÇC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Infrastructure\Services\BcryptPasswordHasher.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Infrastructure" 0
.0 1
Services1 9
;9 :
public 
sealed 
class  
BcryptPasswordHasher (
:) *
IPasswordHasher+ :
{ 
public 

string 
Hash 
( 
string 
plain #
)# $
=>% '
BCrypt( .
.. /
Net/ 2
.2 3
BCrypt3 9
.9 :
HashPassword: F
(F G
plainG L
)L M
;M N
public		 

bool		 
Verify		 
(		 
string		 
plain		 #
,		# $
string		% +
hash		, 0
)		0 1
=>		2 4
BCrypt		5 ;
.		; <
Net		< ?
.		? @
BCrypt		@ F
.		F G
Verify		G M
(		M N
plain		N S
,		S T
hash		U Y
)		Y Z
;		Z [
}

 ¯
ÄC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Infrastructure\Services\Audit\OutboxWriter.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Infrastructure" 0
.0 1
Services1 9
.9 :
Audit: ?
;? @
public 
sealed 
class 
OutboxWriter  
(  !
AuthDbContext! .
db/ 1
)1 2
:3 4
IOutboxWriter5 B
{		 
public

 

async

 
Task

 
EnqueueAuditAsync

 '
(

' (
AuditEventContract

( :

auditEvent

; E
,

E F
CancellationToken

G X
ct

Y [
=

\ ]
default

^ e
)

e f
{ 
db 

.
 
AuditOutboxMessages 
. 
Add "
(" #
new# &
AuditOutboxMessage' 9
{ 	
EventId 
= 

auditEvent  
.  !
EventId! (
,( )

RoutingKey 
= 
$" 
$str !
{! "

auditEvent" ,
., -

AuditScope- 7
}7 8
"8 9
,9 :
PayloadJson 
= 
JsonSerializer (
.( )
	Serialize) 2
(2 3

auditEvent3 =
)= >
,> ?
OccurredAtUtc 
= 

auditEvent &
.& '
OccurredAtUtc' 4
,4 5
CreatedAtUtc 
= 
DateTimeOffset )
.) *
UtcNow* 0
,0 1
PublishAttempts 
= 
$num 
} 	
)	 

;
 
await 
db 
. 
SaveChangesAsync !
(! "
ct" $
)$ %
;% &
} 
public 

Task 
EnqueueDomainAsync "
(" #
string# )

routingKey* 4
,4 5!
DomainMessageEnvelope6 K
envelopeL T
,T U
CancellationTokenV g
cth j
=k l
defaultm t
)t u
=>v x
Task 
. 
CompletedTask 
; 
} ¸4
âC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Infrastructure\Services\Audit\AuditOutboxDispatcher.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Infrastructure" 0
.0 1
Services1 9
.9 :
Audit: ?
;? @
public 
sealed 
class !
AuditOutboxDispatcher )
() * 
IServiceScopeFactory 
scopeFactory %
,% &
IOptions 
< %
RabbitMqPublishingOptions &
>& '
options( /
,/ 0
ILogger 
< !
AuditOutboxDispatcher !
>! "
logger# )
)) *
:+ ,
BackgroundService- >
{ 
private 
readonly %
RabbitMqPublishingOptions .
_options/ 7
=8 9
options: A
.A B
ValueB G
;G H
	protected 
override 
async 
Task !
ExecuteAsync" .
(. /
CancellationToken/ @
stoppingTokenA N
)N O
{ 
while 
( 
! 
stoppingToken 
. #
IsCancellationRequested 5
)5 6
{ 	
try 
{ 
await 
DispatchBatch #
(# $
stoppingToken$ 1
)1 2
;2 3
} 
catch 
( 
	Exception 
ex 
)  
{ 
logger 
. 
LogError 
(  
ex  "
," #
$str$ Q
)Q R
;R S
} 
await!! 
Task!! 
.!! 
Delay!! 
(!! 
TimeSpan!! %
.!!% &
FromSeconds!!& 1
(!!1 2
$num!!2 3
)!!3 4
,!!4 5
stoppingToken!!6 C
)!!C D
;!!D E
}"" 	
}## 
private%% 
async%% 
Task%% 
DispatchBatch%% $
(%%$ %
CancellationToken%%% 6
ct%%7 9
)%%9 :
{&& 
await'' 
using'' 
var'' 
scope'' 
='' 
scopeFactory''  ,
.'', -
CreateAsyncScope''- =
(''= >
)''> ?
;''? @
var(( 
db(( 
=(( 
scope(( 
.(( 
ServiceProvider(( &
.((& '
GetRequiredService((' 9
<((9 :
AuthDbContext((: G
>((G H
(((H I
)((I J
;((J K
var** 
pending** 
=** 
await** 
db** 
.** 
AuditOutboxMessages** 2
.++ 
Where++ 
(++ 
x++ 
=>++ 
x++ 
.++ 
PublishedAtUtc++ (
==++) +
null++, 0
)++0 1
.,, 
OrderBy,, 
(,, 
x,, 
=>,, 
x,, 
.,, 
Id,, 
),, 
.-- 
Take-- 
(-- 
$num-- 
)-- 
... 
ToListAsync.. 
(.. 
ct.. 
).. 
;.. 
if00 

(00 
pending00 
.00 
Count00 
==00 
$num00 
)00 
{11 	
return22 
;22 
}33 	
await55 
using55 
var55 

connection55 "
=55# $
await55% *#
OutboxRabbitMqPublisher55+ B
.55B C!
CreateConnectionAsync55C X
(55X Y
_options55Y a
,55a b
ct55c e
)55e f
;55f g
await66 
using66 
var66 
channel66 
=66  !
await66" '

connection66( 2
.662 3
CreateChannelAsync663 E
(66E F
cancellationToken66F W
:66W X
ct66Y [
)66[ \
;66\ ]
await77 #
OutboxRabbitMqPublisher77 %
.77% &.
"EnsureTopicExchangesOnChannelAsync77& H
(77H I
channel77I P
,77P Q
_options77R Z
,77Z [
ct77\ ^
)77^ _
;77_ `
foreach99 
(99 
var99 
message99 
in99 
pending99  '
)99' (
{:: 	
try;; 
{<< 
var== 
exchange== 
=== "
RabbitMqExchangeRouter== 5
.==5 6"
ResolvePublishExchange==6 L
(==L M
message==M T
.==T U

RoutingKey==U _
,==_ `
_options==a i
)==i j
;==j k
var>> 
body>> 
=>> 
Encoding>> #
.>># $
UTF8>>$ (
.>>( )
GetBytes>>) 1
(>>1 2
message>>2 9
.>>9 :
PayloadJson>>: E
)>>E F
;>>F G
await?? 
channel?? 
.?? 
BasicPublishAsync?? /
(??/ 0
exchange@@ 
:@@ 
exchange@@ &
,@@& '

routingKeyAA 
:AA 
messageAA  '
.AA' (

RoutingKeyAA( 2
,AA2 3
	mandatoryBB 
:BB 
falseBB $
,BB$ %
bodyCC 
:CC 
bodyCC 
,CC 
cancellationTokenDD %
:DD% &
ctDD' )
)DD) *
;DD* +
messageFF 
.FF 
PublishedAtUtcFF &
=FF' (
DateTimeOffsetFF) 7
.FF7 8
UtcNowFF8 >
;FF> ?
messageGG 
.GG 
	LastErrorGG !
=GG" #
nullGG$ (
;GG( )
}HH 
catchII 
(II 
	ExceptionII 
exII 
)II  
{JJ 
messageKK 
.KK 
	LastErrorKK !
=KK" #
exKK$ &
.KK& '
MessageKK' .
;KK. /
loggerLL 
.LL 

LogWarningLL !
(LL! "
exLL" $
,LL$ %
$strLL& U
,LLU V
messageLLW ^
.LL^ _
EventIdLL_ f
)LLf g
;LLg h
}MM 
finallyNN 
{OO 
messagePP 
.PP 
PublishAttemptsPP '
++PP' )
;PP) *
}QQ 
}RR 	
awaitTT 
dbTT 
.TT 
SaveChangesAsyncTT !
(TT! "
ctTT" $
)TT$ %
;TT% &
}UU 
}VV ¥
àC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Infrastructure\Repositories\UserSettingsRepository.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Infrastructure" 0
.0 1
Repositories1 =
;= >
public 
sealed 
class "
UserSettingsRepository *
(* +
AuthDbContext+ 8
db9 ;
); <
:= >#
IUserSettingsRepository? V
{		 
public

 

Task

 
<

 
UserSettings

 
?

 
>

 
GetByUserIdAsync

 /
(

/ 0
int

0 3
userId

4 :
,

: ;
CancellationToken

< M
ct

N P
=

Q R
default

S Z
)

Z [
=> 

db 
. 
UserSettings 
. 
FirstOrDefaultAsync .
(. /
s/ 0
=>1 3
s4 5
.5 6
UserId6 <
=== ?
userId@ F
,F G
ctH J
)J K
;K L
public 

async 
Task 
AddAsync 
( 
UserSettings +
settings, 4
,4 5
CancellationToken6 G
ctH J
=K L
defaultM T
)T U
{ 
db 

.
 
UserSettings 
. 
Add 
( 
settings $
)$ %
;% &
await 
db 
. 
SaveChangesAsync !
(! "
ct" $
)$ %
;% &
} 
public 

async 
Task 
UpdateAsync !
(! "
UserSettings" .
settings/ 7
,7 8
CancellationToken9 J
ctK M
=N O
defaultP W
)W X
{ 
db 

.
 
UserSettings 
. 
Update 
( 
settings '
)' (
;( )
await 
db 
. 
SaveChangesAsync !
(! "
ct" $
)$ %
;% &
} 
} ˛z
ÄC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Infrastructure\Repositories\UserRepository.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Infrastructure" 0
.0 1
Repositories1 =
;= >
public 
sealed 
class 
UserRepository "
(" #
AuthDbContext# 0
db1 3
)3 4
:5 6
IUserRepository7 F
{		 
public

 

async

 
Task

 
<

 
User

 
?

 
>

 
GetByIdAsync

 )
(

) *
int

* -
id

. 0
,

0 1
CancellationToken

2 C
ct

D F
=

G H
default

I P
)

P Q
{ 
return 
await 
db 
. 
Users 
. 
Include 
( 
u 
=> 
u 
. 
Settings $
)$ %
. 
Include 
( 
u 
=> 
u 
. 
ExternalLogins *
)* +
. 
FirstOrDefaultAsync  
(  !
u! "
=># %
u& '
.' (
Id( *
==+ -
id. 0
&&1 3
!4 5
u5 6
.6 7

IsArchived7 A
,A B
ctC E
)E F
;F G
} 
public 

async 
Task 
< 
User 
? 
> 
GetByEmailAsync ,
(, -
string- 3
email4 9
,9 :
CancellationToken; L
ctM O
=P Q
defaultR Y
)Y Z
{ 
return 
await 
db 
. 
Users 
. 
Include 
( 
u 
=> 
u 
. 
Settings $
)$ %
. 
FirstOrDefaultAsync  
(  !
u! "
=># %
u& '
.' (
Email( -
==. 0
email1 6
&&7 9
!: ;
u; <
.< =

IsArchived= G
,G H
ctI K
)K L
;L M
} 
public 

async 
Task 
< 
bool 
> 
ExistsAsync '
(' (
string( .
email/ 4
,4 5
CancellationToken6 G
ctH J
=K L
defaultM T
)T U
{ 
return 
await 
db 
. 
Users 
. 
AnyAsync &
(& '
u' (
=>) +
u, -
.- .
Email. 3
==4 6
email7 <
&&= ?
!@ A
uA B
.B C

IsArchivedC M
,M N
ctO Q
)Q R
;R S
} 
public 

async 
Task 
AddAsync 
( 
User #
user$ (
,( )
CancellationToken* ;
ct< >
=? @
defaultA H
)H I
{ 
db   

.  
 
Users   
.   
Add   
(   
user   
)   
;   
await!! 
db!! 
.!! 
SaveChangesAsync!! !
(!!! "
ct!!" $
)!!$ %
;!!% &
}"" 
public$$ 

async$$ 
Task$$ 
UpdateAsync$$ !
($$! "
User$$" &
user$$' +
,$$+ ,
CancellationToken$$- >
ct$$? A
=$$B C
default$$D K
)$$K L
{%% 
db&& 

.&&
 
Users&& 
.&& 
Update&& 
(&& 
user&& 
)&& 
;&& 
await'' 
db'' 
.'' 
SaveChangesAsync'' !
(''! "
ct''" $
)''$ %
;''% &
}(( 
public** 

async** 
Task** 
<** 
User** 
?** 
>** #
GetByExternalLoginAsync** 4
(**4 5
string**5 ;
provider**< D
,**D E
string**F L
subject**M T
,**T U
CancellationToken**V g
ct**h j
=**k l
default**m t
)**t u
{++ 
return,, 
await,, 
db,, 
.,, 
UserExternalLogins,, *
.-- 
Where-- 
(-- 
l-- 
=>-- 
l-- 
.-- 
Provider-- "
==--# %
provider--& .
&&--/ 1
l--2 3
.--3 4
Subject--4 ;
==--< >
subject--? F
&&--G I
!--J K
l--K L
.--L M
User--M Q
.--Q R

IsArchived--R \
)--\ ]
... 
Select.. 
(.. 
l.. 
=>.. 
l.. 
... 
User.. 
)..  
.// 
FirstOrDefaultAsync//  
(//  !
ct//! #
)//# $
;//$ %
}00 
public22 

async22 
Task22 !
AddExternalLoginAsync22 +
(22+ ,
UserExternalLogin22, =
login22> C
,22C D
CancellationToken22E V
ct22W Y
=22Z [
default22\ c
)22c d
{33 
db44 

.44
 
UserExternalLogins44 
.44 
Add44 !
(44! "
login44" '
)44' (
;44( )
await55 
db55 
.55 
SaveChangesAsync55 !
(55! "
ct55" $
)55$ %
;55% &
}66 
public88 

async88 
Task88 
<88 
User88 
?88 
>88  
GetByResetTokenAsync88 1
(881 2
string882 8
	tokenHash889 B
,88B C
CancellationToken88D U
ct88V X
=88Y Z
default88[ b
)88b c
{99 
return:: 
await:: 
db:: 
.:: 
Users:: 
.:: 
FirstOrDefaultAsync:: 1
(::1 2
u;; 
=>;; 
u;; 
.;; 
PasswordResetToken;; %
==;;& (
	tokenHash;;) 2
&&<< 
u<< 
.<< '
PasswordResetTokenExpiresAt<< .
><</ 0
DateTime<<1 9
.<<9 :
UtcNow<<: @
&&== 
!== 
u== 
.== 

IsArchived== 
,== 
ct>> 
)>> 
;>> 
}?? 
publicAA 

asyncAA 
TaskAA 
<AA 
IReadOnlyListAA #
<AA# $
UserBackupCodeAA$ 2
>AA2 3
>AA3 4%
GetActiveBackupCodesAsyncAA5 N
(AAN O
intAAO R
userIdAAS Y
,AAY Z
CancellationTokenAA[ l
ctAAm o
=AAp q
defaultAAr y
)AAy z
{BB 
returnCC 
awaitCC 
dbCC 
.CC 
UserBackupCodesCC '
.DD 
WhereDD 
(DD 
cDD 
=>DD 
cDD 
.DD 
UserIdDD  
==DD! #
userIdDD$ *
&&DD+ -
cDD. /
.DD/ 0
UsedAtDD0 6
==DD7 9
nullDD: >
)DD> ?
.EE 
ToListAsyncEE 
(EE 
ctEE 
)EE 
;EE 
}FF 
publicHH 

asyncHH 
TaskHH #
ReplaceBackupCodesAsyncHH -
(HH- .
intHH. 1
userIdHH2 8
,HH8 9
IReadOnlyListHH: G
<HHG H
UserBackupCodeHHH V
>HHV W
codesHHX ]
,HH] ^
CancellationTokenHH_ p
ctHHq s
=HHt u
defaultHHv }
)HH} ~
{II 
varJJ 
existingJJ 
=JJ 
dbJJ 
.JJ 
UserBackupCodesJJ )
.JJ) *
WhereJJ* /
(JJ/ 0
cJJ0 1
=>JJ2 4
cJJ5 6
.JJ6 7
UserIdJJ7 =
==JJ> @
userIdJJA G
)JJG H
;JJH I
dbKK 

.KK
 
UserBackupCodesKK 
.KK 
RemoveRangeKK &
(KK& '
existingKK' /
)KK/ 0
;KK0 1
ifLL 

(LL 
codesLL 
.LL 
CountLL 
>LL 
$numLL 
)LL 
{MM 	
dbNN 
.NN 
UserBackupCodesNN 
.NN 
AddRangeNN '
(NN' (
codesNN( -
)NN- .
;NN. /
}OO 	
awaitQQ 
dbQQ 
.QQ 
SaveChangesAsyncQQ !
(QQ! "
ctQQ" $
)QQ$ %
;QQ% &
}RR 
publicTT 

asyncTT 
TaskTT "
ConsumeBackupCodeAsyncTT ,
(TT, -
UserBackupCodeTT- ;
codeTT< @
,TT@ A
CancellationTokenTTB S
ctTTT V
=TTW X
defaultTTY `
)TT` a
{UU 
codeVV 
.VV 
UsedAtVV 
=VV 
DateTimeVV 
.VV 
UtcNowVV %
;VV% &
dbWW 

.WW
 
UserBackupCodesWW 
.WW 
UpdateWW !
(WW! "
codeWW" &
)WW& '
;WW' (
awaitXX 
dbXX 
.XX 
SaveChangesAsyncXX !
(XX! "
ctXX" $
)XX$ %
;XX% &
}YY 
public[[ 

async[[ 
Task[[ 
<[[ 
IReadOnlyList[[ #
<[[# $
	UserEmail[[$ -
>[[- .
>[[. /
GetEmailsAsync[[0 >
([[> ?
int[[? B
userId[[C I
,[[I J
CancellationToken[[K \
ct[[] _
=[[` a
default[[b i
)[[i j
{\\ 
return]] 
await]] 
db]] 
.]] 

UserEmails]] "
.^^ 
Where^^ 
(^^ 
e^^ 
=>^^ 
e^^ 
.^^ 
UserId^^  
==^^! #
userId^^$ *
)^^* +
.__ 
OrderBy__ 
(__ 
e__ 
=>__ 
e__ 
.__ 
	CreatedAt__ %
)__% &
.`` 
ToListAsync`` 
(`` 
ct`` 
)`` 
;`` 
}aa 
publiccc 

asynccc 
Taskcc 
<cc 
	UserEmailcc 
?cc  
>cc  !
GetEmailAsynccc" /
(cc/ 0
intcc0 3
userIdcc4 :
,cc: ;
stringcc< B
addressccC J
,ccJ K
CancellationTokenccL ]
ctcc^ `
=cca b
defaultccc j
)ccj k
{dd 
returnee 
awaitee 
dbee 
.ee 

UserEmailsee "
.ee" #
FirstOrDefaultAsyncee# 6
(ee6 7
eee7 8
=>ee9 ;
eee< =
.ee= >
UserIdee> D
==eeE G
userIdeeH N
&&eeO Q
eeeR S
.eeS T
AddresseeT [
==ee\ ^
addressee_ f
,eef g
cteeh j
)eej k
;eek l
}ff 
publichh 

asynchh 
Taskhh 
<hh 
boolhh 
>hh $
EmailExistsAnywhereAsynchh 4
(hh4 5
stringhh5 ;
addresshh< C
,hhC D
CancellationTokenhhE V
cthhW Y
=hhZ [
defaulthh\ c
)hhc d
{ii 
returnjj 
awaitjj 
dbjj 
.jj 
Usersjj 
.jj 
AnyAsyncjj &
(jj& '
ujj' (
=>jj) +
ujj, -
.jj- .
Emailjj. 3
==jj4 6
addressjj7 >
&&jj? A
!jjB C
ujjC D
.jjD E

IsArchivedjjE O
,jjO P
ctjjQ S
)jjS T
||kk 
awaitkk 
dbkk 
.kk 

UserEmailskk "
.kk" #
AnyAsynckk# +
(kk+ ,
ekk, -
=>kk. 0
ekk1 2
.kk2 3
Addresskk3 :
==kk; =
addresskk> E
,kkE F
ctkkG I
)kkI J
;kkJ K
}ll 
publicnn 

asyncnn 
Tasknn 
AddEmailAsyncnn #
(nn# $
	UserEmailnn$ -
emailnn. 3
,nn3 4
CancellationTokennn5 F
ctnnG I
=nnJ K
defaultnnL S
)nnS T
{oo 
dbpp 

.pp
 

UserEmailspp 
.pp 
Addpp 
(pp 
emailpp 
)pp  
;pp  !
awaitqq 
dbqq 
.qq 
SaveChangesAsyncqq !
(qq! "
ctqq" $
)qq$ %
;qq% &
}rr 
publictt 

asynctt 
Tasktt 
UpdateEmailAsynctt &
(tt& '
	UserEmailtt' 0
emailtt1 6
,tt6 7
CancellationTokentt8 I
ctttJ L
=ttM N
defaultttO V
)ttV W
{uu 
dbvv 

.vv
 

UserEmailsvv 
.vv 
Updatevv 
(vv 
emailvv "
)vv" #
;vv# $
awaitww 
dbww 
.ww 
SaveChangesAsyncww !
(ww! "
ctww" $
)ww$ %
;ww% &
}xx 
publiczz 

asynczz 
Taskzz 
RemoveEmailAsynczz &
(zz& '
	UserEmailzz' 0
emailzz1 6
,zz6 7
CancellationTokenzz8 I
ctzzJ L
=zzM N
defaultzzO V
)zzV W
{{{ 
db|| 

.||
 

UserEmails|| 
.|| 
Remove|| 
(|| 
email|| "
)||" #
;||# $
await}} 
db}} 
.}} 
SaveChangesAsync}} !
(}}! "
ct}}" $
)}}$ %
;}}% &
}~~ 
public
ÄÄ 

async
ÄÄ 
Task
ÄÄ -
ReleaseExternalIdentifiersAsync
ÄÄ 5
(
ÄÄ5 6
int
ÄÄ6 9
userId
ÄÄ: @
,
ÄÄ@ A
CancellationToken
ÄÄB S
ct
ÄÄT V
=
ÄÄW X
default
ÄÄY `
)
ÄÄ` a
{
ÅÅ 
await
ÇÇ 
db
ÇÇ 
.
ÇÇ  
UserExternalLogins
ÇÇ #
.
ÇÇ# $
Where
ÇÇ$ )
(
ÇÇ) *
l
ÇÇ* +
=>
ÇÇ, .
l
ÇÇ/ 0
.
ÇÇ0 1
UserId
ÇÇ1 7
==
ÇÇ8 :
userId
ÇÇ; A
)
ÇÇA B
.
ÇÇB C 
ExecuteDeleteAsync
ÇÇC U
(
ÇÇU V
ct
ÇÇV X
)
ÇÇX Y
;
ÇÇY Z
await
ÉÉ 
db
ÉÉ 
.
ÉÉ 

UserEmails
ÉÉ 
.
ÉÉ 
Where
ÉÉ !
(
ÉÉ! "
e
ÉÉ" #
=>
ÉÉ$ &
e
ÉÉ' (
.
ÉÉ( )
UserId
ÉÉ) /
==
ÉÉ0 2
userId
ÉÉ3 9
)
ÉÉ9 :
.
ÉÉ: ; 
ExecuteDeleteAsync
ÉÉ; M
(
ÉÉM N
ct
ÉÉN P
)
ÉÉP Q
;
ÉÉQ R
}
ÑÑ 
}ÖÖ “
wC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Infrastructure\Data\AuthDbContext.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Infrastructure" 0
.0 1
Data1 5
;5 6
public 
sealed 
class 
AuthDbContext !
(! "
DbContextOptions" 2
<2 3
AuthDbContext3 @
>@ A
optionsB I
)I J
:K L
	DbContextM V
(V W
optionsW ^
)^ _
{		 
public

 

DbSet

 
<

 
User

 
>

 
Users

 
=>

 
Set

  #
<

# $
User

$ (
>

( )
(

) *
)

* +
;

+ ,
public 

DbSet 
< 
UserSettings 
> 
UserSettings +
=>, .
Set/ 2
<2 3
UserSettings3 ?
>? @
(@ A
)A B
;B C
public 

DbSet 
< 
UserExternalLogin "
>" #
UserExternalLogins$ 6
=>7 9
Set: =
<= >
UserExternalLogin> O
>O P
(P Q
)Q R
;R S
public 

DbSet 
< 
UserBackupCode 
>  
UserBackupCodes! 0
=>1 3
Set4 7
<7 8
UserBackupCode8 F
>F G
(G H
)H I
;I J
public 

DbSet 
< 
	UserEmail 
> 

UserEmails &
=>' )
Set* -
<- .
	UserEmail. 7
>7 8
(8 9
)9 :
;: ;
public 

DbSet 
< 
UserAuditLog 
> 
UserAuditLogs ,
=>- /
Set0 3
<3 4
UserAuditLog4 @
>@ A
(A B
)B C
;C D
public 

DbSet 
< 
AuditOutboxMessage #
># $
AuditOutboxMessages% 8
=>9 ;
Set< ?
<? @
AuditOutboxMessage@ R
>R S
(S T
)T U
;U V
	protected 
override 
void 
OnModelCreating +
(+ ,
ModelBuilder, 8
modelBuilder9 E
)E F
{ 
base 
. 
OnModelCreating 
( 
modelBuilder )
)) *
;* +
modelBuilder 
. )
ApplyAuthEntityConfigurations 2
(2 3
)3 4
;4 5
} 
} 