//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Obj_TOUCH
// Database: 4D Labels
// ID[3435E427D0454685AD24E4103F98D9AD]
// Created #7-7-2015 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($objectName : Text;  ...  : Text)

var $i : Integer
var $ptr : Pointer

For ($i; 1; Count parameters:C259; 1)
	
	$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; ${$i})
	
	If (Not:C34(Is nil pointer:C315($ptr)))
		
		$ptr->:=$ptr->
		
	End if 
End for 