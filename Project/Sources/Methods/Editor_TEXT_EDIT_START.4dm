//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_TEXT_EDIT_START
  // Database: 4D Labels
  // ID[960A786CC9F64B3FA5175842F13F4D31]
  // Created #9-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($kLon_topOffset;$Lon_bottom;$Lon_fontSize;$Lon_frameBottom;$Lon_frameLeft;$Lon_frameRight)
C_LONGINT:C283($Lon_frameTop;$Lon_left;$Lon_parameters;$Lon_right;$Lon_style;$Lon_top)
C_REAL:C285($Num_editorHeight;$Num_editorWidth;$Num_editorX;$Num_editorY;$Num_xScaling;$Num_xTranslation)
C_REAL:C285($Num_yTranslation)
C_TEXT:C284($Dom_canvas;$Dom_label;$Dom_object;$Txt_buffer;$Txt_fill;$Txt_ID)
C_TEXT:C284($Txt_stroke)
C_OBJECT:C1216($Obj_dialog)

ARRAY LONGINT:C221($tLon_length;0)
ARRAY LONGINT:C221($tLon_pos;0)

If (False:C215)
	C_TEXT:C284(Editor_TEXT_EDIT_START ;$1)
	C_TEXT:C284(Editor_TEXT_EDIT_START ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Dom_canvas:=$1
	$Txt_ID:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
	$Dom_label:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Dom_object:=DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID)

  //keep references
OB SET:C1220($Obj_dialog;\
"DomTextEdit";$Dom_object;\
"DomTextEditId";$Txt_ID)

editor_SELECT_HIDE ($Txt_ID)

SVG GET ATTRIBUTE:C1056(*;"Image";$Txt_ID;"editor:x";$Num_editorX)
SVG GET ATTRIBUTE:C1056(*;"Image";$Txt_ID;"editor:y";$Num_editorY)
SVG GET ATTRIBUTE:C1056(*;"Image";$Txt_ID;"editor:width";$Num_editorWidth)
SVG GET ATTRIBUTE:C1056(*;"Image";$Txt_ID;"editor:height";$Num_editorHeight)
SVG GET ATTRIBUTE:C1056(*;"Image";$Txt_ID;"editor:sx";$Num_xScaling)

SVG GET ATTRIBUTE:C1056(*;"Image";$Txt_ID;"editor:tx";$Num_xTranslation)
SVG GET ATTRIBUTE:C1056(*;"Image";$Txt_ID;"editor:ty";$Num_yTranslation)

OBJECT GET COORDINATES:C663(*;"Image";$Lon_frameLeft;$Lon_frameTop;$Lon_frameRight;$Lon_frameBottom)

$kLon_topOffset:=OB Get:C1224(<>label_params;"top";Is longint:K8:6)

$Lon_left:=$Num_editorX+$Num_xTranslation
$Lon_top:=$kLon_topOffset+$Num_editorY+$Num_yTranslation
$Lon_right:=$Lon_left+$Num_editorWidth
$Lon_bottom:=$Lon_top+$Num_editorHeight

  //corrections
$Lon_left:=Choose:C955($Lon_left<$Lon_frameLeft;$Lon_frameLeft;$Lon_left)
$Lon_top:=Choose:C955($Lon_top<$Lon_frameTop;$Lon_frameTop;$Lon_top)
$Lon_right:=Choose:C955($Lon_right>$Lon_frameRight;$Lon_frameRight;$Lon_right)
$Lon_bottom:=Choose:C955($Lon_bottom>$Lon_frameBottom;$Lon_frameBottom;$Lon_bottom)

$Dom_object:=DOM Find XML element by ID:C1010($Dom_label;$Txt_ID)

  //style
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"style";$Txt_buffer)
$Lon_style:=Plain:K14:1
$Lon_style:=Choose:C955($Txt_buffer="@italic@";$Lon_style | Italic:K14:3;$Lon_style)
$Lon_style:=Choose:C955($Txt_buffer="@bold@";$Lon_style | Bold:K14:2;$Lon_style)
$Lon_style:=Choose:C955($Txt_buffer="@underline@";$Lon_style | Underline:K14:4;$Lon_style)
OBJECT SET FONT STYLE:C166(*;"TextEdit";$Lon_style)

  //alignment
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"alignment";$Txt_buffer)

Case of 
		
		  //________________________________________
	: ($Txt_buffer="center")
		
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"TextEdit";Align left:K42:2)
		
		  //________________________________________
	: ($Txt_buffer="end")
		
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"TextEdit";Align right:K42:4)
		
		  //________________________________________
	Else 
		
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"TextEdit";Align left:K42:2)
		
		  //________________________________________
End case 

  //font name
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"font-name";$Txt_buffer)
OBJECT SET FONT:C164(*;"TextEdit";$Txt_buffer)

  //font size
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"font-size";$Lon_fontSize)
OBJECT SET FONT SIZE:C165(*;"TextEdit";$Lon_fontSize*$Num_xScaling)

  //colors
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"stroke-color";$Txt_stroke)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"fill-color";$Txt_fill)
OBJECT SET RGB COLORS:C628(*;"TextEdit";Color_to_long ($Txt_stroke;True:C214);Color_to_long ($Txt_fill))

  //value
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"value";(OBJECT Get pointer:C1124(Object named:K67:5;"TextEdit"))->)

OBJECT SET VISIBLE:C603(*;"TextEdit";True:C214)
OBJECT SET COORDINATES:C1248(*;"TextEdit";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
GOTO OBJECT:C206(*;"TextEdit")

  //disable shortcuts
OBJECT SET VISIBLE:C603(*;"shortcut.@";False:C215)

CALL SUBFORM CONTAINER:C1086(-104)  //disable "Enter"

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End