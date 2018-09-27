#include <stdio.h>
#include "token.h"
#include <string.h>
/*Token type:1 for number
               2 for for operator
               3 for comparison
               4 for logical except not
               5 for logical not
               6 for stack operations
               7 for arg
               8 for if
               9 for else
               10 for endif
               11 for ;
               12 for defun
               13 for function name
               14 for return
               */
int isDigit(char input){
   
if (input>=48&&input<=57){
	return 1;
}
 return 0;
}

int isWhitespace(char input){
  int n;
  if (input==' '||input=='\n'||input=='\t'){
    n=1;
  } else {n=0;}

  return (n);


}

int isNumString(const char inputString[]){// return 1 if decimal, return 2 if hex, return 0 if neither.

 int pointNum=0;
 int i=0;
 int nonDigitTeller=0;
 
 /*for(i=0;i<strlen(inputString);i++){
  if(isWhitespace(inputString[i])){return 0;}
 }*/


 if (inputString[0]=='0'&&inputString[1]=='x'){
 	return 2; //assume that nothing other than hex will begin by 0x
 }


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




int read_token (token *theToken, FILE *theFile){//return 1 if key word or number is encountered,
	                                             //return 0 if a comment is encountered
	                                            //return 2 if a function name is encountered
   char str[200]={0};
   int i=0;
   int n=0;
   char tempStr[300]={0};
   int commentRecorder=1;

   fscanf(theFile,"%s",str);
   strcpy(theToken->str,str);
   n=strlen(str);

   theToken->type=0;

for(i=0;i<strlen(str);i++){
   	if(str[i]==';'){
   		//theToken->type=11;
   		commentRecorder=0;
        str[i]=0;
   		strcpy(theToken->str,str);
        fgets(tempStr,288,theFile);//push the fp to the the new line.

   	}
   }
   

   if(isNumString(str)==2){sscanf(str,"%x",&(theToken->literal_value)); theToken->type=1;return commentRecorder;}
   if(isNumString(str)==1){sscanf(str,"%d",&(theToken->literal_value)); theToken->type=1;return commentRecorder;}

   if(str[0]=='+'||str[0]=='-'||str[0]=='*'||str[0]=='/'||str[0]=='%'){theToken->type=2;return commentRecorder;}

   if(strcmp(str,"lt")==0||strcmp(str,"le")==0||strcmp(str,"eq")==0||strcmp(str,"ge")==0||strcmp(str,"gt")==0){theToken->type=3;return commentRecorder;}
  
   if (strcmp(str,"and")==0||strcmp(str,"or")==0){theToken->type=4;return commentRecorder;}

   if(strcmp(str,"not")==0){theToken->type=5;return commentRecorder;}

   if(strcmp(str,"drop")==0||strcmp(str,"dup")==0||strcmp(str,"swap")==0||strcmp(str,"max")==0||strcmp(str,"low8")==0){theToken->type=6;return commentRecorder;}

   if(str[0]=='a'&&str[1]=='r'&&str[2]=='g'){
   	theToken->type=7;
    theToken->arg_no=str[3]-'0';
   return commentRecorder;}

   if(strcmp(str,"if")==0){theToken->type=8;return commentRecorder;}

   if(strcmp(str,"else")==0){theToken->type=9;return commentRecorder;}

   if(strcmp(str,"endif")==0){theToken->type=10;return commentRecorder;}

   
   if(strcmp(str,"defun")==0){theToken->type=12;return commentRecorder;}

   if(strcmp(str,"return")==0){theToken->type=14;return commentRecorder;}

   if(strlen(str)>0){theToken->type=13;return 2;}

   return commentRecorder;

}

/*Token type:1 for number
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