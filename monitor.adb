with Ada.Text_IO;
with Common;
with Warehouse;

package body Monitor is

   task body Controller is
      Robot_States : array (1 .. Common.Robot_Count) of Common.Robot_State :=
        (others => Common.Free);       --  state of each robot
      Deliveries   : Integer := 0;
      S            : Common.Stock;        --  stock from the warehouse
      Total        : Integer;             --  total of goods in the warehouse
      Next_Print   : Integer := 5;        --  duration of the next report
      Ended        : Boolean := False;
   begin
      while not Ended loop
         --  robots status check
         select
            accept Robot_Status (Id : Integer; State : Common.Robot_State) do
               Robot_States (Id) := State;
            end Robot_Status;
         or
            accept Delivery_Done;
            Deliveries := Deliveries + 1;
         or
            accept Finish;
            Ended := True;
         or
            delay 1.0;
         end select;

         --  every 5 seconds print the state of the center
         if Common.Now >= Next_Print then
            Warehouse.Storage.Get_Stock (S);
            Total := S (Common.A) + S (Common.B) + S (Common.C);

            Ada.Text_IO.Put_Line ("--------- CENTER ---------");
            -- warehouse status
            Ada.Text_IO.Put_Line
              ("Warehouse:"
               & Integer'Image (Total)
               & " /"
               & Integer'Image (Common.Warehouse_Capacity));

            -- robots states
            for I in 1 .. Common.Robot_Count loop
               Ada.Text_IO.Put_Line
                 ("Robot R"
                  & Integer'Image (I)
                  & ": "
                  & Common.Robot_State'Image (Robot_States (I)));
            end loop;

            -- deliveries and goods
            Ada.Text_IO.Put_Line
              ("Deliveries handled:" & Integer'Image (Deliveries));
            for G in Common.Goods_Type loop
               Ada.Text_IO.Put_Line
                 ("Goods "
                  & Common.Goods_Type'Image (G)
                  & ":"
                  & Integer'Image (S (G)));
            end loop;
            Ada.Text_IO.Put_Line ("--------------------------");

            Next_Print := Next_Print + 5;
         end if;
      end loop;
   end Controller;

end Monitor;
