//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_INIT
  // Database: 4D Labels
  // ID[F2AB60EDB4BC40E0B9EF63D1E68F512E]
  // Created #12-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_parameters;$Lon_platform)
C_POINTER:C301($Ptr_buffer)
C_TEXT:C284($Dir_media)

ARRAY TEXT:C222($tTxt_buffer;0)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
	$Ptr_buffer:=OBJECT Get pointer:C1124(Object named:K67:5;"object")
	OB GET PROPERTY NAMES:C1232($Ptr_buffer->;$tTxt_buffer)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Size of array:C274($tTxt_buffer)=0)  //INIT
	
	  //show debug objects if any
	OBJECT SET VISIBLE:C603(*;"Debug@";<>Boo_debug)
	
	  //show inworks object
	OBJECT SET VISIBLE:C603(*;"tool.2";<>Boo_debug)  //freehand tool
	
	_O_PLATFORM PROPERTIES:C365($Lon_platform)
	
	  //init default values & toolbar
	$Dir_media:=Get 4D folder:C485(Current resources folder:K5:16)\
		+"images"+Folder separator:K24:12\
		+"editor"+Folder separator:K24:12
	
	  //init the dynamic object
	OB SET:C1220($Ptr_buffer->;\
		"inited";True:C214;\
		"root-media";$Dir_media;\
		"platform";$Lon_platform;\
		"default-font";"'"+OBJECT Get font:C1069(*;"AutoFont")+"'";\
		"debug";<>Boo_debug;\
		"step-X";10;\
		"step-Y";10;\
		"stroke-width";1;\
		"canvas";"")
	
	  //keep DOCUMENT because READ PICTURE FILE over-writes DOCUMENT
	OB SET:C1220((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;\
		"document";DOCUMENT)
	
	  //upadte toolbar
	Editor_SET_TOOL 
	Editor_SET_FILL 
	Editor_SET_STROKE 
	Editor_SET_STROKE_WIDTH 
	Editor_SET_FONT_COLOR 
	
	Editor_TOOL_SET_ENABLED (False:C215)
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End