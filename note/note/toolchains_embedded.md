# compiler 
## GCC
in the computer when we install the compiler 

```bash
sudo apt install gcc
```

This act as the native compiler under the architecture of the computer (which is x86_64)
and this "gcc" translate the C code for into the x86_64 machine code only my computer can understand and it also imply that it is managed by Linux operating system
which provide a terminal for printf to give output too

## The Cross Compilation
because the computer x86_64 and the micro controller (ARM cortex M4) has different architecture and also different brain
so we install the tool on the x86_64 that the host can run this tool and this tool will generate the machine for not for the host but for the target that in tool is built for 
which is ARM CORTEX-M4 - the compiler will be gcc-arm-none-eabi

We can also know this through the esp32 project that we installed the tool for esp32 
riscv32-esp-elf-gcc

```bash
sudo apt install gcc-arm-none-eabi
```

"eabi" stand for: Embedded Application Binary Interface  (haven't learn much about this yet)

# Binary Utilities
binutils-arm-none-eabi
# the Binutils
in the native C when we use gcc to compiler C code behind the scene this call a linux version of binutils to do the job (such as "as" and "ld"). 
It can do this because it know exactly how the standarnd linux OS work with the hardware.
So the Linux linker can just slaps our code together and let the OS handle everything about the memory inside of the architecture

But in the micro controller we don't have OS our code need to know exactly where is the physical address is before it ever touch the board 
That's why we need the ARM Linker provided by the vendor with the linker script .ld 

## when the Linker finish codes together 
This bundle of code turn of to be the .elf fine (executable and linkable format)
- on Linux the laptop know how to read this file (it know how to read the metadata), setup memory and run it 
- on STM32 this chip has no idea what is this .elf file is. If we load this file to the micro controller it will crash 
and this tool arm-none-eabi-objcopy will strip away all the computer-readable  metadata and extract pure, raw .bin file that contains nothing but pure voltage 
instructions for the STM32's flash memory 

Inspecting the Damage (size and objdump)

On a laptop, you have gigabytes of RAM. You don't usually care if your program is 50KB or 500KB.
Your STM32F446RE has 512KB of Flash and 128KB of RAM. You will use arm-none-eabi-size constantly to check exactly how much memory you have left, ensuring you don't accidentally overflow your microcontroller's tiny brain.

```bash
sudo apt install binutils-arm-none-eabi
```



