This repository contains Boston housing data analysis using R and R markdown. It demonstrates data cleaning, visualization, statistical analysis, and predictive modeling techniques.
The dataset contains housing data from Boston suburbs in 1978 and is widely used for regression tasks in data science.

Project Goals:
- Perform Exploratory Data Analysis (EDA)
- Identify the key features affecting housing prices
- Build a predictive model for housing prices

Technologies used:
- R
- R Markdown
- ggplot2
- randomForest
- corrplot
- MASS (for dataset)

Files:
- Boston Housing Analysis Code.R: the raw code used to perform the analysis in the PDF.
- Boston-Housing-Analysis.pdf: the full, polished report knitted to a PDF.

How to run:
- Download Boston Housing Analysis Code.R.
- Install any necessary libraries.
- Run code.

Key Findings:
- rm, ptratio, and lstat are among the most important predictors of house price
- Having a river on the tract of land (or on its boundary) corresponds to a higher house price.
- The higher the nitrogen oxide concentration in the house's area, the lower the price of the house.
- The more rooms in a house, the higher the price is.
- The further the house from an employment center, the lower the price of the house.
- The higher the radial highway accessibility, the higher the price of the house.
- The higher pupil-teacher ratio of the area, the lower the price.
- The higher the percentage of low-status population, the lower the price of the house.

Limitations:
- Sample size lowered through outlier removal; could lower representativeness.
- Variable chas is very unbalanced, leading to bias.
- Some linear regression assumptions may have been violated, weakening predictive power.
- Only parametric models were employed.
- The dataset is rahter old (1978).
