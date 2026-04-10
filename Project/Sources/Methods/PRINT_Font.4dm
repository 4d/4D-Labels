//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : PRINT_Font
// Database: 4D Labels
// ID[A0729F9C50CC49DFAC5B1F9886FF0A7B]
// Created #21-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Text
var $1 : Text

var $Boo_OK : Boolean
var $Lon_parameters : Integer
var $kTxt_defaultFont; $Txt_buffer; $Txt_fontFamilly; $Txt_fontName : Text

ARRAY TEXT:C222($tTxt_font; 0)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Txt_fontFamilly:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
	$kTxt_defaultFont:="Times"
	
	FONT LIST:C460($tTxt_font; System fonts:K80:1)
	
	//#ACI0100864 [
	ARRAY TEXT:C222($tTxt_recent; 0)
	var $i : Integer
	FONT LIST:C460($tTxt_recent; Recent fonts:K80:3)
	
	For ($i; 1; Size of array:C274($tTxt_recent); 1)
		
		APPEND TO ARRAY:C911($tTxt_font; $tTxt_recent{$i})
		
	End for 
	//]
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
//must split font familly & find the first installed font

//#TO_BE_DONE split font familly

$Txt_buffer:=Replace string:C233($Txt_fontFamilly; "'"; "")

//#TO_BE_DONE for each font, find if installed & keep the first one

$Boo_OK:=Choose:C955($Txt_buffer=".@"; True:C214; (Find in array:C230($tTxt_font; $Txt_buffer)>0))

$Txt_fontName:=Choose:C955($Boo_OK; $Txt_buffer; $kTxt_defaultFont)

// ----------------------------------------------------
// Return
return $Txt_fontName

// ----------------------------------------------------
// End