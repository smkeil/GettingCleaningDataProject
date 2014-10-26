library(dplyr)

## Read in needed data files.
orig_training_set <- tbl_df(read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"))
training_labels <- tbl_df(read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt"))
training_subjects <- tbl_df(read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"))
orig_test_set <- tbl_df(read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"))
test_labels <- tbl_df(read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt"))
test_subjects <- tbl_df(read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"))
activity_labels <- tbl_df(read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"))
features <- tbl_df(read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt"))

## Reassign column names in orig_training_set and orig_test_set from
## {V1, ... V561} to explicit measurement name from features file.
colnames(orig_training_set) <- as.character(features[,2])
colnames(orig_test_set) <- as.character(features[,2])

## Provide meaningful column names.
colnames(training_subjects) <- "subject"
colnames(test_subjects) <- "subject"
colnames(training_labels) <- "activity"
colnames(test_labels) <- "activity"

## Identify indices of column names to keep, i.e. any with 'mean()' or 'std()'
## in their measurement name.
cols_to_keep <- grep("mean\\()|std\\()", features[,2],
                     ignore.case=TRUE, fixed=FALSE, value=FALSE)

## Reduce datasets to contain only columns that are being kept.
reduced_training_set <- orig_training_set[, cols_to_keep]
reduced_test_set <- orig_test_set[, cols_to_keep]

## Append columns for Subject number and Activity.
reduced_training_set <- cbind(training_subjects, training_labels,
                              reduced_training_set)
reduced_test_set <- cbind(test_subjects, test_labels, reduced_test_set)

## Combine training and test datasets to one datafile.
combined_data <- rbind(reduced_training_set, reduced_test_set)

## Substitute Activity Label names in place of Activity.
combined_data$activity <- factor(as.character(combined_data$activity),
                          levels = activity_labels$V1,
                          labels = activity_labels$V2)

## Perform additional cleaning up of variable names:
tmp_colnames <- colnames(combined_data)
tmp_colnames <- sub("^t", "time-", tmp_colnames)
tmp_colnames <- sub("^f", "frequency-", tmp_colnames)
tmp_colnames <- sub("BodyBody", "Body", tmp_colnames)
tmp_colnames <- sub("Acc", "-Acceleration", tmp_colnames)
tmp_colnames <- sub("Gyro", "-Gyroscope", tmp_colnames)
tmp_colnames <- sub("Jerk", "-Jerk", tmp_colnames)
tmp_colnames <- sub("Mag", "-Magnitude", tmp_colnames)
tmp_colnames <- sub("std", "standard-deviation", tmp_colnames)
tmp_colnames <- sub("\\(\\)", "", tmp_colnames)
tmp_colnames <- tolower(tmp_colnames)
colnames(combined_data) <- tmp_colnames

## For each Subject-Activity, calculate the mean value for each measurement.
tidy_data <- combined_data %>% group_by(subject, activity) %>% summarise_each(funs(mean))

write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
