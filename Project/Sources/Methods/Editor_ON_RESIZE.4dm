//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_ON_RESIZE
  // Database: 4D Labels
  // ID[941D080CF55841B7A67A5B89BB624FF7]
  // Created #17-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($kLon_margin;$Lon_bottom;$Lon_i;$Lon_left;$Lon_offsetX;$Lon_offsetY)
C_LONGINT:C283($Lon_parameters;$Lon_right;$Lon_top;$Lon_viewPortHeight;$Lon_viewPortWidth)
C_REAL:C285($Num_cx;$Num_cy;$Num_editorSx;$Num_editorSy;$Num_editorTx;$Num_editorTy)
C_REAL:C285($Num_height;$Num_rotation;$Num_width;$Num_X;$Num_x1;$Num_x2)
C_REAL:C285($Num_xTranslation;$Num_Y;$Num_y1;$Num_y2;$Num_yTranslation;$Num_zoom)
C_REAL:C285($Num_zoomX;$Num_zoomY)
C_TEXT:C284($Dom_buffer;$Dom_canvas;$Dom_label;$Dom_objects;$kTxt_selectPrefix;$Txt_direction)
C_TEXT:C284($Txt_formName;$Txt_ID;$Txt_scale;$Txt_transform;$Txt_type)
C_OBJECT:C1216($Obj_dialog)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
	$Obj_dialog:=Editor_Get_grips (->$Dom_label;->$Dom_canvas)
	
	$kTxt_selectPrefix:=String:C10(<>label_params["select-prefix"])
	
	$kLon_margin:=20  //#TO_BE_DONE
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Length:C16($Dom_canvas)=0)
	
End if 

If (Length:C16($Dom_canvas)#0)
	
	  //close text edit if any
	Editor_TEXT_EDIT_Stop 
	
	$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;"form")
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"name";$Txt_formName)
	
	If (Length:C16($Txt_formName)>0)
		
		Editor_SET_ENABLED (False:C215)
		
		Editor_PUT_USER_FORM ($Txt_formName)
		
	Else 
		
		$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;"size")
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"width";$Num_width)
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"height";$Num_height)
		
		$Lon_offsetX:=(Num:C11(<>label_params.width)-$Num_width)/2
		$Lon_offsetY:=(Num:C11(<>label_params.height)-$Num_height)/2
		
		OBJECT GET SUBFORM CONTAINER SIZE:C1148($Lon_viewPortWidth;$Lon_viewPortHeight)
		$Lon_viewPortHeight:=$Lon_viewPortHeight-Num:C11(<>label_params["image-left"])
		
		DOM SET XML ATTRIBUTE:C866($Dom_canvas;\
			"width";$Lon_viewPortWidth;\
			"height";$Lon_viewPortHeight)
		
		$Num_zoomX:=$Lon_viewPortWidth/($Num_width+$kLon_margin)
		$Num_zoomY:=($Lon_viewPortHeight)/($Num_height+$kLon_margin)
		$Num_zoom:=Choose:C955($Num_zoomX<$Num_zoomY;$Num_zoomX;$Num_zoomY)
		
		  //keep value
		OB SET:C1220($Obj_dialog;\
			"zoom";$Num_zoom)
		
		$Num_xTranslation:=$Lon_viewPortWidth/2-(($Num_width*$Num_zoom)/2)
		$Num_yTranslation:=$Lon_viewPortHeight/2-(($Num_height*$Num_zoom)/2)
		
		$Txt_scale:=" scale("+String:C10($Num_zoom;"&xml")+","+String:C10($Num_zoom;"&xml")+")"
		$Txt_transform:="translate("+String:C10($Num_xTranslation;"&xml")+","+String:C10($Num_yTranslation;"&xml")+")"+$Txt_scale
		
		$Num_editorSx:=$Num_zoom
		$Num_editorSy:=$Num_zoom
		
		  // LABEL BACKGROUND
		DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;"label");\
			"transform";$Txt_transform;\
			"width";$Num_width;\
			"height";$Num_height)
		
		  // OBJECTS
		$Dom_objects:=DOM Find XML element by ID:C1010($Dom_label;"objects")
		
		For ($Lon_i;1;DOM Count XML elements:C726($Dom_objects;"object");1)
			
			$Dom_buffer:=DOM Find XML element:C864($Dom_objects;"objects/object["+String:C10($Lon_i)+"]")
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"id";$Txt_ID)
			
			C_TEXT:C284($t)  // #ACI0099899
			$t:=DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID)
			
			If (OK=1)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"type";$Txt_type)
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"left";$Lon_left)
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"top";$Lon_top)
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"right";$Lon_right)
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"bottom";$Lon_bottom)
				
				$Num_width:=$Lon_right-$Lon_left
				$Num_height:=$Lon_bottom-$Lon_top
				
				$Num_X:=-$Lon_offsetX+($Num_xTranslation/$Num_zoom)+$Lon_left-Num:C11(<>label_params.left)
				$Num_Y:=-$Lon_offsetY+($Num_yTranslation/$Num_zoom)+$Lon_top-Num:C11(<>label_params.top)
				
				$Num_editorTx:=(($Num_width/2)+$Num_X)*$Num_zoom
				$Num_editorTy:=(($Num_height/2)+$Num_Y)*$Num_zoom
				
				$Txt_transform:="translate("+String:C10($Num_editorTx;"&xml")+","+String:C10($Num_editorTy;"&xml")+")"+$Txt_scale
				
				$Num_X:=($Num_cx-($Num_width/2))*$Num_editorSx
				$Num_Y:=($Num_cy-($Num_height/2))*$Num_editorSy
				$Num_width:=$Num_width*$Num_editorSx
				$Num_height:=$Num_height*$Num_editorSy
				
				If ($Txt_type="line")\
					 | ($Txt_type="polyline")\
					 | ($Txt_type="text")\
					 | ($Txt_type="variable")\
					 | ($Txt_type="oval")\
					 | ($Txt_type="rect")\
					 | ($Txt_type="round-rect")\
					 | ($Txt_type="image")
					
					DOM SET XML ATTRIBUTE:C866($t;\
						"transform";$Txt_transform;\
						"editor:x";$Num_X;\
						"editor:y";$Num_Y;\
						"editor:width";$Num_width;\
						"editor:height";$Num_height;\
						"editor:tx";$Num_editorTx;\
						"editor:ty";$Num_editorTy;\
						"editor:sx";$Num_editorSx;\
						"editor:sy";$Num_editorSy;\
						"editor:cx";$Num_cx;\
						"editor:cy";$Num_cy;\
						"editor:r";$Num_rotation)
					
					Case of 
							
							  //----------------------------------------
						: ($Txt_type="line")
							
							$Num_x1:=-$Num_width/2/$Num_editorSx
							$Num_x2:=$Num_width/2/$Num_editorSx
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"direction";$Txt_direction)
							
							If ($Txt_direction="up")
								
								$Num_y1:=$Num_height/2/$Num_editorSy
								$Num_y2:=-1*($Num_height/2/$Num_editorSy)
								
							Else 
								
								$Num_y1:=-1*($Num_height/2/$Num_editorSy)
								$Num_y2:=$Num_height/2/$Num_editorSy
								
							End if 
							
							DOM SET XML ATTRIBUTE:C866($t;\
								"x1";$Num_x1;\
								"y1";$Num_y1;\
								"x2";$Num_x2;\
								"y2";$Num_y2;\
								"editor:direction";$Txt_direction)
							
							  //----------------------------------------
						: ($Txt_type="polyline")
							
							  //points are already updated
							
							  //----------------------------------------
						: ($Txt_type="text")
							
							DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID+"-textArea");\
								"x";($Num_width/2/$Num_editorSx)-($Num_width/$Num_editorSx);\
								"y";($Num_height/2/$Num_editorSy)-($Num_height/$Num_editorSy);\
								"width";$Num_width/$Num_editorSx;\
								"height";$Num_height/$Num_editorSy)
							
							DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID+"-rect");\
								"x";($Num_width/2/$Num_editorSx)-($Num_width/$Num_editorSx);\
								"y";($Num_height/2/$Num_editorSy)-($Num_height/$Num_editorSy);\
								"width";$Num_width/$Num_editorSx;\
								"height";$Num_height/$Num_editorSy)
							
							  //----------------------------------------
						: ($Txt_type="variable")
							
							DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID+"-textArea");\
								"x";($Num_width/2/$Num_editorSx)-($Num_width/$Num_editorSx);\
								"y";($Num_height/2/$Num_editorSy)-($Num_height/$Num_editorSy);\
								"width";$Num_width/$Num_editorSx;\
								"height";$Num_height/$Num_editorSy)
							
							DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID+"-rect");\
								"x";($Num_width/2/$Num_editorSx)-($Num_width/$Num_editorSx);\
								"y";($Num_height/2/$Num_editorSy)-($Num_height/$Num_editorSy);\
								"width";$Num_width/$Num_editorSx;\
								"height";$Num_height/$Num_editorSy)
							
							  //----------------------------------------
						: ($Txt_type="oval")
							
							DOM SET XML ATTRIBUTE:C866($t;\
								"rx";$Num_width/2/$Num_editorSx;\
								"ry";$Num_height/2/$Num_editorSy)
							
							  //----------------------------------------
						: ($Txt_type="rect")\
							 | ($Txt_type="round-rect")
							
							DOM SET XML ATTRIBUTE:C866($t;\
								"x";($Num_width/2/$Num_editorSx)-($Num_width/$Num_editorSx);\
								"y";($Num_height/2/$Num_editorSy)-($Num_height/$Num_editorSy);\
								"width";$Num_width/$Num_editorSx;\
								"height";$Num_height/$Num_editorSy;\
								"rx";Choose:C955($Txt_type="round-rect";Num:C11(<>label_params.defaultRoundRect);0);\
								"ry";Choose:C955($Txt_type="round-rect";Num:C11(<>label_params.defaultRoundRect);0))
							
							  //----------------------------------------
						: ($Txt_type="image")
							
							DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID+"-rect");\
								"x";($Num_width/2/$Num_editorSx)-($Num_width/$Num_editorSx);\
								"y";($Num_height/2/$Num_editorSy)-($Num_height/$Num_editorSy);\
								"width";$Num_width/$Num_editorSx;\
								"height";$Num_height/$Num_editorSy)
							
							DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID+"-image");\
								"x";($Num_width/2/$Num_editorSx)-($Num_width/$Num_editorSx);\
								"y";($Num_height/2/$Num_editorSy)-($Num_height/$Num_editorSy);\
								"width";$Num_width/$Num_editorSx;\
								"height";$Num_height/$Num_editorSy)
							
							  //----------------------------------------
					End case 
				End if 
			End if 
		End for 
		
		  //SELECTION
		For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label);1)
			
			$Txt_ID:=Editor_SELECT_Get_id ($Dom_label;$Lon_i)
			
			$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID)
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"editor:tx";$Num_xTranslation)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"editor:ty";$Num_yTranslation)
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"editor:x";$Num_X)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"editor:y";$Num_Y)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"editor:width";$Num_width)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"editor:height";$Num_height)
			
			$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_canvas;$kTxt_selectPrefix+$Txt_ID)
			
			DOM SET XML ATTRIBUTE:C866($Dom_buffer;\
				"transform";"translate("+String:C10($Num_xTranslation;"&xml")+","+String:C10($Num_yTranslation;"&xml")+")")
			
			DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;"select-rect-"+$Txt_ID);\
				"x";$Num_X;\
				"y";$Num_Y;\
				"width";$Num_width;\
				"height";$Num_height)
			
			DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;"select-tl-"+$Txt_ID);\
				"x";$Num_X-(10/2);\
				"y";$Num_Y-(10/2);\
				"width";10;\
				"height";10)
			
			DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;"select-tm-"+$Txt_ID);\
				"x";$Num_X-(10/2)+($Num_width/2);\
				"y";$Num_Y-(10/2);\
				"width";10;\
				"height";10)
			
			DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;"select-tr-"+$Txt_ID);\
				"x";$Num_X-(10/2)+$Num_width;\
				"y";$Num_Y-(10/2);\
				"width";10;\
				"height";10)
			
			DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;"select-ml-"+$Txt_ID);\
				"x";$Num_X-(10/2);\
				"y";$Num_Y-(10/2)+($Num_height/2);\
				"width";10;\
				"height";10)
			
			DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;"select-mr-"+$Txt_ID);\
				"x";$Num_X-(10/2)+$Num_width;\
				"y";$Num_Y-(10/2)+($Num_height/2);\
				"width";10;\
				"height";10)
			
			DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;"select-bl-"+$Txt_ID);\
				"x";$Num_X-(10/2);\
				"y";$Num_Y-(10/2)+$Num_height;\
				"width";10;\
				"height";10)
			
			DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;"select-bm-"+$Txt_ID);\
				"x";$Num_X-(10/2)+($Num_width/2);\
				"y";$Num_Y-(10/2)+$Num_height;\
				"width";10;\
				"height";10)
			
			DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_canvas;"select-br-"+$Txt_ID);\
				"x";$Num_X-(10/2)+$Num_width;\
				"y";$Num_Y-(10/2)+$Num_height;\
				"width";10;\
				"height";10)
			
		End for 
		
		Editor_REDRAW 
		
		Editor_SET_ENABLED (True:C214)
		
	End if 
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End