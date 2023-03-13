clear
*insheet using "C:\Users\kraso\iCloudDrive\Documents\RA\CE Design\Hospitality data_cleaned.csv"
insheet using "/Users/craiglandry/Documents/_Research/COVID19/Hospitality/Hospitality data_cleaned.csv"
*insheet using "/Users/sonu/Downloads/Hospitality data_cleaned.csv"
set more off
drop q8

gen male=(q4=="Male")

/*
                  Q5 |      Freq.     Percent        Cum.
---------------------+-----------------------------------
  $10,000 to $19,999 |         64        5.36        5.36
$100,000 to $149,999 |        204       17.09       22.45
    $150,000 or more |        151       12.65       35.09
  $20,000 to $29,999 |         80        6.70       41.79
  $30,000 to $39,999 |        116        9.72       51.51
  $40,000 to $49,999 |        115        9.63       61.14
  $50,000 to $59,999 |        114        9.55       70.69
  $60,000 to $69,999 |         84        7.04       77.72
  $70,000 to $79,999 |         83        6.95       84.67
  $80,000 to $89,999 |         66        5.53       90.20
  $90,000 to $99,999 |         64        5.36       95.56
   Less than $10,000 |         53        4.44      100.00
---------------------+-----------------------------------
               Total |      1,194      100.00*/
			  
gen inc=7 if q5=="Less than $10,000"
replace inc=15 if q5=="$10,000 to $19,999"
replace inc=25 if q5=="$20,000 to $29,999"
replace inc=35 if q5=="$30,000 to $39,999"
replace inc=45 if q5=="$40,000 to $49,999"
replace inc=55 if q5=="$50,000 to $59,999"
replace inc=65 if q5=="$60,000 to $69,999"
replace inc=75 if q5=="$70,000 to $79,999"
replace inc=85 if q5=="$80,000 to $89,999"
replace inc=95 if q5=="$90,000 to $99,999"
replace inc=125 if q5=="$100,000 to $149,999"
*replace inc=175 if q5=="$150,000 or more"
*PARETO CORRECTION: UPPER$/2*(1+((ln(UPPER% + LOWER%) - ln(LOWER%))/(ln(UPPER$) - ln(LOWER$)))/((ln(UPPER%+LOWER%) - ln(LOWER%))/(ln(UPPER$) - ln(LOWER$)) -1)) if q5=="1250,000 or more"
 
replace inc=150/2*(1+((ln(12.65 + 17.09) - ln(17.09))/(ln(150) - ln(100)))/((ln(12.65 + 17.09) - ln(17.09))/(ln(150) - ln(100)) -1)) if q5=="$150,000 or more"

/*            Q6 |      Freq.     Percent        Cum.
---------------+-----------------------------------
       Florida |        277       23.20       23.20
       Georgia |        192       16.08       39.28
      Maryland |        160       13.40       52.68
North Carolina |        214       17.92       70.60
South Carolina |        137       11.47       82.08
      Virginia |        214       17.92      100.00
---------------+-----------------------------------
         Total |      1,194      100.00
*/

gen fl=(q6=="Florida")
gen ga=(q6=="Georgia")
gen md=(q6=="Maryland")
gen nc=(q6=="North Carolina")
gen sc=(q6=="South Carolina")
gen va=(q6=="Virginia")

rename q7 zip

*KNOWLEDGE AND BELIEFS: Q9_1-Q9_9
gen support_shelter=1 if q9_1=="Somewhat agree" | q9_1=="Agree" | q9_1=="Strongly agree"
replace support_shelter=0 if support_shelter==.
gen cont_shelter=1 if q9_2=="Somewhat agree" | q9_2=="Agree" | q9_2=="Strongly agree"
replace cont_shelter=0 if cont_shelter==.
gen shelter_vaccine=1 if q9_3=="Somewhat agree" | q9_3=="Agree" | q9_3=="Strongly agree"
replace shelter_vaccine=0 if shelter_vaccine==.
gen vuln_shelter=1 if q9_4=="Somewhat agree" | q9_4=="Agree" | q9_4=="Strongly agree"
replace vuln_shelter=0 if vuln_shelter==.
gen public_masks=1 if q9_5=="Somewhat agree" | q9_5=="Agree" | q9_5=="Strongly agree"
replace public_masks=0 if public_masks==.
gen emp_masks=1 if q9_6=="Somewhat agree" | q9_6=="Agree" | q9_6=="Strongly agree"
replace emp_masks=0 if emp_masks==.
gen groups_safe=1 if q9_7=="Somewhat agree" | q9_7=="Agree" | q9_7=="Strongly agree"
replace groups_safe=0 if groups_safe==.
gen social_d=1 if q9_8=="Somewhat agree" | q9_8=="Agree" | q9_8=="Strongly agree"
replace social_d=0 if social_d==.
gen covid_indoors=1 if q9_9=="Somewhat agree" | q9_9=="Agree" | q9_9=="Strongly agree"
replace covid_indoors=0 if covid_indoors==.

*ATTITUDES & BHEAVIORS: Q10_1 - Q10_9
gen health_crisis=1 if q10_1=="Somewhat agree" | q10_1=="Agree" | q10_1=="Strongly agree"
replace health_crisis=0 if health_crisis==.
gen shelter_policy=1 if q10_2=="Somewhat agree" | q10_2=="Agree" | q10_2=="Strongly agree"
replace shelter_policy=0 if shelter_policy==.
gen closing_policy=1 if q10_3=="Somewhat agree" | q10_3=="Agree" | q10_3=="Strongly agree"
replace closing_policy=0 if closing_policy==.
gen shutdown_cost=1 if q10_4=="Somewhat agree" | q10_4=="Agree" | q10_4=="Strongly agree"
replace shutdown_cost=0 if shutdown_cost==.
gen bau=1 if q10_5=="Somewhat agree" | q10_5=="Agree" | q10_5=="Strongly agree"
replace bau=0 if bau==.
gen uncomf_masks=1 if q10_6=="Somewhat agree" | q10_6=="Agree" | q10_6=="Strongly agree"
replace uncomf_masks=0 if uncomf_masks==.
gen infect_groceries=1 if q10_7=="Somewhat agree" | q10_7=="Agree" | q10_7=="Strongly agree"
replace infect_groceries=0 if infect_groceries==.
gen infect_delivery=1 if q10_8=="Somewhat agree" | q10_8=="Agree" | q10_8=="Strongly agree"
replace infect_delivery=0 if infect_delivery==.
gen take_vaccine=1 if q10_9=="Somewhat agree" | q10_9=="Agree" | q10_9=="Strongly agree"
replace take_vaccine=0 if take_vaccine==.

*AVERTGING BEHAVIORS: Q12 & Q13, NEED TO BE PARSED
gen shelter0 = strpos(q12, "Sheltered-in-place") > 0 
gen sociald0 = strpos(q12, "Limited exposure to people as much as possible") > 0 
gen rest_del0 = strpos(q12, "Ordered food for restaurant delivery") > 0 
gen rest_to0 = strpos(q12, "Ordered food for restaurant takeout or curbside pickup") > 0 
gen groc_del0 = strpos(q12, "Ordered food for grocery store delivery") > 0 
gen groc_pu0 = strpos(q12, "Ordered food for grocery curbside pickup") > 0 
gen cookhome0 = strpos(q12, "Prepared more home-cooked meals") > 0 
gen mask0 = strpos(q12, "Wore masks in public") > 0 
gen other_mask0 = strpos(q12, "Expected others to wear masks in public") > 0 
gen avoid_crowd0 = strpos(q12, "Avoided crowded public spaces") > 0 

/*                            Q12_11_TEXT |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
             Cancelled all travel plans |          1        2.04        2.04
Continuous handwashing when I returne.. |          1        2.04        4.08
                  Did nothing different |          1        2.04        6.12
                        Hand sanitizing |          1        2.04        8.16
I had a respiratory illness in March .. |          1        2.04       10.20
               Limited Doctor‚Äôs visits. |          1        2.04       12.24
           Limited medical appointments |          1        2.04       14.29
Most grocery stores and Walmart had s.. |          1        2.04       16.33
My therapist stopped practicing due t.. |          1        2.04       18.37
                                NOTHING |          1        2.04       20.41
                      No Church service |          1        2.04       22.45
                       No change at all |          1        2.04       24.49
                                Nothing |          1        2.04       26.53
            Opposite of what Trump says |          1        2.04       28.57
    Ordered groceries for home delivery |          1        2.04       30.61
Postponed medical and dental appointm.. |          1        2.04       32.65
SApouse was in Rehab facility recover.. |          1        2.04       34.69
                     SHELTERED IN PLACE |          1        2.04       36.73
              Started working from home |          1        2.04       38.78
                               Tele Med |          1        2.04       40.82
            Tried to live life as usual |          1        2.04       42.86
Use lots of hand sanitizer, wash hand.. |          1        2.04       44.90
Used more personal and household clea.. |          1        2.04       46.94
                  Washed my hands a LOT |          1        2.04       48.98
   Washed or sanitized hands frequently |          1        2.04       51.02
We always cooked most meals at home, .. |          1        2.04       53.06
We limited grocery shopping to one pe.. |          1        2.04       55.10
      Wiped down mail with disinfectant |          1        2.04       57.14
         Wore mask by force NOT by fear |          1        2.04       59.18
             cancelled 3 vacation trips |          1        2.04       61.22
                  cancelled tavel plans |          1        2.04       63.27
                       cancelled travel |          1        2.04       65.31
        cancelled weekly craft meetings |          1        2.04       67.35
cut out doctor appts and only went ou.. |          1        2.04       69.39
                             furloughed |          1        2.04       71.43
                                   none |          2        4.08       75.51
                      none of the above |          1        2.04       77.55
other family members with less mdical.. |          1        2.04       79.59
shopped for food only during limited .. |          1        2.04       81.63
         social distance measures taken |          1        2.04       83.67
         used drive thru at restaurants |          1        2.04       85.71
                           washed hands |          1        2.04       87.76
washed hands whenever coming back fro.. |          1        2.04       89.80
  went grocery shopping less frequently |          1        2.04       91.84
went out only for groceries and other.. |          1        2.04       93.88
        went to physical grocery stores |          1        2.04       95.92
when out practiced social distancing,.. |          1        2.04       97.96
                         work from home |          1        2.04      100.00
----------------------------------------+-----------------------------------
                                  Total |         49      100.00*/

gen shelter1 = strpos(q13, "Continuing to shelter-in-place") > 0 
gen sociald1 = strpos(q13, "Limiting exposure to people as much as possible") > 0 
gen rest_del1 = strpos(q13, "Ordering food for restaurant delivery") > 0 
gen rest_to1 = strpos(q13, "Ordering food for restaurant takeout or curbside pickup") > 0 
gen groc_del1 = strpos(q13, "Ordering food for grocery store delivery") > 0 
gen groc_pu1 = strpos(q13, "Ordering food for grocery curbside pickup") > 0 
gen cookhome1 = strpos(q13, "Preparing more home-cooked meals") > 0 
gen mask1 = strpos(q13, "Wearing masks in public") > 0 
gen other_mask1 = strpos(q13, "Expects others to wear masks in public") > 0 
gen avoid_crowd1 = strpos(q13, "Avoiding crowded public spaces") > 0 

/*                            Q13_11_TEXT |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
              Continue living as normal |          1        2.33        2.33
Dining in restaurants for lunch some .. |          1        2.33        4.65
       Grocery shopping less frequently |          1        2.33        6.98
                   Living life as usual |          1        2.33        9.30
                                NOTHING |          1        2.33       11.63
    No doctors visits, no church visits |          1        2.33       13.95
                      None of the above |          1        2.33       16.28
                     None of this above |          1        2.33       18.60
                               Not much |          1        2.33       20.93
                                Nothing |          2        4.65       25.58
                Nothing that Trump says |          1        2.33       27.91
Ordering groceries to be home delivered |          1        2.33       30.23
                           Praying More |          1        2.33       32.56
                     Same as pre c19 bs |          1        2.33       34.88
          Using a UVC air purifier 24/7 |          1        2.33       37.21
                Washing hands regularly |          1        2.33       39.53
                  Wearing mask by force |          1        2.33       41.86
Willing to go to more varied places/s.. |          1        2.33       44.19
     Wiping down mail with disinfectant |          1        2.33       46.51
                      Working from home |          1        2.33       48.84
avoiding public restrooms when travel.. |          1        2.33       51.16
avoiding recreational shopping, not e.. |          1        2.33       53.49
                        avoiding travel |          1        2.33       55.81
continuing to cook most meals at home.. |          1        2.33       58.14
   daughters bring groceries to my door |          1        2.33       60.47
                         delayed travel |          1        2.33       62.79
do not get near people wearing masks .. |          1        2.33       65.12
                           hand washing |          1        2.33       67.44
                              no travel |          1        2.33       69.77
                                   none |          2        4.65       74.42
                      none of the above |          1        2.33       76.74
                        social distance |          1        2.33       79.07
social distancing, frequent handwashing |          1        2.33       81.40
                       still furloughed |          1        2.33       83.72
still only go out on days when doctor.. |          1        2.33       86.05
        using drive thru at restaurants |          1        2.33       88.37
      very careful when we have to shop |          1        2.33       90.70
                             wash hands |          1        2.33       93.02
            wear mask if it is required |          1        2.33       95.35
       went to physical grocerry stores |          1        2.33       97.67
                         work from home |          1        2.33      100.00
----------------------------------------+-----------------------------------
                                  Total |         43      100.00*/

*COVID EXPOSURE: Q14
/*                                    Q14 |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                                     No |      1,029       86.18       86.18
No, but I was ill in the past 3 or 4 .. |         64        5.36       91.54
Yes, I tested positive, and I had to .. |         28        2.35       93.89
Yes, I tested positive, and I was ver.. |          7        0.59       94.47
Yes, I tested positive, but only expe.. |         20        1.68       96.15
               Yes, but I wasn‚Äôt tested |         46        3.85      100.00
----------------------------------------+-----------------------------------
                                  Total |      1,194      100.00*/						  
gen covid_pos=1 if q14=="Yes, I tested positive, and I had to be hospitalized" | q14=="Yes, I tested positive, and I was very ill but didn‚Äôt have to be hospitalized" ///
 | q14=="Yes, I tested positive, but only experienced minor illness" | q14=="Yes, I tested positive, but was asymptomatic"
replace covid_pos = 0 if covid_pos==.			
					  

*EXPECTED COVID IMPACTS: Q15
/*I expect I would be hospitalized with serious risk of death
I expect I would be hospitalized, but not face serious risk of death
I expect I would be very ill, but not hospitalized
I expect I would experience only minor illness
I expect I would be asymptomatic
Not sure*/

gen death_risk=(q15=="I expect I would be hospitalized with serious risk of death")
gen serious_risk=(q15=="I expect I would be hospitalized, but not face serious risk of death")
gen very_ill=(q15=="I expect I would be very ill, but not hospitalized")
gen minor_ill=(q15=="I expect I would experience only minor illness")
gen asymp=(q15=="I expect I would be asymptomatic")

gen serious_conseq=1 if death_risk==1 | serious_risk==1 | very_ill==1
replace serious_conseq=0 if serious_conseq==.

*Vulnerable HH
gen vuln=(q17=="Yes" | q17=="Maybe")
*Immunity
gen immune=(q18=="Yes")

*VACCINE EXPECTATIONS
gen exp_vaccine = 5 if q19=="In the next 6 months"
replace exp_vaccine = 10  if q19=="In the next 7 to 12 months"
replace exp_vaccine = 17 if q19=="In the next 13 to 24 months"
replace exp_vaccine = 28 if q19=="24 months from now or longer"
gen vaccine_never=(q19=="Never")

*COVID-STATUS HH: Q16								  
gen covid_hh=1 if q16=="Yes" | q16=="Maybe"
replace covid_hh=0 if covid_hh==.


*WORK STATUS & FINANCIAL IMPACTS: Q20
gen employ_same = strpos(q20, "Employment status is the same; working the same as before COVID-19") > 0 
gen employ_same_work_differ = strpos(q20, "Employment status is the same; but working differently than before COVID-19") > 0 

gen retired = strpos(q20, "Employment status is the same ‚Äì retired") > 0 
replace retired =1 if q20_10_text=="Retired" | q20_10_text=="Retired - don't work" | q20_10_text=="both retired" | q20_10_text=="Retired - don't work" ///
| q20_10_text=="I have retired from teaching (effective June 2020)" | q20_10_text=="retired"

gen student = strpos(q20, "Employment status is the same ‚Äì student") > 0 
gen unemp = strpos(q20, "Employment status is the same ‚Äì unemployed") > 0 
gen covid_unemp = strpos(q20, "One or more members has become unemployed due to the COVID-19 pandemic") > 0 
gen covid_jobchange = strpos(q20, "One or more members have changed jobs due to the COVID-19 pandemic") > 0 
gen covid_add_work = strpos(q20, "One or more members have taken on additional work") > 0 
gen covid_less_work = strpos(q20, "One or more members are working less than before COVID-19 pandemic") > 0 

/*
                            Q20_10_TEXT |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
 money and was furloughed while schoo.. |          1        4.55        4.55
                              Homemaker |          2        9.09       13.64
Husband was furloughed for 4 weeks an.. |          1        4.55       18.18
I have retired from teaching (effecti.. |          1        4.55       22.73
                                Retired |          6       27.27       50.00
                   Retired - don't work |          1        4.55       54.55
                   Unchanged---Disabled |          1        4.55       59.09
We are self-employed with many short .. |          1        4.55       63.64
                      Working from home |          1        4.55       68.18
                           both retired |          1        4.55       72.73
                             furloughed |          1        4.55       77.27
       husband works, I do not disabled |          1        4.55       81.82
                                retired |          4       18.18      100.00
----------------------------------------+-----------------------------------
                                  Total |         22      100.00
*/

*RISKY BEHAVIOR AND RISK PERCEPTIONS: Q21
gen risky_phealth=(q21_1=="Extremely willing" | q21_1=="Somewhat willing")
gen averse_phealth=(q21_1=="Extremely unwilling" | q21_1=="Somewhat unwilling")
gen risky_fhealth=(q21_2=="Extremely willing" | q21_2=="Somewhat willing")
gen averse_fhealth=(q21_2=="Extremely unwilling" | q21_2=="Somewhat unwilling")
gen risky_finance=(q21_3=="Extremely willing" | q21_3=="Somewhat willing")
gen averse_finance=(q21_3=="Extremely unwilling" | q21_3=="Somewhat unwilling")
gen risky_auto=(q21_4=="Extremely willing" | q21_4=="Somewhat willing")
gen averse_auto=(q21_4=="Extremely unwilling" | q21_4=="Somewhat unwilling")
gen risky_sports=(q21_5=="Extremely willing" | q21_5=="Somewhat willing")
gen averse_sports=(q21_5=="Extremely unwilling" | q21_5=="Somewhat unwilling")
gen risky_career=(q21_6=="Extremely willing" | q21_6=="Somewhat willing")
gen averse_career=(q21_6=="Extremely unwilling" | q21_6=="Somewhat unwilling")

rename q21_1 phealth_riskscore
rename q21_2 fhealth_riskscore
rename q21_3 finance_riskscore
rename q21_4 auto_riskscore
rename q21_5 sports_riskscore
rename q21_6 career_riskscore

/*Q22, Q23, Q24*/
gen risk_sip=q22/100
replace risk_sip=1 if risk_sip>1
gen risk_reopen=q23/100
replace risk_reopen=1 if risk_reopen>1
gen risk_bau=q24/100
replace risk_bau=1 if risk_bau>1

*PRE-COVID TAKE OUT/DELIVERY: Q25
/*                     Q25 |      Freq.     Percent        Cum.
---------------------------+-----------------------------------
 Five or more times a week |         14        1.17        1.17
    Less than once a month |        309       25.88       27.05
                     Never |        233       19.51       46.57
              Once a month |        203       17.00       63.57
      Once or twice a week |        162       13.57       77.14
Three to four times a week |         43        3.60       80.74
Two or three times a month |        230       19.26      100.00
---------------------------+-----------------------------------
                     Total |      1,194      100.00
*/
gen pre_to=0 if q25=="Never"
replace pre_to=0.5 if q25=="Less than once a month"
replace pre_to=1 if q25=="Once a month"
replace pre_to=3 if q25=="Two or three times a month"
replace pre_to=8 if q25=="Once or twice a week"
replace pre_to=16 if q25=="Three to four times a week"
replace pre_to=20 if q25=="Five or more times a week"
rename q25 pre_to_ord

*PRE-COVID DINING by restaurant type: Q26
gen pre_upscale =20 if q26_1=="Five or more times a week"
replace pre_upscale=16 if q26_1=="Three to four times a week"
replace pre_upscale=8 if q26_1=="Once or twice a week"
replace pre_upscale=3 if q26_1=="Two or three times a month"
replace pre_upscale=1 if q26_1=="Once a month"
replace pre_upscale=0.5 if q26_1=="Less than once a month"
replace pre_upscale=0 if q26_1=="Never"
rename q26_1 pre_ups_ord

gen pre_moderate =20 if q26_2=="Five or more times a week"
replace pre_moderate=16 if q26_2=="Three to four times a week"
replace pre_moderate=9 if q26_2=="Once or twice a week"
replace pre_moderate=3 if q26_2=="Two or three times a month"
replace pre_moderate=1 if q26_2=="Once a month"
replace pre_moderate=0.5 if q26_2=="Less than once a month"
replace pre_moderate=0 if q26_2=="Never"
rename q26_2 pre_mod_ord

gen pre_casual =20 if q26_3=="Five or more times a week"
replace pre_casual=16 if q26_3=="Three to four times a week"
replace pre_casual=8 if q26_3=="Once or twice a week"
replace pre_casual=3 if q26_3=="Two or three times a month"
replace pre_casual=1 if q26_3=="Once a month"
replace pre_casual=0.5 if q26_3=="Less than once a month"
replace pre_casual=0 if q26_3=="Never"
rename q26_3 pre_cas_ord

gen pre_fast =20 if q26_4=="Five or more times a week"
replace pre_fast=16 if q26_4=="Three to four times a week"
replace pre_fast=8 if q26_4=="Once or twice a week"
replace pre_fast=3 if q26_4=="Two or three times a month"
replace pre_fast=1 if q26_4=="Once a month"
replace pre_fast=0.5 if q26_4=="Less than once a month"
replace pre_fast=0 if q26_4=="Never"
rename q26_4 pre_fas_ord

gen pre_quick =21 if q26_5=="Five or more times a week"
replace pre_quick=16 if q26_5=="Three to four times a week"
replace pre_quick=9 if q26_5=="Once or twice a week"
replace pre_quick=3 if q26_5=="Two or three times a month"
replace pre_quick=1 if q26_5=="Once a month"
replace pre_quick=0.5 if q26_5=="Less than once a month"
replace pre_quick=0 if q26_5=="Never"
rename q26_5 pre_qui_ord

gen pre_dine=pre_quick + pre_fast + pre_casual + pre_moderate + pre_upscale 

*DINING PARTY SIZE: Q27
gen adults=q27_1_text
*destring q27_1_text, gen(adults)
replace adults=1 if adults==0
replace adults=. if adults>11
gen children=q27_2_text
replace children=0 if children==.
replace children=. if children>11

*FOOD PREFERENCE QUESTIONS BEFORE COVID: Q28_1 - Q28_19
gen pre_recognize=1 if q28_1=="Somewhat agree" | q28_1=="Agree" | q28_1=="Strongly agree"
replace pre_recognize=0 if pre_recognize==.
gen pre_fastfood=1 if q28_2=="Somewhat agree" | q28_2=="Agree" | q28_2=="Strongly agree"
replace pre_fastfood=0 if pre_fastfood==.
gen pre_local=1 if q28_3=="Somewhat agree" | q28_3=="Agree" | q28_3=="Strongly agree"
replace pre_local=0 if pre_local==.
gen pre_value=1 if q28_4=="Somewhat agree" | q28_4=="Agree" | q28_4=="Strongly agree"
replace pre_value=0 if pre_value==.
gen pre_highqual=1 if q28_5=="Somewhat agree" | q28_5=="Agree" | q28_5=="Strongly agree"
replace pre_highqual=0 if pre_highqual==.
gen pre_convinient=1 if q28_6=="Somewhat agree" | q28_6=="Agree" | q28_6=="Strongly agree"
replace pre_convinient=0 if pre_convinient==.
gen pre_waited=1 if q28_7=="Somewhat agree" | q28_7=="Agree" | q28_7=="Strongly agree"
replace pre_waited=0 if pre_waited==.
gen pre_interaction=1 if q28_8=="Somewhat agree" | q28_8=="Agree" | q28_8=="Strongly agree"
replace pre_interaction=0 if pre_interaction==.
gen pre_novelty=1 if q28_9=="Somewhat agree" | q28_9=="Agree" | q28_9=="Strongly agree"
replace pre_novelty=0 if pre_novelty==.
gen pre_familiar=1 if q28_10=="Somewhat agree" | q28_10=="Agree" | q28_10=="Strongly agree"
replace pre_familiar=0 if pre_familiar==.
gen pre_cuisine=1 if q28_11=="Somewhat agree" | q28_11=="Agree" | q28_11=="Strongly agree"
replace pre_cuisine=0 if pre_cuisine==.
gen pre_nocook=1 if q28_12=="Somewhat agree" | q28_12=="Agree" | q28_12=="Strongly agree"
replace pre_nocook=0 if pre_nocook==.
gen pre_enjoy=1 if q28_13=="Somewhat agree" | q28_13=="Agree" | q28_13=="Strongly agree"
replace pre_enjoy=0 if pre_enjoy==.
gen pre_occasions=1 if q28_14=="Somewhat agree" | q28_14=="Agree" | q28_14=="Strongly agree"
replace pre_occasions=0 if pre_occasions==.
gen pre_athome=1 if q28_15=="Somewhat agree" | q28_15=="Agree" | q28_15=="Strongly agree"
replace pre_athome=0 if pre_athome==.
gen pre_disctinctive=1 if q28_16=="Somewhat agree" | q28_16=="Agree" | q28_16=="Strongly agree"
replace pre_disctinctive=0 if pre_disctinctive==.
gen pre_meetsneeds=1 if q28_17=="Somewhat agree" | q28_17=="Agree" | q28_17=="Strongly agree"
replace pre_meetsneeds=0 if pre_meetsneeds==.
gen pre_easy=1 if q28_18=="Somewhat agree" | q28_18=="Agree" | q28_18=="Strongly agree"
replace pre_easy=0 if pre_easy==.
gen pre_decision=1 if q28_19=="Somewhat agree" | q28_19=="Agree" | q28_19=="Strongly agree"
replace pre_decision=0 if pre_decision==.

*POST-COVID TAKE OUT/DELIVERY
gen post_to_ind=(q29=="Yes")

gen post_to_upscale =20 if q30_1=="Five or more times a week"
replace post_to_upscale=16 if q30_1=="Three to four times a week"
replace post_to_upscale=8 if q30_1=="Once or twice a week"
replace post_to_upscale=3 if q30_1=="Two or three times a month"
replace post_to_upscale=1 if q30_1=="Once a month"
replace post_to_upscale=0.5 if q30_1=="Less than once a month"
replace post_to_upscale=0 if q30_1=="Never"

gen post_to_moderate =20 if q30_2=="Five or more times a week"
replace post_to_moderate=16 if q30_2=="Three to four times a week"
replace post_to_moderate=8 if q30_2=="Once or twice a week"
replace post_to_moderate=3 if q30_2=="Two or three times a month"
replace post_to_moderate=1 if q30_2=="Once a month"
replace post_to_moderate=0.5 if q30_2=="Less than once a month"
replace post_to_moderate=0 if q30_2=="Never"

gen post_to_casual =20 if q30_3=="Five or more times a week"
replace post_to_casual=16 if q30_3=="Three to four times a week"
replace post_to_casual=8 if q30_3=="Once or twice a week"
replace post_to_casual=3 if q30_3=="Two or three times a month"
replace post_to_casual=1 if q30_3=="Once a month"
replace post_to_casual=0.5 if q30_3=="Less than once a month"
replace post_to_casual=0 if q30_3=="Never"

gen post_to_fast =20 if q30_4=="Five or more times a week"
replace post_to_fast=16 if q30_4=="Three to four times a week"
replace post_to_fast=8 if q30_4=="Once or twice a week"
replace post_to_fast=3 if q30_4=="Two or three times a month"
replace post_to_fast=1 if q30_4=="Once a month"
replace post_to_fast=0.5 if q30_4=="Less than once a month"
replace post_to_fast=0 if q30_4=="Never"

gen post_to_quick =20 if q30_5=="Five or more times a week"
replace post_to_quick=16 if q30_5=="Three to four times a week"
replace post_to_quick=8 if q30_5=="Once or twice a week"
replace post_to_quick=3 if q30_5=="Two or three times a month"
replace post_to_quick=1 if q30_5=="Once a month"
replace post_to_quick=0.5 if q30_5=="Less than once a month"
replace post_to_quick=0 if q30_5=="Never"

gen post_to = post_to_quick + post_to_fast + post_to_casual + post_to_moderate + post_to_upscale


*DINE OUT DURING COVID
gen post_d_ind=(q31=="Yes")

gen post_d_upscale =20 if q32=="Five or more times per week"
replace post_d_upscale=16 if q32=="Three or four times a week"
replace post_d_upscale=8 if q32=="Once or twice a week"
replace post_d_upscale=3 if q32=="Two to three times a month"
replace post_d_upscale=1 if q32=="Once a month"
replace post_d_upscale=0.5 if q32=="Less than once a month"
replace post_d_upscale=0 if q32=="Never"
replace post_d_upscale=0 if post_d_upscale==.
*MAINTAIN THIS FREQUENCY?
gen maintain_upscale=(q33=="Extremely likely" | q33=="Moderately likely" | q33=="Slightly likely")

gen post_d_moderate =20 if q34=="Five or more times per week"
replace post_d_moderate=16 if q34=="Three or four times a week"
replace post_d_moderate=8 if q34=="Once or twice a week"
replace post_d_moderate=3 if q34=="Two to three times a month"
replace post_d_moderate=1 if q34=="Once a month"
replace post_d_moderate=0.5 if q34=="Less than once a month"
replace post_d_moderate=0 if q34=="Never"
replace post_d_moderate=0 if post_d_moderate==.

gen maintain_moderate=(q35=="Extremely likely" | q35=="Moderately likely" | q35=="Slightly likely")

gen post_d_casual =20 if q36=="Five or more times per week"
replace post_d_casual=16 if q36=="Three or four times a week"
replace post_d_casual=8 if q36=="Once or twice a week"
replace post_d_casual=3 if q36=="Two to three times a month"
replace post_d_casual=1 if q36=="Once a month"
replace post_d_casual=0.5 if q36=="Less than once a month"
replace post_d_casual=0 if q36=="Never"
replace post_d_casual=0 if post_d_casual==.

gen maintain_casual=(q37=="Extremely likely" | q37=="Moderately likely" | q37=="Slightly likely")

gen post_d_fast =20 if q38=="Five or more times per week"
replace post_d_fast=16 if q38=="Three or four times a week"
replace post_d_fast=8 if q38=="Once or twice a week"
replace post_d_fast=3 if q38=="Two to three times a month"
replace post_d_fast=1 if q38=="Once a month"
replace post_d_fast=0.5 if q38=="Less than once a month"
replace post_d_fast=0 if q38=="Never"
replace post_d_fast=0 if post_d_fast==.

gen maintain_fast=(q39=="Extremely likely" | q39=="Moderately likely" | q39=="Slightly likely")

gen post_d_quick =20 if q40=="Five or more times per week"
replace post_d_quick=16 if q40=="Three or four times a week"
replace post_d_quick=8 if q40=="Once or twice a week"
replace post_d_quick=3 if q40=="Two to three times a month"
replace post_d_quick=1 if q40=="Once a month"
replace post_d_quick=0.5 if q40=="Less than once a month"
replace post_d_quick=0 if q40=="Never"
replace post_d_quick=0 if post_d_quick==.

gen maintain_quick=(q41=="Extremely likely" | q41=="Moderately likely" | q41=="Slightly likely")

gen post_dine=post_d_quick + post_d_fast + post_d_casual + post_d_moderate + post_d_upscale 

/*Q42 If you have NOT dined out since restricstion on dining have been eased, why not*/
gen nod_time=(q42_1=="Stongly agree" | q42_1=="Agree" | q42_1=="Somewhat agree")
gen nod_money=(q42_2=="Stongly agree" | q42_2=="Agree" | q42_2=="Somewhat agree")
gen nod_closed=(q42_3=="Stongly agree" | q42_3=="Agree" | q42_3=="Somewhat agree")
gen nod_outdoor=(q42_4=="Stongly agree" | q42_4=="Agree" | q42_4=="Somewhat agree")
gen nod_sociald=(q42_5=="Stongly agree" | q42_5=="Agree" | q42_5=="Somewhat agree")
gen nod_safety=(q42_6=="Stongly agree" | q42_6=="Agree" | q42_6=="Somewhat agree")
gen nod_comm1=(q42_7=="Stongly agree" | q42_7=="Agree" | q42_7=="Somewhat agree")
gen nod_comm2=(q42_8=="Stongly agree" | q42_8=="Agree" | q42_8=="Somewhat agree")
gen nod_comm3=(q42_9=="Stongly agree" | q42_9=="Agree" | q42_9=="Somewhat agree")
gen nod_vaccine=(q42_10=="Stongly agree" | q42_10=="Agree" | q42_10=="Somewhat agree")

*DINING SAFETY PROTOCOL: Q43
gen DS_6feet=(q43_1=="Extremely important" | q43_1=="Very important" | q43_1=="Moderately important")
gen DS_outdoor=(q43_2=="Extremely important" | q43_2=="Very important" | q43_2=="Moderately important")
gen DS_emp_mask=(q43_3=="Extremely important" | q43_3=="Very important" | q43_3=="Moderately important")
gen DS_emp_gloves=(q43_4=="Extremely important" | q43_4=="Very important" | q43_4=="Moderately important")
gen DS_emp_temps=(q43_5=="Extremely important" | q43_5=="Very important" | q43_5=="Moderately important")
gen DS_guest_temps=(q43_6=="Extremely important" | q43_6=="Very important" | q43_6=="Moderately important")
gen DS_dmenus=(q43_7=="Extremely important" | q43_7=="Very important" | q43_7=="Moderately important")
gen DS_dware=(q43_8=="Extremely important" | q43_8=="Very important" | q43_8=="Moderately important")
gen DS_plexi=(q43_9=="Extremely important" | q43_9=="Very important" | q43_9=="Moderately important")
gen DS_web=(q43_10=="Extremely important" | q43_10=="Very important" | q43_10=="Moderately important")
gen DS_signage=(q43_11=="Extremely important" | q43_11=="Very important" | q43_11=="Moderately important")
gen DS_guest_mask=(q43_12=="Extremely important" | q43_12=="Very important" | q43_12=="Moderately important")
gen DS_compliance=(q43_13=="Extremely important" | q43_13=="Very important" | q43_13=="Moderately important")
gen DS_cpay=(q43_14=="Extremely important" | q43_14=="Very important" | q43_14=="Moderately important")
gen DS_rcapacity=(q43_15=="Extremely important" | q43_15=="Very important" | q43_15=="Moderately important")
gen DS_sanitize=(q43_16=="Extremely important" | q43_16=="Very important" | q43_16=="Moderately important")
gen DS_hand=(q43_17=="Extremely important" | q43_17=="Very important" | q43_17=="Moderately important")
gen DS_to=(q43_18=="Extremely important" | q43_18=="Very important" | q43_18=="Moderately important")
gen DS_sick_signage=(q43_19=="Extremely important" | q43_19=="Very important" | q43_19=="Moderately important")
gen DS_grade=(q43_20=="Extremely important" | q43_20=="Very important" | q43_20=="Moderately important")
gen DS_leave=(q44=="Extremely likely" | q44=="Moderately likely" | q44=="Slightly likely")


/*attempt to assign block numbers*/

/*
                 Q47 |      Freq.     Percent        Cum.
---------------------+-----------------------------------
dine at Restaurant A |         13        8.72        8.72
dine at Restaurant B |         77       51.68       60.40
        not dine out |         59       39.60      100.00
---------------------+-----------------------------------
               Total |        149      100.00

*/

gen block=1 if q47=="dine at Restaurant A" | q47=="dine at Restaurant B" | q47=="not dine out"
replace block=2 if q57=="dine at Restaurant A" | q57=="dine at Restaurant B" | q57=="not dine out"
replace block=3 if q67=="dine at Restaurant A" | q67=="dine at Restaurant B" | q67=="not dine out"
replace block=4 if q77=="dine at Restaurant A" | q77=="dine at Restaurant B" | q77=="not dine out"
replace block=5 if q87=="dine at Restaurant A" | q87=="dine at Restaurant B" | q87=="not dine out"
replace block=6 if q97=="dine at Restaurant A" | q97=="dine at Restaurant B" | q97=="not dine out"
replace block=7 if q107=="dine at Restaurant A" | q107=="dine at Restaurant B" | q107=="not dine out"
replace block=8 if q117=="dine at Restaurant A" | q117=="dine at Restaurant B" | q117=="not dine out"

/*Parsing other questions before expanding the dataset*/

*IMAGERY AND REACTIONS: Q126
gen empmasks_safe=(q126_1=="Strongly agree" | q126_1=="Agree" | q126_1=="Somewhat agree")
gen empmasks_precaut=(q126_2=="Strongly agree" | q126_2=="Agree" | q126_2=="Somewhat agree")
gen empmasks_lesssafe=(q126_3=="Strongly agree" | q126_3=="Agree" | q126_3=="Somewhat agree")
gen empmasks_unapp=(q126_4=="Strongly agree" | q126_4=="Agree" | q126_4=="Somewhat agree")
gen would_dine=(q126_5=="Strongly agree" | q126_5=="Agree" | q126_5=="Somewhat agree")
gen say_positive=(q126_6=="Strongly agree" | q126_6=="Agree" | q126_6=="Somewhat agree")

gen ind_comf=(q127=="Extremely comfortable" | q127=="Moderately comfortable" | q127=="Slightly comfortable")
gen between_comf=(q128=="Extremely comfortable" | q128=="Moderately comfortable" | q128=="Slightly comfortable")
gen between_apart_comf=(q129=="Extremely comfortable" | q129=="Moderately comfortable" | q129=="Slightly comfortable")

/*DEMOGRAPHICS*/

gen bachelor=1 if q130=="Bachelor's degree in college (4-year)"
replace bachelor=0 if bachelor==.
gen graduate=1 if q130=="Master's degree" | q130=="Doctoral degree" | q130=="Professional degree (JD, MD)"
replace graduate=0 if graduate==.

gen hisp=1 if q131=="Yes"
replace hisp=0 if hisp==.

gen hisp_spa=1 if q132=="Spanish"
replace hisp_spa=0 if hisp_spa==.
gen hisp_hisp=1 if q132=="Hispanic"
replace hisp_hisp=0 if hisp_hisp==.
gen hisp_lat=1 if q132=="Latino"
replace hisp_lat=0 if hisp_lat==.

gen white=1 if q133=="White"
replace white=0 if white==.
gen black=1 if q133=="Black or African American"
replace black=0 if black==.
gen asian=1 if q133=="Asian"
replace asian=0 if asian==.
gen native=1 if q133=="American Indian or Alaska Native"
replace native=0 if native==.
gen pacific=1 if q133=="Native Hawaiian or Pacific Islander"
replace pacific=0 if pacific==.

/*         Q133_6_TEXT |      Freq.     Percent        Cum.
---------------------+-----------------------------------
   European American |          2       11.76       11.76
            Hispanic |          2       11.76       23.53
    Israeli American |          1        5.88       29.41
      Latin American |          1        5.88       35.29
              Latino |          1        5.88       41.18
             Mexican |          1        5.88       47.06
          Mixed race |          1        5.88       52.94
Prefer not to answer |          1        5.88       58.82
           caucasian |          1        5.88       64.71
               human |          1        5.88       70.59
              latino |          1        5.88       76.47
               mixed |          1        5.88       82.35
        mixed racial |          1        5.88       88.24
       prefer no ans |          1        5.88       94.12
prefer not to answer |          1        5.88      100.00
---------------------+-----------------------------------
               Total |         17      100.00
*/

/*Q134 OCCUPATION has some random entries, should we use this questions to eliminate unreliable responses??*/


/*From Johnís travel survey: Q135*/
gen trips_culture=(q135_1=="Always" | q135_1=="Often" | q135_1=="Sometimes")
gen trips_enter=(q135_2=="Always" | q135_2=="Often" | q135_2=="Sometimes")
gen trips_events=(q135_3=="Always" | q135_3=="Often" | q135_3=="Sometimes")
gen trips_food=(q135_4=="Always" | q135_4=="Often" | q135_4=="Sometimes")
gen trips_indig=(q135_5=="Always" | q135_5=="Often" | q135_5=="Sometimes")
gen trips_nature=(q135_6=="Always" | q135_6=="Often" | q135_6=="Sometimes")
gen trips_relax=(q135_7=="Always" | q135_7=="Often" | q135_7=="Sometimes")
gen trips_sport=(q135_8=="Always" | q135_8=="Often" | q135_8=="Sometimes")
gen trips_touring=(q135_9=="Always" | q135_9=="Often" | q135_9=="Sometimes")
gen trips_family=(q135_10=="Always" | q135_10=="Often" | q135_10=="Sometimes")

su age male inc bachelor graduate hisp hisp_spa hisp_hisp hisp_lat white black asian native pacific fl ga md nc sc va ///
support_shelter cont_shelter shelter_vaccine vuln_shelter public_masks emp_masks groups_safe social_d covid_indoors ///
health_crisis shelter_policy closing_policy shutdown_cost bau uncomf_masks infect_groceries infect_delivery take_vaccine shelter0 sociald0 ///
rest_del0 rest_to0 groc_del0 groc_pu0 cookhome0 mask0 other_mask0 avoid_crowd0 shelter1 sociald1 rest_to1 groc_del1 groc_pu1 cookhome1 mask1 ///
other_mask1 avoid_crowd1 covid_pos death_risk serious_risk very_ill minor_ill asymp vuln immune exp_vaccine vaccine_never covid_hh employ_same ///
employ_same_work_differ retired student unemp covid_unemp covid_jobchange covid_add_work covid_less_work risky_phealth averse_phealth risky_fhealth ///
averse_fhealth risky_finance averse_finance risky_auto averse_auto risky_sports averse_sports risky_career averse_career risk_sip risk_reopen risk_bau ///
pre_to pre_upscale pre_moderate pre_casual pre_fast pre_quick adults children pre_recognize pre_fastfood pre_local pre_value pre_highqual pre_convinient ///
pre_waited pre_interaction pre_novelty pre_familiar pre_cuisine pre_nocook pre_enjoy pre_athome pre_occasions pre_disctinctive pre_meetsneeds pre_easy ///
pre_decision post_to post_to_upscale post_to_moderate post_to_casual post_to_fast post_to_quick post_d post_d_upscale maintain_upscale post_d_moderate ///
maintain_moderate post_d_casual maintain_casual post_d_fast maintain_fast post_d_quick maintain_quick nod_time nod_money nod_closed nod_outdoor nod_sociald ///
nod_safety nod_comm1 nod_comm2 nod_comm3 nod_vaccine DS_6feet DS_outdoor DS_emp_mask DS_emp_gloves DS_emp_temps DS_guest_temps DS_dmenus DS_plexi DS_dware ///
DS_web DS_signage DS_guest_mask DS_compliance DS_cpay DS_rcapacity DS_sanitize DS_hand DS_to DS_sick_signage DS_grade DS_leave ///
trips_culture trips_enter trips_events trips_food trips_indig trips_nature trips_relax trips_sport trips_touring trips_family ///
empmasks_safe empmasks_precaut empmasks_lesssafe empmasks_unapp would_dine say_positive ind_comf between_comf between_apart_comf, format

/*tabstat age male inc fl ga md nc sc va support_shelter cont_shelter shelter_vaccine vuln_shelter public_masks emp_masks groups_safe social_d covid_indoors ///
health_crisis shelter_policy closing_policy shutdown_cost bau uncomf_masks infect_groceries infect_delivery take_vaccine shelter0 sociald0 ///
rest_del0 rest_to0 groc_del0 groc_pu0 cookhome0 mask0 other_mask0 avoid_crowd0 shelter1 sociald1 rest_to1 groc_del1 groc_pu1 cookhome1 mask1 ///
other_mask1 avoid_crowd1 covid_pos death_risk serious_risk very_ill minor_ill asymp vuln immune exp_vaccine vaccine_never covid_hh employ_same ///
employ_same_work_differ retired student unemp covid_unemp covid_jobchange covid_add_work covid_less_work risky_phealth averse_phealth risky_fhealth ///
averse_fhealth risky_finance averse_finance risky_auto averse_auto risky_sports averse_sports risky_career averse_career risk_sip risk_reopen risk_bau ///
pre_to pre_upscale pre_moderate pre_casual pre_fast pre_quick adults children pre_recognize pre_fastfood pre_local pre_value pre_highqual pre_convinient ///
pre_waited pre_interaction pre_novelty pre_familiar pre_cuisine pre_nocook pre_enjoy pre_athome pre_occasions pre_disctinctive pre_meetsneeds pre_easy ///
pre_decision post_to post_to_upscale post_to_moderate post_to_casual post_to_fast post_to_quick post_d post_d_upscale maintain_upscale post_d_moderate ///
maintain_moderate post_d_casual maintain_casual post_d_fast maintain_fast post_d_quick maintain_quick nod_time nod_money nod_closed nod_outdoor nod_sociald ///
nod_safety nod_comm1 nod_comm2 nod_comm3 nod_vaccine DS_6feet DS_outdoor DS_emp_mask DS_emp_gloves DS_emp_temps DS_guest_temps DS_dmenus DS_plexi DS_dware ///
DS_web DS_signage DS_guest_mask DS_compliance DS_cpay DS_rcapacity DS_sanitize DS_hand DS_to DS_sick_signage DS_grade DS_leave, statistics(mean sd min max)
*/

*create numerical id for respondents
gen id=_n
*expand the data for choice sets
expand 3
*create second set of ids within respondents' ids
sort block id
by block id: gen id2 = _n

/*Creating choice situations dummies*/
gen cs=11 if block==1 & id2==1
replace cs=12 if block==1 & id2==2
replace cs=16 if block==1 & id2==3
replace cs=1 if block==2 & id2==1
replace cs=8 if block==2 & id2==2
replace cs=9 if block==2 & id2==3
replace cs=6 if block==3 & id2==1
replace cs=17 if block==3 & id2==2
replace cs=24 if block==3 & id2==3
replace cs=4 if block==4 & id2==1
replace cs=10 if block==4 & id2==2
replace cs=15 if block==4 & id2==3
replace cs=5 if block==5 & id2==1
replace cs=13 if block==5 & id2==2
replace cs=18 if block==5 & id2==3
replace cs=2 if block==6 & id2==1
replace cs=7 if block==6 & id2==2
replace cs=19 if block==6 & id2==3
replace cs=3 if block==7 & id2==1
replace cs=14 if block==7 & id2==2
replace cs=22 if block==7 & id2==3
replace cs=20 if block==8 & id2==1
replace cs=21 if block==8 & id2==2
replace cs=23 if block==8 & id2==3

*expand the data for options
expand 3
sort block id id2
by block id id2: gen id3 = _n
rename id3 option

/*CREATE CHOICE VARIABLES*/
*CS11
gen choice=1 if q47=="dine at Restaurant A" & cs==11 & option==1
replace choice=0 if choice==. & (q47=="dine at Restaurant B" | q47=="not dine out") & cs==11 & option==1
replace choice=1 if q47=="dine at Restaurant B" & cs==11 & option==2
replace choice=0 if choice==. & (q47=="dine at Restaurant A" | q47=="not dine out") & cs==11 & option==2
replace choice=1 if q47=="not dine out" & cs==11 & option==3
replace choice=0 if choice==. & (q47=="dine at Restaurant A" | q47=="dine at Restaurant B") & cs==11 & option==3

*CS12
replace choice=1 if q50=="dine at Restaurant A" & cs==12 & option==1
replace choice=0 if choice==. & (q50=="dine at Restaurant B" | q50=="not dine out") & cs==12 & option==1
replace choice=1 if q50=="dine at Restaurant B" & cs==12 & option==2
replace choice=0 if choice==. & (q50=="dine at Restaurant A" | q50=="not dine out") & cs==12 & option==2
replace choice=1 if q50=="not dine out" & cs==12 & option==3
replace choice=0 if choice==. & (q50=="dine at Restaurant A" | q50=="dine at Restaurant B") & cs==12 & option==3

*CS16
replace choice=1 if q53=="dine at Restaurant A" & cs==16 & option==1
replace choice=0 if choice==. & (q53=="dine at Restaurant B" | q53=="not dine out") & cs==16 & option==1
replace choice=1 if q53=="dine at Restaurant B" & cs==16 & option==2
replace choice=0 if choice==. & (q53=="dine at Restaurant A" | q53=="not dine out") & cs==16 & option==2
replace choice=1 if q53=="not dine out" & cs==16 & option==3
replace choice=0 if choice==. & (q53=="dine at Restaurant A" | q53=="dine at Restaurant B") & cs==16 & option==3

*CS1
replace choice=1 if q57=="dine at Restaurant A" & cs==1 & option==1
replace choice=0 if choice==. & (q57=="dine at Restaurant B" | q57=="not dine out") & cs==1 & option==1
replace choice=1 if q57=="dine at Restaurant B" & cs==1 & option==2
replace choice=0 if choice==. & (q57=="dine at Restaurant A" | q57=="not dine out") & cs==1 & option==2
replace choice=1 if q57=="not dine out" & cs==1 & option==3
replace choice=0 if choice==. & (q57=="dine at Restaurant A" | q57=="dine at Restaurant B") & cs==1 & option==3

*CS8
replace choice=1 if q60=="dine at Restaurant A" & cs==8 & option==1
replace choice=0 if choice==. & (q60=="dine at Restaurant B" | q60=="not dine out") & cs==8 & option==1
replace choice=1 if q60=="dine at Restaurant B" & cs==8 & option==2
replace choice=0 if choice==. & (q60=="dine at Restaurant A" | q60=="not dine out") & cs==8 & option==2
replace choice=1 if q60=="not dine out" & cs==8 & option==3
replace choice=0 if choice==. & (q60=="dine at Restaurant A" | q60=="dine at Restaurant B") & cs==8 & option==3

*CS9
replace choice=1 if q63=="dine at Restaurant A" & cs==9 & option==1
replace choice=0 if choice==. & (q63=="dine at Restaurant B" | q63=="not dine out") & cs==9 & option==1
replace choice=1 if q63=="dine at Restaurant B" & cs==9 & option==2
replace choice=0 if choice==. & (q63=="dine at Restaurant A" | q63=="not dine out") & cs==9 & option==2
replace choice=1 if q63=="not dine out" & cs==9 & option==3
replace choice=0 if choice==. & (q63=="dine at Restaurant A" | q63=="dine at Restaurant B") & cs==9 & option==3

*CS6
replace choice=1 if q67=="dine at Restaurant A" & cs==6 & option==1
replace choice=0 if choice==. & (q67=="dine at Restaurant B" | q67=="not dine out") & cs==6 & option==1
replace choice=1 if q67=="dine at Restaurant B" & cs==6 & option==2
replace choice=0 if choice==. & (q67=="dine at Restaurant A" | q67=="not dine out") & cs==6 & option==2
replace choice=1 if q67=="not dine out" & cs==6 & option==3
replace choice=0 if choice==. & (q67=="dine at Restaurant A" | q67=="dine at Restaurant B") & cs==6 & option==3

*CS17
replace choice=1 if q70=="dine at Restaurant A" & cs==17 & option==1
replace choice=0 if choice==. & (q70=="dine at Restaurant B" | q70=="not dine out") & cs==17 & option==1
replace choice=1 if q70=="dine at Restaurant B" & cs==17 & option==2
replace choice=0 if choice==. & (q70=="dine at Restaurant A" | q70=="not dine out") & cs==17 & option==2
replace choice=1 if q70=="not dine out" & cs==17 & option==3
replace choice=0 if choice==. & (q70=="dine at Restaurant A" | q70=="dine at Restaurant B") & cs==17 & option==3


*CS24
replace choice=1 if q73=="dine at Restaurant A" & cs==24 & option==1
replace choice=0 if choice==. & (q73=="dine at Restaurant B" | q73=="not dine out") & cs==24 & option==1
replace choice=1 if q73=="dine at Restaurant B" & cs==24 & option==2
replace choice=0 if choice==. & (q73=="dine at Restaurant A" | q73=="not dine out") & cs==24 & option==2
replace choice=1 if q73=="not dine out" & cs==24 & option==3
replace choice=0 if choice==. & (q73=="dine at Restaurant A" | q73=="dine at Restaurant B") & cs==24 & option==3

*CS4
replace choice=1 if q77=="dine at Restaurant A" & cs==4 & option==1
replace choice=0 if choice==. & (q77=="dine at Restaurant B" | q77=="not dine out") & cs==4 & option==1
replace choice=1 if q77=="dine at Restaurant B" & cs==4 & option==2
replace choice=0 if choice==. & (q77=="dine at Restaurant A" | q77=="not dine out") & cs==4 & option==2
replace choice=1 if q77=="not dine out" & cs==4 & option==3
replace choice=0 if choice==. & (q77=="dine at Restaurant A" | q77=="dine at Restaurant B") & cs==4 & option==3

*CS10
replace choice=1 if q80=="dine at Restaurant A" & cs==10 & option==1
replace choice=0 if choice==. & (q80=="dine at Restaurant B" | q80=="not dine out") & cs==10 & option==1
replace choice=1 if q80=="dine at Restaurant B" & cs==10 & option==2
replace choice=0 if choice==. & (q80=="dine at Restaurant A" | q80=="not dine out") & cs==10 & option==2
replace choice=1 if q80=="not dine out" & cs==10 & option==3
replace choice=0 if choice==. & (q80=="dine at Restaurant A" | q80=="dine at Restaurant B") & cs==10 & option==3

*CS15
replace choice=1 if q83=="dine at Restaurant A" & cs==15 & option==1
replace choice=0 if choice==. & (q83=="dine at Restaurant B" | q83=="not dine out") & cs==15 & option==1
replace choice=1 if q83=="dine at Restaurant B" & cs==15 & option==2
replace choice=0 if choice==. & (q83=="dine at Restaurant A" | q83=="not dine out") & cs==15 & option==2
replace choice=1 if q83=="not dine out" & cs==15 & option==3
replace choice=0 if choice==. & (q83=="dine at Restaurant A" | q83=="dine at Restaurant B") & cs==15 & option==3

*CS5
replace choice=1 if q87=="dine at Restaurant A" & cs==5 & option==1
replace choice=0 if choice==. & (q87=="dine at Restaurant B" | q87=="not dine out") & cs==5 & option==1
replace choice=1 if q87=="dine at Restaurant B" & cs==5 & option==2
replace choice=0 if choice==. & (q87=="dine at Restaurant A" | q87=="not dine out") & cs==5 & option==2
replace choice=1 if q87=="not dine out" & cs==5 & option==3
replace choice=0 if choice==. & (q87=="dine at Restaurant A" | q87=="dine at Restaurant B") & cs==5 & option==3

*CS13
replace choice=1 if q90=="dine at Restaurant A" & cs==13 & option==1
replace choice=0 if choice==. & (q90=="dine at Restaurant B" | q90=="not dine out") & cs==13 & option==1
replace choice=1 if q90=="dine at Restaurant B" & cs==13 & option==2
replace choice=0 if choice==. & (q90=="dine at Restaurant A" | q90=="not dine out") & cs==13 & option==2
replace choice=1 if q90=="not dine out" & cs==13 & option==3
replace choice=0 if choice==. & (q90=="dine at Restaurant A" | q90=="dine at Restaurant B") & cs==13 & option==3

*CS18
replace choice=1 if q93=="dine at Restaurant A" & cs==18 & option==1
replace choice=0 if choice==. & (q93=="dine at Restaurant B" | q93=="not dine out") & cs==18 & option==1
replace choice=1 if q93=="dine at Restaurant B" & cs==18 & option==2
replace choice=0 if choice==. & (q93=="dine at Restaurant A" | q93=="not dine out") & cs==18 & option==2
replace choice=1 if q93=="not dine out" & cs==18 & option==3
replace choice=0 if choice==. & (q93=="dine at Restaurant A" | q93=="dine at Restaurant B") & cs==18 & option==3

*CS2
replace choice=1 if q97=="dine at Restaurant A" & cs==2 & option==1
replace choice=0 if choice==. & (q97=="dine at Restaurant B" | q97=="not dine out") & cs==2 & option==1
replace choice=1 if q97=="dine at Restaurant B" & cs==2 & option==2
replace choice=0 if choice==. & (q97=="dine at Restaurant A" | q97=="not dine out") & cs==2 & option==2
replace choice=1 if q97=="not dine out" & cs==2 & option==3
replace choice=0 if choice==. & (q97=="dine at Restaurant A" | q97=="dine at Restaurant B") & cs==2 & option==3

*CS7
replace choice=1 if q100=="dine at Restaurant A" & cs==7 & option==1
replace choice=0 if choice==. & (q100=="dine at Restaurant B" | q100=="not dine out") & cs==7 & option==1
replace choice=1 if q100=="dine at Restaurant B" & cs==7 & option==2
replace choice=0 if choice==. & (q100=="dine at Restaurant A" | q100=="not dine out") & cs==7 & option==2
replace choice=1 if q100=="not dine out" & cs==7 & option==3
replace choice=0 if choice==. & (q100=="dine at Restaurant A" | q100=="dine at Restaurant B") & cs==7 & option==3

*CS19
replace choice=1 if q103=="dine at Restaurant A" & cs==19 & option==1
replace choice=0 if choice==. & (q103=="dine at Restaurant B" | q103=="not dine out") & cs==19 & option==1
replace choice=1 if q103=="dine at Restaurant B" & cs==19 & option==2
replace choice=0 if choice==. & (q103=="dine at Restaurant A" | q103=="not dine out") & cs==19 & option==2
replace choice=1 if q103=="not dine out" & cs==19 & option==3
replace choice=0 if choice==. & (q103=="dine at Restaurant A" | q103=="dine at Restaurant B") & cs==19 & option==3

*CS3
replace choice=1 if q107=="dine at Restaurant A" & cs==3 & option==1
replace choice=0 if choice==. & (q107=="dine at Restaurant B" | q107=="not dine out") & cs==3 & option==1
replace choice=1 if q107=="dine at Restaurant B" & cs==3 & option==2
replace choice=0 if choice==. & (q107=="dine at Restaurant A" | q107=="not dine out") & cs==3 & option==2
replace choice=1 if q107=="not dine out" & cs==3 & option==3
replace choice=0 if choice==. & (q107=="dine at Restaurant A" | q107=="dine at Restaurant B") & cs==3 & option==3

*CS14
replace choice=1 if q110=="dine at Restaurant A" & cs==14 & option==1
replace choice=0 if choice==. & (q110=="dine at Restaurant B" | q110=="not dine out") & cs==14 & option==1
replace choice=1 if q110=="dine at Restaurant B" & cs==14 & option==2
replace choice=0 if choice==. & (q110=="dine at Restaurant A" | q110=="not dine out") & cs==14 & option==2
replace choice=1 if q110=="not dine out" & cs==14 & option==3
replace choice=0 if choice==. & (q110=="dine at Restaurant A" | q110=="dine at Restaurant B") & cs==14 & option==3

*CS22
replace choice=1 if q113=="dine at Restaurant A" & cs==22 & option==1
replace choice=0 if choice==. & (q113=="dine at Restaurant B" | q113=="not dine out") & cs==22 & option==1
replace choice=1 if q113=="dine at Restaurant B" & cs==22 & option==2
replace choice=0 if choice==. & (q113=="dine at Restaurant A" | q113=="not dine out") & cs==22 & option==2
replace choice=1 if q113=="not dine out" & cs==22 & option==3
replace choice=0 if choice==. & (q113=="dine at Restaurant A" | q113=="dine at Restaurant B") & cs==22 & option==3

*CS20
replace choice=1 if q117=="dine at Restaurant A" & cs==20 & option==1
replace choice=0 if choice==. & (q117=="dine at Restaurant B" | q117=="not dine out") & cs==20 & option==1
replace choice=1 if q117=="dine at Restaurant B" & cs==20 & option==2
replace choice=0 if choice==. & (q117=="dine at Restaurant A" | q117=="not dine out") & cs==20 & option==2
replace choice=1 if q117=="not dine out" & cs==20 & option==3
replace choice=0 if choice==. & (q117=="dine at Restaurant A" | q117=="dine at Restaurant B") & cs==20 & option==3

*CS21
replace choice=1 if q120=="dine at Restaurant A" & cs==21 & option==1
replace choice=0 if choice==. & (q120=="dine at Restaurant B" | q120=="not dine out") & cs==21 & option==1
replace choice=1 if q120=="dine at Restaurant B" & cs==21 & option==2
replace choice=0 if choice==. & (q120=="dine at Restaurant A" | q120=="not dine out") & cs==21 & option==2
replace choice=1 if q120=="not dine out" & cs==21 & option==3
replace choice=0 if choice==. & (q120=="dine at Restaurant A" | q120=="dine at Restaurant B") & cs==21 & option==3

*CS23
replace choice=1 if q123=="dine at Restaurant A" & cs==23 & option==1
replace choice=0 if choice==. & (q123=="dine at Restaurant B" | q123=="not dine out") & cs==23 & option==1
replace choice=1 if q123=="dine at Restaurant B" & cs==23 & option==2
replace choice=0 if choice==. & (q123=="dine at Restaurant A" | q123=="not dine out") & cs==23 & option==2
replace choice=1 if q123=="not dine out" & cs==23 & option==3
replace choice=0 if choice==. & (q123=="dine at Restaurant A" | q123=="dine at Restaurant B") & cs==23 & option==3


/*generate attribute levels*/
gen out_seat=1 if (cs==1 | cs==2 | cs==3 | cs==4 |cs==7 |cs==8 |cs==12 | cs==13 | cs==17 | cs==21 | cs==23 | cs==24) & option==1
replace out_seat=0 if out_seat==. & option==1
replace out_seat=1 if (cs==1 | cs==4 | cs==10 | cs==11 |cs==12 |cs==13 |cs==14 | cs==21 | cs==22) & option==2
replace out_seat=0 if out_seat==. & option==2
replace out_seat=0 if option==3

gen six_feet=1 if (cs==1 | cs==3 | cs==4 | cs==5 |cs==7 |cs==11 |cs==13 | cs==14 | cs==15 | cs==16 | cs==17 | cs==18 | cs==23) & option==1
replace six_feet=0 if six_feet==. & option==1
replace six_feet=1 if (cs==2 | cs==3 | cs==7 | cs==9 |cs==10 |cs==11 |cs==12 | cs==14 | cs==16 | cs==20 | cs==21 | cs==24) & option==2
replace six_feet=0 if six_feet==. & option==2
replace six_feet=0 if option==3

gen plexi=1 if (cs==1 | cs==2 | cs==5 | cs==6 |cs==9 |cs==13 |cs==15 | cs==16 | cs==17 | cs==18 | cs==20 | cs==21 | cs==22 | cs==24) & option==1
replace plexi=0 if plexi==. & option==1
replace plexi=1 if (cs==2 | cs==3 | cs==7 | cs==8 |cs==10 |cs==12 |cs==14 | cs==15 | cs==16 | cs==17 | cs==18 | cs==22) & option==2
replace plexi=0 if plexi==. & option==2
replace plexi=0 if option==3

gen mask_emp=1 if (cs==2 | cs==4 | cs==5 | cs==6 |cs==9 |cs==14 |cs==15 | cs==17 | cs==18 | cs==21 | cs==24) & option==1
replace mask_emp=0 if mask_emp==. & option==1
replace mask_emp=1 if (cs==3 | cs==5 | cs==7 | cs==10 |cs==11 |cs==12 |cs==13 | cs==15 | cs==23) & option==2
replace mask_emp=0 if mask_emp==. & option==2
replace mask_emp=0 if option==3

gen mask_diners=1 if (cs==1 | cs==2 | cs==3 | cs==4 |cs==7 |cs==8 |cs==12 | cs==13 | cs==16 | cs==20 | cs==21) & option==1
replace mask_diners=0 if mask_diners==. & option==1
replace mask_diners=1 if (cs==1 | cs==2 | cs==4 | cs==6 |cs==7 |cs==9 |cs==10 | cs==13 | cs==16 | cs==17 | cs==18 | cs==19 | cs==20 | cs==22) & option==2
replace mask_diners=0 if mask_diners==. & option==2
replace mask_diners=0 if option==3

gen dispos=1 if (cs==2 | cs==6 | cs==7 | cs==8 |cs==9 |cs==10 |cs==11 | cs==18 | cs==20 | cs==22 | cs==23) & option==1
replace dispos=0 if dispos==. & option==1
replace dispos=1 if (cs==1 | cs==4 | cs==5 | cs==10 |cs==12 |cs==13 |cs==14 | cs==16 | cs==18 | cs==21 | cs==23 | cs==24) & option==2
replace dispos=0 if dispos==. & option==2
replace dispos=0 if option==3

/*CREATE PRICE VARIABLES*/
gen price=16 if (cs==1 | cs==3 | cs==5 | cs==8 |cs==10 |cs==22) & option==1
replace price=24 if (cs==2 | cs==9 | cs==13 | cs==14 |cs==16 |cs==19) & option==1
replace price=30 if (cs==4 | cs==12 | cs==15 | cs==20 |cs==21 |cs==24) & option==1
replace price=40 if (cs==6 | cs==7 | cs==11 | cs==17 |cs==18 |cs==23) & option==1
replace price=16 if (cs==3 | cs==7 | cs==14 | cs==15 |cs==18 |cs==20 | cs==24) & option==2
replace price=24 if (cs==4 | cs==8 | cs==9 | cs==10 |cs==11 |cs==13) & option==2
replace price=30 if (cs==6 | cs==12 | cs==16 | cs==17 |cs==21 |cs==22) & option==2
replace price=40 if (cs==1 | cs==2 | cs==5 | cs==19 |cs==23) & option==2
replace price=0 if option==3

gen nodine=(option==3)

gen hh_cost = price*adults + 8*children if price==16
replace hh_cost = price*adults + 10*children if price==24
replace hh_cost = price*adults + 12*children if price==30
replace hh_cost = price*adults + 15*children if price==40
replace hh_cost = 0 if price==0


gen id3=id2*id*durationinseconds/600*locationlatitude/100*age/10*cs

*FACTORS LIKELY TO INFLUENCE NO-DINE UTILITY
       
gen nd_cs = nodine*cont_shelter 
gen nd_ss = nodine*support_shelter
gen nd_hc = nodine*health_crisis
gen nd_cp = nodine*covid_pos
gen nd_sq = nodine*serious_conseq
gen nd_vu = nodine*vuln
gen nd_rr = nodine*risk_reopen
gen nd_rh = nodine*risky_phealth
gen nd_ah = nodine*averse_phealth
gen nd_fl = nodine*fl
gen nd_sc = nodine*sc
gen nd_nc = nodine*nc
gen nd_va = nodine*va
gen nd_md = nodine*md


***What were the trip changes pre and post covid driven by to various restaurant type (without price model) 

******* Quick Restaurants*****


***Baseline Model ****
** nbreg model weight per id and exposure on age to vary across variables, intrument is age which is endogenous in the model when we see \c_age

*we estimates the effect of subjective risk and behavior on 
**predining across restaurant types 

nbreg pre_quick pre_value pre_interaction pre_cuisine pre_athome pre_occasions risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
adults children [fweight = id], nolog irr  exposure(age) vce(robust)


nbreg post_to_quick nod_time nod_money nod_sociald risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
support_shelter cont_shelter shelter_vaccine vuln_shelter public_masks age ///
DS_6feet DS_outdoor DS_emp_mask DS_plexi DS_dware ///
DS_web DS_compliance DS_cpay DS_rcapacity DS_sanitize covid_pos adults children exp_vaccine [fweight = id], nolog irr  exposure(age) vce(robust)


** Gmm estimator model with instruments as age a function of adult and children to attenuate endogeneity , exposure is id and 
*iterative moment estimator. Instrument is age which is endogenous in the model when we see \c_age
ivpoisson cfunction pre_quick pre_value pre_interaction pre_cuisine pre_athome pre_occasions risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
(age = adults children), igmm vce(robust) exposure(id) nolog irr

ivpoisson cfunction  post_to_quick nod_time nod_money nod_sociald risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
support_shelter cont_shelter shelter_vaccine vuln_shelter public_masks ///
DS_6feet DS_outdoor DS_emp_mask DS_plexi DS_dware ///
DS_web DS_compliance DS_cpay DS_rcapacity DS_sanitize covid_pos ///
(age =  adults children exp_vaccine) , igmm  vce(robust)  exposure(id) nolog irr

margins, dydx(*)
marginsplot, yline(0)



margins, dydx(*)
marginsplot, yline(0)
predict count
predict p, pr(0, post_to)
summarize post_to count p

summarize post_to_quick pre_quick


tabulate post_to, detail


******* Fast Food Restaurants*****


***Baseline Model ****
** nbreg model weight per id and exposure on age to vary across variables, intrument is age which is endogenous in the model when we see \c_age

we estimates the effect of subjective risk and behavior on 
**predining across restaurant types 

nbreg pre_fastfood pre_value pre_interaction pre_cuisine pre_athome pre_occasions risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
adults children [fweight = id], nolog irr  exposure(age) vce(robust)


nbreg post_to_fastfood nod_time nod_money nod_sociald risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
support_shelter cont_shelter shelter_vaccine vuln_shelter public_masks age ///
DS_6feet DS_outdoor DS_emp_mask DS_plexi DS_dware ///
DS_web DS_compliance DS_cpay DS_rcapacity DS_sanitize covid_pos adults children exp_vaccine [fweight = id], nolog irr  exposure(age) vce(robust)



** Gmm estimator model with instruments as age a function of adult and children to attenuate endogeneity , exposure is id and 
*iterative moment estimator. Instrument is age which is endogenous in the model when we see \c_age
ivpoisson cfunction post_to_fastfood pre_value pre_interaction pre_cuisine pre_athome pre_occasions risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
(age = adults children), igmm vce(robust) exposure(id) nolog irr

ivpoisson cfunction  post_to_fastfood nod_time nod_money nod_sociald risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
support_shelter cont_shelter shelter_vaccine vuln_shelter public_masks ///
DS_6feet DS_outdoor DS_emp_mask DS_plexi DS_dware ///
DS_web DS_compliance DS_cpay DS_rcapacity DS_sanitize covid_pos ///
(age =  adults children exp_vaccine) , igmm  vce(robust)  exposure(id) nolog irr

margins, dydx(*)
marginsplot, yline(0)






*******  Moderate Restaurants*****


***Baseline Model ****
** nbreg model weight per id and exposure on age to vary across variables, intrument is age which is endogenous in the model when we see \c_age

we estimates the effect of subjective risk and behavior on 
**predining across restaurant types 

nbreg pre_moderate pre_value pre_interaction pre_cuisine pre_athome pre_occasions risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
adults children [fweight = id], nolog irr  exposure(age) vce(robust)


nbreg post_to_moderate nod_time nod_money nod_sociald risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
support_shelter cont_shelter shelter_vaccine vuln_shelter public_masks age ///
DS_6feet DS_outdoor DS_emp_mask DS_plexi DS_dware ///
DS_web DS_compliance DS_cpay DS_rcapacity DS_sanitize covid_pos adults children exp_vaccine [fweight = id], nolog irr  exposure(age) vce(robust)






** Gmm estimator model with instruments as age a function of adult and children to attenuate endogeneity , exposure is id and 
*iterative moment estimator. Instrument is age which is endogenous in the model when we see \c_age
ivpoisson cfunction pre_moderate pre_value pre_interaction pre_cuisine pre_athome pre_occasions risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
(age = adults children), igmm vce(robust) exposure(id) nolog irr

ivpoisson cfunction  post_to_moderate nod_time nod_money nod_sociald risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
support_shelter cont_shelter shelter_vaccine vuln_shelter public_masks ///
DS_6feet DS_outdoor DS_emp_mask DS_plexi DS_dware ///
DS_web DS_compliance DS_cpay DS_rcapacity DS_sanitize covid_pos ///
(age =  adults children exp_vaccine) , igmm  vce(robust)  exposure(id) nolog irr

margins, dydx(*)
marginsplot, yline(0)






******* Pre Upscale Restaurants*****


***Baseline Model ****
** nbreg model weight per id and exposure on age to vary across variables, intrument is age which is endogenous in the model when we see \c_age

we estimates the effect of subjective risk and behavior on 
**predining across restaurant types 

nbreg pre_upscale pre_value pre_interaction pre_cuisine pre_athome pre_occasions risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
adults children [fweight = id], nolog irr  exposure(age) vce(robust)


nbreg post_to_upscale nod_time nod_money nod_sociald risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
support_shelter cont_shelter shelter_vaccine vuln_shelter public_masks age ///
DS_6feet DS_outdoor DS_emp_mask DS_plexi DS_dware ///
DS_web DS_compliance DS_cpay DS_rcapacity DS_sanitize covid_pos adults children exp_vaccine [fweight = id], nolog irr  exposure(age) vce(robust)


** Gmm estimator model with instruments as age a function of adult and children to attenuate endogeneity , exposure is id and 
*iterative moment estimator. Instrument is age which is endogenous in the model when we see \c_age
ivpoisson cfunction pre_upscale pre_value pre_interaction pre_cuisine pre_athome pre_occasions risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
(age = adults children), igmm vce(robust) exposure(id) nolog irr

ivpoisson cfunction  post_to_upscale nod_time nod_money nod_sociald risky_phealth ///
averse_phealth risky_finance averse_finance risky_fhealth averse_fhealth ///
support_shelter cont_shelter shelter_vaccine vuln_shelter public_masks ///
DS_6feet DS_outdoor DS_emp_mask DS_plexi DS_dware ///
DS_web DS_compliance DS_cpay DS_rcapacity DS_sanitize covid_pos ///
(age =  adults children exp_vaccine) , igmm  vce(robust)  exposure(id) nolog irr

margins, dydx(*)
marginsplot, yline(0)




**Conclusion : Age is highly endogenous for quick and upscale trips to eat out to eat and not significant for ///
****fast food & MODERATE GROUP IN INCASE OF post dining at moderate restaurants   


*Interesting interpretation for covid positive like being covid positive is not significant for upscale but for quick, moderate and fastfood 



