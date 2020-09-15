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
      E: Integer;
   begin
      for i in 1..N loop
         for j in 1..N loop
            if A(i)>A(j) then
               E:=A(j);
               A(j):=A(i);
               A(i):=E;
            end if;
         end loop;
      end loop;
   end Vector_Sort;

   function Matrix_Sub(A,B: in Matrix) return Matrix is
      S: Matrix;
   begin
      for i in 1..N loop
         for j in 1..N loop
            S(i)(j):=A(i)(j) - B(i)(j);
         end loop;
      end loop;
      return S;
   end Matrix_Sub;

   function Max_of_Matrix(A: in Matrix) return Integer is
      S: Integer;
   begin
      for i in 1..N loop
         for j in 1..N loop
            if A(i)(j)>S then
               S:= A(i)(j);
            end if;
         end loop;
      end loop;
      return S;
   end Max_of_Matrix;

   function Max_of_Vector(A: in Vector) return Integer is
      D: Integer;
   begin
      for i in 1..N loop
         if A(i)>D then
            D:= A(i);
         end if;
      end loop;
      return D;
   end Max_of_Vector;

   procedure Matrix_Fill_Ones (A: out Matrix) is
   begin
      for i in 1..N loop
         for j in 1..N loop
            A(i)(j):=1;
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

   procedure Matrix_Input (A: out Matrix) is
   begin
      for i in 1..N loop
         for j in 1..N loop
            Get(A(i)(j));
         end loop;
      end loop;
   end Matrix_Input;

   procedure Matrix_Output (A: in Matrix) is
   begin
      for i in 1..N loop
         for j in 1..N loop
            Put(A(i)(j));
         end loop;
         New_Line;
      end loop;
      New_Line;
   end Matrix_Output;

   function Func1(A,B,C: in Vector; MA,ME: in Matrix) return Integer is
      Z_Sum, O_Sum, U_Mult: Vector;
      MK: Matrix;
      d: Integer;
   begin
      O_Sum:= Sum_Vector(A,B);
      Z_Sum:= Sum_Vector(O_Sum,C);
      MK:= Matrix_Multiplication(MA,ME);
      U_Mult:= Vector_Matrix_Multiplication(Z_Sum,MK);
      d:= Max_of_Vector(U_Mult);
      return d;
   end Func1;

   function Func2(MH,MK,ML: in Matrix) return Integer is
      MF: Matrix;
      MQ: Matrix;
      q: Integer;
   begin
      MF:= Matrix_Multiplication(MH,MK);
      MQ:= Matrix_Sub(MF, ML);
      q:= Max_of_Matrix(MQ);
      return q;
   end Func2;

   function Func3(P: out Vector; MR,MT: in Matrix) return Vector is
      O: Vector;
      MG: Matrix;
   begin
      Vector_Sort(P);
      MG:= Matrix_Multiplication(MR,MT);
      O:= Vector_Matrix_Multiplication(P,MG);
      return O;
   end Func3;

end data;
