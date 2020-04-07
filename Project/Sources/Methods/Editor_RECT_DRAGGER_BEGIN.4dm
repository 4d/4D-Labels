//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_RECT_DRAGGER_BEGIN
  // Database: 4D Labels
  // ID[66DF3C1CAF704A5BA24DCD2DAA5EFD1E]
  // Created #2-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_REAL:C285($1)
C_REAL:C285($2)

C_BOOLEAN:C305($Boo_update)
C_LONGINT:C283($Lon_mouseX;$Lon_mouseY;$Lon_parameters)
C_TEXT:C284($Dom_canvas;$Dom_select;$Txt_clicked)

If (False:C215)
	C_REAL:C285(Editor_RECT_DRAGGER_BEGIN ;$1)
	C_REAL:C285(Editor_RECT_DRAGGER_BEGIN ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Lon_mouseX:=$1
		$Lon_mouseY:=$2
		
	Else 
		
		$Lon_mouseX:=MOUSEX
		$Lon_mouseY:=MOUSEY
		
	End if 
	
	$Dom_canvas:=OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;"canvas";Is text:K8:3)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Length:C16($Dom_canvas)#0)
	
	$Dom_select:=Editor_SELECT_Get_dragger (True:C214)
	
	$Txt_clicked:=SVG Find element ID by coordinates:C1054(*;"Image";$Lon_mouseX;$Lon_mouseY)
	
	Case of 
			
			  //________________________________________
		: (Length:C16($Txt_clicked)=0)\
			 | ($Txt_clicked="label")  //background image
			
			Editor_TOOL_SET_ENABLED (False:C215)
			
			Editor_SELECT_Clear ((OBJECT Get pointer:C1124(Object subform container:K67:4))->;$Dom_canvas)
			
			$Dom_select:=DOM Create XML element:C865($Dom_canvas;"rect";\
				"id";"select";\
				"transform";"translate("+String:C10($Lon_mouseX;"&xml")+","+String:C10($Lon_mouseY;"&xml")+")";\
				"x";0;\
				"y";0;\
				"width";0;\
				"height";0;\
				"editor:object-type";"";\
				"editor:object-id";"";\
				"shape-rendering";"optimizeSpeed";\
				"fill";"#9999FF";\
				"fill-opacity";0.1;\
				"stroke";"#9999FF";\
				"stroke-width";1;\
				"stroke-opacity";0.7)
			
			Editor_SELECT_SET ($Dom_select)
			
			$Boo_update:=True:C214
			
			  //________________________________________
		: ($Txt_clicked="select@")  //into a handle
			
			Editor_SELECT_HANDLE ($Txt_clicked)
			
			  //________________________________________
		Else 
			
			$Boo_update:=Editor_SELECT_Add ($Txt_clicked;Shift down:C543)
			
			Editor_UPDATE_UI 
			
			  //________________________________________
	End case 
	
	If ($Boo_update)
		
		Editor_REDRAW 
		
	End if 
	
	SET TIMER:C645(-1)
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End