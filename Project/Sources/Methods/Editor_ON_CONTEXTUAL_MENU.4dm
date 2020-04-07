//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_ON_CONTEXTUAL_MENU
  // Database: 4D Labels
  // ID[8FA1643B8FC5418FBEC257F78F4C5200]
  // Created #20-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_BOOLEAN:C305($Boo_createMenu;$Boo_isImage;$Boo_isImageOnly;$Boo_rect;$Boo_round_rect;$Boo_withFill)
C_BOOLEAN:C305($Boo_withStroke;$Boo_withText)
C_LONGINT:C283($Lon_buffer;$Lon_objectCount;$Lon_parameters;$Lon_selCount)
C_TEXT:C284($Dom_canvas;$Dom_label;$Mnu_buffer;$Mnu_pop;$Txt_buffer;$Txt_parameter)
C_TEXT:C284($Txt_preserveAspectRatio)
C_OBJECT:C1216($Obj_inventory)

ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_TEXT:C284(Editor_ON_CONTEXTUAL_MENU ;$1)
	C_TEXT:C284(Editor_ON_CONTEXTUAL_MENU ;$2)
	C_TEXT:C284(Editor_ON_CONTEXTUAL_MENU ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	$Boo_createMenu:=True:C214
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Dom_label:=$1
		$Dom_canvas:=$2
		
		If ($Lon_parameters>=3)
			
			$Txt_parameter:=$3
			$Boo_createMenu:=False:C215
			
		End if 
		
	Else 
		
		Editor_Get_grips (->$Dom_label;->$Dom_canvas)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If ($Boo_createMenu)
	
	$Lon_objectCount:=Editor_Get_objectCount ($Dom_label)
	$Lon_selCount:=Editor_SEL_Get_count ($Dom_label)
	
	If ($Lon_selCount>0)
		
		$Obj_inventory:=Editor_SEL_INVENTORY ($Dom_label)
		
		$Boo_withText:=OB Get:C1224($Obj_inventory;"text";Is boolean:K8:9)
		$Boo_isImage:=OB Get:C1224($Obj_inventory;"image";Is boolean:K8:9)
		$Boo_isImageOnly:=OB Get:C1224($Obj_inventory;"image-only";Is boolean:K8:9)
		$Boo_withFill:=OB Get:C1224($Obj_inventory;"fill";Is boolean:K8:9)
		$Boo_withStroke:=OB Get:C1224($Obj_inventory;"stroke";Is boolean:K8:9)
		$Boo_rect:=OB Get:C1224($Obj_inventory;"rect";Is boolean:K8:9)
		$Boo_round_rect:=OB Get:C1224($Obj_inventory;"round-rect";Is boolean:K8:9)
		
		CLEAR VARIABLE:C89($Obj_inventory)
		
	End if 
	
	$Mnu_pop:=Create menu:C408
	
	Editor_MENU_TOOLS ($Mnu_pop)
	
	If ($Lon_selCount>0)
		
		APPEND MENU ITEM:C411($Mnu_pop;"-")
		
		If ($Boo_withStroke | $Boo_withFill)
			
			If ($Boo_withFill)
				
				$Mnu_buffer:=mnu_Color (Editor_SEL_Get_color ("fill";$Dom_label;$Dom_canvas);"back")
				APPEND MENU ITEM:C411($Mnu_pop;":xliff:Menus_fill";$Mnu_buffer)
				RELEASE MENU:C978($Mnu_buffer)
				
				If (<>Boo_debug)
					
					Editor_MENU_OPACITY ("fill";$Mnu_pop;Editor_SEL_Get_opacity ("fill";$Dom_label;$Dom_canvas))
					
				End if 
				
				APPEND MENU ITEM:C411($Mnu_pop;"-")
				
			End if 
			
			If ($Boo_withStroke)
				
				$Mnu_buffer:=mnu_Color (Editor_SEL_Get_color ("stroke";$Dom_label;$Dom_canvas);"front")
				APPEND MENU ITEM:C411($Mnu_pop;":xliff:Menus_stroke";$Mnu_buffer)
				RELEASE MENU:C978($Mnu_buffer)
				
				If (<>Boo_debug)
					
					Editor_MENU_OPACITY ("stroke";$Mnu_pop;Editor_SEL_Get_opacity ("stroke";$Dom_label;$Dom_canvas))
					
				End if 
				
				Editor_MENU_STROKE_WIDTH (Editor_SEL_Get_stroke_width ($Dom_label;$Dom_canvas);$Mnu_pop)
				
			End if 
		End if 
		
		If ($Boo_withText)
			
			APPEND MENU ITEM:C411($Mnu_pop;"-")
			
			Editor_MENU_TEXT_ATTRIBUTES ($Mnu_pop;$Dom_label;$Dom_canvas)
			
		End if 
		
		If ($Lon_selCount>1)\
			 | ($Lon_objectCount>1)
			
			APPEND MENU ITEM:C411($Mnu_pop;"-")
			
			If ($Lon_selCount>1)
				
				Editor_MENU_ALIGN ($Mnu_pop;$Lon_selCount)
				
			End if 
			
			If ($Lon_objectCount>1)\
				 & ($Lon_selCount#$Lon_objectCount)
				
				Editor_MENU_LEVEL ($Mnu_pop;$Lon_objectCount)
				
			End if 
		End if 
		
		If ($Boo_isImage)
			
			APPEND MENU ITEM:C411($Mnu_pop;"-")
			
			Editor_MENU_IMAGE_OPTIONS (Editor_SEL_Get_aspect_ratio ($Dom_label);$Mnu_pop)
			
		End if 
		
		If ($Boo_rect | $Boo_round_rect)
			
			APPEND MENU ITEM:C411($Mnu_pop;"-")
			
			If ($Boo_round_rect)
				
				APPEND MENU ITEM:C411($Mnu_pop;Get localized string:C991("Menus_rect"))
				SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"rect")
				
			End if 
			
			If ($Boo_rect)
				
				APPEND MENU ITEM:C411($Mnu_pop;Get localized string:C991("Menus_roundRect"))
				SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"round-rect")
				
			End if 
		End if 
	End if 
	
	$Txt_parameter:=Dynamic pop up menu:C1006($Mnu_pop)
	RELEASE MENU:C978($Mnu_pop)
	
End if 

  //===========================================================
Case of 
		
		  //________________________________________
	: (Length:C16($Txt_parameter)=0)
		
		  //NO CHOICE
		
		  //________________________________________
	: ($Txt_parameter="rect")\
		 | ($Txt_parameter="round-rect")
		
		Editor_SEL_SET_RECT ($Txt_parameter;$Dom_label;$Dom_canvas)
		
		  //________________________________________
	: ($Txt_parameter="tool-@")
		
		Editor_SET_TOOL (Replace string:C233($Txt_parameter;"tool-";"";1))
		
		  //________________________________________
	: ($Txt_parameter="fontColor_@")
		
		$Lon_buffer:=mnu_Get_color ($Txt_parameter)
		Editor_SEL_SET_TEXT_COLOR ($Lon_buffer;$Dom_label;$Dom_canvas)
		
		  //keep font color
		Editor_SET_FONT_COLOR ($Lon_buffer)
		
		  //________________________________________
	: ($Txt_parameter="backColor_@")\
		 | ($Txt_parameter="frontColor_@")
		
		  //target
		$Txt_buffer:=Choose:C955($Txt_parameter="back@";"fill";"stroke")
		
		$Lon_buffer:=mnu_Get_color ($Txt_parameter)
		Editor_SEL_SET_COLOR ($Txt_buffer;$Lon_buffer;$Dom_label;$Dom_canvas)
		
		  //________________________________________
	: ($Txt_parameter="@-opacity-@")
		
		  //target
		$Txt_buffer:=Substring:C12($Txt_parameter;1;Position:C15("-";$Txt_parameter)-1)
		
		  //opacity
		$Lon_buffer:=Num:C11(Replace string:C233($Txt_parameter;$Txt_buffer+"-opacity-";"";*))
		
		Editor_SEL_SET_OPACITY ($Txt_buffer;$Lon_buffer;$Dom_label;$Dom_canvas)
		
		  //________________________________________
	: ($Txt_parameter="stroke-width-@")
		
		$Lon_buffer:=Num:C11(Replace string:C233($Txt_parameter;"stroke-width-";"";*))
		
		Editor_SEL_SET_STROKE_WIDTH ($Lon_buffer;$Dom_label;$Dom_canvas)
		
		  //________________________________________
	: ($Txt_parameter="level-@")
		
		Editor_SEL_LEVEL (Delete string:C232($Txt_parameter;1;6);$Dom_label;$Dom_canvas)
		
		  //________________________________________
	: ($Txt_parameter="align-@")
		
		Editor_SEL_ALIGN (Delete string:C232($Txt_parameter;1;6);$Dom_label)
		
		  //________________________________________
	: ($Txt_parameter="distribute-@")
		
		Editor_SEL_DISTRIBUTE (Delete string:C232($Txt_parameter;1;11);$Dom_label)
		
		  //________________________________________
	: ($Txt_parameter="font-size-@")
		
		Editor_SEL_SET_FONT_SIZE (Num:C11(Replace string:C233($Txt_parameter;"font-size-";"";*));$Dom_label;$Dom_canvas)
		
		  //________________________________________
	: ($Txt_parameter="font-@")
		
		If ($Txt_parameter="@-picker")
			
			GOTO OBJECT:C206(*;"picker")
			OPEN FONT PICKER:C1303
			
		Else 
			
			Editor_SEL_SET_FONT (Delete string:C232($Txt_parameter;1;5);$Dom_label;$Dom_canvas)
			
		End if 
		
		  //________________________________________
	: ($Txt_parameter="text-style-@")
		
		Editor_SEL_SET_TEXT_STYLE (Replace string:C233($Txt_parameter;"text-style-";"";*);$Dom_label;$Dom_canvas)
		
		  //________________________________________
	: ($Txt_parameter="text-align-@")
		
		Editor_SEL_SET_TEXT_ALIGNMENT (Replace string:C233($Txt_parameter;"text-align-";"";*);$Dom_label;$Dom_canvas)
		
		  //________________________________________
	: ($Txt_parameter="image-@")
		
		$Txt_preserveAspectRatio:=Choose:C955($Txt_parameter="@-remove";"false";"true")
		Editor_SEL_SET_ASPECT_RATIO ($Txt_preserveAspectRatio;$Dom_label;$Dom_canvas)
		
		  //________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_parameter+"\"")
		
		  //________________________________________
End case 

  //give focus to the picker if any
GOTO OBJECT:C206(*;"picker")

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End