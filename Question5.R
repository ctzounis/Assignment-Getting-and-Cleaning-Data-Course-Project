library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
#create a table with the year and the weekdays of the sampleTimes
#addmargins() is not necessary
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))