// ----------------------------------------------------
// Object method : Editor.Debug_HistoryList - (4D Labels)
// ID[D33BE75517074F5EB5E8B389A1977115]
// Created #25-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
var $Lon_formEvent : Integer
var $Ptr_me : Pointer
var $Txt_me : Text

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Selection Change:K2:29)
		
		var $Lon_column; $Lon_row : Integer
		LISTBOX GET CELL POSITION:C971(*; OBJECT Get name:C1087(Object current:K67:2); $Lon_column; $Lon_row)
		
		Editor_HISTORY_RESTORE($Lon_row)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 