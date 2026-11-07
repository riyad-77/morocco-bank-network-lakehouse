select
    osm_key,
    md5(bank_name) as bank_sk,
    region_iso,
    lat,
    lon,
    first_seen_date,
    is_active
from {{ source('lakehouse', 'silver_osm_banks') }}