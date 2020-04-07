//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : obj_ADAPT_SEPARATOR_LINE
  // Database: 4D Labels
  // ID[8AAB45937ADF4DB99D998B9A021E2B16]
  // Created #14-9-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // Adapt separator's line to a localized label
  // Given the label's name(s) as parameter(s), the lines must be called "name.line"
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284(${2})

C_LONGINT:C283($kLon_offset;$Lon_;$Lon_bottom;$Lon_i;$Lon_left;$Lon_parameters)
C_LONGINT:C283($Lon_right;$Lon_top;$Lon_width)
C_TEXT:C284($Txt_labelName;$Txt_line)

If (False:C215)
	C_TEXT:C284(obj_ADAPT_SEPARATOR_LINE ;$1)
	C_TEXT:C284(obj_ADAPT_SEPARATOR_LINE ;${2})
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_labelName:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	$kLon_offset:=5  //offset between label and line
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;1;$Lon_parameters;1)
	
	$Txt_labelName:=${$Lon_i}
	$Txt_line:=$Txt_labelName+".line"
	
	OBJECT GET COORDINATES:C663(*;$Txt_labelName;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
	OBJECT GET BEST SIZE:C717(*;$Txt_labelName;$Lon_width;$Lon_)
	
	$Lon_right:=$Lon_left+$Lon_width
	OBJECT SET COORDINATES:C1248(*;$Txt_labelName;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
	
	$Lon_left:=$Lon_right+$kLon_offset
	
	OBJECT GET COORDINATES:C663(*;$Txt_line;$Lon_;$Lon_top;$Lon_right;$Lon_bottom)
	OBJECT SET COORDINATES:C1248(*;$Txt_line;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
	
End for 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End