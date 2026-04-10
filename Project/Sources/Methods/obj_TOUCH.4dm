//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Obj_TOUCH
// Database: 4D Labels
// ID[3435E427D0454685AD24E4103F98D9AD]
// Created #7-7-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Text
C_TEXT:C284(${2})

var $Lon_i; $Lon_parameters : Integer
var $Ptr_buffer : Pointer
var $Txt_objectName : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Txt_objectName:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($Lon_i; 1; $Lon_parameters; 1)
	
	$Ptr_buffer:=OBJECT Get pointer:C1124(Object named:K67:5; ${$Lon_i})
	
	If (Not:C34(Is nil pointer:C315($Ptr_buffer)))
		
		$Ptr_buffer->:=$Ptr_buffer->
		
	End if 
End for 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End