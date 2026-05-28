# 32×32 Focal Plane Array (FPA) Selector | Verilog Design

A **Verilog HDL** implementation of a 32×32 Focal Plane Array pixel selector using a row-column scanning architecture with 5-bit counters, 5-to-32 decoders, and cascaded control logic developed during an internship at **DRDO - Solid State Physics Laboratory (SSPL)**.

---

## Overview

A Focal Plane Array (FPA) is a 2D grid of photosensitive detector elements used in infrared imaging, thermal cameras, and sensing systems. Addressing each element individually from a controller requires one dedicated wire per pixel, i.e., 1024 lines for a 32×32 array, which is completely impractical in hardware.

This project solves that problem by implementing an efficient **row-column multiplexed addressing architecture**, reducing the physical control line count from 1024 down to just **64 lines** (32 row + 32 column), while still being able to uniquely activate any of the 1024 pixels in sequence.

---

## Problem Statement

| Approach | Control Lines Required | Complexity |
|---|---|---|
| Direct (naive) addressing | 1024 | Unsustainable |
| Row-column multiplexed (this design) | 64 (32 + 32) | Linear |

The row-column architecture achieves a **16× reduction** in physical routing overhead, with no loss in addressability.

---

## Architecture

The design follows a **synchronous raster-scan** pattern — identical to how a CRT or image sensor reads out pixels line by line.

```
         CLK / RST
              │
    ┌─────────┴─────────┐
    │                   │
5-bit Row Counter   5-bit Col Counter
    │     (cascades ←──  overflow)
    ▼                   ▼
5-to-32 Row Decoder  5-to-32 Col Decoder
    │                   │
    ▼                   ▼
row_sel[31:0]       col_sel[31:0]
    │                   │
    └────────┬──────────┘
             ▼
    Active pixel = row_sel[R] & col_sel[C]
    → Pixel (R, C) selected
```

### Sub-modules

| Module | Description |
|---|---|
| `counter_5bit` | 5-bit synchronous up-counter with synchronous reset; generates addresses 0–31 |
| `decoder_5to32` | 5-to-32 one-hot decoder; converts binary address to 32-bit one-hot select vector |
| `fpa_selector` | Top-level module; instantiates two counters and two decoders with cascade logic |
| `fpa_selector_tb` | Behavioral testbench; drives clock/reset and observes `row_sel` / `col_sel` outputs |

### Scanning Sequence

1. On `rst`, both counters reset to `0`. Pixel (0, 0) is active.
2. On every rising clock edge, the **column counter** increments - scanning left to right across row 0.
3. When the column counter reaches 31 and overflows, a cascade pulse increments the **row counter** - advancing to the next row.
4. After 1024 clock cycles, the full 32×32 array has been scanned once (one full frame).
5. The decoders continuously assert exactly **one bit** on each bus - guaranteeing a single pixel is active at all times.

### Pixel Addressing Example

```
Row counter    = 5'b00101  (decimal 5)  →  row_sel[5]  = 1, all others 0
Column counter = 5'b10010  (decimal 18) →  col_sel[18] = 1, all others 0
                                        →  Pixel (5, 18) uniquely selected
```

---

## Repository Structure

```
32x32-FPA-Selector/
├── 32x32 FPA Selector.srcs/
│   ├── sources_1/            # RTL design files
│   │   └── new/
│   │       ├── fpa_selector.v        # Top-level module
│   │       ├── counter_5bit.v        # 5-bit counter sub-module
│   │       └── decoder_5to32.v       # 5-to-32 decoder sub-module
│   └── sim_1/                # Simulation files
│       └── new/
│           └── fpa_selector_tb.v     # Behavioral testbench
├── 32x32 FPA Selector.xpr    # Vivado project file
├── fpa_selector.tcl           # Tcl script to recreate the project
├── fpa_selector_tb_behav.wcfg # Vivado waveform configuration
├── README.md
└── .gitignore
```

---

## Port Description

### Top-Level Module: `fpa_selector`

| Port | Direction | Width | Description |
|---|---|---|---|
| `clk` | Input | 1 | System clock |
| `rst` | Input | 1 | Synchronous active-high reset |
| `row_sel` | Output | 32 | One-hot row selection vector |
| `col_sel` | Output | 32 | One-hot column selection vector |

### Simulation Waveform (conceptual)

```
clk      _|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_
rst      ‾‾‾|_____________________________________
col_sel  XXXXX| 001 | 002 | 004 | 008 |...| 800000000 | 001 |...
row_sel  XXXXX| 001 | 001 | 001 | 001 |...| 001       | 002 |...
               col0   col1  col2  col3       col31(overflow→row++)
```

---

## Getting Started

### Prerequisites

- [Xilinx Vivado Design Suite](https://www.xilinx.com/support/download.html) (2020.x or later)
- A Xilinx FPGA target (Artix-7, Kintex-7, Zynq, etc.) — *or use simulation only*

### Option 1 — Open the existing Vivado project

```bash
git clone https://github.com/YugRaheja/32x32-FPA-Selector.git
```

Then in Vivado: **File → Open Project** → select `32x32 FPA Selector.xpr`

### Option 2 — Recreate from the Tcl script

```bash
git clone https://github.com/YugRaheja/32x32-FPA-Selector.git
vivado -mode batch -source fpa_selector.tcl
```

### Running Simulation

1. Open the project in Vivado.
2. In the **Flow Navigator**, click **Run Simulation → Run Behavioral Simulation**.
3. Load `fpa_selector_tb_behav.wcfg` to restore the pre-configured waveform view.
4. Verify that `col_sel` performs a 32-cycle one-hot barrel shift, and `row_sel` advances by one bit every 32 cycles.

---

## Key Results & Impact

By replacing direct addressing with row-column decoding, this design delivers:

- **16× fewer control lines** — from 1024 down to 64 (32 rows + 32 columns)
- **Silicon conservation** — reduced routing layers and gate count on the detector substrate
- **Power efficiency** — lower parasitic capacitance from fewer active routing traces
- **Scalability** — extending to 64×64 or 128×128 arrays requires only wider counters and decoders, with no architectural changes

---

## Tools Used

| Tool | Purpose |
|---|---|
| Verilog HDL | RTL design and testbench |
| Xilinx Vivado | Synthesis, simulation, waveform analysis |
| Tcl | Project build automation |

---

## Context

This design was developed as part of an internship at **DRDO — Solid State Physics Laboratory (SSPL)**, New Delhi, targeting infrared focal plane array readout applications.

---

## Topics

`fpga` `verilog-hdl` `rtl-design` `vlsi` `focal-plane-array` `image-sensor` `drdo` `decoder` `counter` `raster-scan`

---

## License
This project is open source. Feel free to use, modify, and distribute it. If you find it helpful, consider giving the repo a ⭐.

---

## Author

**Yug Raheja**
