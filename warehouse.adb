with ada.text_io;
with ada.numerics.discrete_random;

package body Warehouse is

   package Random_Goods is new ada.numerics.discrete_random (Common.Goods_Type);
   subtype Quantity_Range is Integer range 1 .. 5;
   package Random_Qty is new ada.numerics.discrete_random (Quantity_Range);

   task body Storage is 

      Current_Stock : Common.Stock := (others => 0);
      Total_Items : Integer := 0;
      Finished : Boolean := False;

   begin

      while not Finished loop

         select
            --making sure that warehouse is not full
            when Total_Items <= Common.Warehouse_Capacity - 10 =>

               accept Claim_Robot (D : Common.Delivery) do

                  Current_Stock (D.Goods) := Current_Stock (D.Goods) + D.Quantity;
                  Total_Items := Total_Items + D.Quantity;
                  Ada.Text_IO.Put_Line ("[WAREHOUSE] Robot delivered " & Integer'Image (D.Quantity) &
                  " units of product " & Common.Goods_Type'Image (D.Goods));

               end Claim_Robot;

            or 
               --receiving orders from customers 
               accept Receive_Order (O : Common.Order; Done : out Boolean) do
                  --checking if the order can be placed
                  if Current_Stock (O.Goods) >= O.Quantity then

                     Current_Stock (O.Goods) := Current_Stock (O.Goods) - O.Quantity;
                     Total_Items := Total_Items - O.Quantity;
                     Done := True;
                     Ada.Text_IO.Put_Line ("[WAREHOUSE] Order nr: " & Integer'Image(O.Number) & " has been completed.");

                  else

                     Done := False;

                  end if;

               end Receive_Order;

            or

               accept Get_Stock (S : out Common.Stock) do

                  S := Current_Stock;

               end Get_Stock;

            or

               accept Finish do

                  Finished := True;

               end Finish;

         end select;

      end loop;

      ada.text_io.put_line("[WAREHOUSE] Work is done.");

   end Storage;

   task body Customer_Type is
      --Generator for order parameters
      Gen_Goods : Random_Goods.Generator;
      Gen_Qty : Random_Qty.Generator;

      My_Order : Common.Order;
      Done : Boolean := False;
      First_Try : Boolean := True;

   begin

      Random_Goods.Reset (Gen_Goods);
      Random_Qty.Reset (Gen_Qty);

      delay Duration (5 + Id*2);

      My_Order.Number := Id;
      My_Order.Goods := Random_Goods.Random(Gen_Goods);
      My_Order.Quantity := Random_Qty.Random(Gen_Qty);

      Ada.Text_IO.Put_Line ("[" & Integer'Image (Common.Now) & "] [CUSTOMER" & Integer'Image (My_Order.Number) &
                           "] Placed order nr:" & Integer'Image (My_Order.Number) & " for " &
                           Integer'Image (My_Order.Quantity) & " units of product " &
                           Common.Goods_Type'Image (My_Order.Goods));


      --loop not ending until the customer receives his order
      while not Done loop

         Storage.Receive_Order (My_Order, Done);
         --if his order was too big to be completed
         if not Done then
            --if its his first try to place an order then he says that he is waiting
            if First_Try then

               Ada.Text_IO.Put_Line ("[WAREHOUSE] Insufficient stock for order nr: " & Integer'Image(Id));

               Ada.Text_IO.Put_Line ("[" & Integer'Image (Common.Now) & "] [CUSTOMER" & Integer'Image (Id) &
                                    "] Waiting for stock of " & Common.Goods_Type'Image (My_Order.Goods) & "...");
               First_Try := False;

            end if;
            --customer checking every 2s to see if his order can be done
            delay 2.0;

         end if;

      end loop;

      Ada.Text_IO.Put_Line ("[" & Integer'Image (Common.Now) & "] [CUSTOMER" & Integer'Image (Id) &
                            "] Order fulfilled.");

   end Customer_Type;

end Warehouse;