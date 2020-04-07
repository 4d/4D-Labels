//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_MENU_STROKE_WIDTH
  // Database: 4D Labels
  // ID[BA27A7D369E443699225CE6354367B49]
  // Created #5-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_value)
C_TEXT:C284($Mnu_parentMenu;$Mnu_sub)

If (False:C215)
	C_TEXT:C284(Editor_MENU_STROKE_WIDTH ;$0)
	C_LONGINT:C283(Editor_MENU_STROKE_WIDTH ;$1)
	C_TEXT:C284(Editor_MENU_STROKE_WIDTH ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	$Lon_value:=-1
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Lon_value:=$1
		
		If ($Lon_parameters>=2)
			
			$Mnu_parentMenu:=$2
			
		End if 
	End if 
	
	If ($Lon_value=-1)
		
		$Lon_value:=Editor_Get_default_stroke_width 
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_sub:=Create menu:C408

For ($Lon_i;0;9;1)
	
	If ($Lon_i=0)
		
		APPEND MENU ITEM:C411($Mnu_sub;":xliff:Menus_width_0")
		
	Else 
		
		APPEND MENU ITEM:C411($Mnu_sub;Replace string:C233(Get localized string:C991("Menus_width_N");"{n}";String:C10($Lon_i)))
		
	End if 
	
	SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"stroke-width-"+String:C10($Lon_i))
	SET MENU ITEM ICON:C984($Mnu_sub;-1;"file:images/editor/width/stroke-width-"+String:C10($Lon_i)+".svg")
	
	If ($Lon_value=$Lon_i)
		
		SET MENU ITEM MARK:C208($Mnu_sub;-1;Char:C90(18))
		
	End if 
End for 

If ($Lon_parameters>=2)
	
	APPEND MENU ITEM:C411($Mnu_parentMenu;":xliff:Menus_strokeWidth";$Mnu_sub)
	RELEASE MENU:C978($Mnu_sub)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Mnu_sub

  // ----------------------------------------------------
  // End