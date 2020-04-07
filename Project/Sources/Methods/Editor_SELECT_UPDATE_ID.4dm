//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SELECT_UPDATE_ID
  // Database: 4D Labels
  // ID[9FA7E0BFC94849A1AB2FD06E63DBB5C4]
  // Created #21-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_i;$Lon_objectCount;$Lon_parameters;$Lon_selectedCount)
C_TEXT:C284($Dom_Canvas;$Dom_label;$kTxt_classPrefix;$kTxt_objectPrefix;$Txt_;$Txt_buffer)
C_TEXT:C284($Txt_CDATA;$Txt_ID;$Txt_newId;$Txt_objectType;$Txt_oldId)

ARRAY TEXT:C222($tDom_object;0)
ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_TEXT:C284(Editor_SELECT_UPDATE_ID ;$1)
	C_TEXT:C284(Editor_SELECT_UPDATE_ID ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Dom_label:=$1
	$Dom_Canvas:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
	$kTxt_classPrefix:=OB Get:C1224(<>label_params;"classPrefix";Is text:K8:3)
	$kTxt_objectPrefix:=OB Get:C1224(<>label_params;"objectPrefix";Is text:K8:3)
	
	$Lon_objectCount:=Editor_OB_Get_count ($Dom_label;->$tDom_object)
	$Lon_selectedCount:=Editor_SEL_Get_count ($Dom_label;->$tDom_selected)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
ARRAY TEXT:C222($tTxt_oldIDs;$Lon_objectCount)
ARRAY TEXT:C222($tDom_oldObject;$Lon_objectCount)
ARRAY TEXT:C222($tDom_oldClasses;$Lon_objectCount)
ARRAY TEXT:C222($tDom_oldRects;$Lon_objectCount)
ARRAY TEXT:C222($tDom_oldRectClasses;$Lon_objectCount)
ARRAY TEXT:C222($tDom_oldTextAreas;$Lon_objectCount)
ARRAY TEXT:C222($tDom_oldTextAreaClasses;$Lon_objectCount)
ARRAY TEXT:C222($tDom_oldImages;$Lon_objectCount)

ARRAY TEXT:C222($tTxt_newIDs;$Lon_objectCount)

For ($Lon_i;1;$Lon_objectCount;1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"id";$Txt_ID)
	
	$tTxt_oldIDs{$Lon_i}:=$Txt_ID
	$tTxt_newIDs{$Lon_i}:=$kTxt_objectPrefix+String:C10($Lon_i)
	
	$tDom_oldObject{$Lon_i}:=DOM Find XML element by ID:C1010($Dom_Canvas;$Txt_ID)
	$tDom_oldClasses{$Lon_i}:=DOM Find XML element by ID:C1010($Dom_Canvas;$kTxt_classPrefix+$Txt_ID)
	$tDom_oldRects{$Lon_i}:=DOM Find XML element by ID:C1010($Dom_Canvas;$Txt_ID+"-rect")
	$tDom_oldRectClasses{$Lon_i}:=DOM Find XML element by ID:C1010($Dom_Canvas;$kTxt_classPrefix+$Txt_ID+"-rect")
	$tDom_oldTextAreas{$Lon_i}:=DOM Find XML element by ID:C1010($Dom_Canvas;$Txt_ID+"-textArea")
	$tDom_oldTextAreaClasses{$Lon_i}:=DOM Find XML element by ID:C1010($Dom_Canvas;$kTxt_classPrefix+$Txt_ID+"-textArea")
	$tDom_oldImages{$Lon_i}:=DOM Find XML element by ID:C1010($Dom_Canvas;$Txt_ID+"-image")
	
End for 

DOM_ELEMENT_REFRESH_ID ($Dom_Canvas)

For ($Lon_i;1;$Lon_selectedCount;1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
	
	$Txt_buffer:=$kTxt_objectPrefix+String:C10(Find in array:C230($tTxt_oldIDs;$Txt_ID))
	
	DOM SET XML ATTRIBUTE:C866($tDom_selected{$Lon_i};\
		"object-id";$Txt_buffer)
	
	DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_Canvas;"select-tl-"+$Txt_ID);\
		"id";"select-tl-"+$Txt_buffer)
	
	DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_Canvas;"select-tm-"+$Txt_ID);\
		"id";"select-tm-"+$Txt_buffer)
	
	DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_Canvas;"select-tr-"+$Txt_ID);\
		"id";"select-tr-"+$Txt_buffer)
	
	DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_Canvas;"select-ml-"+$Txt_ID);\
		"id";"select-ml-"+$Txt_buffer)
	
	DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_Canvas;"select-mr-"+$Txt_ID);\
		"id";"select-mr-"+$Txt_buffer)
	
	DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_Canvas;"select-bl-"+$Txt_ID);\
		"id";"select-bl-"+$Txt_buffer)
	
	DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_Canvas;"select-bm-"+$Txt_ID);\
		"id";"select-bm-"+$Txt_buffer)
	
	DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_Canvas;"select-br-"+$Txt_ID);\
		"id";"select-br-"+$Txt_buffer)
	
	DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_Canvas;OB Get:C1224(<>label_params;"select-rect-prefix";Is text:K8:3)+$Txt_ID);\
		"id";OB Get:C1224(<>label_params;"select-rect-prefix";Is text:K8:3)+$Txt_buffer)
	
	DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_Canvas;OB Get:C1224(<>label_params;"select-prefix";Is text:K8:3)+$Txt_ID);\
		"id";OB Get:C1224(<>label_params;"select-prefix";Is text:K8:3)+$Txt_buffer)
	
End for 

For ($Lon_i;1;$Lon_objectCount;1)
	
	$Txt_oldId:=$tTxt_oldIDs{$Lon_i}
	$Txt_newId:=$tTxt_newIDs{$Lon_i}
	
	DOM SET XML ATTRIBUTE:C866($tDom_object{$Lon_i};\
		"id";$Txt_newId)
	DOM SET XML ATTRIBUTE:C866($tDom_oldObject{$Lon_i};\
		"id";$Txt_newId;\
		"editor:object-id";$Txt_newId)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_oldObject{$Lon_i};"editor:object-type";$Txt_objectType)
	
	Case of 
			
			  //________________________________________
		: ($Txt_objectType="ellipse")\
			 | ($Txt_objectType="line")\
			 | ($Txt_objectType="rect")
			
			DOM SET XML ATTRIBUTE:C866($tDom_oldObject{$Lon_i};\
				"class";$kTxt_classPrefix+$Txt_newId)
			
			DOM GET XML ELEMENT VALUE:C731($tDom_oldClasses{$Lon_i};$Txt_;$Txt_CDATA)
			$Txt_CDATA:=Replace string:C233($Txt_CDATA;$kTxt_classPrefix+$Txt_oldId;$kTxt_classPrefix+$Txt_newId;1;*)
			DOM SET XML ELEMENT VALUE:C868($tDom_oldClasses{$Lon_i};$Txt_CDATA;*)
			DOM SET XML ATTRIBUTE:C866($tDom_oldClasses{$Lon_i};\
				"id";$kTxt_classPrefix+$Txt_newId)
			
			  //________________________________________
		: ($Txt_objectType="image")
			
			DOM SET XML ATTRIBUTE:C866($tDom_oldRects{$Lon_i};\
				"class";$kTxt_classPrefix+$Txt_newId+"-rect";\
				"id";$Txt_newId+"-rect";\
				"editor:object-id";$Txt_newId)
			DOM SET XML ATTRIBUTE:C866($tDom_oldImages{$Lon_i};\
				"id";$Txt_newId+"-image";\
				"editor:object-id";$Txt_newId)
			
			DOM GET XML ELEMENT VALUE:C731($tDom_oldRectClasses{$Lon_i};$Txt_;$Txt_CDATA)
			$Txt_CDATA:=Replace string:C233($Txt_CDATA;$kTxt_classPrefix+$Txt_oldId+"-rect";$kTxt_classPrefix+$Txt_newId+"-rect";1;*)
			DOM SET XML ELEMENT VALUE:C868($tDom_oldRectClasses{$Lon_i};$Txt_CDATA;*)
			
			DOM SET XML ATTRIBUTE:C866($tDom_oldRectClasses{$Lon_i};\
				"id";$kTxt_classPrefix+$Txt_newId+"-rect")
			
			  //________________________________________
		: ($Txt_objectType="text")\
			 | ($Txt_objectType="variable/text")\
			 | ($Txt_objectType="variable/image")
			
			DOM SET XML ATTRIBUTE:C866($tDom_oldRects{$Lon_i};\
				"class";$kTxt_classPrefix+$Txt_newId+"-rect";\
				"id";$Txt_newId+"-rect";\
				"editor:object-id";$Txt_newId)
			DOM SET XML ATTRIBUTE:C866($tDom_oldTextAreas{$Lon_i};\
				"class";$kTxt_classPrefix+$Txt_newId+"-textArea";\
				"id";$Txt_newId+"-textArea";\
				"editor:object-id";$Txt_newId)
			
			DOM GET XML ELEMENT VALUE:C731($tDom_oldRectClasses{$Lon_i};$Txt_;$Txt_CDATA)
			$Txt_CDATA:=Replace string:C233($Txt_CDATA;$kTxt_classPrefix+$Txt_oldId+"-rect";$kTxt_classPrefix+$Txt_newId+"-rect";1;*)
			DOM SET XML ELEMENT VALUE:C868($tDom_oldRectClasses{$Lon_i};$Txt_CDATA;*)
			
			DOM GET XML ELEMENT VALUE:C731($tDom_oldTextAreaClasses{$Lon_i};$Txt_;$Txt_CDATA)
			$Txt_CDATA:=Replace string:C233($Txt_CDATA;$kTxt_classPrefix+$Txt_oldId+"-textArea";$kTxt_classPrefix+$Txt_newId+"-textArea";1;*)
			DOM SET XML ELEMENT VALUE:C868($tDom_oldTextAreaClasses{$Lon_i};$Txt_CDATA;*)
			
			DOM SET XML ATTRIBUTE:C866($tDom_oldRectClasses{$Lon_i};\
				"id";$kTxt_classPrefix+$Txt_newId+"-rect")
			DOM SET XML ATTRIBUTE:C866($tDom_oldTextAreaClasses{$Lon_i};\
				"id";$kTxt_classPrefix+$Txt_newId+"-textArea")
			
			  //________________________________________
	End case 
End for 

DOM_ELEMENT_REFRESH_ID ($Dom_label)
DOM_ELEMENT_REFRESH_ID ($Dom_Canvas)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End