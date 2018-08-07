#install and load packages
install.packages("dplyr")
library(dplyr)

#Set working directory:

setwd("C:/Users/Philip Mattocks/Documents")


#training data:
train_data <- read.table("UCI HAR Dataset/train/X_train.txt",header=F)
activity_train_data <- read.table("UCI HAR Dataset/train/y_train.txt",header=F,col.names=c("activity"))
subject_train_data <- read.table("UCI HAR Dataset/train/subject_train.txt",header=F,col.names=c("subject"))

#test data:
test_data <- read.table("UCI HAR Dataset/test/X_test.txt",header=F)
activity_test_data <- read.table("UCI HAR Dataset/test/y_test.txt",header=F,col.names=c("activity"))
subject_test_data <- read.table("UCI HAR Dataset/test/subject_test.txt",header=F,col.names=c("subject"))

#read feature data
features <- read.table("UCI HAR Dataset/features.txt",header=F)


features <- sub("^t", "time.",features[,2])
features <- sub("^f", "freq.",features[])
features <- sub("Body", "Body.",features[])
features <- sub("mean", "mean.",features[])
features <- sub("std", "std.",features[])
features <- sub("Gravity", "Gravity.",features[])
features <- sub("-", ".",features[])
features <- sub("()-", ".",features[])
features <- sub("[:(:]", "",features[])
features <- sub("[:):]", "",features[])

##activity labels

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",  header = FALSE)

## add colum names to data using values from Features
colnames(train_data) <- features[]
colnames(test_data) <- features[]
colnames(subject_train_data) <- "Subject"
colnames(activity_train_data) <- "Activity"
colnames(subject_test_data) <- "Subject"
colnames(activity_test_data) <- "Activity"

#add subject and activity to train data
train_data <- cbind(activity_train_data,train_data)
train_data <- cbind(subject_train_data,train_data)

#add subject and activity to test data
test_data <- cbind(activity_test_data,test_data)
test_data <- cbind(subject_test_data,test_data)

#merge test and train
all_data <- rbind(train_data,test_data)

# Combine test and training data into single DF
test_train_all <- rbind(test_data,train_data)



## select columns containing mean, std, Activity, and Subject

mean_sd_act_sub <- test_train_all[ , grepl( "mean" , names( test_train_all ) ) | grepl( "std" , names( test_train_all ) ) |grepl( "Activity" , names( test_train_all ) ) |grepl( "Subject" , names( test_train_all ) )]

mean_sd_act_sub[mean_sd_act_sub$Activity ==1,2] <- as.character(Activity.labels[1,2])
mean_sd_act_sub[mean_sd_act_sub$Activity ==2,2] <- as.character(Activity.labels[2,2])
mean_sd_act_sub[mean_sd_act_sub$Activity ==3,2] <- as.character(Activity.labels[3,2])
mean_sd_act_sub[mean_sd_act_sub$Activity ==4,2] <- as.character(Activity.labels[4,2])
mean_sd_act_sub[mean_sd_act_sub$Activity ==5,2] <- as.character(Activity.labels[5,2])
mean_sd_act_sub[mean_sd_act_sub$Activity ==6,2] <- as.character(Activity.labels[6,2])

## arrange the mean_sd_act_sub data by Subject and by Activity
## Prepare to create a New data set containing all mean values
mean_sd_act_sub <- arrange(mean_sd_act_sub,Subject, Activity)
##group values by Subject and Activity
mean_sd_act_sub <- group_by(mean_sd_act_sub,Subject,Activity)
## create Tidy data using mean values per subject per activity
Tidy.data <- mean_sd_act_sub %>% summarize_all(mean)


## save Tidy data in a file

write.table(Tidy.data, file = "Tidy_data.txt", sep = "")

