//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_ON_CLICKED
  // Database: 4D Labels
  // ID[5EACB0CF9D72435EB6BAC4A9B9D42A41]
  // Created #22-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Dom_canvas;$Dom_form;$Dom_label;$Txt_formName;$Txt_tool)
C_OBJECT:C1216($Obj_parameters)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
	$Obj_parameters:=Editor_Get_grips (->$Dom_label;->$Dom_canvas)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Dom_form:=DOM Find XML element by ID:C1010($Dom_label;"form")

If (OK=1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_form;"name";$Txt_formName)
	
End if 

If (Length:C16($Txt_formName)=0)  //it is not a form
	
	If (Contextual click:C713)
		
		Editor_ON_CONTEXTUAL_MENU ($Dom_label;$Dom_canvas)
		
	Else 
		
		OB SET:C1220($Obj_parameters;\
			"PasteX";OB Get:C1224($Obj_parameters;"step-X";Is longint:K8:6);\
			"PasteY";OB Get:C1224($Obj_parameters;"step-Y";Is longint:K8:6);\
			"PasteZ";1)
		
		  //because the image does not take focus from the text edit
		  //close text edit if any
		Editor_TEXT_EDIT_Stop 
		
		If (MOUSEX#-1)\
			 & (MOUSEY#-1)
			
			OB SET:C1220($Obj_parameters;\
				"clic-x";MOUSEX;\
				"clic-y";MOUSEY)
			
			ASSERT:C1129(DEBUG_Update ("clic";MOUSEX;MOUSEY))
			
			$Txt_tool:=Editor_Get_current_tool 
			
			Case of 
					
					  //________________________________________
				: ($Txt_tool="select")
					
					Editor_RECT_DRAGGER_BEGIN (MOUSEX;MOUSEY)
					
					  //________________________________________
				: ($Txt_tool="rect")\
					 | ($Txt_tool="round-rect")
					
					Editor_COMMON_BEGIN ($Txt_tool;MOUSEX;MOUSEY)
					
					  //________________________________________
				: ($Txt_tool="line")
					
					Editor_COMMON_BEGIN ($Txt_tool;MOUSEX;MOUSEY)
					
					  //________________________________________
				: ($Txt_tool="ellipse")
					
					Editor_COMMON_BEGIN ($Txt_tool;MOUSEX;MOUSEY)
					
					  //________________________________________
				: ($Txt_tool="polyline")
					
					Editor_COMMON_BEGIN ($Txt_tool;MOUSEX;MOUSEY)
					
					  //________________________________________
				: ($Txt_tool="text")
					
					Editor_TEXT_BEGIN (MOUSEX;MOUSEY)
					
					  //________________________________________
			End case 
		End if 
	End if 
	
Else 
	
	  //NOTHING MORE TO DO
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End