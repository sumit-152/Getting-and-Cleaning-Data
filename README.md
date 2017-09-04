# Getting-and-Cleaning-Data

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

Source Data : The source data set that this project was based on was obtained from the Human Activity Recognition Using Smartphones Data Set
Training and test data were first merged together to create one data set, then the measurements on the mean and standard deviation were extracted for each measurement (79 variables extracted from the original 561), and then the measurements were averaged for each subject and activity, resulting in the final data set.

Creating the data set :
	1.	Download the dataset if it does not already exist in the working directory
	2.	Load the activity and feature info
	3.	Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
	4.	Loads the activity and subject data for each dataset, and merges those columns with the dataset
	5.	Merges the two datasets
	6.	Converts the activity and subject columns into factors
	7.	Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The end result is shown in the file tidy.txt. CodeBook.md summarizes the data fields.


