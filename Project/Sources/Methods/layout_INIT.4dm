//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : wizard_INIT
  // Database: 4D Labels
  // ID[E9019810C6A346A4804BB0DF82566898]
  // Created #16-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($Boo_fixedHeight;$Boo_fixedWidth;$Boo_mode;$Boo_prefilled)
C_LONGINT:C283($Lon_;$Lon_i;$Lon_pages;$Lon_parameters;$Lon_platform;$Lst_buffer)
C_POINTER:C301($Ptr_table)
C_TEXT:C284($File_user;$Txt_buffer)

ARRAY TEXT:C222($tTxt_buffer;0)
ARRAY TEXT:C222($tTxt_forms;0)
ARRAY TEXT:C222($tTxt_methods;0)
ARRAY OBJECT:C1221($tObj_param;0)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
OBJECT SET VISIBLE:C603(*;"Debug@";<>Boo_debug)

  //==================== adjust display according to the platform
_O_PLATFORM PROPERTIES:C365($Lon_platform)

If ($Lon_platform=Mac OS:K25:2)
	
	OBJECT SET VISIBLE:C603(*;"win.@";False:C215)
	
Else 
	
	OBJECT SET VISIBLE:C603(*;"mac.@";False:C215)
	
End if 

  //==================== check for user's restrictions
$File_user:=Get 4D folder:C485(Current resources folder:K5:16;*)+"labels.json"

If (Test path name:C476($File_user)=Is a document:K24:1)
	
	$Txt_buffer:=Document to text:C1236($File_user)
	
	JSON PARSE ARRAY:C1219($Txt_buffer;$tObj_param)
	
	For ($Lon_i;1;Size of array:C274($tObj_param);1)
		
		If (C_MASTER_TABLE=OB Get:C1224($tObj_param{$Lon_i};"tableId";Is longint:K8:6))
			
			$tObj_param:=$Lon_i
			$Lon_i:=MAXLONG:K35:2-1
			
		End if 
	End for 
End if 

  //==================== determine if the mode menu should be displayed
$Ptr_table:=Table:C252(C_MASTER_TABLE)

  //get the available forms for the current table
FORM GET NAMES:C1167($Ptr_table->;$tTxt_forms;*)

  //restrict the list, if necessary, according to user instructions
$Boo_prefilled:=($tObj_param>0)

If ($Boo_prefilled)
	
	$Boo_prefilled:=OB Is defined:C1231($tObj_param{$tObj_param};"forms")
	
	If ($Boo_prefilled)
		
		OB GET ARRAY:C1229($tObj_param{$tObj_param};"forms";$tTxt_buffer)
		
		For ($Lon_i;1;Size of array:C274($tTxt_buffer);1)
			
			If (Find in array:C230($tTxt_forms;$tTxt_buffer{$Lon_i})>0)
				
				$Boo_mode:=True:C214
				$Lon_i:=MAXLONG:K35:2-1
				
			End if 
		End for 
	End if 
End if 

  //if not user defined, lists the forms
If (Not:C34($Boo_prefilled))
	
	For ($Lon_i;1;Size of array:C274($tTxt_forms);1)
		
		  //we limit the use of forms with only one page and fixed dimensions
		FORM GET PROPERTIES:C674($Ptr_table->;$tTxt_forms{$Lon_i};$Lon_;$Lon_;$Lon_pages;$Boo_fixedWidth;$Boo_fixedHeight)
		
		If ($Lon_pages=1)\
			 & ($Boo_fixedWidth & $Boo_fixedHeight)
			
			$Boo_mode:=True:C214
			$Lon_i:=MAXLONG:K35:2-1
			
		End if 
	End for 
End if 

  //==================== build the layout order's menu
$Lst_buffer:=New list:C375
APPEND TO LIST:C376($Lst_buffer;Get localized string:C991("vertical");1)
SET LIST ITEM PARAMETER:C986($Lst_buffer;0;"data";True:C214)
APPEND TO LIST:C376($Lst_buffer;Get localized string:C991("horizontal");2)
SET LIST ITEM PARAMETER:C986($Lst_buffer;0;"data";False:C215)
obj_BOUND_WITH_LIST ($Lst_buffer;"layout.order")

  //==================== build the units' menu
$Lst_buffer:=New list:C375
APPEND TO LIST:C376($Lst_buffer;Get localized string:C991("point");1)
SET LIST ITEM PARAMETER:C986($Lst_buffer;0;"data";"pt")
APPEND TO LIST:C376($Lst_buffer;Get localized string:C991("millimeter");2)
SET LIST ITEM PARAMETER:C986($Lst_buffer;0;"data";"mm")
APPEND TO LIST:C376($Lst_buffer;Get localized string:C991("centimeter");3)
SET LIST ITEM PARAMETER:C986($Lst_buffer;0;"data";"cm")
APPEND TO LIST:C376($Lst_buffer;Get localized string:C991("inch");4)
SET LIST ITEM PARAMETER:C986($Lst_buffer;0;"data";"in")
SELECT LIST ITEMS BY POSITION:C381($Lst_buffer;1)
obj_BOUND_WITH_LIST ($Lst_buffer;"size.unit.menu")

  //==================== build the methods' list
$Lst_buffer:=New list:C375

APPEND TO LIST:C376($Lst_buffer;Get localized string:C991("noMethod");-1)
  //APPEND TO LIST($Lst_buffer;"-";-1)

  //get the database's allowed methods
GET ALLOWED METHODS:C908($tTxt_methods)

  //restrict the list, if necessary, according to user instructions
$Boo_prefilled:=($tObj_param>0)

If ($Boo_prefilled)
	
	$Boo_prefilled:=OB Is defined:C1231($tObj_param{$tObj_param};"methods")
	
	If ($Boo_prefilled)
		
		OB GET ARRAY:C1229($tObj_param{$tObj_param};"methods";$tTxt_buffer)
		
		For ($Lon_i;1;Size of array:C274($tTxt_buffer);1)
			
			If (Find in array:C230($tTxt_methods;$tTxt_buffer{$Lon_i})>0)
				
				APPEND TO LIST:C376($Lst_buffer;$tTxt_buffer{$Lon_i};$Lon_i)
				
			End if 
		End for 
	End if 
End if 

  //if not user defined, lists the methods
If (Not:C34($Boo_prefilled))
	
	For ($Lon_i;1;Size of array:C274($tTxt_methods);1)
		
		APPEND TO LIST:C376($Lst_buffer;$tTxt_methods{$Lon_i};$Lon_i)
		
	End for 
End if 

If (Count list items:C380($Lst_buffer)>1)
	
	  //add a separator
	  //#ACI0093910 [
	  //GET LIST ITEM($Lst_buffer;2;$Lon_i;$tTxt_buffer)
	GET LIST ITEM:C378($Lst_buffer;2;$Lon_i;$Txt_buffer)
	  //]
	
	INSERT IN LIST:C625($Lst_buffer;$Lon_i;"-";-1)
	
End if 

obj_BOUND_WITH_LIST ($Lst_buffer;"method.list")

CLEAR VARIABLE:C89($tObj_param)

  // #redmine:20134 adapt separator's line to the localized label
obj_ADAPT_SEPARATOR_LINE ("size.title.1";"size.title.2";"size.title.3")

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End