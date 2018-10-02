# Read tabular data into R
subject_test<-read.table("./data/subject_test.txt", header = FALSE, sep = "", dec = ".")
subject_train<-read.table("./data/subject_train.txt", header = FALSE, sep = "", dec = ".")
X_test<-read.table("./data/X_test.txt", header = FALSE, sep = "", dec = ".")
X_train<-read.table("./data/X_train.txt", header = FALSE, sep = "", dec = ".")
y_test<-read.table("./data/y_test.txt", header = FALSE, sep = "", dec = ".")
y_train<-read.table("./data/y_train.txt", header = FALSE, sep = "", dec = ".")
#In order to do that we need to read the features.txt file because it has what
# the column names V1...Vn corresponds to.
feat<-read.table("./data/features.txt", header = FALSE, sep = "", dec = ".")

#we need the mean and standard deviations
mean.var<-grep("mean()",feat$V2)
std.var<-grep("std()",feat$V2)

#subset the data
new.mean<-mean.var+2
new.std<-std.var+2

#4.Appropriately label the data set with descriptive variable names
test1<-feat[mean.var,2]
test1<-gsub("-","",test1)
test1<-gsub(pattern="mean()",replacement =".Mean." ,test1)
test1<-gsub("[()]","",test1)

test2<-feat[std.var,2]
test2<-gsub("-","",test2)
test2<-gsub(pattern="std()",replacement =".std." ,test2)
test2<-gsub("[()]","",test2)

#Two important comments: 
#a) Change the columns names for the subject_train, subject_test, y_train, y_test
#we need to do this because all the set X y and sebject have column named V1.
#b) subject_train, subject_test should have the same name in order to be able to 
#bind them together. Same stands for the y_train, y_test.
colnames(y_test) <- c("V1.y")
colnames(subject_test) <- c("V1.sub")
colnames(y_train) <- c("V1.y")
colnames(subject_train) <- c("V1.sub")

colnames(X_test)[mean.var] <- test1
colnames(X_test)[std.var] <- test2
colnames(X_train)[mean.var] <- test1
colnames(X_train)[std.var] <- test2




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
new.data$V1.y <- labels.vec[new.data$V1.y]

#4.Appropriately label the data set with descriptive variable names
test1<-feat[mean.var,2]
test1<-gsub("-","",test1)
test1<-gsub(pattern="mean()",replacement =".Mean." ,test1)
test1<-gsub("[()]","",test1)


#test1<-gsub("-","",test1)
#test1<-gsub("()","",test1)