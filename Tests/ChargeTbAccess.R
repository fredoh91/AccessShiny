library(RODBC)
library(data.table)

rm(list=ls())


CM_access<-odbcDriverConnect("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=D:/Users/Frannou/Dev/Access/CM/Dev_CSP/DATA/CM_be.accdb")
CM_CasMarquant <- setDT(sqlFetch(CM_access, "CasMarquant"))
CM_Produits <- setDT(sqlFetch(CM_access, "Produits"))
CM_IntervenantCM <- setDT(sqlFetch(CM_access, "IntervenantCM"))
CM_TbMesuresCalendrier <- setDT(sqlFetch(CM_access, "TbMesuresCalendrier"))
CM_Historique <- setDT(sqlFetch(CM_access, "Historique"))


Babibs_access<-odbcDriverConnect("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=D:/Users/Frannou/Dev/Access/BaseBiblioMesusage/DATA/baBibS_data.accdb")



Babibs_Historique <- setDT(sqlFetch(Babibs_access, "TbStatutBiblioMesusage"))
Babibs_Produits <- setDT(sqlFetch(Babibs_access, "Produits"))
Babibs_TbBiblio <- setDT(sqlFetch(Babibs_access, "TbBiblio"))
Babibs_TbSignal <- setDT(sqlFetch(Babibs_access, "TbSignal"))
Babibs_TbMesusage <- setDT(sqlFetch(Babibs_access, "TbMesusage"))
Babibs_TbMesuresBiblioMes <- setDT(sqlFetch(Babibs_access, "TbMesuresBiblioMes"))
Babibs_TbMesuresBiblioMes_labo <- setDT(sqlFetch(Babibs_access, "TbMesuresBiblioMes_labo"))
# Babibs_RqSignalEnRapport <- setDT(sqlFetch(Babibs_access, "RqSignalEnRapport"))


odbcCloseAll()



class(CasMarquant)
