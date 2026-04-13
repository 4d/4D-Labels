//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Color_to_long
// Database: 4D Labels
// ID[D6AEFA2DB6864C9D967EEEC4C035D503]
// Created #10-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Integer
var $1 : Text
var $2 : Boolean

var $Boo_foreground : Boolean
var $Lon_B; $Lon_color; $Lon_G; $Lon_parameters; $Lon_R : Integer
var $kTxt_pattern; $Txt_color : Text

ARRAY LONGINT:C221($tLon_length; 0)
ARRAY LONGINT:C221($tLon_pos; 0)
// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Txt_color:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		$Boo_foreground:=$2
		
	End if 
	
	$kTxt_pattern:="rgb\\((\\d*),(\\d*),(\\d*)\\)"
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Txt_color="none")\
		 & ($Boo_foreground)
		
		$Lon_color:=-1
		
		//______________________________________________________
	: ($Txt_color="black")
		
		$Lon_color:=0x0000
		
		//______________________________________________________
	: ($Txt_color="white")
		
		$Lon_color:=0xFFFF
		
		//______________________________________________________
	: (Match regex:C1019($kTxt_pattern; $Txt_color; 1; $tLon_pos; $tLon_length))
		
		$Lon_R:=Num:C11(Substring:C12($Txt_color; $tLon_pos{1}; $tLon_length{1}))
		$Lon_G:=Num:C11(Substring:C12($Txt_color; $tLon_pos{2}; $tLon_length{2}))
		$Lon_B:=Num:C11(Substring:C12($Txt_color; $tLon_pos{3}; $tLon_length{3}))
		
		$Lon_color:=($Lon_R << 16)+($Lon_G << 8)+$Lon_B
		
		//______________________________________________________
	Else 
		
		$Lon_color:=Choose:C955($Boo_foreground; 0x0000; 0x00FFFFFF)
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// Return
$0:=$Lon_color

// ----------------------------------------------------
// End