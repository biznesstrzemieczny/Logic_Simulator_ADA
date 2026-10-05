with Ada.Text_IO;
-- adds random numbers
with Ada.Numerics.Discrete_Random;
-- adds time
with Ada.Calendar;

package body Unloading is

   -- procedure that tells us the time
   procedure Log (Message : String) is
   begin
      Ada.Text_IO.Put_Line ("[" & Integer'Image (Common.Now) & "] " & Message);
   end Log;

   -- body of the Station task
   task body Station is
<<<<<<< HEAD
      Current : Common.Delivery;
=======
      Current      : Common.Delivery;
>>>>>>> ea61b3705851c695d271723a090884a0784a705e
      Has_Delivery : Boolean := False;
   begin

      -- station is always ready for the new car during the loop and if the cars are gone the station task is over
      loop
         select
<<<<<<< HEAD
         -- when station is empty -> start unloading the car
            when not Has_Delivery =>
               accept Unload (D : Common.Delivery) do
                  Current := D;
                  Log ("Station: unloading car" & Integer'Image (Current.Id) & " started");
                  -- integer delay duration that is linear to quantity
                  delay Duration (1 + Current.Quantity / 3);
                  Log ("Station: unloading car" & Integer'Image (Current.Id) & " finished");
            end Unload;
            Has_Delivery := True;
         or 
         -- when station is full -> give delivery to a robot
            when Has_Delivery =>
               accept Give_Delivery (D : out Common.Delivery) do
                  D := Current;
               end Give_Delivery;
               Has_Delivery := False;
               Log ("Station: delivery" & Integer'Image (Current.Id) & " handed to a robot");
=======
            -- when station is empty -> start unloading the car
            when not Has_Delivery
            =>accept Unload (D : Common.Delivery) do
               Current := D;
               Log
                 ("Station: unloading car"
                  & Integer'Image (Current.Id)
                  & " started");
               -- integer delay duration that is linear to quantity
               delay Duration (1 + Current.Quantity / 3);
               Log
                 ("Station: unloading car"
                  & Integer'Image (Current.Id)
                  & " finished");
            end Unload;
            Has_Delivery := True;
         or
         -- when station is full -> give delivery to a robot
            when Has_Delivery
            =>accept Give_Delivery (D : out Common.Delivery) do
               D := Current;
            end Give_Delivery;
            Has_Delivery := False;
            Log
              ("Station: delivery"
               & Integer'Image (Current.Id)
               & " handed to a robot");
>>>>>>> ea61b3705851c695d271723a090884a0784a705e
         or
            accept Finish;
            exit;
         end select;
      end loop;
   end Station;

   -- body of the Car_Type task (many cars but same instruction)
   task body Car_Type is
      -- arrival time between cars
      subtype Arrival_Range is Integer range 1 .. 10;

      -- min and max quantity of one car
<<<<<<< HEAD
      subtype Quantity_Range is Integer range 1 .. 10;

      -- random seconds
      package Random_Arrival is new Ada.Numerics.Discrete_Random (Arrival_Range);

      -- random type of product
      package Random_Goods is new Ada.Numerics.Discrete_Random (Common.Goods_Type);

      -- random number of products
      package Random_Quantity is new Ada.Numerics.Discrete_Random (Quantity_Range);

      -- generators of random numbers from each random thing
      Arrival_Gen : Random_Arrival.Generator;
      Goods_Gen : Random_Goods.Generator;
      Quantity_Gen : Random_Quantity.Generator;

      -- universal seed generator
      Seed : constant Integer := Id + Integer (Ada.Calendar.Seconds (Ada.Calendar.Clock) * 1000);

      D : Common.Delivery;

      Max_Wait : constant Duration := 3.0;
=======
      subtype Quantity_Range is Integer range 5 .. 10;

      -- random seconds
      package Random_Arrival is new
        Ada.Numerics.Discrete_Random (Arrival_Range);

      -- random type of product
      package Random_Goods is new
        Ada.Numerics.Discrete_Random (Common.Goods_Type);

      -- random number of products
      package Random_Quantity is new
        Ada.Numerics.Discrete_Random (Quantity_Range);

      -- generators of random numbers from each random thing
      Arrival_Gen  : Random_Arrival.Generator;
      Goods_Gen    : Random_Goods.Generator;
      Quantity_Gen : Random_Quantity.Generator;

      -- universal seed generator
      Seed : constant Integer :=
        Id + Integer (Ada.Calendar.Seconds (Ada.Calendar.Clock) * 1000);

      D : Common.Delivery;

      Max_Wait : constant Duration := 5.0;
>>>>>>> ea61b3705851c695d271723a090884a0784a705e

   begin
      -- random numbers resets
      Random_Arrival.Reset (Arrival_Gen, Seed);
      Random_Goods.Reset (Goods_Gen, Seed + 1);
      Random_Quantity.Reset (Quantity_Gen, Seed + 2);

      -- adds cars arrival delay
      delay Duration (Random_Arrival.Random (Arrival_Gen));

      -- adds random good and quantity to a record
<<<<<<< HEAD
      D := (Id => Id, Goods => Random_Goods.Random (Goods_Gen), Quantity => Random_Quantity.Random (Quantity_Gen));

      -- arrive information
      Log ("Car" & Integer'Image (D.Id) & " arrived with" & Integer'Image (D.Quantity) & " pieces of " & Common.Goods_Type'Image (D.Goods));
=======
      D :=
        (Id       => Id,
         Goods    => Random_Goods.Random (Goods_Gen),
         Quantity => Random_Quantity.Random (Quantity_Gen));

      -- arrive information
      Log
        ("Car"
         & Integer'Image (D.Id)
         & " arrived with"
         & Integer'Image (D.Quantity)
         & " pieces of "
         & Common.Goods_Type'Image (D.Goods));
>>>>>>> ea61b3705851c695d271723a090884a0784a705e
      Log ("Car" & Integer'Image (D.Id) & " waiting for unloading");

      select
         Station.Unload (D);
         Log ("Car" & Integer'Image (D.Id) & " unloaded, leaving");
      or
         delay Max_Wait;
         Log ("Car" & Integer'Image (D.Id) & " gave up waiting, leaving");
      end select;

<<<<<<< HEAD

=======
>>>>>>> ea61b3705851c695d271723a090884a0784a705e
   end Car_Type;

end Unloading;
