with Utils.Command_Lines; use Utils.Command_Lines;
with Utils.Command_Lines.Common;        use Utils.Command_Lines.Common;
package JSON_Gen.Command_Lines is

   package Freeze_Common is new Freeze_Descriptor (Common_Descriptor);

   Descriptor : aliased Command_Line_Descriptor :=
                  Copy_Descriptor (Common_Descriptor);

   pragma Warnings (Off);
   use Common_Flag_Switches, Common_String_Switches,
       Common_String_Seq_Switches, Common_Nat_Switches;
   pragma Warnings (On);

   package Json_Gen_Disable is new Disable_Switches
     (Descriptor, (To_All (Rep_Clauses), To_All (Compute_Timing)));

   type Json_Gen_Flags is
     (Subunits,
      Force,
      Alphabetical_Order,
      Comment_Header_Sample,
      Comment_Header_Spec,
      Ignored_Keep_Tree_File,
      No_Exception,
      No_Local_Header,
      Ignored_Reuse_Tree_File,
      Ignored_Overwrite_Tree_File);
   --  Above "Ignored_" switches are legacy switches from the ASIS-based
   --  version.

   package Json_Gen_Flag_Switches is new Flag_Switches
     (Descriptor,
      Json_Gen_Flags);

   package Json_Gen_Flag_Shorthands is new Json_Gen_Flag_Switches.Set_Shorthands
     ((Subunits                   => null,
       Force                       => +"-f",
       Alphabetical_Order          => +"-gnatyo",
       Comment_Header_Sample       => +"-hg",
       Comment_Header_Spec         => +"-hs",
       Ignored_Keep_Tree_File      => +"-k",
       No_Exception                => null,
       No_Local_Header             => null,
       Ignored_Reuse_Tree_File     => +"-r",
       Ignored_Overwrite_Tree_File => +"-t"));

   type Json_Gen_Strings is
     (Header_File,
      Output);

   package Json_Gen_String_Switches is new String_Switches
     (Descriptor,
      Json_Gen_Strings);

   package Json_Gen_String_Syntax is new Json_Gen_String_Switches.Set_Syntax
     ((Header_File => '=',
       Output      => '='));

   package Json_Gen_String_Shorthands is new Json_Gen_String_Switches
     .Set_Shorthands
       ((Header_File => null,
         Output      => +"-o"));

   --  ???Perhaps Max_Line_Length, Indentation should be moved to Common, and
   --  gnatpp and gnatstub shorthands unified. Output is also shared between
   --  gnatpp and gnatstub. Or perhaps gnatstub should import Pp.Command_Lines.

   type Json_Gen_Nats is
     (Max_Line_Length,
      Indentation,
      Update_Body); -- undocumented
   --  Update_Body is intended mainly for use by GPS or other text editors

   package Json_Gen_Nat_Switches is new Other_Switches
     (Descriptor,
      Json_Gen_Nats,
      Natural,
      Natural'Image,
      Natural'Value);

   package Json_Gen_Nat_Syntax is new Json_Gen_Nat_Switches.Set_Syntax
     ((Max_Line_Length => '!',
       Indentation     => '!',
       Update_Body     => '='));

   No_Update_Body : constant Natural := 0;

   package Json_Gen_Nat_Defaults is new Json_Gen_Nat_Switches.Set_Defaults
     ((Max_Line_Length => 79,
       Indentation     => 3,
       Update_Body     => No_Update_Body));

   package Json_Gen_Nat_Shorthands is new Json_Gen_Nat_Switches.Set_Shorthands
     ((Max_Line_Length => +"-gnatyM",
       Indentation     => +"-gnaty",
       Update_Body     => null));

   package Json_Gen_Nat_Shorthands_2 is new Json_Gen_Nat_Switches.Set_Shorthands
     ((Max_Line_Length => +"-l",
       Indentation     => +"-i",
       Update_Body     => null));

   package Freeze is new Freeze_Descriptor (Descriptor);

   pragma Warnings (Off);
   use Json_Gen_Flag_Switches,
       Json_Gen_String_Switches,
       Json_Gen_Nat_Switches;
   pragma Warnings (On);

   subtype Cmd_Line is Utils.Command_Lines.Command_Line;

   function Update_Body_Specified (Cmd : Cmd_Line) return Boolean is
     (Arg (Cmd, Update_Body) /= No_Update_Body);
   --  If --update-body was not specified on the command line, then it will be
   --  equal to the default (No_Update_Body).

end JSON_Gen.Command_Lines;
