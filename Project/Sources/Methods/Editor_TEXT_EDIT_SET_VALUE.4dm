//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_TEXT_EDIT_SET_VALUE
  // Database: 4D Labels
  // ID[CD0B62E907D14D39A8C898A9E927054F]
  // Created #11-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_breaks;$Lon_i;$Lon_j;$Lon_parameters;$Lon_start)
C_TEXT:C284($Dom_area;$Dom_buffer;$Txt_buffer;$Txt_line;$Txt_value)

ARRAY LONGINT:C221($tLon_lengths;0)
ARRAY LONGINT:C221($tLon_positions;0)
ARRAY TEXT:C222($tTxt_breaks;0)

If (False:C215)
	C_TEXT:C284(Editor_TEXT_EDIT_SET_VALUE ;$1)
	C_TEXT:C284(Editor_TEXT_EDIT_SET_VALUE ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Dom_area:=$1
	$Txt_value:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Lon_breaks:=DOM Count XML elements:C726($Dom_area;"tbreak")

$tTxt_breaks{0}:=DOM Find XML element:C864($Dom_area;"textArea/tbreak";$tTxt_breaks)

For ($Lon_i;1;Size of array:C274($tTxt_breaks);1)
	
	DOM REMOVE XML ELEMENT:C869($tTxt_breaks{$Lon_i})
	
End for 

$Lon_start:=1

While (Match regex:C1019("(.+)";$Txt_value;$Lon_start;$tLon_positions;$tLon_lengths))
	
	$Txt_line:=Substring:C12($Txt_value;$tLon_positions{1};$tLon_lengths{1})
	
	If ($Lon_start=1)
		
		DOM SET XML ELEMENT VALUE:C868($Dom_area;$Txt_line)
		
	Else 
		
		$Txt_buffer:=Substring:C12($Txt_value;$Lon_start;$tLon_positions{1}-$Lon_start)
		$Lon_breaks:=Length:C16(Replace string:C233($Txt_buffer;"\r\n";"\n";*))
		
		For ($Lon_j;1;$Lon_breaks;1)
			
			$tTxt_breaks{0}:=DOM Create XML element:C865($Dom_area;"tbreak")
			
		End for 
		
		$Dom_buffer:=DOM Append XML child node:C1080($Dom_area;XML DATA:K45:12;$Txt_line)
		
	End if 
	
	$Lon_start:=$tLon_positions{1}+$tLon_lengths{1}
	
End while 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End