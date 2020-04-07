//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SET_ENABLED
  // Database: 4D Labels
  // ID[566243417CE24EE2AF7BA1ED6E6412E8]
  // Created #2-7-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($1)

C_BOOLEAN:C305($Boo_enabled)
C_LONGINT:C283($Lon_parameters)

If (False:C215)
	C_BOOLEAN:C305(Editor_SET_ENABLED ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	$Boo_enabled:=True:C214  //default is enabled
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Boo_enabled:=$1
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //toolbar
OBJECT SET ENABLED:C1123(*;"tool.@";$Boo_enabled)
OBJECT SET VISIBLE:C603(*;"action.@";$Boo_enabled)

  //shortcuts
OBJECT SET VISIBLE:C603(*;"shortcut.@";$Boo_enabled)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End