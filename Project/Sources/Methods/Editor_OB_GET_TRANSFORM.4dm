//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_OB_GET_TRANSFORM
// Database: 4D Labels
// ID[F33890B1838542949E2BDFFAC21BF5C2]
// Created #22-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($node : Text;  ...  : Pointer)

var $Num_cx; $Num_cy; $Num_rotation; $Num_xScaling; $Num_xTranslation; $Num_yScaling : Real
var $Num_yTranslation : Real
var $Txt_transform : Text

ARRAY LONGINT:C221($tLon_length; 0)
ARRAY LONGINT:C221($tLon_position; 0)

DOM GET XML ATTRIBUTE BY NAME:C728($node; "transform"; $Txt_transform)

If (Match regex:C1019("translate\\((-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)\\)"; $Txt_transform; 1; $tLon_position; $tLon_length))
	
	$Num_xTranslation:=Num:C11(Substring:C12($Txt_transform; $tLon_position{1}; $tLon_length{1}); ".")
	$Num_yTranslation:=Num:C11(Substring:C12($Txt_transform; $tLon_position{2}; $tLon_length{2}); ".")
	
End if 

If (Match regex:C1019("scale\\((-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)\\)"; $Txt_transform; 1; $tLon_position; $tLon_length))
	
	$Num_xScaling:=Num:C11(Substring:C12($Txt_transform; $tLon_position{1}; $tLon_length{1}); ".")
	$Num_yScaling:=Num:C11(Substring:C12($Txt_transform; $tLon_position{2}; $tLon_length{2}); ".")
	
End if 

If (Match regex:C1019("rotate\\((-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)\\)"; $Txt_transform; 1; $tLon_position; $tLon_length))
	
	$Num_rotation:=Num:C11(Substring:C12($Txt_transform; $tLon_position{1}; $tLon_length{1}); ".")
	$Num_cx:=Num:C11(Substring:C12($Txt_transform; $tLon_position{2}; $tLon_length{2}); ".")
	$Num_cy:=Num:C11(Substring:C12($Txt_transform; $tLon_position{3}; $tLon_length{3}); ".")
	
End if 

$2->:=$Num_xTranslation
$3->:=$Num_yTranslation
$4->:=$Num_xScaling
$5->:=$Num_yScaling
$6->:=$Num_rotation
$7->:=$Num_cx
$8->:=$Num_cy