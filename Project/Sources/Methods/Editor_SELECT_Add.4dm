//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_SELECT_Add
// Database: 4D Labels
// ID[BBF99DAA85884E26ADF5752A8CBD2A78]
// Created #2-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Boolean
var $1 : Text
var $2 : Boolean

var $Boo_append; $Boo_update : Boolean
var $Lon_parameters : Integer
var $Dom_canvas; $Dom_container; $Dom_node; $Txt_ID; $Txt_type : Text
var $Obj_parameters : Object

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	//Required parameters
	$Txt_ID:=$1
	$Boo_append:=$2
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		// <NONE>
		
	End if 
	
	$Obj_parameters:=(OBJECT Get pointer:C1124(Object named:K67:5; "object"))->
	$Dom_canvas:=OB Get:C1224($Obj_parameters; "canvas"; Is text:K8:3)
	
	$Dom_container:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Dom_node:=DOM Find XML element by ID:C1010($Dom_canvas; $Txt_ID)

DOM GET XML ATTRIBUTE BY NAME:C728($Dom_node; "editor:object-type"; $Txt_type)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_node; "editor:object-id"; $Txt_ID)

If (Length:C16($Txt_ID)#0)
	
	$Dom_node:=DOM Find XML element by ID:C1010($Dom_canvas; $Txt_ID)
	
	If (Not:C34(Editor_SELECT_Find($Dom_container; $Txt_ID)))
		
		If (Not:C34($Boo_append))
			
			$Boo_update:=Editor_SELECT_Clear($Dom_container; $Dom_canvas)
			
		End if 
		
		Editor_SELECT($Dom_node; $Txt_ID)
		
		$Boo_update:=True:C214
		
	End if 
End if 

// ----------------------------------------------------
// Return
$0:=True:C214

// ----------------------------------------------------
// End