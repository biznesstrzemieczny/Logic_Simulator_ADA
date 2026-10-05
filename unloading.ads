with Common;

package Unloading is

   --  Unloading station (module 1)
   task Station is
      entry Unload (D : Common.Delivery);   --  a car asks to be unloaded
      entry Give_Delivery (D : out Common.Delivery); -- robot takes a delivery
      entry Finish;                         --  controlled shutdown
   end Station;

   --  Delivery car (module 1 + H: gives up after waiting too long)
   task type Car_Type (Id : Integer);

   Car_1 : Car_Type (1);
   Car_2 : Car_Type (2);
   Car_3 : Car_Type (3);
   Car_4 : Car_Type (4);
   Car_5 : Car_Type (5);

end Unloading;