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
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_styled)
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_buffer;$Txt_textIn)

If (False:C215)
	C_BOOLEAN:C305(str_styledText ;$0)
	C_TEXT:C284(str_styledText ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
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
		
		$Boo_styled:=(Position:C15($Txt_buffer;$Txt_textIn;*)#1)
		
	End if 
End if 

  // ----------------------------------------------------
  // Return
$0:=$Boo_styled

  // ----------------------------------------------------
  // End