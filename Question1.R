if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile="./data/housing.csv",method="curl")
hous <- read.csv("./data/housing.csv")
strsplit(names(hous),"wgtp")