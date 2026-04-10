//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : PRINT_Get_image
// Database: 4D Labels
// ID[FF0C7CDA299C4F969CF8051D3387E1FC]
// Created #20-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Picture
var $1 : Text
var $2 : Text
var $3 : Text

var $Blb_base64 : Blob
var $Lon_parameters : Integer
var $Pic_image : Picture
var $Txt_codec; $Txt_data; $Txt_extension : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	//Required parameters
	
	$Txt_data:=$1
	$Txt_extension:=$2
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		$Txt_codec:=$3
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
CONVERT FROM TEXT:C1011($Txt_data; "us-ascii"; $Blb_base64)

BASE64 DECODE:C896($Blb_base64)

BLOB TO PICTURE:C682($Blb_base64; $Pic_image; $Txt_extension)

SET BLOB SIZE:C606($Blb_base64; 0)

If ($Lon_parameters>=3)
	
	CONVERT PICTURE:C1002($Pic_image; $Txt_codec)
	
End if 

// ----------------------------------------------------
// Return
$0:=$Pic_image

// ----------------------------------------------------
// End