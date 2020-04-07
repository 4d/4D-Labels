  // ----------------------------------------------------
  // Form method : HDI_MESSAGE
  // ID[E2EF77FACFED4246B79064DE7B61D327]
  // Created #16-6-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($kLon_page;$Lon_formEvent)
C_PICTURE:C286($Pic_buffer)
C_OBJECT:C1216($Obj_message)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

$kLon_page:=3  //the page of the widget

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Resize:K2:27)
		
		If (FORM Get current page:C276=$kLon_page)
			
			obj_CENTER ("alert.box";"alert.mask";Horizontally centered:K39:1)
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Close Box:K2:21)
		
		If (FORM Get current page:C276#$kLon_page)
			
			  //get a screenshot of the current page
			FORM SCREENSHOT:C940($Pic_buffer)
			(OBJECT Get pointer:C1124(Object named:K67:5;"Variable"))->:=$Pic_buffer
			
			OB SET:C1220($Obj_message;\
				"message";Get localized string:C991("areYouSure");\
				"ok-label";"save";\
				"no-label";Get localized string:C991("doNotSave");\
				"cancel-label";Get localized string:C991("cancel");\
				"doNotAskAgain";False:C215;\
				"not-resizable";True:C214)
			
			mess_DISPLAY ($Obj_message;$kLon_page)
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 