#!/bin/bash

# Activar entorno virtual
if [ ! -d ".venv" ]; then
    echo "Creando entorno virtual .venv..."
    python3 -m venv .venv
fi

echo "Activando entorno virtual..."
source .venv/bin/activate

# Verificar que IDF_PATH esté definido
if [ -z "$IDF_PATH" ]; then
    echo "ERROR: La variable de entorno IDF_PATH no está definida."
    echo "Por favor, exportá IDF_PATH con la ruta de tu instalación de ESP-IDF."
    echo "Ejemplo:"
    echo "export IDF_PATH=~/esp/esp-idf"
    return 1
fi

# Ejecutar export.sh de ESP-IDF
echo "Ejecutando export.sh desde $IDF_PATH"
source $IDF_PATH/export.sh

# Instalar dependencias si no están presentes
echo "Instalando dependencias necesarias..."
pip install -r $IDF_PATH/requirements.txt

echo "Entorno de ESP-IDF activado. ¡Listo para usar idf.py!"
