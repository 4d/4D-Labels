//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : DEBUG_EXPORT_CANVAS
  // Database: 4D Labels
  // ID[0C31D8C5974648448A56DC18ED0A9D13]
  // Created #21-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Dir_export;$Dom_hdl;$Txt_name;$Txt_what)

If (False:C215)
	C_TEXT:C284(DEBUG_EXPORT ;$1)
	C_TEXT:C284(DEBUG_EXPORT ;$2)
	C_TEXT:C284(DEBUG_EXPORT ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Txt_what:=$1
	$Dom_hdl:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		$Txt_name:=$3
		
	End if 
	
	$Dir_export:=System folder:C487(Desktop:K41:16)+"DEV"+Folder separator:K24:12
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: (Is compiled mode:C492)
		
		  //NOTHING MORE TO DO
		
		  //______________________________________________________
	: (Test path name:C476($Dir_export)#Is a folder:K24:2)
		
		  //NOTHING MORE TO DO
		
		  //______________________________________________________
	: ($Txt_what="canvas")
		
		If (Length:C16($Txt_name)>0)
			
			DOM EXPORT TO FILE:C862($Dom_hdl;$Dir_export+$Txt_name)
			
		Else 
			
			DOM EXPORT TO FILE:C862($Dom_hdl;$Dir_export+"image.svg")
			
		End if 
		
		  //______________________________________________________
	: ($Txt_what="label")
		
		If (Length:C16($Txt_name)>0)
			
			DOM EXPORT TO FILE:C862($Dom_hdl;$Dir_export+$Txt_name)
			
		Else 
			
			DOM EXPORT TO FILE:C862($Dom_hdl;$Dir_export+"label.xml")
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_what+"\"")
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End