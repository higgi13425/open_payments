library(tidyverse)
library(here)
library(tictoc)
library(data.table)
library(vroom)
library(arrow)
library(dtplyr)

# compare data.table to data.table with dtplyr 
# to arrow to vroom with dplyr
# Compare with 2016 data
# 6.4 GB


#1 pure data.table

pdt <- data.table::fread("data_years/OP_DTL_GNRL_PGYR2016_P01212022.csv")

tictoc::tic()
pdt[Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Gastroenterology", 
    .(total_usd = sum(Total_Amount_of_Payment_USDollars)),
    by = .(Physician_First_Name, Physician_Last_Name)]
tictoc::toc()
# 0.3 seconds

#2 data.table with dtplyr
lz_dt <- data.table::fread("data_years/OP_DTL_GNRL_PGYR2016_P01212022.csv") |>
  dtplyr::lazy_dt()
library(dtplyr)
tictoc::tic()
lz_dt |>
  filter(Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Gastroenterology") |>
  group_by(Physician_First_Name, Physician_Last_Name) |>
  summarize(total_usd = sum(Total_Amount_of_Payment_USDollars))
tictoc::toc()
# 1.28 sec


#3 arrow
library(arrow)
da <- read_csv_arrow("data_years/OP_DTL_GNRL_PGYR2016_P01212022.csv") 

tictoc::tic()
da |>
  filter(Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Gastroenterology") |>
  group_by(Physician_First_Name, Physician_Last_Name) |>
  summarize(total_usd = sum(Total_Amount_of_Payment_USDollars)) |>
  collect()
tictoc::toc()
# 4.7 sec

#4 vroom with dplyr (don't bother)
dv <- vroom("data_years/OP_DTL_GNRL_PGYR2016_P01212022.csv") 

tictoc::tic()
dv |>
  filter(Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Gastroenterology") |>
  group_by(Physician_First_Name, Physician_Last_Name) |>
  summarize(total_usd = sum(Total_Amount_of_Payment_USDollars))
tictoc::toc()
# Way TOO MANY sec

# Memory size problem
# 16 GB Mac mini
# Can read in up to 2 of these 11M row datasets, but not 3
# Get error
# R> data2020 <- fread(here("data_years/OP_DTL_GNRL_PGYR2020_P01212022.csv"))
# Error: vector memory exhausted (limit reached?)