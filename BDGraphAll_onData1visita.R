#____________________________________#
#       BDGraph on all data          #
#____________________________________#

#SERVE L'AUSILIO DEL FILE: "GenerateDataT1.R"

#--- Set-Up  ----
# set-up source code
{
  load_data = "~/Desktop/BProject/Rcodes/ClearData1visita.R"
  source(load_data)
}
# Carico BDgraph
library(BDgraph)

#--- Set-Up  ----
# set-up source code
{
  load_data = "~/Desktop/BProject/Rcodes/GenerateDataT1.R"
  source(load_data)
}

#----- Manage the dataset 1a visita -----

# var eliminate PER IL DATASETx 1a VISITA (alcune potrebbero venire utili dopo)
{
  # si eliminano le variabili in coda così l'oridine delle colonne non cambia
  
  data.var = data.1[,-c(209:212)] # progression vars -----da riaggiungere poi
  
  data.var = data.var[,-c(206:198)] # categorical var -----forse da riaggiungere
  
  data.var = data.var[,-c(194:188)] # Variabili che riguardano blood flow: TUTTE NA
  
  data.var = data.var[,-c(162:186)]# rnfl + patient_ID + mac vars: TUTTE NA
  
  data.var = data.var[,-143] # progress var
  
  data.var = data.var[,-134] # USELESS COMMENT:  
  
  data.var = data.var[,-c(130:123)] # macular_thickness -----forse da riaggiungere
  
  data.var = data.var[,-c(121:117)] # RFNL -----forse da riaggiungere
  
  data.var = data.var[,-c(114:115)]# altre progress var -----da riaggiungere poi
  
  data.var = data.var[,-106] # USELESS COMMENT:: FieldsComment  
  
  data.var = data.var[,-97] # USELESS COMMENT: MissingDataExplanation  
  
  data.var = data.var[,-c(95:84)] # variabili in quantili ---bho?
  
  data.var = data.var[,-83] # USELESS COMMENT: CDIcomments
  
  data.var = data.var[,-69] # 2a visita
  
  data.var = data.var[,-c(68:64)] # empty vars
  
  data.var = data.var[,-c(44:40)] # variabili CS (non so a cosa si rifericano): TUTTE NA
  
  data.var = data.var[,-37]# USELESS COMMENT: QuestionnaireComments               
  
  data.var = data.var[,-34] # color
  
  data.var = data.var[,-c(23:19)] # CATEGORICAL var ---forse da riaggiungere
  
  data.var = data.var[,-18] # USELESS COMMENT: Comment
  
  data.var = data.var[,-13] #Other_systemic_dz_1  (SEMPRE VUOTA)
  
  data.var = data.var[,-1] # numero paziente
}

data = data.var
data.var = data.frame(cbind(HIRWA = data$Horz_integrated_rim_width__area_,
                            MAP = data$MAP,
                            IOP = data$IOP,
                            HR = data$HR,
                            OAsys = data$OAsys,
                            OAdys = data$OAdys,
                            CRAsys = data$CRAsys,
                            CRAdys = data$CRAdys,
                            NPCAsys = data$NPCAsys,
                            NPCAdys = data$NPCAdys,
                            TPCAsys = data$TPCAsys,
                            TPCAdys = data$TPCAdys,
                            RNFLmean = data$mean_RNFL_thickness,
                            MD = data$MD
))
#### Let's start ####
sample.bdmcmc <- bdgraph( data = data.var, 
                          method = "gcgm", 
                          iter = 200000, 
                          burnin = 150000,
                          save.all = TRUE ) 


summary(sample.bdmcmc)
select(sample.bdmcmc, vis = 1)
sample.bdmcmc
# Save a single object to a file
saveRDS(sample.bdmcmc, "sample.bdmcmc.rds")
# Restore it under a different name
my_data <- readRDS("sample.bdmcmc.rds")
