-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 22, 2024 at 03:36 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rfid_ac`
--

-- ------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `admin_name` varchar(30) NOT NULL,
  `admin_email` varchar(80) NOT NULL,
  `admin_pwd` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `admin_name`, `admin_email`, `admin_pwd`) VALUES
(1, 'Admin', 'admin@gmail.com', '$2y$10$89uX3LBy4mlU/DcBveQ1l.32nSianDP/E1MfUh.Z.6B4Z0ql3y7PK');

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE `devices` (
  `id` int(11) NOT NULL,
  `device_name` varchar(50) NOT NULL,
  `device_dep` varchar(20) NOT NULL,
  `device_uid` text NOT NULL,
  `device_date` date NOT NULL,
  `device_mode` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `devices`
--

INSERT INTO `devices` (`id`, `device_name`, `device_dep`, `device_uid`, `device_date`, `device_mode`) VALUES
(1, 'leb-103', 'mca', 'f0d27163a1cae5f3', '2024-07-20', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL DEFAULT 'None',
  `remaining_time` double NOT NULL DEFAULT 0,
  `gender` varchar(10) NOT NULL DEFAULT 'None',
  `email` varchar(50) NOT NULL DEFAULT 'None',
  `card_uid` varchar(30) NOT NULL,
  `card_select` tinyint(1) NOT NULL DEFAULT 0,
  `user_date` date NOT NULL,
  `device_uid` varchar(20) NOT NULL DEFAULT '0',
  `device_dep` varchar(20) NOT NULL DEFAULT '0',
  `add_card` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `remaining_time`, `gender`, `email`, `card_uid`, `card_select`, `user_date`, `device_uid`, `device_dep`, `add_card`) VALUES
(1, 'ritu', 439, 'Female', 'ritu@gmail.com', '1441410538', 0, '2024-07-20', 'f0d27163a1cae5f3', 'mca', 1),
(2, 'urvashi', 223, 'Female', 'urvashi@gmail.com', '14417820738', 1, '2024-07-20', 'f0d27163a1cae5f3', 'mca', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users_logs`
--

CREATE TABLE `users_logs` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `remaining_time` double NOT NULL,
  `card_uid` varchar(30) NOT NULL,
  `device_uid` varchar(20) NOT NULL,
  `device_dep` varchar(20) NOT NULL,
  `checkindate` date NOT NULL,
  `timein` time NOT NULL,
  `timeout` time NOT NULL,
  `duration_seconds` int(10) NOT NULL,
  `card_out` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users_logs`
--

INSERT INTO `users_logs` (`id`, `username`, `remaining_time`, `card_uid`, `device_uid`, `device_dep`, `checkindate`, `timein`, `timeout`, `duration_seconds`, `card_out`) VALUES
(1, 'urvashi', 1000, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-20', '20:42:30', '20:47:38', 308, 1),
(2, 'ritu', 500, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-20', '16:19:37', '16:20:00', 23, 1),
(3, 'urvashi', 692, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-20', '16:19:52', '16:20:04', 12, 1),
(4, 'urvashi', 680, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-20', '16:21:29', '16:21:48', 19, 1),
(5, 'ritu', 477, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-20', '16:21:55', '16:22:05', 10, 1),
(6, 'ritu', 467, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-20', '16:22:23', '16:22:30', 7, 1),
(7, 'urvashi', 661, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-20', '16:22:50', '16:24:48', 118, 1),
(8, 'urvashi', 543, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-20', '16:25:01', '16:25:40', 39, 1),
(9, 'ritu', 460, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-20', '16:25:08', '16:25:29', 21, 1),
(10, 'urvashi', 504, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-20', '16:26:00', '16:26:02', 2, 1),
(11, 'urvashi', 502, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-20', '16:30:41', '16:35:14', 273, 1),
(12, 'urvashi', 229, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-20', '17:05:29', '17:05:35', 6, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users_logs`
--
ALTER TABLE `users_logs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `devices`
--
ALTER TABLE `devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users_logs`
--
ALTER TABLE `users_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

