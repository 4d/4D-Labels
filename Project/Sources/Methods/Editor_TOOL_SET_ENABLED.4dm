//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_TOOL_SET_ENABLED
  // Database: 4D Labels
  // ID[EB5B6DA29E9E44D2A65AA643FB717492]
  // Created #8-11-2016 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($1)

C_BOOLEAN:C305($Boo_enabled)
C_LONGINT:C283($Lon_parameters)

If (False:C215)
	C_BOOLEAN:C305(Editor_TOOL_SET_ENABLED ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Boo_enabled:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
OBJECT SET ENABLED:C1123(*;"Align@";$Boo_enabled)
OBJECT SET ENABLED:C1123(*;"Move@";$Boo_enabled)
OBJECT SET ENABLED:C1123(*;"Distribute@";$Boo_enabled)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End