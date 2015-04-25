## run_analysis.R

## Preparation

## This program assumes that the content of 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## is available in your working directory. Please ensure this is done prior to running the 
## program.

## This program requires several packages. Check to see if the packages are already installed.
## If not, install them.

packages <- c("plyr", "dplyr", "tidyr","gdata")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
    install.packages(setdiff(packages, rownames(installed.packages())))  
}

library(plyr)
library(dplyr)
library(tidyr)
library(gdata)

## STEP 1: Merge the training and the test sets to create one data set.

## Read in all the necessary input files.Give some variables descriptive variable names from the start.

features<-read.table("UCI HAR Dataset/features.txt")
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activity","activity_label"))
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt",col.names="subjectID")
X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("UCI HAR Dataset/test/Y_test.txt", col.names="activity")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt", col.names="subjectID")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("UCI HAR Dataset/train/Y_train.txt", col.names="activity")

## Use the features dataset to give descriptive variable names to X_test and X_train.

colnames(X_train)<-features[,2]
colnames(X_test)<-features[,2]

## Bind the columns of the three datasets for the "test" cohort into one file.
## Repeat the process for the "train" cohort.

test<-cbind(subject_test,Y_test,X_test) 
train<-cbind(subject_train,Y_train,X_train)

## Bind the rows of the test and train datasets into one file.

bothgps<-rbind(train,test)

## STEP 2: Extract only the mea surements on the mean and standard deviation for each measurement.

## Library gdata is used for this step.

stmean<-bothgps[,unlist(matchcols(bothgps, with=c("subject","group","activity","mean\\(\\)","std\\(\\)"), method="or"))]

## STEP 3: Use descriptive activity names to name the activities in the data set.

## Merge stmean with the activity lavels dataset by activity number. Drop the activity numbers and
## create a new variable ''activity" which is equal to the labels.

stmean1<-join(stmean,activity_labels,by="activity")
stmean1<- stmean1[ ,c(1,69,3:68)]
names(stmean1)[2]<-"activity"

## Step 4: Appropriately labels the data set with descriptive variable names. 

## Reshape dataset so that the the different types of measurements are in rows, with the actual reading 
## in a separate column. Now each column is labeled with a descriptive variable name.

narrowstm<-gather(stmean1,measureType,reading, -c(subjectID,activity))

## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.

avgReadings <- narrowstm %>%
               group_by(subjectID,activity, measureType)%>%
               summarise_each(funs(mean))
names(avgReadings)[4]<-"avgReading"

## Write the results of Step5 to an output file.

write.table(avgReadings,"samsung_avgReadings.txt",row.names=FALSE)


