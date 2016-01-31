##Introduction

The script run_analysis.Rperforms the 5 steps described in the course project's definition.

First, all the similar data is merged using the rbind() function. 
By similar, we address those files having the same number of columns and referring to the same entities.
Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. 
After extracting these columns, they are given the correct names, taken from features.txt.
As activity data is addressed with values 1:6, we take the activity names and IDs from activity_labels.txt and they are substituted in the dataset.
On the whole dataset, those columns with vague column names are corrected.
Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows).

##Variables

* subjecttrain, ytrain, trainx, subjecttest, ytest, testx are data from downloaded files.

* train and test are merge of the previous datasets.

* mydata is the merge of the two datasets as one dataset

* features is data from downloaded files where features2 is the transformation of features to class "character" to be used in naming the columns representing (trainx and testx)
in the new dataset.

* extract2 is the subset of the the dataset which contain only columns with the mean and standerd deviation.

* A similar approach is taken with activity names through the activities variable.

* mydata.mean is the final tidy data which contain the relevant averages required.  