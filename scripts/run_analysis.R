#loading library
library("plyr")

#loading data from test and train files

#Uses descriptive activity names to name the activities in the data set
#loading labels for each activity
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep = " ")
names(activity_labels) <- c("move_index","move_label")

#test and train X data are fixed width table
#width is the following
width <- c(-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15)

### Test data_set
data_test_X <- read.fwf("./UCI HAR Dataset/test/X_test.txt", width, skip=0)

data_test_Y <- read.table("./UCI HAR Dataset/test/Y_test.txt", sep = " ")
names(data_test_Y) <- "move_index"

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep = " ")
names(subject_test) <- "User_name"

#Lets join the Test data sets
#since we know "move_index" is common within the 2 datasets join from the plyr package is easier than the merge function.
moves_test <- arrange(join(data_test_Y,activity_labels),move_index)
moves_test <- cbind(subject_test,moves_test, data_test_X)

##Train data set, same pattern as for Test data set
data_train_X <- read.fwf("./UCI HAR Dataset/train/X_train.txt", width, skip=0)

data_train_Y <- read.table("./UCI HAR Dataset/train/Y_train.txt", sep = " ")
names(data_train_Y) <- "move_index"

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep = " ")
names(subject_train) <- "User_name"

#Lets join the Train data sets
moves_train <- arrange(join(data_train_Y,activity_labels),move_index)
moves_train <- cbind(subject_train,moves_train,data_train_X)

#Q1:
#Merges the training and the test sets to create one data set.
#Lets join the train and test data sets
users_moves <- rbind(moves_train, moves_test)

#Appropriately labels the data set with descriptive activity names. 
#need to label variables in users_moves
h <- c("users", "moves_ref", "move", "mean", "std", "mad", "max", "min", "sma", "energy", "iqr", "entropy", "arCoeff", "correlation", "maxInds", "meanFreq", "skewness", "kurtosis", "bandsEnergy", "angle")
names(users_moves) <- h

#Q2:
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Lets extract mean and std for the merged dataset
extract <- data.frame(users_moves$users,users_moves$move,users_moves$mean,users_moves$std)

##Second tidy data set
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##lets compute the mean of each variable for each pair of users & moves 
new_ds <- NULL
temp_mean <- ddply(users_moves, .(users,move), summarize, mean=(mean(mean)))
temp_std <- ddply(users_moves, .(users,move), summarize, mean=(mean(std)))[,3]
temp_mad <- ddply(users_moves, .(users,move), summarize, mean=(mean(mad)))[,3]
temp_max <- ddply(users_moves, .(users,move), summarize, mean=(mean(max)))[,3]
temp_min <- ddply(users_moves, .(users,move), summarize, mean=(mean(min)))[,3]
temp_sma <- ddply(users_moves, .(users,move), summarize, mean=(mean(sma)))[,3]
temp_energy <- ddply(users_moves, .(users,move), summarize, mean=(mean(energy)))[,3]
temp_iqr <- ddply(users_moves, .(users,move), summarize, mean=(mean(iqr)))[,3]
temp_entropy <- ddply(users_moves, .(users,move), summarize, mean=(mean(entropy)))[,3]
temp_arCoeff <- ddply(users_moves, .(users,move), summarize, mean=(mean(arCoeff)))[,3]
temp_correlation <- ddply(users_moves, .(users,move), summarize, mean=(mean(correlation)))[,3]
temp_maxInds <- ddply(users_moves, .(users,move), summarize, mean=(mean(maxInds)))[,3]
temp_meanFreq <- ddply(users_moves, .(users,move), summarize, mean=(mean(meanFreq)))[,3]
temp_skewness <- ddply(users_moves, .(users,move), summarize, mean=(mean(skewness)))[,3]
temp_kurtosis <- ddply(users_moves, .(users,move), summarize, mean=(mean(kurtosis)))[,3]
temp_bandsEnergy <- ddply(users_moves, .(users,move), summarize, mean=(mean(bandsEnergy)))[,3]
temp_angle <- ddply(users_moves, .(users,move), summarize, mean=(mean(angle)))[,3]

new_ds <- cbind(temp_mean, temp_std,temp_mad,temp_max,temp_min,temp_sma,temp_energy,temp_iqr,temp_entropy,temp_arCoeff,temp_correlation,temp_maxInds,temp_meanFreq,temp_skewness,temp_kurtosis,temp_bandsEnergy,temp_angle)
n <- c(names(users_moves)[1],names(users_moves)[3:length(names(users_moves))])
names(new_ds) <- n