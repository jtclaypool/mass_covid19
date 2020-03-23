# mass_covid19
Updated March 23, 2020 at 8AM

These are the current cases and relative increases by county of confirmed and presumptive cases (presumptive cases to be assessed as confirmed by the CDC) of Covid-19 in Massachusetts. For others wanting to do more with the data, see the data folder. I intend to add more demographics as detailed in the daily metrics time permitting. 

Details as gathered from Mass.gov

Number of Cases
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/maps/mass_covid19_22032020.png)

Percentage of Population with Cases
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/maps/mass_covid19_percent_22032020.png)
Cases by County
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/line/mass_covid19_all_22032020.png)
Logarithmic Version 
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/line/mass_covid19_all_log_22032020.png)
Broken Out by County
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/line/mass_covid19_22032020.png)

Some simple logarithmic growth rate predictions for Monday now. 
Prediction for March 23rd has increased by 50 (672 -> 723) since new data added from the weekend
Current Predictions
Under:1
Over:0
```
> mod <- lm(log(covid.19)~date:counties+counties,dat_current)
> tomorrow <- data.frame("counties"=unique(dat_current$counties),"date"=as.Date("2020-03-23"))
> predictions <- data.frame("counties"=unique(dat_current$counties),"date"=as.Date("2020-03-23"),"predict"=exp(predict(mod,tomorrow)))
> predictions
              counties       date    predict
1            Berkshire 2020-03-23  26.604631
2                Essex 2020-03-23  83.722784
3            Middlesex 2020-03-23 214.581494
4              Norfolk 2020-03-23  84.707767
5              Suffolk 2020-03-23 138.475335
6            Worcester 2020-03-23  52.894970
7           Barnstable 2020-03-23  36.685343
8              Bristol 2020-03-23  26.762201
9              Hampden 2020-03-23  16.986997
10            Plymouth 2020-03-23  32.932716
11            Franklin 2020-03-23   2.462289
12           Hampshire 2020-03-23   5.656854
13 Dukes and Nantucket 2020-03-23   1.000000
> sum(predictions$predict)
[1] 723.4734

```
