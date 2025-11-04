# Trade-off Evaluation Through Refined Exact Epsilon-Constraint Solver (TETREES)

**TETREES** is a Python-based optimization framework that leverages the Gurobi solver and implements the **exact ε-constraint** method to address the limitations of conventional multi-objective optimization techniques, particularly addressing service-to-resource assignment problems.

## Getting TETREES

TETREES is available via Git at [this link](https://github.com/fdrcdtrz/TETREES). To obtain TETREES enter into the your prefered folder and write the following syntax:
```
$ git clone https://github.com/fdrcdtrz/TETREES.git
```
To synchronize the project repository with the local copy, you can run the pull sub-command. The syntax is as follows:
```
$ git pull
```
To run the framework you also need:

- MATLAB software, available at [this link](https://www.mathworks.com/help/install/ug/install-products-with-internet-connection.html);
- Gurobi Optimization (with a valid license). First of all, obtain your Gurobi Optimization license: you will see it on the Gurobi Optimization website, section User Portal. In the licenses tab, locate your license ID, click the installation icon. A window will pop up with a guide to follow. You'll be asked to install the Gurobi Optimizer software on your computer ([via this link](https://www.gurobi.com/downloads/gurobi-software/)), download the license through the _Download License_ button, and then install it via the suggested command  (e.g., 'grbgetkey <license-key>'; copy and input it in a command/terminal prompt. This command required an active internet connection to communicate with the Gurobi servers.

> [!NOTE]
> Getting a Gurobi license allows you to run bigger instances of the optimization problem.


## Setting TETREES up

All the experiments outputs are stored in a project folder titled `results_dir`, which is a parameter you can modify in `main.py`, before you specify the local path of the project folder, `path_locale`. You can then choose to run either:
- the main optimization provided by TETREES, or 
- three benchmark schemes, namely the random, greedy KPI, and greedy KVI approaches, respectively. 

If you plan to run the epsilon-constraint optimization provided by TETREES, make sure the section in `main.py` titled _EPSILON-CONSTRAINT METHOD: COMPUTATION OF IDEAL AND NADIR POINTS AND EXACT-METHOD IMPLEMENTATION_ is uncommented, while the following one titled _BENCHMARK APPROACHES: GREEDY ASSIGNMENT KPI, KVI AND RANDOM ASSIGNMENT_ is commented (and viceversa if you wish to run benchmarks). 

## Customizing TETREES
TETREES can be fully customized for service-to-resource assignment problems.
The main configurable components are:

### Services 

Characterized by:
- Number and type of services.
- Deadlines, packet loss rate, data rate, size, and impact.

### Resources 

Defined by:
- Demand, number, availability, carbon offset.
- Offered deadline, data rate, and packet loss rate.
- Power consumption per core and per memory unit (`P_c`, `P_m`).
- Core usage factor (`u_c`), processing capability (`fpc`).
- Average demand per hour, mean time to failure (`lambda_failure`), and likelihood of attacks.

### Optimization Parameters 

Specified in optimization.py, including:
delta – ε-step size for discretization
KPI and KVI weights
Gurobi solver parameters:
MIPGap: allowable optimality gap between the best feasible solution and the theoretical bound
MIPFocus: solver emphasis (e.g., finding feasible solutions fast vs. proving optimality)
VarBranch: branching strategy (e.g., reduced-cost or strong branching)
Global parameters such as the carbon intensity factor (CI) and power usage effectiveness (PUE) can also be configured.
For a complete explanation of parameters and methodology, refer to the paper:
Exact ε-constraint optimization for service-to-resource assignment (Computer Communications, 2025)

## Running a simulation with TETREES

# Links to the example headings above

Link to the Getting TETREES section: [Get TETREES](#getting-tetrees).

Link to the Setting TETREES up section: [Set up](#setting-tetrees-up).

Link to the Customizing TETREES section: [Link Text](#customizing-tetrees).

Link to the Running a simulation with TETREES section: [Link Text](#running-tetrees).
