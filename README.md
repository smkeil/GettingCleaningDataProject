GettingCleaningDataProject
==========================
Repository for Course Project for Coursera's "Getting and Cleaning Data"
25Oct2014

1. Download the following zip file which contains all needed data files. 
        https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
        
        A full description of this data is available from its original location:
              http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  
2. Place the above downloaded file in a directory called WORK from which you are able to run R scripts. You should have
...WORK/getdata_projectfiles_UCI HAR Dataset.zip

3. From the directory WORK, unzip the above zip file, accepting the extract defaults. This should result in a new directory
containing several text files with the following path structure:
...WORK/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/{test, train}/...

NOTE: If your operating system does not support space characters in directory (or file) names, or if the path structure of the
extracted contents of the downloaded zip file have changed, you will need to update the path arguments provided to read.table()
on lines 4 through 11 of the run_analysis.R script in order to be sure all data input required by the script is obtained.

4. Place the script run_analysis.R found in this Github repository in the above mentioned directory called WORK. You should have
...WORK/run_analysis.R

5. Run the R script run_analysis.R. run_analysis accomplishes the following tasks. Please see the file CodeBook.md in this
Github repository for more information about the data and how it is transformed to a useful format.
    A. Reads in 8 text data files from the data downloaded above. 
    B. Reassigns or provides useful column names to data of interest.
        
