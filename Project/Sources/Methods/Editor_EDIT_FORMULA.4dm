//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_EDIT_FORMULA
// Database: 4D Labels
// ID[B97B9DEF9B8144CA8DEE578479475C88]
// Created #12-3-2024 by Dominique Delahaye
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------

#DECLARE($id : Text) : Boolean


var $Dom_label; $Dom_object; $Dom_canvas; $value : Text

var $do_update : Boolean

var $save_ok : Integer
var $Obj_dialog : Object


$Dom_label:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
$Dom_object:=DOM Find XML element by ID:C1010($Dom_label; $id)



DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "value"; $value)


$save_ok:=OK

EDIT FORMULA:C806(Table:C252(C_MASTER_TABLE)->; $value)

$do_update:=OK=1

If ($do_update)
	
	DOM SET XML ATTRIBUTE:C866($Dom_object; "value"; $value)
	
	$Obj_dialog:=Editor_Get_grips(->$Dom_label; ->$Dom_canvas)
	
	Editor_TEXT_EDIT_SET_VALUE(DOM Find XML element by ID:C1010($Dom_canvas; $id+"-textArea"); $value)
	
	
End if 

OK:=$save_ok
return $do_update
