-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 08, 2024 at 04:52 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS M321;
USE M321;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `M321`
--

-- --------------------------------------------------------

--
-- Table structure for table `Articles`
--

CREATE TABLE `Articles` (
  `ArticleID` int(11) NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CategoryID` int(11) DEFAULT NULL,
  `Price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Articles`
--

INSERT INTO `Articles` (`ArticleID`, `Name`, `CategoryID`, `Price`) VALUES
(2, 'Branchli', 3, 1.50),
(3, 'Spanisch Brötli', 3, 4.99),
(4, 'Badener Steine', 2, 5.49),
(5, 'Luxemburgerli', 2, 3.99),
(6, 'Schoggi', 3, 6.99);

-- --------------------------------------------------------

--
-- Table structure for table `Categories`
--

CREATE TABLE `Categories` (
  `CategoryID` int(11) NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Categories`
--

INSERT INTO `Categories` (`CategoryID`, `Name`, `Description`) VALUES
(2, 'Clothing', 'Bling to wear'),
(3, 'Chocolates', 'Fine Swiss chocolates from Baden and Zurich.'),
(4, 'Cookies', 'Traditional Swiss cookies, crafted with care.'),
(5, 'Pastries', 'Delicious pastries from local Swiss bakeries.');

-- --------------------------------------------------------

--
-- Table structure for table `Clients`
--

CREATE TABLE `Clients` (
  `ClientID` int(11) NOT NULL,
  `Firstname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Lastname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Clients`
--

INSERT INTO `Clients` (`ClientID`, `Firstname`, `Email`, `Phone`, `Lastname`) VALUES
(2, 'Jon', 'j@f.com', '12341245', 'Foo'),
(3, 'Alice', 'alice@example.com', '123456789', 'Smith'),
(4, 'Bob', 'bob@example.ch', '987654321', 'Brown'),
(5, 'Carol', 'carol@example.ch', '555555555', 'Johnson');

-- --------------------------------------------------------

--
-- Table structure for table `OrderDetails`
--

CREATE TABLE `OrderDetails` (
  `OrderDetailID` int(11) NOT NULL,
  `OrderID` int(11) DEFAULT NULL,
  `ArticleID` int(11) DEFAULT NULL,
  `Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `OrderDetails`
--

INSERT INTO `OrderDetails` (`OrderDetailID`, `OrderID`, `ArticleID`, `Quantity`) VALUES
(4, 4, 6, 10),
(5, 4, 2, 5),
(6, 2, 3, 20),
(7, 2, 4, 10),
(8, 3, 5, 15);

-- --------------------------------------------------------

--
-- Table structure for table `Orders`
--

CREATE TABLE `Orders` (
  `OrderID` int(11) NOT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `OrderDate` datetime(3) NOT NULL,
  `Status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Orders`
--

INSERT INTO `Orders` (`OrderID`, `ClientID`, `OrderDate`, `Status`) VALUES
(2, 2, '2024-02-01 10:00:00.000', 1),
(3, 3, '2024-02-02 15:30:00.000', 2),
(4, 4, '2024-02-03 12:45:00.000', 3);

-- --------------------------------------------------------

--
-- Table structure for table `OrderStatuses`
--

CREATE TABLE `OrderStatuses` (
  `StatusID` int(11) NOT NULL,
  `Status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `OrderStatuses`
--

INSERT INTO `OrderStatuses` (`StatusID`, `Status`) VALUES
(1, 'Open'),
(3, 'Paid'),
(2, 'Prepared'),
(4, 'Processed');

-- --------------------------------------------------------

--
-- Table structure for table `Stock`
--

CREATE TABLE `Stock` (
  `ArticleID` int(11) NOT NULL,
  `WarehouseID` int(11) NOT NULL,
  `Stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Stock`
--

INSERT INTO `Stock` (`ArticleID`, `WarehouseID`, `Stock`) VALUES
(6, 1, 100),
(2, 1, 150),
(3, 2, 200),
(4, 2, 80),
(5, 1, 60),
(2, 2, 50);

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`UserID`, `Username`, `Password`) VALUES
(0, 'Test', 'test');

-- --------------------------------------------------------

--
-- Table structure for table `Warehouses`
--

CREATE TABLE `Warehouses` (
  `WarehouseID` int(11) NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Warehouses`
--

INSERT INTO `Warehouses` (`WarehouseID`, `Name`, `Location`) VALUES
(1, 'Zurich1', 'Zurich'),
(2, 'Zurich2', 'Zurich'),
(3, 'Hauptlager', 'Baden'),
(4, 'Zentrallager Asien', 'Singapur'),
(5, 'Zentrallager Nordamerika', 'New Jersey');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Articles`
--
ALTER TABLE `Articles`
  ADD PRIMARY KEY (`ArticleID`),
  ADD KEY `CategoryID` (`CategoryID`);

--
-- Indexes for table `Categories`
--
ALTER TABLE `Categories`
  ADD PRIMARY KEY (`CategoryID`);

--
-- Indexes for table `Clients`
--
ALTER TABLE `Clients`
  ADD PRIMARY KEY (`ClientID`);

--
-- Indexes for table `OrderDetails`
--
ALTER TABLE `OrderDetails`
  ADD PRIMARY KEY (`OrderDetailID`),
  ADD KEY `ArticleID` (`ArticleID`),
  ADD KEY `OrderID` (`OrderID`);

--
-- Indexes for table `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `ClientID` (`ClientID`),
  ADD KEY `FK_Orders_Statuses` (`Status`);

--
-- Indexes for table `OrderStatuses`
--
ALTER TABLE `OrderStatuses`
  ADD PRIMARY KEY (`StatusID`),
  ADD UNIQUE KEY `Status` (`Status`);

--
-- Indexes for table `Stock`
--
ALTER TABLE `Stock`
  ADD KEY `FK_Stock_Articles` (`ArticleID`),
  ADD KEY `FK_Stock_Warehouses` (`WarehouseID`);

--
-- Indexes for table `Warehouses`
--
ALTER TABLE `Warehouses`
  ADD PRIMARY KEY (`WarehouseID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Articles`
--
ALTER TABLE `Articles`
  MODIFY `ArticleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `Categories`
--
ALTER TABLE `Categories`
  MODIFY `CategoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Clients`
--
ALTER TABLE `Clients`
  MODIFY `ClientID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `OrderDetails`
--
ALTER TABLE `OrderDetails`
  MODIFY `OrderDetailID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `Orders`
--
ALTER TABLE `Orders`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Warehouses`
--
ALTER TABLE `Warehouses`
  MODIFY `WarehouseID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Articles`
--
ALTER TABLE `Articles`
  ADD CONSTRAINT `Articles_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `Categories` (`CategoryID`);

--
-- Constraints for table `OrderDetails`
--
ALTER TABLE `OrderDetails`
  ADD CONSTRAINT `OrderDetails_ibfk_1` FOREIGN KEY (`ArticleID`) REFERENCES `Articles` (`ArticleID`),
  ADD CONSTRAINT `OrderDetails_ibfk_2` FOREIGN KEY (`OrderID`) REFERENCES `Orders` (`OrderID`);

--
-- Constraints for table `Orders`
--
ALTER TABLE `Orders`
  ADD CONSTRAINT `FK_Orders_Statuses` FOREIGN KEY (`Status`) REFERENCES `OrderStatuses` (`StatusID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Orders_ibfk_1` FOREIGN KEY (`ClientID`) REFERENCES `Clients` (`ClientID`);

--
-- Constraints for table `Stock`
--
ALTER TABLE `Stock`
  ADD CONSTRAINT `FK_Stock_Articles` FOREIGN KEY (`ArticleID`) REFERENCES `Articles` (`ArticleID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Stock_Warehouses` FOREIGN KEY (`WarehouseID`) REFERENCES `Warehouses` (`WarehouseID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- Create the new user with the specified password
CREATE USER 'pw_checker'@'localhost' IDENTIFIED BY 'pw_checker';
CREATE USER 'warehouse_admin'@'localhost' IDENTIFIED BY 'whadmin';
-- Grant SELECT permission on the USERS table to the new user
GRANT SELECT ON M321.Users TO 'pw_checker'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON M321.* TO 'warehouse_admin'@'localhost';

-- Apply the changes
FLUSH PRIVILEGES;
