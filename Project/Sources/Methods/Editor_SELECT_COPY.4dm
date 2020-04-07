//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SELECT_COPY
  // Database: 4D Labels
  // ID[80D422422F9346F1891FE4FCFAAE6108]
  // Created #20-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BLOB:C604($Blb_buffer)
C_LONGINT:C283($Lon_i;$Lon_parameters)
C_PICTURE:C286($Pic_buffer)
C_TEXT:C284($Dom_buffer;$Dom_label;$Dom_objects;$Dom_root;$Txt_buffer)
C_OBJECT:C1216($Obj_parameters)

ARRAY TEXT:C222($tDom_nodes;0)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
	$Dom_label:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
	
	ARRAY TEXT:C222($tTxt_selected;0x0000)
	Editor_SELECT_GET_LIST ($Dom_label;->$tTxt_selected)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Size of array:C274($tTxt_selected)#0)
	
	CLEAR PASTEBOARD:C402
	
	  //#ACI0093906 - The clipboard contains nothing [
	
	  //make a copy of the canvas {
	$Obj_parameters:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	DOM EXPORT TO VAR:C863(OB Get:C1224($Obj_parameters;"canvas";Is text:K8:3);$Blb_buffer)
	$Dom_root:=DOM Parse XML variable:C720($Blb_buffer)
	  //}
	
	  //remove the label's border {
	$Dom_buffer:=DOM Find XML element:C864($Dom_root;"svg/rect")
	
	If (OK=1)
		
		DOM REMOVE XML ELEMENT:C869($Dom_buffer)
		
	End if 
	  //}
	
	  //remove all private or non-selected objects {
	$tDom_nodes{0}:=DOM Find XML element:C864($Dom_root;"svg/g";$tDom_nodes)
	
	For ($Lon_i;1;Size of array:C274($tDom_nodes);1)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($tDom_nodes{$Lon_i};"editor:object-id";$Txt_buffer)
		
		If (Length:C16($Txt_buffer)=0)\
			 | (Find in array:C230($tTxt_selected;$Txt_buffer)<0)
			
			DOM REMOVE XML ELEMENT:C869($tDom_nodes{$Lon_i})
			
		End if 
	End for 
	  //}
	
	  //put the picture into the clipboard {
	SVG EXPORT TO PICTURE:C1017($Dom_root;$Pic_buffer)
	SET PICTURE TO PASTEBOARD:C521($Pic_buffer)
	  //}
	
	DOM CLOSE XML:C722($Dom_root)
	CLEAR VARIABLE:C89($Pic_buffer)
	  //]
	
	  //append private data {
	$Dom_root:=DOM Create XML Ref:C861("label")
	
	$Dom_objects:=DOM Create XML element:C865($Dom_root;"objects";\
		"id";"objects")
	
	For ($Lon_i;1;Size of array:C274($tTxt_selected);1)
		
		$Dom_buffer:=DOM Find XML element by ID:C1010($Dom_label;$tTxt_selected{$Lon_i})
		DOM REMOVE XML ATTRIBUTE:C1084(DOM Append XML element:C1082($Dom_objects;$Dom_buffer);"id")
		
	End for 
	
	DOM EXPORT TO VAR:C863($Dom_root;$Blb_buffer)
	DOM CLOSE XML:C722($Dom_root)
	APPEND DATA TO PASTEBOARD:C403("com.4d.blob.xml";$Blb_buffer)
	SET BLOB SIZE:C606($Blb_buffer;0)
	  //}
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End