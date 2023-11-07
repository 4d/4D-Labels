//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_Field_drop
// Database: 4D Labels
// ID[1FEA1E4A1A824D509A5586011B3963C2]
// Created #11-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_BLOB:C604($blob)
C_BOOLEAN:C305($isAdded; $isNewLine; $Boo_OK)
C_LONGINT:C283($kLon_leftOffset; $kLon_topOffset; $Lon_; $bottom; $count; $fieldID)
C_LONGINT:C283($editorHeight; $i; $left; $mouseX; $mouseY)
C_LONGINT:C283($right; $Lon_stepX; $Lon_stepY; $tableID; $textHeight; $textWidth)
C_LONGINT:C283($top; $type; $Lon_viewPortHeight; $Lon_viewPortWidth; $editorWidth)
C_REAL:C285($Num_cx; $Num_cy; $Num_offsetX; $Num_offsetY; $rotation; $Num_tx)
C_REAL:C285($Num_ty; $x; $y; $zoom)
C_TEXT:C284($node; $canvas; $defs; $group; $root)
C_TEXT:C284($groupObjects; $rect; $textArea; $t; $dragOverObject; $fontColor)
C_TEXT:C284($font; $ID; $label)
C_OBJECT:C1216($o; $formData)

ARRAY LONGINT:C221($fieldNumbers; 0)
ARRAY LONGINT:C221($tableNumbers; 0)
ARRAY LONGINT:C221($fieldTypes; 0)
ARRAY TEXT:C222($objects; 0)
ARRAY TEXT:C222($IDs; 0)

If (False:C215)
	C_BOOLEAN:C305(Editor_Field_drop; $0)
	C_TEXT:C284(Editor_Field_drop; $1)
End if 

// ----------------------------------------------------
// Initialisations
If (Asserted:C1132(Count parameters:C259>=1; "Missing parameter"))
	
	// Required parameters
	$root:=$1
	
	GET MOUSE:C468($mouseX; $mouseY; $Lon_)
	
	$formData:=(OBJECT Get pointer:C1124(Object named:K67:5; "object"))->
	$canvas:=OB Get:C1224($formData; "canvas"; Is text:K8:3)
	
	$zoom:=Editor_Get_zoom
	
	$isNewLine:=Shift down:C543
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
GET PASTEBOARD DATA:C401("com.4d.array.table"; $blob)

If (BLOB size:C605($blob)#0)
	
	BLOB TO VARIABLE:C533($blob; $tableNumbers)
	SET BLOB SIZE:C606($blob; 0)
	
	GET PASTEBOARD DATA:C401("com.4d.array.field"; $blob)
	
	If (BLOB size:C605($blob)#0)
		
		BLOB TO VARIABLE:C533($blob; $fieldNumbers)
		SET BLOB SIZE:C606($blob; 0)
		
		GET PASTEBOARD DATA:C401("com.4d.array.field.type"; $blob)
		
		If (BLOB size:C605($blob)#0)
			
			BLOB TO VARIABLE:C533($blob; $fieldTypes)
			SET BLOB SIZE:C606($blob; 0)
			
			// Local coordinates in editor
			$x:=$mouseX-OB Get:C1224($formData; "offset-X"; Is longint:K8:6)+50
			$y:=$mouseY-OB Get:C1224($formData; "offset-Y"; Is longint:K8:6)
			
			$node:=SVG Find element ID by coordinates:C1054(*; "Image"; $x; $y)
			
			$node:=Replace string:C233($node; OB Get:C1224(<>label_params; "select-rect-prefix"; Is text:K8:3); ""; *)
			SVG GET ATTRIBUTE:C1056(*; "Image"; $node; "editor:object-id"; $dragOverObject)
			
			$node:=DOM Find XML element by ID:C1010($root; "size")
			DOM GET XML ATTRIBUTE BY NAME:C728($node; "width"; $editorWidth)
			DOM GET XML ATTRIBUTE BY NAME:C728($node; "height"; $editorHeight)
			
			$Num_offsetX:=(OB Get:C1224(<>label_params; "width"; Is longint:K8:6)-$editorWidth)/2
			$Num_offsetY:=(OB Get:C1224(<>label_params; "height"; Is longint:K8:6)-$editorHeight)/2
			
			$kLon_leftOffset:=OB Get:C1224(<>label_params; "left"; Is longint:K8:6)
			$kLon_topOffset:=OB Get:C1224(<>label_params; "top"; Is longint:K8:6)
			
			// 0,0 relative to label
			$left:=$kLon_leftOffset+$Num_offsetX
			$top:=$kLon_topOffset+$Num_offsetY
			
			OBJECT GET SUBFORM CONTAINER SIZE:C1148($Lon_viewPortWidth; $Lon_viewPortHeight)
			$Lon_viewPortHeight:=$Lon_viewPortHeight-OB Get:C1224(<>label_params; "image-left"; Is longint:K8:6)
			
			$Num_cx:=$Lon_viewPortWidth/2
			$Num_cy:=$Lon_viewPortHeight/2
			
			$Num_tx:=$Num_cx-(($editorWidth*$zoom)/2)
			$Num_ty:=$Num_cy-(($editorHeight*$zoom)/2)
			
			$defs:=DOM Find XML element by ID:C1010($canvas; "defs")
			
			$groupObjects:=DOM Find XML element by ID:C1010($root; "objects")
			$count:=DOM Count XML elements:C726($groupObjects; "object")
			
			$font:=OB Get:C1224($formData; "default-font"; Is text:K8:3)
			
			$Lon_stepX:=OB Get:C1224($formData; "step-X"; Is longint:K8:6)
			$Lon_stepY:=OB Get:C1224($formData; "step-Y"; Is longint:K8:6)
			$label:=""
			
			For ($i; 1; Size of array:C274($tableNumbers); 1)
				
				$type:=$fieldTypes{$i}
				$tableID:=$tableNumbers{$i}
				$fieldID:=$fieldNumbers{$i}
				
				$label:=$label+Parse formula:C1576("[:"+String:C10($tableID)+"]:"+String:C10($fieldID); Formula out with virtual structure:K88:2)
				
				// Compute text sizes
				OB SET:C1220($o; \
					"value"; $label; \
					"font"; $font; \
					"font-size"; 9; \
					"style"; "normal"; \
					"weight"; "normal"; \
					"align"; "start"; \
					"decoration"; "none")
				
				Editor_TEXT_COMPUTE_SIZE($o)
				
				$textWidth:=OB Get:C1224($o; "width"; Is longint:K8:6)
				$textHeight:=OB Get:C1224($o; "height"; Is longint:K8:6)
				
				CLEAR VARIABLE:C89($o)
				
				$isAdded:=False:C215
				
				If (Length:C16($dragOverObject)#0)
					
					SVG GET ATTRIBUTE:C1056(*; "Image"; $dragOverObject; "editor:object-type"; $t)
					
					If (($t="variable/text")\
						 & ($type#Is picture:K8:10))\
						 | (($t="variable/image") & ($type=Is picture:K8:10))
						
						$isAdded:=True:C214
						
					End if 
				End if 
				
				If ($isAdded)
					
					$node:=DOM Find XML element by ID:C1010($root; $dragOverObject)
					
					$group:=DOM Find XML element by ID:C1010($canvas; $dragOverObject)
					$rect:=DOM Find XML element by ID:C1010($canvas; $dragOverObject+"-rect")
					$textArea:=DOM Find XML element by ID:C1010($canvas; $dragOverObject+"-textArea")
					
					DOM GET XML ATTRIBUTE BY NAME:C728($node; "left"; $left)
					DOM GET XML ATTRIBUTE BY NAME:C728($node; "top"; $top)
					
					SVG GET ATTRIBUTE:C1056(*; "Image"; $dragOverObject+"-textArea"; "4D-text"; $t)
					
					$label:=$t+Choose:C955($isNewLine; "\n"; "+")+$label
					
					OB SET:C1220($o; \
						"value"; $label; \
						"font"; $font; \
						"font-size"; 9; \
						"style"; "normal"; \
						"weight"; "normal"; \
						"align"; "start"; \
						"decoration"; "none")
					
					Editor_TEXT_COMPUTE_SIZE($o)
					
					$right:=$left+OB Get:C1224($o; "width"; Is longint:K8:6)
					$bottom:=$top+OB Get:C1224($o; "height"; Is longint:K8:6)
					
					CLEAR VARIABLE:C89($o)
					
					DOM SET XML ATTRIBUTE:C866($node; \
						"left"; $left; \
						"right"; $right; \
						"top"; $top; \
						"bottom"; $bottom; \
						"value"; $label)
					
					Editor_TEXT_EDIT_SET_VALUE($textArea; $label)
					
				Else 
					
					$left:=($x/$zoom)+$kLon_leftOffset-($textWidth/2)-(-$Num_offsetX+($Num_tx/$zoom))
					$top:=($y/$zoom)+$kLon_topOffset-($textHeight/2)-(-$Num_offsetY+($Num_ty/$zoom))
					
					$left:=$left+(($Lon_stepX*($i-1))/$zoom)
					$top:=$top+(($Lon_stepY*($i-1))/$zoom)
					
					$right:=$left+$textWidth
					$bottom:=$top+$textHeight
					
					$ID:=OB Get:C1224(<>label_params; "objectPrefix"; Is text:K8:3)+String:C10($count+$i)
					
					$node:=DOM Create XML element:C865($groupObjects; "object"; \
						"type"; "variable"; \
						"left"; $left; \
						"top"; $top; \
						"right"; $right; \
						"bottom"; $bottom; \
						"table"; $tableID; \
						"field"; $fieldID; \
						"field-type"; $type; \
						"font-name"; $font; \
						"font-size"; 9; \
						"font-color"; "black"; \
						"preserve-aspect-ratio"; "true"; \
						"direction"; "down"; \
						"fill-opacity"; 1; \
						"stroke-opacity"; 1; \
						"stroke-color"; "black"; \
						"fill-color"; "none"; \
						"stroke-width"; 0; \
						"value"; $label; \
						"style"; "plain"; \
						"alignment"; "left"; \
						"id"; $ID)
					
					OB SET:C1220($o; \
						"type"; "variable"; \
						"id"; $ID; \
						"canvas"; $canvas; \
						"defs"; $defs; \
						"x"; $mouseX; \
						"y"; $mouseY; \
						"width"; $textWidth; \
						"height"; $textHeight; \
						"fill"; "rgb(255,255,255)"; \
						"stroke"; "rgb(0,0,0)"; \
						"fill-opacity"; 0; \
						"stroke-opacity"; 0; \
						"stroke-width"; 0; \
						"font-family"; $font; \
						"font-size"; 9; \
						"font-style"; "normal"; \
						"font-weight"; "normal"; \
						"text-decoration"; "none"; \
						"text-align"; "start"; \
						"value"; $label; \
						"field-type"; $type; \
						"editor-x"; $x; \
						"editor-y"; $y; \
						"editor-width"; $editorWidth; \
						"editor-height"; $editorHeight; \
						"x-scaling"; $zoom; \
						"y-scaling"; $zoom; \
						"cx"; 0; \
						"cy"; 0; \
						"r"; $rotation)
					
					$group:=Editor_Put_object($o)
					
					CLEAR VARIABLE:C89($o)
					
					APPEND TO ARRAY:C911($objects; $group)
					APPEND TO ARRAY:C911($IDs; $ID)
					
				End if 
				
				ARRAY LONGINT:C221($tables; 0x0000)
				ARRAY LONGINT:C221($fields; 0x0000)
				
				xml_GET_ATTRIBUTE_BY_NAME($node; "tableList"; ->$t)
				
				If (Length:C16($t)>0)
					
					JSON PARSE ARRAY:C1219($t; $tables)
					
					xml_GET_ATTRIBUTE_BY_NAME($node; "fieldList"; ->$t)
					
					If (Length:C16($t)>0)
						
						JSON PARSE ARRAY:C1219($t; $fields)
						
					End if 
				End if 
				
				APPEND TO ARRAY:C911($tables; $tableID)
				APPEND TO ARRAY:C911($fields; $fieldID)
				
				DOM SET XML ATTRIBUTE:C866($node; \
					"pairs"; Size of array:C274($tables); \
					"tableList"; JSON Stringify array:C1228($tables); \
					"fieldList"; JSON Stringify array:C1228($fields))
				
			End for 
			
			If (Not:C34($isAdded))
				
				// Manage selection
				Editor_SELECT_Clear
				
				For ($i; 1; Size of array:C274($objects); 1)
					
					Editor_SELECT_OBJECT($objects{$i}; $IDs{$i})
					
				End for 
			End if 
			
			Editor_ON_DATA_CHANGE  // Do redraw
			
			$Boo_OK:=True:C214
			
		End if 
	End if 
End if 

// ----------------------------------------------------
// Return
$0:=$Boo_OK

// ----------------------------------------------------
// End