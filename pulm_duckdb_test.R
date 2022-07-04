library(plyr)
library(duckdb)
library(tidyverse)
library(data.table)
library(dtplyr)
library(dbplyr)
library(arrow)
library(here)
library(tictoc)


# open 2014 dataset partitioned by physician, type, specialty, opened with {arrow}
ds_all <- arrow::open_dataset("data_years", format = "csv")

ds <- arrow::read_csv_arrow("data_years/OP_DTL_GNRL_PGYR2014_P01212022.csv")

ds21 <- arrow::read_csv_arrow("data_years/OP_DTL_GNRL_PGYR2021_P06302022.csv")

dt <- data.table::fread("data_years/OP_DTL_GNRL_PGYR2014_P01212022.csv")

# experiment with arrow dataset - trouble with csv files
# Error: Invalid Input Error: arrow_scan: get_next failed(): Invalid: In CSV column #2: Row #707326: CSV conversion error to null: invalid value '1386219'
dataset <- arrow::open_dataset(
  sources = here("data_years"),
  format = "csv")

# experiment with read-in with data.table fread
files <- list.files(
  path = "~/Documents/RCode/open_payments/data_years",
  pattern = "*.csv", 
  full.names = TRUE)

# vector memory exhausted (can't read all)
# This would work with more RAM, I think - only 16GB
# dt <- rbind.fill(lapply(files, fread, header=TRUE))


# 2014 payment by teaching hosp, totals for all comers
# can not filter by specialty - no rows by doc/affiliated teaching hospital
tic()
ds %>% 
  select(Teaching_Hospital_Name, Recipient_State, Total_Amount_of_Payment_USDollars, 
         Physician_Specialty) %>% 
  group_by(Teaching_Hospital_Name) %>% 
  summarise(total_USD_by_hosp = sum(Total_Amount_of_Payment_USDollars)) |>
  arrange(desc(total_USD_by_hosp))|>
  collect()
toc()

# all years total payments by teaching hospital
# arrow, dbplyr version
# actually 60% faster without duckdb
tic()
ds_all %>% 
  select(Teaching_Hospital_Name, Recipient_State, Total_Amount_of_Payment_USDollars, 
         Physician_Specialty) %>% 
  group_by(Teaching_Hospital_Name) %>% 
  summarise(total_USD_by_hosp = sum(Total_Amount_of_Payment_USDollars)) |>
  arrange(desc(total_USD_by_hosp))|>
  collect()
toc()

# data.table version for teaching hospitals 2014
tic()
dt[,
   .(total_USD_by_hosp = sum(Total_Amount_of_Payment_USDollars)),
   by = Teaching_Hospital_Name][order(-total_USD_by_hosp)]
toc()


# 2014 payment by doc, totals for Pulm CC
tic()
ds %>% 
  to_duckdb() %>% 
  select(Teaching_Hospital_Name, Recipient_State, Total_Amount_of_Payment_USDollars, Physician_Last_Name, Physician_First_Name, Physician_Specialty) %>% 
  filter(Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Pulmonary Disease" | Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Critical Care Medicine" ) %>% 
  group_by(Physician_Last_Name, Physician_First_Name) %>% 
  summarise(total_USD = sum(Total_Amount_of_Payment_USDollars),
  count = n() ) |>
  arrange(desc(total_USD)) |>
  head(n = 10) 
toc()

# 2021 payment by doc, totals for Pulm CC
tic()
ds21 %>% 
  to_duckdb() %>% 
  select(Teaching_Hospital_Name, Recipient_State, Total_Amount_of_Payment_USDollars, Covered_Recipient_Last_Name, Covered_Recipient_First_Name, Covered_Recipient_Specialty_1) %>% 
  filter(Covered_Recipient_Specialty_1 == "Allopathic & Osteopathic Physicians|Internal Medicine|Pulmonary Disease" | Covered_Recipient_Specialty_1 == "Allopathic & Osteopathic Physicians|Internal Medicine|Critical Care Medicine" ) %>% 
  group_by(Covered_Recipient_Last_Name, Covered_Recipient_First_Name) %>% 
  summarise(total_USD = sum(Total_Amount_of_Payment_USDollars),
            count = n() ) |>
  arrange(desc(total_USD)) |>
  head(n = 10) 
toc()


# 2014 payment by doc, totals for Pulm CC
# using data.table code

ds_dt <- ds %>% 
  as.data.table()

tic()
ds_dt[Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Pulmonary Disease" | Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Critical Care Medicine",
 .(USD = sum(Total_Amount_of_Payment_USDollars), .N),
 by = .(Physician_First_Name, Physician_Last_Name)] [
   order(-USD)][
     1:10]
toc()


# 2014 payment by state, totals for Pulm CC
ds %>% 
  to_duckdb() %>% 
  select(Teaching_Hospital_Name, Recipient_State, Total_Amount_of_Payment_USDollars, 
         Physician_Specialty) %>% 
  filter(Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Pulmonary Disease" | Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Critical Care Medicine" ) %>% 
  group_by(Recipient_State) %>% 
  summarise(total_USD_by_state = sum(Total_Amount_of_Payment_USDollars)) |>
  arrange(desc(total_USD_by_state))|>
  collect()


# 2014 payment types, totals for Pulm CC
ds %>% 
  to_duckdb() %>% 
  select(Teaching_Hospital_Name, Recipient_State, Total_Amount_of_Payment_USDollars, Nature_of_Payment_or_Transfer_of_Value,
         Physician_Specialty) %>% 
  filter(Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Pulmonary Disease" | Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Critical Care Medicine" ) %>% 
  group_by(Nature_of_Payment_or_Transfer_of_Value) %>% 
summarise(total_USD_by_type = sum(Total_Amount_of_Payment_USDollars)) |>
  arrange(desc(total_USD_by_type))|>
  collect()

# 2014 payment by PharmaCo, totals for Pulm CC
ds %>% 
  to_duckdb() %>% 
  select(Teaching_Hospital_Name, Recipient_State, Total_Amount_of_Payment_USDollars, Physician_Last_Name, Physician_First_Name, Submitting_Applicable_Manufacturer_or_Applicable_GPO_Name,
         Physician_Specialty) %>% 
  filter(Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Pulmonary Disease" | Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Critical Care Medicine" ) %>% 
  group_by(Submitting_Applicable_Manufacturer_or_Applicable_GPO_Name) %>% 
  summarise(total_USD = sum(Total_Amount_of_Payment_USDollars),
            count = n() ) |>
  arrange(desc(total_USD))|>
  collect()

# 2014 food/beverage only, totals for Pulm CC
ds %>% 
  to_duckdb() %>% 
  filter(Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Pulmonary Disease" | Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Critical Care Medicine" ) %>% 
  filter(Nature_of_Payment_or_Transfer_of_Value == "Food and Beverage") %>% 
  group_by(Physician_Last_Name, Physician_First_Name) %>% 
  summarise(total_USD = sum(Total_Amount_of_Payment_USDollars),
            count = n() ) |>
  arrange(desc(total_USD))|>
  collect()

# 2014 royalty license only, totals for Pulm CC
ds %>% 
  to_duckdb() %>% 
  filter(Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Pulmonary Disease" | Physician_Specialty == "Allopathic & Osteopathic Physicians|Internal Medicine|Critical Care Medicine" ) %>% 
  filter(Nature_of_Payment_or_Transfer_of_Value == "Royalty or License") %>% 
  group_by(Physician_Last_Name, Physician_First_Name) %>% 
  summarise(total_USD = sum(Total_Amount_of_Payment_USDollars),
            count = n() ) |>
  arrange(desc(total_USD))|>
  collect()

