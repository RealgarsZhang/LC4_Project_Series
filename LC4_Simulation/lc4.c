#include "lc4.h"
#include <stdio.h>
#include <math.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>





/*#define IMM_9(I) ((I)&0x1FF)
#define IMM_8(I) ((I)&0x00FF)
#define IMM_7(I) ((I)&0x007F)
#define IMM_4(I) ((I)&0x000F)
#define IMM_5(I) ((I)&0x001F)
#define IMM_6(I) ((I)&0x003F)
#define IMM_11(I) ((I)&0x07FF)
#define INSN_OP(I) ((I)>>12)
#define INSN_15_11(I) ((I)>>11)
#define INSN_5_3(I)(((I)&0x0038)>>3)
#define INSN_5_4(I)(((I)&0x0030)>>4)
#define INSN_8_7(I)(((I)&0x0180)>>7)
#define INSN_8_6(I)(((I)&0x01C0)>>6)
#define INSN_11_9(I)(((I)&0x0E00)>>9)
#define INSN_2_0(I)(((I)&0x0007))
*/

unsigned short int signExtend(unsigned short int input,int digitNum){
  unsigned short int n=0xFFFF;
  if ((input>>(digitNum-1))==1){ 
    n=(n>>digitNum);
    n=(n<<digitNum);
    return (n|input);
    }

    else {return input;}

}
void printInstr(unsigned short int I){// print the mnemonic solely according to the instruction
	switch (INSN_15_9(I)){
	case 0:
	printf("NOP\n");
	return ;
	break;

	case 1:
	printf("BRp 0x%x\n",signExtend(IMM_9(I),9));
	break;
 
    case 2:
	printf("BRz 0x%x\n",signExtend(IMM_9(I),9));
    break;

    case 3:
	printf("BRzp 0x%x\n",signExtend(IMM_9(I),9));
    break;

    case 4:
	printf("BRn 0x%x\n",signExtend(IMM_9(I),9));
    break;
    
    case 5:
	printf("BRnp 0x%x\n",signExtend(IMM_9(I),9));
    break;

    case 6:
	printf("BRnz 0x%x\n",signExtend(IMM_9(I),9));
    break;
 
    case 7:
	printf("BRnzp 0x%x\n",signExtend(IMM_9(I),9));
    break;

}

if (INSN_OP(I)==1){
	if(INSN_5_3(I)==0){printf("ADD R%d R%d R%d\n",INSN_11_9(I),INSN_8_6(I),INSN_2_0(I) );}
    else if (INSN_5_3(I)==1){printf("MUL R%d R%d R%d\n",INSN_11_9(I),INSN_8_6(I),INSN_2_0(I) );}
    else if (INSN_5_3(I)==2){printf("SUB R%d R%d R%d\n",INSN_11_9(I),INSN_8_6(I),INSN_2_0(I) );}
    else if (INSN_5_3(I)==3){printf("DIV R%d R%d R%d\n",INSN_11_9(I),INSN_8_6(I),INSN_2_0(I) );}
    else {printf("ADD R%d R%d #%d\n",INSN_11_9(I),INSN_8_6(I),(short)signExtend(IMM_5(I),5) );}
}

if(INSN_OP(I)==2){
	if(INSN_8_7(I)==0){printf("CMP R%d R%d\n",INSN_11_9(I),INSN_2_0(I) );}
	else if (INSN_8_7(I)==1){printf("CMPU R%d R%d\n",INSN_11_9(I),INSN_2_0(I) );}
    else if (INSN_8_7(I)==2){printf("CMPI R%d #%d\n",INSN_11_9(I),(short)signExtend(IMM_7(I),7) );}
    else {printf("CMPIU R%d #%d\n",INSN_11_9(I),IMM_7(I) );}
}

if(INSN_15_11(I)==8){printf("JSRR R%d\n",INSN_8_6(I));}

if(INSN_15_11(I)==9){printf("JSR #%d\n",IMM_11(I) );}

if(INSN_OP(I)==5){
	if (INSN_5_3(I)==0){printf("AND R%d R%d R%d\n",INSN_11_9(I),INSN_8_6(I),INSN_2_0(I));}
    else if (INSN_5_3(I)==1){printf("NOT R%d R%d\n",INSN_11_9(I),INSN_8_6(I));}
    else if (INSN_5_3(I)==2){printf("OR R%d R%d R%d\n",INSN_11_9(I),INSN_8_6(I),INSN_2_0(I));}
    else if (INSN_5_3(I)==3){printf("XOR R%d R%d R%d\n",INSN_11_9(I),INSN_8_6(I),INSN_2_0(I));}
    else {printf("AND R%d R%d #%d\n",INSN_11_9(I),INSN_8_6(I),(short)signExtend(IMM_5(I),5));}
}

if(INSN_OP(I)==6){printf("LDR R%d R%d #%d\n",INSN_11_9(I),INSN_8_6(I),(short)signExtend(IMM_6(I),6));}

if (INSN_OP(I)==7){printf("STR R%d R%d #%d\n",INSN_11_9(I),INSN_8_6(I),(short)signExtend(IMM_6(I),6));}

if (INSN_OP(I)==8){printf("RTI\n");}

if(INSN_OP(I)==9){printf("CONST R%d #%d\n",INSN_11_9(I),(short)signExtend(IMM_9(I),9) );}

if( INSN_OP(I)==10){
	if(INSN_5_4(I)==0){printf("SLL R%d R%d #%d\n",INSN_11_9(I),INSN_8_6(I),IMM_4(I));}
    else if(INSN_5_4(I)==1){printf("SRA R%d R%d #%d\n",INSN_11_9(I),INSN_8_6(I),IMM_4(I));}
    else if(INSN_5_4(I)==2){printf("SRL R%d R%d #%d\n",INSN_11_9(I),INSN_8_6(I),IMM_4(I));}
    else {printf("MOD R%d R%d R%d\n",INSN_11_9(I),INSN_8_6(I),INSN_2_0(I));} 
}

if(INSN_15_11(I)==24){printf("JMPR R%d\n",INSN_8_6(I));}

if(INSN_15_11(I)==25){printf("JMP #%d\n",(short)signExtend(IMM_11(I),11));}

if(INSN_OP(I)==13){printf("HICONST R%d #%d\n",INSN_11_9(I),IMM_8(I));}

if(INSN_OP(I)==15){printf("TRAP #%d\n",IMM_8(I) );}
}


void decode(unsigned short int I, control_signals* control){


    if (INSN_OP(I)==0){

     	control->pc_mux_ctl='0';
     } else if (INSN_15_11(I)==25){control->pc_mux_ctl='2';}
     else if (INSN_15_11(I)==24||INSN_15_11(I)==8||INSN_OP(I)==8){control->pc_mux_ctl='3';}
     else if (INSN_OP(I)==15){control->pc_mux_ctl='4';}
     else if (INSN_15_11(I)==9){control->pc_mux_ctl='5';}
     else {control->pc_mux_ctl='1';}

    if (INSN_OP(I)==8){control->rs_mux_ctl='1';}
          //INSN_OP(I)==1||INSN_15_11(I)==8||INSN_OP(I)==5||INSN_OP(I)==6||INSN_OP(I)==7||INSN_OP(I)==10||INSN_15_11(I)==
    else if (INSN_OP(I)==2||INSN_OP(I)==13){control->rs_mux_ctl='2';}
    else {control->rs_mux_ctl='0';}

    if (INSN_OP(I)==7){control->rt_mux_ctl='1';}
      else {control->rt_mux_ctl='0';}

    if (INSN_OP(I)==4||INSN_OP(I)==15){control->rd_mux_ctl='1';}
      else{control->rd_mux_ctl='0';}

    if(INSN_OP(I)==1||INSN_OP(I)==4||INSN_OP(I)==5||INSN_OP(I)==6||INSN_OP(I)==9||INSN_OP(I)==10||INSN_OP(I)==13||INSN_OP(I)==4||INSN_OP(I)==15){control->reg_file_we='1';}
    else {control->reg_file_we='0';}

    if(INSN_OP(I)==4||INSN_OP(I)==15){control->reg_input_mux_ctl='2';}
    else if (INSN_OP(I)==6){control->reg_input_mux_ctl='1';}
    else {control->reg_input_mux_ctl='0';}

    if(INSN_OP(I)==1&&INSN_5_3(I)==1){control->arith_ctl='1';}
    else if(INSN_OP(I)==1&&INSN_5_3(I)==2){control->arith_ctl='2';}
    else if(INSN_OP(I)==1&&INSN_5_3(I)==3){control->arith_ctl='3';}
    else if (INSN_OP(I)==10&&INSN_5_4(I)==3){control->arith_ctl='4';}
    else {control->arith_ctl='0';}

    if(INSN_OP(I)==1&&(I>>5)%2==1){control->arith_mux_ctl='1';}
    else if (INSN_OP(I)==6||INSN_OP(I)==7){control->arith_mux_ctl='2';}
    else {control->arith_mux_ctl='0';}

    if (INSN_OP(I)==5&&INSN_5_3(I)==1){control->logic_ctl='1';}
    else if (INSN_OP(I)==5&&INSN_5_3(I)==2){control->logic_ctl='2';}
    else if (INSN_OP(I)==5&&INSN_5_3(I)==3){control->logic_ctl='3';}
    else {control->logic_ctl='0';}

    if(INSN_OP(I)==5&&(I>>5)%2!=0){control->logic_mux_ctl='1';}
    else {control->logic_mux_ctl='0';}



   if(INSN_OP(I)==10&&INSN_5_4(I)==0){control->shift_ctl='0';}
   else if (INSN_OP(I)==10&&INSN_5_4(I)==1){control->shift_ctl='1';}
   else {control->shift_ctl='2';}

   if(INSN_OP(I)==9){control->const_ctl='0';}
   else {control->const_ctl='1';}

   if(INSN_OP(I)==2&&INSN_8_7(I)==0){control->cmp_ctl='0';}
    else if(INSN_OP(I)==2&&INSN_8_7(I)==1){control->cmp_ctl='1';}
    else if (INSN_OP(I)==2&&INSN_8_7(I)==2){control->cmp_ctl='2';}
    else {control->cmp_ctl='3';}

    if(INSN_OP(I)==5){control->alu_mux_ctl ='1';}
    else if (INSN_OP(I)==10&&INSN_5_4(I)!=3){control->alu_mux_ctl ='2';}
    else if (INSN_OP(I)==9||INSN_OP(I)==13){control->alu_mux_ctl ='3';}
    else if (INSN_OP(I)==2){control->alu_mux_ctl ='4';}
    else {control->alu_mux_ctl ='0';}

    if(INSN_OP(I)==0||INSN_OP(I)==7||INSN_OP(I)==8||INSN_OP(I)==12){control->nzp_we='0';}
    else {control->nzp_we='1';}

    if(INSN_OP(I)==7){control->data_we='1';}
    else{control->data_we='0';}
}

/*
 * Resets all control signals to 0.
 * Param: pointer to control signals struct.
 */
void clear_signals(control_signals* control){

	control->pc_mux_ctl='1';
    control->rs_mux_ctl='0';
    control->rt_mux_ctl='0';
    control->rd_mux_ctl='0';
    control->reg_file_we='0';
    control->reg_input_mux_ctl='0';
    control-> arith_ctl='0';
    control-> arith_mux_ctl='0';
    control-> logic_ctl='0';
    control-> logic_mux_ctl='0';
    control-> shift_ctl='0';
    control-> const_ctl='0';
    control-> cmp_ctl='0';
    control-> alu_mux_ctl='0';
    control-> nzp_we='0';
    control-> data_we='0';


}
/*
 * Resets the machine state as PennSim would do.
 * Param: pointer to current machine state.
 */
void reset(machine_state* state){
   int i=0;
   state->PC=0x8200;
   state->PSR=0x8002;

   for(i=0;i<8;i++)
   	state->R[i]=0;

   for (i=0;i<65536-1;i++)
   	state->memory[i]=0;

   clear_signals(&(state->control));

}

/*
 * Updates the machine state, simulating a single clock cycle.
 * Returns 0 if update successful, a nonzero error code if unsuccessful.
 * Param: pointer to current machine state.
 */
int update_state(machine_state* state){
	//First I do some exception checking.
	machine_state tempState;
	
	unsigned short int rs_out;
	unsigned short int rt_out;
	unsigned short int alu_out;
	unsigned short int dmemPos;
	unsigned short int I=state->memory[state->PC];	
	unsigned short int regInput_out;
    if ((state->PC>=0x2000&&state->PC<0x8000)||(state->PC>=0xA000&&state->PC<0xC000)){return 1;}
    if(((state->PSR)>>15)==0&&state->PC>=0x8000){return 3;}
    decode(I,&(state->control));
    
    rs_out=state->R[rs_mux(state)];
    rt_out=state->R[rt_mux(state)];
    //printf("ever here\n");

    alu_out=alu_mux(state,rs_out,rt_out);

    regInput_out=reg_input_mux(state,alu_out);
    dmemPos=rs_out+signExtend(IMM_6(I),6);
    tempState=*state;

	


	if (INSN_OP(I)==6||INSN_OP(I)==7){
		if (((state->PSR)>>15)==0&&dmemPos>=0xA000){return 3;}
		if (dmemPos<0x2000||(dmemPos>=0x8000&&dmemPos<0xA000)){return 2;}
	}
    

    printf("0x%x: ",state->PC);//after making sure this instruction will be executed ,I print it
    printInstr(I);
   //Then I update everything of the machine state.
    tempState.PC=pc_mux(state,rs_out);//update PC

    //update PSR:
    if(INSN_OP(I)==15){tempState.PSR=(tempState.PSR|0x8000); }//trap
    if(INSN_OP(I)==8){tempState.PSR=(tempState.PSR&0x7FFF);}  

    if (INSN_OP(I)==2||state->control.reg_file_we=='1'){
        if ((short)regInput_out>0){tempState.PSR=((((tempState.PSR)>>3)<<3)|0x1);}
        else if ((short)regInput_out==0){tempState.PSR=((((tempState.PSR)>>3)<<3)|0x2);}
        else {tempState.PSR=((((tempState.PSR)>>3)<<3)|0x4);}
    }                  

    //update regFIle
    if(state->control.reg_file_we=='1'){tempState.R[rd_mux(state)]=regInput_out;}

    //update memory
    if(state->control.data_we=='1'){tempState.memory[dmemPos]=rt_out;}

    
    *state=tempState;
    //printf("%x\n",state->PC );
    return 0;
}

/*
 * Returns the current output of the RS mux.
 * Param: pointer to current machine state.
 */
unsigned short int rs_mux(machine_state* state){
	if ((state->control).rs_mux_ctl=='0'){return INSN_8_6(state->memory[state->PC]);}
	else if ((state->control).rs_mux_ctl=='1'){return 7;}
	else {return INSN_11_9(state->memory[state->PC]);}
}

/*
 * Returns the current output of the RT mux.
 * Param: pointer to current machine state.
 */
unsigned short int rt_mux(machine_state* state){

     if((state->control).rt_mux_ctl=='0'){return INSN_2_0(state->memory[state->PC]);}
     else {return INSN_11_9(state->memory[state->PC]);}

}
unsigned short int rd_mux(machine_state* state){

     if((state->control).rd_mux_ctl=='0'){return INSN_11_9(state->memory[state->PC]);}
     else {return 7;}

}

/*
 * Returns the current output of the ALU mux.
 * Params: pointer to current machine state, RS mux output, RT mux output.
 */
unsigned short int alu_mux(machine_state* state,
                           unsigned short int rs_out,
                           unsigned short int rt_out){
    unsigned short int I=state->memory[state->PC];
    unsigned short int arithInput;
    unsigned short int logicInput;
    // printf("ALU_MUX_CTL:%c\n",state->control.alu_mux_ctl);
    if (state->control.alu_mux_ctl=='4'){

		if (state->control.cmp_ctl=='0'){
         if((short)rs_out>(short)rt_out){return 1;}
		else if ((short)rs_out==(short)rt_out){return 0;}
		else {return 0xFFFF;}
	}

        if (state->control.cmp_ctl=='1'){
         if(rs_out>rt_out){return 1;}
		else if (rs_out==rt_out){return 0;}
		else {return 0xFFFF;}
	}
        if (state->control.cmp_ctl=='2'){
         if((short)rs_out>(short)signExtend(IMM_7(I),7)){return 1;}
		else if ((short)rs_out==(short)signExtend(IMM_7(I),7)){return 0;}
		else {return 0xFFFF;}
	}
        if (state->control.cmp_ctl=='3'){
         if(rs_out>IMM_7(I)){return 1;}
		else if (rs_out==IMM_7(I)){return 0;}
		else {return 0xFFFF;}
	}



	}
	
/*if (state->control.alu_mux_ctl=='4'){

		if (state->control.cmp_ctl=='0'){
         if((short)rs_out>(short)rt_out){return ((((state->PSR)>>3)<<3)|0x1);}
		else if ((short)rs_out==(short)rt_out){return ((((state->PSR)>>3)<<3)|0x2);}
		else {return ((((state->PSR)>>3)<<3)|0x4);}
	}

        if (state->control.cmp_ctl=='1'){
         if(rs_out>rt_out){return ((((state->PSR)>>3)<<3)|0x1);}
		else if (rs_out==rt_out){return ((((state->PSR)>>3)<<3)|0x2);}
		else {return ((((state->PSR)>>3)<<3)|0x4);}
	}
        if (state->control.cmp_ctl=='2'){
         if((short)rs_out>(short)signExtend(IMM_7(I),7)){return ((((state->PSR)>>3)<<3)|0x1);}
		else if ((short)rs_out==(short)signExtend(IMM_7(I),7)){return ((((state->PSR)>>3)<<3)|0x2);}
		else {return ((((state->PSR)>>3)<<3)|0x4);}
	}
        if (state->control.cmp_ctl=='3'){
         if(rs_out>IMM_7(I)){return ((((state->PSR)>>3)<<3)|0x1);}
		else if (rs_out==IMM_7(I)){return ((((state->PSR)>>3)<<3)|0x2);}
		else {return ((((state->PSR)>>3)<<3)|0x4);}
	}



	}*/
	if (state->control.alu_mux_ctl=='3'){
		if (state->control.const_ctl=='0'){return signExtend(IMM_9(I),9);}
		else {return (rs_out&0xFF)|(IMM_8(I)<<8);}
	}

	if(state->control.alu_mux_ctl=='2'){
		if(state->control.shift_ctl=='0'){return (rs_out<<IMM_4(I));}
		else if (state->control.shift_ctl=='1'){return (unsigned short)((short)rs_out>>IMM_4(I));}
		else {return (rs_out>>IMM_4(I));}
	}

	if (state->control.alu_mux_ctl=='1'){

		if (state->control.logic_mux_ctl=='0'){logicInput=rt_out;}
		else {logicInput=signExtend(IMM_5(I),5);}


		if(state->control.logic_ctl=='3'){return (logicInput^rs_out);}
		else if (state->control.logic_ctl=='2'){return (logicInput|rs_out);}
		else if (state->control.logic_ctl=='1'){return ~rs_out;}
		else {return (logicInput&rs_out);}
	}

	if(state->control.alu_mux_ctl=='0'){
		
		if(state->control.arith_mux_ctl=='0'){arithInput=rt_out;}
		else if (state->control.arith_mux_ctl=='1'){arithInput=signExtend(IMM_5(I),5);}
		else {arithInput=signExtend(IMM_6(I),6);}
           // printf("arith_ctl:%c\n",state->control.arith_ctl);
            //printf("arithInput:%d\n",(short)arithInput);
 //printf("arithInput:%d\n",arithInput);
          //  printf("rs_out:%d\n",(short)rs_out);
           // printf("rs_out:%d\n",rs_out);
		if(state->control.arith_ctl=='0'){
			
			return (unsigned short int)(arithInput+rs_out);
		} else if (state->control.arith_ctl=='1'){return (unsigned short int)(arithInput*rs_out);}
		else if (state->control.arith_ctl=='2'){return (unsigned short int)(rs_out-arithInput);}
        else if (state->control.arith_ctl=='3'&&arithInput!=0){return (unsigned short int)(rs_out/arithInput);}
        else if (state->control.arith_ctl=='4'&&arithInput!=0) { return (unsigned short int)(rs_out%arithInput);}
        else return 0;
    }

return 15;}
/*
 * Returns the current output of the register input mux.
 * Params: pointer to current machine state and current ALU mux output.
 */
unsigned short int reg_input_mux(machine_state* state,
                                 unsigned short int alu_out){

	if (state->control.reg_input_mux_ctl=='0'){return alu_out;}
	else if (state->control.reg_input_mux_ctl=='1'){return state->memory[alu_out];}
	else {return (state->PC+1);}             //potentially buggy here. Consider the position of the PC
}

/*
 * Returns the current output of the PC mux.
 * Params: current RS mux output and pointer to current machine state.
 */
unsigned short int pc_mux(machine_state* state, unsigned short int rs_out){
unsigned short int I=state->memory[state->PC];

	if (state->control.pc_mux_ctl=='5'){return (state->PC&0x8000)|(IMM_11(I)<<4);}
	else if (state->control.pc_mux_ctl=='4'){return (0x8000|IMM_8(I));}
	else if (state->control.pc_mux_ctl=='3'){return rs_out;}
	else if (state->control.pc_mux_ctl=='2'){return state->PC+1+signExtend(IMM_11(I),11);}
	else if (state->control.pc_mux_ctl=='1'){return state->PC+1;}
	else {
		if((INSN_11_9(I)& INSN_2_0(state->PSR))!=0){return state->PC+1+signExtend(IMM_9(I),9);}
		else {return state->PC+1;}


	}

}