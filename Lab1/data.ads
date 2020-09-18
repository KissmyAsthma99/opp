generic
   N: Integer;
package data is
   type Vector is private;
   type Matrix is private;

   function Func1(A,B,C: in Vector; MA,ME: in Matrix) return Vector;
   function Func2(MF,MG,MH: in Matrix) return Matrix;
   function Func3(O,P: in Vector; MP,MS: in Matrix) return Vector;

   function Matrix_Multiplication(A,B: in Matrix) return Matrix;
   function Sum_Vector(A,B: in Vector) return Vector;
   function Vector_Matrix_Multiplication(A: in Vector; B: in Matrix) return Vector;

   procedure Matrix_Sort(A: in out Matrix);
   function Matrix_Add(A,B: in Matrix) return Matrix;

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
