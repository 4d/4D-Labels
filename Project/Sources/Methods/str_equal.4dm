//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : str_equal
  // Database: development
  // ID[DCF30A469D5E4218B85F194A77D16EFA]
  // Created #12-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // Tests if two strings are strictly identical
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($Boo_equal)
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_string_1;$Txt_string_2)

If (False:C215)
	C_BOOLEAN:C305(str_equal ;$0)
	C_TEXT:C284(str_equal ;$1)
	C_TEXT:C284(str_equal ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Txt_string_1:=$1
	$Txt_string_2:=$2
	
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
	: (Length:C16($Txt_string_1)#Length:C16($Txt_string_2))
		
		  //Obviously not identical
		
		  //________________________________________
	: (Length:C16($Txt_string_1)=0)
		
		  //Both strings are empty
		$Boo_equal:=True:C214
		
		  //________________________________________
	Else 
		
		$Boo_equal:=(Position:C15($Txt_string_1;$Txt_string_2;1;*)=1)
		
		  //________________________________________
End case 

  // ----------------------------------------------------
  // Return
$0:=$Boo_equal

  // ----------------------------------------------------
  // End