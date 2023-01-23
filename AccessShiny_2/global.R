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

# onStop(function() {
#   poolClose(pool)
# })




# donnees <- as.data.table(pool %>% tbl("cm_casmarquant") %>% head(5))

# donnees <- dbReadTable(pool, "cm_casmarquant")

# donnees <- dbGetQuery(pool, "SELECT denomination,DCI FROM cm_produits")
# donnees <- dbGetQuery(pool, "SELECT denomination,DCI FROM babibs_produits")
donnees <- dbGetQuery(pool, "SELECT denomination,DCI FROM cm_produits UNION SELECT denomination,DCI FROM babibs_produits ORDER BY denomination,DCI")
produits<-dbGetQuery(pool, "SELECT denomination,DCI FROM cm_produits UNION SELECT denomination,DCI FROM babibs_produits ORDER BY denomination,DCI")
produitsDCI<-as.data.frame(dbGetQuery(pool, "SELECT DCI FROM cm_produits UNION SELECT DCI FROM babibs_produits ORDER BY DCI"))

# testActMes<-dbGetQuery(pool, "SELECT COUNT(*) AS 'Nb', DATE_FORMAT(datePrevision,'%Y/S%u') AS 'AnneeSemaine' FROM cm_tbmesurescalendrier 
#                       WHERE cm_tbmesurescalendrier.dateMiseOeuvre IS NULL AND cm_tbmesurescalendrier.datePrevision IS NOT NULL
#                       GROUP BY DATE_FORMAT(cm_tbmesurescalendrier.datePrevision,'%Y/S%u')
#                       ORDER BY DATE_FORMAT(cm_tbmesurescalendrier.datePrevision,'%Y/S%u')")


# testActMes3<-dbGetQuery(pool, "SELECT idMesure, DATE(datePrevision) AS 'datePrev' FROM cm_tbmesurescalendrier 
# WHERE dateMiseOeuvre IS NULL AND datePrevision IS NOT NULL
# ORDER BY datePrevision"
# )

