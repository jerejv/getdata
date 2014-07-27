==================================================================================
Tidied Dataset of Human Activity Recognition Using Smartphones Dataset Version 1.0
==================================================================================
Jeremy Verbit
==================================================================================

The tidied dataset of the Human Activity Recognition Using Smartphones Dataset Version 1.0 is stored in tidyData.txt.
See codeBook.txt for more information as to the original source of the data.

The run_analysis.R script that tidied the original data source and output it into tidyData.txt performs the following steps:
1. Downloads and unzips the original data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Loads data from all necessary files containing training and test data, their column names, activities, and subjects into data frames.
3. Binds training data with column names, activities, and subjects into one training data frame.
4. Binds test data with column names, activities, and subjects into one test data frame.
5. Combines resulting training and test data into one large data set
6. Strips the full dataset into activity, subject, and only mean and std data columns.
7. Melts the data by subject_id and activity_name.
8. Dcasts the data into means by activity_name and subject_id.
9. Outputs the data to a tidyData.txt file.