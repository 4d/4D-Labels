//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SET_TOOL
  // Database: 4D Labels
  // ID[C522AB52D1C2405CADC32BBD079109F9]
  // Created #6-1-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_x)
C_TEXT:C284($Txt_tool)

If (False:C215)
	C_TEXT:C284(Editor_SET_TOOL ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	$Txt_tool:="select"
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Txt_tool:=$1  //the select tool, if omitted
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //keep the current selected tool
OB SET:C1220((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;\
"tool";$Txt_tool)

If ($Txt_tool="@rect")
	
	OB SET:C1220((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;\
		"rect-tool";$Txt_tool)
	
	OBJECT SET FORMAT:C236(*;"tool.5";";#images/editor/tools/"+$Txt_tool+".png")
	
End if 

$Txt_tool:=Choose:C955($Txt_tool="round-rect";"rect";$Txt_tool)

  //update UI
ARRAY TEXT:C222($tTxt_tools;6)
$tTxt_tools{1}:="select"
$tTxt_tools{2}:="polyline"  //hidden
$tTxt_tools{3}:="text"
$tTxt_tools{4}:="line"
$tTxt_tools{5}:="rect"
$tTxt_tools{6}:="ellipse"

$Lon_x:=Abs:C99(Find in array:C230($tTxt_tools;$Txt_tool))

For ($Lon_i;1;6;1)
	
	(OBJECT Get pointer:C1124(Object named:K67:5;"tool."+String:C10($Lon_i)))->:=Num:C11($Lon_i=$Lon_x)
	
End for 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End