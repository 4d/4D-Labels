C_LONGINT:C283($Lon_page)
C_POINTER:C301($Ptr_)

$Ptr_:=OBJECT Get pointer:C1124(Object named:K67:5;"tabControl")
$Lon_page:=Num:C11($Ptr_->{0})

CLEAR VARIABLE:C89((OBJECT Get pointer:C1124(Object named:K67:5;"Variable"))->)
FORM GOTO PAGE:C247($Lon_page)

REJECT:C38