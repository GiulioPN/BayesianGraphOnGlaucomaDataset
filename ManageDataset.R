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
    #pazienti mancanti nel dataset
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
    }
    
    if(data[i,]$Patient == (500+t))
    {
      index = c(index,i)
      t=t+1;
    }
  }
  index
}

# numero di visite per ogni paziente
{
  rm(v.count)
  v.count = NULL
  for( i in 2:length(index)){
    diff = index[i] - index[i-1];
    v.count = c(v.count, diff);
  }
  # add last elem
  diff = 1091 - index[length(index)];
  v.count = c(v.count, diff);
}

cbind(c(1:115), v.count);

# add numero visite al dataset
{
  visite = NULL
  for( i in 1:115){
    visita_p = c(1:v.count[i])
    visite=c(visite,visita_p)
  }
  data$Visita = visite
}

# numero i pazienti in maniera opportuna da 1 a 115 
{
  n_paziente = NULL
  for( i in 1:115){
    n_paziente=c(n_paziente, rep(i,v.count[i]))
  }
  n_paziente
}

data$N_paziente = n_paziente

# rimuovo variabili inutili
{
  rm(diff)
  rm(i)
  rm(index)
  rm(n_paziente)
  rm(t)
  rm(v.count)
  rm(visita_p)
  rm(visite)
}
