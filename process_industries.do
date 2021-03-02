cd "C:\Users\mohda\Documents\thesis first\3yp\third_year_paper"


import delimited "C:\Users\mohda\Documents\thesis first\3yp\third_year_paper\industry_lockdowns_naics.csv", clear

gen naics2=string(naics)
gen naics_short = substr(naics2,1,2)
drop naics2
export delimited using "C:\Users\mohda\Documents\thesis first\3yp\third_year_paper\industry_lockdowns_naics.csv", replace