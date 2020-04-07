//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : math_Length_conversion
  // Database: 4D Labels
  // ID[E8DA3A5EE0164C71AFF29ED12918E271]
  // Created #6-7-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_REAL:C285($0)
C_REAL:C285($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)

C_LONGINT:C283($Lon_parameters;$Lon_round)
C_REAL:C285($Num_value)
C_TEXT:C284($Txt_fromUnit;$Txt_toUnit)

If (False:C215)
	C_REAL:C285(math_Length_conversion ;$0)
	C_REAL:C285(math_Length_conversion ;$1)
	C_TEXT:C284(math_Length_conversion ;$2)
	C_TEXT:C284(math_Length_conversion ;$3)
	C_LONGINT:C283(math_Length_conversion ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Num_value:=$1
	$Txt_fromUnit:=$2  //in | pt | mm | cm
	
	$Txt_toUnit:="pt"
	$Lon_round:=9
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		$Txt_toUnit:=$3  //in | (pt) | mm | cm
		
		If ($Lon_parameters>=4)
			
			$Lon_round:=$4  //(9)
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Txt_fromUnit=$Txt_toUnit)
		
		  //NOTHING MORE TO DO
		
		  //______________________________________________________
	: ($Txt_toUnit="pt")
		
		Case of 
				
				  //……………………………………………………………………………
			: ($Txt_fromUnit="in")
				
				  //1 inch = 72 point
				$Num_value:=Round:C94($Num_value*72;$Lon_round)
				
				  //……………………………………………………………………………
			: ($Txt_fromUnit="mm")
				
				  //1 millimeter = 2.83464567 point
				$Num_value:=Round:C94($Num_value*2.83464567;$Lon_round)
				
				  //……………………………………………………………………………
			: ($Txt_fromUnit="cm")
				
				  //1 centimeter = 28.346456699999997 point
				$Num_value:=Round:C94($Num_value*((283464566/10000000)+((99999997/100000000)/10000000));$Lon_round)
				
				  //……………………………………………………………………………
			Else 
				
				ASSERT:C1129(False:C215;"Unit unhandled: \""+$Txt_fromUnit+"\"")
				
				  //……………………………………………………………………………
		End case 
		
		  //______________________________________________________
	: ($Txt_toUnit="cm")
		
		Case of 
				
				  //……………………………………………………………………………
			: ($Txt_fromUnit="in")
				
				  //1 inch = 2.5400000025908 centimeter
				$Num_value:=Round:C94($Num_value*(2.54000000259+((8/10000000)/1000000));$Lon_round)
				
				  //……………………………………………………………………………
			: ($Txt_fromUnit="pt")
				
				  //1 point = 0.03527777776895834 centimeter
				$Num_value:=Round:C94($Num_value*((352777/10000000)+(((7776895834/100000000)/10000000)/100));$Lon_round)
				
				  //……………………………………………………………………………
			: ($Txt_fromUnit="mm")
				
				  //1 millimeter = 0.1 centimeter
				$Num_value:=Round:C94($Num_value/10;$Lon_round)
				
				  //……………………………………………………………………………
			Else 
				
				ASSERT:C1129(False:C215;"Unit unhandled: \""+$Txt_fromUnit+"\"")
				
				  //……………………………………………………………………………
		End case 
		
		  //______________________________________________________
	: ($Txt_toUnit="mm")
		
		Case of 
				
				  //……………………………………………………………………………
			: ($Txt_fromUnit="in")
				
				  //1 inch = 25.400000025908 millimeter
				$Num_value:=Round:C94($Num_value*(2.54000000259+((8/10000000)/10000000));$Lon_round)
				
				  //……………………………………………………………………………
			: ($Txt_fromUnit="pt")
				
				  //1 point = 0.35277777768958335 millimeter
				$Num_value:=Round:C94($Num_value*(0.3527777776896+((958335/1000000000)/100000000));$Lon_round)
				
				  //……………………………………………………………………………
			: ($Txt_fromUnit="cm")
				
				  //1 centimeter = 10 millimeter
				$Num_value:=Round:C94($Num_value*10;$Lon_round)
				
				  //……………………………………………………………………………
			Else 
				
				ASSERT:C1129(False:C215;"Unit unhandled: \""+$Txt_fromUnit+"\"")
				
				  //……………………………………………………………………………
		End case 
		
		  //______________________________________________________
	: ($Txt_toUnit="in")
		
		Case of 
				
				  //……………………………………………………………………………
			: ($Txt_fromUnit="pt")
				
				  //1 point = 0.013888888871250001 inch
				$Num_value:=Round:C94($Num_value*(0.01388888887125+((1/1000000000)/1000000000));$Lon_round)
				
				  //……………………………………………………………………………
			: ($Txt_fromUnit="mm")
				
				  //1 millimeter = 0.0393700787 inch
				$Num_value:=Round:C94($Num_value*0.0393700787;$Lon_round)
				
				  //……………………………………………………………………………
			: ($Txt_fromUnit="cm")
				
				  //1 centimeter = 0.393700787 inch
				$Num_value:=Round:C94($Num_value*0.393700787;$Lon_round)
				
				  //……………………………………………………………………………
			Else 
				
				ASSERT:C1129(False:C215;"Unit unhandled: \""+$Txt_fromUnit+"\"")
				
				  //……………………………………………………………………………
		End case 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Invalid destination unit: \""+$Txt_toUnit+"\"")
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // Return
$0:=$Num_value

  // ----------------------------------------------------
  // End