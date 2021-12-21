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
dbListTables(pool)
# drv<- RJDBC::JDBC("org.mariadb.jdbc.Driver",
#                   classPath = system.file("java/mariadb-java-client-2.7.0.jar"
#                                           ,package="Rpgs")
# )
# con <- RJDBC::dbConnect(drv, "jdbc:mariadb://127.0.0.1:3306/access_shiny",
#                         "root", "root"  )

# con <- dbConnect(RMariaDB::MariaDB(), host = "127.0.0.1", dbname = "access_shiny",
#                  user = "root", password = "root")
# dbListTables(con)
