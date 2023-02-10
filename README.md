# Real-Time-Clock-Implementation-on-FPGA
Implementation of a parallel write real-time clock on an FPGA interfaced with a microcontroller.

This project is a VHDL description of an RTC that uses a parallel read and write interface with a microcontroller. 
A 32.768kHz crystal source supplies an input waveform, and this description prescales the signal down to a second-long tick. 
These ticks are used to increment the current time, which can be reset at any given moment. 

The design is accompanied by a testbench to verify its design.

The description is used to target a Lattice FPGA.
