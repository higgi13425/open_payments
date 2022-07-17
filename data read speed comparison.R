library(tidyverse)
library(here)
library(tictoc)
library(data.table)
library(vroom)
library(arrow)
library(duckdb)

# read in 10 rows
tic()
read_csv(here("data_years/OP_DTL_GNRL_PGYR2014_P01212022.csv"), n_max =10)
toc()
# 0.071 sec

# now read in over 11M rows with read_csv
# I have 16 GB of RAM, so
# reading 5.7 GB should work, if slow
tic()
read_csv(here("data_years/OP_DTL_GNRL_PGYR2014_P01212022.csv"))
toc()
#  2873.695 sec ~ 49m

# now read in over 11M rows with data.table::fread
tic()
data.table::fread(here("data_years/OP_DTL_GNRL_PGYR2014_P01212022.csv"))
toc()
# 93.3 sec

# now read in over 11M rows with vroom
tic()
vroom::vroom(here("data_years/OP_DTL_GNRL_PGYR2014_P01212022.csv"))
toc()
# 857.27 sec ~ 14.3 min

# now read in over 11M rows with arrow
tic()
arrow::read_csv_arrow(here("data_years/OP_DTL_GNRL_PGYR2014_P01212022.csv"))
toc()
#  68.785 sec

# read into a dataset object with arrow
ds <- arrow::read_csv_arrow(here("data_years/OP_DTL_GNRL_PGYR2014_P01212022.csv"))

# Memory size problem
# 16 GB Mac mini
# Can read in up to 2 of these 11M row datasets, but not 3
# Get error
# R> data2020 <- fread(here("data_years/OP_DTL_GNRL_PGYR2020_P01212022.csv"))
# Error: vector memory exhausted (limit reached?)