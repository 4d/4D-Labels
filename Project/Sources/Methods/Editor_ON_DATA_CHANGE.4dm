//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_ON_DATA_CHANGE
// Database: 4D Labels
// ID[FE588838B0C34F7B87CD1DB732F5BD1E]
// Created #19-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($1)

C_BLOB:C604($Blb_image)
C_BOOLEAN:C305($Boo_keepHistory)
C_LONGINT:C283($kLon_margin; $Lon_count; $Lon_fieldType; $Lon_fontSize; $Lon_i)
C_LONGINT:C283($Lon_rx; $Lon_ry; $Lon_viewPortHeight; $Lon_viewPortWidth)
C_PICTURE:C286($Pic_buffer)
C_REAL:C285($Num_bottom; $Num_cx; $Num_cy; $Num_editorHeight; $Num_editorWidth; $Num_editorX)
C_REAL:C285($Num_editorY; $Num_fillOpacity; $Num_height; $Num_left; $Num_offsetX; $Num_offsetY)
C_REAL:C285($Num_right; $Num_strokeOpacity; $Num_strokeWidth; $Num_top; $Num_width; $Num_x)
C_REAL:C285($Num_xScaling; $Num_xTranslation; $Num_y; $Num_yScaling; $Num_yTranslation; $Num_zoom)
C_REAL:C285($Num_zoomX; $Num_zoomY)
C_TEXT:C284($Dir_tempo; $Dom_buffer; $Dom_canvas; $Dom_defs; $Dom_form; $Dom_groups)
C_TEXT:C284($Dom_item; $Dom_label; $Dom_object; $Dom_objects; $File_picture; $Svg_root)
C_TEXT:C284($Txt_alignment; $Txt_buffer; $Txt_data; $Txt_direction; $Txt_extension; $Txt_fillColor)
C_TEXT:C284($Txt_fontName; $Txt_formName; $Txt_hash; $Txt_objectId; $Txt_preserveAspectRatio; $Txt_scale)
C_TEXT:C284($Txt_strokeColor; $Txt_style; $Txt_textValue; $Txt_transform; $Txt_translate; $Txt_type)
C_TEXT:C284($Txt_url)
C_OBJECT:C1216($Obj_buffer; $Obj_parameters)

If (False:C215)
	C_BOOLEAN:C305(Editor_ON_DATA_CHANGE; $1)
End if 

// ----------------------------------------------------
// Initialisations

//NO PARAMETERS REQUIRED

//Optional parameters
If (Count parameters:C259>=1)
	
	$Boo_keepHistory:=$1
	
End if 

$Obj_parameters:=(OBJECT Get pointer:C1124(Object named:K67:5; "object"))->
$Dom_canvas:=OB Get:C1224($Obj_parameters; "canvas"; Is text:K8:3)

//#TO_BE_DONE
$kLon_margin:=20  //OB Get(<>label_params;"label-margin";Is longint)


// ----------------------------------------------------
If (Not:C34(Is nil pointer:C315(OBJECT Get pointer:C1124(Object subform container:K67:4))))
	
	$Dom_label:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
	
	If (Length:C16($Dom_label)#0)
		
		If (OB Is defined:C1231($Obj_parameters; "currentDom"))
			
			$Txt_buffer:=OB Get:C1224($Obj_parameters; "currentDom"; Is text:K8:3)
			
		End if 
		
		If ($Txt_buffer#$Dom_label)
			
			//document has changed;
			If (Length:C16($Txt_buffer)#0)
				
				DOM CLOSE XML:C722($Txt_buffer)
				
			End if 
			
			If (Length:C16($Dom_canvas)#0)
				
				DOM CLOSE XML:C722($Dom_canvas)
				
				OB SET:C1220($Obj_parameters; \
					"canvas"; "")
				
			End if 
			
			OB SET:C1220($Obj_parameters; \
				"currentDom"; $Dom_label)
			
			$Dom_form:=DOM Find XML element by ID:C1010($Dom_label; "form")
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_form; "name"; $Txt_formName)
			
			If (Length:C16($Txt_formName)=0)
				
				$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label; "size")
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer; "width"; $Num_width)
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer; "height"; $Num_height)
				
				$Num_offsetX:=(OB Get:C1224(<>label_params; "width"; Is longint:K8:6)-$Num_width)/2
				$Num_offsetY:=(OB Get:C1224(<>label_params; "height"; Is longint:K8:6)-$Num_height)/2
				
				OBJECT GET SUBFORM CONTAINER SIZE:C1148($Lon_viewPortWidth; $Lon_viewPortHeight)
				$Lon_viewPortHeight:=$Lon_viewPortHeight-OB Get:C1224(<>label_params; "image-left"; Is longint:K8:6)
				
				$Svg_root:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg")
				
				//keep DOM reference
				OB SET:C1220($Obj_parameters; \
					"canvas"; $Svg_root)
				
				DOM SET XML ATTRIBUTE:C866($Svg_root; \
					"xmlns:svg"; "http://www.w3.org/2000/svg"; \
					"xmlns:xlink"; "http://www.w3.org/1999/xlink"; \
					"xmlns:editor"; "http://www.4d.com/2014/editor")
				
				$Dom_objects:=DOM Find XML element by ID:C1010($Dom_label; "objects")
				$Lon_count:=DOM Count XML elements:C726($Dom_objects; "object")
				
				$Dom_defs:=DOM Create XML element:C865($Svg_root; "defs"; \
					"id"; "defs")
				
				// ??
				$Dom_groups:=DOM Create XML element:C865($Dom_defs; "editor:groups"; \
					"id"; "groups")
				
				DOM SET XML ATTRIBUTE:C866($Svg_root; \
					"version"; "1.1"; \
					"id"; "svg"; \
					"width"; $Lon_viewPortWidth; \
					"height"; $Lon_viewPortHeight; \
					"viewport-fill"; "#0000FF"; \
					"viewport-fill-opacity"; 0)
				
				//LABEL BACKGROUND
				$Num_cx:=$Lon_viewPortWidth/2
				$Num_cy:=$Lon_viewPortHeight/2
				
				$Num_zoomX:=$Lon_viewPortWidth/($Num_width+$kLon_margin)
				$Num_zoomY:=$Lon_viewPortHeight/($Num_height+$kLon_margin)
				
				$Num_zoom:=Choose:C955($Num_zoomX<$Num_zoomY; $Num_zoomX; $Num_zoomY)
				
				OB SET:C1220($Obj_parameters; \
					"zoom"; $Num_zoom)  //keep value
				
				$Num_xTranslation:=$Num_cx-(($Num_width*$Num_zoom)/2)
				$Num_yTranslation:=$Num_cy-(($Num_height*$Num_zoom)/2)
				
				$Txt_translate:="translate("+String:C10($Num_xTranslation; "&xml")+","+String:C10($Num_yTranslation; "&xml")+")"
				$Txt_scale:="scale("+String:C10($Num_zoom; "&xml")+","+String:C10($Num_zoom; "&xml")+")"
				
				$Txt_transform:=$Txt_translate+" "+$Txt_scale
				
				$Dom_buffer:=DOM Append XML child node:C1080($Svg_root; XML comment:K45:8; "label background")
				
				$Dom_item:=DOM Create XML element:C865($Svg_root; "rect"; \
					"id"; "label"; \
					"x"; 0; \
					"y"; 0; \
					"rx"; 0; \
					"ry"; 0; \
					"transform"; $Txt_transform; \
					"width"; $Num_width; \
					"height"; $Num_height; \
					"fill"; "#FFFFFF"; \
					"fill-opacity"; "1"; \
					"stroke"; "#999999"; \
					"stroke-width"; 0.4; \
					"stroke-opacity"; 0.7; \
					"editor:object-type"; ""; \
					"editor:object-id"; ""; \
					"shape-rendering"; OB Get:C1224(<>label_params; "shape-rendering"; Is text:K8:3))
				
				$Num_xScaling:=$Num_zoom
				$Num_yScaling:=$Num_zoom
				
				If ($Lon_count>0)
					
					$Dom_buffer:=DOM Append XML child node:C1080($Svg_root; XML comment:K45:8; "objects")
					
				End if 
				
				//OBJECTS
				$Dom_buffer:=DOM Append XML child node:C1080($Svg_root; XML comment:K45:8; "objects")
				
				For ($Lon_i; 1; $Lon_count; 1)
					
					$Dom_object:=DOM Find XML element:C864($Dom_objects; "objects/object["+String:C10($Lon_i)+"]")
					
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "type"; $Txt_type)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "left"; $Num_left)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "top"; $Num_top)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "right"; $Num_right)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "bottom"; $Num_bottom)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "stroke-color"; $Txt_strokeColor)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "stroke-width"; $Num_strokeWidth)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "stroke-opacity"; $Num_strokeOpacity)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "fill-color"; $Txt_fillColor)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "fill-opacity"; $Num_fillOpacity)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "id"; $Txt_objectId)
					
					$Num_width:=$Num_right-$Num_left
					$Num_height:=$Num_bottom-$Num_top
					
					$Num_x:=-$Num_offsetX+($Num_xTranslation/$Num_zoom)+$Num_left-OB Get:C1224(<>label_params; "left"; Is longint:K8:6)
					$Num_y:=-$Num_offsetY+($Num_yTranslation/$Num_zoom)+$Num_top-OB Get:C1224(<>label_params; "top"; Is longint:K8:6)
					
					$Num_editorWidth:=$Num_width*$Num_zoom
					$Num_editorHeight:=$Num_height*$Num_zoom
					$Num_editorX:=-($Num_editorWidth/2)
					$Num_editorY:=-($Num_editorHeight/2)
					
					//OVERWRITES THE VALUES !!!!!!!!
					If ($Txt_type="@line")
						
						$Num_fillOpacity:=1  //no transparent lines
						$Num_strokeOpacity:=1
						
					End if 
					
					OB SET:C1220($Obj_buffer; \
						"type"; $Txt_type; \
						"id"; $Txt_objectID; \
						"canvas"; $Svg_root; \
						"defs"; $Dom_defs; \
						"x"; $Num_x; \
						"y"; $Num_y; \
						"width"; $Num_width; \
						"height"; $Num_height; \
						"editor-x"; $Num_editorX; \
						"editor-y"; $Num_editorY; \
						"editor-width"; $Num_editorWidth; \
						"editor-height"; $Num_editorHeight; \
						"x-scaling"; $Num_xScaling; \
						"y-scaling"; $Num_yScaling; \
						"cx"; 0; \
						"cy"; 0; \
						"r"; 0; \
						"fill"; $Txt_fillColor; \
						"fill-opacity"; $Num_fillOpacity; \
						"stroke"; $Txt_strokeColor; \
						"stroke-opacity"; $Num_strokeOpacity; \
						"stroke-width"; $Num_strokeWidth)
					
					Case of 
							
							//________________________________________
						: ($Txt_type="rect")\
							 | ($Txt_type="round-rect")
							
							If ($Txt_type="round-rect")
								
								DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "rx"; $Lon_rx)
								DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "ry"; $Lon_ry)
								
								OB SET:C1220($Obj_buffer; \
									"rx"; $Lon_rx; \
									"ry"; $Lon_ry)
								
							End if 
							
							$Dom_item:=Editor_Put_object($Obj_buffer)
							
							//________________________________________
						: ($Txt_type="image")
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "image-hash"; $Txt_hash)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "image-codec"; $Txt_extension)
							
							$Dir_tempo:=Temporary folder:C486+"Label Editor Images"+Folder separator:K24:12
							CREATE FOLDER:C475($Dir_tempo; *)
							
							$File_picture:=$Dir_tempo+$Txt_hash+$Txt_extension
							
							If (Test path name:C476($File_picture)#Is a document:K24:1)
								
								DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "image-data"; $Txt_data)
								BASE64 DECODE:C896($Txt_data; $Blb_image)
								BLOB TO PICTURE:C682($Blb_image; $Pic_buffer; $Txt_extension)
								WRITE PICTURE FILE:C680($File_picture; $Pic_buffer; $Txt_extension)
								
							End if 
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "preserve-aspect-ratio"; $Txt_preserveAspectRatio)
							$Txt_preserveAspectRatio:=Choose:C955($Txt_preserveAspectRatio="true"; "xMidYMid"; $Txt_preserveAspectRatio)  //compatibility
							
							$Txt_url:="file://"+Convert path system to POSIX:C1106($File_picture; *)
							
							OB SET:C1220($Obj_buffer; \
								"url"; $Txt_url; \
								"preserveAspectRatio"; $Txt_preserveAspectRatio)
							
							$Dom_item:=Editor_Put_object($Obj_buffer)
							
							//________________________________________
						: ($Txt_type="line")
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "direction"; $Txt_direction)
							
							OB SET:C1220($Obj_buffer; \
								"direction"; $Txt_direction)
							
							$Dom_item:=Editor_Put_object($Obj_buffer)
							
							//________________________________________
						: ($Txt_type="polyline")
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "data"; $Txt_data)
							
							OB SET:C1220($Obj_buffer; \
								"data"; $Txt_data)
							
							$Dom_item:=Editor_Put_object($Obj_buffer)
							
							//________________________________________
						: ($Txt_type="oval")
							
							$Dom_item:=Editor_Put_object($Obj_buffer)
							
							//________________________________________
						: ($Txt_type="text")
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "value"; $Txt_textValue)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "font-name"; $Txt_fontName)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "font-size"; $Lon_fontSize)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "style"; $Txt_style)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "alignment"; $Txt_alignment)
							
							OB SET:C1220($Obj_buffer; \
								"font-family"; $Txt_fontName; \
								"font-size"; $Lon_fontSize; \
								"font-style"; Choose:C955($Txt_style="@italic@"; "oblique"; "normal"); \
								"font-weight"; Choose:C955($Txt_style="@bold@"; "bold"; "normal"); \
								"text-decoration"; Choose:C955($Txt_style="@underline@"; "underline"; "none"); \
								"text-align"; Choose:C955($Txt_alignment="center"; $Txt_alignment; Choose:C955($Txt_alignment="right"; "end"; "start")); \
								"value"; $Txt_textValue)
							
							$Dom_item:=Editor_Put_object($Obj_buffer)
							
							//________________________________________
						: ($Txt_type="variable")
							
							//#ACI0101240 ========================================================= [
							var $t : Text
							var $j; $fieldNumber; $tableNumber : Integer
							var $c; $fields; $tables : Collection
							
							xml_GET_ATTRIBUTE_BY_NAME($Dom_object; "tableList"; ->$t)
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "value"; $Txt_textValue)
							
							
							If (Length:C16($t)>0)
								
/*
$tables:=JSON Parse($t)
								
xml_GET_ATTRIBUTE_BY_NAME($Dom_object; "fieldList"; ->$t)
$fields:=JSON Parse($t)
								
$c:=New collection
								
For ($j; 0; $tables.length-1; 1)
								
$c.push(Parse formula("[:"+String($tables[$j])+"]:"+String($fields[$j])+""))
								
End for 
								
DOM GET XML ATTRIBUTE BY NAME($Dom_object; "value"; $t)
								
var $i; $start; $plus; $linefeed; $pos : Integer
								
For ($i; 0; $c.length-1; 1)
								
If ($i=0)
								
$Txt_textValue:=$c[$i]
								
Else 
								
$pos:=$start
$plus:=Position("+"; $t; $pos)
$linefeed:=Position("\n"; $t; $pos)
								
																																								If ($linefeed>0)\
																																													 & (($plus=0) | ($plus>$linefeed))
								
$start:=$linefeed+1
$Txt_textValue:=$Txt_textValue+"\n"+$c[$i]
								
Else 
								
$start:=$plus+1
$Txt_textValue:=$Txt_textValue+"+"+$c[$i]
								
End if 
End if 
End for 
*/
								
							Else 
								
								xml_GET_ATTRIBUTE_BY_NAME($Dom_object; "table"; ->$tableNumber)
								
								If ($tableNumber#0)
									
									xml_GET_ATTRIBUTE_BY_NAME($Dom_object; "field"; ->$fieldNumber)
									$Txt_textValue:=Parse formula:C1576("[:"+String:C10($tableNumber)+"]:"+String:C10($fieldNumber)+"")
									
								Else 
									
									DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "value"; $Txt_textValue)
									$Txt_textValue:=Parse formula:C1576("[:"+String:C10($tableNumber)+"]:"+String:C10($fieldNumber)+"")
									
								End if 
								
							End if 
							
							//====================================================================== ]
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "font-name"; $Txt_fontName)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "font-size"; $Lon_fontSize)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "style"; $Txt_style)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "field-type"; $Lon_fieldType)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "alignment"; $Txt_alignment)
							
							OB SET:C1220($Obj_buffer; \
								"font-family"; $Txt_fontName; \
								"font-size"; $Lon_fontSize; \
								"font-style"; Choose:C955($Txt_style="@italic@"; "oblique"; "normal"); \
								"font-weight"; Choose:C955($Txt_style="@bold@"; "bold"; "normal"); \
								"text-decoration"; Choose:C955($Txt_style="@underline@"; "underline"; "none"); \
								"text-align"; Choose:C955($Txt_alignment="center"; $Txt_alignment; Choose:C955($Txt_alignment="right"; "end"; "start")); \
								"value"; $Txt_textValue; \
								"field-type"; $Lon_fieldType)
							
							$Dom_item:=Editor_Put_object($Obj_buffer)
							
							//________________________________________
						Else 
							
							ASSERT:C1129(False:C215; "Unknown object type: \""+$Txt_type+"\"")
							
							//________________________________________
					End case 
					
					CLEAR VARIABLE:C89($Obj_buffer)
					
				End for 
				
				//update picture
				Editor_REDRAW
				Editor_SET_ENABLED(True:C214)
				
			Else 
				
				Editor_PUT_USER_FORM($Txt_formName)
				Editor_SET_ENABLED(False:C215)
				
			End if 
			
			If (Not:C34($Boo_keepHistory))  //new document (not history)
				
				Editor_SELECT_Clear
				Editor_HISTORY_CLEAR
				
			End if 
			
		Else 
			
			Editor_ON_RESIZE
			
		End if 
		
		If (Not:C34($Boo_keepHistory))
			
			Editor_HISTORY_APPEND
			
		End if 
	End if 
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End