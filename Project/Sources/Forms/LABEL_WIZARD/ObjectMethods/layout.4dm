// ----------------------------------------------------
// Object method : LABEL_WIZARD.layout - (4D Labels)
// ID[F793450F11EB40209BD16F3A5BDE2F86]
// Created #7-7-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_buffer; $Txt_me; $Txt_target; $Dom_label; $Dom_form; $Txt_formName)
C_OBJECT:C1216($Obj_buffer; $Obj_param)
C_POINTER:C301($Ptr_table)
// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent<0)  //call from subform
		
		$Obj_buffer:=$Ptr_me->
		
		Case of 
				
				//-----------------------------------------
			: ($Lon_formEvent=-1)
				
				$Txt_target:=OB Get:C1224($Obj_buffer; "target"; Is text:K8:3)
				OB REMOVE:C1226($Obj_buffer; "target")
				
				$Txt_buffer:=OB Get:C1224($Obj_buffer; $Txt_target; Is text:K8:3)
				wizard_SET_DATA($Txt_target; $Txt_buffer)
				
				//ACI0099603
				//  //ACI0099600
				//$Obj_param:=(OBJECT Get pointer(Object named;"object"))->
				//$Dom_label:=OB Get($Obj_param;"dom";Is text)
				//$Dom_form:=DOM Find XML element by ID($Dom_label;"form")
				//C_TEXT($Txt_formName)
				//DOM GET XML ATTRIBUTE BY NAME($Dom_form;"name";$Txt_formName)
				//If (Length($Txt_formName)#0)
				//If ($Txt_formName#"no-form")
				//If (label_data_Get ("setting.auto-width")="false")
				//$Ptr_table:=Table(C_MASTER_TABLE)
				//C_PICTURE($Pic_buffer)
				//FORM SCREENSHOT($Ptr_table->;$Txt_formName;$Pic_buffer)
				//C_LONGINT($Lon_width;$Lon_height)
				//PICTURE PROPERTIES($Pic_buffer;$Lon_width;$Lon_height)
				//CLEAR VARIABLE($Pic_buffer)
				//wizard_SET_DATA (\
										"size.width";String($Lon_width);\
										"size.height";String($Lon_height))
				//End if 
				//End if 
				//End if 
				
				$Obj_param:=(OBJECT Get pointer:C1124(Object named:K67:5; "object"))->
				$Dom_label:=OB Get:C1224($Obj_param; "dom"; Is text:K8:3)
				$Dom_form:=DOM Find XML element by ID:C1010($Dom_label; "form")
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_form; "name"; $Txt_formName)
				If (Length:C16($Txt_formName)#0)
					If ($Txt_formName#"no-form")
						If (label_data_Get("setting.auto-width")="false")
							$Ptr_table:=Table:C252(C_MASTER_TABLE)
							C_PICTURE:C286($Pic_buffer)
							FORM SCREENSHOT:C940($Ptr_table->; $Txt_formName; $Pic_buffer)
							C_REAL:C285($Num_width; $Num_height)
							PICTURE PROPERTIES:C457($Pic_buffer; $Num_width; $Num_height)
							CLEAR VARIABLE:C89($Pic_buffer)
							C_TEXT:C284($Txt_unit)
							$Txt_unit:=label_data_Get("size.unit")
							If ($Txt_unit#"pt")
								$Num_width:=math_Length_conversion($Num_width; "pt"; $Txt_unit; 2)
								$Num_height:=math_Length_conversion($Num_height; "pt"; $Txt_unit; 2)
							End if 
							wizard_SET_DATA(\
								"size.width"; String:C10($Num_width; "&xml"); \
								"size.height"; String:C10($Num_height; "&xml"))
						End if 
					End if 
				End if 
				
				//-----------------------------------------
			: ($Lon_formEvent=-2)  //automatic resizing
				
				//#ACI0097966 [
				//wizard_SET_DATA ("rows";OB Get($Obj_buffer;"rows";Is text);\
										//"columns";OB Get($Obj_buffer;"columns";Is text);\
										//"size.height";OB Get($Obj_buffer;"size.height";Is text);\
										//"size.width";OB Get($Obj_buffer;"size.width";Is text);\
										//"gap.horizontal";OB Get($Obj_buffer;"gap.horizontal";Is text);\
										//"gap.vertical";OB Get($Obj_buffer;"gap.vertical";Is text);\
										//"margin.left";OB Get($Obj_buffer;"margin.left";Is text);\
										//"margin.top";OB Get($Obj_buffer;"margin.top";Is text);\
										//"margin.right";OB Get($Obj_buffer;"margin.right";Is text);\
										//"margin.bottom";OB Get($Obj_buffer;"margin.bottom";Is text);\
										//"setting.auto-width";"true")
				//
				wizard_SET_DATA("rows"; OB Get:C1224($Obj_buffer; "rows"; Is text:K8:3); \
					"columns"; OB Get:C1224($Obj_buffer; "columns"; Is text:K8:3); \
					"size.height"; OB Get:C1224($Obj_buffer; "size.height"; Is text:K8:3); \
					"size.width"; OB Get:C1224($Obj_buffer; "size.width"; Is text:K8:3); \
					"gap.horizontal"; OB Get:C1224($Obj_buffer; "gap.horizontal"; Is text:K8:3); \
					"gap.vertical"; OB Get:C1224($Obj_buffer; "gap.vertical"; Is text:K8:3); \
					"margin.left"; OB Get:C1224($Obj_buffer; "margin.left"; Is text:K8:3); \
					"margin.top"; OB Get:C1224($Obj_buffer; "margin.top"; Is text:K8:3); \
					"margin.right"; OB Get:C1224($Obj_buffer; "margin.right"; Is text:K8:3); \
					"margin.bottom"; OB Get:C1224($Obj_buffer; "margin.bottom"; Is text:K8:3); \
					"setting.auto-width"; "true"; \
					"setting.landscape"; OB Get:C1224($Obj_buffer; "setting.landscape"; Is text:K8:3))
				//]
				
				//-----------------------------------------
			: ($Lon_formEvent=-3)  //Use printer margins
				
				wizard_SET_DATA("margin.left"; OB Get:C1224($Obj_buffer; "margin.left"; Is text:K8:3); \
					"margin.top"; OB Get:C1224($Obj_buffer; "margin.top"; Is text:K8:3); \
					"margin.right"; OB Get:C1224($Obj_buffer; "margin.right"; Is text:K8:3); \
					"margin.bottom"; OB Get:C1224($Obj_buffer; "margin.bottom"; Is text:K8:3))
				
				//-----------------------------------------
			Else 
				
				ASSERT:C1129(False:C215; "Unknown entry point: \""+String:C10($Lon_formEvent)+"\"")
				
				//-----------------------------------------
		End case 
		
		//______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		//init
		$Ptr_me->:=JSON Parse:C1218("{}")
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 