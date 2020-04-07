//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SELECT_HANDLE
  // Database: 4D Labels
  // ID[44F69A97302F4C1FBA261187E63F51A2]
  // Created #25-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_ID)

If (False:C215)
	C_TEXT:C284(Editor_SELECT_HANDLE ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
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
If (Match regex:C1019("select-.{2}-object-[\\d]+";$Txt_ID))
	
	Editor_SET_HANDLE ($Txt_ID)
	
Else 
	
	Editor_SET_HANDLE 
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End