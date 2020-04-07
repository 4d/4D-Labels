//%attributes = {"invisible":true}
  //DON'T RENAME THESE VARIABLES LINKED TO C++ CODE {
C_LONGINT:C283(C_MASTER_TABLE)
C_TEXT:C284(C_LABEL_DOCUMENT)
  //}

C_LONGINT:C283(MOUSEX;MOUSEY)

If (False:C215)  //wizard
	
	  //_________________________________________
	C_PICTURE:C286(wizard_Field_icon ;$0)
	C_LONGINT:C283(wizard_Field_icon ;$1)
	
	  //_________________________________________
	C_LONGINT:C283(wizard_Field_list ;$0)
	C_LONGINT:C283(wizard_Field_list ;$1)
	C_TEXT:C284(wizard_Field_list ;$2)
	
	  //_________________________________________
	C_LONGINT:C283(wizard_GOTO_PAGE ;$1)
	
	  //_________________________________________
	C_BOOLEAN:C305(wizard_INIT ;$1)
	
	  //_________________________________________
	C_TEXT:C284(wizard_PAPER ;$1)
	
	  //_________________________________________
	C_OBJECT:C1216(wizard_PAPER_PREVIEW ;$1)
	
	  //_________________________________________
	C_BOOLEAN:C305(wizard_Save ;$0)
	C_TEXT:C284(wizard_Save ;$1)
	
	  //_________________________________________
	C_TEXT:C284(wizard_SET_DATA ;$1)
	C_TEXT:C284(wizard_SET_DATA ;$2)
	C_TEXT:C284(wizard_SET_DATA ;${3})
	
	  //_________________________________________
	C_TEXT:C284(wizard_UPDATE_UI ;$1)
	
	  //_________________________________________
End if 

If (False:C215)  //layout
	
	  //_________________________________________
	C_LONGINT:C283(layout_HANDLE ;$1)
	
	  //_________________________________________
	C_TEXT:C284(layout_SET_DATA ;$1)
	C_TEXT:C284(layout_SET_DATA ;$2)
	
	  //_________________________________________
End if 