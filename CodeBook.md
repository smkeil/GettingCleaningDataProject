I. Data input to run_analysis.R

The data used as input is wearable computing data collected from the accelerometers 
of the Samsung Galaxy S II smartphone. 

Further information about the data collected is available at the University of 
California Irvine Machine Learning Repository:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

The needed data can be downloaded from the above UCI location or from Coursera
here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Note that The zip file contains more files than are used in this current analysis.

Two files from the zip file worth reviewing that are not used as input but provide 
good background information on the data are README.txt and features_info.txt .

The following 8 files are used as input to run_analysis.R. The variable name for each file when initially read in to R appears in parenthesis after the file name.

1. activity_labels.txt (activity_labels): 6 rows, 2 columns. There are 6 different activities captured in the smartphone data. This file provides an activity number and activity name
for each activity.

2. features.txt (features): 561 rows, 2 columns. There are 561 features or variables describing the smartphone data captured. The features are a mixture of measurements describing the raw data signals captured plus derivations and estimates from the raw data. As mentioned above, features_info.txt provides more background information. features.txt is simply a list of the 561 variables. The first column of data is simply a list from 1 to 561. The second column of data is the feature name. 

3. subject_train.txt (training_subjects): 7352 rows, 1 column. This is a list of subject numbers that directly corresponds, row for row, to the data in X_train.txt. The data for the subject number at row 7000 in subject_train.txt can be found on row 7000 in the file X_train.txt. There are 21 unique training subject numbers.

4. subject_test.txt (test_subjects): 2947 rows, 1 column. This is a list of subject numbers that directly corresponds, row for row, to the data in X_test.txt. The data for the subject number at row 2000 in subject_test.txt can be found on row 2000 in the file X_test.txt. There are 9 unique test subject numbers.

5. X_train.txt (orig_training_set): 7352 rows, 561 columns. This is the full set of datapoints for the training subjects for all 561 features. Subject numbers for these datapoints are found in subject_train.txt, with a row for row correspondence. The subject for the data at row 7000  in X_train.txt is the subject on row 7000 in subject_train.txt. Features (variable names) for these datapoints are found in features.txt. Rows in features.txt correspond to columns in X_train.txt. The feature for the data in column 100 in X_train.txt is the feature on row 100 in features.txt.

6. X_test.txt (orig_test_set): 2947 rows, 561 columns. This is the full set of datapoints for the test subjects for all 561 features. Subject numbers for these datapoints are found in subject_test.txt, with a row for row correspondence. The subject for the data at row 2000 in X_test.txt is the subject on row 2000 in subject_test.txt. Features (variable names) for these datapoints are found in features.txt. Rows in features.txt correspond to columns in X_test.txt. The feature for the data in column 1000 in X_test.txt is the feature on row 100 in features.txt.

7. y_train.txt (training_labels): 7352 rows, 1 column. This is a list of activities that directly corresponds, row for row, to the data in X_train.txt. The activity performed for the data at row 7000 in X_train.txt can be found on row 7000 of y_train.txt.

8. y_test.txt (test_labels): 2947 rows, 1 column. This is a list of activities that directly corresponds, row for row, to the data in X_test.txt. The activity performed for the data at row 2000 in X_test.txt can be found on row 2000 on y_test.txt.

II. Tidying and Transformations
After reading in all of the above mentioned data, run_analysis.R performs two tasks. 

First, a single, tidy dataset is assembled that appropriately combines the original 8 data files to a single file. As part of this process, the ultimate tidy dataset only includes features (or measurements) that pertain to the mean or standard deviation of the various features captured. 

Second, using the newly assembled tidy dataset, run_analysis.R writes a new file, tidy_data.txt. tidy_data.txt is described in section III below.

The various steps to tidy and other transform the input data to a tidy data set are as follows.
A. The column headers for the 561 columns in each of orig_test_set and orig_training set are set to the appropriate textual feature names.

B. The column header 'subject' is applied for the single column in each of test_subjects and training_subjects.

C. The column header 'activity' is applied for the single column in each of test_labels and training_labels.

D. Remembering the only features of interest in this current analysis are those pertaining to the mean or standard deviation, a list of features to retain is identified. There are likely several ways of deciding which features should be kept. For the purposes of this particular analysis, a feature was identified as one to retain if its original feature name contained either 'mean()' or 'std()'. Analyzing the 561 feature names in this way resulted in a list of 66 features to keep. 

Those 66 features are listed here, with each feature name appearing inside a pair of double quotation marks("feature name").

"tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"           "tBodyAcc-mean()-Z"          
"tBodyAcc-std()-X"            "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
"tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"        "tGravityAcc-mean()-Z"       
"tGravityAcc-std()-X"         "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
"tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"       "tBodyAccJerk-mean()-Z"      
"tBodyAccJerk-std()-X"        "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
"tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"          "tBodyGyro-mean()-Z"         
"tBodyGyro-std()-X"           "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
"tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"      "tBodyGyroJerk-mean()-Z"     
"tBodyGyroJerk-std()-X"       "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
"tBodyAccMag-mean()"          "tBodyAccMag-std()"           "tGravityAccMag-mean()"      
"tGravityAccMag-std()"        "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
"tBodyGyroMag-mean()"         "tBodyGyroMag-std()"          "tBodyGyroJerkMag-mean()"    
"tBodyGyroJerkMag-std()"      "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
"fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"            "fBodyAcc-std()-Y"           
"fBodyAcc-std()-Z"            "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
"fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"        "fBodyAccJerk-std()-Y"       
"fBodyAccJerk-std()-Z"        "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
"fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"           "fBodyGyro-std()-Y"          
"fBodyGyro-std()-Z"           "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
"fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"   "fBodyBodyGyroMag-mean()"    
"fBodyBodyGyroMag-std()"      "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()" 

E. Each of orig_test_set and orig_training_set are reduced to include just the 66 features (columns) of interest, yielding reduced_test_set (2947 rows, 66 columns) and reduced_training_set (7352 rows, 66 columns).

F. The appropriate subject numbers and activity lists are appended to each of reduced_test_set and reduced _training_set using column binding (cbind()), yielding (2947 rows, 68 columns) and (7352 rows, 68 columns) respectively.

G. Test and training data are appended to each other using row binding (rbind()), yielding a data structure called combined_data (10299 rows, 68 columns).

H. At this point, the second column of combined_data is a list of activity numbers. These activity numbers are replaced by activity names. 

I. The 66 feature names retained above in step D above are further "cleaned" as follows. The goal of the cleaning is to end up with descriptive, clear variable (column) names. Anything
cryptic was expanded, space characters and periods were avoided, and all variable names were converted to lower text characters. Certainly, this is subjective and results in very long variable names.

---> Variable names starting with "t" were renamed to start with "time-".

---> Variable names starting with "f" were renamed to start with "frequency-".

---> If the variable name included "BodyBody" (likely a mistake in the original data), "BodyBody" was changed to "Body".

---> If the variable name included "Acc", "Acc" was replaced with "-Acceleration".

---> If the variable name included "Gyro", "Gyro" was replaced with "-Gyroscope".

---> If the variable name included "Jerk", "Jerk" was replaced with "-Jerk".

---> If the variable name included "Mag", "Mag" was replaced with "-Magnitude".

---> If the variable name included "std", "std" was replaced with "standard-deviation".

---> If the variable name included "()", "()" was removed from the variable name.

---> All upper case characters remaining in variable names were converted to lower case.

The column names for the 68 total columns in the resulting tidy data set are as follows, with each revised feature name appearing inside a pair of double quotation marks("feature name").

 [1] "subject"                                                      
 [2] "activity"                                                     
 [3] "time-body-acceleration-mean-x"                                
 [4] "time-body-acceleration-mean-y"                                
 [5] "time-body-acceleration-mean-z"                                
 [6] "time-body-acceleration-standard-deviation-x"                  
 [7] "time-body-acceleration-standard-deviation-y"                  
 [8] "time-body-acceleration-standard-deviation-z"                  
 [9] "time-gravity-acceleration-mean-x"                             
[10] "time-gravity-acceleration-mean-y"                             
[11] "time-gravity-acceleration-mean-z"                             
[12] "time-gravity-acceleration-standard-deviation-x"               
[13] "time-gravity-acceleration-standard-deviation-y"               
[14] "time-gravity-acceleration-standard-deviation-z"               
[15] "time-body-acceleration-jerk-mean-x"                           
[16] "time-body-acceleration-jerk-mean-y"                           
[17] "time-body-acceleration-jerk-mean-z"                           
[18] "time-body-acceleration-jerk-standard-deviation-x"             
[19] "time-body-acceleration-jerk-standard-deviation-y"             
[20] "time-body-acceleration-jerk-standard-deviation-z"             
[21] "time-body-gyroscope-mean-x"                                   
[22] "time-body-gyroscope-mean-y"                                   
[23] "time-body-gyroscope-mean-z"                                   
[24] "time-body-gyroscope-standard-deviation-x"                     
[25] "time-body-gyroscope-standard-deviation-y"                     
[26] "time-body-gyroscope-standard-deviation-z"                     
[27] "time-body-gyroscope-jerk-mean-x"                              
[28] "time-body-gyroscope-jerk-mean-y"                              
[29] "time-body-gyroscope-jerk-mean-z"                              
[30] "time-body-gyroscope-jerk-standard-deviation-x"                
[31] "time-body-gyroscope-jerk-standard-deviation-y"                
[32] "time-body-gyroscope-jerk-standard-deviation-z"                
[33] "time-body-acceleration-magnitude-mean"                        
[34] "time-body-acceleration-magnitude-standard-deviation"          
[35] "time-gravity-acceleration-magnitude-mean"                     
[36] "time-gravity-acceleration-magnitude-standard-deviation"       
[37] "time-body-acceleration-jerk-magnitude-mean"                   
[38] "time-body-acceleration-jerk-magnitude-standard-deviation"     
[39] "time-body-gyroscope-magnitude-mean"                           
[40] "time-body-gyroscope-magnitude-standard-deviation"             
[41] "time-body-gyroscope-jerk-magnitude-mean"                      
[42] "time-body-gyroscope-jerk-magnitude-standard-deviation"        
[43] "frequency-body-acceleration-mean-x"                           
[44] "frequency-body-acceleration-mean-y"                           
[45] "frequency-body-acceleration-mean-z"                           
[46] "frequency-body-acceleration-standard-deviation-x"             
[47] "frequency-body-acceleration-standard-deviation-y"             
[48] "frequency-body-acceleration-standard-deviation-z"             
[49] "frequency-body-acceleration-jerk-mean-x"                      
[50] "frequency-body-acceleration-jerk-mean-y"                      
[51] "frequency-body-acceleration-jerk-mean-z"                      
[52] "frequency-body-acceleration-jerk-standard-deviation-x"        
[53] "frequency-body-acceleration-jerk-standard-deviation-y"        
[54] "frequency-body-acceleration-jerk-standard-deviation-z"        
[55] "frequency-body-gyroscope-mean-x"                              
[56] "frequency-body-gyroscope-mean-y"                              
[57] "frequency-body-gyroscope-mean-z"                              
[58] "frequency-body-gyroscope-standard-deviation-x"                
[59] "frequency-body-gyroscope-standard-deviation-y"                
[60] "frequency-body-gyroscope-standard-deviation-z"                
[61] "frequency-body-acceleration-magnitude-mean"                   
[62] "frequency-body-acceleration-magnitude-standard-deviation"     
[63] "frequency-body-acceleration-jerk-magnitude-mean"              
[64] "frequency-body-acceleration-jerk-magnitude-standard-deviation"
[65] "frequency-body-gyroscope-magnitude-mean"                      
[66] "frequency-body-gyroscope-magnitude-standard-deviation"        
[67] "frequency-body-gyroscope-jerk-magnitude-mean"                 
[68] "frequency-body-gyroscope-jerk-magnitude-standard-deviation" 

J. Within run_analysis.R, combined_data is the resulting tidy dataset (10299 rows, 68 columns). Each row contains "feature" data for 66 features for a particular subject-activity combination.

III. Data output from run_analysis.R.

The final action performed by run_analysis.R is to write a new file, tidy_data.txt, using the newly created tidy dataset (combined_data). The intent of tidy_data.txt is to summarise or consolidate all data for each subject-activity combination to a single row. There are 30 unique subjects (9 test, 21 training) and 6 unique activities. So, a total of 180 rows are expected in the final tidy_data.txt. 

Column headers (variable names) in tidy_data.txt are identical to the 68 columns described above in II.I.

For each subject-data combination, the value reported in columns 3 through 68 of tidy_data.txt is the mean value for that column's feature across all available data.  For example, for Subject 30, considering the Activity of LAYING, the mean value for "frequency-body-gyroscope-jerk-magnitude-standard-deviation" is -0.97548155.
