# open_payments

This repository of R code will allow you to analyze the data downloaded from the Open Payments website.

Install R and Rstudio if not available on your computer, using the instructions in chapter 2 here https://bookdown.org/pdr_higgins/rmrwr/.

Then start by cloning this repository to an RStudio project (I named the project "open_payments") from this Github site. Instructions on how to do this are in chapter 16.1 of the e-book https://bookdown.org/pdr_higgins/rmrwr/.

Then Download the data files to your Downloads folder from the Open Payments website here: https://www.cms.gov/OpenPayments/Data/Dataset-Downloads

Download the zipped data for each program year 2014-2021, and for the separate Physician supplement file. For each program year, you want (from within the zipped folder) the file with GNRL in the title, which ends in .CSV. These look something like "OP_DTL_GNRL_PGY2014_P012120222.csv" for the 2014 year. Move these files (one per year and the physician supplement file) from your downloads folder to the R project.

Then go to the Files tab in RStudio, and open the "open_payment.Rnd"" file. In this file, run the code chunks from top to bottom in order, and inspect the results in the Console window. You need to run these in order, using the green rightward arrow at the top of each code chunk. It will take a couple of minutes to read in the big CSV files (about 400-800 MB each), but the code will run quickly after these are ingested.

Inspect the results in the Console window, or click on the resulting files in the Environment tab to inspect each file of results.

Then experiment with the code. Change the code to filter for annual payments of > 200K, or > 50K. Sort by state, by gastro vs hep. Keep the physician variables and try to build a predictive model of who is making big on speaker fees (hint - it looks like big cities). You can even download some of the other zip files to examine ownership payments and research payments.