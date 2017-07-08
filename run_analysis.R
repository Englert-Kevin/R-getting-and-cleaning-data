

### Load libraries for packages used in the run_analysis script
library(data.table)
library(dplyr)
library(stringr)

### Retrieve raw data to begin analysis

## I used a tempfile() to hold raw data during unzip process. 
## Using a tempfile() gives downloaded zip a unique temporary name in r's temp folder
## This permits the script to run in any working directory, without 
## needing to check if file exists, create dir, etc.
temp <- tempfile()
datalocation <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(datalocation,temp)
unzip(temp)


### Load required files from raw data into R objects
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features_list <- read.table("./UCI HAR Dataset/features.txt")

test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test_X <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_Y <- read.table("./UCI HAR Dataset/test/y_test.txt")

train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train_X <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_Y <- read.table("./UCI HAR Dataset/train/y_train.txt")

## Prepping and combining raw data for later tidying steps

## Update variable names of test_Xtest and train_Xtest with names from features_list
setnames(test_X, names(test_X), as.character(features_list[[2]]))
setnames(train_X, names(train_X), as.character(features_list[[2]]))

## Update names of subjet files to 'subject'
names(test_subjects) <- "subject"
names(train_subjects) <- "subject"
## Update names of activity columns in Y files
names(test_Y) <- "activity"
names(train_Y) <- "activity"

## Merge data frames for subjects, Y, and X for the respective test and train groups
test_all <- cbind(test_subjects, test_Y, test_X)
train_all <- cbind(train_subjects, train_Y, train_X)


#### 1. Merges the training and the test sets to create one data set.
## Merge test_all and train_all
all_measurements <- rbind(test_all, train_all)

#### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std_measurements <- cbind(all_measurements[, 1:2], all_measurements[, grepl("mean|std", names(all_measurements))])

#### 3. Uses descriptive activity names to name the activities in the data set
mean_std_measurements$activity <- factor(mean_std_measurements$activity, levels=1:6, labels = activity_labels$V2)

#### 4. Appropriately labels the data set with descriptive variable names.

## Identify which variables include values that were calculated with a Fast Fourier Transformation.
FFT_calcs <- c("fBodyAcc-", "fBodyAccJerk-", "fBodyGyro-", "fBodyAccJerkMag", "fBodyGyroMag", "fBodyGyroJerkMag")
FFT_calcs_bool_matrix <- sapply(FFT_list, grepl, names(mean_std_measurements))
FFT_calcs_bool_list <- as.logical(FFT_calcs_bool_matrix[, 1] + FFT_calcs_bool_matrix[, 2] + FFT_calcs_bool_matrix[, 3] + FFT_calcs_bool_matrix[, 4] + FFT_calcs_bool_matrix[, 5] + FFT_calcs_bool_matrix[, 6])
names(mean_std_measurements)[FFT_calcs_bool_list] <- paste0(names(mean_std_measurements)[FFT_calcs_bool_list], "calculated with a Fast Fourrier Transformation")

## Identify which variables include values of time versus values of frequency
names(mean_std_measurements) <- gsub("^t","Time of ",names(mean_std_measurements))
names(mean_std_measurements) <- gsub("^f","Frequency of ",names(mean_std_measurements))

## Identify which variables include values related to the body itself or to gravity.
## NOTE: I could not tell for sure what was meant by 'BodyBody' so I treated it as a 3rd option, equal in scope to 'Body' or Gravity' 
names(mean_std_measurements) <- gsub("Body","body ",names(mean_std_measurements))
names(mean_std_measurements) <- gsub("body body ","BodyBody ",names(mean_std_measurements))
names(mean_std_measurements) <- gsub("Gravity","gravity ",names(mean_std_measurements))

## Identify which variables include values on acceleration and on angular velocity.
## NOTE: I do not undersatnd this domain very well. But from what I can gather the gyroscope measure 'angular velocity'. 
names(mean_std_measurements) <- gsub("Acc","acceleration ",names(mean_std_measurements))
names(mean_std_measurements) <- gsub("Gyro","angular velocity ",names(mean_std_measurements))

## Identify which variables include values that are Jerk calculations or magnitude calculations
names(mean_std_measurements) <- gsub("Jerk","Jerk ",names(mean_std_measurements))
names(mean_std_measurements) <- gsub("Mag","magnitude ",names(mean_std_measurements))

## Identify which variables include values that are mean values or standard deviations
## NOTE: I do not undersatnd this domain very well. But I interpreted 'meanFreq' to be a different class of calculation than 'mean' 
names(mean_std_measurements) <- gsub("mean\\(\\)","as a mean value ",names(mean_std_measurements))
names(mean_std_measurements) <- gsub("meanFreq\\(\\)","as a mean frequency value ",names(mean_std_measurements))
names(mean_std_measurements) <- gsub("std\\(\\)","as a standard deviation ",names(mean_std_measurements))

## Identify which variables include values that measured one specific axis X, Y, or Z
names(mean_std_measurements) <- gsub("-X","on the X axis ",names(mean_std_measurements))
names(mean_std_measurements) <- gsub("-Y","on the Y axis ",names(mean_std_measurements))
names(mean_std_measurements) <- gsub("-Z","on the Z axis ",names(mean_std_measurements))

## Clean text strings by removing hyphens and trimming empty space.
names(mean_std_measurements) <- gsub("-","",names(mean_std_measurements))
names(mean_std_measurements) <- str_trim(names(mean_std_measurements))

#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Create a tabl_df to house the clean data.
mean_std_measurements_dplyr <- tbl_df(mean_std_measurements)

## Use dplyr functions to group and sumarize the table data frame by subject and activity by mean.
tidydata <- mean_std_measurements_dplyr %>% group_by(subject,activity) %>% summarize_all(mean)

## Write resulting table data frame to a new txt file in the working directory.
write.table(tidydata, "GettingAndCleaningData_TidyData.txt", row.name=FALSE)
