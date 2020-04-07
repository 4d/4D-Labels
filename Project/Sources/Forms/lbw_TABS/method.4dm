  // ----------------------------------------------------
  // Object method : lbw_TABS - (4D Labels)
  // ID[A7F4D3A1E52B4CE2A687F9922FC0FF7A]
  // Created #8-6-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($kLon_buttonMinWidth;$kLon_hOffset;$l;$Lon_bottom;$Lon_formEvent;$Lon_height)
C_LONGINT:C283($Lon_left;$Lon_right;$Lon_top;$Lon_totalWidth;$Lon_type;$Lon_width)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		  // Set best size
		$kLon_hOffset:=20
		$kLon_buttonMinWidth:=50
		
		OBJECT GET BEST SIZE:C717(*;"label";$Lon_width;$Lon_height)
		$Lon_width:=Choose:C955($Lon_width<$kLon_buttonMinWidth;$kLon_buttonMinWidth;$Lon_width)
		$Lon_width:=$Lon_width*1.2
		$Lon_totalWidth:=$kLon_hOffset+$Lon_width+$kLon_hOffset
		
		OBJECT GET BEST SIZE:C717(*;"layout";$Lon_width;$Lon_height)
		$Lon_width:=Choose:C955($Lon_width<$kLon_buttonMinWidth;$kLon_buttonMinWidth;$Lon_width)
		$Lon_width:=$Lon_width*1.2
		$Lon_totalWidth:=$Lon_totalWidth+$Lon_width+$kLon_hOffset+2
		
		$Lon_width:=$Lon_totalWidth/2
		
		OBJECT GET COORDINATES:C663(*;"label";$l;$Lon_top;$l;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"label";0;$Lon_top;$Lon_width;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"label.bg";0;$Lon_top;$Lon_width;$Lon_bottom+2)
		
		OBJECT GET COORDINATES:C663(*;"layout";$l;$Lon_top;$l;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"layout";$Lon_width;$Lon_top;$Lon_totalWidth;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"layout.bg";$Lon_width-1;$Lon_top;$Lon_totalWidth;$Lon_bottom+2)
		
		  // Call subform to fix width
		CALL SUBFORM CONTAINER:C1086(-($Lon_totalWidth))
		
		  // Set the focus ring color
		OBJECT SET RGB COLORS:C628(*;"selection";Highlight text background color:K23:5;Background color none:K23:10)
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		  //
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Bound Variable Change:K2:52)
		
		$Lon_type:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
		
		If ($Lon_type>0)
			
			OBJECT GET COORDINATES:C663(*;Choose:C955($Lon_type;"";"label.bg";"layout.bg");$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
			OBJECT SET COORDINATES:C1248(*;"selection";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
			
			OBJECT SET VISIBLE:C603(*;"selection";True:C214)
			
		Else 
			
			OBJECT SET ENABLED:C1123(*;"label";False:C215)
			OBJECT SET ENABLED:C1123(*;"layout";False:C215)
			
			OBJECT SET VISIBLE:C603(*;"selection";False:C215)
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 