## Clear the workspace
rm(list=ls())

#__________________________________________________#
#       DIVISIONE DELLE VARIABILI PER FATTORE      #
#__________________________________________________#

#SERVE L'AUSILIO DEL FILE: "GenerateDataT1.R"

#--- Set-Up  ----
# set-up source code
{
  load_data = "~/Desktop/BProject/Rcodes/GenerateDataT1.R"
  source(load_data)
}
#--- CRITERIO DI DIVISIONE ----

# il Glaucoma generalmente è causato o caraterrizzato da fattori di natura diversa:
# 1. Fattori di tipo strutturali (misure del disco ottico)
# 2. Fattori del flusso sanguigno (velocità )
# 3. Fattori legati alla pressione
# 4. Fattori legati alla persona (sesso, razza, diabete...)

# Nella nostra analisi esplorativa le variabii che appartengono ai punti 1,2,3 verranno usate come risposte 
#  
# varaibili piu importanti per ogni categoria:
# 1. RA, HIRWA, 
# 2. RI, OA, CRA TPCA NPCA
# 3. OPP (ingloba tutti gli altri ...per forza che sono correlati dc)

summary(data.var$AGIS_score)
