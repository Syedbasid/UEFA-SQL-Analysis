--Stadium Analysis (From the Stadiums table)

select * from teams;
select * from players
select * from goals
select * from stadiums
select * from matches

--31.	Which stadium has the highest capacity?

select name,city,country,capacity from stadiums order by capacity desc limit 1

--32.	How many stadiums are located in a ‘Russia’ country or ‘London’ city?

select count(distinct name) as total_stadium from stadiums where lower(city)='london' or lower(country)='russia' 


--33.	Which stadium hosted the most matches during a season?

select season,stadium,total_matches
from(
	select m.season,m.stadium,count(*) as total_matches,
	dense_rank() over (partition by m.season order by count(*) desc) as rnk
	from matches m group by m.season,m.stadium
	)t where rnk=1 order by season


--34.	What is the average stadium capacity for teams participating in a each season?

select m.season, round(avg(s.capacity)::numeric,0) as avg_stadium_capacity from matches m join stadiums s 
on m.stadium = s.name group by m.season order by m.season;


--35.	How many teams play in stadiums with a capacity of more than 50,000?

select count(distinct t.team_name) as total_teams from teams t join stadiums s on t.home_stadium = s.name
where s.capacity > 50000;

--36.	Which stadium had the highest attendance on average during a season?

select season,stadium,avg_attendance
from (
    select m.season,m.stadium,avg(m.attendance)::int as avg_attendance,
    dense_rank() over (partition by m.season order by avg(m.attendance) desc) as rnk
    from matches m group by m.season, m.stadium
) t where rnk = 1 order by season;

--37.	What is the distribution of stadium capacities by country?

select country, count(*) as total_stadiums, min(capacity) as min_capacity,max(capacity) as max_capacity,
avg(capacity)::int as avg_capacity from stadiums group by country order by country;