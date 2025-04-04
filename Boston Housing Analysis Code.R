# load data
library(MASS)
data("Boston")

# check first few rows
head(Boston)

# amount of missing vals
sum(is.na(Boston))

# check number of duplicate rows
sum(duplicated(Boston))

# boxplot of all vars
boxplot(Boston, main="Boxplot to Check for Outliers")

# check outlier var scatterplots
library(ggplot2)
independent_vars <- c("crim", "black", "zn")
dependent_var <- "medv"
# Create scatter plots for each independent variable
for (var in independent_vars) {
  p <- ggplot(Boston, aes_string(x = var, y = dependent_var)) +
    geom_point() +
    geom_smooth(method = "lm", color = "red", se = FALSE) + # add regression line for each plot
    ggtitle(paste("Scatter plot of", var, "vs", dependent_var)) +
    theme_minimal()
  
  print(p)
}

# remove crim outliers
Q <- quantile(Boston$crim, probs=c(.25, .75), na.rm = FALSE)
iqr <- IQR(Boston$crim)
up <-  Q[2]+1.5*iqr # Upper Range  
low<- Q[1]-1.5*iqr # Lower Range
Boston<- subset(Boston, Boston$crim > (Q[1] - 1.5*iqr) & Boston$crim < (Q[2]+1.5*iqr))

# remove zn outliers
Q <- quantile(Boston$zn, probs=c(.25, .75), na.rm = FALSE)
iqr <- IQR(Boston$zn)
up <-  Q[2]+1.5*iqr # Upper Range  
low<- Q[1]-1.5*iqr # Lower Range
Boston<- subset(Boston, Boston$zn > (Q[1] - 1.5*iqr) & Boston$zn < (Q[2]+1.5*iqr))

# remove black outliers
Q <- quantile(Boston$black, probs=c(.25, .75), na.rm = FALSE)
iqr <- IQR(Boston$black)
up <-  Q[2]+1.5*iqr # Upper Range  
low<- Q[1]-1.5*iqr # Lower Range
Boston<- subset(Boston, Boston$black > (Q[1] - 1.5*iqr) & Boston$black < (Q[2]+1.5*iqr))

# recheck boxplot
boxplot(Boston, main="Boxplot to Check for Outliers")

dim(Boston) # check dimensions of dataset

unique(Boston$chas)
unique(Boston$rad)

table(Boston$chas)
table(Boston$rad)

chas_table <- table(Boston$chas)
rad_table <- table(Boston$rad)

# Create a bar plot for 'chas'
barplot(chas_table, main="Bar Plot for chas", col="skyblue", xlab="chas", ylab="Frequency")

# Create a bar plot for 'rad'
barplot(rad_table, main="Bar Plot for rad", col="lightgreen", xlab="rad", ylab="Frequency")

# check var types
sapply(Boston, class)

str(Boston) # display contents of dataframe

summary(Boston) # summary stats for each column

library(corrplot)
corrplot(cor(Boston), method = "color")

# SLR (predict price based on just number of rooms)
model1 <- lm(medv ~ rm, data=Boston)
summary(model1)

# check model1 performance
summary(model1)$r.squared

# MLR (predict price using all available vars)
model2 <- lm(medv ~ crim + zn + indus + chas + nox + rm + age + dis + rad + tax + ptratio + black + lstat, data = Boston)
summary(model2)

# check model2 performance
summary(model2)$adj.r.squared

step_model <- step(model2, direction="both")
summary(step_model)

library(randomForest)
rf_model <- randomForest(medv ~ ., data=Boston, importance=TRUE)
importance(rf_model)

giga_rf_model <- lm(medv ~ rm + lstat + indus + ptratio + nox + tax + crim, data = Boston)
summary(giga_rf_model)

library(glmnet) 
x <- model.matrix(medv ~ ., Boston)[, -1]
y <- Boston$medv

cv_model <- cv.glmnet(x, y, alpha = 1)

best_lambda <- cv_model$lambda.min
best_lambda

plot(cv_model) 

best_model <- glmnet(x, y, alpha = 1, lambda = best_lambda)
coef(best_model)

lasso_model <- lm(medv ~ chas + nox + rm + dis + rad + tax + ptratio + black + lstat, data = Boston)
summary(lasso_model)

# Check model residuals
par(mfrow = c(2, 2)) # sets plot pane to be 2 columns x 2 rows
plot(lasso_model) # plots residuals vs. fitted, normal qq, scale-location, residuals vs. leverage

# check independence of errors
library(lmtest)
dwtest(lasso_model)

bptest(lasso_model)

shapiro.test(lasso_model$residuals)

library(car)
vif(lasso_model)

