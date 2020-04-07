//%attributes = {"invisible":true}
C_BOOLEAN:C305(<>Boo_debug)
C_BOOLEAN:C305(<>inited)

C_OBJECT:C1216(<>label_params)

  //#ACI0098408 {
  //
  //#TURN_AROUND_ACI0098451
  //
  //%W-518.7
  //#ACI0097380 [
  // If (Undefined(<>database))
  //  // Dev only
  // ARRAY TEXT(<>database;0;0)
  // End if
  //%W+518.7

C_BOOLEAN:C305(<>database_inited)

  // If (Size of array(<>structure)=0)
If (Not:C34(<>database_inited))
	
	<>database_inited:=True:C214
	  //}
	
	C_LONGINT:C283($Lon_tableNumber;$Lon_tableIndex;$Lon_fieldNumber;$Lon_fieldIndex)
	
	$Lon_tableNumber:=Get last table number:C254
	ARRAY TEXT:C222(<>database;$Lon_tableNumber;0)
	ARRAY TEXT:C222(<>database{0};$Lon_tableNumber)
	
	For ($Lon_tableIndex;1;$Lon_tableNumber;1)
		
		If (Is table number valid:C999($Lon_tableIndex))
			
			<>database{0}{$Lon_tableIndex}:=Table name:C256($Lon_tableIndex)
			
			$Lon_fieldNumber:=Get last field number:C255($Lon_tableIndex)
			ARRAY TEXT:C222(<>database{$Lon_tableIndex};$Lon_fieldNumber)
			
			For ($Lon_fieldIndex;1;$Lon_fieldNumber;1)
				
				If (Is field number valid:C1000($Lon_tableIndex;$Lon_fieldIndex))
					
					<>database{$Lon_tableIndex}{$Lon_fieldIndex}:=Field name:C257($Lon_tableIndex;$Lon_fieldIndex)
					
				End if 
			End for 
		End if 
	End for 
End if 
  //]

If (False:C215)
	
	  //_________________________________________
	C_LONGINT:C283(C_OPEN_EDITOR ;$1)
	C_BOOLEAN:C305(C_OPEN_EDITOR ;$2)
	C_TEXT:C284(C_OPEN_EDITOR ;$3)
	
	  //_________________________________________
	C_LONGINT:C283(C_Print_label ;$0)
	C_LONGINT:C283(C_Print_label ;$1)
	C_TEXT:C284(C_Print_label ;$2)
	C_TEXT:C284(C_Print_label ;$3)
	
	  //_________________________________________
End if 