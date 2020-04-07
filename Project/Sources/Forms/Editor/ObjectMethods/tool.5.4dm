  // ----------------------------------------------------
  // Object method : Editor.tool.5 - (4D Labels)
  // ID[1C2248AEDC214764B81E5661DEFE09AC]
  // Created #5-10-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Mnu_main;$Txt_choice;$Txt_me;$Txt_tool)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Alternative Click:K2:36)
		
		$Mnu_main:=Create menu:C408
		
		APPEND MENU ITEM:C411($Mnu_main;Get localized string:C991("Menus_rect"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"rect")
		SET MENU ITEM ICON:C984($Mnu_main;-1;"#images/editor/tools/m_rect.png")
		
		APPEND MENU ITEM:C411($Mnu_main;Get localized string:C991("Menus_roundRect"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"round-rect")
		SET MENU ITEM ICON:C984($Mnu_main;-1;"#images/editor/tools/m_round-rect.png")
		
		$Txt_choice:=Dynamic pop up menu:C1006($Mnu_main)
		RELEASE MENU:C978($Mnu_main)
		
		If (Length:C16($Txt_choice)#0)
			
			Editor_SET_TOOL ($Txt_choice)
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Txt_tool:=OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;"rect-tool";Is text:K8:3)
		$Txt_tool:=Choose:C955($Txt_tool="@rect";$Txt_tool;"rect")
		Editor_SET_TOOL ($Txt_tool)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 