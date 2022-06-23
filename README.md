# open_payments

This code will allow you to analyze the data downloaded from the Open Payments website.

Start by cloning this repository to an RStudio project

Then Download files from here: https://www.cms.gov/OpenPayments/Data/Dataset-Downloads

Download the data for each program year, and for the Physician supplement file. For each program year, you want the file with GNRL in the tiel, that ends in .CSV. Move these files (one per year) from your downloads folder to the R project.

Then open and run the code chunks in the open_payment.Rmd file. It will take a couple of minutes to read in the big CSV files (about 400-800 MB each).