with Ada.Text_IO;
with Common;
with Unloading;
with Robots;
with Monitor;
with Warehouse;

procedure Main is
begin
   Ada.Text_IO.Put_Line
     ("[" & Integer'Image (Common.Now) & "] Simulation started");

   delay 20.0;

   Robots.Robot_1.Finish;
   Robots.Robot_2.Finish;
   Unloading.Station.Finish;
   Monitor.Controller.Finish;
   Warehouse.Storage.Finish;

   Ada.Text_IO.Put_Line
     ("[" & Integer'Image (Common.Now) & "] Simulation finished");
end Main;
