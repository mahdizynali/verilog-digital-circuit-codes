# Verilog Digital Circuit Codes

A compact collection of basic digital circuit modules written in **Verilog HDL**.

This repository contains simple, beginner-friendly implementations of common combinational logic circuits such as adders, multiplexers, arithmetic units, logic units, and shift units. It is useful for students, hardware design beginners, and anyone learning Verilog through small practical examples.

---

## Circuits Included

| File | Description |
|---|---|
| `halfAdder.v` | Half adder implementation |
| `fullAdder.v` | Full adder implementation |
| `fullAdder_8bit.v` | 8-bit ripple-carry full adder |
| `mux2to1.v` | 2-to-1 multiplexer |
| `mux4to1.v` | 4-to-1 multiplexer |
| `mux4to1_8bit.v` | 8-bit 4-to-1 multiplexer |
| `arithmaticUnit.v` | Basic arithmetic unit |
| `logicUnit.v` | Basic logic unit |
| `shiftLeftUnit.v` | Shift-left unit |
| `shiftRightUnit.v` | Shift-right unit |

---

## Features

- Written in pure Verilog
- Simple and readable module-based design
- Useful for digital logic and HDL practice
- Includes basic building blocks used in ALU design
- Good starting point for simulation, testing, and FPGA learning

---

## Example Usage

You can use each module independently in your own Verilog projects.

Example full adder module usage:

```verilog
fullAdder FA0 (
    .x(a),
    .y(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);
```

Example 8-bit adder usage:

```verilog
fulladder_8bit ADD8 (
    .x(input_a),
    .y(input_b),
    .cin(cin),
    .sum(result),
    .cout(carry_out)
);
```

---

## Simulation

You can simulate the Verilog files using tools such as:

- Icarus Verilog
- ModelSim
- Vivado
- Quartus
- GTKWave

Example using Icarus Verilog:

```bash
iverilog -o output fullAdder.v
vvp output
```

For files that include a testbench:

```bash
iverilog -o sim arithmaticUnit.v
vvp sim
```

---

## Learning Goals

This repository is useful for understanding:

- Basic logic gates
- Half adders and full adders
- Ripple-carry addition
- Multiplexer design
- Bitwise logic operations
- Shift operations
- Simple ALU-style circuit composition
- Structural Verilog design

---

## Suggested Improvements

Future improvements for this repository:

- Add separate testbench files
- Add waveform screenshots
- Add timing diagrams
- Add truth tables for each circuit
- Add synthesis-ready versions
- Add ALU integration example
- Add comments explaining each module

---
