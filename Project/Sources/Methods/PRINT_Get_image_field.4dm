//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : PRINT_Get_image_field
  // Database: 4D Labels
  // ID[575A4F1544BB47D0B96B01FEEC4A679F]
  // Created #20-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_PICTURE:C286($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters;$Lon_start)
C_PICTURE:C286($Pic_image)
C_POINTER:C301($Ptr_field)
C_TEXT:C284($Txt_expression;$Txt_segment)

ARRAY LONGINT:C221($tLon_lengths;0)
ARRAY LONGINT:C221($tLon_positions;0)

If (False:C215)
	C_PICTURE:C286(PRINT_Get_image_field ;$0)
	C_TEXT:C284(PRINT_Get_image_field ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_expression:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	$Lon_start:=1
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
While (Match regex:C1019("([^+]+)";$Txt_expression;$Lon_start;$tLon_positions;$tLon_lengths))
	
	$Txt_segment:=Substring:C12($Txt_expression;$tLon_positions{1};$tLon_lengths{1})
	
	$Ptr_field:=Get_field_pointer ($Txt_segment)
	
	If (Asserted:C1132(Not:C34(Is nil pointer:C315($Ptr_field))))
		
		If (Type:C295($Ptr_field->)=Is picture:K8:10)
			
			COMBINE PICTURES:C987($Pic_image;$Pic_image;Horizontal concatenation:K61:8;$Ptr_field->)
			
		End if 
	End if 
	
	$Lon_start:=$tLon_positions{1}+$tLon_lengths{1}
	
End while 

  // ----------------------------------------------------
  // Return
$0:=$Pic_image

  // ----------------------------------------------------
  // End