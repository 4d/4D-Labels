//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_OB_Get_type
  // Database: 4D Labels
  // ID[9C34A8460BD74F59BE2E4F4ECE171C7E]
  // Created #7-1-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_POINTER:C301($3)
C_POINTER:C301($4)

C_BOOLEAN:C305($Boo_isImage;$Boo_isText)
C_LONGINT:C283($Lon_parameters;$Lon_type)
C_POINTER:C301($Ptr_isImage;$Ptr_isText)
C_TEXT:C284($Dom_label;$Dom_object;$Txt_id;$Txt_type)

If (False:C215)
	C_TEXT:C284(Editor_OB_Get_type ;$0)
	C_TEXT:C284(Editor_OB_Get_type ;$1)
	C_TEXT:C284(Editor_OB_Get_type ;$2)
	C_POINTER:C301(Editor_OB_Get_type ;$3)
	C_POINTER:C301(Editor_OB_Get_type ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Dom_label:=$1
	$Txt_id:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		$Ptr_isText:=$3
		
		If ($Lon_parameters>=4)
			
			$Ptr_isImage:=$4
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Dom_object:=DOM Find XML element by ID:C1010($Dom_label;$Txt_id)

If (Asserted:C1132(OK=1))
	
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"type";$Txt_type)
	
	Case of 
			
			  //________________________________________
		: ($Lon_parameters=2)
			
			  //NOTHING MORE TO DO
			
			  //________________________________________
		: ($Txt_type="text")
			
			$Boo_isText:=True:C214
			
			  //________________________________________
		: ($Txt_type="image")
			
			$Boo_isImage:=True:C214
			
			  //________________________________________
		: ($Txt_type="variable")
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"field-type";$Lon_type)
			$Boo_isText:=($Lon_type#Is picture:K8:10)
			$Boo_isImage:=($Lon_type=Is picture:K8:10)
			
			  //________________________________________
	End case 
End if 

  // ----------------------------------------------------
  // Return
If ($Lon_parameters>=3)
	
	$Ptr_isText->:=$Boo_isText
	
	If ($Lon_parameters>=4)
		
		$Ptr_isImage->:=$Boo_isImage
		
	End if 
End if 

$0:=$Dom_object

  // ----------------------------------------------------
  // End