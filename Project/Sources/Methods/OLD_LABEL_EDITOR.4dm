//%attributes = {"invisible":true}
var $1 : Integer
var $2 : Text
var $3 : Boolean
var $4 : Blob

var $Blb_buffer : Blob
var $Boo_preview : Boolean
var $Lon_process; $Lon_table : Integer
var $Ptr_table : Pointer
var $Txt_path : Text

ARRAY LONGINT:C221($tLon_IDs; 0)

$Lon_table:=$1
$Txt_path:=$2

$Ptr_table:=Table:C252($1)

Case of 
		
		//________________________________________
	: (Count parameters:C259=2)
		
		If (Not:C34(Is nil pointer:C315(Table:C252(Table:C252($Ptr_table))))) & (Length:C16($Txt_path)#0)
			
			$Boo_preview:=(Get print preview:C1197 | Is in print preview:C1198)
			
			LONGINT ARRAY FROM SELECTION:C647($Ptr_table->; $tLon_IDs)
			VARIABLE TO BLOB:C532($tLon_IDs; $Blb_buffer)
			
			$Lon_process:=New process:C317(Current method name:C684; 512*1024; Current method name:C684; $1; $2; $Boo_preview; $Blb_buffer; *)
			
		End if 
		
		//________________________________________
	: (Count parameters:C259=4)
		
		SET PRINT PREVIEW:C364($3)
		
		//just load the document
		PRINT LABEL:C39($Ptr_table->; $Txt_path)
		
		READ ONLY:C145($Ptr_table->)
		BLOB TO VARIABLE:C533($4; $tLon_IDs)
		CREATE SELECTION FROM ARRAY:C640($Ptr_table->; $tLon_IDs)
		
		//display the editor
		PRINT LABEL:C39($Ptr_table->; Char:C90(1))
		
		//________________________________________
End case 