  // ----------------------------------------------------
  // Object method : LAYOUT.size.vertical.box - (4D Labels)
  // ID[F7FFD5BF30184095984191658430857A]
  // Created #21-9-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
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
	: ($Lon_formEvent=On Data Change:K2:15)
		
		If ((OBJECT Get pointer:C1124(Object named:K67:5;"automatic_resizing"))->=0)
			
			layout_SET_DATA ("gap.vertical")
			
		Else 
			
			layout_AUTOMATIC_RESIZING 
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Losing Focus:K2:8)
		
		If (Not:C34(Shift down:C543))
			
			GOTO OBJECT:C206(*;"layout.rows")
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 