--Cross-Table Analysis (Combining multiple tables)


select * from teams
select * from players
select * from goals
select * from stadiums
select * from matches


--38.	Which players scored the most goals in matches held at a specific stadium?

/*select g.pid,count(*) as total_goals from goals g join matches m on g.match_id = m.match_id
where lower(m.stadium) = lower('camp nou') and g.pid is not null group by g.pid order by total_goals desc;*/

select stadium,player_id,total_goals
from(
		select m.stadium,g.pid as player_id, count(*) as total_goals,
		dense_rank() over (partition by  m.stadium order by count(*) desc) rnk
		from goals g join matches m on g.match_id=m.match_id
		where g.pid is not null
		GROUP BY m.stadium, g.pid
) t
WHERE rnk = 1 


--39.	Which team won the most home matches in the season 2021-2022 (based on match scores)?

select home_team,count(*) as home_wins from matches where home_team_score> away_team_score 
and season='2021-2022' group by home_team order by 2 desc limit 1


--40.	Which players played for a team that scored the most goals in the 2021-2022 season?

with team_goals as (
    select team, sum(goals) as total_goals
    from (
        select home_team as team, home_team_score as goals from matches where season = '2021-2022'
        union all
        select away_team, away_team_score from matches where season = '2021-2022'
    ) t
    group by team ),
top_team as (
    select team from team_goals order by total_goals desc limit 1
)
select distinct p.player_id, p.first_name,p.last_name,p.team from players p join top_team tt on p.team = tt.team;


--41.	How many goals were scored by home teams in matches where the attendance was above 50,000?

select sum(home_team_score) as home_goals from matches where attendance > 50000


--42.	Which players played in matches where the score difference (home team score - away team score) was the highest?

with max_diff as (
    select max(abs(home_team_score - away_team_score)) as diff from matches
)
select g.pid,g.match_id,m.season,m.home_team,m.away_team,diff as max_goal_diff from goals g join matches m on g.match_id = m.match_id join max_diff d
on abs(m.home_team_score - m.away_team_score) = d.diff where g.pid is not null;


--43.	How many goals did players score in matches that ended in penalty shootouts?

select count(*) as total_goals from goals g join matches m on g.match_id = m.match_id
where m.penalty_shoot_out = 1;


--44.	What is the distribution of home team wins vs away team wins by country for all seasons?

select s.country,sum(case when m.home_team_score > m.away_team_score then 1 else 0 end) as home_wins,
sum(case when m.home_team_score < m.away_team_score then 1 else 0 end) as away_wins
from matches m  join stadiums s on m.stadium = s.name group by s.country order by s.country;


--45.	Which team scored the most goals in the highest-attended matches?

with max_att as (
    select max(attendance) as max_attendance from matches
)
select team, sum(goals) as total_goals
from (
    select m.home_team as team,m.home_team_score as goals from matches m join max_att a on m.attendance = a.max_attendance
    union all
    select m.away_team, m.away_team_score as goals from matches m join max_att a on m.attendance = a.max_attendance
) t
group by team order by total_goals desc limit 1

--46.	Which players assisted the most goals in matches where their team lost(you can include 3)?

select g.assist,count(*) as total_assists from goals g join matches m on g.match_id = m.match_id join players p
on g.assist = p.player_id where g.assist is not null and (
     (p.team = m.home_team and m.home_team_score < m.away_team_score) or 
	 (p.team = m.away_team and m.away_team_score < m.home_team_score)
  )
group by g.assist order by total_assists desc limit 3


--47.	What is the total number of goals scored by players who are positioned as defenders?

select g.pid as player,count(*) as defender_goals from goals g join players p on g.pid=p.player_id 
where lower(p.position)='defender' group by g.pid order by 2 desc


--48.	Which players scored goals in matches that were held in stadiums with a capacity over 60,000?

select distinct g.pid from goals g join matches m on g.match_id = m.match_id join stadiums s on m.stadium = s.name
where s.capacity > 60000 and g.pid is not null

--49.	How many goals were scored in matches played in cities with specific stadiums in a season?

select m.season,s.city,s.name as stadium ,count(g.goal_id) as total_goals from goals g join matches m on g.match_id = m.match_id
join stadiums s on m.stadium = s.name where lower(s.city) = lower('london') and m.season = '2021-2022'
group by m.season, s.city,s.name


--50.	Which players scored goals in matches with the highest attendance (over 100,000)?

select distinct g.pid from goals g join matches m on g.match_id = m.match_id where m.attendance > 100000
and g.pid is not null

-- No players scored 