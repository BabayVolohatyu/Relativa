­
eC:\Users\babay\myrepos\testing\Relativa\Messaging\src\Relativa.Messaging\RabbitMqPublishingOptions.cs
	namespace 	
Relativa
 
. 
	Messaging 
; 
public 
sealed 
class %
RabbitMqPublishingOptions -
{ 
public 

const 
string #
ConfigurationSectionKey /
=0 1
$str2 A
;A B
public 

string 
Host 
{ 
get 
; 
set !
;! "
}# $
=% &
$str' 2
;2 3
public 

int 
Port 
{ 
get 
; 
set 
; 
}  !
=" #
$num$ (
;( )
public		 

string		 
Username		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
=		) *
$str		+ 2
;		2 3
public

 

string

 
Password

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
=

) *
$str

+ 2
;

2 3
public 

string 
AuditExchange 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 >
;> ?
public 

string 
Exchange 
{ 
get 
=> 
AuditExchange 
; 
set 
=> 
AuditExchange 
= 
value $
;$ %
} 
public 

string 
DomainExchange  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 B
;B C
} õ	
bC:\Users\babay\myrepos\testing\Relativa\Messaging\src\Relativa.Messaging\RabbitMqExchangeRouter.cs
	namespace 	
Relativa
 
. 
	Messaging 
; 
public 
static 
class "
RabbitMqExchangeRouter *
{ 
public 

static 
string "
ResolvePublishExchange /
(/ 0
string0 6

routingKey7 A
,A B%
RabbitMqPublishingOptionsC \
options] d
)d e
{ !
ArgumentNullException 
. 
ThrowIfNull )
() *

routingKey* 4
)4 5
;5 6!
ArgumentNullException		 
.		 
ThrowIfNull		 )
(		) *
options		* 1
)		1 2
;		2 3
return

 

routingKey

 
.

 

StartsWith

 $
(

$ %
$str

% -
,

- .
StringComparison

/ ?
.

? @
OrdinalIgnoreCase

@ Q
)

Q R
? 
options 
. 
AuditExchange #
: 
options 
. 
DomainExchange $
;$ %
} 
} Å
cC:\Users\babay\myrepos\testing\Relativa\Messaging\src\Relativa.Messaging\OutboxRabbitMqPublisher.cs
	namespace 	
Relativa
 
. 
	Messaging 
; 
public 
static 
class #
OutboxRabbitMqPublisher +
{ 
public 

static 
async 
Task %
EnsureTopicExchangesAsync 6
(6 7%
RabbitMqPublishingOptions		 !
options		" )
,		) *
CancellationToken

 
ct

 
)

 
{ 
await 
using 
var 

connection "
=# $
await% *!
CreateConnectionAsync+ @
(@ A
optionsA H
,H I
ctJ L
)L M
;M N
await 
using 
var 
channel 
=  !
await" '

connection( 2
.2 3
CreateChannelAsync3 E
(E F
cancellationTokenF W
:W X
ctY [
)[ \
;\ ]
await .
"EnsureTopicExchangesOnChannelAsync 0
(0 1
channel1 8
,8 9
options: A
,A B
ctC E
)E F
;F G
} 
public 

static 
Task 
< 
IConnection "
>" #!
CreateConnectionAsync$ 9
(9 :%
RabbitMqPublishingOptions: S
optionsT [
,[ \
CancellationToken] n
cto q
)q r
=>s u
new 
ConnectionFactory 
{ 	
HostName 
= 
options 
. 
Host #
,# $
Port 
= 
options 
. 
Port 
,  
UserName 
= 
options 
. 
Username '
,' (
Password 
= 
options 
. 
Password '
} 	
.	 
!
CreateConnectionAsync
 
(  
ct  "
)" #
;# $
public 

static 
async 
Task .
"EnsureTopicExchangesOnChannelAsync ?
(? @
IChannel 
channel 
, %
RabbitMqPublishingOptions !
options" )
,) *
CancellationToken 
ct 
) 
{ 
await 
EnsureTopic 
( 
channel !
,! "
options# *
.* +
AuditExchange+ 8
,8 9
ct: <
)< =
;= >
await   
EnsureTopic   
(   
channel   !
,  ! "
options  # *
.  * +
DomainExchange  + 9
,  9 :
ct  ; =
)  = >
;  > ?
}!! 
private## 
static## 
async## 
Task## 
EnsureTopic## )
(##) *
IChannel##* 2
channel##3 :
,##: ;
string##< B
exchangeName##C O
,##O P
CancellationToken##Q b
ct##c e
)##e f
=>##g i
await$$ 
channel$$ 
.$$  
ExchangeDeclareAsync$$ *
($$* +
exchange%% 
:%% 
exchangeName%% "
,%%" #
type&& 
:&& 
ExchangeType&& 
.&& 
Topic&& $
,&&$ %
durable'' 
:'' 
true'' 
,'' 

autoDelete(( 
:(( 
false(( 
,(( 
cancellationToken)) 
:)) 
ct)) !
)))! "
;))" #
}** 