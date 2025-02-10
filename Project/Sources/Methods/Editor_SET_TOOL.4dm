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

#DECLARE($tool : Text)


var $i; $count_parameters; $index : Integer


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	
	$tool:=($tool="") ? "select" : $tool
	
	////Optional parameters
	//If ($count_parameters>=1)
	
	
	//Else 
	
	//End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
//keep the current selected tool
OB SET:C1220((OBJECT Get pointer:C1124(Object named:K67:5; "object"))->; \
"tool"; $tool)

If ($tool="@rect")
	
	OB SET:C1220((OBJECT Get pointer:C1124(Object named:K67:5; "object"))->; \
		"rect-tool"; $tool)
	
	OBJECT SET FORMAT:C236(*; "tool.5"; ";#images/editor/tools/"+$tool+".png")
	
End if 

$tool:=Choose:C955($tool="round-rect"; "rect"; $tool)

//update UI
ARRAY TEXT:C222($_tools; 7)  // feature #11777 6->7
$_tools{1}:="select"
$_tools{2}:="polyline"  //hidden
$_tools{3}:="text"
$_tools{4}:="line"
$_tools{5}:="rect"
$_tools{6}:="ellipse"

//mark:- feature #11777
$_tools{7}:="formula"

$index:=Abs:C99(Find in array:C230($_tools; $tool))

For ($i; 1; Size of array:C274($_tools); 1)
	
	(OBJECT Get pointer:C1124(Object named:K67:5; "tool."+String:C10($i)))->:=Num:C11($i=$index)
	
End for 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End