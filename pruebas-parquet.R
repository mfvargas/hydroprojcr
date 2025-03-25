library(DBI)
library(duckdb)


bd <- 'parquet/data_Q_45_2.parquet'
csv <- 'csv/data_Q_45_2.csv'
subid <- 605

# Crear conexión a DuckDB (en memoria)
conexion <- dbConnect(duckdb())

# Crear consulta SQL
consulta <- paste0(
  "SELECT * ",
  "FROM '", bd, "' ",
  "WHERE subid = ", subid
)

# Ejecutar consulta SQL
resultado <- dbGetQuery(conexion, consulta)

# Guardar resultado en archivo CSV
write.csv(resultado, csv, row.names = FALSE)

# Cerrar la conexión
dbDisconnect(conexion)