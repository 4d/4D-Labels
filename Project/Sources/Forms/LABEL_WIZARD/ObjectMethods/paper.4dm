  // ----------------------------------------------------
  // Object method : Paper.paper - (4D Labels)
  // ID[35BE5FB873D9480EB19DE89104DCB5E4]
  // Created #18-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Dom_label;$Mnu_main;$Txt_choice;$Txt_ID;$Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Mouse Move:K2:35)
		
		  //$Lon_x:=MOUSEX
		  //$Lon_y:=MOUSEY
		  //$Txt_ID:=SVG Find element ID by coordinates(*;$Txt_me;$Lon_x;$Lon_y)
		  //If ($Txt_ID="label-@")
		  //SVG GET ATTRIBUTE(*;$Txt_me;$Txt_ID;"data";$Txt_buffer)
		  //SVG SET ATTRIBUTE(*;$Txt_me;"tips";"x";$Lon_x-5;"y";$Lon_y-24;"visibility";"visible";"4D-text";$Txt_buffer)//Else
		  //SVG SET ATTRIBUTE(*;$Txt_me;"tips";"visibility";"hidden")//End if
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		If (Contextual click:C713)
			
			$Mnu_main:=Create menu:C408
			
			APPEND MENU ITEM:C411($Mnu_main;"Show printable area")
			SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"printable-area")
			
			$Txt_choice:=Dynamic pop up menu:C1006($Mnu_main)
			RELEASE MENU:C978($Mnu_main)
			
			Case of 
					
					  //………………………………………………………………………………………
				: (Length:C16($Txt_choice)=0)
					
					  // nothing selected
					
					  //………………………………………………………………………………………
				: ($Txt_choice="printable-area")
					
					CALL SUBFORM CONTAINER:C1086(-8858)
					
					  //………………………………………………………………………………………
				Else 
					
					ASSERT:C1129(False:C215;"Unknown menu action ("+$Txt_choice+")")
					
					  //………………………………………………………………………………………
			End case 
			
		Else 
			
			$Txt_ID:=SVG Find element ID by coordinates:C1054(*;$Txt_me;MOUSEX;MOUSEY)
			
			If ($Txt_ID="label-@")
				
				$Dom_label:=OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;"dom";Is text:K8:3)
				
				  //store value
				label_data_SET ("start";Delete string:C232($Txt_ID;1;6);$Dom_label)
				
				  //update UI
				wizard_PAPER ($Dom_label)
				
			End if 
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 