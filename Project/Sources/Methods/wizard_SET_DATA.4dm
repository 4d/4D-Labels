//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : lbw_SET_DATA
// Database: 4D Labels
// ID[DB07854D600B421F95C42615D9FAE4E4]
// Created #16-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Text
var $2 : Text
C_TEXT:C284(${3})

var $Lon_i; $Lon_parameters : Integer
var $Ptr_me : Pointer
var $Txt_data; $Txt_value : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Txt_data:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		$Txt_value:=$2
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($Lon_parameters>2)
	
	For ($Lon_i; 1; $Lon_parameters; 2)
		
		$Txt_data:=${$Lon_i}
		$Txt_value:=${$Lon_i+1}
		
		label_data_SET($Txt_data; $Txt_value)
		
	End for 
	
Else 
	
	If (Length:C16($Txt_value)=0)
		
		$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)
		
		Case of 
				
				//________________________________________
			: (Type:C295($Ptr_me->)=Is text:K8:3)\
				 | (Type:C295($Ptr_me->)=Is alpha field:K8:1)
				
				$Txt_value:=$Ptr_me->
				
				//________________________________________
			: (Type:C295($Ptr_me->)=Is longint:K8:6)\
				 | (Type:C295($Ptr_me->)=Is integer:K8:5)\
				 | (Type:C295($Ptr_me->)=Is integer 64 bits:K8:25)\
				 | (Type:C295($Ptr_me->)=_o_Is float:K8:26)
				
				$Txt_value:=String:C10($Ptr_me->)
				
				//________________________________________
			: (Type:C295($Ptr_me->)=Is real:K8:4)
				
				$Txt_value:=String:C10($Ptr_me->; "&xml")
				
				//________________________________________
			Else 
				
				//ASSERT(False)
				
				//________________________________________
		End case 
	End if 
	
	//store value
	label_data_SET($Txt_data; $Txt_value)
	
End if 

//update UI
wizard_UPDATE_UI

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End