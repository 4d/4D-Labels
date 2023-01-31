//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : PRINT_object
// Database: 4D Labels
// ID[B91744BD7CA84BF59919BACBA3A8E6CF]
// Created #7-4-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)
C_OBJECT:C1216($2)

C_BOOLEAN:C305($Boo_preserveAspectRatio; $Boo_printed)
C_LONGINT:C283($Lon_fontSize; $Lon_fontStyle; $Lon_i; $Lon_parameters; $Lon_start)
C_REAL:C285($Num_vOffset; $Num_hOffset)
C_PICTURE:C286($Pic_buffer)
C_REAL:C285($Num_fillOpacity; $Num_height; $Num_hOffset; $Num_rx; $Num_ry; $Num_strokeOpacity)
C_REAL:C285($Num_strokeWidth; $Num_width; $Num_wOffset; $Num_X; $Num_x1; $Num_x2)
C_REAL:C285($Num_Y; $Num_y1; $Num_y2)
C_TEXT:C284($Dom_object; $Svg_root; $Txt_alignment; $Txt_codec; $Txt_data; $Txt_direction)
C_TEXT:C284($Txt_fill; $Txt_fontcolor; $Txt_fontName; $Txt_stroke; $Txt_strokeDasharray; $Txt_style)
C_TEXT:C284($Txt_type; $Txt_value)
C_OBJECT:C1216($Obj_desc)

ARRAY LONGINT:C221($tLon_lengths; 0)
ARRAY LONGINT:C221($tLon_positions; 0)
ARRAY REAL:C219($tNum_x; 0)
ARRAY REAL:C219($tNum_y; 0)

If (False:C215)
	C_TEXT:C284(PRINT_OBJECT; $1)
	C_OBJECT:C1216(PRINT_OBJECT; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	//Required parameters
	$Txt_type:=$1
	$Obj_desc:=$2
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
	$Num_width:=OB Get:C1224($Obj_desc; "width"; Is real:K8:4)
	$Num_height:=OB Get:C1224($Obj_desc; "height"; Is real:K8:4)
	
	$Txt_stroke:=OB Get:C1224($Obj_desc; "stroke"; Is text:K8:3)
	$Num_strokeWidth:=OB Get:C1224($Obj_desc; "stroke-width"; Is real:K8:4)
	$Num_strokeOpacity:=OB Get:C1224($Obj_desc; "stroke-opacity"; Is real:K8:4)
	
	$Txt_fill:=OB Get:C1224($Obj_desc; "fill"; Is text:K8:3)
	$Num_fillOpacity:=OB Get:C1224($Obj_desc; "fill-opacity"; Is real:K8:4)
	
	$Num_X:=OB Get:C1224($Obj_desc; "x"; Is real:K8:4)
	$Num_Y:=OB Get:C1224($Obj_desc; "y"; Is real:K8:4)
	$Num_hOffset:=OB Get:C1224($Obj_desc; "h-offset"; Is real:K8:4)
	$Num_vOffset:=OB Get:C1224($Obj_desc; "v-offset"; Is real:K8:4)
	
	$Txt_strokeDasharray:=OB Get:C1224($Obj_desc; "stroke-dasharray"; Is text:K8:3)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Svg_root:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg"; "xmlns:svg"; "http://www.w3.org/2000/svg")

DOM SET XML ATTRIBUTE:C866($Svg_root; \
"width"; $Num_strokeWidth+$Num_width+$Num_strokeWidth; \
"height"; $Num_strokeWidth+$Num_height+$Num_strokeWidth)

Case of 
		
		//______________________________________________________
	: ($Txt_type="line")
		
		$Txt_direction:=OB Get:C1224($Obj_desc; "direction"; Is text:K8:3)
		
		$Num_x1:=$Num_strokeWidth
		$Num_x2:=$Num_x1+$Num_width
		
		If ($Txt_direction="up")
			
			$Num_y2:=$Num_strokeWidth
			$Num_y1:=$Num_y2+$Num_height
			
		Else 
			
			$Num_y1:=$Num_strokeWidth
			$Num_y2:=$Num_y1+$Num_height
			
		End if 
		
		$Dom_object:=DOM Create XML element:C865($Svg_root; "line"; \
			"id"; "line"; \
			"x1"; $Num_x1; \
			"y1"; $Num_y1; \
			"x2"; $Num_x2; \
			"y2"; $Num_y2; \
			"fill"; $Txt_fill; \
			"stroke"; $Txt_stroke; \
			"stroke-width"; $Num_strokeWidth; \
			"stroke-opacity"; $Num_strokeOpacity; \
			"stroke-dasharray"; $Txt_strokeDasharray; \
			"shape-rendering"; OB Get:C1224(<>label_params; "shape-rendering"; Is text:K8:3))
		
		//______________________________________________________
	: ($Txt_type="polyline")
		
		$Txt_data:=OB Get:C1224($Obj_desc; "data"; Is text:K8:3)
		
		$Lon_start:=1
		
		While (Match regex:C1019("(-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)"; $Txt_data; $Lon_start; $tLon_positions; $tLon_lengths))
			
			APPEND TO ARRAY:C911($tNum_x; Num:C11(Substring:C12($Txt_data; $tLon_positions{1}; $tLon_lengths{1}); "."))
			APPEND TO ARRAY:C911($tNum_y; Num:C11(Substring:C12($Txt_data; $tLon_positions{2}; $tLon_lengths{2}); "."))
			
			$Lon_start:=$tLon_positions{2}+$tLon_lengths{2}
			
		End while 
		
		CLEAR VARIABLE:C89($Txt_data)
		
		$Num_wOffset:=($Num_width/2)+$Num_strokeWidth
		$Num_hOffset:=($Num_height/2)+$Num_strokeWidth
		
		For ($Lon_i; 1; Size of array:C274($tNum_x); 1)
			
			$tNum_x{$Lon_i}:=$tNum_x{$Lon_i}+$Num_wOffset
			$tNum_y{$Lon_i}:=$tNum_y{$Lon_i}+$Num_hOffset
			$Txt_data:=$Txt_data+" "+String:C10($tNum_x{$Lon_i}; "&xml")+","+String:C10($tNum_y{$Lon_i}; "&xml")
			
		End for 
		
		$Dom_object:=DOM Create XML element:C865($Svg_root; "polyline"; \
			"id"; "polyline"; \
			"points"; $Txt_data; \
			"fill"; $Txt_fill; \
			"fill-opacity"; $Num_fillOpacity; \
			"stroke"; $Txt_stroke; \
			"stroke-width"; $Num_strokeWidth; \
			"stroke-opacity"; $Num_strokeOpacity; \
			"stroke-dasharray"; $Txt_strokeDasharray; \
			"shape-rendering"; OB Get:C1224(<>label_params; "shape-rendering"; Is text:K8:3))
		
		//______________________________________________________
	: ($Txt_type="rect")\
		 | ($Txt_type="round-rect")
		
		$Dom_object:=DOM Create XML element:C865($Svg_root; "rect"; \
			"id"; "rect"; \
			"x"; $Num_strokeWidth; \
			"y"; $Num_strokeWidth; \
			"width"; $Num_width; \
			"height"; $Num_height; \
			"fill"; $Txt_fill; \
			"fill-opacity"; $Num_fillOpacity; \
			"stroke"; $Txt_stroke; \
			"stroke-width"; $Num_strokeWidth; \
			"stroke-opacity"; $Num_strokeOpacity; \
			"stroke-dasharray"; $Txt_strokeDasharray; \
			"shape-rendering"; OB Get:C1224(<>label_params; "shape-rendering"; Is text:K8:3))
		
		If ($Txt_type="round-rect")
			
			$Txt_type:="rect"
			
			DOM SET XML ATTRIBUTE:C866($Dom_object; \
				"rx"; OB Get:C1224(<>label_params; "defaultRoundRect"; Is real:K8:4); \
				"ry"; OB Get:C1224(<>label_params; "defaultRoundRect"; Is real:K8:4))
			
		End if 
		
		//______________________________________________________
	: ($Txt_type="ellipse")
		
		$Num_rx:=$Num_width/2
		$Num_ry:=$Num_height/2
		
		$Dom_object:=DOM Create XML element:C865($Svg_root; "ellipse"; \
			"id"; "ellipse"; \
			"rx"; $Num_rx; \
			"ry"; $Num_ry; \
			"cx"; $Num_rx+$Num_strokeWidth; \
			"cy"; $Num_ry+$Num_strokeWidth; \
			"fill"; $Txt_fill; \
			"fill-opacity"; $Num_fillOpacity; \
			"stroke"; $Txt_stroke; \
			"stroke-width"; $Num_strokeWidth; \
			"stroke-opacity"; $Num_strokeOpacity; \
			"stroke-dasharray"; $Txt_strokeDasharray; \
			"shape-rendering"; OB Get:C1224(<>label_params; "shape-rendering"; Is text:K8:3))
		
		//______________________________________________________
	: ($Txt_type="text")
		
		$Txt_value:=OB Get:C1224($Obj_desc; "value"; Is text:K8:3)
		$Txt_fontName:=OB Get:C1224($Obj_desc; "font-name"; Is text:K8:3)
		$Lon_fontSize:=OB Get:C1224($Obj_desc; "font-size"; Is longint:K8:6)
		$Txt_style:=OB Get:C1224($Obj_desc; "style"; Is text:K8:3)
		$Txt_alignment:=OB Get:C1224($Obj_desc; "alignment"; Is text:K8:3)
		$Txt_fontcolor:=OB Get:C1224($Obj_desc; "font-color"; Is text:K8:3)
		
		$Lon_fontStyle:=Plain:K14:1
		$Lon_fontStyle:=Choose:C955($Txt_style="@italic@"; $Lon_fontStyle | Italic:K14:3; $Lon_fontStyle)
		$Lon_fontStyle:=Choose:C955($Txt_style="@bold@"; $Lon_fontStyle | Bold:K14:2; $Lon_fontStyle)
		$Lon_fontStyle:=Choose:C955($Txt_style="@underline@"; $Lon_fontStyle | Underline:K14:4; $Lon_fontStyle)
		
		//set the styles' attributes
		Case of 
				
				//........................................
			: ($Txt_alignment="center")
				
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "text"; Align center:K42:3)
				
				//........................................
			: ($Txt_alignment="end")\
				 | ($Txt_alignment="right")
				
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "text"; Align right:K42:4)
				
				//........................................
			Else 
				
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "text"; Align left:K42:2)
				
				//........................................
		End case 
		
		OBJECT SET FONT SIZE:C165(*; "text"; $Lon_fontSize)
		OBJECT SET FONT STYLE:C166(*; "text"; $Lon_fontStyle)
		OBJECT SET FONT:C164(*; "text"; $Txt_fontName)
		
		//fixme:ACI0103533
		OBJECT SET RGB COLORS:C628(*; "text"; Color_to_long($Txt_fontcolor))  //; -2)
		
		//set the value
		OBJECT SET TITLE:C194(*; "text"; $Txt_value)
		
		//adjusting sizes
		$Num_hOffset:=$Num_hOffset+0.5
		$Num_vOffset:=$Num_vOffset+0.5
		$Num_width:=$Num_width-0.5
		
		//______________________________________________________
	: ($Txt_type="image")
		
		$Boo_preserveAspectRatio:=OB Get:C1224($Obj_desc; "preserve-aspect-ratio"; Is boolean:K8:9)
		$Txt_type:=Choose:C955($Boo_preserveAspectRatio; "ImageWithAspect"; "Image")
		
		If (OB Is defined:C1231($Obj_desc; "image-data"))
			
			//embedded image
			$Txt_data:=OB Get:C1224($Obj_desc; "image-data"; Is text:K8:3)
			$Txt_codec:=OB Get:C1224($Obj_desc; "image-codec"; Is text:K8:3)
			
			$Pic_buffer:=PRINT_Get_image($Txt_data; $Txt_codec; ".png")
			
		Else 
			
			//image's field
			$Txt_value:=OB Get:C1224($Obj_desc; "value"; Is text:K8:3)
			
			$Pic_buffer:=PRINT_Get_image_field($Txt_value)
			
		End if 
		
		//______________________________________________________
	: ($Txt_type="variable")
		
		$Txt_value:=OB Get:C1224($Obj_desc; "value"; Is text:K8:3)
		$Txt_fontName:=OB Get:C1224($Obj_desc; "font-name"; Is text:K8:3)
		$Lon_fontSize:=OB Get:C1224($Obj_desc; "font-size"; Is longint:K8:6)
		$Txt_style:=OB Get:C1224($Obj_desc; "style"; Is text:K8:3)
		$Txt_alignment:=OB Get:C1224($Obj_desc; "alignment"; Is text:K8:3)
		
		$Lon_fontStyle:=Plain:K14:1
		$Lon_fontStyle:=Choose:C955($Txt_style="@italic@"; $Lon_fontStyle | Italic:K14:3; $Lon_fontStyle)
		$Lon_fontStyle:=Choose:C955($Txt_style="@bold@"; $Lon_fontStyle | Bold:K14:2; $Lon_fontStyle)
		$Lon_fontStyle:=Choose:C955($Txt_style="@underline@"; $Lon_fontStyle | Underline:K14:4; $Lon_fontStyle)
		
		Case of 
				
				//........................................
			: ($Txt_alignment="center")
				
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "variable"; Align center:K42:3)
				
				//........................................
			: ($Txt_alignment="end")\
				 | ($Txt_alignment="right")
				
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "variable"; Align right:K42:4)
				
				//........................................
			Else 
				
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "variable"; Align left:K42:2)
				
				//........................................
		End case 
		
		OBJECT SET FONT SIZE:C165(*; "variable"; $Lon_fontSize)
		OBJECT SET FONT STYLE:C166(*; "variable"; $Lon_fontStyle)
		OBJECT SET FONT:C164(*; "variable"; $Txt_fontName)
		
		//fixme:ACI0103533
		OBJECT SET RGB COLORS:C628(*; "variable"; Color_to_long($Txt_stroke))  //; -2)
		
		//set the value
		OBJECT SET VALUE:C1742("variable"; $Txt_value)
		
		$Num_hOffset:=$Num_hOffset+0.5
		$Num_vOffset:=$Num_vOffset+0.5
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+$Txt_type+"\"")
		
		//______________________________________________________
End case 

If ($Txt_type#"variable@")\
 & ($Txt_type#"text@")\

	If ($Txt_type#"image@")
		
		//get the picture
		SVG EXPORT TO PICTURE:C1017($Svg_root; $Pic_buffer; Copy XML data source:K45:17)
		
	End if 
	
	//assign to the object
	OBJECT SET VALUE:C1742($Txt_type; $Pic_buffer)
	
End if 

//free the memory
DOM CLOSE XML:C722($Svg_root)
CLEAR VARIABLE:C89($Pic_buffer)

//print object
$Boo_printed:=Print object:C1095(*; $Txt_type; \
$Num_X+$Num_hOffset-$Num_strokeWidth; \
$Num_Y+$Num_vOffset-$Num_strokeWidth; \
$Num_strokeWidth+$Num_width+$Num_strokeWidth; \
$Num_strokeWidth+$Num_height+$Num_strokeWidth)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End