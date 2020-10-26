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
var $0 : Text
var $1 : Text
var $2 : Integer
var $3 : Text

If (False:C215)
	C_TEXT:C284(Get_text_display; $0)
	C_TEXT:C284(Get_text_display; $1)
	C_LONGINT:C283(Get_text_display; $2)
	C_TEXT:C284(Get_text_display; $3)
End if 

var $expression; $itemReference; $pattern; $result; $t; $value : Text
var $countTableFieldPairs; $i : Integer

// ----------------------------------------------------
// Initialisations
If (Asserted:C1132(Count parameters:C259>=3; "Missing parameter"))
	
	// Required parameters
	$itemReference:=$1
	$countTableFieldPairs:=$2
	$expression:=$3
	
	$result:=$expression
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($countTableFieldPairs>0)
	
	ARRAY TEXT:C222($results; 0x0000; 0x0000)
	$pattern:="(?mi-s)(\\[[^+\\s;\\)]+)(?:\\+|\\s)?"
	
	If (0=Rgx_ExtractText($pattern; $expression; "1"; ->$results; 0))
		
		ARRAY LONGINT:C221($tables; $countTableFieldPairs)
		ARRAY LONGINT:C221($fields; $countTableFieldPairs)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($itemReference; "tableList"; $t)
		JSON PARSE ARRAY:C1219($t; $tables)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($itemReference; "fieldList"; $t)
		JSON PARSE ARRAY:C1219($t; $fields)
		
		For ($i; 1; Size of array:C274($results); 1)
			
			If ($i<=$countTableFieldPairs)
				
				ARRAY TEXT:C222($keywords; 0x0000)
				GET TEXT KEYWORDS:C1141($results{$i}{1}; $keywords)
				
				Case of 
						
						//______________________________________________________
					: (Is field number valid:C1000($tables{$i}; $fields{$i}))
						
						$value:=Parse formula:C1576("[:"+String:C10($tables{$i})+"]:"+String:C10($fields{$i}); Formula out with virtual structure:K88:2)
						
						//______________________________________________________
					: (Is table number valid:C999($tables{$i}))
						
						$value:=Parse formula:C1576("[:"+String:C10($tables{$i})+"]"; Formula out with virtual structure:K88:2)+"•"+$keywords{2}+"•"
						
						//______________________________________________________
					Else 
						
						$value:="•"+$results{$i}{1}+"•"
						
						//______________________________________________________
				End case 
				
				$result:=Replace string:C233($result; $results{$i}{1}; $value; 1)
				
			End if 
		End for 
	End if 
End if 

// ----------------------------------------------------
// Return
$0:=$result

// ----------------------------------------------------
// End