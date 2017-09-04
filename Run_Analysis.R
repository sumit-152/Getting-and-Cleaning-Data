#Downloading and unzipping dataset
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Reading trainings tables:
a_train <- read.table("./data/UCI HAR Dataset/train/a_train.txt")
b_train <- read.table("./data/UCI HAR Dataset/train/b_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Reading testing tables:
c_test <- read.table("./data/UCI HAR Dataset/test/c_test.txt")
d_test <- read.table("./data/UCI HAR Dataset/test/d_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Reading feature vector:
features <- read.table('./data/UCI HAR Dataset/features.txt')

# Reading activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

# Assign column names 
colnames(a_train) <- features[,2] 
colnames(b_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(c_test) <- features[,2] 
colnames(d_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

#Merge all data in one set
mrg_train <- cbind(b_train, subject_train, a_train)
mrg_test <- cbind(d_test, subject_test, c_test)
setAllInOne <- rbind(mrg_train, mrg_test)

#Reading column names
colNames <- colnames(setAllInOne)

#Create vector for defining ID, mean and standard deviation
mean_and_std <- (grepl("activityId" , colNames) | 
                     grepl("subjectId" , colNames) | 
                     grepl("mean.." , colNames) | 
                     grepl("std.." , colNames) 
)

#Making nessesary subset from setAllInOne
setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]

# Using descriptive activity names to name the activities in the data set
setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

#Making second tidy data set
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

#Writing second tidy data set in txt file
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
