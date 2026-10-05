with Common;

package Monitor is

   --  Center monitor (module G)
   task Controller is
      entry Robot_Status
        (Id : Integer; State : Common.Robot_State);  --  from robots
      entry Delivery_Done;                                           --  deliveried done by robot
      entry Finish;                                                  --  controlled shutdown
   end Controller;

end Monitor;
