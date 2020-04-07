//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SELECT
  // Database: 4D Labels
  // ID[D80F721F2E414A69B7ABE13F6AFBDF18]
  // Created #2-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_parameters)
C_REAL:C285($Num_height;$Num_tx;$Num_ty;$Num_width;$Num_x;$Num_y)
C_TEXT:C284($Dom_buffer;$Dom_canvas;$Dom_g;$Dom_label;$Txt_ID)
C_OBJECT:C1216($Obj_parameters)

If (False:C215)
	C_BOOLEAN:C305(Editor_SELECT ;$0)
	C_TEXT:C284(Editor_SELECT ;$1)
	C_TEXT:C284(Editor_SELECT ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Dom_label:=$1
	$Txt_ID:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
	$Obj_parameters:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	$Dom_canvas:=OB Get:C1224($Obj_parameters;"canvas";Is text:K8:3)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_label;"editor:x";$Num_x)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_label;"editor:y";$Num_y)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_label;"editor:width";$Num_width)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_label;"editor:height";$Num_height)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_label;"editor:tx";$Num_tx)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_label;"editor:ty";$Num_ty)

  //create the selection rectangle
$Dom_g:=DOM Create XML element:C865($Dom_canvas;"g";\
"id";OB Get:C1224(<>label_params;"select-prefix";Is text:K8:3)+$Txt_ID;\
"transform";"translate("+String:C10($Num_tx;"&xml")+","+String:C10($Num_ty;"&xml")+")";\
"editor:object-type";"";\
"editor:object-id";"")

$Dom_buffer:=DOM Create XML element:C865($Dom_g;"rect";\
"id";OB Get:C1224(<>label_params;"select-rect-prefix";Is text:K8:3)+$Txt_ID;\
"x";$Num_x;\
"y";$Num_y;\
"width";$Num_width;\
"height";$Num_height;\
"fill";OB Get:C1224(<>label_params;"selection-fill";Is text:K8:3);\
"fill-opacity";OB Get:C1224(<>label_params;"selection-fill-opacity";Is real:K8:4);\
"stroke";OB Get:C1224(<>label_params;"selection-stroke";Is text:K8:3);\
"stroke-opacity";OB Get:C1224(<>label_params;"selection-stroke-opacity";Is real:K8:4);\
"stroke-width";OB Get:C1224(<>label_params;"selection-stroke-width";Is real:K8:4);\
"editor:object-type";"";\
"editor:object-id";"";\
"shape-rendering";"crispEdges")

  //keep selection
Editor_SELECT_APPEND ((OBJECT Get pointer:C1124(Object subform container:K67:4))->;$Txt_ID)

  //update UI
Editor_SEL_DISPLAY_HANDLES ($Dom_g;$Txt_ID;$Num_x;$Num_y;$Num_width;$Num_height)

  //go to picker
GOTO OBJECT:C206(*;"picker")

  // ----------------------------------------------------
  // Return
  //NONE
  // ----------------------------------------------------
  // End