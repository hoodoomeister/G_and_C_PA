##1. Merges the training and the test sets to create one data set.

##read data test
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", sep="")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep="")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", sep="")
features <- read.table("./UCI HAR Dataset/features.txt", sep="")
column_names <- as.matrix(features[, 2])
 names(X_test) <- column_names

 ##add columns to x_test
  X_test$activity <- y_test
 X_test$subject <- subject_test
 
 ##read data train
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", sep="")
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep="")
  X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", sep="")
  names(X_train) <- column_names

  ##add columns to x_train
  X_train$activity <- y_train
  X_train$subject <- subject_train
  
  ## rename columns name
  names(X_test[,563]) <- "subject"
  names(X_test[,562]) <- "activity"
  names(X_train[,563]) <- "subject"
  names(X_train[,562]) <- "activity"

  ## loop for completing dataset
 n <- nrow(X_test)
  for (i in 1:n) {
  x <- X_test[i, ]
  X_train <- rbind(X_train, x)
}


 data <- X_train
  
  ##2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  
  mean <- grep("mean", features[, 2], ignore.case= TRUE, value= TRUE, perl = TRUE)
sd <- grep("std", features[, 2], ignore.case= TRUE, value= TRUE, perl = TRUE)
s1 <- as.data.frame(sd)
m1 <- as.data.frame(mean)

colnames(m1) <- "V1"
colnames(s1) <- "V1"

n <- nrow(s1)
  for (i in 1:n) {
  x <- s1[i, ]
  x <- as.data.frame(x)
  names(x) <- "V1"
 m1 <- rbind(m1, x)
}

m1 <- m1[order(m1[, 1]),]
m1 <- as.data.frame(m1)

n <- nrow(m1)
m <- nrow(data)
data2 <- matrix(0, ncol = 1, nrow = m)
data2 <- data.frame(data2)



  for (i in 1:n) {
  x <- m1[i, ]
  X <- data[, x]
 X <- data.frame(X)
 names(X) <- x
 data2 <- cbind(data2, X[, 1])

}
m <- ncol(data2)

data2 <- data2[, 2:m-1]
names(data2) <- m1[, 1]


data2$activity <- data[, "activity"]
data2$subject <- data[, "subject"]
  
  ## 3. Uses descriptive activity names to name the activities in the data set
  
  
activity_labels  <- read.table("./UCI HAR Dataset/activity_labels.txt", sep="")


merged_data <- merge(data2, activity_labels, by.x ="activity", by.y="V1")
n <- nrow(merged_data)
names(merged_data)[89] <- "Activity name"
## 4. Appropriately labels the data set with descriptive activity names. 


name <- names(merged_data)
name <- data.frame(name)
name2 <- gsub("-", "", name[, 1])
name2 <- data.frame(name2)
name2 <- gsub("tBody", "Time body ", name2[, 1])
name2 <- data.frame(name2)
name2 <- gsub("tGravity", "Time gravity ", name2[, 1])
name2 <- data.frame(name2)
name2 <- gsub("Gyro", "gyroscope ", name2[, 1])
name2 <- data.frame(name2)
name2 <- gsub("Acc", "accelerometer ", name2[, 1])
name2 <- data.frame(name2)
name2 <- gsub("Mean", " mean", name2[, 1])
name2 <- data.frame(name2)
name2 <- gsub("Mag", " magnitue of signal ", name2[, 1])
name2 <- data.frame(name2)
name2 <- gsub("Jerk", " jerk of signal ", name2[, 1])
name2 <- data.frame(name2)
name2 <- gsub("fBody", "Fast fourier transform body ", name2[, 1])
name2 <- data.frame(name2)
name2 <- gsub("meanFreq", "mean frequency ", name2[, 1])
name2 <- data.frame(name2)
name2 <- gsub("Bodygyroscope", "gyroscope ", name2[, 1])
name2 <- data.frame(name2)
name2 <- gsub("  ", " ", name2[, 1])
name2 <- data.frame(name2)
name2 <- gsub("std", "standard deviation ", name2[, 1])
name2 <- data.frame(name2)
name2 <- as.matrix(name2)
 
names(merged_data) <- name2

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

  ave_data <- aggregate(merged_data[, 2:87], by=list(Category=merged_data[, "Activity name"]), FUN=mean)
  ave_data2 <- aggregate(merged_data[, 2:87], by=list(Category=merged_data[, "subject"]), FUN=mean)
 
 n <- nrow(ave_data)
  for (i in 1:n) {
  x <- ave_data[i, ]
  x <- as.data.frame(x)
 ave_data2 <- rbind(ave_data2, x)
}

tidy_data <- ave_data2

write.table(tidy_data, ".\tidy_data.txt", row.names = TRUE)
