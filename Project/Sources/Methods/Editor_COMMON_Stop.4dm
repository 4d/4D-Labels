//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_COMMON_Stop
  // Database: 4D Labels
  // ID[8572B1A45F6649F3941A165309EEEA61]
  // Created #4-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($Boo_update)
C_LONGINT:C283($kLon_leftOffset;$kLon_topOffset;$Lon_bottom;$Lon_fillColor;$Lon_height;$Lon_i)
C_LONGINT:C283($Lon_left;$Lon_parameters;$Lon_right;$Lon_size;$Lon_strokeColor;$Lon_strokeWidth)
C_LONGINT:C283($Lon_top;$Lon_viewPortHeight;$Lon_viewPortWidth;$Lon_width;$Lon_X;$Lon_x1)
C_LONGINT:C283($Lon_x2;$Lon_xClick;$Lon_Y;$Lon_y1;$Lon_y2;$Lon_yClick)
C_REAL:C285($Num_cx;$Num_cy;$Num_editorHeight;$Num_editorWidth;$Num_editorX;$Num_editorY)
C_REAL:C285($Num_offsetH;$Num_offsetW;$Num_offsetX;$Num_offsetY;$Num_tx;$Num_ty)
C_REAL:C285($Num_xScaling;$Num_xTranslation;$Num_yScaling;$Num_yTranslation;$Num_zoom)
C_TEXT:C284($Dom_buffer;$Dom_canvas;$Dom_label;$Dom_object;$Txt_data;$Txt_direction)
C_TEXT:C284($Txt_fillColor;$Txt_ID;$Txt_strokeColor;$Txt_tool;$Txt_tranform)
C_OBJECT:C1216($Obj_dialog)

If (False:C215)
	C_BOOLEAN:C305(Editor_COMMON_Stop ;$0)
	C_TEXT:C284(Editor_COMMON_Stop ;$1)
	C_LONGINT:C283(Editor_COMMON_Stop ;$2)
	C_LONGINT:C283(Editor_COMMON_Stop ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=3;"Missing parameter"))
	
	  //Required parameters
	$Txt_tool:=$1
	$Lon_X:=$2
	$Lon_Y:=$3
	
	  //Optional parameters
	If ($Lon_parameters>=4)
		
		  // <NONE>
		
	End if 
	
	Editor_GET_CLICK (->$Lon_xClick;->$Lon_yClick)
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	$Dom_canvas:=OB Get:C1224($Obj_dialog;"canvas";Is text:K8:3)
	
	$Dom_object:=Editor_Get_current (True:C214)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"id";$Txt_ID)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If ($Lon_X=$Lon_xClick)\
 | ($Lon_Y=$Lon_yClick)\
 | ($Txt_data="0,0")
	
	  //delete
	DOM REMOVE XML ELEMENT:C869(DOM Find XML element by ID:C1010($Dom_canvas;OB Get:C1224(<>label_params;"classPrefix";Is text:K8:3)+$Txt_ID))
	DOM REMOVE XML ELEMENT:C869($Dom_object)
	
Else 
	
	$Dom_label:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
	
	$Num_zoom:=Editor_Get_zoom 
	
	$kLon_leftOffset:=OB Get:C1224(<>label_params;"left";Is longint:K8:6)
	$kLon_topOffset:=OB Get:C1224(<>label_params;"top";Is longint:K8:6)
	
	$Num_xScaling:=$Num_zoom
	$Num_yScaling:=$Num_zoom
	
	  //specific
	Case of 
			
			  //______________________________________________________
		: ($Txt_tool="polyline")
			
			SVG GET ATTRIBUTE:C1056(*;"Image";$Txt_ID;"points";$Txt_data)
			
			  //append the last point
			$Txt_data:=$Txt_data+" "+String:C10(($Lon_X-$Lon_xClick)/$Num_zoom;"&xml")+","+String:C10(($Lon_Y-$Lon_yClick)/$Num_zoom;"&xml")
			
			  //analyse the path
			ARRAY REAL:C219($tNum_x_relative;0x0000)
			ARRAY REAL:C219($tNum_y_relative;0x0000)
			ARRAY REAL:C219($tNum_x_absolute;0x0000)
			ARRAY REAL:C219($tNum_y_absolute;0x0000)
			ARRAY LONGINT:C221($tLon_positions;0x0000)
			ARRAY LONGINT:C221($tLon_lengths;0x0000)
			
			$tLon_positions{0}:=1
			
			While (Match regex:C1019("(-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)";$Txt_data;$tLon_positions{0};$tLon_positions;$tLon_lengths))
				
				APPEND TO ARRAY:C911($tNum_x_relative;Num:C11(Substring:C12($Txt_data;$tLon_positions{1};$tLon_lengths{1});"."))
				APPEND TO ARRAY:C911($tNum_y_relative;Num:C11(Substring:C12($Txt_data;$tLon_positions{2};$tLon_lengths{2});"."))
				
				$tLon_positions{0}:=$tLon_positions{2}+$tLon_lengths{2}
				
			End while 
			
			COPY ARRAY:C226($tNum_x_relative;$tNum_x_absolute)
			COPY ARRAY:C226($tNum_y_relative;$tNum_y_absolute)
			
			  //get width and height of the form
			SORT ARRAY:C229($tNum_x_relative)
			SORT ARRAY:C229($tNum_y_relative)
			
			$Lon_size:=Size of array:C274($tNum_x_relative)
			
			If ($Lon_size>0)
				
				$Lon_x1:=$tNum_x_relative{1}
				$Lon_y1:=$tNum_y_relative{1}
				$Lon_x2:=$tNum_x_relative{$Lon_size}
				$Lon_y2:=$tNum_y_relative{$Lon_size}
				
			End if 
			
			$Lon_width:=Abs:C99($Lon_x2-$Lon_x1)
			$Lon_height:=Abs:C99($Lon_y2-$Lon_y1)
			
			  //convert points' coordinates
			$Num_offsetW:=-$Lon_x1-($Lon_width/2)
			$Num_offsetH:=-$Lon_y1-($Lon_height/2)
			
			  //build the data
			CLEAR VARIABLE:C89($Txt_data)
			
			For ($Lon_i;1;$Lon_size;1)
				
				$tNum_x_absolute{$Lon_i}:=$tNum_x_absolute{$Lon_i}+$Num_offsetW
				$tNum_y_absolute{$Lon_i}:=$tNum_y_absolute{$Lon_i}+$Num_offsetH
				
				$Txt_data:=$Txt_data+String:C10($tNum_x_absolute{$Lon_i};"&xml")+","+String:C10($tNum_y_absolute{$Lon_i};"&xml")+" "
				
			End for 
			
			$Num_xTranslation:=$Lon_xClick-(($Num_offsetW*$Num_xScaling)-(Cos:C18(90*Degree:K30:2)*($Num_offsetH*$Num_yScaling)))
			$Num_yTranslation:=$Lon_yClick-(Sin:C17(90*Degree:K30:2)*($Num_offsetH*$Num_yScaling))
			
			$Num_editorWidth:=$Lon_width
			$Num_editorHeight:=$Lon_height
			
			$Lon_width:=$Num_editorWidth
			$Lon_height:=$Num_editorHeight
			
			  //________________________________________
		Else 
			
			$Lon_width:=Abs:C99($Lon_X-$Lon_xClick)
			$Lon_height:=Abs:C99($Lon_Y-$Lon_yClick)
			
			$Num_xTranslation:=Choose:C955($Lon_X>$Lon_xClick;($Lon_width/2)+$Lon_xClick;($Lon_width/2)+$Lon_X)
			$Num_yTranslation:=Choose:C955($Lon_Y>$Lon_yClick;($Lon_height/2)+$Lon_yClick;($Lon_height/2)+$Lon_Y)
			
			$Num_editorWidth:=$Lon_width/$Num_xScaling
			$Num_editorHeight:=$Lon_height/$Num_yScaling
			
			  //________________________________________
	End case 
	
	$Num_editorX:=-($Num_editorWidth/2)
	$Num_editorY:=-($Num_editorHeight/2)
	
	$Txt_tranform:="translate("+String:C10($Num_xTranslation;"&xml")+","+String:C10($Num_yTranslation;"&xml")+")"\
		+" scale("+String:C10($Num_xScaling;"&xml")+","+String:C10($Num_yScaling;"&xml")+")"
	
	DOM SET XML ATTRIBUTE:C866($Dom_object;\
		"transform";$Txt_tranform;\
		"editor:x";$Num_editorX;\
		"editor:y";$Num_editorY;\
		"editor:width";$Num_editorWidth;\
		"editor:height";$Num_editorHeight;\
		"editor:tx";$Num_xTranslation;\
		"editor:ty";$Num_yTranslation;\
		"editor:sx";$Num_xScaling;\
		"editor:sy";$Num_yScaling;\
		"editor:cx";0;\
		"editor:cy";0;\
		"editor:r";0)
	
	$Txt_direction:="down"
	
	  //specific
	Case of 
			
			  //______________________________________________________
		: ($Txt_tool="rect")\
			 | ($Txt_tool="round-rect")
			
			If (Shift down:C543)  //constraints
				
				If ($Num_editorWidth>$Num_editorHeight)
					
					$Num_editorHeight:=$Num_editorWidth
					
				Else 
					
					$Num_editorWidth:=$Num_editorHeight
					
				End if 
			End if 
			
			DOM SET XML ATTRIBUTE:C866($Dom_object;\
				"x";$Num_editorX;\
				"y";$Num_editorY;\
				"width";$Num_editorWidth;\
				"height";$Num_editorHeight;\
				"rx";Choose:C955($Txt_tool="round-rect";OB Get:C1224(<>label_params;"defaultRoundRect";Is longint:K8:6);0);\
				"ry";Choose:C955($Txt_tool="round-rect";OB Get:C1224(<>label_params;"defaultRoundRect";Is longint:K8:6);0))
			
			  //______________________________________________________
		: ($Txt_tool="ellipse")
			
			$Txt_tool:="oval"  //*****
			
			If (Shift down:C543)  //constraints
				
				If ($Num_editorWidth>$Num_editorHeight)
					
					$Num_editorHeight:=$Num_editorWidth
					
				Else 
					
					$Num_editorWidth:=$Num_editorHeight
					
				End if 
			End if 
			
			DOM SET XML ATTRIBUTE:C866($Dom_object;\
				"rx";$Num_editorWidth/2;\
				"ry";$Num_editorHeight/2)
			
			  //______________________________________________________
		: ($Txt_tool="line")
			
			$Lon_width:=$Num_editorWidth
			$Lon_height:=$Num_editorHeight
			
			Case of 
					
					  //----------------------------------------
				: (Shift down:C543) & False:C215  //#TO_BE_DONE constraints
					
					$Txt_direction:="down"
					
					If ($Lon_width>$Lon_height)
						
						$Lon_x2:=$Lon_width
						
					Else 
						
						$Lon_y2:=$Lon_height
						
					End if 
					
					  //----------------------------------------
				: ($Lon_X>$Lon_xClick)\
					 & ($Lon_Y>$Lon_yClick)  //br
					
					$Txt_direction:="down"
					
					$Lon_x1:=-($Lon_width/2)
					$Lon_x2:=-$Lon_x1
					$Lon_y1:=-($Lon_height/2)
					$Lon_y2:=-$Lon_y1
					
					  //----------------------------------------
				: ($Lon_X>$Lon_xClick)\
					 & ($Lon_Y<$Lon_yClick)  //tr
					
					$Txt_direction:="up"
					
					$Lon_x1:=-($Lon_width/2)
					$Lon_x2:=-$Lon_x1
					$Lon_y2:=-($Lon_height/2)
					$Lon_y1:=-$Lon_y2
					
					  //----------------------------------------
				: ($Lon_X<$Lon_xClick)\
					 & ($Lon_Y>$Lon_yClick)  //bl
					
					$Txt_direction:="up"
					
					$Lon_x2:=-($Lon_width/2)
					$Lon_x1:=-$Lon_x2
					$Lon_y1:=-($Lon_height/2)
					$Lon_y2:=-$Lon_y1
					
					  //----------------------------------------
				: ($Lon_X<$Lon_xClick)\
					 & ($Lon_Y<$Lon_yClick)  //tl
					
					$Txt_direction:="down"
					
					$Lon_x2:=-($Lon_width/2)
					$Lon_x1:=-$Lon_x2
					$Lon_y2:=-($Lon_height/2)
					$Lon_y1:=-$Lon_y2
					
					  //----------------------------------------
				: ($Lon_X=$Lon_xClick)  //vertical
					
					Case of 
							
							  //……………………………………………………………
						: ($Lon_Y<$Lon_yClick)  //bottom to top
							
							$Txt_direction:="down"
							
							$Lon_y1:=-($Lon_height/2)
							$Lon_y2:=-$Lon_y1
							
							  //……………………………………………………………
						: ($Lon_Y>$Lon_yClick)  //top to bottom
							
							$Txt_direction:="up"
							
							$Lon_y2:=-($Lon_height/2)
							$Lon_y1:=-$Lon_y2
							
							  //……………………………………………………………
					End case 
					
					  //----------------------------------------
				: ($Lon_Y=$Lon_yClick)  //horizontal
					
					$Txt_direction:="down"
					
					Case of 
							
							  //……………………………………………………………
						: ($Lon_X<$Lon_xClick)  //right to left
							
							$Lon_x2:=-($Lon_width/2)
							$Lon_x1:=-$Lon_x2
							
							  //……………………………………………………………
						: ($Lon_X>$Lon_xClick)  //left to right
							
							$Lon_x1:=-($Lon_width/2)
							$Lon_x2:=-$Lon_x1
							
							  //……………………………………………………………
					End case 
					
					  //----------------------------------------
			End case 
			
			DOM SET XML ATTRIBUTE:C866($Dom_object;\
				"x1";$Lon_x1;\
				"y1";$Lon_y1;\
				"x2";$Lon_x2;\
				"y2";$Lon_y2;\
				"editor:direction";$Txt_direction)
			
			  //______________________________________________________
		: ($Txt_tool="polyline")
			
			DOM SET XML ATTRIBUTE:C866($Dom_object;\
				"points";$Txt_data)
			
			  //______________________________________________________
		Else 
			
			ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_tool+"\"")
			
			  //______________________________________________________
	End case 
	
	$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;"size")
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"width";$Lon_width)
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"height";$Lon_height)
	
	$Num_offsetX:=(OB Get:C1224(<>label_params;"width";Is longint:K8:6)-$Lon_width)/2
	$Num_offsetY:=(OB Get:C1224(<>label_params;"height";Is longint:K8:6)-$Lon_height)/2
	
	  //0,0 relative to label
	$Lon_left:=$kLon_leftOffset+$Num_offsetX
	$Lon_top:=$kLon_topOffset+$Num_offsetY
	
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($Lon_viewPortWidth;$Lon_viewPortHeight)
	$Lon_viewPortHeight:=$Lon_viewPortHeight-OB Get:C1224(<>label_params;"image-left";Is longint:K8:6)
	
	$Num_cx:=$Lon_viewPortWidth/2
	$Num_cy:=$Lon_viewPortHeight/2
	
	$Num_tx:=$Num_cx-(($Lon_width*$Num_zoom)/2)
	$Num_ty:=$Num_cy-(($Lon_height*$Num_zoom)/2)
	
	$Lon_left:=($Num_xTranslation/$Num_zoom)+$kLon_leftOffset-($Num_editorWidth/2)-(-$Num_offsetX+($Num_tx/$Num_xScaling))
	$Lon_top:=($Num_yTranslation/$Num_zoom)+$kLon_topOffset-($Num_editorHeight/2)-(-$Num_offsetY+($Num_ty/$Num_yScaling))
	
	$Lon_right:=$Lon_left+$Num_editorWidth
	$Lon_bottom:=$Lon_top+$Num_editorHeight
	
	$Lon_fillColor:=Editor_Get_color ("fill")
	$Txt_fillColor:=Color_from_long ($Lon_fillColor)
	
	$Lon_strokeColor:=Editor_Get_color ("stroke")
	$Txt_strokeColor:=Color_from_long ($Lon_strokeColor)
	$Lon_strokeWidth:=Editor_Get_default_stroke_width 
	
	$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;"objects")
	$Dom_buffer:=DOM Create XML element:C865($Dom_buffer;"object";\
		"type";$Txt_tool;\
		"left";$Lon_left;\
		"top";$Lon_top;\
		"right";$Lon_right;\
		"bottom";$Lon_bottom;\
		"field-type";0;\
		"font-name";OB Get:C1224($Obj_dialog;"default-font";Is text:K8:3);\
		"font-size";9;\
		"direction";$Txt_direction;\
		"preserve-aspect-ratio";"false";\
		"stroke-color";$Txt_strokeColor;\
		"stroke-opacity";1;\
		"fill-color";$Txt_fillColor;\
		"fill-opacity";1;\
		"stroke-width";$Lon_strokeWidth;\
		"style";"plain";\
		"alignment";"left";\
		"id";$Txt_ID)
	
	  // #ACI0100054 {
	Case of 
			
			  //______________________________________________________
		: ($Txt_tool="round-rect")
			
			C_LONGINT:C283($Lon_rx;$Lon_ry)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"rx";$Lon_rx)
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"ry";$Lon_ry)
			
			DOM SET XML ATTRIBUTE:C866($Dom_buffer;\
				"rx";$Lon_rx;\
				"ry";$Lon_ry)
			
			  //______________________________________________________
		: ($Txt_tool="polyline")
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"points";$Txt_data)
			DOM SET XML ATTRIBUTE:C866($Dom_buffer;\
				"points";$Txt_data)
			
			  //______________________________________________________
	End case   //}
	
	  //restore select tool
	Editor_SET_TOOL 
	
	  //manage selection
	Editor_SELECT_OBJECT ($Dom_object;$Txt_ID;True:C214)
	
	$Boo_update:=True:C214
	
End if 

Editor_REDRAW 

  // ----------------------------------------------------
  // Return
$0:=$Boo_update

  // ----------------------------------------------------
  // End