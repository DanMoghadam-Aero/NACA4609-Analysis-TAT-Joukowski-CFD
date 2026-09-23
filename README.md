# NACA 4609 Aerodynamic Analysis: Thin Airfoil Theory, Joukowski Mapping, and Navier-Stokes CFD

## Overview
The objective of this study is to rigorously evaluate, compare, and contrast the aerodynamic characteristics of the cambered NACA 4609 airfoil across a sweep of angles of attack ranging from $0^\circ$ to $20^\circ$. By comparing theoretical baseline data against a viscous computational fluid dynamics (CFD) simulation, this study aims to explicitly demonstrate the limitations of inviscid theory and highlight where viscous modeling becomes necessary.

## Full Report

The complete mathematical formulation, numerical methodology, grid-independence study, aerodynamic comparisons, and flow-field results are available in the full report:

[Read the complete NACA 4609 Aerodynamic Analysis Report](./Report_and_Results/NACA4609_Aerodynamic_Analysis_Report.pdf)

## Theoretical & Numerical Framework
* **Thin Airfoil Theory (TAT):** A custom MATLAB algorithm and GUI developed to automate the computation of aerodynamic force coefficients and surface pressure distributions by placing a vortex sheet along the mean camber line.
* **Joukowski Conformal Mapping:** A classical technique used to map flow over a circle in the complex plane to an airfoil shape in the physical plane. This algorithm computes exact Kutta condition circulation while accounting for the physical thickness and camber of the airfoil.
* **Viscous Navier-Stokes CFD:** An approximately 106,000-element, unstructured C-grid simulation utilizing the $k-\omega$ Shear Stress Transport (SST) turbulence model to capture boundary layer dynamics, flow separation, and viscous effects.

## Key Findings
* **Attached Flow Regime ($0^\circ \le \alpha \le 10^\circ$):** Classical inviscid methods provide highly accurate approximations of lift slope and pressure recovery. The Conformal Mapping approach showed surprisingly accurate pressure-distribution predictions, as it accounts for airfoil thickness.
* **Limitations of Inviscid Theory:** As the angle of attack increases, the classical models fail to capture viscous effects and adverse pressure gradients, mathematically predicting the growth of lift beyond the physical stall regime.
* **Stall Prediction:** The viscous CFD successfully captures the onset of trailing-edge separation at $\alpha = 15^\circ$ and deep stall at $\alpha = 20^\circ$. 

Ultimately, this comparative investigation highlights the relevance and utility of classical inviscid theories for rapid conceptual design, while explicitly defining the limits where full viscous CFD becomes necessary.

## Repository Structure
* `/MATLAB_Solvers`: Contains the custom TAT Graphical User Interface (GUI) and Joukowski mapping scripts.
* `/Navier_Stokes_CFD`: Contains the ANSYS Fluent `.msh` file, convergence history tables, and boundary condition data.
* `/Report_and_Results`: Contains the final compiled academic report (PDF) alongside high-resolution surface pressure and velocity contour visualizations.

* ## Citation

If you reference or build upon this project, the following BibTeX entry may be used:

```bibtex
@techreport{moghadam2026naca4609,
  author      = {Moghadam, Danial},
  title       = {NACA 4609 Aerodynamic Analysis: Thin Airfoil Theory, Joukowski Mapping, and Navier--Stokes CFD},
  institution = {Independent Research},
  year        = {2026},
  month       = {August},
  type        = {Technical Report},
  url         = {https://github.com/DanMoghadam-Aero/NACA4609-Analysis-TAT-Joukowski-CFD},
  note        = {GitHub repository}
}
```

## Author

**Danial Moghadam**  
M.Sc. in Aerospace Engineering -- Aerodynamics  
Independent Research  
[GitHub Portfolio](https://github.com/DanMoghadam-Aero)  
Email: [dan998m@gmail.com](mailto:dan998m@gmail.com)
