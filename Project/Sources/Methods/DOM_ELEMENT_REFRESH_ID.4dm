//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : DOM_ELEMENT_REFRESH_ID
  // Database: 4D Labels
  // ID[F785D09A74244453BDB935A4052E56E7]
  // Created #21-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters;$Lon_x)
C_TEXT:C284($Dom_target;$Txt_ID)

ARRAY LONGINT:C221($tLon_types;0)
ARRAY TEXT:C222($tDom_nodes;0)

If (False:C215)
	C_TEXT:C284(DOM_ELEMENT_REFRESH_ID ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Dom_target:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
xml_GET_ATTRIBUTE_BY_NAME ($Dom_target;"id";->$Txt_ID)

If (Length:C16($Txt_ID)>0)
	
	DOM SET XML ATTRIBUTE:C866($Dom_target;\
		"id";$Txt_ID)  //because the id index needs to be re-built
	
End if 

  //also for child elements
DOM GET XML CHILD NODES:C1081($Dom_target;$tLon_types;$tDom_nodes)

Repeat 
	
	$Lon_x:=Find in array:C230($tLon_types;XML ELEMENT:K45:20;$Lon_x+1)
	
	If ($Lon_x>0)
		
		DOM_ELEMENT_REFRESH_ID ($tDom_nodes{$Lon_x})  //----------- RECURSIVE
		
	End if 
Until ($Lon_x=-1)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End