  - Writing a compiler in C 
  https://www.youtube.com/watch?v=-4RmhDy0A2s&list=PLRnI_2_ZWhtA_ZAzEa8uJF8wgGF0HjjEz&index=1
# History
  Related to the Unix Kernel of Dennis Ritchie, at his time there were several high programming language lik Fortran or PL/I, but they were designed for math or business. They lacked the low-level memory control needed to write an operating system, or their compilers were too large and slow to run on the small minicomputers used for Unix.

  Programming language B was a "typeless" language, it only had one data type (the machine word). The new PDP-11 computer that Unix was being moved to was byte-addressable. B could not efficiently handle individual bytes or character data. 
  C was created specifically to add data types (like char and int) and hardware-level byte addressing to B. (there is the programming language name A before so it's quite funny that he name it is C)


- C was essentially a massive upgrade to B. The first C compiler was written in B and compiled using the existing B compiler.
So fundamentally we just the not let the computer or the OS know what to do when a certain code do something in assembly or machine code, so we basically can write the compiler in any language with the existing compiler just depend on how we would like it to be.


# Write component of a compiler
  There are Stages of compiler for create the final Executable 
  And for the stage to give out the assembly code we will need the *compiler driver*
## Compiler driver 
- This component acts as a testing framework
- The driver is the wrapper that controls everything shown in that diagram (Preprocessor → Compiler → Assembler → Linker).
  - Allow us debug block by block easily without waiting for the final executable code get wrong to fix.

By writing the driver first, when we build a automated pipeline that handles the preprocessor (giving your compiler the correct input) and the assembler/linker (turning our compiler's output into a runnable executable). This allows us to immediate run and thest the output of our compiler as we build it layer by layer.

-> The driver is the wrapper that controls everything shown in that diagram (Preprocessor → Compiler → Assembler → Linker). 

- It is just a concept, it isn't a file or something fixed, like a car can be make of anything as long as it drive you to the destination 

- So we tried to write the compiler driver without any library in C so we use bash script for it
  - Which includes 3 steps:
    - step 1: Preprocess
      The driver takes 
   

## Compiler cores

### The lexer

### Parser

### Code generator



