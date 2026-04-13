//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : lbw_SET_DATA
// Database: 4D Labels
// ID[DB07854D600B421F95C42615D9FAE4E4]
// Created #16-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($data : Text; $value : Text;  ...  : Text)

var $i : Integer
var $tr : Pointer

If (Count parameters:C259>2)
	
	For ($i; 1; Count parameters:C259; 2)
		
		$data:=${$i}
		$value:=${$i+1}
		
		label_data_SET($data; $value)
		
	End for 
	
Else 
	
	If (Length:C16($value)=0)
		
		$tr:=OBJECT Get pointer:C1124(Object current:K67:2)
		
		Case of 
				
				// ________________________________________
			: (Type:C295($tr->)=Is text:K8:3)\
				 | (Type:C295($tr->)=Is alpha field:K8:1)
				
				$value:=$tr->
				
				// ________________________________________
			: (Type:C295($tr->)=Is longint:K8:6)\
				 | (Type:C295($tr->)=Is integer:K8:5)\
				 | (Type:C295($tr->)=Is integer 64 bits:K8:25)\
				 | (Type:C295($tr->)=_o_Is float:K8:26)
				
				$value:=String:C10($tr->)
				
				// ________________________________________
			: (Type:C295($tr->)=Is real:K8:4)
				
				$value:=String:C10($tr->; "&xml")
				
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