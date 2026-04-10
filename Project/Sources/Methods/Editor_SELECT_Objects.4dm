//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_SELECT_Objects
// Database: 4D Labels
// ID[4F2F9B8B5B884EC99DA7C8812716C30E]
// Created #21-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Boolean
var $1 : Real
var $2 : Real
var $3 : Real
var $4 : Real

var $Boo_redraw : Boolean
var $Lon_i; $Lon_intersectCount; $Lon_parameters; $Lon_selectedCount; $Lon_x : Integer
var $Num_height; $Num_width; $Num_x; $Num_y : Real
var $Dom_canvas; $Dom_label : Text

ARRAY TEXT:C222($tTxt_intersectID; 0)
ARRAY TEXT:C222($tTxt_selectedID; 0)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=4; "Missing parameter"))
	
	//Required parameters
	$Num_x:=$1
	$Num_y:=$2
	$Num_width:=$3
	$Num_height:=$4
	
	//Optional parameters
	If ($Lon_parameters>=5)
		
		// <NONE>
		
	End if 
	
	Editor_Get_grips(->$Dom_label; ->$Dom_canvas)
	
	Editor_SELECT_GET_LIST($Dom_label; ->$tTxt_selectedID; True:C214)
	
	$Lon_selectedCount:=Size of array:C274($tTxt_selectedID)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (SVG Find element IDs by rect:C1109(*; "Image"; $Num_x; $Num_y; $Num_width; $Num_height; $tTxt_intersectID))
	
	For ($Lon_i; 1; Size of array:C274($tTxt_intersectID); 1)
		
		If ($tTxt_intersectID{$Lon_i}#"select@")
			
			If (Editor_Is_object($tTxt_intersectID{$Lon_i}))
				
				$Lon_x:=Find in array:C230($tTxt_selectedID; $tTxt_intersectID{$Lon_i})
				
				If ($Lon_x#-1)
					
					DELETE FROM ARRAY:C228($tTxt_selectedID; $Lon_x)
					
				Else 
					
					$Boo_redraw:=True:C214
					
				End if 
				
				$Lon_intersectCount:=$Lon_intersectCount+Num:C11(Editor_SELECT_Add($tTxt_intersectID{$Lon_i}; True:C214))
				
			End if 
		End if 
	End for 
	
	$Boo_redraw:=$Boo_redraw | ($Lon_selectedCount#$Lon_intersectCount)
	
End if 

// ----------------------------------------------------
// Return
$0:=$Boo_redraw

// ----------------------------------------------------
// End