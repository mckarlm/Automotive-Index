-- psql while in the Automotive-Index root folder

CREATE USER indexed_cars_user WITH PASSWORD cars;
-- password made out of habit

CREATE DATABASE indexed_cars
  WITH OWNER = indexed_cars_user;

\i scripts/car_models.sql;

\i scripts/car_model_data.sql; -- ten times

SELECT COUNT(*) -- OPTIONAL
  FROM car_models; -- Should return 223380

---------- TIMING SELECT STATEMENTS ----------

SELECT DISTINCT COUNT(make_title) -- maybe take out COUNT? returns Lamborghini
  FROM car_models
  WHERE make_code = 'LAM'; -- 182.557ms

SELECT DISTINCT COUNT(model_title)
  FROM car_models
  WHERE make_code = 'NISSAN'
  WHERE model_code = 'GT-R'; -- 377.094ms

SELECT COUNT(*)
  FROM car_models
  WHERE make_code = 'LAM'; -- 140.917ms

SELECT COUNT(*)
  FROM car_models
  WHERE year
  BETWEEN 2010 AND 2015; -- 189.577.ms

SELECT COUNT(*)
  FROM car_models
  WHERE year = 2010; -- 136.513ms

---------- INDEXING ----------

CREATE INDEX indexMakeCode
  ON car_models (make_code);

CREATE INDEX indexMakeModelCode
  ON car_models (make_code, model_code);

CREATE INDEX indexYear
  ON car_models (year); 