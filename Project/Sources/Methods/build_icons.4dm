//%attributes = {"invisible":true}
  //C_TEXT($Dom_g;$Dom_path;$Dom_rect;$Dom_tool;$Svg_root)

  //SVG_SET_OPTIONS (SVG_Get_options  ?+ 5)
  //$Svg_root:=SVG_New   //(33;33;"";"";True)
  //SVG_SET_SHAPE_RENDERING ($Svg_root;"crispEdges")

  //  //back
  //SVG_Post_comment ($Svg_root;"background")
  //$Dom_rect:=SVG_New_rect ($Svg_root;0;0;30,5;30,5;0;0;"black";"none";0,2)
  //SVG_SET_TRANSFORM_TRANSLATE ($Dom_rect;0,5;0,5)

  //  //tool
  //SVG_Post_comment ($Svg_root;"tool")

  //Case of 

  //  //______________________________________________________
  //: (False)  //fill

  //$Dom_tool:=SVG_New_rect ($Svg_root;0;0;28,5;28,5;0;0;"white";"black";1)
  //SVG_SET_ID ($Dom_tool;"tool")
  //SVG_SET_TRANSFORM_TRANSLATE ($Dom_tool;1,5;1,5)

  //  //______________________________________________________
  //: (False)  //stroke

  //$Dom_tool:=SVG_New_rect ($Svg_root;0;0;28,5;28,5;0;0;"white";"black";1)
  //SVG_SET_ID ($Dom_tool;"tool")
  //SVG_SET_TRANSFORM_TRANSLATE ($Dom_tool;1,5;1,5)

  //$Dom_rect:=SVG_New_rect ($Svg_root;6,5;6,5;18,5;18,5;0;0;"white";"white";1)
  //$Dom_rect:=SVG_New_rect ($Svg_root;7,5;8;16,5;16;0;0;"grey";"none";0,3)

  //  //______________________________________________________
  //: (True)  //stroke width

  //$Dom_tool:=SVG_New_line ($Svg_root;4;15;27;15;"black";2)
  //SVG_SET_ID ($Dom_tool;"tool")

  //  //______________________________________________________
  //Else 

  //  //______________________________________________________
  //End case 

  //  //arrow
  //SVG_Post_comment ($Svg_root;"arrow")
  //$Dom_g:=SVG_New_group ($Svg_root)

  //$Dom_rect:=SVG_New_rect ($Dom_g;21;21;9;9;0;0;"none";"white";0,1)

  //$Dom_path:=SVG_New_path ($Dom_g;22,5;24;"none";"black")
  //SVG_PATH_LINE_TO ($Dom_path;28;24)
  //SVG_PATH_LINE_TO ($Dom_path;25,5;28)
  //SVG_PATH_CLOSE ($Dom_path)

  //SVG_SET_TRANSFORM_SCALE ($Dom_g;0,8)
  //SVG_SET_TRANSFORM_TRANSLATE ($Dom_g;8;8)

  //SVGTool_SHOW_IN_VIEWER ($Svg_root)
  //SVG_CLEAR ($Svg_root)