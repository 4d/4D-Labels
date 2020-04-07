//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : IFF_Get_byte
  // Database: 4D Labels
  // ID[169BCEECE0BC41E8A0E50DA6FBC6C322]
  // Created #18-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BLOB:C604($0)
C_POINTER:C301($1)
C_POINTER:C301($2)

C_BLOB:C604($Blb_byte)
C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_offset;$Ptr_source)

If (False:C215)
	C_BLOB:C604(IFF_Get_byte ;$0)
	C_POINTER:C301(IFF_Get_byte ;$1)
	C_POINTER:C301(IFF_Get_byte ;$2)
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
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
COPY BLOB:C558($Ptr_source->;$Blb_byte;$Ptr_offset->;0;1)
$Ptr_offset->:=$Ptr_offset->+1

  // ----------------------------------------------------
  // Return
$0:=$Blb_byte

  // ----------------------------------------------------
  // End