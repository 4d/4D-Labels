//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : wizard_INIT
// Database: 4D Labels
// ID[E9019810C6A346A4804BB0DF82566898]
// Created #16-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($init : Boolean)

If (False:C215)
	C_BOOLEAN:C305(wizard_INIT; $1)
End if 

var $t : Text
var $prefilled; $visible : Boolean
var $i : Integer
var $ptr : Pointer
var $objects : Collection
var $file : 4D:C1709.File

ARRAY TEXT:C222($forms; 0)
ARRAY OBJECT:C1221($restrictions; 0)

LABELS_INIT

If (Not:C34($init))
	
	return 
	
End if 

// Display the debug objects, if any
OBJECT SET VISIBLE:C603(*; "Debug@"; <>Boo_debug)

// Adjust display according to the platform
OBJECT SET VISIBLE:C603(*; Is macOS:C1572 ? "win.@" : "mac.@"; False:C215)

// Set the focus rings color
OBJECT SET RGB COLORS:C628(*; "@.focus"; Highlight text background color:K23:5; Background color none:K23:10)

// Check for user's restrictions
$file:=File:C1566("/RESOURCES/labels.json"; *)

If ($file.exists)
	
	JSON PARSE ARRAY:C1219($file.getText(); $restrictions)
	
	For ($i; 1; Size of array:C274($restrictions); 1)
		
		If (C_MASTER_TABLE=Num:C11($restrictions{$i}.tableId))
			
			$restrictions:=$i
			break
			
		End if 
	End for 
End if 

// MARK:-Determine if the mode menu should be displayed
$ptr:=Table:C252(C_MASTER_TABLE)

// Get the available forms for the current table
FORM GET NAMES:C1167($ptr->; $forms; *)

// Restrict the list, if necessary, according to user instructions
$prefilled:=(Num:C11($restrictions)>0)

If ($prefilled)
	
	$prefilled:=$restrictions{$restrictions}.forms#Null:C1517
	
	If ($prefilled)
		
		For each ($t; $restrictions{$restrictions}.forms)
			
			If (Find in array:C230($forms; $t)>0)
				
				$visible:=True:C214
				
				break
				
			End if 
		End for each 
	End if 
End if 

// If not user defined, lists the forms
If (Not:C34($prefilled))
	
	$visible:=(Size of array:C274($forms)>0)
	
End if 

// Test for user label's folder
If (Folder:C1567("/RESOURCES/Labels"; *).exists)
	
	// Add separate pop-up menu
	OBJECT SET FORMAT:C236(*; "toolbar.load"; ";;;;;;;;;;2")
	
End if 

// MARK:-Initialize toolbar
$objects:=[]

$objects.push(New object:C1471(\
"object"; "toolbar.load"; \
"type"; "button"; \
"visible"; True:C214; \
"right-offset"; 10))

$objects.push(New object:C1471(\
"object"; "toolbar.save"; \
"type"; "button"; \
"visible"; True:C214))

$objects.push(New object:C1471(\
"object"; "toolbar.opened.sep.1"; \
"type"; "separator"; \
"visible"; True:C214))

$objects.push(New object:C1471(\
"object"; "toolbar.preview"; \
"type"; "button"; \
"visible"; True:C214))

$objects.push(New object:C1471(\
"object"; "toolbar.print"; \
"type"; "button"; \
"visible"; True:C214))

$objects.push(New object:C1471(\
"object"; "toolbar.opened.sep.2"; \
"type"; "separator"; \
"visible"; True:C214))

$objects.push(New object:C1471(\
"object"; "toolbar.tabs"; \
"type"; "widget"; \
"visible"; True:C214))

$objects.push(New object:C1471(\
"object"; "toolbar.opened.sep.3"; \
"type"; "separator"; \
"visible"; True:C214))

$objects.push(New object:C1471(\
"object"; "toolbar.form"; \
"type"; "button"; \
"visible"; $visible))

ALIGN_OBJECTS({toolbar: $objects})

// Set label's page as default
OBJECT SET VALUE:C1742("toolbar.tabs"; 1)