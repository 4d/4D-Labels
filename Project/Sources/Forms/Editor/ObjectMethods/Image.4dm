  // ----------------------------------------------------
  // Object method : Editor.Image - (4D Labels)
  // ID[F74BE601AD7942C38F04DC1867ED08E5]
  // Created #22-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)

C_BOOLEAN:C305($Boo_label;$Boo_OK)
C_LONGINT:C283($Lon_accept;$Lon_formEvent)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Dom_canvas;$Dom_label;$File_path;$Txt_me)
C_OBJECT:C1216($Obj_parameters)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Double Clicked:K2:5)
		
		Editor_ON_DOUBLE_CLICKED 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		Editor_ON_CLICKED 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Drag Over:K2:13)
		
		$Obj_parameters:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
		$Dom_canvas:=OB Get:C1224($Obj_parameters;"canvas";Is text:K8:3)
		
		ARRAY TEXT:C222($tTxt_dataTypes;0x0000)
		ARRAY TEXT:C222($tTxt_signatures;0x0000)
		GET PASTEBOARD DATA TYPE:C958($tTxt_signatures;$tTxt_dataTypes)
		
		$Lon_accept:=-1
		
		If (Length:C16($Dom_canvas)#0)
			
			  //test for a field (private pasteboard from fields' list)
			If (Pasteboard data size:C400("com.4d.array.table")>0)\
				 & (Pasteboard data size:C400("com.4d.array.field")>0)\
				 & (Pasteboard data size:C400("com.4d.array.field.type")>0)
				
				ASSERT:C1129(DEBUG_Update ("clic";MOUSEX;MOUSEY))
				
				$Lon_accept:=0
				
			Else 
				
				  //if not, test if this is a picture or a label's file
				$File_path:=Get file from pasteboard:C976(1)
				
				If (Length:C16($File_path)#0)
					
					If (Is picture file:C1113($File_path))\
						 | ($File_path="@.4lb")\
						 | ($File_path="@.4lbp")
						
						$Lon_accept:=0
						
					End if 
				End if 
			End if 
		End if 
		
		  // ----------------------------------------------------
		  // Return
		$0:=$Lon_accept
		
		  // ----------------------------------------------------
		
		  //______________________________________________________
	: ($Lon_formEvent=On Drop:K2:12)
		
		If (Not:C34(Is nil pointer:C315(OBJECT Get pointer:C1124(Object subform container:K67:4))))
			
			$Dom_label:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
			
			If (Length:C16($Dom_label)#0)
				
				$Boo_OK:=Editor_Field_drop ($Dom_label)  //from list of fields
				
				If (Not:C34($Boo_OK))
					
					$Boo_OK:=Editor_Image_drop ($Dom_label)  //image files
					
					If (Not:C34($Boo_OK))
						
						$Boo_label:=Editor_Definition_drop   //label description
						
					End if 
				End if 
				
				If ($Boo_label | $Boo_OK)
					
					Editor_SET_TOOL   //restore select tool
					
					If ($Boo_label)
						
						  //close text edit if any
						Editor_TEXT_EDIT_Stop 
						
						CALL SUBFORM CONTAINER:C1086(-113)
						
					Else 
						
						CALL SUBFORM CONTAINER:C1086(-103)
						
						OB SET:C1220($Obj_parameters;\
							"PasteX";OB Get:C1224($Obj_parameters;"step-X";Is longint:K8:6);\
							"PasteY";OB Get:C1224($Obj_parameters;"step-Y";Is longint:K8:6);\
							"PasteZ";1)
						
					End if 
					
					GOTO OBJECT:C206(*;"editor")
					
				End if 
			End if 
		End if 
		
		  //______________________________________________________
	Else 
		
		  //ASSERT(False;"Form event activated unnecessary ("+String($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 