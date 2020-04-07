//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : wizard_PAPER
  // Database: 4D Labels
  // ID[E997EA827E84486184816FA78FB053EA]
  // Created #19-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_landscape)
C_LONGINT:C283($Lon_bottom;$Lon_height;$Lon_i;$Lon_left;$Lon_option;$Lon_parameters)
C_LONGINT:C283($Lon_right;$Lon_top;$Lon_width)
C_TEXT:C284($Dom_label;$Txt_buffer;$Txt_decimalSeparator)
C_OBJECT:C1216($Obj_paper)

If (False:C215)
	C_TEXT:C284(wizard_PAPER ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Dom_label:=$1
		
	Else 
		
		$Dom_label:=OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;"dom";Is text:K8:3)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
GET PRINTABLE MARGIN:C711($Lon_left;$Lon_top;$Lon_right;$Lon_bottom)

GET PRINTABLE AREA:C703($Lon_height;$Lon_width)

OB SET:C1220($Obj_paper;\
"paper-margin-left";$Lon_left;\
"paper-margin-top";$Lon_top;\
"paper-margin-right";$Lon_width;\
"paper-margin-bottom";$Lon_height)

GET PRINT OPTION:C734(Paper option:K47:1;$Lon_width;$Lon_height)

GET PRINT OPTION:C734(Orientation option:K47:2;$Lon_option)
$Boo_landscape:=($Lon_option=2)

  //retrieve stored values in point
ARRAY TEXT:C222($tTxt_objects;8)

$tTxt_objects{1}:="size.width"
$tTxt_objects{2}:="size.height"

$tTxt_objects{3}:="margin.left"
$tTxt_objects{4}:="margin.top"

$tTxt_objects{5}:="gap.horizontal"
$tTxt_objects{6}:="gap.vertical"

$tTxt_objects{7}:="margin.right"
$tTxt_objects{8}:="margin.bottom"

ARRAY REAL:C219($tNum_values;8)

GET SYSTEM FORMAT:C994(Decimal separator:K60:1;$Txt_decimalSeparator)

For ($Lon_i;1;8;1)
	
	XML DECODE:C1091(label_data_Get ($tTxt_objects{$Lon_i};$Dom_label);$tNum_values{$Lon_i})
	
End for 

OB SET:C1220($Obj_paper;\
"layout-rows";Num:C11(label_data_Get ("rows";$Dom_label));\
"layout-columns";Num:C11(label_data_Get ("columns";$Dom_label));\
"layout-start";Num:C11(label_data_Get ("start";$Dom_label));\
"label-width";$tNum_values{1};\
"label-height";$tNum_values{2};\
"margin-left";$tNum_values{3};\
"margin-top";$tNum_values{4};\
"margin-right";$tNum_values{7};\
"margin-bottom";$tNum_values{8};\
"gap-horizontal";$tNum_values{5};\
"gap-vertical";$tNum_values{6};\
"paper-width";Choose:C955($Boo_landscape;$Lon_height;$Lon_width);\
"paper-height";Choose:C955($Boo_landscape;$Lon_width;$Lon_height);\
"order-vertical";label_data_Get ("setting.vertical";$Dom_label)="true";\
"orientation-landscape";$Boo_landscape)

DOM GET XML ATTRIBUTE BY NAME:C728(DOM Find XML element by ID:C1010($Dom_label;"form");"name";$Txt_buffer)

If (Length:C16($Txt_buffer)>0)
	
	OB SET:C1220($Obj_paper;\
		"form-name";$Txt_buffer)
	
End if 

wizard_PAPER_PREVIEW ($Obj_paper)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End