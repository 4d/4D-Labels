//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : layout_AUTOMATIC_RESIZING
  // Database: 4D Labels
  // ID[D5A110A44D2E439A91C7FFD20536B7BE]
  // Created #21-9-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_columnNumber;$Lon_orientation;$Lon_paperHeight;$Lon_paperWidth;$Lon_parameters;$Lon_round)
C_LONGINT:C283($Lon_rowNumber)
C_REAL:C285($Num_availableHeight;$Num_availableWidth;$Num_gapHorizontal;$Num_gapVertical;$Num_labelHeight;$Num_labelWidth)
C_REAL:C285($Num_marginBottom;$Num_marginLeft;$Num_marginRight;$Num_marginTop)
C_TEXT:C284($Txt_unit)
C_OBJECT:C1216($Obj_param)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
	$Obj_param:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //the width and height, in pixels, of the paper
GET PRINT OPTION:C734(Orientation option:K47:2;$Lon_orientation)

If ($Lon_orientation=1)  //Portrait
	
	GET PRINT OPTION:C734(Paper option:K47:1;$Lon_paperWidth;$Lon_paperHeight)
	
Else   //Landscape
	
	GET PRINT OPTION:C734(Paper option:K47:1;$Lon_paperHeight;$Lon_paperWidth)
	
End if 

  //numbers
$Lon_rowNumber:=(OBJECT Get pointer:C1124(Object named:K67:5;"layout.rows"))->
$Lon_columnNumber:=(OBJECT Get pointer:C1124(Object named:K67:5;"layout.columns"))->

  //margins
$Num_marginLeft:=(OBJECT Get pointer:C1124(Object named:K67:5;"size.left.box"))->
$Num_marginTop:=(OBJECT Get pointer:C1124(Object named:K67:5;"size.top.box"))->
$Num_marginRight:=(OBJECT Get pointer:C1124(Object named:K67:5;"size.right.box"))->
$Num_marginBottom:=(OBJECT Get pointer:C1124(Object named:K67:5;"size.bottom.box"))->

  //gaps
$Num_gapHorizontal:=(OBJECT Get pointer:C1124(Object named:K67:5;"size.horizontal.box"))->
$Num_gapVertical:=(OBJECT Get pointer:C1124(Object named:K67:5;"size.vertical.box"))->

  //All calculations are made into points {
$Txt_unit:=OB Get:C1224($Obj_param;"size.unit";Is text:K8:3)

If ($Txt_unit#"pt")
	
	$Num_marginLeft:=math_Length_conversion ($Num_marginLeft;$Txt_unit;"pt";0)
	$Num_marginTop:=math_Length_conversion ($Num_marginTop;$Txt_unit;"pt";0)
	$Num_marginRight:=math_Length_conversion ($Num_marginRight;$Txt_unit;"pt";0)
	$Num_marginBottom:=math_Length_conversion ($Num_marginBottom;$Txt_unit;"pt";0)
	$Num_gapHorizontal:=math_Length_conversion ($Num_gapHorizontal;$Txt_unit;"pt";0)
	$Num_gapVertical:=math_Length_conversion ($Num_gapVertical;$Txt_unit;"pt";0)
	
End if   //}

$Num_availableWidth:=$Lon_paperWidth-$Num_marginLeft-$Num_marginRight
$Num_availableHeight:=$Lon_paperHeight-$Num_marginTop-$Num_marginBottom

$Num_labelWidth:=(($Num_availableWidth+$Num_gapHorizontal)/$Lon_columnNumber)-$Num_gapHorizontal
$Num_labelHeight:=(($Num_availableHeight+$Num_gapVertical)/$Lon_rowNumber)-$Num_gapVertical

  //update UI
(OBJECT Get pointer:C1124(Object named:K67:5;"size.width.box"))->:=$Num_labelWidth
(OBJECT Get pointer:C1124(Object named:K67:5;"size.height.box"))->:=$Num_labelHeight

  //store values
If ($Txt_unit#"pt")
	
	  //convert to user units
	$Lon_round:=Choose:C955($Txt_unit="mm";1;2)
	
	$Num_labelWidth:=math_Length_conversion ($Num_labelWidth;"pt";$Txt_unit;$Lon_round)
	$Num_labelHeight:=math_Length_conversion ($Num_labelHeight;"pt";$Txt_unit;$Lon_round)
	
	$Num_marginLeft:=math_Length_conversion ($Num_marginLeft;"pt";$Txt_unit;$Lon_round)
	$Num_marginTop:=math_Length_conversion ($Num_marginTop;"pt";$Txt_unit;$Lon_round)
	$Num_marginRight:=math_Length_conversion ($Num_marginRight;"pt";$Txt_unit;$Lon_round)
	$Num_marginBottom:=math_Length_conversion ($Num_marginBottom;"pt";$Txt_unit;$Lon_round)
	
	$Num_gapHorizontal:=math_Length_conversion ($Num_gapHorizontal;"pt";$Txt_unit;$Lon_round)
	$Num_gapVertical:=math_Length_conversion ($Num_gapVertical;"pt";$Txt_unit;$Lon_round)
	
End if 

  //store user values
OB SET:C1220($Obj_param;\
"rows";$Lon_rowNumber;\
"columns";$Lon_columnNumber;\
"size.width";$Num_labelWidth;\
"gap.horizontal";$Num_gapHorizontal;\
"size.height";$Num_labelHeight;\
"gap.vertical";$Num_gapVertical;\
"margin.left";$Num_marginLeft;\
"margin.top";$Num_marginTop;\
"margin.right";$Num_marginRight;\
"margin.bottom";$Num_marginBottom)

  //#ACI0097966
OB SET:C1220($Obj_param;\
"setting.landscape";Choose:C955($Lon_orientation;"";"false";"true"))

CALL SUBFORM CONTAINER:C1086(-2)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End