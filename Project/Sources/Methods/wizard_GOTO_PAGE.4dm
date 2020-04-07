//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : wizard_GOTO_PAGE
  // Database: 4D Labels
  // ID[F8F3BF506F5642EDB3055E213B7B0EF7]
  // Created #11-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_page;$Lon_parameters)
C_POINTER:C301($Ptr_buffer)
C_TEXT:C284($Txt_buffer;$Txt_object)
C_OBJECT:C1216($Obj_param)

If (False:C215)
	C_LONGINT:C283(wizard_GOTO_PAGE ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Lon_page:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	$Obj_param:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //keep the current focus for the current page
OB SET:C1220($Obj_param;\
"field-focus-"+String:C10(FORM Get current page:C276);OBJECT Get name:C1087(Object with focus:K67:3))

  //get the last focus for the wanted page
$Txt_object:=OB Get:C1224($Obj_param;"field-focus-"+String:C10($Lon_page);Is text:K8:3)

  //display the wanted page
FORM GOTO PAGE:C247($Lon_page;*)

  //load page
Case of 
		
		  //______________________________________________________
	: ($Lon_page=1)
		
		$Ptr_buffer:=OBJECT Get pointer:C1124(Object named:K67:5;"field.list")
		
		If (Count list items:C380($Ptr_buffer->)=0)
			
			  //first use
			CLEAR LIST:C377($Ptr_buffer->)
			
			$Ptr_buffer->:=wizard_Field_list (C_MASTER_TABLE)
			
		End if 
		
		If (Length:C16($Txt_object)=0)
			
			  //first load
			$Txt_object:="field.search.box"
			
		End if 
		
		GOTO OBJECT:C206(*;$Txt_object)
		
		Case of 
				
				  //----------------------------------------
			: ($Txt_object="field.search.box")
				
				OBJECT SET VISIBLE:C603(*;"field.search.focus";True:C214)
				OBJECT SET VISIBLE:C603(*;"field.search.close";(Length:C16((OBJECT Get pointer:C1124(Object named:K67:5;$Txt_object))->)#0))
				
				  //----------------------------------------
			: ($Txt_object="field.list")
				
				OBJECT SET VISIBLE:C603(*;"field.list.focus";True:C214)
				
				  //----------------------------------------
			Else 
				
				  //NOTHING MORE TO DO
				
				  //----------------------------------------
		End case 
		
		  //-> editor
		(OBJECT Get pointer:C1124(Object named:K67:5;"editor"))->:=OB Get:C1224($Obj_param;"dom";Is text:K8:3)
		
		  //______________________________________________________
	: ($Lon_page=2)
		
		  //give focus to the subform
		GOTO OBJECT:C206(*;"layout")
		
		  //______________________________________________________
	: (Not:C34(<>Boo_debug))
		
		  //NOTHING MORE TO DO
		
		  //______________________________________________________
	: ($Lon_page=4)
		
		ASSERT:C1129(DEBUG_Update (C_LABEL_DOCUMENT))
		
		DOM EXPORT TO VAR:C863(OB Get:C1224($Obj_param;"dom";Is text:K8:3);$Txt_buffer)
		(OBJECT Get pointer:C1124(Object named:K67:5;"code"))->:=xml_ColoredSyntax ($Txt_buffer)
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End