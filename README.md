# COVID-19 Impact on Youth Unemployment in Canada: Econometric Causal Inference & Machine Learning Counterfactual Analysis

This repository evaluates the causal impact of COVID-19 and related policy shocks on youth unemployment and non-employment rates ("Nowork rate") across Canadian provinces. The analysis combines traditional panel econometrics (Difference-in-Differences, Two-Way Fixed Effects, and Driscoll-Kraay standard errors) with machine learning predictive modeling (XGBoost) for policy evaluation, robustness testing, and counterfactual simulation.

---

## 📌 Key Highlights

1. **Difference-in-Differences & Two-Way Fixed Effects (DID & TWFE)**:
   - Uses the four Atlantic provinces as the reference control group to evaluate dynamic policy responses in Ontario/Quebec and the Western provinces (AB, SK, MB, BC).
   - Employs **Driscoll-Kraay standard errors** to handle cross-sectional dependence, autocorrelation, and heteroskedasticity inherent in long panel data.

2. **First-Principles NumPy Implementation**:
   - Manually derives and implements the within-group transformation matrix operations in pure Python (NumPy).
   - Replicates exact TWFE regression coefficients and standard errors calculated by Stata without relying on black-box econometric libraries.

3. **XGBoost Counterfactual Simulation**:
   - Trains an XGBoost model on pre-2020 historical data to construct a counterfactual baseline representing youth unemployment trajectories in the absence of the pandemic.
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
📊 Main Empirical FindingsDimensionKey FindingSubgroup HeterogeneityLockdown policies induced a persistent positive shock on non-students' unemployment and nowork rates. Full-time students in Ontario and Quebec showed no statistically significant shock difference, passing the placebo test.Regional GradientA clear "West-East" sensitivity gradient emerged. The Western provinces were most sensitive to policy shocks, with non-student unemployment higher by 3.96% and nowork rate higher by 4.81% relative to controls. Ontario and Quebec followed with a 3.69% unemployment increase.Counterfactual GapPost-March 2020, Ontario's non-student monthly unemployment averaged 2.53% higher than counterfactual predictions. British Columbia experienced the most severe persistent gap among full-time students.🛠️ Econometric Framework1. Two-Way Fixed Effects Model (TWFE)$$Y_{it} = \beta_0 + \beta_1 \cdot \text{Treat}_i \times \text{Post}_t + \alpha_i + \gamma_t + \varepsilon_{it}$$Where $\alpha_i$ accounts for province-specific fixed effects and $\gamma_t$ captures time-specific shocks.2. Driscoll-Kraay Standard ErrorsTo resolve cross-sectional dependence in panels with small $N$ and large $T$, the spatial correlation consistent covariance matrix is constructed as:$$S_T = \frac{1}{T} \sum_{t=1}^{T} h_t(\hat{\beta}) h_t(\hat{\beta})'$$Where $h_t(\hat{\beta}) = \sum_{i=1}^{N} X_{it} \hat{\varepsilon}_{it}$, combined with a Newey-West lag structure to ensure valid statistical inference.🚀 Quick StartSetup EnvironmentBashgit clone [https://github.com/your-username/canada-youth-unemployment-did.git](https://github.com/your-username/canada-youth-unemployment-did.git)
cd canada-youth-unemployment-did
pip install -r requirements.txt
Key Dependenciespython >= 3.8numpy, pandas, scikit-learnxgbooststatsmodels, linearmodelsmatplotlib, seaborn📜 LicenseThis project is licensed under the MIT License.
