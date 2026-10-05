package Common is

   Car_Count          : constant := 5;
   Robot_Count        : constant := 2;
   Warehouse_Capacity : constant := 50;

   type Goods_Type is (Laptop, Phone, Monitor);

   type Delivery is record
      Id       : Integer;
      Goods    : Goods_Type;
      Quantity : Integer;
   end record;

   type Order is record
      Number   : Integer;
      Goods    : Goods_Type;
      Quantity : Integer;
   end record;

   type Robot_State is (Free, Busy);

   type Stock is array (Goods_Type) of Integer;

   function Now return Integer;

end Common;
