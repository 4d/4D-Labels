  // ----------------------------------------------------
  // Object method : LAYOUT.automatic_resizing - (4D Labels)
  // ID[B596ACFC4BE4464EB7A51AE1D33974B0]
  // Created #21-9-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		If ($Ptr_me->=1)
			
			layout_SET_DATA ("setting.auto-width";"true")
			layout_AUTOMATIC_RESIZING 
			
		Else 
			
			layout_SET_DATA ("setting.auto-width";"false")
			
		End if 
		
		layout_UPDATE_UI 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 