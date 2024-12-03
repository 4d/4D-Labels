//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : xml_GET_ATTRIBUTE_BY_NAME
// Database: 4D Labels
// ID[1DA6CCC62BC7451BA04319B54F3243AE]
// Created #3-7-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($Dom_ref : Text; $Txt_attribute : Text; $Ptr_value : Pointer)

//C_TEXT($1)
//C_TEXT($2)
//C_POINTER($3)

var $Lon_i; $Lon_parameters : Integer
var $Txt_; $Txt_name : Text

//If (False)
//C_TEXT(xml_GET_ATTRIBUTE_BY_NAME; $1)
//C_TEXT(xml_GET_ATTRIBUTE_BY_NAME; $2)
//C_POINTER(xml_GET_ATTRIBUTE_BY_NAME; $3)
//End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=3; "Missing parameter"))
	
	//Required parameters
	//$Dom_ref:=$1
	//$Txt_attribute:=$2
	//$Ptr_value:=$3
	
	//Optional parameters
	If ($Lon_parameters>=4)
		
		// <NONE>
		
	End if 
	
	CLEAR VARIABLE:C89($Ptr_value->)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($Lon_i; 1; DOM Count XML attributes:C727($Dom_ref); 1)
	
	DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_ref; $Lon_i; $Txt_name; $Txt_)
	
	If ($Txt_name=$Txt_attribute)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_ref; $Txt_attribute; $Ptr_value->)
		$Lon_i:=MAXLONG:K35:2-1
		
	End if 
End for 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End