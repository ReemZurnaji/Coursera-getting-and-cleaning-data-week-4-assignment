# Coursera-getting-and-cleaning-data-week-4-assignment
This is the course project for Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

1)Download the dataset and unzip it if it does not already exist in the working directory
2)Load both the activity labels and features data
3)Load both the training and test datasets.
4)load the training subject and test subject data.
5)merging the train and test datasets rowwise after naming the variables and adding the subject and acticities data to both data sets.
6)extracting and store the columns that measure mean or standard deviation.
7)Convert the activity column into factor.
8)name the variables with better discriptive names.
9)Create a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
The resulted tidy data is shown in the file tidy.txt.

