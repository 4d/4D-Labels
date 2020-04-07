//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : str_Capitalize
  // Database: 4D Labels
  // ID[2922B5434FBB49DBB03C67028704C545]
  // Created #1-6-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_length;$Lon_parameters)
C_TEXT:C284($Txt_in;$Txt_out)

If (False:C215)
	C_TEXT:C284(str_Capitalize ;$0)
	C_TEXT:C284(str_Capitalize ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_in:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	$Lon_length:=Length:C16($Txt_in)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If ($Lon_length>0)
	
	$Txt_out:=Uppercase:C13(Substring:C12($Txt_in;1;1);*)+Lowercase:C14(Substring:C12($Txt_in;2);*)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Txt_out

  // ----------------------------------------------------
  // End