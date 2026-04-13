//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : label_Parse_pattern
// Database: 4D Labels
// ID[534B2735468044D38023E9415DF18FEC]
// Created #7-4-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Text
var $1 : Blob

var $Blb_pattern : Blob
var $Lon_i; $Lon_parameters : Integer
var $Txt_byte; $Txt_pattern : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Blb_pattern:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
	ASSERT:C1129(BLOB size:C605($Blb_pattern)=8)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

For ($Lon_i; 0; 7; 1)
	
	$Txt_byte:="00"+Replace string:C233(String:C10($Blb_pattern{$Lon_i}; "&x"); "0x"; ""; *)
	
	If ($Lon_i#0)
		
		$Txt_pattern:=$Txt_pattern+":"
		
	End if 
	
	$Txt_pattern:=$Txt_pattern+Substring:C12($Txt_byte; Length:C16($Txt_byte)-1; 2)
	
End for 

// ----------------------------------------------------
// Return
$0:=$Txt_pattern

// ----------------------------------------------------
// End