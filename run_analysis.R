
## prepare file names:
# main directory		
maindir <- "C:/Courses/R/Project"
setwd(maindir)
#all train, test subj file names
traindir <- paste(maindir,"/train",sep="")
testdir <- paste(maindir,"/test",sep="")
subjtrain <- paste(traindir, "/subject_train.txt",sep="")
subjtest <- paste(testdir, "/subject_test.txt",sep="")
xtrain <- paste(traindir, "/X_train.txt",sep="")
xtest <- paste(testdir, "/X_test.txt",sep="")
ytrain <- paste(traindir, "/Y_train.txt",sep="")
ytest <- paste(testdir, "/Y_test.txt",sep="")

#feature file name
features <-paste(maindir,"/features.txt",sep="")

#activity labels file name
activity_labels <-paste(maindir,"/activity_labels.txt",sep="")


##reading data

#read features and activity labels

Featuresdata <-read.table(features)
ALabelsdata <-read.table(activity_labels)

#read train files

Xdatatrain <- read.table(xtrain)		
Subjdatatrain <- read.table(subjtrain)
Labelsdatatrain <- read.table(ytrain)

#convert train data subject and labels to factors

Labelsdatatrain <- as.factor( c(do.call("cbind",Labelsdatatrain)) )
Subjdatatrain <- as.factor( c(do.call("cbind",Subjdatatrain)) )

#read test files

Xdatatest <- read.table(xtest)		
Subjdatatest <- read.table(subjtest)
Labelsdatatest <- read.table(ytest)

#convert test data subject and labels to factors

Labelsdatatest <- as.factor( c(do.call("cbind",Labelsdatatest)) )
Subjdatatest <- as.factor( c(do.call("cbind",Subjdatatest)) )

##merge the files


Datatrain <- cbind(Subjdatatrain, Xdatatrain, Labelsdatatrain)				                    
colnames(Datatrain) <- c("Subject", as.character(Featuresdata[,2]), "ActivityLabel")	  

Datatest <- cbind(Subjdatatest, Xdatatest, Labelsdatatest)					                      
colnames(Datatest) <- c("Subject", as.character(Featuresdata[,2]), "ActivityLabel")	    


## Merges the training and the test sets to create one data set.
Dataset <- rbind(Datatrain,Datatest)

##extract meand and std

meantitles <-  which(grepl("mean()",colnames(Dataset)))		
stdtitles <- which(grepl("std()", colnames(Dataset)))		

StdMeanColnames <- colnames(Dataset[,sort(c(meantitles, stdtitles))])

Colnames <- c("Subject","ActivityLabel",StdMeanColnames)

StdMeanDataset  <- Dataset[, Colnames]		
head(StdMeanDataset)
		
##handle activity label
				
StdMeanDataset$ActivityLabel <- as.character(ALabelsdata[,2])[StdMeanDataset$ActivityLabel]

#meaningful names

colnames(StdMeanDataset) <- gsub("mean\\(\\)", "MeanValue", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("std\\(\\)", "SandardDeviation", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("mad\\(\\)", "MedianAbsoluteDeviation", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("max\\(\\)", "MaxInArray", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("min\\(\\)", "MinInArray", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("sma\\(\\)", "SignalMagnitudeArea", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("energy\\(\\)", "EnergyMsmt", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("iqr\\(\\)", "InterquartileRange", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("entropy\\(\\)", "SignalEntropy", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("arCoeff\\(\\)", "AutorregresionCoefficients", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("correlation\\(\\)", "Correlation", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("maxInds\\(\\)", "MaxInds", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("maxInds", "MaxMagnutudeIndex", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("meanFreq\\(\\)", "MeanFreq", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("skewness\\(\\)", "Skewness", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("kurtosis\\(\\)", "Kurtosis", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("bandsEnergy\\(\\)", "BandsEnergy", colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("\\-", "",  colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("\\(", "",  colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub("\\)", "",  colnames(StdMeanDataset))
colnames(StdMeanDataset) <- gsub(",", "",  colnames(StdMeanDataset))

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
require(reshape2)
MeltStdMeanDataset <- melt(StdMeanDataset,id=c("Subject","ActivityLabel"),measure.vars=colnames(StdMeanDataset[,3:length(StdMeanDataset)]))
TidyDataset <- dcast(MeltStdMeanDataset,Subject + ActivityLabel ~ variable,mean)

#head(TydiDataset)

## Write the following objects to files:
write.table(TidyDataset,"TidyDataset.txt", sep="\t")

	

		



