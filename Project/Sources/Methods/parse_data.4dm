//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : parse_data
  // Database: 4D Labels
  // ID[9989CE0078D84125B76DFD39DDB5696A]
  // Created #21-11-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Modified by Vincent de Lachaux (08/03/17)
  // ACI0096524 - ACI0095670
  // ----------------------------------------------------
  // Description:
  // Parse a binary label file given as blob
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_POINTER:C301($1)
C_BOOLEAN:C305($2)

C_BLOB:C604($Blb_objectStyle;$Blb_PICT;$Blb_PRNT)
C_BOOLEAN:C305($Boo_autoWidth;$Boo_includePrintSettings;$Boo_isValid;$Boo_landscape;$Boo_oncePerLabel;$Boo_verticalFill)
C_LONGINT:C283($kLon_defaultRoundRect;$Lon_borderWidth;$Lon_bottom;$Lon_countElements;$Lon_countTableFieldPairs;$Lon_dummy)
C_LONGINT:C283($Lon_field;$Lon_frameBackColor;$Lon_frameForeColor;$Lon_hOffset;$Lon_i;$Lon_j)
C_LONGINT:C283($Lon_justification;$Lon_layoutNb;$Lon_left;$Lon_objectBackColor;$Lon_objectForeColor;$Lon_objectSize)
C_LONGINT:C283($Lon_objectType;$Lon_objFieldType;$Lon_offset;$Lon_offsetBackup;$Lon_parameters;$Lon_right)
C_LONGINT:C283($Lon_styleSheet;$Lon_table;$Lon_top;$Lon_unit;$Lon_version;$Lon_vOffset)
C_PICTURE:C286($Pic_buffer)
C_POINTER:C301($Ptr_source)
C_TEXT:C284($Dom_buffer;$Dom_element;$Dom_gap;$Dom_margin;$Dom_printSettings;$Dom_rect)
C_TEXT:C284($Dom_rects;$Dom_selects;$Dom_setting;$Dom_size;$Dom_xml;$kTxt_objectPrefix)
C_TEXT:C284($Txt_alignment;$Txt_buffer;$Txt_codec;$Txt_document;$Txt_fontName;$Txt_layoutName)
C_TEXT:C284($Txt_PRPF;$Txt_PRPS;$Txt_style;$Txt_type;$Txt_variableName)

If (False:C215)
	C_TEXT:C284(parse_data ;$0)
	C_POINTER:C301(parse_data ;$1)
	C_BOOLEAN:C305(parse_data ;$2)
End if 

/* File format for 4D labels.
The format is based on IFF:
http://en.wikipedia.org/wiki/Interchange_File_Format
http://www.martinreddy.net/gfx/2d/IFF.txt
*/

/* Utility structure definitions used in file format.
RECT
WORDtop
WORDleft
WORDbottom
WORDright

PATTERN
BYTE[8]pat// MacOS Pattern structure
*/

/* File format

BEGIN FORM 'ETI4'

BEGIN CHUNK 'Desc'
WORD67// version number
WORDcountElements
END 'Desc'

BEGIN CHUNK 'Bloc'
RECTareaRect
RECTareaRect2
RECTpaperRect
RECTpageRect
RECTpageScreenRect
RECTrealLabelRect
RECTlabelRect
BOOLautoLabelWidth
BOOLlandScapePrint
BOOLverticalFill
BOOLoncePerLabel
WORDtoolSelected
WORDobjSelected
WORDobjLastSelected
WORDlabelWidth
WORDlabelHeight
WORDlabelStart
WORDnbLines
WORDnbColumns
WORDtopMargin
WORDbottomMargin
WORDleftMargin
WORDrightMargin
WORDhGap
WORDvGap
WORDlabelsPerRec
WORDlayoutNb
CHAR[42]layoutName
CHAR[42]standardCode
CHAR[42]procName
LONGBFiller1
LONGBFiller2
LONGBFiller3
LONGunit
CHAR[256]documentName - with  length byte prefix
END 'Bloc'

BEGIN CHUNK 'PRPS' - MacOS print settings
END 'PRPS'

BEGIN CHUNK 'PRPF' - MacOS print page format
END 'PRPF'

BEGIN CHUNK 'PRNT' - 120 bytes MacOS TPrint structure
END CHUNK 'PRNT'

LOOP countElements - countElements has been read in chunk 'Desc'

BEGIN CHUNK 'PICT' - MacOS Pict data for a picture element
END 'PICT'

BEGIN CHUNK 'FFTS' - list of pairs (table,field)
LOOP
WORDtableNo
WORDfieldNo
END LOOP
END 'FFTS'

BEGIN CHUNK 'TEXT'
CHAR[]objectText
END 'TEXT'

BEGIN CHUNK 'Elem'
RECTobjectRect
PATTERNframePat
PATTERNobjectPat
BYTEobjectStyle
WORDobjectTextLength
CHAR[42]variableName
CHAR[42]objectName
CHAR[42]objectFontName
WORDobjectFontNb
WORDframeThickness
WORDframeForeColor
WORDframeBackColor
WORDobjectStyleSheet
WORDobjectSize
WORDobjectJust
WORDobjectType
WORDobjectForeColor
WORDobjectBackColor
WORDobjFieldType
WORDcountTableFieldPairs
LONGFiller1
LONGFiller2
LONGFiller3
LONGFiller4
END 'Elem'

END LOOP

END FORM 'ETI4'
*/

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	ASSERT:C1129(Not:C34(Is nil pointer:C315($1)))
	ASSERT:C1129(Type:C295($1->)=Is BLOB:K8:12)
	
	$Ptr_source:=$1  //4LB document as blob
	$Boo_includePrintSettings:=True:C214
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Boo_includePrintSettings:=$2
		
	End if 
	
	$kLon_defaultRoundRect:=OB Get:C1224(<>label_params;"defaultRoundRect";Is longint:K8:6)
	$kTxt_objectPrefix:=OB Get:C1224(<>label_params;"objectPrefix";Is text:K8:3)
	
	ARRAY TEXT:C222($tTxt_codecs;0x0000)
	PICTURE CODEC LIST:C992($tTxt_codecs)
	
	$Dom_xml:=DOM Create XML Ref:C861("label")
	
	  //#ACI0095670 {
	$Lon_vOffset:=24
	$Lon_hOffset:=60
	  //}
	
Else 
	
	ABORT:C156
	
End if 

If (Caps lock down:C547)
	
	TRACE:C157
	
End if 

  // ----------------------------------------------------
$Dom_selects:=DOM Create XML element:C865($Dom_xml;"selects";\
"id";"selects")

XML SET OPTIONS:C1090($Dom_xml;XML indentation:K45:34;XML with indentation:K45:35)

/* #ACI0096524
 $Lon_blobSize:=BLOB size($Ptr_source->)
 If ($Lon_blobSize>=10021)  //Minimum label file size
*/

If (IFF_Is_group ("FORM";$Ptr_source;->$Lon_offset))
	
	  //BEGIN FORM 'ETI4'
	IFF_Get_long ($Ptr_source;->$Lon_offset)
	
	If (IFF_Is_group ("ETI4";$Ptr_source;->$Lon_offset))
		
		If (IFF_Is_group ("Desc";$Ptr_source;->$Lon_offset))
			
			  //BEGIN CHUNK 'Desc'
			IFF_Get_long ($Ptr_source;->$Lon_offset)
			
			  //WORD67 version number always 67
			$Lon_version:=IFF_Get_short ($Ptr_source;->$Lon_offset)
			
			  //WORDcountElements
			$Lon_countElements:=IFF_Get_short ($Ptr_source;->$Lon_offset)
			
			If (IFF_Is_group ("Bloc";$Ptr_source;->$Lon_offset))
				
				  //BEGIN CHUNK 'Bloc'
				IFF_Get_long ($Ptr_source;->$Lon_offset)  //522
				
				  //RECTareaRect - horizontal
				  //RECTareaRect2 - vertical
				  //RECTpaperRect
				  //RECTpageRect
				  //RECTpageScreenRect
				  //RECTrealLabelRect - after scaling
				  //RECTlabelRect
				If (False:C215)  //(ignored)
					
					$Dom_rects:=DOM Create XML element:C865($Dom_xml;"rects";\
						"id";"rects")
					
					  //RECTareaRect - horizontal
					IFF_GET_RECT ($Ptr_source;->$Lon_top;->$Lon_left;->$Lon_bottom;->$Lon_right;->$Lon_offset)  //rect-horizontal
					$Dom_rect:=DOM Create XML element:C865($Dom_rects;"rect";\
						"id";"rect-horizontal";\
						"type";"horizontal";\
						"top";$Lon_top;\
						"left";$Lon_left;\
						"bottom";$Lon_bottom;\
						"right";$Lon_right)
					
					  //RECTareaRect2 - vertical
					IFF_GET_RECT ($Ptr_source;->$Lon_top;->$Lon_left;->$Lon_bottom;->$Lon_right;->$Lon_offset)  //rect-vertical
					$Dom_rect:=DOM Create XML element:C865($Dom_rects;"rect";\
						"id";"rect-vertical";\
						"type";"vertical";\
						"top";$Lon_top;\
						"left";$Lon_left;\
						"bottom";$Lon_bottom;\
						"right";$Lon_right)
					
					  //RECTpaperRect
					IFF_GET_RECT ($Ptr_source;->$Lon_top;->$Lon_left;->$Lon_bottom;->$Lon_right;->$Lon_offset)  //rect-paper
					$Dom_rect:=DOM Create XML element:C865($Dom_rects;"rect";\
						"id";"rect-paper";\
						"type";"paper";\
						"top";$Lon_top;\
						"left";$Lon_left;\
						"bottom";$Lon_bottom;\
						"right";$Lon_right)
					
					  //RECTpageRect
					IFF_GET_RECT ($Ptr_source;->$Lon_top;->$Lon_left;->$Lon_bottom;->$Lon_right;->$Lon_offset)  //rect-page
					$Dom_rect:=DOM Create XML element:C865($Dom_rects;"rect";\
						"id";"rect-page";\
						"type";"page";\
						"top";$Lon_top;\
						"left";$Lon_left;\
						"bottom";$Lon_bottom;\
						"right";$Lon_right)
					
					  //RECTpageScreenRect
					IFF_GET_RECT ($Ptr_source;->$Lon_top;->$Lon_left;->$Lon_bottom;->$Lon_right;->$Lon_offset)  //rect-page-screen
					$Dom_rect:=DOM Create XML element:C865($Dom_rects;"rect";\
						"id";"rect-page-screen";\
						"type";"page-screen";\
						"top";$Lon_top;\
						"left";$Lon_left;\
						"bottom";$Lon_bottom;\
						"right";$Lon_right)
					
					  //RECTrealLabelRect - after scaling
					IFF_GET_RECT ($Ptr_source;->$Lon_top;->$Lon_left;->$Lon_bottom;->$Lon_right;->$Lon_offset)  //rect-post-scaling
					$Dom_rect:=DOM Create XML element:C865($Dom_rects;"rect";\
						"id";"rect-post-scaling";\
						"type";"post-scaling";\
						"top";$Lon_top;\
						"left";$Lon_left;\
						"bottom";$Lon_bottom;\
						"right";$Lon_right)
					
					  //RECTlabelRect
					IFF_GET_RECT ($Ptr_source;->$Lon_top;->$Lon_left;->$Lon_bottom;->$Lon_right;->$Lon_offset)  //rect-label
					$Dom_rect:=DOM Create XML element:C865($Dom_rects;"rect";\
						"id";"rect-label";\
						"type";"label";\
						"top";$Lon_top;\
						"left";$Lon_left;\
						"bottom";$Lon_bottom;\
						"right";$Lon_right)
					
				Else 
					
					  //#ACI0095670 {
					  //IFF_FILLER (56;->$Lon_offset)
					IFF_FILLER (40;->$Lon_offset)
					IFF_GET_RECT ($Ptr_source;->$Lon_top;->$Lon_left;->$Lon_bottom;->$Lon_right;->$Lon_offset)  //rect-post-scaling
					
					If ($Lon_top=113)\
						 & ($Lon_left=354)
						
						$Lon_vOffset:=0
						$Lon_hOffset:=0
						
					End if 
					
					IFF_FILLER (8;->$Lon_offset)
					  //}
					
				End if 
				
				  //BOOLautoLabelWidth [always False] & BOOLlandScapePrint
				IFF_Get_BOOL ($Ptr_source;->$Boo_autoWidth;->$Boo_landscape;->$Lon_offset)
				
				  //BOOLverticalFill & BOOLoncePerLabel
				IFF_Get_BOOL ($Ptr_source;->$Boo_verticalFill;->$Boo_oncePerLabel;->$Lon_offset)
				
				  //settings
				$Dom_setting:=DOM Create XML element:C865($Dom_xml;"setting";\
					"id";"setting";\
					"vertical";$Boo_verticalFill;\
					"auto-width";$Boo_autoWidth;\
					"landscape";$Boo_landscape)
				
				  //WORDtoolSelected (ignored)
				  //WORDobjSelected (ignored)
				  //WORDobjLastSelected (ignored)
				IFF_FILLER (6;->$Lon_offset)
				
				  //WORDlabelWidth & WORDlabelHeight -in pixels
				$Dom_size:=DOM Create XML element:C865($Dom_xml;"size";\
					"id";"size";\
					"width";IFF_Get_short ($Ptr_source;->$Lon_offset);\
					"height";IFF_Get_short ($Ptr_source;->$Lon_offset))
				
				  //WORDlabelStart & WORDnbLines & WORDnbColumns
				DOM SET XML ATTRIBUTE:C866($Dom_xml;\
					"start";IFF_Get_short ($Ptr_source;->$Lon_offset);\
					"rows";IFF_Get_short ($Ptr_source;->$Lon_offset);\
					"columns";IFF_Get_short ($Ptr_source;->$Lon_offset))
				
				  //WORDtopMargin & WORDbottomMargin & WORDleftMargin & WORDrightMargin
				$Dom_margin:=DOM Create XML element:C865($Dom_xml;"margin";\
					"id";"margin";\
					"top";IFF_Get_short ($Ptr_source;->$Lon_offset);\
					"bottom";IFF_Get_short ($Ptr_source;->$Lon_offset);\
					"left";IFF_Get_short ($Ptr_source;->$Lon_offset);\
					"right";IFF_Get_short ($Ptr_source;->$Lon_offset))
				
				  //WORDhGap & WORDvGap
				$Dom_gap:=DOM Create XML element:C865($Dom_xml;"gap";\
					"id";"gap";\
					"horizontal";IFF_Get_short ($Ptr_source;->$Lon_offset);\
					"vertical";IFF_Get_short ($Ptr_source;->$Lon_offset))
				
				  //WORDlabelsPerRec
				DOM SET XML ATTRIBUTE:C866($Dom_xml;\
					"labels-per-record";IFF_Get_short ($Ptr_source;->$Lon_offset))
				
				  //WORDlayoutNb
				$Lon_layoutNb:=IFF_Get_short ($Ptr_source;->$Lon_offset)
				
				  //124
				If ($Lon_layoutNb#-1)\
					 & ($Lon_layoutNb>0)  // #ACI0099899
					
					  // CHAR[42]layoutName
					$Txt_layoutName:=IFF_Get_pascal_text (42;$Ptr_source;->$Lon_offset)
					
				Else 
					
					IFF_FILLER (42;->$Lon_offset)
					
				End if 
				
				$Dom_buffer:=DOM Create XML element:C865($Dom_xml;"form";\
					"id";"form";\
					"name";$Txt_layoutName;\
					"number";$Lon_layoutNb)
				
				  //CHAR[42]standardCode
				DOM SET XML ATTRIBUTE:C866($Dom_xml;\
					"standard-code";IFF_Get_pascal_text (42;$Ptr_source;->$Lon_offset))
				
				  //CHAR[42]procName
				$Dom_buffer:=DOM Create XML element:C865($Dom_xml;"method";\
					"id";"method";\
					"name";IFF_Get_pascal_text (42;$Ptr_source;->$Lon_offset);\
					"evaluate-per-label";$Boo_oncePerLabel)
				
				  //LONGBFiller1 (unused)
				  //LONGBFiller2 (unused)
				  //LONGBFiller3 (unused)
				IFF_FILLER (12;->$Lon_offset)
				
				  //LONGunit
				$Lon_unit:=IFF_Get_long ($Ptr_source;->$Lon_offset) & 3  //3:inch - 2:cm - 1:mm - 0:pt
				DOM SET XML ATTRIBUTE:C866($Dom_size;\
					"unit";Choose:C955($Lon_unit;"pt";"mm";"cm";"in"))
				
				  //CHAR[256]documentName
				$Txt_document:=IFF_Get_pascal_text (256;$Ptr_source;->$Lon_offset)  //only present when saved from editor
				DOM SET XML ATTRIBUTE:C866($Dom_xml;\
					"document-name";$Txt_document)
				
				  //END 'Bloc'
				IFF_PAD_CHUNK (->$Lon_offset)  //522
				
/* #ACI0096524
If (IFF_Is_group ("PRPS";$Ptr_source;->$Lon_offset))
$Txt_PRPS:=IFF_Get_text ($Ptr_source;->$Lon_offset)
IFF_PAD_CHUNK (->$Lon_offset)
If (IFF_Is_group ("PRPF";$Ptr_source;->$Lon_offset))
$Txt_PRPF:=IFF_Get_text ($Ptr_source;->$Lon_offset)
IFF_PAD_CHUNK (->$Lon_offset)
*/
				
				$Lon_offsetBackup:=$Lon_offset
				
				If (IFF_Is_group ("PRPS";$Ptr_source;->$Lon_offset))
					
					$Txt_PRPS:=IFF_Get_text ($Ptr_source;->$Lon_offset)
					IFF_PAD_CHUNK (->$Lon_offset)
					
					$Lon_offsetBackup:=$Lon_offset
					
				Else 
					
					$Lon_offset:=$Lon_offsetBackup
					
				End if 
				
				If (IFF_Is_group ("PRPF";$Ptr_source;->$Lon_offset))
					
					$Txt_PRPF:=IFF_Get_text ($Ptr_source;->$Lon_offset)
					IFF_PAD_CHUNK (->$Lon_offset)
					
					$Lon_offsetBackup:=$Lon_offset
					
				Else 
					
					$Lon_offset:=$Lon_offsetBackup
					
				End if 
				  //}
				
				If (IFF_Is_group ("PRNT";$Ptr_source;->$Lon_offset))
					
					$Blb_PRNT:=IFF_Get_data ($Ptr_source;->$Lon_offset)
					IFF_PAD_CHUNK (->$Lon_offset)
					
					ARRAY TEXT:C222($tDom_items;$Lon_countElements)
					
					$Dom_element:=DOM Create XML element:C865($Dom_xml;"objects";\
						"id";"objects")
					
					For ($Lon_i;1;$Lon_countElements;1)
						
						CLEAR VARIABLE:C89($Txt_type)
						
						While ($Txt_type#"Elem")
							
							$Txt_type:=IFF_Get_type ($Ptr_source;->$Lon_offset)
							
							If ($Txt_type="PICT")\
								 | ($Txt_type="FFTS")\
								 | ($Txt_type="TEXT")\
								 | ($Txt_type="Elem")
								
								If (Length:C16($tDom_items{$Lon_i})=0)
									
									$tDom_items{$Lon_i}:=DOM Create XML element:C865($Dom_element;"object";\
										"id";$kTxt_objectPrefix+String:C10($Lon_i))
									
								End if 
							End if 
							
							Case of 
									
									  //________________________________________
								: ($Txt_type="PICT")
									
									$Blb_PICT:=IFF_Get_data ($Ptr_source;->$Lon_offset)
									IFF_PAD_CHUNK (->$Lon_offset)
									
									XML SET OPTIONS:C1090($tDom_items{$Lon_i};XML binary encoding:K45:37;XML base64:K45:38)
									XML SET OPTIONS:C1090($tDom_items{$Lon_i};XML picture encoding:K45:40;XML convert to PNG:K45:41)
									
									  //find a codec usable {
									$Txt_codec:=".png"
									
									For ($Lon_j;1;Size of array:C274($tTxt_codecs);1)
										
										BLOB TO PICTURE:C682($Blb_PICT;$Pic_buffer;$tTxt_codecs{$Lon_j})
										
										If (OK=1)
											
											$Txt_codec:=$tTxt_codecs{$Lon_j}
											$Lon_j:=MAXLONG:K35:2-1
											
										End if 
									End for 
									  //}
									
									DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
										"image-data";$Blb_PICT;\
										"image-hash";Generate digest:C1147($Blb_PICT;SHA1 digest:K66:2);\
										"image-codec";$Txt_codec;\
										"fill-opacity";1;\
										"stroke-opacity";1)
									
									  //________________________________________
								: ($Txt_type="FFTS")  //list of pairs (table,field)
									
									  //#ACI0096872 {
									  //$Lon_dummy:=IFF_Get_long ($Ptr_source;->$Lon_offset)
									  //$Lon_table:=IFF_Get_short ($Ptr_source;->$Lon_offset)
									  //$Lon_field:=IFF_Get_short ($Ptr_source;->$Lon_offset)
									  //IFF_PAD_CHUNK (->$Lon_offset)
									  //DOM SET XML ATTRIBUTE($tDom_items{$Lon_i};//"table";$Lon_table;//"field";$Lon_field;//"fill-opacity";1;//"stroke-opacity";1)
									$Lon_countTableFieldPairs:=IFF_Get_long ($Ptr_source;->$Lon_offset)/4
									
									ARRAY LONGINT:C221($tLon_tables;$Lon_countTableFieldPairs)
									ARRAY LONGINT:C221($tLon_fields;$Lon_countTableFieldPairs)
									
									For ($Lon_j;1;$Lon_countTableFieldPairs;1)
										
										$tLon_tables{$Lon_j}:=Abs:C99(IFF_Get_short ($Ptr_source;->$Lon_offset))
										$tLon_fields{$Lon_j}:=Abs:C99(IFF_Get_short ($Ptr_source;->$Lon_offset))
										
									End for 
									
									IFF_PAD_CHUNK (->$Lon_offset)
									
									DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
										"pairs";$Lon_countTableFieldPairs;\
										"tableList";JSON Stringify array:C1228($tLon_tables);\
										"fieldList";JSON Stringify array:C1228($tLon_fields);\
										"fill-opacity";1;\
										"stroke-opacity";1)
									  //}
									
									  //________________________________________
								: ($Txt_type="TEXT")
									
									$Txt_buffer:=IFF_Get_text ($Ptr_source;->$Lon_offset)
									IFF_PAD_CHUNK (->$Lon_offset)
									
									DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
										"value";$Txt_buffer;\
										"fill-opacity";1;\
										"stroke-opacity";1)
									
									  //________________________________________
								: ($Txt_type="Elem")
									
									  //BEGIN CHUNK 'Elem'
									$Lon_dummy:=IFF_Get_long ($Ptr_source;->$Lon_offset)
									
									  //RECTobjectRect
									IFF_GET_RECT ($Ptr_source;->$Lon_top;->$Lon_left;->$Lon_bottom;->$Lon_right;->$Lon_offset)
									
/* #ACI0095670
$Lon_vOffset:=24
$Lon_hOffset:=60
*/
									
									DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
										"top";$Lon_top-$Lon_vOffset;\
										"left";$Lon_left-$Lon_hOffset;\
										"bottom";$Lon_bottom-$Lon_vOffset;\
										"right";$Lon_right-$Lon_hOffset)
									
									  //PATTERNframePat (obsolete)
									IFF_FILLER (8;->$Lon_offset)
									
									  //PATTERNobjectPat (obsolete)
									IFF_FILLER (8;->$Lon_offset)
									
									  //BYTEobjectStyle [0 -> 3: Plain, Bold, Italic, Bold-Italic]
									$Blb_objectStyle:=IFF_Get_byte ($Ptr_source;->$Lon_offset)
									
									  //WORDobjectTextLength
									$Lon_dummy:=IFF_Get_short ($Ptr_source;->$Lon_offset)
									
									  //CHAR[42]variableName
									$Txt_variableName:=IFF_Get_pascal_text (42;$Ptr_source;->$Lon_offset)
									
									  //CHAR[42]objectFontName
									$Txt_fontName:=IFF_Get_pascal_text (42;$Ptr_source;->$Lon_offset)
									
									  //WORDobjectFontNb (obsolete)
									$Lon_dummy:=IFF_Get_short ($Ptr_source;->$Lon_offset)
									
									  //WORDframeThickness [0=No frame]
									$Lon_borderWidth:=IFF_Get_short ($Ptr_source;->$Lon_offset)
									
									  //WORDframeForeColor [0=Black,1=White,2=Red,3=Green,4=Blue,5=Cyan,6=Magenta,7=Yellow]
									$Lon_frameForeColor:=IFF_Get_short ($Ptr_source;->$Lon_offset) & 0x00FF
									
									  //WORDframeBackColor [0=Black,1=White,2=Red,3=Green,4=Blue,5=Cyan,6=Magenta,7=Yellow]
									$Lon_frameBackColor:=IFF_Get_short ($Ptr_source;->$Lon_offset) & 0x00FF
									
									  //WORDobjectStyleSheet ????
									$Lon_styleSheet:=IFF_Get_short ($Ptr_source;->$Lon_offset)
									
									  //WORDobjectSize - [font size for text, oval width for roundrect (always 6)]
									$Lon_objectSize:=IFF_Get_short ($Ptr_source;->$Lon_offset)
									
									  //WORDobjectJust [-1 = right, 0 = left, 1 = center,2 = Automatic]
									$Lon_justification:=IFF_Get_short ($Ptr_source;->$Lon_offset)
									
									  //WORDobjectType [1=Text, 2=Rect, 3=Round-rect,4=Oval ,5=Line, 6=Picture, 7=Variable, 8=text]
									$Lon_objectType:=IFF_Get_short ($Ptr_source;->$Lon_offset)
									
									  //WORDobjectForeColor [0=Black,1=White,2=Red,3=Green,4=Blue,5=Cyan,6=Magenta,7=Yellow]
									$Lon_objectForeColor:=IFF_Get_short ($Ptr_source;->$Lon_offset) & 0x00FF
									
									  //WORDobjectBackColor [0=Black,1=White,2=Red,3=Green,4=Blue,5=Cyan,6=Magenta,7=Yellow]
									$Lon_objectBackColor:=IFF_Get_short ($Ptr_source;->$Lon_offset) & 0x00FF
									
									  //WORDobjFieldType
									$Lon_objFieldType:=IFF_Get_short ($Ptr_source;->$Lon_offset)
									
									  //WORDcountTableFieldPairs
									  //#ACI0096872 {
									  //$Lon_dummy:=IFF_Get_short ($Ptr_source;->$Lon_offset)
									$Lon_countTableFieldPairs:=IFF_Get_short ($Ptr_source;->$Lon_offset)
									
									If ($Lon_countTableFieldPairs>0)
										
										DOM GET XML ATTRIBUTE BY NAME:C728($tDom_items{$Lon_i};"value";$Txt_buffer)
										
										If (Length:C16($Txt_buffer)>0)
											
											DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
												"value";Get_text_display ($tDom_items{$Lon_i};$Lon_countTableFieldPairs;$Txt_buffer))
											
										End if 
									End if 
									  //}
									
									  //LONGFiller1 (unused)
									  //LONGFiller2 (unused)
									  //LONGFiller3 (unused)
									  //LONGFiller4  (unused)
									IFF_FILLER (16;->$Lon_offset)
									
									  //END 'Elem'
									IFF_PAD_CHUNK (->$Lon_offset)
									
									DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
										"type";Choose:C955($Lon_objectType;"rubrique";"text";"rect";"round-rect";"oval";"line";"image";"variable";"text");\
										"field-type";$Lon_objFieldType)
									
									$Txt_alignment:=Choose:C955($Lon_justification+1;"right";"left";"center";"auto")
									$Txt_alignment:=Choose:C955(Length:C16($Txt_alignment)=0;"auto";$Txt_alignment)
									
									Case of 
											
											  //______________________________________________________
										: ($Lon_objectType=1)\
											 | ($Lon_objectType=7)\
											 | ($Lon_objectType=8)  //text & variable
											
											DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
												"font-size";$Lon_objectSize;\
												"alignment";$Txt_alignment)
											
											  //the outline attribute is deprecated
											$Txt_style:=Choose:C955($Blb_objectStyle{0};\
												"plain";\
												"bold";\
												"italic";\
												"bold-italic";\
												"underline";\
												"bold-underline";\
												"italic-underline";\
												"bold-italic-underline";\
												"plain";\
												"bold";\
												"italic";\
												"bold-italic";\
												"underline";\
												"bold-underline";\
												"italic-underline";\
												"bold-italic-underline")
											
											DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
												"font-name";str_Single_quote ($Txt_fontName);\
												"style";$Txt_style;\
												"font-color";Color_from_long (parse_color ($Lon_objectForeColor)))
											
											  //no border
											DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
												"stroke-width";0)
											
											  //#ACI0097094
											DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
												"preserve-aspect-ratio";"true")
											
											  //______________________________________________________
										: ($Lon_objectType=2)  //rect
											
											DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
												"rx";0;\
												"ry";0)
											
											  //______________________________________________________
										: ($Lon_objectType=3)  //round-rect
											
											DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
												"rx";$Lon_objectSize;\
												"ry";$Lon_objectSize)
											
											  //______________________________________________________
										: ($Lon_objectType=4)  //oval
											
											  //______________________________________________________
										: ($Lon_objectType=5)  //line
											
											  //correction
											If (Abs:C99($Lon_top-$Lon_bottom)<=3)
												
												$Lon_top:=$Lon_bottom
												
											Else 
												
												If (Abs:C99($Lon_left-$Lon_right)<=3)
													
													$Lon_right:=$Lon_left
													
												End if 
											End if 
											
											DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
												"top";$Lon_top-$Lon_vOffset;\
												"left";$Lon_left-$Lon_hOffset;\
												"bottom";$Lon_bottom-$Lon_vOffset;\
												"right";$Lon_right-$Lon_hOffset;\
												"direction";Choose:C955($Txt_alignment="center";"up";"down"))
											
											  //______________________________________________________
										: ($Lon_objectType=6)  //image
											
											DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
												"preserve-aspect-ratio";"true")
											
											  //______________________________________________________
									End case 
									
									If (False:C215)  //(ignored)
										
										$Txt_alignment:=Choose:C955($Lon_justification+1;"right";"left";"center";"auto")
										
										DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
											"font-size";$Lon_objectSize;\
											"alignment";Choose:C955(Length:C16($Txt_alignment)=0;"auto";$Txt_alignment))
										
										  //the outline attribute is deprecated
										$Txt_style:=Choose:C955($Blb_objectStyle{0};\
											"plain";\
											"bold";\
											"italic";\
											"bold-italic";\
											"underline";\
											"bold-underline";\
											"italic-underline";\
											"bold-italic-underline";\
											"plain";\
											"bold";\
											"italic";\
											"bold-italic";\
											"underline";\
											"bold-underline";\
											"italic-underline";\
											"bold-italic-underline")
										
										DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};"direction";Choose:C955($Txt_alignment="center";"up";"down");\
											"font-name";str_Single_quote ($Txt_fontName);\
											"style";$Txt_style;\
											"stroke-width";$Lon_borderWidth;\
											"stroke-color";Color_from_long (parse_color ($Lon_objectForeColor));\
											"fill-color";Color_from_long (parse_color ($Lon_frameBackColor));\
											"font-color";Color_from_long (parse_color ($Lon_objectForeColor)))
										
										If ($Lon_objectType=1)  //text
											
											DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
												"stroke-width";0)
											
										End if 
										
										DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
											"preserve-aspect-ratio";"true";\
											"fill-opacity";1;"stroke-opacity";1)
										
									Else 
										
										DOM SET XML ATTRIBUTE:C866($tDom_items{$Lon_i};\
											"stroke-width";$Lon_borderWidth;\
											"stroke-color";Color_from_long (parse_color ($Lon_objectForeColor));\
											"fill-color";Color_from_long (parse_color ($Lon_frameBackColor));\
											"fill-opacity";1;\
											"stroke-opacity";1)
									End if 
									
									  //________________________________________
							End case 
						End while 
					End for 
					
					If ($Boo_includePrintSettings)
						
						$Dom_printSettings:=DOM Create XML element:C865($Dom_xml;"printSettings";\
							"id";"print-settings")
						
						XML SET OPTIONS:C1090($Dom_printSettings;XML binary encoding:K45:37;XML base64:K45:38)
						
						DOM SET XML ATTRIBUTE:C866(DOM Create XML element:C865($Dom_printSettings;"PRNT";\
							"id";"print-settings-prnt");\
							"value";$Blb_PRNT)
						
						DOM SET XML ELEMENT VALUE:C868(DOM Create XML element:C865($Dom_printSettings;"PRPS";\
							"id";"print-settings-prps");\
							$Txt_PRPS;*)
						
						DOM SET XML ELEMENT VALUE:C868(DOM Create XML element:C865($Dom_printSettings;"PRPF";\
							"id";"print-settings-prpf");\
							$Txt_PRPF;*)
						
					End if 
					
					$Boo_isValid:=True:C214
					
				End if 
				
				  //#ACI0096524 {
				  //End if
				  //End if
				  //}
				
			End if 
		End if 
	End if 
End if 

  //#ACI0096524 {
  //End if
  //}

  // ----------------------------------------------------
  // Return
If ($Boo_isValid)
	
	$0:=$Dom_xml  //label definition as XML
	
Else 
	
	DOM CLOSE XML:C722($Dom_xml)
	
End if 

  // ----------------------------------------------------
  // End