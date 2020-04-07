  // ----------------------------------------------------
  // Object method : Editor.Debug_HistoryList - (4D Labels)
  // ID[D33BE75517074F5EB5E8B389A1977115]
  // Created #25-5-2015 by Vincent de Lachaux
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
	: ($Lon_formEvent=On Selection Change:K2:29)
		
		C_LONGINT:C283($Lon_column;$Lon_row)
		LISTBOX GET CELL POSITION:C971(*;OBJECT Get name:C1087(Object current:K67:2);$Lon_column;$Lon_row)
		
		Editor_HISTORY_RESTORE ($Lon_row)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 