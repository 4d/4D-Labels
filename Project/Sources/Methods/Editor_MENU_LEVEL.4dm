//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_MENU_LEVEL
  // Database: 4D Labels
  // ID[C48852C40DBD4BFE8D59FA7C188A84F6]
  // Created #4-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($Lon_objectCount;$Lon_parameters;$Lon_selCount)
C_TEXT:C284($Mnu_parentMenu;$Mnu_sub)

If (False:C215)
	C_TEXT:C284(Editor_MENU_LEVEL ;$0)
	C_TEXT:C284(Editor_MENU_LEVEL ;$1)
	C_LONGINT:C283(Editor_MENU_LEVEL ;$2)
	C_LONGINT:C283(Editor_MENU_LEVEL ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Mnu_parentMenu:=$1
		
		If ($Lon_parameters>=2)
			
			$Lon_objectCount:=$2
			
			If ($Lon_parameters>=3)
				
				$Lon_selCount:=$3
				
			End if 
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_sub:=Create menu:C408

APPEND MENU ITEM:C411($Mnu_sub;":xliff:Menus_movefrontmost")
SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"level-front")
SET MENU ITEM ICON:C984($Mnu_sub;-1;"file:images/editor/level/move-front-most.png")

If ($Lon_objectCount<2)\
 | ($Lon_objectCount=$Lon_selCount)
	
	DISABLE MENU ITEM:C150($Mnu_sub;-1)
	
End if 

APPEND MENU ITEM:C411($Mnu_sub;":xliff:Menus_moveToBackmost")
SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"level-back")
SET MENU ITEM ICON:C984($Mnu_sub;-1;"file:images/editor/level/move-back-most.png")

If ($Lon_objectCount<2)\
 | ($Lon_objectCount=$Lon_selCount)
	
	DISABLE MENU ITEM:C150($Mnu_sub;-1)
	
End if 

APPEND MENU ITEM:C411($Mnu_sub;":xliff:Menus_moveInFront")
SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"level-up")
SET MENU ITEM ICON:C984($Mnu_sub;-1;"file:images/editor/level/move-front.png")

If ($Lon_objectCount<2)\
 | ($Lon_objectCount=$Lon_selCount)
	
	DISABLE MENU ITEM:C150($Mnu_sub;-1)
	
End if 

APPEND MENU ITEM:C411($Mnu_sub;":xliff:Menus_moveBehind")
SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"level-down")
SET MENU ITEM ICON:C984($Mnu_sub;-1;"file:images/editor/level/move-back.png")

If ($Lon_objectCount<2)\
 | ($Lon_objectCount=$Lon_selCount)
	
	DISABLE MENU ITEM:C150($Mnu_sub;-1)
	
End if 

  // ----------------------------------------------------

If ($Lon_parameters>=1)
	
	APPEND MENU ITEM:C411($Mnu_parentMenu;":xliff:Menus_level";$Mnu_sub)
	RELEASE MENU:C978($Mnu_sub)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Mnu_sub

  // ----------------------------------------------------
  // End