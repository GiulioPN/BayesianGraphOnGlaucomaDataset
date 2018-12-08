## Clear the workspace
rm(list=ls())

#____________________________________#
#       MANAGE 1A VISTA DATASET      #
#____________________________________#

#SERVE L'AUSILIO DEL FILE: "GenerateDataT1.R"

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
#tolgo variabili dall'envairoment
rm(i)
rm(index)
rm(t)
#tolgo dataset dall'envairoment
rm(data)
rm(data.1)
#---- NA Counting ----
N.A= rep(0,114)
for (i in 1:114 ){
  N.A[i] = sum(is.na(data.var[,i]))
}
# COLONNE CON PIU DI 100 NA
N.A
cbind(which( N.A > 50 ))


# --- ELIMINO CAMPI CON + DEL 30% DI NA ----
data.var = data.var[,-c(45:47)]


#---- VIF ===> studio della collinearità----
#install.packages("faraway")
library("faraway")

vars.num = sapply(data.var, is.numeric)
data.num = data.var[vars.num]
rm(data.var)

# gruppo delle variabili riguardanti Pressione Arteriosa
{
  X = data.num[,c(16:21)]
  vif(X[,-5])
  # tolgo BPSYS .. collinearità: seleziono OPA    IOP      CCT    BPSYS      MAP 
}
# gruppo delle variabili MD: scelgo baselineMD 
{
  X = cbind(data.num$MD,data.num$BaselineMD)
  vif(X)
}
# Elimino Age65 vs Age
{}
# disc_area vs disk_Area
{
  X = cbind(data.num$disc_area,data.num$cup_disc_area_ratio)
  vif(X) 
}
# TPCA vars ==> scelgo TPCAri?? cosa sarebbe?
{
  X = data.num[,c(42:44)]
  vif(X) 
}
# 


          