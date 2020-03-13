require(usmap)
require(ggplot2)
require(pdftools)
require(rvest)
mass_gov <- pdf_text('https://www.mass.gov/doc/covid-19-cases-in-massachusetts-march-12-2020/download',)
counties <- strsplit(mass_gov,split = '\r\n')[[1]][14:19]
dat <- data.frame('counties'=sapply(strsplit(counties,'\\s+'),'[[',1),'covid.19'=sapply(strsplit(counties,'\\s+'),'[[',2))
require(xlsx)
fips <- read.xlsx("C://Users/448662/Downloads/fips_codes_website.xls",sheetIndex = 1,header = F,colIndex = c(1,4,6),startRow = 13233,endRow = 14906)
fips[which(fips$X1%in%"MA" & fips$X6%in%dat$counties),]
dat$fips <- c(25003,25009,25017,25021,25025,25027)
dat$covid.19 <- as.numeric(as.character(dat$covid.19))
plot_usmap(data = dat,values= 'covid.19',include=c("MA"),regions = 'counties')+
  ggplot2::theme(legend.position = "top",
                 plot.margin = unit(c(0,0,0,0),"cm"))


