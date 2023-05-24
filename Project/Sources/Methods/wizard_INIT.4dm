//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : wizard_INIT
// Database: 4D Labels
// ID[E9019810C6A346A4804BB0DF82566898]
// Created #16-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($1)

C_BOOLEAN:C305($Boo_initDialog; $Boo_mode; $Boo_prefilled)
C_LONGINT:C283($Lon_i; $Lon_parameters; $Lon_platform)
C_POINTER:C301($Ptr_table)
C_TEXT:C284($Dir_user; $File_user; $Txt_buffer)
C_OBJECT:C1216($Obj_toolbar)

ARRAY TEXT:C222($tTxt_buffer; 0)
ARRAY TEXT:C222($tTxt_forms; 0)
ARRAY OBJECT:C1221($tObj_param; 0)

If (False:C215)
	C_BOOLEAN:C305(wizard_INIT; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		$Boo_initDialog:=$1
		
	End if 
	
	LABELS_INIT
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($Boo_initDialog)
	
	//==================== display the debug objects, if any
	OBJECT SET VISIBLE:C603(*; "Debug@"; <>Boo_debug)
	
	//==================== set the focus rings color
	OBJECT SET RGB COLORS:C628(*; "@.focus"; Highlight text background color:K23:5; Background color none:K23:10)
	
	//==================== adjust display according to the platform
	_O_PLATFORM PROPERTIES:C365($Lon_platform)
	
	If ($Lon_platform=Mac OS:K25:2)
		
		OBJECT SET VISIBLE:C603(*; "win.@"; False:C215)
		
	Else 
		
		OBJECT SET VISIBLE:C603(*; "mac.@"; False:C215)
		
	End if 
	
	//==================== check for user's restrictions
	$File_user:=Get 4D folder:C485(Current resources folder:K5:16; *)+"labels.json"
	
	If (Test path name:C476($File_user)=Is a document:K24:1)
		
		$Txt_buffer:=Document to text:C1236($File_user)
		
		JSON PARSE ARRAY:C1219($Txt_buffer; $tObj_param)
		
		For ($Lon_i; 1; Size of array:C274($tObj_param); 1)
			
			If (C_MASTER_TABLE=OB Get:C1224($tObj_param{$Lon_i}; "tableId"; Is longint:K8:6))
				
				$tObj_param:=$Lon_i
				$Lon_i:=MAXLONG:K35:2-1
				
			End if 
		End for 
	End if 
	
	//==================== determine if the mode menu should be displayed
	$Ptr_table:=Table:C252(C_MASTER_TABLE)
	
	//get the available forms for the current table
	FORM GET NAMES:C1167($Ptr_table->; $tTxt_forms; *)
	
	//restrict the list, if necessary, according to user instructions
	$Boo_prefilled:=($tObj_param>0)
	
	If ($Boo_prefilled)
		
		$Boo_prefilled:=OB Is defined:C1231($tObj_param{$tObj_param}; "forms")
		
		If ($Boo_prefilled)
			
			OB GET ARRAY:C1229($tObj_param{$tObj_param}; "forms"; $tTxt_buffer)
			
			For ($Lon_i; 1; Size of array:C274($tTxt_buffer); 1)
				
				If (Find in array:C230($tTxt_forms; $tTxt_buffer{$Lon_i})>0)
					
					$Boo_mode:=True:C214
					$Lon_i:=MAXLONG:K35:2-1
					
				End if 
			End for 
		End if 
	End if 
	
	//if not user defined, lists the forms
	If (Not:C34($Boo_prefilled))
		
		// #20-10-2015 - no restriction to use forms {
		//For ($Lon_i;1;Size of array($tTxt_forms);1)
		//  //we limit the use of forms with only one page and fixed dimensions
		//FORM GET PROPERTIES($Ptr_table->;$tTxt_forms{$Lon_i};$Lon_;$Lon_;$Lon_pages;$Boo_fixedWidth;$Boo_fixedHeight)
		//If ($Lon_pages=1) & ($Boo_fixedWidth & $Boo_fixedHeight)
		//$Boo_mode:=True
		//$Lon_i:=MAXLONG-1
		//End if
		//End for
		
		$Boo_mode:=(Size of array:C274($tTxt_forms)>0)  //}
		
	End if 
	
	//Test for user label's folder
	$Dir_user:=Get 4D folder:C485(Current resources folder:K5:16; *)+"Labels"+Folder separator:K24:12
	
	If (Test path name:C476($Dir_user)=Is a folder:K24:2)
		
		//add separate pop-up menu
		OBJECT SET FORMAT:C236(*; "toolbar.load"; ";;;;;;;;;;2")
		
	End if 
	
	//==================== initialize toolbar
	ARRAY OBJECT:C1221($tObj_objects; 0x0000)
	
	OB SET:C1220($Obj_toolbar; \
		"object"; "toolbar.load"; \
		"type"; "button"; \
		"visible"; True:C214; \
		"right-offset"; 10)
	APPEND TO ARRAY:C911($tObj_objects; $Obj_toolbar)
	CLEAR VARIABLE:C89($Obj_toolbar)
	
	OB SET:C1220($Obj_toolbar; \
		"object"; "toolbar.save"; \
		"type"; "button"; \
		"visible"; True:C214)
	APPEND TO ARRAY:C911($tObj_objects; $Obj_toolbar)
	CLEAR VARIABLE:C89($Obj_toolbar)
	
	OB SET:C1220($Obj_toolbar; \
		"object"; "toolbar.opened.sep.1"; \
		"type"; "separator"; \
		"visible"; True:C214)
	APPEND TO ARRAY:C911($tObj_objects; $Obj_toolbar)
	CLEAR VARIABLE:C89($Obj_toolbar)
	
	OB SET:C1220($Obj_toolbar; \
		"object"; "toolbar.preview"; \
		"type"; "button"; \
		"visible"; True:C214)
	APPEND TO ARRAY:C911($tObj_objects; $Obj_toolbar)
	CLEAR VARIABLE:C89($Obj_toolbar)
	
	OB SET:C1220($Obj_toolbar; \
		"object"; "toolbar.print"; \
		"type"; "button"; \
		"visible"; True:C214)
	APPEND TO ARRAY:C911($tObj_objects; $Obj_toolbar)
	CLEAR VARIABLE:C89($Obj_toolbar)
	
	CLEAR VARIABLE:C89($Obj_toolbar)
	OB SET:C1220($Obj_toolbar; \
		"object"; "toolbar.opened.sep.2"; \
		"type"; "separator"; \
		"visible"; True:C214)
	APPEND TO ARRAY:C911($tObj_objects; $Obj_toolbar)
	CLEAR VARIABLE:C89($Obj_toolbar)
	
	OB SET:C1220($Obj_toolbar; \
		"object"; "toolbar.tabs"; \
		"type"; "widget"; \
		"visible"; True:C214)
	APPEND TO ARRAY:C911($tObj_objects; $Obj_toolbar)
	
	CLEAR VARIABLE:C89($Obj_toolbar)
	OB SET:C1220($Obj_toolbar; \
		"object"; "toolbar.opened.sep.3"; \
		"type"; "separator"; \
		"visible"; True:C214)
	APPEND TO ARRAY:C911($tObj_objects; $Obj_toolbar)
	CLEAR VARIABLE:C89($Obj_toolbar)
	
	//#redmine:20131 {
	//OB SET($Obj_toolbar;"object";"toolbar.mode";"type";"widget";"visible";$Boo_mode)
	OB SET:C1220($Obj_toolbar; \
		"object"; "toolbar.form"; \
		"type"; "button"; \
		"visible"; $Boo_mode)  //}
	APPEND TO ARRAY:C911($tObj_objects; $Obj_toolbar)
	CLEAR VARIABLE:C89($Obj_toolbar)
	
	OB SET ARRAY:C1227($Obj_toolbar; "toolbar"; $tObj_objects)
	CLEAR VARIABLE:C89($tObj_objects)
	
	ALIGN_OBJECTS($Obj_toolbar)
	
	//set label's page as default
	(OBJECT Get pointer:C1124(Object named:K67:5; "toolbar.tabs"))->:=1
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End