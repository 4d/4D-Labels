//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : object_ASSIGNMENT
// ID[A06314A54F4D42C49615BF1917B7CDA4]
// Created 11/10/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Text
var $2 : Pointer

var $Lon_parameters : Integer
var $Ptr_object; $Ptr_value : Pointer
var $Txt_name : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Txt_name:=$1  //object name
	
	$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5; $Txt_name)
	
	If ($Lon_parameters>=2)
		
		If (Asserted:C1132(Not:C34(Is nil pointer:C315($2)); "Nil pointer !"))
			
			$Ptr_value:=$2  //{clear variable if ommited}
			
		Else 
			
			ABORT:C156
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Asserted:C1132(Not:C34(Is nil pointer:C315($Ptr_object))))
	
	If ($Lon_parameters>=2)
		
		$Ptr_object->:=$Ptr_value->
		
	Else 
		
		CLEAR VARIABLE:C89($Ptr_object->)
		
	End if 
End if 

// ----------------------------------------------------
// End