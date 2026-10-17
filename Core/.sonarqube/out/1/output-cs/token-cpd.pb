¨
kC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Domain\Interfaces\ResolvedFilterCondition.cs
	namespace 	
Relativa
 
. 
Core 
. 
Domain 
. 

Interfaces )
;) *
public 
sealed 
record #
ResolvedFilterCondition ,
(, -
int 

PropertyId 
, 
PropertyDataType 
DataType 
, 
string 

Op 
, 
string		 

?		
 
StringValue		 
,		 
int

 
?

 
IntValue

	 
,

 
decimal 
? 
DecimalValue 
, 
bool 
? 	
	BoolValue
 
, 
DateOnly 
? 
	DateValue 
) 
; ô	
pC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Domain\Interfaces\IWorkspaceSettingsRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Domain 
. 

Interfaces )
;) *
public 
	interface (
IWorkspaceSettingsRepository -
{ 
Task 
AddAsync	 
( 
WorkspaceSettings #
settings$ ,
,, -
CancellationToken. ?
ct@ B
=C D
defaultE L
)L M
;M N
Task 
< 	
WorkspaceSettings	 
? 
> !
GetByWorkspaceIdAsync 2
(2 3
int3 6
workspaceId7 B
,B C
CancellationTokenD U
ctV X
=Y Z
default[ b
)b c
;c d
Task		 
UpdateAsync			 
(		 
WorkspaceSettings		 &
settings		' /
,		/ 0
CancellationToken		1 B
ct		C E
=		F G
default		H O
)		O P
;		P Q
}

 è
lC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Domain\Interfaces\IWorkspaceRoleRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Domain 
. 

Interfaces )
;) *
public 
	interface $
IWorkspaceRoleRepository )
{ 
Task 
< 	
WorkspaceRole	 
? 
> 
GetByIdAsync %
(% &
int& )
id* ,
,, -
CancellationToken. ?
ct@ B
=C D
defaultE L
)L M
;M N
Task 
< 	
List	 
< 
WorkspaceRole 
> 
> !
GetByWorkspaceIdAsync 3
(3 4
int4 7
workspaceId8 C
,C D
CancellationTokenE V
ctW Y
=Z [
default\ c
)c d
;d e
Task		 
<		 	
WorkspaceRole			 
?		 
>		 $
GetSystemRoleByNameAsync		 1
(		1 2
string		2 8
name		9 =
,		= >
CancellationToken		? P
ct		Q S
=		T U
default		V ]
)		] ^
;		^ _
Task

 
<

 	
WorkspaceRole

	 
?

 
>

 5
)GetSystemRoleWithPermissionsSupersetAsync

 B
(

B C
IReadOnlyCollection 
< 
string "
>" ##
requiredPermissionNames$ ;
,; <
CancellationToken 
ct 
= 
default &
)& '
;' (
Task 
AddAsync	 
( 
WorkspaceRole 
role  $
,$ %
CancellationToken& 7
ct8 :
=; <
default= D
)D E
;E F
Task 
UpdateAsync	 
( 
WorkspaceRole "
role# '
,' (
CancellationToken) :
ct; =
=> ?
default@ G
)G H
;H I
} ô
hC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Domain\Interfaces\IWorkspaceRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Domain 
. 

Interfaces )
;) *
public 
	interface  
IWorkspaceRepository %
{ 
Task 
< 	
	Workspace	 
? 
> 
GetByIdAsync !
(! "
int" %
id& (
,( )
CancellationToken* ;
ct< >
=? @
defaultA H
)H I
;I J
Task 
< 	
List	 
< 
	Workspace 
> 
> 
GetByUserIdAsync *
(* +
int+ .
userId/ 5
,5 6
CancellationToken7 H
ctI K
=L M
defaultN U
)U V
;V W
Task		 
<		 	
List			 
<		 
	Workspace		 
>		 
>		 -
!GetByUserIdAndOrganizationIdAsync		 ;
(		; <
int		< ?
userId		@ F
,		F G
int		H K
organizationId		L Z
,		Z [
CancellationToken		\ m
ct		n p
=		q r
default		s z
)		z {
;		{ |
Task 
< 	
List	 
< 
	Workspace 
> 
> $
GetByOrganizationIdAsync 2
(2 3
int3 6
organizationId7 E
,E F
CancellationTokenG X
ctY [
=\ ]
default^ e
)e f
;f g
Task 
AddAsync	 
( 
	Workspace 
	workspace %
,% &
CancellationToken' 8
ct9 ;
=< =
default> E
)E F
;F G
Task 
UpdateAsync	 
( 
	Workspace 
	workspace (
,( )
CancellationToken* ;
ct< >
=? @
defaultA H
)H I
;I J
} ı
pC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Domain\Interfaces\IUserRoleWorkspaceRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Domain 
. 

Interfaces )
;) *
public 
	interface (
IUserRoleWorkspaceRepository -
{ 
Task 
< 	
UserRoleWorkspace	 
? 
> 
GetAsync %
(% &
int& )
userId* 0
,0 1
int2 5
workspaceId6 A
,A B
CancellationTokenC T
ctU W
=X Y
defaultZ a
)a b
;b c
Task 
< 	

Dictionary	 
< 
int 
, 
int 
> 
> +
GetRolePrioritiesByUserIdsAsync >
(> ?
int		 
workspaceId		 
,		 
IReadOnlyCollection

 
<

 
int

 
>

  
userIds

! (
,

( )
CancellationToken 
ct 
= 
default &
)& '
;' (
Task 
< 	
List	 
< 
UserRoleWorkspace 
>  
>  !!
GetByWorkspaceIdAsync" 7
(7 8
int8 ;
workspaceId< G
,G H
CancellationTokenI Z
ct[ ]
=^ _
default` g
)g h
;h i
Task 
AddAsync	 
( 
UserRoleWorkspace #
member$ *
,* +
CancellationToken, =
ct> @
=A B
defaultC J
)J K
;K L
Task 
UpdateAsync	 
( 
UserRoleWorkspace &
member' -
,- .
CancellationToken/ @
ctA C
=D E
defaultF M
)M N
;N O
Task 
RemoveAsync	 
( 
UserRoleWorkspace &
member' -
,- .
CancellationToken/ @
ctA C
=D E
defaultF M
)M N
;N O
} ˆ
sC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Domain\Interfaces\IUserRoleOrganizationRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Domain 
. 

Interfaces )
;) *
public 
	interface +
IUserRoleOrganizationRepository 0
{ 
Task 
< 	 
UserRoleOrganization	 
? 
> 
GetAsync  (
(( )
int) ,
userId- 3
,3 4
int5 8
organizationId9 G
,G H
CancellationTokenI Z
ct[ ]
=^ _
default` g
)g h
;h i
Task 
< 	
List	 
<  
UserRoleOrganization "
>" #
># $$
GetByOrganizationIdAsync% =
(= >
int> A
organizationIdB P
,P Q
CancellationTokenR c
ctd f
=g h
defaulti p
)p q
;q r
Task		 
<		 	
List			 
<		  
UserRoleOrganization		 "
>		" #
>		# $
GetByUserIdAsync		% 5
(		5 6
int		6 9
userId		: @
,		@ A
CancellationToken		B S
ct		T V
=		W X
default		Y `
)		` a
;		a b
Task

 
AddAsync

	 
(

  
UserRoleOrganization

 &
member

' -
,

- .
CancellationToken

/ @
ct

A C
=

D E
default

F M
)

M N
;

N O
Task 
UpdateAsync	 
(  
UserRoleOrganization )
member* 0
,0 1
CancellationToken2 C
ctD F
=G H
defaultI P
)P Q
;Q R
Task 
RemoveAsync	 
(  
UserRoleOrganization )
member* 0
,0 1
CancellationToken2 C
ctD F
=G H
defaultI P
)P Q
;Q R
} Ç
iC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Domain\Interfaces\IPermissionRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Domain 
. 

Interfaces )
;) *
public 
	interface !
IPermissionRepository &
{ 
Task 
< 	
List	 
< 

Permission 
> 
> 
GetAllAsync &
(& '
CancellationToken' 8
ct9 ;
=< =
default> E
)E F
;F G
Task 
< 	
List	 
< 

Permission 
> 
> 
GetByIdsAsync (
(( )
IEnumerable) 4
<4 5
int5 8
>8 9
ids: =
,= >
CancellationToken? P
ctQ S
=T U
defaultV ]
)] ^
;^ _
}		 á
lC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Domain\Interfaces\IOrgInvitationRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Domain 
. 

Interfaces )
;) *
public 
	interface $
IOrgInvitationRepository )
{ 
Task 
< 	"
OrganizationInvitation	 
?  
>  !
GetByIdAsync" .
(. /
int/ 2
id3 5
,5 6
CancellationToken7 H
ctI K
=L M
defaultN U
)U V
;V W
Task 
< 	"
OrganizationInvitation	 
?  
>  !
GetByTokenAsync" 1
(1 2
string2 8
token9 >
,> ?
CancellationToken@ Q
ctR T
=U V
defaultW ^
)^ _
;_ `
Task		 
<		 	
List			 
<		 "
OrganizationInvitation		 $
>		$ %
>		% &$
GetByOrganizationIdAsync		' ?
(		? @
int		@ C
organizationId		D R
,		R S
CancellationToken		T e
ct		f h
=		i j
default		k r
)		r s
;		s t
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
 "
OrganizationInvitation

 $
>

$ %
>

% &
GetByEmailAsync

' 6
(

6 7
string

7 =
email

> C
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
;

d e
Task 
< 	"
OrganizationInvitation	 
?  
>  !(
GetPendingByOrgAndEmailAsync" >
(> ?
int? B
organizationIdC Q
,Q R
stringS Y
emailZ _
,_ `
CancellationTokena r
cts u
=v w
defaultx 
)	 Ä
;
Ä Å
Task 
AddAsync	 
( "
OrganizationInvitation (

invitation) 3
,3 4
CancellationToken5 F
ctG I
=J K
defaultL S
)S T
;T U
Task 
UpdateAsync	 
( "
OrganizationInvitation +

invitation, 6
,6 7
CancellationToken8 I
ctJ L
=M N
defaultO V
)V W
;W X
} Æ	
sC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Domain\Interfaces\IOrganizationSettingsRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Domain 
. 

Interfaces )
;) *
public 
	interface +
IOrganizationSettingsRepository 0
{ 
Task 
AddAsync	 
(  
OrganizationSettings &
settings' /
,/ 0
CancellationToken1 B
ctC E
=F G
defaultH O
)O P
;P Q
Task 
< 	 
OrganizationSettings	 
? 
> $
GetByOrganizationIdAsync  8
(8 9
int9 <
organizationId= K
,K L
CancellationTokenM ^
ct_ a
=b c
defaultd k
)k l
;l m
Task		 
UpdateAsync			 
(		  
OrganizationSettings		 )
settings		* 2
,		2 3
CancellationToken		4 E
ct		F H
=		I J
default		K R
)		R S
;		S T
}

 ±
oC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Domain\Interfaces\IOrganizationRoleRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Domain 
. 

Interfaces )
;) *
public 
	interface '
IOrganizationRoleRepository ,
{ 
Task 
< 	
OrganizationRole	 
? 
> 
GetByIdAsync (
(( )
int) ,
id- /
,/ 0
CancellationToken1 B
ctC E
=F G
defaultH O
)O P
;P Q
Task 
< 	
List	 
< 
OrganizationRole 
> 
>  $
GetByOrganizationIdAsync! 9
(9 :
int: =
organizationId> L
,L M
CancellationTokenN _
ct` b
=c d
defaulte l
)l m
;m n
Task		 
<		 	
List			 
<		 
OrganizationRole		 
>		 
>		  
GetSystemRolesAsync		! 4
(		4 5
CancellationToken		5 F
ct		G I
=		J K
default		L S
)		S T
;		T U
Task

 
<

 	
OrganizationRole

	 
?

 
>

 $
GetSystemRoleByNameAsync

 4
(

4 5
string

5 ;
name

< @
,

@ A
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
;

a b
Task 
AddAsync	 
( 
OrganizationRole "
role# '
,' (
CancellationToken) :
ct; =
=> ?
default@ G
)G H
;H I
Task 
UpdateAsync	 
( 
OrganizationRole %
role& *
,* +
CancellationToken, =
ct> @
=A B
defaultC J
)J K
;K L
} â
kC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Domain\Interfaces\IOrganizationRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Domain 
. 

Interfaces )
;) *
public 
sealed 
record !
OrganizationSearchHit *
(* +
int+ .
Id/ 1
,1 2
string3 9
Name: >
,> ?
int@ C
MemberCountD O
,O P
stringQ W

JoinPolicyX b
=c d
$stre k
)k l
;l m
public 
	interface #
IOrganizationRepository (
{ 
Task		 
<		 	
Organization			 
?		 
>		 
GetByIdAsync		 $
(		$ %
int		% (
id		) +
,		+ ,
CancellationToken		- >
ct		? A
=		B C
default		D K
)		K L
;		L M
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
 
Organization

 
>

 
>

 
GetByUserIdAsync

 -
(

- .
int

. 1
userId

2 8
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
;

Y Z
Task 
< 	
List	 
< !
OrganizationSearchHit #
># $
>$ %
SearchAsync& 1
(1 2
string2 8
query9 >
,> ?
CancellationToken@ Q
ctR T
=U V
defaultW ^
)^ _
;_ `
Task 
AddAsync	 
( 
Organization 
organization +
,+ ,
CancellationToken- >
ct? A
=B C
defaultD K
)K L
;L M
Task 
UpdateAsync	 
( 
Organization !
organization" .
,. /
CancellationToken0 A
ctB D
=E F
defaultG N
)N O
;O P
} ∫
jC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Domain\Interfaces\IJoinRequestRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Domain 
. 

Interfaces )
;) *
public 
	interface "
IJoinRequestRepository '
{ 
Task 
< 	#
OrganizationJoinRequest	  
?  !
>! "
GetByIdAsync# /
(/ 0
int0 3
id4 6
,6 7
CancellationToken8 I
ctJ L
=M N
defaultO V
)V W
;W X
Task 
< 	
List	 
< #
OrganizationJoinRequest %
>% &
>& '$
GetByOrganizationIdAsync( @
(@ A
intA D
organizationIdE S
,S T
CancellationTokenU f
ctg i
=j k
defaultl s
)s t
;t u
Task		 
<		 	
List			 
<		 #
OrganizationJoinRequest		 %
>		% &
>		& '
GetByUserIdAsync		( 8
(		8 9
int		9 <
userId		= C
,		C D
CancellationToken		E V
ct		W Y
=		Z [
default		\ c
)		c d
;		d e
Task

 
<

 	#
OrganizationJoinRequest

	  
?

  !
>

! "
GetPendingAsync

# 2
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
? B
organizationId

C Q
,

Q R
CancellationToken

S d
ct

e g
=

h i
default

j q
)

q r
;

r s
Task 
AddAsync	 
( #
OrganizationJoinRequest )
request* 1
,1 2
CancellationToken3 D
ctE G
=H I
defaultJ Q
)Q R
;R S
Task 
UpdateAsync	 
( #
OrganizationJoinRequest ,
request- 4
,4 5
CancellationToken6 G
ctH J
=K L
defaultM T
)T U
;U V
} ï
iC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Domain\Interfaces\IEntityTypeRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Domain 
. 

Interfaces )
;) *
public 
	interface !
IEntityTypeRepository &
{ 
Task 
< 	
List	 
< 

EntityType 
> 
> %
GetAllWithPropertiesAsync 4
(4 5
CancellationToken5 F
ctG I
=J K
defaultL S
)S T
;T U
} ”:
eC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Domain\Interfaces\IEntityRepository.cs
	namespace 	
Relativa
 
. 
Core 
. 
Domain 
. 

Interfaces )
;) *
public 
	interface 
IEntityRepository "
{ 
Task 
< 	

EntityType	 
? 
> "
GetEntityTypeByIdAsync ,
(, -
int- 0
entityTypeId1 =
,= >
CancellationToken? P
ctQ S
=T U
defaultV ]
)] ^
;^ _
Task 
< 	
List	 
< "
EntityRelationshipType $
>$ %
>% &-
!GetOutgoingRelationshipTypesAsync' H
(H I
intI L
entityTypeIdM Y
,Y Z
CancellationToken[ l
ctm o
=p q
defaultr y
)y z
;z {
Task		 
<		 	
List			 
<		 
EntityTypeProperty		  
>		  !
>		! ""
GetTypePropertiesAsync		# 9
(		9 :
int		: =
entityTypeId		> J
,		J K
CancellationToken		L ]
ct		^ `
=		a b
default		c j
)		j k
;		k l
Task

 
<

 	
(

	 

List


 
<

 
Entity

 
>

 
Items

 
,

 
int

 !
Total

" '
)

' (
>

( )
GetByWorkspaceAsync

* =
(

= >
int 
workspaceId 
, 
int 
requesterUserId 
, 
int !
requesterRolePriority !
,! "
int 
? 
entityTypeId 
, 
string 
? 
searchQuery 
, 
int 
skip 
, 
int 
take 
, 
IReadOnlyList 
< #
ResolvedFilterCondition -
>- .
filters/ 6
,6 7
IReadOnlyList 
< 
EntitySortField %
>% &
sort' +
,+ ,
int 
? (
excludeLinkedSourceRelTypeId )
=* +
null, 0
,0 1
int 
? (
excludeLinkedTargetRelTypeId )
=* +
null, 0
,0 1
CancellationToken 
ct 
= 
default &
)& '
;' (
Task 
< 	
Entity	 
? 
> #
GetByIdInWorkspaceAsync )
() *
int* -
entityId. 6
,6 7
int8 ;
workspaceId< G
,G H
CancellationTokenI Z
ct[ ]
=^ _
default` g
)g h
;h i
Task 
< 	
Entity	 
> 
CreateAsync 
( 
Entity 
entity 
, 
List 
< 
EntityPropertyValue  
>  !
propertyValues" 0
,0 1
int 
workspaceId 
, 
IReadOnlyList 
< 
EntityRelationship (
>( )
?) *
relationships+ 8
,8 9
CancellationToken 
ct 
= 
default &
)& '
;' (
Task 
UpdateAsync	 
( 
Entity 
entity "
," #
List$ (
<( )
EntityPropertyValue) <
>< =
newPropertyValues> O
,O P
CancellationTokenQ b
ctc e
=f g
defaulth o
)o p
;p q
Task !
SetArchivedStateAsync	 
( 
int "
entityId# +
,+ ,
bool- 1

isArchived2 <
,< =
CancellationToken> O
ctP R
=S T
defaultU \
)\ ]
;] ^
Task   
ArchiveAsync  	 
(   
int   
entityId   "
,  " #
CancellationToken  $ 5
ct  6 8
=  9 :
default  ; B
)  B C
;  C D
Task## 
<## 	"
EntityRelationshipType##	 
?##  
>##  !(
GetRelationshipTypeByIdAsync##" >
(##> ?
int##? B
relationshipTypeId##C U
,##U V
CancellationToken##W h
ct##i k
=##l m
default##n u
)##u v
;##v w
Task$$ 
<$$ 	
EntityRelationship$$	 
?$$ 
>$$ $
GetRelationshipByIdAsync$$ 6
($$6 7
int$$7 :
relationshipId$$; I
,$$I J
CancellationToken$$K \
ct$$] _
=$$` a
default$$b i
)$$i j
;$$j k
Task%% 
<%% 	
EntityRelationship%%	 
>%%  
AddRelationshipAsync%% 1
(%%1 2
EntityRelationship%%2 D
relationship%%E Q
,%%Q R
CancellationToken%%S d
ct%%e g
=%%h i
default%%j q
)%%q r
;%%r s
Task&& #
RemoveRelationshipAsync&&	  
(&&  !
int&&! $
relationshipId&&% 3
,&&3 4
CancellationToken&&5 F
ct&&G I
=&&J K
default&&L S
)&&S T
;&&T U
Task'' )
UpdateRelationshipSourceAsync''	 &
(''& '
int''' *
relationshipId''+ 9
,''9 :
int''; >
newSourceEntityId''? P
,''P Q
CancellationToken''R c
ct''d f
=''g h
default''i p
)''p q
;''q r
Task(( )
UpdateRelationshipTargetAsync((	 &
(((& '
int((' *
relationshipId((+ 9
,((9 :
int((; >
newTargetEntityId((? P
,((P Q
CancellationToken((R c
ct((d f
=((g h
default((i p
)((p q
;((q r
Task)) 
<)) 	
int))	 
>)) +
CountRelationshipsBySourceAsync)) -
())- .
int)). 1
sourceEntityId))2 @
,))@ A
int))B E
relationshipTypeId))F X
,))X Y
CancellationToken))Z k
ct))l n
=))o p
default))q x
)))x y
;))y z
Task** 
<** 	
int**	 
>** +
CountRelationshipsByTargetAsync** -
(**- .
int**. 1
targetEntityId**2 @
,**@ A
int**B E
relationshipTypeId**F X
,**X Y
CancellationToken**Z k
ct**l n
=**o p
default**q x
)**x y
;**y z
Task++ 
<++ 	
T++	 

>++
 %
ExecuteInTransactionAsync++ %
<++% &
T++& '
>++' (
(++( )
Func++) -
<++- .
Task++. 2
<++2 3
T++3 4
>++4 5
>++5 6
action++7 =
,++= >
CancellationToken++? P
ct++Q S
=++T U
default++V ]
)++] ^
;++^ _
},, Ò
cC:\Users\babay\myrepos\testing\Relativa\Core\src\Relativa.Core.Domain\Interfaces\EntitySortField.cs
	namespace 	
Relativa
 
. 
Core 
. 
Domain 
. 

Interfaces )
;) *
public 
sealed 
record 
EntitySortField $
($ %
int% (

PropertyId) 3
,3 4
string5 ;
	Direction< E
)E F
;F G