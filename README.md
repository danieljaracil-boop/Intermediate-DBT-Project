# Reto Técnico: Implementación de Arquitectura de Datos (dbt + Snowflake)

## 1. Descripción del Proyecto
Este proyecto consiste en la implementación de un flujo de datos completo (ELT) utilizando el dataset `TPCH_SF1` disponible en Snowflake[cite: 2, 11]. El objetivo principal es transformar datos crudos en una capa analítica compuesta por un modelo dimensional (Hechos y Dimensiones) explotable por las Business Units.

## 2. Arquitectura de Capas
Se ha diseñado una arquitectura modular dividida en tres capas de modelización:

### A. Staging Layer (Extracción)
Su propósito es ejecutar la extracción de datos desde los sistemas fuente con el menor impacto posible en el desempeño.
* **Entidades**: Contiene las mismas entidades que el dataset origen.
* **Estrategia de Carga**: 
    * `stg_orders`: Configurada con carga **incremental** para optimizar ventanas de tiempo.
    * Resto de entidades: Configuración de carga total.
* **Materialización**: Tablas.

### B. Transformation Layer (Intermedia)
[cite_start]Capa donde se llevan a cabo transformaciones y combinaciones parciales (campos calculados, granularidad y joins).
* **Materialización**: Vista (carga total).
* **Innovación**: Uso de una **Macro personalizada** (`calculate_discounted_amount`) para estandarizar cálculos financieros de forma reutilizable.

### C. Business Layer (Consumo)
Capa final que proporciona el modelo dimensional explotable.
* **Modelo**: Esquema en estrella (Star Schema).
* **Entidades**: Tabla de hechos `fct_sales` y dimensiones descriptivas `dim_customers` y `dim_date`.
* **Materialización**: Tabla (carga total).



## 3. Calidad y Gobernanza de Datos
Para garantizar un modelo confiable y de nivel profesional, se han implementado:
* **Tests Genéricos**: Pruebas de `unique` y `not_null` en todas las claves primarias.
* **Integridad Referencial**: Tests de `relationships` para asegurar la consistencia entre hechos y dimensiones.
* **Tests de Negocio**: Validación personalizada (`test_no_negative_values`) para asegurar que no existan montos de venta negativos.
* **Monitoreo (Freshness)**: Control de frescura en el origen para garantizar que los datos se actualizan según los SLAs pactados.

## 4. Stack Tecnológico
* **Base de Datos**: Snowflake.
* **Transformación (ETL)**: dbt (Data Build Tool).
* **Lenguaje**: SQL + Jinja (Macros).
* **Control de Versiones**: Git.

## 5. Instrucciones de Ejecución

1. **Instalar Dependencias**: 
   ```bash
   dbt deps 
   ````

2. **Construir y validar el proyecto**
   ````bash
   dbt build
   ````

3. **Generar documentación y linage**:
   ````bash
   dbt docs generate
   dbt docs serve
   ````





