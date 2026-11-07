select
    r.shape_iso        as region_iso,
    p.region_name_fr   as region_name,
    p.population_2024
from {{ source('lakehouse', 'bronze_regions') }} as r
left join {{ ref('population_regions_2024') }} as p
    on r.shape_iso = p.region_iso