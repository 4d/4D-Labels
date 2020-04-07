//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : str_Single_quote
  // Database: 4D Labels
  // ID[CEE94CEF66684E49BEEB61FAC48B4A37]
  // Created #1-6-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_length;$Lon_parameters)
C_TEXT:C284($Txt_buffer;$Txt_in;$Txt_out)

If (False:C215)
	C_TEXT:C284(str_Single_quote ;$0)
	C_TEXT:C284(str_Single_quote ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Txt_in:=$1
		$Lon_length:=Length:C16($Txt_in)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If ($Lon_length>0)
	
	$Txt_out:=$Txt_in
	
	If (Position:C15("'";$Txt_out)#1)
		
		$Txt_out:="'"+$Txt_out
		$Lon_length:=$Lon_length+1
		
	End if 
	
	If (Position:C15("'";$Txt_out;2)#$Lon_length)
		
		$Txt_out:=$Txt_out+"'"
		$Lon_length:=$Lon_length+1
		
	End if 
	
	$Txt_buffer:=Replace string:C233($Txt_out;"'";"")
	
	If ((Length:C16($Txt_buffer)+2)#$Lon_length)
		
		$Txt_out:=$Txt_in  //revert
		
	End if 
	
Else 
	
	$Txt_out:="''"
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Txt_out  //quoted text

  // ----------------------------------------------------
  // End