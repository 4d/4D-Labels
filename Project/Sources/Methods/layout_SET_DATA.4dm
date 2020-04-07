//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : layout_SET_DATA
  // Database: 4D Labels
  // ID[DB07854D600B421F95C42615D9FAE4E4]
  // Created #16-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_target;$Txt_value)
C_OBJECT:C1216($Obj_buffer)

If (False:C215)
	C_TEXT:C284(layout_SET_DATA ;$1)
	C_TEXT:C284(layout_SET_DATA ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_target:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Txt_value:=$2
		
	Else 
		
		$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)
		
		Case of 
				
				  //________________________________________
			: (Type:C295($Ptr_me->)=Is text:K8:3)\
				 | (Type:C295($Ptr_me->)=Is alpha field:K8:1)
				
				$Txt_value:=$Ptr_me->
				
				  //________________________________________
			: (Type:C295($Ptr_me->)=Is longint:K8:6)\
				 | (Type:C295($Ptr_me->)=Is integer:K8:5)\
				 | (Type:C295($Ptr_me->)=Is integer 64 bits:K8:25)\
				 | (Type:C295($Ptr_me->)=_o_Is float:K8:26)
				
				$Txt_value:=String:C10($Ptr_me->)
				
				  //________________________________________
			: (Type:C295($Ptr_me->)=Is real:K8:4)
				
				$Txt_value:=String:C10($Ptr_me->;"&xml")
				
				  //________________________________________
			Else 
				
				ASSERT:C1129(False:C215)
				
				  //________________________________________
		End case 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //store value
$Obj_buffer:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->

OB SET:C1220($Obj_buffer;\
$Txt_target;$Txt_value;\
"target";$Txt_target)

CALL SUBFORM CONTAINER:C1086(-1)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End