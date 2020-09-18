with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;
package body data is
   function Sum_Vector(A,B: in Vector) return Vector is
      S: Vector;
   begin
      for i in 1..N loop
         S(i):=A(i)+B(i);
      end loop;
      return S;
   end Sum_Vector;

   function Matrix_Multiplication(A,B: in Matrix) return Matrix is
      M: Matrix;
      s: Integer;
   begin
      for k in 1..N loop
         for i in 1..N loop
            s:=0;
            for j in 1..N loop
               s:=A(k)(j)*B(j)(i);
               M(k)(i):=s;
            end loop;
         end loop;
      end loop;
      return M;
   end Matrix_Multiplication;

   function Vector_Matrix_Multiplication(A: in Vector; B: in Matrix) return Vector is
      P: Vector;
      s: Integer;
   begin
      for i in 1..N loop
         s:=0;
         for j in 1..N loop
            s:=S+A(i)*B(j)(i);
         end loop;
         P(i):=S;
      end loop;
      return P;
   end Vector_Matrix_Multiplication;

   procedure Vector_Sort(A: in out Vector) is
      e: Integer;
   begin
      for i in 1..N loop
         for j in 1..N loop
            if A(i)>A(j) then
               E:=A(j);
               A(j):=A(i);
               A(i):=e;
            end if;
         end loop;
      end loop;
   end Vector_Sort;

   procedure Matrix_Sort(A: in out Matrix) is
	   m: Integer;
   begin
      for i in 1..n loop
         for j in 1..n loop
           A(i)(j):=A(i)(j);
         end loop;
      end loop;
      for k in 1..n loop
         for i in reverse 1..n loop
            for j in 1..(i-1) loop
               if A(k)(j) <A(k)(j+1) then
                  m :=A(k)(j);
                 A(k)(j):=A(k)(j+1);
                 A(k)(j+1):=m;
               end if;
            end loop;
         end loop;
      end loop;
   end Matrix_Sort;

   function Matrix_Add(A,B: in Matrix) return Matrix is
      S: Matrix;
   begin
      for i in 1..N loop
         for j in 1..N loop
            S(i)(j):=A(i)(j) + B(i)(j);
         end loop;
      end loop;
      return S;
   end Matrix_Add;

   procedure Matrix_Fill_Ones (A: out Matrix) is
   begin
      for i in 1..N loop
         for j in 1..N loop
            A(i)(j):=i;
         end loop;
      end loop;
   end Matrix_Fill_Ones;

   procedure Vector_Fill_Ones (A: out Vector) is
   begin
      for i in 1..N loop
         A(i):=1;
      end loop;
   end Vector_Fill_Ones;

   procedure Vector_Input (A: out Vector) is
   begin
      for i in 1..N loop
         Get(A(i));
      end loop;
   end Vector_Input;

   procedure Vector_Output (A: in Vector) is
   begin
      for i in 1..N loop
         Put(A(i));
      end loop;
      New_Line;
   end Vector_Output;

   procedure Matrix_Input(A: out Matrix) is
   begin
      for i in 1..N loop
         for j in 1..N loop
            Get(A(i)(j));
         end loop;
      end loop;
   end Matrix_Input;

   procedure Matrix_Output(A: in Matrix) is
   begin
      for i in 1..N loop
         for j in 1..N loop
            Put(A(i)(j));
         end loop;
         New_Line;
      end loop;
      New_Line;
   end Matrix_Output;

   function Func1(A,B,C: in Vector; MA,ME: in Matrix) return Vector is
      Z_Sum, O_Sum, D: Vector;
      MK: Matrix;
   begin
      O_Sum:= Sum_Vector(A,B);
      Vector_Sort(O_Sum);
      Z_Sum:= Sum_Vector(O_Sum,C);
      MK:= Matrix_Multiplication(MA,ME);
      D:= Vector_Matrix_Multiplication(Z_Sum,MK);
      return D;
   end Func1;

   function Func2(MF,MG,MH: in Matrix) return Matrix is
      MJ: Matrix;
      MQ: Matrix;
   begin
      MJ:= Matrix_Multiplication(MG,MH);
      MQ:= Matrix_Add(MJ, MF);
      Matrix_Sort(MQ);
      return MQ;
   end Func2;

   function Func3(O,P: in Vector; MP,MS: in Matrix) return Vector is
      T,S: Vector;
      MG: Matrix;
   begin
      S:= Sum_Vector(O,P);
      MG:= Matrix_Multiplication(MP,MS);
      T:= Vector_Matrix_Multiplication(P,MG);
      return T;
   end Func3;
end data;
