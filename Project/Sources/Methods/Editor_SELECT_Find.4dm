//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SELECT_Find
  // Database: 4D Labels
  // ID[4B713DC79AF6429DA26BFE1D7C37DECD]
  // Created #20-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($Boo_selected)
C_LONGINT:C283($Lon_i;$Lon_parameters)
C_TEXT:C284($Dom_label;$Txt_buffer;$Txt_ID)

ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_BOOLEAN:C305(Editor_SELECT_Find ;$0)
	C_TEXT:C284(Editor_SELECT_Find ;$1)
	C_TEXT:C284(Editor_SELECT_Find ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Dom_label:=$1
	$Txt_ID:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected);1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_buffer)
	
	If ($Txt_buffer=$Txt_ID)
		
		$Boo_selected:=True:C214
		$Lon_i:=MAXLONG:K35:2-1
		
	End if 
End for 

  // ----------------------------------------------------
  // Return
$0:=$Boo_selected

  // ----------------------------------------------------
  // End