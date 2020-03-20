# mass_covid19
Updated March 18, 2020

These are the current cases and relative increases by county of confirmed and presumptive cases (presumptive cases to be assessed as confirmed by the CDC) of Covid-19 in Massachusetts. For others wanting to do more with the data, see the data folder. I intend to add more demographics as detailed in the daily metrics time permitting. 

Details as gathered from Mass.gov

Number of Cases
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/maps/mass_covid19_20032020.png)

Percentage of Population with Cases
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/maps/mass_covid19_percent_20032020.png)
Cases by County
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/line/mass_covid19_all_20032020.png)
Logarithmic Version 
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/line/mass_covid19_all_log_20032020.png)
Broken Out by County
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/line/mass_covid19_20032020.png)

Some simple logarithmic growth rate predictions for Monday now. 
Current Predictions
Under:1
Over:0
```
> mod <- lm(log(covid.19)~date:counties+counties,dat_current)
> tomorrow <- data.frame("counties"=unique(dat_current$counties),"date"=as.Date("2020-03-23"))
> predictions <- data.frame("counties"=unique(dat_current$counties),"date"=as.Date("2020-03-23"),"predict"=exp(predict(mod,tomorrow)))
> predictions
     counties       date    predict
1   Berkshire 2020-03-23  27.696414
2       Essex 2020-03-23  81.847130
3   Middlesex 2020-03-23 196.769747
4     Norfolk 2020-03-23  83.645393
5     Suffolk 2020-03-23 123.786301
6   Worcester 2020-03-23  57.754687
7  Barnstable 2020-03-23  40.203792
8     Bristol 2020-03-23  14.715207
9     Hampden 2020-03-23   9.262674
10   Plymouth 2020-03-23  19.380109
11   Franklin 2020-03-23   1.000000
12  Hampshire 2020-03-23  16.000000
> sum(predictions$predict)
[1] 672.0615

```
