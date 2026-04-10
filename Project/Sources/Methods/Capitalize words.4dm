//%attributes = {"invisible":true}
var $0 : Text
var $1 : Text

var $i : Integer

ARRAY TEXT:C222($words; 0)


ASSERT:C1129(Count parameters:C259#0)

GET TEXT KEYWORDS:C1141($1; $words)

For ($i; 1; Size of array:C274($words))
	$0:=$0+Choose:C955($i=1; ""; " ")+str_Capitalize($words{$i})
End for 