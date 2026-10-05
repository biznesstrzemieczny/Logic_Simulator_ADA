with Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

with Common;
with Unloading;
with Warehouse;
with Monitor;

package body Robots is

   task body Robot_Type is
      -- time rand generator
      subtype Drive_Range is Integer range 2 .. 6;
      package Random_Drive is new Ada.Numerics.Discrete_Random (Drive_Range);
      Gen        : Random_Drive.Generator;
      Drive_Time : Drive_Range;

      Current_Delivery : Common.Delivery;
      Ended            : Boolean := False;
   begin
      Random_Drive.Reset (Gen);
      while not Ended loop
         select
            -- receiving goods from the station
            Unloading.Station.Give_Delivery (Current_Delivery);
            Ada.Text_IO.Put_Line
              ("["
               & Integer'Image (Common.Now)
               & "] Robot R"
               & Integer'Image (Id)
               & " received"
               & Integer'Image (Current_Delivery.Quantity)
               & " units of goods "
               & Common.Goods_Type'Image (Current_Delivery.Goods));
            Monitor.Controller.Robot_Status (Id, Common.Busy); -- robot is busy

            --  drive to the warehouse
            Drive_Time := Random_Drive.Random (Gen);
            Ada.Text_IO.Put_Line
              ("["
               & Integer'Image (Common.Now)
               & "] Robot R"
               & Integer'Image (Id)
               & " drives to the warehouse");
            delay Duration (Drive_Time);

            -- delivering the goods in the warehouse
            Warehouse.Storage.Claim_Robot (Current_Delivery);
            Ada.Text_IO.Put_Line
              ("["
               & Integer'Image (Common.Now)
               & "] Robot R"
               & Integer'Image (Id)
               & " delivered the goods");
            Monitor.Controller.Delivery_Done; -- delivered goods (for monitor)

            -- finishing, robot is free again
            Monitor.Controller.Robot_Status (Id, Common.Free);
            Ada.Text_IO.Put_Line
              ("["
               & Integer'Image (Common.Now)
               & "] Robot R"
               & Integer'Image (Id)
               & " is free again");
         or
            delay 1.0;
         end select;

         select
            accept Finish;
            Ended := True;
         else
            null;
         end select;
      end loop;
      Ada.Text_IO.Put_Line
        ("["
         & Integer'Image (Common.Now)
         & "] Robot R"
         & Integer'Image (Id)
         & " finished");
   end Robot_Type;

end Robots;
