# Advent of FPGA Challenge — Day 1 (Verilog)

This repository contains my solutions for Day 1 of the Advent of FPGA Challenge,
implemented in synthesizable Verilog.

The purpose of this work is to explore how problems typically solved in a software
context can be reformulated as hardware-oriented designs, with explicit state,
clocked behavior, and streaming data processing.

Rather than translating software logic directly into RTL, the focus is on expressing
the computation in a way that aligns with how real hardware operates.

## Motivation

Advent of Code problems are usually approached using sequential software algorithms.
However, many of these problems can be naturally expressed as streaming hardware
pipelines when viewed from an architectural perspective.

This project uses Verilog directly to:
- model explicit state using registers
- process inputs incrementally rather than in batches
- explore scalability and throughput from a hardware standpoint

The intent is not aggressive micro-optimization, but clear, correct, and realistic
RTL design that could map cleanly to FPGA or ASIC implementations.

## Repository Structure

The repository is organized by problem part, following the Advent of FPGA format.

Each part contains:
- Verilog RTL source files implementing the design
- A self-checking testbench
- Input files used during simulation
- A README describing the design approach and architectural decisions

Current structure:

aoc-hardcaml-day1/
- part1/
  - day1_safe.v
  - tb_day1_safe.v
  - README.md
- part2/
  - day2_safe.v
  - tb_day2_safe.v
  - input.txt
  - README.md

The design and testbench are intentionally separated to mirror standard hardware
development workflows.

## Current Status

Day 1:
- Part 1 completed and validated
- Part 2 completed and validated
- Both parts implemented as streaming RTL designs
- Correctness verified using cycle-accurate simulation with the full puzzle input

## How to Run

Each part includes a Verilog testbench that:
- reads the puzzle input from a text file
- drives the design cycle by cycle
- prints the final computed result after simulation completes

Simulation can be run using standard Verilog simulators such as Icarus Verilog.

No FPGA synthesis or physical implementation is required for this challenge, though
the RTL is written to remain synthesizable.

## Design Principles

Across both parts, the designs emphasize:

- Streaming computation  
  Inputs are processed one element per cycle with no dependency on total input size.

- Scalability  
  The same RTL works for small test cases and significantly larger inputs without
  modification.

- Explicit state modeling  
  All state is represented using registers with clear clocked updates.

- Hardware-oriented structure  
  The designs avoid software-style control flow and instead rely on predictable,
  cycle-accurate behavior.

## Notes

The focus of this repository is on clarity, correctness, and hardware-style modeling
rather than maximum performance tuning. Each design can be explained and reasoned
about directly at the RTL level.

All code in this repository represents original work and reflects an intentional
hardware-centric approach to solving Advent of FPGA problems.
