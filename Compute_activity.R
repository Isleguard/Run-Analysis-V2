##################################################
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
