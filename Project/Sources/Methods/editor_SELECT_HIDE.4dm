//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : editor_SELECT_HIDE
// Database: 4D Labels
// ID[CDE76DF50D4B414CB522AF23B2070C8A]
// Created #10-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Text

var $Lon_parameters : Integer
var $Txt_ID : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Txt_ID:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
SVG SET ATTRIBUTE:C1055(*; "Image"; $Txt_ID+"-rect"; \
"stroke-opacity"; 0)

//hide the handles
SVG SET ATTRIBUTE:C1055(*; "Image"; OB Get:C1224(<>label_params; "select-rect-prefix"; Is text:K8:3)+$Txt_ID; \
"stroke-opacity"; 0)
SVG SET ATTRIBUTE:C1055(*; "Image"; OB Get:C1224(<>label_params; "select-rect-prefix"; Is text:K8:3)+$Txt_ID; \
"fill-opacity"; 0)

SVG SET ATTRIBUTE:C1055(*; "Image"; "select-tl-"+$Txt_ID; \
"stroke-opacity"; 0)
SVG SET ATTRIBUTE:C1055(*; "Image"; "select-tl-"+$Txt_ID; \
"fill-opacity"; 0)

SVG SET ATTRIBUTE:C1055(*; "Image"; "select-tm-"+$Txt_ID; \
"stroke-opacity"; 0)
SVG SET ATTRIBUTE:C1055(*; "Image"; "select-tm-"+$Txt_ID; \
"fill-opacity"; 0)

SVG SET ATTRIBUTE:C1055(*; "Image"; "select-tr-"+$Txt_ID; \
"stroke-opacity"; 0)
SVG SET ATTRIBUTE:C1055(*; "Image"; "select-tr-"+$Txt_ID; \
"fill-opacity"; 0)

SVG SET ATTRIBUTE:C1055(*; "Image"; "select-ml-"+$Txt_ID; \
"stroke-opacity"; 0)
SVG SET ATTRIBUTE:C1055(*; "Image"; "select-ml-"+$Txt_ID; \
"fill-opacity"; 0)

SVG SET ATTRIBUTE:C1055(*; "Image"; "select-mr-"+$Txt_ID; \
"stroke-opacity"; 0)
SVG SET ATTRIBUTE:C1055(*; "Image"; "select-mr-"+$Txt_ID; \
"fill-opacity"; 0)

SVG SET ATTRIBUTE:C1055(*; "Image"; "select-bl-"+$Txt_ID; \
"stroke-opacity"; 0)
SVG SET ATTRIBUTE:C1055(*; "Image"; "select-bl-"+$Txt_ID; \
"fill-opacity"; 0)

SVG SET ATTRIBUTE:C1055(*; "Image"; "select-bm-"+$Txt_ID; \
"stroke-opacity"; 0)
SVG SET ATTRIBUTE:C1055(*; "Image"; "select-bm-"+$Txt_ID; \
"fill-opacity"; 0)

SVG SET ATTRIBUTE:C1055(*; "Image"; "select-br-"+$Txt_ID; \
"stroke-opacity"; 0)
SVG SET ATTRIBUTE:C1055(*; "Image"; "select-br-"+$Txt_ID; \
"fill-opacity"; 0)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End