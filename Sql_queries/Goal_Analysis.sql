--Goal Analysis From Goals Table

select * from goals;
select * from matches;
select * from players;
select * from stadiums;
select * from teams;

--1.Which player scored the most goals in a each season?

select season,player_id,total_goals
from(
		select m.season,g.pid as player_id, count(*) as total_goals,
		DENSE_RANK() OVER (PARTITION BY m.season ORDER BY COUNT(*) DESC) rnk
		from goals g join matches m on g.match_id=m.match_id
		where g.pid is not null
		GROUP BY m.season, g.pid
) t
WHERE rnk = 1;



--2.	How many goals did each player score in a given season?

select  m.season,g.pid AS player_id,count (*) AS goals_scored from goals g join matches m 
on g.match_id = m.match_id group by m.season, g.pid order by m.season, goals_scored desc;

--3.	What is the total number of goals scored in ‘mt403’ match?

select count(*) as total_goals from goals where match_id = 'mt403';

--4. 	Which player assisted the most goals in a each season?
select season,assist,total_assist
from(
		select m.season,g.assist, count(*) as total_assist,
		DENSE_RANK() OVER (PARTITION BY m.season ORDER BY COUNT(*) DESC) rnk
		from goals g join matches m on g.match_id=m.match_id
		where g.assist is not null
		GROUP BY m.season, g.assist
) t
WHERE rnk = 1;

--5.	Which players have scored goals in more than 10 matches?

select pid, count(distinct match_id) as matches_scored from goals group by pid having count(distinct match_id) > 10;

--6.	What is the average number of goals scored per match in a given season?(type cast)

select m.season, count(g.goal_id)::int / count(distinct m.match_id) as avg_goals_per_match
from matches m left join goals g on m.match_id = g.match_id group by m.season;

--7.	Which player has the most goals in a single match?

select pid,match_id,count(*) as goals_scored from goals group by pid, match_id order by goals_scored desc limit 1;

--8.	Which team scored the most goals in the all seasons?
select team, sum(goals) as total_goals
from (
    select home_team as team, sum(home_team_score) as goals from matches group by home_team union all
	select away_team as team, sum(away_team_score) as goals from matches group by away_team
) t
group by team order by total_goals desc limit 1;


--9.	Which stadium hosted the most goals scored in a single season?

select season, stadium, total_goals
from (
    select m.season,m.stadium,count(*) as total_goals,
    dense_rank() over (partition by m.season order by count(*) desc) as rnk
    from goals g join matches m on g.match_id = m.match_id group by m.season, m.stadium
) t
where rnk = 1;


