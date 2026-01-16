# Day 1 – Part 2 (Verilog)

This directory contains my solution for Day 1, Part 2 of the Advent of FPGA Challenge,
implemented in synthesizable Verilog.

Part 2 builds directly on the ideas introduced in Part 1, but introduces additional
state and control complexity. The goal was not only to extend the functionality, but
to do so in a way that remains hardware-oriented, scalable, and suitable for streaming
execution.

## File Overview

- `day2_safe.v`  
  Contains the core RTL logic for Part 2. The design extends the Part 1 architecture
  by maintaining additional state and applying more complex update rules while still
  operating on a streaming input.

- `tb_day2_safe.v`  
  A self-checking testbench that reads the puzzle input from `input.txt`, drives the
  design cycle by cycle, and prints the final computed result.

- `input.txt`  
  Puzzle input used to validate the implementation against the full problem dataset.

## Design Approach

The Part 2 problem was first analyzed to identify how the additional rules affect state
updates compared to Part 1. Rather than restructuring the design entirely, the existing
streaming model was preserved and extended.

The RTL processes one input element per cycle and updates internal registers based on
the current input and stored state. All behavior is expressed using explicit registers,
combinational logic, and synchronous clocked updates, closely mirroring how the logic
would behave in real hardware.

No full-input buffering is required; the design consumes each input exactly once.

## Architectural Differences from Part 1

Compared to Part 1, this design introduces:

- Additional state registers to track extended problem constraints
- More complex combinational decision logic per cycle
- A richer update path while preserving a single-pass streaming model

Despite these changes, the fundamental architecture remains simple and predictable,
avoiding unnecessary control FSMs or memory structures.

## Scalability

The design has no dependence on the total input size.

As a result:
- Inputs 10× larger require no RTL changes
- Inputs 1000× larger require no RTL changes
- Processing remains one input per cycle

The only factor that scales is the number of cycles required to process the input,
making the design suitable for large datasets and continuous streams.

## Efficiency and Hardware Cost

The implementation prioritizes clarity and correctness while remaining efficient:

- Small, fixed number of registers
- Simple arithmetic and comparison logic
- No dynamic memory allocation or large arrays

This results in a compact design with deterministic timing. If needed, further
area/performance trade-offs could be explored by tightening bit-widths or restructuring
the update logic.

## Exploiting Hardware Parallelism

Although the problem is sequential in nature, the hardware implementation benefits
from parallelism within each clock cycle:

- Multiple comparisons and state updates occur simultaneously
- No instruction sequencing or branching penalties
- Deterministic, cycle-accurate execution

This highlights how even control-heavy problems can be expressed cleanly in hardware.

## Verilog Techniques Used

The RTL intentionally follows best practices for synthesizable Verilog:

- Clear separation of combinational and sequential logic
- Non-blocking assignments for all state updates
- Parameterized widths where appropriate
- No simulation-only constructs in the design logic

These choices result in readable RTL that maps cleanly to FPGA or ASIC implementations.

## Testing and Verification

Verification is performed using `tb_day2_safe.v`. The testbench:

- Reads input from `input.txt`
- Drives the design one cycle per input
- Observes the final output after simulation completes

This approach mirrors standard hardware verification workflows and allows easy
regression testing with different input sets.

## Summary

This Part 2 implementation demonstrates how additional problem complexity can be
handled without abandoning a clean, streaming hardware architecture.

By extending the Part 1 design rather than replacing it, the solution emphasizes
incremental hardware refinement, explicit state management, and scalability — all
key aspects of real-world RTL design.
