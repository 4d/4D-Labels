  // ----------------------------------------------------
  // Form method : Editor - (4D Labels)
  // ID[ECBBDF3534C64FB8BE512C9032F8347B]
  // Created #19-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_container)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Ptr_container:=OBJECT Get pointer:C1124(Object subform container:K67:4)

  // ----------------------------------------------------

If ($Lon_formEvent=On Load:K2:1)
	
	COMPILER_Editor 
	
	Editor_INIT 
	
	If (Asserted:C1132(Type:C295($Ptr_container->)=Is text:K8:3;"The type of subform container is incorrect"))
		
		  //retrieve offsets
		CALL SUBFORM CONTAINER:C1086(-109)
		
	End if 
	
	$Lon_formEvent:=On Bound Variable Change:K2:52
	
End if 

Case of 
		
		  //________________________________________
	: (Is nil pointer:C315($Ptr_container))
		
		  //NOTHING MORE TO DO
		
		  //________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		SET TIMER:C645(0)
		
		  //________________________________________
	: ($Lon_formEvent=On Bound Variable Change:K2:52)
		
		Editor_ON_DATA_CHANGE 
		
		  //________________________________________
	: ($Lon_formEvent=On Activate:K2:9)
		
		  //Enable the shortcuts
		OBJECT SET VISIBLE:C603(*;"shortcut.@";True:C214)
		
		  //________________________________________
	: ($Lon_formEvent=On Deactivate:K2:10)
		
		  //Disable the shortcuts
		OBJECT SET VISIBLE:C603(*;"shortcut.@";False:C215)
		
		  //________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		Editor_ON_TIMER 
		
		  //________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //________________________________________
End case 