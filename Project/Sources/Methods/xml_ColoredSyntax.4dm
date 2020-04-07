//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : xml_ColoredSyntax
  // ID[20858E31C6A94C829CD0963124FCD4C1]
  // Created 06/07/11 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // Return colored XML to display in a Multi-style text object
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_error;$Lon_parameters)
C_TEXT:C284($Txt_attributeFontWeight;$Txt_attributeNameColor;$Txt_attributeValueColor;$Txt_CDATAColor;$Txt_CDATAFontWeight;$Txt_commentColor)
C_TEXT:C284($Txt_commentFontWeight;$Txt_defaultColor;$Txt_defaultFontWeight;$Txt_doctypeColor;$Txt_doctypeFontWeight;$Txt_elementColor)
C_TEXT:C284($Txt_elementFontWeight;$Txt_entityColor;$Txt_entityFontWeight;$Txt_pattern;$Txt_processingColor;$Txt_processingFontWeight)
C_TEXT:C284($Txt_styleAttribute;$Txt_styleCDATA;$Txt_styleComment;$Txt_styleDoctype;$Txt_styleElement;$Txt_styleEntity)
C_TEXT:C284($Txt_styleProcessing;$Txt_xml)

If (False:C215)
	C_TEXT:C284(xml_ColoredSyntax ;$0)
	C_TEXT:C284(xml_ColoredSyntax ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	$Txt_xml:=$1
	
	$Txt_defaultColor:="black"
	$Txt_defaultFontWeight:="normal"
	
	$Txt_elementColor:="#2a2aa7"
	$Txt_elementFontWeight:="normal"
	
	$Txt_attributeFontWeight:="normal"
	$Txt_attributeNameColor:="#f58953"
	$Txt_attributeValueColor:="#9d3d0a"
	
	$Txt_commentColor:="green"
	$Txt_commentFontWeight:="normal"
	
	$Txt_processingColor:="#8526C2"
	$Txt_processingFontWeight:="normal"
	
	$Txt_doctypeColor:="blue"
	$Txt_doctypeFontWeight:="normal"
	
	$Txt_entityColor:="#94961C"
	$Txt_entityFontWeight:="normal"
	
	$Txt_CDATAColor:="grey"
	$Txt_CDATAFontWeight:="normal"
	
	$Txt_styleElement:="<span style=\"color:"+$Txt_elementColor\
		+";font-weight:"+$Txt_elementFontWeight+";\">\\1</span>"
	
	$Txt_styleAttribute:="<span style=\"color:"+$Txt_attributeNameColor\
		+";font-weight:"+$Txt_attributeFontWeight\
		+";\">\\1</span><span style=\"color:"+$Txt_defaultColor\
		+";font-weight:"+$Txt_defaultFontWeight\
		+";\">=\"<span style=\"color:"+$Txt_attributeValueColor\
		+";font-weight:"+$Txt_attributeFontWeight\
		+";\">\\2</span>\"</span>"
	
	$Txt_styleComment:="<span style=\"color:"+$Txt_commentColor\
		+";font-weight:"+$Txt_commentFontWeight+";\">\\1</span>"
	
	$Txt_styleProcessing:="<span style=\"color:"+$Txt_processingColor\
		+";font-weight:"+$Txt_processingFontWeight+";\">\\1</span>"
	
	$Txt_styleDoctype:="<span style=\"color:"+$Txt_doctypeColor\
		+";font-weight:"+$Txt_doctypeFontWeight+";\">\\1</span>"
	
	$Txt_styleEntity:="<span style=\"color:"+$Txt_entityColor\
		+";font-weight:"+$Txt_entityFontWeight+";\">\\1</span>"
	
	$Txt_styleCDATA:="_§§![CDATA[<span style=\"color:"+$Txt_CDATAColor\
		+";font-weight:"+$Txt_CDATAFontWeight+";\">\\1</span>]]_¿¿"
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

  //replace < and > caracteres
$Txt_xml:=Replace string:C233($Txt_xml;"<";"_§§")
$Txt_xml:=Replace string:C233($Txt_xml;">";"_¿¿")

  //CDATA
$Txt_pattern:="(?msi)_§§!\\[CDATA\\[(.*)\\]{2}_¿¿"
$Lon_error:=Rgx_SubstituteText ($Txt_pattern;$Txt_styleCDATA;->$Txt_xml)

  //processing instruction
$Txt_pattern:="(_§§\\?[^_¿¿]*\\?_¿¿)"
$Lon_error:=Rgx_SubstituteText ($Txt_pattern;$Txt_styleProcessing;->$Txt_xml)

  //attributes
$Txt_pattern:="(\\s+[^= ]*)=\"([^\"]*)\"(?!.*\\?_¿¿)"
$Lon_error:=Rgx_SubstituteText ($Txt_pattern;$Txt_styleAttribute;->$Txt_xml)

  //elements
$Txt_pattern:="(_§§[^?_¿¿]*_¿¿)"
$Lon_error:=Rgx_SubstituteText ($Txt_pattern;$Txt_styleElement;->$Txt_xml)

  //comments
$Txt_pattern:="(_§§!--.*?--_¿¿)"
$Lon_error:=Rgx_SubstituteText ($Txt_pattern;$Txt_styleComment;->$Txt_xml)

  //default
$Txt_xml:="<span style=\"color:"+$Txt_defaultColor\
+";font-weight:"+$Txt_defaultFontWeight+";\">"+$Txt_xml+"</span>"

  //doctype
$Txt_pattern:="(_§§\\![^-][^_¿¿]*_¿¿)"
$Lon_error:=Rgx_SubstituteText ($Txt_pattern;$Txt_styleDoctype;->$Txt_xml)

  //entities
$Txt_pattern:="(&amp;[^;]*;)"
$Lon_error:=Rgx_SubstituteText ($Txt_pattern;$Txt_styleEntity;->$Txt_xml)

  //restore < and > caracteres
$Txt_xml:=Replace string:C233($Txt_xml;"_§§";"&lt;")
$Txt_xml:=Replace string:C233($Txt_xml;"_¿¿";"&gt;")

  // ----------------------------------------------------
  // End

$0:=$Txt_xml