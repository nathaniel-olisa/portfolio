# 📊 Earnings Analysis of Financial Specialists by Undergraduate Major

## Overview
This project applies econometric techniques to analyze earnings disparities among financial specialists based on their undergraduate major, using ACS data (2009–2013).

## Objectives
- Quantify the earnings premium for Economics majors in sales occupations.
- Control for omitted variable bias (OVB) using gender as a control variable.
- Visualize findings for better interpretability.

## Tools & Libraries
- **Language:** R
- **Libraries:** tidyverse, ggplot2, dplyr
- **Techniques:** OLS regression, auxiliary regression, descriptive statistics

## Methodology
### 1) Data Cleaning
```r
data <- read.csv("acs_financial_specialists.csv")
data <- na.omit(data)
```

### 2) Descriptive Statistics
```r
summary(data)
aggregate(Earnings ~ Major, data, mean)
aggregate(Earnings ~ Major, data, median)
```

### 3) Regression Models
```r
# Bivariate regression
model1 <- lm(Earnings ~ Econ, data = data)

# Multivariate regression with gender control
model2 <- lm(Earnings ~ Econ + Female, data = data)

# Optional: with interaction
model3 <- lm(Earnings ~ Econ*Female, data = data)

summary(model1)
summary(model2)
summary(model3)
```

### 4) Visualization
```r
library(ggplot2)
ggplot(data, aes(x = Major, y = Earnings)) +
  geom_boxplot() +
  coord_flip() +
  theme_minimal() +
  labs(title = "Earnings by Undergraduate Major",
       x = "Major", y = "Annual Earnings (USD)")
```

## Key Findings (to highlight in your repo)
- Economics majors earned **~$5,700 more** on average than other majors in sales occupations (bivariate estimate).
- Adjusting for gender reduced part of the difference, indicating **OVB** in model 1.
- Variance across majors is substantial; medians often differ from means.

## Repo Structure
```text
/data                  # raw or processed data (omit sensitive PII)
/notebooks             # R scripts or Rmd notebooks
/outputs               # exported plots and model summaries
README.md              # this file
```

## Outputs (place your files/screens here)
- 📄 `outputs/regression_summary.txt`
- 📊 `outputs/earnings_by_major.png`
- 📈 `outputs/ovb_adjusted_model.png`

## Notes
- Replace file names as needed.
- Add a brief *Methods* paragraph in the notebook describing sampling, filters, and assumptions.
