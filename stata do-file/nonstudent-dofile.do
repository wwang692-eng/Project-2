*****Rearange data and difference-in-difference regression analysis for different shocks to unemployment within different provinces*****

cap log close
log using "nonstudent.smcl", replace 
***1. Import dataset

import delimited "C:\Users\Administrator\Documents\加拿大数据\疫情对学生失业率的冲击\Final_Data.csv"




***2. Clean data and generate dummy variables for provinces and times

keep if students=="Non-students" 
* Non-students is the group who most heavily relys on finding jobs, which means this group can reflect the change of unemployment rate more obviously than the other groups of students.


encode ref_date,gen(date)
* In the raw dataset, date value is string which cannot be used for regression, so I use "encode" to change the data type.

encode geo, gen(province_id)
* Similarly, change the data type of provinces.

xtset province_id date
* Now, set the dataset as panel data.


gen treated = ( geo == "Ontario"| geo =="Quebec")
* Set up the dummy variable of treated group which refers to Ontario and Quebec, the variable is named as "treated".


gen post = (ref_date>="2020-03-01")
* Set up the dummy variable for time after covid-19 occured in Canada, generally, the time of covid-19 started is thought from 2020-03-01 in Canada. The variable is named as "post". 


gen did = treated*post
* Set up the interaction term used for DID regression.





***3. Regulate the provinces I will analyze, I already make Ontario and Quebec as the treated group, and I must make sure the four Atlantic provinces are in the control group.
gen compare_sample = .

replace compare_sample = 1 if geo == "Ontario" | geo == "Quebec"

replace compare_sample = 0 if geo == "Nova Scotia" | geo == "New Brunswick" | geo == "Prince Edward Island" | geo == "Newfoundland and Labrador"







***4. For including the time fixed effect in DID regression, I must seperate the year and month from every datetime.
gen date_num = date( ref_date , "YMD")

format date_num %td

gen mdate = mofd(date_num)

format mdate %tm

gen year = year(dofm(mdate))

gen month = month(dofm(mdate))



***5. Check heteroscedasticity, individual fixed effect and parallel trend prepared for DID.
reg  unemploymentrate  did  treated  post
*First, run the most simple OLS regression to checkout if the dataset is accessible to be regressed.

estat imtest, white
*Check if heteroskedasticity exists by White test


reg  unemploymentrate  did  treated  post  i.province_id , vce(cluster province_id )
* Then, use the method LSDV to check if the individual fixed effect of each province exists, the result shows that all provinces' dummy variables are statistically significant, that means individual fixed effect exsits, so we need to use FE regression instead of pooled OLS regression.


tab year, gen (year_)
tab month, gen(month_)
*Generate dummy variables of year and month.


gen treat_year2 = treated* year_2
gen treat_year3 = treated* year_3
gen treat_year4 = treated* year_4
gen treat_year5 = treated* year_5
*Generate four interaction terms that four year dummy variables before 2020 time the dummy variable "treated"   

reg unemploymentrate did treated post treat_year2-treat_year5 if compare_sample != .
*Take the parallel trend test, the result shows coefficients of each interaction term and the p values are not statistically significant, which means parallel trend is proved, so it is accessible to use DID regression.


xtreg unemploymentrate did i.year i.month if compare_sample != ., fe vce(cluster province_id)
*Start DID regression with two-way fixed effect, and cluster robust standard error.






***6. Check the dataset is short panel or long panel
xtdes
* n=10, T=88, so this is a long panel





***7. Check and correct groupwise heteroscedasticity and contemporaneous correlation.
quietly xtreg unemploymentrate did i.year i.month if compare_sample != ., fe vce(cluster province_id)
xttest3
*According to the result shown, the null hypothesis should be rejected strongly, which means groupwise heteroscedasticity exists.


ssc install xttest2
quietly xtreg unemploymentrate did i.year i.month if compare_sample != ., fe vce(cluster province_id)
xttest2
*According to the result shown, the null hypothesis should be rejected strongly, which means contemporaneous correlation exists.


ssc install xtscc
xtscc unemploymentrate  did  year_*  month_*  if compare_sample !=., fe lag(3)
*After the tests above, we need to use the stata command "xtscc" to deal with groupwise heteroscedasticity and contemporaneous correlation.








***8. Let Ontario and Quebec be the treated group, while the Four Atlantic Provinces as the control group to start the DID regression with panel-corrected standard error.
xtscc unemploymentrate  did  year_*  month_*  if compare_sample !=., fe lag(3)

xtscc participationrate  did  year_*  month_*  if compare_sample !=., fe lag(3)

gen nowork = 100- employmentrate
xtscc nowork  did  year_*  month_*  if compare_sample !=., fe lag(3)






***9. Let the Four Western provinces(Alberta,Manitoba,Saskatchewan,British Columbia) be the treated group, while the control group is unchanged to start the DID regression with panel-corrected standard error.
gen treated2 = ( geo == "Alberta"| geo =="Saskatchewan" | geo == "Manitoba" | geo=="British Columbia")
gen did2 = treated2*post
*Repeat above steps of generating province dummy variables and DID interaction term


gen compare_sample2 = .

replace compare_sample2 = 1 if geo == "Alberta"| geo =="Saskatchewan" | geo == "Manitoba" | geo=="British Columbia"
replace compare_sample2 = 0 if geo == "Nova Scotia" | geo == "New Brunswick" | geo == "Prince Edward Island" | geo == "Newfoundland and Labrador"
*Get the new treated group and the control group is unchanged. 




xtscc unemploymentrate  did2  year_*  month_*  if compare_sample2 !=., fe lag(3)
xtscc participationrate  did2  year_*  month_*  if compare_sample2 !=., fe lag(3)
xtscc nowork  did2  year_*  month_*  if compare_sample2 !=., fe lag(3)
*Similarly, take the DID regressions for the new treated group. 







***10. Comparison within pooled OLS, Fixed Effect(Standard), Fixed Effect(Driscoll-Kraay Standard Error) and Random Effect regressions.
quietly reg  unemploymentrate  did treated post ,robust
estimates store OLS

quietly xtreg unemploymentrate did  i.year i.month if compare_sample != ., fe vce(cluster province_id)
estimates store FE_Standard

quietly xtscc unemploymentrate  did  year_*  month_*  if compare_sample !=., fe lag(3)
estimates store FE


quietly xtreg unemploymentrate did if compare_sample != ., re vce(cluster province_id) theta
estimates store RE

esttab OLS FE_Standard FE  RE, r2 se mtitles star







log close












 
