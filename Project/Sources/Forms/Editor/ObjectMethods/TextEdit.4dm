  // ----------------------------------------------------
  // Object method : Editor.TextEdit - (4D Labels)
  // ID[E95F15F1D5D34123B94CF67501F5F9E5]
  // Created #17-2-2015 by Vincent de Lachaux
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
	: ($Lon_formEvent=On Getting Focus:K2:7)
		
		HIGHLIGHT TEXT:C210(*;$Txt_me;1;MAXLONG:K35:2)
		
		  //disable the shortcuts
		OBJECT SET VISIBLE:C603(*;"Rewind";False:C215)
		OBJECT SET VISIBLE:C603(*;"Forward";False:C215)
		OBJECT SET VISIBLE:C603(*;"Delete";False:C215)
		OBJECT SET VISIBLE:C603(*;"Back";False:C215)
		OBJECT SET VISIBLE:C603(*;"All";False:C215)
		OBJECT SET VISIBLE:C603(*;"Copy";False:C215)
		OBJECT SET VISIBLE:C603(*;"Paste";False:C215)
		OBJECT SET VISIBLE:C603(*;"Cut";False:C215)
		OBJECT SET VISIBLE:C603(*;"Duplicate";False:C215)
		
		OBJECT SET ENABLED:C1123(*;"Select@";False:C215)
		OBJECT SET ENABLED:C1123(*;"FillColor@";False:C215)
		OBJECT SET ENABLED:C1123(*;"StrokeColor@";False:C215)
		OBJECT SET ENABLED:C1123(*;"StrokeWidth@";False:C215)
		
		OBJECT SET ENABLED:C1123(*;"Align@";False:C215)
		OBJECT SET ENABLED:C1123(*;"Distribute@";False:C215)
		OBJECT SET ENABLED:C1123(*;"Move@";False:C215)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Losing Focus:K2:8)
		
		  //activate the shortcuts
		OBJECT SET VISIBLE:C603(*;"Rewind";True:C214)
		OBJECT SET VISIBLE:C603(*;"Forward";True:C214)
		OBJECT SET VISIBLE:C603(*;"Delete";True:C214)
		OBJECT SET VISIBLE:C603(*;"Back";True:C214)
		OBJECT SET VISIBLE:C603(*;"All";True:C214)
		OBJECT SET VISIBLE:C603(*;"Copy";True:C214)
		OBJECT SET VISIBLE:C603(*;"Paste";True:C214)
		OBJECT SET VISIBLE:C603(*;"Cut";True:C214)
		OBJECT SET VISIBLE:C603(*;"Duplicate";True:C214)
		
		OBJECT SET ENABLED:C1123(*;"Select@";True:C214)
		OBJECT SET ENABLED:C1123(*;"FillColor@";True:C214)
		OBJECT SET ENABLED:C1123(*;"StrokeColor@";True:C214)
		OBJECT SET ENABLED:C1123(*;"StrokeWidth@";True:C214)
		
		If (Editor_TEXT_EDIT_Stop )
			
			Editor_ON_DATA_CHANGE 
			
		End if 
		
		Editor_UPDATE_UI 
		
		GOTO OBJECT:C206(*;"Image")
		
		  //must be callled in the context in which the original event was triggered
		CALL SUBFORM CONTAINER:C1086(-103)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 