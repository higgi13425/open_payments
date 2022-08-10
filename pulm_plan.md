Pulmonary Analysis Plan

Short term goals
---------------
0. fix varnames in 2021 so that they align with previous years write new csv
0. try analysis on 2016-2021 only - all 75 col
0. Focus just on pulm, not cc
0. retry the open dataset and total spend by year
0. Look into zipcode mapping - merge physicians with zip and lat/long
0. next look at total # payments by year, 

1. Next look at total # people paid by year
2. Top 10 companies - total # payments, total # unique payees, total # dollars - plot companies on 2 axes - # payees vs # dollars to see strategy - broadcast vs narrowcast to KOLs
3. Clean up code to functions
4.Consider using zipcodeR package and mapping zips to county
5. Try grouping by zip, mapping data with geom_sf

- background on sunshine act and open payments - https://www.mgma.com/advocacy/issues/federal-compliance/physician-open-payments-program

GI paper (preprint)
https://www.gastrojournal.org/article/S0016-5085(22)00647-3/fulltext#.YrImO_zdM6Q.twitter

Initial questions and hypotheses
- is the Sunshine Act accomplishing what it set out to do?
- did COVID have a bigger effect than the Sunshine Act?

Notes
- 2021 data will be released on June 30
  - will add data on PAs, NPs, nurse specialists, CRNAs, nurse-midwives
  - worth looking at (17%) or off-topic?
- currently looking at General file - but there are also
  - Research payment files
  - Ownership (stocks, etc) files if own shares in a pharma/device company
    - worth exploring these, or leave alone?
  
Data fields
Files of 3.3-6.4 GB for each year, more than 10 million rows per year (except 2020), each with ~ 65 variables. Note that a lot of field names changed in 2021 (Covered_Provider instead of Physician)
Data dictionary with changes here: https://www.cms.gov/OpenPayments/Downloads/OpenPaymentsDataDictionary.pdf 

Variables include:
[1] "Change_Type"                                                      
 [2] "Covered_Recipient_Type"                                           
 [3] "Teaching_Hospital_CCN"                                            
 [4] "Teaching_Hospital_ID"                                             
 [5] "Teaching_Hospital_Name"                                           
 [6] "Physician_Profile_ID"                                             
 [7] "Physician_First_Name"                                             
 [8] "Physician_Middle_Name"                                            
 [9] "Physician_Last_Name"                                              
[10] "Physician_Name_Suffix"                                            
[11] "Recipient_Primary_Business_Street_Address_Line1"                  
[12] "Recipient_Primary_Business_Street_Address_Line2"                  
[13] "Recipient_City"                                                   
[14] "Recipient_State"                                                  
[15] "Recipient_Zip_Code"                                               
[16] "Recipient_Country"                                                
[17] "Recipient_Province"                                               
[18] "Recipient_Postal_Code"                                            
[19] "Physician_Primary_Type"                                           
[20] "Physician_Specialty"                                              
[21] "Physician_License_State_code1"                                    
[22] "Physician_License_State_code2"                                    
[23] "Physician_License_State_code3"                                    
[24] "Physician_License_State_code4"                                    
[25] "Physician_License_State_code5"                                    
[26] "Submitting_Applicable_Manufacturer_or_Applicable_GPO_Name"        
[27] "Applicable_Manufacturer_or_Applicable_GPO_Making_Payment_ID"      
[28] "Applicable_Manufacturer_or_Applicable_GPO_Making_Payment_Name"    
[29] "Applicable_Manufacturer_or_Applicable_GPO_Making_Payment_State"   
[30] "Applicable_Manufacturer_or_Applicable_GPO_Making_Payment_Country" 
[31] "Total_Amount_of_Payment_USDollars"                                
[32] "Date_of_Payment"                                                  
[33] "Number_of_Payments_Included_in_Total_Amount"                      
[34] "Form_of_Payment_or_Transfer_of_Value"                             
[35] "Nature_of_Payment_or_Transfer_of_Value"                           
[36] "City_of_Travel"                                                   
[37] "State_of_Travel"                                                  
[38] "Country_of_Travel"                                                
[39] "Physician_Ownership_Indicator"                                    
[40] "Third_Party_Payment_Recipient_Indicator"                          
[41] "Name_of_Third_Party_Entity_Receiving_Payment_or_Transfer_of_Value"
[42] "Charity_Indicator"                                                
[43] "Third_Party_Equals_Covered_Recipient_Indicator"                   
[44] "Contextual_Information"                                           
[45] "Delay_in_Publication_Indicator"                                   
[46] "Record_ID"                                                        
[47] "Dispute_Status_for_Publication"                                   
[48] "Product_Indicator"                                                
[49] "Name_of_Associated_Covered_Drug_or_Biological1"                   
[50] "Name_of_Associated_Covered_Drug_or_Biological2"                   
[51] "Name_of_Associated_Covered_Drug_or_Biological3"                   
[52] "Name_of_Associated_Covered_Drug_or_Biological4"                   
[53] "Name_of_Associated_Covered_Drug_or_Biological5"                   
[54] "NDC_of_Associated_Covered_Drug_or_Biological1"                    
[55] "NDC_of_Associated_Covered_Drug_or_Biological2"                    
[56] "NDC_of_Associated_Covered_Drug_or_Biological3"                    
[57] "NDC_of_Associated_Covered_Drug_or_Biological4"                    
[58] "NDC_of_Associated_Covered_Drug_or_Biological5"                    
[59] "Name_of_Associated_Covered_Device_or_Medical_Supply1"             
[60] "Name_of_Associated_Covered_Device_or_Medical_Supply2"             
[61] "Name_of_Associated_Covered_Device_or_Medical_Supply3"             
[62] "Name_of_Associated_Covered_Device_or_Medical_Supply4"             
[63] "Name_of_Associated_Covered_Device_or_Medical_Supply5"             
[64] "Program_Year"                                                     
[65] "Payment_Publication_Date"    



1. Data prep
- filter to pulm and critical care groups
- do some people show up in both?
- should we pool across both if same name/city? YES

2. What was the Sunshine Act/Open Payments designed to accomplish?
- a bit of naming and shaming
- trying to decrease payments
- is this actually happening
- look a total payments from 2013, 2014-2019 (pre-COVID)
- is the slope negative
- at total # of payments from 2014-2019
- is the slope negative
- look at # of persons paid from 2014-2019
- is the slope negative

3. What was the effect of COVID on payments
- change from 2019 to 2021? (down then rebound)
- larger effect than Sunshine Act
- endpoints: total payments, # payments # persons being paid

4. What types of payments/totals - Nature_of_Payment_or_Transfer_of_Value variable
- how have these changed over time?
   - less food/beverage?
   - less entertainment?
   - more undefined Compensation?
- view options at https://openpaymentsdata.cms.gov/search
Defined at https://www.cms.gov/OpenPayments/Natures-of-Payment 
  - Consulting fees
  - Compensation for services other than consulting, including serving as faculty or as a speaker at an event other than a continuing education program
  - Honoraria
  - Gifts
  - Entertainment
  - Food and beverage
  - Travel and lodging
  - Education
  - Research
  - Charitable contributions
  - Debt forgiveness
  - Royalty or license
  - Current or prospective ownership or investment interest
  - Compensation for serving as faculty or as a speaker for a medical education program. (non-CME)
  - CME certified program
  - Grant
  - Space rental or facility fees
  - Travel and lodging
  
  5. What companies are making payments?
  - Submitting_Applicable_Manufacturer_or_Applicable_GPO_Name variable
    - who are top payors?
    - have these #s gone down over time? or up?
      - total $, $ per payee, number of payees
      - big $ to KOL, few to others strategy vs spread it out strategy
      - are some companies shifting payments from food/bev/entertainment to other categories?
      - are more companies classifying payments in undefined compensation?
  - for each company, who are their main sponsored KOLs with big conflict of interest?
      
6. Which teaching hospitals get the most pay from pharma?
- classify and sum by variables 3-5, Teaching Hospital CCN, ID, Name 
- actually hard to do - this only lists payments to hospital directly.
- mostly for patents, etc - City of Hope for recombinant DNA/insulin is #1
- can you do by city/state, assign to a teaching hospital?
- map it by density $ location - would have to geocode cities

6. Which states have docs that get the most pay from pharma? Adjust for population, get per capita payments
- does this vary by category - Nature_of_Payment_or_Transfer_of_Value
- map by region

7. How does this compare to other specialties
- within medicine - COVID signal smaller outside of CC
  - cards
  - GI
