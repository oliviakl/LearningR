# Example of a conflict.

10

# R basics ----------------------------------------------------------------

weight_kilos <- 100
weight_kilos <- 10
weight_kilos
colnames(airquality)
str(airquality)
summary(airquality)

2 + 2


# Packages ----------------------------------------------------------------

library(tidyverse)
library(NHANES)

# run is command+enter
?colnames
help(colnames)
# This will be used for testing out Git


# Looking at data ---------------------------------------------------------

glimpse(NHANES)
# glimpse will let you see the data in a specific way
select(NHANES, Age)
# dataset itself is not being touched, only showing Age of dataset

select(NHANES, Age, Weight, BMI)

select(NHANES, -HeadCirc)
# useful when I dont need all the variables

select(NHANES, starts_with("BP"))
# selects all the varibales that satrt with "BP"

select(NHANES, ends_with("Day"))
#selects data that ends with Day
select(NHANES, contains("Age"))

nhanes_small <- select(NHANES, Age, Gender, BMI, Diabetes, PhysActive, BPSysAve, BPDiaAve, Education)
#creates new object that only includes Age, Gender etc form the data of NHANES
nhanes_small
