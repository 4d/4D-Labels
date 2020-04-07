//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : lbw_UPDATE_UI
  // Database: 4D Labels
  // ID[24250311F6E8464090535971B9381DEA]
  // Created #16-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_activated)
C_LONGINT:C283($Lon_i;$Lon_page;$Lon_parameters;$Lon_x)
C_REAL:C285($Num_buffer)
C_TEXT:C284($Dom_label;$Dom_node;$Txt_buffer;$Txt_object;$Txt_unit)
C_OBJECT:C1216($Obj_buffer;$Obj_param)

If (False:C215)
	C_TEXT:C284(wizard_UPDATE_UI ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Dom_label:=$1
		
	Else 
		
		$Obj_param:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
		$Dom_label:=OB Get:C1224($Obj_param;"dom";Is text:K8:3)
		
	End if 
	
	$Lon_page:=FORM Get current page:C276
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_page=1)
		
		  //================ form menu ================
		$Dom_node:=DOM Find XML element by ID:C1010($Dom_label;"form")
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_node;"name";$Txt_buffer)
		
		  //#ACI0093763 [
		  //(OBJECT Get pointer(Object named;"toolbar.mode"))->:=$Txt_buffer
		  //]
		
		$Boo_activated:=OB Get:C1224($Obj_param;"field-list-enabled";Is boolean:K8:9)
		
		If ($Boo_activated)
			
			  //display list as activated
			OBJECT SET RGB COLORS:C628(*;"field.label";Foreground color:K23:1;Background color:K23:2)
			OBJECT SET RGB COLORS:C628(*;"field.list";Foreground color:K23:1;Background color:K23:2)
			OBJECT SET VISIBLE:C603(*;"field.list.disabled";False:C215)
			OBJECT SET DRAG AND DROP OPTIONS:C1183(*;"field.list";True:C214;False:C215;False:C215;False:C215)
			
			$Lon_x:=OB Get:C1224($Obj_param;"field-index";Is longint:K8:6)
			SELECT LIST ITEMS BY POSITION:C381(*;"field.list";$Lon_x+Num:C11($Lon_x=0))
			
			  //show focus ring, if any
			$Txt_object:=OB Get:C1224($Obj_param;"field-focus-1";Is text:K8:3)
			
			If (Length:C16($Txt_object)=0)
				
				  //first load
				$Txt_object:="field.search.box"
				
			End if 
			
			GOTO OBJECT:C206(*;$Txt_object)
			
			OBJECT SET VISIBLE:C603(*;"field.search.focus";$Txt_object="field.search.box")
			OBJECT SET VISIBLE:C603(*;"field.list.focus";$Txt_object="field.list")
			
		Else 
			
			  //display list as deactivated
			OBJECT SET RGB COLORS:C628(*;"field.label";OB Get:C1224(<>label_params;"disabledTextColor";Is longint:K8:6);Background color:K23:2)
			OBJECT SET RGB COLORS:C628(*;"field.list";OB Get:C1224(<>label_params;"disabledTextColor";Is longint:K8:6);Background color:K23:2)
			OBJECT SET VISIBLE:C603(*;"field.list.disabled";True:C214)
			OBJECT SET DRAG AND DROP OPTIONS:C1183(*;"field.list";False:C215;False:C215;False:C215;False:C215)
			SELECT LIST ITEMS BY POSITION:C381(*;"field.list";-1)
			
			  //hide the focus rings
			OBJECT SET VISIBLE:C603(*;"@.focus";False:C215)
			GOTO OBJECT:C206(*;"editor")
			
		End if 
		
		  //______________________________________________________
	: ($Lon_page=2)
		
		$Obj_buffer:=(OBJECT Get pointer:C1124(Object named:K67:5;"layout"))->
		
		If (OB Is empty:C1297($Obj_buffer))
			
			OB SET:C1220($Obj_buffer;\
				"init";True:C214)
			
		End if 
		
		  //=================== layout ==================
		OB SET:C1220($Obj_buffer;\
			"setting.vertical";label_data_Get ("setting.vertical")="true";\
			"rows";label_data_Get ("rows");\
			"columns";label_data_Get ("columns");\
			"labels-per-record";label_data_Get ("labels-per-record");\
			"setting.auto-width";label_data_Get ("setting.auto-width")="true")
		
		  //=============== Measurements ================
		$Txt_unit:=label_data_Get ("size.unit";$Dom_label)
		OB SET:C1220($Obj_buffer;\
			"size.unit";$Txt_unit)
		
		ARRAY TEXT:C222($tTxt_objects;0x0000)
		
		APPEND TO ARRAY:C911($tTxt_objects;"size.width")
		APPEND TO ARRAY:C911($tTxt_objects;"size.height")
		APPEND TO ARRAY:C911($tTxt_objects;"margin.top")
		APPEND TO ARRAY:C911($tTxt_objects;"margin.left")
		APPEND TO ARRAY:C911($tTxt_objects;"margin.right")
		APPEND TO ARRAY:C911($tTxt_objects;"margin.bottom")
		APPEND TO ARRAY:C911($tTxt_objects;"gap.horizontal")
		APPEND TO ARRAY:C911($tTxt_objects;"gap.vertical")
		
		For ($Lon_i;1;Size of array:C274($tTxt_objects);1)
			
			  //retrieve stored value in point
			$Txt_buffer:=label_data_Get ($tTxt_objects{$Lon_i};$Dom_label)
			
			  //convert the decimal separator
			XML DECODE:C1091($Txt_buffer;$Num_buffer)
			
			If ($Txt_unit="pt")
				
				OB SET:C1220($Obj_buffer;\
					$tTxt_objects{$Lon_i};Round:C94($Num_buffer;0))
				
			Else 
				
				  //convert value
				OB SET:C1220($Obj_buffer;\
					$tTxt_objects{$Lon_i};math_Length_conversion ($Num_buffer;"pt";$Txt_unit;Choose:C955($Txt_unit="mm";1;2)))
				
			End if 
		End for 
		
		  //=================== method ==================
		OB SET:C1220($Obj_buffer;\
			"method";label_data_Get ("method.name");\
			"evaluate-per-label";label_data_Get ("method.evaluate-per-label")="true")
		
		  //Generate On Bound Variable Change
		obj_TOUCH ("layout")
		
		wizard_PAPER ($Dom_label)
		
		  //______________________________________________________
	: ($Lon_page=3)
		
		  //NOTHING MORE TO DO
		
		  //______________________________________________________
	Else 
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End