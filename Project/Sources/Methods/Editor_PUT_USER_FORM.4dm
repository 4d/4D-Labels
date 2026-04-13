//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_PUT_USER_FORM
// Database: 4D Labels
// ID[EBECDF824E4C4479B3E19B1A861C8422]
// Created #2-7-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Text

var $Lon_parameters : Integer
var $p : Picture
var $Ptr_table : Pointer
var $t; $Txt_name : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	// Required parameters
	$Txt_name:=$1
	
	// Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
	$Ptr_table:=Table:C252(C_MASTER_TABLE)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

//=====================================
$t:=4D_NO_ERROR("ON")

FORM SCREENSHOT:C940($Ptr_table->; $Txt_name; $p)
(OBJECT Get pointer:C1124(Object named:K67:5; "Image"))->:=$p

//=====================================
4D_NO_ERROR("OFF"; $t)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// Endh