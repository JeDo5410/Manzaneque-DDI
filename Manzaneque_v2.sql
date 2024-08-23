
-- -----------------------------------------------------
-- Schema manzaneque
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `manzaneque` DEFAULT CHARACTER SET utf8mb4 ;
USE `manzaneque` ;

-- -----------------------------------------------------
-- Table `manzaneque`.`equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manzaneque`.`equipment` (
  `Equipment_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Equipment_Type` VARCHAR(45) NOT NULL,
  `Equipment_Make` VARCHAR(45) NOT NULL,
  `License_Status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Equipment_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `manzaneque`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manzaneque`.`department` (
  `Department_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Department_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Department_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `manzaneque`.`job_title`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manzaneque`.`job_title` (
  `Job_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Job_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Job_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `manzaneque`.`personnel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manzaneque`.`personnel` (
  `Personnel_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Personnel_Name` VARCHAR(45) NOT NULL,
  `equipment_Equipment_ID` INT(11) NOT NULL,
  `department_Department_ID` INT(11) NOT NULL,
  `job_title_Job_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Personnel_ID`),
  INDEX `fk_personnel_equipment1_idx` (`equipment_Equipment_ID` ASC) ,
  INDEX `fk_personnel_department1_idx` (`department_Department_ID` ASC) ,
  INDEX `fk_personnel_job_title1_idx` (`job_title_Job_ID` ASC) ,
  CONSTRAINT `fk_personnel_equipment1`
    FOREIGN KEY (`equipment_Equipment_ID`)
    REFERENCES `manzaneque`.`equipment` (`Equipment_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personnel_department1`
    FOREIGN KEY (`department_Department_ID`)
    REFERENCES `manzaneque`.`department` (`Department_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personnel_job_title1`
    FOREIGN KEY (`job_title_Job_ID`)
    REFERENCES `manzaneque`.`job_title` (`Job_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `manzaneque`.`Login_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manzaneque`.`Login_Details` (
  `LoginDetails_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) ,
  PRIMARY KEY (`LoginDetails_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `manzaneque`.`operator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manzaneque`.`operator` (
  `Operator_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Operator_Name` VARCHAR(45) NOT NULL,
  `Login_Details_LoginDetails_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Operator_ID`),
  INDEX `fk_operator_Login_Details1_idx` (`Login_Details_LoginDetails_ID` ASC) ,
  CONSTRAINT `fk_operator_Login_Details1`
    FOREIGN KEY (`Login_Details_LoginDetails_ID`)
    REFERENCES `manzaneque`.`Login_Details` (`LoginDetails_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `manzaneque`.`problem_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manzaneque`.`problem_type` (
  `ProblemType_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `ProblemType_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ProblemType_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `manzaneque`.`specialty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manzaneque`.`specialty` (
  `Specialty_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Specialty_Name` VARCHAR(45) NOT NULL,
  `problem_type_ProblemType_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Specialty_ID`),
  INDEX `fk_specialty_problem_type1_idx` (`problem_type_ProblemType_ID` ASC) ,
  CONSTRAINT `fk_specialty_problem_type1`
    FOREIGN KEY (`problem_type_ProblemType_ID`)
    REFERENCES `manzaneque`.`problem_type` (`ProblemType_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `manzaneque`.`specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manzaneque`.`specialist` (
  `Specialist_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Specialist_Name` VARCHAR(45) NOT NULL,
  `specialty_Specialty_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Specialist_ID`),
  INDEX `fk_specialist_specialty1_idx` (`specialty_Specialty_ID` ASC) ,
  CONSTRAINT `fk_specialist_specialty1`
    FOREIGN KEY (`specialty_Specialty_ID`)
    REFERENCES `manzaneque`.`specialty` (`Specialty_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `manzaneque`.`Problem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manzaneque`.`Problem` (
  `Problem_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Notes` TINYTEXT NOT NULL,
  `Descriptions` TEXT NOT NULL,
  `DateTime_Resolved` DATETIME NOT NULL,
  `Resolution_Description` text NOT NULL,
  `Status` varchar(15) NOT NULL,
  `operator_Operator_ID` INT(11) NOT NULL,
  `personnel_Personnel_ID` INT(11) NOT NULL,
  `specialist_Specialist_ID` INT(11) NULL,
  `problem_type_ProblemType_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Problem_ID`),
  INDEX `fk_problem_operator1_idx` (`operator_Operator_ID` ASC) ,
  INDEX `fk_problem_personnel1_idx` (`personnel_Personnel_ID` ASC) ,
  INDEX `fk_problem_specialist1_idx` (`specialist_Specialist_ID` ASC) ,
  INDEX `fk_problem_problem_type1_idx` (`problem_type_ProblemType_ID` ASC) ,
  CONSTRAINT `fk_problem_operator1`
    FOREIGN KEY (`operator_Operator_ID`)
    REFERENCES `manzaneque`.`operator` (`Operator_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_problem_personnel1`
    FOREIGN KEY (`personnel_Personnel_ID`)
    REFERENCES `manzaneque`.`personnel` (`Personnel_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_problem_specialist1`
    FOREIGN KEY (`specialist_Specialist_ID`)
    REFERENCES `manzaneque`.`specialist` (`Specialist_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_problem_problem_type1`
    FOREIGN KEY (`problem_type_ProblemType_ID`)
    REFERENCES `manzaneque`.`problem_type` (`ProblemType_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `manzaneque`.`Call`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manzaneque`.`Call` (
  `Call_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Call_Time` DATETIME NOT NULL,
  `Computer_SN` VARCHAR(45) NOT NULL,
  `personnel_Personnel_ID` INT(11) NOT NULL,
  `operator_Operator_ID` INT(11) NOT NULL,
  `problem_Problem_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Call_ID`),
  INDEX `fk_Call_problem1_idx` (`problem_Problem_ID` ASC) ,
  INDEX `fk_Call_personnel1_idx` (`personnel_Personnel_ID` ASC) ,
  INDEX `fk_Call_operator1_idx` (`operator_Operator_ID` ASC) ,
  CONSTRAINT `fk_Call_personnel1`
    FOREIGN KEY (`personnel_Personnel_ID`)
    REFERENCES `manzaneque`.`personnel` (`Personnel_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Call_operator1`
    FOREIGN KEY (`operator_Operator_ID`)
    REFERENCES `manzaneque`.`operator` (`Operator_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Call_problem1`
    FOREIGN KEY (`problem_Problem_ID`)
    REFERENCES `manzaneque`.`Problem` (`Problem_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `manzaneque`.`Call_Problem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manzaneque`.`Call_Problem` (
  `Call_ID` INT(11) NOT NULL,
  `Problem_ID` INT(11) NOT NULL,
  INDEX `Problem_ID` (`Problem_ID` ASC) ,
  UNIQUE INDEX `Call_ID_UNIQUE` (`Call_ID` ASC) ,
  UNIQUE INDEX `Problem_ID_UNIQUE` (`Problem_ID` ASC) ,
  CONSTRAINT `is_associated_with_ibfk_1`
    FOREIGN KEY (`Call_ID`)
    REFERENCES `manzaneque`.`Call` (`Call_ID`),
  CONSTRAINT `is_associated_with_ibfk_2`
    FOREIGN KEY (`Problem_ID`)
    REFERENCES `manzaneque`.`Problem` (`Problem_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


INSERT INTO department (Department_Name) VALUES
('Residential Property Management'),
('Commercial Property Management'),
('Industrial Property Management'),
('Land Development'),
('Brokerage Services'),
('Lending Services'),
('Legal Services'),
('Interior Design'),
('Construction');

INSERT INTO job_title (job_name) VALUES
('Residential Property Manager'),
('Leasing Consultant'),
('Maintenance Technician'),
('Commercial Property Manager'),
('Leasing Agent'),
('Building Engineer'),
('Industrial Property Manager'),
('Asset Manager'),
('Facilities Manager'),
('Land Development Manager'),
('Project Coordinator'),
('Civil Engineer'),
('Real Estate Broker'),
('Sales Associate'),
('Client Relations Manager'),
('Loan Officer'),
('Mortgage Consultant'),
('Credit Analyst'),
('Real Estate Attorney'),
('Paralegal'),
('Legal Secretary'),
('Interior Designer'),
('Design Consultant'),
('Project Manager'),
('Construction Manager'),
('Site Supervisor'),
('Safety Officer'),
('IT Helpdesk Specialist'),
('Systems Administrator'),
('IT Support Technician');

INSERT INTO Equipment (Equipment_Type, Equipment_Make, License_Status) VALUES
('Desktop Computer', 'Dell', 'Licensed'),
('Laptop', 'HP', 'Licensed'),
('Printer', 'Canon', 'Not Licensed'),
('Server', 'IBM', 'Licensed'),
('Router', 'Cisco', 'Not Licensed'),
('Switch', 'Netgear', 'Licensed'),
('Firewall', 'Fortinet', 'Licensed'),
('Scanner', 'Epson', 'Licensed'),
('Projector', 'Sony', 'Not Licensed'),
('VoIP Phone', 'Polycom', 'Licensed'),
('Wireless Access Point', 'Ubiquiti', 'Licensed'),
('NAS Storage', 'Synology', 'Not Licensed'),
('Workstation', 'Lenovo', 'Licensed'),
('Tablet', 'Microsoft Surface', 'Licensed');

INSERT INTO Personnel (Personnel_Name, equipment_Equipment_ID, department_Department_ID, job_title_Job_ID) VALUES
('Alice Thompson', 1, 1, 1),
('Bob Johnson', 2, 2, 2),
('Charlie Brown', 3, 3, 3),
('Daisy Miller', 4, 4, 4),
('Eddie Davis', 5, 5, 5),
('Fiona Wilson', 6, 6, 6),
('George Taylor', 7, 7, 7),
('Hannah Anderson', 8, 8, 8),
('Ivan Thomas', 9, 9, 9),
('Jasmine Jackson', 10, 1, 10),
('Kyle White', 11, 2, 11),
('Lily Harris', 12, 3, 12),
('Mason Martin', 13, 4, 13),
('Nina Thompson', 14, 5, 14),
('Oscar Garcia', 1, 6, 15),
('Penny Martinez', 2, 7, 16),
('Quincy Robinson', 3, 8, 17),
('Rita Clark', 4, 9, 18),
('Sam Rodriguez', 5, 1, 19),
('Tina Lewis', 6, 2, 20),
('Ursula Lee', 7, 3, 21),
('Victor Walker', 8, 4, 22),
('Wendy Hall', 9, 5, 23),
('Xavier Young', 10, 6, 24),
('Yvonne Allen', 11, 7, 25),
('Zachary Wright', 12, 8, 26),
('Amelia Scott', 13, 9, 27),
('Benjamin Green', 14, 1, 28),
('Catherine Adams', 1, 2, 29),
('Daniel Baker', 2, 3, 30),
('Fiona Nelson', 4, 5, 1),
('George Carter', 5, 6, 2),
('Hannah Mitchell', 6, 7, 3),
('Ivan Perez', 7, 8, 4),
('Jasmine Roberts', 8, 9, 5),
('Kyle Turner', 9, 1, 6),
('Lily Phillips', 10, 2, 7),
('Mason Campbell', 11, 3, 8),
('Nina Parker', 12, 4, 9),
('Oscar Evans', 13, 5, 10),
('Penny Edwards', 14, 6, 11),
('Quincy Collins', 1, 7, 12),
('Rita Stewart', 2, 8, 13),
('Sam Ford', 3, 9, 14),
('Tina Morris', 4, 1, 15),
('Ursula Howard', 5, 2, 16),
('Victor Watson', 6, 3, 17),
('Wendy Bailey', 7, 4, 18),
('Xavier Brooks', 8, 5, 19),
('Yvonne Reed', 9, 6, 20),
('Zachary Cooper', 10, 7, 21),
('Amelia Clark', 11, 8, 22),
('Benjamin James', 12, 9, 23),
('Catherine Murphy', 13, 1, 24),
('Daniel Bailey', 14, 2, 25),
('Evelyn Rivera', 1, 3, 26),
('Frank Coleman', 2, 4, 27),
('Grace Henderson', 3, 5, 28),
('Harry Simmons', 4, 6, 29),
('Irene Perry', 5, 7, 30);

INSERT INTO Login_Details (Username, Password) 
VALUES 
('JohnDoe', 'password1'),
('JaneSmith', 'password2'),
('RobertJohnson', 'password3'),
('MaryWilliams', 'password4'),
('JamesBrown', 'password5'),
('PatriciaDavis', 'password6'),
('MichaelMiller', 'password7'),
('LindaWilson', 'password8'),
('WilliamMoore', 'password9'),
('ElizabethTaylor', 'password10');


INSERT INTO Operator (Operator_Name, Login_Details_LoginDetails_ID) 
VALUES 
('John Doe', 1),
('Jane Smith', 2),
('Robert Johnson', 3),
('Mary Williams', 4),
('James Brown', 5),
('Patricia Davis', 6),
('Michael Miller', 7),
('Linda Wilson', 8),
('William Moore', 9),
('Elizabeth Taylor', 10);


INSERT INTO Problem_Type (ProblemType_ID, ProblemType_Name) 
VALUES 
(1, 'Software Issue'),
(2, 'Hardware Issue'),
(3, 'Network Issue'),
(4, 'Security Issue'),
(5, 'Database Issue'),
(6, 'Email Issue'),
(7, 'Printing Issue'),
(8, 'Login Issue'),
(9, 'Performance Issue'),
(10, 'Other Issue');

INSERT INTO Specialty (Specialty_Name, problem_type_ProblemType_ID) 
VALUES 
('Software Specialist', 1),
('Hardware Specialist', 2),
('Network Specialist', 3),
('Security Specialist', 4),
('Database Specialist', 5),
('Email Specialist', 6),
('Printing Specialist', 7),
('Login Specialist', 8),
('Performance Specialist', 9),
('General IT Specialist', 10);

INSERT INTO Specialist (Specialist_Name, specialty_Specialty_ID) 
VALUES 
('John Doe', 1),
('Jane Smith', 2),
('Robert Johnson', 3),
('Mary Williams', 4),
('James Brown', 5),
('Patricia Davis', 6),
('Michael Miller', 7),
('Linda Wilson', 8),
('William Moore', 9),
('Elizabeth Taylor', 10),
('David Anderson', 1),
('Jennifer Thomas', 2),
('Charles Jackson', 3),
('Barbara White', 4),
('Susan Harris', 5),
('Jessica Martin', 6),
('Sarah Thompson', 7),
('Karen Garcia', 8),
('Nancy Martinez', 9),
('Lisa Robinson', 10);

INSERT INTO Problem (Notes, Descriptions, DateTime_Resolved, Resolution_Description, `Status`, operator_Operator_ID, personnel_Personnel_ID, specialist_Specialist_ID, problem_type_ProblemType_ID) 
VALUES 
('Software crash during data entry', 'The software crashed unexpectedly during data entry, losing all unsaved work.', '2023-12-20 12:00:00', 'Updated the software to the latest version which fixed the bug causing the crash.', 'Resolved', 1, 1, 1, 1),
('Cannot connect to network printer', 'The computer cannot connect to the network printer, error code 1234.', '2023-12-20 12:30:00', 'Restarted the print spooler service on the computer, which resolved the issue.', 'Resolved', 2, 2, 2, 2),
('Emails not syncing', 'Emails are not syncing on the computer. Last sync was two days ago.', '2023-12-20 13:00:00', 'Issue currently unresolved. Specialist is investigating.', 'Unresolved', 3, 3, 3, 3),
('Slow computer performance', 'The computer is running very slow, taking a long time to open applications.', '2023-12-20 13:30:00', 'Issue currently unresolved. Specialist is investigating.', 'Unresolved', 4, 4, 4, 4),
('Cannot open database', 'The database cannot be opened, showing error "Database is locked".', '2023-12-20 14:00:00', 'Restarted the database service, which resolved the issue.', 'Resolved', 5, 5, 5, 5),
('Software update failed', 'Attempted to update software but it failed with error code 5678.', '2023-12-20 14:30:00', 'Downloaded and installed the update manually, which resolved the issue.', 'Resolved', 6, 6, 6, 1),
('Cannot connect to VPN', 'Unable to connect to the VPN, error message "VPN server not responding".', '2023-12-20 15:00:00', 'Issue currently unresolved. Specialist is investigating.', 'Unresolved', 7, 7, 7, 3),
('Database query error', 'A database query is returning an error "Syntax error near line 1".', '2023-12-20 15:30:00', 'Corrected the syntax error in the query, which resolved the issue.', 'Resolved', 8, 8, 8, 5),
('Emails going to spam', 'Outgoing emails are being marked as spam by recipients.', '2023-12-20 16:00:00', 'Issue currently unresolved. Specialist is investigating.', 'Unresolved', 9, 9, 9, 6),
('Slow network speed', 'The network speed is very slow, affecting all network operations.', '2023-12-20 16:30:00', 'Restarted the network router, which resolved the issue.', 'Resolved', 10, 10, 10, 3),
('Computer won\'t start', 'The computer won\'t start, no power light.', '2023-12-20 17:00:00', 'Replaced the power supply unit, which resolved the issue.', 'Resolved', 1, 11, 11, 2),
('Cannot install software', 'Unable to install software, error message "Insufficient disk space".', '2023-12-20 17:30:00', 'Freed up disk space by deleting unnecessary files, which resolved the issue.', 'Resolved', 2, 12, 12, 1),
('Printer not printing', 'The printer is not printing, error message "Paper jam".', '2023-12-20 18:00:00', 'Removed the jammed paper from the printer, which resolved the issue.', 'Resolved', 3, 13, 13, 7),
('Cannot open spreadsheet', 'Unable to open a spreadsheet file, error message "File format not recognized".', '2023-12-20 18:30:00', 'Issue currently unresolved. Specialist is investigating.', 'Unresolved', 4, 14, 14, 1),
('Website not loading', 'A website is not loading, error message "Server not found".', '2023-12-20 19:00:00', 'Issue currently unresolved. Specialist is investigating.', 'Unresolved', 5, 15, 15, 3);

INSERT INTO `Call` (Call_Time, Computer_SN, personnel_Personnel_ID, operator_Operator_ID, problem_Problem_ID) 
VALUES 
('2023-12-20 11:45:00', 'SN001', 1, 1, 1),
('2023-12-20 12:15:00', 'SN002', 2, 2, 2),
('2023-12-20 12:45:00', 'SN003', 3, 3, 3),
('2023-12-20 13:15:00', 'SN004', 4, 4, 4),
('2023-12-20 13:45:00', 'SN005', 5, 5, 5),
('2023-12-20 14:15:00', 'SN006', 6, 6, 6),
('2023-12-20 14:45:00', 'SN007', 7, 7, 7),
('2023-12-20 15:15:00', 'SN008', 8, 8, 8),
('2023-12-20 15:45:00', 'SN009', 9, 9, 9),
('2023-12-20 16:15:00', 'SN010', 10, 10, 10),
('2023-12-20 16:45:00', 'SN011', 11, 1, 11),
('2023-12-20 17:15:00', 'SN012', 12, 2, 12),
('2023-12-20 17:45:00', 'SN013', 13, 3, 13),
('2023-12-20 18:15:00', 'SN014', 14, 4, 14),
('2023-12-20 18:45:00', 'SN015', 15, 5, 15);

INSERT INTO Call_Problem (Call_ID, Problem_ID) 
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15);

DELIMITER //
CREATE PROCEDURE CheckEquipmentLicense(IN p_PersonnelID INT)
BEGIN
  DECLARE v_LicenseStatus VARCHAR(255);

  SELECT e.License_Status INTO v_LicenseStatus
  FROM Personnel p
  JOIN Equipment e ON p.equipment_Equipment_ID = e.Equipment_ID
  WHERE p.Personnel_ID = p_PersonnelID;

  IF v_LicenseStatus = 'Not licensed' THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Error: The equipment used by the personnel is not licensed.';
  ELSE
    SELECT 'The equipment used by the personnel is licensed.' AS Message;
  END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER username_to_lowercase
BEFORE INSERT ON login_details
FOR EACH ROW
BEGIN
   SET NEW.username = LOWER(NEW.username);
END; //
DELIMITER ;