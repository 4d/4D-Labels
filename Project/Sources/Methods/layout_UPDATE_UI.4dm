//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : layout_UPDATE_UI
// Database: 4D Labels
// ID[FF2CF011FAFB4108B23855B4766BC323]
// Created #7-10-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_disabledTextColor; $Lon_parameters)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		// <NONE>
		
	End if 
	
	$Lon_disabledTextColor:=OB Get:C1224(<>label_params; "disabledTextColor"; Is longint:K8:6)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ((OBJECT Get pointer:C1124(Object named:K67:5; "automatic_resizing"))->=1)
	
	OBJECT SET ENTERABLE:C238(*; "size.width.box"; False:C215)
	OBJECT SET ENTERABLE:C238(*; "size.height.box"; False:C215)
	
	OBJECT SET ENABLED:C1123(*; "size.width.box"; False:C215)
	OBJECT SET ENABLED:C1123(*; "size.height.box"; False:C215)
	
	OBJECT SET RGB COLORS:C628(*; "size.width.@"; $Lon_disabledTextColor; Background color none:K23:10)
	OBJECT SET RGB COLORS:C628(*; "size.height.@"; $Lon_disabledTextColor; Background color none:K23:10)
	
Else 
	
	OBJECT SET ENTERABLE:C238(*; "size.width.box"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "size.height.box"; True:C214)
	
	OBJECT SET ENABLED:C1123(*; "size.width.box"; True:C214)
	OBJECT SET ENABLED:C1123(*; "size.height.box"; True:C214)
	
	OBJECT SET RGB COLORS:C628(*; "size.width.@"; Foreground color:K23:1; Background color none:K23:10)
	OBJECT SET RGB COLORS:C628(*; "size.height.@"; Foreground color:K23:1; Background color none:K23:10)
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End