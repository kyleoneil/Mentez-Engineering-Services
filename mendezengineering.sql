-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2021 at 06:13 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
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
  `Amount` int(11) NOT NULL,
  `Date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `billings`
--

INSERT INTO `billings` (`BillID`, `Amount`, `Date`) VALUES
(1, 2000, '2020-07-21 00:00:00'),
(2, 5000, '2021-02-13 00:00:00'),
(3, 20000, '2020-10-07 00:00:00'),
(4, 10000, '2021-07-14 04:01:52');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `CustID` int(11) NOT NULL,
  `CustName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`CustID`, `CustName`) VALUES
(1, 'Onil'),
(2, 'Onilito'),
(3, 'Onilito Gwapito'),
(4, 'Oneil'),
(5, 'ImbaOnil'),
(6, 'Yawaers'),
(7, 'Yawaers'),
(8, 'Yawaers'),
(9, 'Yawaers');

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE `materials` (
  `MatID` int(11) NOT NULL,
  `MatDetailsID` int(11) NOT NULL,
  `MatListID` int(11) NOT NULL,
  `TotalPrice` int(11) NOT NULL,
  `MatQty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `materials`
--

INSERT INTO `materials` (`MatID`, `MatDetailsID`, `MatListID`, `TotalPrice`, `MatQty`) VALUES
(2, 2, 1, 400, 2),
(3, 1, 1, 400, 3),
(4, 2, 2, 400, 2),
(5, 3, 2, 500, 3),
(6, 9, 3, 200, 2),
(7, 1, 3, 100, 1),
(8, 9, 4, 200, 2),
(9, 1, 4, 100, 1),
(10, 9, 5, 200, 2),
(11, 1, 5, 100, 1),
(12, 9, 6, 200, 2),
(13, 1, 6, 100, 1);

-- --------------------------------------------------------

--
-- Table structure for table `mat_details`
--

CREATE TABLE `mat_details` (
  `MatDetailsID` int(11) NOT NULL,
  `ServiceID` int(11) DEFAULT NULL,
  `MatDescription` varchar(255) NOT NULL,
  `MatName` varchar(255) NOT NULL,
  `MatPrice` int(11) NOT NULL,
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
(1, 2, 'Wood', 'Flooring', 100, 'IN STOCK', 96, NULL, NULL, NULL),
(2, 3, 'Tiles', 'Flooring', 200, 'IN STOCK', 100, NULL, NULL, NULL),
(3, 3, 'Chandelier', 'Ceiling', 300, 'IN STOCK', 100, NULL, NULL, NULL),
(8, 2, 'onilito4', 'onilito2', 69, 'HAHAY', 233323, NULL, NULL, NULL),
(9, 3, 'sample', 'sample', 200, 'sample', 192, NULL, NULL, NULL),
(10, 2, 's', 'asda', 2, 'a', 2, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mat_list`
--

CREATE TABLE `mat_list` (
  `MatListID` int(11) NOT NULL,
  `TotalListPrice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mat_list`
--

INSERT INTO `mat_list` (`MatListID`, `TotalListPrice`) VALUES
(1, 800),
(2, 900),
(3, 300),
(4, 300),
(5, 300),
(6, 300);

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
(7, 6, 9, 8, '2021-08-13 23:59:59', '2021-08-15 23:59:59');

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
(8, 'umayos', 'ka na sa', 'buhay mo', '123');

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
(9, 'iyakan session', 'Flooring');

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
  `summation` int(11) NOT NULL,
  `DeliveryCharges` int(11) NOT NULL,
  `LaborCharges` int(11) NOT NULL,
  `BendingCharges` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `quotation`
--

INSERT INTO `quotation` (`QuoID`, `CustID`, `ProjectID`, `BillID`, `UserID`, `summation`, `DeliveryCharges`, `LaborCharges`, `BendingCharges`, `created`, `updated`, `deleted`) VALUES
(4, 3, 2, 1, 1, 5000, 3000, 1000, 2000, '2021-01-17 00:00:00', '2021-01-17 00:00:00', 0),
(5, 1, 1, 2, 1, 6000, 3000, 1000, 2000, '2021-01-17 00:00:00', '2021-01-17 00:00:00', 0),
(6, 1, 3, 3, 1, 1000, 3000, 1000, 2000, '2021-01-17 00:00:00', '0000-00-00 00:00:00', 0),
(7, 9, 7, 4, 1, 16969, 6969, 69, 69, '2021-07-14 12:01:52', '0000-00-00 00:00:00', 0);

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
  `SubName` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sub_contractors`
--

INSERT INTO `sub_contractors` (`SubID`, `ServiceID`, `SubListID`, `SubName`, `created`, `updated`, `deleted`) VALUES
(7, 2, 4, 'Carlita', '2021-01-22 21:14:17', '2021-01-23 14:15:55', '2021-01-23 14:03:12'),
(8, 1, 6, 'Euniel', '2021-01-22 21:14:17', NULL, NULL),
(9, 3, 5, 'Lance', '2021-01-22 21:14:17', NULL, NULL),
(10, 1, 5, 'Onilito', '2021-01-22 21:14:17', NULL, NULL),
(11, 4, 5, 'Euniel', '2021-01-22 21:14:17', NULL, NULL),
(15, 1, 6, 'SD', '2021-01-30 01:11:52', NULL, NULL),
(17, 1, NULL, 'SD', '2021-01-30 01:16:56', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sub_contractors_labor`
--

CREATE TABLE `sub_contractors_labor` (
  `SubListID` int(11) NOT NULL,
  `QuoID` int(11) NOT NULL,
  `LaborFee` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sub_contractors_labor`
--

INSERT INTO `sub_contractors_labor` (`SubListID`, `QuoID`, `LaborFee`) VALUES
(4, 4, 698),
(5, 5, 698),
(6, 6, 698);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Username`, `Password`, `Email`, `Name`, `created`, `updated`, `deleted`) VALUES
(1, 'Onilito', 'admin', 's', 'ss', '2021-01-26 00:36:17', '2021-01-26 00:44:57', NULL),
(2, 'Onilitoa', '$2b$10$lW0ZYHuISkfgCwDY4VjsYeuJL9X11jVnL3q4HjYz8fU4L9ZJAU/4u', 's', 'ss', '2021-01-26 00:36:21', '2021-01-26 01:15:17', NULL),
(3, 'sss', '$2b$10$doAughbkFldywBctOeVq7.RwPDdSn5vHmhpghjbe42sElLb7fkg7u', 's', 'ss', '2021-01-26 00:38:43', NULL, NULL),
(4, 'sssss', '$2b$10$lT2npkChdG69Gq9KjJOIfu9TfTG3T.1OzX5BkgqP87L4Gy.YOjAj2', 's', 'ssss', '2021-01-28 23:47:25', NULL, NULL);

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
  MODIFY `BillID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `CustID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `materials`
--
ALTER TABLE `materials`
  MODIFY `MatID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `mat_details`
--
ALTER TABLE `mat_details`
  MODIFY `MatDetailsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `mat_list`
--
ALTER TABLE `mat_list`
  MODIFY `MatListID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `ProjectID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `project_site`
--
ALTER TABLE `project_site`
  MODIFY `ProjSiteID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `project_type`
--
ALTER TABLE `project_type`
  MODIFY `ProjTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `quotation`
--
ALTER TABLE `quotation`
  MODIFY `QuoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `ServiceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sub_contractors`
--
ALTER TABLE `sub_contractors`
  MODIFY `SubID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `sub_contractors_labor`
--
ALTER TABLE `sub_contractors_labor`
  MODIFY `SubListID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
