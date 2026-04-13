//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_MENU_TEXT_STYLE
// Database: 4D Labels
// ID[A571CF2E9BD9464EA498C5F92E84BAB5]
// Created #19-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Text
var $1 : Text
var $2 : Text

var $Lon_parameters : Integer
var $Mnu_parentMenu; $Mnu_sub; $Txt_style : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		$Txt_style:=$1
		
		If ($Lon_parameters>=2)
			
			$Mnu_parentMenu:=$2
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Mnu_sub:=Create menu:C408

APPEND MENU ITEM:C411($Mnu_sub; ":xliff:Menus_textStyleItalic")

If ($Txt_style="@italic@")
	
	SET MENU ITEM MARK:C208($Mnu_sub; -1; Char:C90(18))
	SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "text-style-italic-remove")
	
Else 
	
	SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "text-style-italic")
	
End if 

APPEND MENU ITEM:C411($Mnu_sub; ":xliff:Menus_textStyleBold")

If ($Txt_style="@bold@")
	
	SET MENU ITEM MARK:C208($Mnu_sub; -1; Char:C90(18))
	SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "text-style-bold-remove")
	
Else 
	
	SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "text-style-bold")
	
End if 

APPEND MENU ITEM:C411($Mnu_sub; ":xliff:Menus_textStyleUnderline")

If ($Txt_style="@underline@")
	
	SET MENU ITEM MARK:C208($Mnu_sub; -1; Char:C90(18))
	SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "text-style-underline-remove")
	
Else 
	
	SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "text-style-underline")
	
End if 

If ($Lon_parameters>=2)
	
	APPEND MENU ITEM:C411($Mnu_parentMenu; ":xliff:Menus_textStyle"; $Mnu_sub)
	RELEASE MENU:C978($Mnu_sub)
	
End if 

// ----------------------------------------------------
// Return
$0:=$Mnu_sub

// ----------------------------------------------------
// End