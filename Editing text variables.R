# make this an external chunk that can be included in any file
#options(width = 100)
#opts_chunk$set(message = F, error = F, warning = F, comment = NA, fig.align = 'center', dpi = 100, tidy = F, cache.path = '.cache/', fig.path = 'fig/', cache=TRUE)

#options(xtable.type = 'html')
#knit_hooks$set(inline = function(x) {
 # if(is.numeric(x)) {
  #  round(x, getOption('digits'))
  #} else {
   # paste(as.character(x), collapse = ', ')
  #}
#})
#knit_hooks$set(plot = knitr:::hook_plot_html)

#Fixing character vectors - tolower(), toupper()
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.csv",method="curl")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)
#All capital letters will become lower case
tolower(names(cameraData))

#Fixing character vectors - strsplit()
#Good for automatically splitting variable names
#Important parameters: x, split
#strsplit() this command allows us to spit the data because of some punctuation. For example the "." :
splitNames = strsplit(names(cameraData),"\\.")
splitNames[[5]]
splitNames[[6]]

#Quick aside - lists
#create a list
mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)
mylist[1]
mylist$letters
mylist[[1]]

#Fixing character vectors - sapply()

#Applies a function to each element in a vector or list
#Important parameters: X,FUN
splitNames[[6]][1]
#The following function return the first element of a list that we give it
firstElement <- function(x){x[1]}
#Now we pass the function into sapply in order to apply the function 
#on the list of names (splitNames) of my data
sapply(splitNames,firstElement)

#Peer review experiment data
#Peer review data

fileUrl1 ="https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/reviews.csv"
fileUrl2 = "https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/solutions.csv"
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)

#Fixing character vectors - sub()

#Important parameters: pattern, replacement, x
names(reviews)
#remove the "_"
sub("_","",names(reviews),)

#Fixing character vectors - gsub()
#works for the case that you have multiple "_"
testName <- "this_is_a_test"
sub("_","",testName)
gsub("_","",testName)

#Finding values - grep(),grepl()
#if you want to search throught your data for a particular word in a column
grep("Alameda",cameraData$intersection)
#grepl() return TRUE whenever the word appears in the column that you are checking.
table(grepl("Alameda",cameraData$intersection))
#subset the data that do not contain the word that you want.
cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]

#More on grep()
#value=TRUE: returns the values where the word appears
grep("Alameda",cameraData$intersection,value=TRUE)
grep("JeffStreet",cameraData$intersection)
length(grep("JeffStreet",cameraData$intersection))

#More useful string functions

library(stringr)
#number of characters in a word
nchar("Jeffrey Leek")
#If you want to look at particular places in a string. For example 
#here we want to see from the 1st to the 7th letter of the string.
substr("Jeffrey Leek",1,7)
paste("Jeffrey","Leek")

#More useful string functions
#paste0: you paste things together without space
paste0("Jeffrey","Leek")
#str_trim: it is cutting extra space.
str_trim("Jeff      ")


