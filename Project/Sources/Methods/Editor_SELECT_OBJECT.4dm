//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_SELECT_OBJECT
// Database: 4D Labels
// ID[C53D9B2BFB914415B8FF055F91CEE673]
// Created #6-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($Dom_object : Text; $Txt_ID : Text; $clear : Boolean) : Boolean


C_LONGINT:C283($count_parameters)
C_REAL:C285($Num_editorHeight; $Num_editorTx; $Num_editorTy; $Num_editorWidth; $Num_editorX; $Num_editorY)
C_TEXT:C284($Dom_buffer; $Dom_canvas; $Dom_g; $Dom_label)
C_TEXT:C284($Txt_tranform)

ARRAY TEXT:C222($tDom_selected; 0)

//If (False)
//C_BOOLEAN(Editor_SELECT_OBJECT; $0)
//C_TEXT(Editor_SELECT_OBJECT; $1)
//C_TEXT(Editor_SELECT_OBJECT; $2)
//C_BOOLEAN(Editor_SELECT_OBJECT; $3)
//End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=2; "Missing parameter"))
	
	//Required parameters
	//$Dom_object:=$1
	//$Txt_ID:=$2
	
	//Optional parameters
	//If ($Lon_parameters>=3)
	
	//$Boo_clear:=$3  //{replace selection}
	
	//End if 
	
	Editor_Get_grips(->$Dom_label; ->$Dom_canvas)
	
	If ($clear)
		
		Editor_SELECT_Clear($Dom_label; $Dom_canvas)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "editor:x"; $Num_editorX)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "editor:y"; $Num_editorY)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "editor:width"; $Num_editorWidth)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "editor:height"; $Num_editorHeight)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "editor:tx"; $Num_editorTx)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "editor:ty"; $Num_editorTy)

$Txt_tranform:="translate("+String:C10($Num_editorTx; "&xml")+","+String:C10($Num_editorTy; "&xml")+")"

$Dom_g:=DOM Create XML element:C865($Dom_canvas; "g"; \
"id"; OB Get:C1224(<>label_params; "select-prefix"; Is text:K8:3)+$Txt_ID; \
"transform"; $Txt_tranform; \
"editor:object-type"; ""; \
"editor:object-id"; "")

$Dom_buffer:=DOM Create XML element:C865($Dom_g; "rect"; \
"id"; OB Get:C1224(<>label_params; "select-rect-prefix"; Is text:K8:3)+$Txt_ID; \
"x"; $Num_editorX; \
"y"; $Num_editorY; \
"width"; $Num_editorWidth; \
"height"; $Num_editorHeight; \
"fill"; OB Get:C1224(<>label_params; "selection-fill"; Is text:K8:3); \
"fill-opacity"; OB Get:C1224(<>label_params; "selection-fill-opacity"; Is real:K8:4); \
"stroke"; OB Get:C1224(<>label_params; "selection-stroke"; Is text:K8:3); \
"stroke-opacity"; OB Get:C1224(<>label_params; "selection-stroke-opacity"; Is real:K8:4); \
"stroke-width"; OB Get:C1224(<>label_params; "selection-stroke-width"; Is real:K8:4); \
"editor:object-type"; ""; \
"editor:object-id"; ""; \
"shape-rendering"; "crispEdges")

Editor_SEL_DISPLAY_HANDLES($Dom_g; $Txt_ID; $Num_editorX; $Num_editorY; $Num_editorWidth; $Num_editorHeight)

Editor_SELECT_APPEND((OBJECT Get pointer:C1124(Object subform container:K67:4))->; $Txt_ID)

Editor_TOOL_SET_ENABLED(True:C214)

// ----------------------------------------------------
// Return
return True:C214

// ----------------------------------------------------
// End