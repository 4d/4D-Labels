//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_COMMON_ON_IDLE
  // Database: 4D Labels
  // ID[6C8447FF9D27409AA0042EEDE038E1B0]
  // Created #4-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($Boo_transform)
C_LONGINT:C283($Lon_parameters;$Lon_X;$Lon_x1;$Lon_x2;$Lon_xClick;$Lon_Y)
C_LONGINT:C283($Lon_y1;$Lon_y2;$Lon_yClick)
C_REAL:C285($Num_before_x;$Num_before_y;$Num_height;$Num_rx;$Num_ry;$Num_width)
C_REAL:C285($Num_X;$Num_Y;$Num_zoom)
C_TEXT:C284($Txt_data;$Txt_ID;$Txt_tool;$Txt_translate)

If (False:C215)
	C_TEXT:C284(Editor_COMMON_ON_IDLE ;$1)
	C_LONGINT:C283(Editor_COMMON_ON_IDLE ;$2)
	C_LONGINT:C283(Editor_COMMON_ON_IDLE ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=3;"Missing parameter"))
	
	  //Required parameters
	$Txt_tool:=$1
	$Lon_X:=$2
	$Lon_Y:=$3
	
	  //Optional parameters
	If ($Lon_parameters>=4)
		
		  // <NONE>
		
	End if 
	
	$Boo_transform:=True:C214
	
	DOM GET XML ATTRIBUTE BY NAME:C728(Editor_Get_current ;"id";$Txt_ID)
	
	$Num_zoom:=Editor_Get_zoom 
	
	Editor_GET_CLICK (->$Lon_xClick;->$Lon_yClick)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Txt_tool="rect")\
		 | ($Txt_tool="round-rect")
		
		$Num_width:=Abs:C99($Lon_X-$Lon_xClick)/$Num_zoom
		$Num_height:=Abs:C99($Lon_Y-$Lon_yClick)/$Num_zoom
		
		If (Shift down:C543)  //constraints
			
			If ($Num_width>$Num_height)
				
				$Num_height:=$Num_width
				
			Else 
				
				$Num_width:=$Num_height
				
			End if 
		End if 
		
		  //______________________________________________________
	: ($Txt_tool="ellipse")
		
		$Num_width:=Abs:C99($Lon_X-$Lon_xClick)
		$Num_height:=Abs:C99($Lon_Y-$Lon_yClick)
		
		If (Shift down:C543)  //constraints
			
			If ($Num_width>$Num_height)
				
				$Num_height:=$Num_width
				
			Else 
				
				$Num_width:=$Num_height
				
			End if 
		End if 
		
		  //______________________________________________________
	: ($Txt_tool="line")
		
		$Num_width:=Abs:C99($Lon_X-$Lon_xClick)/$Num_zoom
		$Num_height:=Abs:C99($Lon_Y-$Lon_yClick)/$Num_zoom
		
		Case of 
				
				  //----------------------------------------
			: (Shift down:C543) & False:C215  //#TO_BE_DONE constraints
				
				If ($Num_width>$Num_height)
					
					$Lon_x2:=$Num_width
					
				Else 
					
					$Lon_y2:=$Num_height
					
				End if 
				
				  //----------------------------------------
			: ($Lon_X>$Lon_xClick)\
				 & ($Lon_Y>$Lon_yClick)  //br
				
				$Lon_x2:=$Num_width
				$Lon_y2:=$Num_height
				
				  //----------------------------------------
			: ($Lon_X>$Lon_xClick)\
				 & ($Lon_Y<$Lon_yClick)  //tr
				
				$Lon_y1:=$Num_height
				$Lon_x2:=$Num_width
				
				  //----------------------------------------
			: ($Lon_X<$Lon_xClick)\
				 & ($Lon_Y>$Lon_yClick)  //bl
				
				$Lon_x1:=$Num_width
				$Lon_y2:=$Num_height
				
				  //----------------------------------------
			: ($Lon_X<$Lon_xClick)\
				 & ($Lon_Y<$Lon_yClick)  //tl
				
				$Lon_x2:=$Num_width
				$Lon_y2:=$Num_height
				
				  //----------------------------------------
			: ($Lon_X=$Lon_xClick)  //vertical
				
				$Lon_y2:=Choose:C955($Lon_Y=$Lon_yClick;0;$Num_height)
				
				  //----------------------------------------
			: ($Lon_Y=$Lon_yClick)  //horizontal
				
				$Lon_y2:=Choose:C955($Lon_X=$Lon_xClick;0;$Num_width)
				
				  //----------------------------------------
		End case 
		
		  //______________________________________________________
	: ($Txt_tool="polyline")
		
		$Num_X:=($Lon_X-$Lon_xClick)/$Num_zoom
		$Num_Y:=($Lon_Y-$Lon_yClick)/$Num_zoom
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_tool+"\"")
		
		  //______________________________________________________
End case 

$Lon_X:=Choose:C955($Lon_X>$Lon_xClick;$Lon_xClick;$Lon_X)
$Lon_Y:=Choose:C955($Lon_Y>$Lon_yClick;$Lon_yClick;$Lon_Y)

Case of 
		
		  //______________________________________________________
	: ($Txt_tool="rect")\
		 | ($Txt_tool="round-rect")
		
		$Txt_translate:="translate("+String:C10($Lon_X;"&xml")+","+String:C10($Lon_Y;"&xml")+")"
		
		SVG SET ATTRIBUTE:C1055(*;"Image";$Txt_ID;\
			"width";$Num_width;\
			"height";$Num_height)
		
		  //______________________________________________________
	: ($Txt_tool="ellipse")
		
		$Txt_translate:="translate("+String:C10($Lon_X+($Num_width/2);"&xml")+","+String:C10($Lon_Y+($Num_height/2);"&xml")+")"
		
		$Num_rx:=($Num_width/$Num_zoom)/2
		$Num_ry:=($Num_height/$Num_zoom)/2
		
		SVG SET ATTRIBUTE:C1055(*;"Image";$Txt_ID;\
			"rx";$Num_rx;\
			"ry";$Num_ry)
		
		  //______________________________________________________
	: ($Txt_tool="line")
		
		$Txt_translate:="translate("+String:C10($Lon_X;"&xml")+","+String:C10($Lon_Y;"&xml")+")"
		
		SVG SET ATTRIBUTE:C1055(*;"Image";$Txt_id;\
			"x1";$Lon_x1;\
			"y1";$Lon_y1;\
			"x2";$Lon_x2;\
			"y2";$Lon_y2)
		
		  //______________________________________________________
	: ($Txt_tool="polyline")
		
		Editor_GET_POINTS (->$Num_before_x;->$Num_before_y)
		
		If ($Num_X#$Num_before_x)\
			 | ($Num_Y#$Num_before_y)
			
			Editor_SET_POINTS ($Num_X;$Num_Y)
			
			SVG GET ATTRIBUTE:C1056(*;"Image";$Txt_ID;"points";$Txt_data)
			
			$Txt_data:=$Txt_data+" "+String:C10($Num_X;"&xml")+","+String:C10($Num_Y;"&xml")
			
			SVG SET ATTRIBUTE:C1055((OBJECT Get pointer:C1124(Object named:K67:5;"Image"))->;$Txt_ID;\
				"points";$Txt_data;*)  //save with update of the DOM
			
		End if 
		
		$Boo_transform:=False:C215
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_tool+"\"")
		
		  //______________________________________________________
End case 

If ($Boo_transform)
	
	SVG SET ATTRIBUTE:C1055(*;"Image";$Txt_ID;\
		"transform";$Txt_translate+" scale("+String:C10($Num_zoom;"&xml")+","+String:C10($Num_zoom;"&xml")+")")
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End