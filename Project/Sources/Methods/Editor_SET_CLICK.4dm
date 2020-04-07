//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SET_CLICK
  // Database: 4D Labels
  // ID[D80F069C26434FECA81AD9CB1C005BEE]
  // Created #2-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($Lon_mouseX;$Lon_mouseY;$Lon_parameters)
C_OBJECT:C1216($Obj_dialog)

If (False:C215)
	C_LONGINT:C283(Editor_SET_CLICK ;$1)
	C_LONGINT:C283(Editor_SET_CLICK ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Lon_mouseX:=$1
		$Lon_mouseY:=$2
		
	End if 
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
OB SET:C1220($Obj_dialog;\
"clic-x";$Lon_mouseX;\
"clic-y";$Lon_mouseY)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End