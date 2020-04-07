//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : PRINT_Get_text_field
  // Database: 4D Labels
  // ID[F2B12BEA5D364D6395A18148E86B7EE8]
  // Created #20-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters;$Lon_start;$Lon_subStart;$Lon_type)
C_POINTER:C301($Ptr_field)
C_TEXT:C284($Txt_buffer;$Txt_expression;$Txt_line;$Txt_onErrorMethod;$Txt_result;$Txt_sub)
C_TEXT:C284($Txt_value)

ARRAY LONGINT:C221($tLon_lengths;0)
ARRAY LONGINT:C221($tLon_positions;0)

If (False:C215)
	C_TEXT:C284(PRINT_Get_text_field ;$0)
	C_TEXT:C284(PRINT_Get_text_field ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_expression:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	$Lon_start:=1
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //for each lines
While (Match regex:C1019("(?m)(.+)";$Txt_expression;$Lon_start;$tLon_positions;$tLon_lengths))
	
	$Txt_line:=Substring:C12($Txt_expression;$tLon_positions{1};$tLon_lengths{1})
	
	$Lon_start:=$tLon_positions{1}+$tLon_lengths{1}
	
	$Txt_value:=""
	$Lon_subStart:=1
	
	  //for each expressions in the line
	While (Match regex:C1019("([^+]+)";$Txt_line;$Lon_subStart;$tLon_positions;$tLon_lengths))
		
		$Txt_sub:=Substring:C12($Txt_line;$tLon_positions{1};$tLon_lengths{1})
		
		$Ptr_field:=Get_field_pointer ($Txt_sub)
		
		If (Not:C34(Is nil pointer:C315($Ptr_field)))
			
			$Lon_type:=Type:C295($Ptr_field->)
			
			If ($Lon_type=Is text:K8:3)\
				 | ($Lon_type=Is alpha field:K8:1)
				
				  //
				$Txt_value:=$Txt_value+(" "*Num:C11(Length:C16($Txt_value)>0))+$Ptr_field->
				
			Else 
				
				$Txt_value:=$Txt_value+(" "*Num:C11(Length:C16($Txt_value)>0))+String:C10($Ptr_field->)
				
			End if 
			
		Else 
			
			$Txt_onErrorMethod:=4D_NO_ERROR ("ON")
			$Txt_buffer:="<!--4dtext "+$Txt_sub+"-->"
			PROCESS 4D TAGS:C816($Txt_buffer;$Txt_buffer)
			4D_NO_ERROR ("OFF";$Txt_onErrorMethod)
			
			If (OK=1)
				
				$Txt_value:=Choose:C955(\
					Not:C34(Match regex:C1019("&amp;lt;!--#?4DTEXT";$Txt_buffer;1));\
					$Txt_value+(" "*Num:C11(Length:C16($Txt_value)>0))+$Txt_buffer;\
					$Txt_value+(" "*Num:C11(Length:C16($Txt_value)>0))+$Txt_sub)
				
			End if 
		End if 
		
		$Lon_subStart:=$tLon_positions{1}+$tLon_lengths{1}
		
	End while 
	
	  //#ACI0097633 [
	ARRAY LONGINT:C221($tLon_x;0x0000)
	ARRAY LONGINT:C221($tLon_y;0x0000)
	
	While (Match regex:C1019("(?m-si)&[^;]*;";$Txt_value;1;$tLon_x;$tLon_y))
		
		$Txt_buffer:=Substring:C12($Txt_value;$tLon_x{0};$tLon_y{0})
		
		Case of 
				
				  //______________________________________________________
			: ($Txt_buffer="&amp;")
				
				$Txt_value:=Replace string:C233($Txt_value;$Txt_buffer;"&")
				
				  //______________________________________________________
			: ($Txt_buffer="&lt;")
				
				$Txt_value:=Replace string:C233($Txt_value;$Txt_buffer;"<")
				
				  //______________________________________________________
			: ($Txt_buffer="&gt;")
				
				$Txt_value:=Replace string:C233($Txt_value;$Txt_buffer;">")
				
				  //______________________________________________________
			: ($Txt_buffer="&quot;")
				
				$Txt_value:=Replace string:C233($Txt_value;$Txt_buffer;"\"")
				
				  //______________________________________________________
			: ($Txt_buffer="&apos;")
				
				$Txt_value:=Replace string:C233($Txt_value;$Txt_buffer;"'")
				
				  //______________________________________________________
			Else 
				
				$Txt_value:=Replace string:C233($Txt_value;$Txt_buffer;Char:C90(Num:C11($Txt_buffer)))
				
				  //______________________________________________________
		End case 
	End while 
	  //]
	
	If (Length:C16($Txt_value)#0)
		
		$Txt_result:=$Txt_result+("\r"*Num:C11(Length:C16($Txt_result)#0))+$Txt_value
		
	End if 
End while 

  // ----------------------------------------------------
  // Return
$0:=$Txt_result

  // ----------------------------------------------------
  // End