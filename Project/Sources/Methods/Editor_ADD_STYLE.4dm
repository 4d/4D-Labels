//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_ADD_STYLE
  // Database: 4D Labels
  // ID[59D3584D4C4849B4A73DA22A22548D6E]
  // Created #9-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Dom_canvas;$Dom_defs;$Dom_style;$Txt_class;$Txt_style)

If (False:C215)
	C_TEXT:C284(Editor_ADD_STYLE ;$1)
	C_TEXT:C284(Editor_ADD_STYLE ;$2)
	C_TEXT:C284(Editor_ADD_STYLE ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Dom_canvas:=$1
	$Txt_class:=$2
	$Txt_style:=$3
	
	If (Position:C15(".";$Txt_style)#1)
		
		$Txt_style:="."+$Txt_class+" {"+$Txt_style+"}"
		
	End if 
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Dom_defs:=DOM Find XML element by ID:C1010($Dom_canvas;"defs")

$Dom_style:=DOM Create XML element:C865($Dom_defs;"style";\
"type";"text/css";\
"id";$Txt_class)

DOM SET XML ELEMENT VALUE:C868($Dom_style;$Txt_style;*)  //CDATA

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End