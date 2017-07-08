# Summary of Human Activity Recognition Using Smartphones Dataset

### Subject and Activity Means Analysis
#### by Coursera Student - KPE


#### Data Collection: 
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)

1. Smartlab - Non-Linear Complex Systems Laboratory DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
2. CETpD - Technical Research Centre for Dependency Care and Autonomous Living Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain  activityrecognition '@' smartlab.ws

#### Overview Summary:
The goal of this exercise was the summarize over 10,000 observations on acceleration and angular velocity by two variables: subject and activity, resulting in a data set of 180 observations across 79 variables in addition to the subject and activity variables.

The raw data collection was carried out by the above authers on a group of 30 volunteers within an age bracket of 19-48 years. Each subject performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity measures were captured at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. This analysis was executed on the above raw data. It was combined, reformated, an summarized to examine individual subjects performance by activity.

#### Raw Data Measurement Detail
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

#### Files
Analysis: located on GitHub

- 'run_analysis.R': R script executing the below steps on the associated raw data to clean, unite, and analyse the data. The script stores a tidy data set called, 'GettingAndCleaningData_TidyData.txt' in the working directory.

- 'README.md': This markdown document! It describes the summary test and instructions on how it was carried out to fascilitate replication.

- 'codebook.md': A markdown document defining each variable and its associated units. 

Raw Data: downloaded from the web here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

#### Getting Started
The run_analysis.R script includes code to download, unzip, and load the raw data. 

If you do not wish to have this run automatically. To recreate the process manually, please download the zip file at the above URL and unzip locally.

Be sure to place the unzipped raw data in the working directory or else the script will not work properly.

#### Prerequisites

Software

- R

- RStudio

R Packages

- library(dplr)

- library(stringr)

- library(data.table)

#### Summary Metrics
This analysis focused on the mean and standard deviation units of the raw data set. This was done to isolate measures of central tendency when summarizing by subject and activity. I do not understand this subject domain deeply, so I have added comments in the run_analysis.R script, where my interpretation may differ from expected norms. 

Measurement breakdowns

- Time versus Frequency

- Body, BodyBody,or Gravity

- Acceleration (Acc) versus Angular velocity (Gyro)

- Jerk or Magnitude calculation

- Mean value, meanFrequency value, or standard deviation

- Axial-specific or encompasing all axes

- Fast Fourrier Transformation versus standard

#### Guide To Conducting the Analysis

1. Load libraries for packages used in the run_analysis script

2. Retrieve raw data to begin analysis. Store result of download.file in a tempfile(). This allows the script to run in any working directory without checking for 

3. Load required files from raw data into R objects

4. Prepare and combine raw data for later tidying steps, including: updating variable names for X_test and X_train sets, updating names of activities and features_list files, and merging the 3 data frames (subjects, X, Y) for each group (test, train) into 1 large dataframe.

5. Merges the training and the test sets to create one data set. (Step 1 of the assignment)

6. Extracts only the measurements on the mean and standard deviation for each measurement. (Step 2 of the assignment)

7. Uses descriptive activity names to name the activities in the data set. This involved indexing the number values in each obbservation in the raw data to the corresponding value in the activity_labels data set.(Step 3 in the assigment)

8. Appropriately label the data set with descriptive variable names, by identifying which variables: include a Fast Fourier Transformation, represent time or freqency, body or gravity, acceleration or angular velocity, are Jerk or magnitude calculations, are mean or standard deviations, measure one specific axis, and generally clean the text strings by removing hyphens and empty space.

9. Creates a tidy data set with the average of each variable for each activity and each subject, by create a tabl_df to house the clean data, using dplyr functions to group and sumarize the table data frame by subject and activity by mean, and writing the resulting table data frame to a new txt file in the working directory.

#### System Details
This analysis was conduct using the below system:

Device: MacOS Sierra v10.12.4

R Version: 3.3.3 (2017-03-06)

#### Acknowledgments

In completing the assignment, I referenced:

- PurpleBooth for README template inspiration https://gist.github.com/PurpleBooth/109311bb0361f32d87a2

- thoughtfulblokes article on completing the final assignment:  https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/

- Coursera TA's Guide to executing this course's final project: https://drive.google.com/file/d/0B1r70tGT37UxYzhNQWdXS19CN1U/view
