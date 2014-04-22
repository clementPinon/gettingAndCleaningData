gettingAndCleaningData
======================

Coursera | getting and cleaning data 2014 class | assignment


You should create one R script called run_analysis.R that does the following. 

	#Merges the training and the test sets to create one data set.

	#Extracts only the measurements on the mean and standard deviation for each measurement. 

	#Uses descriptive activity names to name the activities in the data set

	#Appropriately labels the data set with descriptive activity names. 

	#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 



In order to load it in R studio, set the root folder as a working directory and run the following command:
	source("run_analysis.R", local=T)

Merged data sets are stored under "users_moves"

Extract data set with only mean and std is stored under "extract"

tidy data set with mean of each variable for each pair of users & moves is stored under "new_ds"

a brand new tidy data set will then appear in the working directory under "tidyDataSet.txt"