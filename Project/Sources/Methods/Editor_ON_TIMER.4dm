//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_ON_TIMER
// Database: 4D Labels
// ID[6E0A61164FFD4076BDCDB28213DC438F]
// Created #22-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($Boo_update)
C_LONGINT:C283($Lon_; $Lon_mouseButton; $Lon_parameters)
C_TEXT:C284($Txt_tool)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		// <NONE>
		
	End if 
	
	MOUSE POSITION:C468($Lon_; $Lon_; $Lon_mouseButton)
	
	$Txt_tool:=Editor_Get_current_tool
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($Lon_mouseButton=0)  //up
	
	SET TIMER:C645(0)
	SET CURSOR:C469(0)
	
	ASSERT:C1129(DEBUG_Update("on timer"; 0))
	
	Case of 
			
			//________________________________________
		: ($Txt_tool="select")
			
			$Boo_update:=Editor_RECT_DRAGGER_Stop(MOUSEX; MOUSEY)
			
			//________________________________________
		: ($Txt_tool="text")
			
			$Boo_update:=Editor_TEXT_Stop(MOUSEX; MOUSEY)
			
			//________________________________________
		: ($Txt_tool="formula")
			$Boo_update:=Editor_FORMULA_Stop(MOUSEX; MOUSEY)
			
			//________________________________________
		Else 
			
			$Boo_update:=Editor_COMMON_Stop($Txt_tool; MOUSEX; MOUSEY)
			
			//________________________________________
	End case 
	
	If ($Boo_update)
		
		//force update
		(OBJECT Get pointer:C1124(Object subform container:K67:4))->:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
		
	End if 
	
Else 
	
	ASSERT:C1129(DEBUG_Update("on timer"; MOUSEX; MOUSEY))
	
	Case of 
			
			//________________________________________
		: (MOUSEX=-1)\
			 | (MOUSEY=-1)
			
			//NOTHING MORE TO DO
			
			//________________________________________
		: ($Txt_tool="select")
			
			Editor_RECT_DRAGGER_ON_IDLE(MOUSEX; MOUSEY)
			
			//________________________________________
		: ($Txt_tool="text")
			
			Editor_TEXT_ON_IDLE(MOUSEX; MOUSEY)
			
			
		: ($Txt_tool="formula")
			
			//mark:- feature #11777
			Editor_FORMULA_ON_IDLE(MOUSEX; MOUSEY)
			
			//________________________________________
		Else 
			
			Editor_COMMON_ON_IDLE($Txt_tool; MOUSEX; MOUSEY)
			
			//________________________________________
	End case 
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End