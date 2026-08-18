# NACA 4609 Aerodynamic Analysis: Thin Airfoil Theory, Joukowski Mapping, and Navier-Stokes CFD

## Overview
The objective of this study is to rigorously evaluate, compare and contrast the aerodynamic characteristics of the cambered NACA 4609 airfoil across a sweep of angle of attacks ranging from $0^\circ$ to $20^\circ$. By comparing theoretical baseline data against a viscous computational fluid dynamics (CFD) simulation, this study aims to explicitly demonstrate the breaking point of inviscid theory and highlight where viscous numerical modeling becomes essential.

## Theoretical & Numerical Framework
* **Thin Airfoil Theory (TAT):** A custom MATLAB algorithm and GUI developed to automate the computation of aerodynamic force coefficients and surface pressure distributions by placing a vortex sheet along the mean camber line.
* **Joukowski Conformal Mapping:** A classical technique used to map flow over a circle in the complex plane to an airfoil shape in the physical plane. This algorithm computes exact Kutta condition circulation while accounting for the physical thickness and camber of the airfoil.
* **Viscous Navier-Stokes CFD:** A ≈106,000-element, unstructured C-grid simulation utilizing the $k-\omega$ Shear Stress Transport (SST) turbulence model to capture boundary layer dynamics, flow separation, and viscous effects.

## Key Findings
* **Attached Flow Regime ($0^\circ \le \alpha \le 10^\circ$):** Classical inviscid methods provide highly accurate approximations of lift slope and pressure recovery. The Conformal Mapping approach showed surprising accuracy in the computation of the pressure distribution for this method accounts for airfoil thickness.
* **Limitations of Inviscid Theory:** As the angle of attack increases, the classical models fail to capture viscous effects and adverse pressure gradients, mathematically predicting the growth of lift beyond the physical stall regime.
* **Stall Prediction:** The viscous CFD successfully captures the onset of trailing-edge separation at $\alpha = 15^\circ$ and massive deep stall at $\alpha = 20^\circ$. 

Ultimately, this comparative investigation highlights the relevance and utility of classical inviscid theories for rapid conceptual design, while explicitly defining the limits where conducting full viscous numerical modeling becomes a necessity.

## Repository Structure
* `/MATLAB_Solvers`: Contains the custom TAT Graphical User Interface (GUI) and Joukowski mapping scripts.
* `/Navier_Stokes_CFD`: Contains the Ansys Fluent `.msh` file, convergence history tables, and boundary condition data.
* `/Report_and_Results`: Contains the final compiled academic report (PDF) alongside high-resolution surface pressure and velocity contour visualizations.
