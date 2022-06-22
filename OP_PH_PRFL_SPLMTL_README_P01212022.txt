Filename: OP_PH_PRFL_SPLMTL_README_P01212022.txt
Version: 1.0
Date: January 2022

1. Physician Profile Supplement File

The Physician Profile Supplement file contains information about physicians who have been indicated as recipients of payments, other transfers of value, or ownership and investment interest in payment records, as well as physicians who have been identified as principal investigators associated with research payment records published by Open Payments.

This file contains only those physicians that have at least one published payment record in this cycle of the publication as of December 31, 2021. The criteria used by the Centers for Medicare and Medicaid Services (CMS) to determine which payment records are eligible for publication is available in the Open Payments Methodology and Data Dictionary Document. This document can be found on the Resources page of the Open Payments website (https://www.cms.gov/OpenPayments/About/Resources.html). The Methodology and Data Dictionary Document also includes information on the data collection and reporting methodology, data fields included in the files, and any notes or special considerations that users should be aware of. 

2. Considerations for using the CSV File

Microsoft Excel removes leading zeroes from data fields in comma-separated values (CSV) files. Certain fields in this data set may have leading zeroes. These zeroes will be missing when viewing the information within Microsoft Excel. 

Additionally, the latest versions of Microsoft Excel cannot display data sets with more than 1,048,576 rows. This CSV file may exceed that limit. Displaying the data in its entirety may require the use of a spreadsheet program capable of handling very large numbers of records.

3. Details about the OP_PH_PRFL_SPLMTL_P01212022.zip File

This compressed (.zip) file contains one (1) comma-separated values (CSV) file that uses commas as delimiters and one (1) README.txt file. A description of the CSV file is provided below.

OP_PH_PRFL_SPLMTL_P01212022.csv:
This supplementary file displays information on all of the physicians indicated as covered recipients of payments and/or physician principal investigators associated with payments in records published by Open Payments. Each record includes the physician’s demographic information, specialties, and license state, as well as the unique identification number (Physician Profile ID) assigned by Open Payments for each physician. It also includes the unique identification numbers (Associated _Physician Profile_ ID_1 and Associated _Physician Profile_ID_2) of different profiles associated with the same physician. The Physician Profile ID can be used to search Open Payments data to find payments made to, or associated with a specific physician.

The physician profile information included in the payment record data sets is submitted by the reporting entity. In contrast, the physician information included in the supplementary file is derived from different sources, including the National Plan and Provider Enumeration System (NPPES) and the Provider Enrollment, Chain and Ownership System (PECOS). As a result, the data in these sources may differ slightly. When searching for physicians using the Open Payments search tool on https://openpaymentsdata.cms.gov, use the physician information listed in the supplementary file.
