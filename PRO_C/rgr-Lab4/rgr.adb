GNAT Community 2020 (20200818-93)
Copyright 1992-2020, Free Software Foundation, I
Cling: src\lab1.adb
Se file time stamp: 2021-05-20 11:40:26
Cled at: 2021-05-20 14:41
1. -- RGR. Ada 
2. -- A = (B*C)*(Z*MM)+D*(MX*MR)
3. -- 
4. -- Date 
5. with Ada.Integer_Text_IO, Ada.Text_IO;
6. use Ada.Integer_Text_IO, Ada.Text_IO;
7. procedure Lab1 is
8.    N: Integer:=2400;
9.    P: Integer:=4;
10.    H: Integer:=N/P;
11.    type Vector_All is array(Integer range <>) of Integer;
12.    subtype Vector is Vector_All(1..N);
13.    subtype VectorH is Vector_All(1..1*H);
14.    subtype Vector2H is Vector_All(1..2*H);
15.    subtype Vector3H is Vector_All(1..3*H);
16.    type Matrix_All is array(Integer range <>) of Vector;
17.    subtype Matrix is Matrix_All(1..N);
18.    subtype MatrixH is Matrix_All(1..1*H);
19.    subtype Matrix2H is Matrix_All(1..2*H);
20.    subtype Matrix3H is Matrix_All(1..3*H);
21.    -----Procedure for Input Vector-----
22.    procedure VectorInput(V: out Vector) is
23.    begin
24.       for i in 1..N loop
25.          V(i) := 1;
26.       end loop;
27.    end VectorInput;
28.    -----Procedure for Input Matrix-----
29.    procedure MatrixInput(M: out Matrix) is
30.    begin
31.       for i in 1..N loop
32.          for j in 1..N loop
33.             M(i)(j) := 1;
34.          end loop;
35.       end loop;
36.    end MatrixInput;
37.    -----Procedure for Output Vector-----
38.    procedure VectorOutput(V: in Vector; str: in String) is
39.    begin
40.       Put("Vector " & str & ":");
41.       for i in 1..N loop
42.          put(V(i));
43.          Put_Line(" ");
44.       end loop;
45.       Put_Line("");
46.    end VectorOutput;
47.    -----Procedure of calculation AH = a*K+DH*(MX*MRH)-----
48.    procedure Calculate(a : Integer; DH : VectorH; K : Vector; MX : Matrix; MRH : MatrixH;  AH : out VectorH) is
49.       sum1 : Integer;
50.    begin
51.       for i in 1..H loop
52.          for j in 1..N loop
53.             sum1 := 0;
54.             for k in 1..N loop
55.                sum1 := sum1 + MX(k)(j) * MRH(i)(k);
56.             end loop;
57.             -----calculation AH-----
58.             AH(i) := a * K(j) + DH(i) * sum1;
59.          end loop;
60.       end loop;
61.    end Calculate;
62.    procedure tasksProcedure is
63.       ------------------------------Specification Task 1------------------------------
64.       task T1 is
65.          pragma Storage_Size(3000000000);
66.          entry DataT4T1(VH : VectorH; MH : MatrixH); -- CH MRH
67.          entry DataT3T1(V : Vector; VH : VectorH);
68.          entry DataT2T1(MX : Matrix; MMH : MatrixH);
69.          entry T4KT1(V4H : Vector);
70.          entry T3KT1(V3H : Vector3H);
71.          entry T2KT1(V2H : Vector2H);
72.          entry T1a(a : Integer);
73.          entry T2AH(resAH : VectorH);
74.          entry T3AH(res2AH : VectorH);
75.          entry T4AH(res3AH : VectorH);
76.       end T1;
77.       ------------------------------Specification Task 2-----------------------
78.       task T2 is
79.          pragma Storage_Size(3000000000);
80.          entry DataT4T2(VH : VectorH; MH : MatrixH); -- CH MRH
81.          entry DataT3T2(V : Vector; VH : VectorH);
82.          entry DataT1T2(VH : VectorH);
83.          entry T4KT2(V4H : Vector4H);
84.          entry T3KT2(V3H : Vector3H);
85.          entry T1KT2(VH : VectorH);
86.          entry T2a(a : Integer);
87.          entry a1T2(a1 : Integer);
88.       end T2;
89.       ------------------------------Specification Task 3---------------------
90.       task T3 is
91.          pragma Storage_Size(3000000000);
92.          entry DataT4T3(VH : VectorH; MH : MatrixH); -- CH MRH
93.          entry DataT2T3(M : Matrix; MMH : MatrixH);
94.          entry DataT1T3(V : Vector);
95.          entry T4KT3(V4H : Vector4H);
96.          entry T2KT3(V2H : Vector2H);
97.          entry T1KT3(VH : VectorH);
98.          entry a2T3(a2 : Integer);
99.          entry a4T3(a4 : Integer);
100.       end T3;
101.       ------------------------------Specification Task 4----------------------
102.       task T4 is
103.          pragma Storage_Size(3000000000);
104.          entry DataT3T4(V : Vector; VH : VectorH); -- CH MRH
105.          entry DataT2T4(M : Matrix; MMH : MatrixH);
106.          entry DataT1T4(VH : VectorH);
107.          entry T3KT4(V3H : Vector3H);
108.          entry T2KT4(V2H : Vector2H);
109.          entry T1KT4(VH : VectorH);
110.          entry a3T4(a3 : Integer);
111.          entry T4a(a : Integer);
112.       end T4;
113.       ------------------------------Task 1------------------------------
114.       task body T1 is
115.          a1, resa : Integer;
116.          B, Z, A, resk: Vector;
117.          MXH, MMH, MRH : MatrixH;
118.          DH, BH, CH, KH, AH : VectorH; K2H : VactorH;
119.       begin
120.          Put_Line("T1 started.");
121.          VectorInput(B);
122.          ----------------------passing BH to T2---------------------
123.          T2.DataT1T2(B(H+1..2*H));
124.          ----------------------passing BH to T3---------------------
125.          T3.DataT1T3(B(2*H+1..3*H));
126.          ----------------------passing BH to T4---------------------
127.          T4.DataT1T4(B(3*H+1..N));
128.          ----------------------get MXH, MMH ot T2-----------------------
129.          accept DataT2T1 (M : Matrix; MMH : MatrixH) do
130.             MX := M;
131.             MMH := MMH;
132.          end DataT2T1;
133.          ----------------------get Z, DH ot T3-----------------------
134.          accept DataT3T1 (V : in Vector; VH : in VectorH) do
135.             Z := V;
136.             DH := VH;
137.          end DataT3T1;
138.          ----------------------get CH, MRH ot T4-----------------------
139.          accept DataT4T1 (VH : in VectorH; MH : in MatrixH) do
140.             CH := VH;
141.             MRH := MH;
142.          end DataT4T1;
143.          ----------------------calculation a1 = BH * CH----------------------
144.          a1 := 0;
145.          for i in 1..H loop
146.             a1 := a1 + BH(i) * CH(i);
147.          end loop;
148.          ------------------passing a1 to T2----------------------------------
149.          T2.a1T2(a1);
150.          ----------------------------get a ot T3-----------------------------
151.          accept T1a (a : in Integer) do
152.             resa := a;
153.          end T1a;
154.          -----------------calculation KH = (Z*MMH)------------------
155.          for i in 1..H loop
156.             for j in 1..N loop
157.                KH := Z(j)*MMH(i)(j);
158.             end loop;
159.          end loop;
160.          -------------------passing KH to T2, T3, T4-------------------------
161.          T2.T1KT2(KH);
162.          T3.T1KT3(KH);
163.          T4.T1KT4(KH);
164.          ----------------------get KH ot T2----------------------------------
165.          accept T2KT1 (V2H : in Vector2H) do
166.             KH:=V2H;
167.             
168.          end T2KT1;
169.          ----------------------get KH ot T3----------------------------------
170.          accept T3KT1 (V3H : in Vector3H) do
171.             K2H:=V3H;
172.             KH := K2H;
173.          end T3KT1;
174.          ----------------------get KH ot T4----------------------------------
175.          accept T4KT1 (V4H : in Vector_All) do
176.             K4H := V4H;
177.             resk := KH;
178.          end T4KT1;
179.          ----------------------calculation AH = K + a*EH*x-------------------
180.          Calculate(a  => resa, DH => DH, MX => MX, MRH => MRH, K  => resk, AH => AH);
181.          ----------------------get AH ot T2---------------------------------
182.          accept T2AH (resAH : in VectorH) do
183.             A(1..H) := AH;
184.             A(H+1..2*H) := resAH;
185.          end T2AH;
186.          accept T3AH (res2AH : in VectorH) do
187.             A(1..H) := AH;
188.             A(2*H+1..3*H) := res2AH;
189.          end T3AH;
190.          accept T4AH (res3AH : in VectorH) do
191.             A(1..H) := AH;
192.             A(3*H+1..N) := res3AH;
193.          end T4AH;
194.          ---------------------print A----------------------------------------
195.          if (N<10) then
196.             delay(0.5);
197.             VectorOutput(A, "A");
198.          end if;
199.          Put_Line("T1 finished.");
200.       end T1;
201.       ---------------------------------Task 2------------------------------------
202.       task body T2 is
203.          a2, resa : Integer;
204.          DH, BH, CH, KH : VectorH;
205.          K2H : Vector2H;
206.          Z, resk : Vector;
207.          MX, MM : Matrix;
208.          MRH : MatrixH;
209.       begin
210.          Put_Line("T2 started.");
211.          ----------------------------Enter MX, MM----------------------------
212.          MatrixInput(MX);
213.          MatrixInput(MM);
214.          ----------------------passing MX, MMH to T1---------------------
215.          T1.DataT2T1(MX, MMH(2*H+1..3*H));
216.          ----------------------passing MX, MMH to T3---------------------
217.          T3.DataT2T3(MX, MMH(2*H+1..3*H));
218.          ----------------------passing MX, MMH to T4---------------------
219.          T4.DataT2T4(MX, MMH(2*H+1..3*H));
220.          -----------------get B, Z, DH, CH, MRH ot T1, T3, T4-----------------
221.          accept DataT1T2 (VH : in VectorH) do
222.             BH := VH;
223.          end DataT1T2;
224.          accept DataT3T2 (V : in Vector; VH : in VectorH) do
225.             Z := V;
226.             DH := VH;
227.          end DataT3T2;
228.          accept DataT4T2 (VH : in VectorH; MH : in MatrixH) do
229.             CH := VH;
230.             MRH := MH;
231.          end DataT4T2;
232.          ----------------------calculation a2 = BH * CH----------------------
233.          a2 := 0;
234.          for i in H+1..2*H loop
235.             a2 := a2 + BH(i) * CH(i);
236.          end loop;
237.          -------------accept a1 ot T1 and calculation a2 = a2 + a1-----------
238.          accept a1T2 (a1 : in Integer) do
239.             a2 := a2 + a1;
240.          end a1T2;
241.          ------------------------passing a2 to T3----------------------------
242.          T3.a2T3(a2);
243.          ----------------------------get a ot T3-----------------------------
244.          accept T2a (a : in Integer) do
245.             resa := a;
246.          end T2a;
247.          -----------------calculation KH = (Z*MMH)------------------
248.          for i in H+1..2*H loop
249.             for j in 1..N loop
250.                KH := Z(j)*MMH(i)(j);
251.             end loop;
252.          end loop;
253.          ----------------------passing KH to T4------------------------------
254.          T1.T2KT1(K2H);
255.          T3.T2KT3(K2H);
256.          T4.T2KT4(K2H);
257.          ----------------------get KH ot T2----------------------------------
258.          accept T1KT2 (VH : in VectorH) do
259.             KH:=VH;
260.             KH := K2H;
261.          end T1KT2;
262.          accept T3KT2 (V3H : in Vector3H) do
263.             KH := V3H;
264.             resk := KH;
265.          end T3KT2;
266.          accept T4KT2 (V4H : in Vector) do
267.             K2H := V4H;
268.             resk := K2H;
269.          end T4KT2;
270.          -------------------calculation AH = a*K+DH*(MX*MRH)------------------
271.          Calculate(a  => resa, DH => DH, MX => MX, MRH => MRH, K  => K, AH => AH);
272.          --------------------------passing AH to T1-------------------------
273.          T1.T2AH(AH);
274.          Put_Line("T2 finished.");
275.       end T2;
276.       ----------------------Task 3-------------------------
277.       task body T3 is
278.          x, a3, resa : Integer;
279.          D, Z, resk: Vector;
280.          MM, MRH, MX : Matrix;
281.          AH, KH, KH2 : VectorH;
282.          K2H : Vector2H; K3H : Vector3H;
283.          CH, BH, D3H : Vector3H;
284.       begin
285.          Put_Line("T3 started.");
286.          ----------------------------Enter MX, MM----------------------------
287.          VectorInput(Z);
288.          VectorInput(D);
289.          ----------------------passing MX, MMH to T1---------------------
290.          T1.DataT2T1(Z, DH(3*H+1..N));
291.          ----------------------passing MX, MMH to T3---------------------
292.          T3.DataT2T3(MX, MMH(3*H+1..N));
293.          ----------------------passing MX, MMH to T4---------------------
294.          T4.DataT2T4(MX, MMH(3*H+1..N));
295.          -----------------get B, Z, DH, CH, MRH ot T1, T3, T4-----------------
296.          accept DataT1T3 (VH : in VectorH) do
297.             BH := VH;
298.          end DataT1T3;
299.          accept DataT2T3 (V : in Vector; VH : in VectorH) do
300.             Z := V;
301.             DH := VH;
302.          end DataT2T3;
303.          accept DataT4T3 (VH : in VectorH; MH : in MatrixH) do
304.             CH := VH;
305.             MRH := MH;
306.          end DataT4T3;
307.          ----------------------calculation a2 = BH * CH----------------------
308.          a3 := 0;
309.          for i in 3*H+1..N loop
310.             a3 := a3 + BH(i) * CH(i);
311.          end loop;
312.          ------------------------passing a3 to T4----------------------------
313.          T4.a3T4(a3);
314.          -----------accept a2 ot T2 and calculation a3 = a3 + a2------------
315.          accept a4T3 (a4 : in Integer) do
316.             a3 := a2 + a4;
317.          end a4T3;
318.          resa := a3;
319.          ----------------------pass a to T1, T2, T4--------------------------
320.          T1.T1a(resa);
321.          T2.T2a(resa);
322.          T4.T4a(resa);
323.          -----------------calculation KH = (Z*MMH)------------------
324.          for i in 2*H+1..3*H loop
325.             for j in 1..N loop
326.                KH := Z(j)*MMH(j)(i);
327.             end loop;
328.          end loop;
329.          -----------------   get H ot T1, T2, T3      -----------------
330.          accept T1KT3 (VH : in VectorH) do
331.             KH:=VH;
332.             KH:=K3H;
333.          end T1KT3;
334.          accept T2KT3 (V2H : in Vector2H) do
335.             K3H:= V2H;
336.          end T2KT3;
337.          accept T4KT3 (V4H : in Vector) do
338.             K3H := V4H;
339.             resk:=K3H;
340.          end T4KT3;
341.          -------------------calculation AH = a*K+DH*(MX*MRH)------------------
342.          Calculate(a  => resa, DH => DH, MX => MX, MRH => MRH, K  => K, AH => AH);
343.          --------------------------passing A2H to T1-------------------------
344.          T1.T3AH(AH);
345.          Put_Line("T3 finished.");
346.       end T3;
347.       ------------------------------Task 4------------------------------
348.       task body T4 is
349.          resa, a4: Integer;
350.          E, B, C, D, resk : Vector;
351.          ME : Matrix;
352.          AH, KH, KH4 : VectorH;
353.          K2H : Vector2H; K3H : Vector3H;
354.          MMH : MatrixH;
355.       begin
356.          Put_Line("T4 started.");
357.          --------------------------Input C, MR--------------------------
358.          VectorInput(C);
359.          MatrixInput(MR);
360.          ----------------passing CH, MRH to T1, T2, T3, T4------------------
361.          T4.DataT2T4(CH, MRH(3*H+1..N));
362.          T1.DataT4T1(CH, MRH);
363.          T2.DataT4T2(CH, MRH);
364.          T3.DataT4T3(CH, MRH);
365.          -----------------get B, Z, DH, CH, MRH ot T1, T3, T4-----------------
366.          accept DataT1T4 (VH : in VectorH) do
367.             BH := VH;
368.          end DataT1T4;
369.          accept DataT2T4 (M : in Matrix; MMH : in MatrixH) do
370.             MX := M;
371.             MMH := MH;
372.          end DataT2T4;
373.          accept DataT3T4 (V : in Vector; VH : VectorH) do
374.             Z := V;
375.             DH := VH;
376.          end DataT3T4;
377.          ----------------------calculation a4 = BH * CH-----------------------
378.          a4 := 0;
379.          for i in 3*H+1..N loop
380.             a4 := a4 + BH(i) * CH(i);
381.          end loop;
382.          ---------------------accept a3 ot T3-------------------------------
383.          accept a3T4 (a3 : in Integer) do
384.             a4 := a4 + a3;
385.          end a3T4;
386.          ------------------------passing a4 to T3-----------------------------
387.          T3.a4T3(a);
388.          accept T4a (a : in Integer) do
389.             resa := a;
390.          end T4a;
391.          -----------------calculation KH = (Z*MMH)------------------
392.          for i in 3*H+1..N loop
393.             for j in 1..N loop
394.                KH4 := Z(j)*MMH(j)(i);
395.             end loop;
396.          end loop;
397.          -----------------  pass K to T1, T2, T3         -----------------
398.          T1.T4KT1(KH4);
399.          T2.T4KT2(KH4);
400.          T3.T4KT3(KH4);
401.          -----------------   get KH ot T1, T2, T3      -----------------
402.          accept T1KT4 (VH : in VectorH) do
403.             KH:=VH;
404.          end T1KT4;
405.          accept T2KT4 (V2H : in Vector2H) do
406.             KH2:= V2H;
407.          end T2KT4;
408.          accept T3KT4 (V3H : in Vector3H) do
409.             KH4 := V3H;
410.             resk:=KH4;
411.          end T3KT4;
412.          -------------------calculation AH = a*K+DH*(MX*MRH)------------------
413.          Calculate(a  => resa, DH => DH, MX => MX, MRH => MRH, K  => K, AH => AH);
414.          --------------------------passing AH to T1-------------------------
415.          T1.T3AH(AH);
416.          Put_Line("T4 finished.");
417.       end T4;
418.    begin
419.       Put_Line("");
420.    end tasksProcedure;
421. begin
422.    Put_Line("Lab4 started.");
423.    New_Line;
424.    tasksProcedure;
425.    Put_Line("Lab4 finished.");
426.    New_Line;
427. end Lab1;

 427 lines: 49 errors, 7 warnings
