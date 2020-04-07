//%attributes = {}
  // ----------------------------------------------------
  // Project method : test_xml
  // Database: 4D Labels
  // ID[49172D2C19F14C11A34D5C13883F9431]
  // Created #30-6-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // unitTest
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_i;$Lon_parameters)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //32 bits
ASSERT:C1129(xml_IsValidReference ("3438F2C031902008"))
ASSERT:C1129(Not:C34(xml_IsValidReference ("0000000000000000")))

  // 64 bits
ASSERT:C1129(xml_IsValidReference ("00007FC05759857000007FC052D97208"))
ASSERT:C1129(Not:C34(xml_IsValidReference ("00000000000000000000000000000000")))

  //invalid references
ASSERT:C1129(Not:C34(xml_IsValidReference ("")))  //empty
ASSERT:C1129(Not:C34(xml_IsValidReference ("3438F2C03190")))  //too short
ASSERT:C1129(Not:C34(xml_IsValidReference ("00007FC05759857000007FC052D9720")))  //too short
ASSERT:C1129(Not:C34(xml_IsValidReference ("3438F23438F2C031902008C031902008F")))  //too long
ASSERT:C1129(Not:C34(xml_IsValidReference ("3438F2C031902008A")))  //too long
ASSERT:C1129(Not:C34(xml_IsValidReference ("00007FC05759857000007FC052D9720X")))  //bad character
ASSERT:C1129(Not:C34(xml_IsValidReference ("3438F2C03190200Z")))  //bad character

  //note: if the command CLOSE XML is done just after the create, the reference is
  //reused and is always the same. So we made a loop for the creation, then another
  //one for the closing and test
ARRAY TEXT:C222($tDom_buffer;0x0000)

For ($Lon_i;1;100;1)
	
	APPEND TO ARRAY:C911($tDom_buffer;DOM Create XML Ref:C861("test"))
	
End for 

For ($Lon_i;1;Size of array:C274($tDom_buffer);1)
	
	DOM CLOSE XML:C722($tDom_buffer{$Lon_i})
	
	ASSERT:C1129(xml_IsValidReference ($tDom_buffer{$Lon_i}))
	
End for 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End