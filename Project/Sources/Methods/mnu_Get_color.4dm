//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : mnu_Get_color
  // Database: 4D Labels
  // ID[10A31278BFB84CADA53AB0287F8CC114]
  // Created #7-1-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_color;$Lon_parameters)
C_TEXT:C284($Txt_itemParameter)

If (False:C215)
	C_LONGINT:C283(mnu_Get_color ;$0)
	C_TEXT:C284(mnu_Get_color ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_itemParameter:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Lon_color:=convert_hexToDec (Delete string:C232($Txt_itemParameter;1;Position:C15("_";$Txt_itemParameter)))

Case of 
		
		  //------------------------------------
	: ($Lon_color=1)  //None
		
		$Lon_color:=-1  //0
		
		  //------------------------------------
	: ($Lon_color=0)  //personalized
		
		  //displays the system color selection window
		  //and returns the RGB value of the color selected by the user
		$Lon_color:=Select RGB color:C956($Lon_color)
		
		  //------------------------------------
	Else 
		
		  //NOTHING MORE TO DO
		
		  //------------------------------------
End case 

  // ----------------------------------------------------
  // Return
$0:=$Lon_color

  // ----------------------------------------------------
  // End