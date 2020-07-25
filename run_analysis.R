rm(list=ls())
library(dplyr)

#Optional - Set working directory
#baseDir <- "/home/mdonovan/Classes/GettingAndCleaningData/Project"
#setwd(baseDir)

originalDataDir <- "UCI HAR Dataset"
testDataDir <- paste(originalDataDir, "/test", sep = "")
trainDataDir <- paste(originalDataDir, "/train", sep = "")

# 1. Download and extract file if not already present
originalDataFile <- "GACD_Project.zip"
if(! file.exists(originalDataFile)){
   remoteFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
   download.file(remoteFile, originalDataFile ) 
   unzip( originalDataFile)
}



# 2. Set up data frames from data files
features <-read.table( paste(originalDataDir, "/features.txt", sep = "") , col.names = c("n", "FeatureName") )
activity_labels <- read.table( paste(originalDataDir, "/activity_labels.txt", sep = ""), col.names = c("ActivityCode", "ActivityName") )
subject_test <- read.table( paste(originalDataDir, "/test/subject_test.txt", sep = "") , col.names = "SubjectNumber" )
X_test <- read.table( paste(originalDataDir, "/test/X_test.txt", sep = "") , col.names = features$FeatureName)
y_test <- read.table( paste(originalDataDir, "/test/y_test.txt", sep = "") , col.names = "ActivityCode" )
subject_train <- read.table( paste(originalDataDir, "/train/subject_train.txt", sep = "") , col.names = "SubjectNumber")
X_train <- read.table( paste(originalDataDir, "/train/X_train.txt", sep = "")  , col.names = features$FeatureName)
y_train <- read.table( paste(originalDataDir, "/train/y_train.txt", sep = "") , col.names = "ActivityCode" )

# 3. Merge the train and test data sets
X_merged <- rbind(X_train, X_test)
y_merged <- rbind(y_train, y_test)
subject_merged <- rbind(subject_train, subject_test)
data_merged <- cbind(subject_merged, y_merged, X_merged)

# 4. Filter out all columns that are not mean or standard deviation measurements
data_merged <- data_merged %>% select(SubjectNumber, ActivityCode, contains("mean"), contains("std"))
data_merged$ActivityCode <- activity_labels[data_merged$ActivityCode, 2]

# 5. Rename columns for clarity
names(data_merged) <- gsub("gravity" ,"Gravity", names(data_merged))
names(data_merged) <- gsub("mag" ,"Magnitude", names(data_merged))
names(data_merged) <- gsub("Gyro" ,"Gyroscope", names(data_merged))
names(data_merged) <- gsub("-mean()" ,"Mean", names(data_merged))
names(data_merged) <- gsub("-std()" ,"StandardDeviation", names(data_merged))
names(data_merged) <- gsub("-freq()" ,"Frequency", names(data_merged))
names(data_merged) <- gsub("angle" ,"Angle", names(data_merged))
names(data_merged) <- gsub("BodyBody" ,"Body", names(data_merged))
names(data_merged) <- gsub("^t" ,"Time", names(data_merged))
names(data_merged) <- gsub("^f" ,"Frequency", names(data_merged))
names(data_merged) <- gsub("tBody" ,"TimeBody", names(data_merged))

# 6. Summarize average by subject and activity
data_merged <- data_merged %>% group_by(SubjectNumber, ActivityCode) %>% summarise_all( list(mean) )
str(data_merged)
# 7. Write out final summarized table
write.table(data_merged, "DataSummary.txt", row.names = FALSE)







