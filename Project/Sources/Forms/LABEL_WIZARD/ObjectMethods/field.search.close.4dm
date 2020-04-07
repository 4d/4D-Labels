  // ----------------------------------------------------
  // Object method : Search.ClearButton - (4D Labels)
  // ID[7EC6B66CB0E349FFBE4C72B99FA9E379]
  // Created #11-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_list;$Ptr_me)
C_TEXT:C284($Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		CLEAR VARIABLE:C89((OBJECT Get pointer:C1124(Object named:K67:5;"field.search.box"))->)
		
		OBJECT SET VISIBLE:C603(*;$Txt_me;False:C215)
		
		$Ptr_list:=OBJECT Get pointer:C1124(Object named:K67:5;"field.list")
		
		CLEAR LIST:C377($Ptr_list->;*)
		
		$Ptr_list->:=wizard_Field_list (C_MASTER_TABLE;(OBJECT Get pointer:C1124(Object named:K67:5;"field.search.box"))->)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 