#include <stdio.h>
#include <math.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>



struct n {
  
double value;
 
struct n* next;

} ;


typedef struct n NODE;

struct m{

	char  string[120]; // 120 should be sufficient.
    struct m* next;
};

typedef struct m SNODE;


typedef struct {

SNODE* front;
SNODE* rear;

} QUEUE;

int isDigit(char input){
   
if (input>=48&&input<=57){
	return 1;
}
 return 0;
}

int isNumString(const char inputString[]){

 int pointNum=0;
 int i=0;
 int nonDigitTeller=0;
 
 while(inputString[i]){                      //checks if a string can be taken as a number
 	if (inputString[i]=='.'){
 		pointNum++;
 	}
 	if (!isDigit(inputString[i])&&inputString[i]!='.'&&!(i==0&&inputString[i]=='-')&&!(i==0&&inputString[i]=='+')){
      nonDigitTeller=1;
 	}
 	i++;
 }




if (pointNum>1||nonDigitTeller==1||strcmp(inputString,".")==0||strcmp(inputString,"-")==0||strcmp(inputString,"+")==0){
	return 0;
}

return 1;


}


double fabs(double a){
 if (a>=0){
 	return (a);
 }

 return (-a);


}
 
int isWhitespace(char input){
  int n;
  if (input==' '||input=='\n'||input=='\t'){
  	n=1;
  } else {n=0;}

  return (n);


}

void push(NODE** top,double x){
  NODE* temp;
  temp=(NODE*)malloc(sizeof(NODE));           //push an x into the stack 
  temp->value=x;
  temp->next=(*top);
  *top=temp;

  return ;

}

double pop(NODE** top){

  NODE* temp;
  double popValue=0;
  if (*top==NULL){
  	printf("Empty stack!\n");             //return the pop up value. Do the pop
  } else {
    temp=*top;
    *top=(*top)->next;
    popValue=temp->value;
    free(temp);
  }

  return popValue;


}


void dequeue(SNODE** front){
    SNODE* temp;
     if ((*front)==NULL){
     	printf("Empty Queue!\n");
     }else {
     temp=*front;
     *front=(*front)->next;
     free(temp);
     }


}

void enqueue(SNODE** rear,char* inputString){
     SNODE* temp;
     temp=(SNODE*) malloc(sizeof(SNODE));
     strncpy(temp->string,inputString,120);
     temp->next=NULL;
     (*rear)->next=temp;
     *rear=temp;


}


void clearQueue(SNODE* front){

while(front!=NULL){
	dequeue(&front);
}


}


void clearStack(NODE* top){
   
   while (top->next!=NULL){
   pop(&top);
   }
   free(top);

}








int wholePieceNum(char * inputString){            //This function checks how many connected components there are in a string
	                                             // By connected I mean there are no whitespace inside.

int i=0;
int counter=0;

while (inputString[i]){
  if ((inputString[i]==' '||inputString[i]=='\t')&&!isWhitespace(inputString[i+1])){
  	counter++;}
   i++;
}

if(inputString[0]!=' '&&inputString[0]!='\t'){
	counter++;
}
if (inputString[0]=='\n'||strcmp(inputString,"")==0){
    
    counter=0;

}
return(counter);

}





void normalizeString(char* inputString){     // This fcn takes an input string and normalize it into meaningful parts separated by one whitespace
int i=0,k=0;
char tempString[120]={0};

  while(i<118){           // 118 to avoid segmentation fault
    
   if (!isWhitespace(inputString[i])){
   	tempString[k]=inputString[i];
   	k++;
   	if(isWhitespace(inputString[i+1])){
     	tempString[k]=' ';
     	k++;
   	}
    
   	
   }
   i++;

}


if (isWhitespace(tempString[strlen(tempString)-1])){
    tempString[strlen(tempString)-1]=0;

}

strncpy(inputString,tempString,120);


}

int isValidArgument(char inputString[]){
   if (isNumString(inputString)||strcmp(inputString,"+")==0||strcmp(inputString,"-")==0||strcmp(inputString,"*")==0||strcmp(inputString,"/")==0||strcmp(inputString,"sin")==0||strcmp(inputString,"cos")==0||strcmp(inputString,"rand")==0||strcmp(inputString,"sqrt")==0||strcmp(inputString,"pow")==0||strcmp(inputString,"neg")==0||strcmp(inputString,"swap")==0||strcmp(inputString,"pop")==0||strcmp(inputString,"print")==0||strcmp(inputString,"quit")==0){
   	return (1);
   }  else   {return (0);}                                                  



}

int isValidDefinition(char inputString[]){


char tempString[120]={0};//where to place each argument
char dummyString[120]={0};//where to place the rest of the inputString
char tempDummyString[120]={0}; //I am not sure if it is ok to have dummyString both as the input and output


sscanf(inputString,"%s %[^\t\n]",tempString,dummyString);//First check if the first argument is def or append_func
if (strcmp(tempString,"def")!=0&&strcmp(tempString,"append_func")!=0){
    printf("INVALID COMMAND\n");
	return (0);
}

while (wholePieceNum(dummyString)>=2){

  sscanf(dummyString,"%s %[^\t\n]",tempString,tempDummyString);
  strncpy(dummyString,tempDummyString,120);

  if(!isValidArgument(tempString)){
  	printf("INVALID DEF\n");
  	return 0;
  }

}

if (!isValidArgument(dummyString)){
	printf("INVALID DEF\n");
	return 0;
}


return (1);

}

int calculatorOperation(NODE** top,char* inputString,SNODE** front){

double inputNum,result;
NODE* temp;
         // If the input is connected
  
  if (isNumString(inputString)){  

       sscanf(inputString,"%lf",&inputNum);       //buggy, check if something is number                                             // number input
       push(top,inputNum);
       result=inputNum;
       //printf("%lf\n",(*top)->value);

 }
else if (strcmp(inputString,"+")==0){
      
	if ((*top)->next==NULL||(*top)->next->next==NULL){ //assume this complier has short circuit, hopefully.
		printf("STACK ERROR\n");
		return 1;
	}

	result=pop(top);
	result=result+pop(top);
	push(top,result);
	//printf("%lf\n",result);


}

  else if (strcmp(inputString,"-")==0){
     //printf("ever here\n");
	if ((*top)->next==NULL||(*top)->next->next==NULL){
		printf("STACK ERROR\n");
		return 1;
	}

	result=pop(top);
	result=pop(top)-result;
	push(top,result);
	//printf("%lf\n",result);


}

  else if (strcmp(inputString,"*")==0){

	if ((*top)->next==NULL||(*top)->next->next==NULL){
		printf("STACK ERROR\n");
		return 1;
	}

	result=pop(top);
	result=pop(top)*result;
	push(top,result);
	//printf("%lf\n",result);


}

  else if (strcmp(inputString,"/")==0){

	if ((*top)->next==NULL||(*top)->next->next==NULL){
		printf("STACK ERROR\n");
		return 1;
	}
	if (fabs((*top)->next->value-0)<0.0001){

		printf("DENOMINATOR TOO SMALL!");
		return 1;
	}

	result=pop(top);
	result=result/pop(top);
	push(top,result);
	//printf("%lf\n",result);


}


  else if (strcmp(inputString,"sin")==0){

	if ((*top)->next==NULL||(*top)==NULL){
		printf("STACK ERROR\n");
		return 1;
	}
	
	result=pop(top);
	result=sin(result);
	
	push(top,result);
	//printf("%lf\n",result);


}
 
  else if (strcmp(inputString,"cos")==0){

	if ((*top)->next==NULL||(*top)==NULL){
		printf("STACK ERROR\n");
		return 1;
	}
	
	result=pop(top);
	result=cos(result);
	push(top,result);
	//printf("%lf\n",result);


}

 else if (strcmp(inputString,"rand")==0){
    result= 1.0*rand()/RAND_MAX;
    push(top,result);
	//printf("%lf\n",result);

}


 else if (strcmp(inputString,"sqrt")==0){

	if ((*top)->next==NULL||(*top)==NULL){
		printf("STACK ERROR\n");
		return 1;
	}
	if ((*top)->value<0){
		printf("Negative Operand!\n");
		return 1;
	}



	result=pop(top);
	result=sqrt(result);
	
	push(top,result);
	//printf("%lf\n",result);


}

 else if (strcmp(inputString,"pow")==0){

	if ((*top)->next->next==NULL||(*top)->next==NULL){
		printf("STACK ERROR\n");
		return 1;
	}

	result=pop(top);
	result=pow(pop(top),result);
	push(top,result);
	//printf("%lf\n",result);


}

 else if (strcmp(inputString,"neg")==0){

   if ((*top)->next==NULL||(*top)==NULL){
		printf("STACK ERROR\n");
		return 1;
	}


  result=-(*top)->value;
  (*top)->value=result;
 // printf("%lf\n",result);

}

 else if (strcmp(inputString,"swap")==0){

	if ((*top)->next==NULL||(*top)->next->next==NULL){
		printf("STACK ERROR\n");
		return 1;
	}

	result=(*top)->value;                 //here a better name for result is temp, to swap two values
	(*top)->value=(*top)->next->value;
	(*top)->next->value=result;
	result=(*top)->value;                    // Should I out put the result of swap and pop in function call?
	//printf("%lf\n",result);


}

 


 else if (strcmp(inputString,"pop")==0){

	if ((*top)->next==NULL||(*top)==NULL){
		printf("STACK ERROR\n");
		return 1;
	}

	pop(top);
	result=(*top)->value;
	if ((*top)->next!=NULL){
	printf("%lf\n",result);}



}


 else  if (strcmp(inputString,"print")==0){
    temp=(*top);
    if (temp->next==NULL){
    	printf("STACK ERROR\n");
		return 1;
    }    
    
    while(temp->next!=NULL){
        printf("%lf\n",temp->value);
        temp=temp->next;
    }


   }

  else if (strcmp(inputString,"quit")==0){
    clearStack(*top);
    clearQueue(*front);
    return 2;


   }




return 0;

}




int main(){
int i,breaker=0;

int existsDigit=0;
int isFunctionDefined=0;
double inputNum,result;
char inputString[120]={0};
char dummyString[120]={0};//This stores the rest of the input string
char tempDummyString[120]={0};
char tempString[120]={0};
char functionString[120]={0};
SNODE* tempPtr;
SNODE* front;
SNODE* rear; //remember to initialize!
front=NULL;
rear=NULL;

NODE* top;
NODE* temp;
top=(NODE*)malloc(sizeof(NODE));  //initialize the stack
top->next=NULL;
top->value=0;               //Force the num at the bottom to be 0;


/*fgets(inputString,120,stdin);
normalizeString(inputString);
printf("%s",inputString);*/

while(1) {

fgets(inputString,120,stdin); 
//get the input until a backslash n. 
normalizeString(inputString);//Make the inputString with many whitespaces into the form where meaningful components are separated by one ' '





existsDigit=0;
i=0;
while(inputString[i]){
	inputString[i]=tolower(inputString[i]);
	
                                                     //Cleaning the input, tolower then check whether there is any white space or digit
    
    if (isDigit(inputString[i])){
    	existsDigit=1;

    }
    i++;
}

//Here , for second part , I should consider more checking on the inputString.
//Now I only write the first part and leave further checking next.
if (wholePieceNum(inputString)<=1){          // If the input is connected
     
  if (existsDigit==1&&isNumString(inputString)){  

       sscanf(inputString,"%lf",&inputNum);       //buggy, check if something is number                                             // number input
       push(&top,inputNum);
       printf("%lf\n",top->value);

 }
else if (strcmp(inputString,"+")==0){
      
	if (top->next==NULL||top->next->next==NULL){ //assume this complier has short circuit, hopefully.
		printf("STACK ERROR\n");
		continue;
	}

	result=pop(&top);
	result=result+pop(&top);
	push(&top,result);
	printf("%lf\n",result);


}

  else if (strcmp(inputString,"-")==0){

	if (top->next==NULL||top->next->next==NULL){
		printf("STACK ERROR\n");
		continue;
	}

	result=pop(&top);
	result=pop(&top)-result;
	push(&top,result);
	printf("%lf\n",result);


}

  else if (strcmp(inputString,"*")==0){

	if (top->next==NULL||top->next->next==NULL){
		printf("STACK ERROR\n");
		continue;
	}

	result=pop(&top);
	result=pop(&top)*result;
	push(&top,result);
	printf("%lf\n",result);


}

  else if (strcmp(inputString,"/")==0){

	if (top->next==NULL||top->next->next==NULL){
		printf("STACK ERROR\n");
		continue;
	}
	if (fabs(top->next->value-0)<0.0001){

		printf("DENOMINATOR TOO SMALL!");
		continue;
	}

	result=pop(&top);
	result=result/pop(&top);
	push(&top,result);
	printf("%lf\n",result);


}


  else if (strcmp(inputString,"sin")==0){

	if (top->next==NULL||top==NULL){
		printf("STACK ERROR\n");
		continue;
	}
	
	result=pop(&top);
	result=sin(result);
	
	push(&top,result);
	printf("%lf\n",result);


}
 
  else if (strcmp(inputString,"cos")==0){

	if (top->next==NULL||top==NULL){
		printf("STACK ERROR\n");
		continue;
	}
	
	result=pop(&top);
	result=cos(result);
	push(&top,result);
	printf("%lf\n",result);


}

 else if (strcmp(inputString,"rand")==0){
    result= 1.0*rand()/RAND_MAX;
    push(&top,result);
	printf("%lf\n",result);

}


 else if (strcmp(inputString,"sqrt")==0){

	if (top->next==NULL||top==NULL){
		printf("STACK ERROR\n");
		continue;
	}
	if (top->value<0){
		printf("Negative Operand!\n");
		continue;
	}



	result=pop(&top);
	result=sqrt(result);
	
	push(&top,result);
	printf("%lf\n",result);


}

 else if (strcmp(inputString,"pow")==0){

	if (top->next->next==NULL||top->next==NULL){
		printf("STACK ERROR\n");
		continue;
	}

	result=pop(&top);
	result=pow(pop(&top),result);
	push(&top,result);
	printf("%lf\n",result);


}

 else if (strcmp(inputString,"neg")==0){

   if (top->next==NULL||top==NULL){
		printf("STACK ERROR\n");
		continue;
	}


  result=-top->value;
  top->value=result;
  printf("%lf\n",result);

}

 else if (strcmp(inputString,"swap")==0){

	if (top->next==NULL||top->next->next==NULL){
		printf("STACK ERROR\n");
		continue;
	}

	result=top->value;                 //here a better name for result is temp, to swap two values
	top->value=top->next->value;
	top->next->value=result;
	result=top->value;
	printf("%lf\n",result);


}

 


 else if (strcmp(inputString,"pop")==0){

	if (top->next==NULL||top==NULL){
		printf("STACK ERROR\n");
		continue;
	}

	pop(&top);
	result=top->value;
	if (top->next!=NULL){
	printf("%lf\n",result);}



}


 else  if (strcmp(inputString,"print")==0){
    temp=top;
    if (temp->next==NULL){
    	printf("STACK ERROR\n");
		continue;
    }    
    
    while(temp->next!=NULL){
        printf("%lf\n",temp->value);
        temp=temp->next;
    }


   }

  else if (strcmp(inputString,"quit")==0){
    clearStack(top);
    clearQueue(front);
    break;


   }

  else if(strcmp(inputString,"print_func")==0){
    if(isFunctionDefined==1){
    	tempPtr=front;
    while(tempPtr!=NULL){
    	printf("%s\n",tempPtr->string);
    	tempPtr=tempPtr->next;
    }
    } else { printf("NO FUNCTION DEFINED\n");}


  }

  else if (strcmp(inputString,"call_func")==0){
     if (isFunctionDefined==1){
        tempPtr=front;
        breaker=0;
        while(tempPtr!=NULL){

           breaker=calculatorOperation(&top,tempPtr->string,&front);
           if (breaker>0){ break;}
           tempPtr=tempPtr->next;
        }
        if(top->next!=NULL){printf("%lf\n", top->value);}

     }else { printf("NO FUNCTION DEFINED\n");}
 
  }

  else if (strcmp(inputString,"remove_func")==0){

 if (isFunctionDefined==1){
        if(front!=NULL){
        	dequeue(&front);

        }
        if(front==NULL){
        	isFunctionDefined=0;
        }

     }else { printf("NO FUNCTION DEFINED\n");}


  }

//Here I should still consider print_func and call_func

else{ printf("INVALID COMMAND\n");}
}
if (breaker==2){break;}

if (wholePieceNum(inputString)>1){
  
  if(isValidDefinition(inputString)){ // write this function on saturday morning
  	
  	
  	sscanf(inputString,"%s %[^\t\n]",tempString,dummyString);
    

    if(strcmp(tempString,"def")==0){
  	strcpy(functionString,dummyString);
  	isFunctionDefined=1;
     i=0;
  	
    while(functionString[i]){
    	if(functionString[i]==' '){
    		functionString[i]='\n';
    	}
    	i++;
    }
    
    
    functionString[strlen(functionString)]='\n';
    


    clearQueue(front);
    front=(SNODE*)malloc(sizeof(SNODE));
    front->next=NULL;
    strcpy(front->string,tempString);//Here front points to string def,meaningless
    rear=front;

    while (wholePieceNum(dummyString)>=2){
      sscanf(dummyString,"%s %[^\t\n]",tempString,tempDummyString) ;
      strncpy(dummyString,tempDummyString,120);
      enqueue(&rear,tempString);

    }
    enqueue(&rear,dummyString);
    dequeue(&front);
    }else {

      if (isFunctionDefined==1){
        while (wholePieceNum(dummyString)>=2){
          sscanf(dummyString,"%s %[^\t\n]",tempString,tempDummyString) ;
          strncpy(dummyString,tempDummyString,120);
          enqueue(&rear,tempString);
      }
      enqueue(&rear,dummyString);

    } else {printf("NO FUNCTION DEFINED\n");}


    }// Finally the arguments are in the queue. Remove that def 
    



}// print INVALID COMMAND or something else?


}

}











//free(top);
return 0;

}