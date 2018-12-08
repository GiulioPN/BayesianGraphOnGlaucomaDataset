## Clear the workspace
rm(list=ls())

#____________________________________#
#       EXPLORATIVE ANALYSIS         #
#____________________________________#

#SERVE L'AUSILIO DEL FILE: "GenerateDataT1.R"

#--- Set-Up  ----
# set-up source code
{
  load_data = "~/Desktop/BProject/Rcodes/ClearData1visita.R"
  source(load_data)
}
# set-up library: ploty per i grafici
{
  library(ggplot2)
  library("gridExtra")# per i multiplot di ggplot
}
# prima di cominciare creo le classi per Age e YoG
{
  data.var$AgeClass = cut(data.var$Age, seq(20,90,10), right=FALSE)
  data.var$YoGClass = cut(data.var$yearofglaucoma, seq(0,40,5), right=FALSE)
}
# (To Do) Longitudial Explorative Analysis:
{
# libro : R graphic cook book
# sec 7.4, pag 155
# sec 4.1 pag 49
# sec 4.4 pag58
# sec 4.6, 4.7, 4.8  - from pag 58}
}

# Nella nostra analisi esplorativa le variabii che appartengono ai punti 1,2,3 verranno usate come risposte 
#  
# varaibili piu importanti per ogni categoria:
# 1. Fattori di tipo strutturali: RA, HIRWA, 
# 2. Fattori del flusso sanguigno: RI, OA, CRA TPCA NPCA
# 3. Fattori legati alla pressione:OPP (ingloba tutti gli altri ...per forza che sono correlati dc)

# per le var categoriche scegliamo Età, Sesso, Diabete e YoG

# Set up Dataset
data.m = data.frame( HIRWA = data.var$Horz_integrated_rim_width__area_,
                     IOP = data.var$IOP,
                     Sex = data.var$Sex,
                     Diabete = data.var$Diabetes,
                     Age = data.var$AgeClass,
                     Years_of_Glaucoma = data.var$YoGClass)

rm(data.var)

############ BOX POLOT #######
{
# ---- Some BoxPlot of HIWRA ----
{
  # HIRWA vs Diabete 
  
  bp_H.D = ggplot(data= data.m, aes(x=Diabete, y=HIRWA, fill = Diabete )) + geom_boxplot() +
    scale_fill_brewer(palette="Set2") +
    guides(fill=FALSE)
  bp_H.D
  
  summary(X)
  # strano perche sembrerebbe che chi ha il diabete è in condizioni migliori ( HIRWA più alto)
  # però abbiamo solo il 19 % delle persone che sono afette da diabete
  
  # HIRWA vs Age
  
  bp_H.A = ggplot(data= data.m, aes(x=Age, y=HIRWA, fill = Age )) + geom_boxplot() +
    scale_fill_brewer(palette="Dark2") +
    guides(fill=FALSE)
  bp_H.A
  
  summary(X)
  
  # HIRWA vs YoG (interessante) 
  
  X = data.var$YoGClass; X.name = "YoG"
  bp_H.YoG = ggplot(data= data.m, aes(x=Years_of_Glaucoma, y=HIRWA, fill = Years_of_Glaucoma )) + geom_boxplot() +
    scale_fill_brewer(palette="Pastel2") +
    guides(fill=FALSE) +
    xlab("Years of Glaucoma")
  bp_H.YoG
  
  summary(X)
  summary(data.var$yearofglaucoma)
  # Commenti
  {
    
  }
  
  # HIRWA vs Sesso
  
  X = data.var$Sex; X.name = "Sex"
  bp_H.Sex =  ggplot(data= data.m, aes(x=Sex, y=HIRWA, fill = Sex )) + geom_boxplot() +
    scale_fill_brewer(palette="Set1") +
    guides(fill=FALSE)
  bp_H.Sex
  summary(X)
  # 39 % Maschi 
  # 61 % Femmine 
}
  
# ---- Some BoxPlot of IOP ----
{
  # Y vs Diabete 
  X = data.var$Diabetes; X.name = "Diabete"
  bp_Iop.D = ggplot(data= data.m, aes(x=Diabete, y=IOP, fill = Diabete )) + geom_boxplot() +
    scale_fill_brewer(palette="Set2") +
    guides(fill=FALSE)
  bp_Iop.D
  summary(X)
  # strano perche sembrerebbe che chi ha il diabete è in condizioni migliori ( HIRWA più alto)
  # però abbiamo solo il 19 % delle persone che sono afette da diabete
  
  # Y vs Age
  
  X = data.var$AgeClass; X.name = "Age"
  bp_Iop.A = ggplot(data= data.m, aes(x=Age, y=IOP, fill = Age )) + geom_boxplot() +
    scale_fill_brewer(palette="Dark2") +
    guides(fill=FALSE)
  bp_Iop.A
  summary(X)
  
  # Y vs YoG (interessante) 
  
  X = data.var$YoGClass; X.name = "YoG"
  bp_Iop.YoG = ggplot(data= data.m, aes(x=Years_of_Glaucoma, y=IOP, fill = Years_of_Glaucoma )) + geom_boxplot() +
    scale_fill_brewer(palette="Pastel2") +
    xlab("Years of Glaucoma")+
    guides(fill=FALSE)
  bp_Iop.YoG
  summary(X)
  
  # Y vs Sesso
  
  bp_Iop.Sex = ggplot(data= data.m, aes(x=Sex, y=IOP, fill = Sex )) + geom_boxplot() +
    scale_fill_brewer(palette="Set1") +
    guides(fill=FALSE)
  bp_Iop.Sex
  summary(X)
  # 39 % Maschi 
  # 61 % Femmine 
  # Non c'è differenza 
  
}
# ---Plot finale: ----
grid.arrange(bp_H.Sex, bp_H.D, bp_H.YoG,
               bp_Iop.Sex, bp_Iop.D, bp_Iop.YoG ,nrow = 2)
  
}

data.m$HIRWA

p = 1#dim(response)[2] #numero di variabili risposta, IN ANOVA p=1
response = data.frame(HIRWA = data.m$HIRWA) # estraggo le variabili NON categoriche, sostituisci nome in VAR_1
#per MANOVA response = data[,1:2])
fact1 = data.m$Sex
fact2 = data[,3]

fact1.name = levels(fact1)
fact2.name = levels(fact1)

N = dim(data)[1] #numero delle osservazioni totali
n = ncol(data)  #totale variabili
g = length(levels(fact1)) #numero dei livelli del factor1 
b = length(levels(fact2)) #numero dwi livelli del factor2
fit = aov ( as.matrix(response) ~ fact1  ) 
summary(fit)

