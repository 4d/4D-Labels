//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : wizard_Field_icon
// Database: 4D Labels
// ID[9F0A61180A124453B4BADD6790E89677]
// Created #15-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_PICTURE:C286($0)
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_fieldType; $Lon_parameters)
C_PICTURE:C286($Pic_icon)
C_TEXT:C284($File_path; $Txt_imageFile; $Txt_root; $txt_suffix)

If (False:C215)
	C_PICTURE:C286(wizard_Field_icon; $0)
	C_LONGINT:C283(wizard_Field_icon; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Lon_fieldType:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

$txt_suffix:=Choose:C955((FORM Get color scheme:C1761="light"); ""; "_dark")

Case of 
		
		//________________________________________
	: ($Lon_fieldType=Is alpha field:K8:1)
		
		$Txt_imageFile:="Field_1"+$txt_suffix+".png"
		
		//________________________________________
	: ($Lon_fieldType=Is text:K8:3)
		
		$Txt_imageFile:="Field_2"+$txt_suffix+".png"
		
		//________________________________________
	: ($Lon_fieldType=Is date:K8:7)
		
		$Txt_imageFile:="Field_3"+$txt_suffix+".png"
		
		//________________________________________
	: ($Lon_fieldType=Is time:K8:8)
		
		$Txt_imageFile:="Field_4"+$txt_suffix+".png"
		
		//________________________________________
	: ($Lon_fieldType=Is boolean:K8:9)
		
		$Txt_imageFile:="Field_5"+$txt_suffix+".png"
		
		//________________________________________
	: ($Lon_fieldType=Is integer:K8:5)
		
		$Txt_imageFile:="Field_6"+$txt_suffix+".png"
		
		//________________________________________
	: ($Lon_fieldType=Is longint:K8:6)
		
		$Txt_imageFile:="Field_7"+$txt_suffix+".png"
		
		//________________________________________
	: ($Lon_fieldType=Is integer 64 bits:K8:25)
		
		$Txt_imageFile:="Field_8"+$txt_suffix+".png"
		
		//________________________________________
	: ($Lon_fieldType=Is real:K8:4)
		
		$Txt_imageFile:="Field_9"+$txt_suffix+".png"
		
		//________________________________________
	: ($Lon_fieldType=_o_Is float:K8:26)
		
		$Txt_imageFile:="Field_10"+$txt_suffix+".png"
		
		//________________________________________
	: ($Lon_fieldType=Is BLOB:K8:12)
		
		$Txt_imageFile:="Field_11"+$txt_suffix+".png"
		
		//________________________________________
	: ($Lon_fieldType=Is picture:K8:10)
		
		$Txt_imageFile:="Field_12"+$txt_suffix+".png"
		
		//________________________________________
	: ($Lon_fieldType=Is subtable:K8:11)
		
		$Txt_imageFile:="Field_13"+$txt_suffix+".png"
		
		//________________________________________
	: ($Lon_fieldType=Is object:K8:27)
		
		$Txt_imageFile:="Field_14"+$txt_suffix+".png"
		
		//________________________________________
End case 

//get the 4D resource
$Txt_root:=env_4D_Resources_folder_path+"images"+Folder separator:K24:12+"StructureEditor"+Folder separator:K24:12

$File_path:=$Txt_root+$Txt_imageFile

If (Test path name:C476($File_path)=Is a document:K24:1)
	
	READ PICTURE FILE:C678($File_path; $Pic_icon)
	
End if 

// ----------------------------------------------------
// Return
$0:=$Pic_icon

// ----------------------------------------------------
// End