use ETL5;

/*                                                    Cars Manufacturing Analysis                                                               */

-- 1.Find the car with the highest highway MPG.
select Manufacturer,`MPG.highway` from cars93 order by `MPG.highway` desc limit 1;

-- 2.List cars with a price above the average price of all cars
 select Manufacturer,price from cars93 where price > (select avg(price) from cars93);
 
-- 3.Count the number of cars with a city MPG gretaer than 25
select count(Manufacturer) from cars93 where `MPG.city`>25;

-- 4.Find the car with the lowest price among those with a city MPG greater than 20.
select Manufacturer,price from cars93 where `MPG.city`>20 order by price limit 1;

-- 5.Count the number of cars produced in the 'USA.'
select origin,count(manufacturer) from cars93 where origin='USA' group by origin having count(distinct(manufacturer));

-- 6.List cars with a city MPG greater than the average city MPG of American cars.
select manufacturer,`MPG.city` from cars93 where `MPG.city`>(select avg(`MPG.city`) from cars93);

-- 7.Find the car with the lowest price among those with a city MPG greater than the average city MPG.
select manufacturer,price from cars93 where `MPG.city`>(select avg(`MPG.city`) from cars93) order by price limit 1;

-- 8.Find the car with the highest highway MPG among American cars.

select manufacturer,origin,`MPG.highway` from cars93 where origin='USA' order by `MPG.highway` desc limit 1; 

-- 9.Count the number of cars with a price higher than the average price of American cars.
select count(manufacturer) from cars93 where price>(select avg(price) from cars93);

-- 10. List cars with a city MPG higher than the city MPG of the car with the second-highest highway MPG. (IMP)
select*from cars93 where `MPG.city` >(select `MPG.city` from cars93 
                      where `MPG.highway`=(select `MPG.highway` from cars93 order by `MPG.highway` desc limit 1,1));

-- 11. Which manufacturer and model have the highest total average price?
select Manufacturer,Model,(select round(avg(Price)) from cars93) as `highest total Price` from cars93
												order by  `highest total Price` desc limit 1;

-- 12.What is the average city and highway MPG for each car type ? (Small, Sporty, Compact, etc.)
select type,(select round(avg(`MPG.city`)) from cars93) as `avg MPG.city`,
             (select round(avg(`MPG.highway`)) from cars93) as `avg MPG.highway` from cars93 group by type; 

-- 13.Which manufacturer produces the most fuel-efficient cars on average in the MPG.city?
select Manufacturer,(select round(max(`Fuel.tank.capacity`)) from cars93) as `Most Fuel Efficient`,
                                    (select round(avg(`MPG.city`)) from cars93) as ` Avg MPG.city` from cars93 group by Manufacturer;

-- 14.What is the average horsepower for cars with above-average fuel efficiency on the highway?
SELECT distinct(Manufacturer),(select AVG(Horsepower) from cars93) AS AvgHorsepower FROM cars93
                                   where `MPG.highway` > (SELECT AVG(`MPG.highway`) FROM cars93);

-- 15. Which ‘Type’ of car has the best average fuel efficiency in the city?
select distinct(type),(select round(avg(`Fuel.tank.capacity`)) from cars93) as `Avg Fuel Efficiency` from cars93;

-- 16. Which car model with a 4-cylinder engine has the best average fuel efficiency on the highway?
SELECT Model, AVG(`MPG.highway`) AS AvgHighwayMPG FROM cars93 WHERE Cylinders = '4'
                                                GROUP BY Model ORDER BY AvgHighwayMPG DESC LIMIT 1;
                                   
                                   
                                   