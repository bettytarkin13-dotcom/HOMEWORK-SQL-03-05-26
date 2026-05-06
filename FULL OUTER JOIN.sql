CREATE TABLE cars_1 (
  id    INTEGER PRIMARY KEY,
  model TEXT    NOT NULL,
  price REAL    NOT NULL
);

INSERT INTO cars_1 VALUES
  (1,'Toyota Corolla',22000),
  (2,'Honda Civic',24000),
  (3,'Ford Focus',19000),
  (4,'Tesla Model 3',42000);
  
CREATE TABLE drivers_1 (
  id     INTEGER PRIMARY KEY,
  name   TEXT    NOT NULL,
  car_id INTEGER,
  FOREIGN KEY (car_id) REFERENCES cars_1(id)
);

INSERT INTO drivers_1 VALUES
  (1,'Dana',1),
  (2,'Omar',2),
  (3,'Noa',NULL),
  (4,'Liam',3),
  (5,'Rina',NULL);


--1.Write a FULL OUTER JOIN to show all drivers and all cars in one result set--
SELECT d.name,c.model
FROM drivers_1 d
LEFT JOIN cars_1 c ON d.car_id = c.id

UNION

SELECT d.name,c.model
FROM cars_1 c
LEFT JOIN drivers_1 d ON d.car_id = c.id;

--2.From the full-outer result, find only the unmatched rows on EITHER side — drivers with no car AND cars with no driver — add a WHERE clause-

SELECT d.name,c.model
FROM drivers_1 d
LEFT JOIN cars_1 c ON d.car_id = c.id
WHERE c.id IS NULL

UNION

SELECT d.name,c.model
FROM cars_1 c
LEFT JOIN drivers_1 d ON d.car_id = c.id
WHERE d.id IS NULL;


--3.Use COALESCE to replace NULL car prices with 0 for drivers who have no car assigned--

SELECT
   d.name,
   COALESCE(c.price,0) AS car_price
FROM drivers_1 d
LEFT JOIN cars_1 c
ON d.car_id = c.id;

--4.Which single join type lets you find drivers WITHOUT a car AND cars WITHOUT a driver in one query?--
--FULL OUTER JOIN returns all rows from both tables, including unmatched rows, in a single query. 
