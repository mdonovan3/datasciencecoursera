### Coursera Getting and Cleaning Data Course Project Code Book

**The program file `run_analysis.R`performs the following steps:**

1. **Download and extract the zipped file containing the project data**

2. **Set up dataframes from the raw data files**
    - features -- `features.txt`
    - activity_labels -- `activities.txt`
    - subject_test -- `test/subject_test.txt`
    - X_test -- `test/X_test.txt`
    - y_test -- `test/y_test.txt`
    - subject_train -- `train/subject_train.txt`
    - X_train -- `train/X_train.txt`
    - y_train -- `train/y_train.txt`

3. **Merge the data from the training and test sets**
    - X_merged <- X_test, X_train -- by row
    - y_merged <- y_test, y_train -- by row
    - subject_merged <- subject_test, subject_train --by row
    - data_merged <- subject_merged, y_merged, X_merged -- by column
    
4. **Filter out any data that is not a mean or standard deviation value by selecting only features names containing "mean" or "std"**


5. **Rename data frame columns for clarity**
    - Replace numeric activity code with text name
    - replace abbreviations in column names for better interpretablility
    
6. **Summarize data - average values grouped by subject and activity**

7. **Write out the final, summarized form of the data fram resulting from all of 
  the above steps** 
      - Final form of data is written out to `DataSummary.txt`
