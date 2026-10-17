«M
fC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\ModelBuilderExtensions.cs
	namespace 	
Relativa
 
. 
Persistence 
; 
public 
static 
class -
!PersistenceModelBuilderExtensions 5
{		 
public

 

static

 
ModelBuilder

 )
ApplyAuthEntityConfigurations

 <
(

< =
this

= A
ModelBuilder

B N
modelBuilder

O [
)

[ \
{ 
modelBuilder 
. 
ApplyConfiguration '
(' (
new( +
UserConfiguration, =
(= >
)> ?
)? @
;@ A
modelBuilder 
. 
ApplyConfiguration '
(' (
new( +%
UserSettingsConfiguration, E
(E F
)F G
)G H
;H I
modelBuilder 
. 
ApplyConfiguration '
(' (
new( +*
UserExternalLoginConfiguration, J
(J K
)K L
)L M
;M N
modelBuilder 
. 
ApplyConfiguration '
(' (
new( +'
UserBackupCodeConfiguration, G
(G H
)H I
)I J
;J K
modelBuilder 
. 
ApplyConfiguration '
(' (
new( +"
UserEmailConfiguration, B
(B C
)C D
)D E
;E F
modelBuilder 
. 
ApplyConfiguration '
(' (
new( +%
UserAuditLogConfiguration, E
(E F
)F G
)G H
;H I
modelBuilder 
. 
ApplyConfiguration '
(' (
new( ++
AuditOutboxMessageConfiguration, K
(K L
)L M
)M N
;N O
modelBuilder 
. 
Ignore 
< 
UserRoleWorkspace -
>- .
(. /
)/ 0
;0 1
modelBuilder 
. 
Ignore 
<  
UserRoleOrganization 0
>0 1
(1 2
)2 3
;3 4
modelBuilder 
. 
Ignore 
< 
Entity "
>" #
(# $
)$ %
;% &
return 
modelBuilder 
; 
} 
public 

static 
ModelBuilder (
ApplyAllEntityConfigurations ;
(; <
this< @
ModelBuilderA M
modelBuilderN Z
)Z [
{ 
modelBuilder   
.   
ApplyConfiguration   '
(  ' (
new  ( +
UserConfiguration  , =
(  = >
)  > ?
)  ? @
;  @ A
modelBuilder!! 
.!! 
ApplyConfiguration!! '
(!!' (
new!!( +%
UserSettingsConfiguration!!, E
(!!E F
)!!F G
)!!G H
;!!H I
modelBuilder"" 
."" 
ApplyConfiguration"" '
(""' (
new""( +*
UserExternalLoginConfiguration"", J
(""J K
)""K L
)""L M
;""M N
modelBuilder## 
.## 
ApplyConfiguration## '
(##' (
new##( +'
UserBackupCodeConfiguration##, G
(##G H
)##H I
)##I J
;##J K
modelBuilder$$ 
.$$ 
ApplyConfiguration$$ '
($$' (
new$$( +"
UserEmailConfiguration$$, B
($$B C
)$$C D
)$$D E
;$$E F
modelBuilder%% 
.%% 
ApplyConfiguration%% '
(%%' (
new%%( +#
PermissionConfiguration%%, C
(%%C D
)%%D E
)%%E F
;%%F G
modelBuilder'' 
.'' 
ApplyConfiguration'' '
(''' (
new''( +%
OrganizationConfiguration'', E
(''E F
)''F G
)''G H
;''H I
modelBuilder(( 
.(( 
ApplyConfiguration(( '
(((' (
new((( +)
OrganizationRoleConfiguration((, I
(((I J
)((J K
)((K L
;((L M
modelBuilder)) 
.)) 
ApplyConfiguration)) '
())' (
new))( +3
'OrganizationRolePermissionConfiguration)), S
())S T
)))T U
)))U V
;))V W
modelBuilder** 
.** 
ApplyConfiguration** '
(**' (
new**( +-
!UserRoleOrganizationConfiguration**, M
(**M N
)**N O
)**O P
;**P Q
modelBuilder++ 
.++ 
ApplyConfiguration++ '
(++' (
new++( +0
$OrganizationJoinRequestConfiguration++, P
(++P Q
)++Q R
)++R S
;++S T
modelBuilder,, 
.,, 
ApplyConfiguration,, '
(,,' (
new,,( +/
#OrganizationInvitationConfiguration,,, O
(,,O P
),,P Q
),,Q R
;,,R S
modelBuilder.. 
... 
ApplyConfiguration.. '
(..' (
new..( +-
!OrganizationSettingsConfiguration.., M
(..M N
)..N O
)..O P
;..P Q
modelBuilder// 
.// 
ApplyConfiguration// '
(//' (
new//( +*
WorkspaceSettingsConfiguration//, J
(//J K
)//K L
)//L M
;//M N
modelBuilder00 
.00 
ApplyConfiguration00 '
(00' (
new00( +"
WorkspaceConfiguration00, B
(00B C
)00C D
)00D E
;00E F
modelBuilder11 
.11 
ApplyConfiguration11 '
(11' (
new11( +&
WorkspaceRoleConfiguration11, F
(11F G
)11G H
)11H I
;11I J
modelBuilder22 
.22 
ApplyConfiguration22 '
(22' (
new22( +0
$WorkspaceRolePermissionConfiguration22, P
(22P Q
)22Q R
)22R S
;22S T
modelBuilder33 
.33 
ApplyConfiguration33 '
(33' (
new33( +*
UserRoleWorkspaceConfiguration33, J
(33J K
)33K L
)33L M
;33M N
modelBuilder55 
.55 
ApplyConfiguration55 '
(55' (
new55( +#
EntityTypeConfiguration55, C
(55C D
)55D E
)55E F
;55F G
modelBuilder66 
.66 
ApplyConfiguration66 '
(66' (
new66( +
EntityConfiguration66, ?
(66? @
)66@ A
)66A B
;66B C
modelBuilder77 
.77 
ApplyConfiguration77 '
(77' (
new77( +(
EntityWorkspaceConfiguration77, H
(77H I
)77I J
)77J K
;77K L
modelBuilder88 
.88 
ApplyConfiguration88 '
(88' (
new88( +!
PropertyConfiguration88, A
(88A B
)88B C
)88C D
;88D E
modelBuilder99 
.99 
ApplyConfiguration99 '
(99' (
new99( ++
EntityTypePropertyConfiguration99, K
(99K L
)99L M
)99M N
;99N O
modelBuilder:: 
.:: 
ApplyConfiguration:: '
(::' (
new::( +,
 EntityPropertyValueConfiguration::, L
(::L M
)::M N
)::N O
;::O P
modelBuilder;; 
.;; 
ApplyConfiguration;; '
(;;' (
new;;( +/
#EntityRelationshipTypeConfiguration;;, O
(;;O P
);;P Q
);;Q R
;;;R S
modelBuilder<< 
.<< 
ApplyConfiguration<< '
(<<' (
new<<( ++
EntityRelationshipConfiguration<<, K
(<<K L
)<<L M
)<<M N
;<<N O
modelBuilder== 
.== 
ApplyConfiguration== '
(==' (
new==( +-
!PropertyAllowedValueConfiguration==, M
(==M N
)==N O
)==O P
;==P Q
modelBuilder?? 
.?? 
ApplyConfiguration?? '
(??' (
new??( +'
EntityAuditLogConfiguration??, G
(??G H
)??H I
)??I J
;??J K
modelBuilder@@ 
.@@ 
ApplyConfiguration@@ '
(@@' (
new@@( +*
WorkspaceAuditLogConfiguration@@, J
(@@J K
)@@K L
)@@L M
;@@M N
modelBuilderAA 
.AA 
ApplyConfigurationAA '
(AA' (
newAA( +%
UserAuditLogConfigurationAA, E
(AAE F
)AAF G
)AAG H
;AAH I
modelBuilderBB 
.BB 
ApplyConfigurationBB '
(BB' (
newBB( +-
!OrganizationAuditLogConfigurationBB, M
(BBM N
)BBN O
)BBO P
;BBP Q
modelBuilderCC 
.CC 
ApplyConfigurationCC '
(CC' (
newCC( ++
AuditOutboxMessageConfigurationCC, K
(CCK L
)CCL M
)CCM N
;CCN O
modelBuilderDD 
.DD 
ApplyConfigurationDD '
(DD' (
newDD( +,
 AuditProcessedEventConfigurationDD, L
(DDL M
)DDM N
)DDN O
;DDO P
modelBuilderEE 
.EE 
ApplyConfigurationEE '
(EE' (
newEE( +2
&RabbitMqProcessedDeliveryConfigurationEE, R
(EER S
)EES T
)EET U
;EEU V
returnGG 
modelBuilderGG 
;GG 
}HH 
}II ˇ
jC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\WorkspaceSettings.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
WorkspaceSettings 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
WorkspaceId 
{ 
get  
;  !
set" %
;% &
}' (
public 

decimal 
HighRiskThreshold $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 

decimal 
MediumRiskThreshold &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
public		 

string		 
?		 
Description		 
{		  
get		! $
;		$ %
set		& )
;		) *
}		+ ,
public

 

bool

 
RiskScoringEnabled

 "
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
/ 0
public 

	Workspace 
	Workspace 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
null/ 3
!3 4
;4 5
} Â	
pC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\WorkspaceRolePermission.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class #
WorkspaceRolePermission $
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
WsRoleId 
{ 
get 
; 
set "
;" #
}$ %
public 

int 
PermissionId 
{ 
get !
;! "
set# &
;& '
}( )
public 

WorkspaceRole 
Role 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
null. 2
!2 3
;3 4
public		 


Permission		 

Permission		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
=		/ 0
null		1 5
!		5 6
;		6 7
}

 ˇ
fC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\WorkspaceRole.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
WorkspaceRole 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
=% &
null' +
!+ ,
;, -
public 

string 
? 
DisplayName 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

int 
? 
WorkspaceId 
{ 
get !
;! "
set# &
;& '
}( )
public

 

int

 
Priority

 
{

 
get

 
;

 
set

 "
;

" #
}

$ %
public 

bool 

IsArchived 
{ 
get  
;  !
set" %
;% &
}' (
public 

	Workspace 
? 
	Workspace 
{  !
get" %
;% &
set' *
;* +
}, -
public 

ICollection 
< #
WorkspaceRolePermission .
>. /
RolePermissions0 ?
{@ A
getB E
;E F
setG J
;J K
}L M
=N O
newP S
ListT X
<X Y#
WorkspaceRolePermissionY p
>p q
(q r
)r s
;s t
public 

ICollection 
< 
UserRoleWorkspace (
>( )
WorkspaceMembers* :
{; <
get= @
;@ A
setB E
;E F
}G H
=I J
newK N
ListO S
<S T
UserRoleWorkspaceT e
>e f
(f g
)g h
;h i
} Í
bC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\Workspace.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
	Workspace 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
=% &
null' +
!+ ,
;, -
public 

int 
OrganizationId 
{ 
get  #
;# $
set% (
;( )
}* +
public 

int 
CreatedByUserId 
{  
get! $
;$ %
set& )
;) *
}+ ,
public		 

bool		 

IsArchived		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
public

 

Organization

 
Organization

 $
{

% &
get

' *
;

* +
set

, /
;

/ 0
}

1 2
=

3 4
null

5 9
!

9 :
;

: ;
public 

User 
	CreatedBy 
{ 
get 
;  
set! $
;$ %
}& '
=( )
null* .
!. /
;/ 0
public 

WorkspaceSettings 
? 
WorkspaceSettings /
{0 1
get2 5
;5 6
set7 :
;: ;
}< =
public 

ICollection 
< 
EntityWorkspace &
>& '
EntityWorkspaces( 8
{9 :
get; >
;> ?
set@ C
;C D
}E F
=G H
newI L
ListM Q
<Q R
EntityWorkspaceR a
>a b
(b c
)c d
;d e
public 

ICollection 
< 
UserRoleWorkspace (
>( )
Members* 1
{2 3
get4 7
;7 8
set9 <
;< =
}> ?
=@ A
newB E
ListF J
<J K
UserRoleWorkspaceK \
>\ ]
(] ^
)^ _
;_ `
public 

ICollection 
< 
WorkspaceRole $
>$ %
Roles& +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
=: ;
new< ?
List@ D
<D E
WorkspaceRoleE R
>R S
(S T
)T U
;U V
} ê
eC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\UserSettings.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
UserSettings 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
UserId 
{ 
get 
; 
set  
;  !
}" #
public 

string 
Locale 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) -
;- .
public 

User 
User 
{ 
get 
; 
set 
;  
}! "
=# $
null% )
!) *
;* +
}		 ¸
jC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\UserRoleWorkspace.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
UserRoleWorkspace 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
UserId 
{ 
get 
; 
set  
;  !
}" #
public 

int 
WorkspaceId 
{ 
get  
;  !
set" %
;% &
}' (
public 

int 
WsRoleId 
{ 
get 
; 
set "
;" #
}$ %
public		 

DateTime		 
JoinedAt		 
{		 
get		 "
;		" #
set		$ '
;		' (
}		) *
public

 

bool

 

IsArchived

 
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
' (
public 

User 
User 
{ 
get 
; 
set 
;  
}! "
=# $
null% )
!) *
;* +
public 

	Workspace 
	Workspace 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
null/ 3
!3 4
;4 5
public 

WorkspaceRole 
Role 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
null. 2
!2 3
;3 4
} è
mC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\UserRoleOrganization.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class  
UserRoleOrganization !
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
UserId 
{ 
get 
; 
set  
;  !
}" #
public 

int 
OrganizationId 
{ 
get  #
;# $
set% (
;( )
}* +
public 

int 
	OrgRoleId 
{ 
get 
; 
set  #
;# $
}% &
public		 

DateTime		 
JoinedAt		 
{		 
get		 "
;		" #
set		$ '
;		' (
}		) *
public

 

bool

 

IsArchived

 
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
' (
public 

User 
User 
{ 
get 
; 
set 
;  
}! "
=# $
null% )
!) *
;* +
public 

Organization 
Organization $
{% &
get' *
;* +
set, /
;/ 0
}1 2
=3 4
null5 9
!9 :
;: ;
public 

OrganizationRole 
Role  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
null1 5
!5 6
;6 7
} §
jC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\UserExternalLogin.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
UserExternalLogin 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
UserId 
{ 
get 
; 
set  
;  !
}" #
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
null+ /
!/ 0
;0 1
public 

string 
Subject 
{ 
get 
;  
set! $
;$ %
}& '
=( )
null* .
!. /
;/ 0
public		 

DateTime		 
	CreatedAt		 
{		 
get		  #
;		# $
set		% (
;		( )
}		* +
public

 

User

 
User

 
{

 
get

 
;

 
set

 
;

  
}

! "
=

# $
null

% )
!

) *
;

* +
} í
bC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\UserEmail.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
	UserEmail 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
UserId 
{ 
get 
; 
set  
;  !
}" #
public 

string 
Address 
{ 
get 
;  
set! $
;$ %
}& '
=( )
null* .
!. /
;/ 0
public 

bool 

IsVerified 
{ 
get  
;  !
set" %
;% &
}' (
public		 

string		 
Source		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
=		' (
$str		) 1
;		1 2
public

 

string

 
?

 
VerificationToken

 $
{

% &
get

' *
;

* +
set

, /
;

/ 0
}

1 2
public 

DateTime 
? &
VerificationTokenExpiresAt /
{0 1
get2 5
;5 6
set7 :
;: ;
}< =
public 

DateTime 
	CreatedAt 
{ 
get  #
;# $
set% (
;( )
}* +
public 

User 
User 
{ 
get 
; 
set 
;  
}! "
=# $
null% )
!) *
;* +
} Ô

gC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\UserBackupCode.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
UserBackupCode 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
UserId 
{ 
get 
; 
set  
;  !
}" #
public 

string 
CodeHash 
{ 
get  
;  !
set" %
;% &
}' (
=) *
null+ /
!/ 0
;0 1
public 

DateTime 
	CreatedAt 
{ 
get  #
;# $
set% (
;( )
}* +
public		 

DateTime		 
?		 
UsedAt		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
public

 

User

 
User

 
{

 
get

 
;

 
set

 
;

  
}

! "
=

# $
null

% )
!

) *
;

* +
} ∆-
]C:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\User.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
User 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
	FirstName 
{ 
get !
;! "
set# &
;& '
}( )
=* +
null, 0
!0 1
;1 2
public 

string 
LastName 
{ 
get  
;  !
set" %
;% &
}' (
=) *
null+ /
!/ 0
;0 1
public 

string 
Email 
{ 
get 
; 
set "
;" #
}$ %
=& '
null( ,
!, -
;- .
public		 

string		 
?		 
Phone		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
public

 

DateOnly

 
?

 
DateOfBirth

  
{

! "
get

# &
;

& '
set

( +
;

+ ,
}

- .
public 

string 
? 
Password 
{ 
get !
;! "
set# &
;& '
}( )
public 

DateTime 
	CreatedAt 
{ 
get  #
;# $
set% (
;( )
}* +
public 

bool 

IsArchived 
{ 
get  
;  !
set" %
;% &
}' (
public 

string 
? 
PasswordResetToken %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
public 

DateTime 
? '
PasswordResetTokenExpiresAt 0
{1 2
get3 6
;6 7
set8 ;
;; <
}= >
public 

bool 
EmailVerified 
{ 
get  #
;# $
set% (
;( )
}* +
public 

string 
? "
EmailVerificationToken )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
public 

DateTime 
? +
EmailVerificationTokenExpiresAt 4
{5 6
get7 :
;: ;
set< ?
;? @
}A B
public 

bool 
TwoFactorEnabled  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

string 
? 
TwoFactorSecret "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 

string 
? #
TwoFactorMasterCodeHash *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
public 

UserSettings 
? 
Settings !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 

ICollection 
< 
UserExternalLogin (
>( )
ExternalLogins* 8
{9 :
get; >
;> ?
set@ C
;C D
}E F
=G H
newI L
ListM Q
<Q R
UserExternalLoginR c
>c d
(d e
)e f
;f g
public 

ICollection 
< 
UserBackupCode %
>% &
BackupCodes' 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
=A B
newC F
ListG K
<K L
UserBackupCodeL Z
>Z [
([ \
)\ ]
;] ^
public 

ICollection 
< 
	UserEmail  
>  !
Emails" (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
=7 8
new9 <
List= A
<A B
	UserEmailB K
>K L
(L M
)M N
;N O
public 

ICollection 
< 
Entity 
> 
CreatedEntities .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
== >
new? B
ListC G
<G H
EntityH N
>N O
(O P
)P Q
;Q R
public 

ICollection 
< 
UserRoleWorkspace (
>( ) 
WorkspaceMemberships* >
{? @
getA D
;D E
setF I
;I J
}K L
=M N
newO R
ListS W
<W X
UserRoleWorkspaceX i
>i j
(j k
)k l
;l m
public 

ICollection 
<  
UserRoleOrganization +
>+ ,#
OrganizationMemberships- D
{E F
getG J
;J K
setL O
;O P
}Q R
=S T
newU X
ListY ]
<] ^ 
UserRoleOrganization^ r
>r s
(s t
)t u
;u v
} Ø
pC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\RelationshipCardinality.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public		 
enum		 #
RelationshipCardinality		 #
{

 
	ManyToOne 
= 
$num 
, 
	OneToMany 
= 
$num 
, 
OneToOne 
= 
$num 
, 

ManyToMany 
= 
$num 
, 
} 
public 
static 
class -
!RelationshipCardinalityExtensions 5
{ 
public 

static 
string 
ToDatabaseValue (
(( )
this) -#
RelationshipCardinality. E
valueF K
)K L
=>M O
value 
switch 
{ 	#
RelationshipCardinality #
.# $
OneToOne$ ,
=>- /
$str0 <
,< =#
RelationshipCardinality #
.# $
	OneToMany$ -
=>. 0
$str1 >
,> ?#
RelationshipCardinality #
.# $
	ManyToOne$ -
=>. 0
$str1 >
,> ?#
RelationshipCardinality #
.# $

ManyToMany$ .
=>/ 1
$str2 @
,@ A
_ 
=> 
throw 
new '
ArgumentOutOfRangeException 6
(6 7
nameof7 =
(= >
value> C
)C D
,D E
valueF K
,K L
nullM Q
)Q R
,R S
} 	
;	 

public 

static #
RelationshipCardinality )
ParseDatabaseValue* <
(< =
string= C
valueD I
)I J
=>K M
value 
switch 
{ 	
$str   
=>   #
RelationshipCardinality   3
.  3 4
OneToOne  4 <
,  < =
$str!! 
=>!! #
RelationshipCardinality!! 4
.!!4 5
	OneToMany!!5 >
,!!> ?
$str"" 
=>"" #
RelationshipCardinality"" 4
.""4 5
	ManyToOne""5 >
,""> ?
$str## 
=>## #
RelationshipCardinality## 5
.##5 6

ManyToMany##6 @
,##@ A
_$$ 
=>$$ #
RelationshipCardinality$$ (
.$$( )
	ManyToOne$$) 2
,$$2 3
}%% 	
;%%	 

}&& ö
rC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\RabbitMqProcessedDelivery.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
sealed 
class %
RabbitMqProcessedDelivery -
{ 
public 

Guid 
	MessageId 
{ 
get 
;  
set! $
;$ %
}& '
public		 

string		 
ConsumerGroup		 
{		  !
get		" %
;		% &
set		' *
;		* +
}		, -
=		. /
null		0 4
!		4 5
;		5 6
public 

DateTimeOffset 
ProcessedAtUtc (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
} ’
mC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\PropertyAllowedValue.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class  
PropertyAllowedValue !
{ 
public 

int 

PropertyId 
{ 
get 
;  
set! $
;$ %
}& '
public 

string 
Value 
{ 
get 
; 
set "
;" #
}$ %
=& '
null( ,
!, -
;- .
public 

string 
? 
DisplayName 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

Property 
Property 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
null- 1
!1 2
;2 3
}		 â
aC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\Property.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
enum 
PropertyDataType 
{ 
String 

,
 
Int 
, 
Decimal 
, 
Bool 
, 	
Date		 
}

 
public 
class 
Property 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
=% &
null' +
!+ ,
;, -
public 

string 
? 
DisplayName 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

PropertyDataType 
DataType $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 

bool 

IsReadonly 
{ 
get  
;  !
set" %
;% &
}' (
public 

int 
? 
OrganizationId 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

Organization 
? 
Organization %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
public 

ICollection 
< 
EntityTypeProperty )
>) * 
EntityTypeProperties+ ?
{@ A
getB E
;E F
setG J
;J K
}L M
=N O
newP S
ListT X
<X Y
EntityTypePropertyY k
>k l
(l m
)m n
;n o
public 

ICollection 
< 
EntityPropertyValue *
>* + 
EntityPropertyValues, @
{A B
getC F
;F G
setH K
;K L
}M N
=O P
newQ T
ListU Y
<Y Z
EntityPropertyValueZ m
>m n
(n o
)o p
;p q
public 

ICollection 
<  
PropertyAllowedValue +
>+ ,
AllowedValues- :
{; <
get= @
;@ A
setB E
;E F
}G H
=I J
newK N
ListO S
<S T 
PropertyAllowedValueT h
>h i
(i j
)j k
;k l
} µ
cC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\Permission.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 

Permission 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
=% &
null' +
!+ ,
;, -
public 

string 
? 
DisplayName 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

bool 

IsArchived 
{ 
get  
;  !
set" %
;% &
}' (
public		 

ICollection		 
<		 #
WorkspaceRolePermission		 .
>		. /$
WorkspaceRolePermissions		0 H
{		I J
get		K N
;		N O
set		P S
;		S T
}		U V
=		W X
new		Y \
List		] a
<		a b#
WorkspaceRolePermission		b y
>		y z
(		z {
)		{ |
;		| }
public

 

ICollection

 
<

 &
OrganizationRolePermission

 1
>

1 2'
OrganizationRolePermissions

3 N
{

O P
get

Q T
;

T U
set

V Y
;

Y Z
}

[ \
=

] ^
new

_ b
List

c g
<

g h'
OrganizationRolePermission	

h Ç
>


Ç É
(


É Ñ
)


Ñ Ö
;


Ö Ü
} ’
mC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\OrganizationSettings.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class  
OrganizationSettings !
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
OrganizationId 
{ 
get  #
;# $
set% (
;( )
}* +
public 

string 
? 
Description 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

string 

JoinPolicy 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
$str- 3
;3 4
public		 

int		 
?		 
DefaultOrgRoleId		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
public

 

Organization

 
Organization

 $
{

% &
get

' *
;

* +
set

, /
;

/ 0
}

1 2
=

3 4
null

5 9
!

9 :
;

: ;
public 

OrganizationRole 
? 
DefaultOrgRole +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
} Ô	
sC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\OrganizationRolePermission.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class &
OrganizationRolePermission '
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
	OrgRoleId 
{ 
get 
; 
set  #
;# $
}% &
public 

int 
PermissionId 
{ 
get !
;! "
set# &
;& '
}( )
public 

OrganizationRole 
Role  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
null1 5
!5 6
;6 7
public		 


Permission		 

Permission		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
=		/ 0
null		1 5
!		5 6
;		6 7
}

 ù
iC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\OrganizationRole.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
OrganizationRole 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
=% &
null' +
!+ ,
;, -
public 

string 
? 
DisplayName 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

int 
? 
OrganizationId 
{  
get! $
;$ %
set& )
;) *
}+ ,
public

 

int

 
Priority

 
{

 
get

 
;

 
set

 "
;

" #
}

$ %
public 

bool 

IsArchived 
{ 
get  
;  !
set" %
;% &
}' (
public 

Organization 
? 
Organization %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
public 

ICollection 
< &
OrganizationRolePermission 1
>1 2
RolePermissions3 B
{C D
getE H
;H I
setJ M
;M N
}O P
=Q R
newS V
ListW [
<[ \&
OrganizationRolePermission\ v
>v w
(w x
)x y
;y z
public 

ICollection 
<  
UserRoleOrganization +
>+ ,
OrganizationMembers- @
{A B
getC F
;F G
setH K
;K L
}M N
=O P
newQ T
ListU Y
<Y Z 
UserRoleOrganizationZ n
>n o
(o p
)p q
;q r
} å
pC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\OrganizationJoinRequest.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class #
OrganizationJoinRequest $
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
UserId 
{ 
get 
; 
set  
;  !
}" #
public 

int 
OrganizationId 
{ 
get  #
;# $
set% (
;( )
}* +
public 

string 
? 
Message 
{ 
get  
;  !
set" %
;% &
}' (
public		 

string		 
Status		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
=		' (
null		) -
!		- .
;		. /
public

 

DateTime

 
	CreatedAt

 
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
* +
public 

int 
? 
ReviewedByUserId  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

DateTime 
? 

ReviewedAt 
{  !
get" %
;% &
set' *
;* +
}, -
public 

User 
User 
{ 
get 
; 
set 
;  
}! "
=# $
null% )
!) *
;* +
public 

Organization 
Organization $
{% &
get' *
;* +
set, /
;/ 0
}1 2
=3 4
null5 9
!9 :
;: ;
public 

User 
? 

ReviewedBy 
{ 
get !
;! "
set# &
;& '
}( )
} Æ
oC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\OrganizationInvitation.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class "
OrganizationInvitation #
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
OrganizationId 
{ 
get  #
;# $
set% (
;( )
}* +
public 

string 
Email 
{ 
get 
; 
set "
;" #
}$ %
=& '
null( ,
!, -
;- .
public 

int 
	OrgRoleId 
{ 
get 
; 
set  #
;# $
}% &
public		 

int		 
InvitedByUserId		 
{		  
get		! $
;		$ %
set		& )
;		) *
}		+ ,
public

 

string

 
Token

 
{

 
get

 
;

 
set

 "
;

" #
}

$ %
=

& '
null

( ,
!

, -
;

- .
public 

string 
Status 
{ 
get 
; 
set  #
;# $
}% &
=' (
null) -
!- .
;. /
public 

DateTime 
	CreatedAt 
{ 
get  #
;# $
set% (
;( )
}* +
public 

DateTime 
	ExpiresAt 
{ 
get  #
;# $
set% (
;( )
}* +
public 

Organization 
Organization $
{% &
get' *
;* +
set, /
;/ 0
}1 2
=3 4
null5 9
!9 :
;: ;
public 

OrganizationRole 
Role  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
null1 5
!5 6
;6 7
public 

User 
	InvitedBy 
{ 
get 
;  
set! $
;$ %
}& '
=( )
null* .
!. /
;/ 0
} ˜
eC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\Organization.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
Organization 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
=% &
null' +
!+ ,
;, -
public 

bool 

IsArchived 
{ 
get  
;  !
set" %
;% &
}' (
public 

ICollection 
<  
UserRoleOrganization +
>+ ,
Members- 4
{5 6
get7 :
;: ;
set< ?
;? @
}A B
=C D
newE H
ListI M
<M N 
UserRoleOrganizationN b
>b c
(c d
)d e
;e f
public		 

ICollection		 
<		 
OrganizationRole		 '
>		' (
Roles		) .
{		/ 0
get		1 4
;		4 5
set		6 9
;		9 :
}		; <
=		= >
new		? B
List		C G
<		G H
OrganizationRole		H X
>		X Y
(		Y Z
)		Z [
;		[ \
public

 

ICollection

 
<

 #
OrganizationJoinRequest

 .
>

. /
JoinRequests

0 <
{

= >
get

? B
;

B C
set

D G
;

G H
}

I J
=

K L
new

M P
List

Q U
<

U V#
OrganizationJoinRequest

V m
>

m n
(

n o
)

o p
;

p q
public 

ICollection 
< "
OrganizationInvitation -
>- .
Invitations/ :
{; <
get= @
;@ A
setB E
;E F
}G H
=I J
newK N
ListO S
<S T"
OrganizationInvitationT j
>j k
(k l
)l m
;m n
public 

ICollection 
< 
	Workspace  
>  !

Workspaces" ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
=; <
new= @
ListA E
<E F
	WorkspaceF O
>O P
(P Q
)Q R
;R S
public 
 
OrganizationSettings 
?  
Settings! )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
} Õ	
hC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\EntityWorkspace.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
EntityWorkspace 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
EntityId 
{ 
get 
; 
set "
;" #
}$ %
public 

int 
WorkspaceId 
{ 
get  
;  !
set" %
;% &
}' (
public 

Entity 
Entity 
{ 
get 
; 
set  #
;# $
}% &
=' (
null) -
!- .
;. /
public		 

	Workspace		 
	Workspace		 
{		  
get		! $
;		$ %
set		& )
;		) *
}		+ ,
=		- .
null		/ 3
!		3 4
;		4 5
}

 Â	
kC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\EntityTypeProperty.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
EntityTypeProperty 
{ 
public 

int 
EntityTypeId 
{ 
get !
;! "
set# &
;& '
}( )
public 

int 

PropertyId 
{ 
get 
;  
set! $
;$ %
}& '
public 

bool 

IsRequired 
{ 
get  
;  !
set" %
;% &
}' (
public 


EntityType 

EntityType  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
null1 5
!5 6
;6 7
public		 

Property		 
Property		 
{		 
get		 "
;		" #
set		$ '
;		' (
}		) *
=		+ ,
null		- 1
!		1 2
;		2 3
}

 ª
cC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\EntityType.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 

EntityType 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
=% &
null' +
!+ ,
;, -
public 

string 
? 
DisplayName 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

bool 
IsStandalone 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
true- 1
;1 2
public		 

ICollection		 
<		 
Entity		 
>		 
Entities		 '
{		( )
get		* -
;		- .
set		/ 2
;		2 3
}		4 5
=		6 7
new		8 ;
List		< @
<		@ A
Entity		A G
>		G H
(		H I
)		I J
;		J K
public

 

ICollection

 
<

 
EntityTypeProperty

 )
>

) * 
EntityTypeProperties

+ ?
{

@ A
get

B E
;

E F
set

G J
;

J K
}

L M
=

N O
new

P S
List

T X
<

X Y
EntityTypeProperty

Y k
>

k l
(

l m
)

m n
;

n o
public 

ICollection 
< "
EntityRelationshipType -
>- .#
SourceRelationshipTypes/ F
{G H
getI L
;L M
setN Q
;Q R
}S T
=U V
newW Z
List[ _
<_ `"
EntityRelationshipType` v
>v w
(w x
)x y
;y z
public 

ICollection 
< "
EntityRelationshipType -
>- .#
TargetRelationshipTypes/ F
{G H
getI L
;L M
setN Q
;Q R
}S T
=U V
newW Z
List[ _
<_ `"
EntityRelationshipType` v
>v w
(w x
)x y
;y z
} œ
oC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\EntityRelationshipType.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class "
EntityRelationshipType #
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
=% &
null' +
!+ ,
;, -
public 

string 
? 
DisplayName 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

int 
SourceEntityTypeId !
{" #
get$ '
;' (
set) ,
;, -
}. /
public		 

int		 
TargetEntityTypeId		 !
{		" #
get		$ '
;		' (
set		) ,
;		, -
}		. /
public

 

bool

 

IsRequired

 
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
' (
public 
#
RelationshipCardinality "#
RelationshipCardinality# :
{; <
get= @
;@ A
setB E
;E F
}G H
=I J#
RelationshipCardinalityK b
.b c
	ManyToOnec l
;l m
public 


EntityType 
SourceEntityType &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
=5 6
null7 ;
!; <
;< =
public 


EntityType 
TargetEntityType &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
=5 6
null7 ;
!; <
;< =
public 

ICollection 
< 
EntityRelationship )
>) *
EntityRelationships+ >
{? @
getA D
;D E
setF I
;I J
}K L
=M N
newO R
ListS W
<W X
EntityRelationshipX j
>j k
(k l
)l m
;m n
} ¯
kC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\EntityRelationship.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
EntityRelationship 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
SourceEntityId 
{ 
get  #
;# $
set% (
;( )
}* +
public 

int 
TargetEntityId 
{ 
get  #
;# $
set% (
;( )
}* +
public 

int 
RelationshipTypeId !
{" #
get$ '
;' (
set) ,
;, -
}. /
public		 

Entity		 
SourceEntity		 
{		  
get		! $
;		$ %
set		& )
;		) *
}		+ ,
=		- .
null		/ 3
!		3 4
;		4 5
public

 

Entity

 
TargetEntity

 
{

  
get

! $
;

$ %
set

& )
;

) *
}

+ ,
=

- .
null

/ 3
!

3 4
;

4 5
public 
"
EntityRelationshipType !
RelationshipType" 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
=A B
nullC G
!G H
;H I
} ù
lC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\EntityPropertyValue.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
EntityPropertyValue  
{ 
public 

int 
EntityId 
{ 
get 
; 
set "
;" #
}$ %
public 

int 

PropertyId 
{ 
get 
;  
set! $
;$ %
}& '
public 

string 
? 
ValueString 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

int 
? 
ValueInt 
{ 
get 
; 
set  #
;# $
}% &
public		 

decimal		 
?		 
ValueDecimal		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
public

 

bool

 
?

 
	ValueBool

 
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
' (
public 

DateOnly 
? 
	ValueDate 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

Entity 
Entity 
{ 
get 
; 
set  #
;# $
}% &
=' (
null) -
!- .
;. /
public 

Property 
Property 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
null- 1
!1 2
;2 3
} ¸
_C:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\Entity.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
class 
Entity 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
EntityTypeId 
{ 
get !
;! "
set# &
;& '
}( )
public 

int 
CreatedByUserId 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

bool 

IsArchived 
{ 
get  
;  !
set" %
;% &
}' (
public		 


EntityType		 

EntityType		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
=		/ 0
null		1 5
!		5 6
;		6 7
public

 

User

 
CreatedByUser

 
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
, -
null

. 2
!

2 3
;

3 4
public 

ICollection 
< 
EntityWorkspace &
>& '
EntityWorkspaces( 8
{9 :
get; >
;> ?
set@ C
;C D
}E F
=G H
newI L
ListM Q
<Q R
EntityWorkspaceR a
>a b
(b c
)c d
;d e
public 

ICollection 
< 
EntityPropertyValue *
>* + 
EntityPropertyValues, @
{A B
getC F
;F G
setH K
;K L
}M N
=O P
newQ T
ListU Y
<Y Z
EntityPropertyValueZ m
>m n
(n o
)o p
;p q
public 

ICollection 
< 
EntityRelationship )
>) *
SourceRelationships+ >
{? @
getA D
;D E
setF I
;I J
}K L
=M N
newO R
ListS W
<W X
EntityRelationshipX j
>j k
(k l
)l m
;m n
public 

ICollection 
< 
EntityRelationship )
>) *
TargetRelationships+ >
{? @
getA D
;D E
setF I
;I J
}K L
=M N
newO R
ListS W
<W X
EntityRelationshipX j
>j k
(k l
)l m
;m n
} ¨
lC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\AuditProcessedEvent.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
sealed 
class 
AuditProcessedEvent '
{ 
public 

Guid 
EventId 
{ 
get 
; 
set "
;" #
}$ %
public 

DateTimeOffset 
ProcessedAtUtc (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
} •
kC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\AuditOutboxMessage.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
;' (
public 
sealed 
class 
AuditOutboxMessage &
{ 
public 

long 
Id 
{ 
get 
; 
set 
; 
}  
public 

Guid 
EventId 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
PayloadJson 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
null. 2
!2 3
;3 4
public 

string 

RoutingKey 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
null- 1
!1 2
;2 3
public		 

DateTimeOffset		 
OccurredAtUtc		 '
{		( )
get		* -
;		- .
set		/ 2
;		2 3
}		4 5
public

 

DateTimeOffset

 
CreatedAtUtc

 &
{

' (
get

) ,
;

, -
set

. 1
;

1 2
}

3 4
public 

DateTimeOffset 
? 
PublishedAtUtc )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
public 

int 
PublishAttempts 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

string 
? 
	LastError 
{ 
get "
;" #
set$ '
;' (
}) *
} Ä
tC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\AuditLogs\WorkspaceAuditLog.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
.' (
	AuditLogs( 1
;1 2
public 
class 
WorkspaceAuditLog 
:  
AuditLog! )
{ 
public 

int 
? 
WorkspaceId 
{ 
get !
;! "
set# &
;& '
}( )
public 

	Workspace 
? 
	Workspace 
{  !
get" %
;% &
set' *
;* +
}, -
} Û
oC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\AuditLogs\UserAuditLog.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
.' (
	AuditLogs( 1
;1 2
public 
class 
UserAuditLog 
: 
AuditLog $
{ 
public 

int 
? 
TargetUserId 
{ 
get "
;" #
set$ '
;' (
}) *
public 

User 
? 

TargetUser 
{ 
get !
;! "
set# &
;& '
}( )
} è
wC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\AuditLogs\OrganizationAuditLog.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
.' (
	AuditLogs( 1
;1 2
public 
class  
OrganizationAuditLog !
:" #
AuditLog$ ,
{ 
public 

int 
? 
OrganizationId 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

Organization 
? 
Organization %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
} û
qC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\AuditLogs\EntityAuditLog.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
.' (
	AuditLogs( 1
;1 2
public 
class 
EntityAuditLog 
: 
AuditLog &
{ 
public 

int 
? 
EntityId 
{ 
get 
; 
set  #
;# $
}% &
public 

Entity 
? 
Entity 
{ 
get 
;  
set! $
;$ %
}& '
public 

string 
? 

EntityType 
{ 
get  #
;# $
set% (
;( )
}* +
} ˙
kC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Entities\AuditLogs\AuditLog.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Entities '
.' (
	AuditLogs( 1
;1 2
public 
abstract 
class 
AuditLog 
{ 
public 

Guid 
Id 
{ 
get 
; 
set 
; 
}  
public 

string 
Action 
{ 
get 
; 
set  #
;# $
}% &
=' (
null) -
!- .
;. /
public		 

int		 
?		 
ChangedById		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
public

 

User

 
?

 
	ChangedBy

 
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
' (
public 

string 
? 
	FieldName 
{ 
get "
;" #
set$ '
;' (
}) *
public 

JsonDocument 
? 
OldValue !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 

JsonDocument 
? 
NewValue !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 

DateTimeOffset 
	ChangedAt #
{$ %
get& )
;) *
set+ .
;. /
}0 1
} ∫
{C:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Contracts\WorkspaceSettingsUpdatedPayloadV1.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
	Contracts (
;( )
public 
sealed 
record -
!WorkspaceSettingsUpdatedPayloadV1 6
(6 7
int 
WorkspaceId 
, 
int 
OrganizationId 
, 
int 
ActorUserId 
) 
; ©
uC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Contracts\WorkspaceLifecyclePayloadV1.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
	Contracts (
;( )
public 
sealed 
record '
WorkspaceLifecyclePayloadV1 0
(0 1
string 

Action 
, 
int 
WorkspaceId 
, 
int 
OrganizationId 
, 
int 
ActorUserId 
, 
string 

?
 
Name 
) 
; á
~C:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Contracts\OrganizationSettingsUpdatedPayloadV1.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
	Contracts (
;( )
public 
sealed 
record 0
$OrganizationSettingsUpdatedPayloadV1 9
(9 :
int 
OrganizationId 
, 
int 
ActorUserId 
) 
; ∂
jC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Contracts\MlScoringRouting.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
	Contracts (
;( )
public 
static 
class 
MlScoringRouting $
{ 
public 

const 
string 
ExchangeName $
=* +
$str, ?
;? @
public 

const 
string 
CommandQueueName (
=* +
$str, G
;G H
public 

const 
string 
CommandRoutingKey )
=* +
$str, A
;A B
public 

const 
string 
DlxName 
=) *
$str+ B
;B C
public		 

const		 
string		 
DlqName		 
=		) *
$str		+ M
;		M N
}

 
public 
sealed 
record 
MlScoreRpcRequestV1 (
(( )
IReadOnlyList) 6
<6 7
int7 :
>: ;
	EntityIds< E
)E F
;F G
public 
sealed 
record 
MlScoreRpcItemV1 %
(% &
int 
EntityId 
, 
double 

?
 
ClosureScore 
, 
double 

?
 

ChurnScore 
, 
string 

?
 
UnavailableReason 
) 
; 
public 
sealed 
record 
MlScoreRpcReplyV1 &
(& '
IReadOnlyList 
< 
MlScoreRpcItemV1 "
>" #
Scores$ *
,* +
string 

?
 
ErrorMessage 
) 
; π
xC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Contracts\MlRecalculateProgressPayloadV1.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
	Contracts (
;( )
public 
sealed 
record *
MlRecalculateProgressPayloadV1 3
(3 4
Guid 
JobId	 
, 
int 
? 
WorkspaceId	 
, 
string 

Status 
, 
int 
ProcessedCount 
, 
int 

TotalCount 
, 
DateTimeOffset		 
UpdatedAtUtc		 
,		  
string

 

?


 
Message

 
)

 
;

 Â
xC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Contracts\MlRecalculateEnqueuedPayloadV1.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
	Contracts (
;( )
public 
sealed 
record *
MlRecalculateEnqueuedPayloadV1 3
(3 4
Guid 
JobId	 
, 
int 
? 
WorkspaceId	 
, 
int 
RequestedByUserId 
, 
DateTimeOffset 
RequestedAtUtc !
,! "
string 

Scope 
, 
IReadOnlyList		 
<		 
int		 
>		 
	EntityIds		  
,		  !
string

 

Reason

 
)

 
;

 Ω
yC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Contracts\MlRecalculateCompletedPayloadV1.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
	Contracts (
;( )
public 
sealed 
record +
MlRecalculateCompletedPayloadV1 4
(4 5
Guid 
JobId	 
, 
int 
? 
WorkspaceId	 
, 
string 

Status 
, 
int 
ProcessedCount 
, 
int 
SucceededCount 
, 
int		 
FailedCount		 
,		 
DateTimeOffset

 
StartedAtUtc

 
,

  
DateTimeOffset 
CompletedAtUtc !
,! "
string 

?
 
Error 
) 
; Î
qC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Contracts\MessagingSchemaVersions.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
	Contracts (
;( )
public 
static 
class #
MessagingSchemaVersions +
{ 
public 

const 
int 
V1 
= 
$num 
; 
} ¸
gC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Contracts\IOutboxWriter.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
	Contracts (
;( )
public 
	interface 
IOutboxWriter 
{ 
Task 
EnqueueAuditAsync	 
( 
AuditEventContract -

auditEvent. 8
,8 9
CancellationToken: K
ctL N
=O P
defaultQ X
)X Y
;Y Z
Task		 
EnqueueDomainAsync			 
(		 
string		 "

routingKey		# -
,		- .!
DomainMessageEnvelope		/ D
envelope		E M
,		M N
CancellationToken		O `
ct		a c
=		d e
default		f m
)		m n
;		n o
}

 ˛

lC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Contracts\EntityGraphRouting.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
	Contracts (
;( )
public 
static 
class 
EntityGraphRouting &
{ 
public 

const 
string 
CommandQueueName (
=) *
$str+ E
;E F
public		 

const		 
string		 
ExchangeName		 $
=		% &
$str		' >
;		> ?
public

 

const

 
string

 
CommandRoutingKey

 )
=

* +
$str

, A
;

A B
} 
public 
sealed 
record "
EntityGraphCreateRpcV1 +
(+ ,
int 
WorkspaceId 
, 
int 
UserId 
, 
string 

CreateEntityJson 
) 
; 
public 
sealed 
record '
EntityGraphCreateRpcReplyV1 0
(0 1
bool 
Success	 
, 
string 

?
 
ErrorMessage 
, 
string 

?
 
EntityDetailJson 
) 
; Í
xC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Contracts\EntityAnalysisRefreshPayloadV1.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
	Contracts (
;( )
public 
sealed 
record *
EntityAnalysisRefreshPayloadV1 3
(3 4
int 
EntityId 
, 
int 
EntityTypeId 
, 
int 
WorkspaceId 
, 
int 
ActorUserId 
, 
string 

Action 
, 
DateTimeOffset		 
SourceUpdatedAtUtc		 %
)		% &
;		& 'Í$
gC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Contracts\DomainRouting.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
	Contracts (
;( )
public 
static 
class 
DomainRouting !
{ 
public 

const 
string 
ExchangeName $
=% &
$str' 8
;8 9
public 

const 
string $
CoreWorkspaceVerbCreated 0
=1 2
$str3 <
;< =
public 

const 
string $
CoreWorkspaceVerbUpdated 0
=1 2
$str3 <
;< =
public		 

const		 
string		 %
CoreWorkspaceVerbArchived		 1
=		2 3
$str		4 >
;		> ?
public

 

const

 
string

 ,
 CoreWorkspaceVerbSettingsUpdated

 8
=

9 :
$str

; M
;

M N
public 

const 
string /
#CoreOrganizationVerbSettingsUpdated ;
=< =
$str> P
;P Q
public 

const 
string !
CoreEntityVerbChanged -
=. /
$str0 9
;9 :
public 

const 
string %
MlRecalculateVerbEnqueued 1
=2 3
$str4 >
;> ?
public 

const 
string %
MlRecalculateVerbProgress 1
=2 3
$str4 >
;> ?
public 

const 
string &
MlRecalculateVerbCompleted 2
=3 4
$str5 @
;@ A
public 

static 
string #
RoutingKeyCoreWorkspace 0
(0 1
string1 7
verb8 <
)< =
=>> @
verb 
is 
null 
? 
throw 
new  !
ArgumentNullException! 6
(6 7
nameof7 =
(= >
verb> B
)B C
)C D
: 	
$"
 
{ 
BoundedContext 
. 
Core  
}  !
$str! ,
{, -
verb- 1
}1 2
"2 3
;3 4
public 

static 
string &
RoutingKeyCoreOrganization 3
(3 4
string4 :
verb; ?
)? @
=>A C
verb 
is 
null 
? 
throw 
new  !
ArgumentNullException! 6
(6 7
nameof7 =
(= >
verb> B
)B C
)C D
: 	
$"
 
{ 
BoundedContext 
. 
Core  
}  !
$str! /
{/ 0
verb0 4
}4 5
"5 6
;6 7
public 

static 
string  
RoutingKeyCoreEntity -
(- .
string. 4
verb5 9
)9 :
=>; =
verb 
is 
null 
? 
throw 
new  !
ArgumentNullException! 6
(6 7
nameof7 =
(= >
verb> B
)B C
)C D
: 	
$"
 
{ 
BoundedContext 
. 
Core  
}  !
$str! )
{) *
verb* .
}. /
"/ 0
;0 1
public 

static 
string #
RoutingKeyMlRecalculate 0
(0 1
string1 7
verb8 <
)< =
=>> @
verb 
is 
null 
? 
throw 
new  !
ArgumentNullException! 6
(6 7
nameof7 =
(= >
verb> B
)B C
)C D
: 	
$"
 
{ 
BoundedContext 
. 
Ml 
} 
$str ,
{, -
verb- 1
}1 2
"2 3
;3 4
private!! 
static!! 
class!! 
BoundedContext!! '
{"" 
public## 
const## 
string## 
Core##  
=##! "
$str### )
;##) *
public$$ 
const$$ 
string$$ 
Ml$$ 
=$$  
$str$$! %
;$$% &
}%% 
}&& ‡

lC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Contracts\DomainPayloadTypes.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
	Contracts (
;( )
public 
static 
class 
DomainPayloadTypes &
{ 
public 

const 
string  
WorkspaceLifecycleV1 ,
=- .
$str/ W
;W X
public 

const 
string &
WorkspaceSettingsUpdatedV1 2
=3 4
$str5 d
;d e
public 

const 
string )
OrganizationSettingsUpdatedV1 5
=6 7
$str8 j
;j k
public 

const 
string #
EntityAnalysisRefreshV1 /
=0 1
$str2 ^
;^ _
public		 

const		 
string		 #
MlRecalculateEnqueuedV1		 /
=		0 1
$str		2 ^
;		^ _
public

 

const

 
string

 #
MlRecalculateProgressV1

 /
=

0 1
$str

2 ^
;

^ _
public 

const 
string $
MlRecalculateCompletedV1 0
=1 2
$str3 `
;` a
} ∏
oC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Contracts\DomainMessageEnvelope.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
	Contracts (
;( )
public 
sealed 
record !
DomainMessageEnvelope *
(* +
int 
SchemaVersion 
, 
Guid 
	MessageId	 
, 
Guid 
CorrelationId	 
, 
Guid 
? 	
SagaInstanceId
 
, 
Guid 
? 	
CausationId
 
, 
DateTimeOffset		 
OccurredAtUtc		  
,		  !
string

 

SourceService

 
,

 
string 

PayloadTypeName 
, 
string 

PayloadJson 
) 
; î
lC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Contracts\AuditEventContract.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
	Contracts (
;( )
public 
static 
class 
AuditRouting  
{ 
public 

const 
string 
ExchangeName $
=% &
$str' 5
;5 6
public 

const 
string 
ScopeEntity #
=$ %
$str& .
;. /
public 

const 
string 
ScopeWorkspace &
=' (
$str) 4
;4 5
public		 

const		 
string		 
ScopeOrganization		 )
=		* +
$str		, :
;		: ;
public

 

const

 
string

 
	ScopeUser

 !
=

" #
$str

$ *
;

* +
} 
public 
sealed 
record 
AuditEventContract '
(' (
Guid 
EventId	 
, 
int 
SchemaVersion 
, 
DateTimeOffset 
OccurredAtUtc  
,  !
string 

SourceService 
, 
int 
? 
ActorUserId	 
, 
string 


AuditScope 
, 
int 
? 
TargetId	 
, 
string 

Action 
, 
string 

?
 
	FieldName 
, 
string 

?
 

EntityType 
, 
string 

?
 
OldValueJson 
, 
string 

?
 
NewValueJson 
) 
; Ü*
}C:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\WorkspaceSettingsConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class *
WorkspaceSettingsConfiguration +
:, -$
IEntityTypeConfiguration. F
<F G
WorkspaceSettingsG X
>X Y
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
WorkspaceSettings		, =
>		= >
builder		? F
)		F G
{

 
builder 
. 
ToTable 
( 
$str ,
,, -
t. /
=>0 2
{ 	
t 
. 
HasCheckConstraint  
(  !
$str! B
,B C
$strD o
)o p
;p q
t 
. 
HasCheckConstraint  
(  !
$str! D
,D E
$str	F £
)
£ §
;
§ •
} 	
)	 

;
 
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
WorkspaceId  +
)+ ,
., -
HasColumnName- :
(: ;
$str; I
)I J
.J K

IsRequiredK U
(U V
)V W
;W X
builder 
. 
Property 
( 
e 
=> 
e 
.  
HighRiskThreshold  1
)1 2
. 
HasColumnName 
( 
$str 0
)0 1
. 
HasColumnType 
( 
$str )
)) *
. 
HasDefaultValue 
( 
$num !
)! "
. 
ValueGeneratedNever  
(  !
)! "
. 

IsRequired 
( 
) 
; 
builder 
. 
Property 
( 
e 
=> 
e 
.  
MediumRiskThreshold  3
)3 4
. 
HasColumnName 
( 
$str 2
)2 3
. 
HasColumnType 
( 
$str )
)) *
. 
HasDefaultValue 
( 
$num !
)! "
. 
ValueGeneratedNever  
(  !
)! "
. 

IsRequired 
( 
) 
; 
builder 
. 
Property 
( 
e 
=> 
e 
.  
Description  +
)+ ,
.   
HasColumnName   
(   
$str   (
)  ( )
.!! 
HasMaxLength!! 
(!! 
$num!! 
)!! 
."" 

IsRequired"" 
("" 
false"" 
)"" 
;"" 
builder## 
.## 
Property## 
(## 
e## 
=>## 
e## 
.##  
RiskScoringEnabled##  2
)##2 3
.$$ 
HasColumnName$$ 
($$ 
$str$$ 1
)$$1 2
.%% 
HasDefaultValue%% 
(%% 
true%% !
)%%! "
.&& 

IsRequired&& 
(&& 
)&& 
;&& 
builder'' 
.'' 
HasIndex'' 
('' 
e'' 
=>'' 
e'' 
.''  
WorkspaceId''  +
)''+ ,
.(( 
IsUnique(( 
((( 
)(( 
.)) 
HasDatabaseName)) 
()) 
$str)) A
)))A B
;))B C
builder** 
.** 
HasOne** 
(** 
e** 
=>** 
e** 
.** 
	Workspace** '
)**' (
.++ 
WithOne++ 
(++ 
w++ 
=>++ 
w++ 
.++ 
WorkspaceSettings++ -
)++- .
.,, 
HasForeignKey,, 
<,, 
WorkspaceSettings,, ,
>,,, -
(,,- .
e,,. /
=>,,0 2
e,,3 4
.,,4 5
WorkspaceId,,5 @
),,@ A
.-- 
OnDelete-- 
(-- 
DeleteBehavior-- $
.--$ %
Cascade--% ,
)--, -
... 
HasConstraintName.. 
(.. 
$str.. @
)..@ A
;..A B
}// 
}00 ’
ÉC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\WorkspaceRolePermissionConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class 0
$WorkspaceRolePermissionConfiguration 1
:2 3$
IEntityTypeConfiguration4 L
<L M#
WorkspaceRolePermissionM d
>d e
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,#
WorkspaceRolePermission		, C
>		C D
builder		E L
)		L M
{

 
builder 
. 
ToTable 
( 
$str 4
)4 5
;5 6
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
WsRoleId  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 D
)D E
.E F

IsRequiredF P
(P Q
)Q R
;R S
builder 
. 
Property 
( 
e 
=> 
e 
.  
PermissionId  ,
), -
.- .
HasColumnName. ;
(; <
$str< K
)K L
.L M

IsRequiredM W
(W X
)X Y
;Y Z
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
Role "
)" #
. 
WithMany 
( 
r 
=> 
r 
. 
RolePermissions ,
), -
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
WsRoleId" *
)* +
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str -
)- .
;. /
builder 
. 
HasOne 
( 
e 
=> 
e 
. 

Permission (
)( )
. 
WithMany 
( 
p 
=> 
p 
. $
WorkspaceRolePermissions 5
)5 6
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
PermissionId" .
). /
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str 3
)3 4
;4 5
} 
} ﬁ!
yC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\WorkspaceRoleConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class &
WorkspaceRoleConfiguration '
:( )$
IEntityTypeConfiguration* B
<B C
WorkspaceRoleC P
>P Q
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
WorkspaceRole		, 9
>		9 :
builder		; B
)		B C
{

 
builder 
. 
ToTable 
( 
$str )
)) *
;* +
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
Name  $
)$ %
.% &
HasColumnName& 3
(3 4
$str4 :
): ;
.; <

IsRequired< F
(F G
)G H
;H I
builder 
. 
Property 
( 
e 
=> 
e 
.  
DisplayName  +
)+ ,
., -
HasColumnName- :
(: ;
$str; I
)I J
.J K
HasMaxLengthK W
(W X
$numX [
)[ \
;\ ]
builder 
. 
Property 
( 
e 
=> 
e 
.  
WorkspaceId  +
)+ ,
., -
HasColumnName- :
(: ;
$str; I
)I J
.J K

IsRequiredK U
(U V
falseV [
)[ \
;\ ]
builder 
. 
Property 
( 
e 
=> 
e 
.  
Priority  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 B
)B C
.C D

IsRequiredD N
(N O
)O P
;P Q
builder 
. 
HasIndex 
( 
e 
=> 
new !
{" #
e$ %
.% &
Name& *
,* +
e, -
.- .
WorkspaceId. 9
}: ;
); <
. 
IsUnique 
( 
) 
. 
HasDatabaseName 
( 
$str @
)@ A
;A B
builder 
. 
Property 
( 
e 
=> 
e 
.  

IsArchived  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I
HasDefaultValueI X
(X Y
falseY ^
)^ _
;_ `
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
	Workspace '
)' (
. 
WithMany 
( 
w 
=> 
w 
. 
Roles "
)" #
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
WorkspaceId" -
)- .
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str 6
)6 7
;7 8
} 
} ñ 
uC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\WorkspaceConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class "
WorkspaceConfiguration #
:$ %$
IEntityTypeConfiguration& >
<> ?
	Workspace? H
>H I
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
	Workspace		, 5
>		5 6
builder		7 >
)		> ?
{

 
builder 
. 
ToTable 
( 
$str $
)$ %
;% &
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
Name  $
)$ %
.% &
HasColumnName& 3
(3 4
$str4 :
): ;
.; <

IsRequired< F
(F G
)G H
;H I
builder 
. 
Property 
( 
e 
=> 
e 
.  
OrganizationId  .
). /
./ 0
HasColumnName0 =
(= >
$str> O
)O P
.P Q

IsRequiredQ [
([ \
)\ ]
;] ^
builder 
. 
Property 
( 
e 
=> 
e 
.  
CreatedByUserId  /
)/ 0
.0 1
HasColumnName1 >
(> ?
$str? S
)S T
.T U

IsRequiredU _
(_ `
)` a
;a b
builder 
. 
Property 
( 
e 
=> 
e 
.  

IsArchived  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I
HasDefaultValueI X
(X Y
falseY ^
)^ _
;_ `
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
Organization *
)* +
. 
WithMany 
( 
o 
=> 
o 
. 

Workspaces '
)' (
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
OrganizationId" 0
)0 1
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str ;
); <
;< =
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
	CreatedBy '
)' (
. 
WithMany 
( 
) 
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
CreatedByUserId" 1
)1 2
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Restrict% -
)- .
. 
HasConstraintName 
( 
$str 9
)9 :
;: ;
} 
} ˙
xC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\UserSettingsConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class %
UserSettingsConfiguration &
:' ($
IEntityTypeConfiguration) A
<A B
UserSettingsB N
>N O
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
UserSettings		, 8
>		8 9
builder		: A
)		A B
{

 
builder 
. 
ToTable 
( 
$str '
)' (
;( )
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
UserId  &
)& '
.' (
HasColumnName( 5
(5 6
$str6 ?
)? @
.@ A

IsRequiredA K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
Locale  &
)& '
. 
HasColumnName 
( 
$str #
)# $
. 
HasMaxLength 
( 
$num 
) 
. 
HasDefaultValue 
( 
$str !
)! "
. 

IsRequired 
( 
) 
; 
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
UserId  &
)& '
. 
IsUnique 
( 
) 
. 
HasDatabaseName 
( 
$str 7
)7 8
;8 9
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
User "
)" #
. 
WithOne 
( 
u 
=> 
u 
. 
Settings $
)$ %
. 
HasForeignKey 
< 
UserSettings '
>' (
(( )
e) *
=>+ -
e. /
./ 0
UserId0 6
)6 7
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str 6
)6 7
;7 8
} 
} ˆ/
}C:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\UserRoleWorkspaceConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class *
UserRoleWorkspaceConfiguration +
:, -$
IEntityTypeConfiguration. F
<F G
UserRoleWorkspaceG X
>X Y
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
UserRoleWorkspace		, =
>		= >
builder		? F
)		F G
{

 
builder 
. 
ToTable 
( 
$str -
)- .
;. /
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
UserId  &
)& '
.' (
HasColumnName( 5
(5 6
$str6 ?
)? @
.@ A

IsRequiredA K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
WorkspaceId  +
)+ ,
., -
HasColumnName- :
(: ;
$str; I
)I J
.J K

IsRequiredK U
(U V
)V W
;W X
builder 
. 
Property 
( 
e 
=> 
e 
.  
WsRoleId  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 D
)D E
.E F

IsRequiredF P
(P Q
)Q R
;R S
builder 
. 
Property 
( 
e 
=> 
e 
.  
JoinedAt  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
.D E

IsRequiredE O
(O P
)P Q
;Q R
builder 
. 
Property 
( 
e 
=> 
e 
.  

IsArchived  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I
HasDefaultValueI X
(X Y
falseY ^
)^ _
;_ `
builder 
. 
HasIndex 
( 
e 
=> 
new !
{" #
e$ %
.% &
UserId& ,
,, -
e. /
./ 0
WorkspaceId0 ;
}< =
)= >
. 
IsUnique 
( 
) 
. 
HasDatabaseName 
( 
$str =
)= >
;> ?
builder 
. 
HasIndex 
( 
e 
=> 
new !
{" #
e$ %
.% &
WorkspaceId& 1
,1 2
e3 4
.4 5

IsArchived5 ?
}@ A
)A B
. 
HasDatabaseName 
( 
$str 6
)6 7
;7 8
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
User "
)" #
. 
WithMany 
( 
u 
=> 
u 
.  
WorkspaceMemberships 1
)1 2
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
UserId" (
)( )
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str ,
), -
;- .
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
	Workspace '
)' (
. 
WithMany 
( 
w 
=> 
w 
. 
Members $
)$ %
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
WorkspaceId" -
)- .
.   
OnDelete   
(   
DeleteBehavior   $
.  $ %
Cascade  % ,
)  , -
.!! 
HasConstraintName!! 
(!! 
$str!! 1
)!!1 2
;!!2 3
builder"" 
."" 
HasOne"" 
("" 
e"" 
=>"" 
e"" 
."" 
Role"" "
)""" #
.## 
WithMany## 
(## 
r## 
=>## 
r## 
.## 
WorkspaceMembers## -
)##- .
.$$ 
HasForeignKey$$ 
($$ 
e$$ 
=>$$ 
e$$  !
.$$! "
WsRoleId$$" *
)$$* +
.%% 
OnDelete%% 
(%% 
DeleteBehavior%% $
.%%$ %
Restrict%%% -
)%%- .
.&& 
HasConstraintName&& 
(&& 
$str&& ,
)&&, -
;&&- .
}'' 
}(( ö0
ÄC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\UserRoleOrganizationConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class -
!UserRoleOrganizationConfiguration .
:/ 0$
IEntityTypeConfiguration1 I
<I J 
UserRoleOrganizationJ ^
>^ _
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ , 
UserRoleOrganization		, @
>		@ A
builder		B I
)		I J
{

 
builder 
. 
ToTable 
( 
$str 0
)0 1
;1 2
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
UserId  &
)& '
.' (
HasColumnName( 5
(5 6
$str6 ?
)? @
.@ A

IsRequiredA K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
OrganizationId  .
). /
./ 0
HasColumnName0 =
(= >
$str> O
)O P
.P Q

IsRequiredQ [
([ \
)\ ]
;] ^
builder 
. 
Property 
( 
e 
=> 
e 
.  
	OrgRoleId  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 F
)F G
.G H

IsRequiredH R
(R S
)S T
;T U
builder 
. 
Property 
( 
e 
=> 
e 
.  
JoinedAt  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
.D E

IsRequiredE O
(O P
)P Q
;Q R
builder 
. 
Property 
( 
e 
=> 
e 
.  

IsArchived  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I
HasDefaultValueI X
(X Y
falseY ^
)^ _
;_ `
builder 
. 
HasIndex 
( 
e 
=> 
new !
{" #
e$ %
.% &
UserId& ,
,, -
e. /
./ 0
OrganizationId0 >
}? @
)@ A
. 
IsUnique 
( 
) 
. 
HasDatabaseName 
( 
$str 8
)8 9
;9 :
builder 
. 
HasIndex 
( 
e 
=> 
new !
{" #
e$ %
.% &
OrganizationId& 4
,4 5
e6 7
.7 8

IsArchived8 B
}C D
)D E
. 
HasDatabaseName 
( 
$str 0
)0 1
;1 2
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
User "
)" #
. 
WithMany 
( 
u 
=> 
u 
. #
OrganizationMemberships 4
)4 5
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
UserId" (
)( )
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str ,
), -
;- .
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
Organization *
)* +
. 
WithMany 
( 
o 
=> 
o 
. 
Members $
)$ %
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
OrganizationId" 0
)0 1
.   
OnDelete   
(   
DeleteBehavior   $
.  $ %
Cascade  % ,
)  , -
.!! 
HasConstraintName!! 
(!! 
$str!! 4
)!!4 5
;!!5 6
builder"" 
."" 
HasOne"" 
("" 
e"" 
=>"" 
e"" 
."" 
Role"" "
)""" #
.## 
WithMany## 
(## 
r## 
=>## 
r## 
.## 
OrganizationMembers## 0
)##0 1
.$$ 
HasForeignKey$$ 
($$ 
e$$ 
=>$$ 
e$$  !
.$$! "
	OrgRoleId$$" +
)$$+ ,
.%% 
OnDelete%% 
(%% 
DeleteBehavior%% $
.%%$ %
Restrict%%% -
)%%- .
.&& 
HasConstraintName&& 
(&& 
$str&& ,
)&&, -
;&&- .
}'' 
}(( Å 
}C:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\UserExternalLoginConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class *
UserExternalLoginConfiguration +
:, -$
IEntityTypeConfiguration. F
<F G
UserExternalLoginG X
>X Y
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
UserExternalLogin		, =
>		= >
builder		? F
)		F G
{

 
builder 
. 
ToTable 
( 
$str .
). /
;/ 0
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
UserId  &
)& '
.' (
HasColumnName( 5
(5 6
$str6 ?
)? @
.@ A

IsRequiredA K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
Provider  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 B
)B C
.C D
HasMaxLengthD P
(P Q
$numQ S
)S T
.T U

IsRequiredU _
(_ `
)` a
;a b
builder 
. 
Property 
( 
e 
=> 
e 
.  
Subject  '
)' (
.( )
HasColumnName) 6
(6 7
$str7 @
)@ A
.A B
HasMaxLengthB N
(N O
$numO R
)R S
.S T

IsRequiredT ^
(^ _
)_ `
;` a
builder 
. 
Property 
( 
e 
=> 
e 
.  
	CreatedAt  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
.F G

IsRequiredG Q
(Q R
)R S
;S T
builder 
. 
HasIndex 
( 
e 
=> 
new !
{" #
e$ %
.% &
Provider& .
,. /
e0 1
.1 2
Subject2 9
}: ;
); <
. 
IsUnique 
( 
) 
. 
HasDatabaseName 
( 
$str G
)G H
;H I
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
User "
)" #
. 
WithMany 
( 
u 
=> 
u 
. 
ExternalLogins +
)+ ,
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
UserId" (
)( )
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str =
)= >
;> ?
} 
} õ&
uC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\UserEmailConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class "
UserEmailConfiguration #
:$ %$
IEntityTypeConfiguration& >
<> ?
	UserEmail? H
>H I
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
	UserEmail		, 5
>		5 6
builder		7 >
)		> ?
{

 
builder 
. 
ToTable 
( 
$str %
)% &
;& '
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
UserId  &
)& '
.' (
HasColumnName( 5
(5 6
$str6 ?
)? @
.@ A

IsRequiredA K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
Address  '
)' (
.( )
HasColumnName) 6
(6 7
$str7 @
)@ A
.A B
HasMaxLengthB N
(N O
$numO R
)R S
.S T

IsRequiredT ^
(^ _
)_ `
;` a
builder 
. 
Property 
( 
e 
=> 
e 
.  

IsVerified  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I
HasDefaultValueI X
(X Y
falseY ^
)^ _
;_ `
builder 
. 
Property 
( 
e 
=> 
e 
.  
Source  &
)& '
.' (
HasColumnName( 5
(5 6
$str6 >
)> ?
.? @
HasMaxLength@ L
(L M
$numM O
)O P
.P Q

IsRequiredQ [
([ \
)\ ]
;] ^
builder 
. 
Property 
( 
e 
=> 
e 
.  
VerificationToken  1
)1 2
.2 3
HasColumnName3 @
(@ A
$strA U
)U V
;V W
builder 
. 
Property 
( 
e 
=> 
e 
.  &
VerificationTokenExpiresAt  :
): ;
.; <
HasColumnName< I
(I J
$strJ i
)i j
;j k
builder 
. 
Property 
( 
e 
=> 
e 
.  
	CreatedAt  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
.F G

IsRequiredG Q
(Q R
)R S
;S T
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
Address  '
)' (
.( )
IsUnique) 1
(1 2
)2 3
.3 4
HasDatabaseName4 C
(C D
$strD \
)\ ]
;] ^
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
User "
)" #
. 
WithMany 
( 
u 
=> 
u 
. 
Emails #
)# $
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
UserId" (
)( )
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str 4
)4 5
;5 6
} 
} —6
pC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\UserConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class 
UserConfiguration 
:  $
IEntityTypeConfiguration! 9
<9 :
User: >
>> ?
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
User		, 0
>		0 1
builder		2 9
)		9 :
{

 
builder 
. 
ToTable 
( 
$str 
)  
;  !
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
	FirstName  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
.F G

IsRequiredG Q
(Q R
)R S
;S T
builder 
. 
Property 
( 
e 
=> 
e 
.  
LastName  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
.D E

IsRequiredE O
(O P
)P Q
;Q R
builder 
. 
Property 
( 
e 
=> 
e 
.  
Email  %
)% &
.& '
HasColumnName' 4
(4 5
$str5 <
)< =
.= >

IsRequired> H
(H I
)I J
;J K
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
Email  %
)% &
. 
IsUnique 
( 
) 
. 
	HasFilter 
( 
$str 0
)0 1
;1 2
builder 
. 
Property 
( 
e 
=> 
e 
.  
Phone  %
)% &
.& '
HasColumnName' 4
(4 5
$str5 <
)< =
.= >
HasMaxLength> J
(J K
$numK M
)M N
;N O
builder 
. 
Property 
( 
e 
=> 
e 
.  
DateOfBirth  +
)+ ,
., -
HasColumnName- :
(: ;
$str; J
)J K
;K L
builder 
. 
Property 
( 
e 
=> 
e 
.  
Password  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 B
)B C
;C D
builder 
. 
Property 
( 
e 
=> 
e 
.  
	CreatedAt  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
.F G

IsRequiredG Q
(Q R
)R S
;S T
builder 
. 
Property 
( 
e 
=> 
e 
.  

IsArchived  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I
HasDefaultValueI X
(X Y
falseY ^
)^ _
;_ `
builder 
. 
Property 
( 
e 
=> 
e 
.  
PasswordResetToken  2
)2 3
.3 4
HasColumnName4 A
(A B
$strB X
)X Y
;Y Z
builder 
. 
Property 
( 
e 
=> 
e 
.  '
PasswordResetTokenExpiresAt  ;
); <
.< =
HasColumnName= J
(J K
$strK l
)l m
;m n
builder 
. 
Property 
( 
e 
=> 
e 
.  
EmailVerified  -
)- .
.. /
HasColumnName/ <
(< =
$str= M
)M N
.N O
HasDefaultValueO ^
(^ _
false_ d
)d e
;e f
builder 
. 
Property 
( 
e 
=> 
e 
.  "
EmailVerificationToken  6
)6 7
.7 8
HasColumnName8 E
(E F
$strF `
)` a
;a b
builder 
. 
Property 
( 
e 
=> 
e 
.  +
EmailVerificationTokenExpiresAt  ?
)? @
.@ A
HasColumnNameA N
(N O
$strO t
)t u
;u v
builder 
. 
Property 
( 
e 
=> 
e 
.  
TwoFactorEnabled  0
)0 1
.1 2
HasColumnName2 ?
(? @
$str@ T
)T U
.U V
HasDefaultValueV e
(e f
falsef k
)k l
;l m
builder 
. 
Property 
( 
e 
=> 
e 
.  
TwoFactorSecret  /
)/ 0
.0 1
HasColumnName1 >
(> ?
$str? R
)R S
.S T
HasMaxLengthT `
(` a
$numa d
)d e
;e f
builder   
.   
Property   
(   
e   
=>   
e   
.    #
TwoFactorMasterCodeHash    7
)  7 8
.  8 9
HasColumnName  9 F
(  F G
$str  G d
)  d e
.  e f
HasMaxLength  f r
(  r s
$num  s v
)  v w
;  w x
}!! 
}"" ù
zC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\UserBackupCodeConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class '
UserBackupCodeConfiguration (
:) *$
IEntityTypeConfiguration+ C
<C D
UserBackupCodeD R
>R S
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
UserBackupCode		, :
>		: ;
builder		< C
)		C D
{

 
builder 
. 
ToTable 
( 
$str +
)+ ,
;, -
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
UserId  &
)& '
.' (
HasColumnName( 5
(5 6
$str6 ?
)? @
.@ A

IsRequiredA K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
CodeHash  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
.D E
HasMaxLengthE Q
(Q R
$numR U
)U V
.V W

IsRequiredW a
(a b
)b c
;c d
builder 
. 
Property 
( 
e 
=> 
e 
.  
	CreatedAt  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
.F G

IsRequiredG Q
(Q R
)R S
;S T
builder 
. 
Property 
( 
e 
=> 
e 
.  
UsedAt  &
)& '
.' (
HasColumnName( 5
(5 6
$str6 ?
)? @
;@ A
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
UserId  &
)& '
.' (
HasDatabaseName( 7
(7 8
$str8 V
)V W
;W X
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
User "
)" #
. 
WithMany 
( 
u 
=> 
u 
. 
BackupCodes (
)( )
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
UserId" (
)( )
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str :
): ;
;; <
} 
} ˙
ÖC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\RabbitMqProcessedDeliveryConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
sealed 
class 2
&RabbitMqProcessedDeliveryConfiguration :
:; <$
IEntityTypeConfiguration= U
<U V%
RabbitMqProcessedDeliveryV o
>o p
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,%
RabbitMqProcessedDelivery		, E
>		E F
builder		G N
)		N O
{

 
builder 
. 
ToTable 
( 
$str 5
)5 6
;6 7
builder 
. 
HasKey 
( 
x 
=> 
new 
{  !
x" #
.# $
	MessageId$ -
,- .
x/ 0
.0 1
ConsumerGroup1 >
}? @
)@ A
;A B
builder 
. 
Property 
( 
x 
=> 
x 
.  
	MessageId  )
)) *
. 
HasColumnName 
( 
$str '
)' (
. 

IsRequired 
( 
) 
; 
builder 
. 
Property 
( 
x 
=> 
x 
.  
ConsumerGroup  -
)- .
. 
HasColumnName 
( 
$str +
)+ ,
. 
HasMaxLength 
( 
$num 
) 
. 

IsRequired 
( 
) 
; 
builder 
. 
Property 
( 
x 
=> 
x 
.  
ProcessedAtUtc  .
). /
. 
HasColumnName 
( 
$str -
)- .
. 
HasColumnType 
( 
$str (
)( )
. 

IsRequired 
( 
) 
; 
} 
} √
tC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\PropertyConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class !
PropertyConfiguration "
:# $$
IEntityTypeConfiguration% =
<= >
Property> F
>F G
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
Property		, 4
>		4 5
builder		6 =
)		= >
{

 
builder 
. 
ToTable 
( 
$str "
)" #
;# $
builder 
. 
HasKey 
( 
p 
=> 
p 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
p 
=> 
p 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
p 
=> 
p 
.  
Name  $
)$ %
.% &
HasColumnName& 3
(3 4
$str4 :
): ;
.; <

IsRequired< F
(F G
)G H
;H I
builder 
. 
Property 
( 
p 
=> 
p 
.  
DisplayName  +
)+ ,
., -
HasColumnName- :
(: ;
$str; I
)I J
.J K
HasMaxLengthK W
(W X
$numX [
)[ \
;\ ]
builder 
. 
Property 
( 
p 
=> 
p 
.  
DataType  (
)( )
. 
HasColumnName 
( 
$str &
)& '
. 
HasConversion 
< 
string !
>! "
(" #
)# $
. 

IsRequired 
( 
) 
; 
builder 
. 
Property 
( 
p 
=> 
p 
.  

IsReadonly  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I

IsRequiredI S
(S T
)T U
;U V
builder 
. 
Property 
( 
p 
=> 
p 
.  
OrganizationId  .
). /
./ 0
HasColumnName0 =
(= >
$str> O
)O P
;P Q
builder 
. 
HasOne 
( 
p 
=> 
p 
. 
Organization *
)* +
. 
WithMany 
( 
) 
. 
HasForeignKey 
( 
p 
=> 
p  !
.! "
OrganizationId" 0
)0 1
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str 9
)9 :
;: ;
} 
} »
ÄC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\PropertyAllowedValueConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class -
!PropertyAllowedValueConfiguration .
:/ 0$
IEntityTypeConfiguration1 I
<I J 
PropertyAllowedValueJ ^
>^ _
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ , 
PropertyAllowedValue		, @
>		@ A
builder		B I
)		I J
{

 
builder 
. 
ToTable 
( 
$str 0
)0 1
;1 2
builder 
. 
HasKey 
( 
pav 
=> 
new !
{" #
pav$ '
.' (

PropertyId( 2
,2 3
pav4 7
.7 8
Value8 =
}> ?
)? @
;@ A
builder 
. 
Property 
( 
pav 
=> 
pav  #
.# $

PropertyId$ .
). /
./ 0
HasColumnName0 =
(= >
$str> K
)K L
;L M
builder 
. 
Property 
( 
pav 
=> 
pav  #
.# $
Value$ )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 @
)@ A
.A B

IsRequiredB L
(L M
)M N
;N O
builder 
. 
Property 
( 
pav 
=> 
pav  #
.# $
DisplayName$ /
)/ 0
.0 1
HasColumnName1 >
(> ?
$str? M
)M N
.N O
HasMaxLengthO [
([ \
$num\ _
)_ `
;` a
builder 
. 
HasOne 
( 
pav 
=> 
pav !
.! "
Property" *
)* +
. 
WithMany 
( 
p 
=> 
p 
. 
AllowedValues *
)* +
. 
HasForeignKey 
( 
pav 
=> !
pav" %
.% &

PropertyId& 0
)0 1
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str C
)C D
;D E
} 
} Ó
vC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\PermissionConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class #
PermissionConfiguration $
:% &$
IEntityTypeConfiguration' ?
<? @

Permission@ J
>J K
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,

Permission		, 6
>		6 7
builder		8 ?
)		? @
{

 
builder 
. 
ToTable 
( 
$str %
)% &
;& '
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
Name  $
)$ %
.% &
HasColumnName& 3
(3 4
$str4 :
): ;
.; <

IsRequired< F
(F G
)G H
;H I
builder 
. 
Property 
( 
e 
=> 
e 
.  
DisplayName  +
)+ ,
., -
HasColumnName- :
(: ;
$str; I
)I J
.J K
HasMaxLengthK W
(W X
$numX [
)[ \
;\ ]
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
Name  $
)$ %
.% &
IsUnique& .
(. /
)/ 0
;0 1
builder 
. 
Property 
( 
e 
=> 
e 
.  

IsArchived  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I
HasDefaultValueI X
(X Y
falseY ^
)^ _
;_ `
} 
} Ú'
ÄC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\OrganizationSettingsConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class -
!OrganizationSettingsConfiguration .
:/ 0$
IEntityTypeConfiguration1 I
<I J 
OrganizationSettingsJ ^
>^ _
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ , 
OrganizationSettings		, @
>		@ A
builder		B I
)		I J
{

 
builder 
. 
ToTable 
( 
$str /
,/ 0
t1 2
=>3 5
{ 	
t 
. 
HasCheckConstraint  
(  !
$str! >
,> ?
$str@ h
)h i
;i j
} 	
)	 

;
 
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
OrganizationId  .
). /
./ 0
HasColumnName0 =
(= >
$str> O
)O P
.P Q

IsRequiredQ [
([ \
)\ ]
;] ^
builder 
. 
Property 
( 
e 
=> 
e 
.  
Description  +
)+ ,
. 
HasColumnName 
( 
$str (
)( )
. 
HasMaxLength 
( 
$num 
) 
. 

IsRequired 
( 
false 
) 
; 
builder 
. 
Property 
( 
e 
=> 
e 
.  

JoinPolicy  *
)* +
. 
HasColumnName 
( 
$str (
)( )
. 
HasMaxLength 
( 
$num 
) 
. 
HasDefaultValue 
( 
$str #
)# $
. 

IsRequired 
( 
) 
; 
builder 
. 
Property 
( 
e 
=> 
e 
.  
DefaultOrgRoleId  0
)0 1
. 
HasColumnName 
( 
$str 0
)0 1
. 

IsRequired 
( 
false 
) 
; 
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
OrganizationId  .
). /
. 
IsUnique 
( 
) 
.   
HasDatabaseName   
(   
$str   >
)  > ?
;  ? @
builder!! 
.!! 
HasOne!! 
(!! 
e!! 
=>!! 
e!! 
.!! 
Organization!! *
)!!* +
."" 
WithOne"" 
("" 
o"" 
=>"" 
o"" 
."" 
Settings"" $
)""$ %
.## 
HasForeignKey## 
<##  
OrganizationSettings## /
>##/ 0
(##0 1
e##1 2
=>##3 5
e##6 7
.##7 8
OrganizationId##8 F
)##F G
.$$ 
OnDelete$$ 
($$ 
DeleteBehavior$$ $
.$$$ %
Cascade$$% ,
)$$, -
.%% 
HasConstraintName%% 
(%% 
$str%% =
)%%= >
;%%> ?
builder&& 
.&& 
HasOne&& 
(&& 
e&& 
=>&& 
e&& 
.&& 
DefaultOrgRole&& ,
)&&, -
.'' 
WithMany'' 
('' 
)'' 
.(( 
HasForeignKey(( 
((( 
e(( 
=>(( 
e((  !
.((! "
DefaultOrgRoleId((" 2
)((2 3
.)) 
OnDelete)) 
()) 
DeleteBehavior)) $
.))$ %
SetNull))% ,
))), -
.** 
HasConstraintName** 
(** 
$str** A
)**A B
;**B C
}++ 
},, Ê
ÜC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\OrganizationRolePermissionConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class 3
'OrganizationRolePermissionConfiguration 4
:5 6$
IEntityTypeConfiguration7 O
<O P&
OrganizationRolePermissionP j
>j k
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,&
OrganizationRolePermission		, F
>		F G
builder		H O
)		O P
{

 
builder 
. 
ToTable 
( 
$str 7
)7 8
;8 9
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
	OrgRoleId  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 F
)F G
.G H

IsRequiredH R
(R S
)S T
;T U
builder 
. 
Property 
( 
e 
=> 
e 
.  
PermissionId  ,
), -
.- .
HasColumnName. ;
(; <
$str< K
)K L
.L M

IsRequiredM W
(W X
)X Y
;Y Z
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
Role "
)" #
. 
WithMany 
( 
r 
=> 
r 
. 
RolePermissions ,
), -
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
	OrgRoleId" +
)+ ,
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str ,
), -
;- .
builder 
. 
HasOne 
( 
e 
=> 
e 
. 

Permission (
)( )
. 
WithMany 
( 
p 
=> 
p 
. '
OrganizationRolePermissions 8
)8 9
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
PermissionId" .
). /
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str 2
)2 3
;3 4
} 
} ˆ!
|C:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\OrganizationRoleConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class )
OrganizationRoleConfiguration *
:+ ,$
IEntityTypeConfiguration- E
<E F
OrganizationRoleF V
>V W
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
OrganizationRole		, <
>		< =
builder		> E
)		E F
{

 
builder 
. 
ToTable 
( 
$str ,
), -
;- .
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
Name  $
)$ %
.% &
HasColumnName& 3
(3 4
$str4 :
): ;
.; <

IsRequired< F
(F G
)G H
;H I
builder 
. 
Property 
( 
e 
=> 
e 
.  
DisplayName  +
)+ ,
., -
HasColumnName- :
(: ;
$str; I
)I J
.J K
HasMaxLengthK W
(W X
$numX [
)[ \
;\ ]
builder 
. 
Property 
( 
e 
=> 
e 
.  
OrganizationId  .
). /
./ 0
HasColumnName0 =
(= >
$str> O
)O P
.P Q

IsRequiredQ [
([ \
false\ a
)a b
;b c
builder 
. 
Property 
( 
e 
=> 
e 
.  
Priority  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 B
)B C
.C D

IsRequiredD N
(N O
)O P
;P Q
builder 
. 
HasIndex 
( 
e 
=> 
new !
{" #
e$ %
.% &
Name& *
,* +
e, -
.- .
OrganizationId. <
}= >
)> ?
. 
IsUnique 
( 
) 
. 
HasDatabaseName 
( 
$str 4
)4 5
;5 6
builder 
. 
Property 
( 
e 
=> 
e 
.  

IsArchived  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I
HasDefaultValueI X
(X Y
falseY ^
)^ _
;_ `
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
Organization *
)* +
. 
WithMany 
( 
o 
=> 
o 
. 
Roles "
)" #
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
OrganizationId" 0
)0 1
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str :
): ;
;; <
} 
} ¯1
ÉC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\OrganizationJoinRequestConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class 0
$OrganizationJoinRequestConfiguration 1
:2 3$
IEntityTypeConfiguration4 L
<L M#
OrganizationJoinRequestM d
>d e
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,#
OrganizationJoinRequest		, C
>		C D
builder		E L
)		L M
{

 
builder 
. 
ToTable 
( 
$str 4
)4 5
;5 6
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
UserId  &
)& '
.' (
HasColumnName( 5
(5 6
$str6 ?
)? @
.@ A

IsRequiredA K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
OrganizationId  .
). /
./ 0
HasColumnName0 =
(= >
$str> O
)O P
.P Q

IsRequiredQ [
([ \
)\ ]
;] ^
builder 
. 
Property 
( 
e 
=> 
e 
.  
Message  '
)' (
.( )
HasColumnName) 6
(6 7
$str7 @
)@ A
;A B
builder 
. 
Property 
( 
e 
=> 
e 
.  
Status  &
)& '
.' (
HasColumnName( 5
(5 6
$str6 >
)> ?
.? @

IsRequired@ J
(J K
)K L
;L M
builder 
. 
Property 
( 
e 
=> 
e 
.  
	CreatedAt  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
.F G

IsRequiredG Q
(Q R
)R S
;S T
builder 
. 
Property 
( 
e 
=> 
e 
.  
ReviewedByUserId  0
)0 1
.1 2
HasColumnName2 ?
(? @
$str@ U
)U V
;V W
builder 
. 
Property 
( 
e 
=> 
e 
.  

ReviewedAt  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
;H I
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
User "
)" #
. 
WithMany 
( 
) 
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
UserId" (
)( )
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str ,
), -
;- .
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
Organization *
)* +
. 
WithMany 
( 
o 
=> 
o 
. 
JoinRequests )
)) *
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
OrganizationId" 0
)0 1
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str 4
)4 5
;5 6
builder 
. 
HasOne 
( 
e 
=> 
e 
. 

ReviewedBy (
)( )
.   
WithMany   
(   
)   
.!! 
HasForeignKey!! 
(!! 
e!! 
=>!! 
e!!  !
.!!! "
ReviewedByUserId!!" 2
)!!2 3
."" 
OnDelete"" 
("" 
DeleteBehavior"" $
.""$ %
SetNull""% ,
)"", -
.## 
HasConstraintName## 
(## 
$str## 3
)##3 4
;##4 5
builder$$ 
.$$ 
HasIndex$$ 
($$ 
e$$ 
=>$$ 
new$$ !
{$$" #
e$$$ %
.$$% &
OrganizationId$$& 4
,$$4 5
e$$6 7
.$$7 8
Status$$8 >
}$$? @
)$$@ A
.%% 
HasDatabaseName%% 
(%% 
$str%% 0
)%%0 1
;%%1 2
builder&& 
.&& 
HasIndex&& 
(&& 
e&& 
=>&& 
new&& !
{&&" #
e&&$ %
.&&% &
UserId&&& ,
,&&, -
e&&. /
.&&/ 0
Status&&0 6
}&&7 8
)&&8 9
.'' 
HasDatabaseName'' 
('' 
$str'' 1
)''1 2
;''2 3
}(( 
})) Ô8
ÇC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\OrganizationInvitationConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class /
#OrganizationInvitationConfiguration 0
:1 2$
IEntityTypeConfiguration3 K
<K L"
OrganizationInvitationL b
>b c
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,"
OrganizationInvitation		, B
>		B C
builder		D K
)		K L
{

 
builder 
. 
ToTable 
( 
$str 2
)2 3
;3 4
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
OrganizationId  .
). /
./ 0
HasColumnName0 =
(= >
$str> O
)O P
.P Q

IsRequiredQ [
([ \
)\ ]
;] ^
builder 
. 
Property 
( 
e 
=> 
e 
.  
Email  %
)% &
.& '
HasColumnName' 4
(4 5
$str5 <
)< =
.= >

IsRequired> H
(H I
)I J
;J K
builder 
. 
Property 
( 
e 
=> 
e 
.  
	OrgRoleId  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 F
)F G
.G H

IsRequiredH R
(R S
)S T
;T U
builder 
. 
Property 
( 
e 
=> 
e 
.  
InvitedByUserId  /
)/ 0
.0 1
HasColumnName1 >
(> ?
$str? S
)S T
.T U

IsRequiredU _
(_ `
)` a
;a b
builder 
. 
Property 
( 
e 
=> 
e 
.  
Token  %
)% &
.& '
HasColumnName' 4
(4 5
$str5 <
)< =
.= >

IsRequired> H
(H I
)I J
;J K
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
Token  %
)% &
. 
IsUnique 
( 
) 
. 
HasDatabaseName 
( 
$str 7
)7 8
;8 9
builder 
. 
HasIndex 
( 
e 
=> 
new !
{" #
e$ %
.% &
OrganizationId& 4
,4 5
e6 7
.7 8
Status8 >
}? @
)@ A
. 
HasDatabaseName 
( 
$str /
)/ 0
;0 1
builder 
. 
HasIndex 
( 
e 
=> 
new !
{" #
e$ %
.% &
Email& +
,+ ,
e- .
.. /
Status/ 5
}6 7
)7 8
. 
HasDatabaseName 
( 
$str 1
)1 2
;2 3
builder 
. 
Property 
( 
e 
=> 
e 
.  
Status  &
)& '
.' (
HasColumnName( 5
(5 6
$str6 >
)> ?
.? @

IsRequired@ J
(J K
)K L
;L M
builder 
. 
Property 
( 
e 
=> 
e 
.  
	CreatedAt  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
.F G

IsRequiredG Q
(Q R
)R S
;S T
builder 
. 
Property 
( 
e 
=> 
e 
.  
	ExpiresAt  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
.F G

IsRequiredG Q
(Q R
)R S
;S T
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
Organization *
)* +
. 
WithMany 
( 
o 
=> 
o 
. 
Invitations (
)( )
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
OrganizationId" 0
)0 1
.   
OnDelete   
(   
DeleteBehavior   $
.  $ %
Cascade  % ,
)  , -
.!! 
HasConstraintName!! 
(!! 
$str!! 3
)!!3 4
;!!4 5
builder"" 
."" 
HasOne"" 
("" 
e"" 
=>"" 
e"" 
."" 
Role"" "
)""" #
.## 
WithMany## 
(## 
)## 
.$$ 
HasForeignKey$$ 
($$ 
e$$ 
=>$$ 
e$$  !
.$$! "
	OrgRoleId$$" +
)$$+ ,
.%% 
OnDelete%% 
(%% 
DeleteBehavior%% $
.%%$ %
Restrict%%% -
)%%- .
.&& 
HasConstraintName&& 
(&& 
$str&& /
)&&/ 0
;&&0 1
builder'' 
.'' 
HasOne'' 
('' 
e'' 
=>'' 
e'' 
.'' 
	InvitedBy'' '
)''' (
.(( 
WithMany(( 
((( 
)(( 
.)) 
HasForeignKey)) 
()) 
e)) 
=>)) 
e))  !
.))! "
InvitedByUserId))" 1
)))1 2
.** 
OnDelete** 
(** 
DeleteBehavior** $
.**$ %
Restrict**% -
)**- .
.++ 
HasConstraintName++ 
(++ 
$str++ 1
)++1 2
;++2 3
},, 
}-- ç
xC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\OrganizationConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class %
OrganizationConfiguration &
:' ($
IEntityTypeConfiguration) A
<A B
OrganizationB N
>N O
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
Organization		, 8
>		8 9
builder		: A
)		A B
{

 
builder 
. 
ToTable 
( 
$str '
)' (
;( )
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
Name  $
)$ %
.% &
HasColumnName& 3
(3 4
$str4 :
): ;
.; <

IsRequired< F
(F G
)G H
;H I
builder 
. 
Property 
( 
e 
=> 
e 
.  

IsArchived  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I
HasDefaultValueI X
(X Y
falseY ^
)^ _
;_ `
} 
} ì!
{C:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\EntityWorkspaceConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class (
EntityWorkspaceConfiguration )
:* +$
IEntityTypeConfiguration, D
<D E
EntityWorkspaceE T
>T U
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
EntityWorkspace		, ;
>		; <
builder		= D
)		D E
{

 
builder 
. 
ToTable 
( 
$str *
)* +
;+ ,
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
EntityId  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
.D E

IsRequiredE O
(O P
)P Q
;Q R
builder 
. 
Property 
( 
e 
=> 
e 
.  
WorkspaceId  +
)+ ,
., -
HasColumnName- :
(: ;
$str; I
)I J
.J K

IsRequiredK U
(U V
)V W
;W X
builder 
. 
HasIndex 
( 
e 
=> 
new !
{" #
e$ %
.% &
EntityId& .
,. /
e0 1
.1 2
WorkspaceId2 =
}> ?
)? @
. 
IsUnique 
( 
) 
. 
HasDatabaseName 
( 
$str 5
)5 6
;6 7
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
WorkspaceId  +
)+ ,
., -
HasDatabaseName- <
(< =
$str= Q
)Q R
;R S
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
Entity $
)$ %
. 
WithMany 
( 
e 
=> 
e 
. 
EntityWorkspaces -
)- .
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
EntityId" *
)* +
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str -
)- .
;. /
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
	Workspace '
)' (
. 
WithMany 
( 
w 
=> 
w 
. 
EntityWorkspaces -
)- .
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
WorkspaceId" -
)- .
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str 0
)0 1
;1 2
} 
} ﬁ
~C:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\EntityTypePropertyConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class +
EntityTypePropertyConfiguration ,
:- .$
IEntityTypeConfiguration/ G
<G H
EntityTypePropertyH Z
>Z [
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
EntityTypeProperty		, >
>		> ?
builder		@ G
)		G H
{

 
builder 
. 
ToTable 
( 
$str .
). /
;/ 0
builder 
. 
HasKey 
( 
e 
=> 
new 
{  !
e" #
.# $
EntityTypeId$ 0
,0 1
e2 3
.3 4

PropertyId4 >
}? @
)@ A
;A B
builder 
. 
Property 
( 
e 
=> 
e 
.  
EntityTypeId  ,
), -
.- .
HasColumnName. ;
(; <
$str< L
)L M
.M N

IsRequiredN X
(X Y
)Y Z
;Z [
builder 
. 
Property 
( 
e 
=> 
e 
.  

PropertyId  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I

IsRequiredI S
(S T
)T U
;U V
builder 
. 
Property 
( 
e 
=> 
e 
.  

IsRequired  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I
HasDefaultValueI X
(X Y
falseY ^
)^ _
;_ `
builder 
. 
HasOne 
( 
e 
=> 
e 
. 

EntityType (
)( )
. 
WithMany 
( 
t 
=> 
t 
.  
EntityTypeProperties 1
)1 2
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
EntityTypeId" .
). /
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str 3
)3 4
;4 5
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
Property &
)& '
. 
WithMany 
( 
p 
=> 
p 
.  
EntityTypeProperties 1
)1 2
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "

PropertyId" ,
), -
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str 0
)0 1
;1 2
} 
} ¥
vC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\EntityTypeConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class #
EntityTypeConfiguration $
:% &$
IEntityTypeConfiguration' ?
<? @

EntityType@ J
>J K
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,

EntityType		, 6
>		6 7
builder		8 ?
)		? @
{

 
builder 
. 
ToTable 
( 
$str %
)% &
;& '
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
Name  $
)$ %
.% &
HasColumnName& 3
(3 4
$str4 :
): ;
.; <

IsRequired< F
(F G
)G H
;H I
builder 
. 
Property 
( 
e 
=> 
e 
.  
DisplayName  +
)+ ,
., -
HasColumnName- :
(: ;
$str; I
)I J
.J K
HasMaxLengthK W
(W X
$numX [
)[ \
;\ ]
builder 
. 
Property 
( 
e 
=> 
e 
.  
IsStandalone  ,
), -
.- .
HasColumnName. ;
(; <
$str< K
)K L
.L M

IsRequiredM W
(W X
)X Y
;Y Z
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
Name  $
)$ %
.% &
IsUnique& .
(. /
)/ 0
.0 1
HasDatabaseName1 @
(@ A
$strA V
)V W
;W X
} 
} ª-
ÇC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\EntityRelationshipTypeConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class /
#EntityRelationshipTypeConfiguration 0
:1 2$
IEntityTypeConfiguration3 K
<K L"
EntityRelationshipTypeL b
>b c
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,"
EntityRelationshipType		, B
>		B C
builder		D K
)		K L
{

 
builder 
. 
ToTable 
( 
$str 2
)2 3
;3 4
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
Name  $
)$ %
.% &
HasColumnName& 3
(3 4
$str4 :
): ;
.; <

IsRequired< F
(F G
)G H
;H I
builder 
. 
Property 
( 
e 
=> 
e 
.  
DisplayName  +
)+ ,
., -
HasColumnName- :
(: ;
$str; I
)I J
.J K
HasMaxLengthK W
(W X
$numX [
)[ \
;\ ]
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
Name  $
)$ %
.% &
IsUnique& .
(. /
)/ 0
.0 1
HasDatabaseName1 @
(@ A
$strA c
)c d
;d e
builder 
. 
Property 
( 
e 
=> 
e 
.  
SourceEntityTypeId  2
)2 3
.3 4
HasColumnName4 A
(A B
$strB Y
)Y Z
.Z [

IsRequired[ e
(e f
)f g
;g h
builder 
. 
Property 
( 
e 
=> 
e 
.  
TargetEntityTypeId  2
)2 3
.3 4
HasColumnName4 A
(A B
$strB Y
)Y Z
.Z [

IsRequired[ e
(e f
)f g
;g h
builder 
. 
Property 
( 
e 
=> 
e 
.  

IsRequired  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I

IsRequiredI S
(S T
)T U
;U V
builder 
. 
Property 
( 
e 
=> 
e 
.  #
RelationshipCardinality  7
)7 8
. 
HasColumnName 
( 
$str 5
)5 6
. 
HasMaxLength 
( 
$num 
) 
. 

IsRequired 
( 
) 
. 
HasConversion 
( 
v 
=> 
v 
. 
ToDatabaseValue &
(& '
)' (
,( )
v 
=> -
!RelationshipCardinalityExtensions 6
.6 7
ParseDatabaseValue7 I
(I J
vJ K
)K L
)L M
;M N
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
SourceEntityType .
). /
. 
WithMany 
( 
t 
=> 
t 
. #
SourceRelationshipTypes 4
)4 5
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
SourceEntityTypeId" 4
)4 5
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Restrict% -
)- .
. 
HasConstraintName 
( 
$str :
): ;
;; <
builder   
.   
HasOne   
(   
e   
=>   
e   
.   
TargetEntityType   .
)  . /
.!! 
WithMany!! 
(!! 
t!! 
=>!! 
t!! 
.!! #
TargetRelationshipTypes!! 4
)!!4 5
."" 
HasForeignKey"" 
("" 
e"" 
=>"" 
e""  !
.""! "
TargetEntityTypeId""" 4
)""4 5
.## 
OnDelete## 
(## 
DeleteBehavior## $
.##$ %
Restrict##% -
)##- .
.$$ 
HasConstraintName$$ 
($$ 
$str$$ :
)$$: ;
;$$; <
}%% 
}&& ß/
~C:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\EntityRelationshipConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class +
EntityRelationshipConfiguration ,
:- .$
IEntityTypeConfiguration/ G
<G H
EntityRelationshipH Z
>Z [
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
EntityRelationship		, >
>		> ?
builder		@ G
)		G H
{

 
builder 
. 
ToTable 
( 
$str -
)- .
;. /
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
SourceEntityId  .
). /
./ 0
HasColumnName0 =
(= >
$str> P
)P Q
.Q R

IsRequiredR \
(\ ]
)] ^
;^ _
builder 
. 
Property 
( 
e 
=> 
e 
.  
TargetEntityId  .
). /
./ 0
HasColumnName0 =
(= >
$str> P
)P Q
.Q R

IsRequiredR \
(\ ]
)] ^
;^ _
builder 
. 
Property 
( 
e 
=> 
e 
.  
RelationshipTypeId  2
)2 3
.3 4
HasColumnName4 A
(A B
$strB X
)X Y
.Y Z

IsRequiredZ d
(d e
)e f
;f g
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
SourceEntityId  .
). /
./ 0
HasDatabaseName0 ?
(? @
$str@ X
)X Y
;Y Z
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
TargetEntityId  .
). /
./ 0
HasDatabaseName0 ?
(? @
$str@ X
)X Y
;Y Z
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
RelationshipTypeId  2
)2 3
.3 4
HasDatabaseName4 C
(C D
$strD `
)` a
;a b
builder 
. 
HasIndex 
( 
e 
=> 
new !
{" #
e$ %
.% &
SourceEntityId& 4
,4 5
e6 7
.7 8
RelationshipTypeId8 J
,J K
eL M
.M N
TargetEntityIdN \
}] ^
)^ _
. 
IsUnique 
( 
) 
. 
HasDatabaseName 
(  
$str  A
)A B
;B C
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
SourceEntity *
)* +
. 
WithMany 
( 
en 
=> 
en 
. 
SourceRelationships 2
)2 3
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
SourceEntityId" 0
)0 1
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str 4
)4 5
;5 6
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
TargetEntity *
)* +
. 
WithMany 
( 
en 
=> 
en 
. 
TargetRelationships 2
)2 3
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
TargetEntityId" 0
)0 1
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Restrict% -
)- .
.   
HasConstraintName   
(   
$str   4
)  4 5
;  5 6
builder!! 
.!! 
HasOne!! 
(!! 
e!! 
=>!! 
e!! 
.!! 
RelationshipType!! .
)!!. /
."" 
WithMany"" 
("" 
rt"" 
=>"" 
rt"" 
."" 
EntityRelationships"" 2
)""2 3
.## 
HasForeignKey## 
(## 
e## 
=>## 
e##  !
.##! "
RelationshipTypeId##" 4
)##4 5
.$$ 
OnDelete$$ 
($$ 
DeleteBehavior$$ $
.$$$ %
Restrict$$% -
)$$- .
.%% 
HasConstraintName%% 
(%% 
$str%% 8
)%%8 9
;%%9 :
}&& 
}'' Ê&
C:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\EntityPropertyValueConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class ,
 EntityPropertyValueConfiguration -
:. /$
IEntityTypeConfiguration0 H
<H I
EntityPropertyValueI \
>\ ]
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
EntityPropertyValue		, ?
>		? @
builder		A H
)		H I
{

 
builder 
. 
ToTable 
( 
$str /
)/ 0
;0 1
builder 
. 
HasKey 
( 
e 
=> 
new 
{  !
e" #
.# $
EntityId$ ,
,, -
e. /
./ 0

PropertyId0 :
}; <
)< =
;= >
builder 
. 
Property 
( 
e 
=> 
e 
.  
EntityId  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
.D E

IsRequiredE O
(O P
)P Q
;Q R
builder 
. 
Property 
( 
e 
=> 
e 
.  

PropertyId  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I

IsRequiredI S
(S T
)T U
;U V
builder 
. 
Property 
( 
e 
=> 
e 
.  
ValueString  +
)+ ,
., -
HasColumnName- :
(: ;
$str; I
)I J
;J K
builder 
. 
Property 
( 
e 
=> 
e 
.  
ValueInt  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
;D E
builder 
. 
Property 
( 
e 
=> 
e 
.  
ValueDecimal  ,
), -
.- .
HasColumnName. ;
(; <
$str< K
)K L
;L M
builder 
. 
Property 
( 
e 
=> 
e 
.  
	ValueBool  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
;F G
builder 
. 
Property 
( 
e 
=> 
e 
.  
	ValueDate  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
;F G
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
Entity $
)$ %
. 
WithMany 
( 
en 
=> 
en 
.  
EntityPropertyValues 3
)3 4
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
EntityId" *
)* +
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str .
). /
;/ 0
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
Property &
)& '
. 
WithMany 
( 
p 
=> 
p 
.  
EntityPropertyValues 1
)1 2
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "

PropertyId" ,
), -
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Cascade% ,
), -
. 
HasConstraintName 
( 
$str 0
)0 1
;1 2
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  

PropertyId  *
)* +
.+ ,
HasDatabaseName, ;
(; <
$str< P
)P Q
;Q R
} 
}   © 
rC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\EntityConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
class 
EntityConfiguration  
:! "$
IEntityTypeConfiguration# ;
<; <
Entity< B
>B C
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
Entity		, 2
>		2 3
builder		4 ;
)		; <
{

 
builder 
. 
ToTable 
( 
$str  
)  !
;! "
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
EntityTypeId  ,
), -
.- .
HasColumnName. ;
(; <
$str< L
)L M
.M N

IsRequiredN X
(X Y
)Y Z
;Z [
builder 
. 
Property 
( 
e 
=> 
e 
.  
CreatedByUserId  /
)/ 0
.0 1
HasColumnName1 >
(> ?
$str? S
)S T
.T U

IsRequiredU _
(_ `
)` a
;a b
builder 
. 
Property 
( 
e 
=> 
e 
.  

IsArchived  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I
HasDefaultValueI X
(X Y
falseY ^
)^ _
;_ `
builder 
. 
HasOne 
( 
e 
=> 
e 
. 

EntityType (
)( )
. 
WithMany 
( 
t 
=> 
t 
. 
Entities %
)% &
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
EntityTypeId" .
). /
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Restrict% -
)- .
. 
HasConstraintName 
( 
$str 6
)6 7
;7 8
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
CreatedByUserId  /
)/ 0
. 
HasDatabaseName 
( 
$str 8
)8 9
;9 :
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
CreatedByUser +
)+ ,
. 
WithMany 
( 
u 
=> 
u 
. 
CreatedEntities ,
), -
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
CreatedByUserId" 1
)1 2
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Restrict% -
)- .
. 
HasConstraintName 
( 
$str :
): ;
;; <
} 
} Í
C:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\AuditProcessedEventConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
sealed 
class ,
 AuditProcessedEventConfiguration 4
:5 6$
IEntityTypeConfiguration7 O
<O P
AuditProcessedEventP c
>c d
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
AuditProcessedEvent		, ?
>		? @
builder		A H
)		H I
{

 
builder 
. 
ToTable 
( 
$str /
)/ 0
;0 1
builder 
. 
HasKey 
( 
x 
=> 
x 
. 
EventId %
)% &
;& '
builder 
. 
Property 
( 
x 
=> 
x 
.  
EventId  '
)' (
. 
HasColumnName 
( 
$str %
)% &
;& '
builder 
. 
Property 
( 
x 
=> 
x 
.  
ProcessedAtUtc  .
). /
. 
HasColumnName 
( 
$str -
)- .
. 
HasColumnType 
( 
$str (
)( )
. 

IsRequired 
( 
) 
; 
} 
} ﬁ+
~C:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\AuditOutboxMessageConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
;- .
public 
sealed 
class +
AuditOutboxMessageConfiguration 3
:4 5$
IEntityTypeConfiguration6 N
<N O
AuditOutboxMessageO a
>a b
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
AuditOutboxMessage		, >
>		> ?
builder		@ G
)		G H
{

 
builder 
. 
ToTable 
( 
$str &
)& '
;' (
builder 
. 
HasKey 
( 
x 
=> 
x 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
x 
=> 
x 
.  
Id  "
)" #
. 
HasColumnName 
( 
$str 
)  
. 
ValueGeneratedOnAdd  
(  !
)! "
;" #
builder 
. 
Property 
( 
x 
=> 
x 
.  
EventId  '
)' (
. 
HasColumnName 
( 
$str %
)% &
. 

IsRequired 
( 
) 
; 
builder 
. 
Property 
( 
x 
=> 
x 
.  
PayloadJson  +
)+ ,
. 
HasColumnName 
( 
$str )
)) *
. 
HasColumnType 
( 
$str "
)" #
. 

IsRequired 
( 
) 
; 
builder 
. 
Property 
( 
x 
=> 
x 
.  

RoutingKey  *
)* +
. 
HasColumnName 
( 
$str (
)( )
. 
HasMaxLength 
( 
$num 
) 
. 

IsRequired 
( 
) 
; 
builder 
. 
Property 
( 
x 
=> 
x 
.  
OccurredAtUtc  -
)- .
. 
HasColumnName 
( 
$str ,
), -
. 
HasColumnType 
( 
$str (
)( )
. 

IsRequired 
( 
) 
; 
builder   
.   
Property   
(   
x   
=>   
x   
.    
CreatedAtUtc    ,
)  , -
.!! 
HasColumnName!! 
(!! 
$str!! +
)!!+ ,
."" 
HasColumnType"" 
("" 
$str"" (
)""( )
.## 

IsRequired## 
(## 
)## 
;## 
builder$$ 
.$$ 
Property$$ 
($$ 
x$$ 
=>$$ 
x$$ 
.$$  
PublishedAtUtc$$  .
)$$. /
.%% 
HasColumnName%% 
(%% 
$str%% -
)%%- .
.&& 
HasColumnType&& 
(&& 
$str&& (
)&&( )
;&&) *
builder'' 
.'' 
Property'' 
('' 
x'' 
=>'' 
x'' 
.''  
PublishAttempts''  /
)''/ 0
.(( 
HasColumnName(( 
((( 
$str(( -
)((- .
.)) 

IsRequired)) 
()) 
))) 
;)) 
builder** 
.** 
Property** 
(** 
x** 
=>** 
x** 
.**  
	LastError**  )
)**) *
.++ 
HasColumnName++ 
(++ 
$str++ '
)++' (
.,, 
HasMaxLength,, 
(,, 
$num,, 
),, 
;,,  
builder.. 
... 
HasIndex.. 
(.. 
x.. 
=>.. 
new.. !
{.." #
x..$ %
...% &
PublishedAtUtc..& 4
,..4 5
x..6 7
...7 8
Id..8 :
}..; <
)..< =
.// 
HasDatabaseName// 
(// 
$str// 6
)//6 7
;//7 8
builder00 
.00 
HasIndex00 
(00 
x00 
=>00 
x00 
.00  
CreatedAtUtc00  ,
)00, -
.11 
HasDatabaseName11 
(11 
$str11 =
)11= >
;11> ?
builder22 
.22 
HasIndex22 
(22 
x22 
=>22 
x22 
.22  
EventId22  '
)22' (
.33 
IsUnique33 
(33 
)33 
.44 
HasDatabaseName44 
(44 
$str44 7
)447 8
;448 9
}55 
}66 Ô2
áC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\AuditLogs\WorkspaceAuditLogConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
.- .
	AuditLogs. 7
;7 8
public 
class *
WorkspaceAuditLogConfiguration +
:, -$
IEntityTypeConfiguration. F
<F G
WorkspaceAuditLogG X
>X Y
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
WorkspaceAuditLog		, =
>		= >
builder		? F
)		F G
{

 
builder 
. 
ToTable 
( 
$str -
)- .
;. /
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
WorkspaceId  +
)+ ,
., -
HasColumnName- :
(: ;
$str; I
)I J
;J K
builder 
. 
Property 
( 
e 
=> 
e 
.  
Action  &
)& '
.' (
HasColumnName( 5
(5 6
$str6 >
)> ?
.? @
HasMaxLength@ L
(L M
$numM O
)O P
.P Q

IsRequiredQ [
([ \
)\ ]
;] ^
builder 
. 
Property 
( 
e 
=> 
e 
.  
ChangedById  +
)+ ,
., -
HasColumnName- :
(: ;
$str; G
)G H
;H I
builder 
. 
Property 
( 
e 
=> 
e 
.  
	FieldName  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
;F G
builder 
. 
Property 
( 
e 
=> 
e 
.  
OldValue  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
.D E
HasColumnTypeE R
(R S
$strS Z
)Z [
;[ \
builder 
. 
Property 
( 
e 
=> 
e 
.  
NewValue  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
.D E
HasColumnTypeE R
(R S
$strS Z
)Z [
;[ \
builder 
. 
Property 
( 
e 
=> 
e 
.  
	ChangedAt  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
.F G
HasColumnTypeG T
(T U
$strU b
)b c
.c d

IsRequiredd n
(n o
)o p
;p q
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
	Workspace '
)' (
. 
WithMany 
( 
) 
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
WorkspaceId" -
)- .
. 
OnDelete 
( 
DeleteBehavior $
.$ %
SetNull% ,
), -
. 
HasConstraintName 
( 
$str B
)B C
;C D
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
	ChangedBy '
)' (
. 
WithMany 
( 
) 
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
ChangedById" -
)- .
. 
OnDelete 
( 
DeleteBehavior $
.$ %
SetNull% ,
), -
. 
HasConstraintName 
( 
$str =
)= >
;> ?
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
	ChangedAt  )
)) *
.* +
IsDescending+ 7
(7 8
)8 9
.9 :
HasDatabaseName: I
(I J
$strJ m
)m n
;n o
builder   
.   
HasIndex   
(   
e   
=>   
new   !
{  " #
e  $ %
.  % &
WorkspaceId  & 1
,  1 2
e  3 4
.  4 5
	ChangedAt  5 >
}  ? @
)  @ A
.!! 
IsDescending!! 
(!! 
false!! 
,!!  
true!!! %
)!!% &
."" 
HasDatabaseName"" 
("" 
$str"" :
)"": ;
;""; <
builder## 
.## 
HasIndex## 
(## 
e## 
=>## 
new## !
{##" #
e##$ %
.##% &
ChangedById##& 1
,##1 2
e##3 4
.##4 5
	ChangedAt##5 >
}##? @
)##@ A
.$$ 
IsDescending$$ 
($$ 
false$$ 
,$$  
true$$! %
)$$% &
.%% 
HasDatabaseName%% 
(%% 
$str%% ;
)%%; <
;%%< =
}&& 
}'' ﬂ2
ÇC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\AuditLogs\UserAuditLogConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
.- .
	AuditLogs. 7
;7 8
public 
class %
UserAuditLogConfiguration &
:' ($
IEntityTypeConfiguration) A
<A B
UserAuditLogB N
>N O
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
UserAuditLog		, 8
>		8 9
builder		: A
)		A B
{

 
builder 
. 
ToTable 
( 
$str (
)( )
;) *
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
TargetUserId  ,
), -
.- .
HasColumnName. ;
(; <
$str< L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
Action  &
)& '
.' (
HasColumnName( 5
(5 6
$str6 >
)> ?
.? @
HasMaxLength@ L
(L M
$numM O
)O P
.P Q

IsRequiredQ [
([ \
)\ ]
;] ^
builder 
. 
Property 
( 
e 
=> 
e 
.  
ChangedById  +
)+ ,
., -
HasColumnName- :
(: ;
$str; G
)G H
;H I
builder 
. 
Property 
( 
e 
=> 
e 
.  
	FieldName  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
;F G
builder 
. 
Property 
( 
e 
=> 
e 
.  
OldValue  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
.D E
HasColumnTypeE R
(R S
$strS Z
)Z [
;[ \
builder 
. 
Property 
( 
e 
=> 
e 
.  
NewValue  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
.D E
HasColumnTypeE R
(R S
$strS Z
)Z [
;[ \
builder 
. 
Property 
( 
e 
=> 
e 
.  
	ChangedAt  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
.F G
HasColumnTypeG T
(T U
$strU b
)b c
.c d

IsRequiredd n
(n o
)o p
;p q
builder 
. 
HasOne 
( 
e 
=> 
e 
. 

TargetUser (
)( )
. 
WithMany 
( 
) 
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
TargetUserId" .
). /
. 
OnDelete 
( 
DeleteBehavior $
.$ %
SetNull% ,
), -
. 
HasConstraintName 
( 
$str ?
)? @
;@ A
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
	ChangedBy '
)' (
. 
WithMany 
( 
) 
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
ChangedById" -
)- .
. 
OnDelete 
( 
DeleteBehavior $
.$ %
SetNull% ,
), -
. 
HasConstraintName 
( 
$str 8
)8 9
;9 :
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
	ChangedAt  )
)) *
.* +
IsDescending+ 7
(7 8
)8 9
.9 :
HasDatabaseName: I
(I J
$strJ h
)h i
;i j
builder   
.   
HasIndex   
(   
e   
=>   
new   !
{  " #
e  $ %
.  % &
TargetUserId  & 2
,  2 3
e  4 5
.  5 6
	ChangedAt  6 ?
}  @ A
)  A B
.!! 
IsDescending!! 
(!! 
false!! 
,!!  
true!!! %
)!!% &
."" 
HasDatabaseName"" 
("" 
$str"" <
)""< =
;""= >
builder## 
.## 
HasIndex## 
(## 
e## 
=>## 
new## !
{##" #
e##$ %
.##% &
ChangedById##& 1
,##1 2
e##3 4
.##4 5
	ChangedAt##5 >
}##? @
)##@ A
.$$ 
IsDescending$$ 
($$ 
false$$ 
,$$  
true$$! %
)$$% &
.%% 
HasDatabaseName%% 
(%% 
$str%% ;
)%%; <
;%%< =
}&& 
}'' á3
äC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\AuditLogs\OrganizationAuditLogConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
.- .
	AuditLogs. 7
;7 8
public 
class -
!OrganizationAuditLogConfiguration .
:/ 0$
IEntityTypeConfiguration1 I
<I J 
OrganizationAuditLogJ ^
>^ _
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ , 
OrganizationAuditLog		, @
>		@ A
builder		B I
)		I J
{

 
builder 
. 
ToTable 
( 
$str 0
)0 1
;1 2
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
OrganizationId  .
). /
./ 0
HasColumnName0 =
(= >
$str> O
)O P
;P Q
builder 
. 
Property 
( 
e 
=> 
e 
.  
Action  &
)& '
.' (
HasColumnName( 5
(5 6
$str6 >
)> ?
.? @
HasMaxLength@ L
(L M
$numM O
)O P
.P Q

IsRequiredQ [
([ \
)\ ]
;] ^
builder 
. 
Property 
( 
e 
=> 
e 
.  
ChangedById  +
)+ ,
., -
HasColumnName- :
(: ;
$str; G
)G H
;H I
builder 
. 
Property 
( 
e 
=> 
e 
.  
	FieldName  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
;F G
builder 
. 
Property 
( 
e 
=> 
e 
.  
OldValue  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
.D E
HasColumnTypeE R
(R S
$strS Z
)Z [
;[ \
builder 
. 
Property 
( 
e 
=> 
e 
.  
NewValue  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
.D E
HasColumnTypeE R
(R S
$strS Z
)Z [
;[ \
builder 
. 
Property 
( 
e 
=> 
e 
.  
	ChangedAt  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
.F G
HasColumnTypeG T
(T U
$strU b
)b c
.c d

IsRequiredd n
(n o
)o p
;p q
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
Organization *
)* +
. 
WithMany 
( 
) 
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
OrganizationId" 0
)0 1
. 
OnDelete 
( 
DeleteBehavior $
.$ %
SetNull% ,
), -
. 
HasConstraintName 
( 
$str H
)H I
;I J
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
	ChangedBy '
)' (
. 
WithMany 
( 
) 
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
ChangedById" -
)- .
. 
OnDelete 
( 
DeleteBehavior $
.$ %
SetNull% ,
), -
. 
HasConstraintName 
( 
$str @
)@ A
;A B
builder 
. 
HasIndex 
( 
e 
=> 
e 
.  
	ChangedAt  )
)) *
.* +
IsDescending+ 7
(7 8
)8 9
.9 :
HasDatabaseName: I
(I J
$strJ p
)p q
;q r
builder   
.   
HasIndex   
(   
e   
=>   
new   !
{  " #
e  $ %
.  % &
OrganizationId  & 4
,  4 5
e  6 7
.  7 8
	ChangedAt  8 A
}  B C
)  C D
.!! 
IsDescending!! 
(!! 
false!! 
,!!  
true!!! %
)!!% &
."" 
HasDatabaseName"" 
("" 
$str"" =
)""= >
;""> ?
builder## 
.## 
HasIndex## 
(## 
e## 
=>## 
new## !
{##" #
e##$ %
.##% &
ChangedById##& 1
,##1 2
e##3 4
.##4 5
	ChangedAt##5 >
}##? @
)##@ A
.$$ 
IsDescending$$ 
($$ 
false$$ 
,$$  
true$$! %
)$$% &
.%% 
HasDatabaseName%% 
(%% 
$str%% ;
)%%; <
;%%< =
}&& 
}'' ∆5
ÑC:\Users\babay\myrepos\testing\Relativa\Persistence\src\Relativa.Persistence\Configurations\AuditLogs\EntityAuditLogConfiguration.cs
	namespace 	
Relativa
 
. 
Persistence 
. 
Configurations -
.- .
	AuditLogs. 7
;7 8
public 
class '
EntityAuditLogConfiguration (
:) *$
IEntityTypeConfiguration+ C
<C D
EntityAuditLogD R
>R S
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
EntityAuditLog		, :
>		: ;
builder		< C
)		C D
{

 
builder 
. 
ToTable 
( 
$str *
)* +
;+ ,
builder 
. 
HasKey 
( 
e 
=> 
e 
. 
Id  
)  !
;! "
builder 
. 
Property 
( 
e 
=> 
e 
.  
Id  "
)" #
.# $
HasColumnName$ 1
(1 2
$str2 6
)6 7
.7 8
ValueGeneratedOnAdd8 K
(K L
)L M
;M N
builder 
. 
Property 
( 
e 
=> 
e 
.  
EntityId  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
;D E
builder 
. 
Property 
( 
e 
=> 
e 
.  

EntityType  *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: G
)G H
.H I
HasMaxLengthI U
(U V
$numV X
)X Y
;Y Z
builder 
. 
Property 
( 
e 
=> 
e 
.  
Action  &
)& '
.' (
HasColumnName( 5
(5 6
$str6 >
)> ?
.? @
HasMaxLength@ L
(L M
$numM O
)O P
.P Q

IsRequiredQ [
([ \
)\ ]
;] ^
builder 
. 
Property 
( 
e 
=> 
e 
.  
ChangedById  +
)+ ,
., -
HasColumnName- :
(: ;
$str; G
)G H
;H I
builder 
. 
Property 
( 
e 
=> 
e 
.  
	FieldName  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
;F G
builder 
. 
Property 
( 
e 
=> 
e 
.  
OldValue  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
.D E
HasColumnTypeE R
(R S
$strS Z
)Z [
;[ \
builder 
. 
Property 
( 
e 
=> 
e 
.  
NewValue  (
)( )
.) *
HasColumnName* 7
(7 8
$str8 C
)C D
.D E
HasColumnTypeE R
(R S
$strS Z
)Z [
;[ \
builder 
. 
Property 
( 
e 
=> 
e 
.  
	ChangedAt  )
)) *
.* +
HasColumnName+ 8
(8 9
$str9 E
)E F
.F G
HasColumnTypeG T
(T U
$strU b
)b c
.c d

IsRequiredd n
(n o
)o p
;p q
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
Entity $
)$ %
. 
WithMany 
( 
) 
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
EntityId" *
)* +
. 
OnDelete 
( 
DeleteBehavior $
.$ %
SetNull% ,
), -
. 
HasConstraintName 
( 
$str =
)= >
;> ?
builder 
. 
HasOne 
( 
e 
=> 
e 
. 
	ChangedBy '
)' (
. 
WithMany 
( 
) 
. 
HasForeignKey 
( 
e 
=> 
e  !
.! "
ChangedById" -
)- .
. 
OnDelete 
( 
DeleteBehavior $
.$ %
SetNull% ,
), -
. 
HasConstraintName 
( 
$str :
): ;
;; <
builder   
.   
HasIndex   
(   
e   
=>   
e   
.    
	ChangedAt    )
)  ) *
.  * +
IsDescending  + 7
(  7 8
)  8 9
.  9 :
HasDatabaseName  : I
(  I J
$str  J j
)  j k
;  k l
builder!! 
.!! 
HasIndex!! 
(!! 
e!! 
=>!! 
new!! !
{!!" #
e!!$ %
.!!% &
EntityId!!& .
,!!. /
e!!0 1
.!!1 2
	ChangedAt!!2 ;
}!!< =
)!!= >
."" 
IsDescending"" 
("" 
false"" 
,""  
true""! %
)""% &
.## 
HasDatabaseName## 
(## 
$str## 7
)##7 8
;##8 9
builder$$ 
.$$ 
HasIndex$$ 
($$ 
e$$ 
=>$$ 
new$$ !
{$$" #
e$$$ %
.$$% &
ChangedById$$& 1
,$$1 2
e$$3 4
.$$4 5
	ChangedAt$$5 >
}$$? @
)$$@ A
.%% 
IsDescending%% 
(%% 
false%% 
,%%  
true%%! %
)%%% &
.&& 
HasDatabaseName&& 
(&& 
$str&& ;
)&&; <
;&&< =
}'' 
}(( 