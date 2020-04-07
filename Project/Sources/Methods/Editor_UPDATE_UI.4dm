//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_UPDATE_UI
  // Database: 4D Labels
  // ID[9B131DFDC08A4070A1EC5C90C8E8E4CF]
  // Created #10-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // Contextual update
  // ----------------------------------------------------
  // Declarations
C_BLOB:C604($Blb_buffer)
C_LONGINT:C283($kLon_clear;$kLon_copy;$kLon_cut;$kLon_duplicate;$kLon_paste;$kLon_selectAll)
C_LONGINT:C283($Lon_menuEditIndex;$Lon_objectCount;$Lon_parameters;$Lon_selCount)
C_TEXT:C284($Dom_label)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
	$kLon_cut:=4
	$kLon_copy:=5
	$kLon_paste:=6
	$kLon_clear:=7
	$kLon_selectAll:=8
	$kLon_duplicate:=9
	
	$Dom_label:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
	
	$Lon_selCount:=Editor_SEL_Get_count ($Dom_label)
	$Lon_objectCount:=Editor_Get_objectCount ($Dom_label)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //-------------- TOOLBAR ----------------
  //OBJECT SET ENABLED(*;"Align@";1<$Lon_count)
  //OBJECT SET ENABLED(*;"Distribute@";2<$Lon_count)
  //OBJECT SET ENABLED(*;"Move@";0<$Lon_count)

  //-------------- MENUS ------------------
ARRAY TEXT:C222($tTxt_Labels;0x0000)
ARRAY TEXT:C222($tTxt_References;0x0000)
GET MENU ITEMS:C977(Get menu bar reference:C979;$tTxt_Labels;$tTxt_References)
$Lon_menuEditIndex:=Find in array:C230($tTxt_Labels;"Edit")

If ($Lon_selCount>0)
	
	ENABLE MENU ITEM:C149($Lon_menuEditIndex;$kLon_cut)
	ENABLE MENU ITEM:C149($Lon_menuEditIndex;$kLon_copy)
	ENABLE MENU ITEM:C149($Lon_menuEditIndex;$kLon_clear)
	ENABLE MENU ITEM:C149($Lon_menuEditIndex;$kLon_duplicate)
	
Else 
	
	DISABLE MENU ITEM:C150($Lon_menuEditIndex;$kLon_cut)
	DISABLE MENU ITEM:C150($Lon_menuEditIndex;$kLon_copy)
	DISABLE MENU ITEM:C150($Lon_menuEditIndex;$kLon_clear)
	DISABLE MENU ITEM:C150($Lon_menuEditIndex;$kLon_duplicate)
	
End if 

If ($Lon_objectCount>0)\
 & ($Lon_objectCount#$Lon_selCount)
	
	ENABLE MENU ITEM:C149($Lon_menuEditIndex;$kLon_selectAll)
	
Else 
	
	DISABLE MENU ITEM:C150($Lon_menuEditIndex;$kLon_selectAll)
	
End if 

GET PASTEBOARD DATA:C401("com.4d.blob.xml";$Blb_buffer)

If (OK=1)
	
	ENABLE MENU ITEM:C149($Lon_menuEditIndex;$kLon_paste)
	
Else 
	
	DISABLE MENU ITEM:C150($Lon_menuEditIndex;$kLon_paste)
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End