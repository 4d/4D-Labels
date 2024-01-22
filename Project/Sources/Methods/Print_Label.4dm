//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Print_Label
// Database: 4D Labels
// ID[6349290659384A0499FF195E19B79FC1]
// Created #19-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($tableNumber : Integer; $root : Text; $preview : Boolean) : Integer

If (False:C215)
	C_LONGINT:C283(Print_Label; $1)
	C_TEXT:C284(Print_Label; $2)
	C_BOOLEAN:C305(Print_Label; $3)
	C_LONGINT:C283(Print_Label; $0)
End if 

var $fillOpacity; $horizontalOffset; $strokeOpacity; $strokeWidth; $verticalOffset; $x : Real
var $y : Real
var $alignment; $codec; $data; $direction; $fill; $fontColor : Text
var $fontFamilly; $formName; $formula; $labelMethod; $methodCalledOnError; $node : Text
var $objects; $onErrorMethod; $recordMethod; $stroke; $style; $t : Text
var $target; $value : Text
var $automaticWidth; $genericCase; $isLinefeed; $landscape; $perLabel; $preserveAspectRatio : Boolean
var $printed; $stop; $useForm; $vertical : Boolean
var $backupOrientation; $backupProgress; $bottom; $break; $columns; $fontSize : Integer
var $fontStyle; $height; $horizontalGap; $horizontalStartIndex; $i; $labelCount : Integer
var $labelHeight; $labelWidth; $left; $leftMargin; $leftPos; $linefeed : Integer
var $objectNumber; $objecty; $perRecord; $plus; $right; $rightMargin : Integer
var $rows; $startIndex; $top; $topMargin; $topPos; $type : Integer
var $verticalGap; $verticalStartIndex; $width; $xOffset; $yOffset : Integer
var $tablePtr : Pointer
var $o; $object : Object
var $tables : Collection

ARRAY TEXT:C222($formObjects; 0)

// ----------------------------------------------------
// Required parameters
ASSERT:C1129(Count parameters:C259>=2)

COMPILER_LABELS
COMPILER_PRINT

$tablePtr:=Table:C252($tableNumber)

print_ERROR:=0

$methodCalledOnError:=Method called on error:C704
ON ERR CALL:C155(Choose:C955(<>Boo_debug; ""; "Print_CATCH_ERROR"))

// Backup the current print settings
// Must call before opening job
// Need also to turn off progress in database settings
GET PRINT OPTION:C734(_o_Hide printing progress option:K47:12; $backupProgress)
GET PRINT OPTION:C734(Orientation option:K47:2; $backupOrientation)

// mark:Size
$node:=DOM Find XML element by ID:C1010($root; "size")
DOM GET XML ATTRIBUTE BY NAME:C728($node; "width"; $labelWidth)
DOM GET XML ATTRIBUTE BY NAME:C728($node; "height"; $labelHeight)

// mark:Settings
$node:=DOM Find XML element by ID:C1010($root; "setting")
DOM GET XML ATTRIBUTE BY NAME:C728($node; "landscape"; $landscape)
DOM GET XML ATTRIBUTE BY NAME:C728($node; "vertical"; $vertical)
DOM GET XML ATTRIBUTE BY NAME:C728($node; "auto-width"; $automaticWidth)

// Set the print settings
SET PRINT OPTION:C733(_o_Hide printing progress option:K47:12; 1)
SET PRINT OPTION:C733(Orientation option:K47:2; 1+Num:C11($landscape))

// mark:Form to use
$node:=DOM Find XML element by ID:C1010($root; "form")
DOM GET XML ATTRIBUTE BY NAME:C728($node; "name"; $formName)

$useForm:=(Length:C16($formName)>0)

If ($useForm & $automaticWidth)
	
	// Calculate columns & rows number according to the form dimensions
	GET PRINTABLE AREA:C703($height; $width)
	
	$columns:=$width\$labelWidth
	$rows:=$height\$labelHeight
	
Else 
	
	// Ignore the printer margins but consider the paper's margin
	SET PRINTABLE MARGIN:C710(0; 0; 0; 0)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($root; "columns"; $columns)
	DOM GET XML ATTRIBUTE BY NAME:C728($root; "rows"; $rows)
	
End if 

DOM GET XML ATTRIBUTE BY NAME:C728($root; "labels-per-record"; $perRecord)
DOM GET XML ATTRIBUTE BY NAME:C728($root; "start"; $startIndex)

$xOffset:=(OB Get:C1224(<>label_params; "width"; Is longint:K8:6)-$labelWidth)/2
$yOffset:=(OB Get:C1224(<>label_params; "height"; Is longint:K8:6)-$labelHeight)/2

// mark:Margins
$node:=DOM Find XML element by ID:C1010($root; "margin")
DOM GET XML ATTRIBUTE BY NAME:C728($node; "left"; $leftMargin)
DOM GET XML ATTRIBUTE BY NAME:C728($node; "right"; $rightMargin)
DOM GET XML ATTRIBUTE BY NAME:C728($node; "top"; $topMargin)

// mark:Gaps
$node:=DOM Find XML element by ID:C1010($root; "gap")
DOM GET XML ATTRIBUTE BY NAME:C728($node; "horizontal"; $horizontalGap)
DOM GET XML ATTRIBUTE BY NAME:C728($node; "vertical"; $verticalGap)

// mark:Method
$node:=DOM Find XML element by ID:C1010($root; "method")

If (OK=1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($node; "evaluate-per-label"; $perLabel)
	
	If ($perLabel)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($node; "name"; $labelMethod)
		
	Else 
		
		DOM GET XML ATTRIBUTE BY NAME:C728($node; "name"; $recordMethod)
		
	End if 
End if 

$o:=New object:C1471
$o.vertical:=$vertical
$o.preview:=$preview
$o.rows:=$rows
$o.columns:=$columns
$o.width:=$labelWidth
$o.height:=$labelHeight
$o["left-margin"]:=$leftMargin
$o["top-margin"]:=$topMargin
$o["h-gap"]:=$horizontalGap
$o["v-gap"]:=$verticalGap
$o["label-per-record"]:=$perRecord
$o.table:=$tableNumber

OPEN PRINTING JOB:C995

If (print_ERROR=0)
	
	If ($vertical)
		
		$verticalStartIndex:=Choose:C955(($startIndex%$rows)=0; $rows; $startIndex%$rows)
		$horizontalStartIndex:=($startIndex\$rows)+Num:C11(0#($startIndex%$rows))
		
		If ($horizontalStartIndex>$columns)\
			 | ($horizontalStartIndex<1)
			
			$x:=1
			$horizontalOffset:=$leftMargin
			
		Else 
			
			$x:=$horizontalStartIndex
			$horizontalOffset:=$leftMargin+(($x-1)*($labelWidth+$horizontalGap))
			
		End if 
		
		If ($verticalStartIndex>$rows)\
			 | ($verticalStartIndex<1)
			
			$y:=1
			$verticalOffset:=$topMargin
			
		Else 
			
			$y:=$verticalStartIndex
			$verticalOffset:=$topMargin+(($y-1)*($labelHeight+$verticalGap))
			
		End if 
		
	Else 
		
		If ($columns=0)  //#ACI0099724
			
			$horizontalStartIndex:=1
			$verticalStartIndex:=1
			
		Else 
			
			$horizontalStartIndex:=Choose:C955(($startIndex%$columns)=0; $columns; $startIndex%$columns)
			$verticalStartIndex:=($startIndex\$columns)+Num:C11(0#($startIndex%$columns))
			
		End if 
		
		If ($horizontalStartIndex>$columns)\
			 | ($horizontalStartIndex<1)
			
			$x:=1
			$horizontalOffset:=$leftMargin
			
		Else 
			
			$x:=$horizontalStartIndex
			$horizontalOffset:=$leftMargin+(($x-1)*($labelWidth+$horizontalGap))
			
		End if 
		
		If ($verticalStartIndex>$rows)\
			 | ($verticalStartIndex<1)
			
			$y:=1
			$verticalOffset:=$topMargin
			
		Else 
			
			$y:=$verticalStartIndex
			$verticalOffset:=$topMargin+(($y-1)*($labelHeight+$verticalGap))
			
		End if 
	End if 
	
	$labelCount:=1
	
	FIRST RECORD:C50($tablePtr->)
	
	If (Length:C16($recordMethod)#0)\
		 & (Is record loaded:C669($tablePtr->))
		
		$onErrorMethod:=4D_NO_ERROR("ON")
		EXECUTE METHOD:C1007($recordMethod)
		4D_NO_ERROR("OFF"; $onErrorMethod)
		
	End if 
	
	RELATE ONE:C42($tablePtr->)
	
	If ($useForm)
		
		FORM LOAD:C1103($tablePtr->; $formName)
		FORM GET OBJECTS:C898($formObjects; *)
		
		Repeat 
			
			If (Length:C16($labelMethod)#0)
				
				$onErrorMethod:=4D_NO_ERROR("ON")
				EXECUTE METHOD:C1007($labelMethod)
				4D_NO_ERROR("OFF"; $onErrorMethod)
				
			End if 
			
			If (Length:C16($recordMethod)#0)
				
				$onErrorMethod:=4D_NO_ERROR("ON")
				EXECUTE METHOD:C1007($recordMethod)
				4D_NO_ERROR("OFF"; $onErrorMethod)
				
			End if 
			
			For ($i; 1; Size of array:C274($formObjects); 1)
				
				If (OBJECT Get visible:C1075(*; $formObjects{$i}))
					
					OBJECT GET COORDINATES:C663(*; $formObjects{$i}; $left; $top; $right; $bottom)
					
					$printed:=Print object:C1095(*; \
						$formObjects{$i}; \
						$left+$horizontalOffset; \
						$top+$verticalOffset; \
						$right-$left; \
						$bottom-$top)
					
				End if 
			End for 
			
			$o["label-count"]:=$labelCount
			$o.x:=$x
			$o.y:=$y
			$o["h-offset"]:=$horizontalOffset
			$o["v-offset"]:=$verticalOffset
			
			$stop:=Print_Resume($o)
			
			If (Not:C34($stop))
				
				$x:=OB Get:C1224($o; "x"; Is real:K8:4)
				$y:=OB Get:C1224($o; "y"; Is real:K8:4)
				$horizontalOffset:=OB Get:C1224($o; "h-offset"; Is real:K8:4)
				$verticalOffset:=OB Get:C1224($o; "v-offset"; Is real:K8:4)
				
				If ($labelCount<$perRecord)
					
					$labelCount:=$labelCount+1
					
				Else 
					
					$labelCount:=1
					NEXT RECORD:C51($tablePtr->)
					
					FORM LOAD:C1103(Table:C252($tableNumber)->; $formName)
					
					// To redraw form
					RELATE ONE:C42($tablePtr->)
					
					If (Length:C16($recordMethod)#0)
						
						$onErrorMethod:=4D_NO_ERROR("ON")
						EXECUTE METHOD:C1007($recordMethod)
						4D_NO_ERROR("OFF"; $onErrorMethod)
						
					End if 
				End if 
			End if 
		Until (End selection:C36($tablePtr->)\
			 | (print_ERROR#0) | $stop)
		
	Else 
		
		FORM LOAD:C1103("print")
		
		$objects:=DOM Find XML element by ID:C1010($root; "objects")
		$objectNumber:=DOM Count XML elements:C726($objects; "object")
		
		Repeat 
			
			If (Length:C16($labelMethod)#0)
				
				$onErrorMethod:=4D_NO_ERROR("ON")
				EXECUTE METHOD:C1007($labelMethod)
				4D_NO_ERROR("OFF"; $onErrorMethod)
				
			End if 
			
			If (Length:C16($recordMethod)#0)
				
				$onErrorMethod:=4D_NO_ERROR("ON")
				EXECUTE METHOD:C1007($recordMethod)
				4D_NO_ERROR("OFF"; $onErrorMethod)
				
			End if 
			
			If ($preview)  // Print the label rect
				
				$object:=New object:C1471
				$object.x:=0
				$objecty:=0
				$object["h-offset"]:=$horizontalOffset
				$object["v-offset"]:=$verticalOffset
				$object.width:=$labelWidth-0.5
				$object.height:=$labelHeight-0.5
				$object.stroke:="gray"
				$object["stroke-width"]:=0.5
				$object["stroke-opacity"]:=0.5
				$object.fill:="none"
				$object["fill-opacity"]:=0
				$object["stroke-dasharray"]:="1"
				
				PRINT_OBJECT("round-rect"; $object)
				
				CLEAR VARIABLE:C89($object)
				
			End if 
			
			For ($i; 1; $objectNumber; 1)
				
				$node:=DOM Find XML element:C864($objects; "objects/object["+String:C10($i)+"]")
				
				//mark:-Common attributes
				DOM GET XML ATTRIBUTE BY NAME:C728($node; "left"; $leftPos)
				DOM GET XML ATTRIBUTE BY NAME:C728($node; "top"; $topPos)
				DOM GET XML ATTRIBUTE BY NAME:C728($node; "right"; $right)
				DOM GET XML ATTRIBUTE BY NAME:C728($node; "bottom"; $bottom)
				$width:=$right-$leftPos
				$height:=$bottom-$topPos
				$left:=-$xOffset+$leftPos-OB Get:C1224(<>label_params; "left"; Is longint:K8:6)
				$top:=-$yOffset+$topPos-OB Get:C1224(<>label_params; "top"; Is longint:K8:6)
				
				$object:=New object:C1471
				$object.x:=$left
				$object.y:=$top
				$object["h-offset"]:=$horizontalOffset
				$object["v-offset"]:=$verticalOffset
				$object.width:=$width
				$object.height:=$height
				
				DOM GET XML ATTRIBUTE BY NAME:C728($node; "stroke-color"; $stroke)
				$object.stroke:=$stroke
				
				DOM GET XML ATTRIBUTE BY NAME:C728($node; "stroke-width"; $strokeWidth)
				$object["stroke-width"]:=$strokeWidth
				
				DOM GET XML ATTRIBUTE BY NAME:C728($node; "stroke-opacity"; $strokeOpacity)
				$object["stroke-opacity"]:=$strokeOpacity
				
				DOM GET XML ATTRIBUTE BY NAME:C728($node; "fill-color"; $fill)
				$object.fill:=$fill
				
				DOM GET XML ATTRIBUTE BY NAME:C728($node; "fill-opacity"; $fillOpacity)
				$object["fill-opacity"]:=$fillOpacity
				
				//mark:-Specific attributes
				DOM GET XML ATTRIBUTE BY NAME:C728($node; "type"; $target)
				
				Case of 
						
						//mark:line
					: ($target="line")
						
						DOM GET XML ATTRIBUTE BY NAME:C728($node; "direction"; $direction)
						$object.direction:=$direction
						
						PRINT_OBJECT($target; $object)
						
						//mark:polyline
					: ($target="polyline")
						
						DOM GET XML ATTRIBUTE BY NAME:C728($node; "data"; $data)
						$object.data:=$data
						
						PRINT_OBJECT($target; $object)
						
						//mark:rect & round-rect
					: ($target="rect")\
						 | ($target="round-rect")
						
						PRINT_OBJECT($target; $object)
						
						//mark:ellipse (oval)
					: ($target="oval")
						
						PRINT_OBJECT("ellipse"; $object)
						
						//mark:text
					: ($target="text")
						
						If (False:C215)  // ****** NO BACKGROUND
							
							// Background, if any
							If (Length:C16($fill)#0)\
								 | (Length:C16($stroke)#0)
								
								PRINT_OBJECT("rect"; $object)
								
							End if 
						End if 
						
						xml_GET_ATTRIBUTE_BY_NAME($node; "value"; ->$value)
						$object.value:=$value
						
						DOM GET XML ATTRIBUTE BY NAME:C728($node; "font-name"; $fontFamilly)
						//fixme:ACI0100864
						$fontFamilly:=PRINT_Font($fontFamilly)
						$object["font-name"]:=$fontFamilly
						
						DOM GET XML ATTRIBUTE BY NAME:C728($node; "font-size"; $fontSize)
						$object["font-size"]:=$fontSize
						
						DOM GET XML ATTRIBUTE BY NAME:C728($node; "font-color"; $fontColor)
						$object["font-color"]:=$fontColor
						
						DOM GET XML ATTRIBUTE BY NAME:C728($node; "style"; $style)
						$object.style:=$style
						
						DOM GET XML ATTRIBUTE BY NAME:C728($node; "alignment"; $alignment)
						$object.alignment:=$alignment
						
						PRINT_OBJECT("text"; $object)
						
						//mark:image
					: ($target="image")
						
						DOM GET XML ATTRIBUTE BY NAME:C728($node; "image-data"; $data)
						$object["image-data"]:=$data
						
						DOM GET XML ATTRIBUTE BY NAME:C728($node; "image-codec"; $codec)
						$object["image-codec"]:=$codec
						
						DOM GET XML ATTRIBUTE BY NAME:C728($node; "preserve-aspect-ratio"; $preserveAspectRatio)
						$object["preserve-aspect-ratio"]:=$preserveAspectRatio
						
						$object["stroke-width"]:=0
						
						PRINT_OBJECT("image"; $object)
						
						//mark:variable
					: ($target="variable")  // Field and more
						
						DOM GET XML ATTRIBUTE BY NAME:C728($node; "field-type"; $type)
						
						//fixme:ACI0101759
						
						xml_GET_ATTRIBUTE_BY_NAME($node; "tableList"; ->$t)
						
						If (Length:C16($t)>0)
							
							$tables:=JSON Parse:C1218($t)
							
							If ($tables.length>1)  // If there is multiples field it's goes here
								
								DOM GET XML ATTRIBUTE BY NAME:C728($node; "value"; $t)
								
								// ⚠️ Parse formula doesnt parse correctly \n and \r
								CLEAR VARIABLE:C89($value)
								
								Repeat 
									
									$linefeed:=Position:C15("\n"; $t)
									$plus:=Position:C15("+"; $t)
									
									If ($linefeed=0)
										
										$linefeed:=Position:C15("\r"; $t)
										
									End if 
									
									If (($plus=0)\
										 & ($linefeed=0))
										
										$value+=Parse formula:C1576($t; Formula in with virtual structure:K88:1)
										
									Else 
										
										If ((($plus>$linefeed)\
											 & ($linefeed#0))\
											 | ($plus=0))
											
											$break:=$linefeed
											$isLinefeed:=True:C214
											
										Else 
											
											$break:=$plus
											$isLinefeed:=False:C215
											
										End if 
										
										$formula:=Substring:C12($t; 0; $break)
										
										If ($isLinefeed=False:C215)
											
											$value+=Parse formula:C1576($formula; Formula in with virtual structure:K88:1)
											
										Else 
											
											$value+=Parse formula:C1576($formula; Formula in with virtual structure:K88:1)+"+"+Char:C90(Line feed:K15:40)+"+"
											
										End if 
										
										$t:=Substring:C12($t; $break+1)
										
									End if 
									
								Until (($linefeed=0) & ($plus=0))
								
							Else 
								
								$genericCase:=True:C214
								
							End if 
							
						Else 
							
							$genericCase:=True:C214
							
						End if 
						
						If ($genericCase)
							
							DOM GET XML ATTRIBUTE BY NAME:C728($node; "value"; $t)
							$value:=Parse formula:C1576($t; Formula in with virtual structure:K88:1)
							
						End if 
						
						Case of 
								
								// ----------------------------------------
							: ($type=Is picture:K8:10)
								
								$object.value:=$value
								$object["stroke-width"]:=0
								
								DOM GET XML ATTRIBUTE BY NAME:C728($node; "preserve-aspect-ratio"; $preserveAspectRatio)
								$object["preserve-aspect-ratio"]:=$preserveAspectRatio
								
								PRINT_OBJECT("image"; $object)
								
								// ----------------------------------------
							Else 
								
								If (False:C215)  // ****** NO BACKGROUND
									
									// Background, if any
									If (Length:C16($fill)#0)\
										 | (Length:C16($stroke)#0)
										
										PRINT_OBJECT("rect"; $object)
										
									End if 
								End if 
								
								DOM GET XML ATTRIBUTE BY NAME:C728($node; "alignment"; $alignment)
								
								Case of 
										
										//……………………………………………………
									: ($alignment="center")
										
										OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "variable"; Align center:K42:3)
										OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "VariableWithStyle"; Align center:K42:3)
										
										//……………………………………………………
									: ($alignment="end")
										
										OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "variable"; Align right:K42:4)
										OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "VariableWithStyle"; Align right:K42:4)
										
										//……………………………………………………
									Else 
										
										OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "variable"; Align left:K42:2)
										OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "VariableWithStyle"; Align left:K42:2)
										
										//……………………………………………………
								End case 
								
								DOM GET XML ATTRIBUTE BY NAME:C728($node; "font-size"; $fontSize)
								OBJECT SET FONT SIZE:C165(*; "variable"; $fontSize)
								
								DOM GET XML ATTRIBUTE BY NAME:C728($node; "style"; $style)
								$fontStyle:=Plain:K14:1
								$fontStyle:=Choose:C955($style="@italic@"; $fontStyle | Italic:K14:3; $fontStyle)
								$fontStyle:=Choose:C955($style="@bold@"; $fontStyle | Bold:K14:2; $fontStyle)
								$fontStyle:=Choose:C955($style="@underline@"; $fontStyle | Underline:K14:4; $fontStyle)
								OBJECT SET FONT STYLE:C166(*; "variable"; $fontStyle)
								
								DOM GET XML ATTRIBUTE BY NAME:C728($node; "font-name"; $fontFamilly)
								OBJECT SET FONT:C164(*; "variable"; PRINT_Font($fontFamilly))
								
								//mark:- #DD ACI0104353
								
								var $backgroundColor : Integer
								$backgroundColor:=($fill="none") ? Background color none:K23:10 : Background color:K23:2
								
								DOM GET XML ATTRIBUTE BY NAME:C728($node; "font-color"; $fontColor)
								OBJECT SET RGB COLORS:C628(*; "variable"; Color_to_long($fontColor); $backgroundColor)
								
								$t:=PRINT_Get_text_field($value)
								
								If (str_styledText($t))
									
									(OBJECT Get pointer:C1124(Object named:K67:5; "VariableWithStyle"))->:=$t
									
									$printed:=Print object:C1095(*; \
										"VariableWithStyle"; \
										$left+$horizontalOffset; \
										$top+$verticalOffset; \
										$width; \
										$height)
									
								Else 
									
									(OBJECT Get pointer:C1124(Object named:K67:5; "variable"))->:=$t
									
									$printed:=Print object:C1095(*; \
										"variable"; \
										$left+$horizontalOffset+0.5; \
										$top+$verticalOffset+0.5; \
										$width; \
										$height)
									
								End if 
								
								// ----------------------------------------
						End case 
						
						//________________________________________
				End case 
				
				CLEAR VARIABLE:C89($object)
				
			End for 
			
			$o["label-count"]:=$labelCount
			$o.x:=$x
			$o.y:=$y
			$o["h-offset"]:=$horizontalOffset
			$o["v-offset"]:=$verticalOffset
			
			$stop:=Print_Resume($o)
			
			If (Not:C34($stop))
				
				$x:=Num:C11($o.x)
				$y:=Num:C11($o.y)
				$horizontalOffset:=Num:C11($o["h-offset"])
				$verticalOffset:=Num:C11($o["v-offset"])
				
				If ($labelCount<$perRecord)
					
					$labelCount+=1
					
				Else 
					
					$labelCount:=1
					NEXT RECORD:C51($tablePtr->)
					RELATE ONE:C42($tablePtr->)
					
					If (Length:C16($recordMethod)#0)
						
						$onErrorMethod:=4D_NO_ERROR("ON")
						EXECUTE METHOD:C1007($recordMethod)
						4D_NO_ERROR("OFF"; $onErrorMethod)
						
					End if 
				End if 
			End if 
			
		Until (End selection:C36($tablePtr->)\
			 | (print_ERROR#0) | $stop)
		
	End if 
	
Else 
	
	TRACE:C157
	
End if 

CLOSE PRINTING JOB:C996
FORM UNLOAD:C1299

CLEAR VARIABLE:C89($o)
ON ERR CALL:C155($methodCalledOnError)

// Restore print settings and the printer margins
SET PRINT OPTION:C733(_o_Hide printing progress option:K47:12; $backupProgress)
SET PRINT OPTION:C733(Orientation option:K47:2; $backupOrientation)
SET PRINTABLE MARGIN:C710(-1; -1; -1; -1)

return print_ERROR