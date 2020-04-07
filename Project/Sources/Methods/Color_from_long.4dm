//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Color_from_long
  // Database: 4D Labels
  // ID[816EFF42A98C4E8498B404A4E2090C7C]
  // Created #6-1-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_color;$Lon_parameters)
C_TEXT:C284($Txt_color;$Txt_target)

If (False:C215)
	C_TEXT:C284(Color_from_long ;$0)
	C_LONGINT:C283(Color_from_long ;$1)
	C_TEXT:C284(Color_from_long ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Lon_color:=$1
		
		If ($Lon_parameters>=2)
			
			$Txt_target:=$2  //fill | stroke
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_color=-1)
		
		$Txt_color:=Choose:C955($Txt_target="stroke";"black";"none")
		
		  //______________________________________________________
	Else 
		
		$Txt_color:="rgb("\
			+String:C10(($Lon_color & 0x00FF0000) >> 16)+","\
			+String:C10(($Lon_color & 0xFF00) >> 8)+","\
			+String:C10(($Lon_color & 0x00FF))+")"
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // Return
$0:=$Txt_color

  // ----------------------------------------------------
  // End