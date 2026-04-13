// ----------------------------------------------------
// Object method : LABEL_WIZARD.size.unit.menu - (4D Labels)
// ID[114A00735B1141668A92BA5653F2DBF6]
// Created #15-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
var $Lon_formEvent : Integer
var $Ptr_me : Pointer
var $Txt_buffer; $Txt_me : Text

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Data Change:K2:15)
		
		GET LIST ITEM PARAMETER:C985(*; $Txt_me; *; "data"; $Txt_buffer)
		layout_SET_DATA("size.unit"; $Txt_buffer)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 