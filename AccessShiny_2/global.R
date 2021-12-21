library(shiny)
library(DT)
library(dplyr)
library(data.table)
library(RJDBC)
library(DBI)
library(pool)


rm(list=ls())
# load("./AccessShiny.RData")


pool <- dbPool(
  drv = RMariaDB::MariaDB(),
  dbname = "access_shiny",
  host = "127.0.0.1",
  username = "root",
  password = "root"
)

onStop(function() {
  poolClose(pool)
})




# donnees <- as.data.table(pool %>% tbl("cm_casmarquant") %>% head(5))

# donnees <- dbReadTable(pool, "cm_casmarquant")

# donnees <- dbGetQuery(pool, "SELECT denomination,DCI FROM cm_produits")
# donnees <- dbGetQuery(pool, "SELECT denomination,DCI FROM babibs_produits")
donnees <- dbGetQuery(pool, "SELECT denomination,DCI FROM cm_produits UNION SELECT denomination,DCI FROM babibs_produits ORDER BY denomination,DCI")
produits<-dbGetQuery(pool, "SELECT denomination,DCI FROM cm_produits UNION SELECT denomination,DCI FROM babibs_produits ORDER BY denomination,DCI")
produitsDCI<-dbGetQuery(pool, "SELECT DCI FROM cm_produits UNION SELECT DCI FROM babibs_produits ORDER BY DCI")
