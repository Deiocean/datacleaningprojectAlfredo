### Peer graded exercise for Course 3 Week 2

library(plyr)
library(knitr)

## Download and unzip the dataset
urlDataset <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(urlDataset, destfile="Dataset.zip", mode="wb")
unzip("Dataset.zip")

## Import the tables for each part
pathFile <- file.path("C://Users//alfre//OneDrive//Documenti" , "UCI HAR Dataset")

#Import Activity datasets
dataActivityTest  <- read.table(file.path(pathFile, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(pathFile, "train", "Y_train.txt"),header = FALSE)

#Import Subject datasets
dataSubjectTrain <- read.table(file.path(pathFile, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(pathFile, "test" , "subject_test.txt"),header = FALSE)

#Import Feature datasets
dataFeaturesTest  <- read.table(file.path(pathFile, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(pathFile, "train", "X_train.txt"),header = FALSE)

## Point 1: Merging training and test datasets into one dataset named dataFull
dataSub <- rbind(dataSubjectTrain, dataSubjectTest)
dataAct<- rbind(dataActivityTrain, dataActivityTest)
dataFeat<- rbind(dataFeaturesTrain, dataFeaturesTest)

#Variable names
names(dataSub)<-c("subject")
names(dataAct)<- c("activity")
dataFeatName <- read.table(file.path(pathFile, "features.txt"),head=FALSE)
names(dataFeat)<- dataFeatName$V2

dataMerged <- cbind(dataSub, dataAct)
dataFull <- cbind(dataFeat, dataMerged)

## Point 2: Extracts only the measurements on the mean and standard deviation for each measurement
subDataFeatureName <- dataFeatName$V2[grep("mean\\(\\)|std\\(\\)", dataFeatName$V2)]

selectedNames<-c(as.character(subDataFeatureName), "subject", "activity" )
dataFull<-subset(dataFull,select=selectedNames)

## Point 3: Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table(file.path(pathFile, "activity_labels.txt"),header = FALSE)
dataFull$activity <- factor(dataFull$activity, labels = activityLabels$V2)

## Point 4: Appropriately labels the data set with descriptive variable names
#using gsub() for total substitution
names(dataFull)<-gsub("^t", "time", names(dataFull))
names(dataFull)<-gsub("^f", "frequency", names(dataFull))
names(dataFull)<-gsub("Acc", "Accelerometer", names(dataFull))
names(dataFull)<-gsub("Gyro", "Gyroscope", names(dataFull))
names(dataFull)<-gsub("Mag", "Magnitude", names(dataFull))
names(dataFull)<-gsub("BodyBody", "Body", names(dataFull))

##Point 5: Creates a second,independent tidy data set and ouput it
dataFullAgg<-aggregate(. ~subject + activity, dataFull, mean)
dataFullAgg<-dataFullAgg[order(dataFullAgg$subject,dataFullAgg$activity),]
write.table(dataFullAgg, file = "tidyData.txt",row.name=FALSE)

