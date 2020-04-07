//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Convert_from_points
  // Database: 4D Labels
  // ID[6DDFF12F12CC4ED99242B780959B88B7]
  // Created #15-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_REAL:C285($0)
C_REAL:C285($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_LONGINT:C283($Lon_parameters;$Lon_round)
C_REAL:C285($Num_value)
C_TEXT:C284($Txt_unit)

If (False:C215)
	C_REAL:C285(Convert_from_points ;$0)
	C_REAL:C285(Convert_from_points ;$1)
	C_TEXT:C284(Convert_from_points ;$2)
	C_LONGINT:C283(Convert_from_points ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Num_value:=$1  //value in points
	$Txt_unit:=$2  // unit ( in | mm | cm )
	
	$Lon_round:=-1
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		$Lon_round:=$3  //{number of decimals to round}
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //________________________________________
	: ($Txt_unit="in")
		
		$Num_value:=$Num_value*0.0138888889
		
		  //________________________________________
	: ($Txt_unit="mm")
		
		$Num_value:=$Num_value*0.352777778
		
		  //________________________________________
	: ($Txt_unit="cm")
		
		$Num_value:=$Num_value*0.0352777778
		
		  //________________________________________
	Else 
		
		$Num_value:=$Num_value
		
		  //________________________________________
End case 

If ($Lon_round#-1)
	
	$Num_value:=Round:C94($Num_value;$Lon_round)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Num_value  //converted value

  // ----------------------------------------------------
  // End