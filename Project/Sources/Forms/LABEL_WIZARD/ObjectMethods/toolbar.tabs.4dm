// ----------------------------------------------------
// Object method : LABEL_WIZARD.Subform - (4D Labels)
// ID[313628AB1A714520A2A6A2721C11054B]
// Created #8-6-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_bottom; $Lon_formEvent; $Lon_left; $Lon_page; $Lon_right; $Lon_top)
C_LONGINT:C283($Lon_width)
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
	: ($Lon_formEvent=-1)\
		 | ($Lon_formEvent=-2)
		
		$Lon_page:=Abs:C99($Lon_formEvent)
		
		//go to the wanted page
		wizard_GOTO_PAGE($Lon_page)
		
		//update UI
		SET TIMER:C645(-1)
		
		//update the widget
		$Ptr_me->:=$Lon_page
		
		//______________________________________________________
	: ($Lon_formEvent<0)  //set my width
		
		$Lon_width:=Abs:C99($Lon_formEvent)
		OBJECT GET COORDINATES:C663(*; $Txt_me; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
		OBJECT SET COORDINATES:C1248(*; $Txt_me; $Lon_left; $Lon_top; $Lon_left+$Lon_width; $Lon_bottom)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 