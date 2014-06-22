#Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. 

You will be required to submit: 

1. a tidy data set as described below
2. a link to a Github repository with your script for performing the analysis
3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
4. a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here are the data for the project: 

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

 You should create one R script called run_analysis.R that does the following.
  
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Good luck!

======================================================================

##RAW Data Attribute Details

**From UCI HAR Dataset/README.txt**

######RAW Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (**WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING**) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 


 
######Attribute Information:

For each record in the dataset it is provided:  

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

<br />

- 'train/Inertial Signals/total_acc_x_train.txt': **The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'.** Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': **The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.** 

<br />
<br />

**From UCI HAR Dataset/features_info.txt**

######Feature Selection

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'





======================================================================

##Tidy Dataset


###Feature Names

Used guidelines from Week 4, lecture 1, _editingTextVariables_ which is summarized on slide 16/16:

- Names of variables should be:
	- All lower case when possible
	- Descriptive (Diagnosis versus Dx)
	- Not duplicated
	- Not have underscores or dots or white spaces
- Removed any parentheses because it can be difficult to work with in R



###Features

- Removed all features (columns) from RAW dataset that did not have "mean" or "std" in the feature name. I included angle columns because they have the word mean in their name.
- Final tidy dataset includes 88 features listed below.


RAW Feature Name | Tidy Feature Name	| Feature Value
----------------|---------------------|------------------
unnamed in subject_test.txt / subject_train.txt files | "subject"		| ids of subjects - numeric values from 1 to 30
unnamed in activity_labels.txt file | "activity"		| six possible character values: laying, sitting, standing, walking, walkingdown, walkingup
"tBodyAcc-mean()-X" | "tbodyaccmeanx" | see RAW Data Attribute Details above
"tBodyAcc-mean()-Y" | "tbodyaccmeany" | see RAW Data Attribute Details above
"tBodyAcc-mean()-Z" | "tbodyaccmeanz" | see RAW Data Attribute Details above
"tBodyAcc-std()-X" | "tbodyaccstdx" | see RAW Data Attribute Details above
"tBodyAcc-std()-Y" | "tbodyaccstdy" | see RAW Data Attribute Details above
"tBodyAcc-std()-Z" | "tbodyaccstdz" | see RAW Data Attribute Details above
"tGravityAcc-mean()-X" | "tgravityaccmeanx" | see RAW Data Attribute Details above
"tGravityAcc-mean()-Y" | "tgravityaccmeany" | see RAW Data Attribute Details above
"tGravityAcc-mean()-Z" | "tgravityaccmeanz" | see RAW Data Attribute Details above
"tGravityAcc-std()-X" | "tgravityaccstdx" | see RAW Data Attribute Details above
"tGravityAcc-std()-Y" | "tgravityaccstdy" | see RAW Data Attribute Details above
"tGravityAcc-std()-Z" | "tgravityaccstdz" | see RAW Data Attribute Details above
"tBodyAccJerk-mean()-X" | "tbodyaccjerkmeanx" | see RAW Data Attribute Details above
"tBodyAccJerk-mean()-Y" | "tbodyaccjerkmeany" | see RAW Data Attribute Details above
"tBodyAccJerk-mean()-Z" | "tbodyaccjerkmeanz" | see RAW Data Attribute Details above
"tBodyAccJerk-std()-X" | "tbodyaccjerkstdx" | see RAW Data Attribute Details above
"tBodyAccJerk-std()-Y" | "tbodyaccjerkstdy" | see RAW Data Attribute Details above
"tBodyAccJerk-std()-Z" | "tbodyaccjerkstdz" | see RAW Data Attribute Details above
"tBodyGyro-mean()-X" | "tbodygyromeanx" | see RAW Data Attribute Details above
"tBodyGyro-mean()-Y" | "tbodygyromeany" | see RAW Data Attribute Details above
"tBodyGyro-mean()-Z" | "tbodygyromeanz" | see RAW Data Attribute Details above
"tBodyGyro-std()-X" | "tbodygyrostdx" | see RAW Data Attribute Details above
"tBodyGyro-std()-Y" | "tbodygyrostdy" | see RAW Data Attribute Details above
"tBodyGyro-std()-Z" | "tbodygyrostdz" | see RAW Data Attribute Details above
"tBodyGyroJerk-mean()-X" | "tbodygyrojerkmeanx" | see RAW Data Attribute Details above
"tBodyGyroJerk-mean()-Y" | "tbodygyrojerkmeany" | see RAW Data Attribute Details above
"tBodyGyroJerk-mean()-Z" | "tbodygyrojerkmeanz" | see RAW Data Attribute Details above
"tBodyGyroJerk-std()-X" | "tbodygyrojerkstdx" | see RAW Data Attribute Details above
"tBodyGyroJerk-std()-Y" | "tbodygyrojerkstdy" | see RAW Data Attribute Details above
"tBodyGyroJerk-std()-Z" | "tbodygyrojerkstdz" | see RAW Data Attribute Details above
"tBodyAccMag-mean()" | "tbodyaccmagmean" | see RAW Data Attribute Details above
"tBodyAccMag-std()" | "tbodyaccmagstd" | see RAW Data Attribute Details above
"tGravityAccMag-mean()" | "tgravityaccmagmean" | see RAW Data Attribute Details above
"tGravityAccMag-std()" | "tgravityaccmagstd" | see RAW Data Attribute Details above
"tBodyAccJerkMag-mean()" | "tbodyaccjerkmagmean" | see RAW Data Attribute Details above
"tBodyAccJerkMag-std()" | "tbodyaccjerkmagstd" | see RAW Data Attribute Details above
"tBodyGyroMag-mean()" | "tbodygyromagmean" | see RAW Data Attribute Details above
"tBodyGyroMag-std()" | "tbodygyromagstd" | see RAW Data Attribute Details above
"tBodyGyroJerkMag-mean()" | "tbodygyrojerkmagmean" | see RAW Data Attribute Details above
"tBodyGyroJerkMag-std()" | "tbodygyrojerkmagstd" | see RAW Data Attribute Details above
"fBodyAcc-mean()-X" | "fbodyaccmeanx" | see RAW Data Attribute Details above
"fBodyAcc-mean()-Y" | "fbodyaccmeany" | see RAW Data Attribute Details above
"fBodyAcc-mean()-Z" | "fbodyaccmeanz" | see RAW Data Attribute Details above
"fBodyAcc-std()-X" | "fbodyaccstdx" | see RAW Data Attribute Details above
"fBodyAcc-std()-Y" | "fbodyaccstdy" | see RAW Data Attribute Details above
"fBodyAcc-std()-Z" | "fbodyaccstdz" | see RAW Data Attribute Details above
"fBodyAcc-meanFreq()-X" | "fbodyaccmeanfreqx" | see RAW Data Attribute Details above
"fBodyAcc-meanFreq()-Y" | "fbodyaccmeanfreqy" | see RAW Data Attribute Details above
"fBodyAcc-meanFreq()-Z" | "fbodyaccmeanfreqz" | see RAW Data Attribute Details above
"fBodyAccJerk-mean()-X" | "fbodyaccjerkmeanx" | see RAW Data Attribute Details above
"fBodyAccJerk-mean()-Y" | "fbodyaccjerkmeany" | see RAW Data Attribute Details above
"fBodyAccJerk-mean()-Z" | "fbodyaccjerkmeanz" | see RAW Data Attribute Details above
"fBodyAccJerk-std()-X" | "fbodyaccjerkstdx" | see RAW Data Attribute Details above
"fBodyAccJerk-std()-Y" | "fbodyaccjerkstdy" | see RAW Data Attribute Details above
"fBodyAccJerk-std()-Z" | "fbodyaccjerkstdz" | see RAW Data Attribute Details above
"fBodyAccJerk-meanFreq()-X" | "fbodyaccjerkmeanfreqx" | see RAW Data Attribute Details above
"fBodyAccJerk-meanFreq()-Y" | "fbodyaccjerkmeanfreqy" | see RAW Data Attribute Details above
"fBodyAccJerk-meanFreq()-Z" | "fbodyaccjerkmeanfreqz" | see RAW Data Attribute Details above
"fBodyGyro-mean()-X" | "fbodygyromeanx" | see RAW Data Attribute Details above
"fBodyGyro-mean()-Y" | "fbodygyromeany" | see RAW Data Attribute Details above
"fBodyGyro-mean()-Z" | "fbodygyromeanz" | see RAW Data Attribute Details above
"fBodyGyro-std()-X" | "fbodygyrostdx" | see RAW Data Attribute Details above
"fBodyGyro-std()-Y" | "fbodygyrostdy" | see RAW Data Attribute Details above
"fBodyGyro-std()-Z" | "fbodygyrostdz" | see RAW Data Attribute Details above
"fBodyGyro-meanFreq()-X" | "fbodygyromeanfreqx" | see RAW Data Attribute Details above
"fBodyGyro-meanFreq()-Y" | "fbodygyromeanfreqy" | see RAW Data Attribute Details above
"fBodyGyro-meanFreq()-Z" | "fbodygyromeanfreqz" | see RAW Data Attribute Details above
"fBodyAccMag-mean()" | "fbodyaccmagmean" | see RAW Data Attribute Details above
"fBodyAccMag-std()" | "fbodyaccmagstd" | see RAW Data Attribute Details above
"fBodyAccMag-meanFreq()" | "fbodyaccmagmeanfreq" | see RAW Data Attribute Details above
"fBodyBodyAccJerkMag-mean()" | "fbodybodyaccjerkmagmean" | see RAW Data Attribute Details above
"fBodyBodyAccJerkMag-std()" | "fbodybodyaccjerkmagstd" | see RAW Data Attribute Details above
"fBodyBodyAccJerkMag-meanFreq()" | "fbodybodyaccjerkmagmeanfreq" | see RAW Data Attribute Details above
"fBodyBodyGyroMag-mean()" | "fbodybodygyromagmean" | see RAW Data Attribute Details above
"fBodyBodyGyroMag-std()" | "fbodybodygyromagstd" | see RAW Data Attribute Details above
"fBodyBodyGyroMag-meanFreq()" | "fbodybodygyromagmeanfreq" | see RAW Data Attribute Details above
"fBodyBodyGyroJerkMag-mean()" | "fbodybodygyrojerkmagmean" | see RAW Data Attribute Details above
"fBodyBodyGyroJerkMag-std()" | "fbodybodygyrojerkmagstd" | see RAW Data Attribute Details above
"fBodyBodyGyroJerkMag-meanFreq()" | "fbodybodygyrojerkmagmeanfreq" | see RAW Data Attribute Details above
"angle(tBodyAccMean,gravity)" | "angletbodyaccmeangravity" | see RAW Data Attribute Details above
"angle(tBodyAccJerkMean),gravityMean)" | "angletbodyaccjerkmeangravitymean" | see RAW Data Attribute Details above
"angle(tBodyGyroMean,gravityMean)" | "angletbodygyromeangravitymean" | see RAW Data Attribute Details above
"angle(tBodyGyroJerkMean,gravityMean)" | "angletbodygyrojerkmeangravitymean" | see RAW Data Attribute Details above
"angle(X,gravityMean)" | "anglexgravitymean" | see RAW Data Attribute Details above
"angle(Y,gravityMean)" | "angleygravitymean" | see RAW Data Attribute Details above
"angle(Z,gravityMean)" | "anglezgravitymean" | see RAW Data Attribute Details above
  
    

RAW Feature Activity Level Labels | Tidy Feature "activity" - Activity Level Labels
----------------|---------------------------------------
LAYING | laying
SITTING | sitting
STANDING | standing
WALKING | walking
WALKING_DOWNSTAIRS | walkingdown
WALKING_UPSTAIRS | walkingup




