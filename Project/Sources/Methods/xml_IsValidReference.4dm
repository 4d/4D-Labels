//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : xml_IsValidReference
// ID[0A18547EC8AD4F96B4C9EC4933FAA1A3]
// Created #30-6-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($Txt_reference : Text) : Boolean

var $Boo_valid : Boolean
var $Lon_parameters : Integer


// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	//$Txt_reference:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Boo_valid:=Match regex:C1019("(?mi-s)^(?!^0*$)(?:[0-9A-F]{16}){1,2}$"; $Txt_reference; 1)

// ----------------------------------------------------
// Return
return $Boo_valid

// ----------------------------------------------------
// End