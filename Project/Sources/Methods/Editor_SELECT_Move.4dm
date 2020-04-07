//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SELECT_Move
  // Database: 4D Labels
  // ID[EE3415EDF3E64B3B82D3C683721E7761]
  // Created #20-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_REAL:C285($2)
C_REAL:C285($3)
C_BOOLEAN:C305($4)

C_BOOLEAN:C305($Boo_redraw;$Boo_resize;$Boo_update)
C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_image)
C_REAL:C285($Num_bottom;$Num_cx;$Num_cy;$Num_left;$Num_moveX;$Num_moveY)
C_REAL:C285($Num_r;$Num_right;$Num_sx;$Num_sy;$Num_top;$Num_tx)
C_REAL:C285($Num_ty;$Num_zoom)
C_TEXT:C284($Dom_canvas;$Dom_current;$Dom_object;$Txt_ID;$Txt_rotate;$Txt_scale)
C_TEXT:C284($Txt_selectId;$Txt_translate)
C_OBJECT:C1216($Obj_parameters)

If (False:C215)
	C_BOOLEAN:C305(Editor_SELECT_Move ;$0)
	C_TEXT:C284(Editor_SELECT_Move ;$1)
	C_REAL:C285(Editor_SELECT_Move ;$2)
	C_REAL:C285(Editor_SELECT_Move ;$3)
	C_BOOLEAN:C305(Editor_SELECT_Move ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=4;"Missing parameter"))
	
	  //Required parameters
	$Txt_ID:=$1
	$Num_moveX:=$2
	$Num_moveY:=$3
	$Boo_redraw:=$4
	
	$Boo_resize:=Macintosh command down:C546 | Windows Ctrl down:C562
	
	  //Optional parameters
	If ($Lon_parameters>=5)
		
		  // <NONE>
		
	End if 
	
	$Obj_parameters:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	$Dom_canvas:=OB Get:C1224($Obj_parameters;"canvas";Is text:K8:3)
	
	$Dom_current:=DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID)
	
	$Ptr_image:=OBJECT Get pointer:C1124(Object named:K67:5;"Image")
	
	$Txt_selectId:=OB Get:C1224(<>label_params;"select-prefix";Is text:K8:3)+$Txt_ID
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:tx";$Num_tx)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:ty";$Num_ty)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:sx";$Num_sx)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:sy";$Num_sy)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:cx";$Num_cx)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:cy";$Num_cy)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_current;"editor:r";$Num_r)

$Num_zoom:=Editor_Get_zoom 

$Num_tx:=$Num_tx+($Num_moveX*$Num_zoom)
$Num_ty:=$Num_ty+($Num_moveY*$Num_zoom)

If ($Boo_redraw)
	
	$Dom_object:=DOM Find XML element by ID:C1010((OBJECT Get pointer:C1124(Object subform container:K67:4))->;$Txt_ID)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"left";$Num_left)
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"top";$Num_top)
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"right";$Num_right)
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"bottom";$Num_bottom)
	
	If ($Boo_resize)
		
		$Num_right:=$Num_right+$Num_moveX
		$Num_bottom:=$Num_bottom+$Num_moveY
		
	Else 
		
		$Num_left:=$Num_left+$Num_moveX
		$Num_top:=$Num_top+$Num_moveY
		$Num_right:=$Num_right+$Num_moveX
		$Num_bottom:=$Num_bottom+$Num_moveY
		
	End if 
	
	DOM SET XML ATTRIBUTE:C866($Dom_object;\
		"left";$Num_left;\
		"top";$Num_top;\
		"right";$Num_right;\
		"bottom";$Num_bottom)
	
	$Boo_update:=($Num_moveX#0) | ($Num_moveY#0)
	
Else 
	
	$Txt_translate:="translate("+String:C10($Num_tx;"&xml")+","+String:C10($Num_ty;"&xml")+")"
	$Txt_scale:="scale("+String:C10($Num_sx;"&xml")+","+String:C10($Num_sy;"&xml")+")"
	$Txt_rotate:="rotate("+String:C10($Num_r;"&xml")+","+String:C10($Num_cx;"&xml")+","+String:C10($Num_cy;"&xml")+")"
	
	  //do not update the dom during this event, we need the original tx,ty during movement
	SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_ID;\
		"transform";$Txt_translate+" "+$Txt_scale+" "+$Txt_rotate)
	SVG SET ATTRIBUTE:C1055($Ptr_image->;$Txt_selectId;\
		"transform";$Txt_translate+" "+$Txt_rotate)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Boo_update

  // ----------------------------------------------------
  // End