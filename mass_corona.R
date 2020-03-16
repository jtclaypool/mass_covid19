require(usmap)
require(ggplot2)
require(pdftools)
require(rvest)
mass_gov <- pdf_text('https://www.mass.gov/doc/covid-19-cases-in-massachusetts-as-of-march-16-2020/download',)
counties <- strsplit(mass_gov,split = '\r\n')[[1]][8:17]
dat <- data.frame('counties'=sapply(strsplit(counties,'\\s+'),'[[',1),'covid.19'=sapply(strsplit(counties,'\\s+'),'[[',2))
require(xlsx)
fips <- read.xlsx("C://Users/448662/Downloads/fips_codes_website.xls",sheetIndex = 1,header = F,startRow = 13233,endRow = 14906)
cov_counties <- fips[which(fips$X1%in%"MA" & fips$X6%in%dat$counties),]
cov_counties$fips_code <-as.numeric(apply(cov_counties[,c("X2","X3")],1,function(x) paste0(x[1],x[2])))

dat$fips <- cov_counties$fips_code[match(dat$counties,cov_counties$X6)]
dat[which(dat$counties%in%"Berkshire"),"fips"] <- 25003
dat[which(dat$counties%in%"Middlesex"),"fips"] <- 25017
dat[which(dat$counties%in%"Suffolk"),"fips"] <- 25025

dat$covid.19 <- as.numeric(as.character(dat$covid.19))
plot_usmap(data = dat,values= 'covid.19',include=c("MA"),regions = 'counties',labels = T)+
  ggplot2::theme(legend.position = "top",
                 plot.margin = unit(c(0,0,0,0),"cm"))+
  ggplot2::labs(title="Covid-19 Cases in Massachusetss March 16,2020")+
  ggplot2::scale_fill_continuous("Number of Covid-19 Cases")

population <- cbind.data.frame("county"=c("Middlesex","Worcester","Suffolk","Essex","Norfolk","Bristol","Plymouth","Hampden","Barnstable","Hampshire","Berkshire","Franklin","Dukes","Nantucket"),
                               "population"=c(1595192,822280,791766,781024,698249,558905,512135,469116,213690,161159,127328,70935,17313,11101))
dat$pop <- population$population[match(dat$counties,population$county)]
dat$percentage <- dat$covid.19/dat$pop*100

plot_usmap(data = dat,values= 'percentage',include=c("MA"),regions = 'counties',labels = T)+
  ggplot2::theme(legend.position = "top",
                 plot.margin = unit(c(0,0,0,0),"cm"))+
  ggplot2::labs(title="Percentage of Population with Covid-19 Cases in Massachusetss March 16,2020")+
  ggplot2::scale_fill_continuous("Percent of Population with Covid-19 Cases")
