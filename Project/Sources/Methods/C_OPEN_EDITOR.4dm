//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : C_OPEN_EDITOR
// Database: 4D Labels
// ID[46972802CD8341ED8EF9C1435CC60B41]
// Created #7-4-2017 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Integer
var $2 : Boolean
var $3 : Text

var $Boo_autoClose : Boolean
var $Lon_masterTable; $Lon_parameters; $Win_hdl : Integer
var $Dir_resources; $Txt_labelDocument : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	COMPILER_wizard
	
	//NO PARAMETERS REQUIRED
	
	//defaults values
	$Lon_masterTable:=-1
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		$Lon_masterTable:=$1
		
		If ($Lon_parameters>=2)
			
			$Boo_autoClose:=$2
			
			If ($Lon_parameters>=3)
				
				$Txt_labelDocument:=$3
				
			End if 
		End if 
	End if 
	
	C_MASTER_TABLE:=$Lon_masterTable
	C_LABEL_DOCUMENT:=$Txt_labelDocument
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (C_MASTER_TABLE>=0)
	
	If ($Boo_autoClose)
		
		$Win_hdl:=Open form window:C675("LABEL_WIZARD"; Plain form window:K39:10; *)
		DIALOG:C40("LABEL_WIZARD"; *)
		
	Else 
		
		$Win_hdl:=Open form window:C675("LABEL_WIZARD"; Movable form dialog box:K39:8; *)
		DIALOG:C40("LABEL_WIZARD")
		CLOSE WINDOW:C154($Win_hdl)
		
	End if 
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End