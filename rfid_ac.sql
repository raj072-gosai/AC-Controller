-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 20, 2024 at 08:08 AM
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

-- --------------------------------------------------------

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
(1, 'leb-103', 'mca', 'f0d27163a1cae5f3', '2024-07-20', 0);

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
(12, 'urvashi', 229, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-20', '17:05:29', '17:05:35', 6, 1),
(13, 'urvashi', 223, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-22', '19:45:18', '19:45:43', 25, 1),
(14, 'urvashi', 198, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-22', '19:45:53', '19:46:06', 13, 1),
(15, 'urvashi', 185, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-22', '19:52:41', '19:52:50', 9, 1),
(16, 'urvashi', 176, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-22', '19:53:01', '19:53:19', 18, 1),
(17, 'urvashi', 158, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-22', '19:53:31', '19:53:58', 27, 1),
(18, 'urvashi', 131, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-22', '19:54:01', '20:02:06', 485, 1),
(19, 'ritu', 439, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-22', '20:04:08', '20:04:45', 37, 1),
(20, 'ritu', 402, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-22', '20:04:52', '20:05:04', 12, 1),
(21, 'ritu', 390, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-22', '20:05:37', '20:05:45', 8, 1),
(22, 'ritu', 382, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-22', '21:43:09', '00:00:00', 0, 0),
(23, 'urvashi', 1000, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '18:50:02', '18:52:09', 127, 1),
(24, 'urvashi', 873, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '18:52:35', '18:52:51', 16, 1),
(25, 'ritu', 382, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '18:53:01', '18:53:20', 19, 1),
(26, 'urvashi', 857, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '18:53:26', '18:53:34', 8, 1),
(27, 'urvashi', 849, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '18:53:51', '18:54:20', 29, 1),
(28, 'ritu', 363, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '18:54:35', '18:55:06', 31, 1),
(29, 'urvashi', 820, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '18:55:13', '18:55:35', 22, 1),
(30, 'ritu', 332, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '18:59:49', '18:59:58', 9, 1),
(31, 'ritu', 323, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:04:23', '19:04:26', 3, 1),
(32, 'ritu', 320, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:04:27', '19:04:31', 4, 1),
(33, 'ritu', 316, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:04:31', '19:04:52', 21, 1),
(34, 'ritu', 295, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:04:52', '19:05:03', 11, 1),
(35, 'ritu', 284, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:04', '19:05:04', 0, 1),
(36, 'ritu', 284, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:04', '19:05:04', 0, 1),
(37, 'ritu', 284, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:05', '19:05:05', 0, 1),
(38, 'ritu', 284, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:05', '19:05:06', 1, 1),
(39, 'ritu', 283, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:06', '19:05:06', 0, 1),
(40, 'ritu', 283, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:07', '19:05:07', 0, 1),
(41, 'ritu', 283, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:07', '19:05:07', 0, 1),
(42, 'ritu', 283, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:08', '19:05:08', 0, 1),
(43, 'ritu', 283, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:08', '19:05:09', 1, 1),
(44, 'ritu', 282, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:09', '19:05:09', 0, 1),
(45, 'ritu', 282, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:15', '19:05:15', 0, 1),
(46, 'ritu', 282, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:16', '19:05:16', 0, 1),
(47, 'ritu', 282, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:16', '19:05:17', 1, 1),
(48, 'ritu', 281, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:17', '19:05:17', 0, 1),
(49, 'ritu', 281, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:18', '19:05:18', 0, 1),
(50, 'ritu', 281, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:18', '19:05:18', 0, 1),
(51, 'ritu', 281, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:19', '19:05:19', 0, 1),
(52, 'ritu', 281, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:19', '19:05:20', 1, 1),
(53, 'ritu', 280, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:20', '19:05:20', 0, 1),
(54, 'ritu', 280, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:21', '19:05:21', 0, 1),
(55, 'ritu', 280, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:21', '19:05:22', 1, 1),
(56, 'ritu', 279, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:22', '19:05:22', 0, 1),
(57, 'ritu', 279, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:22', '19:05:23', 1, 1),
(58, 'ritu', 278, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:23', '19:05:23', 0, 1),
(59, 'ritu', 278, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:24', '19:05:24', 0, 1),
(60, 'ritu', 278, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:05:24', '19:05:24', 0, 1),
(61, 'ritu', 278, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '19:06:18', '20:44:18', 5880, 1),
(62, 'urvashi', 798, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '20:45:02', '20:45:49', 47, 1),
(63, 'ritu', 100000, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '20:49:24', '20:51:19', 115, 1),
(64, 'ritu', 99885, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '20:52:29', '21:01:00', 511, 1),
(65, 'ritu', 99374, '1441410538', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '21:01:06', '21:02:07', 61, 1),
(66, 'ritu parekh', 10000, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '21:32:50', '21:33:56', 66, 1),
(67, 'ritu parekh', 9934, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '21:34:39', '21:34:58', 19, 1),
(68, 'ritu parekh', 9915, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-23', '21:37:57', '21:42:16', 259, 1),
(69, 'urvashi dave', 2000, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-07-27', '14:42:26', '14:42:41', 15, 1),
(70, 'urvashi dave', 1985, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-07-27', '14:42:56', '14:43:04', 8, 1),
(71, 'urvashi dave', 1977, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-07-27', '14:43:13', '14:43:30', 17, 1),
(72, 'ritu parekh', 9656, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-27', '14:48:20', '14:53:11', 291, 1),
(73, 'urvashi dave', 1960, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-07-27', '14:54:22', '14:57:32', 190, 1),
(74, 'ritu parekh', 9365, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-29', '22:29:03', '22:33:15', 252, 1),
(75, 'ritu parekh', 9113, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-29', '22:34:34', '22:34:52', 18, 1),
(76, 'ritu parekh', 9095, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-29', '22:35:19', '22:35:21', 2, 1),
(77, 'ritu parekh', 9093, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-29', '22:35:37', '22:35:51', 14, 1),
(78, 'urvashi dave', 1770, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-07-30', '23:59:40', '00:00:00', 0, 0),
(79, 'urvashi dave', 1770, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-07-31', '00:04:05', '00:10:59', 414, 1),
(80, 'ritu parekh', 9079, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-31', '00:11:56', '00:12:22', 26, 1),
(81, 'urvashi dave', 1356, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-07-31', '00:16:46', '00:19:21', 155, 1),
(82, 'ritu parekh', 9053, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-31', '00:35:56', '00:41:09', 313, 1),
(83, 'ritu parekh', 8740, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-31', '00:42:31', '00:45:21', 170, 1),
(84, 'ritu parekh', 8570, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-31', '00:46:04', '00:51:04', 300, 1),
(85, 'ritu parekh', 8270, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-31', '00:51:54', '00:53:08', 74, 1),
(86, 'ritu parekh', 8196, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-31', '00:53:57', '00:57:50', 233, 1),
(87, 'ritu parekh', 7963, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-31', '01:00:28', '01:10:59', 631, 1),
(88, 'ritu parekh', 7332, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-31', '01:11:59', '01:19:53', 474, 1),
(89, 'urvashi dave', 1201, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-07-31', '02:13:37', '02:14:09', 32, 1),
(90, 'ritu parekh', 6858, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-31', '02:16:09', '02:18:47', 158, 1),
(91, 'ritu parekh', 6700, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-31', '02:20:15', '02:34:01', 826, 1),
(92, 'ritu parekh', 5874, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-31', '02:34:03', '02:37:07', 184, 1),
(93, 'ritu parekh', 5690, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-07-31', '02:43:04', '02:43:30', 26, 1),
(94, 'ritu parekh', 5664, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-08-01', '20:15:30', '20:19:27', 237, 1),
(95, 'ritu parekh', 5427, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-08-01', '20:35:57', '20:39:25', 208, 1),
(96, 'urvashi dave', 1169, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-08-01', '20:41:39', '20:42:12', 33, 1),
(97, 'urvashi dave', 1136, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-08-01', '20:42:23', '20:45:02', 159, 1),
(98, 'urvashi dave', 977, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-08-01', '20:46:15', '20:46:57', 42, 1),
(99, 'urvashi dave', 935, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-08-01', '20:48:09', '20:56:28', 499, 1),
(100, 'urvashi dave', 436, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-08-01', '20:56:42', '20:58:59', 137, 1),
(101, 'ritu parekh', 5219, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-08-01', '20:59:16', '21:02:25', 189, 1),
(102, 'ritu parekh', 5030, '90e6926', 'f0d27163a1cae5f3', 'mca', '2024-08-01', '21:08:34', '21:15:40', 426, 1),
(103, 'urvashi dave', 299, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-08-01', '21:15:47', '21:19:20', 213, 1),
(104, 'urvashi dave', 86, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-08-03', '16:19:39', '16:19:57', 18, 1),
(105, 'urvashi dave', 68, '90b2cf26', 'f0d27163a1cae5f3', 'mca', '2024-08-03', '16:21:41', '16:22:00', 19, 1),
(106, 'raj', 1000, 'e88f4bd', 'f0d27163a1cae5f3', 'mca', '2024-08-03', '17:00:22', '17:03:12', 170, 1),
(107, 'urvashi', 751, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-10-13', '10:57:02', '10:58:50', 108, 1),
(108, 'urvashi', 643, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-10-13', '10:58:58', '11:00:39', 101, 1),
(109, 'urvashi', 542, '14417820738', 'f0d27163a1cae5f3', 'mca', '2024-10-13', '11:01:29', '00:00:00', 0, 0);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users_logs`
--
ALTER TABLE `users_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
