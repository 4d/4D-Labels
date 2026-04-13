//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : obj_ALIGN_ON_BEST_SIZE
// Database: runtime
// ID[C4F630C70E63475A8F5DEA93FE611F72]
// Created #8-6-2016 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($alignment : Integer; $Txt_objectName : Text;  ...  : Text)


var $unused; $bottom; $height; $i; $left : Integer
var $offset; $oldWidth; $right; $top; $width : Integer

var $parameters:=Count parameters:C259


If ($alignment=Align center:K42:3)
	
	//get the total width defined in design mode
	OBJECT GET COORDINATES:C663(*; $Txt_objectName; $left; $unused; $unused; $unused)
	
	$Txt_objectName:=${$parameters}
	OBJECT GET COORDINATES:C663(*; $Txt_objectName; $unused; $unused; $right; $unused)
	
	$oldWidth:=$right-$left
	
End if 

For ($i; 2; $parameters; 1)
	
	$Txt_objectName:=${$i}
	
	//move current object if any
	OBJECT MOVE:C664(*; $Txt_objectName; $offset; 0)
	
	OBJECT GET BEST SIZE:C717(*; $Txt_objectName; $width; $height)
	
	//add a little margin
	$width:=$width*1.1
	
	//minimum width
	$width:=Choose:C955($width<80; 80; $width)
	
	//get current object coordinates
	OBJECT GET COORDINATES:C663(*; $Txt_objectName; $left; $top; $right; $bottom)
	
	If ($alignment=Align left:K42:2)\
		 | ($alignment=Align center:K42:3)
		
		//resize current object
		OBJECT SET COORDINATES:C1248(*; $Txt_objectName; $left; $top; $left+$width; $bottom)
		
		//calculate the cumulative shift
		$offset:=$offset-(($right-$left)-$width)
		
	Else 
		
		//resize current object
		OBJECT SET COORDINATES:C1248(*; $Txt_objectName; $right-$width; $top; $right; $bottom)
		
		//calculate the cumulative shift
		$offset:=$offset+($right-$left)-$width
		
	End if 
End for 

If ($alignment=Align center:K42:3)
	
	//get the new total width…
	OBJECT GET COORDINATES:C663(*; $Txt_objectName; $left; $unused; $unused; $unused)
	
	$Txt_objectName:=${$parameters}
	OBJECT GET COORDINATES:C663(*; $Txt_objectName; $unused; $unused; $right; $unused)
	
	//…to calculate the offset
	$offset:=Round:C94(($oldWidth-($right-$left))/2; 0)
	
	//then move objects
	For ($i; 2; $parameters; 1)
		
		$Txt_objectName:=${$i}
		OBJECT MOVE:C664(*; $Txt_objectName; $offset; 0)
		
	End for 
End if 