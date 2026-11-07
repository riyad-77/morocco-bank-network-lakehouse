select distinct
    md5(bank_name) as bank_sk,
    bank_name,
    institution_type
from {{ source('lakehouse', 'silver_osm_banks') }}