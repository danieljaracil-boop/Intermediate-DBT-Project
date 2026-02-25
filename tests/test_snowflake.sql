{{ config(materialized='test') }}

SELECT 
    'Conexión Exitosa' AS mensaje,
    CURRENT_TIMESTAMP() AS fecha_ejecucion,
    CURRENT_USER() AS usuario_dbt
