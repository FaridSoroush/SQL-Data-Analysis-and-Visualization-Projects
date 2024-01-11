/* SIDE NOTE: Compare performance of the query rows by using Explain Icon first (Before Indexing and After Indexing)*/

/* Create index on accident_index as it is using in both vehicles and accident tables and join clauses using indexes will perform faster */
/* Create index on accident_index in the accident table */
CREATE INDEX idx_accident_accident_index
ON accident(accident_index);

/* Create index on accident_index in the vehicles table */
CREATE INDEX idx_vehicles_accident_index
ON vehicles(accident_index);



/* get Accident Severity and Total Accidents per Vehicle Type */
SELECT vt.vehicle_type AS 'Vehicle Type', a.accident_severity AS 'Severity', COUNT(vt.vehicle_type) AS 'Number of Accidents'
FROM accident a
JOIN vehicles v ON a.accident_index = v.accident_index
JOIN vehicle_types vt ON v.vehicle_type = vt.vehicle_code
GROUP BY vt.vehicle_type, a.accident_severity
ORDER BY vt.vehicle_type, a.accident_severity, COUNT(vt.vehicle_type);


/* Average Severity by vehicle type */
SELECT vt.vehicle_type AS 'Vehicle Type', AVG(a.accident_severity) AS 'Average Severity', COUNT(vt.vehicle_type) AS 'Number of Accidents'
FROM accident a
JOIN vehicles v ON a.accident_index = v.accident_index
JOIN vehicle_types vt ON v.vehicle_type = vt.vehicle_code
GROUP BY 1
ORDER BY 2,3;


/* Average Severity and Total Accidents by Motorcyle */
SELECT vt.vehicle_type AS 'Vehicle Type', AVG(a.accident_severity) AS 'Average Severity', COUNT(vt.vehicle_type) AS 'Number of Accidents'
FROM accident a
JOIN vehicles v ON a.accident_index = v.accident_index
JOIN vehicle_types vt ON v.vehicle_type = vt.vehicle_code
WHERE vt.vehicle_type LIKE '%otorcycle%'
GROUP BY 1
ORDER BY 2,3;
