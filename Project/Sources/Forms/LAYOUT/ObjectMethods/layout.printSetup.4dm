C_LONGINT:C283($Lon_orientation)

PRINT SETTINGS:C106(1)

If (OK=1)
	
	GET PRINT OPTION:C734(Orientation option:K47:2;$Lon_orientation)
	layout_SET_DATA ("setting.landscape";Choose:C955($Lon_orientation;"";"false";"true"))
	
	  //OB SET($Obj_buffer;\
		$Txt_target;$Txt_value;\
		"target";$Txt_target)
	
	  //CALL SUBFORM CONTAINER(-1)
	
	  //wizard_SET_DATA ("setting.landscape";Choose($Lon_orientation;"";"false";"true"))
	
	If ((OBJECT Get pointer:C1124(Object named:K67:5;"automatic_resizing"))->=1)
		
		layout_AUTOMATIC_RESIZING 
		
	End if 
End if 