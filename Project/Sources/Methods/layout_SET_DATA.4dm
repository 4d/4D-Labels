//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : layout_SET_DATA
// Database: 4D Labels
// ID[DB07854D600B421F95C42615D9FAE4E4]
// Created #16-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($target : Text; $value : Text)

If (Count parameters:C259>=2)
	
	//
	
Else 
	
	var $me:=OBJECT Get pointer:C1124(Object current:K67:2)
	var $type:=Value type:C1509($me->)
	
	Case of 
			
			//________________________________________
		: ($type=Is text:K8:3)
			
			$value:=$me->
			
			//________________________________________
		: ($type=Is longint:K8:6)\
			 || ($type=Is integer:K8:5)
			
			$value:=String:C10($me->)
			
			//________________________________________
		: ($type=Is real:K8:4)
			
			$value:=String:C10($me->; "&xml")
			
			//________________________________________
		Else 
			
			ASSERT:C1129(False:C215)
			
			//________________________________________
	End case 
End if 

var $o : Object:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->

$o[$target]:=$value
$o.target:=$target

CALL SUBFORM CONTAINER:C1086(-1)