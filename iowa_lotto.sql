
	--get everything for preview
--select *
--from iLot

	--used rename to rename all columns(some were excessively long); simplified all.
--sp_rename 'iLot.Sales_total', 'sales'


	--get basic totals
select game, count(game) as game_count, sum(sales) as sum_sales
from iLot
group by game
order by sum(sales)

--	--get absolute total of sales
select sum(sales) as total_sales
from ilot
	
--	--get sales by year/month
select year(week) as year, month(week) as month, sum(sales)
from ilot
group by year(week), month(week)
order by year desc, month desc

	----creating a temp table with "sales by year/month" data
--DROP TABLE IF EXISTS #datedSales
--create table #datedSales
--(game varchar(50),
--year int,
--month int,
--sales bigint,
--game_type int)

--	--populates temptable with y/m sales by game
--		--game id for visual clarity (instant vs instapull)
--Insert into #datedSales
--select game, year(week) as year, month(week) as month, sum(sales),
--CASE
--	when game = 'lotto' then '1'
--	when game = 'Instant' then '2'
--	when game = 'Instaplay' then '3'
--	when game = 'Pulltab' then '4'
--	else '5'
--end as game_id
--FROM iLot
--group by year(week), month(week), game
--order by year desc, month desc

--	--each game sorted year/month with sales/total sales
select year, month, game, sales,
	SUM(sales) over (partition by game) as sum_total,
	sales/sum(sales) over (partition by game) as sum_percent
from #datedSales
group by game, year, month, sales

select *
from #datedSales

	--get total sales by game, with game counts
select count(game), game, sum(sales)
from ilot
group by game

	--sales retaining week date
select week, game, sum(sales) as tally from ilot
group by week, game

	--category sales
select sum(sales), game
from #datedsales
group by game

select sum(sales)
from ilot