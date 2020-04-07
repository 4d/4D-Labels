  // ----------------------------------------------------
  // Form method : MESSAGE - (4D Report)
  // ID[B1C4CB6F3D144B1AA6C7AFFA8BF75597]
  // Created #4-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_comment;$Txt_title)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Ptr_me:=OBJECT Get pointer:C1124(Object subform container:K67:4)

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		  //adjust UI
		obj_BEST_WIDTH (Align left:K42:2;"doNotAskAgain")
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		  //message
		$Txt_title:=OB Get:C1224($Ptr_me->;"message";Is text:K8:3)
		
		ST SET ATTRIBUTES:C1093($Txt_title;ST Start text:K78:15;ST End text:K78:16;\
			Attribute bold style:K65:1;1)
		
		If (OB Is defined:C1231($Ptr_me->;"comment"))
			
			$Txt_comment:=OB Get:C1224($Ptr_me->;"comment";Is text:K8:3)
			
			ST SET ATTRIBUTES:C1093($Txt_comment;ST Start text:K78:15;ST End text:K78:16;\
				Attribute text size:K65:6;10)
			
			$Txt_title:=$Txt_title+"<br/><br/>"+$Txt_comment
			
		End if 
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"text"))->:=$Txt_title
		
		  //OK button's label
		If (OB Is defined:C1231($Ptr_me->;"ok-label"))
			
			OBJECT SET TITLE:C194(*;"OK";OB Get:C1224($Ptr_me->;"ok-label";Is text:K8:3))
			
		End if 
		
		  //adjust UI
		obj_BEST_WIDTH (Align right:K42:4;"ok")
		
		  //Cancel button's label
		If (OB Is defined:C1231($Ptr_me->;"cancel-label"))
			
			OBJECT SET TITLE:C194(*;"cancel";OB Get:C1224($Ptr_me->;"cancel-label";Is text:K8:3))
			OBJECT SET VISIBLE:C603(*;"cancel";True:C214)
			
			  //adjust UI
			obj_BEST_WIDTH (Align left:K42:2;"cancel")
			obj_ALIGN (Align right:K42:4;20;"ok";"cancel")
			
		Else 
			
			OBJECT SET VISIBLE:C603(*;"cancel";False:C215)
			
		End if 
		
		  //no button's label
		If (OB Is defined:C1231($Ptr_me->;"no-label"))
			
			$Txt_title:=OB Get:C1224($Ptr_me->;"no-label";Is text:K8:3)
			OBJECT SET TITLE:C194(*;"no";$Txt_title)
			OBJECT SET VISIBLE:C603(*;"no";True:C214)
			OBJECT SET SHORTCUT:C1185(*;"no";$Txt_title[[1]])  //;0)
			
			  //adjust UI
			obj_BEST_WIDTH (Align left:K42:2;"no")
			
		Else 
			
			OBJECT SET VISIBLE:C603(*;"no";False:C215)
			
		End if 
		
		  //checkbox "Do not ask again"
		If (OB Is defined:C1231($Ptr_me->;"doNotAskAgain"))
			
			(OBJECT Get pointer:C1124(Object named:K67:5;"doNotAskAgain"))->:=0
			OBJECT SET VISIBLE:C603(*;"doNotAskAgain";OB Get:C1224($Ptr_me->;"doNotAskAgain";Is boolean:K8:9))
			
		Else 
			
			OBJECT SET VISIBLE:C603(*;"doNotAskAgain";False:C215)
			
		End if 
		
		  //reset interchange values
		OB SET:C1220($Ptr_me->;\
			"action";"")
		
		OB REMOVE:C1226($Ptr_me->;"doNotAskAgain")
		
		  //______________________________________________________
	: ($Lon_formEvent=On Bound Variable Change:K2:52)  //update UI
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 