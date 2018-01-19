#First we clear the Workspace:
rm(list=ls())
#Loading useful packages for the analysis:
library(dplyr)
library(plyr) 
library(data.table)
library(dplyr) 
#Downloading the data and unzipping it:
temp <- tempfile()
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!(file.exists("./data"))){ dir.create("./data")}
download.file(fileurl,destfile =temp)
unzip(temp, list = TRUE)#unzipe the file
setwd("./data/UCI HAR Dataset")
unlink(temp)
#Reading the files and storing them into variables:
activitylabels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
traininglabels <- read.table("train/y_train.txt")
trainingset <- read.table("train/X_train.txt")
testlabels <- read.table("test/y_test.txt")
testset <- read.table("test/X_test.txt")
trainsubject <- read.table("train/subject_train.txt")
testsubject <- read.table("test/subject_test.txt")
#Naming the columns in trainingset,testset data using features second column which contains the names:
colnames(trainingset) <- t(as.character(features[,2]))
colnames(testset) <- t(as.character(features[,2]))
#Adding activities variable to both trainingset and testset:
trainingset$activities <- as.character(t(traininglabels))
testset$activities <- as.character(t(testlabels))
#Adding participants variable to both trainingset and testset:
trainingset$participants <- trainsubject[,1]
testset$participants <- testsubject[,1]
#Merging the data sets:
data <- rbind(trainingset, testset)
#Getting the Index for Mean and Standard Deviation features and the activities and participants:
MeanIndex <- grep(".*[Mm]ean.*",colnames(data),value = F)
StdIndex <- grep(".*std.*",colnames(data),value = F)
#Extracting only the measurements on the mean and standard deviation:
MeanFeatures <- data[MeanIndex]
StdFeatures <- data[StdIndex]
data <- cbind("participants" = data$participants,"activities"= data$activities,MeanFeatures, StdFeatures)
#Useing descriptive activity names to name the activities in the data set:
data$activities <- factor(data$activities,labels = activitylabels[,2],levels = activitylabels[,1])
#Naming the variables properly with descriptive and simpler names:
names(data) <- gsub("-mean","Mean",names(data))
names(data) <- gsub("-std","Std",names(data))
names(data) <- gsub("[-()]","",names(data))
names(data) <- gsub("^t", "time", names(data))
names(data) <- gsub("^f", "frequency", names(data))
names(data) <- gsub("Acc", "Accelerator", names(data))
names(data) <- gsub("Mag", "Magnitude", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
#Creating a secod dataset:
Tidydata <- data.frame(data)
#Calculating the average of each variable for each activity and subject:
Tidydata <- aggregate(.~ activities+ participants,Tidydata,mean)
#Print the tidy data(creating a file of it):
write.table(Tidydata, file = "TidyDataSet.txt", row.names = FALSE, quote = FALSE)


