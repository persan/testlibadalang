with Utils.Command_Lines; use Utils.Command_Lines;
with Utils.Drivers;

with JSON_Gen.Actions;
with JSON_Gen.Command_Lines;

procedure JSON_Gen.Main is

   --  Main procedure for lalstub

   --     procedure Callback (Phase : Parse_Phase; Swit : Dynamically_Typed_Switch);

   procedure Callback (Phase : Parse_Phase; Swit : Dynamically_Typed_Switch) is
   null;

   Tool : Actions.Json_Gen_Tool;
   Cmd  : Command_Line (JSON_Gen.Command_Lines.Descriptor'Access);

begin
   Utils.Drivers.Driver
     (Cmd => Cmd,
      Tool => Tool,
      Tool_Package_Name     => "jsongen",
      Needs_Per_File_Output => True,
      Callback              => Callback'Unrestricted_Access);
end JSON_Gen.Main;
