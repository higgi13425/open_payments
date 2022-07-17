# Geocoding Provider data
# will use tidygeocoder and provider file
library(tidyverse)
library(tidygeocoder)
library(here)
library(data.table)
library(magrittr)

# read in provider data
provider_data <- vroom::vroom(here("data_providers/OP_CVRD_RCPNT_PRFL_SPLMTL_P06302022.csv"), delim = ",")

# note much easier to find zip/lat/long table on internet
# then clean zips to 5 digit
# then left_join to add lat/long

zip_table <- read_csv("https://gist.githubusercontent.com/erichurst/7882666/raw/5bdc46db47d9515269ab12ed6fb2850377fd869e/US%2520Zip%2520Codes%2520from%25202013%2520Government%2520Data")

# add zip field with 5 digits only
# save back to provider data
provider_data %<>% 
  mutate(ZIP = str_sub(Covered_Recipient_Profile_Zipcode, 1, 5)) %>% 
  left_join(zip_table)

# write back to new file in data_providers folder
write_csv(provider_data, "data_providers/providers_lat_long.csv")

# try geocoding first 100
# note more NAs if include street address
# some NAs if include zipcode
# no NAs if do City, State, Country only
# takes around 2m to code 100 addresses
# 11m for first 1000
first_k <- provider_data %>% 
  slice(1:1000) %>% 
  tibble() %>% 
  geocode(city = Covered_Recipient_Profile_City,
          state = Covered_Recipient_Profile_State,
      country = Covered_Recipient_Profile_Country_Name, method = "osm")  
# 7 missing in first 1000 this way - city, state, country

# try with vroom data, zip and country
first_k <- provider_data %>% 
  slice(1:1000) %>% 
  geocode(postalcode =  Covered_Recipient_Profile_Zipcode,
          country = Covered_Recipient_Profile_Country_Name, method = "osm") 
# this gives 2 NAs - one for military APO, one for a nine digit

# next geocode to 5 digit zip only
# this was a bit faster, with only 2 NAs - again the APO (96319) and oddly, the zip for Mayo Clinic (55905), which has lat, long of 44.0, -92.4 - can fix this in code if needed
first_k <- provider_data %>% 
  slice(1:1000) %>% 
  mutate(zip = str_sub(Covered_Recipient_Profile_Zipcode, 1, 5)) %>% 
  geocode(postalcode =  zip,
          country = Covered_Recipient_Profile_Country_Name, method = "osm") 

# check how many 55905
# it is 2,496
provider_data %>%
  mutate(zip = str_sub(Covered_Recipient_Profile_Zipcode, 1, 5)) %>% 
  filter(zip == 55905)
# note duke medical center also has a zip - 27710, 
# but this geocodes properly.

# test first 10K
# takes about 1 hour
first_k <- provider_data %>% 
  slice(1:10000) %>% 
  mutate(zip = str_sub(Covered_Recipient_Profile_Zipcode, 1, 5)) %>% 
  geocode(postalcode =  zip,
          country = Covered_Recipient_Profile_Country_Name, method = "osm") 

table <- read_csv("https://gist.githubusercontent.com/erichurst/7882666/raw/5bdc46db47d9515269ab12ed6fb2850377fd869e/US%2520Zip%2520Codes%2520from%25202013%2520Government%2520Data")
