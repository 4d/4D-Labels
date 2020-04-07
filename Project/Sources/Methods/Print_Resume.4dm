//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Print_Resume
  // Database: 4D Labels
  // ID[B00881C2732A4654A409F933AAA62DD7]
  // Created #9-10-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_OBJECT:C1216($1)

C_BOOLEAN:C305($Boo_preview;$Boo_stop;$Boo_vertical)
C_LONGINT:C283($Lon_columns;$Lon_hGap;$Lon_hOffset;$Lon_labelCount;$Lon_labelHeight;$Lon_labelWidth)
C_LONGINT:C283($Lon_leftMargin;$Lon_parameters;$Lon_perRecord;$Lon_rows;$Lon_table;$Lon_topMargin)
C_LONGINT:C283($Lon_vGap;$Lon_vOffset;$Lon_xPosition;$Lon_yPosition)
C_POINTER:C301($Ptr_table)

If (False:C215)
	C_BOOLEAN:C305(Print_Resume ;$0)
	C_OBJECT:C1216(Print_Resume ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Boo_vertical:=OB Get:C1224($1;"vertical";Is boolean:K8:9)
	$Boo_preview:=OB Get:C1224($1;"preview";Is boolean:K8:9)
	$Lon_rows:=OB Get:C1224($1;"rows";Is longint:K8:6)
	$Lon_columns:=OB Get:C1224($1;"columns";Is longint:K8:6)
	$Lon_labelWidth:=OB Get:C1224($1;"width";Is longint:K8:6)
	$Lon_labelHeight:=OB Get:C1224($1;"height";Is longint:K8:6)
	$Lon_leftMargin:=OB Get:C1224($1;"left-margin";Is longint:K8:6)
	$Lon_topMargin:=OB Get:C1224($1;"top-margin";Is longint:K8:6)
	$Lon_hGap:=OB Get:C1224($1;"h-gap";Is longint:K8:6)
	$Lon_vGap:=OB Get:C1224($1;"v-gap";Is longint:K8:6)
	$Lon_perRecord:=OB Get:C1224($1;"label-per-record";Is longint:K8:6)
	$Lon_table:=OB Get:C1224($1;"table";Is longint:K8:6)
	$Lon_labelCount:=OB Get:C1224($1;"label-count";Is longint:K8:6)
	$Lon_xPosition:=OB Get:C1224($1;"x";Is longint:K8:6)
	$Lon_yPosition:=OB Get:C1224($1;"y";Is longint:K8:6)
	$Lon_hOffset:=OB Get:C1224($1;"h-offset";Is longint:K8:6)
	$Lon_vOffset:=OB Get:C1224($1;"v-offset";Is longint:K8:6)
	
	$Ptr_table:=Table:C252($Lon_table)
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If ($Boo_vertical)
	
	If ($Lon_yPosition<$Lon_rows)
		
		$Lon_yPosition:=$Lon_yPosition+1
		$Lon_vOffset:=$Lon_vOffset+$Lon_labelHeight+$Lon_vGap
		
	Else 
		
		$Lon_yPosition:=1
		$Lon_vOffset:=$Lon_topMargin
		
		If ($Lon_xPosition<$Lon_columns)
			
			$Lon_xPosition:=$Lon_xPosition+1
			$Lon_hOffset:=$Lon_hOffset+$Lon_labelWidth+$Lon_hGap
			
		Else 
			
			$Lon_xPosition:=1
			$Lon_hOffset:=$Lon_leftMargin
			$Lon_vOffset:=$Lon_topMargin
			
			If (Selected record number:C246($Ptr_table->)#Records in selection:C76($Ptr_table->))\
				 | ($Lon_labelCount#$Lon_perRecord)
				
				$Boo_stop:=$Boo_preview
				
				If (Not:C34($Boo_stop))
					
					PAGE BREAK:C6
					
				End if 
			End if 
		End if 
	End if 
	
Else 
	
	If ($Lon_xPosition<$Lon_columns)
		
		$Lon_xPosition:=$Lon_xPosition+1
		$Lon_hOffset:=$Lon_hOffset+$Lon_labelWidth+$Lon_hGap
		
	Else 
		
		$Lon_xPosition:=1
		$Lon_hOffset:=$Lon_leftMargin
		
		If ($Lon_yPosition<$Lon_rows)
			
			$Lon_yPosition:=$Lon_yPosition+1
			$Lon_vOffset:=$Lon_vOffset+$Lon_labelHeight+$Lon_vGap
			
		Else 
			
			$Lon_yPosition:=1
			$Lon_hOffset:=$Lon_leftMargin
			$Lon_vOffset:=$Lon_topMargin
			
			If (Selected record number:C246($Ptr_table->)#Records in selection:C76($Ptr_table->))\
				 | ($Lon_labelCount#$Lon_perRecord)
				
				$Boo_stop:=$Boo_preview
				
				If (Not:C34($Boo_stop))
					
					PAGE BREAK:C6
					
				End if 
			End if 
		End if 
	End if 
End if 

OB SET:C1220($1;\
"x";$Lon_xPosition;\
"y";$Lon_yPosition;\
"h-offset";$Lon_hOffset;\
"v-offset";$Lon_vOffset)

  // ----------------------------------------------------
  // Return
$0:=$Boo_stop

  // ----------------------------------------------------
  // End