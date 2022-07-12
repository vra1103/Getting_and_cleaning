#Downloading the dataset
> fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
> filename <- "C:/Users/varora/Desktop/Coursera/Week4/Coursera_DS3_Final.zip"
> download.file(fileurl, filename, method="curl")

#Merges the training and the test sets to create one data set.

> subject_test <- read.table("C:/Users/varora/Desktop/Coursera/Week4/Coursera_DS3_Final/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
> x_test <- read.table("C:/Users/varora/Desktop/Coursera/Week4/Coursera_DS3_Final/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
> y_test <- read.table("C:/Users/varora/Desktop/Coursera/Week4/Coursera_DS3_Final/UCI HAR Dataset/test/y_test.txt", col.names = "code")
> subject_train <- read.table("C:/Users/varora/Desktop/Coursera/Week4/Coursera_DS3_Final/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
> x_train <- read.table("C:/Users/varora/Desktop/Coursera/Week4/Coursera_DS3_Final/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
> y_train <- read.table("C:/Users/varora/Desktop/Coursera/Week4/Coursera_DS3_Final/UCI HAR Dataset/train/y_train.txt", col.names = "code")
> XMTT <- rbind(x_train, x_test)
> YMTT <- rbind(y_train, y_test)
> Subject <- rbind(subject_train, subject_test)
> Mergedata <- cbind(Subject, YMTT, XMTT)

Extracts only the measurements on the mean and standard deviation for each measurement. 
> TidyData <- Mergedata %>% select(subject, code, contains("mean"), contains("std"))

#Uses descriptive activity names to name the activities in the data set.
> TidyData$code <- activities[TidyData$code, 2]
         
#Appropriately labels the data set with descriptive variable names. 


> names(TidyData) <- gsub("Acc", "Accelerometer", names(TidyData))
> names(TidyData) <- gsub("Gyro", "Gyroscope", names(TidyData))
> names(TidyData) <- gsub("BodyBody", "Body", names(TidyData))
> names(TidyData) <- gsub("Mag", "Magnitude", names(TidyData))
> names(TidyData) <- gsub("^t", "Time", names(TidyData))
> names(TidyData) <- gsub("^f", "Frequency", names(TidyData))
> names(TidyData) <- gsub("tBody", "Timebody", names(TidyData))
> names(TidyData) <- gsub("-mean()", "Mean", names(TidyData))
> names(TidyData) <- gsub("-std()", "STD", names(TidyData))
> names(TidyData) <- gsub("-freq()", "FREQ", names(TidyData))
> names(TidyData) <- gsub("angle", "Angle", names(TidyData))
> names(TidyData) <- gsub("gravity", "Gravity", names(TidyData))

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

> FinalData <- TidyData %>%
+     group_by(subject, activity) %>%
+     summarise_all(funs(mean))
