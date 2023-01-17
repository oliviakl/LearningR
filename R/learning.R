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
nhanes_small %>%
  select(bp_sys_ave, education)
nhanes_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )
nhanes_small %>%
  select(bmi, contains("age"))
# excersie 7.8 3)
nhanes_small %>%
  rename(bp_systolic = bp_sys_ave)
rlang::last_error()
rlang::last_trace()

# Filtering rows ----------------------------------------------------------

nhanes_small %>%
  filter(phys_active == "No")
# keeps everybody that isnt physical active, "==" keep
nhanes_small %>%
  filter(phys_active != "No")
# "!=" not equal to
nhanes_small %>%
  filter(bmi == 25)
# every bmi thats equal 25
nhanes_small %>%
  filter(bmi >= 25 & phys_active == "No")
# bmi equal or grather 25 and no physical activiy, by default using comma as "and"
nhanes_small %>%
  filter(bmi == 25 | phys_active == "No")
# "|" means OR ; be careful around OR


# Arranging rows ----------------------------------------------------------

nhanes_small %>%
  arrange(desc(age))
# arrage is select, desc to see oldest
nhanes_small %>%
  arrange(desc(age), bmi)
# arrange/sorting rows usually only sort by 1 or 2 variables; least used of the functions

# Mutating columns --------------------------------------------------------

nhanes_small %>%
  mutate(age = age * 12)
# what you want to mutate an exciting column, but you can rename it something that doesn't exsist yet see next
nhanes_small %>%
  mutate(age_month = age * 12)
# to create new column
nhanes_small %>%
  mutate(age_month = age * 12, logged_bmi = log(bmi))
# with a comma can add as many as we want --> what to do multiple calculations at once
nhanes_small %>%
  mutate(
    age_month = age * 12,
    logged_bmi = log(bmi),
    age_weeks = age_month * 4
  )
# does it sequ, so it will be abkle to do them both
nhanes_small %>%
  mutate(
    age_month = age * 12,
    logged_bmi = log(bmi),
    age_weeks = age_month * 4,
    old = if_else(
      age >= 30,
      "old",
      "young"
    )
  )
# to distinglish btw old and young

# Exercise 7.12 Piping, filtering and mutating ----------------------------

# 1. BMI between 20 and 40 with diabetes
nhanes_small %>%
  # Format should follow: variable >= number or character
  filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes")

# Pipe the data into mutate function and:
nhanes_modified <- nhanes_small %>% # Specifying dataset
  mutate(
    # 2. Calculate mean arterial pressure
    mean_art_pres = (((2 * bp_dia_ave) + bp_sys_ave) / 3),
    # 3. Create young_child variable using a condition
    young_child = if_else(age < 6, "Yes", "No")
  )

nhanes_modified

# Summarizing  ------------------------------------------------------------

nhanes_small %>%
  summarise(
    max_bmi = max(bmi)
  )
# summarize will only give you one row unless xou group it NA because missing values, to deal with that use na.rm = TRUE
nhanes_small %>%
  summarise(
    max_bmi = max(bmi, na.rm = TRUE)
  )
# only gives what Im asking for
nhanes_small %>%
  filter(!is.na(diabetes)) %>%
  group_by(
    diabetes,
    phys_active
  ) %>%
  summarize(
    max_bmi = max(bmi,
      na.rm = TRUE
    ),
    min_bmi = min(bmi,
      na.rm = TRUE
    )
  ) %>%
ungroup()
# group_by to use split and combine for diabetes and phys_active
# always want to end with ungrouping, could mess up later analysis

#save dataset write_csv
write_csv(
    nhanes_small,
    here::here("data/nhances_small.csv")
)
# here() function to tell R to go to the project root and then use that file path
# puts .csv file in the LearningR in data folder
