//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_MENU_TEXT_ALIGNMENT
// Database: 4D Labels
// ID[628E03F828AC4ABD9C2197B564B80097]
// Created #21-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Text
var $1 : Text
var $2 : Text

var $Lon_parameters : Integer
var $Mnu_parentMenu; $Mnu_sub; $Txt_alignment : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		$Txt_alignment:=$1
		
		If ($Lon_parameters>=2)
			
			$Mnu_parentMenu:=$2
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Mnu_sub:=Create menu:C408

APPEND MENU ITEM:C411($Mnu_sub; ":xliff:Menus_alignLeft")
SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "text-align-start")
SET MENU ITEM MARK:C208($Mnu_sub; -1; Char:C90(18)*Num:C11($Txt_alignment="start"))

APPEND MENU ITEM:C411($Mnu_sub; ":xliff:Menus_alignCenter")
SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "text-align-center")
SET MENU ITEM MARK:C208($Mnu_sub; -1; Char:C90(18)*Num:C11($Txt_alignment="center"))

APPEND MENU ITEM:C411($Mnu_sub; ":xliff:Menus_alignRight")
SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "text-align-end")
SET MENU ITEM MARK:C208($Mnu_sub; -1; Char:C90(18)*Num:C11($Txt_alignment="end"))

If ($Lon_parameters>=2)
	
	APPEND MENU ITEM:C411($Mnu_parentMenu; ":xliff:Menus_textAlignment"; $Mnu_sub)
	RELEASE MENU:C978($Mnu_sub)
	
End if 

// ----------------------------------------------------
// Return
$0:=$Mnu_sub

// ----------------------------------------------------
// End