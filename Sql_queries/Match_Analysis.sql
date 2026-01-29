--Match Analysis (From the Matches table)

select * from goals;
select * from matches;
select * from players;
select * from stadiums;
select * from teams;

--10.	What was the highest-scoring match in a particular season?

/*select season,match_id,home_team,away_team, home_team_score + away_team_score as total_goals
from matches order by season,total_goals;*/
select season,match_id,home_team,away_team,total_goals
from (
    select season,match_id,home_team,away_team, home_team_score + away_team_score as total_goals,
    dense_rank() over (partition by season order by home_team_score + away_team_score desc) as rnk
    from matches) t
where rnk = 1 order by season;

--11.	How many matches ended in a draw in a given season?
select season,count(*) as draw_matches from matches where home_team_score = away_team_score group by season;

--12.	Which team had the highest average score (home and away) in the season 2021-2022?

select team,avg(goals)  as avg_goals
from (
    select home_team as team, home_team_score as goals from matches where season = '2021-2022'
	union all
	select away_team as team,away_team_score as goals from matches where season = '2021-2022'
) t
group by team order by avg_goals desc limit 1;

--13.	How many penalty shootouts occurred in a each season?

select season, count(*) as penalty_shootouts from matches where penalty_shoot_out = 1 group by season;

--14.	What is the average attendance for home teams in the 2021-2022 season?

select home_team,trunc(avg(attendance),0) as avg_attendance from matches where season = '2021-2022' group by home_team
order by avg_attendance desc;

--15.	Which stadium hosted the most matches in a each season?

select season, stadium, total_matches
from (
   	select season,stadium,count(*) as total_matches,
    dense_rank() over (partition by season order by count(*) desc) as rnk from matches group by season, 
	stadium ) t where rnk = 1;
--16.	What is the distribution of matches played in different countries in a season?

select m.season,s.country,count(*) as total_matches from matches m join stadiums s
on m.stadium = s.name group by m.season, s.country order by m.season, total_matches desc;

--17.	What was the most common result in matches (home win, away win, draw)?

select result, count(*) as total_matches
from (
    select case
    when home_team_score > away_team_score then 'home win'
    when home_team_score < away_team_score then 'away win'
    else 'draw'
    end as result
    from matches
) t group by result order by total_matches desc;
