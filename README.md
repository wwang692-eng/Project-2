# Project-2
ML &amp; Counterfactual Evaluation of COVID-19 Macroeconomic Shocks across 10 Canadian Provinces using DiD, TWFE, and XGBoost.
# 🇨🇦 Counterfactual Prediction & Causal Inference: Assessing COVID-19 Macroeconomic Shocks Across Canadian Provinces

[![Python 3.10+](https://img.shields.io/badge/python-3.10+-blue.svg)](https://www.python.org/)
[![Stata MP 18.0](https://img.shields.io/badge/stata-MP_18.0-red.svg)](https://www.stata.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📌 Executive Summary
This repository presents an end-to-end econometric and machine learning framework designed to evaluate the causal impact of the COVID-19 pandemic on unemployment rates across 10 Canadian provinces. 

By combining **Difference-in-Differences (DiD)** and **Two-Way Fixed Effects (TWFE)** with an **XGBoost Counterfactual Prediction Engine**, this project quantifies the true net shock attributable to pandemic disruptions while isolating unobserved province-specific heterogeneity and national macroeconomic trends.

---

## 🔬 Econometric Identification & Causal Framework

### 1. Two-Way Fixed Effects (TWFE) Specification
To estimate the causal effect of COVID-19 on non-student vs. student unemployment, we specify the panel econometric model:

$$Y_{it} = \beta_0 + \beta_1 (Treatment_i \times Post_t) + \gamma_i + \lambda_t + \mathbf{X}_{it}'\boldsymbol{\delta} + \varepsilon_{it}$$

Where:
- $Y_{it}$: Unemployment rate in province $i$ at month $t$.
- $Treatment_i \times Post_t$: Policy and shock exposure interaction term.
- $\gamma_i$: Province fixed effects (controlling for time-invariant provincial characteristics).
- $\lambda_t$: Time fixed effects (controlling for macroeconomic shocks common to all provinces).
- $\mathbf{X}_{it}$: Vector of dynamic provincial economic covariates.

### 2. Machine Learning Counterfactual Pipeline
To simulate the benchmark baseline ("What if NO COVID-19 occurred?"):
1. **Pre-Treatment Training**: Trained an optimized **XGBoost Regressor** on pre-2020 macroeconomic indicators across all 10 provinces.
2. **Out-of-Sample Counterfactual Generation**: Projected baseline unemployment trajectories for the post-2020 window (2020-03 to 2025-12).
3. **Treatment Shock Quantification**: Computed cumulative percentage point anomalies by measuring the divergence between realized values $Y_{it}$ and counterfactual predictions $\hat{Y}_{it}^{counterfactual}$.

---

## 💡 Key Empirical Findings

- **Ontario Shock**: Identified a cumulative **116.2 percentage point anomaly** in Ontario's non-student unemployment gap relative to its baseline trajectory.
- **Heterogeneous Recovery**: Uncovered "gradual recovery" patterns in provinces like Manitoba, where structural labor adjustments occurred significantly faster than in eastern provinces.
- **Robustness**: Replicated Stata coefficient estimates using pure **NumPy matrix programming** to guarantee computational internal validity.

---

## 🛠️ Repository Architecture

```text
├── data/                  # Provincial unemployment & macroeconomic time series
├── src/                   # Core codebase
│   ├── pystata_bridge/    # Python-Stata MP synchronization scripts (Pandas/NumPy)
│   ├── models/            # XGBoost hyperparameter tuning & TWFE regressions
│   └── visualization/     # Interactive mapping and counterfactual plotting modules
├── notebooks/             # End-to-end research workflow
│   └── covid_unemployment_causal_analysis.ipynb
├── results/               # Estimated coefficients, counterfactual plots, and maps
├── requirements.txt       # Python environment dependencies
└── README.md
```

---

## ⚡ Quick Start & Execution

```bash
# Clone the repository
git clone [https://github.com/wwang692-eng/Project-2.git](https://github.com/wwang692-eng/Project-2.git)
cd your-repo-name

# Set up virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install required packages
pip install -r requirements.txt

# Run Python-Stata integration pipeline
python src/pystata_bridge/run_pipeline.py
```

---

## 🛠️ Tech Stack
- **Causal Inference & Panel Data**: Difference-in-Differences (DiD), Two-Way Fixed Effects (TWFE)
- **Machine Learning**: XGBoost, Scikit-Learn
- **Data Engineering & Computation**: PyStata (Python-Stata MP Interface), Pandas, NumPy
- **Visualization**: Folium / Plotly (Interactive Provincial Heterogeneity Maps), Matplotlib
