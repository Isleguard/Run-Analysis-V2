#############################################################
#
#   Program:  Run-Analysis.R
#
#   date: 4/26/2015
#   by:   Gary Baggett
#
#   Propose:
#       To process a Sumsung data set (see info below) and to make
#       a tidy dataset from it and providing some basic analysis information
#
#   Original Dataset Description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#   Original Dataset:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
#############################################################
#   Working code
#
#   Data Reading section
#   Note: Data from site above, loaded to local pc via firefox and unzipped using 7-zip
#
#    ytrain and ytest are the label vectors for the "x" data
ytest<-read.table("./UCI HAR Dataset/test/Y_test.txt",sep=" ") 

xtest<-read.table("./UCI HAR Dataset/test/X_test.txt",nrows=2947)  # 2947 rows by 561 columns
xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt",nrows=7352) #7352 rows by 561 columns
##################################################################
#
#   read and generate the column and row labels
#
labls<-read.table("./UCI HAR Dataset/features.txt",nrows=561)
atable<-read.table("./UCI HAR Dataset/activity_labels.txt",nrows=6,sep=" ")

lv<-data.frame( t(labls))           # transpose rows,columns to get better data format
lv1<-as.vector(unname(unlist(lv[2,])))  #convert data to vector
#  now label the data tables
colnames(xtest)<-lv1                    
colnames(xtrain)<-lv1

#   Generate the row labels  file: codetest.R
for (i in 1:2947) {
    for (j in 1:6)  {
        if(ytest[i,1]==atable[j,1]) {
            ytest[i,1]<-as.character(atable[j,2])
        }
    }
}

## Merge the new labels with the data table as the row names
colnames(ytest)<-"Activity"
test<-cbind2(ytest,xtest)        # now have 562(!) columns

## do the same for the train data   file: codetest_train.R
for (i in 1:7352) {
    for (j in 1:6)  {
        if(ytrain[i,1]==atable[j,1]) {
            ytrain[i,1]<-as.character(atable[j,2])
        }
    }
}

colnames(ytrain) <-"Activity"
train<-cbind2(ytrain,xtrain)

###########################################################
# Now have two types of data: train and test
# should combine the two along the rows -->  merge data sets
###########################################################
data<-rbind2(test,train)

#we should also write it out to a file for "protection" to save steps from having to rebuild
write.table(data, file="./train_and_test.csv",sep=",",col.names=TRUE,row.names=FALSE)

############################################################
# Next Section:
#   Create output matrix, label and then stuff in values
#   process row labels and column lables.
#   column labels already exist:  Variable: lv1
#   row labels: length = 14  (dont forget the overall average and SD)
lrow<-c("walking_mean","walking_sd","walk_up_mean","walk_up_sd","walk_dn_mean","walk_dn_sd","sitting_mean","sitting_sd","standing_mean","standing_sd","laying_mean","laying_sd","total mean","total sd")

data1<-matrix(data=NA,nrow=12,ncol=561)
colnames(data1)<-lv1
rownames(data1)<-lrow

#####################################################################
## start the analysis part of the data :  file: compute_activity.R
#####################################################################
#  Generate the lists based upon the specific
#  row names for each column
##################################################

for (i in 2:ncol(data)) {  #skip 1st col as it is label
    w1<-0
    wu<-0
    wd<-0
    sit<-0
    stand<-0
    lay<-0
    #
    #  generate the list of data per column for use by the function
    #
    for(j in 1:nrow(data)) {   #create vectors of columnar data
        if(data[j,1] == "WALKING")           {w1<-c(w1,as.numeric(data[j,i]))}    
        if(data[j,1] == "WALKING_UPSTAIRS")  {wu<-c(wu,as.numeric(data[j,i]))}
        if(data[j,1] == "WALKING_DOWNSTAIRS"){wd<-c(wd,as.numeric(data[j,i]))}
        if(data[j,1] == "SITTING")           {sit<-c(sit,as.numeric(data[j,i]))}
        if(data[j,1] == "STANDING")          {stand<-c(stand,as.numeric(data[j,i]))}
        if(data[j,1] == "LAYING")            {lay<-c(lay,as.numeric(data[j,i]))}
    }
    #####################################################
    # initialize the first time creation of the vector
    
    indx<-(i-1)
    #  Walking
    data1[1,indx]<- mean(w1,na.rm=TRUE)    # mean
    data1[2,indx]<- sd(w1,na.rm=TRUE)      # standard dev
    #  Walking upstairs
    data1[3,indx]<- mean(wu,na.rm=TRUE)
    data1[4,indx]<- sd(wu,na.rm=TRUE)
    #  walking downstairs
    data1[5,indx]<- mean(wd,na.rm=TRUE)
    data1[6,indx]<- sd(wd,na.rm=TRUE)
    #  sitting
    data1[7,indx]<- mean(sit,na.rm=TRUE)
    data1[8,indx]<- sd(sit,na.rm=TRUE)
    #  standing
    data1[9,indx]<-  mean(stand,na.rm=TRUE)
    data1[10,indx]<- sd(stand,na.rm=TRUE)
    #  laying
    data[11,indx]<- mean(lay,na.rm=TRUE)
    data[12,indx]<- sd(lay,na.rm=TRUE)
    
}
####################################################################
#   Now compute the final two rows which contain the average and sd
#   for the whole dataset
####################################################################
#  Compute total mean and sd from samples values

for (i in 2:562) {
    indx<-(i-1)
    data1[13,indx]<-mean(as.numeric(data[,i]))    #mean
    data1[14,indx]<-sd(as.numeric(data[,i]))     #standard dev.
}


####################################################################
#  Finally, write out the file
####################################################################

write.table(data1,"tidy.txt",sep=",",col.names=TRUE,row.names=FALSE)







