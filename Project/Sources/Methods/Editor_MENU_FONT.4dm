//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_MENU_FONT
  // Database: 4D Labels
  // ID[1833464799F241CC90EABAD40BCF2C61]
  // Created #18-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_x)
C_TEXT:C284($Mnu_parentMenu;$Mnu_sub;$Txt_font)

ARRAY TEXT:C222($tTxt_buffer;0)
ARRAY TEXT:C222($tTxt_fonts;0)

If (False:C215)
	C_TEXT:C284(Editor_MENU_FONT ;$0)
	C_TEXT:C284(Editor_MENU_FONT ;$1)
	C_TEXT:C284(Editor_MENU_FONT ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Txt_font:=$1
		
		If ($Lon_parameters>=2)
			
			$Mnu_parentMenu:=$2
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_sub:=Create menu:C408

FONT LIST:C460($tTxt_fonts;Favorite fonts:K80:2)
FONT LIST:C460($tTxt_buffer;Recent fonts:K80:3)

For ($Lon_i;1;Size of array:C274($tTxt_buffer);1)
	
	If (Find in array:C230($tTxt_fonts;$tTxt_buffer{$Lon_i})=-1)
		
		APPEND TO ARRAY:C911($tTxt_fonts;$tTxt_buffer{$Lon_i})
		
	End if 
End for 

  //append current font if any
If ($Txt_font#"-")  //not mixed
	
	If (Find in array:C230($tTxt_fonts;$Txt_font)=-1)
		
		APPEND TO ARRAY:C911($tTxt_fonts;$Txt_font)
		
	End if 
End if 

SORT ARRAY:C229($tTxt_fonts)

  //manage system font
$Lon_x:=Find in array:C230($tTxt_fonts;OBJECT Get font:C1069(*;"AutoFont"))

If ($Lon_x>0)
	
	DELETE FROM ARRAY:C228($tTxt_fonts;$Lon_x;1)
	INSERT IN ARRAY:C227($tTxt_fonts;1;2)
	$tTxt_fonts{1}:=Get localized string:C991("Menus_systemFont")
	$tTxt_fonts{2}:="-"
	
End if 

For ($Lon_i;1;Size of array:C274($tTxt_fonts);1)
	
	APPEND MENU ITEM:C411($Mnu_sub;$tTxt_fonts{$Lon_i})
	SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"font-"+$tTxt_fonts{$Lon_i})
	
	If ($tTxt_fonts{$Lon_i}=$Txt_font)
		
		SET MENU ITEM MARK:C208($Mnu_sub;-1;Char:C90(18))
		
	End if 
End for 

If (Count menu items:C405($Mnu_sub)>0)
	
	APPEND MENU ITEM:C411($Mnu_sub;"-")
	
End if 

If ($Lon_parameters>=2)
	
	APPEND MENU ITEM:C411($Mnu_parentMenu;":xliff:Menus_font";$Mnu_sub)
	RELEASE MENU:C978($Mnu_sub)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Mnu_sub

  // ----------------------------------------------------
  // End