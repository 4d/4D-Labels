//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_Field_drop
  // Database: 4D Labels
  // ID[1FEA1E4A1A824D509A5586011B3963C2]
  // Created #11-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_BLOB:C604($Blb_field;$Blb_table;$Blb_type)
C_BOOLEAN:C305($Boo_append;$Boo_newLine;$Boo_OK)
C_LONGINT:C283($kLon_leftOffset;$kLon_topOffset;$Lon_;$Lon_bottom;$Lon_count;$Lon_fieldID)
C_LONGINT:C283($Lon_height;$Lon_i;$Lon_left;$Lon_mouse_X;$Lon_mouse_Y;$Lon_parameters)
C_LONGINT:C283($Lon_right;$Lon_stepX;$Lon_stepY;$Lon_tableID;$Lon_textHeight;$Lon_textWidth)
C_LONGINT:C283($Lon_top;$Lon_type;$Lon_viewPortHeight;$Lon_viewPortWidth;$Lon_width;$Lon_X)
C_LONGINT:C283($Lon_Y)
C_REAL:C285($Num_cx;$Num_cy;$Num_offsetX;$Num_offsetY;$Num_rotation;$Num_tx)
C_REAL:C285($Num_ty;$Num_xScaling;$Num_xTranslation;$Num_yScaling;$Num_yTranslation;$Num_zoom)
C_TEXT:C284($Dom_buffer;$Dom_canvas;$Dom_defs;$Dom_g;$Dom_label;$Dom_object)
C_TEXT:C284($Dom_objects;$Dom_rect;$Dom_textArea;$Txt_buffer;$Txt_dragOverObject;$Txt_fontColor)
C_TEXT:C284($Txt_fontFamily;$Txt_ID;$Txt_value)
C_OBJECT:C1216($Obj_buffer;$Obj_dialog)

ARRAY LONGINT:C221($tLon_fieldIDs;0)
ARRAY LONGINT:C221($tLon_tableIDs;0)
ARRAY LONGINT:C221($tLon_types;0)
ARRAY TEXT:C222($tDom_objects;0)
ARRAY TEXT:C222($tTxt_IDs;0)

If (False:C215)
	C_BOOLEAN:C305(Editor_Field_drop ;$0)
	C_TEXT:C284(Editor_Field_drop ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Dom_label:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	GET MOUSE:C468($Lon_mouse_X;$Lon_mouse_Y;$Lon_)
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	$Dom_canvas:=OB Get:C1224($Obj_dialog;"canvas";Is text:K8:3)
	
	$Num_zoom:=Editor_Get_zoom 
	
	GET PASTEBOARD DATA:C401("com.4d.array.table";$Blb_table)
	GET PASTEBOARD DATA:C401("com.4d.array.field";$Blb_field)
	GET PASTEBOARD DATA:C401("com.4d.array.field.type";$Blb_type)
	
	$Boo_newLine:=Shift down:C543
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (BLOB size:C605($Blb_table)#0)
	
	If (BLOB size:C605($Blb_field)#0)
		
		If (BLOB size:C605($Blb_type)#0)
			
			BLOB TO VARIABLE:C533($Blb_table;$tLon_tableIDs)
			SET BLOB SIZE:C606($Blb_table;0)
			
			BLOB TO VARIABLE:C533($Blb_field;$tLon_fieldIDs)
			SET BLOB SIZE:C606($Blb_field;0)
			
			BLOB TO VARIABLE:C533($Blb_type;$tLon_types)
			SET BLOB SIZE:C606($Blb_type;0)
			
			  //local coordinates in editor
			$Lon_X:=$Lon_mouse_X-OB Get:C1224($Obj_dialog;"offset-X";Is longint:K8:6)+50
			$Lon_Y:=$Lon_mouse_Y-OB Get:C1224($Obj_dialog;"offset-Y";Is longint:K8:6)
			
			$Num_xScaling:=$Num_zoom
			$Num_yScaling:=$Num_zoom
			
			$Num_xTranslation:=$Lon_X
			$Num_yTranslation:=$Lon_Y
			
			$Dom_buffer:=SVG Find element ID by coordinates:C1054(*;"Image";$Lon_X;$Lon_Y)
			
			$Dom_buffer:=Replace string:C233($Dom_buffer;OB Get:C1224(<>label_params;"select-rect-prefix";Is text:K8:3);"";*)
			SVG GET ATTRIBUTE:C1056(*;"Image";$Dom_buffer;"editor:object-id";$Txt_dragOverObject)
			
			$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;"size")
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"width";$Lon_width)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"height";$Lon_height)
			
			$Num_offsetX:=(OB Get:C1224(<>label_params;"width";Is longint:K8:6)-$Lon_width)/2
			$Num_offsetY:=(OB Get:C1224(<>label_params;"height";Is longint:K8:6)-$Lon_height)/2
			
			$kLon_leftOffset:=OB Get:C1224(<>label_params;"left";Is longint:K8:6)
			$kLon_topOffset:=OB Get:C1224(<>label_params;"top";Is longint:K8:6)
			
			  //0,0 relative to label
			$Lon_left:=$kLon_leftOffset+$Num_offsetX
			$Lon_top:=$kLon_topOffset+$Num_offsetY
			
			OBJECT GET SUBFORM CONTAINER SIZE:C1148($Lon_viewPortWidth;$Lon_viewPortHeight)
			$Lon_viewPortHeight:=$Lon_viewPortHeight-OB Get:C1224(<>label_params;"image-left";Is longint:K8:6)
			
			$Num_cx:=$Lon_viewPortWidth/2
			$Num_cy:=$Lon_viewPortHeight/2
			
			$Num_tx:=$Num_cx-(($Lon_width*$Num_zoom)/2)
			$Num_ty:=$Num_cy-(($Lon_height*$Num_zoom)/2)
			
			$Dom_defs:=DOM Find XML element by ID:C1010($Dom_canvas;"defs")
			
			$Dom_objects:=DOM Find XML element by ID:C1010($Dom_label;"objects")
			$Lon_count:=DOM Count XML elements:C726($Dom_objects;"object")
			
			$Txt_fontFamily:=OB Get:C1224($Obj_dialog;"default-font";Is text:K8:3)
			
			$Lon_stepX:=OB Get:C1224($Obj_dialog;"step-X";Is longint:K8:6)
			$Lon_stepY:=OB Get:C1224($Obj_dialog;"step-Y";Is longint:K8:6)
			
			For ($Lon_i;1;Size of array:C274($tLon_tableIDs);1)
				
				$Lon_type:=$tLon_types{$Lon_i}
				$Lon_tableID:=$tLon_tableIDs{$Lon_i}
				$Lon_fieldID:=$tLon_fieldIDs{$Lon_i}
				
				$Txt_value:="["+Table name:C256($Lon_tableID)+"]"+Field name:C257($Lon_tableID;$Lon_fieldID)
				
				  //compute text sizes
				OB SET:C1220($Obj_buffer;\
					"value";$Txt_value;\
					"font";$Txt_fontFamily;\
					"font-size";9;\
					"style";"normal";\
					"weight";"normal";\
					"align";"start";\
					"decoration";"none")
				
				Editor_TEXT_COMPUTE_SIZE ($Obj_buffer)
				
				$Lon_textWidth:=OB Get:C1224($Obj_buffer;"width";Is longint:K8:6)
				$Lon_textHeight:=OB Get:C1224($Obj_buffer;"height";Is longint:K8:6)
				
				CLEAR VARIABLE:C89($Obj_buffer)
				
				$Boo_append:=False:C215
				
				If (Not:C34(Length:C16($Txt_dragOverObject)=0))
					
					SVG GET ATTRIBUTE:C1056(*;"Image";$Txt_dragOverObject;"editor:object-type";$Txt_buffer)
					
					If (($Txt_buffer="variable/text")\
						 & ($Lon_type#Is picture:K8:10))\
						 | (($Txt_buffer="variable/image") & ($Lon_type=Is picture:K8:10))
						
						$Boo_append:=True:C214
						
					End if 
				End if 
				
				If ($Boo_append)
					
					$Dom_object:=DOM Find XML element by ID:C1010($Dom_label;$Txt_dragOverObject)
					
					$Dom_g:=DOM Find XML element by ID:C1010($Dom_canvas;$Txt_dragOverObject)
					$Dom_rect:=DOM Find XML element by ID:C1010($Dom_canvas;$Txt_dragOverObject+"-rect")
					$Dom_textArea:=DOM Find XML element by ID:C1010($Dom_canvas;$Txt_dragOverObject+"-textArea")
					
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"left";$Lon_left)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"top";$Lon_top)
					
					SVG GET ATTRIBUTE:C1056(*;"Image";$Txt_dragOverObject+"-textArea";"4D-text";$Txt_buffer)
					
					$Txt_value:=Choose:C955($Boo_newLine;$Txt_buffer+"\n"+$Txt_value;$Txt_buffer+"+"+$Txt_value)
					
					OB SET:C1220($Obj_buffer;\
						"value";$Txt_value;\
						"font";$Txt_fontFamily;\
						"font-size";9;\
						"style";"normal";\
						"weight";"normal";\
						"align";"start";\
						"decoration";"none")
					
					Editor_TEXT_COMPUTE_SIZE ($Obj_buffer)
					
					$Lon_right:=$Lon_left+OB Get:C1224($Obj_buffer;"width";Is longint:K8:6)
					$Lon_bottom:=$Lon_top+OB Get:C1224($Obj_buffer;"height";Is longint:K8:6)
					
					CLEAR VARIABLE:C89($Obj_buffer)
					
					DOM SET XML ATTRIBUTE:C866($Dom_object;\
						"left";$Lon_left;\
						"right";$Lon_right;\
						"top";$Lon_top;\
						"bottom";$Lon_bottom;\
						"value";$Txt_value)
					
					Editor_TEXT_EDIT_SET_VALUE ($Dom_textArea;$Txt_value)
					
				Else 
					
					$Lon_left:=($Num_xTranslation/$Num_zoom)+$kLon_leftOffset-($Lon_textWidth/2)-(-$Num_offsetX+($Num_tx/$Num_xScaling))
					$Lon_top:=($Num_yTranslation/$Num_zoom)+$kLon_topOffset-($Lon_textHeight/2)-(-$Num_offsetY+($Num_ty/$Num_yScaling))
					
					$Lon_left:=$Lon_left+(($Lon_stepX*($Lon_i-1))/$Num_zoom)
					$Lon_top:=$Lon_top+(($Lon_stepY*($Lon_i-1))/$Num_zoom)
					
					$Lon_right:=$Lon_left+$Lon_textWidth
					$Lon_bottom:=$Lon_top+$Lon_textHeight
					
					$Txt_ID:=OB Get:C1224(<>label_params;"objectPrefix";Is text:K8:3)+String:C10($Lon_count+$Lon_i)
					
					$Txt_fontColor:="black"
					
					$Dom_object:=DOM Create XML element:C865($Dom_objects;"object";\
						"type";"variable";\
						"left";$Lon_left;\
						"top";$Lon_top;\
						"right";$Lon_right;\
						"bottom";$Lon_bottom;\
						"table";$Lon_tableID;\
						"field";$Lon_fieldID;\
						"field-type";$Lon_type;\
						"font-name";$Txt_fontFamily;\
						"font-size";9;\
						"font-color";$Txt_fontColor;\
						"preserve-aspect-ratio";"true";\
						"direction";"down";\
						"fill-opacity";1;\
						"stroke-opacity";1;\
						"stroke-color";"black";\
						"fill-color";"none";\
						"stroke-width";0;\
						"value";$Txt_value;\
						"style";"plain";\
						"alignment";"left";\
						"id";$Txt_ID)
					
					OB SET:C1220($Obj_buffer;\
						"type";"variable";\
						"id";$Txt_ID;\
						"canvas";$Dom_canvas;\
						"defs";$Dom_defs;\
						"x";$Lon_mouse_X;\
						"y";$Lon_mouse_Y;\
						"width";$Lon_textWidth;\
						"height";$Lon_textHeight;\
						"fill";"rgb(255,255,255)";\
						"stroke";"rgb(0,0,0)";\
						"fill-opacity";0;\
						"stroke-opacity";0;\
						"stroke-width";0;\
						"font-family";$Txt_fontFamily;\
						"font-size";9;\
						"font-style";"normal";\
						"font-weight";"normal";\
						"text-decoration";"none";\
						"text-align";"start";\
						"value";$Txt_value;\
						"field-type";$Lon_type;\
						"editor-x";$Lon_X;\
						"editor-y";$Lon_Y;\
						"editor-width";$Lon_width;\
						"editor-height";$Lon_height;\
						"x-scaling";$Num_xScaling;\
						"y-scaling";$Num_yScaling;\
						"cx";0;\
						"cy";0;\
						"r";$Num_rotation)
					
					$Dom_g:=Editor_Put_object ($Obj_buffer)
					
					CLEAR VARIABLE:C89($Obj_buffer)
					
					APPEND TO ARRAY:C911($tDom_objects;$Dom_g)
					APPEND TO ARRAY:C911($tTxt_IDs;$Txt_ID)
					
				End if 
				
				  //#ACI0096872 {
				ARRAY LONGINT:C221($tLon_t;0x0000)
				ARRAY LONGINT:C221($tLon_f;0x0000)
				
				  // #28-6-2017 [
				  //DOM GET XML ATTRIBUTE BY NAME($Dom_object;"tableList";$Txt_buffer)
				  //JSON PARSE ARRAY($Txt_buffer;$tLon_t)
				  //DOM GET XML ATTRIBUTE BY NAME($Dom_object;"fieldList";$Txt_buffer)
				  //JSON PARSE ARRAY($Txt_buffer;$tLon_f)
				xml_GET_ATTRIBUTE_BY_NAME ($Dom_object;"tableList";->$Txt_buffer)
				
				If (Length:C16($Txt_buffer)>0)
					
					JSON PARSE ARRAY:C1219($Txt_buffer;$tLon_t)
					
					xml_GET_ATTRIBUTE_BY_NAME ($Dom_object;"fieldList";->$Txt_buffer)
					
					If (Length:C16($Txt_buffer)>0)
						
						JSON PARSE ARRAY:C1219($Txt_buffer;$tLon_f)
						
					End if 
				End if 
				  //]
				
				APPEND TO ARRAY:C911($tLon_t;$Lon_tableID)
				APPEND TO ARRAY:C911($tLon_f;$Lon_fieldID)
				
				DOM SET XML ATTRIBUTE:C866($Dom_object;\
					"pairs";Size of array:C274($tLon_t);\
					"tableList";JSON Stringify array:C1228($tLon_t);\
					"fieldList";JSON Stringify array:C1228($tLon_f))
				  //}
				
			End for 
			
			If (Not:C34($Boo_append))
				
				  //manage selection
				Editor_SELECT_Clear 
				
				For ($Lon_i;1;Size of array:C274($tDom_objects);1)
					
					Editor_SELECT_OBJECT ($tDom_objects{$Lon_i};$tTxt_IDs{$Lon_i})
					
				End for 
			End if 
			
			Editor_ON_DATA_CHANGE   //do redraw
			
			$Boo_OK:=True:C214
			
		End if 
	End if 
End if 

  // ----------------------------------------------------
  // Return
$0:=$Boo_OK

  // ----------------------------------------------------
  // End