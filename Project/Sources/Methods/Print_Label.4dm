//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Print_Label
  // Database: 4D Labels
  // ID[6349290659384A0499FF195E19B79FC1]
  // Created #19-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($Boo_form;$Boo_landscape;$Boo_perLabel;$Boo_preserveAspectRatio;$Boo_preview;$Boo_printed)
C_BOOLEAN:C305($Boo_stop;$Boo_vertical)
C_LONGINT:C283($Lon_backupOrientation;$Lon_backupProgress;$Lon_bottom;$Lon_columns;$Lon_fontSize;$Lon_fontStyle)
C_LONGINT:C283($Lon_height;$Lon_hGap;$Lon_hStartIndex;$Lon_i;$Lon_labelCount;$Lon_labelHeight)
C_LONGINT:C283($Lon_labelWidth;$Lon_left;$Lon_leftMargin;$Lon_objectCount;$Lon_orientation;$Lon_parameters)
C_LONGINT:C283($Lon_perRecord;$Lon_right;$Lon_rightMargin;$Lon_rows;$Lon_startIndex;$Lon_table)
C_LONGINT:C283($Lon_top;$Lon_topMargin;$Lon_type;$Lon_vGap;$Lon_vStartIndex;$Lon_width)
C_LONGINT:C283($Lon_X;$Lon_xOffset;$Lon_Y;$Lon_yOffset)
C_POINTER:C301($Ptr_image;$Ptr_table)
C_REAL:C285($Num_fillOpacity;$Num_hOffset;$Num_strokeOpacity;$Num_strokeWidth;$Num_vOffset;$Num_xPosition)
C_REAL:C285($Num_yPosition)
C_TEXT:C284($Dom_buffer;$Dom_label;$Dom_object;$Dom_objects;$Txt_alignment;$Txt_buffer)
C_TEXT:C284($Txt_codec;$Txt_data;$Txt_direction;$Txt_fill;$Txt_fontColor;$Txt_fontFamilly)
C_TEXT:C284($Txt_form;$Txt_labelMethod;$Txt_labelRecord;$Txt_onErrorCall;$Txt_onErrorMethod;$Txt_stroke)
C_TEXT:C284($Txt_style;$Txt_type;$Txt_value)
C_OBJECT:C1216($Obj_desc;$Obj_print)

ARRAY TEXT:C222($tTxt_objects;0)

If (False:C215)
	C_LONGINT:C283(Print_Label ;$0)
	C_LONGINT:C283(Print_Label ;$1)
	C_TEXT:C284(Print_Label ;$2)
	C_BOOLEAN:C305(Print_Label ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  // Required parameters
	$Lon_table:=$1  // No de la table
	$Dom_label:=$2  // Reference XML
	
	  // Optional parameters
	If ($Lon_parameters>=3)
		
		  //#redmine:18107
		$Boo_preview:=$3
		
	End if 
	
	COMPILER_LABELS 
	COMPILER_PRINT 
	
	$Ptr_table:=Table:C252($Lon_table)
	
	print_ERROR:=0
	
	$Txt_onErrorCall:=Method called on error:C704
	
	ON ERR CALL:C155(Choose:C955(<>Boo_debug;"";"Print_CATCH_ERROR"))
	
	  // Backup the current print settings
	  // Must call before opening job
	  // Need also to turn off progress in database settings
	GET PRINT OPTION:C734(Hide printing progress option:K47:12;$Lon_backupProgress)
	GET PRINT OPTION:C734(Orientation option:K47:2;$Lon_backupOrientation)
	
	  //#ACI0099882 {
	  // Ignore the printer margins but consider the paper's margin
	  //SET PRINTABLE MARGIN(0;0;0;0)
	  //}
	
	  //#ACI0097380
	  // $Lon_backupCaseSensitivity:=Get database parameter(SQL engine case sensitivity)
	  // SET DATABASE PARAMETER(SQL engine case sensitivity;0)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  // Size
$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;"size")
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"width";$Lon_labelWidth)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"height";$Lon_labelHeight)

  // ----------------------------------------------------
  // Settings
$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;"setting")
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"landscape";$Boo_landscape)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"vertical";$Boo_vertical)

  // Set the print settings

SET PRINT OPTION:C733(Hide printing progress option:K47:12;1)

SET PRINT OPTION:C733(Orientation option:K47:2;1+Num:C11($Boo_landscape))

  // ----------------------------------------------------
  // Form to use
$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;"form")
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"name";$Txt_form)

$Boo_form:=(Length:C16($Txt_form)>0)

If ($Boo_form)
	
	  // Calculate columns & rows number according to the form dimensions
	GET PRINTABLE AREA:C703($Lon_height;$Lon_width)
	GET PRINT OPTION:C734(Orientation option:K47:2;$Lon_orientation)
	
	  //#ACI0099200: test below is now commented/
	  //If ($Lon_orientation=2)  // Landscape
	  //$Lon_columns:=$Lon_width\$Lon_labelHeight
	  //$Lon_rows:=$Lon_height\$Lon_labelWidth
	  //Else 
	
	$Lon_columns:=$Lon_width\$Lon_labelWidth
	$Lon_rows:=$Lon_height\$Lon_labelHeight
	
	  //End if 
	
Else 
	
	  //#ACI0099882 {
	  // Ignore the printer margins but consider the paper's margin
	SET PRINTABLE MARGIN:C710(0;0;0;0)
	  //}
	
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_label;"columns";$Lon_columns)
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_label;"rows";$Lon_rows)
	
End if 

DOM GET XML ATTRIBUTE BY NAME:C728($Dom_label;"labels-per-record";$Lon_perRecord)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_label;"start";$Lon_startIndex)

$Lon_xOffset:=(OB Get:C1224(<>label_params;"width";Is longint:K8:6)-$Lon_labelWidth)/2
$Lon_yOffset:=(OB Get:C1224(<>label_params;"height";Is longint:K8:6)-$Lon_labelHeight)/2

  // ----------------------------------------------------
  // Margins
$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;"margin")
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"left";$Lon_leftMargin)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"right";$Lon_rightMargin)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"top";$Lon_topMargin)

  // ----------------------------------------------------
  // Gaps
$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;"gap")
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"horizontal";$Lon_hGap)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"vertical";$Lon_vGap)

  // ----------------------------------------------------
  // Method
$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;"method")

If (OK=1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"evaluate-per-label";$Boo_perLabel)
	
	If ($Boo_perLabel)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"name";$Txt_labelMethod)
		
	Else 
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_buffer;"name";$Txt_labelRecord)
		
	End if 
End if 

OB SET:C1220($Obj_print;\
"vertical";$Boo_vertical;\
"preview";$Boo_preview;\
"rows";$Lon_rows;\
"columns";$Lon_columns;\
"width";$Lon_labelWidth;\
"height";$Lon_labelHeight;\
"left-margin";$Lon_leftMargin;\
"top-margin";$Lon_topMargin;\
"h-gap";$Lon_hGap;\
"v-gap";$Lon_vGap;\
"label-per-record";$Lon_perRecord;\
"table";$Lon_table)

  //======================================================================
OPEN PRINTING JOB:C995

  //======================================================================
If (print_ERROR=0)
	
	If ($Boo_vertical)
		
		$Lon_vStartIndex:=Choose:C955(($Lon_startIndex%$Lon_rows)=0;$Lon_rows;$Lon_startIndex%$Lon_rows)
		$Lon_hStartIndex:=($Lon_startIndex\$Lon_rows)+Num:C11(0#($Lon_startIndex%$Lon_rows))
		
		If ($Lon_hStartIndex>$Lon_columns)\
			 | ($Lon_hStartIndex<1)
			
			$Num_xPosition:=1
			$Num_hOffset:=$Lon_leftMargin
			
		Else 
			
			$Num_xPosition:=$Lon_hStartIndex
			$Num_hOffset:=$Lon_leftMargin+(($Num_xPosition-1)*($Lon_labelWidth+$Lon_hGap))
			
		End if 
		
		If ($Lon_vStartIndex>$Lon_rows)\
			 | ($Lon_vStartIndex<1)
			
			$Num_yPosition:=1
			$Num_vOffset:=$Lon_topMargin
			
		Else 
			
			$Num_yPosition:=$Lon_vStartIndex
			$Num_vOffset:=$Lon_topMargin+(($Num_yPosition-1)*($Lon_labelHeight+$Lon_vGap))
			
		End if 
		
	Else 
		
		$Lon_hStartIndex:=Choose:C955(($Lon_startIndex%$Lon_columns)=0;$Lon_columns;$Lon_startIndex%$Lon_columns)
		$Lon_vStartIndex:=($Lon_startIndex\$Lon_columns)+Num:C11(0#($Lon_startIndex%$Lon_columns))
		
		If ($Lon_hStartIndex>$Lon_columns)\
			 | ($Lon_hStartIndex<1)
			
			$Num_xPosition:=1
			$Num_hOffset:=$Lon_leftMargin
			
		Else 
			
			$Num_xPosition:=$Lon_hStartIndex
			$Num_hOffset:=$Lon_leftMargin+(($Num_xPosition-1)*($Lon_labelWidth+$Lon_hGap))
			
		End if 
		
		If ($Lon_vStartIndex>$Lon_rows)\
			 | ($Lon_vStartIndex<1)
			
			$Num_yPosition:=1
			$Num_vOffset:=$Lon_topMargin
			
		Else 
			
			$Num_yPosition:=$Lon_vStartIndex
			$Num_vOffset:=$Lon_topMargin+(($Num_yPosition-1)*($Lon_labelHeight+$Lon_vGap))
			
		End if 
	End if 
	
	$Lon_labelCount:=1
	
	FIRST RECORD:C50($Ptr_table->)
	
	If (Length:C16($Txt_labelRecord)#0)\
		 & (Is record loaded:C669($Ptr_table->))
		
		$Txt_onErrorMethod:=4D_NO_ERROR ("ON")
		EXECUTE METHOD:C1007($Txt_labelRecord)
		4D_NO_ERROR ("OFF";$Txt_onErrorMethod)
		
	End if 
	
	RELATE ONE:C42($Ptr_table->)
	
	If ($Boo_form)
		
		FORM LOAD:C1103($Ptr_table->;$Txt_form)
		FORM GET OBJECTS:C898($tTxt_objects;*)
		
		Repeat 
			
			If (Length:C16($Txt_labelMethod)#0)
				
				$Txt_onErrorMethod:=4D_NO_ERROR ("ON")
				EXECUTE METHOD:C1007($Txt_labelMethod)
				4D_NO_ERROR ("OFF";$Txt_onErrorMethod)
				
			End if 
			
			If (Length:C16($Txt_labelRecord)#0)
				
				$Txt_onErrorMethod:=4D_NO_ERROR ("ON")
				EXECUTE METHOD:C1007($Txt_labelRecord)
				4D_NO_ERROR ("OFF";$Txt_onErrorMethod)
				
			End if 
			
			For ($Lon_i;1;Size of array:C274($tTxt_objects);1)
				
				If (OBJECT Get visible:C1075(*;$tTxt_objects{$Lon_i}))
					
					OBJECT GET COORDINATES:C663(*;$tTxt_objects{$Lon_i};$Lon_X;$Lon_Y;$Lon_right;$Lon_bottom)
					
					$Boo_printed:=Print object:C1095(*;\
						$tTxt_objects{$Lon_i};\
						$Lon_X+$Num_hOffset;\
						$Lon_Y+$Num_vOffset;\
						$Lon_right-$Lon_X;\
						$Lon_bottom-$Lon_Y)
					
				End if 
			End for 
			
			OB SET:C1220($Obj_print;\
				"label-count";$Lon_labelCount;\
				"x";$Num_xPosition;\
				"y";$Num_yPosition;\
				"h-offset";$Num_hOffset;\
				"v-offset";$Num_vOffset)
			
			$Boo_stop:=Print_Resume ($Obj_print)
			
			If (Not:C34($Boo_stop))
				
				$Num_xPosition:=OB Get:C1224($Obj_print;"x";Is real:K8:4)
				$Num_yPosition:=OB Get:C1224($Obj_print;"y";Is real:K8:4)
				$Num_hOffset:=OB Get:C1224($Obj_print;"h-offset";Is real:K8:4)
				$Num_vOffset:=OB Get:C1224($Obj_print;"v-offset";Is real:K8:4)
				
				If ($Lon_labelCount<$Lon_perRecord)
					
					$Lon_labelCount:=$Lon_labelCount+1
					
				Else 
					
					$Lon_labelCount:=1
					NEXT RECORD:C51($Ptr_table->)
					
					FORM LOAD:C1103(Table:C252($Lon_table)->;$Txt_form)
					
					  // To redraw form
					RELATE ONE:C42($Ptr_table->)
					
					If (Length:C16($Txt_labelRecord)#0)
						
						$Txt_onErrorMethod:=4D_NO_ERROR ("ON")
						EXECUTE METHOD:C1007($Txt_labelRecord)
						4D_NO_ERROR ("OFF";$Txt_onErrorMethod)
						
					End if 
				End if 
			End if 
		Until (End selection:C36($Ptr_table->)\
			 | (print_ERROR#0) | $Boo_stop)
		
	Else 
		
		FORM LOAD:C1103("print")
		
		$Dom_objects:=DOM Find XML element by ID:C1010($Dom_label;"objects")
		$Lon_objectCount:=DOM Count XML elements:C726($Dom_objects;"object")
		
		
		Repeat 
			
			If (Length:C16($Txt_labelMethod)#0)
				
				$Txt_onErrorMethod:=4D_NO_ERROR ("ON")
				EXECUTE METHOD:C1007($Txt_labelMethod)
				4D_NO_ERROR ("OFF";$Txt_onErrorMethod)
				
			End if 
			
			If (Length:C16($Txt_labelRecord)#0)
				
				$Txt_onErrorMethod:=4D_NO_ERROR ("ON")
				EXECUTE METHOD:C1007($Txt_labelRecord)
				4D_NO_ERROR ("OFF";$Txt_onErrorMethod)
				
			End if 
			
			If ($Boo_preview)  // Print the label rect
				
				  //aci0099065 : the Y doesn't have to grow for the preview
				  //OB SET($Obj_desc;\
										"x";$Num_xPosition-1.5;\
										"y";$Num_yPosition-1.5;\
										"h-offset";$Num_hOffset;\
										"v-offset";$Num_vOffset;\
										"width";$Lon_labelWidth-0.5;\
										"height";$Lon_labelHeight-0.5;\
										"stroke";"gray";\
										"stroke-width";0.5;\
										"stroke-opacity";0.5;\
										"fill";"none";\
										"fill-opacity";0;\
										"stroke-dasharray";"1")
				
				OB SET:C1220($Obj_desc;\
					"x";0;\
					"y";0;\
					"h-offset";$Num_hOffset;\
					"v-offset";$Num_vOffset;\
					"width";$Lon_labelWidth-0.5;\
					"height";$Lon_labelHeight-0.5;\
					"stroke";"gray";\
					"stroke-width";0.5;\
					"stroke-opacity";0.5;\
					"fill";"none";\
					"fill-opacity";0;\
					"stroke-dasharray";"1")
				
				PRINT_OBJECT ("round-rect";$Obj_desc)
				
				CLEAR VARIABLE:C89($Obj_desc)
				
			End if 
			
			For ($Lon_i;1;$Lon_objectCount;1)
				
				$Dom_object:=DOM Find XML element:C864($Dom_objects;"objects/object["+String:C10($Lon_i)+"]")
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"type";$Txt_type)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"left";$Lon_left)
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"top";$Lon_top)
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"right";$Lon_right)
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"bottom";$Lon_bottom)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"fill-color";$Txt_fill)
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"fill-opacity";$Num_fillOpacity)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"stroke-color";$Txt_stroke)
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"stroke-width";$Num_strokeWidth)
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"stroke-opacity";$Num_strokeOpacity)
				
				$Lon_width:=$Lon_right-$Lon_left
				$Lon_height:=$Lon_bottom-$Lon_top
				
				$Lon_X:=-$Lon_xOffset+$Lon_left-OB Get:C1224(<>label_params;"left";Is longint:K8:6)
				$Lon_Y:=-$Lon_yOffset+$Lon_top-OB Get:C1224(<>label_params;"top";Is longint:K8:6)
				
				OB SET:C1220($Obj_desc;\
					"x";$Lon_X;\
					"y";$Lon_Y;\
					"h-offset";$Num_hOffset;\
					"v-offset";$Num_vOffset;\
					"width";$Lon_width;\
					"height";$Lon_height;\
					"stroke";$Txt_stroke;\
					"stroke-width";$Num_strokeWidth;\
					"stroke-opacity";$Num_strokeOpacity;\
					"fill";$Txt_fill;\
					"fill-opacity";$Num_fillOpacity)
				
				Case of 
						
						  //________________________________________
					: ($Txt_type="line")
						
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"direction";$Txt_direction)
						OB SET:C1220($Obj_desc;\
							"direction";$Txt_direction)
						
						PRINT_OBJECT ($Txt_type;$Obj_desc)
						
						  //________________________________________
					: ($Txt_type="polyline")
						
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"data";$Txt_data)
						OB SET:C1220($Obj_desc;\
							"data";$Txt_data)
						
						PRINT_OBJECT ($Txt_type;$Obj_desc)
						
						  //________________________________________
					: ($Txt_type="rect")\
						 | ($Txt_type="round-rect")
						
						PRINT_OBJECT ($Txt_type;$Obj_desc)
						
						  //________________________________________
					: ($Txt_type="oval")
						
						  // ********************
						  //$Txt_type:="ellipse"
						  // ********************
						
						PRINT_OBJECT ("ellipse";$Obj_desc)
						
						  //________________________________________
					: ($Txt_type="text")
						
						If (False:C215)  // ****** NO BACKGROUND
							
							  // Background, if any
							If (Length:C16($Txt_fill)#0)\
								 | (Length:C16($Txt_stroke)#0)
								
								PRINT_OBJECT ("rect";$Obj_desc)
								
							End if 
						End if 
						
						  // Text
						  // DOM GET XML ATTRIBUTE BY NAME($Dom_object;"value";$Txt_value) // #ACI0099899
						xml_GET_ATTRIBUTE_BY_NAME ($Dom_object;"value";->$Txt_value)
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"font-name";$Txt_fontFamilly)
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"font-color";$Txt_fontColor)
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"font-size";$Lon_fontSize)
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"style";$Txt_style)
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"alignment";$Txt_alignment)
						
						OB SET:C1220($Obj_desc;\
							"value";$Txt_value;\
							"font-name";$Txt_fontFamilly;\
							"font-size";$Lon_fontSize;\
							"font-color";$Txt_fontColor;\
							"style";$Txt_style;\
							"alignment";$Txt_alignment)
						
						PRINT_OBJECT ("text";$Obj_desc)
						
						  //________________________________________
					: ($Txt_type="image")
						
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"image-data";$Txt_data)
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"image-codec";$Txt_codec)
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"preserve-aspect-ratio";$Boo_preserveAspectRatio)
						
						If (False:C215)
							$Ptr_image:=OBJECT Get pointer:C1124(Object named:K67:5;Choose:C955($Boo_preserveAspectRatio;"ImageWithAspect";"Image"))
							$Ptr_image->:=PRINT_Get_image ($Txt_data;$Txt_codec;".png")
							
							$Boo_printed:=Print object:C1095(*;"ImageWithAspect";$Lon_X+$Num_hOffset;$Lon_Y+$Num_vOffset;$Lon_width;$Lon_height)
							
						Else 
							
							OB SET:C1220($Obj_desc;\
								"image-data";$Txt_data;\
								"image-codec";$Txt_codec;\
								"preserve-aspect-ratio";$Boo_preserveAspectRatio;\
								"stroke-width";0)
							
							PRINT_OBJECT ("image";$Obj_desc)
						End if 
						
						  //________________________________________
					: ($Txt_type="variable")  // Field and more
						
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"field-type";$Lon_type)
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"value";$Txt_value)
						
						Case of 
								
								  // ----------------------------------------
							: ($Lon_type=Is picture:K8:10)
								
								DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"preserve-aspect-ratio";$Boo_preserveAspectRatio)
								
								OB SET:C1220($Obj_desc;\
									"value";$Txt_value;\
									"preserve-aspect-ratio";$Boo_preserveAspectRatio;\
									"stroke-width";0)
								
								PRINT_OBJECT ("image";$Obj_desc)
								
								  // ----------------------------------------
							Else 
								
								If (False:C215)  // ****** NO BACKGROUND
									
									  // Background, if any
									If (Length:C16($Txt_fill)#0)\
										 | (Length:C16($Txt_stroke)#0)
										
										PRINT_OBJECT ("rect";$Obj_desc)
										
									End if 
								End if 
								
								DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"font-name";$Txt_fontFamilly)
								DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"font-size";$Lon_fontSize)
								DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"font-color";$Txt_fontColor)
								DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"style";$Txt_style)
								DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"alignment";$Txt_alignment)
								
								$Lon_fontStyle:=Plain:K14:1
								$Lon_fontStyle:=Choose:C955($Txt_style="@italic@";$Lon_fontStyle | Italic:K14:3;$Lon_fontStyle)
								$Lon_fontStyle:=Choose:C955($Txt_style="@bold@";$Lon_fontStyle | Bold:K14:2;$Lon_fontStyle)
								$Lon_fontStyle:=Choose:C955($Txt_style="@underline@";$Lon_fontStyle | Underline:K14:4;$Lon_fontStyle)
								
								Case of 
										
										  //……………………………………………………
									: ($Txt_alignment="center")
										
										OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"variable";Align center:K42:3)
										OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"VariableWithStyle";Align center:K42:3)
										
										  //……………………………………………………
									: ($Txt_alignment="end")
										
										OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"variable";Align right:K42:4)
										OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"VariableWithStyle";Align right:K42:4)
										
										  //……………………………………………………
									Else 
										
										OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"variable";Align left:K42:2)
										OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"VariableWithStyle";Align left:K42:2)
										
										  //……………………………………………………
								End case 
								
								OBJECT SET FONT SIZE:C165(*;"variable";$Lon_fontSize)
								OBJECT SET FONT STYLE:C166(*;"variable";$Lon_fontStyle)
								OBJECT SET FONT:C164(*;"variable";PRINT_Font ($Txt_fontFamilly))
								OBJECT SET RGB COLORS:C628(*;"variable";Color_to_long ($Txt_fontColor);-2)
								
								$Txt_buffer:=PRINT_Get_text_field ($Txt_value)
								
								If (str_styledText ($Txt_buffer))
									
									(OBJECT Get pointer:C1124(Object named:K67:5;"VariableWithStyle"))->:=$Txt_buffer
									
									$Boo_printed:=Print object:C1095(*;\
										"VariableWithStyle";\
										$Lon_X+$Num_hOffset;\
										$Lon_Y+$Num_vOffset;\
										$Lon_width;\
										$Lon_height)
									
								Else 
									
									(OBJECT Get pointer:C1124(Object named:K67:5;"variable"))->:=$Txt_buffer
									
									$Boo_printed:=Print object:C1095(*;\
										"variable";\
										$Lon_X+$Num_hOffset+0.5;\
										$Lon_Y+$Num_vOffset+0.5;\
										$Lon_width;\
										$Lon_height)
									
								End if 
								
								  // ----------------------------------------
						End case 
						
						  //________________________________________
				End case 
				
				CLEAR VARIABLE:C89($Obj_desc)
				
			End for 
			
			OB SET:C1220($Obj_print;\
				"label-count";$Lon_labelCount;\
				"x";$Num_xPosition;\
				"y";$Num_yPosition;\
				"h-offset";$Num_hOffset;\
				"v-offset";$Num_vOffset)
			
			$Boo_stop:=Print_Resume ($Obj_print)
			
			If (Not:C34($Boo_stop))
				
				$Num_xPosition:=OB Get:C1224($Obj_print;"x";Is real:K8:4)
				$Num_yPosition:=OB Get:C1224($Obj_print;"y";Is real:K8:4)
				$Num_hOffset:=OB Get:C1224($Obj_print;"h-offset";Is real:K8:4)
				$Num_vOffset:=OB Get:C1224($Obj_print;"v-offset";Is real:K8:4)
				
				If ($Lon_labelCount<$Lon_perRecord)
					
					$Lon_labelCount:=$Lon_labelCount+1
					
				Else 
					
					$Lon_labelCount:=1
					NEXT RECORD:C51($Ptr_table->)
					RELATE ONE:C42($Ptr_table->)
					
					If (Length:C16($Txt_labelRecord)#0)
						
						$Txt_onErrorMethod:=4D_NO_ERROR ("ON")
						EXECUTE METHOD:C1007($Txt_labelRecord)
						4D_NO_ERROR ("OFF";$Txt_onErrorMethod)
						
					End if 
				End if 
			End if 
			
		Until (End selection:C36($Ptr_table->)\
			 | (print_ERROR#0) | $Boo_stop)
		
		
	End if 
	
Else 
	
	TRACE:C157
	
End if 

  //======================================================================
CLOSE PRINTING JOB:C996

  //Case of
  //  //______________________________________________________
  //: (End selection($Ptr_table->))
  //ALERT("fin de selection")
  //  //______________________________________________________
  //: (print_ERROR#0)
  //ALERT("error: "+String(print_ERROR))
  //  //______________________________________________________
  //: ($Boo_stop)
  //ALERT("stopped")
  //  //______________________________________________________
  //Else
  //ALERT("ok")
  //  //______________________________________________________
  //End case

FORM UNLOAD:C1299

CLEAR VARIABLE:C89($Obj_print)

ON ERR CALL:C155($Txt_onErrorCall)

  //======================================================================

  // Restore print settings and the printer margins
SET PRINT OPTION:C733(Hide printing progress option:K47:12;$Lon_backupProgress)
SET PRINT OPTION:C733(Orientation option:K47:2;$Lon_backupOrientation)
SET PRINTABLE MARGIN:C710(-1;-1;-1;-1)


  //#ACI0097380

  // SET DATABASE PARAMETER(SQL engine case sensitivity;$Lon_backupCaseSensitivity)

  // ----------------------------------------------------
  // Return
$0:=print_ERROR

  // ----------------------------------------------------
  // End