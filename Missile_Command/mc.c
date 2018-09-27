/**
 * mc.c
 * CIS240 Fall 2016
 Illustration of the bonus:
 The incoming missiles will get faster and faster as game progresses.
 The contact radius of outgoing missiles will be smaller and smaller.
 The missile splits after some time.
 Contacting the missile which birfurcates from the splitting does not increment the score.
 */

#include "lc4libc.h"

/************************************************
 *  DATA STRUCTURES FOR GAME STATE
 ***********************************************/

/** Width and height of lc4 */
#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 124

/** Number of cities and launchers in the game */
#define NUM_CITIES 2

/** Number of targets incoming can target (cities + 1 launcher) */
#define NUM_TARGETS NUM_CITIES+1 

/** Number of maximum outgoing and incoming allowed on the screen */
#define MAX_OUTGOING 1
#define MAX_INCOMING 3

/** Number of missiles allowed per round*/
#define MISSILES_PER_ROUND 8

/** The y position of where the cities and launcher are located */
#define GROUND_LEVEL 116

/** The x positions of where the cities and launcher are located */
#define LEFT_CITY_XPOS	20
#define RIGHT_CITY_XPOS 100
#define MISSILE_COMMAND_XPOS 60

/** The squared distance where missiles will contact
 * if it is in the radius */
#define CONTACT_RADIUS 250

/** Delay between GETC_TIMER - default at 10ms */
#define GETC_TIMER_DELAY 5

/** x coordinate of the cities and launcher*/
#define xCity0 30
#define xCity1 90
#define xLauncher 61

/*the period of refreshing the screen= MISSILE_REFRESH_PERIOD*GETC_TIMER_DELAY*/
#define MISSILE_REFRESH_PERIOD 2
#define SPLIT_TIME 10

int trajIncoming[MAX_INCOMING][2][300]={0};// This stores the trajectory of the incoming missiles,First dim represents which missile, second for x and y,third for coor value
int trajOutgoing[2][300]={0};
int trajIncomingSplit[MAX_INCOMING][2][300]={0};
int outgoingPusher=0;
int incomingPusher[3]={0}; 
int incomingSplitPusher[3]={0};  // These pushers will be the index to trace where we are on the trajectory
int keyInput=0;
int incomingsLeft=8;
int HIT_RADIUS=6;
int currentScore=0;
/** 2D array presenting the cursor */
lc4uint cursorImage[] = {
  0x00,
  0x00,
  0x18,
  0x3C,
  0x3C,
  0x18,
  0x00,
  0x00
};
lc4uint safeCityImage[] = {
  0xC3,
  0xC3,
  0xC3,
  0xC3,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
};
lc4uint destroyedCityImage[] = {
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0xFF,
  0xFF,
  0xFF,
};
lc4uint safeLauncherImage[] = {
  0xC3,
  0xC3,
  0xC3,
  0xC3,
  0xC3,
  0xC3,
  0xC3,
  0xC3,
};
lc4uint scoreImages[17][8]={
0xFF,0xC1,0xA1,0x91,0x89,0x85,0x83,0xFF,
0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x18,
0xFF,0x01,0x01,0xFF,0x80,0x80,0x80,0xFF,
0xFF,0x01,0x01,0xFF,0x01,0x01,0x01,0xFF,
0x88,0x88,0x88,0xFF,0x08,0x08,0x08,0x08,
0xFF,0x80,0x80,0xFF,0x01,0x01,0x01,0xFF,
0x80,0x80,0x80,0xFF,0x81,0x81,0x81,0xFF,
0xFF,0x01,0x01,0x01,0x01,0x01,0x01,0x01,
0xFF,0x81,0x81,0xFF,0x81,0x81,0x81,0xFF,
0xFF,0x81,0x81,0xFF,0x01,0x01,0x01,0x01,
0x8F,0x89,0x89,0x89,0x89,0x89,0x89,0x8F,
0x84,0x84,0x84,0x84,0x84,0x84,0x84,0x84,
0x8F,0x81,0x81,0x8F,0x88,0x88,0x88,0x8F,
0x8F,0x81,0x81,0x8F,0x81,0x81,0x81,0x8F,
0x8A,0x8A,0x8A,0x8F,0x82,0x82,0x82,0x82,
0x8F,0x88,0x88,0x8F,0x81,0x81,0x81,0x8F,
0x88,0x88,0x88,0x8F,0x89,0x89,0x89,0x8F,




};
/** Array of targets that the incoming will target */
lc4uint targets[NUM_TARGETS];
int max(int a,int b){
	if(a>b){
		return a;
	}else {return b;}
}
/** City struct that consists of the x position and 2D array */
/** representing the city's image */
typedef struct {
  lc4bool isDestroyed;
  lc4uint x;
  lc4uint cityImage[8];
}City;

/** Array consisting of cities */
City cities[NUM_CITIES];

/** Missile launcher struct that consists of the number missiles */
/** that the launcher has left, its x position and 2D array */
/** representing the missile launcher's image */
typedef struct {
  lc4bool isDestroyed;
  int missilesLeft;
  int x;
  lc4uint launcherImage[8];
}MissileLauncher;

/** Instance of the MissileLauncher Struct */
MissileLauncher missileLauncher;

/************************************************
 *  Projectile Struct
 *  lc4bool isActive - boolean representing 
 *                     if the projectile 
 *                     is active or not
 ***********************************************/
typedef struct {
  lc4bool isActive;
}Projectile;

/** Array consisting of missiles on the screen */
Projectile outgoing[MAX_OUTGOING];

/** Array consisting of incoming on the screen */
Projectile incoming[MAX_INCOMING];
Projectile incomingSplit[MAX_INCOMING];
/** Cursor struct consisting of the cursor's x and y position */
typedef struct{
  int x;
  int y;
}Cursor;

/** Instance of the cursor*/
Cursor cursor;

/* Line struct consisting of the starting point and the ending point*/
typedef struct{
 int x1;
 int x2;
 int y1;
 int y2;
 
}Line;

Line incomingLine[MAX_INCOMING];
Line outgoingLine[MAX_OUTGOING];
Line incomingSplitLine[MAX_INCOMING];

/***************************************************************
 * Debugging and utility functions
 * DO NOT EDIT
 ***************************************************************/

/************************************************
 *  Printnum - Prints out the value on the lc4
 ***********************************************/
void printnum (int n) {
  int abs_n;
  char str[10], *ptr;

  // Corner case (n == 0)
  if (n == 0) {
    lc4_puts ((lc4uint*)"0");
    return;
  }
 
  abs_n = (n < 0) ? -n : n;

  // Corner case (n == -32768) no corresponding +ve value
  if (abs_n < 0) {
    lc4_puts ((lc4uint*)"-32768");
    return;
  }

  ptr = str + 10; // beyond last character in string

  *(--ptr) = 0; // null termination

  while (abs_n) {
    *(--ptr) = (abs_n % 10) + 48; // generate ascii code for digit
    abs_n /= 10;
  }

  // Handle -ve numbers by adding - sign
  if (n < 0) *(--ptr) = '-';

  lc4_puts((lc4uint*)ptr);
}

void endl () {
  lc4_puts((lc4uint*)"\n");
}

/************************************************
 *  abs - returns the absolute value
 ***********************************************/
int abs(int value)
{
  if(value < 0)
    return -value;
  return value;
}

/************************************************
 *  rand16 - This function returns a random 
 *  number between 0 and 128
 ***********************************************/
int rand16 ()
{
  int lfsr;

  // Advance the lfsr seven times
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();

  // return the last 7 bits
  return (lfsr & 0x7F);
}

/***************************************************************
 * End of Debugging and utility functions
 ***************************************************************/
void DrawScoreTracker(){
  lc4_draw_sprite(62, 0, WHITE, scoreImages[currentScore]);


}
/************************************************
 * DrawCursor - 
 * Draws the cursor sprite in white 
 ***********************************************/
 void DrawCursor() 
 {
lc4_draw_sprite(cursor.x-2,cursor.y-2,WHITE,cursorImage);
 }

/************************************************
 *  DrawMissileLauncher - 
 *  Draws the missile launcher in white based on 
 *  the number of missiles left
 ***********************************************/
 void DrawMissileLauncher()
 {

lc4uint tempArray[8]={0,0,0,0,0,0,0,0};
int i= missileLauncher.missilesLeft;
int k=7;

while (i>0)
{ tempArray[k]=0xFF;
  i--;                        //obtain the word to draw
  k--;
}

lc4_draw_sprite(missileLauncher.x, GROUND_LEVEL, WHITE, tempArray); /*This fcn is not responsible for updating.*/
 

}

/************************************************
 *  DrawCities - 
 *  Draws the cities in white
 ***********************************************/
 void DrawCities()
 {
lc4_draw_sprite(cities[1].x, GROUND_LEVEL, RED, cities[1].cityImage);
lc4_draw_sprite(cities[0].x, GROUND_LEVEL, RED, cities[0].cityImage);
 }

/************************************************
 *  DrawIncoming - 
 *  Draws each incoming 
 ***********************************************/
 void DrawIncoming()         /*n indicates which incoming to draw, color indicates the color.I add a color argument here
                                                   because I want to use black to clear a certain line.*/
 {
  int i=0;

  
  for (i=0;i<MAX_INCOMING;i++){if (incoming[i].isActive==1){
  lc4_draw_line(incomingLine[i].x1, incomingLine[i].y1, incomingLine[i].x2, incomingLine[i].y2, WHITE);
     }
   }
 }

/************************************************
 *  DrawOutgoing
 *  Draws each outgoing missile 
 ***********************************************/
 void DrawOutgoing() /* color indicates the color of the Outgoing line.*/
 {
  int i=0;
  for (i=0;i<MAX_OUTGOING;i++){
  	if (outgoing[i].isActive==1){
  lc4_draw_line(outgoingLine[i].x1, outgoingLine[i].y1, outgoingLine[i].x2, outgoingLine[i].y2, GREEN);
     }
   }

 }

void DrawIncomingSplit(){
  int i=0;
  for (i=0;i<MAX_INCOMING;i++){
    if (incomingSplit[i].isActive==1){
      lc4_draw_line(incomingSplitLine[i].x1, incomingSplitLine[i].y1, incomingSplitLine[i].x2, incomingSplitLine[i].y2, WHITE);
    }

  }

}
/************************************************
 *  Reset - 
 *  Clears the screen
 ***********************************************/
void reset()
{
  lc4_reset_vmem();
  lc4_blt_vmem();
}
/************************************************
 *  Redraw - 
 *  Assuming that the PennSim is run with double 
 *  buffered mode, (using the launcher -> 
 *  (java -jar PennSim.jar -d))
 *  First, we should clear the video memory buffer 
 *  using lc4_reset_vmem.  Then we draw the scene 
 *  and then swap the video memory buffer using 
 *  lc4_blt_vmem
 ***********************************************/
void Redraw()
{
  lc4_reset_vmem();// clears the buffer
  DrawScoreTracker();
  DrawCursor();
  DrawMissileLauncher();
  DrawCities();
  DrawOutgoing();          //draw everything to the buffer
  DrawIncoming();
  DrawIncomingSplit();
  lc4_blt_vmem();// loads the buffer
}

/************************************************
 *  ResetGame - 
 *  Resets the game. 
 ***********************************************/
void flipArray(int inputArray[][300]){           //instead of flipArray, flipTraj may be better
 int i,k=0,tempArray[2][300]={0};
 for (i=0;i<300;i++){
    tempArray[0][i]=inputArray[0][i];
    tempArray[1][i]=inputArray[1][i];
    if (inputArray[0][i]==0&&inputArray[1][i]==0){
       k=i;
       break;
    }
   }
  for (i=0;i<k;i++){
  inputArray[0][i]=tempArray[0][k-i-1];
  inputArray[1][i]=tempArray[1][k-i-1];
  }
 
 
}

 void checkTraj(int x0,int y0,int inputArray[][300]){         // This function checks whether the direction of the traj calculated is reversed.If so,flip it.
  if (inputArray[0][0]!=x0||inputArray[1][0]!=y0){
  	flipArray(inputArray);
  }                                                                  

}

void getTrajectory(int x0,int y0,int x1,int y1,int inputArray[][300]){
int st,deltax,deltay,temp,ystep,error,y,i,x;
int tempx0=x0,tempy0=y0;
int tempArray[2][300]={0};
if (abs(y1-y0)>abs(x1-x0)){
	st=1;
}else {
	st=0;
}

if (st==1){
	temp=x0;
	x0=y0;
	y0=temp;                 //This large function just does the algorithm of HW6 drawline function.

	temp=x1;
	x1=y1;
	y1=temp;
}

if (x0>x1){
	temp=x0;
	x0=x1;
	x1=temp;

	temp=y1;
	y1=y0;
	y0=temp;

}

deltax=x1-x0;
deltay=abs(y1-y0);
error=0;
y=y0;

if (y0<y1){
	ystep=1;
}else{
	ystep=-1;
}

for(x=x0,i=0;x<=x1;x++,i++){
  if (st==1){
  	
  	inputArray[0][i]=y;
  	
  	inputArray[1][i]=x;
  } else{
  	
  	inputArray[0][i]=x;
  	inputArray[1][i]=y;
  }
 error=error+deltay;

 if (2*error>=deltax){
 	y=y+ystep;
 	error=error-deltax;
 }



}

/*if (inputArray[0][0]!=tempx0||inputArray[1][0]!=tempy0){ 
                          // if the end point and start point are interchanged during the trajectory calculating process, flip the array.{  for (i=0;i<300;i++){
  flipArray(inputArray);
}*/
	
  
}





void nullifyArray(int inputArray[][300]){

int i;
for (i=0;i<300;i++){
	inputArray[0][i]=0;
	inputArray[1][i]=0;
}



}

void ResetGame()
 {
    int i,antiSlope=0;
     i=0;
     reset();
     keyInput=0;
     currentScore=0;
    outgoingPusher=0;
    
        //everytime reset everything.This is the start of a round
  incomingLine[0].x1=rand16();
  incomingLine[0].y1=1;// subtle.I set this 1 because in the flipArray fcn I assume (0,0)will never be on any line
  incomingLine[0].x2=xLauncher;
  incomingLine[0].y2=GROUND_LEVEL;
  targets[0]=xLauncher;

  incomingLine[1].x1=rand16();
  incomingLine[1].y1=1;                   //When games starts, initialize 3 incomings.
  incomingLine[1].x2=xCity1;
  incomingLine[1].y2=GROUND_LEVEL;
  targets[1]=xCity1;

  incomingLine[2].x1=rand16();
  incomingLine[2].y1=1;
  incomingLine[2].x2=xCity0;
  incomingLine[2].y2=GROUND_LEVEL;
  targets[2]=xCity0;

  for (i=0;i<MAX_INCOMING;i++){
  incoming[i].isActive=1;
  incomingPusher[i]=0;
  nullifyArray(trajIncoming[i]);
  nullifyArray(trajIncomingSplit[i]);
  getTrajectory(incomingLine[i].x1,incomingLine[i].y1,incomingLine[i].x2,incomingLine[i].y2,trajIncoming[i]);
  checkTraj(incomingLine[i].x1,incomingLine[i].y1,trajIncoming[i]);
  incomingLine[i].x2=trajIncoming[i][0][0];               //This loop calculates the trajectory when a round of game starts
  incomingLine[i].y2=trajIncoming[i][1][0];
  incomingSplit[i].isActive=0;
  incomingSplitPusher[i]=0;
  }                                                     
  incomingsLeft=5;
  
 
cities[0].x=xCity0;
cities[1].x=xCity1;
cities[0].isDestroyed=0;
cities[1].isDestroyed=0;


for (i=0;i<=7;i++){

cities[0].cityImage[i]=safeCityImage[i];
cities[1].cityImage[i]=safeCityImage[i];
missileLauncher.launcherImage[i]=safeLauncherImage[i];
}


missileLauncher.missilesLeft=8;
missileLauncher.x=xLauncher;
missileLauncher.isDestroyed=0;

for(i=0;i<MAX_OUTGOING;i++){
    outgoing[i].isActive=0;
                    
}
                                     //reset that isActive thing
nullifyArray(trajOutgoing);

cursor.x=15;
cursor.y=15;
Redraw();


 }


void initializeOutgoing(){
	   
	    outgoing[0].isActive=1;
        missileLauncher.missilesLeft--;

        outgoingLine[0].x1=xLauncher;
        outgoingLine[0].y1=GROUND_LEVEL;
        
        outgoingLine[0].x2=cursor.x;
        outgoingLine[0].y2=cursor.y;
        nullifyArray(trajOutgoing);
        getTrajectory(outgoingLine[0].x1,outgoingLine[0].y1,outgoingLine[0].x2,outgoingLine[0].y2,trajOutgoing);
        checkTraj(outgoingLine[0].x1,outgoingLine[0].y1,trajOutgoing);
        outgoingLine[0].x2=trajOutgoing[0][0];
        outgoingLine[0].y2=trajOutgoing[1][0]; 
       
      

}


void checkKeyInput(){

if (keyInput==97&&cursor.x>5){         // if a is pressed and the x cooordinate is not too small
      cursor.x=cursor.x-3;
      Redraw();
  }
  if (keyInput==100&&cursor.x<122){         // if d is pressed and the x cooordinate is not too large
      cursor.x=cursor.x+3;
      Redraw();
  }
  if (keyInput==119&&cursor.y>5){         // if w is pressed and the y cooordinate is not too small
      cursor.y=cursor.y-3;
      Redraw();
  }
  if (keyInput==115&&cursor.y<108){         // if s is pressed and the y cooordinate is not too large,and I forbid it from going too low
      cursor.y=cursor.y+3;
      Redraw();
  }
  if (keyInput==114&&outgoing[0].isActive==0&&missileLauncher.missilesLeft>0&&missileLauncher.isDestroyed==0){ 
        initializeOutgoing();                  // when r is pressed. temporariely dealing with the case MAX_OUTGOING==1
        
                     //Here I should compute the trajectory of the line.
  } 


}
 void pushIncomingsForward(){
 	int i=0;
for(i=0;i<MAX_INCOMING;i++){              //everytime this fcn is called, push the active incoming forward
    	if (incoming[i].isActive==1){
        incomingPusher[i]++;
        incomingLine[i].x2=trajIncoming[i][0][incomingPusher[i]];//if a certain line is positive, add 1 to the pusher and draw the line forward
        incomingLine[i].y2=trajIncoming[i][1][incomingPusher[i]];
       }
    }

 }

 void pushOutgoingForward(){
if (outgoing[0].isActive==1){
        outgoingPusher++;
        outgoingLine[0].x2=trajOutgoing[0][outgoingPusher];
        outgoingLine[0].y2=trajOutgoing[1][outgoingPusher];
        //printnum(trajOutgoing[0][outgoingPusher]);    debug code                         // similar to the last one
    }
    
 }

 void resetOutgoing(){
 	 outgoing[0].isActive=0;
     outgoingLine[0].x1=xLauncher;
     outgoingLine[0].y1=GROUND_LEVEL;
        
     outgoingLine[0].x2=xLauncher;             //If outgoing reaches the ORIGINAL position of the cursor,
     outgoingLine[0].y2=GROUND_LEVEL;          //It explodes and trajectory,pusher,line are all nullified.
     nullifyArray(trajOutgoing);
     outgoingPusher=0;
 }

 void checkIfOutgoingSelfExplode(){
  if (outgoing[0].isActive==1&&trajOutgoing[0][outgoingPusher+1]==0&&trajOutgoing[1][outgoingPusher+1]==0){
     resetOutgoing();
  }
 

 }
 void checkIfIncomingsGetHit(){
   int i=0,isHit=0;
   if (outgoing[0].isActive==1){
   for (i=0;i<MAX_INCOMING;i++){
     if(abs(outgoingLine[0].x2-incomingLine[i].x2)<HIT_RADIUS && abs(outgoingLine[0].y2-incomingLine[i].y2)<HIT_RADIUS){
      incoming[i].isActive=0;
      incomingLine[i].x1=1;
      incomingLine[i].y1=1;
      incomingLine[i].x2=1;            //If any incoming is hit, nullify it.
      incomingLine[i].y1=1;
      nullifyArray(trajIncoming[i]);
      incomingPusher[i]=0;
      targets[i]=0;
      isHit=1;
      currentScore++;
     }}



  for (i=0;i<MAX_INCOMING;i++){
     if(incomingSplit[i].isActive==1&&abs(outgoingLine[0].x2-incomingSplitLine[i].x2)<HIT_RADIUS && abs(outgoingLine[0].y2-incomingSplitLine[i].y2)<HIT_RADIUS){
      incomingSplit[i].isActive=0;
      incomingSplitLine[i].x1=1;
      incomingSplitLine[i].y1=1;
      incomingSplitLine[i].x2=1;            //If any incoming is hit, nullify it.
      incomingSplitLine[i].y1=1;
      nullifyArray(trajIncomingSplit[i]);
      incomingSplitPusher[i]=0;
      
      isHit=1;
      currentScore++;
     }
   }
  if (isHit==1){
  	resetOutgoing();        //if hitting incoming,the outgoing is reset.
  }




 }

}


void reinitializeIncoming(int i){
	     int randomNum=rand16()%3;
         incoming[i].isActive=1;
         incomingLine[i].x1=rand16();
         incomingLine[i].y1=1;
         incomingLine[i].y2=GROUND_LEVEL;
         if (targets[0]!=xCity0&&targets[1]!=xCity0&&targets[2]!=xCity0&&cities[0].isDestroyed==0||missileLauncher.isDestroyed==1&&cities[0].isDestroyed==0){
          incomingLine[i].x2=xCity0;
          targets[i]=xCity0;
         }else if(targets[0]!=xCity1&&targets[1]!=xCity1&&targets[2]!=xCity1&&cities[1].isDestroyed==0||missileLauncher.isDestroyed==1&&cities[1].isDestroyed==0){
         	incomingLine[i].x2=xCity1;
         	targets[i]=xCity1;
         }else {
         	incomingLine[i].x2=xLauncher;
         	targets[i]=xLauncher;
         }
  

  nullifyArray(trajIncoming[i]);
  getTrajectory(incomingLine[i].x1,incomingLine[i].y1,incomingLine[i].x2,incomingLine[i].y2,trajIncoming[i]);
  checkTraj(incomingLine[i].x1,incomingLine[i].y1,trajIncoming[i]);
  incomingLine[i].x2=trajIncoming[i][0][0];               
  incomingLine[i].y2=trajIncoming[i][1][0];
  incomingPusher[i]=0;


}
void checkIfNeedToReinitializeIncomings(){
    int i;
    for (i=0;i<MAX_INCOMING;i++){
    	if(incoming[i].isActive==0&&incomingsLeft>0){
           incomingsLeft--;
           reinitializeIncoming(i);

    	}
    }


}

void destroyCity(int n){
  int i;
  cities[n].isDestroyed=1;
  for (i=0;i<=7;i++){
     cities[n].cityImage[i]=destroyedCityImage[i];
}

}

void destroyMissileLauncher(){
	int i;
	missileLauncher.isDestroyed=1;
	missileLauncher.missilesLeft=0;
    for (i=0;i<8;i++){
    	missileLauncher.launcherImage[i]=0;
    }
}

void resetIncoming(int i){
      incoming[i].isActive=0;
      incomingLine[i].x1=1;
      incomingLine[i].y1=1;
      incomingLine[i].x2=1;            //If any incoming is hit, nullify it.
      incomingLine[i].y1=1;
      nullifyArray(trajIncoming[i]);
      incomingPusher[i]=0;
      targets[i]=0;

}

void resetIncomingSplit(int i){
      incomingSplit[i].isActive=0;
      incomingSplitLine[i].x1=1;
      incomingSplitLine[i].y1=1;
      incomingSplitLine[i].x2=1;            //If any incoming is hit, nullify it.
      incomingSplitLine[i].y1=1;
      nullifyArray(trajIncomingSplit[i]);
      incomingSplitPusher[i]=0;

}


void checkIfAnythingIsDestroyed(){
 int i,tempx;
 for (i=0;i<MAX_INCOMING;i++){
     if(incoming[i].isActive==1&&trajIncoming[i][0][incomingPusher[i]+1]==0&&trajIncoming[i][1][incomingPusher[i]+1]==0){
     	tempx=trajIncoming[i][0][incomingPusher[i]];

        if(abs(tempx-xCity0)<3){
     	destroyCity(0);
       }
        if (abs(tempx-xCity1)<3){
     	destroyCity(1);
       }
        if (abs(tempx-xLauncher)<3){
        destroyMissileLauncher();
       }

       resetIncoming(i);

     }
}
  for (i=0;i<MAX_INCOMING;i++){
     if(incomingSplit[i].isActive==1&&trajIncomingSplit[i][0][incomingSplitPusher[i]+1]==0&&trajIncomingSplit[i][1][incomingSplitPusher[i]+1]==0){
      tempx=trajIncomingSplit[i][0][incomingSplitPusher[i]];

        if(abs(tempx-xCity0)<3){
      destroyCity(0);
       }
        if (abs(tempx-xCity1)<3){
      destroyCity(1);
       }
        if (abs(tempx-xLauncher)<3){
        destroyMissileLauncher();
       }

       resetIncomingSplit(i);

     }



 }
     


}

void pushIncomingSplitsForward(){
int i=0;
for(i=0;i<MAX_INCOMING;i++){              //everytime this fcn is called, push the active incoming forward
      if (incomingSplit[i].isActive==1){
        incomingSplitPusher[i]++;
        incomingSplitLine[i].x2=trajIncomingSplit[i][0][incomingSplitPusher[i]];//if a certain line is positive, add 1 to the pusher and draw the line forward
        incomingSplitLine[i].y2=trajIncomingSplit[i][1][incomingSplitPusher[i]];
       }
    }

}

void initializeIncomingSplit(int i){

      
         incomingSplit[i].isActive=1;
         incomingSplitLine[i].x1=incomingLine[i].x2;
         incomingSplitLine[i].y1=incomingLine[i].y2;
         incomingSplitLine[i].y2=GROUND_LEVEL;

         if (targets[i]==xCity1){
          incomingSplitLine[i].x2=xCity0;
          
         }else if(targets[i]==xCity0){
          incomingSplitLine[i].x2=xLauncher;
          
         }else {
          incomingSplitLine[i].x2=xCity1;
          
         }
  

  nullifyArray(trajIncomingSplit[i]);
  getTrajectory(incomingSplitLine[i].x1,incomingSplitLine[i].y1,incomingSplitLine[i].x2,incomingSplitLine[i].y2,trajIncomingSplit[i]);
  checkTraj(incomingSplitLine[i].x1,incomingSplitLine[i].y1,trajIncomingSplit[i]);
  incomingSplitLine[i].x2=trajIncomingSplit[i][0][0];               
  incomingSplitLine[i].y2=trajIncomingSplit[i][1][0];
  incomingSplitPusher[i]=0;


}


void checkIfSplit(){
int i;
for (i=0;i<MAX_INCOMING;i++){
 if (incomingSplit[i].isActive==0&&incomingPusher[i]==SPLIT_TIME)
   initializeIncomingSplit(i);
}




}
/************************************************
 *  main - 
 *  Initalize game state by reseting the game state
 *  Loops until the the user loses
 ***********************************************/
 int main ()
 { 
   int i,breaker=0;
   
   int timeCounter=0; // timeCounter here is important. in the second while loop, it controls the period of refreshing,etc,the speed of the missile
   
  //** Print to screen and initalize game state. */
  lc4_puts ((lc4uint*)"Welcome to Missile Command!\n");
  lc4_puts ((lc4uint*)"a,d,s,w for left,right,down,up\n");
  lc4_puts ((lc4uint*)"r for launching missiles\n"); 
  
 
  while(1) 
  {
  	if (breaker==1){
	break;
  }
    ResetGame();
    
  
  while (1){

    keyInput=lc4_getc_timer(GETC_TIMER_DELAY);// Check if there is any input
    checkKeyInput();

    /*pushIncomingsForward();
 	pushOutgoingForward();   // when the a missile refresh period is reached, make timeCounter 0 and push lines forward

    Redraw();*/


    HIT_RADIUS=3+incomingsLeft;               // HIT_RADIUS gets smaller and smaller
    pushOutgoingForward();
    Redraw();

 if (timeCounter>=MISSILE_REFRESH_PERIOD*incomingsLeft){           //incomings flies faster and faster
 	timeCounter=0;// make timeCounter 0;
 	pushIncomingsForward();
 	pushIncomingSplitsForward();// when the a missile refresh period is reached, make timeCounter 0 and push lines forward

    Redraw();          
    
    } else {
   timeCounter++;
        }
 
 checkIfOutgoingSelfExplode();
 checkIfIncomingsGetHit();
 checkIfAnythingIsDestroyed();
 checkIfNeedToReinitializeIncomings();
 checkIfSplit();

 if (cities[0].isDestroyed==1&&cities[1].isDestroyed==1){
 	breaker=1;
 	break;
 }
 if (incoming[0].isActive==0&&incoming[1].isActive==0&&incoming[2].isActive==0&&incomingsLeft==0){
 	break;
 }
//Here I should consider what will happen if missiles touch the boundary and an incoming is hit.
            }


}

lc4_puts ((lc4uint*)"You lose!\n"); 
  return 0;

}

















