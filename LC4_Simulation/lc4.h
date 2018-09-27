/*
 * CIS 240 HW 9: LC4 Simulator
 * lc4.h - defines machine state struct and prototypes for related functions
 */

/*
 * Struct representing all 16 control signals.
 */

#ifndef LC4_H
#define LC4_H

#define IMM_9(I) ((I)&0x1FF)
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
#define INSN_2_0(I)(((I)&0x0007))

typedef struct {
    unsigned char pc_mux_ctl;
    unsigned char rs_mux_ctl;
    unsigned char rt_mux_ctl;
    unsigned char rd_mux_ctl;
    unsigned char reg_file_we;
    unsigned char reg_input_mux_ctl;
    unsigned char arith_ctl;
    unsigned char arith_mux_ctl;
    unsigned char logic_ctl;
    unsigned char logic_mux_ctl;
    unsigned char shift_ctl;
    unsigned char const_ctl;
    unsigned char cmp_ctl;
    unsigned char alu_mux_ctl;
    unsigned char nzp_we;
    unsigned char data_we;
} control_signals;


/*
 * Struct representing the complete state of the machine.
 */
typedef struct {
  // Current value of the program counter register
  unsigned short int PC;

  // Processor status register; bit[2]=N, [1]=Z, [0]=P, bit[15]=privilege bit
  unsigned short int PSR;

  // Machine registers - all 8
  unsigned short int R[8];

  // Machine memory - all rows
  unsigned short int memory[65536];

  // Control signals - struct containing all 16
  control_signals control;

} machine_state;

// signEXtend: extend the sign according to its efficient number of digits.
unsigned short int signExtend (unsigned short int input,int digitNum);
/*
 * Decodes instruction and sets control signals accordingly.
 * Params: instruction to decode and pointer to control signals struct.
 */

void printInstr(unsigned short int I);

void decode(unsigned short int I, control_signals* control);

/*
 * Resets all control signals to 0.
 * Param: pointer to control signals struct.
 */
void clear_signals(control_signals* control);

/*
 * Resets the machine state as PennSim would do.
 * Param: pointer to current machine state.
 */
void reset(machine_state* state);

/*
 * Updates the machine state, simulating a single clock cycle.
 * Returns 0 if update successful, a nonzero error code if unsuccessful.
 * Param: pointer to current machine state.
 */
int update_state(machine_state* state);

/*
 * Returns the current output of the RS mux.
 * Param: pointer to current machine state.
 */
unsigned short int rs_mux(machine_state* state);

/*
 * Returns the current output of the RT mux.
 * Param: pointer to current machine state.
 */
unsigned short int rt_mux(machine_state* state);

/*
 * Returns the current output of the ALU mux.
 * Params: pointer to current machine state, RS mux output, RT mux output.
 */
unsigned short int rd_mux(machine_state* state);
unsigned short int alu_mux(machine_state* state,
                           unsigned short int rs_out,
                           unsigned short int rt_out);

/*
 * Returns the current output of the register input mux.
 * Params: pointer to current machine state and current ALU mux output.
 */
unsigned short int reg_input_mux(machine_state* state,
                                 unsigned short int alu_out);

/*
 * Returns the current output of the PC mux.
 * Params: current RS mux output and pointer to current machine state.
 */
unsigned short int pc_mux(machine_state* state, unsigned short int rs_out);
#endif