with Common;

package Monitor is

   task Controller is
      entry Robot_Status
        (Id    : Integer;
         State : Common.Robot_State);  --  from robots if busy or free
      entry Delivery_Done;                                           --  deliveries done by robot
      entry Finish;
   end Controller;

end Monitor;
