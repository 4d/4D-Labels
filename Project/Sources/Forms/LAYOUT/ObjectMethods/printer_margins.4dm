  // ----------------------------------------------------
  // Object method : LAYOUT.printer_margins - (4D Labels)
  // ID[B3FF5469D2654388816E6B5B580F8610]
  // Created #25-9-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent;$Lon_round)
C_POINTER:C301($Ptr_me)
C_REAL:C285($Num_marginBottom;$Num_marginLeft;$Num_marginRight;$Num_marginTop)
C_TEXT:C284($Txt_me;$Txt_unit)
C_OBJECT:C1216($Obj_param)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Mouse Enter:K2:33)
		
		OBJECT SET FONT STYLE:C166(*;$Txt_me;Underline:K14:4)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Mouse Leave:K2:34)
		
		OBJECT SET FONT STYLE:C166(*;$Txt_me;Plain:K14:1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Obj_param:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
		
		  //values, in pixels, of the different margins of the current printer
		GET PRINTABLE MARGIN:C711($Num_marginLeft;$Num_marginTop;$Num_marginRight;$Num_marginBottom)
		
		$Txt_unit:=OB Get:C1224($Obj_param;"size.unit";Is text:K8:3)
		
		If ($Txt_unit#"pt")
			
			  //convert to user unit
			$Lon_round:=Choose:C955($Txt_unit="mm";1;2)
			
			$Num_marginLeft:=math_Length_conversion ($Num_marginLeft;"pt";$Txt_unit;$Lon_round)
			$Num_marginTop:=math_Length_conversion ($Num_marginTop;"pt";$Txt_unit;$Lon_round)
			$Num_marginRight:=math_Length_conversion ($Num_marginRight;"pt";$Txt_unit;$Lon_round)
			$Num_marginBottom:=math_Length_conversion ($Num_marginBottom;"pt";$Txt_unit;$Lon_round)
			
		End if 
		
		  //update UI
		(OBJECT Get pointer:C1124(Object named:K67:5;"size.left.box"))->:=$Num_marginLeft
		(OBJECT Get pointer:C1124(Object named:K67:5;"size.top.box"))->:=$Num_marginTop
		(OBJECT Get pointer:C1124(Object named:K67:5;"size.right.box"))->:=$Num_marginRight
		(OBJECT Get pointer:C1124(Object named:K67:5;"size.bottom.box"))->:=$Num_marginBottom
		
		If ((OBJECT Get pointer:C1124(Object named:K67:5;"automatic_resizing"))->=0)
			
			  //store calculated values
			OB SET:C1220($Obj_param;\
				"margin.left";$Num_marginLeft;\
				"margin.top";$Num_marginTop;\
				"margin.right";$Num_marginRight;\
				"margin.bottom";$Num_marginBottom)
			
			CALL SUBFORM CONTAINER:C1086(-3)
			
		Else 
			
			layout_AUTOMATIC_RESIZING 
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 