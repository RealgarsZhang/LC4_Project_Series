#include "objectfiles.h"
#include "lc4.h"
#include <stdio.h>
#include <math.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
/*
 * Check that the given file exists.
 * Params: pointer to file, pointer to filename.
 */
void file_check (FILE* file, char *filename){
	file=fopen(filename,"rb");
	if (file==NULL){
		printf("File Not Found\n");
		exit(0);
	}
	fclose(file);
	return ;

}

/*
 * Changes a 4-bit word's endian.
 * Params: int to convert.
 */
int flip_endian (int word){
    return ((word<<16)|(word>>16));

}

unsigned short int short_flip_endian(unsigned short int word){

return ((word<<8)|(word>>8));



}
/*
 * Read an object file and modify the machine state accordingly.
 * Return a zero if successful and a non-zero error code if you encounter a
 * problem.
 * Params: poitner to filename, pointer to current machine state.
 */
int read_object_file (char *filename, machine_state *state){

	int i=0;
    unsigned int j=0;
    unsigned short int word,address,n,temp;
    int sectionIndicator=0;
    int ifJustEnterASection=0;
    int CorDIndicator=0; 
    FILE* fpr;
    file_check(fpr,filename);
    fpr=fopen(filename,"rb");
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

    		state->memory[address+j]=word;
            //printf("n:%x\n",n);
            //printf("j:%d\n\n",j);
    	}
    }
      
    if (sectionIndicator==2){

    	for(j=0;j<n;j++){
    		fread(&word,sizeof(short),1,fpr);
    		word=short_flip_endian(word);

    		state->memory[address+j]=word;

    	}
    }

      }
    
 

    fclose(fpr);  
    return 0;
}
