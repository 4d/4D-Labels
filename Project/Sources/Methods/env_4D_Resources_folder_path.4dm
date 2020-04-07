//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : env_4D_Resources_folder_path
  // Database: 4D Labels
  // ID[8471613630494D63B0215B1E6F021915]
  // Created #7-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Dir_pathname;$Dir_root)

If (False:C215)
	C_TEXT:C284(env_4D_Resources_folder_path ;$0)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  // NO PARAMETERS REQUIRED
	
	  // Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Is Windows:C1573)
	
	  // Get parent path
	$Dir_root:=Path to object:C1547(Application file:C491).parentFolder
	
Else 
	
	  // Contents path
	$Dir_root:=Object to path:C1548(New object:C1471(\
		"name";"Contents";\
		"parentFolder";Application file:C491;\
		"isFolder";True:C214))
	
End if 

$Dir_pathname:=Object to path:C1548(New object:C1471(\
"name";"Resources";\
"parentFolder";$Dir_root;\
"isFolder";True:C214))

  // ----------------------------------------------------
  // Return
$0:=$Dir_pathname  // Path of 4D the Resources' folder

  // ----------------------------------------------------
  // End