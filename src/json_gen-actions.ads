with Libadalang.Analysis; use Libadalang.Analysis;
with Utils.Char_Vectors; use Utils.Char_Vectors;
with Utils.Command_Lines; use Utils.Command_Lines;
with Utils.Tools; use Utils.Tools;
with Pp.Scanner; use Pp;

package JSON_Gen.Actions is

   type Json_Gen_Tool is new Tool_State with private;
   procedure Format_Vector
     (Cmd       : Command_Line;
      Input     : Char_Vector;
      Node      : Ada_Node;
      In_Range  : Char_Subrange;
      Output    : out Char_Vector;
      Out_Range : out Char_Subrange;
      Messages  : out Pp.Scanner.Source_Message_Vector);

private
   overriding procedure Init (Tool : in out Json_Gen_Tool;
                              Cmd  : in out Command_Line);

   overriding procedure Per_File_Action
     (Tool      : in out Json_Gen_Tool;
      Cmd       : Command_Line;
      File_Name : String;
      Input     : String;
      BOM_Seen  : Boolean;
      Unit      : Analysis_Unit);

   overriding procedure Final (Tool : in out Json_Gen_Tool;
                               Cmd  : Command_Line);
   overriding procedure Tool_Help (Tool : Json_Gen_Tool);

   type Json_Gen_Tool is new Tool_State with record
      Ignored_Out_Range : Char_Subrange;
      Ignored_Messages  : Scanner.Source_Message_Vector;
   end record;

   --  For Debugging:

   procedure Dump
     (Tool    : in out Json_Gen_Tool;
      Message : String := "");

end JSON_Gen.Actions;
