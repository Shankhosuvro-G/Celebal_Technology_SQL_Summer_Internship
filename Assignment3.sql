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
select
    s1.Name AS StudentName,
    s2.Name AS BestFriendName,
    p2.Salary AS BestFriendSalary
from
    Students s1
join
    Friends f on s1.ID = f.ID
join
    Students s2 on f.Friend_ID = s2.ID
join
    Packages p1 on s1.ID = p1.ID
join
    Packages p2 on s2.ID = p2.ID
where
    p2.Salary > p1.Salary
order by
    p2.Salary;

-- Task - 3
select distinct
    f1.X AS X,
    f1.Y AS Y
from
    Functions f1
join
    Functions f2 on f1.X = f2.Y and f1.Y = f2.X
where
    f1.X < f1.Y
order by
    f1.X;

-- Task - 4
