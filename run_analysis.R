#Please take note that I refer to the following website:
#https://rstudio-pubs-static.s3.amazonaws.com/37290_8e5a126a3a044b95881ae8df530da583.html


# Download the file
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip")

#unzip the file
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

#Get the list of files that are in the unzipped folder "UCI HAR Dataset"
path_ref <- file.path("./data", "UCI HAR Dataset")
files<- list.files(path_ref, recursive = TRUE)

#Read the Activity files
dataActivityTest <- read.table(file.path(path_ref, "test", "y_test.txt"), header = FALSE)
dataActivityTrain <- read.table(file.path(path_ref, "train", "y_train.txt"), header = FALSE)

#Read subject files
dataSubjectTest <- read.table(file.path(path_ref, "test", "subject_test.txt"), header = FALSE)
dataSubjectTrain <- read.table(file.path(path_ref, "train", "subject_train.txt"), header = FALSE)

#Read features files
dataFeaturesTest <- read.table(file.path(path_ref, "test", "X_test.txt"), header = FALSE)
dataFeatureTrain <- read.table(file.path(path_ref, "train", "X_train.txt"), header = FALSE)

#Join the tables by rows
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeatureTrain, dataFeaturesTest)

#Set names
names(dataSubject) <- c("subject")
names(dataActivity) <- c("activity")
dataFeaturesNames <- read.table(file.path(path_ref, "features.txt"), header = FALSE)
names(dataFeatures)<-dataFeaturesNames$V2

#Combine columns
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

#Subset Name of features by measurements on the mean and std
subdataFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

#Subset the data frame by selected names of Features
selectedNames <- c(as.character(subdataFeaturesNames), "subject", "activity")
Data<- subset(Data, select = selectedNames)

#Read activity names from "activity_labels.txt"
activityLabels<-read.table(file.path(path_ref, "activity_labels.txt"), header = FALSE)

#Label the data with descriptive variable names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

#Create tidy data set and output
library(plyr);
Data2<- aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject, Data2$activity),]
write.table(Data2, file = "tidydata.txt", row.name = FALSE)

