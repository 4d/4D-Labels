//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : C_Print_label
// Database: 4D Labels
// ID[9F9C4D578CED4E42909F143CCD47BF55]
// Created #19-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
//PRINT LABEL ( {aTable }{;}{ document {; * | >}} )
//aTable     Table     Table to print, or Default table, if omitted
//document   String    Name of disk label document
//* | >               * to suppress the printing dialog boxes, or > to not reinitialize print settings
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_BLOB:C604($Blb_buffer)
C_BOOLEAN:C305($Boo_OK; $Boo_withPrintSettings)
C_LONGINT:C283($Lon_bottom; $Lon_error; $Lon_height; $Lon_left; $Lon_orientation; $Lon_parameters)
C_LONGINT:C283($Lon_right; $Lon_table; $Lon_top; $Lon_width)
C_PICTURE:C286($Pic_buffer)
C_POINTER:C301($Ptr_table)
C_TEXT:C284($Dom_label; $File_; $File_path; $Txt_form; $Txt_onErrorMethod; $Txt_option)
C_OBJECT:C1216($file; $o)

ARRAY LONGINT:C221($tLon_records; 0)

If (False:C215)
	C_LONGINT:C283(C_Print_label; $0)
	C_LONGINT:C283(C_Print_label; $1)
	C_TEXT:C284(C_Print_label; $2)
	C_TEXT:C284(C_Print_label; $3)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	ASSERT:C1129(4D_LOG("Begin C_PRINT_LABEL"))
	
	//Required parameters
	$Lon_table:=$1
	
	ASSERT:C1129(4D_LOG("Table id: "+String:C10($Lon_table)))
	
	COMPILER_LABELS
	LABELS_INIT
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		$File_path:=$2
		
		If ($Lon_parameters>=3)
			
			$Txt_option:=$3  // "*" | ">"
			
			ASSERT:C1129(4D_LOG("Options: "+$Txt_option))
			
		End if 
	End if 
	
	$Ptr_table:=Table:C252($Lon_table)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: (Is nil pointer:C315(Table:C252(Table:C252($Ptr_table))))
		
		$Lon_error:=17  //A table was expected
		
		ASSERT:C1129(4D_LOG("A table was expected"))
		
		//______________________________________________________
	: (Records in selection:C76($Ptr_table->)=0)
		
		$Lon_error:=1138  //Selection is Null
		
		ASSERT:C1129(4D_LOG("Selection is Null"))
		
		//______________________________________________________
	: ($File_path="file:@")
		
		//If you specify the document parameter, the labels are printed with the label
		//setup defined in document.
		
		//absolute path prefixed with "file:"
		$File_path:=Delete string:C232($File_path; 1; 5)
		
		//#ACI0094907 [
		//the validity of the path name was already done before the call
		//$Boo_OK:=True
		Case of 
				
				//…………………………………………………………………………………………………………
			: (Length:C16($File_path)=0)
				
				//If document is an empty string (""), PRINT LABEL will present an Open File
				//dialog box so the user can specify the file to use for the label setup.
				
				ASSERT:C1129(4D_LOG("Empty path"))
				
				//#ACI0094652 {
				//$Txt_buffer:=Select document(13893;".4lb;.4lbp";Get localized string("Select label settings file...");Package open+Use sheet window)
				//#ACI0096139 {
				//PLATFORM PROPERTIES($Lon_platform)
				//$File_:=Select document(13893;Choose($Lon_platform=Windows;".4lb";"4DET");Get localized string("Select label settings file...");Package open+Use sheet window)
				$File_:=Select document:C905(13893; ".4lb;.4lbp"; Get localized string:C991("Select label settings file..."); Package open:K24:8+Use sheet window:K24:11)
				//}
				//]
				
				$Boo_OK:=(OK=1)
				
				If ($Boo_OK)
					
					$File_path:=DOCUMENT
					
				Else 
					
					$Lon_error:=-128  //Printing interrupted by the user
					
					ASSERT:C1129(4D_LOG("Printing interrupted by the user"))
					
				End if 
				
				//…………………………………………………………………………………………………………
			: (Position:C15(Folder separator:K24:12; $File_path)=0)
				
				//manage "relative" file path
				//the file is near the structure file
				
				$File_path:=Get 4D folder:C485(Database folder:K5:14; *)+$File_path
				
				$Boo_OK:=True:C214
				
				//…………………………………………………………………………………………………………
			Else 
				
				$Boo_OK:=(Test path name:C476($File_path)=Is a document:K24:1)
				
				//…………………………………………………………………………………………………………
		End case 
		
		If ($Boo_OK)
			
			If (Length:C16($File_path)>0)\
				 & (Test path name:C476($File_path)=Is a document:K24:1)
				
				$Boo_OK:=True:C214
				
			Else 
				
				$Lon_error:=-43
				
			End if 
		End if 
		//]
		
		ASSERT:C1129(4D_LOG("File: "+$File_path))
		
		//______________________________________________________
	: ($File_path="form:@")
		
		// Current form name prefixed with "form:"
		$Txt_form:=Delete string:C232($File_path; 1; 5)
		
		ASSERT:C1129(4D_LOG("Form: "+$Txt_form))
		
		$Dom_label:=DOM Parse XML source:C719(Get 4D folder:C485(Current resources folder:K5:16)+"default.4lbp")
		DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_label; "form"); "name"; $Txt_form)
		
		//#ACI0099882
		//FORM SCREENSHOT($Ptr_table->;$Txt_form;$Pic_buffer)
		//PICTURE PROPERTIES($Pic_buffer;$Lon_width;$Lon_height)
		//CLEAR VARIABLE($Pic_buffer)
		FORM GET PROPERTIES:C674($Ptr_table->; $Txt_form; $Lon_width; $Lon_height)
		DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_label; "size"); \
			"width"; $Lon_width; \
			"height"; $Lon_height)
		
		GET PRINTABLE MARGIN:C711($Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
		DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_label; "margin"); \
			"left"; $Lon_left; \
			"top"; $Lon_top; \
			"right"; $Lon_right; \
			"bottom"; $Lon_bottom)
		
		$Boo_OK:=(OK=1)
		
		//______________________________________________________
	: (Length:C16($File_path)=0)
		
		ASSERT:C1129(False:C215; "OBSOLETE ENTRYPOINT")
		
		//______________________________________________________
	Else 
		
		$Lon_error:=-43  //File not found
		
		ASSERT:C1129(4D_LOG("File not found"))
		
		//______________________________________________________
End case 

If ($Boo_OK)
	
	Case of 
			
			//………………………………………………………………
		: ($File_path="@.4lbp")
			
			$Dom_label:=DOM Parse XML source:C719($File_path)
			
			//………………………………………………………………
		: ($File_path="@.4lb")  //binary format
			
			DOCUMENT TO BLOB:C525($File_path; $Blb_buffer)
			
			$Dom_label:=parse_data(->$Blb_buffer; $Boo_withPrintSettings)
			
			//………………………………………………………………
		Else 
			
			//NOTHING MORE TO DO
			
			//………………………………………………………………
	End case 
	
	If (Length:C16($Dom_label)>0)
		
		Case of 
				
				//………………………………………………………………
			: ($Txt_option="*")
				
				//The * parameter causes a print job using the current print parameters.
				
				//………………………………………………………………
			: ($Txt_option=">")
				
				//Furthermore, the > parameter causes a print job without reinitializing the
				//current print parameters. This setting is useful for executing several
				//successive calls to PRINT LABEL (ex. inside a loop) while maintaining previously
				//set customized print parameters.
				
				//………………………………………………………………
			Else 
				
				PRINT SETTINGS:C106
				
				$Boo_OK:=(OK=1)
				
				//………………………………………………………………
		End case 
		
		If ($Boo_OK)
			
			GET PRINT OPTION:C734(Orientation option:K47:2; $Lon_orientation)
			
			DOM SET XML ATTRIBUTE:C866(DOM Find XML element by ID:C1010($Dom_label; "setting"); \
				"landscape"; ($Lon_orientation=2))
			
			//print
			$Lon_error:=Print_Label($Lon_table; $Dom_label)
			
			ASSERT:C1129(4D_LOG(Choose:C955($Lon_error=0; "No error"; "Error: "+String:C10($Lon_error))))
			
		Else 
			
			$Lon_error:=-128  //Printing interrupted by the user
			
			ASSERT:C1129(4D_LOG("Printing interrupted by the user"))
			
		End if 
		
		DOM CLOSE XML:C722($Dom_label)
		
	Else 
		
		If ($Lon_error=0)
			
			$Lon_error:=-9914  //Internal fault
			
			ASSERT:C1129(4D_LOG("Internal fault"))
			
		End if 
	End if 
End if 

// ----------------------------------------------------
// Return
$0:=$Lon_error

// ----------------------------------------------------
// End