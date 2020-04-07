//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : paper_PREVIEW
  // Database: 4D Labels
  // ID[94CFD8E737414699B958B33D5E200F90]
  // Created #17-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_OBJECT:C1216($1)

C_BLOB:C604($Blb_Buffer)
C_BOOLEAN:C305($Boo_form;$Boo_landscape;$Boo_vertical)
C_LONGINT:C283($Lon_bottom;$Lon_columns;$Lon_fontSize;$Lon_i;$Lon_ID;$Lon_j)
C_LONGINT:C283($Lon_left;$Lon_number;$Lon_parameters;$Lon_right;$Lon_round;$Lon_rows)
C_LONGINT:C283($Lon_start;$Lon_top)
C_PICTURE:C286($Pic_buffer)
C_POINTER:C301($Ptr_table)
C_REAL:C285($Num_gapHorizontal;$Num_gapVertical;$Num_height;$Num_marginBottom;$Num_marginLeft;$Num_marginRight)
C_REAL:C285($Num_marginTop;$Num_paperHeight;$Num_paperWidth;$Num_width;$Num_x;$Num_y)
C_TEXT:C284($Dom_common;$Dom_group;$Dom_item;$Svg_defs;$Svg_root;$Txt_form)
C_TEXT:C284($Txt_values)
C_OBJECT:C1216($Obj_param)

If (False:C215)
	C_OBJECT:C1216(wizard_PAPER_PREVIEW ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Obj_param:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	$Lon_rows:=OB Get:C1224($Obj_param;"layout-rows";Is longint:K8:6)
	$Lon_columns:=OB Get:C1224($Obj_param;"layout-columns";Is longint:K8:6)
	$Lon_start:=OB Get:C1224($Obj_param;"layout-start";Is longint:K8:6)
	$Num_width:=OB Get:C1224($Obj_param;"label-width";Is real:K8:4)
	$Num_height:=OB Get:C1224($Obj_param;"label-height";Is real:K8:4)
	
	$Num_marginLeft:=OB Get:C1224($Obj_param;"margin-left";Is real:K8:4)
	$Num_marginTop:=OB Get:C1224($Obj_param;"margin-top";Is real:K8:4)
	$Num_marginRight:=OB Get:C1224($Obj_param;"margin-right";Is real:K8:4)
	$Num_marginBottom:=OB Get:C1224($Obj_param;"margin-bottom";Is real:K8:4)
	
	$Num_gapHorizontal:=OB Get:C1224($Obj_param;"gap-horizontal";Is real:K8:4)
	$Num_gapVertical:=OB Get:C1224($Obj_param;"gap-vertical";Is real:K8:4)
	
	$Num_paperWidth:=OB Get:C1224($Obj_param;"paper-width";Is real:K8:4)
	$Num_paperHeight:=OB Get:C1224($Obj_param;"paper-height";Is real:K8:4)
	
	$Boo_vertical:=OB Get:C1224($Obj_param;"order-vertical";Is boolean:K8:9)
	
	$Boo_landscape:=OB Get:C1224($Obj_param;"orientation-landscape";Is boolean:K8:9)
	
	$Txt_form:=OB Get:C1224($Obj_param;"form-name";Is text:K8:3)
	$Boo_form:=(Length:C16($Txt_form)>0)
	
	  //adapt font-size and rounding corner with the number of labels to display {
	$Lon_fontSize:=Choose:C955($Lon_columns>($Lon_rows*1.2);Round:C94(($Num_width/3)*(8/$Lon_columns);0);Round:C94($Num_height/3;0))
	$Lon_round:=Choose:C955($Boo_form;0;8-Round:C94(($Lon_rows*$Lon_columns)/30;0))
	  //}
	
	  //default values
	$Lon_start:=Choose:C955($Lon_start>0;$Lon_start;1)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Svg_root:=DOM Create XML Ref:C861("svg";"http://www.w3.org/2000/svg";\
"xmlns:xlink";"http://www.w3.org/1999/xlink")

XML SET OPTIONS:C1090($Svg_root;XML indentation:K45:34;Choose:C955(<>Boo_debug;XML with indentation:K45:35;XML no indentation:K45:36))

$Svg_defs:=DOM Create XML element:C865($Svg_root;"defs")

If (True:C214)  //============= define styles
	
	  //common styles
	DOM SET XML ELEMENT VALUE:C868(\
		DOM Create XML element:C865($Svg_defs;"style";\
		"type";"text/css");\
		".main{shape-rendering:crispEdges;stroke-width:0.5}")
	
	  //user margin's
	DOM SET XML ELEMENT VALUE:C868(\
		DOM Create XML element:C865($Svg_defs;"style";\
		"type";"text/css");\
		".user-margin{stroke:blue;stroke-dasharray:2,2}")
	
	  //printable margin's
	DOM SET XML ELEMENT VALUE:C868(\
		DOM Create XML element:C865($Svg_defs;"style";\
		"type";"text/css");\
		".print-area{fill:none;stroke:red;stroke-dasharray:2,2}")
	
	  //paper sheet
	DOM SET XML ELEMENT VALUE:C868(\
		DOM Create XML element:C865($Svg_defs;"style";\
		"type";"text/css");\
		".paper{fill:white;stroke:grey}")
	
	  //label
	DOM SET XML ELEMENT VALUE:C868(\
		DOM Create XML element:C865($Svg_defs;"style";\
		"type";"text/css");\
		".label{rx:"+String:C10($Lon_round)+"}")
	
	  //label numbers = text
	DOM SET XML ELEMENT VALUE:C868(\
		DOM Create XML element:C865($Svg_defs;"style";\
		"type";"text/css");\
		"text{fill:darkgray;font-family:'"+OBJECT Get font:C1069(*;"system_font")+"';font-size:"+String:C10($Lon_fontSize)+";text-anchor:middle}")
	
	  //label-selected
	DOM SET XML ELEMENT VALUE:C868(\
		DOM Create XML element:C865($Svg_defs;"style";\
		"type";"text/css");\
		".activated{fill:white;stroke:black;fill-opacity:1}")
	
	  //label-unselected
	DOM SET XML ELEMENT VALUE:C868(\
		DOM Create XML element:C865($Svg_defs;"style";\
		"type";"text/css");\
		".unactivated{fill:lightslategray;stroke:white;fill-opacity:0.4}")
	
	  //tips = textArea
	DOM SET XML ELEMENT VALUE:C868(\
		DOM Create XML element:C865($Svg_defs;"style";\
		"type";"text/css");\
		"textArea{fill:darkgray;font-family:'"+OBJECT Get font:C1069(*;"system_font")+"';font-size:24;text-anchor:middle}")
	
End if 

If (True:C214)  //============= define symbol for the label
	
	If ($Boo_form)
		
		$Ptr_table:=Table:C252(C_MASTER_TABLE)
		
		  //create embedded image of the form {
		FORM SCREENSHOT:C940($Ptr_table->;$Txt_form;$Pic_buffer)
		PICTURE PROPERTIES:C457($Pic_buffer;$Num_width;$Num_height)
		
		  //Encode in base64
		PICTURE TO BLOB:C692($Pic_Buffer;$Blb_Buffer;".png")
		CLEAR VARIABLE:C89($Pic_buffer)
		
		If (OK=1)
			
			BASE64 ENCODE:C895($Blb_Buffer;$Txt_form)
			SET BLOB SIZE:C606($Blb_Buffer;0)
			
			$Txt_form:="data:;base64,"+$Txt_form
			
		End if 
		
		$Dom_item:=DOM Create XML element:C865(\
			DOM Create XML element:C865($Svg_defs;"symbol";\
			"id";"label");\
			"image";\
			"xlink:href";$Txt_form;\
			"x";0;\
			"y";0;\
			"width";$Num_width;\
			"height";$Num_height;\
			"class";"label")
		  //}
		
		  //define filter for unactivated labels{
		$Txt_values:=\
			".299 .587 .114 0 0 "+\
			".299 .587 .114 0 0 "+\
			".299 .587 .114 0 0 "+\
			"0 0 0 1 0"
		
		$Dom_item:=DOM Create XML element:C865($Svg_defs;"filter";\
			"id";"unactivated";\
			"filterUnits";"objectBoundingBox";\
			"x";"0%";\
			"y";"0%";\
			"width";"100%";\
			"height";"100%")
		
		$Dom_item:=DOM Create XML element:C865($Dom_item;"feColorMatrix";\
			"type";"matrix";\
			"in";"SourceGraphic";\
			"values";$Txt_values)
		  //}
		
	Else 
		
		$Dom_item:=DOM Create XML element:C865(\
			DOM Create XML element:C865($Svg_defs;"symbol";\
			"id";"label");\
			"rect";\
			"width";$Num_width;\
			"height";$Num_height;\
			"class";"label")
		
	End if 
End if 

$Dom_common:=DOM Create XML element:C865($Svg_root;"g";\
"class";"main")

  //============= paper
$Dom_item:=DOM Create XML element:C865($Dom_common;"rect";\
"x";0;\
"y";0;\
"width";$Num_paperWidth;\
"height";$Num_paperHeight;\
"class";"paper")

  //============= show printable area
GET PRINTABLE MARGIN:C711($Lon_left;$Lon_top;$Lon_right;$Lon_bottom)

$Dom_group:=DOM Create XML element:C865($Dom_common;"g";\
"class";"print-area")

  //top
$Dom_item:=DOM Create XML element:C865($Dom_group;"line";\
"x1";1;\
"y1";$Lon_top;\
"x2";$Num_paperWidth;\
"y2";$Lon_top)

  //left
$Dom_item:=DOM Create XML element:C865($Dom_group;"line";\
"x1";$Lon_left;\
"y1";1;\
"x2";$Lon_left;\
"y2";$Num_paperHeight)

  //bottom
$Dom_item:=DOM Create XML element:C865($Dom_group;"line";\
"x1";1;\
"y1";$Num_paperHeight-$Lon_bottom;\
"x2";$Num_paperWidth;\
"y2";$Num_paperHeight-$Lon_bottom)

  //right
$Dom_item:=DOM Create XML element:C865($Dom_group;"line";\
"x1";$Num_paperWidth-$Lon_right;\
"y1";1;\
"x2";$Num_paperWidth-$Lon_right;\
"y2";$Num_paperHeight)

  //============= user margins
$Dom_group:=DOM Create XML element:C865($Dom_common;"g";\
"class";"user-margin")

  //top
$Dom_item:=DOM Create XML element:C865($Dom_group;"line";\
"x1";1;\
"y1";$Num_marginTop;\
"x2";$Num_paperWidth;\
"y2";$Num_marginTop)

  //left
$Dom_item:=DOM Create XML element:C865($Dom_group;"line";\
"x1";$Num_marginLeft;\
"y1";1;\
"x2";$Num_marginLeft;\
"y2";$Num_paperHeight)

  //bottom
$Dom_item:=DOM Create XML element:C865($Dom_group;"line";\
"x1";1;\
"y1";$Num_paperHeight-$Num_marginBottom;\
"x2";$Num_paperWidth;\
"y2";$Num_paperHeight-$Num_marginBottom)

  //right
$Dom_item:=DOM Create XML element:C865($Dom_group;"line";\
"x1";$Num_paperWidth-$Num_marginRight;\
"y1";1;\
"x2";$Num_paperWidth-$Num_marginRight;\
"y2";$Num_paperHeight)

  //============= labels
$Num_x:=$Num_marginLeft
$Num_y:=$Num_marginTop

For ($Lon_i;1;Choose:C955($Boo_vertical;$Lon_columns;$Lon_rows);1)
	
	For ($Lon_j;1;Choose:C955($Boo_vertical;$Lon_rows;$Lon_columns);1)
		
		$Lon_ID:=$Lon_ID+1
		
		$Lon_number:=$Lon_ID-$Lon_start+1
		
		$Dom_group:=DOM Create XML element:C865($Dom_common;"g";\
			"id";String:C10($Lon_ID;"label-###");"data";$Lon_number+$Lon_start-1)
		
		If ($Boo_form)
			
			$Dom_item:=DOM Create XML element:C865($Dom_group;"use";\
				"xlink:href";"#label";\
				"x";$Num_x;\
				"y";$Num_y)
			
			If ($Lon_ID<$Lon_start)
				
				DOM SET XML ATTRIBUTE:C866($Dom_item;\
					"filter";"url(#unactivated)")
				
			End if 
			
		Else 
			
			$Dom_item:=DOM Create XML element:C865($Dom_group;"use";\
				"xlink:href";"#label";\
				"x";$Num_x;\
				"y";$Num_y;\
				"class";Choose:C955($Lon_ID>=$Lon_start;"activated";"unactivated"))
			
		End if 
		
		If ($Lon_ID>=$Lon_start)
			
			DOM SET XML ELEMENT VALUE:C868(\
				DOM Create XML element:C865(\
				DOM Create XML element:C865($Dom_group;"text";\
				"x";$Num_x+($Num_width\2);\
				"y";$Num_y+($Num_height\2));\
				"tspan";\
				"dy";$Lon_fontSize/2);\
				$Lon_number)
			
		End if 
		
		If ($Boo_vertical)
			
			$Num_y:=$Num_y+$Num_gapVertical+$Num_height
			
		Else 
			
			$Num_x:=$Num_x+$Num_gapHorizontal+$Num_width
			
		End if 
	End for 
	
	If ($Boo_vertical)
		
		$Num_x:=$Num_x+$Num_gapHorizontal+$Num_width
		$Num_y:=$Num_marginTop
		
	Else 
		
		$Num_x:=$Num_marginLeft
		$Num_y:=$Num_y+$Num_gapVertical+$Num_height
		
	End if 
End for 

SVG EXPORT TO PICTURE:C1017($Svg_root;(OBJECT Get pointer:C1124(Object named:K67:5;"paper"))->;Get XML data source:K45:16)
DOM CLOSE XML:C722($Svg_root)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End