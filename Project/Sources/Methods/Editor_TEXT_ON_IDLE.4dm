//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_TEXT_ON_IDLE
  // Database: 4D Labels
  // ID[2F9D154A95084A419FE730A8B280E23C]
  // Created #9-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($Lon_parameters;$Lon_X;$Lon_xClick;$Lon_Y;$Lon_yClick)
C_REAL:C285($Num_height;$Num_width;$Num_zoom)
C_TEXT:C284($Txt_ID;$Txt_scale;$Txt_translate)

If (False:C215)
	C_LONGINT:C283(Editor_TEXT_ON_IDLE ;$1)
	C_LONGINT:C283(Editor_TEXT_ON_IDLE ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Lon_X:=$1
	$Lon_Y:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Num_zoom:=Editor_Get_zoom 

DOM GET XML ATTRIBUTE BY NAME:C728(Editor_Get_current ;"id";$Txt_ID)

Editor_GET_CLICK (->$Lon_xClick;->$Lon_yClick)

$Num_width:=Abs:C99($Lon_X-$Lon_xClick)/$Num_zoom
$Num_height:=Abs:C99($Lon_Y-$Lon_yClick)/$Num_zoom

$Lon_X:=Choose:C955($Lon_X>$Lon_xClick;$Lon_xClick;$Lon_X)
$Lon_Y:=Choose:C955($Lon_Y>$Lon_yClick;$Lon_yClick;$Lon_Y)

$Txt_translate:="translate("+String:C10($Lon_X;"&xml")+","+String:C10($Lon_Y;"&xml")+")"
$Txt_scale:="scale("+String:C10($Num_zoom;"&xml")+","+String:C10($Num_zoom;"&xml")+")"

  //group
SVG SET ATTRIBUTE:C1055(*;"Image";$Txt_ID;\
"transform";$Txt_translate+" "+$Txt_scale)

  //rect
SVG SET ATTRIBUTE:C1055(*;"Image";$Txt_ID+"-rect";\
"width";$Num_width;\
"height";$Num_height)

  //textArea
SVG SET ATTRIBUTE:C1055(*;"Image";$Txt_ID+"-textArea";\
"width";$Num_width;\
"height";$Num_height)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End