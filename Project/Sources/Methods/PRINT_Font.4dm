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
C_TEXT:C284($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_OK)
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($kTxt_defaultFont;$Txt_buffer;$Txt_fontFamilly;$Txt_fontName)

ARRAY TEXT:C222($tTxt_font;0)

If (False:C215)
	C_TEXT:C284(PRINT_Font ;$0)
	C_TEXT:C284(PRINT_Font ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_fontFamilly:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	$kTxt_defaultFont:="Times"
	
	FONT LIST:C460($tTxt_font;System fonts:K80:1)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //must split font familly & find the first installed font

  //#TO_BE_DONE split font familly

$Txt_buffer:=Replace string:C233($Txt_fontFamilly;"'";"")

  //#TO_BE_DONE for each font, find if installed & keep the first one

$Boo_OK:=Choose:C955($Txt_buffer=".@";True:C214;(Find in array:C230($tTxt_font;$Txt_buffer)>0))

$Txt_fontName:=Choose:C955($Boo_OK;$Txt_buffer;$kTxt_defaultFont)

  // ----------------------------------------------------
  // Return
$0:=$Txt_fontName

  // ----------------------------------------------------
  // End