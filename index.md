---
title       : Estimate MPG for vehicles
subtitle    : An analysis of 2014 vehicle data
author      : Annie Flippo - 11/15/2014
job         : Developing Data Products Coursera class, part of Johns Hopkins Data Science Series
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # {tomorrow, zenburn, solarized_light}
widgets     : []            # {mathjax, quiz, bootstrap}
ext_widgets : {rCharts: libraries/nvd3}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
--- 

## Are you a car designer or a car enthusiast?
Do you want to know how fuel-efficient is your newly designed car before it is built or remodeled?

This is a MPG calculator based on analysis of the [2014 Kiplinger's New Car Rankings: Compare Costs, Performance data](http://www.kiplinger.com/tool/cars/T011-S001-2012-new-car-rankings-compare-costs-performance-da/index.php?table=all&mfr=&filter=all?id=all)

Modern vehicles have new attributes that may be important in determining MPG such as
- Fuel type (i.e. Flexible Fuel, Hybrid)
- Transmission type (i.e. Hybrid)
- Drivetrain (All-wheel, front-wheel, rear-wheel drive)

Try the calculator here [Estimate the Fuel Efficiency](https://acflippo.shinyapps.io/estimateMPG/)!

--- .class #id 

## Data Gathering and Preparation

There were 1626 new vehicle listed in the Kiplinger's data set.  Many of the vehicles listed were a flavor of the base model such as Acura ILX 2.0L 4d and Acura ILX 2.0L 4d w/Premium Pkg.  Duplicates of make and model combinations were removed, based on trim/technology or other superficial options, because the data point is already represented in its base make/model.  The final dataset consists of the base models and their variations in:
- number of cylinders
- engine fuel type (diesel, flexible fuel, gas, hybrid)
- engine displacement (in liters)
- transmission type (automatic or manual)
- drivetrain type (all-wheel, front-wheel, rear-wheel drive)
- weight (in pounds)

In addition, all electric vehicles were eliminated as they do not use conventional fuel and their MPG is stated by another measure, eMPG.  The final data set consists of 1473 rows.

--- .class #id 

## The Analysis

1. Stepwise model selection was performed using stepAIC to tease out significant predictors.  
2. Predictors (at 95% significant level) were used to perform a linear regression on city\_mpg and hwy\_mpg.
3. This resulted in simple linear equation that could be easily implemented.

*Note*: The data set was overwhelming consisted of Gas engine cars so the predictions were more accurate for Gas engine (see below for the fuel-type percentages), go ahead and try it out yourself [Estimate Fuel Efficiency](https://acflippo.shinyapps.io/estimateMPG/). See [Code for this analysis](https://github.com/acflippo/mpg_presentation/tree/gh-pages).


```
Source: local data frame [4 x 2]

       eng_type percent_of_data
1        Diesel           3.530
2 Flexible Fuel           6.178
3           Gas          84.929
4        Hybrid           5.363
```

--- .class #id 

## Interactive Graph of MPG vs Fuel Type 
#### Grouped by number of cylinders  

To select or deselect number of cylinders shown in the graph, click on the number legend on the upper-right corner. 

<iframe src=' assets/fig/nvd3plot2.html ' scrolling='no' frameBorder='0' seamless class='rChart nvd3 ' id=iframe- chart1 ></iframe> <style>iframe.rChart{ width: 100%; height: 400px;}</style>





