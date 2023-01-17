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
# selects data that ends with Day
select(NHANES, contains("Age"))

nhanes_small <- select(NHANES, Age, Gender, BMI, Diabetes, PhysActive, BPSysAve, BPDiaAve, Education)
# creates new object that only includes Age, Gender etc form the data of NHANES
nhanes_small


# Fixing variable names ---------------------------------------------------

nhanes_small <- rename_with(nhanes_small, snakecase::to_snake_case)
# no brakes after sto_snake_case because no function, rename_with can use a couple styles saved in R
nhanes_small
# run nhanes_small to see the rename changes
nhanes_small <- rename(nhanes_small, sex = gender)
# rename one section (first always the dataset in this case nhanes_small), new name SEX old name GENDER
nhanes_small
# dont need ti retype it can always run in the beginning of section as well


# Piping  -----------------------------------------------------------------

colnames(nhanes_small)
# how it normally looks
nhanes_small %>%
  colnames()
# does the same as before, dont need 1st position because the pipe will write it in already
nhanes_small %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)
# piping put in 1st position aka dataset in there and then, read it how you would see it, easier
