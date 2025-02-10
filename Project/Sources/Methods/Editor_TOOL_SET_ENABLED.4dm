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

#DECLARE($enable : Boolean)

var $count_parameters : Integer

If (False:C215)
	C_BOOLEAN:C305(Editor_TOOL_SET_ENABLED; $1)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	
	
	//Optional parameters
	If ($count_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
OBJECT SET ENABLED:C1123(*; "Align@"; $enable)
OBJECT SET ENABLED:C1123(*; "Move@"; $enable)
OBJECT SET ENABLED:C1123(*; "Distribute@"; $enable)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End