//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SELECT_DIST_HORIZONTAL
  // Database: 4D Labels
  // ID[A9F503D005BB4D4EA668BA5F966A3C45]
  // Created #25-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($Boo_redraw)
C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_selCount)
C_REAL:C285($Num_bottomMost;$Num_center;$Num_gap;$Num_height;$Num_leftMost;$Num_newBottom)
C_REAL:C285($Num_newLeft;$Num_newRight;$Num_newTop;$Num_rightMost;$Num_topMost;$Num_width)
C_TEXT:C284($Dom_label;$Txt_direction;$Txt_ID)

ARRAY TEXT:C222($tDom_object;0)

If (False:C215)
	C_TEXT:C284(Editor_SEL_DISTRIBUTE ;$1)
	C_TEXT:C284(Editor_SEL_DISTRIBUTE ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	$Txt_direction:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Dom_label:=$2
		
	Else 
		
		Editor_Get_grips (->$Dom_label)
		
	End if 
	
	  //get selection
	$Lon_selCount:=Editor_SEL_Get_count ($Dom_label;->$tDom_object)
	
	  //transform to object handles
	For ($Lon_i;1;$Lon_selCount;1)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"object-id";$Txt_ID)
		$tDom_object{$Lon_i}:=DOM Find XML element by ID:C1010($Dom_label;$Txt_ID)
		
	End for 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Txt_direction="horizontal")
		
		  //get the positions and middles
		ARRAY REAL:C219($tNum_left;$Lon_selCount)
		ARRAY REAL:C219($tNum_right;$Lon_selCount)
		
		For ($Lon_i;1;$Lon_selCount;1)
			
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"left";$tNum_left{$Lon_i})
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"right";$tNum_right{$Lon_i})
			
		End for 
		
		SORT ARRAY:C229($tNum_left;$tNum_right;$tDom_object)
		
		  //determine the leftmost and rightmost
		$Num_leftMost:=$tNum_left{1}+(($tNum_right{1}-$tNum_left{1})/2)
		$Num_rightMost:=$tNum_left{$Lon_selCount}+(($tNum_right{$Lon_selCount}-$tNum_left{$Lon_selCount})/2)
		
		  //calculate the gap
		$Num_gap:=($Num_rightMost-$Num_leftMost)/($Lon_selCount-1)
		$Num_center:=$Num_leftMost
		
		  //move objects - from the second object until the before last
		For ($Lon_i;2;$Lon_selCount-1;1)
			
			$Num_width:=($tNum_right{$Lon_i}-$tNum_left{$Lon_i})/2
			
			$Num_center:=$Num_center+$Num_gap
			
			$Num_newLeft:=$Num_center-$Num_width
			$Num_newRight:=$Num_center+$Num_width
			
			If ($Num_newLeft#$tNum_left{$Lon_i})\
				 | ($Num_newRight#$tNum_right{$Lon_i})
				
				DOM SET XML ATTRIBUTE:C866($tDom_object{$Lon_i};\
					"left";$Num_newLeft;\
					"right";$Num_newRight)
				
				$Boo_redraw:=True:C214
				
			End if 
		End for 
		
		  //______________________________________________________
	: ($Txt_direction="vertical")
		
		  //get the positions and middles
		ARRAY REAL:C219($tNum_top;$Lon_selCount)
		ARRAY REAL:C219($tNum_bottom;$Lon_selCount)
		
		For ($Lon_i;1;$Lon_selCount;1)
			
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"top";$tNum_top{$Lon_i})
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"bottom";$tNum_bottom{$Lon_i})
			
		End for 
		
		SORT ARRAY:C229($tNum_top;$tNum_bottom;$tDom_object)
		
		  //determine the topmost and bottommost
		$Num_topMost:=$tNum_top{1}+(($tNum_bottom{1}-$tNum_top{1})/2)
		$Num_bottomMost:=$tNum_top{$Lon_selCount}+(($tNum_bottom{$Lon_selCount}-$tNum_top{$Lon_selCount})/2)
		
		  //calculate the gap
		$Num_gap:=($Num_bottomMost-$Num_topMost)/($Lon_selCount-1)
		$Num_center:=$Num_topMost
		
		  //move objects - from the second object until the before last
		For ($Lon_i;2;$Lon_selCount-1;1)
			
			$Num_height:=($tNum_bottom{$Lon_i}-$tNum_top{$Lon_i})/2
			
			$Num_center:=$Num_center+$Num_gap
			
			$Num_newTop:=$Num_center-$Num_height
			$Num_newBottom:=$Num_center+$Num_height
			
			If ($Num_newTop#$tNum_top{$Lon_i})\
				 | ($Num_newBottom#$tNum_bottom{$Lon_i})
				
				DOM SET XML ATTRIBUTE:C866($tDom_object{$Lon_i};\
					"top";$Num_newTop;\
					"bottom";$Num_newBottom)
				
				$Boo_redraw:=True:C214
				
			End if 
		End for 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_direction+"\"")
		
		  //______________________________________________________
End case 

If ($Boo_redraw)
	
	Editor_ON_RESIZE 
	Editor_UPDATE 
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End