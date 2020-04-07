//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : xml_IsValidReference
  // ID[0A18547EC8AD4F96B4C9EC4933FAA1A3]
  // Created #30-6-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_valid)
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_reference)

If (False:C215)
	C_BOOLEAN:C305(xml_IsValidReference ;$0)
	C_TEXT:C284(xml_IsValidReference ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_reference:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Boo_valid:=Match regex:C1019("(?mi-s)^(?!^0*$)(?:[0-9A-F]{16}){1,2}$";$Txt_reference;1)

  // ----------------------------------------------------
  // Return
$0:=$Boo_valid

  // ----------------------------------------------------
  // End