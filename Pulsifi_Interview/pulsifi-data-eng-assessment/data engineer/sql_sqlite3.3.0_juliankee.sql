--SQLite v3.3.0

CREATE TABLE profile_action_table (
  profile_action_id INT
  ,profile_id INT
  ,action_id INT
  ,created_at timestamp
);


INSERT INTO profile_action_table (profile_action_id,profile_id,action_id,created_at) VALUES 
(1,11,1,'2020-01-01 01:00:00'),
(2,22,3,'2020-01-01 02:00:00'),
(3,11,3,'2020-01-01 03:00:00'),
(4,22,2,'2020-01-01 04:00:00'),
(5,22,1,'2020-01-01 05:00:00'),
(6,11,4,'2020-01-01 06:00:00'),
(7,11,2,'2020-01-01 07:00:00'),
(8,22,2,'2020-01-01 08:00:00');

create table profile_table (
  profile_id INT
  , name VARCHAR(500)
  , gender VARCHAR(500)
 );
 
 INSERT INTO profile_table (profile_id,name,gender) 
 VALUES
 (11,'Alex','Male'),
 (22,'Beth','Female'),
 (33,'Chad','Male');
 
 
 create table action_table (
   action_id INT
   ,action_type VARCHAR(500)
   );
   
 INSERT INTO action_table (action_id,action_type)
 VALUES
 (1,'Login'),
 (2,'Logout'),
 (3,'Start Assessment'),
 (4,'Finish Assessment');
 
 
 
 
select
pt.name
,pt.gender
,fir."last_action"
,fir."last_action_time"
,sec."2nd_last_action"
,sec."2nd_last_action_time"
from profile_table pt
left join (
select
pat.profile_id
,at.action_type as last_action
,max(created_at) as last_action_time
from profile_action_table pat
left join action_table at
  	on at.action_id = pat.action_id
group by
pat.profile_id
) fir
	on fir.profile_id = pt.profile_id

left join (
select
pat.profile_id,
at.action_type as "2nd_last_action",
max(created_at) as "2nd_last_action_time"
from profile_action_table pat
left join action_table at
	on pat.action_id = at.action_id
where profile_id||''||created_at not in (select profile_id||''||max(created_at) from profile_action_table group by profile_id)
group by
profile_id
) sec
	on sec.profile_id = pt.profile_id;