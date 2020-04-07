//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : num_not_INF
  // Database: 4D Labels
  // ID[8ECA0DEBD0A544B38D13F943FEFB5B9C]
  // Created #20-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // to filter INF (SVG runtime error)
  // ----------------------------------------------------
  // Declarations
C_REAL:C285($0)
C_REAL:C285($1)

C_LONGINT:C283($Lon_parameters)
C_REAL:C285($Num_in;$Num_out)

If (False:C215)
	C_REAL:C285(num_not_INF ;$0)
	C_REAL:C285(num_not_INF ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Num_in:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Num_out:=Num:C11(String:C10($Num_in))

  // ----------------------------------------------------
  // Return
$0:=$Num_out

  // ----------------------------------------------------
  // End