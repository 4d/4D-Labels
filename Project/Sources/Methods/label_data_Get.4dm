//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : label_data_Get
  // Database: 4D Labels
  //  ID[C7D38EE16CEC4D9FBE9884F1B94BC6AC]
  // Created #15-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_dot;$Lon_parameters)
C_TEXT:C284($Dom_item;$Dom_label;$Txt_data;$Txt_element;$Txt_onErrorMethod;$Txt_value)

If (False:C215)
	C_TEXT:C284(label_data_Get ;$0)
	C_TEXT:C284(label_data_Get ;$1)
	C_TEXT:C284(label_data_Get ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_data:=$1  //attribute name
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Dom_label:=$2  //{XML Reference}
		
	Else 
		
		$Dom_label:=OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;"dom";Is text:K8:3)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Lon_dot:=Position:C15(".";$Txt_data)

$Txt_onErrorMethod:=4D_NO_ERROR ("ON")

If ($Lon_dot>0)
	
	$Txt_element:=Substring:C12($Txt_data;1;$Lon_dot-1)
	
	$Dom_item:=DOM Find XML element:C864($Dom_label;"label/"+$Txt_element)
	
	If (Asserted:C1132(OK=1;"Missing element: \""+$Txt_element+"\""))
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_item;Substring:C12($Txt_data;$Lon_dot+1);$Txt_value)
		
	End if 
	
Else 
	
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_label;$Txt_data;$Txt_value)
	
End if 

4D_NO_ERROR ("OFF";$Txt_onErrorMethod)

  // ----------------------------------------------------
  // Return
$0:=$Txt_value

  // ----------------------------------------------------
  // End