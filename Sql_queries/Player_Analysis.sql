--Player Analysis (From the Players table)

select * from goals;
select * from matches;
select * from players;
select * from stadiums;
select * from teams;

--18.	Which players have the highest total goals scored (including assists)?

select player_id,sum(goal_count + assist_count) as total_contributions
from (
    select pid as player_id,count(*) as goal_count, 0 as assist_count from goals group by pid
	union all
	select assist as player_id,0 as goal_count,count(*) as assist_count from goals where assist is not null
    group by assist
) t
group by player_id order by total_contributions desc;

--19.	What is the average height and weight of players per position?

select position,round(avg(height)::numeric,2) as avg_height, round(avg(weight)::numeric,2) as avg_weight from players where height is 
not null and weight is not null group by position;


--20.	Which player has the most goals scored with their left foot?

select g.pid, count(*) as left_foot_goals from goals g join players p on g.pid = p.player_id
where p.foot = 'L' group by g.pid order by left_foot_goals desc limit 1;


--21.	What is the average age of players per team?

select team, avg(extract(year from age(current_date, dob)))::int as avg_age from players group by team

--22.	How many players are listed as playing for a each team in a season?
select team, count(*) as total_players from players where team is not null group by team order by total_players desc;


--23.	Which player has played in the most matches in the each season?

select season, pid, matches_played
from (
    select m.season,g.pid,count(distinct g.match_id) as matches_played,
    dense_rank() over (partition by m.season order by count(distinct g.match_id) desc
    ) as rnk
    from goals g join matches m on g.match_id = m.match_id where g.pid is not null group by m.season, g.pid
) t where rnk = 1 order by season;


--24.	What is the most common position for players across all teams?

select position,count(*) as total_players
from players group by position order by total_players desc limit 1;


--25.	Which players have never scored a goal?

select p.player_id,p.first_name,p.last_name from players p left join goals g on p.player_id = g.pid
where g.pid is null;