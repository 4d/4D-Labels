//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Obj_BEST_WIDTH
// Database: runtime
// ID[754FE76DAA6A49F293FAF5AA869135F4]
// Created #26-11-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Sets the width of object(s) according to localisation
// ----------------------------------------------------
#DECLARE($alignment : Integer; $objectName : Text;  ...  : Text)

var $bottom; $height; $i; $left; $right; $top : Integer
var $width : Integer

For ($i; 2; Count parameters:C259; 1)
	
	$objectName:=${$i}
	
	OBJECT GET BEST SIZE:C717(*; $objectName; $width; $height)
	
	$width:=$width*1.1  //10% more
	
	OBJECT GET COORDINATES:C663(*; $objectName; $left; $top; $right; $bottom)
	
	Case of 
			
			//______________________________________________________
		: ($alignment=Align left:K42:2)
			
			$right:=$left+$width
			
			//______________________________________________________
		: ($alignment=Align right:K42:4)
			
			$left:=$right-$width
			
			//______________________________________________________
		: ($alignment=Align center:K42:3)
			
			$left:=$left+((($right-$left)-$width)\2)
			$right:=$left+$width
			
			//______________________________________________________
		Else 
			
			ASSERT:C1129(False:C215; "Unknown entry point: \""+String:C10($alignment)+"\"")
			
			//______________________________________________________
	End case 
	
	OBJECT SET COORDINATES:C1248(*; $objectName; $left; $top; $right; $bottom)
	
End for 