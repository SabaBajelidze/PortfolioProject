--we are now going to see our table.
select * from smokers
--firstly, lets delte columns we dont need
alter table smokers drop column 
DataSource, Data_value_footnote_symbol,
Data_value_footnote, data_value_std_err,
Low_confidence_limit, high_confidence_limit,
sample_size, topictypeid, topicid, measureid, 
stratificationid1, stratificationid2, stratificationid3, stratificationid4
--i know that some of this information may be useful, however we dont need them in this scenario.
--now, lets see what we got.
select * from smokers
-- we have 15 columns with 38050 rows. problem is, this table contains data from all different questions from survey. lets see all different questions which were asked
select distinct topicdesc from smokers
--there are 3 distinct topics, lets see each one and explore questions which were asked.
select distinct measuredesc from smokers where topicdesc = 'Cigarette Consumption (Adults)'
-- we can see 2 distinct questions asked on this topic, lets do this on all topics
select distinct measuredesc from smokers where topicdesc = 'Cigarette Use (Adults)'
--there are 4 distinct questions about this topic
select distinct measuredesc from smokers where topicdesc = 'Cessation (Adults)'
--this much information in one table can cause difficulties in understanding the data. so, lets make new tables using each topics.
select * into CigaretteConsumption from smokers where topicdesc = 'Cigarette Consumption (Adults)'
select * from CigaretteConsumption
--we have made new table using old one. now lets delete rows in which response is null
delete from CigaretteConsumption
where response is null
-- 765 rows affected
select * from cigaretteconsumption
-- this leaves us with one question, which asks smokers how many cigarettes they use per day.
--lets see distinct answers
select distinct response from CigaretteConsumption
-- this table is now usable in power BI
-- lets make similar tables using cigarette use and cessation
select * into CigaretteUse from smokers where topicdesc = 'Cigarette Use (Adults)'
select * from Cigaretteuse
-- now lets delete rows where response is null and do same for cessation
delete from CigaretteUse where response is null
--18000 rows affected
select * into Cessation from smokers where topicdesc = 'Cessation (Adults)'
select * from Cessation
--now, we have 4 tables, from which we created 3. we will be using this 3 tables in power bi to make reports.


