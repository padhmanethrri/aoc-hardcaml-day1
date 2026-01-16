# Day 1 – Part 1 (Verilog)

This directory contains a synthesizable Verilog implementation of Day 1, Part 1 of
the Advent of FPGA Challenge.

The design focuses on expressing the problem as a streaming hardware computation
rather than a software-style loop, allowing the same RTL to scale naturally with
input size.

## File Overview

- `day1_safe.v`  
  Implements the core computation logic as a clocked, streaming RTL module.
  The design processes one input value per cycle and updates internal state
  using explicit registers.

- `tb_day1_safe.v`  
  A self-checking testbench that reads input values from a text file, applies
  them to the design cycle by cycle, and reports the final result.

- `input.txt`  
  Puzzle input used for validation.

## Design Approach

Before writing RTL, the problem was analyzed to identify the minimal state and
operations required for correct computation. The solution was then mapped to
hardware using explicit registers, combinational logic, and synchronous updates.

Rather than buffering the full input, the design operates on a stream of values.
Each input is consumed exactly once, and the accumulated result is updated
incrementally.

## Scalability

The design has no dependency on input length or fixed-size buffers.

As a result:
- Inputs 10× larger require no changes
- Inputs 1000× larger require no changes
- Throughput remains one input per cycle

The only scaling factor is total simulation or execution time, which grows linearly
with the number of input elements.

## Efficiency and Area Considerations

The RTL uses:
- A small number of registers
- Simple combinational comparisons
- No complex control FSMs

This results in a compact design with predictable timing behavior. If desired,
area and performance trade-offs could be explored by adjusting bit widths or
adding additional pipelining.

## Architecture and Parallelism

The design exploits hardware parallelism that is not available in software:

- Comparisons and state updates occur within a single clock cycle
- No instruction sequencing or branching
- Deterministic, cycle-accurate execution

This structure makes the design suitable for FPGA implementation and demonstrates
how even simple problems can benefit from hardware-oriented thinking.

## Verilog Techniques Used

Although written in plain Verilog, the design intentionally uses:
- Parameterized widths to avoid hard-coded assumptions
- Clear separation of combinational and sequential logic
- Non-blocking assignments for all state updates
- Synthesizable constructs only (no simulation-only shortcuts)

These techniques result in RTL that is both readable and synthesis-friendly.

## Testing and Verification

The testbench drives the design using realistic inputs from `input.txt` and
verifies correctness by observing the final accumulated output.

This mirrors standard hardware verification practices and allows easy regression
testing with different input sets.

## Summary

This implementation demonstrates how a simple Advent of Code problem can be
reformulated as a scalable, streaming hardware accelerator using careful RTL
design in Verilog.

The focus is not only on correctness, but on expressing the computation in a way
that aligns with how real hardware operates.
