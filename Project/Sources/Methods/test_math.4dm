//%attributes = {}
  // ----------------------------------------------------
  // Project method : test_math
  // Database: 4D Labels
  // ID[0E9A016C5E7049B887EA3D31DB962F05]
  // Created #8-8-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // unit test method for the "math" lib
  // ----------------------------------------------------
  // Declarations

  // ----------------------------------------------------
  // Initialisations

  // ----------------------------------------------------
If (True:C214)  // to point [print]
	
	  //from inch
	ASSERT:C1129(String:C10(math_Length_conversion (1;"in";"pt");"&xml")="72")
	ASSERT:C1129(String:C10(math_Length_conversion (2.5;"in";"pt");"&xml")="180")
	ASSERT:C1129(String:C10(math_Length_conversion (5;"in";"pt");"&xml")="360")
	
	  //from millimeter
	ASSERT:C1129(String:C10(math_Length_conversion (1;"mm";"pt");"&xml")="2.83464567")
	ASSERT:C1129(String:C10(math_Length_conversion (2.5;"mm";"pt");"&xml")="7.086614175")
	ASSERT:C1129(String:C10(math_Length_conversion (5;"mm";"pt");"&xml")="14.17322835")
	ASSERT:C1129(String:C10(math_Length_conversion (20;"mm";"pt");"&xml")="56.6929134")
	ASSERT:C1129(String:C10(math_Length_conversion (20.65;"mm";"pt");"&xml")="58.535433085")
	
	  //from centimeter
	ASSERT:C1129(String:C10(math_Length_conversion (1;"cm";"pt");"&xml")="28.3464567")
	ASSERT:C1129(String:C10(math_Length_conversion (2.5;"cm";"pt");"&xml")="70.86614175")
	ASSERT:C1129(String:C10(math_Length_conversion (5;"cm";"pt");"&xml")="141.7322835")
	ASSERT:C1129(String:C10(math_Length_conversion (20;"cm";"pt");"&xml")="566.929134")
	ASSERT:C1129(String:C10(math_Length_conversion (20.65;"cm";"pt");"&xml")="585.354330855")
	
	  //from point
	ASSERT:C1129(String:C10(math_Length_conversion (1;"pt";"pt");"&xml")="1")
	ASSERT:C1129(String:C10(math_Length_conversion (2.5;"pt";"pt");"&xml")="2.5")
	ASSERT:C1129(String:C10(math_Length_conversion (5;"pt";"pt");"&xml")="5")
	
End if 

If (True:C214)  // to centimeter
	
	  //from point
	ASSERT:C1129(String:C10(math_Length_conversion (1;"pt";"cm");"&xml")="0.035277778")
	ASSERT:C1129(String:C10(math_Length_conversion (2.5;"pt";"cm");"&xml")="0.088194444")
	ASSERT:C1129(String:C10(math_Length_conversion (5;"pt";"cm");"&xml")="0.176388889")
	ASSERT:C1129(String:C10(math_Length_conversion (20;"pt";"cm");"&xml")="0.705555555")
	
	  //from inch
	ASSERT:C1129(String:C10(math_Length_conversion (1;"in";"cm");"&xml")="2.540000003")
	ASSERT:C1129(String:C10(math_Length_conversion (2.5;"in";"cm");"&xml")="6.350000006")
	ASSERT:C1129(String:C10(math_Length_conversion (5;"in";"cm");"&xml")="12.700000013")
	ASSERT:C1129(String:C10(math_Length_conversion (20.65;"in";"cm");"&xml")="52.451000054")
	
	  //from millimeter
	ASSERT:C1129(String:C10(math_Length_conversion (1;"mm";"cm");"&xml")="0.1")
	ASSERT:C1129(String:C10(math_Length_conversion (2.5;"mm";"cm");"&xml")="0.25")
	ASSERT:C1129(String:C10(math_Length_conversion (5;"mm";"cm");"&xml")="0.5")
	ASSERT:C1129(String:C10(math_Length_conversion (20;"mm";"cm");"&xml")="2")
	ASSERT:C1129(String:C10(math_Length_conversion (20.65;"mm";"cm");"&xml")="2.065")
	
End if 

If (True:C214)  // to millimeter
	
	  //from point
	ASSERT:C1129(String:C10(math_Length_conversion (1;"pt";"mm");"&xml")="0.352777778")
	ASSERT:C1129(String:C10(math_Length_conversion (2.5;"pt";"mm");"&xml")="0.881944444")
	ASSERT:C1129(String:C10(math_Length_conversion (5;"pt";"mm");"&xml")="1.763888888")
	ASSERT:C1129(String:C10(math_Length_conversion (20;"pt";"mm");"&xml")="7.055555554")
	
	  //from inch
	ASSERT:C1129(String:C10(math_Length_conversion (1;"in";"mm");"&xml")="2.540000003")
	ASSERT:C1129(String:C10(math_Length_conversion (2.5;"in";"mm");"&xml")="6.350000006")
	ASSERT:C1129(String:C10(math_Length_conversion (5;"in";"mm");"&xml")="12.700000013")
	ASSERT:C1129(String:C10(math_Length_conversion (20.65;"in";"mm");"&xml")="52.451000053")
	
	  //from centimeter
	ASSERT:C1129(String:C10(math_Length_conversion (1;"cm";"mm");"&xml")="10")
	ASSERT:C1129(String:C10(math_Length_conversion (2.5;"cm";"mm");"&xml")="25")
	ASSERT:C1129(String:C10(math_Length_conversion (5;"cm";"mm");"&xml")="50")
	ASSERT:C1129(String:C10(math_Length_conversion (20;"cm";"mm");"&xml")="200")
	ASSERT:C1129(String:C10(math_Length_conversion (20.65;"cm";"mm");"&xml")="206.5")
	
End if 

If (True:C214)  //reverse & rounded
	
	  // mm <-> pt
	ASSERT:C1129(math_Length_conversion (math_Length_conversion (1;"mm";"pt");"pt";"mm";2)=1)
	ASSERT:C1129(math_Length_conversion (math_Length_conversion (10;"mm";"pt");"pt";"mm";2)=10)
	ASSERT:C1129(math_Length_conversion (math_Length_conversion (5;"mm";"pt");"pt";"mm";2)=5)
	ASSERT:C1129(math_Length_conversion (math_Length_conversion (20;"mm";"pt");"pt";"mm";2)=20)
	ASSERT:C1129(math_Length_conversion (math_Length_conversion (20.65;"mm";"pt");"pt";"mm";2)=20.65)
	
	  // cm <-> pt
	ASSERT:C1129(math_Length_conversion (math_Length_conversion (1;"cm";"pt");"pt";"cm";2)=1)
	ASSERT:C1129(math_Length_conversion (math_Length_conversion (10;"cm";"pt");"pt";"cm";2)=10)
	ASSERT:C1129(math_Length_conversion (math_Length_conversion (5;"cm";"pt");"pt";"cm";2)=5)
	ASSERT:C1129(math_Length_conversion (math_Length_conversion (20;"cm";"pt");"pt";"cm";2)=20)
	ASSERT:C1129(math_Length_conversion (math_Length_conversion (20.65;"cm";"pt");"pt";"cm";2)=20.65)
	
	  // in <-> pt
	ASSERT:C1129(math_Length_conversion (math_Length_conversion (1;"in";"pt");"pt";"in";2)=1)
	ASSERT:C1129(math_Length_conversion (math_Length_conversion (10;"in";"pt");"pt";"in";2)=10)
	ASSERT:C1129(math_Length_conversion (math_Length_conversion (5;"in";"pt");"pt";"in";2)=5)
	ASSERT:C1129(math_Length_conversion (math_Length_conversion (20;"in";"pt");"pt";"in";2)=20)
	ASSERT:C1129(math_Length_conversion (math_Length_conversion (20.65;"in";"pt");"pt";"in";2)=20.65)
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End