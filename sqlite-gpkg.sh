#!/bin/bash
set -e

# Crear o sobreescribir el GPKG con la capa cr_shape
ogr2ogr -f GPKG hydroprojcr.gpkg cr_shape.shp -nln cr_shape

# Procesar las tablas de Data45_2.sqlite
echo "===== Importando capas de Data45_2.sqlite ====="
for LAYER in $(
    ogrinfo Data45_2.sqlite \
    | grep '^[0-9]\+:' \
    | sed -E 's/^[0-9]+: ([^ ]+).*/\1/'
); do
    echo "-> Capa original: ${LAYER}; importando como: ${LAYER}_45_2"
    ogr2ogr \
        -f GPKG \
        -append \
        -nln "${LAYER}_45_2" \
        hydroprojcr.gpkg \
        Data45_2.sqlite "${LAYER}"
done

# Procesar las tablas de Data85_2.sqlite
echo "===== Importando capas de Data85_2.sqlite ====="
for LAYER in $(
    ogrinfo Data85_2.sqlite \
    | grep '^[0-9]\+:' \
    | sed -E 's/^[0-9]+: ([^ ]+).*/\1/'
); do
    echo "-> Capa original: ${LAYER}; importando como: ${LAYER}_85_2"
    ogr2ogr \
        -f GPKG \
        -append \
        -nln "${LAYER}_85_2" \
        hydroprojcr.gpkg \
        Data85_2.sqlite "${LAYER}"
done

echo "¡GeoPackage hydroprojcr.gpkg creado exitosamente!"
