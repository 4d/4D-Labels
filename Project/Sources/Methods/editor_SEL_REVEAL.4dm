//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : editor_SEL_REVEAL
  // Database: 4D Labels
  // ID[F27BD6CA368B445EA978C8191DF865A6]
  // Created #17-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters)
C_REAL:C285($Num_fillOpacity;$Num_strokeOpacity)
C_TEXT:C284($Txt_ID)

If (False:C215)
	C_TEXT:C284(editor_SEL_REVEAL ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_ID:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
SVG SET ATTRIBUTE:C1055(*;"Image";$Txt_ID+"-rect";\
"stroke-opacity";OB Get:C1224(<>label_params;"selection-fill-opacity";Is real:K8:4))

SVG SET ATTRIBUTE:C1055(*;"Image";OB Get:C1224(<>label_params;"select-rect-prefix";Is text:K8:3)+$Txt_ID;\
"stroke-opacity";OB Get:C1224(<>label_params;"selection-stroke-opacity";Is real:K8:4))
SVG SET ATTRIBUTE:C1055(*;"Image";OB Get:C1224(<>label_params;"select-rect-prefix";Is text:K8:3)+$Txt_ID;\
"fill-opacity";OB Get:C1224(<>label_params;"selection-fill-opacity";Is real:K8:4))

$Num_fillOpacity:=OB Get:C1224(<>label_params;"selection-handle-fill-opacity";Is real:K8:4)
$Num_strokeOpacity:=OB Get:C1224(<>label_params;"selection-handle-stroke-opacity";Is real:K8:4)

SVG SET ATTRIBUTE:C1055(*;"Image";"select-tl-"+$Txt_ID;\
"stroke-opacity";$Num_strokeOpacity)
SVG SET ATTRIBUTE:C1055(*;"Image";"select-tl-"+$Txt_ID;\
"fill-opacity";$Num_fillOpacity)

SVG SET ATTRIBUTE:C1055(*;"Image";"select-tm-"+$Txt_ID;\
"stroke-opacity";$Num_strokeOpacity)
SVG SET ATTRIBUTE:C1055(*;"Image";"select-tm-"+$Txt_ID;\
"fill-opacity";$Num_fillOpacity)

SVG SET ATTRIBUTE:C1055(*;"Image";"select-tr-"+$Txt_ID;\
"stroke-opacity";$Num_strokeOpacity)
SVG SET ATTRIBUTE:C1055(*;"Image";"select-tr-"+$Txt_ID;\
"fill-opacity";$Num_fillOpacity)

SVG SET ATTRIBUTE:C1055(*;"Image";"select-ml-"+$Txt_ID;\
"stroke-opacity";$Num_strokeOpacity)
SVG SET ATTRIBUTE:C1055(*;"Image";"select-ml-"+$Txt_ID;\
"fill-opacity";$Num_fillOpacity)

SVG SET ATTRIBUTE:C1055(*;"Image";"select-mr-"+$Txt_ID;\
"stroke-opacity";$Num_strokeOpacity)
SVG SET ATTRIBUTE:C1055(*;"Image";"select-mr-"+$Txt_ID;\
"fill-opacity";$Num_fillOpacity)

SVG SET ATTRIBUTE:C1055(*;"Image";"select-bl-"+$Txt_ID;\
"stroke-opacity";$Num_strokeOpacity)
SVG SET ATTRIBUTE:C1055(*;"Image";"select-bl-"+$Txt_ID;\
"fill-opacity";$Num_fillOpacity)

SVG SET ATTRIBUTE:C1055(*;"Image";"select-bm-"+$Txt_ID;\
"stroke-opacity";$Num_strokeOpacity)
SVG SET ATTRIBUTE:C1055(*;"Image";"select-bm-"+$Txt_ID;\
"fill-opacity";$Num_fillOpacity)

SVG SET ATTRIBUTE:C1055(*;"Image";"select-br-"+$Txt_ID;\
"stroke-opacity";$Num_strokeOpacity)
SVG SET ATTRIBUTE:C1055(*;"Image";"select-br-"+$Txt_ID;\
"fill-opacity";$Num_fillOpacity)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End