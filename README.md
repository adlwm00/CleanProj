Data Cleaning Course Project ReadMe
Files in this repo:
README.md
CodeBook.md - variable listing (similar to the one from Quiz 1, as instructed by TAs)
run_analysis.R

This analysis is a part of Coursera's Getting and Cleaning Data class. The project's main goal is to help students learn how to get and clean data from the web, and to output a resulting tidy dataset. The output is meant to follow the principles of tidy data as outline in Hadley Wickham's paper entitled "Tidy Data," which may be downloaded here. http://vita.had.co.nz/papers/tidy-data.pdf. The three main principles are:
1) Each variable forms a column 
2) Each observation forms a row
3) Each type of observational unit forms a table.
run_analysis.R analyses data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
The script should run as long as the Samsung data is in your working directory. The data should be downloaded from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Before running the script:
1) Download the Samsung data
2) Unzip the file
3) Set your R working directory to the directory that contains the directory "UCI HAR Dataset."

run_analysis.R will complete the following steps:
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Read the script's annotations for more detail about the purpose of specific code.
See codebook.md for the variable listing of the output dataset.

Study Design

See README.txt in the directory downloaded from Samsung for more information about the data they collected and provided. Here, I will describe what I do with the data provided by Samsung.

Step1: Merges the training and the test sets to create one data set.
Training Data
'train/X_train.txt': Training set.
'train/Y_train.txt': Training labels.
'train/subject_train.txt': Training subjects.

Test Data
'test/X_test.txt': Test set.
'test/Y_test.txt': Test labels.
'train/subject_test.txt': Test subjects.

The variables of X_train and Y_train are replaced with the labels in features.txt, which represent the types of measurements collected.
The columns of the training datasets are bound together, then likewise for the test. Then the training data rows are bound with the test data rows.

Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
Functionality from the library gdata is used to subset the measurement variables to those that contain the phrases "mean()" or "std()".

Step 3: Uses descriptive activity names to name the activities in the data set.
The numeric activity codes are replaced by the labelled activities in activity_labels.txt.

Step 4: Appropriately labels the data set with descriptive variable names. 
This step required some reshaping of the data. I decided to make the file "narrow" instead of "wide." The bulk of the columns until now have represented various types of measurements. It seems quite different to read the data with long, complicated variable names.
In this step, the data are restructures such that there is one variable "measureType" that contains the respective types and a variable "reading" that contains the corresponding measurement. 
After restructuring, the dataset has four variables with descriptive names:
subjectID
activity
measureType
reading

Step5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
In this step, the average is taken for each subjectID, activity, and measureType combination. The variable reading is now called avgReading.
The output dataset is submitted through Coursera and is entitled samsung_avgReadings.txt.

Tidy Data Thoughts
As indicated in the course discussion boards, there is no one right answer to how to tidy these data. I've made certain assumptions that not need be the assumptions others made. However, according to the instructions, we were to focus on creating output in which:
1) Each variable forms a column 
2) Each observation forms a row
My output does that. Regarding 1) I restructured the data such that the four columns represent intuitively distinct and descriptive variables. Regarding 2) each observation does form one row. Each row represent a unique subject ID, activity and measurement collected. 
I did consider separating the mean measurements and the standard deviation measurements into two separate variables, but I saw on one of the discussion boards, a TA suggested that if we opt to produce a "narrow" dataset, that it would contain four columns. Separating the two would have created a fifth variable. So I assume the TAs feel this is sufficiently tidy.
