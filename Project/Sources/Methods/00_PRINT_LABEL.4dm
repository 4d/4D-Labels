//%attributes = {}
C_LONGINT:C283($Lon_error;$Lon_table)
C_TEXT:C284($File_path)

  //ALL RECORDS()

$Lon_table:=1

Case of 
		
		  //______________________________________________________
	: (True:C214)
		
		$File_path:="form:Sample Label 2"
		
		  //______________________________________________________
	: (False:C215)
		
		$File_path:="file:"+Get 4D folder:C485(Current resources folder:K5:16)+"labels"+Folder separator:K24:12+"test_print.4lbp"
		
		  //______________________________________________________
	Else 
		
		  //______________________________________________________
End case 

$Lon_error:=C_Print_label ($Lon_table;$File_path)