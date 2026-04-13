//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : rgx_Options
// Created 28/09/07 by Vincent
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
var $0 : Text
var $1 : Integer

var $Lon_Options : Integer
var $Txt_Pattern : Text

$Lon_Options:=$1

If ($Lon_Options ?? 0)\
 | ($Lon_Options ?? 1)\
 | ($Lon_Options ?? 2)\
 | ($Lon_Options ?? 3)
	
	$Txt_Pattern:="(?"
	$Txt_Pattern:=$Txt_Pattern+("i"*Num:C11($Lon_Options ?? 0))
	$Txt_Pattern:=$Txt_Pattern+("m"*Num:C11($Lon_Options ?? 1))
	$Txt_Pattern:=$Txt_Pattern+("s"*Num:C11($Lon_Options ?? 2))
	$Txt_Pattern:=$Txt_Pattern+("x"*Num:C11($Lon_Options ?? 3))
	$Txt_Pattern:=$Txt_Pattern+")"
	
End if 

$0:=$Txt_Pattern