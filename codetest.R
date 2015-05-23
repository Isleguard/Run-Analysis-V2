for (i in 1:2947) {
    for (j in 1:6)  {
        if(ytest1[i,1]==atable[j,1]) {
            ytest1[i,1]<-as.character(atable[j,2])
        }
    }
} 