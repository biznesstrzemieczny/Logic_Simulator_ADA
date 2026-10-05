package Common is

   --  Simulation parameters
   Car_Count          : constant := 5;
   Robot_Count        : constant := 2;
   Warehouse_Capacity : constant := 50;

   --  Kinds of goods (module 3: at least 3)
   type Goods_Type is (A, B, C);

   --  Delivery brought by a car (module 1)
   type Delivery is record
      Id       : Integer;
      Goods    : Goods_Type;
      Quantity : Integer;
   end record;

   --  Customer order (module A)
   type Order is record
      Number   : Integer;
      Goods    : Goods_Type;
      Quantity : Integer;
   end record;

   --  Robot state shown by the monitor (module G)
   type Robot_State is (Free, Busy);

   type Stock is array (Goods_Type) of Integer;

end Common;
