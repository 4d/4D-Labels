//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SELECT_SET
  // Database: 4D Labels
  // ID[EBD55F0A97754E8EB559C5C4DC2330AB]
  // Created #7-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_selected)
C_OBJECT:C1216($Obj_dialog)

If (False:C215)
	C_TEXT:C284(Editor_SELECT_SET ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Txt_selected:=$1
		
	End if 
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
OB SET:C1220($Obj_dialog;\
"rect-dragger";$Txt_selected)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End