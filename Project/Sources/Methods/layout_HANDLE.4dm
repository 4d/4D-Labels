//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : layout_HANDLE
// Database: 4D Labels
// ID[4AD91E218DCC4F26B7322AB8398E45B1]
// Created #7-7-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_color; $Lon_formEvent; $Lon_parameters)

If (False:C215)
	C_LONGINT:C283(layout_HANDLE; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		$Lon_formEvent:=$1
		
	Else 
		
		$Lon_formEvent:=Form event code:C388
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Activate:K2:9)
		
		//intensify the text labels
		OBJECT SET RGB COLORS:C628(*; "@.label@"; Foreground color:K23:1; Background color none:K23:10)
		OBJECT SET RGB COLORS:C628(*; "size.@"; Foreground color:K23:1; Background color none:K23:10)
		OBJECT SET RGB COLORS:C628(*; "layout.@"; Foreground color:K23:1; Background color none:K23:10)
		OBJECT SET RGB COLORS:C628(*; "method.@"; Foreground color:K23:1; Background color none:K23:10)
		OBJECT SET RGB COLORS:C628(*; "automatic_resizing"; Foreground color:K23:1; Background color none:K23:10)
		
		layout_UPDATE_UI
		
		//______________________________________________________
	: ($Lon_formEvent=On Deactivate:K2:10)
		
		//dim the text labels
		$Lon_color:=OB Get:C1224(<>label_params; "disabledTextColor"; Is longint:K8:6)
		OBJECT SET RGB COLORS:C628(*; "@.label@"; $Lon_color; Background color none:K23:10)
		OBJECT SET RGB COLORS:C628(*; "size.@"; $Lon_color; Background color none:K23:10)
		OBJECT SET RGB COLORS:C628(*; "layout.@"; $Lon_color; Background color none:K23:10)
		OBJECT SET RGB COLORS:C628(*; "method.@"; $Lon_color; Background color none:K23:10)
		OBJECT SET RGB COLORS:C628(*; "automatic_resizing"; $Lon_color; Background color none:K23:10)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+String:C10($Lon_formEvent)+"\"")
		
		//______________________________________________________
End case 

//restore lines' color
OBJECT SET RGB COLORS:C628(*; "@.line"; 0x00C0C0C0; Background color none:K23:10)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End