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
C_TEXT:C284($1)
C_POINTER:C301($2)

C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_object;$Ptr_value)
C_TEXT:C284($Txt_name)

If (False:C215)
	C_TEXT:C284(obj_ASSIGNMENT ;$1)
	C_POINTER:C301(obj_ASSIGNMENT ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	$Txt_name:=$1  //object name
	
	$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5;$Txt_name)
	
	If ($Lon_parameters>=2)
		
		If (Asserted:C1132(Not:C34(Is nil pointer:C315($2));"Nil pointer !"))
			
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