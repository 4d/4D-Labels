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
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_fontSize;$Lon_i;$Lon_parameters)
C_TEXT:C284($Mnu_parentMenu;$Mnu_sub)

If (False:C215)
	C_TEXT:C284(Editor_MENU_FONT_SIZE ;$0)
	C_LONGINT:C283(Editor_MENU_FONT_SIZE ;$1)
	C_TEXT:C284(Editor_MENU_FONT_SIZE ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Lon_fontSize:=$1
		
		If ($Lon_parameters>=2)
			
			$Mnu_parentMenu:=$2
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_sub:=Create menu:C408

For ($Lon_i;9;36;1)
	
	Case of 
			
			  //______________________________________________________
		: ($Lon_i<=14)
			
			APPEND MENU ITEM:C411($Mnu_sub;String:C10($Lon_i))
			SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"font-size-"+String:C10($Lon_i))
			SET MENU ITEM MARK:C208($Mnu_sub;-1;Char:C90(18)*Num:C11($Lon_fontSize=$Lon_i))
			
			  //______________________________________________________
		: ($Lon_i<=24)\
			 & (($Lon_i%2)=0)
			
			APPEND MENU ITEM:C411($Mnu_sub;String:C10($Lon_i))
			SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"font-size-"+String:C10($Lon_i))
			SET MENU ITEM MARK:C208($Mnu_sub;-1;Char:C90(18)*Num:C11($Lon_fontSize=$Lon_i))
			
			  //______________________________________________________
		: ($Lon_i=36)
			
			APPEND MENU ITEM:C411($Mnu_sub;String:C10($Lon_i))
			SET MENU ITEM PARAMETER:C1004($Mnu_sub;-1;"font-size-"+String:C10($Lon_i))
			SET MENU ITEM MARK:C208($Mnu_sub;-1;Char:C90(18)*Num:C11($Lon_fontSize=$Lon_i))
			
			  //______________________________________________________
	End case 
End for 

If ($Lon_parameters>=2)
	
	APPEND MENU ITEM:C411($Mnu_parentMenu;":xliff:Menus_fontSize";$Mnu_sub)
	RELEASE MENU:C978($Mnu_sub)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Mnu_sub

  // ----------------------------------------------------
  // End