for (i in 1:7352) {
    for (j in 1:6)  {
        if(ytrain[i,1]==atable[j,1]) {
            ytrain[i,1]<-as.character(atable[j,2])
        }
    }
} 