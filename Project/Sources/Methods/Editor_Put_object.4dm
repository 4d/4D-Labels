//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_Put_object
// Database: 4D Labels
// ID[11197D8817CD42DC9F756AA68D287354]
// Created #16-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)
C_OBJECT:C1216($1)

C_BOOLEAN:C305($Boo_inGroup)
C_LONGINT:C283($Lon_parameters; $Lon_type; $Lon_x1; $Lon_x2; $Lon_y1; $Lon_y2)
C_REAL:C285($Num_centerX; $Num_centerY; $Num_editorHeight; $Num_editorWidth; $Num_editorX; $Num_editorY)
C_REAL:C285($Num_fillOpacity; $Num_height; $Num_rotation; $Num_strokeOpacity; $Num_strokeWidth; $Num_width)
C_REAL:C285($Num_x; $Num_xScalling; $Num_xTranslation; $Num_y; $Num_yScalling; $Num_yTranslation)
C_TEXT:C284($Dom_buffer; $Dom_canvas; $Dom_defs; $Dom_object; $Txt_class; $Txt_data)
C_TEXT:C284($Txt_direction; $Txt_fill; $Txt_ID; $Txt_stroke; $Txt_style; $Txt_transform)
C_TEXT:C284($Txt_type)

If (False:C215)
	C_TEXT:C284(Editor_Put_object; $0)
	C_OBJECT:C1216(Editor_Put_object; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Txt_type:=OB Get:C1224($1; "type"; Is text:K8:3)
	
	$Txt_ID:=OB Get:C1224($1; "id"; Is text:K8:3)
	$Dom_canvas:=OB Get:C1224($1; "canvas"; Is text:K8:3)
	$Dom_defs:=OB Get:C1224($1; "defs"; Is text:K8:3)
	
	$Num_x:=OB Get:C1224($1; "x"; Is longint:K8:6)
	$Num_y:=OB Get:C1224($1; "y"; Is longint:K8:6)
	
	$Num_width:=OB Get:C1224($1; "width"; Is real:K8:4)
	$Num_height:=OB Get:C1224($1; "height"; Is real:K8:4)
	
	$Num_editorX:=OB Get:C1224($1; "editor-x"; Is real:K8:4)
	$Num_editorY:=OB Get:C1224($1; "editor-y"; Is real:K8:4)
	
	$Num_editorWidth:=OB Get:C1224($1; "editor-width"; Is real:K8:4)
	$Num_editorHeight:=OB Get:C1224($1; "editor-height"; Is real:K8:4)
	
	$Num_xScalling:=OB Get:C1224($1; "x-scaling"; Is real:K8:4)
	$Num_yScalling:=OB Get:C1224($1; "y-scaling"; Is real:K8:4)
	
	$Num_centerX:=OB Get:C1224($1; "cx"; Is real:K8:4)
	$Num_centerY:=OB Get:C1224($1; "cy"; Is real:K8:4)
	
	$Num_rotation:=OB Get:C1224($1; "r"; Is real:K8:4)
	
	$Txt_fill:=OB Get:C1224($1; "fill"; Is text:K8:3)
	$Num_fillOpacity:=OB Get:C1224($1; "fill-opacity"; Is real:K8:4)
	
	$Txt_stroke:=OB Get:C1224($1; "stroke"; Is text:K8:3)
	$Num_strokeOpacity:=OB Get:C1224($1; "stroke-opacity"; Is real:K8:4)
	$Num_strokeWidth:=OB Get:C1224($1; "stroke-width"; Is real:K8:4)
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Txt_class:=OB Get:C1224(<>label_params; "classPrefix"; Is text:K8:3)+$Txt_ID

Case of 
		
		//______________________________________________________
	: ($Txt_type="rect")\
		 | ($Txt_type="round-rect")
		
		$Txt_type:="rect"
		
		$Txt_style:="fill:"+$Txt_fill\
			+";fill-opacity:"+String:C10($Num_fillOpacity; "&xml")\
			+";stroke:"+$Txt_stroke\
			+";stroke-width:"+String:C10($Num_strokeWidth; "&xml")\
			+";stroke-opacity:"+String:C10($Num_strokeOpacity; "&xml")
		
		//______________________________________________________
	: ($Txt_type="image")
		
		$Boo_inGroup:=True:C214
		
		$Txt_class:=OB Get:C1224(<>label_params; "classPrefix"; Is text:K8:3)+$Txt_ID+"-rect"
		
		$Txt_style:="fill:#FFFFFF"\
			+";fill-opacity:0.1"\
			+";stroke:gray"\
			+";stroke-width:0.5"\
			+";stroke-opacity:0"\
			+";stroke-dasharray:1"\
			+";stroke-linejoin:"+OB Get:C1224(<>label_params; "stroke-linejoin"; Is text:K8:3)
		
		//______________________________________________________
	: ($Txt_type="line")
		
		$Txt_direction:=OB Get:C1224($1; "direction"; Is text:K8:3)
		
		$Txt_style:="fill:"+$Txt_fill\
			+";fill-opacity:"+String:C10($Num_fillOpacity; "&xml")\
			+";stroke:"+$Txt_stroke\
			+";stroke-width:"+String:C10($Num_strokeWidth; "&xml")\
			+";stroke-opacity:"+String:C10($Num_strokeOpacity; "&xml")
		
		//______________________________________________________
	: ($Txt_type="polyline")
		
		$Txt_style:="fill:"+$Txt_fill\
			+";fill-opacity:"+String:C10($Num_fillOpacity; "&xml")\
			+";stroke:"+$Txt_stroke\
			+";stroke-width:"+String:C10($Num_strokeWidth; "&xml")\
			+";stroke-opacity:"+String:C10($Num_strokeOpacity; "&xml")
		
		//______________________________________________________
	: ($Txt_type="oval")
		
		$Txt_type:="ellipse"
		
		$Txt_style:="fill:"+$Txt_fill\
			+";fill-opacity:"+String:C10($Num_fillOpacity; "&xml")\
			+";stroke:"+$Txt_stroke\
			+";stroke-width:"+String:C10($Num_strokeWidth; "&xml")\
			+";stroke-opacity:"+String:C10($Num_strokeOpacity; "&xml")
		
		//______________________________________________________
	: ($Txt_type="text")
		
		$Boo_inGroup:=True:C214
		
		$Txt_class:=OB Get:C1224(<>label_params; "classPrefix"; Is text:K8:3)+$Txt_ID+"-rect"
		
		$Txt_style:="fill:"+$Txt_fill\
			+";fill-opacity:0"\
			+";stroke:gray"\
			+";stroke-width:0.5"\
			+";stroke-opacity:0"\
			+";stroke-dasharray:1"\
			+";stroke-linejoin:"+OB Get:C1224(<>label_params; "stroke-linejoin"; Is text:K8:3)
		
		//______________________________________________________
	: ($Txt_type="variable")
		
		$Boo_inGroup:=True:C214
		
		$Txt_class:=OB Get:C1224(<>label_params; "classPrefix"; Is text:K8:3)+$Txt_ID+"-rect"
		
		$Lon_type:=OB Get:C1224($1; "field-type"; Is longint:K8:6)
		
		$Txt_type:="variable/"+Choose:C955($Lon_type=Is picture:K8:10; "image"; "text")
		
		Case of 
				
				//-----------------------
			: ($Lon_type=Is picture:K8:10)
				
				$Txt_style:="fill:#FFFFFF"\
					+";fill-opacity:0.1"\
					+";stroke:#999999"\
					+";stroke-width:0.4"\
					+";stroke-opacity:0"\
					+";stroke-dasharray:2,2"\
					+";stroke-linejoin:"+OB Get:C1224(<>label_params; "stroke-linejoin"; Is text:K8:3)
				
				//-----------------------
			Else 
				
				// #20-10-2015 - no more background
				If (False:C215)
					$Txt_style:="fill:"+$Txt_fill\
						+";fill-opacity:"+String:C10($Num_fillOpacity; "&xml")\
						+";stroke:"+$Txt_stroke\
						+";stroke-width:"+String:C10($Num_strokeWidth; "&xml")\
						+";stroke-opacity:"+String:C10($Num_strokeOpacity; "&xml")\
						+";stroke-linejoin:"+OB Get:C1224(<>label_params; "stroke-linejoin"; Is text:K8:3)
					
				Else 
					
					$Txt_style:="fill:none"\
						+";fill-opacity:0"\
						+";stroke:none"\
						+";stroke-width:0"\
						+";stroke-opacity:0"\
						+";stroke-linejoin:"+OB Get:C1224(<>label_params; "stroke-linejoin"; Is text:K8:3)
				End if 
				
				//-----------------------
		End case 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+$Txt_type+"\"")
		
		//______________________________________________________
End case 

Editor_ADD_STYLE($Dom_canvas; $Txt_class; $Txt_style)

$Num_xTranslation:=(($Num_width/2)+$Num_x)*$Num_xScalling
$Num_yTranslation:=(($Num_height/2)+$Num_y)*$Num_yScalling

$Txt_transform:="translate("+String:C10($Num_xTranslation; "&xml")+","+String:C10($Num_yTranslation; "&xml")+")"\
+" scale("+String:C10($Num_xScalling; "&xml")+","+String:C10($Num_yScalling; "&xml")+")"

//put complex object into a group
$Dom_object:=DOM Create XML element:C865($Dom_canvas; Choose:C955($Boo_inGroup; "g"; $Txt_type); \
"id"; $Txt_ID; \
"editor:group"; ""; \
"editor:object-type"; $Txt_type; \
"editor:object-id"; $Txt_ID; \
"editor:x"; $Num_editorX; \
"editor:y"; $Num_editorY; \
"editor:width"; $Num_editorWidth; \
"editor:height"; $Num_editorHeight; \
"editor:tx"; $Num_xTranslation; \
"editor:ty"; $Num_yTranslation; \
"editor:sx"; $Num_xScalling; \
"editor:sy"; $Num_yScalling; \
"editor:cx"; $Num_centerX; \
"editor:cy"; $Num_centerY; \
"editor:r"; $Num_rotation; \
"transform"; $Txt_transform)

Case of 
		
		//______________________________________________________
	: ($Txt_type="rect")
		
		DOM SET XML ATTRIBUTE:C866($Dom_object; \
			"class"; $Txt_class; \
			"x"; -$Num_width/2; \
			"y"; -$Num_height/2; \
			"width"; $Num_width; \
			"height"; $Num_height; \
			"rx"; OB Get:C1224($1; "rx"; Is real:K8:4); \
			"ry"; OB Get:C1224($1; "ry"; Is real:K8:4); \
			"shape-rendering"; OB Get:C1224(<>label_params; "shape-rendering"; Is text:K8:3))
		
		//______________________________________________________
	: ($Txt_type="image")  //complex
		
		//bounding rect
		$Dom_buffer:=DOM Create XML element:C865($Dom_object; "rect"; \
			"id"; $Txt_ID+"-rect"; \
			"class"; $Txt_class; \
			"x"; -$Num_width/2; \
			"y"; -$Num_height/2; \
			"width"; $Num_width; \
			"height"; $Num_height; \
			"editor:object-type"; $Txt_type; \
			"editor:object-id"; $Txt_ID; \
			"shape-rendering"; OB Get:C1224(<>label_params; "shape-rendering"; Is text:K8:3))
		
		//image
		If (OB Is defined:C1231($1; "data"))
			
			$Txt_data:=OB Get:C1224($1; "data"; Is text:K8:3)
			
		End if 
		
		$Dom_buffer:=DOM Create XML element:C865($Dom_object; "image"; \
			"id"; $Txt_ID+"-image"; \
			"x"; -$Num_width/2; \
			"y"; -$Num_height/2; \
			"xlink:href"; Choose:C955(Length:C16($Txt_data)=0; OB Get:C1224($1; "url"; Is text:K8:3); "data:;base64,"+$Txt_data); \
			"width"; $Num_width; \
			"height"; $Num_height; \
			"preserveAspectRatio"; OB Get:C1224($1; "preserveAspectRatio"; Is text:K8:3); \
			"editor:object-type"; $Txt_type; \
			"editor:object-id"; $Txt_ID)
		
		//______________________________________________________
	: ($Txt_type="line")
		
		If ($Num_width#0)
			
			$Lon_x1:=-$Num_width/2
			$Lon_x2:=$Num_width/2
			
		End if 
		
		If ($Num_height#0)
			
			If ($Txt_direction="up")
				
				$Lon_y2:=-$Num_height/2
				$Lon_y1:=$Num_height/2
				
			Else 
				
				$Lon_y1:=-$Num_height/2
				$Lon_y2:=$Num_height/2
				
			End if 
		End if 
		
		DOM SET XML ATTRIBUTE:C866($Dom_object; \
			"class"; $Txt_class; \
			"x1"; $Lon_x1; \
			"y1"; $Lon_y1; \
			"x2"; $Lon_x2; \
			"y2"; $Lon_y2; \
			"editor:direction"; $Txt_direction; \
			"shape-rendering"; OB Get:C1224(<>label_params; "shape-rendering"; Is text:K8:3))
		
		//______________________________________________________
	: ($Txt_type="polyline")
		
		DOM SET XML ATTRIBUTE:C866($Dom_object; \
			"class"; $Txt_class; \
			"points"; OB Get:C1224($1; "data"; Is text:K8:3); \
			"shape-rendering"; OB Get:C1224(<>label_params; "shape-rendering"; Is text:K8:3))
		
		//______________________________________________________
	: ($Txt_type="ellipse")
		
		DOM SET XML ATTRIBUTE:C866($Dom_object; \
			"class"; $Txt_class; \
			"cx"; 0; \
			"cy"; 0; \
			"rx"; $Num_width/2; \
			"ry"; $Num_height/2; \
			"shape-rendering"; OB Get:C1224(<>label_params; "shape-rendering"; Is text:K8:3))
		
		//______________________________________________________
	: ($Txt_type="text")  //complex
		
		//bounding rect
		$Dom_buffer:=DOM Create XML element:C865($Dom_object; "rect"; \
			"id"; $Txt_ID+"-rect"; \
			"class"; $Txt_class; \
			"x"; -$Num_width/2; \
			"y"; -$Num_height/2; \
			"width"; $Num_width; \
			"height"; $Num_height; \
			"editor:object-type"; $Txt_type; \
			"editor:object-id"; $Txt_ID; \
			"shape-rendering"; OB Get:C1224(<>label_params; "shape-rendering"; Is text:K8:3))
		
		//textArea
		$Txt_class:=OB Get:C1224(<>label_params; "classPrefix"; Is text:K8:3)+$Txt_ID+"-textArea"
		
		$Txt_style:="fill:"+$Txt_stroke\
			+";fill-opacity:"+String:C10($Num_fillOpacity; "&xml")\
			+";stroke:"+$Txt_stroke\
			+";stroke-width:"+String:C10($Num_strokeWidth; "&xml")\
			+";stroke-opacity:"+String:C10($Num_strokeOpacity; "&xml")\
			+";font-size:"+String:C10(OB Get:C1224($1; "font-size"; Is real:K8:4); "&xml")\
			+";text-decoration:"+OB Get:C1224($1; "text-decoration"; Is text:K8:3)\
			+";text-align:"+OB Get:C1224($1; "text-align"; Is text:K8:3)\
			+";font-weight:"+OB Get:C1224($1; "font-weight"; Is text:K8:3)\
			+";font-style:"+OB Get:C1224($1; "font-style"; Is text:K8:3)\
			+"; font-family:"+OB Get:C1224($1; "font-family"; Is text:K8:3)
		
		Editor_ADD_STYLE($Dom_canvas; $Txt_class; $Txt_style)
		
		$Dom_buffer:=DOM Create XML element:C865($Dom_object; "textArea"; \
			"id"; $Txt_ID+"-textArea"; \
			"class"; $Txt_class; \
			"x"; -$Num_width/2; \
			"y"; -$Num_height/2; \
			"width"; $Num_width; \
			"height"; $Num_height; \
			"text-rendering"; OB Get:C1224(<>label_params; "text-rendering"; Is text:K8:3); \
			"editor:object-type"; $Txt_type; \
			"editor:object-id"; $Txt_ID)
		
		Editor_TEXT_EDIT_SET_VALUE($Dom_buffer; OB Get:C1224($1; "value"; Is text:K8:3))
		
		//______________________________________________________
	: ($Txt_type="variable@")
		
		//bounding rect
		$Dom_buffer:=DOM Create XML element:C865($Dom_object; "rect"; \
			"id"; $Txt_ID+"-rect"; \
			"class"; $Txt_class; \
			"x"; -$Num_width/2; \
			"y"; -$Num_height/2; \
			"width"; $Num_width; \
			"height"; $Num_height; \
			"editor:object-type"; $Txt_type; \
			"editor:object-id"; $Txt_ID; \
			"shape-rendering"; OB Get:C1224(<>label_params; "shape-rendering"; Is text:K8:3))
		
		//textArea
		$Txt_class:=OB Get:C1224(<>label_params; "classPrefix"; Is text:K8:3)+$Txt_ID+"-textArea"
		
		//no transparency for text
		If (False:C215)
			
			$Txt_style:="fill:"+$Txt_stroke\
				+";fill-opacity:1"\
				+";stroke:"+$Txt_stroke\
				+";stroke-width:"+String:C10($Num_strokeWidth; "&xml")\
				+";stroke-opacity:"+String:C10($Num_strokeOpacity; "&xml")\
				+";font-size:"+Choose:C955($Lon_type=Is picture:K8:10; "9"; String:C10(OB Get:C1224($1; "font-size"; Is real:K8:4); "&xml"))\
				+";text-decoration:"+OB Get:C1224($1; "text-decoration"; Is text:K8:3)\
				+";text-align:"+OB Get:C1224($1; "text-align"; Is text:K8:3)\
				+";font-weight:"+OB Get:C1224($1; "font-weight"; Is text:K8:3)\
				+";font-style:"+OB Get:C1224($1; "font-style"; Is text:K8:3)\
				+";font-family:"+OB Get:C1224($1; "font-family"; Is text:K8:3)
			
		Else 
			
			$Txt_style:="fill:"+$Txt_stroke\
				+";fill-opacity:1"\
				+";stroke:none"\
				+";stroke-width:0"\
				+";stroke-opacity:0"\
				+";font-size:"+String:C10(OB Get:C1224($1; "font-size"; Is real:K8:4); "&xml")\
				+";text-decoration:"+OB Get:C1224($1; "text-decoration"; Is text:K8:3)\
				+";text-align:"+OB Get:C1224($1; "text-align"; Is text:K8:3)\
				+";font-weight:"+OB Get:C1224($1; "font-weight"; Is text:K8:3)\
				+";font-style:"+OB Get:C1224($1; "font-style"; Is text:K8:3)\
				+";font-family:"+OB Get:C1224($1; "font-family"; Is text:K8:3)
			
		End if 
		
		Editor_ADD_STYLE($Dom_canvas; $Txt_class; $Txt_style)
		
		$Dom_buffer:=DOM Create XML element:C865($Dom_object; "textArea"; \
			"id"; $Txt_ID+"-textArea"; \
			"class"; $Txt_class; \
			"x"; -$Num_width/2; \
			"y"; -$Num_height/2; \
			"width"; $Num_width; \
			"height"; $Num_height; \
			"text-rendering"; OB Get:C1224(<>label_params; "text-rendering"; Is text:K8:3); \
			"editor:object-type"; $Txt_type; \
			"editor:object-id"; $Txt_ID)
		
		Editor_TEXT_EDIT_SET_VALUE($Dom_buffer; OB Get:C1224($1; "value"; Is text:K8:3))
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+$Txt_type+"\"")
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// Return
return $Dom_object

// ----------------------------------------------------
// End