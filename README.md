# BayesianRcodes
Bayesian Project on glaucoma dataset

**OBJ:** find a relation among variables using bayesian graphical network (ie. BDGraph)

**Files Description:**
  
  * `ManageDataset.R` : aggiunge 2 campi al dataset: Visita(per ogni paziente abbiamo il numero di visite) e n_paziente (numerazione corretta dei pazienti), la variabile Patient ha dei numeri mancanti.
  	Questo per facilitare la filtrazione al numero di visite
  * `GenerateDataT1.R`: restituisce solo data.1 (filtra i pazienti per 1a visita) 
  * `ClearData1visita.R`: elimina le variabili inutili 