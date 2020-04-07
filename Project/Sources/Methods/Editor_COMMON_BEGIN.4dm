//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_COMMON_BEGIN
  // Database: 4D Labels
  // ID[1C314E6B9B624EFE891D2CA00FD6758E]
  // Created #4-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($Lon_mouseX;$Lon_mouseY;$Lon_parameters)
C_REAL:C285($Num_zoom)
C_TEXT:C284($Dom_canvas;$Dom_label;$Dom_node;$Dom_objects;$Txt_buffer;$Txt_class)
C_TEXT:C284($Txt_objectID;$Txt_style;$Txt_tool;$Txt_transform)

If (False:C215)
	C_TEXT:C284(Editor_COMMON_BEGIN ;$1)
	C_LONGINT:C283(Editor_COMMON_BEGIN ;$2)
	C_LONGINT:C283(Editor_COMMON_BEGIN ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_tool:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		$Lon_mouseX:=$2
		$Lon_mouseY:=$3
		
	Else 
		
		$Lon_mouseX:=MOUSEX
		$Lon_mouseY:=MOUSEY
		
	End if 
	
	Editor_Get_grips (->$Dom_label;->$Dom_canvas)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Length:C16($Dom_canvas)#0)
	
	$Txt_buffer:=Editor_SELECT_Get_dragger (True:C214)
	
	$Dom_objects:=DOM Find XML element by ID:C1010($Dom_label;"objects")
	$Txt_objectID:=OB Get:C1224(<>label_params;"objectPrefix";Is text:K8:3)+String:C10(DOM Count XML elements:C726($Dom_objects;"object")+1)
	$Txt_class:=OB Get:C1224(<>label_params;"classPrefix";Is text:K8:3)+$Txt_objectID
	
	  //common
	$Dom_node:=DOM Create XML element:C865($Dom_canvas;Choose:C955($Txt_tool="round-rect";"rect";$Txt_tool);\
		"id";$Txt_objectID;\
		"class";$Txt_class;\
		"editor:group";"";\
		"editor:object-type";Choose:C955($Txt_tool="round-rect";"rect";$Txt_tool);\
		"editor:object-id";$Txt_objectID;\
		"editor:x";0;\
		"editor:y";0;\
		"editor:width";0;\
		"editor:height";0;\
		"editor:tx";$Lon_mouseX;\
		"editor:ty";$Lon_mouseY;\
		"editor:sx";1;\
		"editor:sy";1;\
		"editor:cx";0;\
		"editor:cy";0;\
		"editor:r";0;\
		"shape-rendering";OB Get:C1224(<>label_params;"shape-rendering";Is text:K8:3))
	
	  //specific
	Case of 
			
			  //______________________________________________________
		: ($Txt_tool="rect")\
			 | ($Txt_tool="round-rect")
			
			DOM SET XML ATTRIBUTE:C866($Dom_node;\
				"x";0;\
				"y";0;\
				"width";0;\
				"height";0;\
				"rx";Choose:C955($Txt_tool="round-rect";OB Get:C1224(<>label_params;"defaultRoundRect";Is longint:K8:6);0);\
				"ry";Choose:C955($Txt_tool="round-rect";OB Get:C1224(<>label_params;"defaultRoundRect";Is longint:K8:6);0))
			
			$Txt_transform:="translate("+String:C10($Lon_mouseX;"&xml")+","+String:C10($Lon_mouseY;"&xml")+")"
			
			  //______________________________________________________
		: ($Txt_tool="ellipse")
			
			DOM SET XML ATTRIBUTE:C866($Dom_node;\
				"rx";0;\
				"ry";0;\
				"cx";0;\
				"cy";0)
			
			$Txt_transform:="translate("+String:C10($Lon_mouseX;"&xml")+","+String:C10($Lon_mouseY;"&xml")+")"
			
			  //______________________________________________________
		: ($Txt_tool="line")
			
			DOM SET XML ATTRIBUTE:C866($Dom_node;\
				"x1";0;\
				"y1";0;\
				"x2";0;\
				"y2";0;\
				"editor:direction";"down")
			
			$Txt_transform:="translate("+String:C10($Lon_mouseX;"&xml")+","+String:C10($Lon_mouseY;"&xml")+")"
			
			  //______________________________________________________
		: ($Txt_tool="polyline")
			
			DOM SET XML ATTRIBUTE:C866($Dom_node;\
				"points";"0,0";\
				"editor:direction";"down")
			
			$Num_zoom:=Editor_Get_zoom 
			
			$Txt_transform:="translate("+String:C10($Lon_mouseX;"&xml")+","+String:C10($Lon_mouseY;"&xml")+")"\
				+" scale("+String:C10($Num_zoom;"&xml")+","+String:C10($Num_zoom;"&xml")+")"
			
			Editor_SET_POINTS (0;0)
			
			  //______________________________________________________
		Else 
			
			ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_tool+"\"")
			
			  //______________________________________________________
	End case 
	
	DOM SET XML ATTRIBUTE:C866($Dom_node;\
		"transform";$Txt_transform)
	
	$Txt_style:="fill:"+Color_from_long (Editor_Get_color ("fill"))\
		+";fill-opacity:1"\
		+";stroke:"+Color_from_long (Editor_Get_color ("stroke"))\
		+";stroke-width:"+String:C10(Editor_Get_default_stroke_width ;"&xml")\
		+";stroke-opacity:1"\
		+";stroke-linejoin:"+OB Get:C1224(<>label_params;"stroke-linejoin";Is text:K8:3)
	
	Editor_ADD_STYLE ($Dom_canvas;$Txt_class;$Txt_style)
	
	Editor_SET_CURRENT ($Dom_node)
	
	SET TIMER:C645(-1)
	
	Editor_REDRAW 
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End