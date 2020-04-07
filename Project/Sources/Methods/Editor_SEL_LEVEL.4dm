//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_MOVE_BACK
  // Database: 4D Labels
  // ID[32DAA7BB447E452CAE525D100B080BF3]
  // Created #18-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_BOOLEAN:C305($Boo_redraw)
C_LONGINT:C283($Lon_i;$Lon_level;$Lon_objectCount;$Lon_parameters)
C_TEXT:C284($Dom_canvas;$Dom_label;$kTxt_selectPrefix;$Txt_action;$Txt_ID)

ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_TEXT:C284(Editor_SEL_LEVEL ;$1)
	C_TEXT:C284(Editor_SEL_LEVEL ;$2)
	C_TEXT:C284(Editor_SEL_LEVEL ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_action:=$1  // back | down | front | up
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Dom_label:=$2
		
		If ($Lon_parameters>=3)
			
			$Dom_canvas:=$3
			
		End if 
	End if 
	
	Editor_Get_grips (->$Dom_label;->$Dom_canvas)
	
	$kTxt_selectPrefix:=OB Get:C1224(<>label_params;"select-prefix";Is text:K8:3)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Txt_action="back")
		
		For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected);1)
			
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
			
			If (Editor_OB_Get_level ($Txt_ID)#1)
				
				  //Container
				DOM_ELEMENT_MOVE (DOM Find XML element by ID:C1010($Dom_label;$Txt_ID);1)
				DOM_ELEMENT_MOVE ($tDom_selected{$Lon_i};1)
				
				  //Canvas
				DOM_ELEMENT_MOVE (DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID);3)
				DOM_ELEMENT_MOVE (DOM Find XML element by ID:C1010($Dom_canvas;$kTxt_selectPrefix+$Txt_ID))
				
				$Boo_redraw:=True:C214
				
			End if 
		End for 
		
		  //______________________________________________________
	: ($Txt_action="down")
		
		For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected);1)
			
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
			
			$Lon_level:=Editor_OB_Get_level ($Txt_ID)
			
			If ($Lon_level#1)
				
				  //Container
				DOM_ELEMENT_MOVE (DOM Find XML element by ID:C1010($Dom_label;$Txt_ID);$Lon_level-1)
				DOM_ELEMENT_MOVE ($tDom_selected{$Lon_i};$Lon_level-1)
				
				  //Canvas
				DOM_ELEMENT_MOVE (DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID);$Lon_level+1)
				DOM_ELEMENT_MOVE (DOM Find XML element by ID:C1010($Dom_canvas;$kTxt_selectPrefix+$Txt_ID))
				
				$Boo_redraw:=True:C214
				
			End if 
		End for 
		
		  //______________________________________________________
	: ($Txt_action="front")
		
		$Lon_objectCount:=Editor_Get_objectCount ($Dom_label)
		
		For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected);1)
			
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
			
			If (Editor_OB_Get_level ($Txt_ID)#$Lon_objectCount)
				
				  //Container
				DOM_ELEMENT_MOVE (DOM Find XML element by ID:C1010($Dom_label;$Txt_ID))
				DOM_ELEMENT_MOVE ($tDom_selected{$Lon_i})
				
				  //Canvas
				DOM_ELEMENT_MOVE (DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID))
				DOM_ELEMENT_MOVE (DOM Find XML element by ID:C1010($Dom_canvas;$kTxt_selectPrefix+$Txt_ID))
				
				$Boo_redraw:=True:C214
				
			End if 
		End for 
		
		  //______________________________________________________
	: ($Txt_action="up")
		
		$Lon_objectCount:=Editor_Get_objectCount ($Dom_label)
		
		For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected);1)
			
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
			
			$Lon_level:=Editor_OB_Get_level ($Txt_ID)
			
			If ($Lon_level<$Lon_objectCount)
				
				If ($Lon_level<($Lon_objectCount-1))
					
					  //Container
					DOM_ELEMENT_MOVE (DOM Find XML element by ID:C1010($Dom_label;$Txt_ID);$Lon_level+2)
					DOM_ELEMENT_MOVE ($tDom_selected{$Lon_i};$Lon_level+2)
					
					  //Canvas
					DOM_ELEMENT_MOVE (DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID);$Lon_level+4)
					DOM_ELEMENT_MOVE (DOM Find XML element by ID:C1010($Dom_canvas;$kTxt_selectPrefix+$Txt_ID))
					
				Else 
					
					  //Container
					DOM_ELEMENT_MOVE (DOM Find XML element by ID:C1010($Dom_label;$Txt_ID))
					DOM_ELEMENT_MOVE ($tDom_selected{$Lon_i})
					
					  //Canvas
					DOM_ELEMENT_MOVE (DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID))
					DOM_ELEMENT_MOVE (DOM Find XML element by ID:C1010($Dom_canvas;$kTxt_selectPrefix+$Txt_ID))
					
				End if 
				
				$Boo_redraw:=True:C214
				
			End if 
		End for 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_action+"\"")
		
		  //______________________________________________________
End case 

If ($Boo_redraw)
	
	Editor_SELECT_UPDATE_ID ($Dom_label;$Dom_canvas)
	Editor_UPDATE 
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End