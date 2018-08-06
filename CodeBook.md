Assignmnet 4 for getting and cleaning data.

FIles contained:
CodeBook.md - describes the variables, data, and transformations

README.md - Explains the analysis files is clear and understandable
run_analysis.R does:

Runs from the same directory as the UCI HAR Dataset folder. It imports the test and training sets, combines them into one file, and then calculates the mean and standard deviation. It then replaces the numerical values for each activity with the descriptive values. Lastly it creates a new dataframe which shows the mean and standard deviations per subject and activity.
