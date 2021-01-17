-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 17, 2021 at 03:32 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

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
(3, 20000, '2020-10-07 00:00:00');

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
(5, 'ImbaOnil');

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
(5, 3, 2, 500, 3);

-- --------------------------------------------------------

--
-- Table structure for table `mat_details`
--

CREATE TABLE `mat_details` (
  `MatDetailsID` int(11) NOT NULL,
  `MatDescription` varchar(255) NOT NULL,
  `MatName` varchar(255) NOT NULL,
  `MatPrice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mat_details`
--

INSERT INTO `mat_details` (`MatDetailsID`, `MatDescription`, `MatName`, `MatPrice`) VALUES
(1, 'Wood', 'Flooring', 100),
(2, 'Tiles', 'Flooring', 200),
(3, 'Chandelier', 'Ceiling', 300);

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
(2, 900);

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
(3, 2, 1, 2, '0000-00-00 00:00:00', '2020-02-20 00:00:00');

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
(4, 'Argao', 'Gutlang', '61th avenue', '7000');

-- --------------------------------------------------------

--
-- Table structure for table `project_type`
--

CREATE TABLE `project_type` (
  `ProjTypeID` int(11) NOT NULL,
  `ProjDesc` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `project_type`
--

INSERT INTO `project_type` (`ProjTypeID`, `ProjDesc`) VALUES
(1, 'Flooring'),
(2, 'Mason'),
(3, 'Ceiling'),
(4, 'Glass'),
(5, 'Foundation');

-- --------------------------------------------------------

--
-- Table structure for table `quotation`
--

CREATE TABLE `quotation` (
  `QuoID` int(11) NOT NULL,
  `CustID` int(11) NOT NULL,
  `ProjectID` int(11) NOT NULL,
  `BillID` int(11) NOT NULL,
  `summation` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `quotation`
--

INSERT INTO `quotation` (`QuoID`, `CustID`, `ProjectID`, `BillID`, `summation`, `UserID`, `created`, `updated`) VALUES
(4, 3, 2, 1, 5000, 1, '2021-01-17 00:00:00', '2021-01-17 00:00:00'),
(5, 1, 1, 2, 6000, 1, '2021-01-17 00:00:00', '2021-01-17 00:00:00'),
(6, 1, 3, 3, 1000, 1, '2021-01-17 00:00:00', '0000-00-00 00:00:00');

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
(1, 'Delivery'),
(2, 'Wiring'),
(3, 'Lighting'),
(4, 'Plumming');

-- --------------------------------------------------------

--
-- Table structure for table `sub_contractors`
--

CREATE TABLE `sub_contractors` (
  `SubID` int(11) NOT NULL,
  `ServiceID` int(11) NOT NULL,
  `SubListID` int(11) NOT NULL,
  `SubName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sub_contractors`
--

INSERT INTO `sub_contractors` (`SubID`, `ServiceID`, `SubListID`, `SubName`) VALUES
(6, 1, 4, 'Euniel'),
(7, 2, 4, 'Carl'),
(8, 1, 6, 'Euniel'),
(9, 3, 5, 'Lance'),
(10, 1, 5, 'Onilito'),
(11, 4, 5, 'Euniel');

-- --------------------------------------------------------

--
-- Table structure for table `sub_contractors_list`
--

CREATE TABLE `sub_contractors_list` (
  `SubListID` int(11) NOT NULL,
  `QuoID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sub_contractors_list`
--

INSERT INTO `sub_contractors_list` (`SubListID`, `QuoID`) VALUES
(4, 4),
(5, 5),
(6, 6);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Username`, `Password`) VALUES
(1, 'admin', 'admin');

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
  ADD PRIMARY KEY (`MatDetailsID`);

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
-- Indexes for table `sub_contractors_list`
--
ALTER TABLE `sub_contractors_list`
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
  MODIFY `BillID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `CustID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `materials`
--
ALTER TABLE `materials`
  MODIFY `MatID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `mat_details`
--
ALTER TABLE `mat_details`
  MODIFY `MatDetailsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mat_list`
--
ALTER TABLE `mat_list`
  MODIFY `MatListID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `ProjectID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `project_site`
--
ALTER TABLE `project_site`
  MODIFY `ProjSiteID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `project_type`
--
ALTER TABLE `project_type`
  MODIFY `ProjTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `quotation`
--
ALTER TABLE `quotation`
  MODIFY `QuoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `ServiceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sub_contractors`
--
ALTER TABLE `sub_contractors`
  MODIFY `SubID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `sub_contractors_list`
--
ALTER TABLE `sub_contractors_list`
  MODIFY `SubListID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  ADD CONSTRAINT `FK_SubListIDSub` FOREIGN KEY (`SubListID`) REFERENCES `sub_contractors_list` (`SubListID`);

--
-- Constraints for table `sub_contractors_list`
--
ALTER TABLE `sub_contractors_list`
  ADD CONSTRAINT `FK_QuoIDSubList` FOREIGN KEY (`QuoID`) REFERENCES `quotation` (`QuoID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
