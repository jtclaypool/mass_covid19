# mass_covid19
Updated March 18, 2020

These are the current cases and relative increases by county of confirmed and presumptive cases (presumptive cases to be assessed as confirmed by the CDC) of Covid-19 in Massachusetts. For others wanting to do more with the data, see the data folder. I intend to add more demographics as detailed in the daily metrics time permitting. 

Details as gathered from Mass.gov

Number of Cases
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/maps/mass_covid19_19032020.png)

Percentage of Population with Cases
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/maps/mass_covid19_percent_19032020.png)
Cases by County
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/line/mass_covid19_all_19032020.png)
![covid_current](https://github.com/jtclaypool/mass_covid19/blob/master/plots/line/mass_covid19_19032020.png)

Some simple logarithmic growth rate predictions 
```
> mod <- lm(log(covid.19)~date:counties+counties,dat_current)
> tomorrow <- data.frame("counties"=unique(dat_current$counties),"date"=as.Date("2020-03-20"))
> predictions <- data.frame("counties"=unique(dat_current$counties),"date"=as.Date("2020-03-20"),"predict"=exp(predict(mod,tomorrow)))
Warning message:
In predict.lm(mod, tomorrow) :
  prediction from a rank-deficient fit may be misleading
> predictions
     counties       date    predict
1   Berkshire 2020-03-20  19.715511
2       Essex 2020-03-20  27.459935
3   Middlesex 2020-03-20 130.967756
4     Norfolk 2020-03-20  56.848674
5     Suffolk 2020-03-20  71.976044
6   Worcester 2020-03-20  21.408819
7  Barnstable 2020-03-20   7.071068
8     Bristol 2020-03-20   9.486833
9     Hampden 2020-03-20   4.242641
10   Plymouth 2020-03-20   6.454972
11   Franklin 2020-03-20   1.000000
12  Hampshire 2020-03-20   1.000000
> sum(predictions$predict)
[1] 357.6323

```
