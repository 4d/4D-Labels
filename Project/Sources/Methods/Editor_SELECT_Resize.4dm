//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SELECT_Resize
  // Database: 4D Labels
  // ID[414BBB2F432A4948A81A03AD27F8493A]
  // Created #20-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_REAL:C285($2)
C_REAL:C285($3)
C_BOOLEAN:C305($4)

C_BOOLEAN:C305($Boo_changeDirection;$Boo_flipX;$Boo_flipY;$Boo_redraw;$Boo_update)
C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_start)
C_POINTER:C301($Ptr_image)
C_REAL:C285($Num_bottom;$Num_buffer;$Num_currentHeight;$Num_currentWidth;$Num_cx;$Num_cy)
C_REAL:C285($Num_height;$Num_left;$Num_moveX;$Num_moveY;$Num_offsetX;$Num_offsetY)
C_REAL:C285($Num_r;$Num_ratioH;$Num_ratioW;$Num_right;$Num_sx;$Num_sy)
C_REAL:C285($Num_top;$Num_tx;$Num_ty;$Num_width;$Num_x;$Num_x1)
C_REAL:C285($Num_x2;$Num_y;$Num_y1;$Num_y2)
C_TEXT:C284($Dom_canvas;$Dom_current;$Dom_object;$Txt_BLId;$Txt_BMId;$Txt_BRId)
C_TEXT:C284($Txt_direction;$Txt_handleId;$Txt_ID;$Txt_MLId;$Txt_MRId;$Txt_objectType)
C_TEXT:C284($Txt_points;$Txt_rotate;$Txt_scale;$Txt_selectId;$Txt_selectRectId;$Txt_TLId)
C_TEXT:C284($Txt_TMId;$Txt_translate;$Txt_TRId)
C_OBJECT:C1216($Obj_parameters)

If (False:C215)
	C_BOOLEAN:C305(Editor_SELECT_Resize ;$0)
	C_TEXT:C284(Editor_SELECT_Resize ;$1)
	C_REAL:C285(Editor_SELECT_Resize ;$2)
	C_REAL:C285(Editor_SELECT_Resize ;$3)
	C_BOOLEAN:C305(Editor_SELECT_Resize ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=4;"Missing parameter"))
	
	  //Required parameters
	$Txt_ID:=$1
	$Num_moveX:=$2
	$Num_moveY:=$3
	$Boo_redraw:=$4
	
	  //Optional parameters
	If ($Lon_parameters>=5)
		
		  // <NONE>
		
	End if 
	
	$Obj_parameters:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	$Dom_canvas:=OB Get:C1224($Obj_parameters;"canvas";Is text:K8:3)
	
	$Dom_current:=DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID)
	
	$Ptr_image:=OBJECT Get pointer:C1124(Object named:K67:5;"Image")
	
	$Txt_selectId:=OB Get:C1224(<>label_params;"select-prefix";Is text:K8:3)+$Txt_ID
	$Txt_selectRectId:=OB Get:C1224(<>label_params;"select-rect-prefix";Is text:K8:3)+$Txt_ID
	
	$Txt_TLId:="select-tl-"+$Txt_ID
	$Txt_TMId:="select-tm-"+$Txt_ID
	$Txt_TRId:="select-tr-"+$Txt_ID
	$Txt_MLId:="select-ml-"+$Txt_ID
	$Txt_MRId:="select-mr-"+$Txt_ID
	$Txt_BLId:="select-bl-"+$Txt_ID
	$Txt_BMId:="select-bm-"+$Txt_ID
	$Txt_BRId:="select-br-"+$Txt_ID
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:tx";$Num_tx)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:ty";$Num_ty)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:sx";$Num_sx)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:sy";$Num_sy)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:cx";$Num_cx)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:cy";$Num_cy)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:r";$Num_r)

DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:object-type";$Txt_objectType)

  //DOM GET XML ATTRIBUTE BY NAME($Dom_current;"editor:object-id";$objectId)

DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:x";$Num_x)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:y";$Num_y)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:width";$Num_width)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:height";$Num_height)

$Txt_handleId:=Substring:C12(Editor_Get_handle ;8;2)

$Num_offsetX:=num_not_INF ((Cos:C18(($Num_r)*Degree:K30:2)*$Num_moveX)+(Sin:C17(($Num_r)*Degree:K30:2)*$Num_moveY))
$Num_offsetY:=num_not_INF ((Cos:C18(($Num_r)*Degree:K30:2)*$Num_moveY)+(-Sin:C17(($Num_r)*Degree:K30:2)*$Num_moveX))

$Num_offsetX:=$Num_offsetX*$Num_sx
$Num_offsetY:=$Num_offsetY*$Num_sy

Case of 
		
		  //________________________________________
	: ($Txt_handleId="tl")
		
		$Num_height:=$Num_height-$Num_offsetY
		$Num_y:=-($Num_height/2)
		$Num_width:=$Num_width-$Num_offsetX
		$Num_x:=-($Num_width/2)
		
		$Num_tx:=$Num_tx+num_not_INF (-(($Num_offsetY/2)*Sin:C17(($Num_r)*Degree:K30:2))+(($Num_offsetX/2)*Cos:C18(($Num_r)*Degree:K30:2)))
		$Num_ty:=$Num_ty+num_not_INF ((($Num_offsetY/2)*Cos:C18(($Num_r)*Degree:K30:2))+(($Num_offsetX/2)*Sin:C17(($Num_r)*Degree:K30:2)))
		
		  //________________________________________
	: ($Txt_handleId="tm")
		
		$Num_height:=$Num_height-$Num_offsetY
		$Num_y:=-($Num_height/2)
		
		$Num_tx:=$Num_tx-num_not_INF (($Num_offsetY/2)*Sin:C17(($Num_r)*Degree:K30:2))
		$Num_ty:=$Num_ty+num_not_INF (($Num_offsetY/2)*Cos:C18(($Num_r)*Degree:K30:2))
		
		  //________________________________________
	: ($Txt_handleId="tr")
		
		$Num_height:=$Num_height-$Num_offsetY
		$Num_y:=-($Num_height/2)
		$Num_width:=$Num_width+$Num_offsetX
		$Num_x:=-($Num_width/2)
		
		$Num_tx:=$Num_tx+num_not_INF (-(($Num_offsetY/2)*Sin:C17(($Num_r)*Degree:K30:2))+(($Num_offsetX/2)*Cos:C18(($Num_r)*Degree:K30:2)))
		$Num_ty:=$Num_ty+num_not_INF ((($Num_offsetY/2)*Cos:C18(($Num_r)*Degree:K30:2))+(($Num_offsetX/2)*Sin:C17(($Num_r)*Degree:K30:2)))
		
		  //________________________________________
	: ($Txt_handleId="ml")
		
		$Num_width:=$Num_width-$Num_offsetX
		$Num_x:=-($Num_width/2)
		
		$Num_tx:=$Num_tx+num_not_INF (($Num_offsetX/2)*Cos:C18(($Num_r)*Degree:K30:2))
		$Num_ty:=$Num_ty+num_not_INF (($Num_offsetX/2)*Sin:C17(($Num_r)*Degree:K30:2))
		
		  //________________________________________
	: ($Txt_handleId="mr")
		
		$Num_width:=$Num_width+$Num_offsetX
		$Num_x:=-($Num_width/2)
		
		$Num_tx:=$Num_tx+num_not_INF (($Num_offsetX/2)*Cos:C18(($Num_r)*Degree:K30:2))
		$Num_ty:=$Num_ty+num_not_INF (($Num_offsetX/2)*Sin:C17(($Num_r)*Degree:K30:2))
		
		  //________________________________________
	: ($Txt_handleId="bl")
		
		$Num_height:=$Num_height+$Num_offsetY
		$Num_y:=-($Num_height/2)
		$Num_width:=$Num_width-$Num_offsetX
		$Num_x:=-($Num_width/2)
		
		$Num_tx:=$Num_tx+num_not_INF (-(($Num_offsetY/2)*Sin:C17(($Num_r)*Degree:K30:2))+(($Num_offsetX/2)*Cos:C18(($Num_r)*Degree:K30:2)))
		$Num_ty:=$Num_ty+num_not_INF ((($Num_offsetY/2)*Cos:C18(($Num_r)*Degree:K30:2))+(($Num_offsetX/2)*Sin:C17(($Num_r)*Degree:K30:2)))
		
		  //________________________________________
	: ($Txt_handleId="bm")
		
		$Num_height:=$Num_height+$Num_offsetY
		$Num_y:=-($Num_height/2)
		
		$Num_tx:=$Num_tx-num_not_INF (($Num_offsetY/2)*Sin:C17(($Num_r)*Degree:K30:2))
		$Num_ty:=$Num_ty+num_not_INF (($Num_offsetY/2)*Cos:C18(($Num_r)*Degree:K30:2))
		
		  //________________________________________
	: ($Txt_handleId="br")
		
		$Num_height:=$Num_height+$Num_offsetY
		$Num_y:=-($Num_height/2)
		$Num_width:=$Num_width+$Num_offsetX
		$Num_x:=-($Num_width/2)
		
		$Num_tx:=$Num_tx+num_not_INF (-(($Num_offsetY/2)*Sin:C17(($Num_r)*Degree:K30:2))+(($Num_offsetX/2)*Cos:C18(($Num_r)*Degree:K30:2)))
		$Num_ty:=$Num_ty+num_not_INF ((($Num_offsetY/2)*Cos:C18(($Num_r)*Degree:K30:2))+(($Num_offsetX/2)*Sin:C17(($Num_r)*Degree:K30:2)))
		
		  //________________________________________
End case 

If ($Boo_redraw)
	
	$Dom_object:=DOM Find XML element by ID:C1010((OBJECT Get pointer:C1124(Object subform container:K67:4))->;$Txt_ID)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"left";$Num_left)
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"top";$Num_top)
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"right";$Num_right)
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"bottom";$Num_bottom)
	
	If ($Txt_objectType="line")
		
		Case of 
				
				  //________________________________________
			: ($Num_width<0)\
				 & ($Num_height<0)
				
				  //NOTHING MORE TO DO
				
				  //________________________________________
			: ($Num_width<0)\
				 & ($Num_height>0)
				
				$Boo_changeDirection:=True:C214
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"direction";$Txt_direction)
				DOM SET XML ATTRIBUTE:C866($Dom_object;\
					"direction";Choose:C955($Txt_direction="down";"up";"down"))
				
				  //________________________________________
			: ($Num_width>0)\
				 & ($Num_height<0)
				
				$Boo_changeDirection:=True:C214
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"direction";$Txt_direction)
				DOM SET XML ATTRIBUTE:C866($Dom_object;\
					"direction";Choose:C955($Txt_direction="down";"up";"down"))
				
				  //________________________________________
			: ($Num_width>0)\
				 & ($Num_height>0)
				
				  //NOTHING MORE TO DO
				
				  //________________________________________
		End case 
	End if 
	
	Case of 
			
			  //________________________________________
		: ($Txt_handleId="tl")
			
			If ($Num_width<0)
				
				$Num_buffer:=$Num_right
				$Num_right:=$Num_left+($Num_offsetX/$Num_sx)
				$Num_left:=$Num_buffer
				
			Else 
				
				$Num_left:=$Num_left+($Num_offsetX/$Num_sx)
				
			End if 
			
			If ($Num_height<0)
				
				$Num_buffer:=$Num_bottom
				$Num_bottom:=$Num_top+($Num_offsetY/$Num_sy)
				$Num_top:=$Num_buffer
				
			Else 
				
				$Num_top:=$Num_top+($Num_offsetY/$Num_sy)
				
			End if 
			
			  //________________________________________
		: ($Txt_handleId="tm")
			
			If ($Num_height<0)
				
				$Num_buffer:=$Num_bottom
				$Num_bottom:=$Num_top+($Num_offsetY/$Num_sy)
				$Num_top:=$Num_buffer
				
			Else 
				
				$Num_top:=$Num_top+($Num_offsetY/$Num_sy)
				
			End if 
			
			  //________________________________________
		: ($Txt_handleId="tr")
			
			If ($Num_width<0)
				
				$Num_buffer:=$Num_left
				$Num_left:=$Num_right+($Num_offsetX/$Num_sx)
				$Num_right:=$Num_buffer
				
			Else 
				
				$Num_right:=$Num_right+($Num_offsetX/$Num_sx)
				
			End if 
			
			If ($Num_height<0)
				
				$Num_buffer:=$Num_bottom
				$Num_bottom:=$Num_top+($Num_offsetY/$Num_sy)
				$Num_top:=$Num_buffer
				
			Else 
				
				$Num_top:=$Num_top+($Num_offsetY/$Num_sy)
				
			End if 
			
			  //________________________________________
		: ($Txt_handleId="ml")
			
			If ($Num_width<0)
				
				$Num_buffer:=$Num_right
				$Num_right:=$Num_left+($Num_offsetX/$Num_sx)
				$Num_left:=$Num_buffer
				
			Else 
				
				$Num_left:=$Num_left+($Num_offsetX/$Num_sx)
				
			End if 
			
			  //________________________________________
		: ($Txt_handleId="mr")
			
			If ($Num_width<0)
				
				$Num_buffer:=$Num_left
				$Num_left:=$Num_right+($Num_offsetX/$Num_sx)
				$Num_right:=$Num_buffer
				
			Else 
				
				$Num_right:=$Num_right+($Num_offsetX/$Num_sx)
				
			End if 
			
			  //________________________________________
		: ($Txt_handleId="bl")
			
			If ($Num_width<0)
				
				$Num_buffer:=$Num_right
				$Num_right:=$Num_left+($Num_offsetX/$Num_sx)
				$Num_left:=$Num_buffer
				
			Else 
				
				$Num_left:=$Num_left+($Num_offsetX/$Num_sx)
				
			End if 
			
			If ($Num_height<0)
				
				$Num_buffer:=$Num_top
				$Num_top:=$Num_bottom+($Num_offsetY/$Num_sy)
				$Num_bottom:=$Num_buffer
				
			Else 
				
				$Num_bottom:=$Num_bottom+($Num_offsetY/$Num_sy)
				
			End if 
			
			  //________________________________________
		: ($Txt_handleId="bm")
			
			If ($Num_height<0)
				
				$Num_buffer:=$Num_top
				$Num_top:=$Num_bottom+($Num_offsetY/$Num_sy)
				$Num_bottom:=$Num_buffer
				
			Else 
				
				$Num_bottom:=$Num_bottom+($Num_offsetY/$Num_sy)
				
			End if 
			
			  //________________________________________
		: ($Txt_handleId="br")
			
			If ($Num_width<0)
				
				$Num_buffer:=$Num_left
				$Num_left:=$Num_right+($Num_offsetX/$Num_sx)
				$Num_right:=$Num_buffer
				
			Else 
				
				$Num_right:=$Num_right+($Num_offsetX/$Num_sx)
				
			End if 
			
			If ($Num_height<0)
				
				$Num_buffer:=$Num_top
				$Num_top:=$Num_bottom+($Num_offsetY/$Num_sy)
				$Num_bottom:=$Num_buffer
				
			Else 
				
				$Num_bottom:=$Num_bottom+($Num_offsetY/$Num_sy)
				
			End if 
			
			  //________________________________________
	End case 
	
	DOM SET XML ATTRIBUTE:C866($Dom_object;\
		"left";$Num_left;\
		"top";$Num_top;\
		"right";$Num_right;\
		"bottom";$Num_bottom)
	
	$Boo_update:=Choose:C955($Txt_objectType="line";\
		($Num_moveX#0) | ($Num_moveY#0) | $Boo_changeDirection;\
		($Num_moveX#0) | ($Num_moveY#0))
	
	If ($Txt_objectType="polyline")
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"points";$Txt_points)
		
		$Lon_start:=1
		
		While (Match regex:C1019("(-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)";$Txt_points;$Lon_start;$tLon_position;$tLon_length))
			
			APPEND TO ARRAY:C911($tNum_pointX;Num:C11(Substring:C12($Txt_points;$tLon_position{1};$tLon_length{1});"."))
			APPEND TO ARRAY:C911($tNum_pointY;Num:C11(Substring:C12($Txt_points;$tLon_position{2};$tLon_length{2});"."))
			
			$Lon_start:=$tLon_position{2}+$tLon_length{2}
			
		End while 
		
		SVG GET ATTRIBUTE:C1056($Ptr_image->;$Txt_ID;"editor:width";$Num_currentWidth)
		SVG GET ATTRIBUTE:C1056($Ptr_image->;$Txt_ID;"editor:height";$Num_currentHeight)
		
		$Num_ratioW:=$Num_width/$Num_currentWidth
		$Num_ratioH:=$Num_height/$Num_currentHeight
		
		CLEAR VARIABLE:C89($Txt_points)
		
		For ($Lon_i;1;Size of array:C274($tNum_pointX);1)
			
			$tNum_pointX{$Lon_i}:=$tNum_pointX{$Lon_i}*$Num_ratioW
			$tNum_pointY{$Lon_i}:=$tNum_pointY{$Lon_i}*$Num_ratioH
			$Txt_points:=$Txt_points+" "+String:C10($tNum_pointX{$Lon_i};"&xml")+","+String:C10($tNum_pointY{$Lon_i};"&xml")
			
		End for 
		
		DOM SET XML ATTRIBUTE:C866($Dom_object;\
			"data";$Txt_points)
		DOM SET XML ATTRIBUTE:C866($Dom_current;\
			"points";$Txt_points)
		
		$Boo_update:=True:C214
		
	End if 
	
Else 
	
	$Txt_translate:="translate("+String:C10($Num_tx;"&xml")+","+String:C10($Num_ty;"&xml")+")"
	$Txt_scale:="scale("+String:C10($Num_sx;"&xml")+","+String:C10($Num_sy;"&xml")+")"
	$Txt_rotate:="rotate("+String:C10($Num_r;"&xml")+","+String:C10($Num_cx;"&xml")+","+String:C10($Num_cy;"&xml")+")"
	
	  //flip
	If ($Num_width<0)
		
		$Num_x:=$Num_x+$Num_width
		$Num_width:=-$Num_width
		$Num_x1:=$Num_x+$Num_width
		$Num_x2:=$Num_x
		$Boo_flipX:=True:C214
		
	Else 
		
		$Num_x1:=$Num_x
		$Num_x2:=$Num_x+$Num_width
		
	End if 
	
	If ($Num_height<0)
		
		$Num_y:=$Num_y+$Num_height
		$Num_height:=-$Num_height
		$Num_y1:=$Num_y+$Num_height
		$Num_y2:=$Num_y
		$Boo_flipY:=True:C214
		
	Else 
		
		$Num_y1:=$Num_y
		$Num_y2:=$Num_y+$Num_height
		
	End if 
	
	  //move the target
	Case of 
			
			  //________________________________________
		: ($Txt_objectType="ellipse")
			
			SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_ID;\
				"rx";$Num_width/2/$Num_sx;\
				"ry";$Num_height/2/$Num_sy)
			
			  //________________________________________
		: ($Txt_objectType="rect")
			
			SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_ID;\
				"x";$Num_x/$Num_sx;\
				"y";$Num_y/$Num_sy;\
				"width";$Num_width/$Num_sx;\
				"height";$Num_height/$Num_sy)
			
			  //________________________________________
		: ($Txt_objectType="line")
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:direction";$Txt_direction)
			
			If ($Txt_direction="up")
				
				SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_ID;\
					"x1";$Num_x1/$Num_sx;\
					"y1";$Num_y2/$Num_sy;\
					"x2";$Num_x2/$Num_sx;\
					"y2";$Num_y1/$Num_sy)
				
			Else 
				
				SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_ID;\
					"x1";$Num_x1/$Num_sx;\
					"y1";$Num_y1/$Num_sy;\
					"x2";$Num_x2/$Num_sx;\
					"y2";$Num_y2/$Num_sy)
				
			End if 
			
			  //________________________________________
		: ($Txt_objectType="polyline")
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"points";$Txt_points)
			
			ARRAY LONGINT:C221($tLon_position;0x0000)
			ARRAY LONGINT:C221($tLon_length;0x0000)
			
			ARRAY REAL:C219($tNum_pointX;0x0000)
			ARRAY REAL:C219($tNum_pointY;0x0000)
			
			$Lon_start:=1
			
			While (Match regex:C1019("(-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)";$Txt_points;$Lon_start;$tLon_position;$tLon_length))
				
				APPEND TO ARRAY:C911($tNum_pointX;Num:C11(Substring:C12($Txt_points;$tLon_position{1};$tLon_length{1});"."))
				APPEND TO ARRAY:C911($tNum_pointY;Num:C11(Substring:C12($Txt_points;$tLon_position{2};$tLon_length{2});"."))
				
				$Lon_start:=$tLon_position{2}+$tLon_length{2}
				
			End while 
			
			SVG GET ATTRIBUTE:C1056($Ptr_image->;$Txt_ID;"editor:width";$Num_currentWidth)
			SVG GET ATTRIBUTE:C1056($Ptr_image->;$Txt_ID;"editor:height";$Num_currentHeight)
			
			$Num_ratioW:=$Num_width/$Num_currentWidth
			$Num_ratioH:=$Num_height/$Num_currentHeight
			
			CLEAR VARIABLE:C89($Txt_points)
			
			For ($Lon_i;1;Size of array:C274($tNum_pointX);1)
				
				$tNum_pointX{$Lon_i}:=$tNum_pointX{$Lon_i}*$Num_ratioW
				$tNum_pointY{$Lon_i}:=$tNum_pointY{$Lon_i}*$Num_ratioH
				
				If ($Boo_flipX)
					
					$tNum_pointX{$Lon_i}:=-$tNum_pointX{$Lon_i}
					
				End if 
				
				If ($Boo_flipY)
					
					$tNum_pointY{$Lon_i}:=-$tNum_pointY{$Lon_i}
					
				End if 
				
				$Txt_points:=$Txt_points+" "+String:C10($tNum_pointX{$Lon_i};"&xml")+","+String:C10($tNum_pointY{$Lon_i};"&xml")
				
			End for 
			
			SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_ID;\
				"points";$Txt_points)
			
			  //________________________________________
		: ($Txt_objectType="variable/image")
			
			SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_ID+"-rect";\
				"x";$Num_x/$Num_sx;\
				"y";$Num_y/$Num_sy;\
				"width";$Num_width/$Num_sx;\
				"height";$Num_height/$Num_sy)
			
			SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_ID+"-textArea";\
				"x";$Num_x/$Num_sx;\
				"y";$Num_y/$Num_sy;\
				"width";$Num_width/$Num_sx;\
				"height";$Num_height/$Num_sy)
			
			SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_ID+"-image";\
				"x";$Num_x/$Num_sx;\
				"y";$Num_y/$Num_sy;\
				"width";$Num_width/$Num_sx;\
				"height";$Num_height/$Num_sy)
			
			  //________________________________________
		: ($Txt_objectType="variable/text")\
			 | ($Txt_objectType="text")
			
			SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_ID+"-rect";\
				"x";$Num_x/$Num_sx;\
				"y";$Num_y/$Num_sy;\
				"width";$Num_width/$Num_sx;\
				"height";$Num_height/$Num_sy)
			
			SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_ID+"-textArea";\
				"x";$Num_x/$Num_sx;\
				"y";$Num_y/$Num_sy;\
				"width";$Num_width/$Num_sx;\
				"height";$Num_height/$Num_sy)
			
			  //________________________________________
		: ($Txt_objectType="image")
			
			SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_ID+"-rect";\
				"x";$Num_x/$Num_sx;\
				"y";$Num_y/$Num_sy;\
				"width";$Num_width/$Num_sx;\
				"height";$Num_height/$Num_sy)
			
			SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_ID+"-image";\
				"x";$Num_x/$Num_sx;\
				"y";$Num_y/$Num_sy;\
				"width";$Num_width/$Num_sx;\
				"height";$Num_height/$Num_sy)
			
			  //________________________________________
	End case 
	
	  //move the primitive or group
	SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_ID;\
		"transform";$Txt_translate+" "+$Txt_scale+" "+$Txt_rotate)
	
	  //move the object
	SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_selectId;\
		"transform";$Txt_translate+" "+$Txt_rotate)
	
	  //move the rect
	SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_selectRectId;\
		"x";$Num_x;\
		"y";$Num_y;\
		"width";$Num_width;\
		"height";$Num_height)
	
	  //move the handles
	SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_TLId;\
		"x";$Num_x-5;\
		"y";$Num_y-5)
	SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_TMId;\
		"x";$Num_x-5+($Num_width/2);\
		"y";$Num_y-5)
	SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_TRId;\
		"x";$Num_x-5+$Num_width;\
		"y";$Num_y-5)
	SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_MLId;\
		"x";$Num_x-5;\
		"y";$Num_y-5+($Num_height/2))
	SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_MRId;\
		"x";$Num_x-5+$Num_width;\
		"y";$Num_y-5+($Num_height/2))
	SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_BLId;\
		"x";$Num_x-5;\
		"y";$Num_y-5+$Num_height)
	SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_BMId;\
		"x";$Num_x-5+($Num_width/2);\
		"y";$Num_y-5+$Num_height)
	SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_BRId;\
		"x";$Num_x-5+$Num_width;\
		"y";$Num_y-5+$Num_height)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Boo_update

  // ----------------------------------------------------
  // End