//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : convert_longToHex
  // Database: 4D Labels
  // ID[52377B154EE44F38B5DAE56416AA8916]
  // Created #7-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_parameters;$Lon_value)
C_TEXT:C284($Txt_hex)

If (False:C215)
	C_TEXT:C284(convert_longToHex ;$0)
	C_LONGINT:C283(convert_longToHex ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Lon_value:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Txt_hex:="000000"+Replace string:C233(String:C10($Lon_value;"&x");"0x";"";*)
$Txt_hex:="#"+Substring:C12($Txt_hex;Length:C16($Txt_hex)-5;6)

  // ----------------------------------------------------
  // Return

$0:=$Txt_hex

  // ----------------------------------------------------
  // End