//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : DOM_ELEMENT_MOVE
  // Database: 4D Labels
  // ID[07D651BFFA02417CB8E1341C163E334C]
  // Created #25-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($Lon_level;$Lon_parameters)
C_TEXT:C284($Dom_new;$Dom_node;$Dom_parent)

If (False:C215)
	C_TEXT:C284(DOM_ELEMENT_MOVE ;$1)
	C_LONGINT:C283(DOM_ELEMENT_MOVE ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Dom_node:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Lon_level:=$2  //
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Dom_parent:=DOM Get parent XML element:C923($Dom_node)

DOM_ELEMENT_CLEAR_ID ($Dom_node)

If ($Lon_level>0)
	
	  //move to given level
	$Dom_new:=DOM Insert XML element:C1083($Dom_parent;$Dom_node;$Lon_level)
	
Else 
	
	  //move to last level
	$Dom_new:=DOM Append XML element:C1082($Dom_parent;$Dom_node)
	
End if 

DOM REMOVE XML ELEMENT:C869($Dom_node)

DOM_ELEMENT_RESTORE_ID ($Dom_new)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End