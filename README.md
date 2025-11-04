# Trade-off Evaluation Through Refined Exact Epsilon-Constraint Solver (TETREES)

TETREES is a Python-based optimization framework that leverages the Gurobi solver and implements the exact ε-constraint method to address the limitations of conventional multi-objective optimization techniques, particularly addressing service-to-resource assignment problems.

## Getting TETREES

TETREES is available via Git at this link. To obtain TETREES enter into the your prefered folder and write the following syntax:
```
$ git clone https://github.com/fdrcdtrz/TETREES.git
```
To synchronize the project repository with the local copy, you can run the pull sub-command. The syntax is as follows:
```
$ git pull
```
To run the framework you also need:

- MATLAB software, available at this link; https://www.mathworks.com/help/install/ug/install-products-with-internet-connection.html
- Gurobi Optimization software and license. First of all, obtain your Gurobi Optimization license: you will see it on the Gurobi Optimization website, section User Portal. In the licenses tab, for a license with a given ID, click the installation icon on the right. A window will pop up with a guide to follow. You'll be asked to install the Gurobi Optimizer software on your computer (https://www.gurobi.com/downloads/gurobi-software/), download the license through the red Download License button, and then install it via the suggested command  (e.g., 'grbgetkey <license-key>'; copy and input it in a command/terminal prompt. This command required an active internet connection to communicate with the Gurobi servers.
Getting a Gurobi license allows you to run bigger instances of the optimization problem.


## Setting TETREES up

All the run experiments and simulations will be stored in a project titled 'results_dir', which is a parameter you can modify in 'main.py', before you specify the local path of the project folder, 'path_locale'. You then have the chance to run the main optimization provided by TETREES or a benchmark scheme to compare TETREES with, namely the random, greedy KPI, and greedy KVI approaches, respectively. If you plan to run the epsilon-constraint optimization provided by TETREES, make sure the section in 'main.py' titled _EPSILON-CONSTRAINT METHOD: COMPUTATION OF IDEAL AND NADIR POINTS AND EXACT-METHOD IMPLEMENTATION_ is not commented, while the following one titled _BENCHMARK APPROACHES: GREEDY ASSIGNMENT KPI, KVI AND RANDOM ASSIGNMENT_ is, and viceversa for the benchmark approaches. 

# Links to the example headings above

Link to the Introduction section: [Link Text](#trade-off-evaluation-through-refined-exact-epsilon-constraint-solver-(TETREES)).

Link to the Getting TETREES section: [Link Text](#getting-tetrees).

