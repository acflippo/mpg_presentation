# This is the data analysis that determined the coefficients
# that went into the shiny Application

setwd("~/Dropbox/Coursera_DataProducts/estMPG")

library(slidify)
library(dplyr)
library(MASS)
library(rCharts)

kipcars <- read.csv("./kiplinger_car_facts.csv")
kipcars$displacement <- as.numeric(kipcars$displacement)
kipcars$cyl <- as.factor(kipcars$cyl)

# Can't use dply's select because of MASS library
cityDF <- kipcars[, c(2,4:11)]
citylm <- lm(city_mpg ~ . -1, data=cityDF)
cityStep <- stepAIC(citylm)
summary(cityStep)
summary(citylm)

n1 <- nPlot(city_mpg ~ eng_type, group = 'cyl', type = 'multiBarHorizontalChart', data=kipcars, main="City MPG for cylinder")
n1$chart(showControls = F)
n1$xAxis(axisLabel = "Miles per Gallon")
n1$addParams(width = 600, height = 400, dom = 'chart1', title = "City MPG for Number of Cylinders")
n1


p3 <- nPlot(~ cyl, group = 'gear', data = mtcars, type = 'multiBarHorizontalChart')
p3$chart(showControls = F)
p3
# > summary(citylm)
# 
# Call:
#     lm(formula = city_mpg ~ . - 1, data = cityDF)
# 
# Residuals:
#     Min       1Q   Median       3Q      Max 
# -10.2460  -1.0673  -0.0254   1.1220  11.8189 
# 
# Coefficients:
#     Estimate Std. Error t value Pr(>|t|)    
#     eng_typeDiesel        47.7015600  1.1953297  39.907  < 2e-16 ***
#     eng_typeFlexible Fuel 42.1867599  1.1780201  35.812  < 2e-16 ***
#     eng_typeGas           42.1858582  1.1152667  37.826  < 2e-16 ***
#     eng_typeHybrid        56.5392404  1.1568265  48.874  < 2e-16 ***
#     torque                -0.0063933  0.0024278  -2.633 0.008543 ** 
#     hp                    -0.0143775  0.0025087  -5.731 1.21e-08 ***
#     cyl4                  -3.3110759  1.0347143  -3.200 0.001404 ** 
#     cyl5                  -5.4970127  1.1374469  -4.833 1.49e-06 ***
#     cyl6                  -3.3231275  1.1111751  -2.991 0.002831 ** 
#     cyl8                  -0.0406935  1.2595237  -0.032 0.974230    
#     cyl10                 -2.6388025  1.5704267  -1.680 0.093112 .  
#     cyl12                  1.8624058  1.6952600   1.099 0.272126    
#     displacement          -0.7453061  0.1664411  -4.478 8.13e-06 ***
#     drivetrainAWD          0.0039303  0.2614442   0.015 0.988008    
#     drivetrainFWD          0.9848402  0.2611147   3.772 0.000169 ***
#     drivetrainRWD         -0.2916201  0.3159339  -0.923 0.356139    
#     transmissionManual    -1.0672956  0.1681929  -6.346 2.95e-10 ***
#     weight                -0.0030381  0.0001718 -17.689  < 2e-16 ***
#     ---
#     Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 2.233 on 1455 degrees of freedom
# Multiple R-squared:  0.9901,    Adjusted R-squared:  0.9899 
# F-statistic:  8047 on 18 and 1455 DF,  p-value: < 2.2e-16

hwyDF <- kipcars[, c(3:11)]
hwylm <- lm(hwy_mpg ~ . -1, data=hwyDF)
hwyStep <- stepAIC(hwylm)
summary(hwyStep)

hwylm2 <- lm(hwy_mpg ~ eng_type + hp + displacement + drivetrain + transmission -1, data=hwyDF)
summary(hwylm2)


# Call:
#     lm(formula = hwy_mpg ~ eng_type + hp + displacement + drivetrain + 
#            transmission - 1, data = hwyDF)
# 
# Residuals:
#     Min      1Q  Median      3Q     Max 
# -9.2592 -2.1916 -0.0849  2.0554  8.1048 
# 
# Coefficients:
#     Estimate Std. Error t value Pr(>|t|)    
#     eng_typeDiesel        41.387263   0.582879  71.005  < 2e-16 ***
#     eng_typeFlexible Fuel 34.326396   0.588877  58.291  < 2e-16 ***
#     eng_typeGas           35.205590   0.428535  82.153  < 2e-16 ***
#     eng_typeHybrid        41.443058   0.508323  81.529  < 2e-16 ***
#     hp                    -0.016292   0.001712  -9.518  < 2e-16 ***
#     displacement          -2.122179   0.141263 -15.023  < 2e-16 ***
#     drivetrainAWD          2.349554   0.343530   6.839 1.16e-11 ***
#     drivetrainFWD          4.868717   0.328291  14.831  < 2e-16 ***
#     drivetrainRWD          5.499805   0.377484  14.570  < 2e-16 ***
#     transmissionManual     0.747232   0.208620   3.582 0.000352 ***
#     ---
#     Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 3.004 on 1463 degrees of freedom
# Multiple R-squared:  0.9898,    Adjusted R-squared:  0.9897 
# F-statistic: 1.421e+04 on 10 and 1463 DF,  p-value: < 2.2e-16
# Residual standard error: 2.896 on 1456 degrees of freedom
# Multiple R-squared:  0.9906,    Adjusted R-squared:  0.9905 
# F-statistic:  8997 on 17 and 1456 DF,  p-value: < 2.2e-16
