//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : 4D_LOG
  // Database: 4D Labels
  // ID[7A8C25E4AC1C4CCAA5FBFC802D05B5B6]
  // Created #8-10-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters;$Lon_type;$Lon_where)
C_TEXT:C284($Txt_database;$Txt_message)

If (False:C215)
	C_BOOLEAN:C305(4D_LOG ;$0)
	C_TEXT:C284(4D_LOG ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_message:=$1
	
	  //Default values
	$Lon_where:=Into 4D debug message:K38:5
	$Lon_type:=Error message:K38:3
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	$Txt_database:=Replace string:C233(Structure file:C489;Get 4D folder:C485(Database folder:K5:14);"")
	$Txt_database:=Replace string:C233($Txt_database;".4db";"")
	$Txt_database:=Replace string:C233($Txt_database;".4dc";"")
	
	$Txt_message:="["+$Txt_database+"] "+$Txt_message
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
LOG EVENT:C667($Lon_where;$Txt_message;$Lon_type)

  // ----------------------------------------------------
  // Return
$0:=True:C214  //For a use with ASSERT

  // ----------------------------------------------------
  // End