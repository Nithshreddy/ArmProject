    AREA   appcode,CODE,READONLY 
    IMPORT printMsg
    EXPORT __main 
    ENTRY

__main FUNCTION
 

 
        VLDR.F32 s15,=5.0; our radius 10
		VLDR.F32 s22,= 0.005;
		VLDR.F32 s23,= 1;incrementing angle in degrees
        VLDR.F32 s25,= 100
		VLDR.F32 s18,=50; center X
		VLDR.F32 s19,=50;  center Y
		VLDR.F32 s21,=0.0; to store value
	    MOV R8,#1;
        MOV R9,#4;		
loop3   VLDR.F32 s12,=0.0; angle in degrees
        
        MOV R6,#360;
		VLDR.F32 s13,=3.14; pi value 
		VLDR.F32 s14,=180.0;  
loop2	VMUL.F32 s21,s12,s13;
		VDIV.F32 s0,s21,s14; angle in radians
        BL Sine
        BL Cosine
 
							  
		

	
	    
		VMUL.F32 s16,s2,s15; rsin
		VMUL.F32 s17,s10,s15; rcos
        VADD.F32 s16,s16,s19; x+rsin
     	VADD.F32 s17,s17,s18;  y+rcos
		VMUL.F32 s17,s17,s25;
		VMUL.F32 s16,s16,s25;
		VMOV.F32 R0,s17;   moving new X into a register 
		VMOV.F32 R1,s16;   moving new Y into a register
		
		BL printMsg;
		VADD.F32 s12,s12,s23;  adding angle in s12 with s23 which is 1
		VADD.F32 s15,s15,s22; INCREMENTING radius
		SUB R6,R6,#1;      decrementing R6 till it becomes 0
		CMP R6,#0;
		
		BNE loop2;
		ADD R8,#1
		CMP R8,R9
		
		BLT loop3
		
stop    B stop;                  
        ENDFUNC
Sine  FUNCTION		
		;Sine series :                          	    
		MOV R4,#10;          This will be our max no. of terms 
		VMOV.F32 s7,#1.0;    For our count i we take help of S7
		VMOV.F32 s1,s0;      Intermediate element value x and moved in S1
		VMOV.F32 s2,s0;      S2 will have our sum of these elements
		VMOV.F32 s6,#-1.0;   constant value used in Sine
		VMOV.F32 s8,#2.0;    constant value
		VMOV.F32 s9,#1.0;    constant value to help calculate further
		
	

Sineloop	VMUL.F32 s3,s1,s6;  Multiplying t with -1 s3
		VMUL.F32 s3,s3,s0;  Further multiplying with our x and storing in S3
		VMUL.F32 s3,s3,s0;  Basically squaring the same(t*(-1)*x*x) s3 =-x^3
		VMUL.F32 s4,s7,s8;  For Sine expansion we do i*2 and storing in S4
		VADD.F32 s5,s4,s9;  Adding 1 i.e. 2*i+1 and storing in S5
		VMUL.F32 s4,s4,s5;  Multiplying S4&S5 i.e. (2*i*(2*i+1) and storing in S4
		VDIV.F32 s1,s3,s4;  Dividing our S3 with S4 to get another intermediate value    
		VADD.F32 s2,s2,s1;  Adding our next intermediate element to sum
		VADD.F32 s7,s7,s9;  Incrementing our count by 1
		
		SUB R4,R4,#1;
		CMP R4,#0;                           Output is in S2
		BNE Sineloop
		BX LR
		ENDFUNC
Cosine FUNCTION		
		;Cos series: 		
		 
		MOV R4,#10;       No of terms  
		VMOV.F32 s7,#1.0;  Count i in S7
		VMOV.F32 s1,#1.0;  Intermediate element t in S1
		VMOV.F32 s10,#1.0; sum in S10
		
		
Cosloop	VMUL.F32 s3,s1,s6;    Mult. t with -1
		    VMUL.F32 s3,s3,s0;    Mult with angle x
		    VMUL.F32 s3,s3,s0;    once again i.e. squaring (t*(-1)*x*x)
		    VMUL.F32 s4,s7,s8;    To get the denominator 2*i
		    VSUB.F32 s5,s4,s9;    decreaSineg by 1 i.e. 2*i-1
		    VMUL.F32 s4,s4,s5;    Final denominator (2*i*(2*i-1)
		    VDIV.F32 s1,s3,s4;    We keep our intermediate element expression into t
		    VADD.F32 s10,s10,s1;  Adding to our sum & S10 will hold final output
		    VADD.F32 s7,s7,s9;    Count i is incremented 
		
		SUB R4,R4,#1;         
		CMP R4,#0;               Looping again by checking if zero or not
		BNE Cosloop
		BX LR
		ENDFUNC                     
        END