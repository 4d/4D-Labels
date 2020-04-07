//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_Definition_drop
  // Database: 4D Labels
  // ID[7A3178924DED430C8B150CEF957165AD]
  // Created #25-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Dom_label;$File_pasteboard)

If (False:C215)
	C_BOOLEAN:C305(Editor_Definition_drop ;$0)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
	$File_pasteboard:=Get file from pasteboard:C976(1)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If ($File_pasteboard="@.4lb")\
 | ($File_pasteboard="@.4lbp")
	
	$Dom_label:=label_Parse_document ($File_pasteboard;True:C214)
	
	If (Length:C16($Dom_label)#0)
		
		  //free memory
		DOM CLOSE XML:C722($Dom_label)
		
		C_LABEL_DOCUMENT:=$File_pasteboard
		
		$0:=True:C214
		
	End if 
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End