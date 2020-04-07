//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SELECT_DELETE
  // Database: 4D Labels
  // ID[29B9BC78CB4C4FE1A5E989CA5359CE3E]
  // Created #20-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_count;$Lon_i;$Lon_parameters)
C_POINTER:C301($Ptr_container)
C_TEXT:C284($Dom_canvas;$Dom_label;$Txt_ID;$Txt_type)
C_OBJECT:C1216($Obj_parameters)

ARRAY TEXT:C222($tDom_selected;0)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
	$Ptr_container:=OBJECT Get pointer:C1124(Object subform container:K67:4)
	
	$Obj_parameters:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	$Dom_canvas:=OB Get:C1224($Obj_parameters;"canvas";Is text:K8:3)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Not:C34(Is nil pointer:C315($Ptr_container)))
	
	$Dom_label:=$Ptr_container->
	
	If (Length:C16($Dom_label)#0)
		
		  //DEBUG_EXPORT ("canvas";$Dom_canvas;"canvas_before.svg")
		
		$Lon_count:=Editor_SEL_Get_count ($Dom_label;->$tDom_selected)
		
		If ($Lon_count>0)
			
			For ($Lon_i;1;$Lon_count;1)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
				
				  //remove select from canvas
				DOM REMOVE XML ELEMENT:C869(DOM Find XML element by ID:C1010($Dom_canvas;OB Get:C1224(<>label_params;"select-prefix";Is text:K8:3)+$Txt_ID))
				
				  //remove class from canvas
				DOM GET XML ATTRIBUTE BY NAME:C728(DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID);"editor:object-type";$Txt_type)
				
				Case of 
						
						  //________________________________________
					: ($Txt_type="ellipse")\
						 | ($Txt_type="line")\
						 | ($Txt_type="rect")\
						 | ($Txt_type="polyline")
						
						DOM REMOVE XML ELEMENT:C869(DOM Find XML element by ID:C1010($Dom_canvas;OB Get:C1224(<>label_params;"classPrefix";Is text:K8:3)+$Txt_ID))
						
						  //________________________________________
					: ($Txt_type="image")
						
						DOM REMOVE XML ELEMENT:C869(DOM Find XML element by ID:C1010($Dom_canvas;OB Get:C1224(<>label_params;"classPrefix";Is text:K8:3)+$Txt_ID+"-rect"))
						
						  //________________________________________
					: ($Txt_type="text")\
						 | ($Txt_type="variable/text")\
						 | ($Txt_type="variable/image")
						
						DOM REMOVE XML ELEMENT:C869(DOM Find XML element by ID:C1010($Dom_canvas;OB Get:C1224(<>label_params;"classPrefix";Is text:K8:3)+$Txt_ID+"-textArea"))
						DOM REMOVE XML ELEMENT:C869(DOM Find XML element by ID:C1010($Dom_canvas;OB Get:C1224(<>label_params;"classPrefix";Is text:K8:3)+$Txt_ID+"-rect"))
						
						  //________________________________________
				End case 
				
				  //remove object from canvas
				DOM REMOVE XML ELEMENT:C869(DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID))
				
				  //remove object from container
				DOM REMOVE XML ELEMENT:C869(DOM Find XML element by ID:C1010($Dom_label;$Txt_ID))
				
				  //remove object from container/selects
				DOM REMOVE XML ELEMENT:C869($tDom_selected{$Lon_i})
				
			End for 
			
			Editor_SELECT_UPDATE_ID ($Dom_label;$Dom_canvas)
			
			  //DEBUG_EXPORT ("canvas";$Dom_canvas;"canvas_after.svg")
			
			Editor_ON_DATA_CHANGE 
			
			Editor_UPDATE_UI 
			
			Editor_REDRAW 
			
			CALL SUBFORM CONTAINER:C1086(-103)
			
		End if 
	End if 
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End