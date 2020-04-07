//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : mess_DISPLAY
  // Database: 4D Report
  // ID[93B6124780444178BBE7D302F9B13E72]
  // Created #5-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_OBJECT:C1216($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($Boo_hResizing;$Boo_vResizing)
C_LONGINT:C283($Lon_page;$Lon_parameters)
C_OBJECT:C1216($Obj_message)

If (False:C215)
	C_OBJECT:C1216(mess_DISPLAY ;$1)
	C_LONGINT:C283(mess_DISPLAY ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Obj_message:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Lon_page:=$2
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //adjust position
obj_CENTER ("alert.box";"alert.mask";Horizontally centered:K39:1)

OBJECT SET VISIBLE:C603(*;"alert.@";True:C214)

  //keep environment
FORM GET HORIZONTAL RESIZING:C1077($Boo_hResizing)
FORM GET VERTICAL RESIZING:C1078($Boo_vResizing)

OB SET:C1220($Obj_message;\
"page";FORM Get current page:C276;\
"h-resizing";$Boo_hResizing;\
"v-resizing";$Boo_vResizing)

If (OB Get:C1224($Obj_message;"not-resizable";Is boolean:K8:9))
	
	FORM SET HORIZONTAL RESIZING:C892(False:C215)
	FORM SET VERTICAL RESIZING:C893(False:C215)
	
End if 

  //assign object to the widget
obj_BOUND_WITH_OBJECT ($Obj_message;"alert.box")

If ($Lon_page#0)
	
	FORM GOTO PAGE:C247($Lon_page)
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End