//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_MENU_ALIGN
  // Database: 4D Labels
  // ID[DBD90966792240C0BCA257CC07DE2F6E]
  // Created #20-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($Boo_distribute)
C_LONGINT:C283($Lon_parameters;$Lon_selCount)
C_TEXT:C284($Mnu_parentMenu;$Mnu_sub)

If (False:C215)
	C_TEXT:C284(Editor_MENU_ALIGN ;$0)
	C_TEXT:C284(Editor_MENU_ALIGN ;$1)
	C_LONGINT:C283(Editor_MENU_ALIGN ;$2)
	C_BOOLEAN:C305(Editor_MENU_ALIGN ;$3)
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
			
			$Lon_selCount:=$2
			
			$Boo_distribute:=($Lon_selCount>2)
			
			If ($Lon_parameters>=3)
				
				$Boo_distribute:=$3  //force distribution items
				
			End if 
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_sub:=Create menu:C408

APPEND MENU ITEM:C411($Mnu_sub;":xliff:Menus_objectalignleft")
SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"align-left")
SET MENU ITEM ICON:C984($Mnu_sub;-1;"file:images/editor/align/align-left.png")

If ($Lon_selCount<2)
	
	DISABLE MENU ITEM:C150($Mnu_sub;-1)
	
End if 

APPEND MENU ITEM:C411($Mnu_sub;":xliff:Menus_objectalignright")
SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"align-right")
SET MENU ITEM ICON:C984($Mnu_sub;-1;"file:images/editor/align/align-right.png")

If ($Lon_selCount<2)
	
	DISABLE MENU ITEM:C150($Mnu_sub;-1)
	
End if 

APPEND MENU ITEM:C411($Mnu_sub;":xliff:Menus_objectaligntop")
SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"align-top")
SET MENU ITEM ICON:C984($Mnu_sub;-1;"file:images/editor/align/align-top.png")

If ($Lon_selCount<2)
	
	DISABLE MENU ITEM:C150($Mnu_sub;-1)
	
End if 

APPEND MENU ITEM:C411($Mnu_sub;":xliff:Menus_objectalignbottom")
SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"align-bottom")
SET MENU ITEM ICON:C984($Mnu_sub;-1;"file:images/editor/align/align-bottom.png")

If ($Lon_selCount<2)
	
	DISABLE MENU ITEM:C150($Mnu_sub;-1)
	
End if 

APPEND MENU ITEM:C411($Mnu_sub;"-")

APPEND MENU ITEM:C411($Mnu_sub;":xliff:Menus_objectalignhorizontal")
SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"align-horizontal")
SET MENU ITEM ICON:C984($Mnu_sub;-1;"file:images/editor/align/align-horizontal.png")

If ($Lon_selCount<2)
	
	DISABLE MENU ITEM:C150($Mnu_sub;-1)
	
End if 

APPEND MENU ITEM:C411($Mnu_sub;":xliff:Menus_objectalignvertical")
SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"align-vertical")
SET MENU ITEM ICON:C984($Mnu_sub;-1;"file:images/editor/align/align-vertical.png")

If ($Lon_selCount<2)
	
	DISABLE MENU ITEM:C150($Mnu_sub;-1)
	
End if 

If ($Boo_distribute)
	
	APPEND MENU ITEM:C411($Mnu_sub;"-")
	
	APPEND MENU ITEM:C411($Mnu_sub;":xliff:Menus_distributehorizontal")
	SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"distribute-horizontal")
	SET MENU ITEM ICON:C984($Mnu_sub;-1;"file:images/editor/align/distribute-horizontal.png")
	
	If ($Lon_selCount<3)
		
		DISABLE MENU ITEM:C150($Mnu_sub;-1)
		
	End if 
	
	APPEND MENU ITEM:C411($Mnu_sub;":xliff:Menus_distributevertical")
	SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"distribute-vertical")
	SET MENU ITEM ICON:C984($Mnu_sub;-1;"file:images/editor/align/distribute-vertical.png")
	
	If ($Lon_selCount<3)
		
		DISABLE MENU ITEM:C150($Mnu_sub;-1)
		
	End if 
End if 

If ($Lon_parameters>=1)
	
	APPEND MENU ITEM:C411($Mnu_parentMenu;":xliff:"+Choose:C955($Lon_selCount<3;"Menus_align";"Menus_align_and_distribute");$Mnu_sub)
	RELEASE MENU:C978($Mnu_sub)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Mnu_sub

  // ----------------------------------------------------
  // End