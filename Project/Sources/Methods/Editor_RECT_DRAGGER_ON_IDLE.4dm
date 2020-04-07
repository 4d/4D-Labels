//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_RECT_DRAGGER_ON_IDLE
  // Database: 4D Labels
  // ID[7B36E5AC746642DCA5F7E611A121572B]
  // Created #6-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_REAL:C285($1)
C_REAL:C285($2)

C_BOOLEAN:C305($Boo_redraw)
C_LONGINT:C283($Lon_count;$Lon_i;$Lon_parameters;$Lon_xClick;$Lon_yClick)
C_REAL:C285($Num_height;$Num_moveX;$Num_moveY;$Num_width;$Num_X;$Num_Y)
C_REAL:C285($Num_zoom)
C_TEXT:C284($Dom_buffer;$Dom_canvas;$Dom_label;$Txt_buffer;$Txt_transform)

If (False:C215)
	C_REAL:C285(Editor_RECT_DRAGGER_ON_IDLE ;$1)
	C_REAL:C285(Editor_RECT_DRAGGER_ON_IDLE ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Num_X:=$1
	$Num_Y:=$2
	
	$Txt_buffer:=Editor_SELECT_Get_dragger 
	
	Editor_Get_grips (->$Dom_label;->$Dom_canvas)
	
	Editor_GET_CLICK (->$Lon_xClick;->$Lon_yClick)
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Length:C16($Txt_buffer)#0)
	
	$Num_width:=Abs:C99($Num_X-$Lon_xClick)
	$Num_height:=Abs:C99($Num_Y-$Lon_yClick)
	
	$Num_X:=Choose:C955($Num_X>$Lon_xClick;$Lon_xClick;$Num_X)
	$Num_Y:=Choose:C955($Num_Y>$Lon_yClick;$Lon_yClick;$Num_Y)
	
	$Txt_transform:="translate("+String:C10($Num_X;"&xml")+","+String:C10($Num_Y;"&xml")+")"
	
	If (Editor_SELECT_Objects ($Num_X;$Num_Y;$Num_width;$Num_height))
		
		$Boo_redraw:=True:C214
		
		DOM SET XML ATTRIBUTE:C866($Txt_buffer;\
			"width";$Num_width;\
			"height";$Num_height;\
			"transform";$Txt_transform)
		
		Editor_UPDATE_UI 
		
	Else 
		
		  //this is enough to simply draw the rect
		SVG SET ATTRIBUTE:C1055(*;"Image";"select";\
			"width";$Num_width;\
			"height";$Num_height;\
			"transform";$Txt_transform)
		
	End if 
	
Else   //handle manipulation
	
	$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;"selects")
	$Lon_count:=DOM Count XML elements:C726($Dom_buffer;"select")
	
	$Num_zoom:=Editor_Get_zoom 
	
	$Num_moveX:=($Num_X-$Lon_xClick)/$Num_zoom
	$Num_moveY:=($Num_Y-$Lon_yClick)/$Num_zoom
	
	If ($Lon_count#0)
		
		If (Length:C16(Editor_Get_handle )#0)
			
			For ($Lon_i;1;$Lon_count;1)
				
				Editor_SELECT_Resize (Editor_SELECT_Get_id ($Dom_label;$Lon_i);$Num_moveX;$Num_moveY;False:C215)
				
			End for 
			
		Else 
			
			For ($Lon_i;1;$Lon_count;1)
				
				Editor_SELECT_Move (Editor_SELECT_Get_id ($Dom_label;$Lon_i);$Num_moveX;$Num_moveY;False:C215)
				
			End for 
		End if 
	End if 
End if 

If ($Boo_redraw)
	
	Editor_REDRAW 
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End