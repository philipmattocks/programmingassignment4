library(dplyr)
library(datasets)

#Import data from the files and combine so there's a single test and
# single training DF

#test data:
x_test <- read.table("UCI HAR Dataset/test/X_test.txt",header=F)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",header=F,col.names=c("activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",header=F,col.names=c("subject"))
# combine the three DFs
test_all <- cbind(y_test,subject_test,x_test)

#training data:
x_train <- read.table("UCI HAR Dataset/train/X_train.txt",header=F)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",header=F,col.names=c("activity"))
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",header=F,col.names=c("subject"))
# combine the three DFs
train_all <- cbind(y_train,subject_train,x_train)

# Combine test and training data into single DF
test_train_all <- rbind(test_all,train_all)

#Get mean and SD for all measurements, drop the actual measurements so we just
# have activity, subject, mean and standarddev 
mean <- rowMeans(test_train_all[, -(1:2)])
standarddev <- apply(test_train_all[, -(1:2)],1, sd, na.rm = TRUE)
test_train_all_mean_sd <- cbind(test_train_all[1:2],mean,standarddev)

#Use descriptive activity names instead of activity numbers:
activities <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
test_train_all_mean_sd$activity <- lapply(test_train_all_mean_sd$activity,function(x){
  if (x==1){x <- "WALKING"}
  else if (x==2){x <- "WALKING_UPSTAIRS"}
  else if (x==3){x <- "WALKING_DOWNSTAIRS"}
  else if(x==4){x <- "SITTING"}
  else if (x==5){x <- "STANDING"}
  else if (x==6){x <- "LAYING"}
  })

#Calculate mean and SD for each combination of subject and  activity
avg_sd_by_activity_subject <- aggregate(test_train_all_mean_sd[,(3:4)],list(as.character(test_train_all_mean_sd$activity),test_train_all_mean_sd$subject),mean)
colnames(avg_sd_by_activity_subject)[1:2] <-c("activity","subject")

