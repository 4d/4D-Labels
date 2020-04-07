//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_PUT_USER_FORM
  // Database: 4D Labels
  // ID[EBECDF824E4C4479B3E19B1A861C8422]
  // Created #2-7-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters)
C_PICTURE:C286($p)
C_POINTER:C301($Ptr_table)
C_TEXT:C284($t;$Txt_name)

If (False:C215)
	C_TEXT:C284(Editor_PUT_USER_FORM ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  // Required parameters
	$Txt_name:=$1
	
	  // Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	$Ptr_table:=Table:C252(C_MASTER_TABLE)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

  //=====================================
$t:=4D_NO_ERROR ("ON")

FORM SCREENSHOT:C940($Ptr_table->;$Txt_name;$p)
(OBJECT Get pointer:C1124(Object named:K67:5;"Image"))->:=$p

  //=====================================
4D_NO_ERROR ("OFF";$t)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // Endh