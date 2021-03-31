-------------------------------------
--  Laboratory work #1
--  F1: D = (SORT(A + B) + C) *(MA*ME)
--  F2: ML = SORT(MF + MG*MH)
--  F3: T = (O + P)*(MP * MS)
--  Date 30.09.2020
-------------------------------------
with data;
with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;
with System.Multiprocessors; use System.Multiprocessors;
procedure Lab1 is
   N: Integer:=4;
   package Data1 is new data(N);
   use Data1;
   D,T: Vector;
   ML: Matrix;

   CPU_0: CPU_Range:= 1;
   CPU_1: CPU_Range:= 2;

   procedure Tasks is
      task T1 is
         pragma Task_Name("T1");
         pragma Priority(1);
         pragma Storage_Size(10000000);
         pragma CPU(CPU_0);
      end T1;

      task T2 is
         pragma Task_Name("T2");
         pragma Priority(2);
         pragma Storage_Size(10000000);
         pragma CPU(CPU_1);
      end T2;

      task T3 is
         pragma Task_Name("T3");
         pragma Priority(3);
         pragma Storage_Size(10000000);
         pragma CPU(CPU_1);
      end T3;

      task body T1 is
         A,B,C: Vector;
         MA,ME: Matrix;
      begin
         Put_Line("Task T1 started.");
         delay 1.0;
         Vector_Fill_Ones(A);
         Vector_Fill_Ones(B);
         Vector_Fill_Ones(C);
         Matrix_Fill_Ones(MA);
         Matrix_Fill_Ones(ME);
         D:= Func1(A=>A, B=>B, C=>C, MA=>MA, ME=>ME);
      end T1;

      task body T2 is
         MF,MH,MG: Matrix;
      begin
         Put_Line("Task T2 started.");
         delay 1.0;
         Matrix_Fill_Ones(MF);
         Matrix_Fill_Ones(MG);
         Matrix_Fill_Ones(MH);
         ML:= Func2(MF => MF, MG => MG, MH => MH);
       end T2;

      task body T3 is
         O,P: Vector;
         MP,MS: Matrix;
      begin
         Put_Line("Task T3 started.");
         delay 1.0;
         Vector_Fill_Ones(O);
         Vector_Fill_Ones(P);
         Matrix_Fill_Ones(MP);
         Matrix_Fill_Ones(MS);
         T:= Func3(O => O, P => P,MP => MP,MS => MS);
      end T3;
   begin
      null;
   end Tasks;

begin
   Tasks;
   New_Line;
   Put("T1: D = ");
   Vector_Output(D);
   New_Line;
   Put_Line("Task T1 finished.");

   New_Line;
   Put_Line("T2: ML = ");
   Matrix_Output(A => ML);
   Put_Line("Task T2 finished.");

   New_Line;
   Put_Line("T3: T = ");
   Vector_Output(T);
   Put_Line("Task T3 finished.");
end Lab1;
