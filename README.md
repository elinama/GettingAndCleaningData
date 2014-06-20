# Elina Maliarsky #

[Source of original data:](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


## The data ##

- 'activity_labels.txt': Associates the class labels with their activity name accordingly.
- 'features.txt': List of all features

### Training Data ###
- 'subject_train.txt': Training subject's identification. Ranges from 1 to 30. 
- X_train.txt': Training set 
-'y_train.txt': Training labels 

### Test Data ###
- 'subject_test.txt': Test subject's identification. Ranges from 2 to 24. 
- 'X_test.txt': Test set 
- 'y_test.txt': Test labels 

For additional information on the contents contained within each file, please refer to the following file: 'README.txt'

## GETTING AND CLEANING DATA PROCEDURE, STEP 0: Setup and read data ##
1. Set up the main data path and the data pathes to all the files
2. Read the content of all the files above: activity, features, train and test files 

## GETTING AND CLEANING DATA PROCEDURE, STEP 1: Combine together ##
### Combines all files to form one data set ###

1. Merge all train files: 7532 rows, 563 columns
2. Merge all test files: 2947 rows, 563 columns
3. Merge train and test sets together: 10299 rows, 563 columns

## GETTING AND CLEANING DATA PROCEDURE, STEP 2: Extract mean and std columns ##

1. Extracts all titles containing 'mean()' string, 46 variables
2. Extracts all titles containing 'std()' string, 33 variables
3. Extract 'subject' and 'activity_label' 

Tidy data set contains 81 variables

## GETTING AND CLEANING DATA PROCEDURE, STEP 3: Handle activity labels
Replaces the name value of label by string:
1. 1 WALKING
2. 2 WALKING_UPSTAIRS
3. 3 WALKING_DOWNSTAIRS
4. 4 SITTING
5. 5 STANDING
6. 6 LAYING

## GETTING AND CLEANING DATA PROCEDURE, STEP 4: Meaningful names

One by one replacing of variable names by more meaningful

## GETTING AND CLEANING DATA PROCEDURE, STEP 5: Create tidy data set

Resulting data set: 180 rows, 81 columns

'melt' and 'dcast' commands are used
























