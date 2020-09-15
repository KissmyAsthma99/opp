generic
   N: Integer;
package data is

   type Vector is private;
   type Matrix is private;

   function Func1(A,B,C: in Vector; MA,ME: in Matrix) return Integer;
   function Func2(MH,MK,ML: in Matrix) return Integer;
   function Func3(P: out Vector; MR,MT: in Matrix) return Vector;

   function Matrix_Multiplication(A,B: in Matrix) return Matrix;
   function Sum_Vector(A,B: in Vector) return Vector;
   function Vector_Matrix_Multiplication(A: in Vector; B: in Matrix) return Vector;
   function Max_of_Vector(A: in Vector) return Integer;

   function Max_of_Matrix(A: in Matrix) return Integer;
   function Matrix_Sub(A,B: in Matrix) return Matrix;

   procedure Vector_Sort(A: in out Vector);

   procedure Vector_Fill_Ones(A: out Vector);
   procedure Matrix_Fill_Ones(A: out Matrix);

   procedure Vector_Input (A: out Vector);  -- fills values of
   procedure Vector_Output (A: in Vector);  -- shows values of

   procedure Matrix_Input (A: out Matrix);
   procedure Matrix_Output (A: in Matrix);

private
   type Vector is array(1..N) of Integer;
   type Matrix is array(1..N) of Vector;

end data;
