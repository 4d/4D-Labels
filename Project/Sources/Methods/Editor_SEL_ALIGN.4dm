//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_ALIGN
  // Database: 4D Labels
  // ID[BDCF776570264B82A6635BC824D0B348]
  // Created #18-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($Boo_redraw)
C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_selCount)
C_REAL:C285($Num_bottom;$Num_bottomMost;$Num_center;$Num_height;$Num_left;$Num_leftMost)
C_REAL:C285($Num_newBottom;$Num_newLeft;$Num_newRight;$Num_newTop;$Num_right;$Num_rightMost)
C_REAL:C285($Num_top;$Num_topMost;$Num_width)
C_TEXT:C284($Dom_label;$Txt_alignment;$Txt_ID)

ARRAY TEXT:C222($tDom_object;0)

If (False:C215)
	C_TEXT:C284(Editor_SEL_ALIGN ;$1)
	C_TEXT:C284(Editor_SEL_ALIGN ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_alignment:=$1
	
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
	: ($Txt_alignment="left")
		
		  //get the leftmost
		For ($Lon_i;1;$Lon_selCount;1)
			
			  //get current
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"left";$Num_left)
			
			$Boo_redraw:=($Lon_i#1) & ($Num_left#$Num_leftMost)
			
			If ($Lon_i=1)\
				 | ($Num_left<$Num_leftMost)
				
				$Num_leftMost:=$Num_left
				
			End if 
		End for 
		
		If ($Boo_redraw)
			
			  //align
			For ($Lon_i;1;$Lon_selCount;1)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"left";$Num_left)
				DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"right";$Num_right)
				
				DOM SET XML ATTRIBUTE:C866($tDom_object{$Lon_i};\
					"left";$Num_leftMost;\
					"right";$Num_right-($Num_left-$Num_leftMost))
				
			End for 
		End if 
		
		  //______________________________________________________
	: ($Txt_alignment="right")
		
		  //get the rightmost
		For ($Lon_i;1;$Lon_selCount;1)
			
			  //get current
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"right";$Num_right)
			
			$Boo_redraw:=($Lon_i#1) & ($Num_right#$Num_rightMost)
			
			If ($Lon_i=1)\
				 | ($Num_right>$Num_rightMost)
				
				$Num_rightMost:=$Num_right
				
			End if 
		End for 
		
		If ($Boo_redraw)
			
			  //align
			For ($Lon_i;1;$Lon_selCount;1)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"left";$Num_left)
				DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"right";$Num_right)
				
				DOM SET XML ATTRIBUTE:C866($tDom_object{$Lon_i};\
					"right";$Num_rightMost;\
					"left";$Num_left+($Num_rightMost-$Num_right))
				
			End for 
		End if 
		
		  //______________________________________________________
	: ($Txt_alignment="top")
		
		  //get the topmost
		For ($Lon_i;1;$Lon_selCount;1)
			
			  //get current
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"top";$Num_top)
			
			$Boo_redraw:=($Lon_i#1) & ($Num_top#$Num_topMost)
			
			If ($Lon_i=1)\
				 | ($Num_top<$Num_topMost)
				
				$Num_topMost:=$Num_top
				
			End if 
		End for 
		
		If ($Boo_redraw)
			
			  //align
			For ($Lon_i;1;$Lon_selCount;1)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"top";$Num_top)
				DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"bottom";$Num_bottom)
				
				DOM SET XML ATTRIBUTE:C866($tDom_object{$Lon_i};\
					"top";$Num_topMost;\
					"bottom";$Num_bottom-($Num_top-$Num_topMost))
				
			End for 
		End if 
		
		  //______________________________________________________
	: ($Txt_alignment="bottom")
		
		  //get the bottommost
		For ($Lon_i;1;$Lon_selCount;1)
			
			  //get current
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"bottom";$Num_bottom)
			
			$Boo_redraw:=($Lon_i#1) & ($Num_bottom#$Num_bottomMost)
			
			If ($Lon_i=1)\
				 | ($Num_bottom>$Num_bottomMost)
				
				$Num_bottomMost:=$Num_bottom
				
			End if 
		End for 
		
		If ($Boo_redraw)
			
			  //align
			For ($Lon_i;1;$Lon_selCount;1)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"top";$Num_top)
				DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"bottom";$Num_bottom)
				
				DOM SET XML ATTRIBUTE:C866($tDom_object{$Lon_i};\
					"bottom";$Num_bottomMost;\
					"top";$Num_top+($Num_bottomMost-$Num_bottom))
				
			End for 
		End if 
		
		  //______________________________________________________
	: ($Txt_alignment="vertical")
		
		  //get topmost & bottommost
		For ($Lon_i;1;$Lon_selCount;1)
			
			  //get current
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"top";$Num_top)
			
			If ($Lon_i=1)\
				 | ($Num_top<$Num_topMost)
				
				$Num_topMost:=$Num_top
				
			End if 
			
			  //get current
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"bottom";$Num_bottom)
			
			If ($Lon_i=1)\
				 | ($Num_bottom>$Num_bottomMost)
				
				$Num_bottomMost:=$Num_bottom
				
			End if 
		End for 
		
		$Num_center:=$Num_topMost+(($Num_bottomMost-$Num_topMost)/2)
		
		For ($Lon_i;1;$Lon_selCount;1)
			
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"top";$Num_top)
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"bottom";$Num_bottom)
			
			$Num_height:=($Num_bottom-$Num_top)/2
			
			$Num_newTop:=$Num_center-$Num_height
			$Num_newBottom:=$Num_center+$Num_height
			
			If ($Num_newTop#$Num_top)\
				 | ($Num_newBottom#$Num_bottom)
				
				DOM SET XML ATTRIBUTE:C866($tDom_object{$Lon_i};\
					"bottom";$Num_newBottom;\
					"top";$Num_newTop)
				
				$Boo_redraw:=True:C214
				
			End if 
		End for 
		
		  //______________________________________________________
	: ($Txt_alignment="horizontal")
		
		  //get leftmost & rightmost
		For ($Lon_i;1;$Lon_selCount;1)
			
			  //get current
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"left";$Num_left)
			
			If ($Lon_i=1)\
				 | ($Num_left<$Num_leftMost)
				
				$Num_leftMost:=$Num_left
				
			End if 
			
			  //get current
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"right";$Num_right)
			
			If ($Lon_i=1)\
				 | ($Num_right>$Num_rightMost)
				
				$Num_rightMost:=$Num_right
				
			End if 
		End for 
		
		$Num_center:=$Num_leftMost+(($Num_rightMost-$Num_leftMost)/2)
		
		For ($Lon_i;1;$Lon_selCount;1)
			
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"left";$Num_left)
			DOM GET XML ATTRIBUTE BY NAME:C728($tDom_object{$Lon_i};"right";$Num_right)
			
			$Num_width:=($Num_right-$Num_left)/2
			
			$Num_newLeft:=$Num_center-$Num_width
			$Num_newRight:=$Num_center+$Num_width
			
			If ($Num_newLeft#$Num_left)\
				 | ($Num_newRight#$Num_right)
				
				DOM SET XML ATTRIBUTE:C866($tDom_object{$Lon_i};\
					"left";$Num_newLeft;\
					"right";$Num_newRight)
				
				$Boo_redraw:=True:C214
				
			End if 
		End for 
		
		  //______________________________________________________
	Else 
		
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