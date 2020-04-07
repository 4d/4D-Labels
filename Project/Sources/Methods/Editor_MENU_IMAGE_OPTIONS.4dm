//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_MENU_IMAGE_OPTIONS
  // Database: 4D Labels
  // ID[D3D6E13AACC64978B0B64C5CEAE6322F]
  // Created #20-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Mnu_parentMenu;$Mnu_sub;$Txt_preserveAspectRatio)

If (False:C215)
	C_TEXT:C284(Editor_MENU_IMAGE_OPTIONS ;$0)
	C_TEXT:C284(Editor_MENU_IMAGE_OPTIONS ;$1)
	C_TEXT:C284(Editor_MENU_IMAGE_OPTIONS ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Txt_preserveAspectRatio:=$1
		
		If ($Lon_parameters>=2)
			
			$Mnu_parentMenu:=$2
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_sub:=Create menu:C408

APPEND MENU ITEM:C411($Mnu_sub;":xliff:Menus_scaledToFitPropCentered")
SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"image-preserve-aspect-ratio"+Choose:C955($Txt_preserveAspectRatio="true";"-remove";""))
SET MENU ITEM MARK:C208($Mnu_sub;-1;Char:C90(18)*Num:C11($Txt_preserveAspectRatio="true"))

If ($Lon_parameters>=2)
	
	APPEND MENU ITEM:C411($Mnu_parentMenu;":xliff:Menus_image";$Mnu_sub)
	RELEASE MENU:C978($Mnu_sub)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Mnu_sub

  // ----------------------------------------------------
  // End