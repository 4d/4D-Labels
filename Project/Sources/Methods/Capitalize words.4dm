//%attributes = {"invisible":true}
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($i)

ARRAY TEXT:C222($words;0)

If (False:C215)
	C_TEXT:C284(Capitalize words ;$0)
	C_TEXT:C284(Capitalize words ;$1)
End if 

ASSERT:C1129(Count parameters:C259#0)

GET TEXT KEYWORDS:C1141($1;$words)

For ($i;1;Size of array:C274($words))
	$0:=$0+Choose:C955($i=1;"";" ")+str_Capitalize ($words{$i})
End for 