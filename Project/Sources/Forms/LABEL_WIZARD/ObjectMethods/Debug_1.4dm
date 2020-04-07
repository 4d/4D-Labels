C_TEXT:C284($Mnu_main;$Txt_choice)

ARRAY TEXT:C222($tTxt_components;0)

$Mnu_main:=Create menu:C408

APPEND MENU ITEM:C411($Mnu_main;"Debug")
SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"debug")

COMPONENT LIST:C1001($tTxt_components)

If (Find in array:C230($tTxt_components;"labels")=-1)
	
	APPEND MENU ITEM:C411($Mnu_main;"Old Editor")
	SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"old")
	
End if 

APPEND MENU ITEM:C411($Mnu_main;"Dump label")
SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"label")

APPEND MENU ITEM:C411($Mnu_main;"Dump svg")
SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"svg")

$Txt_choice:=Dynamic pop up menu:C1006($Mnu_main)
RELEASE MENU:C978($Mnu_main)

Case of 
		
		  //………………………………………………………………………………………
	: (Length:C16($Txt_choice)=0)
		
		  // nothing selected
		
		  //………………………………………………………………………………………
	: ($Txt_choice="debug")
		
		wizard_GOTO_PAGE (4)
		
		  //………………………………………………………………………………………
	: ($Txt_choice="old")
		
		EXECUTE METHOD:C1007("OLD_LABEL_EDITOR";*;C_MASTER_TABLE;C_LABEL_DOCUMENT)
		
		  //………………………………………………………………………………………
	: ($Txt_choice="label")
		
		DEBUG_EXPORT ("label";OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;"dom";Is text:K8:3))
		
		  //………………………………………………………………………………………
	: ($Txt_choice="svg")
		
		DEBUG_EXPORT ("canvas";OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5;"object";"editor"))->;"canvas";Is text:K8:3))
		
		  //………………………………………………………………………………………
	Else 
		
		ASSERT:C1129(False:C215;"Unknown menu action ("+$Txt_choice+")")
		
		  //………………………………………………………………………………………
End case 