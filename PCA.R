## Clear the workspace
rm(list=ls())

#_________________#
#       PCA       #
#_________________#

#SERVE L'AUSILIO DEL FILE: "ClearData1visita.R"

#--- Set-Up  ----
# set-up source code
{
  load_data = "~/Desktop/BProject/Rcodes/ClearData1visita.R"
  source(load_data)
}
# set-up library: ploty per i grafici
{
  library("plotly")
  library("gridExtra")# per i multiplot di ggplot
}

#----- Manage the dataset 1a visita -----

# Seleziono solo var numeriche non categoriche (pca funziona solo con var num!!)
{
  # solo  numeric
  vars.num = sapply(data.var, is.numeric)
  data.num = data.var[vars.num]
}
# elimino dataset salvati che non servono alla fine dell'analisi
{
rm(data.1)
rm(data.var)
}

#------ PCA -------
# set dataset e parametri for the PCA
{
  data.pca = data.num
  rm(data.num) # impostato il dataset non serve piu quello precedente
  namesVar = names(data.pca)
  toll = 0.05 # tolleranza per selezionare le var con influenza maggiore
}

pca = prcomp(na.omit(data.pca),center = T, scale = T)
summary(pca)

# plot PoV (proportion of variance) 
plot(pca, type = "l")

# le pc assumono valori simili: nessuna evidenzia un peso significativo

#Plot PC 1st: grafico delle var con maggiore influenza nella 1a PCA
{
  index = 1 # indica che che plottiamo solo la 1a pc
  loading = pca$rotation[,index] # variabile dei pesi per ogni var
  dataframe <- as.data.frame(loading[which(loading^2 > toll)])
  names(dataframe) <-  "loads"
  # plot usando ploty
  Colored_by <- names(data.pca[which(loading^2 > toll)])
  plot.load <- ggplot(data = dataframe , aes(x = names(data.pca[which(loading^2 > toll)]), y=dataframe$loads^2, fill =Colored_by)) + geom_bar(stat = "identity", colour = "black")
  plot.load <- plot.load + ylab("Loadings (L2 norm)") + xlab("Original variables")
  plot.load <- (  plot.load + ggtitle(paste("Principal Component",as.character(index),sep = " "))
                  + theme(plot.title = element_text(lineheight=.8, face="bold", hjust = 0.5)) 
                  + scale_fill_discrete(name="LEGEND", breaks=names(data.pca),labels=namesVar) 
  ) 
  plot.load
}
# final comments
{
  # l'analisi sulla 1a pc non ci porta a nulla: nessuan variabile evidenzia un'effettiva importanza
  # inoltre anche tra le varie principal components non c'è ne una significativa (vedi plot PoV)
}

########## ggplot PoV Plot #########
# PoV
{
pca 
eigs <- pca$sdev^2
eigs[1] / sum(eigs)
eigs[2] / sum(eigs)

pca.complete = rbind(
  SD = sqrt(eigs),
  Proportion = eigs/sum(eigs),
  Cumulative = cumsum(eigs)/sum(eigs))

pc.PoV = data.frame( PCs = c(1:5),
            PoV = pca.complete[2,(1:5)]) # solo le prime 10 PCs

pca.plot = ggplot(pc.PoV, aes(x=PCs,y=PoV )) + 
          geom_line(color='steelblue',size=1) + geom_point(size=2) + xlab("Principal Components") + ylab("Propotion of Variance") +
          ggtitle(paste("PCA")) 
pca.plot
}

#--- Combine the plots ----

grid.arrange(pca.plot,plot.load,ncol = 2)

