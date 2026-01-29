-- team analysis
-- dataset: uefa competitions
-- tables used: teams, matches, stadiums

--q26.	Which team has the largest home stadium in terms of capacity?

select  t.team_name,
        s.name as stadium_name,
        s.capacity
 from teams t 
 join stadiums s 
  on t.home_stadium=s.name 
order by s.capacity desc 
limit 1;
 

--q27.	Which teams from a each country participated in the UEFA competition in a season?

select m.season,
       t.country,
       t.team_name as teams 
from teams t 
join matches m
  on t.team_name = m.home_team 
  or t.team_name = m.away_team
group by m.season, t.country,t.team_name  
order by m.season, t.country;

--q28.	Which team scored the most goals across home and away matches in a given season?

select season,
       team, 
       total_goals
from (
    select season,
           team,
           sum(goals) as total_goals,
           dense_rank() over (
                partition by season 
                order by sum(goals) desc
           ) as rnk
  from (
      select season, 
             home_team as team,
             home_team_score as goals 
      from matches
		  union all
		  select season,
             away_team as team,
             away_team_score as goals 
      from matches
    ) t
    group by season, team
  ) x
where rnk = 1 
order by season;

--q29.	How many teams have home stadiums in a each city or country?

select s.city,
       count(distinct t.team_name) as total_teams 
from teams t 
join stadiums s 
  on t.home_stadium=s.name
group by s.city 
order by total_teams desc

-- q29 (alt). how many teams have home stadiums in each country?

select s.country,
       count(distinct t.team_name) as total_teams 
from teams t join stadiums s 
  on t.home_stadium=s.name
group by s.country 
order by total_teams desc

--q30.	Which teams had the most home wins in the 2021-2022 season?

select home_team, 
       count(*) as home_wins 
from matches 
where season = '2021-2022' 
  and home_team_score > away_team_score 
group by home_team 
order by home_wins desc;
