  //update linked object

(OBJECT Get pointer:C1124(Object named:K67:5;"layout.columns"))->:=Self:C308->

If ((OBJECT Get pointer:C1124(Object named:K67:5;"automatic_resizing"))->=0)
	
	layout_SET_DATA ("rows")
	
Else 
	
	layout_AUTOMATIC_RESIZING 
	
End if 