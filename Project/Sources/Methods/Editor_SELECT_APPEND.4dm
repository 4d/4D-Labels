//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SELECT_APPEND
  // Database: 4D Labels
  // ID[60E515280FFB4371A1A746552B98B78E]
  // Created #20-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Dom_buffer;$Dom_label;$Txt_ID)

If (False:C215)
	C_TEXT:C284(Editor_SELECT_APPEND ;$1)
	C_TEXT:C284(Editor_SELECT_APPEND ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Dom_label:=$1
	$Txt_ID:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;"selects")
$Dom_buffer:=DOM Create XML element:C865($Dom_buffer;"select";\
"object-id";$Txt_ID)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End