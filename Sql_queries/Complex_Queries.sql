--Additional Complex Queries

select * from teams
select * from players
select * from goals
select * from stadiums
select * from matches

--51.	What is the average number of goals scored by each team in the first 30 minutes of a match?

select team,floor(avg(goals_scored)) as avg_goals_first_30
from(
   select m.match_id,p.team,count(*) as goals_scored from goals g join matches m on g.match_id=m.match_id
   join players p  on g.pid=p.player_id where g.duration<=30 and g.pid is not null group by m.match_id,
   p.team ) t  group by team order by avg_goals_first_30 desc


--52.	Which stadium had the highest average score difference between home and away teams?

select stadium,avg(abs(home_team_score - away_team_score))::int as avg_score_diff from matches group by stadium
order by avg_score_diff desc limit 1

--53.	How many players scored in every match they played during a given season?

select season,count(*) as total_players
from (
    select m.season,g.pid,count(distinct g.match_id) as matches_with_goal from goals g join matches m
    on g.match_id = m.match_id where g.pid is not null group by m.season, g.pid
) t
group by season order by season;

--54.	Which teams won the most matches with a goal difference of 3 or more in the 2021-2022 season?

select team,count(*) as big_wins
from(
 	select home_team  as team from matches where season='2021-2022' and home_team_score-away_team_score>=3
	union all
	select away_team from matches where season='2021-2022' and away_team_score-home_team_score>=3 ) t
	group by team order by big_wins desc

--55.	Which player from a specific country has the highest goals per match ratio?

/*select p.player_id,p.first_name,p.last_name,count(distinct g.goal_id)::float / count(distinct g.match_id) 
as goals_per_match from players p join goals g on p.player_id = g.pid where lower(p.nationality) = lower('portugal')
group by p.player_id, p.first_name, p.last_name order by goals_per_match desc limit 1;*/




select nationality,player_id,first_name,last_name,goals_per_match
from (
    select p.nationality,p.player_id,p.first_name,p.last_name,
	count(g.goal_id)::int / count(distinct g.match_id) as goals_per_match,
    dense_rank() over (partition by p.nationality order by 
	count(g.goal_id)::int / count(distinct g.match_id) desc) as rnk
    from players p join goals g on p.player_id = g.pid where g.pid is not null
    group by p.nationality, p.player_id, p.first_name, p.last_name
) t where rnk = 1 order by goals_per_match desc;