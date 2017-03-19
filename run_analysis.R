library(dplyr)

#[TASK 1 & 4]

  #importing activity labels & features
  activity_labels <- read.table("~/UCI HAR Dataset/activity_labels.txt")
  features <- read.table("~/UCI HAR Dataset/features.txt")
  
  #importing training dataset & labels
  train_observations <- read.table("~/UCI HAR Dataset/train/X_train.txt",header = F)
  train_activity_labels <- read.table("~/UCI HAR Dataset/train/y_train.txt")
  train_subjects <- read.table("~/UCI HAR Dataset/train/subject_train.txt")
  
  #Assign names to header - part of task 4       
  colnames(train_observations) <- as.character(unlist(features[2]))
  colnames(train_activity_labels) <- "activity_labels"
  colnames(train_subjects) <- "subjects"
  
  #add label and subject column to test dataset
  train_dataset <- cbind.data.frame(train_subjects,train_activity_labels,train_observations)
  
  #importing testing dataset & labels
  test_observations <- read.table("~/UCI HAR Dataset/test/X_test.txt")
  test_activity_labels <- read.table("~/UCI HAR Dataset/test/y_test.txt")
  test_subjects <- read.table("~/UCI HAR Dataset/test/subject_test.txt")
  
  #Assign names to header - part of task 4       
  colnames(test_observations) <- as.character(unlist(features[2]))
  colnames(test_activity_labels) <- "activity_labels"
  colnames(test_subjects) <- "subjects"
  
  #add label and subject column to test dataset
  test_dataset <- cbind.data.frame(test_subjects,test_activity_labels,test_observations)
  
  #combine both train and test datasets
  combined_dataset <- rbind(train_dataset,test_dataset)
  
  #removing temp datasets
  rm(features)
  rm(test_activity_labels,test_dataset,test_observations,test_subjects)
  rm(train_activity_labels,train_dataset,train_observations,train_subjects)
    
#[TASK 2] - extracting mean and std deviation for each measurement
  
  #extract columns that contain mean or standard deviation for each measurement
  col_mean_or_std<-c(grep("mean|std",names(combined_dataset)))
  extracted_dataset <- combined_dataset[,c(1,2,col_mean_or_std)]
  
  #check col names
  names(extracted_dataset)
  
#[TASK 3] - naming activities in dataset
  temp_dataset <- merge(extracted_dataset,activity_labels,by.x="activity_labels",by.y="V1",all = T)
  temp_dataset <- select(temp_dataset,-(1))
  temp_dataset <- select(temp_dataset,81,1:80)
  tidy_dataset <- rename(temp_dataset, activity_labels = V2)
  rm(activity_labels,combined_dataset,extracted_dataset,temp_dataset,col_mean_or_std)
  
#[TASK 5] - calculate the mean of each variable by activity and subjects
  regrouped_dataset <- group_by(tidy_dataset,activity_labels,subjects)
  tidy_dataset2<-summarise_each(regrouped_dataset,funs(mean))
  rm(regrouped_dataset)
  
  write.table(tidy_dataset2,"~/UCI HAR Dataset/tidy_dataset.txt",row.names = F)
  
  
  
  
  
  
  
  

  
  
  
  
  
  
  