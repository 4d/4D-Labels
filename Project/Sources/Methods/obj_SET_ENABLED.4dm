//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Obj_SET_ENABLED
// Database: 4D Report
// ID[A690FCAE07CF4785B5F1C914E30ECF8E]
// Created #23-1-2015 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($enabled : Boolean;  ...  : Text)

var $i : Integer
var $object : Text

For ($i; 2; Count parameters:C259; 1)
	
	$object:=${$i}
	OBJECT SET ENABLED:C1123(*; $object; $enabled)
	OBJECT SET RGB COLORS:C628(*; $object; $enabled ? Foreground color:K23:1 : Dark shadow color:K23:3; Background color none:K23:10)
	
End for 