# open_payments

This R ode will allow you to analyze the data downloaded from the Open Payments website.

Install R and Rstudio if not available on your computer, using the instructions in chapter 2 here https://bookdown.org/pdr_higgins/rmrwr/.

Then start by cloning this repository to an RStudio project (I named the project "open_payments") from this Github site. Instructions on how to do this are in chapter 16.1 of the e-book https://bookdown.org/pdr_higgins/rmrwr/.

Then Download the data files to your Downloads folder from here: https://www.cms.gov/OpenPayments/Data/Dataset-Downloads

Download the zipped data for each program year 2014-2021, and for the separate Physician supplement file. For each program year, you want (from within the zipped folder) the file with GNRL in the title, which ends in .CSV. These look something like "OP_DTL_GNRL_PGY2014_P012120222.csv" for the 2014 year. Move these files (one per year and the physician supplement file) from your downloads folder to the R project.

Then open and run the code chunks in the open_payment.Rmd file. You need to run these in order, using the green rightward arrow at the top of each code chunk. It will take a couple of minutes to read in the big CSV files (about 400-800 MB each), but the code will run quickly after these are ingested.