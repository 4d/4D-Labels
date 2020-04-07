//%attributes = {"invisible":true}
C_BOOLEAN:C305(<>Boo_debug)

<>Boo_debug:=(Structure file:C489=Structure file:C489(*))\
 | Not:C34(Is compiled mode:C492)

C_OBJECT:C1216(<>editor_params)

  //Error if not declared in 64 bits
C_LONGINT:C283(MOUSEX;MOUSEY)

If (False:C215)  //EVENTS
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_ON_DATA_CHANGE ;$1)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_SET_ENABLED ;$1)
	
	  //____________________________________
	C_TEXT:C284(Editor_ON_CONTEXTUAL_MENU ;$1)
	C_TEXT:C284(Editor_ON_CONTEXTUAL_MENU ;$2)
	C_TEXT:C284(Editor_ON_CONTEXTUAL_MENU ;$3)
	
	  //____________________________________
End if 

If (False:C215)  //HISTORY
	
	  //____________________________________
	C_LONGINT:C283(Editor_HISTORY_RESTORE ;$1)
	
	  //____________________________________
End if 

If (False:C215)  //TOOLS
	
	  //____________________________________
	C_LONGINT:C283(Editor_SET_STROKE_WIDTH ;$1)
	
	  //____________________________________
	C_LONGINT:C283(Editor_Get_default_stroke_width ;$0)
	
	  //____________________________________
	C_LONGINT:C283(Editor_SET_FILL ;$1)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_Field_drop ;$0)
	C_TEXT:C284(Editor_Field_drop ;$1)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_Image_drop ;$0)
	C_TEXT:C284(Editor_Image_drop ;$1)
	C_PICTURE:C286(Editor_Image_drop ;$2)
	
	  //____________________________________
	C_LONGINT:C283(Editor_SET_FONT_COLOR ;$1)
	
	  //____________________________________
	C_LONGINT:C283(Editor_SET_STROKE ;$1)
	
	  //____________________________________
	C_TEXT:C284(Editor_SET_TOOL ;$1)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_TOOL_SET_ENABLED ;$1)
	
	  //____________________________________
	C_TEXT:C284(Editor_UPDATE_TOOL ;$1)
	C_REAL:C285(Editor_UPDATE_TOOL ;$2)
	
	  //____________________________________
End if 

If (False:C215)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_Definition_drop ;$0)
	
	  //____________________________________
	C_TEXT:C284(Editor_Get_handle ;$0)
	
	  //____________________________________
	C_TEXT:C284(Editor_SET_HANDLE ;$1)
	
	  //____________________________________
	C_POINTER:C301(Editor_GET_CLICK ;$1)
	C_POINTER:C301(Editor_GET_CLICK ;$2)
	
	C_LONGINT:C283(Editor_SET_CLICK ;$1)
	C_LONGINT:C283(Editor_SET_CLICK ;$2)
	
	  //____________________________________
	C_LONGINT:C283(Editor_Get_color ;$0)
	C_TEXT:C284(Editor_Get_color ;$1)
	
	  //____________________________________
	C_TEXT:C284(Editor_Get_current ;$0)
	C_BOOLEAN:C305(Editor_Get_current ;$1)
	
	  //____________________________________
	C_OBJECT:C1216(Editor_Get_grips ;$0)
	C_POINTER:C301(Editor_Get_grips ;$1)
	C_POINTER:C301(Editor_Get_grips ;$2)
	
	  //____________________________________
	C_LONGINT:C283(Editor_Get_objectCount ;$0)
	C_TEXT:C284(Editor_Get_objectCount ;$1)
	
	C_TEXT:C284(Editor_SET_CURRENT ;$1)
	
	C_POINTER:C301(Editor_GET_POINTS ;$1)
	C_POINTER:C301(Editor_GET_POINTS ;$2)
	
	C_REAL:C285(Editor_SET_POINTS ;$1)
	C_REAL:C285(Editor_SET_POINTS ;$2)
	
	  //____________________________________
	C_TEXT:C284(Editor_OB_Get_type ;$0)
	C_TEXT:C284(Editor_OB_Get_type ;$1)
	C_TEXT:C284(Editor_OB_Get_type ;$2)
	C_POINTER:C301(Editor_OB_Get_type ;$3)
	C_POINTER:C301(Editor_OB_Get_type ;$4)
	
	  //____________________________________
	C_TEXT:C284(Editor_Get_current_tool ;$0)
	
	  //____________________________________
	C_REAL:C285(Editor_Get_zoom ;$0)
	
	  //____________________________________
	C_TEXT:C284(Editor_REDRAW ;$1)
	
	  //____________________________________
End if 

If (False:C215)  //PRIVATE
	
	  //____________________________________
	C_TEXT:C284(Editor_ADD_STYLE ;$1)
	C_TEXT:C284(Editor_ADD_STYLE ;$2)
	C_TEXT:C284(Editor_ADD_STYLE ;$3)
	
	  //____________________________________
End if 

If (False:C215)
	
	  //____________________________________
	C_TEXT:C284(Editor_Put_object ;$0)
	C_OBJECT:C1216(Editor_Put_object ;$1)
	
	  //____________________________________
	C_TEXT:C284(Editor_PUT_USER_FORM ;$1)
	
	  //____________________________________
End if 

If (False:C215)  //DRAW
	
	  //rect, ellipse, line, polyline…
	  //____________________________________
	C_BOOLEAN:C305(Editor_COMMON_Stop ;$0)
	C_TEXT:C284(Editor_COMMON_Stop ;$1)
	C_LONGINT:C283(Editor_COMMON_Stop ;$2)
	C_LONGINT:C283(Editor_COMMON_Stop ;$3)
	
	  //____________________________________
	C_TEXT:C284(Editor_COMMON_ON_IDLE ;$1)
	C_LONGINT:C283(Editor_COMMON_ON_IDLE ;$2)
	C_LONGINT:C283(Editor_COMMON_ON_IDLE ;$3)
	
	  //____________________________________
	C_TEXT:C284(Editor_COMMON_BEGIN ;$1)
	C_LONGINT:C283(Editor_COMMON_BEGIN ;$2)
	C_LONGINT:C283(Editor_COMMON_BEGIN ;$3)
	
	  //rect dragger
	  //____________________________________
	C_REAL:C285(Editor_RECT_DRAGGER_BEGIN ;$1)
	C_REAL:C285(Editor_RECT_DRAGGER_BEGIN ;$2)
	
	  //____________________________________
	C_REAL:C285(Editor_RECT_DRAGGER_ON_IDLE ;$1)
	C_REAL:C285(Editor_RECT_DRAGGER_ON_IDLE ;$2)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_RECT_DRAGGER_Stop ;$0)
	C_REAL:C285(Editor_RECT_DRAGGER_Stop ;$1)
	C_REAL:C285(Editor_RECT_DRAGGER_Stop ;$2)
	
	  //text
	  //____________________________________
	C_LONGINT:C283(Editor_TEXT_BEGIN ;$1)
	C_LONGINT:C283(Editor_TEXT_BEGIN ;$2)
	
	  //____________________________________
	C_LONGINT:C283(Editor_TEXT_ON_IDLE ;$1)
	C_LONGINT:C283(Editor_TEXT_ON_IDLE ;$2)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_TEXT_Stop ;$0)
	C_LONGINT:C283(Editor_TEXT_Stop ;$1)
	C_LONGINT:C283(Editor_TEXT_Stop ;$2)
	
	  //____________________________________
End if 

If (False:C215)  //text object
	
	  //____________________________________
	C_OBJECT:C1216(Editor_TEXT_COMPUTE_SIZE ;$1)
	
	  //____________________________________
	C_TEXT:C284(Editor_TEXT_EDIT_SET_VALUE ;$1)
	C_TEXT:C284(Editor_TEXT_EDIT_SET_VALUE ;$2)
	
	  //____________________________________
	C_TEXT:C284(Editor_TEXT_EDIT_START ;$1)
	C_TEXT:C284(Editor_TEXT_EDIT_START ;$2)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_TEXT_EDIT_Stop ;$0)
	
	  //____________________________________
End if 