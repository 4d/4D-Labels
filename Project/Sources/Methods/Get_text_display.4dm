//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Get_text_display
  // Database: 4D Labels
  // ID[D95A171ACCDE41F6A5263BA07CE66A1F]
  // Created #6-6-2017 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)

C_LONGINT:C283($Lon_countTableFieldPairs;$Lon_i;$Lon_parameters)
C_TEXT:C284($Dom_itemReference;$Txt_buffer;$Txt_expression;$Txt_pattern;$Txt_result;$Txt_value)


If (False:C215)
	C_TEXT:C284(Get_text_display ;$0)
	C_TEXT:C284(Get_text_display ;$1)
	C_LONGINT:C283(Get_text_display ;$2)
	C_TEXT:C284(Get_text_display ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=3;"Missing parameter"))
	
	  //Required parameters
	$Dom_itemReference:=$1
	$Lon_countTableFieldPairs:=$2
	$Txt_expression:=$3
	
	  //Optional parameters
	If ($Lon_parameters>=4)
		
		  // <NONE>
		
	End if 
	
	$Txt_result:=$Txt_expression
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If ($Lon_countTableFieldPairs>0)
	
	ARRAY TEXT:C222($tTxt_results;0x0000;0x0000)
	$Txt_pattern:="(?mi-s)(\\[[^+\\s;\\)]+)(?:\\+|\\s)?"
	
	If (0=Rgx_ExtractText ($Txt_pattern;$Txt_expression;"1";->$tTxt_results;0))
		
		ARRAY LONGINT:C221($tLon_tables;$Lon_countTableFieldPairs)
		ARRAY LONGINT:C221($tLon_fields;$Lon_countTableFieldPairs)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_itemReference;"tableList";$Txt_buffer)
		JSON PARSE ARRAY:C1219($Txt_buffer;$tLon_tables)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_itemReference;"fieldList";$Txt_buffer)
		JSON PARSE ARRAY:C1219($Txt_buffer;$tLon_fields)
		
		For ($Lon_i;1;Size of array:C274($tTxt_results);1)
			
			If ($Lon_i<=$Lon_countTableFieldPairs)
				
				ARRAY TEXT:C222($tTxt_keywords;0x0000)
				GET TEXT KEYWORDS:C1141($tTxt_results{$Lon_i}{1};$tTxt_keywords)
				
				Case of 
						
						  //______________________________________________________
					: (Is field number valid:C1000($tLon_tables{$Lon_i};$tLon_fields{$Lon_i}))
						
						$Txt_value:="["+Table name:C256($tLon_tables{$Lon_i})+"]"+Field name:C257($tLon_tables{$Lon_i};$tLon_fields{$Lon_i})
						
						  //______________________________________________________
					: (Is table number valid:C999($tLon_tables{$Lon_i}))
						
						$Txt_value:="["+Table name:C256($tLon_tables{$Lon_i})+"]•"+$tTxt_keywords{2}+"•"
						
						  //______________________________________________________
					Else 
						
						$Txt_value:="•"+$tTxt_results{$Lon_i}{1}+"•"
						
						  //______________________________________________________
				End case 
				
				$Txt_result:=Replace string:C233($Txt_result;$tTxt_results{$Lon_i}{1};$Txt_value;1)
				
			End if 
		End for 
	End if 
End if 

  // ----------------------------------------------------
  // Return
$0:=$Txt_result

  // ----------------------------------------------------
  // End