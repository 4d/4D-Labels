//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_Is_object
  // Database: 4D Labels
  // ID[B2988D16B89E47558B71DF98B53913EB]
  // Created #13-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_isObject)
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_buffer;$Txt_ID)

If (False:C215)
	C_BOOLEAN:C305(Editor_Is_object ;$0)
	C_TEXT:C284(Editor_Is_object ;$1)
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
SVG GET ATTRIBUTE:C1056(*;"Image";$Txt_ID;"editor:object-id";$Txt_buffer)
$Boo_isObject:=(1=Position:C15($Txt_ID;$Txt_buffer;*)) & (Length:C16($Txt_ID)=Length:C16($Txt_buffer))

  // ----------------------------------------------------
  // Return
$0:=$Boo_isObject

  // ----------------------------------------------------
  // End