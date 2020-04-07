  // ----------------------------------------------------
  // Object method : LABEL_WIZARD.size.order.menu - (4D Labels)
  // ID[2CB316AB43554FB897108D7574FF5F1A]
  // Created #15-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($Boo_buffer)
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
	: ($Lon_formEvent=On Data Change:K2:15)
		
		GET LIST ITEM PARAMETER:C985(*;$Txt_me;*;"data";$Boo_buffer)
		
		layout_SET_DATA ("setting.vertical";Choose:C955($Boo_buffer;"true";"false"))
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 