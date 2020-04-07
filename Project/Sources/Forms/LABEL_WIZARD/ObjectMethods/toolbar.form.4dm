  // ----------------------------------------------------
  // Object method : LABEL_WIZARD.toolbar.load - (4D Labels)
  // ID[0C73C6FBFFFB465B99F178C8596458AE]
  // Created #8-6-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($Boo_prefilled)
C_LONGINT:C283($Lon_formEvent;$Lon_height;$Lon_i;$Lon_width)
C_PICTURE:C286($Pic_buffer)
C_POINTER:C301($Ptr_me;$Ptr_table)
C_TEXT:C284($Dom_form;$Dom_label;$File_user;$Mnu_choice;$Mnu_main;$Txt_buffer)
C_TEXT:C284($Txt_current;$Txt_me)
C_OBJECT:C1216($Obj_param)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)\
		 | ($Lon_formEvent=On Alternative Click:K2:36)
		
		ARRAY TEXT:C222($tTxt_buffer;0x0000)
		ARRAY TEXT:C222($tTxt_forms;0x0000)
		ARRAY OBJECT:C1221($tObj_param;0x0000)
		
		$Obj_param:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
		$Dom_label:=OB Get:C1224($Obj_param;"dom";Is text:K8:3)
		$Dom_form:=DOM Find XML element by ID:C1010($Dom_label;"form")
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_form;"name";$Txt_current)
		
		  //==================== check for user's restrictions
		$File_user:=Get 4D folder:C485(Current resources folder:K5:16;*)+"labels.json"
		
		If (Test path name:C476($File_user)=Is a document:K24:1)
			
			$Txt_buffer:=Document to text:C1236($File_user)
			
			JSON PARSE ARRAY:C1219($Txt_buffer;$tObj_param)
			
			For ($Lon_i;1;Size of array:C274($tObj_param);1)
				
				If (C_MASTER_TABLE=OB Get:C1224($tObj_param{$Lon_i};"tableId";Is longint:K8:6))
					
					$tObj_param:=$Lon_i
					$Lon_i:=MAXLONG:K35:2-1
					
				End if 
			End for 
		End if 
		
		$Mnu_main:=Create menu:C408
		
		APPEND MENU ITEM:C411($Mnu_main;Get localized string:C991("noForm"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"no-form")
		
		If (Length:C16($Txt_current)=0)
			
			SET MENU ITEM MARK:C208($Mnu_main;-1;Char:C90(18))
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_main;"-")
		
		$Ptr_table:=Table:C252(C_MASTER_TABLE)
		
		  //get the available forms for the current table
		FORM GET NAMES:C1167($Ptr_table->;$tTxt_forms;*)
		
		  //restrict the list, if necessary, according to user instructions
		$Boo_prefilled:=($tObj_param>0)
		
		If ($Boo_prefilled)
			
			$Boo_prefilled:=OB Is defined:C1231($tObj_param{$tObj_param};"forms")
			
		End if 
		
		If ($Boo_prefilled)
			
			OB GET ARRAY:C1229($tObj_param{$tObj_param};"forms";$tTxt_buffer)
			
			For ($Lon_i;1;Size of array:C274($tTxt_buffer);1)
				
				If (Find in array:C230($tTxt_forms;$tTxt_buffer{$Lon_i})>0)
					
					APPEND MENU ITEM:C411($Mnu_main;$tTxt_buffer{$Lon_i})
					SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;$tTxt_buffer{$Lon_i})
					
					If ($Txt_current=$tTxt_buffer{$Lon_i})
						
						SET MENU ITEM MARK:C208($Mnu_main;-1;Char:C90(18))
						
					End if 
				End if 
			End for 
			
		Else 
			
			  // #20-10-2015 - no restriction to use forms [
			  //For ($Lon_i;1;Size of array($tTxt_forms);1)
			  //  //we limit the use of forms with only one page and fixed dimensions
			  //FORM GET PROPERTIES($Ptr_table->;$tTxt_forms{$Lon_i};$Lon_;$Lon_;$Lon_pages;$Boo_fixedWidth;$Boo_fixedHeight)
			  //If ($Lon_pages=1)& ($Boo_fixedWidth & $Boo_fixedHeight)
			  //APPEND MENU ITEM($Mnu_main;$tTxt_forms{$Lon_i})
			  //SET MENU ITEM PARAMETER($Mnu_main;-1;$tTxt_forms{$Lon_i})
			  //  //#ACI0093764
			  //  //If ($Txt_current=$tTxt_buffer{$Lon_i})
			  //If ($Txt_current=$tTxt_forms{$Lon_i})
			  //SET MENU ITEM MARK($Mnu_main;-1;Char(18))
			  //End if
			  //End if
			  //End for
			For ($Lon_i;1;Size of array:C274($tTxt_forms);1)
				
				APPEND MENU ITEM:C411($Mnu_main;$tTxt_forms{$Lon_i})
				SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;$tTxt_forms{$Lon_i})
				SET MENU ITEM MARK:C208($Mnu_main;-1;Char:C90(18)*Num:C11($Txt_current=$tTxt_forms{$Lon_i}))
				
			End for 
			  //]
			
		End if 
		
		$Mnu_choice:=Dynamic pop up menu:C1006($Mnu_main)
		RELEASE MENU:C978($Mnu_main)
		
		Case of 
				
				  //………………………………………………………………
			: (Length:C16($Mnu_choice)=0)
				
				  //NOTHING MORE TO DO
				
				  //………………………………………………………………
			: ($Mnu_choice="no-form")
				
				DOM SET XML ATTRIBUTE:C866($Dom_form;\
					"name";"";\
					"number";-1)
				
				  //enable fields' list
				OB SET:C1220($Obj_param;\
					"field-list-enabled";True:C214)
				
				Editor_SET_ENABLED (True:C214)
				
				  //give focus to the search box
				GOTO OBJECT:C206(*;OB Get:C1224($Obj_param;"field-focus-1";Is text:K8:3))
				
				SET TIMER:C645(-1)
				
				  //update editor
				(OBJECT Get pointer:C1124(Object named:K67:5;"editor"))->:=$Dom_label
				
				  //………………………………………………………………
			Else 
				
				DOM SET XML ATTRIBUTE:C866($Dom_form;\
					"name";$Mnu_choice;\
					"number";0)
				
				  //update Layout {
				FORM SCREENSHOT:C940($Ptr_table->;$Mnu_choice;$Pic_buffer)
				PICTURE PROPERTIES:C457($Pic_buffer;$Lon_width;$Lon_height)
				CLEAR VARIABLE:C89($Pic_buffer)
				
				  //ACI0099601 : add the test if the setting is auto width
				If (label_data_Get ("setting.auto-width")="false")
					
					label_data_SET ("size.width";String:C10($Lon_width))
					label_data_SET ("size.height";String:C10($Lon_height))
					
				End if 
				  //}
				
				  //disable fields' list
				OB SET:C1220($Obj_param;\
					"field-list-enabled";False:C215)
				
				Editor_SET_ENABLED (False:C215)
				
				  //give the focus to the editor
				GOTO OBJECT:C206(*;"editor")
				
				SET TIMER:C645(-1)
				
				  //update editor
				(OBJECT Get pointer:C1124(Object named:K67:5;"editor"))->:=$Dom_label
				
				  //………………………………………………………………
		End case 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 