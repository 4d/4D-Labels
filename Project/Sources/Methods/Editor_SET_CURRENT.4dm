//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SET_CURRENT
  // Database: 4D Labels
  // ID[D67B4C0C1782447AA13F2B94C24A1504]
  // Created #2-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_object)
C_TEXT:C284($Dom_object)

If (False:C215)
	C_TEXT:C284(Editor_SET_CURRENT ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Dom_object:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5;"object")
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
OB SET:C1220($Ptr_object->;\
"DomCurrent";$Dom_object)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End