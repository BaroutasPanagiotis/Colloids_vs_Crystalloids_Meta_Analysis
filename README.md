# Colloids_vs_Crystalloids_Meta_Analysis
This repository contains data, scripts, and results for a systematic review and meta-analysis on fluid therapy (colloids vs. crystalloids) in critically ill patients with septic shock.

Files in the Repository

Data
28_days_mortality_df.xlsx
Contains the extracted data for 28-day mortality outcomes from the included studies.
Qualitatively extracted data.xlsx
Includes qualitatively extracted data for narrative synthesis and subgroup analysis.
R Scripts
Progress_plot.R
Script to generate progress plots visualizing study inclusion and exclusion during the review process.
Recall_plot.R
Script to create recall plots for data extraction and consistency checks.
SolutionsAdmMetaAnalysis.R
Script for running the meta-analysis on the solutions administered, including statistical tests and visualizations.
Documentation
README.md
This file provides an overview of the project and repository structure.
Repository Purpose

The aim of this repository is to:

Provide transparency in the data analysis process for the systematic review.
Share tools and scripts for replicating or adapting the analysis.
Contribute to the body of evidence-based practice in intensive care.
Key Features

Meta-analysis of randomized controlled trials (RCTs).
Visualizations of study selection and data extraction progress.
Subgroup analysis for comparing colloid and crystalloid therapies.
Getting Started

Clone the repository:
git clone https://github.com/YourUsername/ICU_FluidTherapy_MetaAnalysis.git
Install R and required libraries: Ensure you have the necessary R packages installed:
install.packages(c("meta", "ggplot2", "dplyr", "readxl"))
Run the scripts:
To generate visualizations, execute Progress_plot.R and Recall_plot.R.
To perform the meta-analysis, run SolutionsAdmMetaAnalysis.R.
Results Summary

The main findings include:

Mortality outcomes at 28 days.
Comparisons of effectiveness and safety between colloid and crystalloid therapies.
Insights into subgroup differences.
Contributions

Feel free to contribute by:

Forking the repository.
Submitting pull requests for code improvements.
Reporting issues or suggesting enhancements.
