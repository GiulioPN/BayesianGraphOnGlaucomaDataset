#### Carico dati prima visita ####
{
  #data = read.table('dataset/****.txt', header=T)
  data = read.csv('Dati1visita.csv', header=T)
}

####  Carico BDgraph ####
library(BDgraph);
#### Filtro il dataset con le variabili che ci interessano (paper AG)####
{
  data.var = data.frame(cbind(HIRWA = data$Horz_integrated_rim_width__area_,
                              Sex = data$Sex,
                              IOP = data$IOP,
                              fh = data$family_history,
                              diab = data$Diabetes,
                              YoG = data$yearofglaucoma,
                              OPP = data$OPP,
                              MD = data$MD
  ))
}

#### Let's start ####
# complete function bdgraph
bdgraph( data, 
         n = NULL, 
         method = "ggm", 
         algorithm = "bdmcmc", 
         iter = 5000, 
         burnin = iter / 2, 
         g.start = "empty", 
         g.space = NULL, 
         prior.df = 3,
         multi.update = NULL, 
         save.all = FALSE, 
         print = 1000 )
sample.bdmcmc <- bdgraph( data = data.var, 
                          method = "gcgm", 
                          iter = 200000, 
                          burnin = 150000,
                          save.all = TRUE ) 

summary(sample.bdmcmc)


#### Analisi di convergenza ####
{
  traceplot(sample.bdmcmc); #(acl = FALSE, pacf = FALSE, main = NULL)
}
