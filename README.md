# 32×32 Focal Plane Array (FPA) Selector | Verilog Design

## Overview
This project implements a **32×32 Focal Plane Array (FPA) Selector** in **Verilog HDL**, developed during my internship at **DRDO - Solid State Physics Laboratory (SSPL)**.

The design provides an efficient hardware addressing mechanism for selecting individual pixels/elements in a 32×32 focal plane array using a **row-column scanning architecture**, significantly reducing control complexity compared to direct addressing.

Instead of individually controlling all **1024 array elements**, the architecture uses counters and decoders to generate one-hot row and column selection signals.

---

## Problem Statement
A 32×32 focal plane array contains:
- **32 rows**
- **32 columns**
- **1024 total selectable elements**

Directly controlling each element would require 1024 independent control lines, leading to massive routing complexity, unsustainable hardware overhead, and poor scalability. This project solves the problem by implementing an efficient, multiplexed digital selector architecture that cuts the physical control line requirements down drastically.

---

## Architecture
The selector is based on a synchronous **row-column addressing mechanism**. 

### Components Used
* **5-bit Row Counter (`counter_5bit`):** Generates row addresses ranging from `00000` to `11111` (0 to 31).
* **5-bit Column Counter:** Generates column addresses ranging from `00000` to `11111` (0 to 31).
* **5-to-32 Row Decoder:** Converts the 5-bit row binary address into a one-hot 32-bit row selection vector (`row_sel[31:0]`).
* **5-to-32 Column Decoder:** Converts the 5-bit column binary address into a one-hot 32-bit column selection vector (`col_sel[31:0]`).
* **Control Logic:** Coordinates scanning and selection timing, advancing the column counter on every clock edge and cascading to the row counter upon column roll-over.

---

## Working Principle
1. On a system reset (`rst`), both row and column counters initialize to zero, selecting the origin pixel (0,0).
2. With every active clock edge, the column counter increments, scanning across the selected row.
3. Upon completing a full row scan (column 31 reaching overflow), a cascade signal increments the row counter, shifting focus to the next consecutive row.
4. The decoders convert these internal binary addresses into 32-bit one-hot vectors.
5. The unique physical intersection of the active row line and active column line isolates and selects exactly **one FPA element** at any given instant.

### Example Mapping:
* Internal Row Address = `00101` $\rightarrow$ Decoded to `row_sel[5] = 1`
* Internal Column Address = `10010` $\rightarrow$ Decoded to `col_sel[18] = 1`
* **Resulting Action:** Pixel (5,18) is uniquely active out of 1024 possible array locations.

---

## Simulation & Verification
Verification was conducted via behavioral simulation utilizing a custom Verilog testbench (`fpa_selector_tb.v`). 

* **Test Strategy:** Asserted system reset, observed initialization parameters, and forced consecutive clock cycles to observe the sequential stepping behavior of the 32-bit buses.
* **Observed Outputs:** Validated that `col_sel` properly executes a 32-cycle barrel shift pattern before clearing back to bit-0, concurrently triggering a single-bit shift in the `row_sel` vector. No invalid multi-hot states were detected during transition periods.

---

## Conclusion & Impact
By transitioning from an elemental direct-addressing layout to a matrix-style row-column decoding architecture, the physical connection footprint was compressed from **1024 direct lines down to just 64 physical lines** (32 rows + 32 columns). 

This reduction yields critical design advantages for infrared sensing and imaging applications developed at **DRDO-SSPL**:
1. **Silicon Conservation:** Dramatically reduces the required routing layers and logic gate count on the target array substrate.
2. **Scalability:** Establishes a modular logic baseline that can be scaled effortlessly to larger array architectures (e.g., 64×64 or 128×128) with minimal proportional increases in control line overhead.
3. **Power Efficiency:** Mitigates parasitic routing capacitance across the array fabric, driving down active dynamic power consumption during high-frequency array raster scans.
