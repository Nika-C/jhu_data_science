

#### run analysis ####

# install and load libraries
if (! "data.table" %in% rownames(installed.packages())){
  install.packages("data.table")
}

if (! "dplyr" %in% rownames(installed.packages())){
  install.packages("dplyr")
}

# data.table enables fast read for flat files
library(data.table)

# dplyr enables use of pipes, grouping, summarizing
library(dplyr)


### get data ###

# set your wd
#setwd("C:/Users/martin.fridrich/Desktop/R_Data")

# if source data not downloaded, nor extracted - download
if (!("movement_data.zip" %in% list.files() | 
      "./UCI HAR Dataset" %in% list.dirs())) {
    
    download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile = "movement_data.zip")
}

# if not extracted - extract
if (!"./UCI HAR Dataset" %in% list.dirs()){
  unzip(zipfile = "movement_data.zip")
}

oldwd <- getwd()
setwd("UCI HAR Dataset")


### read data in ###

features <- fread("features.txt", col.names = c("ncol","feature_label"))
activity_labels <- fread("activity_labels.txt", col.names = c("activity_id", "activity_label"))

subject_train <- fread("train/subject_train.txt", col.names = c("subject_id"))
X_train <- fread("train/X_train.txt")
y_train <- fread("train/y_train.txt", col.names = c("activity_id"))

subject_test <- fread("test/subject_test.txt", col.names = c("subject_id"))
X_test <- fread("test/X_test.txt")
y_test <- fread("test/y_test.txt", col.names = c("activity_id"))


### merge all into one dataset ###

# merge subject and activity vecs
subject_vec <- rbind(subject_train, subject_test)
activity_vec <- rbind(y_train, y_test)

# merge measurements
measurements_df <- rbind(X_train, X_test)

# name features
colnames(measurements_df) <- features$feature_label

activity_df <- cbind(subject_id = subject_vec$subject_id,
                     activity_id = activity_vec$activity_id,
                     measurements_df)


### identify and filter appropriate measurements (mju + sd) ###

col_filter <- grepl(x = colnames(activity_df), pattern = "subject_id|activity_id|mean\\(\\)|std\\(\\)")
activity_df <- activity_df[,..col_filter]


### attach apropriate activity labels ###

activity_labels <- tolower(activity_labels$activity_label) # use snake notation
activity_df$activity_label <- activity_labels[activity_df$activity_id]


### rename features ###

colnames(activity_df) <- colnames(activity_df) %>% 
                            gsub(pattern = "^f", replacement = "freqdomain_") %>%
                            gsub(pattern = "^t", replacement = "timedomain_") %>%
                            gsub(pattern = "Acc", replacement = "_Accelerometer") %>%
                            gsub(pattern = "Gyro", replacement = "_Gyroscope") %>%
                            gsub(pattern = "Jerk", replacement = "_jerk") %>% 
  
                            gsub(pattern = "Mag", replacement = "_Magnitude") %>%
                            gsub(pattern = "Freq", replacement = "_Frequency") %>%
                            gsub(pattern = "-std()", replacement = "_standarddeviation") %>%
                            gsub(pattern = "-mean()", replacement = "_mean") %>%
                            gsub(pattern = "[()]", replacement = "") %>%
                            gsub(pattern = "-", replacement = "_") %>%
                            
                            # typo correction
                            gsub(pattern = "BodyBody", replacement = "Body")%>%
                            tolower()

# reorder df
activity_df <- activity_df[,c(1,ncol(activity_df),3:(ncol(activity_df)-1)), with =F]


### group and summarize
activity_df$activity_label <- as.factor(activity_df$activity_label)
subject_activity_mean_df <- activity_df %>%
                      group_by(subject_id, activity_label) %>%
                        summarise_all(funs(mean))


### spit it out
setwd(oldwd)

# transformed dataset
write.table(activity_df, file = "activity_df.txt",
            row.names = F)

# tidy dataset
write.table(subject_activity_mean_df, file = "subject_activity_mean_df.txt",
            row.names = F)

rm(list = ls())