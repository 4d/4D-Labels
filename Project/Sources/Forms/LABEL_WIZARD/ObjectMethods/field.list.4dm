  // ----------------------------------------------------
  // Object method : Table.Fields - (4D Labels)
  // ID[5FD518ED72094CF5B8C12F06E151E026]
  // Created #11-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_BLOB:C604($Blb_fields;$Blb_tables;$Blb_types)
C_LONGINT:C283($Lon_field;$Lon_formEvent;$Lon_i;$Lon_table;$Lon_type;$Lon_x)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_me)
C_OBJECT:C1216($Obj_param)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

If ($Lon_formEvent#On Load:K2:1)
	
	$Obj_param:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		obj_BOUND_WITH_LIST (New list:C375)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Getting Focus:K2:7)
		
		$Lon_x:=OB Get:C1224($Obj_param;"field-index";Is longint:K8:6)
		SELECT LIST ITEMS BY POSITION:C381(*;"field.list";$Lon_x+Num:C11($Lon_x=0))
		
		OBJECT SET VISIBLE:C603(*;"field.@.focus";False:C215)
		OBJECT SET VISIBLE:C603(*;"field.list.focus";True:C214)
		
		OB SET:C1220($Obj_param;\
			"field-focus-1";$Txt_me)
		
		  //________________________________________
	: ($Lon_formEvent=On Losing Focus:K2:8)
		
		OBJECT SET VISIBLE:C603(*;"field.list.focus";False:C215)
		
		  //________________________________________
	: ($Lon_formEvent=On Selection Change:K2:29)
		
		OB SET:C1220($Obj_param;\
			"field-index";Selected list items:C379(*;$Txt_me))
		
		  //______________________________________________________
	: ($Lon_formEvent=On Begin Drag Over:K2:44)
		
		CLEAR PASTEBOARD:C402
		
		ARRAY LONGINT:C221($tLon_selected;0x0000)
		
		$tLon_selected{0}:=Selected list items:C379(*;$Txt_me;$tLon_selected;*)
		
		If (0#Size of array:C274($tLon_selected))
			
			ARRAY LONGINT:C221($tLon_tables;0x0000)
			ARRAY LONGINT:C221($tLon_fields;0x0000)
			ARRAY LONGINT:C221($tLon_types;0x0000)
			
			For ($Lon_i;1;Size of array:C274($tLon_selected);1)
				
				$tLon_selected{0}:=$tLon_selected{$Lon_i}
				
				GET LIST ITEM PARAMETER:C985(*;$Txt_me;$tLon_selected{0};"tableId";$Lon_table)
				GET LIST ITEM PARAMETER:C985(*;$Txt_me;$tLon_selected{0};"fieldId";$Lon_field)
				GET LIST ITEM PARAMETER:C985(*;$Txt_me;$tLon_selected{0};"fieldType";$Lon_type)
				
				APPEND TO ARRAY:C911($tLon_tables;$Lon_table)
				APPEND TO ARRAY:C911($tLon_fields;$Lon_field)
				APPEND TO ARRAY:C911($tLon_types;$Lon_type)
				
			End for 
			
			VARIABLE TO BLOB:C532($tLon_tables;$Blb_tables)
			VARIABLE TO BLOB:C532($tLon_fields;$Blb_fields)
			VARIABLE TO BLOB:C532($tLon_types;$Blb_types)
			
			APPEND DATA TO PASTEBOARD:C403("com.4d.array.table";$Blb_tables)
			APPEND DATA TO PASTEBOARD:C403("com.4d.array.field";$Blb_fields)
			APPEND DATA TO PASTEBOARD:C403("com.4d.array.field.type";$Blb_types)
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		CLEAR LIST:C377($Ptr_me->;*)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 