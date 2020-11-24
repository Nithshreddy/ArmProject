	
	AREA appcode, CODE, READONLY
    IMPORT printMsg
	EXPORT __main
	ENTRY

__main FUNCTION
 

 
        VLDR.F32 s15,=11.0; our radius 11
		VLDR.F32 s16,= 1;
		
		VLDR.F32 s12,=0.0; angle in degrees
		VLDR.F32 s18,=50.0; center X
		VLDR.F32 s19,=100.0;  center Y
		VLDR.F32 s21,=0.0; to store value
		
		
		MOV R6,#360;
		VLDR.F32 s13,=3.14; pi value 
		VLDR.F32 s14,=180.0;  
loop2	VMUL.F32 s21,s12,s13;
		VDIV.F32 s0,s21,s14;
 
 
 ;Sine series :                          	    
		MOV R4,#10;          This will be our max no. of terms 
		VMOV.F32 s7,#1.0;    For our count i we take help of S7
		VMOV.F32 s1,s0;      Intermediate element value t and moved in S1
		VMOV.F32 s2,s0;      S2 will have our sum of these elements
		VMOV.F32 s6,#-1.0;   constant value used in Sine
		VMOV.F32 s8,#2.0;    constant value
		VMOV.F32 s9,#1.0;    constant value to help calculate further
		
	

Sineloop	VMUL.F32 s3,s1,s6;  Multiplying t with -1
		VMUL.F32 s3,s3,s0;  Further multiplying with our x and storing in S3
		VMUL.F32 s3,s3,s0;  Basically squaring the same(t*(-1)*x*x) 
		VMUL.F32 s4,s7,s8;  For Sine expansion we do i*2 and storing in S4
		VADD.F32 s5,s4,s9;  Adding 1 i.e. 2*i+1 and storing in S5
		VMUL.F32 s4,s4,s5;  Multiplying S4&S5 i.e. (2*i*(2*i+1) and storing in S4
		VDIV.F32 s1,s3,s4;  Dividing our S3 with S4 to get another intermediate value    
		VADD.F32 s2,s2,s1;  Adding our next intermediate element to sum
		VADD.F32 s7,s7,s9;  Incrementing our count by 1
		
		SUB R4,R4,#1;
		CMP R4,#0;                           Output is in S2
		BNE Sineloop
		                      
							  
		
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
	
	    
		VMUL.F32 s16,s2,s15; y+rsin
		VMUL.F32 s17,s10,s15; x+rcos
        VADD.F32 s16,s16,s19; adding S19 to get centre
     	VADD.F32 s17,s17,s18;  same step
		VMOV.F32 R0,s17;   moving it into a register 
		VMOV.F32 R1,s16; same step
		VMOV.F32 R2,s15;  radius
		VMOV.F32 R3,s12;  angle in degrees
		BL printMsg;
		VADD.F32 s12,s12,s9;  adding angle in s12 with s9 which is 1
		VADD.F32 s15,s15,s16; adding radius
		SUB R6,R6,#1;      decrementing R6 till it becomes 0
		CMP R6,#0;
		BNE loop2;
		
stop    B stop;                  
        ENDFUNC
        END
