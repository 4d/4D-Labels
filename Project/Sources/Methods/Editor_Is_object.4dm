//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_Is_object
// Database: 4D Labels
// ID[B2988D16B89E47558B71DF98B53913EB]
// Created #13-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Boolean
var $1 : Text

var $Boo_isObject : Boolean
var $Lon_parameters : Integer
var $Txt_buffer; $Txt_ID : Text


// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Txt_ID:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
SVG GET ATTRIBUTE:C1056(*; "Image"; $Txt_ID; "editor:object-id"; $Txt_buffer)
$Boo_isObject:=(1=Position:C15($Txt_ID; $Txt_buffer; *)) & (Length:C16($Txt_ID)=Length:C16($Txt_buffer))

// ----------------------------------------------------
// Return
$0:=$Boo_isObject

// ----------------------------------------------------
// End