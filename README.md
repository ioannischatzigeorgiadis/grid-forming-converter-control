# Grid Forming Converter Control and Current Limitation Under Grid Disturbances

**Diploma Thesis | Electrical and Computer Engineering | National Technical University of Athens (NTUA)**

## Overview

This project investigates the dynamic behavior, control, and current limitation of a three-phase Grid Forming (GFM) Voltage Source Converter (VSC) under balanced and unbalanced grid disturbances.

The study focuses on maintaining stable converter operation during grid faults while respecting converter current limits. Particular emphasis is placed on positive and negative sequence control, the coordination of current limiting strategies, and the trade-offs between voltage support, current protection, and dynamic performance.

The control system was developed and evaluated through simulations in PLECS, with MATLAB used for processing and visualization.

The complete diploma thesis provides a detailed presentation of the converter modeling, control architecture, current limitation strategies, simulation scenarios, and analysis of results.

**[Read the Full Diploma Thesis (PDF)](DIPLOMA_IOANNIS_FINAL.pdf)**

## Research Objectives

- Develop and simulate a three-phase GFM converter with positive and negative sequence control.
- Investigate converter behavior under symmetrical and asymmetrical grid disturbances.
- Implement and compare different current limitation methods.
- Evaluate the influence of current priority allocation on converter response.
- Analyze the trade-offs between current limitation, voltage regulation, and stable operation.

## System Modeling and Control Architecture

The studied system consists of a three-phase voltage source converter connected to an AC power system through an inductive interface.

The converter implements a hierarchical control architecture comprising:

### 1. Grid Forming Control

The positive sequence control includes:

- **Active Power Synchronization:** Active power–frequency droop control for synchronization with the power system.
- **Reactive Power Voltage Regulation:** Reactive power–voltage droop control for voltage reference generation.

### 2. Positive and Negative Sequence Control

Separate positive and negative sequence control paths are implemented to manage converter behavior under unbalanced operating conditions.

The control architecture incorporates:

- Double Decoupled Synchronous Reference Frame (DDSRF) sequence extraction.
- Voltage regulation using virtual admittance and PI-based control approaches.
- Synchronous reference frame current controllers.
- Measurement filtering and reference generation.

## Current Limitation Strategies

Three main categories of current limitation are investigated.

### Priority Based Current Limitation

Allocates available converter current capacity according to predefined priorities, including:

- Positive sequence priority
- Negative sequence priority

The effects of priority selection on current allocation and control performance are examined.

### Elliptical Current Limitation

Applies a coordinated scaling factor to positive and negative sequence current references to constrain the resulting phase current demand.

### Virtual Admittance Based Current Limitation

Adjusts the effective virtual admittance during overcurrent conditions to limit converter current while retaining voltage source behavior.

## Simulation Scenarios

The converter is evaluated under several grid disturbances:

- Single-phase voltage sags
- Two-phase voltage sags
- Three-phase symmetrical voltage sags
- Single-phase voltage phase jumps

The simulation results are analyzed in terms of:

- Point of Common Coupling (PCC) voltage
- Three-phase converter currents
- Positive sequence active and reactive power
- Positive and negative sequence dq currents
- Dynamic response and current limitation performance

## Tools and Technologies

- **PLECS:** Converter modeling, control implementation, and dynamic simulation
- **MATLAB:** Data processing, numerical analysis, and automated plotting
- **LaTeX:** Scientific documentation and thesis preparation

## Repository Structure

The repository contains the PLECS simulation model and MATLAB scripts developed for the implementation and analysis of the grid forming converter control system.

```text
grid-forming-converter-control/
│
├── README.md
│
├── models/
│   └── [PLECS simulation model]
│
├── matlab/
│   ├── [System parameters script]
│   └── [Simulation results processing scripts]
│
└── thesis/
    └── [Diploma thesis PDF]
```

The PLECS model implements the converter and its control system, while the MATLAB scripts support simulation data processing and visualization.

## Requirements

The project uses the following software:

- **PLECS Standalone:** For running the converter simulations and analyzing the control system.
- **MATLAB:** For parameter initialization, processing exported simulation data, and generating figures.

Software compatibility may depend on the versions and toolboxes installed.

## Running the Simulations

### Step 1 — Open the PLECS Model

Open the provided `.plecs` model using PLECS Standalone.

Ensure that that the model is configured for the intended simulation scenario.

### Step 2 — Configure the Grid Disturbance

Select the disturbance scenario to be investigated, such as:

- Single-phase voltage sag
- Two-phase voltage sag
- Three-phase voltage sag
- Voltage phase jump

The converter response can then be evaluated under the selected operating conditions and current limitation strategy.

### Step 3 — Run the Simulation

Execute the simulation in PLECS and examine the converter response, including PCC voltages, converter currents, and positive and negative sequence quantities.

### Step 5 — Process the Results in MATLAB

Export the required simulation signals and use the corresponding MATLAB scripts to process the results and generate comparative plots.

Some plotting scripts may require specific CSV filenames or directory structures. Their input requirements should be checked before execution.

## Simulation Outputs

The simulation framework is designed to investigate:

- Three-phase PCC voltages
- Three-phase converter currents
- Positive sequence active and reactive power
- Positive sequence dq currents
- Negative sequence dq currents
- Transient response under grid disturbances
- Performance of the implemented current limitation strategies

## Author

**Yiannis Hatzigeorgiadis**

Electrical and Computer Engineering

National Technical University of Athens (NTUA)

[LinkedIn](https://www.linkedin.com/in/ioannis-chatzigeorgiadis/)
