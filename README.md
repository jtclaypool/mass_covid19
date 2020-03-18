# mass_covid19
Updated March 18, 2020

These are the current cases and relative increases by county of confirmed and presumptive cases (presumptive cases to be assessed as confirmed by the CDC) of Covid-19 in Massachusetts. For others wanting to do more with the data, see the data folder. I intend to add more demographics as detailed in the daily metrics time permitting. 

Details as gathered from Mass.gov

Number of Cases
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/maps/mass_covid19_18032020.png)

Percentage of Population with Cases
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/maps/mass_covid19_percent_18032020.png)
Cases by County
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/line/mass_covid19_all_18032020.png)
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/line/mass_covid19_18032020.png)

Some simple logarithmic growth rate predictions (please PLEASE be wrong!!!)
mod <- lm(log(covid.19)~date:counties,dat_current)
tomorrow <- data.frame("counties"=unique(dat_current$counties),"date"=as.Date("2020-03-19"))
exp(predict(mod,tomorrow))

predictions
     counties       date    predict
1   Berkshire 2020-03-19  26.470535
2       Essex 2020-03-19   9.693905
3   Middlesex 2020-03-19 167.653764
4     Norfolk 2020-03-19  77.352338
5     Suffolk 2020-03-19  76.120077
6   Worcester 2020-03-19   7.782630
7  Barnstable 2020-03-19   2.375574
8     Bristol 2020-03-19   5.513746
9     Hampden 2020-03-19   1.885446
10   Plymouth 2020-03-19   6.311711
11   Franklin 2020-03-19   1.223275
> sum(predictions$predict)
[1] 382.383
