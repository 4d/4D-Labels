//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_TEXT_COMPUTE_SIZE
  // Database: 4D Labels
  // ID[6F1D26A4FDBD495D8D714F6C83889E50]
  // Created #11-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_OBJECT:C1216($1)

C_LONGINT:C283($Lon_height;$Lon_height_2;$Lon_parameters;$Lon_size;$Lon_width)
C_PICTURE:C286($Pic_buffer)
C_TEXT:C284($Dom_area;$Svg_root;$Txt_align;$Txt_buffer;$Txt_decoration;$Txt_font)
C_TEXT:C284($Txt_style;$Txt_value;$Txt_weight)
C_OBJECT:C1216($Obj_param)

ARRAY LONGINT:C221($tLon_lengths;0)
ARRAY LONGINT:C221($tLon_positions;0)

If (False:C215)
	C_OBJECT:C1216(Editor_TEXT_COMPUTE_SIZE ;$1)
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
	
	$Txt_value:=OB Get:C1224($Obj_param;"value";Is text:K8:3)
	$Txt_font:=OB Get:C1224($Obj_param;"font";Is text:K8:3)
	$Lon_size:=OB Get:C1224($Obj_param;"font-size";Is longint:K8:6)
	$Txt_style:=OB Get:C1224($Obj_param;"style";Is text:K8:3)
	$Txt_weight:=OB Get:C1224($Obj_param;"weight";Is text:K8:3)
	$Txt_align:=OB Get:C1224($Obj_param;"align";Is text:K8:3)
	$Txt_decoration:=OB Get:C1224($Obj_param;"decoration";Is text:K8:3)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Svg_root:=DOM Create XML Ref:C861("svg";"http://www.w3.org/2000/svg")

$Dom_area:=DOM Create XML element:C865($Svg_root;"text";\
"x";0;\
"y";0;\
"fill";"red";\
"fill-opacity";0.4;\
"font-family";$Txt_font;\
"font-size";$Lon_size;\
"font-style";$Txt_style;\
"font-weight";$Txt_weight;\
"text-anchor";$Txt_align;\
"text-decoration";$Txt_decoration;\
"text-rendering";OB Get:C1224(<>label_params;"text-rendering";Is text:K8:3))

  //to compute the handing height of the last line
$Txt_buffer:=$Txt_value

If (Match regex:C1019(".*$";$Txt_value;1;$tLon_positions;$tLon_lengths))
	
	$Txt_buffer:=Substring:C12($Txt_value;$tLon_positions{0};$tLon_lengths{0})
	
End if 

DOM SET XML ELEMENT VALUE:C868($Dom_area;$Txt_buffer)

SVG EXPORT TO PICTURE:C1017($Svg_root;$Pic_buffer)
PICTURE PROPERTIES:C457($Pic_buffer;$Lon_width;$Lon_height)

DOM SET XML ATTRIBUTE:C866($Dom_area;\
"fill-opacity";0)

$Dom_area:=DOM Create XML element:C865($Svg_root;"textArea";\
"x";0;\
"y";0;\
"fill";"red";\
"fill-opacity";0.4;\
"font-family";$Txt_font;\
"font-size";$Lon_size;\
"font-style";$Txt_style;\
"font-weight";$Txt_weight;\
"text-align";$Txt_align;\
"text-decoration";$Txt_decoration;\
"text-rendering";OB Get:C1224(<>label_params;"text-rendering";Is text:K8:3))

Editor_TEXT_EDIT_SET_VALUE ($Dom_area;$Txt_value)

SVG EXPORT TO PICTURE:C1017($Svg_root;$Pic_buffer)
PICTURE PROPERTIES:C457($Pic_buffer;$Lon_width;$Lon_height_2)

DOM SET XML ATTRIBUTE:C866($Dom_area;\
"height";$Lon_height_2+$Lon_height)

$Dom_area:=DOM Create XML element:C865($Svg_root;"rect";\
"x";0;\
"y";0;\
"width";$Lon_width;\
"height";$Lon_height_2+$Lon_height-4;\
"fill-opacity";0.1;\
"shape-rendering";OB Get:C1224(<>label_params;"shape-rendering";Is text:K8:3))

SVG EXPORT TO PICTURE:C1017($Svg_root;$Pic_buffer)
PICTURE PROPERTIES:C457($Pic_buffer;$Lon_width;$Lon_height)

DOM CLOSE XML:C722($Svg_root)

  // ----------------------------------------------------
  // Return
OB SET:C1220($Obj_param;\
"width";$Lon_width;\
"height";$Lon_height)

  // ----------------------------------------------------
  // End
CLEAR VARIABLE:C89($Pic_buffer)
CLEAR VARIABLE:C89($tLon_positions)
CLEAR VARIABLE:C89($tLon_lengths)