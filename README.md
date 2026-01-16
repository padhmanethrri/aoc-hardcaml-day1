# Advent of FPGA Challenge – Verilog Solutions

This repository contains my solutions for the Advent of FPGA Challenge, implemented
using synthesizable Verilog.

The goal of this work is to explore how algorithmic problems from Advent of Code can
be mapped onto realistic hardware architectures, with explicit state, clocked behavior,
and streaming data processing rather than CPU-style batch computation.

## Motivation

Advent of Code problems are traditionally solved in software, but they also provide
an opportunity to think in terms of hardware architecture, dataflow, and throughput.

For this project, Verilog was chosen to directly express RTL-level hardware behavior.
The emphasis is on writing clear, parameterized, and synthesis-friendly code that
reflects real FPGA and ASIC design practices.

## Repository Structure

Solutions are organized by day and part, following the Advent of FPGA structure.

Each part contains:
- Verilog RTL source files
- A self-checking testbench
- Input files used during simulation
- A README describing the design approach and architectural decisions

Example structure:

aoc-hardcaml-day1/
└── part1/
    ├── day1_safe.v
    ├── tb_day1_safe.v
    ├── input.txt
    └── README.md

The RTL and testbench are intentionally separated to mirror standard hardware
development workflows.

## Current Status

- **Day 1**
  - Part 1 completed and validated
  - Fully streaming RTL design
  - Verified using cycle-accurate simulation with full puzzle input

## How to Run

Each part includes a Verilog testbench that reads the puzzle input from a text file,
drives the design cycle by cycle, and prints the final result.

Simulation can be run using standard Verilog simulators such as Icarus Verilog.

## Notes

The focus of this repository is on correctness, clarity, and hardware-oriented
modeling rather than purely software-style logic. All designs are written to be
synthesizable and structured in a way that allows future exploration of scalability,
parallelism, and architectural trade-offs.

All code in this repository represents original work and can be reasoned about
directly at the RTL level.
