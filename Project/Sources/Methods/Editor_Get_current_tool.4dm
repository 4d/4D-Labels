//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_Get_current_tool
  // Database: 4D Labels
  // ID[16AC92A693BB4EE2A71482D324DCF4E9]
  // Created #6-1-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)

C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_object)
C_TEXT:C284($Txt_tool)

If (False:C215)
	C_TEXT:C284(Editor_Get_current_tool ;$0)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
	$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5;"object")
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Asserted:C1132(Not:C34(Is nil pointer:C315($Ptr_object))))
	
	$Txt_tool:=OB Get:C1224($Ptr_object->;"tool";Is text:K8:3)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Txt_tool

  // ----------------------------------------------------
  // End