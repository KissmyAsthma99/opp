-------------------------------------
--  Laboratory work #1
--  F1: d = MAX((A + B + C) *(MA*ME))
--  F2: q = MAX(MH * MK - ML)
--  F3: O = SORT(P)*(MR*MT)
--  Korinenko I. IO-83
--  Date 16 09 2020
-------------------------------------
with data;
with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;
with System.Multiprocessors; use System.Multiprocessors;
procedure Lab1 is
   N: Integer:=2;
   package Data1 is new data(N);
   use Data1;
   Res1: Integer;
   Res2: Integer;
   Res3: Vector;

   CPU_0: CPU_Range:= 1;
   CPU_1: CPU_Range:= 2;
   CPU_2: CPU_Range:= 3;

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
         pragma CPU(CPU_2);
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
         Res1:= Func1(A=>A, B=>B, C=>C, MA=>MA, ME=>ME);
      end T1;

      task body T2 is
         MH,MK,ML: Matrix;
      begin
         Put_Line("Task T2 started.");
         delay 1.0;
         Matrix_Fill_Ones(MH);
         Matrix_Fill_Ones(MK);
         Matrix_Fill_Ones(ML);
         Res2:= Func2(MH => MH,MK => MK,ML => ML);
       end T2;

      task body T3 is
         P: Vector;
         MR,MT: Matrix;
      begin
         Put_Line("Task T3 started.");
         delay 1.0;
         Vector_Fill_Ones(P);
         Matrix_Fill_Ones(MR);
         Matrix_Fill_Ones(MT);
         Res3:= Func3(P => P,MR => MR,MT => MT);
      end T3;
   begin
      null;
   end Tasks;


begin
   Tasks;
   New_Line;
   Put("T1: d = ");
   Put(Res1);
   New_Line;
   Put_Line("Task T1 finished.");

   New_Line;
   Put("T2: q = ");
   Put(Res2);
   New_Line;
   Put_Line("Task T2 finished.");

   New_Line;
   Put_Line("T3: O = ");
   Vector_Output(Res3);
   Put_Line("Task T3 finished.");

end Lab1;
