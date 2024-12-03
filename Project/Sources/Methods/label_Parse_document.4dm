//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : label_Parse_document
// Database: 4D Labels
// ID[AE75712761854EB98589E07A393647EC]
// Created #10-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($File_path : Text; $Boo_withPrintSettings : Boolean) : Text

var $Blb_buffer : Blob
var $Boo_converted; $Boo_OK : Boolean
var $Lon_parameters : Integer
var $Lon_version : Integer
var $Dom_; $Dom_label; $Txt_onErrorMethod : Text

var $i : Integer
var $t : Text



// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	//$File_path:=$1  //path of the label document
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		//$Boo_withPrintSettings:=$2
		
	End if 
	
	If (Test path name:C476($File_path)#Is a document:K24:1)
		
		//load the default label
		$File_path:=Get 4D folder:C485(Current resources folder:K5:16)+"default.4lbp"
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
//SET ASSERT ENABLED(True)

If ($File_path="@.4lbp")
	
	$Dom_label:=DOM Parse XML source:C719($File_path)
	
	// #ACI0100054 {
	// Don't omit to update Resources/default.4lbp
	If (OK=1)
		
		xml_GET_ATTRIBUTE_BY_NAME($Dom_label; "version"; ->$Lon_version)
		
		If ($Lon_version<2)
			
			//fix ACI0100054
			ARRAY TEXT:C222($tDom_objects; 0x0000)
			$tDom_objects{0}:=DOM Find XML element:C864($Dom_label; "label/objects/object"; $tDom_objects)
			
			If (OK=1)
				
				
				For ($i; 1; Size of array:C274($tDom_objects); 1)
					
					DOM GET XML ATTRIBUTE BY NAME:C728($tDom_objects{$i}; "type"; $t)
					
					If ($t="round-rect")
						
						DOM SET XML ATTRIBUTE:C866($tDom_objects{$i}; \
							"rx"; Num:C11(<>label_params.defaultRoundRect); \
							"ry"; Num:C11(<>label_params.defaultRoundRect))
						
					End if 
				End for 
				
				$Lon_version:=2
				
			End if 
			
			DOM SET XML ATTRIBUTE:C866($Dom_label; "version"; $Lon_version)
			
		End if 
	End if   //}
	
Else 
	
	// Parse a binary label document (old format)
	DOCUMENT TO BLOB:C525($File_path; $Blb_buffer)
	
	$Dom_label:=parse_data(->$Blb_buffer; $Boo_withPrintSettings)
	
	$Boo_converted:=True:C214
	
End if 

// Store the converted status or not
OB SET:C1220((OBJECT Get pointer:C1124(Object named:K67:5; "object"))->; "converted"; $Boo_converted)

// Add missing elements if any
If (Asserted:C1132(xml_IsValidReference($Dom_label)))
	
	$Dom_:=DOM Find XML element:C864($Dom_label; "label/selects")
	
	If (OK=0)
		
		$Dom_:=DOM Create XML element:C865($Dom_label; "selects"; "id"; "selects")
		
	End if 
	
	$Dom_:=DOM Find XML element:C864($Dom_label; "label/objects")
	
	If (OK=0)
		
		$Dom_:=DOM Create XML element:C865($Dom_label; "objects"; "id"; "objects")
		
	End if 
	
End if 

// ----------------------------------------------------
// Return
return $Dom_label

// ----------------------------------------------------
// End