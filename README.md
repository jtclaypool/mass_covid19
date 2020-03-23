# mass_covid19
Updated March 23, 2020

These are the current cases and relative increases by county of confirmed and presumptive cases (presumptive cases to be assessed as confirmed by the CDC) of Covid-19 in Massachusetts. For others wanting to do more with the data, see the data folder. I intend to add more demographics as detailed in the daily metrics time permitting. 

Details as gathered from Mass.gov

Number of Cases
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/maps/mass_covid19_23032020.png)

Percentage of Population with Cases
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/maps/mass_covid19_percent_23032020.png)
Cases by County
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/line/mass_covid19_all_23032020.png)
Logarithmic Version 
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/line/mass_covid19_all_log_23032020.png)
Broken Out by County
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/line/mass_covid19_23032020.png)

Some simple logarithmic growth rate predictions. 

Current Predictions
Under:2
Over:0
```
> mod <- lm(log(covid.19)~date:counties+counties,dat_current)
> tomorrow <- data.frame("counties"=unique(dat_current$counties),"date"=as.Date("2020-03-24"))
> predictions <- data.frame("counties"=unique(dat_current$counties),"date"=as.Date("2020-03-24"),"predict"=exp(predict(mod,tomorrow)))
> predictions
              counties       date    predict
1            Berkshire 2020-03-24  29.403354
2                Essex 2020-03-24 115.053697
3            Middlesex 2020-03-24 251.379785
4              Norfolk 2020-03-24  94.195024
5              Suffolk 2020-03-24 169.999529
6            Worcester 2020-03-24  68.873536
7           Barnstable 2020-03-24  55.577468
8              Bristol 2020-03-24  36.570024
9              Hampden 2020-03-24  24.727468
10            Plymouth 2020-03-24  46.268091
11            Franklin 2020-03-24   2.639016
12           Hampshire 2020-03-24   8.987812
13 Dukes and Nantucket 2020-03-24   1.000000
> sum(predictions$predict)
[1] 904.6748
```
