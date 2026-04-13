//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_SEL_INVENTORY
// Database: 4D Labels
// ID[54998622DF4B4DF4AB034EF409E98BE7]
// Created #20-4-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Object
var $1 : Text

var $Boo_fill; $Boo_image; $Boo_isImage; $Boo_isImageOnly; $Boo_isText; $Boo_rect : Boolean
var $Boo_round_rect; $Boo_stroke; $Boo_text; $Boo_withFill; $Boo_withStroke : Boolean
var $Lon_i; $Lon_parameters; $Lon_type : Integer
var $Dom_label; $Dom_object; $Txt_ID; $Txt_type : Text
var $Obj_result : Object

ARRAY TEXT:C222($tDom_selected; 0)


// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	$Dom_label:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
	$Boo_isImageOnly:=True:C214
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($Lon_i; 1; Editor_SEL_Get_count($Dom_label; ->$tDom_selected))
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i}; "object-id"; $Txt_ID)
	
	$Dom_object:=DOM Find XML element by ID:C1010($Dom_label; $Txt_ID)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "type"; $Txt_type)
	
	CLEAR VARIABLE:C89($Boo_text)
	CLEAR VARIABLE:C89($Boo_image)
	
	Case of 
			
			//________________________________________
		: ($Txt_type="line")
			
			$Boo_stroke:=True:C214
			
			//________________________________________
		: ($Txt_type="polyline")
			
			$Boo_fill:=True:C214
			$Boo_stroke:=True:C214
			
			//________________________________________
		: ($Txt_type="oval")
			
			$Boo_fill:=True:C214
			$Boo_stroke:=True:C214
			
			//________________________________________
		: ($Txt_type="rect")\
			 | ($Txt_type="round-rect")
			
			$Boo_fill:=True:C214
			$Boo_stroke:=True:C214
			$Boo_rect:=$Boo_rect | ($Txt_type="rect")
			$Boo_round_rect:=$Boo_round_rect | ($Txt_type="round-rect")
			
			//________________________________________
		: ($Txt_type="text")
			
			$Boo_text:=True:C214
			$Boo_fill:=True:C214
			$Boo_stroke:=True:C214
			
			//________________________________________
		: ($Txt_type="image")
			
			$Boo_image:=True:C214
			
			//________________________________________
		: ($Txt_type="variable")
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "field-type"; $Lon_type)
			$Boo_image:=($Lon_type=Is picture:K8:10)
			$Boo_text:=Not:C34($Boo_image)
			$Boo_fill:=$Boo_text
			$Boo_stroke:=$Boo_text
			
			//________________________________________
	End case 
	
	$Boo_isText:=$Boo_isText | $Boo_text
	$Boo_isImage:=$Boo_isImage | $Boo_image
	$Boo_withFill:=$Boo_withFill | $Boo_fill
	$Boo_withStroke:=$Boo_withStroke | $Boo_stroke
	
	$Boo_isImageOnly:=$Boo_isImageOnly & $Boo_image
	
End for 

OB SET:C1220($Obj_result; \
"text"; $Boo_isText; \
"image"; $Boo_isImage; \
"image-only"; $Boo_isImageOnly; \
"fill"; $Boo_withFill; \
"stroke"; $Boo_withStroke; \
"rect"; $Boo_rect; \
"round-rect"; $Boo_round_rect)

// ----------------------------------------------------
// Return
$0:=$Obj_result

// ----------------------------------------------------
// End