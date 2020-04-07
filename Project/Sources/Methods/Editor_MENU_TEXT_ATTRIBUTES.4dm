//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_MENU_TEXT_ATTRIBUTES
  // Database: 4D Labels
  // ID[7154B6E74B8848B8A7F1231D5AB6D8A0]
  // Created #20-8-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_BOOLEAN:C305($4)

C_BOOLEAN:C305($Boo_disabled)
C_LONGINT:C283($Lon_fontSize;$Lon_parameters;$Lon_styles)
C_TEXT:C284($Dom_canvas;$Dom_label;$Mnu_buffer;$Mnu_pop;$Txt_font;$Txt_style)

If (False:C215)
	C_TEXT:C284(Editor_MENU_TEXT_ATTRIBUTES ;$1)
	C_TEXT:C284(Editor_MENU_TEXT_ATTRIBUTES ;$2)
	C_TEXT:C284(Editor_MENU_TEXT_ATTRIBUTES ;$3)
	C_BOOLEAN:C305(Editor_MENU_TEXT_ATTRIBUTES ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Mnu_pop:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		$Dom_label:=$2
		$Dom_canvas:=$3
		
		If ($Lon_parameters>=4)
			
			$Boo_disabled:=$4
			
		End if 
		
	Else 
		
		Editor_Get_grips (->$Dom_label;->$Dom_canvas)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Txt_font:=Editor_SEL_Get_font ($Dom_label)
$Mnu_buffer:=Editor_MENU_FONT ($Txt_font;$Mnu_pop)

If ($Boo_disabled)
	
	DISABLE MENU ITEM:C150($Mnu_pop;-1)
	
End if 

APPEND MENU ITEM:C411($Mnu_buffer;"-")

APPEND MENU ITEM:C411($Mnu_buffer;":xliff:Menus_showFonts")
SET MENU ITEM PARAMETER:C1004($Mnu_buffer;-1;"font-picker")

$Lon_fontSize:=Editor_SEL_Get_font_size ($Dom_label)
$Mnu_buffer:=Editor_MENU_FONT_SIZE ($Lon_fontSize;$Mnu_pop)

If ($Boo_disabled)
	
	DISABLE MENU ITEM:C150($Mnu_pop;-1)
	
End if 

APPEND MENU ITEM:C411($Mnu_pop;"-")

$Txt_style:=Editor_SEL_Get_text_style ($Dom_label;$Dom_canvas)
$Mnu_buffer:=Editor_MENU_TEXT_STYLE ($Txt_style;$Mnu_pop)

If ($Boo_disabled)
	
	DISABLE MENU ITEM:C150($Mnu_pop;-1)
	
End if 

$Mnu_buffer:=mnu_Color (Editor_SEL_Get_font_color ($Dom_label);"font")
APPEND MENU ITEM:C411($Mnu_pop;Get localized string:C991("Menus_fontColor");$Mnu_buffer)
RELEASE MENU:C978($Mnu_buffer)

If ($Boo_disabled)
	
	SET MENU ITEM MARK:C208($Mnu_buffer;-1;"")
	DISABLE MENU ITEM:C150($Mnu_pop;-1)
	
End if 

$Mnu_buffer:=Editor_MENU_TEXT_ALIGNMENT (Editor_SEL_Get_text_align ($Dom_label);$Mnu_pop)

If ($Boo_disabled)
	
	DISABLE MENU ITEM:C150($Mnu_pop;-1)
	
End if 

  //update picker
$Lon_styles:=(Bold:K14:2*Num:C11($Txt_style="@bold@"))+(Italic:K14:3*Num:C11($Txt_style="@italic@"))+(Underline:K14:4*Num:C11($Txt_style="@underline@"))

OBJECT SET FONT:C164(*;"picker";$Txt_font)
OBJECT SET FONT SIZE:C165(*;"picker";$Lon_fontSize)
OBJECT SET FONT STYLE:C166(*;"picker";$Lon_styles)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End