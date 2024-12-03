// ----------------------------------------------------
// Form method : LABEL_WIZARD.Editor - (4D Labels)
// ID[41EE05A7C3E649609878704547C31B11]
// Created #10-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
var $Lon_; $Lon_formEvent; $Lon_left; $Lon_top : Integer
var $Ptr_me : Pointer
var $Dom_label; $Txt_me : Text

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

// ----------------------------------------------------

Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=-109)  //set subform's offsets
		
		OBJECT GET COORDINATES:C663(*; $Txt_me; $Lon_left; $Lon_top; $Lon_; $Lon_)
		
		OB SET:C1220((OBJECT Get pointer:C1124(Object named:K67:5; "object"; $Txt_me))->; \
			"offset-X"; $Lon_left+51; \
			"offset-Y"; $Lon_top+55)
		
		//______________________________________________________
	: ($Lon_formEvent=-103)
		
		//enable "Enter"
		OB SET:C1220((OBJECT Get pointer:C1124(Object named:K67:5; "object"))->; \
			"no-print"; False:C215)
		
		//______________________________________________________
	: ($Lon_formEvent=-104)  //disable "Enter"
		
		OB SET:C1220((OBJECT Get pointer:C1124(Object named:K67:5; "object"))->; \
			"no-print"; True:C214)
		
		//______________________________________________________
	: ($Lon_formEvent=-113)  //drag & drop of a label template
		
		$Dom_label:=label_Parse_document(C_LABEL_DOCUMENT; True:C214)
		
		OB SET:C1220((OBJECT Get pointer:C1124(Object named:K67:5; "object"))->; \
			"dom"; $Dom_label; \
			"path"; C_LABEL_DOCUMENT)
		
		$Ptr_me->:=$Dom_label
		
		//______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		//
		
		//______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		//
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 