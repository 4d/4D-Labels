//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : str_styledText
// Database: 4D Labels
// ID[9310DF7599B34B70A797327D9F97F20C]
// Created #20-4-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Boolean
var $1 : Text

var $Boo_styled : Boolean
var $Lon_parameters : Integer
var $Txt_buffer; $Txt_textIn : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Txt_textIn:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

If (Length:C16($Txt_textIn)#0)
	
	$Txt_buffer:=ST Get plain text:C1092($Txt_textIn)
	
	If (Length:C16($Txt_buffer)#Length:C16($Txt_textIn))
		
		$Boo_styled:=(Position:C15($Txt_buffer; $Txt_textIn; *)#1)
		
	End if 
End if 

// ----------------------------------------------------
// Return
$0:=$Boo_styled

// ----------------------------------------------------
// End