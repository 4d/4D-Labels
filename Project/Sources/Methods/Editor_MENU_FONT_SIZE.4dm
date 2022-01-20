//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_MENU_FONT_SIZE
// Database: 4D Labels
// ID[F95978D86FD44355A20A54F4B9344B7A]
// Created #19-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Text
var $1 : Integer
var $2 : Text

If (False:C215)
	C_TEXT:C284(Editor_MENU_FONT_SIZE; $0)
	C_LONGINT:C283(Editor_MENU_FONT_SIZE; $1)
	C_TEXT:C284(Editor_MENU_FONT_SIZE; $2)
End if 

var $fontSizeMenu; $parentMenu : Text
var $fontSize; $i : Integer

// ----------------------------------------------------
// Initialisations

// NO PARAMETERS REQUIRED

// Optional parameters
If (Count parameters:C259>=1)
	
	$fontSize:=$1
	
	If (Count parameters:C259>=2)
		
		$parentMenu:=$2
		
	End if 
End if 

// ----------------------------------------------------
$fontSizeMenu:=Create menu:C408

For ($i; 6; 36; 1)
	
	Case of 
			
			//______________________________________________________
		: ($i<=14)
			
			APPEND MENU ITEM:C411($fontSizeMenu; String:C10($i))
			SET MENU ITEM PARAMETER:C1004($fontSizeMenu; -1; "font-size-"+String:C10($i))
			SET MENU ITEM MARK:C208($fontSizeMenu; -1; Char:C90(18)*Num:C11($fontSize=$i))
			
			//______________________________________________________
		: ($i<=24)  // Only pair values
			
			If (($i%2)=0)
				
				APPEND MENU ITEM:C411($fontSizeMenu; String:C10($i))
				SET MENU ITEM PARAMETER:C1004($fontSizeMenu; -1; "font-size-"+String:C10($i))
				SET MENU ITEM MARK:C208($fontSizeMenu; -1; Char:C90(18)*Num:C11($fontSize=$i))
				
			End if 
			
			//______________________________________________________
			// Note: font size 25 to 35 are not displayed
			//______________________________________________________
			
			//______________________________________________________
		: ($i=36)
			
			APPEND MENU ITEM:C411($fontSizeMenu; String:C10($i))
			SET MENU ITEM PARAMETER:C1004($fontSizeMenu; -1; "font-size-"+String:C10($i))
			SET MENU ITEM MARK:C208($fontSizeMenu; -1; Char:C90(18)*Num:C11($fontSize=$i))
			
			//______________________________________________________
	End case 
End for 

If (Count parameters:C259>=2)
	
	APPEND MENU ITEM:C411($parentMenu; ":xliff:Menus_fontSize"; $fontSizeMenu)
	RELEASE MENU:C978($fontSizeMenu)
	
End if 

// ----------------------------------------------------
// Return
$0:=$fontSizeMenu

// ----------------------------------------------------
// End