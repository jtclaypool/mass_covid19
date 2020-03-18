require(usmap)
require(ggplot2)
require(pdftools)
require(rvest)
require(xlsx)
fips <- read.xlsx("C://Users/448662/Downloads/fips_codes_website.xls",sheetIndex = 1,header = F,startRow = 13233,endRow = 14906)
previous <- c('https://www.mass.gov/files/documents/2020/03/11/covid-19-case-report-3-11-2020.pdf',
              'https://www.mass.gov/doc/covid-19-cases-in-massachusetts-march-12-2020/download',
              'https://www.mass.gov/doc/covid-19-cases-in-massachusetts-as-of-march-13-2020/download',
              'https://www.mass.gov/doc/covid-19-cases-in-massachusetts-as-of-march-16-2020/download',
              'https://www.mass.gov/doc/covid-19-cases-in-massachusetts-as-of-march-17-2020/download',
              'https://www.mass.gov/doc/covid-19-cases-in-massachusetts-as-of-march-18-2020/download')

build_dat_table <- function(cdc,x=8,y=17,date){
  mass_gov <- pdf_text(cdc)
  counties <- strsplit(mass_gov,split = '\r\n')[[1]][x:y]
  dat <- data.frame('counties'=sapply(strsplit(counties,'\\s+'),'[[',1),'covid.19'=sapply(strsplit(counties,'\\s+'),'[[',2))
  
  cov_counties <- fips[which(fips$X1%in%"MA" & fips$X6%in%dat$counties),]
  cov_counties$fips_code <-as.numeric(apply(cov_counties[,c("X2","X3")],1,function(x) paste0(x[1],x[2])))
  
  dat$fips <- cov_counties$fips_code[match(dat$counties,cov_counties$X6)]
  dat[which(dat$counties%in%"Berkshire"),"fips"] <- 25003
  dat[which(dat$counties%in%"Middlesex"),"fips"] <- 25017
  dat[which(dat$counties%in%"Suffolk"),"fips"] <- 25025
  dat[which(dat$counties%in%"Franklin"),"fips"] <- 25011
  dat$covid.19 <- as.numeric(as.character(dat$covid.19))
  dat$date <- as.Date(date,"%m/%d/%Y")
  population <- cbind.data.frame("county"=c("Middlesex","Worcester","Suffolk","Essex","Norfolk","Bristol","Plymouth","Hampden","Barnstable","Hampshire","Berkshire","Franklin","Dukes","Nantucket"),
                                 "population"=c(1595192,822280,791766,781024,698249,558905,512135,469116,213690,161159,127328,70935,17313,11101))
  dat$population <- population$population[match(dat$counties,population$county)]
  dat$percentage <- dat$covid.19/dat$population*100
  return(dat)
}
load('data/covid_cases.RData')
#dat_0311 <- build_dat_table(previous[1],14,19,'3/11/2020')
#dat_0312 <- build_dat_table(previous[2],14,19,'3/12/2020')
#dat_0313 <- build_dat_table(previous[3],14,19,'3/13/2020')
#dat_0316 <- build_dat_table(previous[4],8,17,'3/16/2020')
#dat_0317 <- build_dat_table(previous[5],8,17,'3/17/2020')


dat_current <- rbind.data.frame(dat_current,build_dat_table(previous[6],8,18,'3/18/2020'))

#dat_current <- rbind.data.frame(dat_0311,dat_0313,dat_0316,dat_0317)
#source: https://www.massachusetts-demographics.com/counties_by_population

save(dat_current,file = 'data/covid_cases.RData')
write.table(dat_current,'data/covid_cases.csv',sep = ',',col.names = T,row.names = F)

#current <- 
plot_usmap(data = dat_current[which(dat_current$date%in%as.Date("2020-03-18")),],values= 'covid.19',include=c("MA"),regions = 'counties',labels = T,aes(size=2))+
  ggplot2::scale_fill_continuous("Number of Covid-19 Cases")+
  ggplot2::theme(legend.position = "top",
                 plot.margin = unit(c(0,0,0,0),"cm"))+
  ggplot2::labs(title="Covid-19 Cases in Massachusetss March 18,2020")
#ggsave('plots/maps/mass_covid19_17032020.png',current,width = 70,height = 65,units = 'mm',scale = 10)
#source: https://www.massachusetts-demographics.com/counties_by_population

#percentage <- 
plot_usmap(data = dat_current[which(dat_current$date%in%as.Date("2020-03-18")),],values= 'percentage',include=c("MA"),regions = 'counties',labels = T)+
  ggplot2::theme(legend.position = "top",
                 plot.margin = unit(c(0,0,0,0),"cm"))+
  ggplot2::labs(title="Percentage of Population with Covid-19 Cases in Massachusetss March 18,2020")+
  ggplot2::scale_fill_continuous("Percent of Population with Covid-19 Cases")
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
ggplot(dat_current,aes(x=date,y=covid.19,fill=counties))+
  geom_area()+
  scale_fill_manual(values = rep(cbPalette,length(unique(dat_current$counties))))+
  theme(axis.text.x = element_text(angle=45))

ggplot(dat_current,aes(x=date,y=covid.19,fill=counties))+
  facet_grid(.~counties)+
  geom_area()+
  scale_fill_manual(values = rep(cbPalette,length(unique(dat_current$counties))))+
  theme(axis.text.x = element_text(angle=45))
