//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : IFF_Get_text
  // Database: 4D Labels
  // ID[462938BC556E454AAD4C356D15A8E6C8]
  // Created #18-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_POINTER:C301($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)

C_LONGINT:C283($Lon_parameters;$Lon_textFormat)
C_POINTER:C301($Ptr_offset;$Ptr_source)
C_TEXT:C284($Txt_text)

If (False:C215)
	C_TEXT:C284(IFF_Get_text ;$0)
	C_POINTER:C301(IFF_Get_text ;$1)
	C_POINTER:C301(IFF_Get_text ;$2)
	C_LONGINT:C283(IFF_Get_text ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	ASSERT:C1129(Not:C34(Is nil pointer:C315($1)))
	ASSERT:C1129(Type:C295($1->)=Is BLOB:K8:12)
	
	$Ptr_source:=$1  //BLOB Ptr
	
	ASSERT:C1129(Not:C34(Is nil pointer:C315($2)))
	ASSERT:C1129(Type:C295($2->)=Is longint:K8:6)
	
	$Ptr_offset:=$2  //offset Ptr
	
	$Lon_textFormat:=Mac text without length:K22:10
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		$Lon_textFormat:=$3
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Txt_text:=BLOB to text:C555($Ptr_source->;$Lon_textFormat;$Ptr_offset->;IFF_Get_long ($Ptr_source;$Ptr_offset))

  // ----------------------------------------------------
  // Return
$0:=$Txt_text

  // ----------------------------------------------------
  // End