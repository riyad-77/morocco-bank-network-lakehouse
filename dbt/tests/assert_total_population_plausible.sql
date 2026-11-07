select sum(population_2024) as total_population
from {{ ref('dim_region') }}
having sum(population_2024) not between 36000000 and 37500000