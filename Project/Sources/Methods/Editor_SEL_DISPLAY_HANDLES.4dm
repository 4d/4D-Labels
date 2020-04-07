//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_DISPLAY_HANDLES
  // Database: 4D Labels
  // ID[0CA00C52335F41ACB2075410EA35DF65]
  // Created #2-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_REAL:C285($3)
C_REAL:C285($4)
C_REAL:C285($5)
C_REAL:C285($6)

C_LONGINT:C283($kLon_handleWidth;$Lon_parameters)
C_REAL:C285($kNum_fillOpacity;$kNum_strokeOpacity;$kNum_strokeWidth;$Num_height;$Num_width;$Num_x)
C_REAL:C285($Num_y)
C_TEXT:C284($Dom_handle;$Dom_label;$kTxt_fill;$kTxt_stroke;$Txt_ID)

If (False:C215)
	C_TEXT:C284(Editor_SEL_DISPLAY_HANDLES ;$1)
	C_TEXT:C284(Editor_SEL_DISPLAY_HANDLES ;$2)
	C_REAL:C285(Editor_SEL_DISPLAY_HANDLES ;$3)
	C_REAL:C285(Editor_SEL_DISPLAY_HANDLES ;$4)
	C_REAL:C285(Editor_SEL_DISPLAY_HANDLES ;$5)
	C_REAL:C285(Editor_SEL_DISPLAY_HANDLES ;$6)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=6;"Missing parameter"))
	
	  //Required parameters
	$Dom_label:=$1
	$Txt_ID:=$2
	$Num_x:=$3
	$Num_y:=$4
	$Num_width:=$5
	$Num_height:=$6
	
	  //Optional parameters
	If ($Lon_parameters>=7)
		
		  // <NONE>
		
	End if 
	
	$kLon_handleWidth:=OB Get:C1224(<>label_params;"selection-handle-width";Is longint:K8:6)
	
	$kTxt_fill:=OB Get:C1224(<>label_params;"selection-handle-fill";Is text:K8:3)
	$kNum_fillOpacity:=OB Get:C1224(<>label_params;"selection-handle-fill-opacity";Is real:K8:4)
	
	$kTxt_stroke:=OB Get:C1224(<>label_params;"selection-handle-stroke";Is text:K8:3)
	$kNum_strokeOpacity:=OB Get:C1224(<>label_params;"selection-handle-stroke-opacity";Is real:K8:4)
	$kNum_strokeWidth:=OB Get:C1224(<>label_params;"selection-handle-stroke-width";Is real:K8:4)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //top-left
$Dom_handle:=DOM Create XML element:C865($Dom_label;"rect";\
"id";"select-tl-"+$Txt_ID;\
"x";$Num_x-($kLon_handleWidth/2);\
"y";$Num_y-($kLon_handleWidth/2);\
"width";$kLon_handleWidth;\
"height";$kLon_handleWidth;\
"fill";$kTxt_fill;\
"fill-opacity";$kNum_fillOpacity;\
"editor:object-type";"";\
"editor:object-id";"";\
"stroke";$kTxt_stroke;\
"stroke-opacity";$kNum_strokeOpacity;\
"stroke-width";$kNum_strokeWidth;\
"shape-rendering";"crispEdges")

  //top-middle
$Dom_handle:=DOM Create XML element:C865($Dom_label;"rect";\
"id";"select-tm-"+$Txt_ID;\
"x";$Num_x-($kLon_handleWidth/2)+($Num_width/2);\
"y";$Num_y-($kLon_handleWidth/2);\
"width";$kLon_handleWidth;\
"height";$kLon_handleWidth;\
"fill";$kTxt_fill;\
"fill-opacity";$kNum_fillOpacity;\
"editor:object-type";"";\
"editor:object-id";"";\
"stroke";$kTxt_stroke;\
"stroke-opacity";$kNum_strokeOpacity;\
"stroke-width";$kNum_strokeWidth;\
"shape-rendering";"crispEdges")

  //top-right
$Dom_handle:=DOM Create XML element:C865($Dom_label;"rect";\
"id";"select-tr-"+$Txt_ID;\
"x";$Num_x-($kLon_handleWidth/2)+$Num_width;\
"y";$Num_y-($kLon_handleWidth/2);\
"width";$kLon_handleWidth;\
"height";$kLon_handleWidth;\
"fill";$kTxt_fill;\
"fill-opacity";$kNum_fillOpacity;\
"editor:object-type";"";\
"editor:object-id";"";\
"stroke";$kTxt_stroke;\
"stroke-opacity";$kNum_strokeOpacity;\
"stroke-width";$kNum_strokeWidth;\
"shape-rendering";"crispEdges")

  //left-middle
$Dom_handle:=DOM Create XML element:C865($Dom_label;"rect";\
"id";"select-ml-"+$Txt_ID;\
"x";$Num_x-($kLon_handleWidth/2);\
"y";$Num_y-($kLon_handleWidth/2)+($Num_height/2);\
"width";$kLon_handleWidth;\
"height";$kLon_handleWidth;\
"fill";$kTxt_fill;\
"fill-opacity";$kNum_fillOpacity;\
"editor:object-type";"";\
"editor:object-id";"";\
"stroke";$kTxt_stroke;\
"stroke-opacity";$kNum_strokeOpacity;\
"stroke-width";$kNum_strokeWidth;\
"shape-rendering";"crispEdges")

  //right-middle
$Dom_handle:=DOM Create XML element:C865($Dom_label;"rect";\
"id";"select-mr-"+$Txt_ID;\
"x";$Num_x-($kLon_handleWidth/2)+$Num_width;\
"y";$Num_y-($kLon_handleWidth/2)+($Num_height/2);\
"width";$kLon_handleWidth;\
"height";$kLon_handleWidth;\
"fill";$kTxt_fill;\
"fill-opacity";$kNum_fillOpacity;\
"editor:object-type";"";\
"editor:object-id";"";\
"stroke";$kTxt_stroke;\
"stroke-opacity";$kNum_strokeOpacity;\
"stroke-width";$kNum_strokeWidth;\
"shape-rendering";"crispEdges")

  //bottom-left
$Dom_handle:=DOM Create XML element:C865($Dom_label;"rect";\
"id";"select-bl-"+$Txt_ID;\
"x";$Num_x-($kLon_handleWidth/2);\
"y";$Num_y-($kLon_handleWidth/2)+$Num_height;\
"width";$kLon_handleWidth;\
"height";$kLon_handleWidth;\
"fill";$kTxt_fill;\
"fill-opacity";$kNum_fillOpacity;\
"editor:object-type";"";\
"editor:object-id";"";\
"stroke";$kTxt_stroke;\
"stroke-opacity";$kNum_strokeOpacity;\
"stroke-width";$kNum_strokeWidth;\
"shape-rendering";"crispEdges")

  //bottom-middle
$Dom_handle:=DOM Create XML element:C865($Dom_label;"rect";\
"id";"select-bm-"+$Txt_ID;\
"x";$Num_x-($kLon_handleWidth/2)+($Num_width/2);\
"y";$Num_y-($kLon_handleWidth/2)+$Num_height;\
"width";$kLon_handleWidth;\
"height";$kLon_handleWidth;\
"fill";$kTxt_fill;\
"fill-opacity";$kNum_fillOpacity;\
"editor:object-type";"";\
"editor:object-id";"";\
"stroke";$kTxt_stroke;\
"stroke-opacity";$kNum_strokeOpacity;\
"stroke-width";$kNum_strokeWidth;\
"shape-rendering";"crispEdges")

  //bottom-right
$Dom_handle:=DOM Create XML element:C865($Dom_label;"rect";\
"id";"select-br-"+$Txt_ID;\
"x";$Num_x-($kLon_handleWidth/2)+$Num_width;\
"y";$Num_y-($kLon_handleWidth/2)+$Num_height;\
"width";$kLon_handleWidth;\
"height";$kLon_handleWidth;\
"fill";$kTxt_fill;\
"fill-opacity";$kNum_fillOpacity;\
"editor:object-type";"";\
"editor:object-id";"";\
"stroke";$kTxt_stroke;\
"stroke-opacity";$kNum_strokeOpacity;\
"stroke-width";$kNum_strokeWidth;\
"shape-rendering";"crispEdges")

Editor_SET_HANDLE 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End