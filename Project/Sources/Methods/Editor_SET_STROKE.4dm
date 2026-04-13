//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_SET_STROKE
// Database: 4D Labels
// ID[A7938F4D819B4E63AF099E534C67EBBF]
// Created #7-1-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Integer

var $Lon_; $Lon_color; $Lon_parameters : Integer
var $Txt_name : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		$Lon_color:=$1
		
	Else 
		
		$Lon_color:=1  //default is black
		
		//bond the button to the dynamic image
		RESOLVE POINTER:C394(OBJECT Get pointer:C1124(Object named:K67:5; "stroke"); $Txt_name; $Lon_; $Lon_)
		OBJECT SET FORMAT:C236(*; "action.stroke"; ";!"+$Txt_name)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
//keep current value
OB SET:C1220((OBJECT Get pointer:C1124(Object named:K67:5; "object"))->; \
"stroke"; $Lon_color)

//update UI
Editor_UPDATE_TOOL("stroke"; $Lon_color)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End