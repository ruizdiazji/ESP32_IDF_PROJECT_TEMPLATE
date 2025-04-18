# 🚀 Plantilla Base para Proyecto ESP-IDF

Este proyecto sirve como base para crear nuevos firmwares usando [ESP-IDF](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/). Incluye una guía paso a paso para configurar, compilar y flashear el firmware.

---

## ✅ Asegurarse de que idf.py esta activado
El comando idf.py es un wrapper de Python que no estará disponible si no activás el entorno primero. Además, necesita saber dónde están las herramientas de ESP-IDF, los toolchains, y otras variables como IDF_PATH.

### 🧪 ¿Cómo activar idf.py?

Tenés dos opciones:

🔹 Opción 1: Activar directamente con export.sh

```bash 
source $IDF_PATH/export.sh
```
📍 IDF_PATH es la ruta donde instalaste ESP-IDF. Por ejemplo:
```bash
source ~/esp/esp-idf/export.sh
```

🔹 Opción 2: Activar dentro de un entorno virtual Python (recomendado)
```bash
python3 -m venv .venv
source .venv/bin/activate
source $IDF_PATH/export.sh
```
Esto garantiza que idf.py y sus dependencias estén bien aisladas y listos para usar.

### 🧪 Verificar si está activado

Podés probar:
```bash
idf.py --version
```
Si ves algo como:
```bash
ESP-IDF v5.1.2
```
entonces está todo bien configurado ✅


## 📁 Estructura Inicial del Proyecto

```bash
idf.py create-project nombre_del_proyecto
cd nombre_del_proyecto

Esto crea una estructura como la siguiente:

nombre_del_proyecto/
├── CMakeLists.txt
├── main/
│   ├── CMakeLists.txt
│   └── nombre_del_proyecto.c
└── sdkconfig
```

---

## ⚙️ Configuración con Menuconfig

Para configurar el comportamiento del proyecto, ejecutar:
```bash
 idf.py menuconfig
```
Configuraciones útiles:
- Wi-Fi / Bluetooth
- Log levels
- Seguridad (Flash encryption / Secure Boot)
- CPU frequency
- GPIOs y periféricos

## ✍️ Código de ejemplo en main/nombre_del_proyecto.c

```bash
#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_log.h"

static const char *TAG = "main";

void app_main(void) {
    ESP_LOGI(TAG, "Firmware iniciado correctamente.");

    while (1) {
        ESP_LOGI(TAG, "Parpadeando...");
        vTaskDelay(pdMS_TO_TICKS(1000));
    }
}
```

## 🧪 Compilación y Flasheo
Compilar el proyecto:
``` bash
idf.py build
```

Flashear y monitorear la salida serial:
``` bash
idf.py -p /dev/ttyUSB0 flash monitor
```

 Reemplazá /dev/ttyUSB0 por el puerto correcto en tu sistema.

 ## 🪛 Organización recomendada del proyecto
 
 Podés agregar estas carpetas si querés reutilizar componentes:
 ``` makefile
components/        # Librerías o drivers propios
include/           # Archivos header globales
partitions.csv     # Esquema de particiones personalizado
```

## 🔧 Funcionalidades comunes para agregar

    ✅ Conexión Wi-Fi STA o AP (esp_wifi.h)

    ✅ Almacenamiento persistente (nvs_flash)

    ✅ Logs con ESP_LOG*

    ✅ Tareas con FreeRTOS

    ✅ Comunicación MQTT (esp-mqtt)

    ✅ BLE / ESP-NOW / UART / I2C / SPI

## 📌 Comandos útiles

```bash
idf.py menuconfig
idf.py build
idf.py flash monitor
idf.py clean
idf.py fullclean
```

## ✨ Recomendaciones

    Crear entornos virtuales con idf export.sh.

    Documentar los periféricos y esquemas en /docs.


## ✅ Crear entornos virtuales con idf export.sh

- ### 🧱 Opción 1: Activar directamente en cada terminal
    Si no usás entorno virtual (como venv o virtualenv), simplemente hacés:
    ``` bash 
    . $IDF_PATH/export.sh
    ```
    🔁 Tenés que hacerlo cada vez que abrís una nueva terminal si no estás usando entorno virtual.

- ### 🧪 Opción 2: Usar entorno virtual con Python

    ESP-IDF viene con herramientas en Python (como idf.py, esptool.py, etc.), así que podés usar un entorno virtual para aislarlas:

    1. Crear entorno virtual (una vez)
        ``` bash
        python3 -m venv .venv
        ```
        Esto crea una carpeta .venv/ con un entorno virtual de Python.
    
    2. Activar entorno virtual (cada vez que trabajás)
        ``` bash
            source .venv/bin/activate
        ```
        El prompt cambia a algo así como (.venv) indicando que estás en el entorno virtual.
    
    3. Correr export.sh dentro del entorno virtual

        Con el entorno activado:
        ``` bash
            source $IDF_PATH/export.sh
        ```
        Esto carga las herramientas de ESP-IDF en tu entorno virtual.
    
    4. Instalar dependencias (una vez)

        ``` bash
            pip install -r $IDF_PATH/requirements.txt
        ```
        Esto instala las herramientas necesarias como idf.py, esptool, pyserial, etc.

## 📌 Tips extra

Podes usar un script para automatizar la creacion y activacion del entorno virtual necesario para utilizar las herramientas de idf.py

El script setup.sh se encarga de:

    1. Crea un entorno virtual .venv si no existe

    2. Lo activa

    3. Verifica que tengas configurado IDF_PATH

    4. Ejecuta export.sh

    5. Instala las dependencias necesarias

Podés colocarlo en la raíz de cualquier proyecto ESP-IDF y ejecutarlo con:
```bash
source setup.sh
```

Si no tenes exportada la ruta donde se encuentra el esp idf, podes utilizar el archivo env.example:

1. Copia el archivo .env.example y renombralo a .env
    ```bash
    cp .env.example .env
    ```
2. Editá el valor de IDF_PATH con la ruta real donde tenés ESP-IDF instalado.

3. Luego podés cargarlo antes de ejecutar el setup.sh:
    ```bash
    source .env
    source setup.sh
    ```