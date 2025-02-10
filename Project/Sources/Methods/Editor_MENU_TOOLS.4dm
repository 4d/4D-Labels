//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_MENU_TOOLS
// Database: 4D Labels
// ID[6C9BBF06602A45D293498B557B083029]
// Created #22-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($menu : Text) : Text

//C_TEXT($0)
//C_TEXT($1)

C_LONGINT:C283($count_parameters)
C_TEXT:C284($Mnu_main; $Mnu_tools; $Txt_tool)

//If (False)
//C_TEXT(Editor_MENU_TOOLS; $0)
//C_TEXT(Editor_MENU_TOOLS; $1)
//End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($count_parameters>=1)
		
		$Mnu_main:=$1
		
	End if 
	
	$Txt_tool:=Editor_Get_current_tool
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Mnu_tools:=Create menu:C408

APPEND MENU ITEM:C411($Mnu_tools; ":xliff:Menus_toolSelect")
SET MENU ITEM ICON:C984($Mnu_tools; -1; "file:images/editor/tools/m_select.png")
SET MENU ITEM PARAMETER:C1004($Mnu_tools; -1; "tool-select")
SET MENU ITEM MARK:C208($Mnu_tools; -1; Char:C90(18)*Num:C11($Txt_tool="select"))

APPEND MENU ITEM:C411($Mnu_tools; ":xliff:Menus_toolLine")
SET MENU ITEM ICON:C984($Mnu_tools; -1; "file:images/editor/tools/m_line.png")
SET MENU ITEM PARAMETER:C1004($Mnu_tools; -1; "tool-line")
SET MENU ITEM MARK:C208($Mnu_tools; -1; Char:C90(18)*Num:C11($Txt_tool="line"))

APPEND MENU ITEM:C411($Mnu_tools; ":xliff:Menus_toolRectangle")
SET MENU ITEM ICON:C984($Mnu_tools; -1; "file:images/editor/tools/m_rect.png")
SET MENU ITEM PARAMETER:C1004($Mnu_tools; -1; "tool-rect")
SET MENU ITEM MARK:C208($Mnu_tools; -1; Char:C90(18)*Num:C11($Txt_tool="rect"))

APPEND MENU ITEM:C411($Mnu_tools; ":xliff:Menus_toolOval")
SET MENU ITEM ICON:C984($Mnu_tools; -1; "file:images/editor/tools/m_circle.png")
SET MENU ITEM PARAMETER:C1004($Mnu_tools; -1; "tool-ellipse")
SET MENU ITEM MARK:C208($Mnu_tools; -1; Char:C90(18)*Num:C11($Txt_tool="ellipse"))

APPEND MENU ITEM:C411($Mnu_tools; ":xliff:Menus_toolText")
SET MENU ITEM ICON:C984($Mnu_tools; -1; "file:images/editor/tools/m_text.png")
SET MENU ITEM PARAMETER:C1004($Mnu_tools; -1; "tool-text")
SET MENU ITEM MARK:C208($Mnu_tools; -1; Char:C90(18)*Num:C11($Txt_tool="text"))


//mark:- feature #11777

APPEND MENU ITEM:C411($Mnu_tools; ":xliff:Menus_toolFormula")
SET MENU ITEM ICON:C984($Mnu_tools; -1; "file:images/editor/tools/m_text.png")
SET MENU ITEM PARAMETER:C1004($Mnu_tools; -1; "tool-variable")
SET MENU ITEM MARK:C208($Mnu_tools; -1; Char:C90(18)*Num:C11($Txt_tool="variable"))

If (<>Boo_debug)
	
	APPEND MENU ITEM:C411($Mnu_tools; ":xliff:Menus_toolPolyline")
	SET MENU ITEM ICON:C984($Mnu_tools; -1; "file:images/editor/tools/m_polyline.png")
	SET MENU ITEM PARAMETER:C1004($Mnu_tools; -1; "tool-polyline")
	SET MENU ITEM MARK:C208($Mnu_tools; -1; Char:C90(18)*Num:C11($Txt_tool="polyline"))
	
End if 

If ($count_parameters>=1)
	
	APPEND MENU ITEM:C411($Mnu_main; ":xliff:Menus_tool"; $Mnu_tools)
	RELEASE MENU:C978($Mnu_tools)
	
End if 

// ----------------------------------------------------
// Return
return $Mnu_tools

// ----------------------------------------------------
// End