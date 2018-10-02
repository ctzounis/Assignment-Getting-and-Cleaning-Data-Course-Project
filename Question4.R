if(!file.exists("./data")){dir.create("./data")}
fileUrl1 ="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl1,destfile="./data/GDPdata.csv",method="curl")
download.file(fileUrl2,destfile="./data/edudata.csv",method="curl")
#if you check the file you will see that only 190 countries are ranked
#because of the arguments stringsAsFactors = F, header = F we 
#need skip =5 
GDPdata = read.csv("./data/GDPdata.csv",skip=5, nrows=190, stringsAsFactors = F, header = F) 
edudata <- read.csv("./data/edudata.csv", stringsAsFactors = F)
## Subset only needed data, name columns in gdpData and convert GDP Value to numeric
GDPdata <- GDPdata[, c(1, 2, 4, 5)]
colnames(GDPdata) <- c("CountryCode", "Rank", "Country.Name", "GDP.Value")
#remove the "," from the values of the column GDP.Value
GDPdata$GDP.Value <- as.numeric(gsub(",", "", GDPdata$GDP.Value))
## Merge data by country codes
matchedData <- merge(GDPdata, edudata, by.x = "CountryCode", by.y = "CountryCode")
isFiscalYearEnd <- grepl("fiscal year end", tolower(dt$Special.Notes))
isJune <- grepl("june", tolower(dt$Special.Notes))
table(isFiscalYearEnd, isJune)
