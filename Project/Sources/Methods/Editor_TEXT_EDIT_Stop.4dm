//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_TEXT_EDIT_Stop
// Database: 4D Labels
// ID[5BF00476DE3B47EAB0199D650DA16743]
// Created #17-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($Boo_update)
C_LONGINT:C283($Lon_i; $Lon_parameters)
C_POINTER:C301($Ptr_textEdit)
C_TEXT:C284($Dom_canvas; $Dom_label; $Dom_object; $Dom_text; $Txt_buffer; $Txt_ID)
C_TEXT:C284($Txt_old; $Txt_value)
C_OBJECT:C1216($Obj_dialog)

ARRAY TEXT:C222($tDom_selects; 0)

If (False:C215)
	C_BOOLEAN:C305(Editor_TEXT_EDIT_Stop; $0)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		// <NONE>
		
	End if 
	
	$Obj_dialog:=Editor_Get_grips(->$Dom_label; ->$Dom_canvas)
	
	$Dom_text:=OB Get:C1224($Obj_dialog; "DomTextEdit"; Is text:K8:3)
	$Txt_ID:=OB Get:C1224($Obj_dialog; "DomTextEditId"; Is text:K8:3)
	
	//get edited text
	$Ptr_textEdit:=OBJECT Get pointer:C1124(Object named:K67:5; "TextEdit")
	$Txt_value:=$Ptr_textEdit->
	$Ptr_textEdit->:=""
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Length:C16($Dom_text)#0)
	
	//clear values
	OB REMOVE:C1226($Obj_dialog; "DomTextEdit")
	OB REMOVE:C1226($Obj_dialog; "DomTextEditId")
	
	//reveal selection
	editor_SEL_REVEAL($Txt_ID)
	
	//hide the text-box
	OBJECT MOVE:C664(*; "TextEdit"; 0; 0; 0; 0; *)
	OBJECT SET VISIBLE:C603(*; "TextEdit"; False:C215)
	
	If (OBJECT Get name:C1087(Object with focus:K67:3)="TextEdit")
		
		$Dom_object:=DOM Find XML element by ID:C1010($Dom_label; $Txt_ID)
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "value"; $Txt_old)
		
		Case of 
				
				//________________________________________
			: (Length:C16($Txt_value)=0)  //remove the object
				
				DOM REMOVE XML ELEMENT:C869(DOM Find XML element by ID:C1010($Dom_canvas; OB Get:C1224(<>label_params; "classPrefix"; Is text:K8:3)+$Txt_ID+"-textArea"))
				
				DOM REMOVE XML ELEMENT:C869(DOM Find XML element by ID:C1010($Dom_canvas; OB Get:C1224(<>label_params; "classPrefix"; Is text:K8:3)+$Txt_ID+"-rect"))
				
				//remove select from canvas
				DOM REMOVE XML ELEMENT:C869(DOM Find XML element by ID:C1010($Dom_canvas; OB Get:C1224(<>label_params; "select-prefix"; Is text:K8:3)+$Txt_ID))
				
				//remove object from canvas
				DOM REMOVE XML ELEMENT:C869($Dom_text)
				
				//remove object from container
				DOM REMOVE XML ELEMENT:C869(DOM Find XML element by ID:C1010($Dom_label; $Txt_ID))
				
				//remove object from container/selects
				For ($Lon_i; 1; Editor_SEL_Get_count($Dom_label; ->$tDom_selects); 1)
					
					DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selects{$Lon_i}; "object-id"; $Txt_buffer)
					
					If ($Txt_ID=$Txt_buffer)
						
						DOM REMOVE XML ELEMENT:C869($tDom_selects{$Lon_i})
						$Lon_i:=MAXLONG:K35:2-1
						
					End if 
				End for 
				
				Editor_SELECT_UPDATE_ID($Dom_label; $Dom_canvas)  //#TO_BE_DONE
				
				$Boo_update:=True:C214
				
				//________________________________________
			: (Length:C16($Txt_value)=Length:C16($Txt_old))\
				 & (Position:C15($Txt_old; $Txt_value; *)=1)  //the value is unchanged
				
				//NOTHING MORE TO DO
				
				//________________________________________
			Else 
				
				DOM SET XML ATTRIBUTE:C866($Dom_object; \
					"value"; $Txt_value)
				
				Editor_TEXT_EDIT_SET_VALUE(DOM Find XML element by ID:C1010($Dom_canvas; $Txt_ID+"-textArea"); $Txt_value)
				
				$Boo_update:=True:C214
				
				//________________________________________
		End case 
	End if 
	
	//enable shortcuts
	OBJECT SET VISIBLE:C603(*; "shortcut.@"; True:C214)
	
Else 
	
	//NOTHING MORE TO DO
	
End if 

// ----------------------------------------------------
// Return
return $Boo_update

// ----------------------------------------------------
// End