-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema doranstockV2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema doranstockV2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `doranstockV2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `doranstockV2` ;

-- -----------------------------------------------------
-- Table `doranstockV2`.`customert`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doranstockV2`.`customert` (
  `CustomerID` VARCHAR(50) NOT NULL,
  `CustomerName` VARCHAR(50) NOT NULL,
  `CustomerAddress` VARCHAR(50) NOT NULL,
  `CustomerCounty` VARCHAR(50) NOT NULL,
  `CustomerCountry` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(50) NOT NULL,
  `Phone` INT NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doranstockV2`.`locationt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doranstockV2`.`locationt` (
  `LocationID` VARCHAR(50) NOT NULL,
  `LocationType` VARCHAR(50) NOT NULL,
  `Nursery` VARCHAR(50) NOT NULL,
  `LocationSize` DOUBLE NULL DEFAULT NULL,
  `Capacity` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`LocationID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doranstockV2`.`potsizet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doranstockV2`.`potsizet` (
  `PotSizeID` VARCHAR(50) NOT NULL,
  `Type` VARCHAR(50) NOT NULL,
  `Area` DOUBLE NOT NULL,
  `AreaSpaced` DOUBLE NOT NULL,
  PRIMARY KEY (`PotSizeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doranstockV2`.`varietyt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doranstockV2`.`varietyt` (
  `VarietyID` VARCHAR(50) NOT NULL,
  `Variety` VARCHAR(50) NOT NULL,
  `Family` VARCHAR(50) NOT NULL,
  `Genus` VARCHAR(50) NOT NULL,
  `FamilyCode` VARCHAR(50) NOT NULL,
  `VarietyNumber` INT NULL DEFAULT NULL,
  PRIMARY KEY (`VarietyID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doranstockV2`.`productt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doranstockV2`.`productt` (
  `ProductID` VARCHAR(50) NOT NULL,
  `VarietyID` VARCHAR(50) NOT NULL,
  `PotSizeID` VARCHAR(50) NOT NULL,
  `AvailableStock` INT NULL DEFAULT '0',
  `StandardPrice` FLOAT NULL DEFAULT '2.2',
  `PlantStatus` VARCHAR(255) NULL DEFAULT NULL,
  `PriceWoodies` FLOAT(5,2) NULL DEFAULT NULL,
  `Price_band1` FLOAT(5,2) NULL DEFAULT NULL,
  `Price_band2` FLOAT(5,2) NULL DEFAULT NULL,
  `Price_band3` FLOAT(5,2) NULL DEFAULT NULL,
  `Price_band4` FLOAT(5,2) NULL DEFAULT NULL,
  `Price_band5` FLOAT(5,2) NULL DEFAULT NULL,
  `Price_band6` FLOAT(5,2) NULL DEFAULT NULL,
  `Price_band7` FLOAT(5,2) NULL DEFAULT NULL,
  PRIMARY KEY (`ProductID`),
  INDEX `fk_productt_variety_idx` (`VarietyID` ASC),
  INDEX `fk_productt_pot_idx` (`PotSizeID` ASC),
  CONSTRAINT `fk_productt_pot`
    FOREIGN KEY (`PotSizeID`)
    REFERENCES `doranstock`.`potsizet` (`PotSizeID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_productt_variety`
    FOREIGN KEY (`VarietyID`)
    REFERENCES `doranstock`.`varietyt` (`VarietyID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doranstockV2`.`stockt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doranstockV2`.`stockt` (
  `BatchNumber` int AUTO_INCREMENT,
  `ProductID` VARCHAR(50) NOT NULL,
  `Family` VARCHAR(50) NOT NULL,
  `Variety` VARCHAR(50) NOT NULL,
  `LocationID` VARCHAR(50) NOT NULL,
  `PotSizeID` VARCHAR(50) NOT NULL,
  `Quantity` INT NULL DEFAULT '0',
  `potdate` DATE NULL DEFAULT NULL,
  `Batch-1` VARCHAR(50) NULL DEFAULT NULL,
  `SupplierCode` VARCHAR(50) NULL DEFAULT 'DORAN',
  `WeekNumber` VARCHAR(10) NULL DEFAULT NULL,
  `potyear` INT NULL DEFAULT NULL,
  `Brand/Store` VARCHAR(50) NULL DEFAULT 'General',
  `BatchStatus` VARCHAR(50) NULL DEFAULT 'Growing',
  PRIMARY KEY (`BatchNumber`),
  INDEX `fk_stockt_Product_idx` (`ProductID` ASC),
  INDEX `fk_stockt_Location_idx` (`LocationID` ASC),
  INDEX `fk_stockt_pot_idx` (`PotSizeID` ASC),
  CONSTRAINT `fk_stockt_Location`
    FOREIGN KEY (`LocationID`)
    REFERENCES `doranstock`.`locationt` (`LocationID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_stockt_pot`
    FOREIGN KEY (`PotSizeID`)
    REFERENCES `doranstock`.`potsizet` (`PotSizeID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_stockt_Product`
    FOREIGN KEY (`ProductID`)
    REFERENCES `doranstock`.`productt` (`ProductID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doranstock`.`dumpt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doranstockV2`.`dumpt` (
  `DumpID` INT NOT NULL AUTO_INCREMENT,
  `BatchNumber` int NOT NULL,
  `Quantity` INT NULL DEFAULT '0',
  `Date` DATE NOT NULL,
  PRIMARY KEY (`DumpID`),
  INDEX `fk_Dumpt_stock_idx` (`BatchNumber` ASC),
  CONSTRAINT `fk_Dumpt_stock`
    FOREIGN KEY (`BatchNumber`)
    REFERENCES `doranstock`.`stockt` (`BatchNumber`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doranstock`.`employeet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doranstockV2`.`employeet` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `EmployeeName` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(50) NULL DEFAULT NULL,
  `Phone` INT NULL DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 23
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doranstock`.`inspectiont`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doranstockV2`.`inspectiont` (
  `InspectionID` INT NOT NULL AUTO_INCREMENT,
  `BatchNumber` int NOT NULL,
  `Issues` VARCHAR(2000) NOT NULL,
  `EmployeeID` INT NULL DEFAULT NULL,
  `Status` VARCHAR(100) NULL DEFAULT NULL,
  `StatusDate` DATE NOT NULL,
  PRIMARY KEY (`InspectionID`),
  INDEX `fk_inspectiont_stock_idx` (`BatchNumber` ASC),
  INDEX `fk_inspectiont_employee_idx` (`EmployeeID` ASC),
  CONSTRAINT `fk_inspectiont_Employee`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `doranstock`.`employeet` (`EmployeeID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_inspectiont_stock`
    FOREIGN KEY (`BatchNumber`)
    REFERENCES `doranstock`.`stockt` (`BatchNumber`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doranstock`.`movedt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doranstockV2`.`movedt` (
  `MovedID` INT NOT NULL AUTO_INCREMENT,
  `BatchNumber` int NOT NULL,
  `LocationID` VARCHAR(50) NOT NULL,
  `Quantity` INT NULL DEFAULT '0',
  `Date` DATE NOT NULL,
  PRIMARY KEY (`MovedID`),
  INDEX `fk_Movedt_stock_idx` (`BatchNumber` ASC),
  INDEX `fk_Movedt_location_idx` (`LocationID` ASC),
  CONSTRAINT `fk_Movedt_location`
    FOREIGN KEY (`LocationID`)
    REFERENCES `doranstock`.`locationt` (`LocationID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Movedt_stock`
    FOREIGN KEY (`BatchNumber`)
    REFERENCES `doranstock`.`stockt` (`BatchNumber`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doranstock`.`orderst`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doranstockV2`.`orderst` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` VARCHAR(50) NOT NULL,
  `BatchNumber` int NOT NULL,
  `Quantity` INT NULL DEFAULT '0',
  `Date` DATE DEFAULT (CURRENT_DATE),
  PRIMARY KEY (`OrderID`),
  INDEX `fk_ordert_stock_idx` (`BatchNumber` ASC),
  INDEX `fk_ordert_customer_idx` (`CustomerID` ASC),
  CONSTRAINT `fk_ordert_customer`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `doranstock`.`customert` (`CustomerID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ordert_stock`
    FOREIGN KEY (`BatchNumber`)
    REFERENCES `doranstock`.`stockt` (`BatchNumber`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doranstock`.`suppliert`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doranstockV2`.`suppliert` (
  `SupplierCode` VARCHAR(50) NOT NULL,
  `SupplierName` VARCHAR(50) NOT NULL,
  `Country` VARCHAR(50) NOT NULL,
  `GrowerID` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(50) NOT NULL,
  `Phone` INT NOT NULL,
  PRIMARY KEY (`SupplierCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `doranstockV2`;

DELIMITER $$
USE `doranstockV2`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `doranstockV2`.`ProductID_stockT`
BEFORE INSERT ON `doranstockV2`.`stockt`
FOR EACH ROW
BEGIN

SET NEW.Family = (select Family from varietyt v where v.variety = new.variety),
	@var1 = (select VarietyID from varietyt v where v.variety = new.variety),
    new.ProductID = CONCAT(new.PotsizeID, '-', @var1),
	NEW.potyear = RIGHT(YEAR(new.potdate),2),
    NEW.WeekNumber = WEEK(new.potdate);
    
End$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
