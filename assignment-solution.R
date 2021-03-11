#Loading libraries
library(readxl)

#Set Working Directory
setwd("C:/Users/1514133/Downloads") #Just change the WD to a folder containing the requested datasets and run it! 

#Import Datasets
gdp <- read_excel("API_NY.GDP.PCAP.CD_DS2_en_excel_v2_2055610.xls",sheet="Data",range="A4:BM268") #gdp data
tax <- read_excel("API_GC.TAX.TOTL.GD.ZS_DS2_en_excel_v2_2056263.xls",sheet="Data",range="A4:BM268") #tax data
region <- read_excel("API_GC.TAX.TOTL.GD.ZS_DS2_en_excel_v2_2056263.xls",sheet="Metadata - Countries",range="A1:B264") #region data

#Keep requested year
gdp2015 <- gdp[,c("Country Code","2015")] #create dataframe with gdp for year 2015
tax2015 <- tax[,c("Country Code","2015")] #create dataframe with tax for year 2015

##
names(gdp2015)[names(gdp2015) == "2015"] <- "gdp" #change name of columns
names(tax2015)[names(tax2015) == "2015"] <- "tax" #change name of columns

#Merge data
data <- merge(gdp2015,tax2015,by="Country Code") #merge gdp2015 and tax2015 by "Country Code"
data <- merge(data,region,by="Country Code")  #merge region by "Country Code"

#Create subsample with requested Region
sample <- subset(data,Region=="Latin America & Caribbean")

#Plot data
plot(sample$gdp, sample$tax, type = "p", 
     xlab="GDP per capita (current US$)",
     ylab="Tax Revenue (% of GDP)") #plot "tax" over "gdp" adding x-axis and y-axis labels  

title("1512345: Latin America & Caribbean in 2015") #add a title to plot
