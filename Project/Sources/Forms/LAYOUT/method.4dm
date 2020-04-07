  // ----------------------------------------------------
  // Form method : LAYOUT - (4D Labels)
  // ID[9D2FAC95BFEE46EA9212B292EF8A7F68]
  // Created #7-7-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($Boo_buffer)
C_LONGINT:C283($Lon_formEvent;$Lon_i;$Lon_ref;$Lon_x)
C_POINTER:C301($Ptr_object)
C_REAL:C285($Num_marginBottom;$Num_marginLeft;$Num_marginRight;$Num_marginTop)
C_TEXT:C284($Txt_buffer;$Txt_object;$Txt_unit)
C_OBJECT:C1216($Obj_buffer;$Obj_param)

ARRAY TEXT:C222($tTxt_properties;0)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5;"object")

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		layout_INIT 
		
		If (Type:C295($Ptr_object->)=Is undefined:K8:13)
			
			OB SET:C1220($Obj_param;\
				"field-focus";"layout.rows")
			
			$Ptr_object->:=$Obj_param
			
		End if 
		
		obj_ALIGN_ON_BEST_SIZE (Align center:K42:3;"layout.printSetup")
		obj_ALIGN_ON_BEST_SIZE (Align center:K42:3;"printer_margins")
		obj_ALIGN_ON_BEST_SIZE (Align left:K42:2;"method.radio.record";"method.radio.label")
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Activate:K2:9)
		
		  //restore last focus
		$Txt_object:=OB Get:C1224($Ptr_object->;"field-focus";Is text:K8:3)
		GOTO OBJECT:C206(*;$Txt_object)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Losing Focus:K2:8)
		
		  //keep the current focus
		$Txt_object:=OBJECT Get name:C1087(Object with focus:K67:3)
		OB SET:C1220($Ptr_object->;\
			"field-focus";$Txt_object)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		  //clear lists
		CLEAR LIST:C377((OBJECT Get pointer:C1124(Object named:K67:5;"size.unit.menu"))->;*)
		CLEAR LIST:C377((OBJECT Get pointer:C1124(Object named:K67:5;"layout.order"))->;*)
		CLEAR LIST:C377((OBJECT Get pointer:C1124(Object named:K67:5;"method.list"))->;*)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Bound Variable Change:K2:52)
		
		$Obj_buffer:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
		
		  //=================== layout ==================
		SELECT LIST ITEMS BY POSITION:C381(*;"layout.order";Choose:C955(OB Get:C1224($Obj_buffer;"setting.vertical";Is boolean:K8:9);1;2))  //default is "Vertical"
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"layout.rows"))->:=OB Get:C1224($Obj_buffer;"rows";Is longint:K8:6)
		(OBJECT Get pointer:C1124(Object named:K67:5;"layout.columns"))->:=OB Get:C1224($Obj_buffer;"columns";Is longint:K8:6)
		(OBJECT Get pointer:C1124(Object named:K67:5;"layout.labels-per-record"))->:=OB Get:C1224($Obj_buffer;"labels-per-record";Is longint:K8:6)
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"layout.rows.stepper"))->:=OB Get:C1224($Obj_buffer;"rows";Is longint:K8:6)
		(OBJECT Get pointer:C1124(Object named:K67:5;"layout.columns.stepper"))->:=OB Get:C1224($Obj_buffer;"columns";Is longint:K8:6)
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"automatic_resizing"))->:=Num:C11(OB Get:C1224($Obj_buffer;"setting.auto-width";Is boolean:K8:9))
		
		  //=================== method ==================
		$Txt_buffer:=OB Get:C1224($Obj_buffer;"method";Is text:K8:3)
		$Boo_buffer:=(Length:C16($Txt_buffer)>0)
		
		$Lon_x:=Choose:C955($Boo_buffer;Find in list:C952(*;"method.list";$Txt_buffer;0);0)
		
		SELECT LIST ITEMS BY POSITION:C381(*;"method.list";Choose:C955($Lon_x=0;1;$Lon_x))  //default is "No Method"
		
		OBJECT SET ENABLED:C1123(*;"method.radio.@";$Boo_buffer & ($Lon_x>0))
		
		$Boo_buffer:=OB Get:C1224($Obj_buffer;"evaluate-per-label";Is boolean:K8:9)
		(OBJECT Get pointer:C1124(Object named:K67:5;"method.radio.label"))->:=Num:C11($Boo_buffer)
		(OBJECT Get pointer:C1124(Object named:K67:5;"method.radio.record"))->:=Num:C11(Not:C34($Boo_buffer))
		
		  //=============== Measurements ================
		$Txt_unit:=OB Get:C1224($Obj_buffer;"size.unit";Is text:K8:3)
		
		For ($Lon_i;1;Count list items:C380(*;"size.unit.menu");1)
			
			GET LIST ITEM:C378(*;"size.unit.menu";$Lon_i;$Lon_ref;$Txt_buffer)
			GET LIST ITEM PARAMETER:C985(*;"size.unit.menu";$Lon_ref;"data";$Txt_buffer)
			
			If ($Txt_buffer=$Txt_unit)
				
				$Lon_x:=$Lon_i
				$Lon_i:=MAXLONG:K35:2-1
				
			End if 
		End for 
		
		SELECT LIST ITEMS BY POSITION:C381(*;"size.unit.menu";Choose:C955($Lon_x=0;1;$Lon_x))  //default is "Point"
		
		OB GET PROPERTY NAMES:C1232($Obj_buffer;$tTxt_properties)
		
		For ($Lon_i;1;Size of array:C274($tTxt_properties);1)
			
			If (($tTxt_properties{$Lon_i}="size.@")\
				 & ($tTxt_properties{$Lon_i}#"size.unit"))\
				 | ($tTxt_properties{$Lon_i}="margin.@")\
				 | ($tTxt_properties{$Lon_i}="gap.@")
				
				$Txt_object:="size."+Substring:C12($tTxt_properties{$Lon_i};Position:C15(".";$tTxt_properties{$Lon_i})+1)+".box"
				$Ptr_object:=(OBJECT Get pointer:C1124(Object named:K67:5;$Txt_object))
				
				If ($Txt_unit="pt")
					
					$Ptr_object->:=Round:C94(OB Get:C1224($Obj_buffer;$tTxt_properties{$Lon_i};Is longint:K8:6);0)
					OBJECT SET FORMAT:C236($Ptr_object->;"### ##0")
					
				Else 
					
					  //convert value
					$Ptr_object->:=OB Get:C1224($Obj_buffer;$tTxt_properties{$Lon_i};Is real:K8:4)
					OBJECT SET FORMAT:C236($Ptr_object->;Choose:C955($Txt_unit="mm";"#,###,##0.0;#,###,##0.0;0";"#,###,##0.00;#,###,##0.00;00"))
					
				End if 
			End if 
		End for 
		
		If (OB Get:C1224($Obj_buffer;"init";Is boolean:K8:9))  //first load
			
			OB REMOVE:C1226($Obj_buffer;"init")
			
			If (True:C214)
				
				  //adapt margins according to the current printer {
				GET PRINTABLE MARGIN:C711($Num_marginLeft;$Num_marginTop;$Num_marginRight;$Num_marginBottom)
				
				$Num_marginLeft:=$Num_marginLeft+10
				$Num_marginTop:=$Num_marginTop+10
				$Num_marginRight:=$Num_marginRight+10
				$Num_marginBottom:=$Num_marginBottom+10
				
				If ($Txt_unit#"pt")
					
					$Num_marginLeft:=math_Length_conversion ($Num_marginLeft;$Txt_unit;"pt";0)
					$Num_marginTop:=math_Length_conversion ($Num_marginTop;$Txt_unit;"pt";0)
					$Num_marginRight:=math_Length_conversion ($Num_marginRight;$Txt_unit;"pt";0)
					$Num_marginBottom:=math_Length_conversion ($Num_marginBottom;$Txt_unit;"pt";0)
					
				End if 
				
				  //update UI
				(OBJECT Get pointer:C1124(Object named:K67:5;"size.left.box"))->:=$Num_marginLeft
				(OBJECT Get pointer:C1124(Object named:K67:5;"size.top.box"))->:=$Num_marginTop
				(OBJECT Get pointer:C1124(Object named:K67:5;"size.right.box"))->:=$Num_marginRight
				(OBJECT Get pointer:C1124(Object named:K67:5;"size.bottom.box"))->:=$Num_marginBottom
				  //}
				
			End if 
			
			If (OB Get:C1224($Obj_buffer;"setting.auto-width";Is boolean:K8:9))
				
				layout_AUTOMATIC_RESIZING 
				
			End if 
			
			layout_UPDATE_UI 
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 