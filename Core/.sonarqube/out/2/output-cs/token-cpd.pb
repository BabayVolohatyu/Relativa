”	
C:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Domain\Interfaces\IUserSettingsRepository.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Domain" (
.( )

Interfaces) 3
;3 4
public 
	interface #
IUserSettingsRepository (
{ 
Task 
< 	
UserSettings	 
? 
> 
GetByUserIdAsync (
(( )
int) ,
userId- 3
,3 4
CancellationToken5 F
ctG I
=J K
defaultL S
)S T
;T U
Task 
AddAsync	 
( 
UserSettings 
settings '
,' (
CancellationToken) :
ct; =
=> ?
default@ G
)G H
;H I
Task		 
UpdateAsync			 
(		 
UserSettings		 !
settings		" *
,		* +
CancellationToken		, =
ct		> @
=		A B
default		C J
)		J K
;		K L
}

 È*
wC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Domain\Interfaces\IUserRepository.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Domain" (
.( )

Interfaces) 3
;3 4
public 
	interface 
IUserRepository  
{ 
Task 
< 	
User	 
? 
> 
GetByIdAsync 
( 
int  
id! #
,# $
CancellationToken% 6
ct7 9
=: ;
default< C
)C D
;D E
Task 
< 	
User	 
? 
> 
GetByEmailAsync 
(  
string  &
email' ,
,, -
CancellationToken. ?
ct@ B
=C D
defaultE L
)L M
;M N
Task		 
<		 	
bool			 
>		 
ExistsAsync		 
(		 
string		 !
email		" '
,		' (
CancellationToken		) :
ct		; =
=		> ?
default		@ G
)		G H
;		H I
Task

 
AddAsync

	 
(

 
User

 
user

 
,

 
CancellationToken

 .
ct

/ 1
=

2 3
default

4 ;
)

; <
;

< =
Task 
UpdateAsync	 
( 
User 
user 
, 
CancellationToken  1
ct2 4
=5 6
default7 >
)> ?
;? @
Task 
< 	
User	 
? 
> #
GetByExternalLoginAsync '
(' (
string( .
provider/ 7
,7 8
string9 ?
subject@ G
,G H
CancellationTokenI Z
ct[ ]
=^ _
default` g
)g h
;h i
Task !
AddExternalLoginAsync	 
( 
UserExternalLogin 0
login1 6
,6 7
CancellationToken8 I
ctJ L
=M N
defaultO V
)V W
;W X
Task 
< 	
User	 
? 
>  
GetByResetTokenAsync $
($ %
string% +
	tokenHash, 5
,5 6
CancellationToken7 H
ctI K
=L M
defaultN U
)U V
;V W
Task 
< 	
IReadOnlyList	 
< 
UserBackupCode %
>% &
>& '%
GetActiveBackupCodesAsync( A
(A B
intB E
userIdF L
,L M
CancellationTokenN _
ct` b
=c d
defaulte l
)l m
;m n
Task #
ReplaceBackupCodesAsync	  
(  !
int! $
userId% +
,+ ,
IReadOnlyList- :
<: ;
UserBackupCode; I
>I J
codesK P
,P Q
CancellationTokenR c
ctd f
=g h
defaulti p
)p q
;q r
Task "
ConsumeBackupCodeAsync	 
(  
UserBackupCode  .
code/ 3
,3 4
CancellationToken5 F
ctG I
=J K
defaultL S
)S T
;T U
Task 
< 	
IReadOnlyList	 
< 
	UserEmail  
>  !
>! "
GetEmailsAsync# 1
(1 2
int2 5
userId6 <
,< =
CancellationToken> O
ctP R
=S T
defaultU \
)\ ]
;] ^
Task 
< 	
	UserEmail	 
? 
> 
GetEmailAsync "
(" #
int# &
userId' -
,- .
string/ 5
address6 =
,= >
CancellationToken? P
ctQ S
=T U
defaultV ]
)] ^
;^ _
Task 
< 	
bool	 
> $
EmailExistsAnywhereAsync '
(' (
string( .
address/ 6
,6 7
CancellationToken8 I
ctJ L
=M N
defaultO V
)V W
;W X
Task 
AddEmailAsync	 
( 
	UserEmail  
email! &
,& '
CancellationToken( 9
ct: <
== >
default? F
)F G
;G H
Task 
UpdateEmailAsync	 
( 
	UserEmail #
email$ )
,) *
CancellationToken+ <
ct= ?
=@ A
defaultB I
)I J
;J K
Task 
RemoveEmailAsync	 
( 
	UserEmail #
email$ )
,) *
CancellationToken+ <
ct= ?
=@ A
defaultB I
)I J
;J K
Task +
ReleaseExternalIdentifiersAsync	 (
(( )
int) ,
userId- 3
,3 4
CancellationToken5 F
ctG I
=J K
defaultL S
)S T
;T U
} Ž
uC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Domain\Interfaces\ITotpProvider.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Domain" (
.( )

Interfaces) 3
;3 4
public 
	interface 
ITotpProvider 
{ 
string 

GenerateSecret 
( 
) 
; 
string 

BuildOtpAuthUri 
( 
string !
secret" (
,( )
string* 0
accountName1 <
,< =
string> D
issuerE K
)K L
;L M
bool 

VerifyCode	 
( 
string 
secret !
,! "
string# )
code* .
). /
;/ 0
} ÷
uC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Domain\Interfaces\ITokenService.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Domain" (
.( )

Interfaces) 3
;3 4
public 
	interface 
ITokenService 
{ 
( 
string 
Token 
, 
DateTime 
	ExpiresAt %
)% &
GenerateAccessToken' :
(: ;
User; ?
user@ D
)D E
;E F
} —
rC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Domain\Interfaces\ISmsSender.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Domain" (
.( )

Interfaces) 3
;3 4
public 
	interface 

ISmsSender 
{ 
Task 
	SendAsync	 
( 
string 
toPhone !
,! "
string# )
message* 1
,1 2
CancellationToken3 D
ctE G
=H I
defaultJ Q
)Q R
;R S
} ±
wC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Domain\Interfaces\IPasswordHasher.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Domain" (
.( )

Interfaces) 3
;3 4
public 
	interface 
IPasswordHasher  
{ 
string 

Hash 
( 
string 
plain 
) 
; 
bool 
Verify	 
( 
string 
plain 
, 
string $
hash% )
)) *
;* +
} ¸
tC:\Users\babay\myrepos\testing\Relativa\Authentication\src\Relativa.Authentication.Domain\Interfaces\IEmailSender.cs
	namespace 	
Relativa
 
. 
Authentication !
.! "
Domain" (
.( )

Interfaces) 3
;3 4
public 
	interface 
IEmailSender 
{ 
Task 
	SendAsync	 
( 
string 
to 
, 
string 
subject 
, 
string 
htmlBody 
, 
string		 
?		 
textBody		 
=		 
null		 
,		  
CancellationToken

 
ct

 
=

 
default

 &
)

& '
;

' (
} 