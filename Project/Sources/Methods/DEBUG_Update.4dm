//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : DEBUG_Update
// Database: 4D Labels
// ID[CE020683638949309D246B8F4D39165A]
// Created #12-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Boolean
var $1 : Text
var $2 : Integer
var $3 : Integer

var $Lon_parameters : Integer
var $Ptr_buffer : Pointer
var $Txt_entrypoint : Text


// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Txt_entrypoint:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//________________________________________
	: (Not:C34(OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5; "object"))->; "debug"; Is boolean:K8:9)))
		
		//NOTHING MORE TO DO
		
		//______________________________________________________
	: ($Txt_entrypoint="redraw")
		
		$Ptr_buffer:=OBJECT Get pointer:C1124(Object named:K67:5; "Debug_Redraw")
		$Ptr_buffer->:=$Ptr_buffer->+1
		
		//______________________________________________________
	: ($Txt_entrypoint="on timer")
		
		$Ptr_buffer:=OBJECT Get pointer:C1124(Object named:K67:5; "Debug_TimerCount")
		
		If ($Lon_parameters=2)
			
			$Ptr_buffer->:=0  //reset
			
		Else 
			
			$Ptr_buffer->:=$Ptr_buffer->+1
			(OBJECT Get pointer:C1124(Object named:K67:5; "Debug_MouseX"))->:=$2
			(OBJECT Get pointer:C1124(Object named:K67:5; "Debug_MouseY"))->:=$3
			
		End if 
		
		//______________________________________________________
	: ($Txt_entrypoint="clic")
		
		(OBJECT Get pointer:C1124(Object named:K67:5; "Debug_ClickX"))->:=$2
		(OBJECT Get pointer:C1124(Object named:K67:5; "Debug_ClickY"))->:=$3
		
		//______________________________________________________
	: ($Txt_entrypoint="history")
		
		(OBJECT Get pointer:C1124(Object named:K67:5; "Debug_History"))->:=$2
		
		//______________________________________________________
	: (False:C215)
		
		//______________________________________________________
	Else   //path
		
		(OBJECT Get pointer:C1124(Object named:K67:5; "Debug_Path"))->:=$Txt_entrypoint
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// Return
$0:=True:C214  //allow using ASSERT

// ----------------------------------------------------
// End