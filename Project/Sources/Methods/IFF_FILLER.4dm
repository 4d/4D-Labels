//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : IFF_FILLER
  // Database: 4D Labels
  // ID[8C28B7B4F36C4F90BBDC995D29D1A2E8]
  // Created #18-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)
C_POINTER:C301($2)

C_LONGINT:C283($Lon_padding;$Lon_parameters)
C_POINTER:C301($Ptr_offset)

If (False:C215)
	C_LONGINT:C283(IFF_FILLER ;$1)
	C_POINTER:C301(IFF_FILLER ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Lon_padding:=$1
	
	ASSERT:C1129(Not:C34(Is nil pointer:C315($2)))
	ASSERT:C1129(Type:C295($2->)=Is longint:K8:6)
	
	$Ptr_offset:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Ptr_offset->:=$Ptr_offset->+$Lon_padding

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End