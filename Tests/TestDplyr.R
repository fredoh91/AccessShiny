library(shiny)
library(DT)
library(dplyr)
library(data.table)
library(RJDBC)
library(DBI)
library(pool)

produits_1<-dplyr::select(CM_Produits,denomination,DCI)
produits_2<-dplyr::select(Babibs_Produits,denomination,DCI)
produits<-dplyr::union(produits_1,produits_2)
produits<-dplyr::arrange(produits,denomination)
rm('produits_1','produits_2')

produits_1<-dplyr::select(CM_Produits,DCI)
produits_2<-dplyr::select(Babibs_Produits,DCI)
produits<-dplyr::union(produits_1,produits_2)
produitsDCI<-dplyr::arrange(produits,DCI)
rm('produits_1','produits_2')

# dplyr::mutate(CM_CasMarquant,TypeSignal="CM")

#test<-dplyr::union()
# mutate(CM_CasMarquant,TypeSignal="CM")
# test <-  select(Babibs_Produits,denomination,DCI,IdSignal) %>% inner_join(Babibs_TbSignal, Babibs_TbBiblio, by = "IdSignal") %>% filter (Babibs_Produits$denomination %in% c("ADALIMUMAB ((MAMMIFERE/HAMSTER/CHO))","ADALIMUMAB"))
# 
# test <- Babibs_Produits %>% inner_join(Babibs_TbSignal, Babibs_TbBiblio, by = "IdSignal") 

rm(test)

test <- select(Babibs_Produits,denomination,DCI,IdSignal) %>% inner_join(select(Babibs_TbSignal,IdSignal,NumSignal), by = "IdSignal") %>% inner_join(select(Babibs_TbBiblio,IdSignal,IdBiblio), by = "IdSignal") %>% mutate(TypeSignal="Biblio") %>% rename("NumCRPV/NumSignal" = "NumSignal") %>% filter (denomination %in% c("ADALIMUMAB ((MAMMIFERE/HAMSTER/CHO))","ADALIMUMAB"))



test <- select(CM_Produits,denomination,DCI,idCas) %>%
  inner_join(select(CM_CasMarquant,idCas,numeroCRPV), by = "idCas") %>%
  mutate(TypeSignal="CM") %>%
  rename("NumCRPV/NumSignal" = "numeroCRPV","Id" = "idCas") %>%
  filter (denomination %in% c("ABILIFY","ABILIFY 1 mg/ml, solution buvable"))



test <-       select(Babibs_Produits,denomination,DCI,IdSignal) %>%
  inner_join(select(Babibs_TbSignal,IdSignal,NumSignal), by = "IdSignal") %>%
  inner_join(select(Babibs_TbBiblio,IdSignal), by = "IdSignal") %>%
  mutate(TypeSignal="Biblio") %>%
  rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") %>%
  filter (denomination %in% c("ADALIMUMAB","ADALIMUMAB ((MAMMIFERE/HAMSTER/CHO))"))


pool <- dbPool(
  drv = RMariaDB::MariaDB(),
  dbname = "access_shiny",
  host = "127.0.0.1",
  username = "root",
  password = "root"
)
rm(produits,produitsDCI)
produits<-dbGetQuery(pool, "SELECT denomination,DCI FROM cm_produits UNION SELECT denomination,DCI FROM babibs_produits ORDER BY denomination,DCI")
produitsDCI<-dbGetQuery(pool, "SELECT DCI FROM cm_produits UNION SELECT DCI FROM babibs_produits ORDER BY DCI")

test<-dbGetQuery(pool, "SELECT cm_produits.denomination,cm_produits.DCI,cm_produits.idCas,cm_casmarquant.numeroCRPV,'CM' AS TypeSignal FROM cm_produits INNER JOIN cm_casmarquant ON cm_produits.idCas = cm_casmarquant.idCas")




test <- union_all (select(CM_Produits,denomination,DCI,idCas) %>%
  inner_join(select(CM_CasMarquant,idCas,numeroCRPV), by = "idCas") %>%
  mutate(TypeSignal="CM") %>%
  rename("NumCRPV/NumSignal" = "numeroCRPV","Id" = "idCas") %>%
  filter (denomination %in% c("ABILIFY","ABILIFY 1 mg/ml, solution buvable")),
        select(Babibs_Produits,denomination,DCI,IdSignal) %>%
  inner_join(select(Babibs_TbSignal,IdSignal,NumSignal), by = "IdSignal") %>%
  inner_join(select(Babibs_TbBiblio,IdSignal), by = "IdSignal") %>%
  mutate(TypeSignal="Biblio") %>%
  rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") %>%
  filter (denomination %in% c("ADALIMUMAB","ADALIMUMAB ((MAMMIFERE/HAMSTER/CHO))")))
