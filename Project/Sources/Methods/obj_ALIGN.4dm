//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Obj_ALIGN
// Database: 4D Report
// ID[C4AC2C9B6DBB43FBA2AEC05C5201C0F8]
// Created #20-1-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Integer
var $2 : Integer
var $3 : Text
var $4 : Text
C_TEXT:C284(${5})

var $Lon_; $Lon_align; $Lon_bottom; $Lon_i; $Lon_left; $Lon_offset : Integer
var $Lon_parameters; $Lon_right; $Lon_top : Integer
var $Txt_object; $Txt_reference : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=4; "Missing parameter"))
	
	//Required parameters
	$Lon_align:=$1
	$Lon_offset:=$2
	$Txt_reference:=$3
	
	//Optional parameters
	If ($Lon_parameters>=5)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
OBJECT GET COORDINATES:C663(*; $Txt_reference; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)

Case of 
		
		//______________________________________________________
	: ($Lon_align=Align right:K42:4)
		
		For ($Lon_i; 4; $Lon_parameters; 1)
			
			$Txt_object:=${$Lon_i}
			OBJECT GET COORDINATES:C663(*; $Txt_object; $Lon_; $Lon_; $Lon_right; $Lon_)
			OBJECT MOVE:C664(*; $Txt_object; ($Lon_left-$Lon_right)-20; 0)
			
		End for 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215)  //#TO_BE_DONE
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End