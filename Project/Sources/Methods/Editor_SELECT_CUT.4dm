//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SELECT_CUT
  // Database: 4D Labels
  // ID[BBB8725121CF4A969A004B0A347032CE]
  // Created #20-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_parameters)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Editor_SELECT_COPY 
Editor_SELECT_DELETE 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End