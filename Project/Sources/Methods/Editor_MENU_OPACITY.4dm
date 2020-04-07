//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_MENU_FILL_OPACITY
  // Database: 4D Labels
  // ID[AD533F8A600C4DF5B86A6F9664F32BD9]
  // Created #4-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_REAL:C285($3)

C_LONGINT:C283($Lon_i;$Lon_parameters)
C_REAL:C285($Num_opacity)
C_TEXT:C284($Mnu_parentMenu;$Mnu_sub;$Txt_target)

If (False:C215)
	C_TEXT:C284(Editor_MENU_OPACITY ;$0)
	C_TEXT:C284(Editor_MENU_OPACITY ;$1)
	C_TEXT:C284(Editor_MENU_OPACITY ;$2)
	C_REAL:C285(Editor_MENU_OPACITY ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_target:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Mnu_parentMenu:=$2
		
		If ($Lon_parameters>=3)
			
			$Num_opacity:=$3
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_sub:=Create menu:C408

For ($Lon_i;0;100;10)
	
	APPEND MENU ITEM:C411($Mnu_sub;Replace string:C233(Get localized string:C991("Menus_opacity");"{n}";String:C10($Lon_i)))
	SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;$Txt_target+"-opacity-"+String:C10($Lon_i))
	SET MENU ITEM ICON:C984($Mnu_sub;-1;"file:images/editor/opacity/"+$Txt_target+"-opacity-"+String:C10($Lon_i)+".svg")
	
	Case of 
			
			  //______________________________________________________
		: ($Lon_i=0)\
			 & ($Num_opacity=0)
			
			SET MENU ITEM MARK:C208($Mnu_sub;-1;Char:C90(18))
			
			  //______________________________________________________
		: (($Lon_i/100)=$Num_opacity)
			
			SET MENU ITEM MARK:C208($Mnu_sub;-1;Char:C90(18))
			
			  //______________________________________________________
	End case 
End for 

If ($Lon_parameters>=1)
	
	APPEND MENU ITEM:C411($Mnu_parentMenu;":xliff:Menus_"+$Txt_target+"Opacity";$Mnu_sub)
	RELEASE MENU:C978($Mnu_sub)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Mnu_sub

  // ----------------------------------------------------
  // End