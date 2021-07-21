-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 21, 2021 at 04:43 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mendezengineering`
--

-- --------------------------------------------------------

--
-- Table structure for table `billings`
--

CREATE TABLE `billings` (
  `BillID` int(11) NOT NULL,
  `Amount` decimal(11,0) NOT NULL,
  `Date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `billings`
--

INSERT INTO `billings` (`BillID`, `Amount`, `Date`) VALUES
(1, '2000', '2020-07-21 00:00:00'),
(2, '5000', '2021-02-13 00:00:00'),
(3, '20000', '2020-10-07 00:00:00'),
(4, '10000', '2021-07-14 04:01:52'),
(5, '4320', '2021-07-19 17:46:16'),
(6, '1279', '2021-07-19 17:46:48'),
(7, '1203', '2021-07-19 17:55:59'),
(8, '2700', '2021-07-19 17:58:56'),
(9, '1584', '2021-07-19 18:28:29'),
(10, '1236', '2021-07-20 05:50:08'),
(11, '2472', '2021-07-20 05:52:53'),
(12, '7920', '2021-07-20 06:28:50'),
(13, '1920', '2021-07-20 14:11:45'),
(14, '43704', '2021-07-20 14:38:44'),
(15, '6720', '2021-07-20 14:40:57'),
(16, '60000480', '2021-07-20 14:44:52');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `CustID` int(11) NOT NULL,
  `FirstName` varchar(255) NOT NULL,
  `MiddleName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`CustID`, `FirstName`, `MiddleName`, `LastName`) VALUES
(1, '', '', ''),
(2, '', '', ''),
(3, '', '', ''),
(4, '', '', ''),
(5, '', '', ''),
(6, '', '', ''),
(7, '', '', ''),
(8, '', '', ''),
(9, '', '', ''),
(10, '', '', ''),
(11, '', '', ''),
(12, '', '', ''),
(13, '', '', ''),
(14, '', '', ''),
(15, '', '', ''),
(16, '', '', ''),
(17, '', '', ''),
(18, '', '', ''),
(19, '', '', ''),
(20, '', '', ''),
(21, '', '', ''),
(22, '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE `materials` (
  `MatID` int(11) NOT NULL,
  `MatDetailsID` int(11) NOT NULL,
  `MatListID` int(11) NOT NULL,
  `TotalPrice` decimal(11,0) NOT NULL,
  `MatQty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `materials`
--

INSERT INTO `materials` (`MatID`, `MatDetailsID`, `MatListID`, `TotalPrice`, `MatQty`) VALUES
(2, 2, 1, '400', 2),
(3, 1, 1, '400', 3),
(4, 2, 2, '400', 2),
(5, 3, 2, '500', 3),
(6, 9, 3, '200', 2),
(7, 1, 3, '100', 1),
(8, 9, 4, '200', 2),
(9, 1, 4, '100', 1),
(10, 9, 5, '200', 2),
(11, 1, 5, '100', 1),
(12, 9, 6, '200', 2),
(13, 1, 6, '100', 1),
(14, 1, 7, '2000', 20),
(15, 1, 8, '1000', 10),
(16, 1, 9, '1000', 10),
(17, 1, 10, '2000', 20),
(18, 1, 11, '1000', 10),
(19, 1, 12, '1000', 10),
(20, 1, 13, '2000', 20),
(21, 3, 14, '6000', 20),
(22, 3, 14, '300', 20),
(23, 1, 14, '1000', 10),
(24, 1, 14, '100', 10),
(25, 3, 14, '300', 20),
(26, 3, 14, '300', 20),
(27, 2, 14, '4000', 20),
(28, 2, 14, '200', 20),
(29, 3, 15, '300', 20),
(30, 3, 16, '300', 20),
(31, 1, 16, '2000', 20),
(32, 1, 17, '100', 20),
(33, 3, 17, '300', 20),
(34, 1, 18, '100', 20),
(35, 3, 18, '300', 20),
(36, 1, 19, '100', 20),
(37, 3, 19, '300', 20),
(38, 11, 20, '1000', 10),
(39, 2, 21, '8000', 40),
(40, 2, 21, '8000', 40),
(41, 11, 22, '5000', 50),
(42, 12, 23, '50000000', 50000),
(43, 11, 24, '100', 10),
(44, 14, 24, '1000', 1000),
(45, 11, 25, '100', 50),
(46, 12, 25, '10000', 10),
(47, 11, 27, '100', 10),
(48, 14, 27, '1', 1000),
(49, 11, 28, '100', 10),
(50, 14, 28, '1', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `mat_details`
--

CREATE TABLE `mat_details` (
  `MatDetailsID` int(11) NOT NULL,
  `ServiceID` int(11) DEFAULT NULL,
  `MatDescription` varchar(255) NOT NULL,
  `MatName` varchar(255) NOT NULL,
  `MatPrice` decimal(11,0) NOT NULL,
  `MatStatus` varchar(255) NOT NULL,
  `MatQuantity` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mat_details`
--

INSERT INTO `mat_details` (`MatDetailsID`, `ServiceID`, `MatDescription`, `MatName`, `MatPrice`, `MatStatus`, `MatQuantity`, `created`, `updated`, `deleted`) VALUES
(1, 2, 'Wood', 'Flooring', '100', 'IN STOCK', -104, NULL, NULL, NULL),
(2, 3, 'Tiles', 'Flooring', '200', 'IN STOCK', 20, NULL, NULL, NULL),
(3, 3, 'Chandelier', 'Ceiling', '300', 'IN STOCK', -60, NULL, NULL, NULL),
(8, 2, 'onilito4', 'onilito2', '69', 'HAHAY', 233323, NULL, NULL, NULL),
(9, 3, 'sample', 'sample', '200', 'sample', 192, NULL, NULL, NULL),
(10, 2, 's', 'asda', '2', 'a', 2, NULL, NULL, NULL),
(11, 1, '10x10', 'Roofing Material', '100', 'In Stock', -40, '2021-07-20 22:09:01', '2021-07-20 22:43:34', NULL),
(12, 1, 'Seen', 'Roof', '1000', 'In Stock', -49990, '2021-07-20 22:42:15', NULL, NULL),
(13, 1, 'None', 'None', '100', 'For Order', 100, '2021-07-20 22:43:01', NULL, NULL),
(14, 1, 'Hello', 'Roof', '1', 'In Stock', -2999, '2021-07-20 22:45:43', NULL, NULL),
(15, 1, 'Hello', 'Roof', '100', 'In Stock', 100, '2021-07-20 22:46:31', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mat_list`
--

CREATE TABLE `mat_list` (
  `MatListID` int(11) NOT NULL,
  `TotalListPrice` decimal(11,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mat_list`
--

INSERT INTO `mat_list` (`MatListID`, `TotalListPrice`) VALUES
(1, '800'),
(2, '900'),
(3, '300'),
(4, '300'),
(5, '300'),
(6, '300'),
(7, '2000'),
(8, '1000'),
(9, '1000'),
(10, '2000'),
(11, '1000'),
(12, '1000'),
(13, '2000'),
(14, '1600'),
(15, '1800'),
(16, '300'),
(17, '400'),
(18, '400'),
(19, '400'),
(20, '2000'),
(21, '16000'),
(22, '5000'),
(23, '50000000'),
(24, '100'),
(25, '100'),
(26, '0'),
(27, '101'),
(28, '101');

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `ProjectID` int(11) NOT NULL,
  `MatListID` int(11) NOT NULL,
  `ProjTypeID` int(11) NOT NULL,
  `ProjSiteID` int(11) NOT NULL,
  `ProjStart` datetime NOT NULL,
  `ProjEnd` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`ProjectID`, `MatListID`, `ProjTypeID`, `ProjSiteID`, `ProjStart`, `ProjEnd`) VALUES
(1, 1, 3, 4, '2017-08-25 00:00:00', '2019-08-25 00:00:00'),
(2, 2, 5, 2, '2020-10-05 00:00:00', '2022-02-02 00:00:00'),
(3, 2, 1, 2, '0000-00-00 00:00:00', '2020-02-20 00:00:00'),
(4, 3, 6, 5, '2021-08-13 23:59:59', '2021-08-15 23:59:59'),
(5, 4, 7, 6, '2021-08-13 23:59:59', '2021-08-15 23:59:59'),
(6, 5, 8, 7, '2021-08-13 23:59:59', '2021-08-15 23:59:59'),
(7, 6, 9, 8, '2021-08-13 23:59:59', '2021-08-15 23:59:59'),
(8, 7, 10, 9, '2021-07-19 00:00:00', '2021-07-19 00:00:00'),
(9, 8, 11, 10, '2021-07-19 00:00:00', '2021-07-19 00:00:00'),
(10, 9, 12, 11, '2021-07-19 00:00:00', '2021-07-19 00:00:00'),
(11, 10, 13, 12, '2021-07-19 00:00:00', '2021-07-19 00:00:00'),
(12, 11, 14, 13, '2021-07-19 00:00:00', '2021-07-19 00:00:00'),
(13, 12, 16, 15, '2021-07-20 00:00:00', '2021-07-20 00:00:00'),
(14, 13, 17, 16, '2021-07-20 00:00:00', '2021-07-20 00:00:00'),
(15, 19, 18, 17, '2021-07-20 00:00:00', '2021-07-20 00:00:00'),
(16, 28, 19, 18, '2021-07-21 00:00:00', '2021-07-21 00:00:00'),
(17, 21, 20, 19, '2021-07-20 00:00:00', '2021-07-21 00:00:00'),
(18, 25, 21, 20, '2021-07-20 00:00:00', '2021-07-20 00:00:00'),
(19, 23, 22, 21, '2021-07-20 00:00:00', '2021-07-20 00:00:00'),
(20, 26, 23, 22, '2021-07-21 00:00:00', '2021-07-21 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `project_site`
--

CREATE TABLE `project_site` (
  `ProjSiteID` int(11) NOT NULL,
  `City` varchar(255) NOT NULL,
  `Barangay` varchar(255) NOT NULL,
  `StreetNumber` varchar(255) NOT NULL,
  `PostalCode` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `project_site`
--

INSERT INTO `project_site` (`ProjSiteID`, `City`, `Barangay`, `StreetNumber`, `PostalCode`) VALUES
(1, 'Cebu City', 'Tisa', '251', '6000'),
(2, 'Davao City', 'Somewhere in Davao', '221 jupiter', '420'),
(3, 'Makati City', 'Makati barangay', '231', '69'),
(4, 'Argao', 'Gutlang', '61th avenue', '7000'),
(5, 'umayos', 'ka na sa', 'buhay mo', '123'),
(6, 'umayos', 'ka na sa', 'buhay mo', '123'),
(7, 'umayos', 'ka na sa', 'buhay mo', '123'),
(8, 'umayos', 'ka na sa', 'buhay mo', '123'),
(9, 'umayos2', 'ka na sa2', 'buhay mo22', '1232222'),
(10, 'umayos2', 'ka na sa2', 'buhay mo22', '1232222'),
(11, 'umayos2', 'ka na sa2', 'buhay mo22', '1232222'),
(12, 'umayos2', 'ka na sa2', 'buhay mo22', '1232222'),
(13, 'Cebu', 'Test 1', 'Buenavista Homes, Jugan', '6001'),
(14, 'Cebu', 'was', 'Buenavista Homes, Jugan', '6001'),
(15, 'Cebu', 'Test 1', 'Buenavista Homes, Jugan', '6001'),
(16, 'Cebu', 'test', 'Buenavista Homes, Jugan', '6001'),
(17, 'Cebu', 'Test 1', 'Buenavista Homes, Jugan', '6001'),
(18, 'Cebu', 'test', 'Buenavista Homes, Jugan', '6001'),
(19, 'City', 'Barangay', 'Street', '123'),
(20, 'Cebu', 'test', 'Buenavista Homes, Jugan', '6001'),
(21, 'Crt', 'Bara', 'Str', '21'),
(22, '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `project_type`
--

CREATE TABLE `project_type` (
  `ProjTypeID` int(11) NOT NULL,
  `ProjDesc` varchar(255) DEFAULT NULL,
  `ProjType` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `project_type`
--

INSERT INTO `project_type` (`ProjTypeID`, `ProjDesc`, `ProjType`) VALUES
(1, 'Flooring', 'Dummy'),
(2, 'Mason', 'Dummy'),
(3, 'Ceiling', 'Dummy'),
(4, 'Glass', 'Dummy'),
(5, 'Foundation', 'Dummy'),
(6, 'iyakan session', 'Flooring'),
(7, 'iyakan session', 'Flooring'),
(8, 'iyakan session', 'Flooring'),
(9, 'iyakan session', 'Flooring'),
(10, 'Test 1', 'Test 1'),
(11, 'Test 12', 'Test 12'),
(12, NULL, 's'),
(13, 'Eunieluwu223232', 'Euniel222'),
(14, 'Test', 'Test'),
(15, 'was', 'was'),
(16, 'was', 'was'),
(17, 'test', 'test'),
(18, 'Compound', 'Compound'),
(19, 'Project Desc 1', 'Project Desc 1'),
(20, 'John do Desc', 'John do Desc'),
(21, 'Por', 'Por'),
(22, 'New QuotDesc', 'New QuotDesc'),
(23, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `quotation`
--

CREATE TABLE `quotation` (
  `QuoID` int(11) NOT NULL,
  `CustID` int(11) NOT NULL,
  `ProjectID` int(11) NOT NULL,
  `BillID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `summation` decimal(11,0) NOT NULL,
  `DeliveryCharges` decimal(11,0) NOT NULL,
  `LaborCharges` decimal(11,0) NOT NULL,
  `BendingCharges` decimal(11,0) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `quotation`
--

INSERT INTO `quotation` (`QuoID`, `CustID`, `ProjectID`, `BillID`, `UserID`, `summation`, `DeliveryCharges`, `LaborCharges`, `BendingCharges`, `created`, `updated`, `deleted`) VALUES
(4, 3, 2, 1, 1, '5000', '3000', '1000', '2000', '2021-01-17 00:00:00', '2021-01-17 00:00:00', 1),
(5, 1, 1, 2, 1, '6000', '3000', '1000', '2000', '2021-01-17 00:00:00', '2021-01-17 00:00:00', 1),
(6, 1, 3, 3, 1, '1000', '3000', '1000', '2000', '2021-01-17 00:00:00', '0000-00-00 00:00:00', 1),
(7, 9, 7, 4, 1, '16969', '6969', '69', '69', '2021-07-14 12:01:52', '0000-00-00 00:00:00', 0),
(8, 10, 8, 5, 1, '0', '1000', '500', '100', '2021-07-20 01:46:16', '2021-07-20 01:49:33', 0),
(9, 11, 9, 6, 1, '366', '22', '222', '22', '2021-07-20 01:46:48', '2021-07-20 01:53:45', 0),
(10, 12, 10, 7, 1, '114', '1', '12', '1', '2021-07-20 01:55:59', '2021-07-20 02:08:27', 0),
(11, 13, 11, 8, 1, '350', '100', '100', '50', '2021-07-20 01:58:56', '2021-07-20 02:27:51', 1),
(12, 14, 12, 9, 1, '1320', '300', '10', '10', '2021-07-20 02:28:29', '0000-00-00 00:00:00', 1),
(13, 15, 13, 10, 1, '50222', '10', '102', '10', '2021-07-20 13:50:08', '2021-07-20 14:16:01', 1),
(14, 16, 14, 11, 1, '2060', '20', '20', '20', '2021-07-20 13:52:53', '0000-00-00 00:00:00', 1),
(15, 17, 15, 12, 1, '1000', '200', '400', '0', '2021-07-20 14:28:50', '2021-07-20 16:21:07', 1),
(16, 18, 16, 13, 1, '701', '100', '500', '0', '2021-07-20 22:11:45', '2021-07-21 22:18:52', 0),
(17, 19, 17, 14, 1, '36420', '200', '20020', '200', '2021-07-20 22:38:44', '0000-00-00 00:00:00', 0),
(18, 20, 18, 15, 1, '10700', '200', '200', '200', '2021-07-20 22:40:57', '2021-07-20 23:19:25', 0),
(19, 21, 19, 16, 1, '50000400', '100', '200', '100', '2021-07-20 22:44:52', '0000-00-00 00:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `ServiceID` int(11) NOT NULL,
  `ServiceName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`ServiceID`, `ServiceName`) VALUES
(1, 'Roofing'),
(2, 'Masonry'),
(3, 'Electrical'),
(4, 'Plumbing');

-- --------------------------------------------------------

--
-- Table structure for table `sub_contractors`
--

CREATE TABLE `sub_contractors` (
  `SubID` int(11) NOT NULL,
  `ServiceID` int(11) NOT NULL,
  `SubListID` int(11) DEFAULT NULL,
  `FirstName` varchar(255) NOT NULL,
  `MiddleName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sub_contractors`
--

INSERT INTO `sub_contractors` (`SubID`, `ServiceID`, `SubListID`, `FirstName`, `MiddleName`, `LastName`, `created`, `updated`, `deleted`) VALUES
(7, 2, 4, '', '', '', '2021-01-22 21:14:17', '2021-01-23 14:15:55', '2021-01-23 14:03:12'),
(8, 1, 6, '', '', '', '2021-01-22 21:14:17', NULL, '2021-07-20 20:31:08'),
(9, 3, 5, '', '', '', '2021-01-22 21:14:17', NULL, NULL),
(10, 1, 5, '', '', '', '2021-01-22 21:14:17', NULL, '2021-07-20 22:08:30'),
(11, 4, 5, '', '', '', '2021-01-22 21:14:17', NULL, NULL),
(15, 1, 6, '', '', '', '2021-01-30 01:11:52', NULL, NULL),
(17, 1, NULL, '', '', '', '2021-01-30 01:16:56', NULL, '2021-07-20 20:33:19'),
(35, 1, 10, '', '', '', '0000-00-00 00:00:00', '2021-07-20 02:27:51', NULL),
(36, 1, 11, '', '', '', '2021-07-20 02:28:29', NULL, '2021-07-20 20:33:10'),
(38, 1, 13, '', '', '', '2021-07-20 13:52:53', NULL, NULL),
(46, 1, 12, '', '', '', '0000-00-00 00:00:00', '2021-07-20 14:16:01', '2021-07-20 20:33:24'),
(56, 1, 14, '', '', '', '0000-00-00 00:00:00', '2021-07-20 16:21:07', '2021-07-20 20:33:15'),
(57, 1, NULL, '', '', '', '2021-07-20 22:08:15', NULL, NULL),
(59, 1, 16, '', '', '', '2021-07-20 22:38:44', NULL, NULL),
(61, 1, 18, '', '', '', '2021-07-20 22:44:52', NULL, NULL),
(63, 1, 17, '', '', '', '0000-00-00 00:00:00', '2021-07-20 23:19:25', NULL),
(65, 1, 15, '', '', '', '0000-00-00 00:00:00', '2021-07-21 22:18:52', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sub_contractors_labor`
--

CREATE TABLE `sub_contractors_labor` (
  `SubListID` int(11) NOT NULL,
  `QuoID` int(11) NOT NULL,
  `LaborFee` decimal(11,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sub_contractors_labor`
--

INSERT INTO `sub_contractors_labor` (`SubListID`, `QuoID`, `LaborFee`) VALUES
(4, 4, '698'),
(5, 5, '698'),
(6, 6, '698'),
(7, 8, '500'),
(8, 9, '222'),
(9, 10, '12'),
(10, 11, '100'),
(11, 12, '10'),
(12, 13, '102'),
(13, 14, '20'),
(14, 15, '400'),
(15, 16, '500'),
(16, 17, '20020'),
(17, 18, '200'),
(18, 19, '200');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `FirstName` varchar(255) NOT NULL,
  `MiddleName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Username`, `Password`, `Email`, `FirstName`, `MiddleName`, `LastName`, `created`, `updated`, `deleted`) VALUES
(1, 'Onilito', 'admin', 's', '', '', '', '2021-01-26 00:36:17', '2021-01-26 00:44:57', NULL),
(2, 'Onilitoa', '$2b$10$lW0ZYHuISkfgCwDY4VjsYeuJL9X11jVnL3q4HjYz8fU4L9ZJAU/4u', 'sawd', '', '', '', '2021-01-26 00:36:21', '2021-01-26 01:15:17', NULL),
(3, 'sss', '$2b$10$doAughbkFldywBctOeVq7.RwPDdSn5vHmhpghjbe42sElLb7fkg7u', 's', '', '', '', '2021-01-26 00:38:43', NULL, NULL),
(4, 'sssss', '$2b$10$lT2npkChdG69Gq9KjJOIfu9TfTG3T.1OzX5BkgqP87L4Gy.YOjAj2', 's', '', '', '', '2021-01-28 23:47:25', NULL, '2021-07-20 14:01:07'),
(5, 'wdd', '$2b$10$PHjo0l7/13Z0r9p4wWY3POuWbW0vBGDqLuRRNnmGnGBr0wiWPEfbS', 'aa@sdadw', '', '', '', '2021-07-20 20:29:31', NULL, NULL),
(6, 'NewMark2', '$2b$10$ZcaMvN.nceomNTdNUOugIODNs9BaHzlQ94KUGM7MiQStJvA5irdzq', 'New2@yahoo.com', '', '', '', '2021-07-20 22:15:48', NULL, '2021-07-20 22:16:15'),
(7, 'New', '$2b$10$Kyp6vF88FFtyMqT.fBq1WuF4oEwN9Wa.A3I6ml9g0guHhYMO968US', 'New@yahoo.com', '', '', '', '2021-07-20 22:18:15', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `billings`
--
ALTER TABLE `billings`
  ADD PRIMARY KEY (`BillID`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`CustID`);

--
-- Indexes for table `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`MatID`),
  ADD KEY `FK_MatDetailsID` (`MatDetailsID`),
  ADD KEY `FK_MatListID` (`MatListID`);

--
-- Indexes for table `mat_details`
--
ALTER TABLE `mat_details`
  ADD PRIMARY KEY (`MatDetailsID`),
  ADD KEY `FK_ServiceIDmat_det` (`ServiceID`);

--
-- Indexes for table `mat_list`
--
ALTER TABLE `mat_list`
  ADD PRIMARY KEY (`MatListID`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`ProjectID`),
  ADD KEY `FK_MatListIDProj` (`MatListID`),
  ADD KEY `FK_ProjSiteIDProj` (`ProjSiteID`),
  ADD KEY `FK_ProjTypeIDProj` (`ProjTypeID`);

--
-- Indexes for table `project_site`
--
ALTER TABLE `project_site`
  ADD PRIMARY KEY (`ProjSiteID`);

--
-- Indexes for table `project_type`
--
ALTER TABLE `project_type`
  ADD PRIMARY KEY (`ProjTypeID`);

--
-- Indexes for table `quotation`
--
ALTER TABLE `quotation`
  ADD PRIMARY KEY (`QuoID`),
  ADD KEY `FK_QCustIDQuo` (`CustID`),
  ADD KEY `FK_ProjectIDQuo` (`ProjectID`),
  ADD KEY `FK_BillIDQuo` (`BillID`),
  ADD KEY `FK_UserIDQuo` (`UserID`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`ServiceID`);

--
-- Indexes for table `sub_contractors`
--
ALTER TABLE `sub_contractors`
  ADD PRIMARY KEY (`SubID`),
  ADD KEY `FK_ServiceIDSub` (`ServiceID`),
  ADD KEY `FK_SubListIDSub` (`SubListID`);

--
-- Indexes for table `sub_contractors_labor`
--
ALTER TABLE `sub_contractors_labor`
  ADD PRIMARY KEY (`SubListID`),
  ADD KEY `FK_QuoIDSubList` (`QuoID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `billings`
--
ALTER TABLE `billings`
  MODIFY `BillID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `CustID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `materials`
--
ALTER TABLE `materials`
  MODIFY `MatID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `mat_details`
--
ALTER TABLE `mat_details`
  MODIFY `MatDetailsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `mat_list`
--
ALTER TABLE `mat_list`
  MODIFY `MatListID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `ProjectID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `project_site`
--
ALTER TABLE `project_site`
  MODIFY `ProjSiteID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `project_type`
--
ALTER TABLE `project_type`
  MODIFY `ProjTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `quotation`
--
ALTER TABLE `quotation`
  MODIFY `QuoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `ServiceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sub_contractors`
--
ALTER TABLE `sub_contractors`
  MODIFY `SubID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `sub_contractors_labor`
--
ALTER TABLE `sub_contractors_labor`
  MODIFY `SubListID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `materials`
--
ALTER TABLE `materials`
  ADD CONSTRAINT `FK_MatDetailsID` FOREIGN KEY (`MatDetailsID`) REFERENCES `mat_details` (`MatDetailsID`),
  ADD CONSTRAINT `FK_MatListID` FOREIGN KEY (`MatListID`) REFERENCES `mat_list` (`MatListID`);

--
-- Constraints for table `mat_details`
--
ALTER TABLE `mat_details`
  ADD CONSTRAINT `FK_ServiceIDmat_det` FOREIGN KEY (`ServiceID`) REFERENCES `services` (`ServiceID`);

--
-- Constraints for table `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `FK_MatListIDProj` FOREIGN KEY (`MatListID`) REFERENCES `mat_list` (`MatListID`),
  ADD CONSTRAINT `FK_ProjSiteIDProj` FOREIGN KEY (`ProjSiteID`) REFERENCES `project_site` (`ProjSiteID`),
  ADD CONSTRAINT `FK_ProjTypeIDProj` FOREIGN KEY (`ProjTypeID`) REFERENCES `project_type` (`ProjTypeID`);

--
-- Constraints for table `quotation`
--
ALTER TABLE `quotation`
  ADD CONSTRAINT `FK_BillIDQuo` FOREIGN KEY (`BillID`) REFERENCES `billings` (`BillID`),
  ADD CONSTRAINT `FK_ProjectIDQuo` FOREIGN KEY (`ProjectID`) REFERENCES `project` (`ProjectID`),
  ADD CONSTRAINT `FK_QCustIDQuo` FOREIGN KEY (`CustID`) REFERENCES `customers` (`CustID`),
  ADD CONSTRAINT `FK_UserIDQuo` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `sub_contractors`
--
ALTER TABLE `sub_contractors`
  ADD CONSTRAINT `FK_ServiceIDSub` FOREIGN KEY (`ServiceID`) REFERENCES `services` (`ServiceID`),
  ADD CONSTRAINT `FK_SubListIDSub` FOREIGN KEY (`SubListID`) REFERENCES `sub_contractors_labor` (`SubListID`);

--
-- Constraints for table `sub_contractors_labor`
--
ALTER TABLE `sub_contractors_labor`
  ADD CONSTRAINT `FK_QuoIDSubList` FOREIGN KEY (`QuoID`) REFERENCES `quotation` (`QuoID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
