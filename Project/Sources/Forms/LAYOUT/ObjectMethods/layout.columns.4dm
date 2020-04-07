  // ----------------------------------------------------
  // Object method : LAYOUT.layout.columns - (4D Labels)
  // ID[30A388D639B5411EB979949733161EFF]
  // Created #24-9-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($Boo_update)
C_LONGINT:C283($Lon_formEvent;$Lon_key)
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
	: ($Lon_formEvent=On Before Keystroke:K2:6)
		
		$Lon_key:=Character code:C91(Keystroke:C390)
		
		Case of 
				
				  //______________________________________________________
			: ($Lon_key=Down arrow key:K12:19)
				
				If (Self:C308->>1)
					
					Self:C308->:=Self:C308->-1
					$Boo_update:=True:C214
					
				End if 
				
				FILTER KEYSTROKE:C389("")
				
				  //______________________________________________________
			: ($Lon_key=Up arrow key:K12:18)
				
				Self:C308->:=Self:C308->+1
				FILTER KEYSTROKE:C389("")
				$Boo_update:=True:C214
				
				  //______________________________________________________
		End case 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Data Change:K2:15)
		
		$Boo_update:=True:C214
		
		  //______________________________________________________
	: ($Lon_formEvent=On Getting Focus:K2:7)
		
		OBJECT SET VISIBLE:C603(*;"layout.columns.stepper";True:C214)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Losing Focus:K2:8)
		
		OBJECT SET VISIBLE:C603(*;"layout.columns.stepper";False:C215)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 

If ($Boo_update)
	
	  //update linked object
	(OBJECT Get pointer:C1124(Object named:K67:5;"layout.columns.stepper"))->:=Self:C308->
	
	If ((OBJECT Get pointer:C1124(Object named:K67:5;"automatic_resizing"))->=0)
		
		layout_SET_DATA ("columns")
		
	Else 
		
		layout_AUTOMATIC_RESIZING 
		
	End if 
End if 