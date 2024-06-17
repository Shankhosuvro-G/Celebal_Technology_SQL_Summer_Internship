-- Task - 1
with TaskGroup as (
    select
        Task_ID,
        Start_Date,
        End_Date,
        ROW_NUMBER() OVER (order by Start_Date) - 
        ROW_NUMBER() OVER (PARTITION by DATEADD(day, -ROW_NUMBER() OVER (order by Start_Date), Start_Date) order by Start_Date) as Project_ID
    from Projects
)
select
    MIN(Start_Date) as Start_Date,
    MAX(End_Date) as End_Date,
    DATEDIFF(day, MIN(Start_Date), MAX(End_Date)) + 1 as Duration
from TaskGroup
group by Project_ID
order by Duration, MIN(Start_Date);

-- Task - 2
