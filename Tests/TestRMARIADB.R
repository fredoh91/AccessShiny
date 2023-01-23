library(RJDBC)
library(DBI)
library(pool)

pool <- dbPool(
  drv = RMariaDB::MariaDB(),
  dbname = "access_shiny",
  host = "127.0.0.1",
  username = "root",
  password = "root"
)
# dbListTables(pool)
# drv<- RJDBC::JDBC("org.mariadb.jdbc.Driver",
#                   classPath = system.file("java/mariadb-java-client-2.7.0.jar"
#                                           ,package="Rpgs")
# )
# con <- RJDBC::dbConnect(drv, "jdbc:mariadb://127.0.0.1:3306/access_shiny",
#                         "root", "root"  )

# con <- dbConnect(RMariaDB::MariaDB(), host = "127.0.0.1", dbname = "access_shiny",
#                  user = "root", password = "root")
# dbListTables(con)


test<-dbGetQuery(pool, "SELECT COUNT(*) AS 'Nb', DATE_FORMAT(datePrevision,'%Y/S%u') AS 'AnneeSemaine' FROM cm_tbmesurescalendrier 
                      WHERE cm_tbmesurescalendrier.dateMiseOeuvre IS NULL AND cm_tbmesurescalendrier.datePrevision IS NOT NULL
                      GROUP BY DATE_FORMAT(cm_tbmesurescalendrier.datePrevision,'%Y/S%u')
                      ORDER BY DATE_FORMAT(cm_tbmesurescalendrier.datePrevision,'%Y/S%u')"
)
testActMes2<-dbGetQuery(pool, "SELECT idMesure, DATE_FORMAT(datePrevision,'%Y/S%u') AS 'AnneeSemaine' FROM cm_tbmesurescalendrier 
WHERE dateMiseOeuvre IS NULL AND datePrevision IS NOT NULL
ORDER BY DATE_FORMAT(datePrevision,'%Y/S%u')"
)
testActMes3<-dbGetQuery(pool, "SELECT idMesure, DATE(datePrevision) AS 'datePrev' FROM cm_tbmesurescalendrier 
WHERE dateMiseOeuvre IS NULL AND datePrevision IS NOT NULL
ORDER BY datePrevision"
)