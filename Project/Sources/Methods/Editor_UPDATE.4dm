//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_UPDATE
  // Database: 4D Labels
  // ID[095960C647A54E1CBD24AAC6DF83A987]
  // Created #19-5-2015 by Vincent de Lachaux
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

Editor_REDRAW 

Editor_HISTORY_APPEND 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End