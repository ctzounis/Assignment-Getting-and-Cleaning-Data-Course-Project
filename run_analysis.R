
# Read tabular data into R
subject_test<-read.table("./data/subject_test.txt", header = FALSE, sep = "", dec = ".")
subject_train<-read.table("./data/subject_train.txt", header = FALSE, sep = "", dec = ".")
X_test<-read.table("./data/X_test.txt", header = FALSE, sep = "", dec = ".")
X_train<-read.table("./data/X_train.txt", header = FALSE, sep = "", dec = ".")
y_test<-read.table("./data/y_test.txt", header = FALSE, sep = "", dec = ".")
y_train<-read.table("./data/y_train.txt", header = FALSE, sep = "", dec = ".")
feat<-read.table("./data/features.txt", header = FALSE, sep = "", dec = ".")


mean.var<-grep("mean()",feat$V2)
std.var<-grep("std()",feat$V2)



colnames(y_test) <- c("Activity")
colnames(subject_test) <- c("Subject")
colnames(y_train) <- c("Activity")
colnames(subject_train) <- c("Subject")

#4.Appropriately label the data set with descriptive variable names

col.names1<-feat[mean.var,2]
col.names1<-gsub("-","",col.names1)
col.names1<-gsub(pattern="mean()",replacement =".Mean." ,col.names1)
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



#1.Merge the data

total_test<-cbind(subject_test, y_test, X_test)
total_train<-cbind(subject_train, y_train, X_train)
total<-rbind(total_test, total_train)


#2. Extract only the measurements 

new.mean<-mean.var+2
new.std<-std.var+2

new.data<-total[, c(1, 2, new.mean,new.std)]

#3. Uses descriptive activity names to name the activities in the data set

act.label<-read.table("./data/activity_labels.txt", header = FALSE, sep = "", dec = ".")

labels.vec <- act.label[,2]

new.data$Activity <- labels.vec[new.data$Activity]

#5. From the data set in step 4, create a second, independent tidy data set 

new.data <- new.data[order(new.data$Subject, new.data$Activity),]


library(dplyr)

output<-NULL

for (i in 1:30){
outcome<-new.data %>% filter(Subject==i) %>% group_by(Activity) %>% summarise_all(funs(mean))
output<-rbind(output, outcome)
}
print(output)