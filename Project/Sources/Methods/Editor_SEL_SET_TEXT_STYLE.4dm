//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_SET_TEXT_STYLE
  // Database: 4D Labels
  // ID[5816A5D4F53242F0AB6D898C96C9B4F5]
  // Created #19-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_BOOLEAN:C305($Boo_bold;$Boo_image;$Boo_italic;$Boo_redraw;$Boo_remove;$Boo_text)
C_BOOLEAN:C305($Boo_underline)
C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_styles)
C_TEXT:C284($Dom_canvas;$Dom_label;$Dom_object;$Dom_style;$Txt_;$Txt_class)
C_TEXT:C284($Txt_current;$Txt_data;$Txt_ID;$Txt_style;$Txt_value)

ARRAY LONGINT:C221($tLon_length;0)
ARRAY LONGINT:C221($tLon_position;0)
ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_TEXT:C284(Editor_SEL_SET_TEXT_STYLE ;$1)
	C_TEXT:C284(Editor_SEL_SET_TEXT_STYLE ;$2)
	C_TEXT:C284(Editor_SEL_SET_TEXT_STYLE ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_style:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Dom_label:=$2
		
		If ($Lon_parameters>=3)
			
			$Dom_canvas:=$3
			
		End if 
	End if 
	
	Editor_Get_grips (->$Dom_label;->$Dom_canvas)
	
	$Boo_italic:=($Txt_style="italic@")
	$Boo_bold:=($Txt_style="bold@")
	$Boo_underline:=($Txt_style="underline@")
	$Boo_remove:=($Txt_style="@-remove")
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected);1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
	
	$Dom_object:=Editor_OB_Get_type ($Dom_label;$Txt_ID;->$Boo_text;->$Boo_image)
	
	$Txt_class:=OB Get:C1224(<>label_params;"classPrefix";Is text:K8:3)+$Txt_ID+"-textArea"
	
	If ($Boo_text)
		
		$Dom_style:=DOM Find XML element by ID:C1010($Dom_canvas;$Txt_class)
		
		If (OK=1)  //is an object with style
			
			DOM GET XML ELEMENT VALUE:C731($Dom_style;$Txt_;$Txt_data)  //CDATA
			
			If ($Boo_bold)
				
				$Txt_value:=Choose:C955($Boo_remove;"normal";"bold")
				
				If (Match regex:C1019("(?m)(.*font-weight:)([^;]+)(;.*)";$Txt_data;1;$tLon_position;$tLon_length))
					
					$Txt_current:=Substring:C12($Txt_data;$tLon_position{2};$tLon_length{2})
					
					If ($Txt_value#$Txt_current)
						
						DOM SET XML ELEMENT VALUE:C868($Dom_style;Substring:C12($Txt_data;$tLon_position{1};$tLon_length{1})+$Txt_value+Substring:C12($Txt_data;$tLon_position{3};$tLon_length{3});*)
						
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"style";$Txt_value)
						
						$Txt_value:=Replace string:C233($Txt_value;"-bold-";"";*)
						$Txt_value:=Replace string:C233($Txt_value;"bold-";"";*)
						$Txt_value:=Replace string:C233($Txt_value;"bold";"";*)
						
						$Txt_value:=Choose:C955($Boo_remove;Choose:C955($Txt_value="";"plain";$Txt_value);Choose:C955($Txt_value="plain";"bold";"bold-"+$Txt_value))
						
						DOM SET XML ATTRIBUTE:C866($Dom_object;\
							"style";$Txt_value)
						
						$Boo_redraw:=True:C214
						
					End if 
				End if 
			End if 
			
			If ($Boo_italic)
				
				$Txt_value:=Choose:C955($Boo_remove;"normal";"oblique")
				
				If (Match regex:C1019("(?m)(.*font-style:)([^;]+)(;.*)";$Txt_data;1;$tLon_position;$tLon_length))
					
					$Txt_current:=Substring:C12($Txt_data;$tLon_position{2};$tLon_length{2})
					
					If ($Txt_value#$Txt_current)
						
						DOM SET XML ELEMENT VALUE:C868($Dom_style;Substring:C12($Txt_data;$tLon_position{1};$tLon_length{1})+$Txt_value+Substring:C12($Txt_data;$tLon_position{3};$tLon_length{3});*)
						
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"style";$Txt_value)
						
						$Txt_value:=Replace string:C233($Txt_value;"-italic-";"";*)
						$Txt_value:=Replace string:C233($Txt_value;"italic-";"";*)
						$Txt_value:=Replace string:C233($Txt_value;"italic";"";*)
						
						$Txt_value:=Choose:C955($Boo_remove;Choose:C955($Txt_value="";"plain";$Txt_value);Choose:C955($Txt_value="plain";"italic";"italic-"+$Txt_value))
						
						DOM SET XML ATTRIBUTE:C866($Dom_object;\
							"style";$Txt_value)
						
						$Boo_redraw:=True:C214
						
					End if 
				End if 
			End if 
			
			If ($Boo_underline)
				
				$Txt_value:=Choose:C955($Boo_remove;"none";"underline")
				
				If (Match regex:C1019("(?m)(.*text-decoration:)([^;]+)(;.*)";$Txt_data;1;$tLon_position;$tLon_length))
					
					$Txt_current:=Substring:C12($Txt_data;$tLon_position{2};$tLon_length{2})
					
					If ($Txt_value#$Txt_current)
						
						DOM SET XML ELEMENT VALUE:C868($Dom_style;Substring:C12($Txt_data;$tLon_position{1};$tLon_length{1})+$Txt_value+Substring:C12($Txt_data;$tLon_position{3};$tLon_length{3});*)
						
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"style";$Txt_value)
						
						$Txt_value:=Replace string:C233($Txt_value;"-underline-";"";*)
						$Txt_value:=Replace string:C233($Txt_value;"underline-";"";*)
						$Txt_value:=Replace string:C233($Txt_value;"underline";"";*)
						
						$Txt_value:=Choose:C955($Boo_remove;Choose:C955($Txt_value="";"plain";$Txt_value);Choose:C955($Txt_value="plain";"underline";"underline-"+$Txt_value))
						
						DOM SET XML ATTRIBUTE:C866($Dom_object;\
							"style";$Txt_value)
						
						$Boo_redraw:=True:C214
						
					End if 
				End if 
			End if 
		End if 
	End if 
End for 

If ($Boo_redraw)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"style";$Txt_value)
	
	$Lon_styles:=Bold:K14:2*Num:C11($Txt_value="@bold@")+Italic:K14:3*Num:C11($Txt_value="@italic@")+Underline:K14:4*Num:C11($Txt_value="@underline@")
	
	OBJECT SET FONT STYLE:C166(*;"picker";$Lon_styles)
	
	Editor_UPDATE 
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End