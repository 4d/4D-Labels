//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_Image_drop
  // Database: 4D Labels
  // ID[F21D8EF4432E48B1A203E2A1D5EBADD4]
  // Created #13-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_PICTURE:C286($2)

C_BLOB:C604($Blb_buffer)
C_BOOLEAN:C305($Boo_OK)
C_LONGINT:C283($kLon_leftOffset;$kLon_topOffset;$Lon_;$Lon_bottom;$Lon_count;$Lon_height)
C_LONGINT:C283($Lon_i;$Lon_left;$Lon_mouse_X;$Lon_mouse_Y;$Lon_parameters;$Lon_right)
C_LONGINT:C283($Lon_size;$Lon_stepX;$Lon_stepY;$Lon_top;$Lon_viewPortHeight;$Lon_viewPortWidth)
C_LONGINT:C283($Lon_width;$Lon_X;$Lon_Y)
C_PICTURE:C286($Pic_buffer)
C_REAL:C285($Num_buffer;$Num_cx;$Num_cy;$Num_imageScale;$Num_offsetX;$Num_offsetY)
C_REAL:C285($Num_picHeight;$Num_picWidth;$Num_rotation;$Num_tx;$Num_ty;$Num_xScaling)
C_REAL:C285($Num_xTranslation;$Num_yScaling;$Num_yTranslation;$Num_zoom)
C_TEXT:C284($Dir_tempo;$Dom_buffer;$Dom_canvas;$Dom_defs;$Dom_g;$Dom_label)
C_TEXT:C284($Dom_object;$Dom_objects;$File_buffer;$Txt_buffer;$Txt_data;$Txt_extension)
C_TEXT:C284($Txt_fontFamily;$Txt_hash;$Txt_name;$Txt_objectID;$Txt_url)
C_OBJECT:C1216($Obj_buffer;$Obj_dialog)

ARRAY PICTURE:C279($tPic_images;0)
ARRAY TEXT:C222($tDom_objects;0)
ARRAY TEXT:C222($tTxt_IDs;0)

If (False:C215)
	C_BOOLEAN:C305(Editor_Image_drop ;$0)
	C_TEXT:C284(Editor_Image_drop ;$1)
	C_PICTURE:C286(Editor_Image_drop ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Dom_label:=$1
		
		If ($Lon_parameters>=2)
			
			APPEND TO ARRAY:C911($tPic_images;$2)
			
		End if 
		
	Else 
		
		$Dom_label:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
		
	End if 
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	$Dom_canvas:=OB Get:C1224($Obj_dialog;"canvas";Is text:K8:3)
	
	$Num_zoom:=Editor_Get_zoom 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Size of array:C274($tPic_images)=0)
	
	$Lon_i:=1
	
	Repeat 
		
		$File_buffer:=Get file from pasteboard:C976($Lon_i)
		$Lon_size:=Length:C16($File_buffer)
		
		If ($Lon_size#0)
			
			If (Is picture file:C1113($File_buffer))
				
				READ PICTURE FILE:C678($File_buffer;$Pic_buffer)
				APPEND TO ARRAY:C911($tPic_images;$Pic_buffer)
				CLEAR VARIABLE:C89($Pic_buffer)
				
			End if 
		End if 
		
		$Lon_i:=$Lon_i+1
		
	Until ($Lon_size=0)
	
	  //local coordinates in editor
	GET MOUSE:C468($Lon_mouse_X;$Lon_mouse_Y;$Lon_)
	$Lon_X:=$Lon_mouse_X-OB Get:C1224($Obj_dialog;"offset-X";Is longint:K8:6)+50
	$Lon_Y:=$Lon_mouse_Y-OB Get:C1224($Obj_dialog;"offset-Y";Is longint:K8:6)
	
Else 
	
	$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_canvas;"label")
	
	If (OK=1)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"transform";$Txt_buffer)
		
		ARRAY LONGINT:C221($tLon_position;0x0000)
		ARRAY LONGINT:C221($tLon_length;0x0000)
		
		If (Match regex:C1019("(?mi-s)translate\\(([^,]*),([^)]*)\\)";$Txt_buffer;1;$tLon_position;$tLon_length))
			
			XML DECODE:C1091(Substring:C12($Txt_buffer;$tLon_position{1};$tLon_length{1});$Num_buffer)
			$Lon_X:=Round:C94($Num_buffer;0)
			
			XML DECODE:C1091(Substring:C12($Txt_buffer;$tLon_position{2};$tLon_length{2});$Num_buffer)
			$Lon_Y:=Round:C94($Num_buffer;0)
			
			$Lon_X:=$Lon_X+OB Get:C1224($Obj_dialog;"offset-X";Is longint:K8:6)-51
			$Lon_Y:=$Lon_Y+OB Get:C1224($Obj_dialog;"offset-Y";Is longint:K8:6)-55
			
		End if 
	End if 
End if 

If (Size of array:C274($tPic_images)#0)
	
	$Num_xScaling:=$Num_zoom
	$Num_yScaling:=$Num_zoom
	
	$Num_xTranslation:=$Lon_X
	$Num_yTranslation:=$Lon_Y
	
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
	
	For ($Lon_i;1;Size of array:C274($tPic_images);1)
		
		PICTURE PROPERTIES:C457($tPic_images{$Lon_i};$Num_picWidth;$Num_picHeight)
		
		If ($Num_picWidth>$Num_picHeight)
			
			If ($Num_picWidth>64)
				
				$Num_imageScale:=64/$Num_picWidth
				$Num_picWidth:=$Num_picWidth*$Num_imageScale
				$Num_picHeight:=$Num_picHeight*$Num_imageScale
				
			End if 
			
		Else 
			
			If ($Num_picHeight>64)
				
				$Num_imageScale:=64/$Num_picHeight
				$Num_picWidth:=$Num_picWidth*$Num_imageScale
				$Num_picHeight:=$Num_picHeight*$Num_imageScale
				
			End if 
		End if 
		
		$Lon_left:=($Num_xTranslation/$Num_zoom)+$kLon_leftOffset-($Num_picWidth/2)-(-$Num_offsetX+($Num_tx/$Num_xScaling))
		$Lon_top:=($Num_yTranslation/$Num_zoom)+$kLon_topOffset-($Num_picHeight/2)-(-$Num_offsetY+($Num_ty/$Num_yScaling))
		
		$Lon_left:=$Lon_left+(($Lon_stepX*($Lon_i-1))/$Num_zoom)
		$Lon_top:=$Lon_top+(($Lon_stepY*($Lon_i-1))/$Num_zoom)
		
		$Lon_right:=$Lon_left+$Num_picWidth
		$Lon_bottom:=$Lon_top+$Num_picHeight
		
		$File_buffer:=Get picture file name:C1171($tPic_images{$Lon_i})
		
		ARRAY LONGINT:C221($tLon_positions;0x0000)
		ARRAY LONGINT:C221($tLon_lengths;0x0000)
		
		If (Match regex:C1019("(.+)(\\.[^.]+)";$File_buffer;1;$tLon_positions;$tLon_lengths))
			
			$Txt_extension:=Substring:C12($File_buffer;$tLon_positions{2};$tLon_lengths{2})
			$Txt_name:=Substring:C12($File_buffer;$tLon_positions{1};$tLon_lengths{1})
			
		Else 
			
			$Txt_extension:=".png"
			$Txt_name:="image"+String:C10($Lon_i)
			
		End if 
		
		PICTURE TO BLOB:C692($tPic_images{$Lon_i};$Blb_buffer;$Txt_extension)
		BASE64 ENCODE:C895($Blb_buffer;$Txt_data)
		
		$Txt_hash:=Generate digest:C1147($Blb_buffer;SHA1 digest:K66:2)
		$Dir_tempo:=Temporary folder:C486+"Label Editor Images"+Folder separator:K24:12
		
		If (Test path name:C476($Dir_tempo+$Txt_hash+$Txt_extension)#Is a document:K24:1)
			
			CREATE FOLDER:C475($Dir_tempo;*)
			BLOB TO DOCUMENT:C526($Dir_tempo+$Txt_hash+$Txt_extension;$Blb_buffer)
			
		End if 
		
		$Txt_objectID:=OB Get:C1224(<>label_params;"objectPrefix";Is text:K8:3)+String:C10($Lon_count+$Lon_i)
		
		$Dom_object:=DOM Create XML element:C865($Dom_objects;"object";\
			"type";"image";\
			"left";$Lon_left;\
			"top";$Lon_top;\
			"right";$Lon_right;\
			"bottom";$Lon_bottom;\
			"field-type";0;\
			"font-name";$Txt_fontFamily;\
			"font-size";9;\
			"style";"plain";\
			"alignment";"left";\
			"preserve-aspect-ratio";"true";\
			"direction";"down";\
			"fill-opacity";0;\
			"stroke-opacity";1;\
			"stroke-color";"#000000";\
			"fill-color";"#FFFFFF";\
			"stroke-width";0;\
			"image-data";$Txt_data;\
			"image-hash";$Txt_hash;\
			"image-name";$Txt_name;\
			"image-codec";$Txt_extension;\
			"id";$Txt_objectID)
		
		$Txt_url:="file:///"+Convert path system to POSIX:C1106($Dir_tempo+$Txt_hash+$Txt_extension;*)
		
		OB SET:C1220($Obj_buffer;\
			"type";"image";\
			"id";$Txt_objectID;\
			"canvas";$Dom_canvas;\
			"defs";$Dom_defs;\
			"x";$Lon_mouse_X;\
			"y";$Lon_mouse_Y;\
			"url";$Txt_url;\
			"preserveAspectRatio";"xMidYMid";\
			"width";$Num_picWidth;\
			"height";$Num_picHeight;\
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
		APPEND TO ARRAY:C911($tTxt_IDs;$Txt_objectID)
		
	End for 
	
	  //manage selection
	Editor_SELECT_Clear 
	
	For ($Lon_i;1;Size of array:C274($tDom_objects);1)
		
		Editor_SELECT_OBJECT ($tDom_objects{$Lon_i};$tTxt_IDs{$Lon_i})
		
	End for 
	
	Editor_ON_DATA_CHANGE   //do redraw
	
	SET CURSOR:C469
	
	$Boo_OK:=True:C214
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Boo_OK

  // ----------------------------------------------------
  // End