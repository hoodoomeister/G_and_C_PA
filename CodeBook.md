##CodeBook

1. Merges the training and the test sets to create one data set using read.table() and loop with rbind() function to merge 
train and test sets in single file. I read names of variables from features.txt and added as names of columns, final name of object - data.  

2. Extracts only the measurements on the mean and standard deviation for each measurement. 
I extracted from raw data every column from whole set which gives info about mean or standard deviation using grep() function
to find every name of column with 'mean' and 'sd'. In loop with cbind(0 function I read columns from single file from first part.
Final name of object - data2.

3. Uses descriptive activity names to name the activities in the data set.
I merged data from second column from activity_labels.txt with data as merged_data.

4. Appropriately labels the data set with descriptive activity names. 
I read names of merged_data into name data.frame and using gsub() function I changed them to make it more readable, after that 
i renamed merged_data.

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
I created 2 data.frames ave_data and ave_data2 which were mean values for every variable grouped by subject (person) and activity name.
In loop using rbind() function I merged those files into one called tidy_data.
I write data.frame tidy_data as text file tidy_data.txt.



Tidy_data.txt file contains 87 columns, in first are Categories for every row, first 30 (1:30) rows describes average 
values for every person who took part in this experiment. Last 6 rows describes average values for activities:
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

I chooded those variable to see any correlation between them, subject and activity name. Variables are in the same units as were 
originaly. 
I have noticed that every mean of variable for every category have the same order of magnitue and really close values.
