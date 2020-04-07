//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_RECT_DRAGGER_Stop
  // Database: 4D Labels
  // ID[FA75B89A84464FDDB9D9276729CDB29A]
  // Created #6-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_REAL:C285($1)
C_REAL:C285($2)

C_BOOLEAN:C305($Boo_redraw;$Boo_update)
C_LONGINT:C283($Lon_count;$Lon_i;$Lon_parameters;$Lon_xClick;$Lon_yClick)
C_REAL:C285($Num_moveX;$Num_moveY;$Num_X;$Num_Y;$Num_zoom)
C_TEXT:C284($Dom_buffer;$Dom_label;$Txt_buffer)

If (False:C215)
	C_BOOLEAN:C305(Editor_RECT_DRAGGER_Stop ;$0)
	C_REAL:C285(Editor_RECT_DRAGGER_Stop ;$1)
	C_REAL:C285(Editor_RECT_DRAGGER_Stop ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Num_X:=$1
	$Num_Y:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
	$Txt_buffer:=Editor_SELECT_Get_dragger (True:C214)
	
	Editor_Get_grips (->$Dom_label)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Length:C16($Txt_buffer)#0)
	
	$Boo_redraw:=True:C214
	
Else   //handle manipulation
	
	$Num_zoom:=Editor_Get_zoom 
	
	Editor_GET_CLICK (->$Lon_xClick;->$Lon_yClick)
	
	$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;"selects")
	$Lon_count:=DOM Count XML elements:C726($Dom_buffer;"select")
	
	$Num_moveX:=($Num_X-$Lon_xClick)/$Num_zoom
	$Num_moveY:=($Num_Y-$Lon_yClick)/$Num_zoom
	
	If ($Lon_count#0)
		
		If (Length:C16(Editor_Get_handle )#0)
			
			For ($Lon_i;1;$Lon_count;1)
				
				$Boo_update:=$Boo_update\
					 | Editor_SELECT_Resize (Editor_SELECT_Get_id ($Dom_label;$Lon_i);$Num_moveX;$Num_moveY;True:C214)
				
			End for 
			
		Else 
			
			For ($Lon_i;1;$Lon_count;1)
				
				$Boo_update:=$Boo_update\
					 | Editor_SELECT_Move (Editor_SELECT_Get_id ($Dom_label;$Lon_i);$Num_moveX;$Num_moveY;True:C214)
				
			End for 
		End if 
		
		Editor_SET_HANDLE 
		
		$Boo_redraw:=True:C214
		
	End if 
End if 

If ($Boo_redraw)
	
	  //this will erase the selection rect
	Editor_REDRAW 
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Boo_update

  // ----------------------------------------------------
  // End