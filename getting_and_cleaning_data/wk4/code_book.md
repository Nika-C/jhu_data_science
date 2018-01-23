### Code book

#### Data set
Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, authors captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen [here](https://www.youtube.com/watch?v=XOEN9W05_4A).

An updated version of this dataset can be found [here](http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions). It includes labels of postural transitions between activities and also the full raw inertial signals instead of the ones pre-processed into windows.

#### Imported files
- `features.txt`: list of all features,
- `activity_labels.txt`: links the class labels with their activity name,
- `train/X_train.txt`: training set,
- `train/y_train.txt`: training labels,
- `train/subject_train.txt`: each row identifies the subject who performed the activity for each window sample, it ranges from 1 to 30, 
- `test/X_test.txt`: test set,
- `test/y_test.txt`: test labels,
- `test/subject_test.txt`: each row identifies the subject who performed the activity for each window sample, it ranges from 1 to 30. 

#### Transformations

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation
        for each measurement.
 3. Uses descriptive activity names to name the activities in the data
    set.
 4. Appropriately labels the data set with descriptive variable names.
 5. From the data set in step 4, creates a second, independent tidy data set with the mean point estimate of each variable for each activity and each subject.

Implementation description can be found in `readme.md` file.

#### Features

The features come from the accelerometer and gyroscope 3-axial raw signals `timedomain_accelometer_xyz` and `timedomain_gyroscope_xyz`. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (`timedomain_body_accelerometer_xyz` and `timedomain_gravity_accelerometer_xyz`) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (`timedomain_body_accelerometer_jerk_xyz` and `timedomain_body_gyroscope_jerk_xyz`). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (`timedomain_body_accelerometer_magnitude`, `timedomain_gravity_accelerometer_magnitude`, `timedomain_body_accelerometer_jerk_magnitude`, `timedomain_body_gyroscope_magnitude`, `timedomain_body_gyroscope_jerk_magnitude`). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing `freqdomain_body_accelerometer_xyz`, `freqdomain_body_accelerometer_jerk_xyz`, `freqdomain_body_gyroscope_xyz`, `freqdomain_body_accelerometer_magnitude`, 
`freqdomain_body_accelerometer_jerk_magnitude`, 
`freqdomain_body_gyroscope_magnitude`, `freqdomain_body_gyroscope_jerk_magnitude` (Please note that `freqdomain` stands for frequency domain).

These signals were used to estimate variables of the feature vector for each pattern:  `_xyz` is used to denote 3-axial signals in the X, Y and Z directions.

`timedomain_body_accelerometer_xyz` 
`timedomain_gravity_accelerometer_xyz` 
`timedomain_body_accelerometer_jerk_xyz`
`timedomain_body_gyroscope_xyz` 
`timedomain_body_gyroscope_jerk_xyz`
`timedomain_body_accelerometer_magnitude`
`timedomain_gravity_accelerometer_magnitude`
`timedomain_body_accelerometer_jerk_magnitude`
`timedomain_body_gyroscope_magnitude`
`timedomain_body_gyroscope_jerk_magnitude`
`freqdomain_body_accelerometer_xyz`
`freqdomain_body_accelerometer_jerk_xyz`
`freqdomain_body_gyroscope_xyz`
`freqdomain_body_accelerometer_magnitude`
`freqdomain_body_accelerometer_jerk_magnitude`
`freqdomain_body_gyroscope_magnitude`
`freqdomain_body_gyroscope_jerk_magnitude`

The set of variables that were estimated from these signals are: 

 - `mean`: mean value, mean point estimate (calculated across subject
   and activity),  
 - `standard_deviation`: standard deviation, mean point
   estimate (calculated across subject and activity).

#### Units
Original features were measured in:

- the acceleration signal from the smartphone accelerometer X axis in standard gravity units `g`,
- the body acceleration signal obtained by subtracting the gravity from the total acceleration, 
- the angular velocity vector measured by the gyroscope for each window sample, the units are radians/second. 

Note: all measurements were normalized on scale [-1,1]. 

Source:
[UCI Machine Learning Repository: Smartphone-Based Recognition of Human Activities and Postural Transitions Data Set ](http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions)
