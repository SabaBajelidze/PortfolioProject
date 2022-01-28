-- lets name this table smokers
select * from Smokers
-- lets remove useless columns
alter table smokers drop column topictypeid, topicid, measureid, stratificationid1, stratificationid2, stratificationid3, stratificationid4
--lets see what we got
select * from smokers
-- we still have some unwanted columns, lets fix it
alter table smokers drop column datasource, data_value_footnote_symbol, data_value_footnote, data_value_std_err, low_confidence_limit, high_confidence_limit
select * from smokers
--much better. however, we are not done yet.
-- lets delte rows(surveys) where sample size is not provided
delete from Smokers where Sample_Size is null
--as we can see, we deleted 2009 rows.
select * from Smokers
--we dont need column topictype, as every row has same 
alter table smokers drop column topictype 
select * from Smokers
select * from smokers where TopicDesc = 'Cessation (Adults)'
--as this table do not provide good form of information, we must delete useless data. so, lets delete rows where measuredesc is Quit Attempt in Past Year Among Every Day Cigarette Smokers
-- as this data dont provide accurate answers.
delete from smokers where MeasureDesc = 'Quit Attempt in Past Year Among Every Day Cigarette Smokers'
-- we deleted 1621 more rows.
-----------------------------------------------------------------------------------------------------------
select * from Smokers
select * from smokers where TopicDesc = 'Cigarette Use (Adults)'
select distinct measuredesc from Smokers where TopicDesc = 'Cigarette Use (Adults)'
select * from smokers where TopicDesc = 'Cessation (Adults)'
select distinct measuredesc from Smokers where TopicDesc = 'Cessation (Adults)'
select * from smokers where TopicDesc = 'Cigarette Consumption (Adults)'
select distinct measuredesc from Smokers where TopicDesc = 'Cigarette Consumption (Adults)'
--it is useless to have this much information in one table, so i am going to split this table in more useful and little tables.
-- lets make new table based on measuredesc - current smoking
select * into CurrentSmokers from Smokers where MeasureDesc = 'Current Smoking'
--13842 rows affected, lets see our new table.
select * from CurrentSmokers
-- this table is almost usable fro power BI.
select * from smokers where MeasureDesc = 'smoking status'
--as we can see, when measuredesc is smoking status and answer is current, it is same as Currentsmokers, so , we will add this info to currentsmokers
insert into Currentsmokers select * from Smokers where MeasureDesc = 'smoking status' and Response = 'Current'
--2388 rows affected.
select * from CurrentSmokers
--as this data is into currentsmokers, we can remove more columns to make it easy to understand and work on.
alter table currentsmokers drop column topicdesc, measuredesc, response, data_value_unit, data_value_type
select * from CurrentSmokers
--good currentsmokers is done and ready for excel. lets make more tables like this
select * from smokers where measuredesc = 'Smoking Frequency'
select * into SmokingFrequency from smokers where measuredesc = 'Smoking Frequency'
-- we have made another table named smokingfrequency which has 4774 rows.
select * into NeverSmokers from smokers where MeasureDesc = 'Smoking Status' and Response = 'Never'
--new table named neversmokers which has 2388 rows
select * into FormerSmokers from smokers where MeasureDesc = 'Smoking Status' and Response = 'Former'
--new table named formersmokers which has 2388 rows
-- lets delete rows which has cessation as topicdesc as its not as important to us 
delete from smokers where TopicDesc = 'Cessation (Adults)'
select * from FormerSmokers
-- lets make last table based on Daily Cigarette Consumption Among Every Day Smokers - Average
select * into AveragePerDay from smokers where MeasureDesc = 'Daily Cigarette Consumption Among Every Day Smokers - Average'
--this table has 765 rows.
--now with new tables ready, we can go to excel and power BI and start making reports
--we went from having 1 useless table full of very different information to having 5 tables with useable information.


