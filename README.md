# Project-2
# COVID-19 Impact on Youth Unemployment in Canada: Econometric Causal Inference & Machine Learning Counterfactual Analysis

This repository evaluates the causal impact of COVID-19 and related policy shocks on youth unemployment and non-employment rates ("Nowork rate") across Canadian provinces[cite: 22, 23, 26]. The analysis combines traditional panel econometrics (Difference-in-Differences, Two-Way Fixed Effects, and Driscoll-Kraay standard errors) with machine learning predictive modeling (XGBoost) for policy evaluation, robustness testing, and counterfactual simulation[cite: 5, 22, 26, 34, 35].

---

## 📌 Key Highlights

1. **Difference-in-Differences & Two-Way Fixed Effects (DID & TWFE)**:
   - Uses the four Atlantic provinces as the reference control group to evaluate dynamic policy responses in Ontario/Quebec and the Western provinces (AB, SK, MB, BC)[cite: 22, 28].
   - Employs **Driscoll-Kraay standard errors** to handle cross-sectional dependence, autocorrelation, and heteroskedasticity inherent in long panel data[cite: 5, 34, 35].

2. **First-Principles NumPy Implementation**:
   - Manually derives and implements the within-group transformation matrix operations in pure Python (NumPy)[cite: 24, 25].
   - Replicates exact TWFE regression coefficients and standard errors calculated by Stata without relying on black-box econometric libraries[cite: 24, 25].

3. **XGBoost Counterfactual Simulation**:
   - Trains an XGBoost model on pre-2020 historical data to construct a counterfactual baseline representing youth unemployment trajectories in the absence of the pandemic[cite: 26, 27, 29].
   - Quantifies the duration and magnitude of policy shocks by tracking the monthly cumulative gap between observed and counterfactual rates post-March 2020.

4. **Placebo Testing & Subgroup Heterogeneity**:
   - Conducts placebo tests on full-time students to demonstrate group heterogeneity.
   - Establishes that youth unemployment increases were driven primarily by labor market restrictions rather than general macroeconomic collapses.

---

## 📂 Repository Structure

```text
.
├── data/                   # Provincial panel datasets on youth unemployment and macro indicators
├── notebooks/              # Jupyter Notebooks covering analysis and modeling workflows
│   ├── 01_did_twfe_model.ipynb        # DID and Fixed Effects estimations
│   ├── 02_numpy_manual_twfe.ipynb     # Manual NumPy matrix derivation vs Stata benchmarks
│   └── 03_xgboost_counterfactual.ipynb# Counterfactual prediction and gap analysis
├── results/                # Exported regression tables and visualization plots
├── docs/                   # Empirical project report (unem.pdf)
└── README.md
