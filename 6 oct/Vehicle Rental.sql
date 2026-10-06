CREATE TABLE vehicles 
(
vehicle_id INT PRIMARY KEY,
vehicle_name VARCHAR(100),
vehicle_type VARCHAR(50),
daily_rate DECIMAL(10,2),
available_status VARCHAR(20)
);
INSERT INTO vehicles VALUES
(1, 'Honda City', 'Car', 2500, 'Available'),
(2, 'Toyota Innova', 'Car', 3500, 'Available'),
(3, 'Royal Enfield', 'Bike', 1200, 'Rented'),
(4, 'Activa', 'Scooter', 700, 'Available'),
(5, 'Mahindra Thar', 'SUV', 4500, 'Rented'),
(6, 'Hyundai Creta', 'SUV', 3200, 'Available'),
(7, 'KTM Duke', 'Bike', 1500, 'Available');
DELIMITER //
-- EXERCISE 1
CREATE PROCEDURE GetAllVehicles()
BEGIN
    SELECT * FROM vehicles;
END //
CALL GetAllVehicles();
-- EXERCISE 2
CREATE PROCEDURE GetAvailableVehicles()
BEGIN
    SELECT * FROM vehicles WHERE available_status = 'Available';
END //
CALL GetAvailableVehicles();
-- EXERCISE 3
CREATE PROCEDURE GetVehiclesByType(IN v_type VARCHAR(50))
BEGIN
    SELECT * FROM vehicles WHERE vehicle_type = v_type;
END //
CALL GetVehiclesByType('Car');
-- EXERCISE 4
CREATE PROCEDURE GetVehiclesByMaxRate(IN max_rate DECIMAL(10,2))
BEGIN
    SELECT * FROM vehicles WHERE daily_rate <= max_rate;
END //
CALL GetVehiclesByMaxRate(2000.00);
-- EXERCISE 5
CREATE PROCEDURE UpdateVehicleRate(IN v_id INT, IN new_rate DECIMAL(10,2))
BEGIN
    UPDATE vehicles SET daily_rate = new_rate WHERE vehicle_id = v_id;
END //
CALL UpdateVehicleRate(1, 2600.00);
-- EXERCISE 6
CREATE PROCEDURE UpdateVehicleStatus(IN v_id INT, IN new_status VARCHAR(20))
BEGIN
    UPDATE vehicles SET available_status = new_status WHERE vehicle_id = v_id;
END //
CALL UpdateVehicleStatus(3, 'Available');
-- EXERCISE 7
CREATE PROCEDURE IncreaseRateByPercentage(IN pct DECIMAL(5,2))
BEGIN
    UPDATE vehicles SET daily_rate = daily_rate * (1 + (pct / 100));
END //
CALL IncreaseRateByPercentage(10.00);
-- EXERCISE 8
CREATE PROCEDURE DeleteVehicleById(IN v_id INT)
BEGIN
    DELETE FROM vehicles WHERE vehicle_id = v_id;
END //
CALL DeleteVehicleById(7);
-- EXERCISE 9
CREATE PROCEDURE GetVehiclesInRateRange(IN min_rate DECIMAL(10,2), IN max_rate DECIMAL(10,2))
BEGIN
    SELECT * FROM vehicles WHERE daily_rate BETWEEN min_rate AND max_rate;
END //
CALL GetVehiclesInRateRange(1000.00, 3000.00);
-- EXERCISE 10
CREATE PROCEDURE CountVehiclesByType(IN v_type VARCHAR(50), OUT total_count INT)
BEGIN
    SELECT COUNT(*) INTO total_count FROM vehicles WHERE vehicle_type = v_type;
END //
CALL CountVehiclesByType('SUV', @total_suvs);
SELECT @total_suvs AS total_suv_count;
DELIMITER ;