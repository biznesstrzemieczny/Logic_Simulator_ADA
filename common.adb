with Ada.Calendar;

package body Common is

   Start_Time : Ada.Calendar.Time := Ada.Calendar.Clock;

   function Now return Integer is
   begin
      return Integer (Ada.Calendar."-" (Ada.Calendar.Clock, Start_Time));
   end Now;

end Common;