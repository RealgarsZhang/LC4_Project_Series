/*
 * CIS 240 HW 9: LC4 Simulator
 * trace.c
 */

#include "lc4.h"
#include "objectfiles.h"
#include <stdio.h>

#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

/*#define IMM_9(I) ((I)&0x1FF)
#define IMM_8(I) ((I)&0x00FF)
#define IMM_7(I) ((I)&0x007F)
#define IMM_4(I) ((I)&0x000F)
#define IMM_5(I) ((I)&0x001F)
#define IMM_6(I) ((I)&0x003F)
#define IMM_11(I) ((I)&0x07FF)
#define INSN_OP(I) ((I)>>12)
#define INSN_15_11(I) ((I)>>11)
#define INSN_15_9(I)((I)>>9)
#define INSN_5_3(I)(((I)&0x0038)>>3)
#define INSN_5_4(I)(((I)&0x0030)>>4)
#define INSN_8_7(I)(((I)&0x0180)>>7)
#define INSN_8_6(I)(((I)&0x01C0)>>6)
#define INSN_11_9(I)(((I)&0x0E00)>>9)
#define INSN_2_0(I)(((I)&0x0007))*/
#define R(I) ((I<<1)>>11)
#define G(I) ((I<<6)>>11)
#define B(I) ((I<<11)>>11)

void printState(machine_state state){
	int j;
  


	printf("PC:%x\n",state.PC );
	printf("PSR:%x\n",state.PSR);
    for(j=0;j<8;j++){printf("R%d:%x\n",j,state.R[j]);}
    printf("\n");
}
int main(int argc, char ** argv)
{ int DISPLAY_LENGTH=124*128;
  int COL=128;
  int ROW=124;
  unsigned char ImgPutter;








  unsigned short int tempPC;
  int crusher=0;//TODO: Initialize machine state and control signals
  unsigned short int I;
  machine_state state;
  int i=0,kk;
  unsigned int j=0;
  FILE* fpr; //pointer for reading
  FILE* fpw; //pointer for writing
  unsigned short int word,address,n,temp;
  int sectionIndicator=0;
  int ifJustEnterASection=0;
  int CorDIndicator=0;      //Indicating if the current printing is in Data or code.0 for code and 1 for data
  reset(&state);
  
  fpw=fopen(argv[1],"wb");
  assert(argc>=3);


/*fpr=fopen("public-test_trap_rti_ldr_str.obj","rd");
while(!feof(fpr)){
	word=fgetc(fpr)|(fgetc(fpr)<<8);
printf("%x\n",short_flip_endian(word));
}*/


 for(i=2;i<argc;i++){// a very outer loop to deal with different .obj files
     
    read_object_file(argv[i],&state);
      /*fpr=fopen(argv[i],"rb");
      //reset(&state);// ATTENTION!! ATTENTION!! This reset is imply for milestone!!!!!!!!!!!!!!!!!!!!!!!!!!!
      while(!feof(fpr)){


        fread(&word,sizeof(short),1,fpr);
        
        word=short_flip_endian(word);
        if(word!=0xcade&&word!=0xdada&&word!=0xcade&&word!=0xc387&&word!=0xF17E&&word!=0x715e){break;}
        //printf("%x",word);
        switch(word){
         case 0xcade :

         sectionIndicator=1;
         ifJustEnterASection=1;
         fread(&address,sizeof(short),1,fpr);
         fread(&n,sizeof(short),1,fpr);          //This is data section. Record the addr and n
         address=short_flip_endian(address);
         n=short_flip_endian(n);

         //printf("%x\n",n);
        // printf("%x\n",address);
         break;

         case 0xdada :
         sectionIndicator=2;

         ifJustEnterASection=1;
         fread(&address,sizeof(short),1,fpr);//Similarly
         fread(&n,sizeof(short),1,fpr);
         address=short_flip_endian(address);
         n=short_flip_endian(n);
         break;

         case 0xC387 :
         sectionIndicator=3;
         ifJustEnterASection=0;
         fread(&address,sizeof(short),1,fpr);
         fread(&n,sizeof(short),1,fpr);     //ignore this section by fseek over n bytes
         address=short_flip_endian(address);
         n=short_flip_endian(n);
         fseek(fpr,n,SEEK_CUR);
         break;

         case 0xF17E :
         sectionIndicator=4;         //Similarly.
         ifJustEnterASection=0;
         fread(&n,sizeof(short),1,fpr);
         n=short_flip_endian(n);
         fseek(fpr,n,SEEK_CUR);
         break;

         case 0x715E :
         sectionIndicator=5;  

         ifJustEnterASection=0;
         fseek(fpr,6,SEEK_CUR);
         break;
         
         default:
         ifJustEnterASection=0; 
 

        }
    //printf("%x",word);
   
    if (sectionIndicator==1){
        


        for(j=0;j<n;j++){//type conversion here. Potentially buggy
    		//printf("j:%d\n",j);
    		fread(&word,sizeof(short),1,fpr);
    		word=short_flip_endian(word);

    		state.memory[address+j]=word;
            //printf("n:%x\n",n);
            //printf("j:%d\n\n",j);
    	}
    }
      
    if (sectionIndicator==2){

    	for(j=0;j<n;j++){
    		fread(&word,sizeof(short),1,fpr);
    		word=short_flip_endian(word);

    		state.memory[address+j]=word;

    	}
    }

      }
    
 

    fclose(fpr);*/
  }                                              //Reading process done!!
  // TODO: Read in object files
 /* ifJustEnterASection=0;
  for (j=0;j<65536;j++){
  	if(j==0||j==0x8000||j==0x8100){
  		ifJustEnterASection=1;
  	}
    if(j==0x2000||j==0xA000){
  		ifJustEnterASection=2;
  	}
  	if (ifJustEnterASection==0&&state.memory[j]!=0){
  		printf("memory address: %x = %x\n",j,state.memory[j]);
  	}
  	if(ifJustEnterASection==1&&state.memory[j]!=0){
  		printf("Code:\n");
  		printf("memory address: %x = %x\n",j,state.memory[j]);
        ifJustEnterASection=0;  	
  	}
  	if(ifJustEnterASection==2&&state.memory[j]!=0){
  		printf("Data:\n");
  		printf("memory address: %x = %x\n",j,state.memory[j]);
  	    ifJustEnterASection=0;
  	}
  	
  }*/

	while(state.PC != 0x80FF) {
    //printf("INSN:%x\n",state.memory[state.PC]);
    I=state.memory[state.PC];
    tempPC=state.PC;
    
    

     
    kk=update_state(&state);

    if(kk==0){
    fwrite(&tempPC,sizeof(short),1,fpw);
    fwrite(&I,sizeof(short),1,fpw);
    	
    }
    
    //printState(state);
    if(kk==1){
   		printf("Attempting to execute data as code!\n");
   		break;   
   		crusher=1;                                   // TODO: Simulate LC4
    }

    if(kk==2){
        printf("Attempting to access code as data!\n");
        break;
        crusher=1;
	  
	}

	if(kk==3){
		printf("Attempting to access OS section in user mode!\n");
		break;
		crusher=1;
	}

    }
    if (crusher==0&&kk==0){
    I=state.memory[state.PC];	
    printf("0x%x: ",state.PC);//after making sure this instruction will be executed ,I print it
    printInstr(I);
    
    fwrite(&state.PC,sizeof(short),1,fpw);
    fwrite(&I,sizeof(short),1,fpw);
	printf("Trace completed without error.\n");}
	//for(j=0;j<8;j++){printf("R%d:%x\n",j,state.R[j]);}
	//printState(state);	

//Following is the bonus part


    fclose(fpw);
    fpw=fopen("image.ppm","wb");
    
    fprintf(fpw,"P6\n128 124\n31\n");
    ROW=124;
    COL=128;
    for(i=0;i<ROW;i++)
      for(j=0;j<COL;j++){
        word=state.memory[0xC000+i*COL+j];
        fputc(R(word),fpw);
        fputc(G(word),fpw);
        fputc(B(word),fpw);

      }
     fclose(fpw);
	return 0;
    }

