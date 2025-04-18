# 📁 Estructura del Proyecto Base en ESP-IDF

Este documento explica brevemente **para qué sirve cada parte** de la estructura típica de un proyecto basado en ESP-IDF.

---

## 🗂️ Estructura general del proyecto

```bash
esp32_firmware_template/ 
├── CMakeLists.txt 
├── main/ 
│   ├── CMakeLists.txt 
│   └── esp32_firmware_template.c 
├── sdkconfig 
├── README.md 
├── setup.sh 
└── .env.example
```

---

## 📄 Archivos y carpetas explicados

### `CMakeLists.txt`
Archivo principal que define el proyecto para CMake. Indica dónde están los componentes y cuál es el archivo principal (`main/`).

```cmake
include($ENV{IDF_PATH}/tools/cmake/project.cmake)
project(esp32_firmware_template)

```

### `main/`

Contiene el código fuente principal del firmware.

`main/CMakeLists.txt`

Indica qué archivos fuente están incluidos y sus dependencias.

`main/esp32_firmware_template.c`

Archivo principal del firmware, donde se encuentra la función app_main() (el punto de entrada del programa, equivalente al main() en C estándar).

### `sdkconfig`

Archivo generado automáticamente por idf.py menuconfig. Contiene todas las configuraciones del firmware, como:

    Log levels

    Configuración Wi-Fi

    Funciones habilitadas

    Selección de periféricos

No editar manualmente. Se modifica con:
```bash
idf.py menuconfig
```

### `README.md`

Documentación general del proyecto, cómo compilarlo, flashearlo y entender su funcionamiento.

### `setup.sh`

Script de ayuda para:

    Crear y activar un entorno virtual Python

    Ejecutar el export.sh de ESP-IDF

    Instalar dependencias requeridas por idf.py

### `.env.example`

Archivo de ejemplo con la variable IDF_PATH que apunta a tu instalación de ESP-IDF. Se puede copiar como .env y cargar con source para que el setup.sh funcione correctamente.

### 🔁 Opcionales recomendados

#### `components/`

Si el proyecto crece, se pueden mover drivers, librerías propias o reutilizables a esta carpeta.

#### `partitions.csv`

Si necesitás definir un esquema de particiones personalizado, este archivo te permite definir la flash layout.