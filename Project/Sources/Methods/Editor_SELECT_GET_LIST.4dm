//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_SELECT_GET_LIST
// Database: 4D Labels
// ID[698AF5EABE8448B49FEFC34C5FB59636]
// Created #13-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Text
var $2 : Pointer
var $3 : Boolean

var $Boo_clear : Boolean
var $Lon_count; $Lon_i; $Lon_parameters : Integer
var $Ptr_selectedArray : Pointer
var $Dom_buffer; $Dom_canvas; $Dom_label : Text
var $Obj_parameters : Object

ARRAY TEXT:C222($tDom_selected; 0)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	//Required parameters
	$Dom_label:=$1
	$Ptr_selectedArray:=$2
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		$Boo_clear:=$3
		
	End if 
	
	$Obj_parameters:=(OBJECT Get pointer:C1124(Object named:K67:5; "object"))->
	$Dom_canvas:=OB Get:C1224($Obj_parameters; "canvas"; Is text:K8:3)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label; "selects")
$tDom_selected{0}:=DOM Find XML element:C864($Dom_buffer; "selects/select"; $tDom_selected)

$Lon_count:=Size of array:C274($tDom_selected)
ARRAY TEXT:C222($tTxt_buffer; $Lon_count)

For ($Lon_i; 1; $Lon_count; 1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i}; "object-id"; $tTxt_buffer{$Lon_i})
	
	If ($Boo_clear)
		
		$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_canvas; OB Get:C1224(<>label_params; "select-prefix"; Is text:K8:3)+$tTxt_buffer{$Lon_i})
		
		If (xml_IsValidReference($Dom_buffer))
			
			DOM REMOVE XML ELEMENT:C869($Dom_buffer)
			
		Else 
			
			//some objects were selected when the document was saved
			
		End if 
		
		DOM REMOVE XML ELEMENT:C869($tDom_selected{$Lon_i})
		
	End if 
End for 

//%W-518.1
COPY ARRAY:C226($tTxt_buffer; $2->)
//%W+518.1

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End