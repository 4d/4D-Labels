//%attributes = {"invisible":true}
If (False:C215)  //actions
	
	  //____________________________________
	C_TEXT:C284(Editor_SEL_ALIGN ;$1)
	C_TEXT:C284(Editor_SEL_ALIGN ;$2)
	
	  //____________________________________
	C_TEXT:C284(Editor_SEL_DISTRIBUTE ;$1)
	C_TEXT:C284(Editor_SEL_DISTRIBUTE ;$2)
	
	  //____________________________________
	C_TEXT:C284(Editor_SEL_DISPLAY_HANDLES ;$1)
	C_TEXT:C284(Editor_SEL_DISPLAY_HANDLES ;$2)
	C_REAL:C285(Editor_SEL_DISPLAY_HANDLES ;$3)
	C_REAL:C285(Editor_SEL_DISPLAY_HANDLES ;$4)
	C_REAL:C285(Editor_SEL_DISPLAY_HANDLES ;$5)
	C_REAL:C285(Editor_SEL_DISPLAY_HANDLES ;$6)
	
	  //____________________________________
	C_TEXT:C284(Editor_SEL_LEVEL ;$1)
	C_TEXT:C284(Editor_SEL_LEVEL ;$2)
	C_TEXT:C284(Editor_SEL_LEVEL ;$3)
	
	  //____________________________________
	C_LONGINT:C283(Editor_SEL_MOVE ;$1)
	C_LONGINT:C283(Editor_SEL_MOVE ;$2)
	
	  //____________________________________
	C_TEXT:C284(editor_SEL_REVEAL ;$1)
	
	  //____________________________________
End if 

If (False:C215)
	
	  //____________________________________
	C_OBJECT:C1216(Editor_SEL_INVENTORY ;$0)
	C_TEXT:C284(Editor_SEL_INVENTORY ;$1)
	
	  //____________________________________
	C_TEXT:C284(Editor_SELECT_HANDLE ;$1)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_SELECT ;$0)
	C_TEXT:C284(Editor_SELECT ;$1)
	C_TEXT:C284(Editor_SELECT ;$2)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_SELECT_Add ;$0)
	C_TEXT:C284(Editor_SELECT_Add ;$1)
	C_BOOLEAN:C305(Editor_SELECT_Add ;$2)
	
	  //____________________________________
	C_TEXT:C284(Editor_SELECT_APPEND ;$1)
	C_TEXT:C284(Editor_SELECT_APPEND ;$2)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_SELECT_Clear ;$0)
	C_TEXT:C284(Editor_SELECT_Clear ;$1)
	C_TEXT:C284(Editor_SELECT_Clear ;$2)
	
	  //____________________________________
	C_TEXT:C284(Editor_SELECT_Get_id ;$0)
	C_TEXT:C284(Editor_SELECT_Get_id ;$1)
	C_LONGINT:C283(Editor_SELECT_Get_id ;$2)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_SELECT_PASTE ;$1)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_SELECT_Find ;$0)
	C_TEXT:C284(Editor_SELECT_Find ;$1)
	C_TEXT:C284(Editor_SELECT_Find ;$2)
	
	  //____________________________________
	C_TEXT:C284(Editor_SELECT_Get_dragger ;$0)
	C_BOOLEAN:C305(Editor_SELECT_Get_dragger ;$1)
	
	  //____________________________________
	C_TEXT:C284(Editor_SELECT_GET_LIST ;$1)
	C_POINTER:C301(Editor_SELECT_GET_LIST ;$2)
	C_BOOLEAN:C305(Editor_SELECT_GET_LIST ;$3)
	
	  //____________________________________
	C_TEXT:C284(editor_SELECT_HIDE ;$1)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_SELECT_Move ;$0)
	C_TEXT:C284(Editor_SELECT_Move ;$1)
	C_REAL:C285(Editor_SELECT_Move ;$2)
	C_REAL:C285(Editor_SELECT_Move ;$3)
	C_BOOLEAN:C305(Editor_SELECT_Move ;$4)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_SELECT_OBJECT ;$0)
	C_TEXT:C284(Editor_SELECT_OBJECT ;$1)
	C_TEXT:C284(Editor_SELECT_OBJECT ;$2)
	C_BOOLEAN:C305(Editor_SELECT_OBJECT ;$3)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_SELECT_Objects ;$0)
	C_REAL:C285(Editor_SELECT_Objects ;$1)
	C_REAL:C285(Editor_SELECT_Objects ;$2)
	C_REAL:C285(Editor_SELECT_Objects ;$3)
	C_REAL:C285(Editor_SELECT_Objects ;$4)
	
	  //____________________________________
	C_BOOLEAN:C305(Editor_SELECT_Resize ;$0)
	C_TEXT:C284(Editor_SELECT_Resize ;$1)
	C_REAL:C285(Editor_SELECT_Resize ;$2)
	C_REAL:C285(Editor_SELECT_Resize ;$3)
	C_BOOLEAN:C305(Editor_SELECT_Resize ;$4)
	
	  //____________________________________
	C_TEXT:C284(Editor_SELECT_SET ;$1)
	
	  //____________________________________
	C_TEXT:C284(Editor_SELECT_UPDATE_ID ;$1)
	C_TEXT:C284(Editor_SELECT_UPDATE_ID ;$2)
	
	  //____________________________________
End if 

If (False:C215)  //getter
	
	  //____________________________________
	C_TEXT:C284(Editor_SEL_Get_aspect_ratio ;$0)
	C_TEXT:C284(Editor_SEL_Get_aspect_ratio ;$1)
	
	  //____________________________________
	C_LONGINT:C283(Editor_SEL_Get_color ;$0)
	C_TEXT:C284(Editor_SEL_Get_color ;$1)
	C_TEXT:C284(Editor_SEL_Get_color ;$2)
	
	  //____________________________________
	C_LONGINT:C283(Editor_SEL_Get_count ;$0)
	C_TEXT:C284(Editor_SEL_Get_count ;$1)
	C_POINTER:C301(Editor_SEL_Get_count ;$2)
	
	  //____________________________________
	C_TEXT:C284(Editor_SEL_Get_font ;$0)
	C_TEXT:C284(Editor_SEL_Get_font ;$1)
	C_POINTER:C301(Editor_SEL_Get_font ;$2)
	
	  //____________________________________
	C_LONGINT:C283(Editor_SEL_Get_font_color ;$0)
	C_TEXT:C284(Editor_SEL_Get_font_color ;$1)
	
	  //____________________________________
	C_LONGINT:C283(Editor_SEL_Get_font_size ;$0)
	C_TEXT:C284(Editor_SEL_Get_font_size ;$1)
	
	  //____________________________________
	C_REAL:C285(Editor_SEL_Get_opacity ;$0)
	C_TEXT:C284(Editor_SEL_Get_opacity ;$1)
	C_TEXT:C284(Editor_SEL_Get_opacity ;$2)
	
	  //____________________________________
	C_LONGINT:C283(Editor_SEL_Get_stroke_width ;$0)
	C_TEXT:C284(Editor_SEL_Get_stroke_width ;$1)
	
	  //____________________________________
	C_TEXT:C284(Editor_SEL_Get_text_align ;$0)
	C_TEXT:C284(Editor_SEL_Get_text_align ;$1)
	
	  //____________________________________
	C_TEXT:C284(Editor_SEL_Get_text_style ;$0)
	C_TEXT:C284(Editor_SEL_Get_text_style ;$1)
	
	  //____________________________________
End if 

If (False:C215)  //setter
	
	  //____________________________________
	C_TEXT:C284(Editor_SEL_SET_ASPECT_RATIO ;$1)
	C_TEXT:C284(Editor_SEL_SET_ASPECT_RATIO ;$2)
	C_TEXT:C284(Editor_SEL_SET_ASPECT_RATIO ;$3)
	
	  //____________________________________
	C_TEXT:C284(Editor_SEL_SET_COLOR ;$1)
	C_LONGINT:C283(Editor_SEL_SET_COLOR ;$2)
	C_TEXT:C284(Editor_SEL_SET_COLOR ;$3)
	C_TEXT:C284(Editor_SEL_SET_COLOR ;$4)
	
	  //____________________________________
	C_TEXT:C284(Editor_SEL_SET_FONT ;$1)
	C_TEXT:C284(Editor_SEL_SET_FONT ;$2)
	C_TEXT:C284(Editor_SEL_SET_FONT ;$3)
	
	  //____________________________________
	C_LONGINT:C283(Editor_SEL_SET_FONT_SIZE ;$1)
	C_TEXT:C284(Editor_SEL_SET_FONT_SIZE ;$2)
	C_TEXT:C284(Editor_SEL_SET_FONT_SIZE ;$3)
	
	  //____________________________________
	C_TEXT:C284(Editor_SEL_SET_OPACITY ;$1)
	C_LONGINT:C283(Editor_SEL_SET_OPACITY ;$2)
	C_TEXT:C284(Editor_SEL_SET_OPACITY ;$3)
	C_TEXT:C284(Editor_SEL_SET_OPACITY ;$4)
	
	  //____________________________________
	C_TEXT:C284(Editor_SEL_SET_RECT ;$1)
	C_TEXT:C284(Editor_SEL_SET_RECT ;$2)
	C_TEXT:C284(Editor_SEL_SET_RECT ;$3)
	
	  //____________________________________
	C_LONGINT:C283(Editor_SEL_SET_STROKE_WIDTH ;$1)
	C_TEXT:C284(Editor_SEL_SET_STROKE_WIDTH ;$2)
	C_TEXT:C284(Editor_SEL_SET_STROKE_WIDTH ;$3)
	
	  //____________________________________
	C_TEXT:C284(Editor_SEL_SET_TEXT_ALIGNMENT ;$1)
	C_TEXT:C284(Editor_SEL_SET_TEXT_ALIGNMENT ;$2)
	C_TEXT:C284(Editor_SEL_SET_TEXT_ALIGNMENT ;$3)
	
	  //____________________________________
	C_LONGINT:C283(Editor_SEL_SET_TEXT_COLOR ;$1)
	C_TEXT:C284(Editor_SEL_SET_TEXT_COLOR ;$2)
	C_TEXT:C284(Editor_SEL_SET_TEXT_COLOR ;$3)
	
	  //____________________________________
	C_TEXT:C284(Editor_SEL_SET_TEXT_STYLE ;$1)
	C_TEXT:C284(Editor_SEL_SET_TEXT_STYLE ;$2)
	C_TEXT:C284(Editor_SEL_SET_TEXT_STYLE ;$3)
	
	  //____________________________________
End if 