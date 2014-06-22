########################################################################################
##
## Date 2014-06-04
## Written by Carl Smith for Getting and Cleaning Data class
## 
## Software used to test and run script:
## MacOS X 10.9.3
## R version 3.1.0 (2014-04-10) -- "Spring Dance"
## RStudio Version 0.98.507
##
########################################################################################

run_analysis <- function() {

        # Check to see if a data directory exists in the current working directory and make one if needed.
        if(!file.exists("./data")) {
                dir.create("./data")
        }

        # Check to see if the Samsung dataset directory is in the data directory of the working directory.
        if(!file.exists("./data/UCI HAR Dataset")) {

		# Check to see if the Samsung zip file is in the data directory of the working directory.
		# If not, download it.
                
                if(!file.exists("./data/FUCIHARDataset.zip")) {
                	fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                	download.file(fileURL,destfile="./data/FUCIHARDataset.zip",method="curl",mode="wb")
                	dataDownloaded <- date()
                	print(paste("Downloaded Samsung zip file on", dataDownloaded))
                }

		# Unzip the Sumsung data so it can be read.
		unzip("./data/FUCIHARDataset.zip", unzip="/usr/bin/unzip",exdir = "./data/")
	}


        
        
        
        # Read the features
        features <- read.delim("./data/UCI HAR Dataset/features.txt", header = FALSE,
                               stringsAsFactors=FALSE, sep="", col.names=c("rownumber","featurenames"))
        
        # Clean up the feature names based on lecture 04_01_editingTextVariables summarized 
        # on slide 16/16. I personally think the names would be easier to read with a few
        # underscores or in Camel-case or something but I've tried to follow the lecture's
        # recommendations for variable naming conventions as closely as I can.
        ##
        ## From Week 4, lecture 1, slide 16 of 16:
        ## Names of variables should be
        ##   - All lower case when possible
        ##   - Descriptive (Diagnosis versus Dx)
        ##   - Not duplicated
        ##   - Not have underscores or dots or white spaces
        ##
        # Remove dash, open paren, close paren, comma, and period. 
        # Also make the name text all lower case.
        features$featurenames <- tolower(features$featurenames)
        features$featurenames <- gsub("-|\\(|\\)|\\.|\\,","",features$featurenames)
        
        # Read in the test subset
        testactivity <- read.delim("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE,
                                   stringsAsFactors=FALSE, col.names=c("activity"))
        
        # Read in the training subset
        trainingactivity <- read.delim("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE,
                                       stringsAsFactors=FALSE, col.names=c("activity"))
        
        # Read a copy of the activity lables
        activitylabels <- read.delim("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE, 
                                     stringsAsFactors=FALSE, sep="", 
                                     col.names=c("activityid","activitylabel"), 
                                     colClasses = c("character", "character"))
        
        # Clean up the activity labels similar to what was done to feature names above
        activitylabels$activitylabel <- tolower(activitylabels$activitylabel)
        activitylabels$activitylabel <- gsub("_","",activitylabels$activitylabel)
        
        # Replace the activity ids with activity labels
        # I know this is ugly doing it manually. I tried a for loop but had scoping issues. 
        # Should be able to do in a beautiful way with one of the apply functions if I have time.
        testactivity$activity <- sub(1, activitylabels$activitylabel[1], testactivity$activity)
        testactivity$activity <- sub(2, activitylabels$activitylabel[2], testactivity$activity)
        testactivity$activity <- sub(3, activitylabels$activitylabel[3], testactivity$activity)
        testactivity$activity <- sub(4, activitylabels$activitylabel[4], testactivity$activity)
        testactivity$activity <- sub(5, activitylabels$activitylabel[5], testactivity$activity)
        testactivity$activity <- sub(6, activitylabels$activitylabel[6], testactivity$activity)
        trainingactivity$activity <- sub(1, activitylabels$activitylabel[1], trainingactivity$activity)
        trainingactivity$activity <- sub(2, activitylabels$activitylabel[2], trainingactivity$activity)
        trainingactivity$activity <- sub(3, activitylabels$activitylabel[3], trainingactivity$activity)
        trainingactivity$activity <- sub(4, activitylabels$activitylabel[4], trainingactivity$activity)
        trainingactivity$activity <- sub(5, activitylabels$activitylabel[5], trainingactivity$activity)
        trainingactivity$activity <- sub(6, activitylabels$activitylabel[6], trainingactivity$activity)
        
        rm(activitylabels)
        
        testsubject <- read.delim("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, 
                                  stringsAsFactors=FALSE, col.names=c("subject"))
        
        testX <- read.delim("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE,
                            stringsAsFactors=FALSE, sep="", col.names=c(features$featurenames))
        
        trainingsubject <- read.delim("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE,
                                      stringsAsFactors=FALSE, col.names=c("subject"))
        
        trainingX <- read.delim("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE,
                                stringsAsFactors=FALSE, sep="", col.names=c(features$featurenames))
        
        rm(features)
        
        # Combine the subject, activity and result columns
        testgroup <- cbind(testsubject, testactivity, testX)
        traininggroup <- cbind(trainingsubject, trainingactivity, trainingX)
        
        rm(testactivity, trainingactivity, testsubject, testX, trainingsubject, trainingX)
        
        # Combine the test group and the training group
        totalgroup <- rbind(testgroup,traininggroup)
        
        rm(testgroup,traininggroup)
        
        # Remove any column that is not a measurement's mean, measurement's std, 
        # the subject identifier column or the activity identifier column
        totalgroupmeanstd <- totalgroup[,grepl("std|mean|subject|activity",names(totalgroup))]
        
        # Write the first tidy dataset. This is a TAB delimited text file.
        write.table(totalgroupmeanstd, file="./data/tidy_dataset.txt", sep="\t", row.names=FALSE)
        
        # Generate a dataset of means by subject and activity - this is the tidy dataset
        meantable <- aggregate(. ~ subject + activity, data=totalgroupmeanstd, FUN=mean)
        
        # Write the tidy dataset with means by subject and activity.
        # This is a TAB delimited text file.
        # This is the tidy dataset I upload to Coursera for grading.
        write.table(meantable, file="./data/tidy_mean_data.txt", sep="\t", row.names=FALSE)
        
        
}
