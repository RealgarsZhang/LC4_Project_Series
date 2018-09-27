#include <stdio.h>
#include "token.h"
#include <string.h>
#include <assert.h>
#include <stdlib.h>

struct nn{
	struct nn* lastIf;
    int hasElseAppeared;
    int ifLabel;     };

typedef struct nn ifStruct;


void pushValue(int value,FILE* fpw){
	unsigned short int  inputValue=value;
	fprintf(fpw,"ADD R6,R6,-1\n");
	fprintf(fpw,"CONST R0,0x%x\n",inputValue&0xFF);
	fprintf(fpw,"HICONST R0,0x%x\n",inputValue>>8);
	fprintf(fpw, "STR R0,R6,#0\n");

}

void arithOperation(char* str,FILE* fpw){
	if (strcmp(str,"+")==0){
		fprintf(fpw, "LDR R0,R6,#0\n");//load the top
		fprintf(fpw, "LDR R1,R6,#1\n");// load the second
		fprintf(fpw, "ADD R0,R1,R0\n");//do the arith and store the result in R0
		fprintf(fpw, "ADD R6,R6,#1\n");//move R6 down
		fprintf(fpw, "STR R0,R6,#0\n");//store the result in the addr of R6
	}

    if (strcmp(str,"-")==0){
		fprintf(fpw, "LDR R0,R6,#0\n");//load the top
		fprintf(fpw, "LDR R1,R6,#1\n");// load the second
		fprintf(fpw, "SUB R0,R0,R1\n");//do the arith and store the result in R0
		fprintf(fpw, "ADD R6,R6,#1\n");//move R6 down
		fprintf(fpw, "STR R0,R6,#0\n");//store the result in the addr of R6
	}

    if (strcmp(str,"*")==0){
		fprintf(fpw, "LDR R0,R6,#0\n");//load the top
		fprintf(fpw, "LDR R1,R6,#1\n");// load the second
		fprintf(fpw, "MUL R0,R0,R1\n");//do the arith and store the result in R0
		fprintf(fpw, "ADD R6,R6,#1\n");//move R6 down
		fprintf(fpw, "STR R0,R6,#0\n");//store the result in the addr of R6
	}
  
    if (strcmp(str,"/")==0){
		fprintf(fpw, "LDR R0,R6,#0\n");//load the top
		fprintf(fpw, "LDR R1,R6,#1\n");// load the second
		fprintf(fpw, "DIV R0,R0,R1\n");//do the arith and store the result in R0
		fprintf(fpw, "ADD R6,R6,#1\n");//move R6 down
		fprintf(fpw, "STR R0,R6,#0\n");//store the result in the addr of R6
	}

	if (strcmp(str,"%")==0){
		fprintf(fpw, "LDR R0,R6,#0\n");//load the top
		fprintf(fpw, "LDR R1,R6,#1\n");// load the second
		fprintf(fpw, "MOD R0,R0,R1\n");//do the arith and store the result in R0
		fprintf(fpw, "ADD R6,R6,#1\n");//move R6 down
		fprintf(fpw, "STR R0,R6,#0\n");//store the result in the addr of R6
	}
}

void comparison(char* str,FILE* fpw,int operationNum){
	if(strcmp(str,"lt")==0){
		fprintf(fpw, "LDR R0,R6,#0\n");//R0 has a
		fprintf(fpw, "LDR R1,R6,#1\n");//R1 holds b
		fprintf(fpw, "CONST R2,#1\n");//let R2 be 1.later it shall hold the result of comparisn
		fprintf(fpw, "CMP R0,R1\n");
		fprintf(fpw, "BRn lt_%d\n",operationNum);  // if true, skip the line following so that R2 is still 1
		fprintf(fpw, "CONST R2,#0\n");
		fprintf(fpw, "lt_%d\n",operationNum);
        fprintf(fpw, "ADD R6,R6,#1\n");//move the stack ptr
        fprintf(fpw, "STR R2,R6,#0\n"); //save the result
	}

    if(strcmp(str,"le")==0){
		fprintf(fpw, "LDR R0,R6,#0\n");//R0 has a
		fprintf(fpw, "LDR R1,R6,#1\n");//R1 holds b
		fprintf(fpw, "CONST R2,#1\n");//let R2 be 1.later it shall hold the result of comparisn
		fprintf(fpw, "CMP R0,R1\n");
		fprintf(fpw, "BRnz le_%d\n",operationNum);  // if true, skip the line following so that R2 is still 1
		fprintf(fpw, "CONST R2,#0\n");
		fprintf(fpw, "le_%d\n",operationNum);
        fprintf(fpw, "ADD R6,R6,#1\n");//move the stack ptr
        fprintf(fpw, "STR R2,R6,#0\n"); //save the result
     
	}

	if(strcmp(str,"eq")==0){
		fprintf(fpw, "LDR R0,R6,#0\n");//R0 has a
		fprintf(fpw, "LDR R1,R6,#1\n");//R1 holds b
		fprintf(fpw, "CONST R2,#1\n");//let R2 be 1.later it shall hold the result of comparisn
		fprintf(fpw, "CMP R0,R1\n");
		fprintf(fpw, "BRz eq_%d\n",operationNum);  // if true, skip the line following so that R2 is still 1
		fprintf(fpw, "CONST R2,#0\n");
		fprintf(fpw, "eq_%d\n",operationNum);  // if true, skip the line following so that R2 is still 1
        fprintf(fpw, "ADD R6,R6,#1\n");//move the stack ptr
        fprintf(fpw, "STR R2,R6,#0\n"); //save the result
	}

	if(strcmp(str,"ge")==0){
		fprintf(fpw, "LDR R0,R6,#0\n");//R0 has a
		fprintf(fpw, "LDR R1,R6,#1\n");//R1 holds b
		fprintf(fpw, "CONST R2,#1\n");//let R2 be 1.later it shall hold the result of comparisn
		fprintf(fpw, "CMP R0,R1\n");
		fprintf(fpw, "BRzp ge_%d\n",operationNum);  // if true, skip the line following so that R2 is still 1
		fprintf(fpw, "CONST R2,#0\n");
		fprintf(fpw, "ge_%d\n",operationNum);
        fprintf(fpw, "ADD R6,R6,#1\n");//move the stack ptr
        fprintf(fpw, "STR R2,R6,#0\n"); //save the result
	}

	if(strcmp(str,"gt")==0){
		fprintf(fpw, "LDR R0,R6,#0\n");//R0 has a
		fprintf(fpw, "LDR R1,R6,#1\n");//R1 holds b
		fprintf(fpw, "CONST R2,#1\n");//let R2 be 1.later it shall hold the result of comparisn
		fprintf(fpw, "CMP R0,R1\n");
		fprintf(fpw, "BRp gt_%d\n",operationNum);  // if true, skip the line following so that R2 is still 1
		fprintf(fpw, "CONST R2,#0\n");
		fprintf(fpw, "gt_%d\n",operationNum); 
        fprintf(fpw, "ADD R6,R6,#1\n");//move the stack ptr
        fprintf(fpw, "STR R2,R6,#0\n"); //save the result
	}
}
void andOr(char* str, FILE* fpw){
	fprintf(fpw, "LDR R0,R6,#0\n");//R0 has a
    fprintf(fpw, "LDR R1,R6,#1\n");//R1 holds b
    fprintf(fpw, "%s R2,R1,R0\n",str);
    fprintf(fpw, "ADD R6,R6,#1\n");//move the stack ptr
    fprintf(fpw, "STR R2,R6,#0\n"); //save the result

}

void logicalNot(FILE* fpw){
	fprintf(fpw, "LDR R0,R6,#0\n");
	fprintf(fpw, "NOT R0,R0\n");
	fprintf(fpw, "STR R0,R6,#0\n");
}

void stackOperation(char* str,FILE* fpw,int operationNum){
	

	if (strcmp(str,"drop")==0){
		fprintf(fpw, "ADD R6,R6,#1\n");
			}

    if (strcmp(str,"dup")==0){
    	fprintf(fpw, "LDR R0,R6,#0\n");
    	fprintf(fpw, "ADD R6,R6,#-1\n");
        fprintf(fpw, "STR R0,R6,#0\n");
    }

    if(strcmp(str,"swap")==0){
    	fprintf(fpw, "LDR R0,R6,#0\n");
    	fprintf(fpw, "LDR R1,R6,#1\n");
    	fprintf(fpw, "STR R0,R6,#1\n");
    	fprintf(fpw, "STR R1,R6,#0\n");
    }

    if(strcmp(str,"max")==0){
    	fprintf(fpw, "LDR R0,R6,#0\n");
    	fprintf(fpw, "LDR R1,R6,#1\n");
    	fprintf(fpw, "ADD R2,R0,#0\n");//Assume R0 is larger and store it in R2

    	fprintf(fpw, "CMP R0,R1\n");//If R0 is not larger ,let R2 be R1
    	fprintf(fpw, "BRzp max_%d\n",operationNum);
    	fprintf(fpw, "ADD R2,R1,#0\n");
    	fprintf(fpw, "max_%d\n",operationNum);
    	fprintf(fpw, "ADD R6,R6,#1\n");
    	fprintf(fpw, "STR R2,R6,#0\n");

    }

    if(strcmp(str,"low8")==0){
    	fprintf(fpw, "LDR R0,R6,#0\n");
    	fprintf(fpw, "CONST R1,0xFF\n");
    	fprintf(fpw, "AND R0,R0,R1\n");
    	fprintf(fpw, "STR R0,R6,#0\n");
    }
}

void argOperation(char *str,FILE* fpw){
	int num;
	sscanf(str,"arg%d",&num);

	fprintf(fpw, "LDR R0,R5,#%d\n",num+2);
	fprintf(fpw, "ADD R6,R6,#-1\n");
	fprintf(fpw, "STR R0,R6,#0\n");
}




   int main(int argc,char** argv){
       
       assert(argc==2); // Here is what I should modify if we accept multiple files.
       char tempStr[200]={0};
       token t;
       int isDefiningFcn=0;
       int isInMain=0;
       int n=0,i=0;
       ifStruct* currentIf=NULL;
       ifStruct* tempIf=NULL;
       int cumulativeIf=0;
       char previousStr[200]=".CODE";
       int operationNum=0;//for the label of a small jump in the furture
      /* int currentIf=0;   //Three variables for labeling of ifs
       int lastIf=0;
       int tempIf=0;*/



       FILE* fpr=fopen(argv[1],"r");
       if(fpr==NULL){printf("Fail to open the file.\n");}

       strcpy(tempStr,argv[1]);
       n=strlen(tempStr);
       tempStr[n-1]=0;
       strcat(tempStr,"asm");
       FILE* fpw=fopen(tempStr,"w");

       strcpy(tempStr,argv[1]);
       n=strlen(tempStr);
       tempStr[n-1]=0;
       tempStr[n-2]=0;

     fprintf(fpw, ".CODE\n");

     while(!feof(fpr)){

     	if(strcmp(t.str,"")!=0){strcpy(previousStr,t.str);}
       	read_token(&t,fpr);
        if(strcmp(t.str,"")==0){t.type=0;}

        //printf("%s %d\n",t.str,t.type);


         /*Token type:  0 for nothing
               1 for number
               2 for for operator
               3 for comparison
               4 for logical except not
               5 for logical not
               6 for stack operations
               7 for arg
               8 for if
               9 for else
               10 for endif
               11 for anything having ;
               12 for defun
               13 for function name
               14 for return
               */
       	if(t.type==1){pushValue(t.literal_value,fpw);}

       	if(t.type==2){arithOperation(t.str,fpw);}

       	if(t.type==3){comparison(t.str,fpw,operationNum);operationNum++;}

       	if(t.type==4){andOr(t.str,fpw);}

       	if(t.type==5){logicalNot(fpw);}

       	if(t.type==6){stackOperation(t.str,fpw,operationNum);operationNum++;}

       	if(t.type==7){argOperation(t.str,fpw);}

       	if(t.type==8){
       		cumulativeIf++;
       		/*lastIf=currentIf;
       		currentIf=cumulativeIf;*/
            tempIf=currentIf;
            currentIf=(ifStruct*)malloc(sizeof(ifStruct));
            currentIf->lastIf=tempIf;
            currentIf->ifLabel=cumulativeIf;
            currentIf->hasElseAppeared=0;

       		fprintf(fpw, "ADD R6,R6,#1\n");
       		fprintf(fpw, "LDR R0,R6,#-1\n");
       		fprintf(fpw, "BRz %s_%d\n",tempStr,2*currentIf->ifLabel-1);//prints the label for else
             
       	}

       	if(t.type==9){
       		currentIf->hasElseAppeared=1;
       		fprintf(fpw, "JMP %s_%d\n", tempStr,2*currentIf->ifLabel);
            fprintf(fpw, "%s_%d\n",tempStr,2*currentIf->ifLabel-1);//prints the label for else
       	}
        
        if(t.type==10){
        	if(currentIf->hasElseAppeared==0){fprintf(fpw, "%s_%d\n",tempStr,2*currentIf->ifLabel-1);}
        	else {fprintf(fpw, "%s_%d\n", tempStr,2*currentIf->ifLabel);}
        	tempIf=currentIf;
        	currentIf=tempIf->lastIf;        //give the control back to the embedding if
        	free(tempIf);               

        }

        if(t.type==12){
        	//fprintf(fpw, ".CODE\n");
        	fprintf(fpw, ".FALIGN\n");
        	isDefiningFcn=1;


        }

       if(t.type==13){
       	
       	if(strcmp(previousStr,"defun")==0) {
       		fprintf(fpw, "%s\n", t.str);
       		fprintf(fpw, "STR R7, R6, #-2\n");
       		fprintf(fpw, "STR R5, R6, #-3\n");
       		fprintf(fpw, "ADD R6, R6, #-3\n");
       		fprintf(fpw, "ADD R5, R6, #0 \n");

       }else{
       	    fprintf(fpw, "LEA R7,%s\n",t.str );
       	    fprintf(fpw, "JSRR R7\n");
            }

       // if(strcmp(t.str,"main")==0){isInMain=1;}

       }

       if(t.type==14){
       	isDefiningFcn=0;
       	fprintf(fpw, "LDR R0, R6, #0\nSTR R0, R5, #2\nADD R6, R5, #0\nADD R6, R6, #2\nLDR R7, R5, #1\nLDR R5, R5, #0\nRET\n");
        isInMain=0;
       }

       }

fclose(fpw);
fclose(fpr);

	return 0;
}