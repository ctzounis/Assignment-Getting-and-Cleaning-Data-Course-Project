if(!file.exists("./data")){dir.create("./data")}
fileUrl1 ="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl1,destfile="./data/GDPdata.csv",method="curl")
#if you check the file you will see that only 190 countries are ranked
#because of the arguments stringsAsFactors = F, header = F we 
#need skip =5 
GDPdata = read.csv("./data/GDPdata.csv",skip=5, nrows=190, stringsAsFactors = F, header = F)
GDPdata <- GDPdata[, c(1, 2, 4, 5)]
colnames(GDPdata) <- c("CountryCode", "Rank", "Country.Name", "GDP.Value")
GDP.Value<-as.numeric(gsub(",", "", GDPdata$GDP.Value))
mean(GDP.Value)