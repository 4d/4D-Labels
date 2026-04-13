// ----------------------------------------------------
// Object method : LABEL_WIZARD.method.list - (4D Labels)
// ID[DD895AC73DAC43619D1C1D0323D7280B]
// Created #18-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
var $Lon_formEvent; $Lon_ID : Integer
var $Ptr_me : Pointer
var $Txt_me; $Txt_method : Text

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Data Change:K2:15)
		
		GET LIST ITEM:C378($Ptr_me->; *; $Lon_ID; $Txt_method)
		layout_SET_DATA("method.name"; $Txt_method*Num:C11($Lon_ID>0))
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 