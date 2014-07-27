## If file doesn't exist, download, unzip
if(!file.exists("./getdata")){dir.create("./getdata")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./getdata/data.zip",mode="wb")
unzip("./getdata/data.zip",exdir="./getdata")


## Load training and test sets
trainingFile <- "./getdata/UCI HAR Dataset/train/X_train.txt"
testFile <- "./getdata/UCI HAR Dataset/test/X_test.txt"
featuresFile <- "./getdata/UCI HAR Dataset/features.txt"
trainingFactorsFile <- "./getdata/UCI HAR Dataset/train/Y_train.txt"
testFactorsFile <- "./getdata/UCI HAR Dataset/test/Y_test.txt"
trainingSubjectsFile <- "./getdata/UCI HAR Dataset/train/subject_train.txt"
testSubjectsFile <- "./getdata/UCI HAR Dataset/test/subject_test.txt"
activityLabelsFile <- "./getdata/UCI HAR Dataset/activity_labels.txt"

featuresData <- read.table(featuresFile,col.names=c("colnum","measurement_name"))
trainingData <- read.table(trainingFile)
testData <- read.table(testFile)
names(trainingData) <- featuresData$measurement_name
names(testData) <- featuresData$measurement_name
trainingFactors <- read.table(trainingFactorsFile,col.names="activity_id")
testFactors <- read.table(testFactorsFile,col.names="activity_id")
trainingSubjects <- read.table(trainingSubjectsFile,col.names="subject_id")
testSubjects <- read.table(testSubjectsFile,col.names="subject_id")
activityLabels <- read.table(activityLabelsFile,col.names=c("id","activity_name"))


## Add activity ids to trainingData and merge with activities
trainingData <- cbind(trainingData,trainingFactors,trainingSubjects)
trainingData <- merge(trainingData,activityLabels,by.x="activity_id",by.y="id")
trainingData <- subset(trainingData, select = -activity_id)


## Add activity ids to testData and merge with activities
testData <- cbind(testData,testFactors,testSubjects)
testData <- merge(testData,activityLabels,by.x="activity_id",by.y="id")
testData <- subset(testData, select = -activity_id)


## Combine trainingData with testData
fullData <- rbind(trainingData,testData)


## Filter for activity_name, subject_id, means, and stds
limitedData <- fullData[grep("mean\\(\\)|std\\(\\)|activity_name|subject_id",names(fullData))]


## Averages for each activity and subject
meltedData <- melt(limitedData,id=c("subject_id","activity_name"))
averageData <- dcast(meltedData, activity_name + subject_id ~ variable, mean)


##Write averageData to tidydata.txt file
write.table(averageData,"./getdata/tidyData.txt",row.names=FALSE)