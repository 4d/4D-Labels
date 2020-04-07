  // ----------------------------------------------------
  // Object method : Editor.action.alignment - (4D Labels)
  // ID[CCECDE563B48477092C5CF9B83D5EFAE]
  // Created #20-8-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_;$Lon_bottom;$Lon_formEvent;$Lon_left;$Lon_selCount)
C_POINTER:C301($Ptr_me;$Ptr_object)
C_TEXT:C284($Dom_canvas;$Dom_label;$Mnu_;$Mnu_pop;$Txt_me;$Txt_parameter)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		Editor_Get_grips (->$Dom_label;->$Dom_canvas)
		
		$Lon_selCount:=Editor_SEL_Get_count ($Dom_label)
		
		$Mnu_:=Create menu:C408
		
		$Mnu_pop:=Editor_MENU_ALIGN ($Mnu_;$Lon_selCount;True:C214)
		
		OBJECT GET COORDINATES:C663(*;$Txt_me;$Lon_left;$Lon_;$Lon_;$Lon_bottom)
		
		$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5;"object")
		$Lon_left:=$Lon_left+OB Get:C1224($Ptr_object->;"offset-X";Is longint:K8:6)-51
		$Lon_bottom:=$Lon_bottom+OB Get:C1224($Ptr_object->;"offset-Y";Is longint:K8:6)-61
		
		$Txt_parameter:=Dynamic pop up menu:C1006($Mnu_pop;"";$Lon_left;$Lon_bottom)
		RELEASE MENU:C978($Mnu_pop)
		
		RELEASE MENU:C978($Mnu_)
		
		Editor_ON_CONTEXTUAL_MENU ($Dom_label;$Dom_canvas;$Txt_parameter)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 