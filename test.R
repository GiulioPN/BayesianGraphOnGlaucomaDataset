install.packages("BDgraph")
library("BDgraph")
# set-up source code
{
  load_data = "~/Desktop/BProject/Rcodes/00_loadData.R"
  name_file = "Ker_file"
  source(load_data)
}
data$Horz_integrated_rim_width__area_
data$MD
data$Sex
data$IOP
data$family_history
data$Diabetes
data$yearofglaucoma
data$OPP
#seleziono solo alcune variabili
data.var = data.frame(cbind(HIRWA = data.1$Horz_integrated_rim_width__area_,
                            Sex = data.1$Sex,
                            IOP = data.1$IOP,
                            fh = data.1$family_history,
                            diab = data.1$Diabetes,
                            YoG = data.1$yearofglaucoma,
                            OPP = data.1$OPP
                            ))

#### let's start ####
# burnin: mcmc che vengono eliminare nnelle iterazioni
sample.bdmcmc <- bdgraph( data = data.var, method = "gcgm", iter = 200000, burnin = 150000 )
summary( sample.bdmcmc )

traceplot( sample.bdmcmc, acf = TRUE, pacf = TRUE )

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


