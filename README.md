# RISC-V Implementation of 32-bits ALU & MIPS-like Single Cycle CPU
### Hw3 directory is 32-bits ripple carry 32 bits ALU.
### Hw4 directory is 32-bits single cycle cpu with following instructions available.
| Instruction Type | Instructions | 
|------------------|--------------|
| R-Type | add, sub, and, or, slt | 
| I-Type | addi, slti, ld |
| S-Type | sd |
| B-Type | beq |
| J-Type | jal |
**Decoding instructions with following table:**<br\>![Imgur](https://i.imgur.com/rNM9IJj.png)
> You can run these .v files through icarusverilog to compile and run the .out files.
ex. iverilog -o ".outfilename" testbench.v
