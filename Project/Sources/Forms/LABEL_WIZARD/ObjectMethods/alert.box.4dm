  // ----------------------------------------------------
  // Object method : NQR.message - (4D Report)
  // ID[BD24E8DCC7684EB9A0A642A958F325B6]
  // Created #4-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_action;$Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent<0)
		
		$Txt_action:=OB Get:C1224($Ptr_me->;"action";Is text:K8:3)
		
		Case of 
				
				  //______________________________________________________
			: ($Txt_action="cancel")
				
				  //don't close
				REJECT:C38
				
				  //cleanup
				CLEAR VARIABLE:C89((OBJECT Get pointer:C1124(Object named:K67:5;"Variable"))->)
				
				  //restore the current page
				FORM GOTO PAGE:C247(OB Get:C1224($Ptr_me->;"page";Is longint:K8:6))
				
				  //______________________________________________________
			: ($Txt_action="no")
				
				CANCEL:C270
				
				  //______________________________________________________
			: ($Txt_action="ok")
				
				  //save
				If (wizard_Save )
					
					ACCEPT:C269
					
				End if 
				
				  //……………………………………………………………
		End case 
		
		  //restore resizing if any
		If (OB Is defined:C1231($Ptr_me->;"h-resizing"))
			
			FORM SET HORIZONTAL RESIZING:C892(OB Get:C1224($Ptr_me->;"h-resizing";Is boolean:K8:9))
			
		End if 
		
		If (OB Is defined:C1231($Ptr_me->;"v-resizing"))
			
			FORM SET VERTICAL RESIZING:C893(OB Get:C1224($Ptr_me->;"v-resizing";Is boolean:K8:9))
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Getting Focus:K2:7)
		
		  //NOTHING MORE TO DO
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 