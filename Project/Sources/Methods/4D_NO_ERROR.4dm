//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : 4D_NO_ERROR
  // Database: 4D Labels
  // ID[2A4997B674894DF0A3426A528B06ECFD]
  // Created #12-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // traps errors
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_entryPoint;$Txt_me;$Txt_onErrorMethod)

If (False:C215)
	C_TEXT:C284(4D_NO_ERROR ;$0)
	C_TEXT:C284(4D_NO_ERROR ;$1)
	C_TEXT:C284(4D_NO_ERROR ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Txt_entryPoint:=$1  //'ON' to install - "OFF" to uninstall
		
		If ($Lon_parameters>=2)
			
			$Txt_onErrorMethod:=$2  //{for 'OFF' -> method to restore} (if missing -> stops the trapping of errors)
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Txt_me:=Current method name:C684

Case of 
		
		  //________________________________________
	: (Length:C16($Txt_entryPoint)=0)
		
		If (Method called on error:C704=$Txt_me)
			
			  //Error handling manager
			IDLE:C311  //no error
			
			OK:=0
			
		Else 
			
			ASSERT:C1129(False:C215;"Missing entry point")
			
		End if 
		
		  //________________________________________
	: ($Txt_entryPoint="ON")
		
		$Txt_onErrorMethod:=Method called on error:C704
		
		If ($Txt_onErrorMethod#$Txt_me)  //& (Is compiled mode)
			
			ON ERR CALL:C155($Txt_me)
			
		End if 
		
		$0:=$Txt_onErrorMethod  //previously installed method
		
		  //________________________________________
	: ($Txt_entryPoint="OFF")
		
		ON ERR CALL:C155($Txt_onErrorMethod)
		
		  //________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_entryPoint+"\"")
		
		  //________________________________________
End case 

  // ----------------------------------------------------
  // Return

  // ----------------------------------------------------
  // End