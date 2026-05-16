# Hamming(7,4) Encoder-Decoder System

A complete digital communication system implementing **Hamming(7,4) error detection and correction** using Verilog HDL.

This project demonstrates:

- Hamming(7,4) encoding
- Single-bit error injection
- Syndrome generation
- Single-bit error correction
- Recovery of original data

The system is fully modular and simulation-friendly, making it suitable for:
- Digital Design coursework
- Error Control Coding demonstrations
- FPGA implementation
- Verilog practice
- GitHub portfolio projects

---

# Features

- 4-bit input data
- 7-bit Hamming encoded output
- Configurable single-bit error injection
- Automatic error detection
- Automatic single-bit error correction
- Syndrome output for debugging
- Modular RTL architecture
- GTKWave compatible simulation

---

# Hamming(7,4) Overview

The Hamming(7,4) code uses:
- 4 data bits
- 3 parity bits

to create a:
- 7-bit protected codeword

It can:
- Detect up to 2-bit errors
- Correct 1-bit errors

---

# Bit Mapping

| Position | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|----------|---|---|---|---|---|---|---|
| Type     | P1 | P2 | D3 | P4 | D2 | D1 | D0 |

---

# Parity Equations

```math
P1 = D3 ⊕ D2 ⊕ D0
```

```math
P2 = D3 ⊕ D1 ⊕ D0
```

```math
P4 = D2 ⊕ D1 ⊕ D0
```

---

# Syndrome Generation

The decoder recomputes parity to generate the syndrome:

```math
S = S4 S2 S1
```

Where:
- `000` → No error
- Non-zero → Error position

Example:

| Syndrome | Error Position |
|----------|----------------|
| 001 | Bit 1 |
| 011 | Bit 3 |
| 101 | Bit 5 |
| 111 | Bit 7 |

---

# System Architecture

<img width="1367" height="601" alt="image" src="https://github.com/user-attachments/assets/27e4666d-2dc2-4a22-9587-8786c0d4168c" />


---

# Project Structure

```text
hamming74-system/
│
├── rtl/
│   ├── hamming74_encoder.v
│   ├── error_injector.v
│   ├── hamming74_decoder.v
│   └── hamming74_system.v
│
├── tb/
│   └── hamming74_system_tb.v
│
├── sim/
│   ├── waveform.vcd
│   └── waveform.png
│
├── docs/
│   └── block_diagram.png
│
└── README.md
```

---

# Module Description

## 1. Encoder

Generates parity bits and creates the 7-bit Hamming codeword.

### Inputs
- `data_in[3:0]`

### Outputs
- `code_out[6:0]`

---

## 2. Error Injector

Introduces a single-bit error at a selected position.

### Inputs
- `code_in[6:0]`
- `error_pos[2:0]`
- `enable`

### Outputs
- `code_out[6:0]`

---

## 3. Decoder

Detects and corrects single-bit errors using syndrome logic.

### Inputs
- `code_in[6:0]`

### Outputs
- `data_out[3:0]`
- `syndrome[2:0]`

---

## 4. Top Module

Integrates:
- Encoder
- Error Injector
- Decoder

### Outputs
- Original data
- Encoded data
- Corrupted data
- Syndrome
- Corrected data

---

# Simulation

## Compile

Using Icarus Verilog:

```bash
iverilog -o sim.out \
rtl/hamming74_encoder.v \
rtl/error_injector.v \
rtl/hamming74_decoder.v \
rtl/hamming74_system.v \
tb/hamming74_system_tb.v
```

---

## Run Simulation

```bash
vvp sim.out
```

---

## Open Waveform

```bash
gtkwave waveform.vcd
```

---

# Example

## Input

```text
data_in = 1011
```

## Encoded

```text
encoded_data = 0110010
```

## Inject Error at Bit 5

```text
corrupted_data = 0100010
```

## Syndrome

```text
syndrome = 101
```

## Corrected Output

```text
corrected_data = 1011
```

---

# Future Improvements

Possible extensions:

- SECDED (Single Error Correction Double Error Detection)
- FPGA implementation
- UART transmission
- Randomized error generation
- Burst error analysis
- Parameterized Hamming code generator
- SystemVerilog assertions
- UVM-based verification

---

# Applications

- Digital communication systems
- ECC memory systems
- Space electronics
- Fault-tolerant computing
- Data transmission systems

---

# Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave

---

# License

This project is open-source and available under the MIT License.
