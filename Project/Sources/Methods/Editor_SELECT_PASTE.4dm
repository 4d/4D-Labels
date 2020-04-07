//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SELECT_PASTE
  // Database: 4D Labels
  // ID[10BCE80A69E7433D9085AA83D9658B44]
  // Created #22-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($1)

C_BLOB:C604($Blb_buffer;$Blb_image)
C_BOOLEAN:C305($Boo_duplicate)
C_LONGINT:C283($Lon_fieldType;$Lon_fillOpacity;$Lon_fontSize;$Lon_i;$Lon_objectNumber;$Lon_parameters)
C_LONGINT:C283($Lon_pasteboardCount;$Lon_pasteX;$Lon_pasteY;$Lon_rx;$Lon_ry;$Lon_strokeOpacity)
C_LONGINT:C283($Lon_viewPortHeight;$Lon_viewPortWidth)
C_PICTURE:C286($Pic_buffer)
C_REAL:C285($Num_bottom;$Num_cx;$Num_cy;$Num_editorHeight;$Num_editorWidth;$Num_editorX)
C_REAL:C285($Num_editorY;$Num_height;$Num_left;$Num_offsetX;$Num_offsetY;$Num_right)
C_REAL:C285($Num_strokeWidth;$Num_top;$Num_width;$Num_x;$Num_xScaling;$Num_xTranslation)
C_REAL:C285($Num_y;$Num_yScaling;$Num_yTranslation;$Num_zoom)
C_TEXT:C284($Dir_tempo;$Dom_buffer;$Dom_canvas;$Dom_defs;$Dom_label;$Dom_new)
C_TEXT:C284($Dom_object;$Dom_objects;$Dom_pasteboard;$Dom_pasteboardObjects;$Txt_alignment;$Txt_data)
C_TEXT:C284($Txt_direction;$Txt_extension;$Txt_fillColor;$Txt_fontName;$Txt_hash;$Txt_objectId)
C_TEXT:C284($Txt_preserveAspectRatio;$Txt_strokeColor;$Txt_style;$Txt_textValue;$Txt_type;$Txt_url)
C_OBJECT:C1216($Obj_buffer;$Obj_parameters)

ARRAY TEXT:C222($tDom_objects;0)
ARRAY TEXT:C222($tTxt_;0)
ARRAY TEXT:C222($tTxt_IDs;0)
ARRAY TEXT:C222($tTxt_names;0)
ARRAY TEXT:C222($tTxt_types;0)

If (False:C215)
	C_BOOLEAN:C305(Editor_SELECT_PASTE ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  // NO PARAMETERS REQUIRED
	
	  // Optional parameters
	If ($Lon_parameters>=1)
		
		$Boo_duplicate:=$1
		
	End if 
	
	$Obj_parameters:=Editor_Get_grips (->$Dom_label;->$Dom_canvas)
	
	$Num_zoom:=Editor_Get_zoom 
	
	$Lon_pasteX:=OB Get:C1224($Obj_parameters;"PasteX";Is longint:K8:6)
	$Lon_pasteY:=OB Get:C1224($Obj_parameters;"PasteY";Is longint:K8:6)
	
	$Dom_objects:=DOM Find XML element by ID:C1010($Dom_label;"objects")
	$Lon_objectNumber:=DOM Count XML elements:C726($Dom_objects;"object")
	
	$Dom_defs:=DOM Find XML element by ID:C1010($Dom_canvas;"defs")
	
	  // Test for private data
	If (Is macOS:C1572)
		
		  // Test on  native types
		GET PASTEBOARD DATA TYPE:C958($tTxt_;$tTxt_types)
		OK:=Num:C11(Find in array:C230($tTxt_types;"com.4d.blob.xml")>0)
		
	Else 
		
		  // Test format names
		GET PASTEBOARD DATA TYPE:C958($tTxt_;$tTxt_types;$tTxt_names)
		OK:=Num:C11(Find in array:C230($tTxt_names;"com.4d.blob.xml")>0)
		
	End if 
	
	If (OK=1)
		
		GET PASTEBOARD DATA:C401("com.4d.blob.xml";$Blb_buffer)
		
		If (OK=1)
			
			$Dom_pasteboard:=DOM Parse XML variable:C720($Blb_buffer)
			
		End if 
		
		SET BLOB SIZE:C606($Blb_buffer;0)
		
	Else 
		
		  // If not, test for a picture
		GET PICTURE FROM PASTEBOARD:C522($Pic_buffer)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (OK=1)
	
	Editor_SELECT_Clear ($Dom_label;$Dom_canvas)
	
	$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;"size")
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"width";$Num_width)
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"height";$Num_height)
	
	$Num_offsetX:=(OB Get:C1224(<>label_params;"width";Is longint:K8:6)-$Num_width)/2
	$Num_offsetY:=(OB Get:C1224(<>label_params;"height";Is longint:K8:6)-$Num_height)/2
	
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($Lon_viewPortWidth;$Lon_viewPortHeight)
	$Lon_viewPortHeight:=$Lon_viewPortHeight-OB Get:C1224(<>label_params;"image-left";Is longint:K8:6)
	
	$Num_cx:=$Lon_viewPortWidth/2
	$Num_cy:=$Lon_viewPortHeight/2
	
	$Num_xTranslation:=$Num_cx-(($Num_width*$Num_zoom)/2)
	$Num_yTranslation:=$Num_cy-(($Num_height*$Num_zoom)/2)
	
	$Num_xScaling:=$Num_zoom
	$Num_yScaling:=$Num_zoom
	
	  //#ACI0093906 [
	If (Picture size:C356($Pic_buffer)>0)
		
		Editor_Image_drop ($Dom_label;$Pic_buffer)
		
		CALL SUBFORM CONTAINER:C1086(-103)
		
	Else 
		  //]
		
		$Dom_pasteboardObjects:=DOM Find XML element by ID:C1010($Dom_pasteboard;"objects")
		$Lon_pasteboardCount:=DOM Count XML elements:C726($Dom_pasteboardObjects;"object")
		
		  // OBJECTS
		For ($Lon_i;1;$Lon_pasteboardCount;1)
			
			$Dom_object:=DOM Find XML element:C864($Dom_pasteboardObjects;"objects/object["+String:C10($Lon_i)+"]")
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"type";$Txt_type)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"left";$Num_left)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"top";$Num_top)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"right";$Num_right)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"bottom";$Num_bottom)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"stroke-color";$Txt_strokeColor)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"fill-color";$Txt_fillColor)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"stroke-width";$Num_strokeWidth)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"fill-opacity";$Lon_fillOpacity)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"stroke-opacity";$Lon_strokeOpacity)
			
			If ($Boo_duplicate)
				
				$Num_left:=$Num_left+$Lon_pasteX
				$Num_top:=$Num_top+$Lon_pasteY
				$Num_right:=$Num_right+$Lon_pasteX
				$Num_bottom:=$Num_bottom+$Lon_pasteY
				
			End if 
			
			$Dom_new:=DOM Append XML element:C1082($Dom_objects;$Dom_object)
			
			$Txt_objectId:=OB Get:C1224(<>label_params;"objectPrefix";Is text:K8:3)+String:C10($Lon_objectNumber+$Lon_i)
			
			DOM SET XML ATTRIBUTE:C866($Dom_new;\
				"id";$Txt_objectId;\
				"left";$Num_left;\
				"right";$Num_right;\
				"top";$Num_top;\
				"bottom";$Num_bottom)
			
			$Num_width:=$Num_right-$Num_left
			$Num_height:=$Num_bottom-$Num_top
			
			$Num_x:=-$Num_offsetX+($Num_xTranslation/$Num_zoom)+$Num_left-OB Get:C1224(<>label_params;"left";Is longint:K8:6)
			$Num_y:=-$Num_offsetY+($Num_yTranslation/$Num_zoom)+$Num_top-OB Get:C1224(<>label_params;"top";Is longint:K8:6)
			
			$Num_editorWidth:=$Num_width*$Num_zoom
			$Num_editorHeight:=$Num_height*$Num_zoom
			$Num_editorX:=-($Num_editorWidth/2)
			$Num_editorY:=-($Num_editorHeight/2)
			
			OB SET:C1220($Obj_buffer;\
				"type";$Txt_type;\
				"id";$Txt_objectID;\
				"canvas";$Dom_canvas;\
				"defs";$Dom_defs;\
				"x";$Num_x;\
				"y";$Num_y;\
				"width";$Num_width;\
				"height";$Num_height;\
				"editor-x";$Num_editorX;\
				"editor-y";$Num_editorY;\
				"editor-width";$Num_editorWidth;\
				"editor-height";$Num_editorHeight;\
				"x-scaling";$Num_xScaling;\
				"y-scaling";$Num_yScaling;\
				"cx";0;\
				"cy";0;\
				"r";0;\
				"fill";$Txt_fillColor;\
				"fill-opacity";$Lon_fillOpacity;\
				"stroke";$Txt_strokeColor;\
				"stroke-opacity";$Lon_strokeOpacity;\
				"stroke-width";$Num_strokeWidth)
			
			Case of 
					
					  //________________________________________
				: ($Txt_type="rect")\
					 | ($Txt_type="round-rect")
					
					If ($Txt_type="round-rect")
						
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"rx";$Lon_rx)
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"ry";$Lon_ry)
						
					End if 
					
					OB SET:C1220($Obj_buffer;\
						"rx";$Lon_rx;\
						"ry";$Lon_ry)
					
					APPEND TO ARRAY:C911($tDom_objects;Editor_Put_object ($Obj_buffer))
					APPEND TO ARRAY:C911($tTxt_IDs;$Txt_objectId)
					
					  //________________________________________
				: ($Txt_type="image")
					
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"image-hash";$Txt_hash)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"image-codec";$Txt_extension)
					
					$Dir_tempo:=Temporary folder:C486+"Label Editor Images"+Folder separator:K24:12
					
					If (Test path name:C476($Dir_tempo+$Txt_hash+$Txt_extension)#Is a document:K24:1)
						
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"image-data";$Txt_data)
						BASE64 DECODE:C896($Txt_data;$Blb_image)
						BLOB TO DOCUMENT:C526($Dir_tempo+$Txt_hash+$Txt_extension;$Blb_image)
						
					End if 
					
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"preserve-aspect-ratio";$Txt_preserveAspectRatio)
					
					  // Compatibility
					$Txt_preserveAspectRatio:=Choose:C955($Txt_preserveAspectRatio="true";"xMidYMid";$Txt_preserveAspectRatio)
					
					$Txt_url:="file:///"+Convert path system to POSIX:C1106($Dir_tempo+$Txt_hash+$Txt_extension;*)
					
					OB SET:C1220($Obj_buffer;\
						"url";$Txt_url;\
						"preserveAspectRatio";$Txt_preserveAspectRatio)
					
					APPEND TO ARRAY:C911($tDom_objects;Editor_Put_object ($Obj_buffer))
					APPEND TO ARRAY:C911($tTxt_IDs;$Txt_objectId)
					
					  //________________________________________
				: ($Txt_type="line")
					
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"direction";$Txt_direction)
					
					OB SET:C1220($Obj_buffer;\
						"direction";$Txt_direction)
					
					APPEND TO ARRAY:C911($tDom_objects;Editor_Put_object ($Obj_buffer))
					APPEND TO ARRAY:C911($tTxt_IDs;$Txt_objectId)
					
					  //________________________________________
				: ($Txt_type="polyline")
					
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"data";$Txt_data)
					
					OB SET:C1220($Obj_buffer;\
						"data";$Txt_data)
					
					APPEND TO ARRAY:C911($tDom_objects;Editor_Put_object ($Obj_buffer))
					APPEND TO ARRAY:C911($tTxt_IDs;$Txt_objectId)
					
					  //________________________________________
				: ($Txt_type="oval")
					
					APPEND TO ARRAY:C911($tDom_objects;Editor_Put_object ($Obj_buffer))
					APPEND TO ARRAY:C911($tTxt_IDs;$Txt_objectId)
					
					  //________________________________________
				: ($Txt_type="text")
					
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"value";$Txt_textValue)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"font-name";$Txt_fontName)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"font-size";$Lon_fontSize)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"style";$Txt_style)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"alignment";$Txt_alignment)
					
					OB SET:C1220($Obj_buffer;\
						"font-family";$Txt_fontName;\
						"font-size";$Lon_fontSize;\
						"font-style";Choose:C955($Txt_style="@italic@";"oblique";"normal");\
						"font-weight";Choose:C955($Txt_style="@bold@";"bold";"normal");\
						"text-decoration";Choose:C955($Txt_style="@underline@";"underline";"none");\
						"text-align";Choose:C955($Txt_alignment="center";$Txt_alignment;Choose:C955($Txt_alignment="right";"end";"start"));\
						"value";$Txt_textValue)
					
					APPEND TO ARRAY:C911($tDom_objects;Editor_Put_object ($Obj_buffer))
					APPEND TO ARRAY:C911($tTxt_IDs;$Txt_objectId)
					
					  //________________________________________
				: ($Txt_type="variable")
					
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"value";$Txt_textValue)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"font-name";$Txt_fontName)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"font-size";$Lon_fontSize)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"style";$Txt_style)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"field-type";$Lon_fieldType)
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"alignment";$Txt_alignment)
					
					OB SET:C1220($Obj_buffer;\
						"font-family";$Txt_fontName;\
						"font-size";$Lon_fontSize;\
						"font-style";Choose:C955($Txt_style="@italic@";"oblique";"normal");\
						"font-weight";Choose:C955($Txt_style="@bold@";"bold";"normal");\
						"text-decoration";Choose:C955($Txt_style="@underline@";"underline";"none");\
						"text-align";Choose:C955($Txt_alignment="center";$Txt_alignment;Choose:C955($Txt_alignment="right";"end";"start"));\
						"value";$Txt_textValue;\
						"field-type";$Lon_fieldType)
					
					APPEND TO ARRAY:C911($tDom_objects;Editor_Put_object ($Obj_buffer))
					APPEND TO ARRAY:C911($tTxt_IDs;$Txt_objectId)
					
					  //________________________________________
			End case 
		End for 
		
		DOM CLOSE XML:C722($Dom_pasteboard)
		
		For ($Lon_i;1;Size of array:C274($tDom_objects);1)
			
			Editor_SELECT_OBJECT ($tDom_objects{$Lon_i};$tTxt_IDs{$Lon_i})
			
		End for 
		
		Editor_UPDATE_UI 
		
		Editor_REDRAW 
		
		CALL SUBFORM CONTAINER:C1086(-103)
		
	End if 
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End