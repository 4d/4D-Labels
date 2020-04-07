//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : IFF_Get_pascal_text
  // Database: 4D Labels
  // ID[31D3B0D7A9BA4C30B86ED50952DB5738]
  // Created #18-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_LONGINT:C283($Lon_length;$Lon_parameters;$Lon_position)
C_POINTER:C301($Ptr_offset;$Ptr_source)
C_TEXT:C284($Txt_result)

If (False:C215)
	C_TEXT:C284(IFF_Get_pascal_text ;$0)
	C_LONGINT:C283(IFF_Get_pascal_text ;$1)
	C_POINTER:C301(IFF_Get_pascal_text ;$2)
	C_POINTER:C301(IFF_Get_pascal_text ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=3;"Missing parameter"))
	
	  //Required parameters
	$Lon_length:=$1
	
	ASSERT:C1129(Not:C34(Is nil pointer:C315($2)))
	ASSERT:C1129(Type:C295($2->)=Is BLOB:K8:12)
	
	$Ptr_source:=$2  //BLOB Ptr
	
	ASSERT:C1129(Not:C34(Is nil pointer:C315($3)))
	ASSERT:C1129(Type:C295($3->)=Is longint:K8:6)
	
	$Ptr_offset:=$3  //offset Ptr
	
	  //Optional parameters
	If ($Lon_parameters>=4)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Lon_position:=$Ptr_offset->

$Txt_result:=BLOB to text:C555($Ptr_source->;Mac Pascal string:K22:8;$Ptr_offset->)

$Ptr_offset->:=$Lon_position+$Lon_length

  // ----------------------------------------------------
  // Return
$0:=$Txt_result

  // ----------------------------------------------------
  // End