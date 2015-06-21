# CodeBook

#Background

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

#Variables

##six variables:
- object: number of volunteers, from 1 to 30
- activity: six activities, ordered: "LAYING" "SITTING" "STANDING" "WALKING" "WALKING_DOWNSTAIRS" "WALKING_UPSTAIRS"
- feature: 17 features, ordered: "tBodyAcc" "tGravityAcc" "tBodyAccJerk" "tBodyGyro" "tBodyGyroJerk" "tBodyAccMag" "tGravityAccMag" "tBodyAccJerkMag" "tBodyGyroMag" "tBodyGyroJerkMag" "fBodyAcc" "fBodyAccJerk" "fBodyGyro" "fBodyAccMag" "fBodyBodyAccJerkMag" "fBodyBodyGyroMag" "fBodyBodyGyroJerkMag"
- method: 2 method, ordered: "mean()" "std()" 
- axial: 3 axials, ordered: "X" "Y" "Z"
- meanvalue: mean value of upper levels, lentgh: 11880

11880 obeservations in different levels

#steps on tidying the dataset

1. Combine train data and test data
2. Abstract features from the method mean() and std(), nitice exclude method meanFreq()
3. Name the abstrcted data by using the feature names and activity names
4. Calculate mean value of each feature on activity level and subject value
5. Split each feature into three variables: feture, method and axial
6. Merge all the features into a long data frame.






