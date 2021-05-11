//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : LABELS_INIT
// Database: 4D Labels
// ID[DE0BBB586B0D42368A1B152591FE34DD]
// Created #7-10-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_parameters)
C_BOOLEAN:C305($boo_isColorSchemeLight)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Not:C34(<>inited))\
 | (Shift down:C543 & Not:C34(Is compiled mode:C492))
	
	<>inited:=True:C214
	
	<>Boo_debug:=(Structure file:C489=Structure file:C489(*))\
		 | Not:C34(Is compiled mode:C492)
	
	SET ASSERT ENABLED:C1131(<>Boo_debug)
	
	//Label editor round rect default rx/ry
	OB SET:C1220(<>label_params; \
		"defaultRoundRect"; 6)
	
	//prefix
	OB SET:C1220(<>label_params; \
		"objectPrefix"; "object-"; \
		"classPrefix"; "class-"; \
		"select-prefix"; "select-")
	
	//object shape rendering
	OB SET:C1220(<>label_params; \
		"shape-rendering"; "geometricPrecision"; \
		"text-rendering"; "auto"; \
		"stroke-linejoin"; "miter")
	
	//Label Editor Matrix
	OB SET:C1220(<>label_params; \
		"left"; 237; \
		"top"; 55; \
		"width"; 348; \
		"height"; 191; \
		"label-margin"; 20)
	
	//Label Editor Matrix (Subform)
	OB SET:C1220(<>label_params; \
		"image-left"; 70; \
		"image-top"; 10)
	
	$boo_isColorSchemeLight:=(FORM Get color scheme:C1761="light")
	
	//the color for the deactivated texts
	OB SET:C1220(<>label_params; \
		"disabledTextColor"; Choose:C955($boo_isColorSchemeLight; 0x008D8D8D; 0x00939694))
	
	//selection
	OB SET:C1220(<>label_params; \
		"select-rect-prefix"; "select-rect-"; \
		"selection-fill"; "#666666"; \
		"selection-fill-opacity"; 0.1; \
		"selection-stroke"; "#EEEEEE"; \
		"selection-stroke-opacity"; 0.7; \
		"selection-stroke-width"; 1; \
		"selection-handle-width"; 10; \
		"selection-handle-fill"; "#9999FF"; \
		"selection-handle-fill-opacity"; 0.7; \
		"selection-handle-stroke"; "#EEEEEE"; \
		"selection-handle-stroke-opacity"; 0.7; \
		"selection-handle-stroke-width"; 0.5)
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End