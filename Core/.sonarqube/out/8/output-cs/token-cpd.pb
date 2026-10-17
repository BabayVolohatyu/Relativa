¥
lC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Services\Audit\OutboxWriter.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Services' /
./ 0
Audit0 5
;5 6
public 
sealed 
class 
OutboxWriter  
(  !
RelativaDbContext! 2
db3 5
)5 6
:7 8
IOutboxWriter9 F
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
public 

async 
Task 
EnqueueDomainAsync (
(( )
string) /

routingKey0 :
,: ;!
DomainMessageEnvelope< Q
envelopeR Z
,Z [
CancellationToken\ m
ctn p
=q r
defaults z
)z {
{ 
db 

.
 
AuditOutboxMessages 
. 
Add "
(" #
new# &
AuditOutboxMessage' 9
{ 	
EventId 
= 
envelope 
. 
	MessageId (
,( )

RoutingKey 
= 

routingKey #
,# $
PayloadJson 
= 
JsonSerializer (
.( )
	Serialize) 2
(2 3
envelope3 ;
); <
,< =
OccurredAtUtc   
=   
envelope   $
.  $ %
OccurredAtUtc  % 2
,  2 3
CreatedAtUtc!! 
=!! 
DateTimeOffset!! )
.!!) *
UtcNow!!* 0
,!!0 1
PublishAttempts"" 
="" 
$num"" 
}## 	
)##	 

;##
 
await%% 
db%% 
.%% 
SaveChangesAsync%% !
(%%! "
ct%%" $
)%%$ %
;%%% &
}&& 
}'' ·4
uC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Services\Audit\AuditOutboxDispatcher.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Services' /
./ 0
Audit0 5
;5 6
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
<((9 :
RelativaDbContext((: K
>((K L
(((L M
)((M N
;((N O
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
}VV Ä
yC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Repositories\WorkspaceSettingsRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Repositories' 3
;3 4
public 
sealed 
class '
WorkspaceSettingsRepository /
(/ 0
RelativaDbContext0 A
dbB D
)D E
:F G(
IWorkspaceSettingsRepositoryH d
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
 
AddAsync

 
(

 
WorkspaceSettings

 0
settings

1 9
,

9 :
CancellationToken

; L
ct

M O
=

P Q
default

R Y
)

Y Z
{ 
db 

.
 
WorkspaceSettings 
. 
Add  
(  !
settings! )
)) *
;* +
await 
db 
. 
SaveChangesAsync !
(! "
ct" $
)$ %
;% &
} 
public 

async 
Task 
< 
WorkspaceSettings '
?' (
>( )!
GetByWorkspaceIdAsync* ?
(? @
int@ C
workspaceIdD O
,O P
CancellationTokenQ b
ctc e
=f g
defaulth o
)o p
=> 

await 
db 
. 
WorkspaceSettings %
.% &
FirstOrDefaultAsync& 9
(9 :
s: ;
=>< >
s? @
.@ A
WorkspaceIdA L
==M O
workspaceIdP [
,[ \
ct] _
)_ `
;` a
public 

async 
Task 
UpdateAsync !
(! "
WorkspaceSettings" 3
settings4 <
,< =
CancellationToken> O
ctP R
=S T
defaultU \
)\ ]
{ 
db 

.
 
WorkspaceSettings 
. 
Update #
(# $
settings$ ,
), -
;- .
await 
db 
. 
SaveChangesAsync !
(! "
ct" $
)$ %
;% &
} 
} ñA
uC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Repositories\WorkspaceRoleRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Repositories' 3
;3 4
public 
sealed 
class #
WorkspaceRoleRepository +
(+ ,
RelativaDbContext, =
db> @
)@ A
:B C$
IWorkspaceRoleRepositoryD \
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
 
WorkspaceRole

 #
?

# $
>

$ %
GetByIdAsync

& 2
(

2 3
int

3 6
id

7 9
,

9 :
CancellationToken

; L
ct

M O
=

P Q
default

R Y
)

Y Z
{ 
return 
await 
db 
. 
WorkspaceRoles &
. 
Include 
( 
r 
=> 
r 
. 
RolePermissions +
)+ ,
. 
ThenInclude 
( 
rp 
=>  "
rp# %
.% &

Permission& 0
)0 1
. 
FirstOrDefaultAsync  
(  !
r! "
=># %
r& '
.' (
Id( *
==+ -
id. 0
&&1 3
!4 5
r5 6
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
List 
< 
WorkspaceRole (
>( )
>) *!
GetByWorkspaceIdAsync+ @
(@ A
intA D
workspaceIdE P
,P Q
CancellationTokenR c
ctd f
=g h
defaulti p
)p q
{ 
return 
await 
db 
. 
WorkspaceRoles &
. 
Include 
( 
r 
=> 
r 
. 
RolePermissions +
)+ ,
. 
ThenInclude 
( 
rp 
=>  "
rp# %
.% &

Permission& 0
)0 1
. 
Where 
( 
r 
=> 
( 
r 
. 
WorkspaceId &
==' )
null* .
||/ 1
r2 3
.3 4
WorkspaceId4 ?
==@ B
workspaceIdC N
)N O
&&P R
!S T
rT U
.U V

IsArchivedV `
)` a
. 
ToListAsync 
( 
ct 
) 
; 
} 
public 

async 
Task 
< 
WorkspaceRole #
?# $
>$ %$
GetSystemRoleByNameAsync& >
(> ?
string? E
nameF J
,J K
CancellationTokenL ]
ct^ `
=a b
defaultc j
)j k
{ 
return 
await 
db 
. 
WorkspaceRoles &
. 
Include 
( 
r 
=> 
r 
. 
RolePermissions +
)+ ,
. 
ThenInclude 
( 
rp 
=>  "
rp# %
.% &

Permission& 0
)0 1
.   
FirstOrDefaultAsync    
(    !
r  ! "
=>  # %
r  & '
.  ' (
Name  ( ,
==  - /
name  0 4
&&  5 7
r  8 9
.  9 :
WorkspaceId  : E
==  F H
null  I M
&&  N P
!  Q R
r  R S
.  S T

IsArchived  T ^
,  ^ _
ct  ` b
)  b c
;  c d
}!! 
public## 

async## 
Task## 
<## 
WorkspaceRole## #
?### $
>##$ %5
)GetSystemRoleWithPermissionsSupersetAsync##& O
(##O P
IReadOnlyCollection$$ 
<$$ 
string$$ "
>$$" ##
requiredPermissionNames$$$ ;
,$$; <
CancellationToken%% 
ct%% 
=%% 
default%% &
)%%& '
{&& 
if'' 

('' #
requiredPermissionNames'' #
.''# $
Count''$ )
==''* ,
$num''- .
)''. /
return(( 
null(( 
;(( 
var** 
required** 
=** #
requiredPermissionNames** .
.**. /
	ToHashSet**/ 8
(**8 9
StringComparer**9 G
.**G H
Ordinal**H O
)**O P
;**P Q
var++ 
systemRoles++ 
=++ 
await++ 
db++  "
.++" #
WorkspaceRoles++# 1
.,, 
Include,, 
(,, 
r,, 
=>,, 
r,, 
.,, 
RolePermissions,, +
),,+ ,
.-- 
ThenInclude-- 
(-- 
rp-- 
=>--  "
rp--# %
.--% &

Permission--& 0
)--0 1
... 
Where.. 
(.. 
r.. 
=>.. 
r.. 
... 
WorkspaceId.. %
==..& (
null..) -
&&... 0
!..1 2
r..2 3
...3 4

IsArchived..4 >
)..> ?
.// 
OrderBy// 
(// 
r// 
=>// 
r// 
.// 
Id// 
)// 
.00 
ToListAsync00 
(00 
ct00 
)00 
;00 
return22 
systemRoles22 
.22 
FirstOrDefault22 )
(22) *
role22* .
=>22/ 1
{33 	
var44 
granted44 
=44 
role44 
.44 
RolePermissions44 .
.55 
Select55 
(55 
rp55 
=>55 
rp55  
.55  !

Permission55! +
?55+ ,
.55, -
Name55- 1
)551 2
.66 
Where66 
(66 
name66 
=>66 
!66  
string66  &
.66& '
IsNullOrWhiteSpace66' 9
(669 :
name66: >
)66> ?
)66? @
.77 
Cast77 
<77 
string77 
>77 
(77 
)77 
.88 
	ToHashSet88 
(88 
StringComparer88 )
.88) *
Ordinal88* 1
)881 2
;882 3
return99 
required99 
.99 
All99 
(99  
granted99  '
.99' (
Contains99( 0
)990 1
;991 2
}:: 	
)::	 

;::
 
};; 
public== 

async== 
Task== 
AddAsync== 
(== 
WorkspaceRole== ,
role==- 1
,==1 2
CancellationToken==3 D
ct==E G
===H I
default==J Q
)==Q R
{>> 
db?? 

.??
 
WorkspaceRoles?? 
.?? 
Add?? 
(?? 
role?? "
)??" #
;??# $
await@@ 
db@@ 
.@@ 
SaveChangesAsync@@ !
(@@! "
ct@@" $
)@@$ %
;@@% &
}AA 
publicCC 

asyncCC 
TaskCC 
UpdateAsyncCC !
(CC! "
WorkspaceRoleCC" /
roleCC0 4
,CC4 5
CancellationTokenCC6 G
ctCCH J
=CCK L
defaultCCM T
)CCT U
{DD 
dbEE 

.EE
 
WorkspaceRolesEE 
.EE 
UpdateEE  
(EE  !
roleEE! %
)EE% &
;EE& '
awaitFF 
dbFF 
.FF 
SaveChangesAsyncFF !
(FF! "
ctFF" $
)FF$ %
;FF% &
}GG 
}HH ÇP
qC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Repositories\WorkspaceRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Repositories' 3
;3 4
public 
sealed 
class 
WorkspaceRepository '
(' (
RelativaDbContext( 9
db: <
)< =
:> ? 
IWorkspaceRepository@ T
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
 
	Workspace

 
?

  
>

  !
GetByIdAsync

" .
(

. /
int

/ 2
id

3 5
,

5 6
CancellationToken

7 H
ct

I K
=

L M
default

N U
)

U V
{ 
return 
await 
db 
. 

Workspaces "
. 
FirstOrDefaultAsync  
(  !
w! "
=># %
w& '
.' (
Id( *
==+ -
id. 0
&&1 3
!4 5
w5 6
.6 7

IsArchived7 A
,A B
ctC E
)E F
;F G
} 
public 

async 
Task 
< 
List 
< 
	Workspace $
>$ %
>% &
GetByUserIdAsync' 7
(7 8
int8 ;
userId< B
,B C
CancellationTokenD U
ctV X
=Y Z
default[ b
)b c
{ 
var 
viaMembership 
= 
await !
db" $
.$ %
UserRoleWorkspaces% 7
. 
Where 
( 
urw 
=> 
urw 
. 
UserId $
==% '
userId( .
&&/ 1
!2 3
urw3 6
.6 7

IsArchived7 A
)A B
. 
Select 
( 
urw 
=> 
urw 
. 
	Workspace (
)( )
. 
Where 
( 
w 
=> 
! 
w 
. 

IsArchived %
)% &
. 
ToListAsync 
( 
ct 
) 
; 
var 
orgOwnerOrgIds 
= 
await "
db# %
.% &!
UserRoleOrganizations& ;
. 
AsNoTracking 
( 
) 
. 
Where 
( 
uro 
=> 
uro 
. 
UserId $
==% '
userId( .
&&/ 1
!2 3
uro3 6
.6 7

IsArchived7 A
&&B D
uro 
. 
Role "
!=# %
null& *
&&+ -
uro. 1
.1 2
Role2 6
.6 7
Name7 ;
==< >
$str? J
)J K
. 
Select 
( 
uro 
=> 
uro 
. 
OrganizationId -
)- .
. 
Distinct 
( 
) 
. 
ToListAsync 
( 
ct 
) 
; 
if   

(   
orgOwnerOrgIds   
.   
Count    
==  ! #
$num  $ %
)  % &
return!! 
viaMembership!!  
;!!  !
var## 
ownedOrgWorkspaces## 
=##  
await##! &
db##' )
.##) *

Workspaces##* 4
.$$ 
AsNoTracking$$ 
($$ 
)$$ 
.%% 
Where%% 
(%% 
w%% 
=>%% 
orgOwnerOrgIds%% &
.%%& '
Contains%%' /
(%%/ 0
w%%0 1
.%%1 2
OrganizationId%%2 @
)%%@ A
&&%%B D
!%%E F
w%%F G
.%%G H

IsArchived%%H R
)%%R S
.&& 
ToListAsync&& 
(&& 
ct&& 
)&& 
;&& 
return(( 
viaMembership(( 
.)) 
Concat)) 
()) 
ownedOrgWorkspaces)) &
)))& '
.** 
GroupBy** 
(** 
w** 
=>** 
w** 
.** 
Id** 
)** 
.++ 
Select++ 
(++ 
g++ 
=>++ 
g++ 
.++ 
First++  
(++  !
)++! "
)++" #
.,, 
ToList,, 
(,, 
),, 
;,, 
}-- 
public// 

async// 
Task// 
<// 
List// 
<// 
	Workspace// $
>//$ %
>//% &$
GetByOrganizationIdAsync//' ?
(//? @
int//@ C
organizationId//D R
,//R S
CancellationToken//T e
ct//f h
=//i j
default//k r
)//r s
{00 
return11 
await11 
db11 
.11 

Workspaces11 "
.22 
Where22 
(22 
w22 
=>22 
w22 
.22 
OrganizationId22 (
==22) +
organizationId22, :
&&22; =
!22> ?
w22? @
.22@ A

IsArchived22A K
)22K L
.33 
ToListAsync33 
(33 
ct33 
)33 
;33 
}44 
public66 

async66 
Task66 
<66 
List66 
<66 
	Workspace66 $
>66$ %
>66% &-
!GetByUserIdAndOrganizationIdAsync66' H
(66H I
int77 
userId77 
,77 
int88 
organizationId88 
,88 
CancellationToken99 
ct99 
=99 
default99 &
)99& '
{:: 
var;; 
viaMembership;; 
=;; 
await;; !
db;;" $
.;;$ %
UserRoleWorkspaces;;% 7
.<< 
Where<< 
(<< 
urw<< 
=><< 
urw<< 
.<< 
UserId<< $
==<<% '
userId<<( .
&&<</ 1
!<<2 3
urw<<3 6
.<<6 7

IsArchived<<7 A
)<<A B
.== 
Select== 
(== 
urw== 
=>== 
urw== 
.== 
	Workspace== (
)==( )
.>> 
Where>> 
(>> 
w>> 
=>>> 
!>> 
w>> 
.>> 

IsArchived>> %
&&>>& (
w>>) *
.>>* +
OrganizationId>>+ 9
==>>: <
organizationId>>= K
)>>K L
.?? 
ToListAsync?? 
(?? 
ct?? 
)?? 
;?? 
varAA 

isOrgOwnerAA 
=AA 
awaitAA 
dbAA !
.AA! "!
UserRoleOrganizationsAA" 7
.BB 
AsNoTrackingBB 
(BB 
)BB 
.CC 
WhereCC 
(CC 
uroCC 
=>CC 
uroCC 
.CC 
UserIdCC $
==CC% '
userIdCC( .
&&CC/ 1
uroCC2 5
.CC5 6
OrganizationIdCC6 D
==CCE G
organizationIdCCH V
&&CCW Y
!CCZ [
uroCC[ ^
.CC^ _

IsArchivedCC_ i
)CCi j
.DD 
AnyAsyncDD 
(DD 
uroDD 
=>DD 
uroDD  
.DD  !
RoleDD! %
!=DD& (
nullDD) -
&&DD. 0
uroDD1 4
.DD4 5
RoleDD5 9
.DD9 :
NameDD: >
==DD? A
$strDDB M
,DDM N
ctDDO Q
)DDQ R
;DDR S
ifFF 

(FF 
!FF 

isOrgOwnerFF 
)FF 
returnGG 
viaMembershipGG  
;GG  !
varII 
allOrgII 
=II 
awaitII $
GetByOrganizationIdAsyncII 3
(II3 4
organizationIdII4 B
,IIB C
ctIID F
)IIF G
;IIG H
returnKK 
viaMembershipKK 
.LL 
ConcatLL 
(LL 
allOrgLL 
)LL 
.MM 
GroupByMM 
(MM 
wMM 
=>MM 
wMM 
.MM 
IdMM 
)MM 
.NN 
SelectNN 
(NN 
gNN 
=>NN 
gNN 
.NN 
FirstNN  
(NN  !
)NN! "
)NN" #
.OO 
ToListOO 
(OO 
)OO 
;OO 
}PP 
publicRR 

asyncRR 
TaskRR 
AddAsyncRR 
(RR 
	WorkspaceRR (
	workspaceRR) 2
,RR2 3
CancellationTokenRR4 E
ctRRF H
=RRI J
defaultRRK R
)RRR S
{SS 
dbTT 

.TT
 

WorkspacesTT 
.TT 
AddTT 
(TT 
	workspaceTT #
)TT# $
;TT$ %
awaitUU 
dbUU 
.UU 
SaveChangesAsyncUU !
(UU! "
ctUU" $
)UU$ %
;UU% &
}VV 
publicXX 

asyncXX 
TaskXX 
UpdateAsyncXX !
(XX! "
	WorkspaceXX" +
	workspaceXX, 5
,XX5 6
CancellationTokenXX7 H
ctXXI K
=XXL M
defaultXXN U
)XXU V
{YY 
dbZZ 

.ZZ
 

WorkspacesZZ 
.ZZ 
UpdateZZ 
(ZZ 
	workspaceZZ &
)ZZ& '
;ZZ' (
await[[ 
db[[ 
.[[ 
SaveChangesAsync[[ !
([[! "
ct[[" $
)[[$ %
;[[% &
}\\ 
}]] ¿:
yC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Repositories\UserRoleWorkspaceRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Repositories' 3
;3 4
public 
sealed 
class '
UserRoleWorkspaceRepository /
(/ 0
RelativaDbContext0 A
dbB D
)D E
:F G(
IUserRoleWorkspaceRepositoryH d
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
 
UserRoleWorkspace

 '
?

' (
>

( )
GetAsync

* 2
(

2 3
int

3 6
userId

7 =
,

= >
int

? B
workspaceId

C N
,

N O
CancellationToken

P a
ct

b d
=

e f
default

g n
)

n o
{ 
return 
await 
db 
. 
UserRoleWorkspaces *
. 
Include 
( 
urw 
=> 
urw 
.  
User  $
)$ %
. 
Include 
( 
urw 
=> 
urw 
.  
Role  $
)$ %
. 
ThenInclude 
( 
r 
=> !
r" #
.# $
RolePermissions$ 3
)3 4
. 
ThenInclude  
(  !
rp! #
=>$ &
rp' )
.) *

Permission* 4
)4 5
. 
FirstOrDefaultAsync  
(  !
urw! $
=>% '
urw( +
.+ ,
UserId, 2
==3 5
userId6 <
&&= ?
urw@ C
.C D
WorkspaceIdD O
==P R
workspaceIdS ^
&&_ a
!b c
urwc f
.f g

IsArchivedg q
,q r
cts u
)u v
;v w
} 
public 

async 
Task 
< 

Dictionary  
<  !
int! $
,$ %
int& )
>) *
>* ++
GetRolePrioritiesByUserIdsAsync, K
(K L
int 
workspaceId 
, 
IReadOnlyCollection 
< 
int 
>  
userIds! (
,( )
CancellationToken 
ct 
= 
default &
)& '
{ 
if 

( 
userIds 
. 
Count 
== 
$num 
) 
return 
new 

Dictionary !
<! "
int" %
,% &
int' *
>* +
(+ ,
), -
;- .
return 
await 
db 
. 
UserRoleWorkspaces *
. 
AsNoTracking 
( 
) 
. 
Where 
( 
urw 
=> 
urw 
. 
WorkspaceId )
==* ,
workspaceId- 8
&&9 ;
!< =
urw= @
.@ A

IsArchivedA K
&&L N
userIdsO V
.V W
ContainsW _
(_ `
urw` c
.c d
UserIdd j
)j k
)k l
. 
Select 
( 
urw 
=> 
new 
{  
urw! $
.$ %
UserId% +
,+ ,
urw- 0
.0 1
Role1 5
.5 6
Priority6 >
}? @
)@ A
.   
ToDictionaryAsync   
(   
x    
=>  ! #
x  $ %
.  % &
UserId  & ,
,  , -
x  . /
=>  0 2
x  3 4
.  4 5
Priority  5 =
,  = >
ct  ? A
)  A B
;  B C
}!! 
public## 

async## 
Task## 
<## 
List## 
<## 
UserRoleWorkspace## ,
>##, -
>##- .!
GetByWorkspaceIdAsync##/ D
(##D E
int##E H
workspaceId##I T
,##T U
CancellationToken##V g
ct##h j
=##k l
default##m t
)##t u
{$$ 
return%% 
await%% 
db%% 
.%% 
UserRoleWorkspaces%% *
.&& 
Include&& 
(&& 
urw&& 
=>&& 
urw&& 
.&&  
User&&  $
)&&$ %
.'' 
Include'' 
('' 
urw'' 
=>'' 
urw'' 
.''  
Role''  $
)''$ %
.(( 
ThenInclude(( 
((( 
r(( 
=>(( !
r((" #
.((# $
RolePermissions(($ 3
)((3 4
.)) 
ThenInclude))  
())  !
rp))! #
=>))$ &
rp))' )
.))) *

Permission))* 4
)))4 5
.** 
Where** 
(** 
urw** 
=>** 
urw** 
.** 
WorkspaceId** )
==*** ,
workspaceId**- 8
&&**9 ;
!**< =
urw**= @
.**@ A

IsArchived**A K
)**K L
.++ 
ToListAsync++ 
(++ 
ct++ 
)++ 
;++ 
},, 
public.. 

async.. 
Task.. 
AddAsync.. 
(.. 
UserRoleWorkspace.. 0
member..1 7
,..7 8
CancellationToken..9 J
ct..K M
=..N O
default..P W
)..W X
{// 
db00 

.00
 
UserRoleWorkspaces00 
.00 
Add00 !
(00! "
member00" (
)00( )
;00) *
await11 
db11 
.11 
SaveChangesAsync11 !
(11! "
ct11" $
)11$ %
;11% &
}22 
public44 

async44 
Task44 
UpdateAsync44 !
(44! "
UserRoleWorkspace44" 3
member444 :
,44: ;
CancellationToken44< M
ct44N P
=44Q R
default44S Z
)44Z [
{55 
db66 

.66
 
UserRoleWorkspaces66 
.66 
Update66 $
(66$ %
member66% +
)66+ ,
;66, -
await77 
db77 
.77 
SaveChangesAsync77 !
(77! "
ct77" $
)77$ %
;77% &
}88 
public:: 

async:: 
Task:: 
RemoveAsync:: !
(::! "
UserRoleWorkspace::" 3
member::4 :
,::: ;
CancellationToken::< M
ct::N P
=::Q R
default::S Z
)::Z [
{;; 
db<< 

.<<
 
UserRoleWorkspaces<< 
.<< 
Remove<< $
(<<$ %
member<<% +
)<<+ ,
;<<, -
await== 
db== 
.== 
SaveChangesAsync== !
(==! "
ct==" $
)==$ %
;==% &
}>> 
}?? ©6
|C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Repositories\UserRoleOrganizationRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Repositories' 3
;3 4
public 
sealed 
class *
UserRoleOrganizationRepository 2
(2 3
RelativaDbContext3 D
dbE G
)G H
:I J+
IUserRoleOrganizationRepositoryK j
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
  
UserRoleOrganization

 *
?

* +
>

+ ,
GetAsync

- 5
(

5 6
int

6 9
userId

: @
,

@ A
int

B E
organizationId

F T
,

T U
CancellationToken

V g
ct

h j
=

k l
default

m t
)

t u
{ 
return 
await 
db 
. !
UserRoleOrganizations -
. 
Include 
( 
uro 
=> 
uro 
.  
User  $
)$ %
. 
Include 
( 
uro 
=> 
uro 
.  
Role  $
)$ %
. 
ThenInclude 
( 
r 
=> !
r" #
.# $
RolePermissions$ 3
)3 4
. 
ThenInclude  
(  !
rp! #
=>$ &
rp' )
.) *

Permission* 4
)4 5
. 
FirstOrDefaultAsync  
(  !
uro! $
=>% '
uro( +
.+ ,
UserId, 2
==3 5
userId6 <
&&= ?
uro@ C
.C D
OrganizationIdD R
==S U
organizationIdV d
&&e g
!h i
uroi l
.l m

IsArchivedm w
,w x
cty {
){ |
;| }
} 
public 

async 
Task 
< 
List 
<  
UserRoleOrganization /
>/ 0
>0 1$
GetByOrganizationIdAsync2 J
(J K
intK N
organizationIdO ]
,] ^
CancellationToken_ p
ctq s
=t u
defaultv }
)} ~
{ 
return 
await 
db 
. !
UserRoleOrganizations -
. 
Include 
( 
uro 
=> 
uro 
.  
User  $
)$ %
. 
Include 
( 
uro 
=> 
uro 
.  
Role  $
)$ %
. 
ThenInclude 
( 
r 
=> !
r" #
.# $
RolePermissions$ 3
)3 4
. 
ThenInclude  
(  !
rp! #
=>$ &
rp' )
.) *

Permission* 4
)4 5
. 
Where 
( 
uro 
=> 
uro 
. 
OrganizationId ,
==- /
organizationId0 >
&&? A
!B C
uroC F
.F G

IsArchivedG Q
)Q R
. 
ToListAsync 
( 
ct 
) 
; 
} 
public 

async 
Task 
< 
List 
<  
UserRoleOrganization /
>/ 0
>0 1
GetByUserIdAsync2 B
(B C
intC F
userIdG M
,M N
CancellationTokenO `
cta c
=d e
defaultf m
)m n
{   
return!! 
await!! 
db!! 
.!! !
UserRoleOrganizations!! -
."" 
Include"" 
("" 
uro"" 
=>"" 
uro"" 
.""  
User""  $
)""$ %
.## 
Include## 
(## 
uro## 
=>## 
uro## 
.##  
Role##  $
)##$ %
.$$ 
ThenInclude$$ 
($$ 
r$$ 
=>$$ !
r$$" #
.$$# $
RolePermissions$$$ 3
)$$3 4
.%% 
ThenInclude%%  
(%%  !
rp%%! #
=>%%$ &
rp%%' )
.%%) *

Permission%%* 4
)%%4 5
.&& 
Where&& 
(&& 
uro&& 
=>&& 
uro&& 
.&& 
UserId&& $
==&&% '
userId&&( .
&&&&/ 1
!&&2 3
uro&&3 6
.&&6 7

IsArchived&&7 A
)&&A B
.'' 
ToListAsync'' 
('' 
ct'' 
)'' 
;'' 
}(( 
public** 

async** 
Task** 
AddAsync** 
(**  
UserRoleOrganization** 3
member**4 :
,**: ;
CancellationToken**< M
ct**N P
=**Q R
default**S Z
)**Z [
{++ 
db,, 

.,,
 !
UserRoleOrganizations,,  
.,,  !
Add,,! $
(,,$ %
member,,% +
),,+ ,
;,,, -
await-- 
db-- 
.-- 
SaveChangesAsync-- !
(--! "
ct--" $
)--$ %
;--% &
}.. 
public00 

async00 
Task00 
UpdateAsync00 !
(00! " 
UserRoleOrganization00" 6
member007 =
,00= >
CancellationToken00? P
ct00Q S
=00T U
default00V ]
)00] ^
{11 
db22 

.22
 !
UserRoleOrganizations22  
.22  !
Update22! '
(22' (
member22( .
)22. /
;22/ 0
await33 
db33 
.33 
SaveChangesAsync33 !
(33! "
ct33" $
)33$ %
;33% &
}44 
public66 

async66 
Task66 
RemoveAsync66 !
(66! " 
UserRoleOrganization66" 6
member667 =
,66= >
CancellationToken66? P
ct66Q S
=66T U
default66V ]
)66] ^
{77 
db88 

.88
 !
UserRoleOrganizations88  
.88  !
Remove88! '
(88' (
member88( .
)88. /
;88/ 0
await99 
db99 
.99 
SaveChangesAsync99 !
(99! "
ct99" $
)99$ %
;99% &
}:: 
};; â
rC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Repositories\PermissionRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Repositories' 3
;3 4
public 
sealed 
class  
PermissionRepository (
(( )
RelativaDbContext) :
db; =
)= >
:? @!
IPermissionRepositoryA V
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
List

 
<

 

Permission

 %
>

% &
>

& '
GetAllAsync

( 3
(

3 4
CancellationToken

4 E
ct

F H
=

I J
default

K R
)

R S
{ 
return 
await 
db 
. 
Permissions #
. 
Where 
( 
p 
=> 
! 
p 
. 

IsArchived %
)% &
. 
ToListAsync 
( 
ct 
) 
; 
} 
public 

async 
Task 
< 
List 
< 

Permission %
>% &
>& '
GetByIdsAsync( 5
(5 6
IEnumerable6 A
<A B
intB E
>E F
idsG J
,J K
CancellationTokenL ]
ct^ `
=a b
defaultc j
)j k
{ 
var 
idList 
= 
ids 
. 
ToList 
(  
)  !
;! "
return 
await 
db 
. 
Permissions #
. 
Where 
( 
p 
=> 
idList 
. 
Contains '
(' (
p( )
.) *
Id* ,
), -
&&. 0
!1 2
p2 3
.3 4

IsArchived4 >
)> ?
. 
ToListAsync 
( 
ct 
) 
; 
} 
} Ê=
uC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Repositories\OrgInvitationRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Repositories' 3
;3 4
public 
sealed 
class #
OrgInvitationRepository +
(+ ,
RelativaDbContext, =
db> @
)@ A
:B C$
IOrgInvitationRepositoryD \
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
 "
OrganizationInvitation

 ,
?

, -
>

- .
GetByIdAsync

/ ;
(

; <
int

< ?
id

@ B
,

B C
CancellationToken

D U
ct

V X
=

Y Z
default

[ b
)

b c
{ 
return 
await 
db 
. #
OrganizationInvitations /
. 
Include 
( 
i 
=> 
i 
. 
Organization (
)( )
. 
Include 
( 
i 
=> 
i 
. 
Role  
)  !
. 
FirstOrDefaultAsync  
(  !
i! "
=># %
i& '
.' (
Id( *
==+ -
id. 0
,0 1
ct2 4
)4 5
;5 6
} 
public 

async 
Task 
< "
OrganizationInvitation ,
?, -
>- .
GetByTokenAsync/ >
(> ?
string? E
tokenF K
,K L
CancellationTokenM ^
ct_ a
=b c
defaultd k
)k l
{ 
return 
await 
db 
. #
OrganizationInvitations /
. 
Include 
( 
i 
=> 
i 
. 
Organization (
)( )
. 
Include 
( 
i 
=> 
i 
. 
Role  
)  !
. 
FirstOrDefaultAsync  
(  !
i! "
=># %
i& '
.' (
Token( -
==. 0
token1 6
,6 7
ct8 :
): ;
;; <
} 
public 

async 
Task 
< 
List 
< "
OrganizationInvitation 1
>1 2
>2 3$
GetByOrganizationIdAsync4 L
(L M
intM P
organizationIdQ _
,_ `
CancellationTokena r
cts u
=v w
defaultx 
)	 Ä
{ 
return 
await 
db 
. #
OrganizationInvitations /
. 
Include 
( 
i 
=> 
i 
. 
Organization (
)( )
. 
Include 
( 
i 
=> 
i 
. 
Role  
)  !
. 
Where 
( 
i 
=> 
i 
. 
OrganizationId (
==) +
organizationId, :
): ;
.   
ToListAsync   
(   
ct   
)   
;   
}!! 
public## 

async## 
Task## 
<## 
List## 
<## "
OrganizationInvitation## 1
>##1 2
>##2 3
GetByEmailAsync##4 C
(##C D
string##D J
email##K P
,##P Q
CancellationToken##R c
ct##d f
=##g h
default##i p
)##p q
{$$ 
if%% 

(%% 
string%% 
.%% 
IsNullOrWhiteSpace%% %
(%%% &
email%%& +
)%%+ ,
)%%, -
return&& 
[&& 
]&& 
;&& 
var(( 

normalized(( 
=(( 
email(( 
.(( 
Trim(( #
(((# $
)(($ %
.((% &
ToLowerInvariant((& 6
(((6 7
)((7 8
;((8 9
return)) 
await)) 
db)) 
.)) #
OrganizationInvitations)) /
.** 
Include** 
(** 
i** 
=>** 
i** 
.** 
Organization** (
)**( )
.++ 
Include++ 
(++ 
i++ 
=>++ 
i++ 
.++ 
Role++  
)++  !
.,, 
Where,, 
(,, 
i,, 
=>,, 
i,, 
.,, 
Email,, 
==,,  "

normalized,,# -
&&,,. 0
i,,1 2
.,,2 3
Status,,3 9
==,,: <
$str,,= F
),,F G
.-- 
ToListAsync-- 
(-- 
ct-- 
)-- 
;-- 
}.. 
public00 

async00 
Task00 
<00 "
OrganizationInvitation00 ,
?00, -
>00- .(
GetPendingByOrgAndEmailAsync00/ K
(00K L
int00L O
organizationId00P ^
,00^ _
string00` f
email00g l
,00l m
CancellationToken00n 
ct
00Ä Ç
=
00É Ñ
default
00Ö å
)
00å ç
{11 
var22 

normalized22 
=22 
email22 
.22 
Trim22 #
(22# $
)22$ %
.22% &
ToLowerInvariant22& 6
(226 7
)227 8
;228 9
return33 
await33 
db33 
.33 #
OrganizationInvitations33 /
.44 
Include44 
(44 
i44 
=>44 
i44 
.44 
Role44  
)44  !
.55 
FirstOrDefaultAsync55  
(55  !
i66 
=>66 
i66 
.66 
OrganizationId66 %
==66& (
organizationId66) 7
&&77 
i77 
.77 
Email77 
==77  "

normalized77# -
&&88 
i88 
.88 
Status88  
==88! #
$str88$ -
,88- .
ct99 
)99 
;99 
}:: 
public<< 

async<< 
Task<< 
AddAsync<< 
(<< "
OrganizationInvitation<< 5

invitation<<6 @
,<<@ A
CancellationToken<<B S
ct<<T V
=<<W X
default<<Y `
)<<` a
{== 
db>> 

.>>
 #
OrganizationInvitations>> "
.>>" #
Add>># &
(>>& '

invitation>>' 1
)>>1 2
;>>2 3
await?? 
db?? 
.?? 
SaveChangesAsync?? !
(??! "
ct??" $
)??$ %
;??% &
}@@ 
publicBB 

asyncBB 
TaskBB 
UpdateAsyncBB !
(BB! ""
OrganizationInvitationBB" 8

invitationBB9 C
,BBC D
CancellationTokenBBE V
ctBBW Y
=BBZ [
defaultBB\ c
)BBc d
{CC 
dbDD 

.DD
 #
OrganizationInvitationsDD "
.DD" #
UpdateDD# )
(DD) *

invitationDD* 4
)DD4 5
;DD5 6
awaitEE 
dbEE 
.EE 
SaveChangesAsyncEE !
(EE! "
ctEE" $
)EE$ %
;EE% &
}FF 
}GG ¬
|C:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Repositories\OrganizationSettingsRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Repositories' 3
;3 4
public 
sealed 
class *
OrganizationSettingsRepository 2
(2 3
RelativaDbContext3 D
dbE G
)G H
:I J+
IOrganizationSettingsRepositoryK j
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
 
AddAsync

 
(

  
OrganizationSettings

 3
settings

4 <
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
{ 
db 

.
  
OrganizationSettings 
.  
Add  #
(# $
settings$ ,
), -
;- .
await 
db 
. 
SaveChangesAsync !
(! "
ct" $
)$ %
;% &
} 
public 

async 
Task 
<  
OrganizationSettings *
?* +
>+ ,$
GetByOrganizationIdAsync- E
(E F
intF I
organizationIdJ X
,X Y
CancellationTokenZ k
ctl n
=o p
defaultq x
)x y
=> 

await 
db 
.  
OrganizationSettings (
. 
Include 
( 
s 
=> 
s 
. 
DefaultOrgRole *
)* +
. 
FirstOrDefaultAsync  
(  !
s! "
=># %
s& '
.' (
OrganizationId( 6
==7 9
organizationId: H
,H I
ctJ L
)L M
;M N
public 

async 
Task 
UpdateAsync !
(! " 
OrganizationSettings" 6
settings7 ?
,? @
CancellationTokenA R
ctS U
=V W
defaultX _
)_ `
{ 
db 

.
  
OrganizationSettings 
.  
Update  &
(& '
settings' /
)/ 0
;0 1
await 
db 
. 
SaveChangesAsync !
(! "
ct" $
)$ %
;% &
} 
} Ü5
tC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Repositories\OrganizationRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Repositories' 3
;3 4
public 
sealed 
class "
OrganizationRepository *
(* +
RelativaDbContext+ <
db= ?
)? @
:A B#
IOrganizationRepositoryC Z
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
 
Organization

 "
?

" #
>

# $
GetByIdAsync

% 1
(

1 2
int

2 5
id

6 8
,

8 9
CancellationToken

: K
ct

L N
=

O P
default

Q X
)

X Y
{ 
return 
await 
db 
. 
Organizations %
. 
FirstOrDefaultAsync  
(  !
o! "
=># %
o& '
.' (
Id( *
==+ -
id. 0
&&1 3
!4 5
o5 6
.6 7

IsArchived7 A
,A B
ctC E
)E F
;F G
} 
public 

async 
Task 
< 
List 
< 
Organization '
>' (
>( )
GetByUserIdAsync* :
(: ;
int; >
userId? E
,E F
CancellationTokenG X
ctY [
=\ ]
default^ e
)e f
{ 
return 
await 
db 
. !
UserRoleOrganizations -
. 
Where 
( 
uro 
=> 
uro 
. 
UserId $
==% '
userId( .
&&/ 1
!2 3
uro3 6
.6 7

IsArchived7 A
)A B
. 
Select 
( 
uro 
=> 
uro 
. 
Organization +
)+ ,
. 
Where 
( 
o 
=> 
! 
o 
. 

IsArchived %
)% &
. 
ToListAsync 
( 
ct 
) 
; 
} 
public 

async 
Task 
< 
List 
< !
OrganizationSearchHit 0
>0 1
>1 2
SearchAsync3 >
(> ?
string? E
queryF K
,K L
CancellationTokenM ^
ct_ a
=b c
defaultd k
)k l
{ 
var 
organizations 
= 
db 
. 
Organizations ,
., -
Where- 2
(2 3
o3 4
=>5 7
!8 9
o9 :
.: ;

IsArchived; E
)E F
;F G
var 
trimmed 
= 
query 
? 
. 
Trim !
(! "
)" #
;# $
organizations 
= 
string 
. 
IsNullOrEmpty ,
(, -
trimmed- 4
)4 5
? 
organizations 
. 
OrderByDescending -
(- .
o. /
=>0 2
o3 4
.4 5
Members5 <
.< =
Count= B
(B C
mC D
=>E G
!H I
mI J
.J K

IsArchivedK U
)U V
)V W
.W X
ThenByX ^
(^ _
o_ `
=>a c
od e
.e f
Namef j
)j k
:   
organizations   
.   
Where   !
(  ! "
o  " #
=>  $ &
EF  ' )
.  ) *
	Functions  * 3
.  3 4
ILike  4 9
(  9 :
o  : ;
.  ; <
Name  < @
,  @ A
$"  B D
$str  D E
{  E F
trimmed  F M
}  M N
$str  N O
"  O P
)  P Q
)  Q R
.  R S
OrderBy  S Z
(  Z [
o  [ \
=>  ] _
o  ` a
.  a b
Name  b f
)  f g
;  g h
return"" 
await"" 
organizations"" "
.## 
Take## 
(## 
$num## 
)## 
.$$ 
Select$$ 
($$ 
o$$ 
=>$$ 
new$$ !
OrganizationSearchHit$$ 2
($$2 3
o%% 
.%% 
Id%% 
,%% 
o&& 
.&& 
Name&& 
,&& 
o'' 
.'' 
Members'' 
.'' 
Count'' 
(''  
m''  !
=>''" $
!''% &
m''& '
.''' (

IsArchived''( 2
)''2 3
,''3 4
o(( 
.(( 
Settings(( 
!=(( 
null(( "
?((# $
o((% &
.((& '
Settings((' /
.((/ 0

JoinPolicy((0 :
:((; <
$str((= C
)((C D
)((D E
.)) 
ToListAsync)) 
()) 
ct)) 
))) 
;)) 
}** 
public,, 

async,, 
Task,, 
AddAsync,, 
(,, 
Organization,, +
organization,,, 8
,,,8 9
CancellationToken,,: K
ct,,L N
=,,O P
default,,Q X
),,X Y
{-- 
db.. 

...
 
Organizations.. 
... 
Add.. 
(.. 
organization.. )
)..) *
;..* +
await// 
db// 
.// 
SaveChangesAsync// !
(//! "
ct//" $
)//$ %
;//% &
}00 
public22 

async22 
Task22 
UpdateAsync22 !
(22! "
Organization22" .
organization22/ ;
,22; <
CancellationToken22= N
ct22O Q
=22R S
default22T [
)22[ \
{33 
db44 

.44
 
Organizations44 
.44 
Update44 
(44  
organization44  ,
)44, -
;44- .
await55 
db55 
.55 
SaveChangesAsync55 !
(55! "
ct55" $
)55$ %
;55% &
}66 
}77 ú0
xC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Repositories\OrganizationRoleRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Repositories' 3
;3 4
public 
sealed 
class &
OrganizationRoleRepository .
(. /
RelativaDbContext/ @
dbA C
)C D
:E F'
IOrganizationRoleRepositoryG b
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
 
OrganizationRole

 &
?

& '
>

' (
GetByIdAsync

) 5
(

5 6
int

6 9
id

: <
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
{ 
return 
await 
db 
. 
OrganizationRoles )
. 
Include 
( 
r 
=> 
r 
. 
RolePermissions +
)+ ,
. 
ThenInclude 
( 
rp 
=>  "
rp# %
.% &

Permission& 0
)0 1
. 
FirstOrDefaultAsync  
(  !
r! "
=># %
r& '
.' (
Id( *
==+ -
id. 0
&&1 3
!4 5
r5 6
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
List 
< 
OrganizationRole +
>+ ,
>, -$
GetByOrganizationIdAsync. F
(F G
intG J
organizationIdK Y
,Y Z
CancellationToken[ l
ctm o
=p q
defaultr y
)y z
{ 
return 
await 
db 
. 
OrganizationRoles )
. 
Include 
( 
r 
=> 
r 
. 
RolePermissions +
)+ ,
. 
ThenInclude 
( 
rp 
=>  "
rp# %
.% &

Permission& 0
)0 1
. 
Where 
( 
r 
=> 
( 
r 
. 
OrganizationId )
==* ,
null- 1
||2 4
r5 6
.6 7
OrganizationId7 E
==F H
organizationIdI W
)W X
&&Y [
!\ ]
r] ^
.^ _

IsArchived_ i
)i j
. 
ToListAsync 
( 
ct 
) 
; 
} 
public 

async 
Task 
< 
List 
< 
OrganizationRole +
>+ ,
>, -
GetSystemRolesAsync. A
(A B
CancellationTokenB S
ctT V
=W X
defaultY `
)` a
{ 
return 
await 
db 
. 
OrganizationRoles )
. 
Include 
( 
r 
=> 
r 
. 
RolePermissions +
)+ ,
. 
ThenInclude 
( 
rp 
=>  "
rp# %
.% &

Permission& 0
)0 1
.   
Where   
(   
r   
=>   
r   
.   
OrganizationId   (
==  ) +
null  , 0
&&  1 3
!  4 5
r  5 6
.  6 7

IsArchived  7 A
)  A B
.!! 
ToListAsync!! 
(!! 
ct!! 
)!! 
;!! 
}"" 
public$$ 

async$$ 
Task$$ 
<$$ 
OrganizationRole$$ &
?$$& '
>$$' ($
GetSystemRoleByNameAsync$$) A
($$A B
string$$B H
name$$I M
,$$M N
CancellationToken$$O `
ct$$a c
=$$d e
default$$f m
)$$m n
{%% 
return&& 
await&& 
db&& 
.&& 
OrganizationRoles&& )
.'' 
FirstOrDefaultAsync''  
(''  !
r''! "
=>''# %
r''& '
.''' (
Name''( ,
==''- /
name''0 4
&&''5 7
r''8 9
.''9 :
OrganizationId'': H
==''I K
null''L P
&&''Q S
!''T U
r''U V
.''V W

IsArchived''W a
,''a b
ct''c e
)''e f
;''f g
}(( 
public** 

async** 
Task** 
AddAsync** 
(** 
OrganizationRole** /
role**0 4
,**4 5
CancellationToken**6 G
ct**H J
=**K L
default**M T
)**T U
{++ 
db,, 

.,,
 
OrganizationRoles,, 
.,, 
Add,,  
(,,  !
role,,! %
),,% &
;,,& '
await-- 
db-- 
.-- 
SaveChangesAsync-- !
(--! "
ct--" $
)--$ %
;--% &
}.. 
public00 

async00 
Task00 
UpdateAsync00 !
(00! "
OrganizationRole00" 2
role003 7
,007 8
CancellationToken009 J
ct00K M
=00N O
default00P W
)00W X
{11 
db22 

.22
 
OrganizationRoles22 
.22 
Update22 #
(22# $
role22$ (
)22( )
;22) *
await33 
db33 
.33 
SaveChangesAsync33 !
(33! "
ct33" $
)33$ %
;33% &
}44 
}55 ¯
rC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Repositories\EntityTypeRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Repositories' 3
;3 4
public 
sealed 
class  
EntityTypeRepository (
(( )
RelativaDbContext) :
db; =
)= >
:? @!
IEntityTypeRepositoryA V
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
List

 
<

 

EntityType

 %
>

% &
>

& '%
GetAllWithPropertiesAsync

( A
(

A B
CancellationToken

B S
ct

T V
=

W X
default

Y `
)

` a
{ 
return 
await 
db 
. 
EntityTypes #
. 
AsNoTracking 
( 
) 
. 
Include 
( 
et 
=> 
et 
.  
EntityTypeProperties 2
)2 3
. 
ThenInclude 
( 
etp  
=>! #
etp$ '
.' (
Property( 0
)0 1
. 
ThenInclude  
(  !
p! "
=># %
p& '
.' (
AllowedValues( 5
)5 6
. 
Include 
( 
et 
=> 
et 
. #
SourceRelationshipTypes 5
)5 6
. 
ThenInclude 
( 
rt 
=>  "
rt# %
.% &
TargetEntityType& 6
)6 7
. 
Include 
( 
et 
=> 
et 
. #
TargetRelationshipTypes 5
)5 6
. 
ThenInclude 
( 
rt 
=>  "
rt# %
.% &
SourceEntityType& 6
)6 7
. 
OrderBy 
( 
et 
=> 
et 
. 
Id  
)  !
. 
ToListAsync 
( 
ct 
) 
; 
} 
} ππ
nC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Repositories\EntityRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Repositories' 3
;3 4
public 
sealed 
class 
EntityRepository $
($ %
RelativaDbContext% 6
db7 9
)9 :
:; <
IEntityRepository= N
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
 

EntityType

 
?

 
>

 "
GetEntityTypeByIdAsync

 3
(

3 4
int

4 7
entityTypeId

8 D
,

D E
CancellationToken

F W
ct

X Z
=

[ \
default

] d
)

d e
=>

f h
db 

.
 
EntityTypes 
. 
AsNoTracking 
( 
) 
. 
FirstOrDefaultAsync  
(  !
e! "
=># %
e& '
.' (
Id( *
==+ -
entityTypeId. :
,: ;
ct< >
)> ?
;? @
public 

Task 
< 
List 
< "
EntityRelationshipType +
>+ ,
>, --
!GetOutgoingRelationshipTypesAsync. O
(O P
intP S
entityTypeIdT `
,` a
CancellationTokenb s
ctt v
=w x
default	y Ä
)
Ä Å
=>
Ç Ñ
db 

.
 #
EntityRelationshipTypes "
. 
AsNoTracking 
( 
) 
. 
Where 
( 
rt 
=> 
rt 
. 
SourceEntityTypeId .
==/ 1
entityTypeId2 >
)> ?
. 
ToListAsync 
( 
ct 
) 
; 
public 

async 
Task 
< 
List 
< 
EntityTypeProperty -
>- .
>. /"
GetTypePropertiesAsync0 F
(F G
intG J
entityTypeIdK W
,W X
CancellationTokenY j
ctk m
=n o
defaultp w
)w x
{ 
return 
await 
db 
.  
EntityTypeProperties ,
. 
AsNoTracking 
( 
) 
. 
Include 
( 
etp 
=> 
etp 
.  
Property  (
)( )
. 
ThenInclude 
( 
p 
=> !
p" #
.# $
AllowedValues$ 1
)1 2
. 
Where 
( 
etp 
=> 
etp 
. 
EntityTypeId *
==+ -
entityTypeId. :
): ;
. 
ToListAsync 
( 
ct 
) 
; 
} 
public 

async 
Task 
< 
( 
List 
< 
Entity "
>" #
Items$ )
,) *
int+ .
Total/ 4
)4 5
>5 6
GetByWorkspaceAsync7 J
(J K
int   
workspaceId   
,   
int!! 
requesterUserId!! 
,!! 
int"" !
requesterRolePriority"" !
,""! "
int## 
?## 
entityTypeId## 
,## 
string$$ 
?$$ 
searchQuery$$ 
,$$ 
int%% 
skip%% 
,%% 
int&& 
take&& 
,&& 
IReadOnlyList'' 
<'' #
ResolvedFilterCondition'' -
>''- .
filters''/ 6
,''6 7
IReadOnlyList(( 
<(( 
EntitySortField(( %
>((% &
sort((' +
,((+ ,
int)) 
?)) (
excludeLinkedSourceRelTypeId)) )
=))* +
null)), 0
,))0 1
int** 
?** (
excludeLinkedTargetRelTypeId** )
=*** +
null**, 0
,**0 1
CancellationToken++ 
ct++ 
=++ 
default++ &
)++& '
{,, 
skip-- 
=-- 
Math-- 
.-- 
Max-- 
(-- 
skip-- 
,-- 
$num-- 
)--  
;--  !
take.. 
=.. 
Math.. 
... 
Clamp.. 
(.. 
take.. 
,.. 
$num..  !
,..! "
$num..# &
)..& '
;..' (
var00 
query00 
=00 
db00 
.00 
Entities00 
.11 
AsNoTracking11 
(11 
)11 
.22 
Where22 
(22 
e22 
=>22 
!22 
e22 
.22 

IsArchived22 %
&&22& (
e22) *
.22* +
EntityWorkspaces22+ ;
.22; <
Any22< ?
(22? @
ew22@ B
=>22C E
ew22F H
.22H I
WorkspaceId22I T
==22U W
workspaceId22X c
)22c d
)22d e
.33 
Where33 
(33 
e33 
=>33 
e44 
.44 
CreatedByUserId44 !
==44" $
requesterUserId44% 4
||55 
db55 
.55 
UserRoleWorkspaces55 (
.55( )
Any55) ,
(55, -
urw55- 0
=>551 3
urw66 
.66 
WorkspaceId66 #
==66$ &
workspaceId66' 2
&&77 
!77 
urw77 
.77 

IsArchived77 &
&&88 
urw88 
.88 
UserId88 !
==88" $
e88% &
.88& '
CreatedByUserId88' 6
&&99 
urw99 
.99 
Role99 
.99  
Priority99  (
>99) *!
requesterRolePriority99+ @
)99@ A
)99A B
;99B C
if;; 

(;; 
entityTypeId;; 
is;; 
>;; 
$num;; 
);;  
query<< 
=<< 
query<< 
.<< 
Where<< 
(<<  
e<<  !
=><<" $
e<<% &
.<<& '
EntityTypeId<<' 3
==<<4 6
entityTypeId<<7 C
.<<C D
Value<<D I
)<<I J
;<<J K
if>> 

(>> 
!>> 
string>> 
.>> 
IsNullOrWhiteSpace>> &
(>>& '
searchQuery>>' 2
)>>2 3
)>>3 4
{?? 	
var@@ 
pattern@@ 
=@@ 
searchQuery@@ %
.@@% &
Trim@@& *
(@@* +
)@@+ ,
;@@, -
queryAA 
=AA 
queryAA 
.AA 
WhereAA 
(AA  
eAA  !
=>AA" $
eAA% &
.AA& ' 
EntityPropertyValuesAA' ;
.AA; <
AnyAA< ?
(AA? @
epvAA@ C
=>AAD F
epvBB 
.BB 
ValueStringBB 
!=BB  "
nullBB# '
&&BB( *
epvBB+ .
.BB. /
ValueStringBB/ :
.BB: ;
ContainsBB; C
(BBC D
patternBBD K
)BBK L
)BBL M
)BBM N
;BBN O
}CC 	
ifEE 

(EE (
excludeLinkedSourceRelTypeIdEE (
isEE) +
>EE, -
$numEE. /
)EE/ 0
queryFF 
=FF 
queryFF 
.FF 
WhereFF 
(FF  
eFF  !
=>FF" $
!FF% &
dbFF& (
.FF( )
EntityRelationshipsFF) <
.GG 
AnyGG 
(GG 
rGG 
=>GG 
rGG 
.GG 
SourceEntityIdGG *
==GG+ -
eGG. /
.GG/ 0
IdGG0 2
&&GG3 5
rGG6 7
.GG7 8
RelationshipTypeIdGG8 J
==GGK M(
excludeLinkedSourceRelTypeIdGGN j
.GGj k
ValueGGk p
)GGp q
)GGq r
;GGr s
ifII 

(II (
excludeLinkedTargetRelTypeIdII (
isII) +
>II, -
$numII. /
)II/ 0
queryJJ 
=JJ 
queryJJ 
.JJ 
WhereJJ 
(JJ  
eJJ  !
=>JJ" $
!JJ% &
dbJJ& (
.JJ( )
EntityRelationshipsJJ) <
.KK 
AnyKK 
(KK 
rKK 
=>KK 
rKK 
.KK 
TargetEntityIdKK *
==KK+ -
eKK. /
.KK/ 0
IdKK0 2
&&KK3 5
rKK6 7
.KK7 8
RelationshipTypeIdKK8 J
==KKK M(
excludeLinkedTargetRelTypeIdKKN j
.KKj k
ValueKKk p
)KKp q
)KKq r
;KKr s
foreachNN 
(NN 
varNN 
fNN 
inNN 
filtersNN !
)NN! "
{OO 	
varPP 
pidPP 
=PP 
fPP 
.PP 

PropertyIdPP "
;PP" #
queryQQ 
=QQ 
(QQ 
fQQ 
.QQ 
DataTypeQQ 
,QQ  
fQQ! "
.QQ" #
OpQQ# %
)QQ% &
switchQQ' -
{RR 
(SS 
PropertyDataTypeSS !
.SS! "
StringSS" (
,SS( )
$strSS+ /
)SS/ 0
=>SS9 ;
querySS< A
.SSA B
WhereSSB G
(SSG H
eSSH I
=>SSJ L
eSSM N
.SSN O 
EntityPropertyValuesSSO c
.SSc d
AnySSd g
(SSg h
vSSh i
=>SSj l
vSSm n
.SSn o

PropertyIdSSo y
==SSz |
pid	SS} Ä
&&
SSÅ É
v
SSÑ Ö
.
SSÖ Ü
ValueString
SSÜ ë
==
SSí î
f
SSï ñ
.
SSñ ó
StringValue
SSó ¢
)
SS¢ £
)
SS£ §
,
SS§ •
(TT 
PropertyDataTypeTT !
.TT! "
StringTT" (
,TT( )
$strTT+ 0
)TT0 1
=>TT9 ;
queryTT< A
.TTA B
WhereTTB G
(TTG H
eTTH I
=>TTJ L
eTTM N
.TTN O 
EntityPropertyValuesTTO c
.TTc d
AnyTTd g
(TTg h
vTTh i
=>TTj l
vTTm n
.TTn o

PropertyIdTTo y
==TTz |
pid	TT} Ä
&&
TTÅ É
v
TTÑ Ö
.
TTÖ Ü
ValueString
TTÜ ë
!=
TTí î
f
TTï ñ
.
TTñ ó
StringValue
TTó ¢
)
TT¢ £
)
TT£ §
,
TT§ •
(UU 
PropertyDataTypeUU !
.UU! "
StringUU" (
,UU( )
$strUU+ 5
)UU5 6
=>UU9 ;
queryUU< A
.UUA B
WhereUUB G
(UUG H
eUUH I
=>UUJ L
eUUM N
.UUN O 
EntityPropertyValuesUUO c
.UUc d
AnyUUd g
(UUg h
vUUh i
=>UUj l
vUUm n
.UUn o

PropertyIdUUo y
==UUz |
pid	UU} Ä
&&
UUÅ É
v
UUÑ Ö
.
UUÖ Ü
ValueString
UUÜ ë
!=
UUí î
null
UUï ô
&&
UUö ú
v
UUù û
.
UUû ü
ValueString
UUü ™
.
UU™ ´
Contains
UU´ ≥
(
UU≥ ¥
f
UU¥ µ
.
UUµ ∂
StringValue
UU∂ ¡
!
UU¡ ¬
)
UU¬ √
)
UU√ ƒ
)
UUƒ ≈
,
UU≈ ∆
(VV 
PropertyDataTypeVV !
.VV! "
StringVV" (
,VV( )
$strVV+ 7
)VV7 8
=>VV: <
queryVV= B
.VVB C
WhereVVC H
(VVH I
eVVI J
=>VVK M
eVVN O
.VVO P 
EntityPropertyValuesVVP d
.VVd e
AnyVVe h
(VVh i
vVVi j
=>VVk m
vVVn o
.VVo p

PropertyIdVVp z
==VV{ }
pid	VV~ Å
&&
VVÇ Ñ
v
VVÖ Ü
.
VVÜ á
ValueString
VVá í
!=
VVì ï
null
VVñ ö
&&
VVõ ù
v
VVû ü
.
VVü †
ValueString
VV† ´
.
VV´ ¨

StartsWith
VV¨ ∂
(
VV∂ ∑
f
VV∑ ∏
.
VV∏ π
StringValue
VVπ ƒ
!
VVƒ ≈
)
VV≈ ∆
)
VV∆ «
)
VV« »
,
VV» …
(WW 
PropertyDataTypeWW !
.WW! "
IntWW" %
,WW% &
$strWW+ /
)WW/ 0
=>WW9 ;
queryWW< A
.WWA B
WhereWWB G
(WWG H
eWWH I
=>WWJ L
eWWM N
.WWN O 
EntityPropertyValuesWWO c
.WWc d
AnyWWd g
(WWg h
vWWh i
=>WWj l
vWWm n
.WWn o

PropertyIdWWo y
==WWz |
pid	WW} Ä
&&
WWÅ É
v
WWÑ Ö
.
WWÖ Ü
ValueInt
WWÜ é
==
WWè ë
f
WWí ì
.
WWì î
IntValue
WWî ú
)
WWú ù
)
WWù û
,
WWû ü
(XX 
PropertyDataTypeXX !
.XX! "
IntXX" %
,XX% &
$strXX+ 0
)XX0 1
=>XX9 ;
queryXX< A
.XXA B
WhereXXB G
(XXG H
eXXH I
=>XXJ L
eXXM N
.XXN O 
EntityPropertyValuesXXO c
.XXc d
AnyXXd g
(XXg h
vXXh i
=>XXj l
vXXm n
.XXn o

PropertyIdXXo y
==XXz |
pid	XX} Ä
&&
XXÅ É
v
XXÑ Ö
.
XXÖ Ü
ValueInt
XXÜ é
!=
XXè ë
f
XXí ì
.
XXì î
IntValue
XXî ú
)
XXú ù
)
XXù û
,
XXû ü
(YY 
PropertyDataTypeYY !
.YY! "
IntYY" %
,YY% &
$strYY+ /
)YY/ 0
=>YY9 ;
queryYY< A
.YYA B
WhereYYB G
(YYG H
eYYH I
=>YYJ L
eYYM N
.YYN O 
EntityPropertyValuesYYO c
.YYc d
AnyYYd g
(YYg h
vYYh i
=>YYj l
vYYm n
.YYn o

PropertyIdYYo y
==YYz |
pid	YY} Ä
&&
YYÅ É
v
YYÑ Ö
.
YYÖ Ü
ValueInt
YYÜ é
>
YYè ê
f
YYë í
.
YYí ì
IntValue
YYì õ
)
YYõ ú
)
YYú ù
,
YYù û
(ZZ 
PropertyDataTypeZZ !
.ZZ! "
IntZZ" %
,ZZ% &
$strZZ+ /
)ZZ/ 0
=>ZZ9 ;
queryZZ< A
.ZZA B
WhereZZB G
(ZZG H
eZZH I
=>ZZJ L
eZZM N
.ZZN O 
EntityPropertyValuesZZO c
.ZZc d
AnyZZd g
(ZZg h
vZZh i
=>ZZj l
vZZm n
.ZZn o

PropertyIdZZo y
==ZZz |
pid	ZZ} Ä
&&
ZZÅ É
v
ZZÑ Ö
.
ZZÖ Ü
ValueInt
ZZÜ é
<
ZZè ê
f
ZZë í
.
ZZí ì
IntValue
ZZì õ
)
ZZõ ú
)
ZZú ù
,
ZZù û
([[ 
PropertyDataType[[ !
.[[! "
Int[[" %
,[[% &
$str[[+ 0
)[[0 1
=>[[9 ;
query[[< A
.[[A B
Where[[B G
([[G H
e[[H I
=>[[J L
e[[M N
.[[N O 
EntityPropertyValues[[O c
.[[c d
Any[[d g
([[g h
v[[h i
=>[[j l
v[[m n
.[[n o

PropertyId[[o y
==[[z |
pid	[[} Ä
&&
[[Å É
v
[[Ñ Ö
.
[[Ö Ü
ValueInt
[[Ü é
>=
[[è ë
f
[[í ì
.
[[ì î
IntValue
[[î ú
)
[[ú ù
)
[[ù û
,
[[û ü
(\\ 
PropertyDataType\\ !
.\\! "
Int\\" %
,\\% &
$str\\+ 0
)\\0 1
=>\\9 ;
query\\< A
.\\A B
Where\\B G
(\\G H
e\\H I
=>\\J L
e\\M N
.\\N O 
EntityPropertyValues\\O c
.\\c d
Any\\d g
(\\g h
v\\h i
=>\\j l
v\\m n
.\\n o

PropertyId\\o y
==\\z |
pid	\\} Ä
&&
\\Å É
v
\\Ñ Ö
.
\\Ö Ü
ValueInt
\\Ü é
<=
\\è ë
f
\\í ì
.
\\ì î
IntValue
\\î ú
)
\\ú ù
)
\\ù û
,
\\û ü
(]] 
PropertyDataType]] !
.]]! "
Decimal]]" )
,]]) *
$str]]+ /
)]]/ 0
=>]]9 ;
query]]< A
.]]A B
Where]]B G
(]]G H
e]]H I
=>]]J L
e]]M N
.]]N O 
EntityPropertyValues]]O c
.]]c d
Any]]d g
(]]g h
v]]h i
=>]]j l
v]]m n
.]]n o

PropertyId]]o y
==]]z |
pid	]]} Ä
&&
]]Å É
v
]]Ñ Ö
.
]]Ö Ü
ValueDecimal
]]Ü í
==
]]ì ï
f
]]ñ ó
.
]]ó ò
DecimalValue
]]ò §
)
]]§ •
)
]]• ¶
,
]]¶ ß
(^^ 
PropertyDataType^^ !
.^^! "
Decimal^^" )
,^^) *
$str^^+ 0
)^^0 1
=>^^9 ;
query^^< A
.^^A B
Where^^B G
(^^G H
e^^H I
=>^^J L
e^^M N
.^^N O 
EntityPropertyValues^^O c
.^^c d
Any^^d g
(^^g h
v^^h i
=>^^j l
v^^m n
.^^n o

PropertyId^^o y
==^^z |
pid	^^} Ä
&&
^^Å É
v
^^Ñ Ö
.
^^Ö Ü
ValueDecimal
^^Ü í
!=
^^ì ï
f
^^ñ ó
.
^^ó ò
DecimalValue
^^ò §
)
^^§ •
)
^^• ¶
,
^^¶ ß
(__ 
PropertyDataType__ !
.__! "
Decimal__" )
,__) *
$str__+ /
)__/ 0
=>__9 ;
query__< A
.__A B
Where__B G
(__G H
e__H I
=>__J L
e__M N
.__N O 
EntityPropertyValues__O c
.__c d
Any__d g
(__g h
v__h i
=>__j l
v__m n
.__n o

PropertyId__o y
==__z |
pid	__} Ä
&&
__Å É
v
__Ñ Ö
.
__Ö Ü
ValueDecimal
__Ü í
>
__ì î
f
__ï ñ
.
__ñ ó
DecimalValue
__ó £
)
__£ §
)
__§ •
,
__• ¶
(`` 
PropertyDataType`` !
.``! "
Decimal``" )
,``) *
$str``+ /
)``/ 0
=>``9 ;
query``< A
.``A B
Where``B G
(``G H
e``H I
=>``J L
e``M N
.``N O 
EntityPropertyValues``O c
.``c d
Any``d g
(``g h
v``h i
=>``j l
v``m n
.``n o

PropertyId``o y
==``z |
pid	``} Ä
&&
``Å É
v
``Ñ Ö
.
``Ö Ü
ValueDecimal
``Ü í
<
``ì î
f
``ï ñ
.
``ñ ó
DecimalValue
``ó £
)
``£ §
)
``§ •
,
``• ¶
(aa 
PropertyDataTypeaa !
.aa! "
Decimalaa" )
,aa) *
$straa+ 0
)aa0 1
=>aa9 ;
queryaa< A
.aaA B
WhereaaB G
(aaG H
eaaH I
=>aaJ L
eaaM N
.aaN O 
EntityPropertyValuesaaO c
.aac d
Anyaad g
(aag h
vaah i
=>aaj l
vaam n
.aan o

PropertyIdaao y
==aaz |
pid	aa} Ä
&&
aaÅ É
v
aaÑ Ö
.
aaÖ Ü
ValueDecimal
aaÜ í
>=
aaì ï
f
aañ ó
.
aaó ò
DecimalValue
aaò §
)
aa§ •
)
aa• ¶
,
aa¶ ß
(bb 
PropertyDataTypebb !
.bb! "
Decimalbb" )
,bb) *
$strbb+ 0
)bb0 1
=>bb9 ;
querybb< A
.bbA B
WherebbB G
(bbG H
ebbH I
=>bbJ L
ebbM N
.bbN O 
EntityPropertyValuesbbO c
.bbc d
Anybbd g
(bbg h
vbbh i
=>bbj l
vbbm n
.bbn o

PropertyIdbbo y
==bbz |
pid	bb} Ä
&&
bbÅ É
v
bbÑ Ö
.
bbÖ Ü
ValueDecimal
bbÜ í
<=
bbì ï
f
bbñ ó
.
bbó ò
DecimalValue
bbò §
)
bb§ •
)
bb• ¶
,
bb¶ ß
(cc 
PropertyDataTypecc !
.cc! "
Boolcc" &
,cc& '
$strcc+ /
)cc/ 0
=>cc9 ;
querycc< A
.ccA B
WhereccB G
(ccG H
eccH I
=>ccJ L
eccM N
.ccN O 
EntityPropertyValuesccO c
.ccc d
Anyccd g
(ccg h
vcch i
=>ccj l
vccm n
.ccn o

PropertyIdcco y
==ccz |
pid	cc} Ä
&&
ccÅ É
v
ccÑ Ö
.
ccÖ Ü
	ValueBool
ccÜ è
==
ccê í
f
ccì î
.
ccî ï
	BoolValue
ccï û
)
ccû ü
)
ccü †
,
cc† °
(dd 
PropertyDataTypedd !
.dd! "
Booldd" &
,dd& '
$strdd+ 0
)dd0 1
=>dd9 ;
querydd< A
.ddA B
WhereddB G
(ddG H
eddH I
=>ddJ L
eddM N
.ddN O 
EntityPropertyValuesddO c
.ddc d
Anyddd g
(ddg h
vddh i
=>ddj l
vddm n
.ddn o

PropertyIdddo y
==ddz |
pid	dd} Ä
&&
ddÅ É
v
ddÑ Ö
.
ddÖ Ü
	ValueBool
ddÜ è
!=
ddê í
f
ddì î
.
ddî ï
	BoolValue
ddï û
)
ddû ü
)
ddü †
,
dd† °
(ee 
PropertyDataTypeee !
.ee! "
Dateee" &
,ee& '
$stree+ /
)ee/ 0
=>ee9 ;
queryee< A
.eeA B
WhereeeB G
(eeG H
eeeH I
=>eeJ L
eeeM N
.eeN O 
EntityPropertyValueseeO c
.eec d
Anyeed g
(eeg h
veeh i
=>eej l
veem n
.een o

PropertyIdeeo y
==eez |
pid	ee} Ä
&&
eeÅ É
v
eeÑ Ö
.
eeÖ Ü
	ValueDate
eeÜ è
==
eeê í
f
eeì î
.
eeî ï
	DateValue
eeï û
)
eeû ü
)
eeü †
,
ee† °
(ff 
PropertyDataTypeff !
.ff! "
Dateff" &
,ff& '
$strff+ 0
)ff0 1
=>ff9 ;
queryff< A
.ffA B
WhereffB G
(ffG H
effH I
=>ffJ L
effM N
.ffN O 
EntityPropertyValuesffO c
.ffc d
Anyffd g
(ffg h
vffh i
=>ffj l
vffm n
.ffn o

PropertyIdffo y
==ffz |
pid	ff} Ä
&&
ffÅ É
v
ffÑ Ö
.
ffÖ Ü
	ValueDate
ffÜ è
!=
ffê í
f
ffì î
.
ffî ï
	DateValue
ffï û
)
ffû ü
)
ffü †
,
ff† °
(gg 
PropertyDataTypegg !
.gg! "
Dategg" &
,gg& '
$strgg+ /
)gg/ 0
=>gg9 ;
querygg< A
.ggA B
WhereggB G
(ggG H
eggH I
=>ggJ L
eggM N
.ggN O 
EntityPropertyValuesggO c
.ggc d
Anyggd g
(ggg h
vggh i
=>ggj l
vggm n
.ggn o

PropertyIdggo y
==ggz |
pid	gg} Ä
&&
ggÅ É
v
ggÑ Ö
.
ggÖ Ü
	ValueDate
ggÜ è
>
ggê ë
f
ggí ì
.
ggì î
	DateValue
ggî ù
)
ggù û
)
ggû ü
,
ggü †
(hh 
PropertyDataTypehh !
.hh! "
Datehh" &
,hh& '
$strhh+ /
)hh/ 0
=>hh9 ;
queryhh< A
.hhA B
WherehhB G
(hhG H
ehhH I
=>hhJ L
ehhM N
.hhN O 
EntityPropertyValueshhO c
.hhc d
Anyhhd g
(hhg h
vhhh i
=>hhj l
vhhm n
.hhn o

PropertyIdhho y
==hhz |
pid	hh} Ä
&&
hhÅ É
v
hhÑ Ö
.
hhÖ Ü
	ValueDate
hhÜ è
<
hhê ë
f
hhí ì
.
hhì î
	DateValue
hhî ù
)
hhù û
)
hhû ü
,
hhü †
(ii 
PropertyDataTypeii !
.ii! "
Dateii" &
,ii& '
$strii+ 0
)ii0 1
=>ii9 ;
queryii< A
.iiA B
WhereiiB G
(iiG H
eiiH I
=>iiJ L
eiiM N
.iiN O 
EntityPropertyValuesiiO c
.iic d
Anyiid g
(iig h
viih i
=>iij l
viim n
.iin o

PropertyIdiio y
==iiz |
pid	ii} Ä
&&
iiÅ É
v
iiÑ Ö
.
iiÖ Ü
	ValueDate
iiÜ è
>=
iiê í
f
iiì î
.
iiî ï
	DateValue
iiï û
)
iiû ü
)
iiü †
,
ii† °
(jj 
PropertyDataTypejj !
.jj! "
Datejj" &
,jj& '
$strjj+ 0
)jj0 1
=>jj9 ;
queryjj< A
.jjA B
WherejjB G
(jjG H
ejjH I
=>jjJ L
ejjM N
.jjN O 
EntityPropertyValuesjjO c
.jjc d
Anyjjd g
(jjg h
vjjh i
=>jjj l
vjjm n
.jjn o

PropertyIdjjo y
==jjz |
pid	jj} Ä
&&
jjÅ É
v
jjÑ Ö
.
jjÖ Ü
	ValueDate
jjÜ è
<=
jjê í
f
jjì î
.
jjî ï
	DateValue
jjï û
)
jjû ü
)
jjü †
,
jj† °
_kk 
=>kk 
querykk 
}ll 
;ll 
}mm 	
IOrderedQueryablepp 
<pp 
Entitypp  
>pp  !
orderedpp" )
;pp) *
ifqq 

(qq 
sortqq 
isqq 
{qq 
Countqq 
:qq 
>qq 
$numqq  
}qq! "
)qq" #
{rr 	
orderedss 
=ss 
	ApplySortss 
(ss  
queryss  %
,ss% &
sortss' +
[ss+ ,
$numss, -
]ss- .
,ss. /
isFirstss0 7
:ss7 8
truess9 =
)ss= >
;ss> ?
foreachtt 
(tt 
vartt 
stt 
intt 
sorttt "
.tt" #
Skiptt# '
(tt' (
$numtt( )
)tt) *
)tt* +
ordereduu 
=uu 
	ApplySortuu #
(uu# $
ordereduu$ +
,uu+ ,
suu- .
,uu. /
isFirstuu0 7
:uu7 8
falseuu9 >
)uu> ?
;uu? @
}vv 	
elseww 
{xx 	
orderedyy 
=yy 
queryyy 
.yy 
OrderByyy #
(yy# $
eyy$ %
=>yy& (
eyy) *
.yy* +
Idyy+ -
)yy- .
;yy. /
}zz 	
var|| 
total|| 
=|| 
await|| 
ordered|| !
.||! "

CountAsync||" ,
(||, -
ct||- /
)||/ 0
;||0 1
var}} 
items}} 
=}} 
await}} 
ordered}} !
.~~ 
Include~~ 
(~~ 
e~~ 
=>~~ 
e~~ 
.~~ 

EntityType~~ &
)~~& '
. 
Include 
( 
e 
=> 
e 
.  
EntityPropertyValues 0
)0 1
.
ÄÄ 
ThenInclude
ÄÄ 
(
ÄÄ 
epv
ÄÄ  
=>
ÄÄ! #
epv
ÄÄ$ '
.
ÄÄ' (
Property
ÄÄ( 0
)
ÄÄ0 1
.
ÅÅ 
Skip
ÅÅ 
(
ÅÅ 
skip
ÅÅ 
)
ÅÅ 
.
ÇÇ 
Take
ÇÇ 
(
ÇÇ 
take
ÇÇ 
)
ÇÇ 
.
ÉÉ 
ToListAsync
ÉÉ 
(
ÉÉ 
ct
ÉÉ 
)
ÉÉ 
;
ÉÉ 
return
ÖÖ 
(
ÖÖ 
items
ÖÖ 
,
ÖÖ 
total
ÖÖ 
)
ÖÖ 
;
ÖÖ 
}
ÜÜ 
private
àà 
static
àà 
IOrderedQueryable
àà $
<
àà$ %
Entity
àà% +
>
àà+ ,
	ApplySort
àà- 6
(
àà6 7

IQueryable
àà7 A
<
ààA B
Entity
ààB H
>
ààH I
query
ààJ O
,
ààO P
EntitySortField
ààQ `
s
ààa b
,
ààb c
bool
ààd h
isFirst
àài p
)
ààp q
{
ââ 
var
ää 
pid
ää 
=
ää 
s
ää 
.
ää 

PropertyId
ää 
;
ää 
var
ãã 
desc
ãã 
=
ãã 
s
ãã 
.
ãã 
	Direction
ãã 
.
ãã 
Equals
ãã %
(
ãã% &
$str
ãã& ,
,
ãã, -
StringComparison
ãã. >
.
ãã> ?
OrdinalIgnoreCase
ãã? P
)
ããP Q
;
ããQ R
return
åå 
(
åå 
isFirst
åå 
,
åå 
desc
åå 
)
åå 
switch
åå %
{
çç 	
(
éé 
true
éé 
,
éé 
true
éé 
)
éé 
=>
éé 
query
éé #
.
éé# $
OrderByDescending
éé$ 5
(
éé5 6
e
éé6 7
=>
éé8 :
e
éé; <
.
éé< ="
EntityPropertyValues
éé= Q
.
èè 
Where
èè 
(
èè 
v
èè 
=>
èè 
v
èè 
.
èè 

PropertyId
èè (
==
èè) +
pid
èè, /
)
èè/ 0
.
èè0 1
Select
èè1 7
(
èè7 8
v
èè8 9
=>
èè: <
v
èè= >
.
èè> ?
ValueString
èè? J
)
èèJ K
.
èèK L
FirstOrDefault
èèL Z
(
èèZ [
)
èè[ \
)
èè\ ]
,
èè] ^
(
êê 
true
êê 
,
êê 
false
êê 
)
êê 
=>
êê 
query
êê #
.
êê# $
OrderBy
êê$ +
(
êê+ ,
e
êê, -
=>
êê. 0
e
êê1 2
.
êê2 3"
EntityPropertyValues
êê3 G
.
ëë 
Where
ëë 
(
ëë 
v
ëë 
=>
ëë 
v
ëë 
.
ëë 

PropertyId
ëë (
==
ëë) +
pid
ëë, /
)
ëë/ 0
.
ëë0 1
Select
ëë1 7
(
ëë7 8
v
ëë8 9
=>
ëë: <
v
ëë= >
.
ëë> ?
ValueString
ëë? J
)
ëëJ K
.
ëëK L
FirstOrDefault
ëëL Z
(
ëëZ [
)
ëë[ \
)
ëë\ ]
,
ëë] ^
(
íí 
false
íí 
,
íí 
true
íí 
)
íí 
=>
íí 
(
íí 
(
íí  
IOrderedQueryable
íí  1
<
íí1 2
Entity
íí2 8
>
íí8 9
)
íí9 :
query
íí: ?
)
íí? @
.
íí@ A
ThenByDescending
ííA Q
(
ííQ R
e
ííR S
=>
ííT V
e
ííW X
.
ííX Y"
EntityPropertyValues
ííY m
.
ìì 
Where
ìì 
(
ìì 
v
ìì 
=>
ìì 
v
ìì 
.
ìì 

PropertyId
ìì (
==
ìì) +
pid
ìì, /
)
ìì/ 0
.
ìì0 1
Select
ìì1 7
(
ìì7 8
v
ìì8 9
=>
ìì: <
v
ìì= >
.
ìì> ?
ValueString
ìì? J
)
ììJ K
.
ììK L
FirstOrDefault
ììL Z
(
ììZ [
)
ìì[ \
)
ìì\ ]
,
ìì] ^
(
îî 
false
îî 
,
îî 
false
îî 
)
îî 
=>
îî 
(
îî 
(
îî  
IOrderedQueryable
îî  1
<
îî1 2
Entity
îî2 8
>
îî8 9
)
îî9 :
query
îî: ?
)
îî? @
.
îî@ A
ThenBy
îîA G
(
îîG H
e
îîH I
=>
îîJ L
e
îîM N
.
îîN O"
EntityPropertyValues
îîO c
.
ïï 
Where
ïï 
(
ïï 
v
ïï 
=>
ïï 
v
ïï 
.
ïï 

PropertyId
ïï (
==
ïï) +
pid
ïï, /
)
ïï/ 0
.
ïï0 1
Select
ïï1 7
(
ïï7 8
v
ïï8 9
=>
ïï: <
v
ïï= >
.
ïï> ?
ValueString
ïï? J
)
ïïJ K
.
ïïK L
FirstOrDefault
ïïL Z
(
ïïZ [
)
ïï[ \
)
ïï\ ]
,
ïï] ^
}
ññ 	
;
ññ	 

}
óó 
public
ôô 

async
ôô 
Task
ôô 
<
ôô 
Entity
ôô 
?
ôô 
>
ôô %
GetByIdInWorkspaceAsync
ôô 6
(
ôô6 7
int
ôô7 :
entityId
ôô; C
,
ôôC D
int
ôôE H
workspaceId
ôôI T
,
ôôT U
CancellationToken
ôôV g
ct
ôôh j
=
ôôk l
default
ôôm t
)
ôôt u
{
öö 
var
õõ 
exists
õõ 
=
õõ 
await
õõ 
db
õõ 
.
õõ 
EntityWorkspaces
õõ .
.
úú 
AnyAsync
úú 
(
úú 
ew
úú 
=>
úú 
ew
úú 
.
úú 
EntityId
úú '
==
úú( *
entityId
úú+ 3
&&
úú4 6
ew
úú7 9
.
úú9 :
WorkspaceId
úú: E
==
úúF H
workspaceId
úúI T
,
úúT U
ct
úúV X
)
úúX Y
;
úúY Z
if
ûû 

(
ûû 
!
ûû 
exists
ûû 
)
ûû 
return
üü 
null
üü 
;
üü 
return
°° 
await
°° 
db
°° 
.
°° 
Entities
°°  
.
¢¢ 
AsNoTracking
¢¢ 
(
¢¢ 
)
¢¢ 
.
££ 
AsSplitQuery
££ 
(
££ 
)
££ 
.
§§ 
Where
§§ 
(
§§ 
e
§§ 
=>
§§ 
e
§§ 
.
§§ 
Id
§§ 
==
§§ 
entityId
§§  (
)
§§( )
.
•• 
Include
•• 
(
•• 
e
•• 
=>
•• 
e
•• 
.
•• 

EntityType
•• &
)
••& '
.
¶¶ 
Include
¶¶ 
(
¶¶ 
e
¶¶ 
=>
¶¶ 
e
¶¶ 
.
¶¶ "
EntityPropertyValues
¶¶ 0
)
¶¶0 1
.
ßß 
ThenInclude
ßß 
(
ßß 
epv
ßß  
=>
ßß! #
epv
ßß$ '
.
ßß' (
Property
ßß( 0
)
ßß0 1
.
®® 
Include
®® 
(
®® 
e
®® 
=>
®® 
e
®® 
.
®® !
SourceRelationships
®® /
)
®®/ 0
.
©© 
ThenInclude
©© 
(
©© 
r
©© 
=>
©© !
r
©©" #
.
©©# $
RelationshipType
©©$ 4
)
©©4 5
.
™™ 
Include
™™ 
(
™™ 
e
™™ 
=>
™™ 
e
™™ 
.
™™ !
SourceRelationships
™™ /
)
™™/ 0
.
´´ 
ThenInclude
´´ 
(
´´ 
r
´´ 
=>
´´ !
r
´´" #
.
´´# $
TargetEntity
´´$ 0
)
´´0 1
.
¨¨ 
ThenInclude
¨¨  
(
¨¨  !
t
¨¨! "
=>
¨¨# %
t
¨¨& '
.
¨¨' (

EntityType
¨¨( 2
)
¨¨2 3
.
≠≠ 
Include
≠≠ 
(
≠≠ 
e
≠≠ 
=>
≠≠ 
e
≠≠ 
.
≠≠ !
SourceRelationships
≠≠ /
)
≠≠/ 0
.
ÆÆ 
ThenInclude
ÆÆ 
(
ÆÆ 
r
ÆÆ 
=>
ÆÆ !
r
ÆÆ" #
.
ÆÆ# $
TargetEntity
ÆÆ$ 0
)
ÆÆ0 1
.
ØØ 
ThenInclude
ØØ  
(
ØØ  !
t
ØØ! "
=>
ØØ# %
t
ØØ& '
.
ØØ' ("
EntityPropertyValues
ØØ( <
)
ØØ< =
.
∞∞ 
ThenInclude
∞∞ $
(
∞∞$ %
epv
∞∞% (
=>
∞∞) +
epv
∞∞, /
.
∞∞/ 0
Property
∞∞0 8
)
∞∞8 9
.
±± 
Include
±± 
(
±± 
e
±± 
=>
±± 
e
±± 
.
±± !
TargetRelationships
±± /
)
±±/ 0
.
≤≤ 
ThenInclude
≤≤ 
(
≤≤ 
r
≤≤ 
=>
≤≤ !
r
≤≤" #
.
≤≤# $
RelationshipType
≤≤$ 4
)
≤≤4 5
.
≥≥ 
Include
≥≥ 
(
≥≥ 
e
≥≥ 
=>
≥≥ 
e
≥≥ 
.
≥≥ !
TargetRelationships
≥≥ /
)
≥≥/ 0
.
¥¥ 
ThenInclude
¥¥ 
(
¥¥ 
r
¥¥ 
=>
¥¥ !
r
¥¥" #
.
¥¥# $
SourceEntity
¥¥$ 0
)
¥¥0 1
.
µµ 
ThenInclude
µµ  
(
µµ  !
s
µµ! "
=>
µµ# %
s
µµ& '
.
µµ' (

EntityType
µµ( 2
)
µµ2 3
.
∂∂ 
Include
∂∂ 
(
∂∂ 
e
∂∂ 
=>
∂∂ 
e
∂∂ 
.
∂∂ !
TargetRelationships
∂∂ /
)
∂∂/ 0
.
∑∑ 
ThenInclude
∑∑ 
(
∑∑ 
r
∑∑ 
=>
∑∑ !
r
∑∑" #
.
∑∑# $
SourceEntity
∑∑$ 0
)
∑∑0 1
.
∏∏ 
ThenInclude
∏∏  
(
∏∏  !
s
∏∏! "
=>
∏∏# %
s
∏∏& '
.
∏∏' ("
EntityPropertyValues
∏∏( <
)
∏∏< =
.
ππ 
ThenInclude
ππ $
(
ππ$ %
epv
ππ% (
=>
ππ) +
epv
ππ, /
.
ππ/ 0
Property
ππ0 8
)
ππ8 9
.
∫∫ !
FirstOrDefaultAsync
∫∫  
(
∫∫  !
ct
∫∫! #
)
∫∫# $
;
∫∫$ %
}
ªª 
public
ΩΩ 

async
ΩΩ 
Task
ΩΩ 
<
ΩΩ 
Entity
ΩΩ 
>
ΩΩ 
CreateAsync
ΩΩ )
(
ΩΩ) *
Entity
ææ 
entity
ææ 
,
ææ 
List
øø 
<
øø !
EntityPropertyValue
øø  
>
øø  !
propertyValues
øø" 0
,
øø0 1
int
¿¿ 
workspaceId
¿¿ 
,
¿¿ 
IReadOnlyList
¡¡ 
<
¡¡  
EntityRelationship
¡¡ (
>
¡¡( )
?
¡¡) *
relationships
¡¡+ 8
,
¡¡8 9
CancellationToken
¬¬ 
ct
¬¬ 
=
¬¬ 
default
¬¬ &
)
¬¬& '
{
√√ 
await
ƒƒ 
using
ƒƒ 
var
ƒƒ 
tx
ƒƒ 
=
ƒƒ 
await
ƒƒ "
db
ƒƒ# %
.
ƒƒ% &
Database
ƒƒ& .
.
ƒƒ. /#
BeginTransactionAsync
ƒƒ/ D
(
ƒƒD E
ct
ƒƒE G
)
ƒƒG H
;
ƒƒH I
db
∆∆ 

.
∆∆
 
Entities
∆∆ 
.
∆∆ 
Add
∆∆ 
(
∆∆ 
entity
∆∆ 
)
∆∆ 
;
∆∆  
await
«« 
db
«« 
.
«« 
SaveChangesAsync
«« !
(
««! "
ct
««" $
)
««$ %
;
««% &
foreach
…… 
(
…… 
var
…… 
pv
…… 
in
…… 
propertyValues
…… )
)
……) *
{
   	
pv
ÀÀ 
.
ÀÀ 
EntityId
ÀÀ 
=
ÀÀ 
entity
ÀÀ  
.
ÀÀ  !
Id
ÀÀ! #
;
ÀÀ# $
}
ÃÃ 	
db
ŒŒ 

.
ŒŒ
 "
EntityPropertyValues
ŒŒ 
.
ŒŒ  
AddRange
ŒŒ  (
(
ŒŒ( )
propertyValues
ŒŒ) 7
)
ŒŒ7 8
;
ŒŒ8 9
db
–– 

.
––
 
EntityWorkspaces
–– 
.
–– 
Add
–– 
(
––  
new
––  #
EntityWorkspace
––$ 3
{
––4 5
EntityId
––6 >
=
––? @
entity
––A G
.
––G H
Id
––H J
,
––J K
WorkspaceId
––L W
=
––X Y
workspaceId
––Z e
}
––f g
)
––g h
;
––h i
if
““ 

(
““ 
relationships
““ 
is
““ 
{
““ 
Count
““ $
:
““$ %
>
““& '
$num
““( )
}
““* +
)
““+ ,
{
”” 	
foreach
‘‘ 
(
‘‘ 
var
‘‘ 
rel
‘‘ 
in
‘‘ 
relationships
‘‘  -
)
‘‘- .
{
’’ 
rel
÷÷ 
.
÷÷ 
SourceEntityId
÷÷ "
=
÷÷# $
entity
÷÷% +
.
÷÷+ ,
Id
÷÷, .
;
÷÷. /
}
◊◊ 
db
ŸŸ 
.
ŸŸ !
EntityRelationships
ŸŸ "
.
ŸŸ" #
AddRange
ŸŸ# +
(
ŸŸ+ ,
relationships
ŸŸ, 9
)
ŸŸ9 :
;
ŸŸ: ;
}
⁄⁄ 	
await
‹‹ 
db
‹‹ 
.
‹‹ 
SaveChangesAsync
‹‹ !
(
‹‹! "
ct
‹‹" $
)
‹‹$ %
;
‹‹% &
await
›› 
tx
›› 
.
›› 
CommitAsync
›› 
(
›› 
ct
›› 
)
››  
;
››  !
return
ﬂﬂ 
entity
ﬂﬂ 
;
ﬂﬂ 
}
‡‡ 
public
‚‚ 

async
‚‚ 
Task
‚‚ 
UpdateAsync
‚‚ !
(
‚‚! "
Entity
‚‚" (
entity
‚‚) /
,
‚‚/ 0
List
‚‚1 5
<
‚‚5 6!
EntityPropertyValue
‚‚6 I
>
‚‚I J
newPropertyValues
‚‚K \
,
‚‚\ ]
CancellationToken
‚‚^ o
ct
‚‚p r
=
‚‚s t
default
‚‚u |
)
‚‚| }
{
„„ 
await
‰‰ 
using
‰‰ 
var
‰‰ 
tx
‰‰ 
=
‰‰ 
await
‰‰ "
db
‰‰# %
.
‰‰% &
Database
‰‰& .
.
‰‰. /#
BeginTransactionAsync
‰‰/ D
(
‰‰D E
ct
‰‰E G
)
‰‰G H
;
‰‰H I
var
ÊÊ 
existing
ÊÊ 
=
ÊÊ 
await
ÊÊ 
db
ÊÊ 
.
ÊÊ  "
EntityPropertyValues
ÊÊ  4
.
ÁÁ 
Where
ÁÁ 
(
ÁÁ 
epv
ÁÁ 
=>
ÁÁ 
epv
ÁÁ 
.
ÁÁ 
EntityId
ÁÁ &
==
ÁÁ' )
entity
ÁÁ* 0
.
ÁÁ0 1
Id
ÁÁ1 3
)
ÁÁ3 4
.
ËË 
ToListAsync
ËË 
(
ËË 
ct
ËË 
)
ËË 
;
ËË 
db
ÈÈ 

.
ÈÈ
 "
EntityPropertyValues
ÈÈ 
.
ÈÈ  
RemoveRange
ÈÈ  +
(
ÈÈ+ ,
existing
ÈÈ, 4
)
ÈÈ4 5
;
ÈÈ5 6
await
ÍÍ 
db
ÍÍ 
.
ÍÍ 
SaveChangesAsync
ÍÍ !
(
ÍÍ! "
ct
ÍÍ" $
)
ÍÍ$ %
;
ÍÍ% &
foreach
ÏÏ 
(
ÏÏ 
var
ÏÏ 
pv
ÏÏ 
in
ÏÏ 
newPropertyValues
ÏÏ ,
)
ÏÏ, -
{
ÌÌ 	
pv
ÓÓ 
.
ÓÓ 
EntityId
ÓÓ 
=
ÓÓ 
entity
ÓÓ  
.
ÓÓ  !
Id
ÓÓ! #
;
ÓÓ# $
}
ÔÔ 	
db
ÒÒ 

.
ÒÒ
 "
EntityPropertyValues
ÒÒ 
.
ÒÒ  
AddRange
ÒÒ  (
(
ÒÒ( )
newPropertyValues
ÒÒ) :
)
ÒÒ: ;
;
ÒÒ; <
await
ÛÛ 
db
ÛÛ 
.
ÛÛ 
SaveChangesAsync
ÛÛ !
(
ÛÛ! "
ct
ÛÛ" $
)
ÛÛ$ %
;
ÛÛ% &
await
ÙÙ 
tx
ÙÙ 
.
ÙÙ 
CommitAsync
ÙÙ 
(
ÙÙ 
ct
ÙÙ 
)
ÙÙ  
;
ÙÙ  !
}
ıı 
public
˜˜ 

async
˜˜ 
Task
˜˜ #
SetArchivedStateAsync
˜˜ +
(
˜˜+ ,
int
˜˜, /
entityId
˜˜0 8
,
˜˜8 9
bool
˜˜: >

isArchived
˜˜? I
,
˜˜I J
CancellationToken
˜˜K \
ct
˜˜] _
=
˜˜` a
default
˜˜b i
)
˜˜i j
{
¯¯ 
await
˘˘ 
db
˘˘ 
.
˘˘ 
Entities
˘˘ 
.
˙˙ 
Where
˙˙ 
(
˙˙ 
e
˙˙ 
=>
˙˙ 
e
˙˙ 
.
˙˙ 
Id
˙˙ 
==
˙˙ 
entityId
˙˙  (
)
˙˙( )
.
˚˚  
ExecuteUpdateAsync
˚˚ 
(
˚˚  
s
˚˚  !
=>
˚˚" $
s
˚˚% &
.
˚˚& '
SetProperty
˚˚' 2
(
˚˚2 3
e
˚˚3 4
=>
˚˚5 7
e
˚˚8 9
.
˚˚9 :

IsArchived
˚˚: D
,
˚˚D E

isArchived
˚˚F P
)
˚˚P Q
,
˚˚Q R
ct
˚˚S U
)
˚˚U V
;
˚˚V W
}
¸¸ 
public
˛˛ 

Task
˛˛ 
ArchiveAsync
˛˛ 
(
˛˛ 
int
˛˛  
entityId
˛˛! )
,
˛˛) *
CancellationToken
˛˛+ <
ct
˛˛= ?
=
˛˛@ A
default
˛˛B I
)
˛˛I J
=>
˛˛K M#
SetArchivedStateAsync
ˇˇ 
(
ˇˇ 
entityId
ˇˇ &
,
ˇˇ& '
true
ˇˇ( ,
,
ˇˇ, -
ct
ˇˇ. 0
)
ˇˇ0 1
;
ˇˇ1 2
public
ÅÅ 

Task
ÅÅ 
<
ÅÅ $
EntityRelationshipType
ÅÅ &
?
ÅÅ& '
>
ÅÅ' (*
GetRelationshipTypeByIdAsync
ÅÅ) E
(
ÅÅE F
int
ÅÅF I 
relationshipTypeId
ÅÅJ \
,
ÅÅ\ ]
CancellationToken
ÅÅ^ o
ct
ÅÅp r
=
ÅÅs t
default
ÅÅu |
)
ÅÅ| }
=>ÅÅ~ Ä
db
ÇÇ 

.
ÇÇ
 %
EntityRelationshipTypes
ÇÇ "
.
ÉÉ 
AsNoTracking
ÉÉ 
(
ÉÉ 
)
ÉÉ 
.
ÑÑ 
Include
ÑÑ 
(
ÑÑ 
rt
ÑÑ 
=>
ÑÑ 
rt
ÑÑ 
.
ÑÑ 
SourceEntityType
ÑÑ .
)
ÑÑ. /
.
ÖÖ 
Include
ÖÖ 
(
ÖÖ 
rt
ÖÖ 
=>
ÖÖ 
rt
ÖÖ 
.
ÖÖ 
TargetEntityType
ÖÖ .
)
ÖÖ. /
.
ÜÜ !
FirstOrDefaultAsync
ÜÜ  
(
ÜÜ  !
rt
ÜÜ! #
=>
ÜÜ$ &
rt
ÜÜ' )
.
ÜÜ) *
Id
ÜÜ* ,
==
ÜÜ- / 
relationshipTypeId
ÜÜ0 B
,
ÜÜB C
ct
ÜÜD F
)
ÜÜF G
;
ÜÜG H
public
àà 

Task
àà 
<
àà  
EntityRelationship
àà "
?
àà" #
>
àà# $&
GetRelationshipByIdAsync
àà% =
(
àà= >
int
àà> A
relationshipId
ààB P
,
ààP Q
CancellationToken
ààR c
ct
ààd f
=
ààg h
default
àài p
)
ààp q
=>
ààr t
db
ââ 

.
ââ
 !
EntityRelationships
ââ 
.
ää 
AsNoTracking
ää 
(
ää 
)
ää 
.
ãã 
Include
ãã 
(
ãã 
r
ãã 
=>
ãã 
r
ãã 
.
ãã 
RelationshipType
ãã ,
)
ãã, -
.
åå 
ThenInclude
åå 
(
åå 
rt
åå 
=>
åå  "
rt
åå# %
.
åå% &
SourceEntityType
åå& 6
)
åå6 7
.
çç 
Include
çç 
(
çç 
r
çç 
=>
çç 
r
çç 
.
çç 
RelationshipType
çç ,
)
çç, -
.
éé 
ThenInclude
éé 
(
éé 
rt
éé 
=>
éé  "
rt
éé# %
.
éé% &
TargetEntityType
éé& 6
)
éé6 7
.
èè 
Include
èè 
(
èè 
r
èè 
=>
èè 
r
èè 
.
èè 
SourceEntity
èè (
)
èè( )
.
êê 
ThenInclude
êê 
(
êê 
e
êê 
=>
êê !
e
êê" #
.
êê# $
EntityWorkspaces
êê$ 4
)
êê4 5
.
ëë 
Include
ëë 
(
ëë 
r
ëë 
=>
ëë 
r
ëë 
.
ëë 
TargetEntity
ëë (
)
ëë( )
.
íí 
ThenInclude
íí 
(
íí 
e
íí 
=>
íí !
e
íí" #
.
íí# $
EntityWorkspaces
íí$ 4
)
íí4 5
.
ìì !
FirstOrDefaultAsync
ìì  
(
ìì  !
r
ìì! "
=>
ìì# %
r
ìì& '
.
ìì' (
Id
ìì( *
==
ìì+ -
relationshipId
ìì. <
,
ìì< =
ct
ìì> @
)
ìì@ A
;
ììA B
public
ïï 

async
ïï 
Task
ïï 
<
ïï  
EntityRelationship
ïï (
>
ïï( )"
AddRelationshipAsync
ïï* >
(
ïï> ? 
EntityRelationship
ïï? Q
relationship
ïïR ^
,
ïï^ _
CancellationToken
ïï` q
ct
ïïr t
=
ïïu v
default
ïïw ~
)
ïï~ 
{
ññ 
db
óó 

.
óó
 !
EntityRelationships
óó 
.
óó 
Add
óó "
(
óó" #
relationship
óó# /
)
óó/ 0
;
óó0 1
await
òò 
db
òò 
.
òò 
SaveChangesAsync
òò !
(
òò! "
ct
òò" $
)
òò$ %
;
òò% &
return
ôô 
relationship
ôô 
;
ôô 
}
öö 
public
úú 

async
úú 
Task
úú %
RemoveRelationshipAsync
úú -
(
úú- .
int
úú. 1
relationshipId
úú2 @
,
úú@ A
CancellationToken
úúB S
ct
úúT V
=
úúW X
default
úúY `
)
úú` a
{
ùù 
await
ûû 
db
ûû 
.
ûû !
EntityRelationships
ûû $
.
üü 
Where
üü 
(
üü 
r
üü 
=>
üü 
r
üü 
.
üü 
Id
üü 
==
üü 
relationshipId
üü  .
)
üü. /
.
††  
ExecuteDeleteAsync
†† 
(
††  
ct
††  "
)
††" #
;
††# $
}
°° 
public
££ 

async
££ 
Task
££ 
<
££ 
T
££ 
>
££ '
ExecuteInTransactionAsync
££ 2
<
££2 3
T
££3 4
>
££4 5
(
££5 6
Func
££6 :
<
££: ;
Task
££; ?
<
££? @
T
££@ A
>
££A B
>
££B C
action
££D J
,
££J K
CancellationToken
££L ]
ct
££^ `
=
££a b
default
££c j
)
££j k
{
§§ 
await
•• 
using
•• 
var
•• 
tx
•• 
=
•• 
await
•• "
db
••# %
.
••% &
Database
••& .
.
••. /#
BeginTransactionAsync
••/ D
(
••D E
ct
••E G
)
••G H
;
••H I
var
¶¶ 
result
¶¶ 
=
¶¶ 
await
¶¶ 
action
¶¶ !
(
¶¶! "
)
¶¶" #
;
¶¶# $
await
ßß 
tx
ßß 
.
ßß 
CommitAsync
ßß 
(
ßß 
ct
ßß 
)
ßß  
;
ßß  !
return
®® 
result
®® 
;
®® 
}
©© 
public
´´ 

Task
´´ +
UpdateRelationshipSourceAsync
´´ -
(
´´- .
int
´´. 1
relationshipId
´´2 @
,
´´@ A
int
´´B E
newSourceEntityId
´´F W
,
´´W X
CancellationToken
´´Y j
ct
´´k m
=
´´n o
default
´´p w
)
´´w x
=>
¨¨ 

db
¨¨ 
.
¨¨ !
EntityRelationships
¨¨ !
.
≠≠ 
Where
≠≠ 
(
≠≠ 
r
≠≠ 
=>
≠≠ 
r
≠≠ 
.
≠≠ 
Id
≠≠ 
==
≠≠ 
relationshipId
≠≠  .
)
≠≠. /
.
ÆÆ  
ExecuteUpdateAsync
ÆÆ 
(
ÆÆ  
s
ÆÆ  !
=>
ÆÆ" $
s
ÆÆ% &
.
ÆÆ& '
SetProperty
ÆÆ' 2
(
ÆÆ2 3
r
ÆÆ3 4
=>
ÆÆ5 7
r
ÆÆ8 9
.
ÆÆ9 :
SourceEntityId
ÆÆ: H
,
ÆÆH I
newSourceEntityId
ÆÆJ [
)
ÆÆ[ \
,
ÆÆ\ ]
ct
ÆÆ^ `
)
ÆÆ` a
;
ÆÆa b
public
∞∞ 

Task
∞∞ +
UpdateRelationshipTargetAsync
∞∞ -
(
∞∞- .
int
∞∞. 1
relationshipId
∞∞2 @
,
∞∞@ A
int
∞∞B E
newTargetEntityId
∞∞F W
,
∞∞W X
CancellationToken
∞∞Y j
ct
∞∞k m
=
∞∞n o
default
∞∞p w
)
∞∞w x
=>
±± 

db
±± 
.
±± !
EntityRelationships
±± !
.
≤≤ 
Where
≤≤ 
(
≤≤ 
r
≤≤ 
=>
≤≤ 
r
≤≤ 
.
≤≤ 
Id
≤≤ 
==
≤≤ 
relationshipId
≤≤  .
)
≤≤. /
.
≥≥  
ExecuteUpdateAsync
≥≥ 
(
≥≥  
s
≥≥  !
=>
≥≥" $
s
≥≥% &
.
≥≥& '
SetProperty
≥≥' 2
(
≥≥2 3
r
≥≥3 4
=>
≥≥5 7
r
≥≥8 9
.
≥≥9 :
TargetEntityId
≥≥: H
,
≥≥H I
newTargetEntityId
≥≥J [
)
≥≥[ \
,
≥≥\ ]
ct
≥≥^ `
)
≥≥` a
;
≥≥a b
public
µµ 

Task
µµ 
<
µµ 
int
µµ 
>
µµ -
CountRelationshipsBySourceAsync
µµ 4
(
µµ4 5
int
µµ5 8
sourceEntityId
µµ9 G
,
µµG H
int
µµI L 
relationshipTypeId
µµM _
,
µµ_ `
CancellationToken
µµa r
ct
µµs u
=
µµv w
default
µµx 
)µµ Ä
=>µµÅ É
db
∂∂ 

.
∂∂
 !
EntityRelationships
∂∂ 
.
∑∑ 

CountAsync
∑∑ 
(
∑∑ 
r
∑∑ 
=>
∑∑ 
r
∑∑ 
.
∑∑ 
SourceEntityId
∑∑ -
==
∑∑. 0
sourceEntityId
∑∑1 ?
&&
∑∑@ B
r
∑∑C D
.
∑∑D E 
RelationshipTypeId
∑∑E W
==
∑∑X Z 
relationshipTypeId
∑∑[ m
,
∑∑m n
ct
∑∑o q
)
∑∑q r
;
∑∑r s
public
ππ 

Task
ππ 
<
ππ 
int
ππ 
>
ππ -
CountRelationshipsByTargetAsync
ππ 4
(
ππ4 5
int
ππ5 8
targetEntityId
ππ9 G
,
ππG H
int
ππI L 
relationshipTypeId
ππM _
,
ππ_ `
CancellationToken
ππa r
ct
ππs u
=
ππv w
default
ππx 
)ππ Ä
=>ππÅ É
db
∫∫ 

.
∫∫
 !
EntityRelationships
∫∫ 
.
ªª 

CountAsync
ªª 
(
ªª 
r
ªª 
=>
ªª 
r
ªª 
.
ªª 
TargetEntityId
ªª -
==
ªª. 0
targetEntityId
ªª1 ?
&&
ªª@ B
r
ªªC D
.
ªªD E 
RelationshipTypeId
ªªE W
==
ªªX Z 
relationshipTypeId
ªª[ m
,
ªªm n
ct
ªªo q
)
ªªq r
;
ªªr s
}ºº «{
ÇC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Messaging\EntityGraphCommandConsumerHostedService.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
	Messaging' 0
;0 1
public 
sealed 
class $
EntityGraphRabbitOptions ,
{ 
public 

const 
string 

SectionKey "
=# $
$str% 4
;4 5
public 

string 
Host 
{ 
get 
; 
set !
;! "
}# $
=% &
$str' 2
;2 3
public 

int 
Port 
{ 
get 
; 
set 
; 
}  !
=" #
$num$ (
;( )
public 

string 
Username 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ 2
;2 3
public 

string 
Password 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ 2
;2 3
} 
public 
sealed 
class 3
'EntityGraphCommandConsumerHostedService ;
(; <
ILogger 
< 3
'EntityGraphCommandConsumerHostedService 3
>3 4
logger5 ;
,; <
IOptions 
< $
EntityGraphRabbitOptions %
>% &
optionsAccessor' 6
,6 7 
IServiceScopeFactory 
scopeFactory %
)% &
:' (
BackgroundService) :
{ 
private 
static 
readonly !
JsonSerializerOptions 1
Json2 6
=7 8
new9 <
(< =
)= >
{  
PropertyNamingPolicy   
=   
JsonNamingPolicy   /
.  / 0
	CamelCase  0 9
,  9 :'
PropertyNameCaseInsensitive!! #
=!!$ %
true!!& *
,!!* +
}"" 
;"" 
private$$ 
readonly$$ $
EntityGraphRabbitOptions$$ -
_opts$$. 3
=$$4 5
optionsAccessor$$6 E
.$$E F
Value$$F K
;$$K L
	protected&& 
override&& 
async&& 
Task&& !
ExecuteAsync&&" .
(&&. /
CancellationToken&&/ @
stoppingToken&&A N
)&&N O
{'' 
var(( 
factory(( 
=(( 
new(( 
ConnectionFactory(( +
{)) 	
HostName** 
=** 
_opts** 
.** 
Host** !
,**! "
Port++ 
=++ 
_opts++ 
.++ 
Port++ 
,++ 
UserName,, 
=,, 
_opts,, 
.,, 
Username,, %
,,,% &
Password-- 
=-- 
_opts-- 
.-- 
Password-- %
,--% &
}.. 	
;..	 

while00 
(00 
!00 
stoppingToken00 
.00 #
IsCancellationRequested00 5
)005 6
{11 	
try22 
{33 
await44 
using44 
var44 

connection44  *
=44+ ,
await44- 2
factory443 :
.44: ;!
CreateConnectionAsync44; P
(44P Q
stoppingToken44Q ^
)44^ _
;44_ `
await55 
using55 
var55 
channel55  '
=55( )
await55* /

connection550 :
.55: ;
CreateChannelAsync55; M
(55M N
cancellationToken55N _
:55_ `
stoppingToken55a n
)55n o
;55o p
await77 
channel77 
.77  
ExchangeDeclareAsync77 2
(772 3
exchange88 
:88 
EntityGraphRouting88 0
.880 1
ExchangeName881 =
,88= >
type99 
:99 
ExchangeType99 &
.99& '
Topic99' ,
,99, -
durable:: 
::: 
true:: !
,::! "

autoDelete;; 
:;; 
false;;  %
,;;% &
cancellationToken<< %
:<<% &
stoppingToken<<' 4
)<<4 5
;<<5 6
await>> 
channel>> 
.>> 
QueueDeclareAsync>> /
(>>/ 0
queue?? 
:?? 
EntityGraphRouting?? -
.??- .
CommandQueueName??. >
,??> ?
durable@@ 
:@@ 
true@@ !
,@@! "
	exclusiveAA 
:AA 
falseAA $
,AA$ %

autoDeleteBB 
:BB 
falseBB  %
,BB% &
cancellationTokenCC %
:CC% &
stoppingTokenCC' 4
)CC4 5
;CC5 6
awaitEE 
channelEE 
.EE 
QueueBindAsyncEE ,
(EE, -
queueFF 
:FF 
EntityGraphRoutingFF -
.FF- .
CommandQueueNameFF. >
,FF> ?
exchangeGG 
:GG 
EntityGraphRoutingGG 0
.GG0 1
ExchangeNameGG1 =
,GG= >

routingKeyHH 
:HH 
EntityGraphRoutingHH  2
.HH2 3
CommandRoutingKeyHH3 D
,HHD E
cancellationTokenII %
:II% &
stoppingTokenII' 4
)II4 5
;II5 6
awaitKK 
channelKK 
.KK 
BasicQosAsyncKK +
(KK+ ,
$numKK, -
,KK- .
$numKK/ 0
,KK0 1
falseKK2 7
,KK7 8
stoppingTokenKK9 F
)KKF G
;KKG H
varMM 
consumerMM 
=MM 
newMM "&
AsyncEventingBasicConsumerMM# =
(MM= >
channelMM> E
)MME F
;MMF G
consumerNN 
.NN 
ReceivedAsyncNN &
+=NN' )
asyncNN* /
(NN0 1
_NN1 2
,NN2 3
eaNN4 6
)NN6 7
=>NN8 :
{OO 
awaitPP 
HandleAsyncPP %
(PP% &
channelPP& -
,PP- .
eaPP/ 1
,PP1 2
stoppingTokenPP3 @
)PP@ A
;PPA B
}QQ 
;QQ 
awaitSS 
channelSS 
.SS 
BasicConsumeAsyncSS /
(SS/ 0
EntityGraphRoutingTT &
.TT& '
CommandQueueNameTT' 7
,TT7 8
autoAckUU 
:UU 
falseUU "
,UU" #
consumerVV 
:VV 
consumerVV &
,VV& '
cancellationTokenWW %
:WW% &
stoppingTokenWW' 4
)WW4 5
;WW5 6
tryYY 
{ZZ 
await[[ 
Task[[ 
.[[ 
Delay[[ $
([[$ %
Timeout[[% ,
.[[, -
Infinite[[- 5
,[[5 6
stoppingToken[[7 D
)[[D E
;[[E F
}\\ 
catch]] 
(]] !
TaskCanceledException]] ,
)]], -
{^^ 
}`` 
}aa 
catchbb 
(bb 
	Exceptionbb 
exbb 
)bb  
whenbb! %
(bb& '
!bb' (
stoppingTokenbb( 5
.bb5 6#
IsCancellationRequestedbb6 M
)bbM N
{cc 
loggerdd 
.dd 
LogErrordd 
(dd  
exdd  "
,dd" #
$strdd$ ^
)dd^ _
;dd_ `
awaitee 
Taskee 
.ee 
Delayee  
(ee  !
TimeSpanee! )
.ee) *
FromSecondsee* 5
(ee5 6
$numee6 7
)ee7 8
,ee8 9
stoppingTokenee: G
)eeG H
;eeH I
}ff 
}gg 	
}hh 
privatejj 
asyncjj 
Taskjj 
HandleAsyncjj "
(jj" #
IChanneljj# +
channeljj, 3
,jj3 4!
BasicDeliverEventArgsjj5 J
eajjK M
,jjM N
CancellationTokenjjO `
ctjja c
)jjc d
{kk 
varll 
propsll 
=ll 
eall 
.ll 
BasicPropertiesll &
;ll& '
varmm 

replyPropsmm 
=mm 
newmm 
BasicPropertiesmm ,
{nn 	
CorrelationIdoo 
=oo 
propsoo !
.oo! "
CorrelationIdoo" /
,oo/ 0
}pp 	
;pp	 

asyncrr 
Taskrr 

ReplyAsyncrr 
(rr '
EntityGraphCreateRpcReplyV1rr 9
payloadrr: A
)rrA B
{ss 	
iftt 
(tt 
stringtt 
.tt 
IsNullOrEmptytt $
(tt$ %
propstt% *
.tt* +
ReplyTott+ 2
)tt2 3
)tt3 4
returnuu 
;uu 
varww 
bytesww 
=ww 
Encodingww  
.ww  !
UTF8ww! %
.ww% &
GetBytesww& .
(ww. /
JsonSerializerww/ =
.ww= >
	Serializeww> G
(wwG H
payloadwwH O
,wwO P
JsonwwQ U
)wwU V
)wwV W
;wwW X
awaitxx 
channelxx 
.xx 
BasicPublishAsyncxx +
(xx+ ,
exchangeyy 
:yy 
stringyy  
.yy  !
Emptyyy! &
,yy& '

routingKeyzz 
:zz 
propszz !
.zz! "
ReplyTozz" )
,zz) *
	mandatory{{ 
:{{ 
false{{  
,{{  !
basicProperties|| 
:||  

replyProps||! +
,||+ ,
body}} 
:}} 
bytes}} 
,}} 
cancellationToken~~ !
:~~! "
ct~~# %
)~~% &
;~~& '
} 	
try
ÅÅ 
{
ÇÇ 	
var
ÉÉ 
json
ÉÉ 
=
ÉÉ 
Encoding
ÉÉ 
.
ÉÉ  
UTF8
ÉÉ  $
.
ÉÉ$ %
	GetString
ÉÉ% .
(
ÉÉ. /
ea
ÉÉ/ 1
.
ÉÉ1 2
Body
ÉÉ2 6
.
ÉÉ6 7
ToArray
ÉÉ7 >
(
ÉÉ> ?
)
ÉÉ? @
)
ÉÉ@ A
;
ÉÉA B
var
ÑÑ 
cmd
ÑÑ 
=
ÑÑ 
JsonSerializer
ÑÑ $
.
ÑÑ$ %
Deserialize
ÑÑ% 0
<
ÑÑ0 1$
EntityGraphCreateRpcV1
ÑÑ1 G
>
ÑÑG H
(
ÑÑH I
json
ÑÑI M
,
ÑÑM N
Json
ÑÑO S
)
ÑÑS T
;
ÑÑT U
if
ÖÖ 
(
ÖÖ 
cmd
ÖÖ 
is
ÖÖ 
null
ÖÖ 
)
ÖÖ 
{
ÜÜ 
await
áá 

ReplyAsync
áá  
(
áá  !
new
áá! $)
EntityGraphCreateRpcReplyV1
áá% @
(
áá@ A
false
ááA F
,
ááF G
$str
ááH Z
,
ááZ [
null
áá\ `
)
áá` a
)
ááa b
;
ááb c
await
àà 
channel
àà 
.
àà 
BasicAckAsync
àà +
(
àà+ ,
ea
àà, .
.
àà. /
DeliveryTag
àà/ :
,
àà: ;
false
àà< A
,
ààA B
ct
ààC E
)
ààE F
;
ààF G
return
ââ 
;
ââ 
}
ää 
var
åå 
request
åå 
=
åå 
JsonSerializer
åå (
.
åå( )
Deserialize
åå) 4
<
åå4 5!
CreateEntityRequest
åå5 H
>
ååH I
(
ååI J
cmd
ååJ M
.
ååM N
CreateEntityJson
ååN ^
,
åå^ _
Json
åå` d
)
ååd e
;
ååe f
if
çç 
(
çç 
request
çç 
is
çç 
null
çç 
)
çç  
{
éé 
await
èè 

ReplyAsync
èè  
(
èè  !
new
èè! $)
EntityGraphCreateRpcReplyV1
èè% @
(
èè@ A
false
èèA F
,
èèF G
$str
èèH c
,
èèc d
null
èèe i
)
èèi j
)
èèj k
;
èèk l
await
êê 
channel
êê 
.
êê 
BasicAckAsync
êê +
(
êê+ ,
ea
êê, .
.
êê. /
DeliveryTag
êê/ :
,
êê: ;
false
êê< A
,
êêA B
ct
êêC E
)
êêE F
;
êêF G
return
ëë 
;
ëë 
}
íí 
using
îî 
var
îî 
scope
îî 
=
îî 
scopeFactory
îî *
.
îî* +
CreateScope
îî+ 6
(
îî6 7
)
îî7 8
;
îî8 9
var
ïï 
entityService
ïï 
=
ïï 
scope
ïï  %
.
ïï% &
ServiceProvider
ïï& 5
.
ïï5 6 
GetRequiredService
ïï6 H
<
ïïH I
IEntityService
ïïI W
>
ïïW X
(
ïïX Y
)
ïïY Z
;
ïïZ [
var
óó 
detail
óó 
=
óó 
await
óó 
entityService
óó ,
.
óó, -
CreateAsync
óó- 8
(
óó8 9
cmd
óó9 <
.
óó< =
WorkspaceId
óó= H
,
óóH I
cmd
óóJ M
.
óóM N
UserId
óóN T
,
óóT U
request
óóV ]
,
óó] ^
ct
óó_ a
)
óóa b
;
óób c
var
òò 

detailJson
òò 
=
òò 
JsonSerializer
òò +
.
òò+ ,
	Serialize
òò, 5
(
òò5 6
detail
òò6 <
,
òò< =
Json
òò> B
)
òòB C
;
òòC D
await
ôô 

ReplyAsync
ôô 
(
ôô 
new
ôô  )
EntityGraphCreateRpcReplyV1
ôô! <
(
ôô< =
true
ôô= A
,
ôôA B
null
ôôC G
,
ôôG H

detailJson
ôôI S
)
ôôS T
)
ôôT U
;
ôôU V
await
öö 
channel
öö 
.
öö 
BasicAckAsync
öö '
(
öö' (
ea
öö( *
.
öö* +
DeliveryTag
öö+ 6
,
öö6 7
false
öö8 =
,
öö= >
ct
öö? A
)
ööA B
;
ööB C
}
õõ 	
catch
úú 
(
úú 
	Exception
úú 
ex
úú 
)
úú 
{
ùù 	
logger
ûû 
.
ûû 

LogWarning
ûû 
(
ûû 
ex
ûû  
,
ûû  !
$str
ûû" >
)
ûû> ?
;
ûû? @
try
üü 
{
†† 
await
°° 

ReplyAsync
°°  
(
°°  !
new
°°! $)
EntityGraphCreateRpcReplyV1
°°% @
(
°°@ A
false
°°A F
,
°°F G
ex
°°H J
.
°°J K
Message
°°K R
,
°°R S
null
°°T X
)
°°X Y
)
°°Y Z
;
°°Z [
}
¢¢ 
catch
££ 
(
££ 
	Exception
££ 
replyEx
££ $
)
££$ %
{
§§ 
logger
•• 
.
•• 

LogWarning
•• !
(
••! "
replyEx
••" )
,
••) *
$str
••+ U
)
••U V
;
••V W
}
¶¶ 
await
®® 
channel
®® 
.
®® 
BasicAckAsync
®® '
(
®®' (
ea
®®( *
.
®®* +
DeliveryTag
®®+ 6
,
®®6 7
false
®®8 =
,
®®= >
ct
®®? A
)
®®A B
;
®®B C
}
©© 	
}
™™ 
}´´ Ø0
sC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Repositories\JoinRequestRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Repositories' 3
;3 4
public 
sealed 
class !
JoinRequestRepository )
() *
RelativaDbContext* ;
db< >
)> ?
:@ A"
IJoinRequestRepositoryB X
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
 #
OrganizationJoinRequest

 -
?

- .
>

. /
GetByIdAsync

0 <
(

< =
int

= @
id

A C
,

C D
CancellationToken

E V
ct

W Y
=

Z [
default

\ c
)

c d
{ 
return 
await 
db 
. $
OrganizationJoinRequests 0
. 
Include 
( 
r 
=> 
r 
. 
User  
)  !
. 
Include 
( 
r 
=> 
r 
. 
Organization (
)( )
. 
FirstOrDefaultAsync  
(  !
r! "
=># %
r& '
.' (
Id( *
==+ -
id. 0
,0 1
ct2 4
)4 5
;5 6
} 
public 

async 
Task 
< 
List 
< #
OrganizationJoinRequest 2
>2 3
>3 4$
GetByOrganizationIdAsync5 M
(M N
intN Q
organizationIdR `
,` a
CancellationTokenb s
ctt v
=w x
default	y Ä
)
Ä Å
{ 
return 
await 
db 
. $
OrganizationJoinRequests 0
. 
Include 
( 
r 
=> 
r 
. 
User  
)  !
. 
Include 
( 
r 
=> 
r 
. 
Organization (
)( )
. 
Where 
( 
r 
=> 
r 
. 
OrganizationId (
==) +
organizationId, :
&&; =
r> ?
.? @
Status@ F
==G I
$strJ S
)S T
. 
ToListAsync 
( 
ct 
) 
; 
} 
public 

async 
Task 
< 
List 
< #
OrganizationJoinRequest 2
>2 3
>3 4
GetByUserIdAsync5 E
(E F
intF I
userIdJ P
,P Q
CancellationTokenR c
ctd f
=g h
defaulti p
)p q
{ 
return 
await 
db 
. $
OrganizationJoinRequests 0
. 
Include 
( 
r 
=> 
r 
. 
Organization (
)( )
. 
Include 
( 
r 
=> 
r 
. 
User  
)  !
.   
Include   
(   
r   
=>   
r   
.   

ReviewedBy   &
)  & '
.!! 
Where!! 
(!! 
r!! 
=>!! 
r!! 
.!! 
UserId!!  
==!!! #
userId!!$ *
)!!* +
."" 
ToListAsync"" 
("" 
ct"" 
)"" 
;"" 
}## 
public%% 

async%% 
Task%% 
<%% #
OrganizationJoinRequest%% -
?%%- .
>%%. /
GetPendingAsync%%0 ?
(%%? @
int%%@ C
userId%%D J
,%%J K
int%%L O
organizationId%%P ^
,%%^ _
CancellationToken%%` q
ct%%r t
=%%u v
default%%w ~
)%%~ 
{&& 
return'' 
await'' 
db'' 
.'' $
OrganizationJoinRequests'' 0
.(( 
FirstOrDefaultAsync((  
(((  !
r((! "
=>((# %
r((& '
.((' (
UserId((( .
==((/ 1
userId((2 8
&&((9 ;
r((< =
.((= >
OrganizationId((> L
==((M O
organizationId((P ^
&&((_ a
r((b c
.((c d
Status((d j
==((k m
$str((n w
,((w x
ct((y {
)(({ |
;((| }
})) 
public++ 

async++ 
Task++ 
AddAsync++ 
(++ #
OrganizationJoinRequest++ 6
request++7 >
,++> ?
CancellationToken++@ Q
ct++R T
=++U V
default++W ^
)++^ _
{,, 
db-- 

.--
 $
OrganizationJoinRequests-- #
.--# $
Add--$ '
(--' (
request--( /
)--/ 0
;--0 1
await.. 
db.. 
... 
SaveChangesAsync.. !
(..! "
ct.." $
)..$ %
;..% &
}// 
public11 

async11 
Task11 
UpdateAsync11 !
(11! "#
OrganizationJoinRequest11" 9
request11: A
,11A B
CancellationToken11C T
ct11U W
=11X Y
default11Z a
)11a b
{22 
db33 

.33
 $
OrganizationJoinRequests33 #
.33# $
Update33$ *
(33* +
request33+ 2
)332 3
;333 4
await44 
db44 
.44 
SaveChangesAsync44 !
(44! "
ct44" $
)44$ %
;44% &
}55 
}66 £E
gC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Infrastructure\Data\RelativaDbContext.cs
	namespace 	
Relativa
 
. 
Core 
. 
Infrastructure &
.& '
Data' +
;+ ,
public		 
sealed		 
class		 
RelativaDbContext		 %
(		% &
DbContextOptions		& 6
<		6 7
RelativaDbContext		7 H
>		H I
options		J Q
)		Q R
:		S T
	DbContext		U ^
(		^ _
options		_ f
)		f g
{

 
public 

DbSet 
< 
User 
> 
Users 
=> 
Set  #
<# $
User$ (
>( )
() *
)* +
;+ ,
public 

DbSet 
< 

Permission 
> 
Permissions (
=>) +
Set, /
</ 0

Permission0 :
>: ;
(; <
)< =
;= >
public 

DbSet 
< 
Organization 
> 
Organizations ,
=>- /
Set0 3
<3 4
Organization4 @
>@ A
(A B
)B C
;C D
public 

DbSet 
<  
OrganizationSettings %
>% & 
OrganizationSettings' ;
=>< >
Set? B
<B C 
OrganizationSettingsC W
>W X
(X Y
)Y Z
;Z [
public 

DbSet 
< 
OrganizationRole !
>! "
OrganizationRoles# 4
=>5 7
Set8 ;
<; <
OrganizationRole< L
>L M
(M N
)N O
;O P
public 

DbSet 
< &
OrganizationRolePermission +
>+ ,'
OrganizationRolePermissions- H
=>I K
SetL O
<O P&
OrganizationRolePermissionP j
>j k
(k l
)l m
;m n
public 

DbSet 
<  
UserRoleOrganization %
>% &!
UserRoleOrganizations' <
=>= ?
Set@ C
<C D 
UserRoleOrganizationD X
>X Y
(Y Z
)Z [
;[ \
public 

DbSet 
< #
OrganizationJoinRequest (
>( )$
OrganizationJoinRequests* B
=>C E
SetF I
<I J#
OrganizationJoinRequestJ a
>a b
(b c
)c d
;d e
public 

DbSet 
< "
OrganizationInvitation '
>' (#
OrganizationInvitations) @
=>A C
SetD G
<G H"
OrganizationInvitationH ^
>^ _
(_ `
)` a
;a b
public 

DbSet 
< 
WorkspaceSettings "
>" #
WorkspaceSettings$ 5
=>6 8
Set9 <
<< =
WorkspaceSettings= N
>N O
(O P
)P Q
;Q R
public 

DbSet 
< 
	Workspace 
> 

Workspaces &
=>' )
Set* -
<- .
	Workspace. 7
>7 8
(8 9
)9 :
;: ;
public 

DbSet 
< 
WorkspaceRole 
> 
WorkspaceRoles  .
=>/ 1
Set2 5
<5 6
WorkspaceRole6 C
>C D
(D E
)E F
;F G
public 

DbSet 
< #
WorkspaceRolePermission (
>( )$
WorkspaceRolePermissions* B
=>C E
SetF I
<I J#
WorkspaceRolePermissionJ a
>a b
(b c
)c d
;d e
public 

DbSet 
< 
UserRoleWorkspace "
>" #
UserRoleWorkspaces$ 6
=>7 9
Set: =
<= >
UserRoleWorkspace> O
>O P
(P Q
)Q R
;R S
public 

DbSet 
< 

EntityType 
> 
EntityTypes (
=>) +
Set, /
</ 0

EntityType0 :
>: ;
(; <
)< =
;= >
public 

DbSet 
< 
Entity 
> 
Entities !
=>" $
Set% (
<( )
Entity) /
>/ 0
(0 1
)1 2
;2 3
public 

DbSet 
< 
EntityWorkspace  
>  !
EntityWorkspaces" 2
=>3 5
Set6 9
<9 :
EntityWorkspace: I
>I J
(J K
)K L
;L M
public 

DbSet 
< 
Property 
> 

Properties %
=>& (
Set) ,
<, -
Property- 5
>5 6
(6 7
)7 8
;8 9
public   

DbSet   
<   
EntityTypeProperty   #
>  # $ 
EntityTypeProperties  % 9
=>  : <
Set  = @
<  @ A
EntityTypeProperty  A S
>  S T
(  T U
)  U V
;  V W
public!! 

DbSet!! 
<!! 
EntityPropertyValue!! $
>!!$ % 
EntityPropertyValues!!& :
=>!!; =
Set!!> A
<!!A B
EntityPropertyValue!!B U
>!!U V
(!!V W
)!!W X
;!!X Y
public"" 

DbSet"" 
<"" "
EntityRelationshipType"" '
>""' (#
EntityRelationshipTypes"") @
=>""A C
Set""D G
<""G H"
EntityRelationshipType""H ^
>""^ _
(""_ `
)""` a
;""a b
public## 

DbSet## 
<## 
EntityRelationship## #
>### $
EntityRelationships##% 8
=>##9 ;
Set##< ?
<##? @
EntityRelationship##@ R
>##R S
(##S T
)##T U
;##U V
public$$ 

DbSet$$ 
<$$  
PropertyAllowedValue$$ %
>$$% &!
PropertyAllowedValues$$' <
=>$$= ?
Set$$@ C
<$$C D 
PropertyAllowedValue$$D X
>$$X Y
($$Y Z
)$$Z [
;$$[ \
public%% 

DbSet%% 
<%% 
EntityAuditLog%% 
>%%  
EntityAuditLogs%%! 0
=>%%1 3
Set%%4 7
<%%7 8
EntityAuditLog%%8 F
>%%F G
(%%G H
)%%H I
;%%I J
public&& 

DbSet&& 
<&& 
WorkspaceAuditLog&& "
>&&" #
WorkspaceAuditLogs&&$ 6
=>&&7 9
Set&&: =
<&&= >
WorkspaceAuditLog&&> O
>&&O P
(&&P Q
)&&Q R
;&&R S
public'' 

DbSet'' 
<'' 
UserAuditLog'' 
>'' 
UserAuditLogs'' ,
=>''- /
Set''0 3
<''3 4
UserAuditLog''4 @
>''@ A
(''A B
)''B C
;''C D
public(( 

DbSet(( 
<((  
OrganizationAuditLog(( %
>((% &!
OrganizationAuditLogs((' <
=>((= ?
Set((@ C
<((C D 
OrganizationAuditLog((D X
>((X Y
(((Y Z
)((Z [
;(([ \
public)) 

DbSet)) 
<)) 
AuditOutboxMessage)) #
>))# $
AuditOutboxMessages))% 8
=>))9 ;
Set))< ?
<))? @
AuditOutboxMessage))@ R
>))R S
())S T
)))T U
;))U V
public** 

DbSet** 
<** 
AuditProcessedEvent** $
>**$ % 
AuditProcessedEvents**& :
=>**; =
Set**> A
<**A B
AuditProcessedEvent**B U
>**U V
(**V W
)**W X
;**X Y
	protected,, 
override,, 
void,, 
OnModelCreating,, +
(,,+ ,
ModelBuilder,,, 8
modelBuilder,,9 E
),,E F
{-- 
base.. 
... 
OnModelCreating.. 
(.. 
modelBuilder.. )
)..) *
;..* +
modelBuilder// 
.// (
ApplyAllEntityConfigurations// 1
(//1 2
)//2 3
;//3 4
}00 
}11 