//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : PRINT_object
// Database: 4D Labels
// ID[B91744BD7CA84BF59919BACBA3A8E6CF]
// Created #7-4-2015 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($target : Text; $o : Object)

If (False:C215)
	C_TEXT:C284(PRINT_OBJECT; $1)
	C_OBJECT:C1216(PRINT_OBJECT; $2)
End if 

var $fillOpacity; $height; $hOffset; $rx; $ry; $strokeOpacity : Real
var $strokeWidth; $vOffset; $width; $wOffset; $X; $x1 : Real
var $x2; $Y; $y1; $y2 : Real
var $alignment; $data; $fill; $node; $root; $stroke : Text
var $strokeDasharray; $style : Text
var $picture : Picture
var $printed : Boolean
var $fontStyle; $i; $start : Integer

// Required parameters
ASSERT:C1129(Count parameters:C259=2)

$width:=Num:C11($o.width)
$height:=Num:C11($o.height)

$stroke:=String:C10($o.stroke)
$strokeWidth:=Num:C11($o["stroke-width"])
$strokeOpacity:=Num:C11($o["stroke-opacity"])
$strokeDasharray:=String:C10($o["stroke-dasharray"])

$fill:=String:C10($o.fill)
$fillOpacity:=Num:C11($o["fill-opacity"])

$X:=Num:C11($o.x)
$Y:=Num:C11($o.y)
$hOffset:=Num:C11($o["h-offset"])
$vOffset:=Num:C11($o["v-offset"])


$root:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg"; "xmlns:svg"; "http://www.w3.org/2000/svg")

DOM SET XML ATTRIBUTE:C866($root; \
"width"; $strokeWidth+$width+$strokeWidth; \
"height"; $strokeWidth+$height+$strokeWidth)

Case of 
		
		//MARK:-line
	: ($target="line")
		
		$x1:=$strokeWidth
		$x2:=$x1+$width
		
		If (String:C10($o.direction)="up")
			
			$y2:=$strokeWidth
			$y1:=$y2+$height
			
		Else 
			
			$y1:=$strokeWidth
			$y2:=$y1+$height
			
		End if 
		
		$node:=DOM Create XML element:C865($root; "line"; \
			"id"; "line"; \
			"x1"; $x1; \
			"y1"; $y1; \
			"x2"; $x2; \
			"y2"; $y2; \
			"fill"; $fill; \
			"stroke"; $stroke; \
			"stroke-width"; $strokeWidth; \
			"stroke-opacity"; $strokeOpacity; \
			"stroke-dasharray"; $strokeDasharray; \
			"shape-rendering"; String:C10(<>label_params["shape-rendering"]))
		
		//MARK:-polyline
	: ($target="polyline")
		
		$data:=String:C10($o.data)
		
		ARRAY LONGINT:C221($lengths; 0x0000)
		ARRAY LONGINT:C221($positions; 0x0000)
		ARRAY REAL:C219($posX; 0x0000)
		ARRAY REAL:C219($posY; 0x0000)
		
		$start:=1
		
		While (Match regex:C1019("(-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)"; $data; $start; $positions; $lengths))
			
			APPEND TO ARRAY:C911($posX; Num:C11(Substring:C12($data; $positions{1}; $lengths{1}); "."))
			APPEND TO ARRAY:C911($posY; Num:C11(Substring:C12($data; $positions{2}; $lengths{2}); "."))
			
			$start+=$positions{2}+$lengths{2}
			
		End while 
		
		CLEAR VARIABLE:C89($data)
		
		$wOffset:=($width/2)+$strokeWidth
		$hOffset:=($height/2)+$strokeWidth
		
		For ($i; 1; Size of array:C274($posX); 1)
			
			$posX{$i}:=$posX{$i}+$wOffset
			$posY{$i}:=$posY{$i}+$hOffset
			$data+=" "+String:C10($posX{$i}; "&xml")+","+String:C10($posY{$i}; "&xml")
			
		End for 
		
		$node:=DOM Create XML element:C865($root; "polyline"; \
			"id"; "polyline"; \
			"points"; $data; \
			"fill"; $fill; \
			"fill-opacity"; $fillOpacity; \
			"stroke"; $stroke; \
			"stroke-width"; $strokeWidth; \
			"stroke-opacity"; $strokeOpacity; \
			"stroke-dasharray"; $strokeDasharray; \
			"shape-rendering"; String:C10(<>label_params["shape-rendering"]))
		
		//MARK:-rect & round-rect
	: ($target="rect")\
		 | ($target="round-rect")
		
		$node:=DOM Create XML element:C865($root; "rect"; \
			"id"; "rect"; \
			"x"; $strokeWidth; \
			"y"; $strokeWidth; \
			"width"; $width; \
			"height"; $height; \
			"fill"; $fill; \
			"fill-opacity"; $fillOpacity; \
			"stroke"; $stroke; \
			"stroke-width"; $strokeWidth; \
			"stroke-opacity"; $strokeOpacity; \
			"stroke-dasharray"; $strokeDasharray; \
			"shape-rendering"; String:C10(<>label_params["shape-rendering"]))
		
		If ($target="round-rect")
			
			$target:="rect"
			
			DOM SET XML ATTRIBUTE:C866($node; \
				"rx"; Num:C11(<>label_params["defaultRoundRect"]); \
				"ry"; Num:C11(<>label_params["defaultRoundRect"]))
			
		End if 
		
		//MARK:-ellipse
	: ($target="ellipse")
		
		$rx:=$width/2
		$ry:=$height/2
		
		$node:=DOM Create XML element:C865($root; "ellipse"; \
			"id"; "ellipse"; \
			"rx"; $rx; \
			"ry"; $ry; \
			"cx"; $rx+$strokeWidth; \
			"cy"; $ry+$strokeWidth; \
			"fill"; $fill; \
			"fill-opacity"; $fillOpacity; \
			"stroke"; $stroke; \
			"stroke-width"; $strokeWidth; \
			"stroke-opacity"; $strokeOpacity; \
			"stroke-dasharray"; $strokeDasharray; \
			"shape-rendering"; String:C10(<>label_params["shape-rendering"]))
		
		//MARK:-text
	: ($target="text")
		
		$alignment:=String:C10($o.alignment)
		
		Case of 
				
				//........................................
			: ($alignment="center")
				
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "text"; Align center:K42:3)
				
				//........................................
			: ($alignment="end")\
				 | ($alignment="right")
				
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "text"; Align right:K42:4)
				
				//........................................
			Else 
				
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "text"; Align left:K42:2)
				
				//........................................
		End case 
		
		OBJECT SET FONT SIZE:C165(*; "text"; Num:C11($o["font-size"]))
		OBJECT SET FONT:C164(*; "text"; String:C10($o["font-name"]))
		
		$style:=String:C10($o.style)
		$fontStyle:=Plain:K14:1
		$fontStyle:=$style="@italic@" ? $fontStyle | Italic:K14:3 : $fontStyle
		$fontStyle:=$style="@bold@" ? $fontStyle | Bold:K14:2 : $fontStyle
		$fontStyle:=$style="@underline@" ? $fontStyle | Underline:K14:4 : $fontStyle
		OBJECT SET FONT STYLE:C166(*; "text"; $fontStyle)
		
		// Fixme:ACI0103533
		OBJECT SET RGB COLORS:C628(*; "text"; Color_to_long(String:C10($o["font-color"])))  //; -2)
		
		// Set the value
		OBJECT SET TITLE:C194(*; "text"; String:C10($o.value))
		
		// Adjusting sizes
		$hOffset:=$hOffset+0.5
		$vOffset:=$vOffset+0.5
		$width:=$width-0.5
		
		//MARK:-image
	: ($target="image")
		
		$target:=Bool:C1537($o["preserve-aspect-ratio"]) ? "ImageWithAspect" : "Image"
		
		If ($o["image-data"]#Null:C1517)
			
			// Embedded image
			$picture:=PRINT_Get_image(String:C10($o["image-data"]); String:C10($o["image-codec"]); ".png")
			
		Else 
			
			// Image's field
			$picture:=PRINT_Get_image_field(String:C10($o.value))
			
		End if 
		
		//MARK:-variable
	: ($target="variable")
		
		$alignment:=String:C10($o.alignment)
		
		Case of 
				
				//........................................
			: ($alignment="center")
				
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $target; Align center:K42:3)
				
				//........................................
			: ($alignment="end")\
				 | ($alignment="right")
				
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $target; Align right:K42:4)
				
				//........................................
			Else 
				
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $target; Align left:K42:2)
				
				//........................................
		End case 
		
		OBJECT SET FONT SIZE:C165(*; $target; Num:C11($o["font-size"]))
		OBJECT SET FONT:C164(*; $target; String:C10($o["font-name"]))
		
		$style:=String:C10($o.style)
		$fontStyle:=Plain:K14:1
		$fontStyle:=$style="@italic@" ? $fontStyle | Italic:K14:3 : $fontStyle
		$fontStyle:=$style="@bold@" ? $fontStyle | Bold:K14:2 : $fontStyle
		$fontStyle:=$style="@underline@" ? $fontStyle | Underline:K14:4 : $fontStyle
		OBJECT SET FONT STYLE:C166(*; $target; $fontStyle)
		
		// Fixme:ACI0103533
		OBJECT SET RGB COLORS:C628(*; $target; Color_to_long($stroke))  // ; -2)
		
		// Set the value
		OBJECT SET VALUE:C1742($target; String:C10($o.value))
		
		$hOffset:=$hOffset+0.5
		$vOffset:=$vOffset+0.5
		
		//______________________________________________________
End case 

If ($target#"variable@")\
 & ($target#"text@")\

	If ($target#"image@")
		
		// Get the picture
		SVG EXPORT TO PICTURE:C1017($root; $picture; Copy XML data source:K45:17)
		
	End if 
	
	// Assign to the object
	OBJECT SET VALUE:C1742($target; $picture)
	
End if 

// Free the memory
DOM CLOSE XML:C722($root)
CLEAR VARIABLE:C89($picture)

// Print object
$printed:=Print object:C1095(*; $target; \
$X+$hOffset-$strokeWidth; \
$Y+$vOffset-$strokeWidth; \
$strokeWidth+$width+$strokeWidth; \
$strokeWidth+$height+$strokeWidth)