#include "stm32f4xx.h"
#include <string.h>
#include <stdio.h>

void printMsg(int a,int b)
{
	 float a1=*((float*) &a);
	 float b1=*((float*) &b);
	
	 char Msg1[10];
	 char Msg2[10];
	
	 char *ptr;
	 sprintf(Msg1, "%f , ", a1);
	 
	 ptr = Msg1 ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   
	 }
	 ITM_SendChar(',')	 ;
	 sprintf(Msg2, "%f,/n", b1);
	 ptr = Msg2 ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 ITM_SendChar('\n')	 ;
}