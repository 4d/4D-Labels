// ----------------------------------------------------
// Object method : LABEL_WIZARD.method.radio.label - (4D Labels)
// ID[B6243D4A22874385A08CAA18BF40E57D]
// Created #18-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
var $Lon_formEvent : Integer
var $Ptr_me : Pointer
var $Txt_me : Text

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		layout_SET_DATA("method.evaluate-per-label"; "true")
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 