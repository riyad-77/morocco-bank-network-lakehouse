with active_agencies as (
    select
        f.region_iso,
        b.institution_type
    from {{ ref('fact_agency') }} as f
    join {{ ref('dim_bank') }} as b
        on f.bank_sk = b.bank_sk
    where f.is_active
)

select
    r.region_iso,
    r.region_name,
    r.population_2024,
    count_if(a.institution_type in ('banque', 'banque participative')) as bank_branches,
    count_if(a.institution_type like 'transfert%')                      as money_transfer_points,
    count_if(a.institution_type = 'microcrédit')                        as microcredit_points,
    round(
        10000 * count_if(a.institution_type in ('banque', 'banque participative'))
        / r.population_2024,
        2
    ) as bank_branches_per_10k
from {{ ref('dim_region') }} as r
left join active_agencies as a
    on r.region_iso = a.region_iso
group by r.region_iso, r.region_name, r.population_2024