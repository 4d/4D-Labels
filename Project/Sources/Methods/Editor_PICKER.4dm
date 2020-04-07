//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_PICKER
  // Database: 4D Labels
  // ID[58911415406542338F2D521694CF3CFF]
  // Created #19-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent;$Lon_parameters;$Lon_size)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_font;$Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
	$Lon_formEvent:=Form event code:C388
	$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
	$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Getting Focus:K2:7)
		
		  //set the attributes according to the current selection
		OBJECT SET FONT:C164(*;$Txt_me;Editor_SEL_Get_font )
		OBJECT SET FONT SIZE:C165(*;$Txt_me;Editor_SEL_Get_font_size )
		
		  //______________________________________________________
	: ($Lon_formEvent=On After Edit:K2:43)
		
		  ///set selection attributes according to the current values
		$Txt_font:=OBJECT Get font:C1069(*;$Txt_me)
		$Lon_size:=OBJECT Get font size:C1070(*;$Txt_me)
		
		Editor_SEL_SET_FONT ($Txt_font)
		Editor_SEL_SET_FONT_SIZE ($Lon_size)
		
		  //keep the current values
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End