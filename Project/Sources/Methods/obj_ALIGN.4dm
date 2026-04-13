//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Obj_ALIGN
// Database: 4D Report
// ID[C4AC2C9B6DBB43FBA2AEC05C5201C0F8]
// Created #20-1-2015 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($alignment : Integer; $offset : Integer; $reference : Text;  ...  : Text)

var $bottom; $dummy; $i; $left; $right; $top : Integer

OBJECT GET COORDINATES:C663(*; $reference; $left; $top; $right; $bottom)

Case of 
		
		// ______________________________________________________
	: ($alignment=Align right:K42:4)
		
		For ($i; 4; Count parameters:C259; 1)
			
			var $name : Text:=${$i}
			OBJECT GET COORDINATES:C663(*; $name; $dummy; $dummy; $right; $dummy)
			OBJECT MOVE:C664(*; $name; ($left-$right)-20; 0)
			
		End for 
		
		// ______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215)  // #TO_BE_DONE
		
		// ______________________________________________________
End case 