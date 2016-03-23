#CodeBook
This CodeBook documents explaination of the code in run_analysis.R script

#Part 1: Get the data
a) check data file exists or not, otherwise create one
b) download file (add method = "curl" if using MAC)
c) Unzip data file
d) Exam file folder and assign file path to a variable named "path_ref"

#Part 2: Read the data
We have 3 categories of data - subject, activity and feature; for each category, there are 2 types - test and train. Following steps are aimed to read all required data.
a) Read activity files
b) Read subject files
c) Read feature files

#Part 3: Merge the data
Since we have already read data from files, now we can proceed to merge data. We merge the data based on categories.
a) Use "rbind" to merge Subject data
b) Use "rbind" to merge Acitvity data
c) Use "rbind" to merge Feature data
d) After merging data, then assign name for each categories. assign "subject" to subject data; assign "activity" to activity data; take note that feature data has its own names stored in "feature.txt". So we should align names with data.
e) Merge all data blocks to get data frame

#Part 4: Process the data
a) Get only names for mean and std measurements
b) Subset data from data frame to get only the data of requried features and required measurements, together with "subject" and "activity"
c) Read descriptive names from activity_labels.txt file and set the labels to activity data
d) Replace the feature names with desciptive names. For example,
- prefix t is replaced by time
- Acc is replaced by Accelerometer
- Gyro is replaced by Gyroscope
- prefix f is replaced by frequency
- Mag is replaced by Magnitude
- BodyBody is replaced by Body

#Part 5: Export the data
a) Use aggregate function to create a subset data with the average of each variable for each activity and each subject
b) Order the rows based on subject name and then activity name
c) Write to table


