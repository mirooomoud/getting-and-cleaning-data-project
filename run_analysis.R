library(dplyr)
library(reshape2)
setwd("C:/Users/Mahmoud/Desktop/UCI HAR Dataset")

# Step 1
# Merge the training and test sets to create one data set

subjecttrain<-read.table("C:/Users/Mahmoud/Desktop/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
ytrain<-read.table("C:/Users/Mahmoud/Desktop/UCI HAR Dataset/train/y_train.txt", header = FALSE)
trainX<-read.table("C:/Users/Mahmoud/Desktop/UCI HAR Dataset/train/X_train.txt", header = FALSE)
train<-cbind(subjecttrain, ytrain, trainX)

subjecttest<-read.table("C:/Users/Mahmoud/Desktop/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
ytest<-read.table("C:/Users/Mahmoud/Desktop/UCI HAR Dataset/test/y_test.txt", header = FALSE)
testx<-read.table("C:/Users/Mahmoud/Desktop/UCI HAR Dataset/test/X_test.txt", header = FALSE)
test<-cbind(subjecttest, ytest, testx)

mydata<-rbind(train, test)

# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement

features<-read.table("C:/Users/Mahmoud/Desktop/UCI HAR Dataset/features.txt", header = FALSE)
features2<-as.character(features[ , 2])
colnames(mydata)<-c("subject", "activity", features2)
extract <- grep(".*mean.*|.*std.*", features[,2])
extract2<-subset(mydata, select = extract)


# Step 3
# Use descriptive activity names to name the activities in the data set

activity1<-read.table("C:/Users/Mahmoud/Desktop/UCI HAR Dataset/activity_labels.txt", header = FALSE)
activities<-as.data.frame(activity1)
colnames(activities)<-c("activity", "activitylabel")
extract2[, 2] = activities[extract2[, 2], 2]

# Step 4
# Appropriately label the data set with descriptive variable names

names(extract2)<-gsub("^t", "time", names(extract2))
names(extract2)<-gsub("^f", "frequency", names(extract2))
names(extract2)<-gsub("Acc", "Accelerometer", names(extract2))
names(extract2)<-gsub("Gyro", "Gyroscope", names(extract2))
names(extract2)<-gsub("Mag", "Magnitude", names(extract2))
names(extract2)<-gsub("BodyBody", "Body", names(extract2))

# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject

mydata.melt<-melt(extract2, id = c("subject", "activity"))
mydata.mean <- dcast(mydata.melt, subject + activity ~ variable, mean)
write.table(mydata.mean, file = "tidydata.txt",row.name=FALSE)
