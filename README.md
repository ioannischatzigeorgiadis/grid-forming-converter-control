# Grid Forming Converter Control and Current Limitation Under Grid Disturbances

**Diploma Thesis | Electrical and Computer Engineering | National Technical University of Athens (NTUA)**

## Overview

This project investigates the dynamic behavior, control, and current limitation of a three-phase Grid Forming (GFM) Voltage Source Converter (VSC) under balanced and unbalanced grid disturbances.

The study focuses on maintaining stable converter operation during grid faults while respecting converter current limits. Particular emphasis is placed on positive and negative sequence control, the coordination of current limiting strategies, and the trade-offs between voltage support, current protection, and dynamic performance.

The control system was developed and evaluated through simulations in PLECS, with MATLAB used for processing, visualization, and comparative analysis of simulation results.

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
- d-axis priority

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
- Combined grid disturbances

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

The repository is intended to contain the following material as it becomes available:

- `models/` — PLECS simulation models
- `matlab/` — MATLAB scripts for data processing and visualization
- `figures/` — Selected simulation results and technical diagrams
- `thesis/` — Diploma thesis document, subject to publication permissions

## Documentation and Results

Selected simulation figures, implementation files, and technical documentation will be added progressively.

## Author

**Yiannis Hatzigeorgiadis**

Electrical and Computer Engineering

National Technical University of Athens (NTUA)

[LinkedIn](https://www.linkedin.com/in/ioannis-chatzigeorgiadis/)
