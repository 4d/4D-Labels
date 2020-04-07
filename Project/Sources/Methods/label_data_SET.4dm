//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : label_data_SET
  // Database: 4D Labels
  // ID[0DCEA14EB134433AA93B33A389CA536A]
  // Created #15-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283($Lon_dot;$Lon_parameters)
C_TEXT:C284($Dom_item;$Dom_label;$Dom_size;$Txt_data;$Txt_element;$Txt_decimalSeparator)
C_TEXT:C284($Txt_unit;$Txt_value)

If (False:C215)
	C_TEXT:C284(label_data_SET ;$1)
	C_TEXT:C284(label_data_SET ;$2)
	C_TEXT:C284(label_data_SET ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Txt_data:=$1
	$Txt_value:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		$Dom_label:=$3
		
	Else 
		
		$Dom_label:=OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;"dom";Is text:K8:3)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Lon_dot:=Position:C15(".";$Txt_data)

If ($Lon_dot>0)
	
	$Txt_element:=Substring:C12($Txt_data;1;$Lon_dot-1)
	
	$Dom_item:=DOM Find XML element:C864($Dom_label;"label/"+$Txt_element)
	
	If (Asserted:C1132(OK=1;"Missing element: \""+$Txt_element+"\""))
		
		If ($Txt_data="@.width")\
			 | ($Txt_data="@.height")\
			 | ($Txt_data="@.top")\
			 | ($Txt_data="@.left")\
			 | ($Txt_data="@.right")\
			 | ($Txt_data="@.bottom")\
			 | ($Txt_data="@.horizontal")\
			 | (($Txt_data="@.vertical") & ($Txt_data#"setting.@"))
			
			  //these values must be converted into points
			
			$Dom_size:=DOM Find XML element:C864($Dom_label;"label/size")
			xml_GET_ATTRIBUTE_BY_NAME ($Dom_size;"unit";->$Txt_unit)
			$Txt_unit:=Choose:C955(Length:C16($Txt_unit)=0;"pt";$Txt_unit)
			
			If (Position:C15(".";$Txt_value)>0)
				
				GET SYSTEM FORMAT:C994(Decimal separator:K60:1;$Txt_decimalSeparator)
				$Txt_value:=Replace string:C233($Txt_value;".";$Txt_decimalSeparator)
				
			End if 
			
			DOM SET XML ATTRIBUTE:C866($Dom_item;\
				Substring:C12($Txt_data;$Lon_dot+1);\
				math_Length_conversion (Num:C11($Txt_value);$Txt_unit;"pt"))
			
		Else 
			
			DOM SET XML ATTRIBUTE:C866($Dom_item;\
				Substring:C12($Txt_data;$Lon_dot+1);$Txt_value)
			
		End if 
	End if 
	
Else 
	
	DOM SET XML ATTRIBUTE:C866($Dom_label;\
		$Txt_data;$Txt_value)
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End