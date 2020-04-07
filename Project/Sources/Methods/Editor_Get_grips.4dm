//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_Get_grips
  // Database: 4D Labels
  // ID[EEE8D563CDA846E980C151FCC9159F67]
  // Created #19-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_OBJECT:C1216($0)
C_POINTER:C301($1)
C_POINTER:C301($2)

C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_canvas;$Ptr_label;$Ptr_parameters)

If (False:C215)
	C_OBJECT:C1216(Editor_Get_grips ;$0)
	C_POINTER:C301(Editor_Get_grips ;$1)
	C_POINTER:C301(Editor_Get_grips ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Ptr_label:=$1  //DOM
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Ptr_canvas:=$2  //DOM
		
	End if 
	
	$Ptr_parameters:=OBJECT Get pointer:C1124(Object named:K67:5;"object")
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Length:C16($Ptr_label->)=0)
	
	$Ptr_label->:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
	
End if 

If ($Lon_parameters>=2)
	
	If (Length:C16($Ptr_canvas->)=0)
		
		$Ptr_canvas->:=OB Get:C1224($Ptr_parameters->;"canvas";Is text:K8:3)
		
	End if 
End if 

  // ----------------------------------------------------
  // Return
$0:=$Ptr_parameters->  //local parameters' object

  // ----------------------------------------------------
  // End