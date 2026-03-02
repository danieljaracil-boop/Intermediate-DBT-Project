# Reto Técnico: Arquitectura de Datos dbt + Snowflake (TPCH)

## 1. Descripción del Proyecto
Este proyecto implementa un flujo de datos completo (ELT) utilizando el dataset de industria **TPCH_SF1** en Snowflake. El objetivo es transformar datos crudos en una capa analítica compuesta por un modelo dimensional (Star Schema) optimizado para el consumo de Business Intelligence.

## 2. Arquitectura de Capas
Se ha implementado una arquitectura modular siguiendo las mejores prácticas de dbt:

### A. Staging Layer (`models/staging/`)
Mapeo directo y limpieza inicial de las entidades fuente.
* **Materialización**: Tablas.
* **Estrategia Incremental**: El modelo `stg_orders` utiliza carga **incremental** basada en `o_orderdate` para optimizar el rendimiento y reducir el consumo de recursos en Snowflake.
* **Gobernanza**: Control de frescura (`source freshness`) configurado para monitorear la latencia de los datos de origen.

### B. Intermediate Layer (`models/intermediate/`)
Capa de lógica de negocio donde se realizan cruces complejos y cálculos.
* **Modelos**: `int_order_items` y `int_locations`.
* **Lógica**: Uso de una **Macro personalizada** (`calculate_discounted_amount`) para centralizar el cálculo del importe neto tras descuentos, garantizando la reutilización del código.
* **Materialización**: Vista.

### C. Business Layer - Marts (`models/marts/`)
Producto final listo para el negocio, estructurado como modelo dimensional.
* **Fact Table**: `fct_sales` (Métricas de ventas agregadase).
* **Dimensions**: `dim_customers` (Atributos de cliente), `dim_locations` (Dimensión espacial simplificada) y `dim_date` (Dimensión temporal generada mediante *date spine*).
* **Materialización**: Tablas.



## 3. Calidad y Validación de Datos
El proyecto cuenta con una robusta suite de validación que garantiza la fiabilidad del modelo dimensional:

* **Integridad Básica**: Tests de `unique` y `not_null` en todas las claves primarias.
* **Integridad Referencial**: Tests de `relationships` entre la tabla de hechos y sus dimensiones.
* **Lógica de Negocio**: Test singular personalizado (`test_no_negative_values`) para asegurar que no existen importes negativos en la facturación.
* **Estandarización**: Cumplimiento del estándar de dbt v1.8+ (parámetros de tests anidados bajo la propiedad `arguments`).

## 4. Stack Tecnológico
* **Data Warehouse**: Snowflake.
* **Modelado y Transformación**: dbt Core / Cloud.
* **Lenguajes**: SQL y Jinja.
* **Control de Versiones**: Git.

## 5. Instrucciones de Uso

1.  **Instalar dependencias**:
    ```bash
    dbt deps
    ```
    
2.  **Construir y Validar el Pipeline**:
    ```bash
    dbt build
    ```

3.  **Visualizar Linaje y Documentación**:
    ```bash
    dbt docs generate
    dbt docs serve
    ```



---
**Desarrollado por:** Daniel Jaracil  
**Estado del Proyecto:** PASS=9 | WARN=0 | ERROR=0