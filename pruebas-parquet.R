library(DBI)
library(duckdb)


# Archivo Parquet local
# bd <- 'parquet/data_Q_45_2.parquet'

# Archivo Parquet remoto
bd <- 'https://github.com/mfvargas/hydroprojcr/raw/refs/heads/main/parquet/data_Q_45_2.parquet'

# Archivo CSV de salida
csv <- 'csv/data_Q_45_2.csv'

# Parámetro para filtrar los datos
subid <- 605


# Crear conexión a DuckDB (en memoria)
conexion <- dbConnect(duckdb())

# Instalar y cargar la extensión httpfs para acceder archivos remotos
dbExecute(conexion, "INSTALL httpfs;")
dbExecute(conexion, "LOAD httpfs;")

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