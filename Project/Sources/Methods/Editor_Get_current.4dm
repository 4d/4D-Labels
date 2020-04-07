//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_Get_current
  // Database: 4D Labels
  // ID[C5EF9D164FE94570AA8665624529EEB4]
  // Created #2-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_BOOLEAN:C305($1)

C_BOOLEAN:C305($Boo_clear)
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Dom_current)
C_OBJECT:C1216($Obj_dialog)

If (False:C215)
	C_TEXT:C284(Editor_Get_current ;$0)
	C_BOOLEAN:C305(Editor_Get_current ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Boo_clear:=$1
		
	End if 
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Dom_current:=OB Get:C1224($Obj_dialog;"DomCurrent";Is text:K8:3)

If ($Boo_clear)
	
	OB SET:C1220($Obj_dialog;\
		"DomCurrent";"")
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Dom_current

  // ----------------------------------------------------
  // End