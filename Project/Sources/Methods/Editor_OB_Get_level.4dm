//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_OB_Get_level
// Database: 4D Labels
// ID[CEDA30A0EA434CCFB3831C04523FCACF]
// Created #18-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Integer
var $1 : Text

var $Lon_level; $Lon_parameters : Integer
var $Txt_ID : Text

ARRAY LONGINT:C221($tLon_length; 0)
ARRAY LONGINT:C221($tLon_position; 0)

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
If (Match regex:C1019("object-([\\d]+)"; $Txt_ID; 1; $tLon_position; $tLon_length))
	
	$Lon_level:=Num:C11(Substring:C12($Txt_ID; $tLon_position{1}; $tLon_length{1}))
	
End if 

// ----------------------------------------------------
// Return
$0:=$Lon_level

// ----------------------------------------------------
// End