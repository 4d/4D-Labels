//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Convert_into_points
// Database: 4D Labels
// ID[D0D2F58C0ED14D048E30C05EEBA7CD62]
// Created #15-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Real
var $1 : Real
var $2 : Text

var $Lon_parameters : Integer
var $Num_value : Real
var $Txt_unit : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	//Required parameters
	$Num_value:=$1
	$Txt_unit:=$2
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//________________________________________
	: ($Txt_unit="in")
		
		$Num_value:=$Num_value*72
		
		//________________________________________
	: ($Txt_unit="mm")
		
		$Num_value:=$Num_value*2.83464567
		
		//________________________________________
	: ($Txt_unit="cm")
		
		//1 Centimeter = 28.3464567 Points [Postscript]
		//1 Point = 0.0352777778 Centimeters
		$Num_value:=$Num_value*((283464566/10000000)+((99999997/100000000)/10000000))
		
		//________________________________________
	Else 
		
		//________________________________________
End case 

// ----------------------------------------------------
// Return
$0:=$Num_value

// ----------------------------------------------------
// End