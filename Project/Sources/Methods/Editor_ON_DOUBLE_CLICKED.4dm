//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_ON_DOUBLE_CLICKED
// Database: 4D Labels
// ID[E83C890A5C03403BAB7C8EB98F517908]
// Created #9-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE()

var $mouseX; $mouseY; $count_parameters : Integer
var $Ptr_object : Pointer
var $Dom_canvas; $Dom_form; $Dom_label; $Dom_object; $Txt_clicked; $Txt_formName : Text
var $Txt_ID; $Txt_objectType; $Txt_tool : Text


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5; "object")  //dialog items
	
	//Optional parameters
	If ($count_parameters>=1)
		
		// <NONE>
		
	End if 
	
	$mouseX:=MOUSEX
	$mouseY:=MOUSEY
	
	Editor_Get_grips(->$Dom_label; ->$Dom_canvas)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Dom_form:=DOM Find XML element by ID:C1010($Dom_label; "form")
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_form; "name"; $Txt_formName)

If (Length:C16($Txt_formName)=0)
	
	//because the image does not take focus from the text edit
	Editor_TEXT_EDIT_Stop
	
	If (Length:C16($Dom_canvas)#0)
		
		If ($mouseX#-1)\
			 & ($mouseY#-1)
			
			SET TIMER:C645(0)  //stop timer if any
			
			Editor_SET_CLICK($mouseX; $mouseY)
			
			ASSERT:C1129(DEBUG_Update("clic"; $mouseX; $mouseY))
			
			$Txt_clicked:=SVG Find element ID by coordinates:C1054(*; "Image"; $mouseX; $mouseY)
			
			$Txt_tool:=Editor_Get_current_tool
			
			Case of 
					
					//______________________________________________________
				: ($Txt_tool="select")
					
					Case of 
							
							//---------------------------------------------
						: (Length:C16($Txt_clicked)=0)\
							 | ($Txt_clicked="label")  //background image
							
							//NOTHING MORE TO DO
							
							//---------------------------------------------
						: ($Txt_clicked=(OB Get:C1224(<>label_params; "select-rect-prefix"; Is text:K8:3)+"@"))
							
							$Txt_ID:=Replace string:C233($Txt_clicked; OB Get:C1224(<>label_params; "select-rect-prefix"; Is text:K8:3); ""; *)
							$Dom_object:=DOM Find XML element by ID:C1010($Dom_canvas; $Txt_ID)
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "editor:object-type"; $Txt_objectType)
							
							Case of 
									
									//………………………………………………………………………………………
								: ($Txt_objectType="text") | ($Txt_objectType="variable/text")
									
									
									Editor_TEXT_EDIT_START($Dom_canvas; $Txt_ID)
									
									//: ($Txt_objectType="variable/text")
									
									//If (Editor_EDIT_FORMULA($Txt_ID))
									
									//Editor_ON_DATA_CHANGE
									
									//Editor_UPDATE_UI
									
									//End if 
									
									
									//………………………………………………………………………………………
								Else 
									
									//NOTHING MORE TO DO
									
									//………………………………………………………………………………………
							End case 
							
							//---------------------------------------------
					End case 
					
					//______________________________________________________
				Else 
					
					//NOTHING MORE TO DO
					
					//______________________________________________________
			End case 
		End if 
	End if 
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End