setwd("~/Dropbox/Coursera_DataProducts")

# Annie - Install required libraries if you don't already have them
#library(devtools)
#install_github('slidify','ramnathv')
#install_github('slidifyLibraries', 'ramnathv')
#library(slidify)
#library(XML)
#library(httr)
#library(RCurl)

baseurl<-"http://www.kiplinger.com/tool/cars/T011-S001-2012-new-car-rankings-compare-costs-performance-da/index.php?kip_id="

# Doing one set of kiplinger's category of vehicles at a time
# cat <- '2530-'
# cat <- 'SPORTS-'
# cat <- '3040-'
# cat <- 'LGXOVER-'
# cat <- 'SMXOVER-'
# cat <- 'OVER50-'
# cat <- 'WAGON-'
# cat <- 'MIDXOVER-'
# cat <- 'UNDER20-'
# cat <- '2025-X'
# cat <- 'MINIVAN-'
cat <- 'TB%20SUV-'

for (i in 1:300) {

url <- paste(baseurl, cat, i, sep="")

html <- htmlTreeParse(url, useInternalNodes=T)
t <- xpathSApply(html, '//*[@id="autoTable"]', function(x) gsub('(\r)||(\t)', '', xmlValue(x)))

if (!is.null(unlist(t))) {
    split_t <- strsplit(t, "\n")
    textArray <- unlist(split_t)
    
    make_model <- textArray[2]
    make_model <- substring(make_model, 1, nchar(make_model)-1)
    
    city_mpg <- substring(textArray[11], 11, 12)
    hwy_mpg  <- substring(textArray[11], 26, 27)
    eng_type_split <- unlist(strsplit(textArray[11], "Recommended fuel"))[1]
    eng_type <- unlist(strsplit(eng_type_split, "Engine type: "))[2]
    
    torque_split <- strsplit(textArray[31], "Torque \\(lb.-ft.\\): ")
    torque <- unlist(torque_split)[2]
    
    hp_split <- strsplit(unlist(torque_split)[1], "Horsepower: ")
    hp <- unlist(hp_split)[2]
    
    cyl_split <- strsplit(unlist(hp_split)[1], "Number of cylinders: ")
    cyl <- unlist(cyl_split)[2]
    
    Displ_split <- strsplit(unlist(cyl_split)[1], "Displacement \\(L\\): ")
    displacement <- unlist(Displ_split)[2]
    
    Drivetrain_split <- strsplit(unlist(Displ_split)[1], "Drivetrain: ")
    drivetrain <- unlist(Drivetrain_split)[2]
    
    Tran_split <- strsplit(unlist(Drivetrain_split)[1], "Transmission: ")
    transmission <- unlist(Tran_split)[2]
    
    weight_split <- unlist(strsplit(textArray[35], "Curb weight \\(lbs\\): "))
    weight <- gsub(",", "", unlist(weight_split)[2])

    car_txt <- paste(make_model, city_mpg, hwy_mpg, eng_type, torque, hp, cyl, displacement, drivetrain, transmission, weight, sep=",")
    # Make sure to use append to continuously write data to result data file
    write(car_txt, file="kiplinger_car_facts.csv", append = TRUE)
    
} else {
    print ("Nothing to do")
} # endif

} # end for-loop
