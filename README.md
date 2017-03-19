# Getting_and_Cleaning_Data
R Script for Getting and Cleaning Data Assignment

Things to note before running this script.

	Make sure that the Samsung datasets are located in the working directory. Otherwise the script will not work.
	Files utilised by this script:
		
		Located in main folder: (/UCI HAR Dataset)
		file 1 - activity_labels.txt
		file 2 - features.txt
		
		Located in train sub folder: (/UCI HAR Dataset/train)
		file 3 - X_train.txt
		file 4 - y_train.txt
		file 5 - subject_train.txt
		
		Located in test sub folder: (/UCI HAR Dataset/test)
		file 6 - X_test.txt
		file 7 - y_test.txt
		file 8 - subject_test.txt

How the script works:

	1 - Load 'dplyr' package and import 2 global files from the main folder
			- file 1 - activity_labels = list of activities undertaken by subjects (between 1 and 6)
			- file 2 - features = descriptive label for recordings undertaken (column names for file 3)
			
	2 - Import 3 files from main train folder
			- file 3 - observations from train 
			- file 4 - type of activities undertaken for each observation (between 1 and 6)
			- file 5 - list of participants, who undertook the activities (aka subjects)

	3 - Assign column names to files 3, 4 & 5
			- For file 3, the col headers are assigned based on the file 2
			- For files 4 and 5, the column headers will be assigned "activity_labels" and "subjects" respectively
			Check - The resulting dataset should have 7,352 observations with 563 variables.
			
	4 - Create a train dataset by merging files 3, 4 and 5 using cbind.  
		
	5 - Steps 2, 3 and 4 are repeated to create a combined test dataset. Below are the files used by the scrip
			- file 6 - observations from test
			- file 7 - type of activities undertaken for each observation (between 1 and 6)
			- file 8 - list of participants, who undertook the activities (aka subjects)
			Check - The resulting dataset should have 2,947 observations with 563 variables.			
			
	6 - Combined dataset is created by merging the train and test datasets using rbind. 
		Check - The resulting dataset should have 10,299 observations with 563 variables. 
	
	7 - Temporary files removed to free up space. 
	
	8 - Using grep, a temporary dataset called "extracted dataset" is created by subsetting columns where calculation of mean or standard deviation has been undertaken. 
		The first two variables "activity_labels" and "subjects" are retained in this dataset.
		Note that variables with 'Freqmean' as part of their description are also extracted as mean.
		Check - The resulting dataset should have 10,299 observations with 81 variables.		
		
	9 - Using merge, the labels for activities (file 1) are added to "extracted dataset". The data set is then renamed "temp_dataset".
	
	10- Using select, the variables in "extracted dataset" are re-arranged so that the descriptive activity labels comes first and followed by 'subjects'
		The variable with normalised activity labels is dropped from the dataset.
		The variable with descriptive activity labels is then renamed as "activity labels"
		The temporary dataset is then renamed as "tidy_dataset"
		All other temporary datasets removed to free up space.
		Check - The resulting dataset should have 10,299 observations with 81 variables.
				
	11- To calculate the mean for each variable by activity and subjects, group_by function is used to rearranged the tidy dataset.
		This dataset is renamed as regrouped_dataset
		Using summarise_each, mean for each variable is calculated by activity and by subjects (participants)
		The final dataset is named "tidy_dataset2"
		Check - The resulting dataset should have 180 observations with 81 variables. (sense check = 6 activities x 30 participants)
		
Codebook
	
	Introduction:
	The dataset "tidy_dataset2" shows the average values of mean (including freqmean) and standard deviation calculated based on test observations on 6 various physical activities undertook by 30 participants while wearing a Samsung2. 

	Detailed based on readme from the original datasets:
	The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
	Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
	Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
	The experiments have been video-recorded to label the data manually. 
	The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

	Variables explained:
	(Extract from the supplementary file accompanying the original dataset)
	
	The vaiables selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
	These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
	Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
	Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ),
	using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

	Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 
	Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

	Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. 
	(Note the 'f' to indicate frequency domain signals). 

	These signals were used to estimate variables of the feature vector for each pattern:  
	'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

	tBodyAcc-XYZ
	tGravityAcc-XYZ
	tBodyAccJerk-XYZ
	tBodyGyro-XYZ
	tBodyGyroJerk-XYZ
	tBodyAccMag
	tGravityAccMag
	tBodyAccJerkMag
	tBodyGyroMag
	tBodyGyroJerkMag
	fBodyAcc-XYZ
	fBodyAccJerk-XYZ
	fBodyGyro-XYZ
	fBodyAccMag
	fBodyAccJerkMag
	fBodyGyroMag
	fBodyGyroJerkMag

	The set of variables that were estimated from these signals are: 
	mean(): Mean value
	std(): Standard deviation
	meanFreq(): Weighted average of the frequency components to obtain a mean frequency	
	
	Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

	gravityMean
	tBodyAccMean
	tBodyAccJerkMean
	tBodyGyroMean
	tBodyGyroJerkMean