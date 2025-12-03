# Hepatitis C Dataset Analysis - BIOS 611 Final Project

## Project Description
This project analyzes the Hepatitis C dataset to explore biomarkers and predictive factors for liver disease progression. The analysis includes data exploration, visualization, statistical modeling, and machine learning approaches to understand the relationship between clinical measurements and disease categories.


## Project Structure
```
final_project_611/
├── README.md              # This file
├── Makefile              # Automation workflow
├── Dockerfile            # Container environment setup
├── .gitignore            # Git ignore rules
├── report.Rmd            # Main analysis (R Markdown)
├── report.html           # Generated report (final deliverable)
├── figures/              # Generated figures
└── data/
    └── hcvdat0.csv       # Dataset
    
```

## Data Source

The Hepatitis C dataset contains clinical measurements and demographic information for patients. The dataset includes:
- Demographic variables (Age, Sex)
- Liver function tests (ALB, ALP, ALT, AST, BIL, CHE, CHOL, CREA, GGT, PROT)
- Disease category classification (Category)

**Dataset location**: `data/hcvdat0.csv`

## Prerequisites

- Docker installed on your system
- Git (for cloning the repository)
- 4GB+ available RAM

## Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/Yuting66621/BIOS-611---Final-Project.git
cd final_project_611
```

### 2. Build Docker Image
```bash
docker build -t final-project .
```

**Note**: Building takes approximately 10-15 minutes as it installs all required R packages.

### 3. Run Container with RStudio
```bash

docker run \
  -e PASSWORD=611rstudio \
  -p 8787:8787 \
  -v $(pwd):/home/rstudio/workspace \
  final-project
```

### 4. Access RStudio

Open your web browser and navigate to:
- **URL**: http://localhost:8787
- **Username**: `rstudio`
- **Password**: `611rstudio`

### 5. Generate Report

In RStudio Terminal (or your local terminal in the project directory):
```bash
cd workspace  # (if in RStudio)
make report
```

This will generate `report.html` in the project directory.

## Makefile Targets

The project is organized as a Makefile with the following targets:

- `make all` - Generate the final HTML report (default target)
- `make report` - Generate `report.html` from `report.Rmd`
- `make install` - Install required R packages (if needed)
- `make clean` - Remove generated files (report.html, cache files)
- `make help` - Display available targets

### Example Usage
```bash
# Generate report
make report

# Clean up generated files
make clean

# Regenerate report from scratch
make clean && make report
```

## Required R Packages

The following R packages are pre-installed in the Docker image:

**Core packages:**
- tidyverse (ggplot2, dplyr, tidyr, readr, etc.)
- rmarkdown, knitr

**Visualization:**
- corrplot, naniar, GGally, plotly

**Statistical Analysis:**
- factoextra, cluster

**Machine Learning:**
- caret, glmnet, pROC, randomForest, MASS

**Utilities:**
- reshape2

## Analysis Pipeline

The analysis follows this workflow:

1. **Data Cleaning and Processing**
   - Loading dataset
   - Understand the data structure
   - Check for missing values
   - Imputation strategy and data filtering
   - Dataset creation
    - Screening Dataset: Binary classification (Healthy vs Disease, n=597)
    - Staging Dataset: Multi-class classification (Hepatitis, Fibrosis, Cirrhosis, n=64)

2. **Exploratory Data Analysis (EDA)**
   - Correlation analysis
   - Biomarkers distribution analysis

3. **Dimensionality Reduction**
   - Principal Component Analysis (PCA)
   - Variance explained analysis
   - Feature contribution analysis

4. **Disease screening (Lasso + Logistic Regression)**
   - Feature selection with Lasso - AST, BIL, GGT
   - Model performance
   

5. **Disease Staging (Random Forest + LDA)**
   - Random Forest Variable Importance
   - LDA: Linear Discriminant Analysis
   - Model Performance

## Key Findings

- **Staging Model Performance:**: 
  - AST, BIL, and GGT provide 96% accuracy for detecting disease
  - High specificity (98.5%) minimizes false alarms
  - Practical for routine screening with minimal blood tests
- **Different Biomarkers Matter for Screening vs Staging**: 
  - Screening (healthy vs diseased): AST, BIL, GGT (damage markers)
  - Staging (severity within disease): ALB, CHE, ALP (function markers)
  - This reflects different biological questions - detection vs progression
- **Disease Staging is Inherently Difficult**: 
  - Hepatitis and Fibrosis overlap substantially (71% accuracy)
  - Cirrhosis is distinct and easy to identify
  - The continuum nature of liver disease progression limits discrete classification
- **Biomarker Patterns Reflect Liver Physiology**: 
  - Damage markers (AST, GGT) rise with disease → cell injury
  - Synthesis markers (ALB, CHE) fall with disease → reduced function
  - Patterns are consistent with known liver pathophysiology
- **Model Simplicity vs Performance Trade-off**:
  - Lasso reduced 11 features to 3 with minimal performance loss
  - Simpler models are more practical for clinical deployment
  - Random Forest identified key staging markers but accuracy remains limited

(See `report.html` for detailed findings)

## For Developers

### Project Organization

The project follows a reproducible research workflow:

1. **Dockerfile** ensures environment consistency
2. **Makefile** automates the entire pipeline
3. **R Markdown** provides literate programming
4. **Git** tracks version history

### Modifying the Analysis

1. Edit `report.Rmd` to modify analysis
2. Run `make clean` to remove old outputs
3. Run `make report` to regenerate

### Adding New Packages

Add packages to `Dockerfile`:
```dockerfile
RUN install2.r --error --skipinstalled \
    your_new_package
```

Then rebuild the image:
```bash
docker build -t final-project .
```





## Author

Yuting Sun
BIOS 611 - Fall 2025

## License
This project is submitted as coursework for BIOS 611.

## Acknowledgments

- Dataset: https://archive.ics.uci.edu/dataset/571/hcv+data
- R packages: See `sessionInfo()` in report.html
- Docker base image: rocker/tidyverse
