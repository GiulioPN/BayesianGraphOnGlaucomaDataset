## Clear the workspace
rm(list=ls())

# set in path_data the path of the dataset
path_data = "~/Desktop/BProject"
#path_code = "~/Desktop/BProject/Rcodes"
setwd(path_data)

# load function
{
  #load("~/Documents/Workspace/Rscript/mcshapiro.test.RData")
}
#load dataset
{
  #data = read.table('dataset/****.txt', header=T)
  data = read.csv('data.csv', header=T)
}

# solo prima osservazione ---> data.1
{ 
  #index = rep(0,123)
  index = NULL
  t = 1;
  for (i in 1:1090 )
  {
    if(t == 10){
      t=t+1; i = i-1;
    }
    if(t == 21){
      t=t+1; 
    }
    if(t == 47){
      t=t+1; 
    }
    if(t == 55){
      t=t+1; 
    }
    if(t == 65){
      t=t+1; 
    }
    if(t == 68){
      t=t+1; 
    }
    if(t == 115){
      t=t+2; 
    }

    if(data[i,]$Patient == (500+t))
    {
      index = c(index,i)
      t=t+1;
    }
  }
index
data.1 = data[index,]
rm(index)
rm(i)
rm(t)
}
#View(data.1) 
#write.csv(data.1, "data1.csv")

#PCA
{
  # solo var numeric
  vars.num = sapply(data.1, is.numeric)
  data.num = data.1[vars.num]
  
}
# data.var
{
  data.var = data.frame(cbind(HIRWA = data.1$Horz_integrated_rim_width__area_,
                              Sex = data.1$Sex,
                              IOP = data.1$IOP,
                              fh = data.1$family_history,
                              diab = data.1$Diabetes,
                              YoG = data.1$yearofglaucoma,
                              OPP = data.1$OPP
  ))
}

