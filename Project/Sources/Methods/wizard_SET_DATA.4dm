//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : lbw_SET_DATA
// Database: 4D Labels
// ID[DB07854D600B421F95C42615D9FAE4E4]
// Created #16-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($data : Text; $value : Text;  ...  : Text)

If (Count parameters:C259>2)
	
	var $i : Integer
	
	For ($i; 1; Count parameters:C259; 2)
		
		$data:=${$i}
		$value:=${$i+1}
		
		label_data_SET($data; $value)
		
	End for 
	
Else 
	
	If (Length:C16($value)=0)
		
		var $me:=OBJECT Get pointer:C1124(Object current:K67:2)
		var $type:=Value type:C1509($me->)
		
		Case of 
				
				// ________________________________________
			: ($type=Is text:K8:3)\
				 || ($type=Is alpha field:K8:1)
				
				$value:=$me->
				
				// ________________________________________
			: ($type=Is longint:K8:6)\
				 || ($type=Is integer:K8:5)
				
				$value:=String:C10($me->)
				
				// ________________________________________
			: ($type=Is real:K8:4)
				
				$value:=String:C10($me->; "&xml")
				
				// ________________________________________
			Else 
				
				// ASSERT(False)
				
				// ________________________________________
		End case 
	End if 
	
	// Store value
	label_data_SET($data; $value)
	
End if 

// Update UI
wizard_UPDATE_UI