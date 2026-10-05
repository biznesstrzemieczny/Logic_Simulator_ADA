package Robots is

   task type Robot_Type (Id : Integer) is
      entry Finish;
   end Robot_Type;

   Robot_1 : Robot_Type (1);
   Robot_2 : Robot_Type (2);

end Robots;
