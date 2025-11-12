# Trade-off Evaluation Through Refined Exact Epsilon-Constraint Solver (TETREES)

**TETREES** is a Python-based optimization framework that leverages the Gurobi solver and implements the **exact ε-constraint** method to address the limitations of conventional multi-objective optimization techniques, particularly addressing service-to-resource assignment problems.

---

## Table of Contents
- [Getting TETREES](#getting-tetrees)
- [Setting TETREES up](#setting-tetrees-up)
- [Customizing TETREES](#customizing-tetrees)
- [Running a simulation with TETREES](#running-a-simulation-with-tetrees)
- [Plotting the results of a simulation with TETREES](#plotting-the-results-of-a-simulation-with-tetrees)
- [Additional Support](#additional-support)
- [License](#license)


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
- Gurobi Optimization (with a valid license). First of all, obtain your Gurobi Optimization license: you will see it on the Gurobi Optimization website, section User Portal. In the licenses tab, locate your license ID, click the installation icon. A window will pop up with a guide to follow. You'll be asked to install the Gurobi Optimizer software on your computer ([via this link](https://www.gurobi.com/downloads/gurobi-software/)), download the license through the _Download License_ button, and then install it via the suggested command  (e.g., `grbgetkey <license-key>`; copy and input it in a command/terminal prompt. This command requires an active internet connection to communicate with the Gurobi servers.

> [!NOTE]
> Getting a Gurobi license allows you to run bigger instances of the optimization problem.



## Setting TETREES up

All the experiments outputs are stored in a project folder titled `results_dir`, which is a parameter you can modify in `main.py`, before you specify the local path of the project folder, `path_locale`. You can then choose to run either:
- the main optimization provided by TETREES, or 
- three benchmark schemes, namely the random, greedy KPI, and greedy KVI approaches, respectively. 

If you plan to run the ε-constraint optimization provided by TETREES, make sure the section in `main.py` titled _EPSILON-CONSTRAINT METHOD: COMPUTATION OF IDEAL AND NADIR POINTS AND EXACT-METHOD IMPLEMENTATION_ is uncommented, while the following one titled _BENCHMARK APPROACHES: GREEDY ASSIGNMENT KPI, KVI AND RANDOM ASSIGNMENT_ is commented (and viceversa if you wish to run benchmarks). 



## Customizing TETREES
TETREES can be fully customized for service-to-resource assignment problems.
The main configurable components are:

### 👥 Services 

Characterized by:
- Number and type of services.
- Deadlines, packet loss rate, data rate, size, and impact.

The loop `for i in range(num_services_type)` allows to generate the service types: this block can be customized as preferred. The list `probabilities` allows to bias the occurrence of certain service types: with the baseline setup, service type 7 appears more frequently, which represents a higher demand for that kind of service. Then, for each simulated service in `num_services`, a corresponding type is selected cyclically from the probabilities list, generating the array `service_requests`. 

### 🔎Resources 

Defined by:
- Demand, number, availability, carbon offset.
- Offered deadline, data rate, and packet loss rate.
- Power consumption per core and per memory unit (`P_c`, `P_m`).
- Core usage factor (`u_c`), processing capability (`fpc`).
- Average demand per hour, mean time to failure (`lambda_failure`), and likelihood of attacks.

These values are determined by cycling through predefined lists, and some of them are adjusted conditionally depending on the resource’s environmental footprint (`carbon_offset_value`). For instance, more sustainable resources are assigned lower power consumption and higher reliability, while less efficient ones have higher energy costs and lower availability. This mechanism allows the simulation to capture heterogeneity among resources.

### 🛠️Optimization Parameters 

Specified in `main.py`, including:
- delta, hence the ε-step size for discretization.
- KPI and KVI weights.

Specified in `optimization.py`, including:
- MIPGap, the allowable optimality gap between the best feasible solution and the theoretical bound
- MIPFocus, the solver emphasis (e.g., finding feasible solutions fast vs. proving optimality)
- VarBranch, the branching strategy (e.g., reduced-cost or strong branching)
- Heuristics, the fraction of runtime spent on heuristics.

Global parameters such as the carbon intensity factor (`CI`) and power usage effectiveness (`PUE`) can also be configured.
For a complete explanation of parameters and methodology, refer to [this paper](https://www.sciencedirect.com/science/article/pii/S138912862500444X).


## Running a simulation with TETREES

As an illustrative simulation scenario, we consider the case of services belonging to the *Trusted Environments* service class, such as multimedia and extended reality applications such as telepresence, education and gaming, where privacy and security are of utmost importance. In this context, the trustworthiness indicator is given higher relevance in the optimization process, with a weight of 0.8, while the remaining social KVIs, i.e., sustainability and inclusiveness, are assigned lower and equal weights of 0.1 each. This configuration (e.g., `weights_kvi = [0.8, 0.1, 0.1]`) reflects a design choice in which ensuring data confidentiality and reliability takes precedence over other ethical or societal concerns.

From a performance perspective, the KPI weights are set to emphasize both transmission quality and reliability. Specifically, data rate and packet loss rate are assigned weights of 0.5 and 0.3, respectively, while the remaining KPI, representing for instance latency or energy efficiency, is weighted 0.2 (`weights_kpi = [0.2,0.5,0.3]`). All other resource and service setup parameters, such as the number of services, available network resources, and demand profiles, are left unchanged with respect to the current configuration defined in the repository. The optimization parameters of the solver are also kept consistent with the baseline setup, with the following key configurations: `MIPFocus=0` for a balanced tree search, `VarBranch=2` to use the reduced cost branching strategy, in the vein of the Cut-and-Solve strategy,  `MIPGap=0.03` to balance solution accuracy and computational effort, and `Heuristics=0.05` for minimal runtime spent on heuristics. More setups can be selected according to the need, instance size of the problem, and its complexity.

## Plotting the results of a simulation with TETREES

Once the csv files have been generated, it is possible to plot significant results with MATLAB. 
  - With the `KPI_KVI_vs_Resources.m` script, two comparative plots showing how different optimization strategies perform as the number of available resources increases are generated. The first plot represents the total network quality performance (KPI) versus the number of resources, while the second illustrates the total social and ethical value (KVI) under the same conditions. The analysis compares four approaches: the proposed TETREES solution, a greedy algorithm maximizing KPI, a greedy algorithm maximizing KVI, and a random benchmark. Each approach retrieves data from benchmark folders corresponding to different experimental setups. The script reads the relevant CSV files (`pareto_solutions.csv`, `greedy_kpi_results.csv`, `greedy_kvi_results.csv`, and `random_results.csv`) located in these folders, extracts the KPI and KVI values, and plots their evolution as resource availability changes.

    - Several input parameters can be modified to adapt the analysis. The base path (`base_path`) can be changed to point to the directory where the experiment folders are stored. The folder lists (`folders_proposed` and `folders_benchmark`) define which configurations are analyzed and can be updated to include more scenarios or different naming schemes. The vector of resource quantities (`num_resources`) specifies the values used on the x-axis and should correspond to the resources available in each benchmark case. 

  - Through the `KPI_KVI_vs_Services.m` script, instead, two separate plots to analyze how different optimization approaches perform as the number of services varies, while keeping the number of resources constant, are generated. The first plot shows the total network quality performance (KPI) as a function of the number of services, and the second illustrates the corresponding total social and ethical value (KVI). The goal is to visualize how the four algorithms under comparison—namely the proposed TETREES optimization, a greedy approach that maximizes KPI, a random baseline, and a greedy approach that maximizes KVI—respond to increasing service demand. For each configuration, the script retrieves experimental results from a set of benchmark folders that correspond to different service quantities. It reads the data stored in the CSV files `pareto_solutions.csv`, `greedy_kpi_results.csv`, `greedy_kvi_results.csv`, and `random_results.csv`, extracts representative KPI and KVI values, and generates line plots comparing the performance of the four approaches.

    - Once again, several input parameters can be modified to adapt the analysis to different datasets or experimental conditions: the base path (`base_path`), the folder lists (`folders_proposed` and `folders_benchmark`), and the vector of services (`num_services`).

  - Finally, the `Pareto_Frontiers_Construction.m` script is designed to visualize Pareto fronts obtained from multiple experimental configurations, highlighting the trade-off between network performance and social or ethical value. Each curve in the plot corresponds to a different configuration. For each configuration, the script reads the file `pareto_solutions.csv` located inside a results folder, extracts the total network quality performance (KPI) and total social and ethical value (KVI), and plots these as a series of connected points. The result is a comparative figure that shows how the Pareto fronts shift under varying system conditions.

    - Among the input parameters which can be modified to tailor the analysis, we recall the main path (`main_folder`). The list of result folders (`result_names`) defines which configurations are included in the plot and can be adjusted depending on the set of experiments being compared. 

# Additional Support
Please refer to this web page for additional support.


## License
TEETRES is released under the GPL-3.0 license.

