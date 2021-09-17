// ----------------------------------------------------
// Form method : LABEL_WIZARD - (4D Labels)
// ID[5441EAFC29AA4A28AC57FABB4E78FAED]
// Created #1-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($Boo_scrollbar; $boo_light)
C_LONGINT:C283($kLon_messagePage; $Lon_; $Lon_bottom; $Lon_color; $Lon_formEvent; $Lon_page)
C_LONGINT:C283($Lon_top)
C_PICTURE:C286($Pic_buffer)
C_TEXT:C284($Txt_object)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388

$kLon_messagePage:=3

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		COMPILER_LABELS
		COMPILER_wizard
		
		wizard_INIT(True:C214)
		
		//init the dynamic object
		(OBJECT Get pointer:C1124(Object named:K67:5; "object"))->:=New object:C1471(\
			"path"; C_LABEL_DOCUMENT; \
			"field-list-enabled"; True:C214; \
			"dom"; label_Parse_document(C_LABEL_DOCUMENT; True:C214))
		
		wizard_GOTO_PAGE(1)
		
		$boo_light:=(FORM Get color scheme:C1761="light")
		OBJECT SET VISIBLE:C603(*; "@background@"; $boo_light)
		
		
		SET TIMER:C645(-1)
		
		
		//______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		wizard_DEINIT
		
		//______________________________________________________
	: ($Lon_formEvent=On Page Change:K2:54)
		
		wizard_UPDATE_UI
		
		//______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		wizard_UPDATE_UI
		
		//________________________________________
	: ($Lon_formEvent=On Activate:K2:9)
		
		$Lon_page:=FORM Get current page:C276
		
		//intensify the text labels
		OBJECT SET RGB COLORS:C628(*; "@.label@"; Foreground color:K23:1; Background color none:K23:10)
		
		Case of 
				
				//----------------------------------------
			: ($Lon_page=1)
				
				If (OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5; "object"))->; "field-list-enabled"; Is boolean:K8:9))
					
					//display list as activated
					OBJECT SET RGB COLORS:C628(*; "field.list"; Foreground color:K23:1; Background color none:K23:10)
					
				End if 
				
				//show focus ring, if any
				$Txt_object:=OBJECT Get name:C1087(Object with focus:K67:3)
				OBJECT SET VISIBLE:C603(*; "field.search.focus"; $Txt_object="field.search.box")
				OBJECT SET VISIBLE:C603(*; "field.list.focus"; $Txt_object="field.list")
				
				EXECUTE METHOD IN SUBFORM:C1085("editor"; "Editor_ON_FOCUS")
				
				//----------------------------------------
			: ($Lon_page=2)
				
				EXECUTE METHOD IN SUBFORM:C1085("layout"; "layout_HANDLE"; *; $Lon_formEvent)
				
				//----------------------------------------
			Else 
				
				//NOTHING MORE TO DO
				
				//----------------------------------------
		End case 
		
		//________________________________________
	: ($Lon_formEvent=On Deactivate:K2:10)
		
		$Lon_page:=FORM Get current page:C276
		
		//dim the text labels
		$Lon_color:=OB Get:C1224(<>label_params; "disabledTextColor"; Is longint:K8:6)
		OBJECT SET RGB COLORS:C628(*; "@.label@"; $Lon_color; Background color none:K23:10)
		
		Case of 
				
				//----------------------------------------
			: ($Lon_page=1)
				
				//display list as deactivated
				OBJECT SET RGB COLORS:C628(*; "field.list"; OB Get:C1224(<>label_params; "disabledTextColor"; Is longint:K8:6); Background color none:K23:10)
				
				//hide the focus rings
				OBJECT SET VISIBLE:C603(*; "@.focus"; False:C215)
				
				EXECUTE METHOD IN SUBFORM:C1085("editor"; "Editor_ON_BLUR")
				
				//----------------------------------------
			: ($Lon_page=2)
				
				EXECUTE METHOD IN SUBFORM:C1085("layout"; "layout_HANDLE"; *; $Lon_formEvent)
				
				//----------------------------------------
			Else 
				
				//NOTHING MORE TO DO
				
				//----------------------------------------
		End case 
		
		//________________________________________
	: ($Lon_formEvent=On Close Box:K2:21)
		
		If (False:C215)  //################################################
			
			If (FORM Get current page:C276#$kLon_messagePage)
				
				//get a screenshot of the current page
				FORM SCREENSHOT:C940($Pic_buffer)
				(OBJECT Get pointer:C1124(Object named:K67:5; "Variable"))->:=$Pic_buffer
				
				mess_DISPLAY(New object:C1471(\
					"message"; Get localized string:C991("areYouSure"); \
					"ok-label"; ".Save"; \
					"no-label"; Get localized string:C991("doNotSave"); \
					"cancel-label"; Get localized string:C991("cancel"); \
					"doNotAskAgain"; False:C215; \
					"not-resizable"; True:C214)\
					; $kLon_messagePage)
				
			End if 
			
		Else 
			
			CANCEL:C270
			
		End if   //#####################################################
		
		//________________________________________
	: ($Lon_formEvent=On Resize:K2:27)
		
		EXECUTE METHOD IN SUBFORM:C1085("editor"; "Editor_ON_RESIZE")
		
		If (FORM Get current page:C276=$kLon_messagePage)
			
			obj_CENTER("alert.box"; "alert.mask"; Horizontally centered:K39:1)
			
		End if 
		
		//vertical scrollbar of the layout subform
		OBJECT GET COORDINATES:C663(*; "layout"; $Lon_; $Lon_top; $Lon_; $Lon_bottom)
		$Boo_scrollbar:=(($Lon_bottom-$Lon_top)<600)
		OBJECT SET SCROLLBAR:C843(*; "layout"; False:C215; $Boo_scrollbar)
		OBJECT SET VISIBLE:C603(*; "scroolbar.@"; $Boo_scrollbar)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 