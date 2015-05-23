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
