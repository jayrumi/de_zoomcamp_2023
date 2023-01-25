-- Question 3. Count records
select count(*) as trip_count
from public.green_taxi_data
where 
	date(lpep_pickup_datetime) = date('2019-01-15')
	and date(lpep_dropoff_datetime) = date('2019-01-15');

-- Question 4. Largest trip for each day
select date(lpep_pickup_datetime) as max_trip_day
from public.green_taxi_data
where trip_distance = (select max(trip_distance) from public.green_taxi_data)
;

-- Question 5. The number of passengers
select 
  passenger_count, 
  count(*) as total
from public.green_taxi_data
where lpep_pickup_datetime::date = '2019-01-01'::date
and passenger_count in (2, 3)
group by passenger_count;

-- Question 6. Largest tip
select do_zone."Zone"
from 
	public.green_taxi_data as gtp 
join
	public.zones as do_zone
		on gtp."DOLocationID" = do_zone."LocationID"
where "PULocationID" = (select "LocationID" from public.zones where "Zone" = 'Astoria')
group by do_zone."Zone"
order by max(gtp.tip_amount) desc
limit 1
;
