with Common;

package Warehouse is

   --  Warehouse with its own stock (module 3)
   task Storage is
      entry Claim_Robot (D : Common.Delivery);                         --  robot delivers goods
      entry Get_Stock (S : out Common.Stock);                    --  current stock
      entry Receive_Order (O : Common.Order; Done : out Boolean);  --  customer order (A)
      entry Finish;                                              --  controlled shutdown
   end Storage;

   --  Customer placing orders (module A)
   task type Customer_Type (Id : Integer);

   Customer_1 : Customer_Type (1);
   Customer_2 : Customer_Type (2);
   Customer_3 : Customer_Type (3);
   Customer_4 : Customer_Type (4);
   

end Warehouse;