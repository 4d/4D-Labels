//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : wizard_Save
// Database: 4D Labels
// ID[69C8E5BA53924BA8AB554C543FAE95F7]
// Created #16-6-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_success)
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($File_pathname; $kTxt_extension; $Txt_extension; $Txt_name)
C_OBJECT:C1216($Obj_form; $Obj_path)

If (False:C215)
	C_BOOLEAN:C305(wizard_Save; $0)
	C_TEXT:C284(wizard_Save; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	// NO PARAMETERS REQUIRED
	
	// Optional parameters
	If ($Lon_parameters>=1)
		
		$File_pathname:=$1
		
	End if 
	
	$kTxt_extension:=".4lbp"
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Length:C16($File_pathname)=0)
	
	$Txt_name:=Select document:C905(13893; \
		$kTxt_extension; \
		Localized string:C991("Save label settings file..."); \
		Package open:K24:8+Use sheet window:K24:11 | File name entry:K24:17)
	
	
	
Else 
	
	DOCUMENT:=$File_pathname
	OK:=1
	
End if 

If (OK=1)
	
	$Obj_path:=Path to object:C1547(DOCUMENT)
	$Obj_path.extension:=$kTxt_extension
	$File_pathname:=Object to path:C1548($Obj_path)
	//ACI0101350{
	If (Is Windows:C1573)
		If (Substring:C12($File_pathname; Length:C16($File_pathname)-9)=".4lbp.4lbp")
			$File_pathname:=Substring:C12($File_pathname; 0; Length:C16($File_pathname)-5)
		End if 
	End if 
	//}
	C_LABEL_DOCUMENT:=$File_pathname
	
	$Obj_form:=(OBJECT Get pointer:C1124(Object named:K67:5; "object"))->
	
	$Obj_form.path:=$File_pathname
	
	DOM EXPORT TO FILE:C862($Obj_form.dom; $File_pathname)
	
	$Boo_success:=(OK=1)
	
End if 

// ----------------------------------------------------
// Return
return $Boo_success

// ----------------------------------------------------
// End