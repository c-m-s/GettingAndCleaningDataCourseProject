#README for GettingAndCleaningDataCourseProject folder
====================================

##run_analysis.R

<br />
This R script does the following:

- Checks for the RAW data and attempts to reaquire it if not found locally.
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- Creates tidy_dataset.txt of the cleaned data. This is a 10 MB file. I did not upload to github or to the Coursera website. We are asked to generate this file as part of our script but there is no mention to upload this file.
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject named, tidy_mean_data.txt. This is the file I uploaded to Coursera and just to be safe I've uploaded to github too.


## tidy_mean_data.txt

- Text file saved with **TAB** delimiters.
- Second, independent tidy data set with the average of each variable for each activity and each subject.
- **This is the tidy dataset that I uploaded to the Coursera website.**
