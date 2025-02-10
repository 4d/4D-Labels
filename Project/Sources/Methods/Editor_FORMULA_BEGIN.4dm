//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_TEXT_BEGIN
// Database: 4D Labels
// ID[26256239D0DD487ABADDA956A381890F]
// Created #6-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($Lon_mouseX; $Lon_mouseY; $Lon_parameters)
C_TEXT:C284($Dom_canvas; $Dom_g; $Dom_label; $Dom_node; $Dom_objects; $Txt_buffer)
C_TEXT:C284($Txt_class; $Txt_color; $Txt_objectID; $Txt_style; $Txt_tool; $Txt_transform)
C_OBJECT:C1216($Obj_parameters)

If (False:C215)
	C_LONGINT:C283(Editor_TEXT_BEGIN; $1)
	C_LONGINT:C283(Editor_TEXT_BEGIN; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	//Required parameters
	$Lon_mouseX:=$1
	$Lon_mouseY:=$2
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		// <NONE>
		
	End if 
	
	$Obj_parameters:=Editor_Get_grips(->$Dom_label; ->$Dom_canvas)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Length:C16($Dom_canvas)#0)
	
	Editor_SELECT_Clear($Dom_label; $Dom_canvas)
	
	$Txt_buffer:=Editor_SELECT_Get_dragger(True:C214)
	
	$Dom_objects:=DOM Find XML element by ID:C1010($Dom_label; "objects")
	$Txt_objectID:=OB Get:C1224(<>label_params; "objectPrefix"; Is text:K8:3)+String:C10(DOM Count XML elements:C726($Dom_objects; "object")+1)
	
	$Txt_transform:="translate("+String:C10($Lon_mouseX; "&xml")+","+String:C10($Lon_mouseY; "&xml")+")"
	
	$Txt_tool:="variable/text"
	
	//this complex object must be included into a group for future manipulations
	$Dom_g:=DOM Create XML element:C865($Dom_canvas; "g"; \
		"id"; $Txt_objectID; \
		"editor:group"; ""; \
		"editor:object-type"; $Txt_tool; \
		"editor:object-id"; $Txt_objectID; \
		"editor:x"; 0; \
		"editor:y"; 0; \
		"editor:width"; 0; \
		"editor:height"; 0; \
		"editor:tx"; $Lon_mouseX; \
		"editor:ty"; $Lon_mouseY; \
		"editor:sx"; 1; \
		"editor:sy"; 1; \
		"editor:cx"; 0; \
		"editor:cy"; 0; \
		"editor:r"; 0; \
		"transform"; $Txt_transform)
	
	//a rectangle for the background of the textArea
	$Txt_class:=OB Get:C1224(<>label_params; "classPrefix"; Is text:K8:3)+$Txt_objectID+"-rect"
	
	If (False:C215)  //no background for text
		$Txt_style:="fill:"+Color_from_long(Editor_Get_color("fill"))\
			+";fill-opacity:1"\
			+";stroke:gray"\
			+";stroke-width:0.5"\
			+";stroke-opacity:1"\
			+";stroke-linejoin:"+OB Get:C1224(<>label_params; "stroke-linejoin"; Is text:K8:3)\
			+";stroke-dasharray:1"
		
	Else 
		
		$Txt_style:="fill:none"\
			+";fill-opacity:1"\
			+";stroke:gray"\
			+";stroke-width:0.5"\
			+";stroke-opacity:1"\
			+";stroke-linejoin:"+OB Get:C1224(<>label_params; "stroke-linejoin"; Is text:K8:3)\
			+";stroke-dasharray:1"
	End if 
	
	Editor_ADD_STYLE($Dom_canvas; $Txt_class; $Txt_style)
	
	$Dom_node:=DOM Create XML element:C865($Dom_g; "rect"; \
		"id"; $Txt_objectID+"-rect"; \
		"class"; $Txt_class; \
		"x"; 0; \
		"y"; 0; \
		"width"; 0; \
		"height"; 0; \
		"editor:object-type"; $Txt_tool; \
		"editor:object-id"; $Txt_objectID; \
		"shape-rendering"; OB Get:C1224(<>label_params; "shape-rendering"; Is text:K8:3))
	
	//the textArea
	$Txt_class:=OB Get:C1224(<>label_params; "classPrefix"; Is text:K8:3)+$Txt_objectID+"-textArea"
	
	//$Txt_color:=Color_from_long (Editor_Get_color ("stroke"))
	$Txt_color:="black"
	
	$Txt_style:="fill:"+$Txt_color\
		+";fill-opacity:1"\
		+";stroke:"+$Txt_color\
		+";stroke-width:1"\
		+";stroke-opacity:1"\
		+";font-size:9"\
		+";text-decoration:none"\
		+";text-align:start"\
		+";font-weight:normal"\
		+";font-style:normal"\
		+";font-family:"+OB Get:C1224($Obj_parameters; "default-font"; Is text:K8:3)
	
	Editor_ADD_STYLE($Dom_canvas; $Txt_class; $Txt_style)
	
	$Dom_node:=DOM Create XML element:C865($Dom_g; "textArea"; \
		"id"; $Txt_objectID+"-textArea"; \
		"class"; $Txt_class; \
		"x"; 0; \
		"y"; 0; \
		"width"; 0; \
		"height"; 0; \
		"editor:group"; ""; \
		"editor:object-type"; $Txt_tool; \
		"editor:object-id"; $Txt_objectID; \
		"editor:x"; 0; \
		"editor:y"; 0; \
		"editor:width"; 0; \
		"editor:height"; 0; \
		"editor:tx"; $Lon_mouseX; \
		"editor:ty"; $Lon_mouseY; \
		"editor:sx"; 1; \
		"editor:sy"; 1; \
		"editor:cx"; 0; \
		"editor:cy"; 0; \
		"editor:r"; 0; \
		"text-rendering"; OB Get:C1224(<>label_params; "text-rendering"; Is text:K8:3))
	
	Editor_SET_CURRENT($Dom_g)
	
	SET TIMER:C645(-1)
	
	Editor_REDRAW
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End