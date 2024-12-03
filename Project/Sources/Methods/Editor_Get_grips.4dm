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

#DECLARE($Ptr_label : Pointer; $Ptr_canvas : Pointer) : Object

var $count_parameters : Integer
var $Ptr_parameters : Pointer

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	
	//Optional parameters
	If ($count_parameters>=2)
		
		
	End if 
	
	$Ptr_parameters:=OBJECT Get pointer:C1124(Object named:K67:5; "object")
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Length:C16($Ptr_label->)=0)
	
	$Ptr_label->:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
	
End if 

If ($count_parameters>=2)
	
	If (Length:C16($Ptr_canvas->)=0)
		
		$Ptr_canvas->:=OB Get:C1224($Ptr_parameters->; "canvas"; Is text:K8:3)
		
	End if 
	
End if 

// ----------------------------------------------------
// Return
return $Ptr_parameters->  //local parameters' object

// ----------------------------------------------------
// End