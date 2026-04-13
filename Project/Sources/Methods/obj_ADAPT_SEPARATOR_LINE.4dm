//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : obj_ADAPT_SEPARATOR_LINE
// Database: 4D Labels
// ID[8AAB45937ADF4DB99D998B9A021E2B16]
// Created #14-9-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Adapt separator's line to a localized label
// Given the label's name(s) as parameter(s), the lines must be called "name.line"
// ----------------------------------------------------
#DECLARE( ...  : Text)

var $kLon_offset; $dummy; $bottom; $i; $left; $parameters : Integer
var $right; $top; $width : Integer
var $labelName; $Txt_line : Text

$parameters:=Count parameters:C259

If (Asserted:C1132($parameters>=1; "Missing parameter"))
	
	//Required parameters
	$labelName:=$1
	
	//Optional parameters
	If ($parameters>=2)
		
		// <NONE>
		
	End if 
	
	$kLon_offset:=5  //offset between label and line
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($i; 1; $parameters; 1)
	
	$labelName:=${$i}
	$Txt_line:=$labelName+".line"
	
	OBJECT GET COORDINATES:C663(*; $labelName; $left; $top; $right; $bottom)
	OBJECT GET BEST SIZE:C717(*; $labelName; $width; $dummy)
	
	$right:=$left+$width
	OBJECT SET COORDINATES:C1248(*; $labelName; $left; $top; $right; $bottom)
	
	$left:=$right+$kLon_offset
	
	OBJECT GET COORDINATES:C663(*; $Txt_line; $dummy; $top; $right; $bottom)
	OBJECT SET COORDINATES:C1248(*; $Txt_line; $left; $top; $right; $bottom)
	
End for 