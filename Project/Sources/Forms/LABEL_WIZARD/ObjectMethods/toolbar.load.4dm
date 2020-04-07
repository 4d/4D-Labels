  // ----------------------------------------------------
  // Object method : LABEL_WIZARD.toolbar.load - (4D Labels)
  // ID[0C73C6FBFFFB465B99F178C8596458AE]
  // Created #8-6-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent;$Lon_i)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Dir_user;$Dom_label;$File_;$Mnu_main;$Txt_formName;$Txt_me)
C_OBJECT:C1216($Obj_param)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Alternative Click:K2:36)
		
		$Dir_user:=Get 4D folder:C485(Current resources folder:K5:16;*)\
			+"Labels"+Folder separator:K24:12
		
		ARRAY TEXT:C222($tTxt_files;0x0000)
		DOCUMENT LIST:C474($Dir_user;$tTxt_files;Ignore invisible:K24:16)
		
		$Mnu_main:=Create menu:C408
		
		For ($Lon_i;1;Size of array:C274($tTxt_files);1)
			
			If ($tTxt_files{$Lon_i}="@.4lb")\
				 | ($tTxt_files{$Lon_i}="@.4lbp")
				
				APPEND MENU ITEM:C411($Mnu_main;$tTxt_files{$Lon_i})
				SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;$Dir_user+$tTxt_files{$Lon_i})
				
			End if 
		End for 
		
		$tTxt_files{0}:=Dynamic pop up menu:C1006($Mnu_main)
		RELEASE MENU:C978($Mnu_main)
		
		OK:=Num:C11(Length:C16($tTxt_files{0})#0)
		
		If (OK=1)
			
			DOCUMENT:=$tTxt_files{0}
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		  //#ACI0094652 [
		  //$File_:=Select document(13893;".4lb;.4lbp";$Txt_title;Package open+Use sheet window)
		  //#ACI0096139 {
		  //PLATFORM PROPERTIES($Lon_platform)
		  //$File_:=Select document(13893;Choose($Lon_platform=Windows;".4lb";"4DET");Get localized string("Select label settings file...");Package open+Use sheet window)
		$File_:=Select document:C905(13893;".4lb;.4lbp";Get localized string:C991("Select label settings file...");Package open:K24:8+Use sheet window:K24:11)
		  //}
		  //]
		
		  //______________________________________________________
	Else 
		
		OK:=0
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 

If (OK=1)
	
	$Dom_label:=label_Parse_document (DOCUMENT;True:C214)
	
	If (Length:C16($Dom_label)>0)
		
		C_LABEL_DOCUMENT:=DOCUMENT
		
		$Obj_param:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
		
		OB SET:C1220($Obj_param;\
			"dom";$Dom_label;\
			"path";C_LABEL_DOCUMENT)
		
		OB REMOVE:C1226($Obj_param;"currentDom")
		
		DOM GET XML ATTRIBUTE BY NAME:C728(DOM Find XML element by ID:C1010($Dom_label;"form");"name";$Txt_formName)
		OB SET:C1220($Obj_param;\
			"field-list-enabled";Length:C16($Txt_formName)=0)
		
		  //#ACI0093908 [
		  //(OBJECT Get pointer(Object named;"toolbar.mode"))->:=$Txt_buffer
		  //]
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"editor"))->:=$Dom_label  //will update the picture
		
		wizard_UPDATE_UI 
		
	End if 
End if 