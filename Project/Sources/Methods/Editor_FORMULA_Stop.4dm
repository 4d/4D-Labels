//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_TEXT_Stop
// Database: 4D Labels
// ID[B2670EE316C445A4BA739BD859F763B8]
// Created #9-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($Boo_update)
C_LONGINT:C283($kLon_leftOffset; $kLon_topOffset; $Lon_bottom; $Lon_height; $Lon_left; $Lon_mouseX)
C_LONGINT:C283($Lon_mouseY; $Lon_parameters; $Lon_right; $Lon_top; $Lon_viewPortHeight; $Lon_viewPortWidth)
C_LONGINT:C283($Lon_width; $Lon_xClick; $Lon_yClick)
C_REAL:C285($Num_cx; $Num_cy; $Num_editorHeight; $Num_editorWidth; $Num_editorX; $Num_editorY)
C_REAL:C285($Num_offsetX; $Num_offsetY; $Num_tx; $Num_ty; $Num_xScaling; $Num_xTranslation)
C_REAL:C285($Num_yScaling; $Num_yTranslation; $Num_zoom)
C_TEXT:C284($Dom_buffer; $Dom_canvas; $Dom_label; $Dom_object; $Dom_textArea; $Txt_buffer)
C_TEXT:C284($Txt_ID; $Txt_strokeColor; $Txt_tranform; $Txt_value)
C_OBJECT:C1216($Obj_parameters)

If (False:C215)
	C_BOOLEAN:C305(Editor_TEXT_Stop; $0)
	C_LONGINT:C283(Editor_TEXT_Stop; $1)
	C_LONGINT:C283(Editor_TEXT_Stop; $2)
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
	
	Editor_GET_CLICK(->$Lon_xClick; ->$Lon_yClick)
	
	$Obj_parameters:=(OBJECT Get pointer:C1124(Object named:K67:5; "object"))->
	$Dom_canvas:=OB Get:C1224($Obj_parameters; "canvas"; Is text:K8:3)
	
	$Dom_object:=Editor_Get_current(True:C214)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "id"; $Txt_ID)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (($Lon_mouseX=$Lon_xClick)\
 | ($Lon_mouseY=$Lon_yClick))
	
	//delete
	DOM REMOVE XML ELEMENT:C869(DOM Find XML element by ID:C1010($Dom_canvas; OB Get:C1224(<>label_params; "classPrefix"; Is text:K8:3)+$Txt_ID+"-rect"))
	DOM REMOVE XML ELEMENT:C869(DOM Find XML element by ID:C1010($Dom_canvas; OB Get:C1224(<>label_params; "classPrefix"; Is text:K8:3)+$Txt_ID+"-textArea"))
	DOM REMOVE XML ELEMENT:C869($Dom_object)
	
Else 
	
	//hide the drawing rectangle
	$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_canvas; OB Get:C1224(<>label_params; "classPrefix"; Is text:K8:3)+$Txt_ID+"-rect")
	DOM GET XML ELEMENT VALUE:C731($Dom_buffer; $Txt_buffer; $Txt_buffer)  //CDATA
	$Txt_buffer:=Replace string:C233($Txt_buffer; "stroke-opacity:1;"; "stroke-opacity:0;")
	DOM SET XML ELEMENT VALUE:C868($Dom_buffer; $Txt_buffer; *)  //CDATA
	
	$Dom_label:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
	
	$Num_zoom:=Editor_Get_zoom
	
	$kLon_leftOffset:=OB Get:C1224(<>label_params; "left"; Is longint:K8:6)
	$kLon_topOffset:=OB Get:C1224(<>label_params; "top"; Is longint:K8:6)
	
	$Num_xScaling:=$Num_zoom
	$Num_yScaling:=$Num_zoom
	
	$Lon_width:=Abs:C99($Lon_mouseX-$Lon_xClick)
	$Lon_height:=Abs:C99($Lon_mouseY-$Lon_yClick)
	
	$Num_xTranslation:=Choose:C955($Lon_mouseX>$Lon_xClick; (($Lon_width/2)+$Lon_xClick); (($Lon_width/2)+$Lon_mouseX))
	$Num_yTranslation:=Choose:C955($Lon_mouseY>$Lon_yClick; (($Lon_height/2)+$Lon_yClick); (($Lon_height/2)+$Lon_mouseY))
	
	$Num_editorWidth:=$Lon_width/$Num_xScaling
	$Num_editorHeight:=$Lon_height/$Num_yScaling
	
	$Num_editorX:=-($Num_editorWidth/2)
	$Num_editorY:=-($Num_editorHeight/2)
	
	$Lon_width:=$Num_editorWidth
	$Lon_height:=$Num_editorHeight
	
	$Txt_tranform:="translate("+String:C10($Num_xTranslation; "&xml")\
		+","+String:C10($Num_yTranslation; "&xml")+")"\
		+" scale("+String:C10($Num_xScaling; "&xml")+","+String:C10($Num_yScaling; "&xml")+")"
	
	DOM SET XML ATTRIBUTE:C866($Dom_object; \
		"transform"; $Txt_tranform; \
		"editor:x"; $Num_editorX; \
		"editor:y"; $Num_editorY; \
		"editor:width"; $Num_editorWidth; \
		"editor:height"; $Num_editorHeight; \
		"editor:tx"; $Num_xTranslation; \
		"editor:ty"; $Num_yTranslation; \
		"editor:sx"; $Num_xScaling; \
		"editor:sy"; $Num_yScaling; \
		"editor:cx"; 0; \
		"editor:cy"; 0; \
		"editor:r"; 0)
	
	$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_canvas; $Txt_ID+"-rect")
	
	DOM SET XML ATTRIBUTE:C866($Dom_buffer; \
		"x"; $Num_editorX; \
		"y"; $Num_editorY; \
		"width"; $Lon_width; \
		"height"; $Lon_height; \
		"editor:x"; $Num_editorX; \
		"editor:y"; $Num_editorY; \
		"editor:width"; $Num_editorWidth; \
		"editor:height"; $Num_editorHeight; \
		"editor:tx"; $Num_xTranslation; \
		"editor:ty"; $Num_yTranslation; \
		"editor:sx"; $Num_xScaling; \
		"editor:sy"; $Num_yScaling; \
		"editor:cx"; 0; \
		"editor:cy"; 0; \
		"editor:r"; 0)
	
	$Dom_textArea:=DOM Find XML element by ID:C1010($Dom_canvas; $Txt_ID+"-textArea")
	
	DOM SET XML ATTRIBUTE:C866($Dom_textArea; \
		"x"; $Num_editorX; \
		"y"; $Num_editorY; \
		"width"; $Lon_width; \
		"height"; $Lon_height; \
		"editor:x"; $Num_editorX; \
		"editor:y"; $Num_editorY; \
		"editor:width"; $Num_editorWidth; \
		"editor:height"; $Num_editorHeight; \
		"editor:tx"; $Num_xTranslation; \
		"editor:ty"; $Num_yTranslation; \
		"editor:sx"; $Num_xScaling; \
		"editor:sy"; $Num_yScaling; \
		"editor:cx"; 0; \
		"editor:cy"; 0; \
		"editor:r"; 0)
	
	$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label; "size")
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer; "width"; $Lon_width)
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer; "height"; $Lon_height)
	
	$Num_offsetX:=(OB Get:C1224(<>label_params; "width"; Is longint:K8:6)-$Lon_width)/2
	$Num_offsetY:=(OB Get:C1224(<>label_params; "height"; Is longint:K8:6)-$Lon_height)/2
	
	//0,0 relative to label
	$Lon_left:=$kLon_leftOffset+$Num_offsetX
	$Lon_top:=$kLon_topOffset+$Num_offsetY
	
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($Lon_viewPortWidth; $Lon_viewPortHeight)
	$Lon_viewPortHeight:=$Lon_viewPortHeight-OB Get:C1224(<>label_params; "image-left"; Is longint:K8:6)
	
	$Num_cx:=$Lon_viewPortWidth/2
	$Num_cy:=$Lon_viewPortHeight/2
	
	$Num_tx:=$Num_cx-(($Lon_width*$Num_zoom)/2)
	$Num_ty:=$Num_cy-(($Lon_height*$Num_zoom)/2)
	
	$Lon_left:=($Num_xTranslation/$Num_zoom)+$kLon_leftOffset-($Num_editorWidth/2)-(-$Num_offsetX+($Num_tx/$Num_xScaling))
	$Lon_top:=($Num_yTranslation/$Num_zoom)+$kLon_topOffset-($Num_editorHeight/2)-(-$Num_offsetY+($Num_ty/$Num_yScaling))
	
	$Lon_right:=$Lon_left+$Num_editorWidth
	$Lon_bottom:=$Lon_top+$Num_editorHeight
	
	$Txt_strokeColor:=Color_from_long(Editor_Get_color("font-color"))
	
	$Txt_value:=Localized string:C991("Labels_sampleformula")
	
	$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label; "objects")
	
	
	
	var $save_ok : Integer
	var $do_delete : Boolean
	
	$save_ok:=OK
	
	EDIT FORMULA:C806(Table:C252(C_MASTER_TABLE)->; $Txt_value)
	
	$do_delete:=OK=0
	If ($do_delete)
	Else 
		
		
		
		$Dom_buffer:=DOM Create XML element:C865($Dom_buffer; "object"; \
			"type"; "variable"; \
			"left"; $Lon_left; \
			"top"; $Lon_top; \
			"right"; $Lon_right; \
			"bottom"; $Lon_bottom; \
			"field-type"; 0; \
			"font-name"; OB Get:C1224($Obj_parameters; "default-font"; Is text:K8:3); \
			"font-color"; $Txt_strokeColor; \
			"font-size"; 9; \
			"preserve-aspect-ratio"; "false"; \
			"stroke-color"; $Txt_strokeColor; \
			"stroke-width"; Editor_Get_default_stroke_width; \
			"stroke-opacity"; 1; \
			"fill-color"; Color_from_long(Editor_Get_color("fill")); \
			"fill-opacity"; 1; \
			"direction"; "down"; \
			"value"; $Txt_value; \
			"style"; "plain"; \
			"alignment"; "left"; \
			"id"; $Txt_ID)
		
		
		Editor_TEXT_EDIT_SET_VALUE($Dom_textArea; $Txt_value)
	End if 
	
	Editor_SET_TOOL
	Editor_SELECT_OBJECT($Dom_object; $Txt_ID)
	
	If ($do_delete)
		
		Editor_SELECT_DELETE
		
	End if 
	
	OK:=$save_ok
	
	//restore select tool
	//#TO_BE_DONE - directly edit the new entry
	
	$Boo_update:=True:C214
	
End if 

Editor_REDRAW

// ----------------------------------------------------
// Return
return $Boo_update

// ----------------------------------------------------
// End