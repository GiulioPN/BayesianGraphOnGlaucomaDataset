## Clear the workspace
rm(list=ls())

#____________________________________#
#       SET 1A VISTA DATASET         #
#____________________________________#

#SERVE L'AUSILIO DEL FILE: "ManageDataset.R"

#--- Set-Up  ----
# set-up source code
{
  load_data = "~/Desktop/BProject/Rcodes/ManageDataset.R"
  source(load_data)
}

# dati prima visita, per la seconda basta cambiare il valore 
data.1 = data[which(data$Visita == 1),]


