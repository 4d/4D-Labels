//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_UPDATE_TOOL
// Database: 4D Labels
// ID[E8F84F3346E94B23B702159ED59D712C]
// Created #9-6-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)
C_REAL:C285($2)

C_LONGINT:C283($Lon_parameters)
C_PICTURE:C286($Pic_buffer)
C_REAL:C285($Num_value)
C_TEXT:C284($Dom_root; $Dom_tool; $Txt_tool)
C_OBJECT:C1216($Obj_param)
C_BOOLEAN:C305($boo_isLightScheme)

If (False:C215)
	C_TEXT:C284(Editor_UPDATE_TOOL; $1)
	C_REAL:C285(Editor_UPDATE_TOOL; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	//Required parameters
	$Txt_tool:=$1
	$Num_value:=$2
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		// <NONE>
		
	End if 
	
	$Obj_param:=(OBJECT Get pointer:C1124(Object named:K67:5; "object"))->
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

$boo_isLightScheme:=(FORM Get color scheme:C1761="light")

$Dom_root:=DOM Parse XML source:C719(OB Get:C1224($Obj_param; "root-media"; Is text:K8:3)+$Txt_tool+Choose:C955($boo_isLightScheme; ""; "_dark")+".svg")

If (OK=1)
	
	$Dom_tool:=DOM Find XML element by ID:C1010($Dom_root; "tool")
	
	If (OK=1)
		
		Case of 
				
				//______________________________________________________
			: ($Txt_tool="stroke-width")
				
				If ($Num_value=0)
					
					DOM SET XML ATTRIBUTE:C866($Dom_tool; \
						"stroke"; "#9999FF"; \
						"stroke-dasharray"; "2,2"; \
						"stroke-width"; 1)
					
				Else 
					
					DOM SET XML ATTRIBUTE:C866($Dom_tool; \
						"stroke"; "rgb(0,0,0)"; \
						"stroke-dasharray"; ""; \
						"stroke-width"; $Num_value)
					
				End if 
				
				//______________________________________________________
			Else 
				
				//fill & stroke
				DOM SET XML ATTRIBUTE:C866($Dom_tool; \
					"fill"; Color_from_long($Num_value; $Txt_tool))
				
				//______________________________________________________
		End case 
		
		SVG EXPORT TO PICTURE:C1017($Dom_root; $Pic_buffer)
		CONVERT PICTURE:C1002($Pic_buffer; ".png")
		
		OBJECT SET VALUE:C1742($Txt_tool; $Pic_buffer)
		
	End if 
	
	DOM CLOSE XML:C722($Dom_root)
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End