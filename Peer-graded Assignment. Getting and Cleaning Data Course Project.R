#The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
#Review criterialess 
#The submitted data set is tidy.
#The Github repo contains the required scripts.
#GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
#The README that explains the analysis files is clear and understandable.
#The work submitted for this project is the work of the student who submitted it.
#Getting and Cleaning Data Course Projectless 
#The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

#One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
  
#  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Here are the data for the project:
  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#You should create one R script called run_analysis.R that does the following.

#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#######################################SOLUTION###################################

#1. Merge the training and the test sets to create one data set

#Always, open first a data .txt file in a notepad 
#application to have an idea how the data was stored 
#and what function to use to read the data
#You will see the data for this project was stored as a 
#table of numbers separated with single spaces. 


# Read tabular data into R
subject_test<-read.table("./data/subject_test.txt", header = FALSE, sep = "", dec = ".")
subject_train<-read.table("./data/subject_train.txt", header = FALSE, sep = "", dec = ".")
X_test<-read.table("./data/X_test.txt", header = FALSE, sep = "", dec = ".")
X_train<-read.table("./data/X_train.txt", header = FALSE, sep = "", dec = ".")
y_test<-read.table("./data/y_test.txt", header = FALSE, sep = "", dec = ".")
y_train<-read.table("./data/y_train.txt", header = FALSE, sep = "", dec = ".")

#write.csv(df, 'test2.csv')
#makeCodebook(iris, replace=TRUE)

#We will need for the step 4 for the project to give names to the variables 
#of our data. The names can be taken from the following file.
#So, read the features.txt file because it has what
# the column names V1...Vn corresponds to.
feat<-read.table("./data/features.txt", header = FALSE, sep = "", dec = ".")

#Moreover, in the step 3 we will need to subset the orginal data. We will keep
#only those that have to do with the mean and standard deviations of the 
#measurements of the experiment
mean.var<-grep("mean()",feat$V2)
std.var<-grep("std()",feat$V2)


#Two important comments: 
#a) Change the columns names for the subject_train, subject_test, y_train, y_test
#we need to do this because all the set X y and sebject have column named V1.
#b) subject_train, subject_test should have the same name in order to be able to 
#bind them together. Same stands for the y_train, y_test.
colnames(y_test) <- c("Activity")
colnames(subject_test) <- c("Subject")
colnames(y_train) <- c("Activity")
colnames(subject_train) <- c("Subject")

#4.Appropriately label the data set with descriptive variable names
#we can name the data based on what we have in the file features.txt
#inorder to do that we need to clean up a bit the names in the file.
col.names1<-feat[mean.var,2]
col.names1<-gsub("-","",col.names1)
col.names1<-gsub(pattern="mean()",replacement =".Mean." ,col.names1)
#here we need the [] around the parenteses because otherwise we will not be able
#to remove the () symbol.
col.names1<-gsub("[()]","",col.names1)

col.names2<-feat[std.var,2]
col.names2<-gsub("-","",col.names2)
col.names2<-gsub(pattern="std()",replacement =".std." ,col.names2)
col.names2<-gsub("[()]","",col.names2)

#Now that we cleaned the names we can change the names of the original datasets.
colnames(X_test)[mean.var] <- col.names1
colnames(X_test)[std.var] <- col.names2
colnames(X_train)[mean.var] <- col.names1
colnames(X_train)[std.var] <- col.names2




#first use cbind to add all the columns of the test and the train sets
total_test<-cbind(subject_test, y_test, X_test)
total_train<-cbind(subject_train, y_train, X_train)



#use rbind to add all the rows of the test and the train sets to one dataset
total<-rbind(total_test, total_train)


#2. Extract only the measurements 
#on the mean and standard deviation for each measurement

#This instruction can be a little confusing. Do you remember the tidy 
#data principle? Observations (measurements) are rows and Variables 
#measured are columns. You should have noticed that the columns in your 
#new data set are named V1,...Vn. So what do you exactly have to extract ?

#“for each measurement” here means for each row, and “the measurements on 
#the mean and standard deviation” is telling you which columns to look for

#Tip: look at the file named features.txt. Here is a list with the 
#variable names (columns) used originally in X_train and X_test tables. 
#Remember you have added two columns (subject ids and activity names) to 
#your new data set!

#What we want here is to subset the dataset that we created in the previous 
#step which has only the columns that have only the mean and standard deviations 
#values of the experiment.

#subset the data
#here we need to add the number to because the first two columns of the new dataset
#are the y variable and the subject variable.
new.mean<-mean.var+2
new.std<-std.var+2

new.data<-total[, c(1, 2, new.mean,new.std)]

#3. Uses descriptive activity names to name the activities in the data set
#Now you have to change activity IDs in the second column with activity 
#names. Look at the file named activity_labels.txt. Here is a look‐up 
#table which links IDs with unique activity names.
#There are several ways to do this. You can use for loops, the sapply 
#function, etc. Or we can do the following.
#First we load the labels table on R
act.label<-read.table("./data/activity_labels.txt", header = FALSE, sep = "", dec = ".")
#Then create a vector from the second column of the table which is 
#the labels of the activities
labels.vec <- act.label[,2]
#Repace the column with just numbers in our "total" dataset with a new column
#labels for the activities.
new.data$Activity <- labels.vec[new.data$Activity]

#5. From the data set in step 4, create a second, independent tidy data set 
#with the average of each variable for each activity and each subject

#First we need to order the data

new.data <- new.data[order(new.data$Subject, new.data$Activity),]

#For this step we need the dplyr library
library(dplyr)
#at the beggining the output is empty
output<-NULL
#Start the loop that for every iteration: a) filters the data and keeps the ones that
#have Subject==i. b) groups the subset by activities and c) applies the mean
#for all the columns.
for (i in 1:30){
outcome<-new.data %>% filter(Subject==i) %>% group_by(Activity) %>% summarise_all(funs(mean))
output<-rbind(output, outcome)
}
print(output)