//%attributes = {}
C_TEXT:C284($Txt_buffer)

  //------------------------------------------------------------------------------
ASSERT:C1129(str_Single_quote ="''")
ASSERT:C1129(str_Single_quote ("Hello world")="'Hello world'")
ASSERT:C1129(str_Single_quote ("'Hello world")="'Hello world'")
ASSERT:C1129(str_Single_quote ("'Hello world'")="'Hello world'")
ASSERT:C1129(str_Single_quote ("Hello world'")="'Hello world'")
ASSERT:C1129(str_Single_quote ("Hello' world")="Hello' world")

  //------------------------------------------------------------------------------
$Txt_buffer:="Hello world"

ASSERT:C1129(Not:C34(str_styledText ($Txt_buffer)))

ST SET ATTRIBUTES:C1093($Txt_buffer;ST Start text:K78:15;ST End text:K78:16;\
Attribute bold style:K65:1;1)

ASSERT:C1129(str_styledText ($Txt_buffer))

ASSERT:C1129(str_styledText ("<span>This is <span style='font-weight:bold'>some</span> test text</span>"))
ASSERT:C1129(str_styledText ("This is <span style='font-weight:bold'>some</span> test text"))

  //------------------------------------------------------------------------------
ASSERT:C1129(str_equal ("HELLO";"HELLO"))
ASSERT:C1129(str_equal ("Hello";"Hello"))
ASSERT:C1129(Not:C34(str_equal ("HELLO";"Hello")))
ASSERT:C1129(Not:C34(str_equal ("hello";"Hello")))

  //------------------------------------------------------------------------------
ASSERT:C1129(Position:C15("Hello";str_Capitalize ("HELLO");1;*)=1)
ASSERT:C1129(str_equal (str_Capitalize ("HELLO");"Hello"))

ASSERT:C1129(Position:C15("Hello";str_Capitalize ("hello");1;*)=1)
ASSERT:C1129(str_equal (str_Capitalize ("Hello");"Hello"))

ASSERT:C1129(Not:C34(str_equal (str_Capitalize ("hello world");"Hello World")))
ASSERT:C1129(Not:C34(str_equal (str_Capitalize ("HELLO");"HELLO")))