-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 30, 2026 at 11:21 AM
-- Server version: 10.11.14-MariaDB
-- PHP Version: 8.1.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kanisasoft_kanisasoft`
--

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `location` varchar(255) DEFAULT NULL,
  `acquired_date` date DEFAULT NULL,
  `value` decimal(12,2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contributions`
--

CREATE TABLE `contributions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `type` varchar(255) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `method` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `giver_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contribution_types`
--

CREATE TABLE `contribution_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contribution_types`
--

INSERT INTO `contribution_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Sadaka', '2025-11-17 23:54:09', '2025-11-17 23:54:09'),
(2, 'Fungu la Kumi', '2025-11-17 23:54:09', '2025-11-17 23:54:09'),
(3, 'Maendeleo', '2025-11-17 23:54:09', '2025-11-17 23:54:09'),
(4, 'Misaada Maalum', '2025-11-17 23:54:09', '2025-11-17 23:54:09'),
(5, 'Zaka', '2026-01-10 12:45:41', '2026-01-10 12:45:41');

-- --------------------------------------------------------

--
-- Table structure for table `deleted_members`
--

CREATE TABLE `deleted_members` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `deleted_by` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `time` time DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `category` varchar(255) NOT NULL DEFAULT 'General',
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `title`, `date`, `time`, `location`, `category`, `description`, `created_at`, `updated_at`) VALUES
(1, 'MAOMBI YA SIKU 40', '2026-01-07', '17:00:00', NULL, 'Washirika', 'Maombi ya mfungo ya siku 40 kwa washirika wote', '2026-01-07 19:54:09', '2026-01-07 19:54:09'),
(2, 'ZAMU ZA WIKI', '2026-01-07', '18:30:00', NULL, 'Washirika', 'Mwinjilist Erick Andrea\nAtakuwa za wiki hii.', '2026-01-07 20:34:54', '2026-01-07 20:34:54');

-- --------------------------------------------------------

--
-- Table structure for table `galleries`
--

CREATE TABLE `galleries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `leader_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `leader_id`, `created_at`, `updated_at`) VALUES
(1, 'SIFA NA MUZIKI', NULL, '2026-01-03 22:01:58', '2026-01-12 10:12:40'),
(2, 'MEDIA', NULL, '2026-01-03 22:02:39', '2026-01-03 22:02:39'),
(3, 'WANAUME', NULL, '2026-01-03 22:02:55', '2026-01-03 22:02:55'),
(4, 'CYM', NULL, '2026-01-03 22:58:07', '2026-01-12 10:09:14'),
(5, 'UWW', NULL, '2026-01-03 22:58:35', '2026-01-03 22:58:35'),
(6, 'WAZEE', NULL, '2026-01-12 10:10:46', '2026-01-12 10:11:11'),
(7, 'WANAWAKE', NULL, '2026-01-18 14:13:30', '2026-01-18 14:13:30'),
(8, 'WATOTO', NULL, '2026-01-21 22:12:55', '2026-01-21 22:12:55');

-- --------------------------------------------------------

--
-- Table structure for table `guests`
--

CREATE TABLE `guests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `church_origin` varchar(255) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `prayer` tinyint(1) NOT NULL DEFAULT 0,
  `salvation` tinyint(1) NOT NULL DEFAULT 0,
  `joining` tinyint(1) NOT NULL DEFAULT 0,
  `travel` tinyint(1) NOT NULL DEFAULT 0,
  `other` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leaders`
--

CREATE TABLE `leaders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `leader_code` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `full_name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `leaders`
--

INSERT INTO `leaders` (`id`, `leader_code`, `user_id`, `full_name`, `phone`, `email`, `created_at`, `updated_at`, `status`) VALUES
(23, 'LEAD-696e0fa92eca5', 23, 'Julius Kindole', '255719800813', 'kindole72@gmail.com', '2026-01-19 16:04:09', '2026-01-19 16:04:09', 'active'),
(24, 'LEAD-696e101b61c9e', 25, 'NTULI KAPOLOGWE', '255758833304', 'wapastantuli@gmail.com', '2026-01-19 16:06:03', '2026-01-19 16:06:03', 'active'),
(25, 'LEAD-696e2cf02739f', 16, 'Oscar Batista Kindole', '255784824624', 'oscarkindole@gmail.com', '2026-01-19 18:09:04', '2026-01-19 18:09:04', 'active'),
(27, 'LEAD-696e2f08bba12', 19, 'Reuben Bulugu', '255754544438', 'bulugur@yahoo.com', '2026-01-19 18:18:00', '2026-01-19 18:18:00', 'active'),
(28, 'LEAD-69710a0f1f5ac', 22, 'DAMIAN GERVAS NDABATINYA', '255758047674', 'kigomawax@gmail.com', '2026-01-21 22:17:03', '2026-01-21 22:17:03', 'active'),
(31, 'LEAD-697a44e4e64b0', 23, 'Julius Kindole', '255719800813', 'kindole72@gmail.com', '2026-01-28 22:18:28', '2026-01-28 22:18:28', 'active'),
(32, 'LEAD-697a450494908', 16, 'Oscar Batista Kindole', '255784824624', 'oscarkindole@gmail.com', '2026-01-28 22:19:00', '2026-01-28 22:19:00', 'active'),
(33, 'LEAD-697a457aa22ca', 25, 'NTULI KAPOLOGWE', '255758833304', 'wapastantuli@gmail.com', '2026-01-28 22:20:58', '2026-01-28 22:20:58', 'active'),
(35, 'LEAD-697b8a1ada794', 19, 'Reuben Bulugu', '255754544438', 'bulugur@yahoo.com', '2026-01-29 21:26:02', '2026-01-29 21:26:02', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `leadership_roles`
--

CREATE TABLE `leadership_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `requires_member` tinyint(1) NOT NULL DEFAULT 1,
  `protected` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `leadership_roles`
--

INSERT INTO `leadership_roles` (`id`, `title`, `requires_member`, `protected`, `created_at`, `updated_at`) VALUES
(2, 'mchungaji', 1, 1, NULL, NULL),
(3, 'katibu', 1, 1, NULL, NULL),
(4, 'mtunza hazina', 1, 1, NULL, NULL),
(5, 'Mzee', 1, 0, '2026-01-03 21:11:33', '2026-01-03 21:11:33'),
(6, 'Mchungaji Kiongozi', 1, 0, '2026-01-03 21:12:07', '2026-01-03 21:12:07'),
(7, 'Mwinjilisti', 1, 0, '2026-01-03 21:12:20', '2026-01-03 21:12:20'),
(8, 'Shemasi', 1, 0, '2026-01-03 21:12:31', '2026-01-03 21:12:31'),
(9, 'Mzee wa Kanisa', 1, 0, '2026-01-07 19:48:02', '2026-01-07 19:48:02'),
(10, 'Media Timu', 1, 0, '2026-01-17 22:51:19', '2026-01-17 22:51:19'),
(12, 'Mchungaji  Kiongozi', 1, 0, '2026-01-18 14:19:28', '2026-01-18 14:19:28'),
(13, 'Katibu wa Kanisa', 1, 0, '2026-01-19 18:11:08', '2026-01-19 18:11:08'),
(14, 'Mzee wa Kanisa Kiongozi', 1, 0, '2026-01-19 18:17:44', '2026-01-19 18:17:44');

-- --------------------------------------------------------

--
-- Table structure for table `leaders_backup`
--

CREATE TABLE `leaders_backup` (
  `id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `leadership_role_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `leaders_backup`
--

INSERT INTO `leaders_backup` (`id`, `leadership_role_id`, `user_id`, `full_name`, `phone`, `email`, `created_at`, `updated_at`, `status`) VALUES
(9, 3, 17, 'Isaya Raphael Mwanyamba', '255787001007', 'kakaisaya@gmail.com', '2026-01-17 14:56:46', '2026-01-17 14:56:46', 'active'),
(10, 5, 17, 'Isaya Raphael Mwanyamba', '255787001007', 'kakaisaya@gmail.com', '2026-01-17 17:13:26', '2026-01-17 17:13:26', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `leader_leadership_role`
--

CREATE TABLE `leader_leadership_role` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `leader_id` bigint(20) UNSIGNED NOT NULL,
  `leadership_role_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `leader_leadership_role`
--

INSERT INTO `leader_leadership_role` (`id`, `leader_id`, `leadership_role_id`, `created_at`, `updated_at`) VALUES
(3, 31, 9, '2026-01-28 22:18:28', '2026-01-28 22:18:28'),
(4, 32, 12, '2026-01-28 22:19:00', '2026-01-28 22:19:00'),
(5, 33, 9, '2026-01-28 22:20:58', '2026-01-28 22:20:58'),
(7, 35, 9, '2026-01-29 21:26:02', '2026-01-29 21:26:02');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `birth_date` date DEFAULT NULL,
  `birth_place` varchar(255) DEFAULT NULL,
  `birth_district` varchar(255) DEFAULT NULL,
  `marital_status` enum('Ameoa','Ameolewa','Hajaoa','Hajaolewa','Mjane','Mgane') DEFAULT NULL,
  `spouse_name` varchar(255) DEFAULT NULL,
  `number_of_children` int(11) DEFAULT NULL,
  `residential_zone` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `date_of_conversion` date DEFAULT NULL,
  `church_of_conversion` varchar(255) DEFAULT NULL,
  `baptism_date` date DEFAULT NULL,
  `baptism_place` varchar(255) DEFAULT NULL,
  `baptizer_name` varchar(255) DEFAULT NULL,
  `baptizer_title` varchar(255) DEFAULT NULL,
  `previous_church` varchar(255) DEFAULT NULL,
  `previous_church_status` varchar(255) DEFAULT NULL,
  `tangu_lini` varchar(255) DEFAULT NULL,
  `church_service` varchar(255) DEFAULT NULL,
  `service_duration` varchar(255) DEFAULT NULL,
  `education_level` varchar(255) DEFAULT NULL,
  `profession` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `work_place` varchar(255) DEFAULT NULL,
  `work_contact` varchar(255) DEFAULT NULL,
  `lives_alone` tinyint(1) DEFAULT NULL,
  `lives_with` text DEFAULT NULL,
  `family_role` varchar(255) DEFAULT NULL,
  `live_with_who` varchar(255) DEFAULT NULL,
  `next_of_kin` varchar(255) DEFAULT NULL,
  `next_of_kin_phone` varchar(255) DEFAULT NULL,
  `membership_number` varchar(255) DEFAULT NULL,
  `verified_by` varchar(255) DEFAULT NULL,
  `membership_start_date` date DEFAULT NULL,
  `membership_status` enum('active','left','detained','deceased','lost') NOT NULL DEFAULT 'active',
  `deactivation_reason` varchar(255) DEFAULT NULL,
  `is_authorized` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`id`, `user_id`, `full_name`, `gender`, `birth_date`, `birth_place`, `birth_district`, `marital_status`, `spouse_name`, `number_of_children`, `residential_zone`, `phone_number`, `email`, `date_of_conversion`, `church_of_conversion`, `baptism_date`, `baptism_place`, `baptizer_name`, `baptizer_title`, `previous_church`, `previous_church_status`, `tangu_lini`, `church_service`, `service_duration`, `education_level`, `profession`, `occupation`, `work_place`, `work_contact`, `lives_alone`, `lives_with`, `family_role`, `live_with_who`, `next_of_kin`, `next_of_kin_phone`, `membership_number`, `verified_by`, `membership_start_date`, `membership_status`, `deactivation_reason`, `is_authorized`, `created_at`, `updated_at`) VALUES
(12, 15, 'Tumaini  Peter Kaaya', 'M', '2025-12-30', '22 Feb 1991', NULL, 'Ameoa', 'Angela Kalalu', 0, 'Kijichi', '255712104508', 'Kaayah9@gmail.com', '2006-10-07', 'TAG Ungandi B', '2007-12-30', 'TAG Ilongero', 'Mchungaji Musa', 'Mchungaji', NULL, NULL, NULL, 'Media', NULL, 'Elimu ya chuo kikuu', NULL, 'Nimejiajiri', 'Makumbusho', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 0, '2025-12-31 00:41:05', '2025-12-31 00:41:05'),
(13, 16, 'Oscar Batista Kindole', 'M', '1979-01-04', 'Iringa DC', NULL, 'Ameoa', 'Janet Chisi', 5, 'Kongowe', '255784824624', 'oscarkindole@gmail.com', '1996-10-18', 'George PHC', '1998-01-25', 'George PHC', 'Cesus Tembo', 'Mchungaji', NULL, NULL, NULL, 'Mchungaji', NULL, 'Elimu ya chuo', NULL, 'Nimeajiriwa', 'FPCT Kurasini', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, 'active', NULL, 0, '2026-01-02 23:10:00', '2026-01-03 03:15:34'),
(14, 17, 'Isaya Raphael Mwanyamba', 'M', '1979-12-19', 'Handeni TC/Tanga', NULL, 'Ameoa', 'Loveness Mollel', 3, 'Kigamboni', '255787001007', 'kakaisaya@gmail.com', '1990-07-01', 'FPCT Handeni', '1995-12-10', 'FPCT Mombo', 'Gabriel Mwampulo', 'Mchungaji', NULL, NULL, NULL, 'Mzee wa Kanisa', NULL, 'Elimu ya chuo kikuu', NULL, 'Nimeajiriwa', 'Taasisi ya Uhasibu Tanzania', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0002', NULL, NULL, 'active', NULL, 0, '2026-01-03 11:35:08', '2026-01-03 11:45:06'),
(16, 19, 'Reuben Bulugu', 'M', '1963-04-16', 'Bariadi Simiyu', NULL, 'Ameoa', 'Jane Martine', 5, 'Kongowe', '255754544438', 'bulugur@yahoo.com', '1981-06-08', 'PAG', '1982-01-10', 'PAG Igegu Bariadi', 'Pastor Patroba Nyagori', 'Mchungaji', NULL, NULL, NULL, 'Mzee wa Kanisa', NULL, 'Elimu ya chuo kikuu', NULL, 'Nimeajiriwa', 'FPCT-Centre', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0003', NULL, NULL, 'active', NULL, 0, '2026-01-03 22:19:30', '2026-01-03 23:01:17'),
(17, 20, 'Dr. Suleiman Mathew IKOMBA', 'M', '1967-03-05', 'Kigoma Rular KIGOMA', NULL, 'Ameoa', 'Philomena Solomon Muhamila', 3, 'Mgeninani', '255788677472', 'suleimanikomba@gmail.com', '1987-12-06', 'Pentekoste Motomoto', '1987-12-25', 'Bitale Kigoma', 'Askofu Mathayo Suleiman', 'Askofu', NULL, NULL, NULL, 'Mzee wa Kanisa', NULL, 'Elimu ya chuo kikuu', NULL, 'Nimeajiriwa', 'Manispaa ya Temeke', 'Box 46343 Dar es Salaam', 0, NULL, NULL, NULL, NULL, NULL, '0004', NULL, NULL, 'active', NULL, 0, '2026-01-04 11:40:19', '2026-01-04 22:37:49'),
(18, 21, 'Abigail Suleiman Mathew', 'F', '2004-08-12', 'Dar es Salaam, Temeke', NULL, 'Hajaolewa', NULL, 0, 'Mgeninani', '255699650632', 'abigailmathew34@gmail.com', '2022-06-22', 'Mbeya', '2023-06-04', 'FPCT Kurasini', 'Mch. Oscar Kindole', 'Mchungaji Kiongozi', NULL, NULL, NULL, 'Hakuna kwa sasa', NULL, 'Elimu ya chuo kikuu', NULL, 'Mwanafunzi', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'left', 'Amehama', 0, '2026-01-05 10:44:00', '2026-01-16 07:53:45'),
(19, 22, 'DAMIAN GERVAS NDABATINYA', 'M', '1972-07-01', 'BUHIGWE KIGOMA', NULL, 'Ameoa', 'GERDA PAULO TEBUYE', 4, 'Tandika', '255758047674', 'kigomawax@gmail.com', '1992-07-10', 'MBEYA PENTECOST CURCH', '1992-09-01', 'MBEYA PENTECOST CHURCH', 'JACKSON MWALYEGO', 'MCHUNGAJI', NULL, NULL, NULL, 'MZEE WA KANISA', NULL, 'Elimu ya chuo', NULL, 'Nimejiajiri', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0005', NULL, NULL, 'active', NULL, 0, '2026-01-07 11:13:50', '2026-01-07 14:22:51'),
(20, 23, 'Julius Kindole', 'M', '1981-06-03', 'Ilala, Dar Es Salaam', NULL, 'Ameoa', 'Emiliana Peter Kaaya', 4, 'Mgeninani', '255719800813', 'kindole72@gmail.com', '1999-01-10', 'Pentecostal New Hope', '2002-09-21', 'FPCT Kurasini', 'Mch. Daniel Mghenyi', 'Mchungaji kiongozi', NULL, NULL, NULL, 'Mwimbaji', NULL, 'Elimu ya chuo', NULL, 'Nimeajiriwa', 'Printzone Limited', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0006', NULL, NULL, 'active', NULL, 0, '2026-01-07 14:07:25', '2026-01-07 14:23:03'),
(21, 24, 'Sospeter Bathoha', 'M', '1975-04-06', 'Kigoma', NULL, 'Ameoa', 'Elicia Sekishahu Kisoma', 3, 'Mbande', '255768920734', 'sbathoha@gmail.com', '1992-10-20', 'Msimba', '1992-12-19', 'Kamara', 'Pinoni Rilageza', 'Mchungaji', NULL, NULL, NULL, 'Mzee wa Kanisa na Mwimbaji', NULL, 'Elimu ya chuo kikuu', NULL, 'Nimeajiriwa', 'Chuo Kikuu cha Kikatoliki Mwenge', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0007', NULL, NULL, 'active', NULL, 0, '2026-01-07 15:08:26', '2026-01-09 10:04:32'),
(22, 25, 'NTULI KAPOLOGWE', 'M', '1985-01-27', 'Mbeya', NULL, 'Ameoa', 'Neema Peter Mndeme', 4, 'Mbande', '255758833304', 'wapastantuli@gmail.com', '2006-04-09', 'EAGT Soweto Mbeya', '2007-01-14', 'Dar es salaam', 'Mchungaji John', 'Mchungaji', NULL, NULL, NULL, 'Ualimu wa Neno, huduma ya Vijana', NULL, 'Elimu ya chuo kikuu', 'Uhasibu na Usimamizi wa miradi', 'Nimeajiriwa', 'Arusha/Mikoa ya Kusini', '0758833304', 0, NULL, NULL, NULL, NULL, NULL, '0008', NULL, NULL, 'active', NULL, 0, '2026-01-17 10:06:48', '2026-01-18 14:14:13');

-- --------------------------------------------------------

--
-- Table structure for table `member_group`
--

CREATE TABLE `member_group` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `group_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `member_group`
--

INSERT INTO `member_group` (`id`, `member_id`, `group_id`, `created_at`, `updated_at`) VALUES
(1, 13, 8, '2026-01-27 22:47:34', '2026-01-27 22:47:34');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2025_05_19_135833_create_groups_table', 1),
(2, '2025_05_19_140701_create_sessions_table', 1),
(3, '2025_05_19_143136_create_users_table', 1),
(4, '2025_05_19_145151_create_members_table', 1),
(5, '2025_05_19_152738_create_cache_table', 1),
(6, '2025_05_19_152903_create_personal_access_tokens_table', 1),
(7, '2025_05_20_160505_add_role_to_users_table', 1),
(8, '2025_05_24_152906_create_member_group_table', 1),
(9, '2025_05_24_221613_add_deactivation_reason_to_members_table', 1),
(10, '2025_05_25_010524_create_deleted_members_table', 1),
(11, '2025_05_25_022113_create_roles_table', 1),
(12, '2025_05_25_023307_add_role_id_to_users_table', 1),
(13, '2025_05_28_023331_create_guests_table', 1),
(14, '2025_05_28_180013_create_leadership_roles_table', 1),
(15, '2025_05_28_215130_create_leaders_table', 1),
(16, '2025_05_28_231210_add_status_to_leaders_table', 1),
(17, '2025_05_29_011805_create_events_table', 1),
(18, '2025_05_29_035001_create_contributions_table', 1),
(19, '2025_05_29_045500_create_contribution_types_table', 1),
(20, '2025_05_29_163350_create_assets_table', 1),
(21, '2025_05_29_164328_add_quantity_to_assets_table', 1),
(22, '2025_05_30_004603_add_protected_to_leadership_roles_table', 1),
(23, '2025_05_30_053817_create_sms_logs_table', 1),
(24, '2025_05_30_145145_add_receiver_to_sms_logs_table', 1),
(25, '2025_05_30_154922_update_leader_column_in_groups_table', 1),
(26, '2025_05_30_155630_rollback_leader_column_in_groups_table', 1),
(27, '2025_05_30_160254_add_leader_id_to_groups_table', 1),
(28, '2025_06_01_090502_create_galleries_table', 1),
(29, '2025_06_22_140334_update_marital_status_enum_in_users_table', 1),
(30, '2025_06_22_140606_update_marital_status_in_members_table', 1),
(31, '2025_06_23_150111_create_user_settings_table', 1),
(32, '2025_10_03_152712_add_new_fields_to_members_table', 1),
(33, '2025_10_03_154613_add_birth_district_to_users_table', 1),
(34, '2026_01_09_070450_create_password_resets_table', 2),
(35, '2026_01_17_135132_add_leader_code_to_leaders_table', 3),
(36, '2026_01_11_071705_create_personal_access_tokens_table', 1),
(37, '2025_11_27_092441_create_jobs_table', 4),
(38, '2026_01_22_115409_create_leader_leadership_role_table', 4),
(39, '2026_01_22_151715_remove_leadership_role_id_from_leaders_table', 5),
(40, '2026_01_24_062827_update_groups_table_structure', 6),
(41, '2026_01_22_144548_add_timestamps_to_leader_leadership_role_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('shadrackmussa97@gmail.com', '$2y$12$.NI3W.qzB48j88VftVUIQeAJC2c4M1FsDWyoycstWsu6R3HPWRYo6', '2026-01-15 16:05:57'),
('kaayah9@gmail.com', '$2y$12$LQuKNq/pmDbbpHaYl59b/eYtzxj5NOHqYZvtcg16.LSLCDpFQKq9G', '2026-01-21 21:38:35');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', '1c9526148781d95f6565ff0a9382c653a069c50bb8787fb8a77164e3081c1247', '[\"*\"]', NULL, NULL, '2025-11-16 21:59:12', '2025-11-16 21:59:12'),
(3, 'App\\Models\\User', 1, 'auth_token', '4deb4d278c7138b2e64bdf1839dac49690db036094c13e4b9d3fc901d4873084', '[\"*\"]', '2025-11-18 11:56:10', NULL, '2025-11-18 11:56:09', '2025-11-18 11:56:10'),
(5, 'App\\Models\\User', 1, 'auth_token', 'e433b3cd72e36c509cadf93e7ce2ee38b85c78a26ee238bf05420aea4f63328c', '[\"*\"]', '2025-11-18 15:07:29', NULL, '2025-11-18 15:05:50', '2025-11-18 15:07:29'),
(7, 'App\\Models\\User', 2, 'auth_token', '904ae257b8a03e201c25cbc7ceff611cb0b04882cab9b830e71cf29bc4e07386', '[\"*\"]', NULL, NULL, '2025-11-18 15:31:04', '2025-11-18 15:31:04'),
(10, 'App\\Models\\User', 1, 'auth_token', 'd212ecdaad9ff030492e68868f9f1f95d9d111c2d1fa5336112d6c4bd8080303', '[\"*\"]', '2025-11-27 13:27:29', NULL, '2025-11-27 13:26:34', '2025-11-27 13:27:29'),
(11, 'App\\Models\\User', 1, 'auth_token', 'ca1b96e0d55df8ed841ad29f2e7a93d6447c56a6d1cd563e145a40007de1cc07', '[\"*\"]', '2025-12-06 12:13:22', NULL, '2025-12-03 12:55:25', '2025-12-06 12:13:22'),
(12, 'App\\Models\\User', 1, 'auth_token', '510ff6887a1cafa89da8244a346faaf3561ecdd244c324c9ab88d01234c455e1', '[\"*\"]', NULL, NULL, '2025-12-06 10:53:14', '2025-12-06 10:53:14'),
(13, 'App\\Models\\User', 1, 'auth_token', '1eb0df9fb8c04149acefc1de60b428cbd6ee32b59869fba342cca57d77e604b0', '[\"*\"]', NULL, NULL, '2025-12-06 11:33:29', '2025-12-06 11:33:29'),
(15, 'App\\Models\\User', 1, 'auth_token', 'b29b8031bfa50de7bde599e5989f6c8e8beb8645fd05ebb0b1481815aeb7c441', '[\"*\"]', '2025-12-06 13:51:57', NULL, '2025-12-06 11:40:52', '2025-12-06 13:51:57'),
(17, 'App\\Models\\User', 3, 'auth_token', '04ce1b806ad1c1beb50093c36046ce25cdf474d4d938804cc58efd211274fe8a', '[\"*\"]', NULL, NULL, '2025-12-06 12:03:53', '2025-12-06 12:03:53'),
(18, 'App\\Models\\User', 1, 'auth_token', 'a33fb0d3c4bcf1f251a9cf2841c112dcca6620918bbb11e89c76c91e770c96ac', '[\"*\"]', '2025-12-06 12:06:21', NULL, '2025-12-06 12:04:09', '2025-12-06 12:06:21'),
(19, 'App\\Models\\User', 1, 'auth_token', '54999621ba5a124c69ebb5d1276a56269aff2b5e9acd40e648f837af94760c11', '[\"*\"]', '2025-12-06 16:22:10', NULL, '2025-12-06 12:16:56', '2025-12-06 16:22:10'),
(20, 'App\\Models\\User', 4, 'auth_token', '7b3d883cd178c81f8bdee0ba4442e9f5dc81fdb71b097b95b0217907daba80c1', '[\"*\"]', NULL, NULL, '2025-12-06 12:25:59', '2025-12-06 12:25:59'),
(21, 'App\\Models\\User', 5, 'auth_token', '16419b7971e98b0cac9e2aee7a3b212243d51f91e7e37c5276bec1d7226fc582', '[\"*\"]', NULL, NULL, '2025-12-06 12:37:31', '2025-12-06 12:37:31'),
(22, 'App\\Models\\User', 6, 'auth_token', '1f95afae49be0eb5865fb0b1cea4103f51c40a1b1faafbb24a100e8c6370fc33', '[\"*\"]', NULL, NULL, '2025-12-06 13:50:25', '2025-12-06 13:50:25'),
(23, 'App\\Models\\User', 7, 'auth_token', '4dec3c0e089b2432d9c5bd6cd14685b9d95e9ae8d9bb07bb9ef6ca22137cedbd', '[\"*\"]', NULL, NULL, '2025-12-06 16:13:34', '2025-12-06 16:13:34'),
(24, 'App\\Models\\User', 1, 'auth_token', 'e8a611170a6803413d69786c776eee68668f8a03bb51514315dbf5c4d1110082', '[\"*\"]', '2025-12-06 16:16:19', NULL, '2025-12-06 16:15:21', '2025-12-06 16:16:19'),
(26, 'App\\Models\\User', 8, 'auth_token', '6e55da5b9ecf035b71076d23d6d0603c3e3e42fbdc2908be45795eeac33d19c2', '[\"*\"]', NULL, NULL, '2025-12-08 17:40:21', '2025-12-08 17:40:21'),
(27, 'App\\Models\\User', 1, 'auth_token', 'b63345490f01cae7bbca853e8d023236e2276357e2bf6740b256f371ff314ba3', '[\"*\"]', '2025-12-08 17:40:56', NULL, '2025-12-08 17:40:28', '2025-12-08 17:40:56'),
(29, 'App\\Models\\User', 9, 'auth_token', 'b4e808b2bce7de7c99f1d70bc8c1c8fa18a32de69f1472d8d2cd4baf80a1d1e2', '[\"*\"]', NULL, NULL, '2025-12-13 16:06:49', '2025-12-13 16:06:49'),
(31, 'App\\Models\\User', 1, 'auth_token', '17c1269fe95c9c42f40ae87293c4f2ea2572592e83d9c14370bc33dd790d13c3', '[\"*\"]', '2025-12-13 16:21:12', NULL, '2025-12-13 16:21:11', '2025-12-13 16:21:12'),
(32, 'App\\Models\\User', 1, 'auth_token', 'a72c03af2ecd55ebe1d3c2f3116bac1ab02b227c90dccf3fdae663d5ffc521b5', '[\"*\"]', '2025-12-28 21:37:09', NULL, '2025-12-28 21:37:06', '2025-12-28 21:37:09'),
(35, 'App\\Models\\User', 10, 'auth_token', 'd471b613c3be02c0515de87b93252f84b2c66cbf1e37d2ea1a457870234a583b', '[\"*\"]', NULL, NULL, '2025-12-30 12:12:32', '2025-12-30 12:12:32'),
(37, 'App\\Models\\User', 11, 'auth_token', '747880838eee6b6d745d825710a9576ff2274b6c27c60379c875d656c3edd22c', '[\"*\"]', NULL, NULL, '2025-12-30 12:23:59', '2025-12-30 12:23:59'),
(38, 'App\\Models\\User', 1, 'auth_token', 'a8712902025f6c16be04a4f26d01d61467f7f2d4aef681620a12c988bc2aa4d2', '[\"*\"]', '2025-12-30 12:28:55', NULL, '2025-12-30 12:24:31', '2025-12-30 12:28:55'),
(40, 'App\\Models\\User', 1, 'auth_token', '5b960b6054997dcf577ba737bc7618165cf58413cafbfe69adc10aa6674edf31', '[\"*\"]', '2025-12-30 21:20:58', NULL, '2025-12-30 21:20:00', '2025-12-30 21:20:58'),
(41, 'App\\Models\\User', 15, 'auth_token', '7666d17fcee664f0f1ad9ecfc6dcb008b2d0b774402ce64b9fb748d21dde0640', '[\"*\"]', NULL, NULL, '2025-12-31 00:41:05', '2025-12-31 00:41:05'),
(42, 'App\\Models\\User', 15, 'auth_token', 'c1d3cc2c01698d865c1c608a1079ccecb115ae5a7a70dee4b8499ce26e223720', '[\"*\"]', '2025-12-31 02:38:03', NULL, '2025-12-31 02:37:42', '2025-12-31 02:38:03'),
(43, 'App\\Models\\User', 15, 'auth_token', '516a5193e93c4a83c9713a12459adcaafb1d3f625fb931ef287c36a2b9064bc5', '[\"*\"]', '2025-12-31 10:29:38', NULL, '2025-12-31 10:29:37', '2025-12-31 10:29:38'),
(44, 'App\\Models\\User', 15, 'auth_token', 'de87dc1b81ed3c9b1b94808ee2545db73185d905f479627b896e041527f566f9', '[\"*\"]', '2025-12-31 10:34:59', NULL, '2025-12-31 10:34:58', '2025-12-31 10:34:59'),
(46, 'App\\Models\\User', 15, 'auth_token', '57d7dc73bf10bd7d566d8728f334a0670a7819bd62ceea66524342f22a3accd6', '[\"*\"]', '2026-01-02 14:09:51', NULL, '2026-01-01 11:21:48', '2026-01-02 14:09:51'),
(47, 'App\\Models\\User', 15, 'auth_token', '8865e24a0cae5dca272484995aa1017388ba8e9cd5a5cf7ddfea06e76b6082c0', '[\"*\"]', '2026-01-02 13:26:21', NULL, '2026-01-02 13:26:07', '2026-01-02 13:26:21'),
(49, 'App\\Models\\User', 15, 'auth_token', '0db94760cde627a0e694740fba2b6b84659e80c517ab9490f41c2ede14fc410e', '[\"*\"]', '2026-01-02 20:21:27', NULL, '2026-01-02 20:19:37', '2026-01-02 20:21:27'),
(50, 'App\\Models\\User', 16, 'auth_token', '14ca3522c71cc0516cf917d49f31dc424b9b93cc3d4bc8129f6987e03e9adc09', '[\"*\"]', NULL, NULL, '2026-01-02 23:10:00', '2026-01-02 23:10:00'),
(51, 'App\\Models\\User', 15, 'auth_token', '45a4563fba95adb2ebed57003dad45e0a382d02f7f047bc68f11689b5983e01e', '[\"*\"]', '2026-01-03 03:15:48', NULL, '2026-01-03 03:15:18', '2026-01-03 03:15:48'),
(52, 'App\\Models\\User', 15, 'auth_token', '367645e27ef9c0033193eb1905ac12ae583b59bc9c104114cda61410f9ed8cd5', '[\"*\"]', '2026-01-03 03:16:38', NULL, '2026-01-03 03:16:11', '2026-01-03 03:16:38'),
(53, 'App\\Models\\User', 15, 'auth_token', '0e44be6e9d8f81cbb13167f7a5a682a199ff8db68cfb9f977a468382ddfa9e15', '[\"*\"]', '2026-01-03 10:21:55', NULL, '2026-01-03 10:21:30', '2026-01-03 10:21:55'),
(54, 'App\\Models\\User', 17, 'auth_token', 'c8381e1fceb0b887947532e69d8ae4063c46a98ae75267dac56c05f5da10faf5', '[\"*\"]', NULL, NULL, '2026-01-03 11:35:08', '2026-01-03 11:35:08'),
(55, 'App\\Models\\User', 15, 'auth_token', 'bc5d804071eac4ddad88ee19ec1dbe2a163eb616211628060ef591594633ad91', '[\"*\"]', '2026-01-03 11:45:11', NULL, '2026-01-03 11:44:55', '2026-01-03 11:45:11'),
(56, 'App\\Models\\User', 15, 'auth_token', '81c836acd38d5f217665af6239e8c448076932e8be77b4091b64dde264563b61', '[\"*\"]', '2026-01-03 11:46:14', NULL, '2026-01-03 11:45:22', '2026-01-03 11:46:14'),
(57, 'App\\Models\\User', 15, 'auth_token', '4fa54e01f0a90c2e0e95f615aae53edac8093a3b6d070786980accb836d0297f', '[\"*\"]', '2026-01-03 11:46:19', NULL, '2026-01-03 11:46:19', '2026-01-03 11:46:19'),
(58, 'App\\Models\\User', 17, 'auth_token', 'aa11b763f2e50ce9bfcf58bd6439f7d4cb51a6fa8f9f02ab4dd5a9bffeeb2af8', '[\"*\"]', '2026-01-03 13:30:40', NULL, '2026-01-03 13:24:07', '2026-01-03 13:30:40'),
(60, 'App\\Models\\User', 18, 'auth_token', 'a82799066e4cf7a1bc539bb0ca1115a405593f91103dd518308a934ca8e1d95a', '[\"*\"]', NULL, NULL, '2026-01-03 14:21:31', '2026-01-03 14:21:31'),
(62, 'App\\Models\\User', 15, 'auth_token', 'b2521e97b2995765afd535951c17a4f748f48198be1a99ac9096f7da1862985e', '[\"*\"]', '2026-01-03 14:32:54', NULL, '2026-01-03 14:32:41', '2026-01-03 14:32:54'),
(64, 'App\\Models\\User', 15, 'auth_token', '407f7fc26126882406bcd8956a54d4aa1fc2a317ac1f07552afd984380f56aad', '[\"*\"]', '2026-01-03 14:34:21', NULL, '2026-01-03 14:34:20', '2026-01-03 14:34:21'),
(65, 'App\\Models\\User', 15, 'auth_token', '8123ce4566429389612f58011547104b56ddd62075ccb211b5565ab26d3e43fe', '[\"*\"]', '2026-01-03 14:34:57', NULL, '2026-01-03 14:34:51', '2026-01-03 14:34:57'),
(66, 'App\\Models\\User', 15, 'auth_token', '2c0ba606a940316f0fad905dbdd96f1886b5f6390271db33fff9b4fe4078f5e4', '[\"*\"]', '2026-01-03 16:51:55', NULL, '2026-01-03 16:51:54', '2026-01-03 16:51:55'),
(67, 'App\\Models\\User', 15, 'auth_token', '06566217a6fc0a43fb7f226a440b844342dcd32ddc5418e82eb048f208d9a459', '[\"*\"]', '2026-01-03 18:13:06', NULL, '2026-01-03 18:13:05', '2026-01-03 18:13:06'),
(68, 'App\\Models\\User', 17, 'auth_token', 'bb6f28bb1af294304bf2d1fc0831f3877280c0cb83cfa7e03fca0860887f189a', '[\"*\"]', '2026-01-03 21:09:37', NULL, '2026-01-03 21:07:38', '2026-01-03 21:09:37'),
(69, 'App\\Models\\User', 17, 'auth_token', 'ab3188da9fc21cd3ab7d6aac6b916745fa6236e6257cab33b6c2dd30f254ac17', '[\"*\"]', '2026-01-03 21:14:55', NULL, '2026-01-03 21:10:54', '2026-01-03 21:14:55'),
(70, 'App\\Models\\User', 17, 'auth_token', '84b7d46713c2b3b16efc51d6fbb559cd29ef3f1f57da649fa0117a63696ce49d', '[\"*\"]', '2026-01-03 21:17:33', NULL, '2026-01-03 21:16:25', '2026-01-03 21:17:33'),
(71, 'App\\Models\\User', 17, 'auth_token', '12b012b47c4f360d03e12e9112dff3cbad36c0f2034469b2c058d5db45d376af', '[\"*\"]', '2026-01-03 21:23:04', NULL, '2026-01-03 21:18:46', '2026-01-03 21:23:04'),
(72, 'App\\Models\\User', 17, 'auth_token', '9f58b369a4e4db4c5d41960b18d721ae62ef1840f8cc6fc23cb1dd12922ac954', '[\"*\"]', '2026-01-03 21:38:32', NULL, '2026-01-03 21:38:30', '2026-01-03 21:38:32'),
(73, 'App\\Models\\User', 15, 'auth_token', 'd128fcdd9188e96d1148258530b05bd1a25195da662c2ddc0eef8f8c8ebbda03', '[\"*\"]', '2026-01-06 11:31:45', NULL, '2026-01-03 21:54:57', '2026-01-06 11:31:45'),
(74, 'App\\Models\\User', 15, 'auth_token', '4011e87892b6abdd6e8d86bc556bbe3cf6d08fe127add9c6c5d8ed9da7a5aa2e', '[\"*\"]', '2026-01-03 21:55:20', NULL, '2026-01-03 21:55:20', '2026-01-03 21:55:20'),
(75, 'App\\Models\\User', 17, 'auth_token', 'fa023070d58fbe7d56ef93e608348fb589887fe6ee3782dcb942e9d54950b2ee', '[\"*\"]', '2026-01-03 21:59:26', NULL, '2026-01-03 21:59:25', '2026-01-03 21:59:26'),
(76, 'App\\Models\\User', 15, 'auth_token', 'cba55e489923af50abd160b9d2faf07198e18e322b85885d642194b9ff834e1d', '[\"*\"]', '2026-01-03 22:00:08', NULL, '2026-01-03 22:00:08', '2026-01-03 22:00:08'),
(77, 'App\\Models\\User', 15, 'auth_token', '38578d3092936d1d42305d9b0fd8149b9a62f603ada67dc1e68a94cfc6a6c29f', '[\"*\"]', '2026-01-03 22:00:41', NULL, '2026-01-03 22:00:29', '2026-01-03 22:00:41'),
(78, 'App\\Models\\User', 15, 'auth_token', '4e8c7f9460f25aa977871a0fb1ad67f7955b06597481ff08113e4c5213e30ec8', '[\"*\"]', '2026-01-03 22:02:55', NULL, '2026-01-03 22:00:45', '2026-01-03 22:02:55'),
(79, 'App\\Models\\User', 15, 'auth_token', '6fb296913cb8222b4e27128b559a97d00bd513f0a6a3b89ae878d9902a8cd200', '[\"*\"]', '2026-01-03 22:05:14', NULL, '2026-01-03 22:04:32', '2026-01-03 22:05:14'),
(80, 'App\\Models\\User', 15, 'auth_token', 'e6f3a981cb8a242017248f8dc01df4954b2fb4dec9f09e0cd4bc71b7b0369f12', '[\"*\"]', '2026-01-03 22:05:51', NULL, '2026-01-03 22:05:31', '2026-01-03 22:05:51'),
(81, 'App\\Models\\User', 15, 'auth_token', 'dc7cd307bb348bd0edc0109024584e4920d9032b58c692fcb6dd77b4d9a0e7e3', '[\"*\"]', '2026-01-03 22:06:57', NULL, '2026-01-03 22:06:04', '2026-01-03 22:06:57'),
(82, 'App\\Models\\User', 15, 'auth_token', '0b4d82bfa4ab0cf8dffc66dfe0ff5d51fc103a3a9755559c69b1959e98594805', '[\"*\"]', '2026-01-03 22:10:32', NULL, '2026-01-03 22:07:34', '2026-01-03 22:10:32'),
(83, 'App\\Models\\User', 15, 'auth_token', '3971e0da513f6ae89781db2e044d7041d7c6b1d23ee91e8ba0d23e333372e786', '[\"*\"]', '2026-01-03 22:12:58', NULL, '2026-01-03 22:11:10', '2026-01-03 22:12:58'),
(84, 'App\\Models\\User', 15, 'auth_token', 'aeebf171162032ae332a707acf669b87089c41cc3dad26773b83a3edcaa3ef28', '[\"*\"]', '2026-01-03 22:13:15', NULL, '2026-01-03 22:13:05', '2026-01-03 22:13:15'),
(85, 'App\\Models\\User', 15, 'auth_token', '3969b79e529337ec5cc7eabde2f338e431c912392b7031c34b3178835cf16639', '[\"*\"]', '2026-01-03 22:13:40', NULL, '2026-01-03 22:13:38', '2026-01-03 22:13:40'),
(86, 'App\\Models\\User', 19, 'auth_token', 'f24f57c0b5a77663b39fe8db1bd2b8888a86e050406204766cf2cc7077db9d23', '[\"*\"]', NULL, NULL, '2026-01-03 22:19:30', '2026-01-03 22:19:30'),
(87, 'App\\Models\\User', 17, 'auth_token', '0c2018ad4de406a374d0ad49400df057fca7f468b6c2bba5962944ce5d557bb0', '[\"*\"]', '2026-01-03 22:54:43', NULL, '2026-01-03 22:54:16', '2026-01-03 22:54:43'),
(88, 'App\\Models\\User', 17, 'auth_token', '5d1cc915a0fd8a24af31157f021c8e1d66691c20ed3fec17d8fbfb40ee7b64e5', '[\"*\"]', '2026-01-03 22:56:48', NULL, '2026-01-03 22:55:03', '2026-01-03 22:56:48'),
(89, 'App\\Models\\User', 17, 'auth_token', '874a5d2844d4eb83fefea9be819e435bb00c1311fa2d46d4cafd8d4d6d1f293f', '[\"*\"]', '2026-01-03 23:01:31', NULL, '2026-01-03 22:56:54', '2026-01-03 23:01:31'),
(90, 'App\\Models\\User', 15, 'auth_token', 'a1497b18a78180c9bb9954adfc4fd5fab3210ece5020e2cb85a700bccfdd6ae6', '[\"*\"]', '2026-01-03 23:11:25', NULL, '2026-01-03 23:11:23', '2026-01-03 23:11:25'),
(91, 'App\\Models\\User', 15, 'auth_token', 'cc8de659540c24ac3a85fed77048fa7ec9df161a8208fb35ac14a0f4974d6e99', '[\"*\"]', '2026-01-03 23:11:44', NULL, '2026-01-03 23:11:39', '2026-01-03 23:11:44'),
(92, 'App\\Models\\User', 17, 'auth_token', 'a8abeb8f1f05705fd8b6c2d75a74de70e3da8162ec43e786a3255deb4ce0a7f9', '[\"*\"]', '2026-01-03 23:15:35', NULL, '2026-01-03 23:14:42', '2026-01-03 23:15:35'),
(93, 'App\\Models\\User', 17, 'auth_token', '3bde4d43048d9f0d31d9817d8fce52dee69c52289199d9620475cba7be49abbc', '[\"*\"]', '2026-01-03 23:15:52', NULL, '2026-01-03 23:15:51', '2026-01-03 23:15:52'),
(94, 'App\\Models\\User', 15, 'auth_token', '0442fb6526535eada3b3b87a895ad7cdbd33f5bdf05978cc01b10516b4ec18d1', '[\"*\"]', '2026-01-03 23:38:14', NULL, '2026-01-03 23:38:08', '2026-01-03 23:38:14'),
(95, 'App\\Models\\User', 15, 'auth_token', '634c30271516fbbdb14b5592aad0ebc55bbca5cdc142c39766f74eaf69ab5323', '[\"*\"]', '2026-01-03 23:45:55', NULL, '2026-01-03 23:45:33', '2026-01-03 23:45:55'),
(96, 'App\\Models\\User', 15, 'auth_token', '733bb0bba5fd289ef0a89c219288801a51c6b6231b279626c07cb0f42660582b', '[\"*\"]', '2026-01-04 09:49:56', NULL, '2026-01-04 09:49:19', '2026-01-04 09:49:56'),
(97, 'App\\Models\\User', 15, 'auth_token', 'a95034762e84cb65519c90d87f14534932c94e2a4d4fa8fa3a788365194a98e7', '[\"*\"]', '2026-01-04 09:59:07', NULL, '2026-01-04 09:58:54', '2026-01-04 09:59:07'),
(98, 'App\\Models\\User', 20, 'auth_token', '79350bc68b22bb707ef14c4369f1156b83e109a9a1f4f9c9ebad40aa47afb8bb', '[\"*\"]', NULL, NULL, '2026-01-04 11:40:19', '2026-01-04 11:40:19'),
(99, 'App\\Models\\User', 15, 'auth_token', '358ae332bbbddc6d055254cc5b23a886496741a3378a0321b7670f1805bee0a0', '[\"*\"]', '2026-01-04 21:42:28', NULL, '2026-01-04 21:42:23', '2026-01-04 21:42:28'),
(100, 'App\\Models\\User', 17, 'auth_token', '4097e70fc47a2028cafb8b6381069d6bfa81eb15cc99b7c40f1dbd629c97c23c', '[\"*\"]', '2026-01-04 22:37:57', NULL, '2026-01-04 22:37:02', '2026-01-04 22:37:57'),
(101, 'App\\Models\\User', 15, 'auth_token', '4542b60bcd94cfb914a7182bccae5ce7d3c67b28822b7533fe88ef688b302b97', '[\"*\"]', '2026-01-04 22:42:17', NULL, '2026-01-04 22:41:54', '2026-01-04 22:42:17'),
(102, 'App\\Models\\User', 21, 'auth_token', 'fa2d1b8624400cb149f1b52cfca78a4d42f9e789abfd613f407b8e76aa56da69', '[\"*\"]', NULL, NULL, '2026-01-05 10:44:00', '2026-01-05 10:44:00'),
(103, 'App\\Models\\User', 15, 'auth_token', '212beb0d871dd024559ca8de106d0966020b91d6b5bfe93ddec61ef914a85364', '[\"*\"]', '2026-01-05 18:12:03', NULL, '2026-01-05 17:51:09', '2026-01-05 18:12:03'),
(104, 'App\\Models\\User', 15, 'auth_token', 'f030ef5d9b8bb462abcacb999fedc024c3d96ec854cf1c02cbf557340bc13108', '[\"*\"]', '2026-01-05 18:14:15', NULL, '2026-01-05 18:10:48', '2026-01-05 18:14:15'),
(105, 'App\\Models\\User', 15, 'auth_token', 'e83b18a51a2005b5eaed9bf9847cdf6ebdfea4fb3634e64bd7045de2be97eca3', '[\"*\"]', '2026-01-05 18:14:52', NULL, '2026-01-05 18:14:51', '2026-01-05 18:14:52'),
(106, 'App\\Models\\User', 15, 'auth_token', 'a818eb5dda6c595f32cfccd7fd86ec128792353c701becdd70d4082583c734b7', '[\"*\"]', '2026-01-05 18:15:13', NULL, '2026-01-05 18:15:02', '2026-01-05 18:15:13'),
(107, 'App\\Models\\User', 15, 'auth_token', '885e483c09681b52878ab2223df0453a1517a98c82b0887c07d011cd63223bac', '[\"*\"]', '2026-01-05 21:38:56', NULL, '2026-01-05 21:38:20', '2026-01-05 21:38:56'),
(108, 'App\\Models\\User', 15, 'auth_token', '6bbec34a4e6b7e94b0e8b44296444007fb72141ab9d3a207e6d9747f6460d13e', '[\"*\"]', '2026-01-06 10:54:53', NULL, '2026-01-06 10:54:51', '2026-01-06 10:54:53'),
(109, 'App\\Models\\User', 15, 'auth_token', '1c5ef168dd137594c69b71f1df6890aeb1d1cc449964bb5930b5ddbe37dc3497', '[\"*\"]', '2026-01-06 10:59:50', NULL, '2026-01-06 10:59:35', '2026-01-06 10:59:50'),
(110, 'App\\Models\\User', 15, 'auth_token', 'f866893a1872d0153707a08d931aeff59619b15c67ebbcdac546e41684a0414e', '[\"*\"]', '2026-01-06 11:07:38', NULL, '2026-01-06 11:07:30', '2026-01-06 11:07:38'),
(112, 'App\\Models\\User', 15, 'auth_token', '5275c26d89e556c3b04c99947f7307ba245cc90d153ba82325e75ed7fa3f5bb1', '[\"*\"]', '2026-01-06 15:25:34', NULL, '2026-01-06 15:25:07', '2026-01-06 15:25:34'),
(116, 'App\\Models\\User', 15, 'auth_token', '31049fb459c02d7d895bbb19edec7d209a26802805bf75c5cd6d47cdb2e03e56', '[\"*\"]', NULL, NULL, '2026-01-06 19:06:55', '2026-01-06 19:06:55'),
(117, 'App\\Models\\User', 15, 'auth_token', 'b4e98bc3f38ee67f720fbf2d836ce4024d69166c81da97a194dfec0c30e651c3', '[\"*\"]', '2026-01-06 19:08:03', NULL, '2026-01-06 19:07:29', '2026-01-06 19:08:03'),
(118, 'App\\Models\\User', 15, 'auth_token', '33dd3ecbd23badcc22821c4b34e97d90067f1c07257bbbd82ba39a846dfa5f81', '[\"*\"]', '2026-01-06 20:03:04', NULL, '2026-01-06 19:49:59', '2026-01-06 20:03:04'),
(119, 'App\\Models\\User', 15, 'auth_token', 'd70c608a35709a3ae62a7d6edd5a6c92e2806b89a98d71a0db562fa9b99f9b8c', '[\"*\"]', '2026-01-06 21:25:22', NULL, '2026-01-06 21:16:14', '2026-01-06 21:25:22'),
(120, 'App\\Models\\User', 17, 'auth_token', '2941cb3d9b4ab39cc00efb010a4612925ebece6482f66b7f181550cb6b376bfb', '[\"*\"]', '2026-01-06 22:10:16', NULL, '2026-01-06 22:09:58', '2026-01-06 22:10:16'),
(121, 'App\\Models\\User', 17, 'auth_token', '4f3ac50a329ffd8fe9b59d51b22f07ef92c8a194a256e80d56c2a567b22c8b97', '[\"*\"]', '2026-01-06 23:02:40', NULL, '2026-01-06 23:02:24', '2026-01-06 23:02:40'),
(122, 'App\\Models\\User', 17, 'auth_token', '486f4b70b6a519dd9b20847884599919e23afa1e514a7d4bd8b1ca6a2523d004', '[\"*\"]', '2026-01-06 23:04:18', NULL, '2026-01-06 23:04:17', '2026-01-06 23:04:18'),
(123, 'App\\Models\\User', 17, 'auth_token', '8729c4b181519ca4bb16fa703cefb9104d4c1b46fd653e1c8f3a1781f0034e67', '[\"*\"]', '2026-01-06 23:06:29', NULL, '2026-01-06 23:06:20', '2026-01-06 23:06:29'),
(124, 'App\\Models\\User', 17, 'auth_token', '32e49bd27d9ab8dd8a396acb36807331433e9fd705f65174acb85e3abd988d68', '[\"*\"]', '2026-01-06 23:08:52', NULL, '2026-01-06 23:08:34', '2026-01-06 23:08:52'),
(125, 'App\\Models\\User', 15, 'auth_token', 'e94b35d54cd6af59de61c85fe42b44717ef39a4eec1fd0ee3c960597cb9c007a', '[\"*\"]', '2026-01-06 23:16:39', NULL, '2026-01-06 23:16:25', '2026-01-06 23:16:39'),
(126, 'App\\Models\\User', 15, 'auth_token', '7b29f13b414ff0ed160dab8155a9c60a8e2ac8cf035f2fe5ade26bb1bc26b874', '[\"*\"]', '2026-01-06 23:43:25', NULL, '2026-01-06 23:43:12', '2026-01-06 23:43:25'),
(127, 'App\\Models\\User', 15, 'auth_token', '976740779c5185d224a66f0c96f710976423478d6c5a1218da81ca62982a37be', '[\"*\"]', '2026-01-06 23:43:47', NULL, '2026-01-06 23:43:41', '2026-01-06 23:43:47'),
(128, 'App\\Models\\User', 15, 'auth_token', '7687e6a902b9a86f9b6cdce97a63822d5e7aebf92fc5e23036be964f5c27c468', '[\"*\"]', '2026-01-06 23:44:28', NULL, '2026-01-06 23:44:16', '2026-01-06 23:44:28'),
(129, 'App\\Models\\User', 15, 'auth_token', '6a0daf981c18d878ab0875c1ea33bb4faa9995d681188edbf43ff5e69f6df59b', '[\"*\"]', '2026-01-06 23:45:15', NULL, '2026-01-06 23:44:41', '2026-01-06 23:45:15'),
(130, 'App\\Models\\User', 22, 'auth_token', '711e8ac5a8bc43ead26bd64ff3c776a67ded25955c4795fa185e869aaa364864', '[\"*\"]', NULL, NULL, '2026-01-07 11:13:50', '2026-01-07 11:13:50'),
(131, 'App\\Models\\User', 15, 'auth_token', 'b4b4753c49170e49e164278157eaca2d3129d38e3b530f87b84ebeed007c86ec', '[\"*\"]', '2026-01-07 12:57:42', NULL, '2026-01-07 12:57:32', '2026-01-07 12:57:42'),
(132, 'App\\Models\\User', 23, 'auth_token', '39f5780f22af9e69dafcc5aba1a675b74019134bbcc087094232837eb6521769', '[\"*\"]', NULL, NULL, '2026-01-07 14:07:25', '2026-01-07 14:07:25'),
(133, 'App\\Models\\User', 17, 'auth_token', '776209a6269435b806d2b2b5e54d455c1d58e3a918d6361b68d1c9a617d3faf1', '[\"*\"]', '2026-01-07 14:23:32', NULL, '2026-01-07 14:22:37', '2026-01-07 14:23:32'),
(134, 'App\\Models\\User', 15, 'auth_token', 'c32db3257593edbdd6ed48ac3b6f2aa40a9fd6bc2651c2984f4285f84440ac5b', '[\"*\"]', '2026-01-07 14:36:09', NULL, '2026-01-07 14:34:21', '2026-01-07 14:36:09'),
(135, 'App\\Models\\User', 23, 'auth_token', '67ece10fc8cc5f5dd886a7376cdd7cbc82271da5eeb14367ec01c87c97054a34', '[\"*\"]', '2026-01-07 14:39:16', NULL, '2026-01-07 14:37:30', '2026-01-07 14:39:16'),
(136, 'App\\Models\\User', 15, 'auth_token', 'bb1cca3866574a960bfd061763b7daa7c62e994ea99127cff547a995cc11da3e', '[\"*\"]', '2026-01-07 15:02:36', NULL, '2026-01-07 15:02:05', '2026-01-07 15:02:36'),
(137, 'App\\Models\\User', 15, 'auth_token', 'bb0b1146cd3086aeba78a4e1b7dd811c40931a7062a8791961783e7c68d15686', '[\"*\"]', '2026-01-07 15:08:57', NULL, '2026-01-07 15:03:26', '2026-01-07 15:08:57'),
(138, 'App\\Models\\User', 24, 'auth_token', '463fe3d097c439120a507305d448ea0af4acd6637eb24429a68af6f6541c682f', '[\"*\"]', NULL, NULL, '2026-01-07 15:08:26', '2026-01-07 15:08:26'),
(139, 'App\\Models\\User', 23, 'auth_token', 'd6359296d04347d5bd77c98fcbf804f9a446221939be7c7b524fcb5197ae77cf', '[\"*\"]', '2026-01-07 18:25:17', NULL, '2026-01-07 15:10:06', '2026-01-07 18:25:17'),
(140, 'App\\Models\\User', 17, 'auth_token', '1a5e5f8eafc7cb175def2c443f278bbc9a5186acc2f24095845bb7634c303200', '[\"*\"]', '2026-01-07 16:24:03', NULL, '2026-01-07 16:13:15', '2026-01-07 16:24:03'),
(143, 'App\\Models\\User', 15, 'auth_token', 'b8f426666efcddbdbd89079d81ce0d998843aa420a1ad389ae36208a70977b26', '[\"*\"]', '2026-01-07 19:39:55', NULL, '2026-01-07 19:39:38', '2026-01-07 19:39:55'),
(144, 'App\\Models\\User', 15, 'auth_token', '19407ca8602d1ae43bae829ecb62af6bde3c82556995261d0df7c582f16cb5b4', '[\"*\"]', '2026-01-07 19:42:59', NULL, '2026-01-07 19:41:30', '2026-01-07 19:42:59'),
(145, 'App\\Models\\User', 15, 'auth_token', '62988c22a0fed33706cbb41b765462667bc96de17b51c1f83301b8278ee970cd', '[\"*\"]', '2026-01-07 19:43:49', NULL, '2026-01-07 19:43:13', '2026-01-07 19:43:49'),
(146, 'App\\Models\\User', 15, 'auth_token', 'e01575b1233428f050652ca3b509e4c2d7ffa8536bd1842b4152a8188c3ff6c4', '[\"*\"]', '2026-01-07 19:45:30', NULL, '2026-01-07 19:45:02', '2026-01-07 19:45:30'),
(147, 'App\\Models\\User', 15, 'auth_token', '7ad1a493ef4b8c55f49b08195f0302fc8ba1400a188fe7a95296a0b607680154', '[\"*\"]', '2026-01-07 19:46:25', NULL, '2026-01-07 19:46:20', '2026-01-07 19:46:25'),
(148, 'App\\Models\\User', 15, 'auth_token', '4830af280aaf9a29992fb67f98f3242ec2570608a9368920590ebe4ac8f5b23d', '[\"*\"]', '2026-01-07 19:46:42', NULL, '2026-01-07 19:46:41', '2026-01-07 19:46:42'),
(149, 'App\\Models\\User', 15, 'auth_token', 'e8f6563659a21ba99aaf15fd9630a1af9557f977d43ed52f785439ac6a00a016', '[\"*\"]', '2026-01-07 19:47:11', NULL, '2026-01-07 19:47:07', '2026-01-07 19:47:11'),
(150, 'App\\Models\\User', 15, 'auth_token', 'a8ed79cc6a25bd501238ff6c687d940b6bbde208c014a84e56f90b8410f4855a', '[\"*\"]', '2026-01-07 19:48:44', NULL, '2026-01-07 19:47:38', '2026-01-07 19:48:44'),
(151, 'App\\Models\\User', 15, 'auth_token', '4d62d725517614c191afffd4c0167a4fd360a22a6e69ade0dd84333a6ac7d948', '[\"*\"]', '2026-01-07 19:49:03', NULL, '2026-01-07 19:48:59', '2026-01-07 19:49:03'),
(152, 'App\\Models\\User', 15, 'auth_token', '94ecca88a1e6830868acc26d7bbc61747545f2bed4bd6eef548fa90543f0ef7b', '[\"*\"]', '2026-01-07 19:54:12', NULL, '2026-01-07 19:54:07', '2026-01-07 19:54:12'),
(153, 'App\\Models\\User', 15, 'auth_token', '1574afbcc3fa0d24ee3d8021cd64a993380d8b125b05418a409a5c921a189ac2', '[\"*\"]', '2026-01-07 19:54:35', NULL, '2026-01-07 19:54:33', '2026-01-07 19:54:35'),
(154, 'App\\Models\\User', 15, 'auth_token', 'ee7045ead83825fe5ceab427538f6ab5702351f489f32eafbf605d0bab87559a', '[\"*\"]', '2026-01-07 20:34:54', NULL, '2026-01-07 20:30:30', '2026-01-07 20:34:54'),
(155, 'App\\Models\\User', 15, 'auth_token', 'fe328b8cd31cd2f4f17e7ab9a0a0c786612fe5ac79e5d822aa67b1ecb73c6011', '[\"*\"]', '2026-01-07 20:35:42', NULL, '2026-01-07 20:35:00', '2026-01-07 20:35:42'),
(156, 'App\\Models\\User', 15, 'auth_token', 'bbfec3e74a3816e177a77deecec3df46944225abf601360b10023f87ff1ee591', '[\"*\"]', '2026-01-07 20:36:59', NULL, '2026-01-07 20:35:51', '2026-01-07 20:36:59'),
(157, 'App\\Models\\User', 15, 'auth_token', '94c4cd615458ba25dc1b0bba58ebd1ffec212901318ad0bbd54545b87a61e4c8', '[\"*\"]', '2026-01-07 20:38:23', NULL, '2026-01-07 20:38:22', '2026-01-07 20:38:23'),
(158, 'App\\Models\\User', 15, 'auth_token', '776371db05bd3371744021a804e345a6892d22e3c60eb5a22d6b0694ac77ff2f', '[\"*\"]', '2026-01-07 20:38:59', NULL, '2026-01-07 20:38:42', '2026-01-07 20:38:59'),
(159, 'App\\Models\\User', 15, 'auth_token', '476e482edb4edde7ce40ed173ea2a61ebe0a5203cc294880e268d815e4a43f9a', '[\"*\"]', '2026-01-07 20:46:54', NULL, '2026-01-07 20:46:53', '2026-01-07 20:46:54'),
(160, 'App\\Models\\User', 15, 'auth_token', 'f0a849cfcd1562352bf0707918b4fde4338654e703603c8d01fe9474ba79c32c', '[\"*\"]', '2026-01-07 20:47:33', NULL, '2026-01-07 20:47:32', '2026-01-07 20:47:33'),
(161, 'App\\Models\\User', 15, 'auth_token', '211d59dd972cd70bd430facfe0866fc6bcdd2648c4dad8e9ecf3050e3a2a58e0', '[\"*\"]', '2026-01-07 21:19:32', NULL, '2026-01-07 21:19:18', '2026-01-07 21:19:32'),
(162, 'App\\Models\\User', 15, 'auth_token', 'dce01583c9829f00ce088acb8db81684ef42e864b000e124efdc5a79614cd474', '[\"*\"]', '2026-01-07 21:19:54', NULL, '2026-01-07 21:19:53', '2026-01-07 21:19:54'),
(163, 'App\\Models\\User', 15, 'auth_token', '386a526b26080224ee64939902dcf22b01d69149b247e3062ad163b0f5c05517', '[\"*\"]', '2026-01-07 21:20:30', NULL, '2026-01-07 21:20:29', '2026-01-07 21:20:30'),
(164, 'App\\Models\\User', 15, 'auth_token', 'cdecff4aee60f0ce0716d3ce3ebb06647baac2738e69bd2daf0731b80da717e8', '[\"*\"]', '2026-01-07 21:22:42', NULL, '2026-01-07 21:22:29', '2026-01-07 21:22:42'),
(165, 'App\\Models\\User', 15, 'auth_token', '56cb3db201fd21bc3728678af9d21a3c09a1921093049731c819aaa72a574824', '[\"*\"]', '2026-01-07 21:24:24', NULL, '2026-01-07 21:23:11', '2026-01-07 21:24:24'),
(166, 'App\\Models\\User', 15, 'auth_token', '5e09fc21a97b9eb8501bc12d1f87722b50c458f6138f5315b4939ffcc4b903c9', '[\"*\"]', '2026-01-07 23:39:27', NULL, '2026-01-07 21:43:43', '2026-01-07 23:39:27'),
(167, 'App\\Models\\User', 15, 'auth_token', '2afd9606d2a099045f67ee784017e5ee6f517978c4d0201d6ba2d89e1f2dc173', '[\"*\"]', '2026-01-08 15:30:28', NULL, '2026-01-07 21:47:16', '2026-01-08 15:30:28'),
(168, 'App\\Models\\User', 15, 'auth_token', '8a9a8042cd7b469881867be746429e1c4734bb813ca5ce254117c9ad31fe81ef', '[\"*\"]', '2026-01-07 21:57:02', NULL, '2026-01-07 21:57:02', '2026-01-07 21:57:02'),
(169, 'App\\Models\\User', 15, 'auth_token', '66fcc2fffe4182410b8ca4f3ca26b7fd270f64fab68b96164fe615516dff9afa', '[\"*\"]', NULL, NULL, '2026-01-08 21:53:58', '2026-01-08 21:53:58'),
(170, 'App\\Models\\User', 15, 'auth_token', 'cae1f5d4d7334067189ffc7018c87400f86dbfc37887495323f514f11c0c8454', '[\"*\"]', '2026-01-08 21:54:54', NULL, '2026-01-08 21:54:12', '2026-01-08 21:54:54'),
(171, 'App\\Models\\User', 17, 'auth_token', '30e9750e2a65bab1bb6b21efcb1e528148434433482692239b948cfde61c085c', '[\"*\"]', '2026-01-09 10:04:55', NULL, '2026-01-09 10:02:50', '2026-01-09 10:04:55'),
(172, 'App\\Models\\User', 24, 'auth_token', '4113c9364cf6bd34c38c7fe4dba458410504a3a4b0b76623154614fe2d5b5f6e', '[\"*\"]', '2026-01-09 10:33:15', NULL, '2026-01-09 10:33:11', '2026-01-09 10:33:15'),
(174, 'App\\Models\\User', 15, 'auth_token', 'f91bfa34e5b43ea65c28cc4912fed20f97f99807b3132c72c076f5634136fac1', '[\"*\"]', '2026-01-09 14:37:38', NULL, '2026-01-09 14:37:35', '2026-01-09 14:37:38'),
(175, 'App\\Models\\User', 15, 'auth_token', '58484aeaf48c855dcdf538905663bb69a220c082fcd78c220f5f06a87a82f80b', '[\"*\"]', '2026-01-09 18:23:37', NULL, '2026-01-09 16:47:38', '2026-01-09 18:23:37'),
(176, 'App\\Models\\User', 15, 'auth_token', 'c0b5fbab60e47e206de764024d08120a03db5d083280fdf18d253abf1a975fdd', '[\"*\"]', '2026-01-10 00:35:39', NULL, '2026-01-10 00:35:37', '2026-01-10 00:35:39'),
(178, 'App\\Models\\User', 15, 'auth_token', '41da4a6be5194bfb37ac7a42360b8b8d170d7c0f2b1e684a3172c26585455525', '[\"*\"]', '2026-01-10 14:29:29', NULL, '2026-01-10 14:29:26', '2026-01-10 14:29:29'),
(179, 'App\\Models\\User', 15, 'auth_token', '632d40a586fc820a5be191d5fd656222b322c473e668c4bf3592ff5dc7db6086', '[\"*\"]', '2026-01-10 14:29:52', NULL, '2026-01-10 14:29:43', '2026-01-10 14:29:52'),
(183, 'App\\Models\\User', 15, 'auth_token', '857704215e1ad4b09fb4a881a1b73e68a6cf02a0685947d28e13046667b9fb21', '[\"*\"]', '2026-01-11 12:50:27', NULL, '2026-01-11 12:50:25', '2026-01-11 12:50:27'),
(185, 'App\\Models\\User', 15, 'auth_token', 'ca6dbd7c967b586d0a7e48576323c6150dcc9e6e365e8db04173c0a2c054fe17', '[\"*\"]', '2026-01-12 09:15:05', NULL, '2026-01-12 09:15:02', '2026-01-12 09:15:05'),
(186, 'App\\Models\\User', 17, 'auth_token', '4e0a3109d90db4b7b2c3e5385748a80d20eb5ca302eb68cbf656cbff03454fc1', '[\"*\"]', '2026-01-12 09:58:47', NULL, '2026-01-12 09:56:49', '2026-01-12 09:58:47'),
(187, 'App\\Models\\User', 17, 'auth_token', '35aa123e8290a842ad09871b94ca809047ab2a6850f72afa283676c4d148eb9f', '[\"*\"]', '2026-01-12 09:59:32', NULL, '2026-01-12 09:59:31', '2026-01-12 09:59:32'),
(188, 'App\\Models\\User', 17, 'auth_token', 'bccec747229e217c0106d5554b6af2c7ea1091a027db09a5f06a049989ccb7fb', '[\"*\"]', '2026-01-12 10:01:29', NULL, '2026-01-12 10:00:29', '2026-01-12 10:01:29'),
(189, 'App\\Models\\User', 17, 'auth_token', '064dad920dc4a3e82967e03c204e9e7a71f4236bccb6434b867deda2894ada58', '[\"*\"]', '2026-01-12 10:13:54', NULL, '2026-01-12 10:02:02', '2026-01-12 10:13:54'),
(190, 'App\\Models\\User', 15, 'auth_token', 'f26ccc661d13e1b6ae6598628b9c0049e62a7fc4b76da92a04ff3528c887bc43', '[\"*\"]', '2026-01-12 10:13:13', NULL, '2026-01-12 10:09:23', '2026-01-12 10:13:13'),
(191, 'App\\Models\\User', 15, 'auth_token', '07dbb3142414eccbc46027ad65fc26daaf7688b32f4e09f35d5196b350b672e1', '[\"*\"]', '2026-01-12 10:22:54', NULL, '2026-01-12 10:13:34', '2026-01-12 10:22:54'),
(192, 'App\\Models\\User', 15, 'auth_token', '660dff3410bdbc9a007b513a42edaf5a4d78fd1ab1cd183021683b8ffd5efd82', '[\"*\"]', '2026-01-12 10:14:48', NULL, '2026-01-12 10:14:47', '2026-01-12 10:14:48'),
(193, 'App\\Models\\User', 15, 'auth_token', 'db602a2af7974666e63704084b363098e845c4a9282f42fd83bde25edb7b5afb', '[\"*\"]', '2026-01-12 10:15:26', NULL, '2026-01-12 10:15:25', '2026-01-12 10:15:26'),
(194, 'App\\Models\\User', 15, 'auth_token', '429d69798134e7126e40e04b6f13730d5b775fc1300ff5ec6c145e6b5ba0f09d', '[\"*\"]', '2026-01-12 10:15:47', NULL, '2026-01-12 10:15:46', '2026-01-12 10:15:47'),
(195, 'App\\Models\\User', 17, 'auth_token', 'ad1084f502a37339ee62f75609731f78334ec8a9a2d21b312497bef7c9977549', '[\"*\"]', '2026-01-12 10:19:47', NULL, '2026-01-12 10:19:46', '2026-01-12 10:19:47'),
(198, 'App\\Models\\User', 15, 'auth_token', '7b89edff365abf3e78fdbd94378d4124d2ccb2d1f5a4dbbf99f47eec1dea0a26', '[\"*\"]', '2026-01-13 09:08:10', NULL, '2026-01-12 21:57:22', '2026-01-13 09:08:10'),
(199, 'App\\Models\\User', 15, 'auth_token', 'daac7fab311eb1072635b0a4c03ce949033c9163924a0497fcb7fe7f974bfed4', '[\"*\"]', '2026-01-12 22:00:16', NULL, '2026-01-12 22:00:14', '2026-01-12 22:00:16'),
(200, 'App\\Models\\User', 15, 'auth_token', 'e3e7599735f53e7565cd4db4d1136563c6a621fe97aa72aa9930472087f5bf8c', '[\"*\"]', '2026-01-12 22:00:31', NULL, '2026-01-12 22:00:25', '2026-01-12 22:00:31'),
(201, 'App\\Models\\User', 15, 'auth_token', 'c99299d6af7443ab47435caf008d669d879944093d902eb2268f16f6f23ad598', '[\"*\"]', '2026-01-12 22:01:57', NULL, '2026-01-12 22:01:37', '2026-01-12 22:01:57'),
(202, 'App\\Models\\User', 15, 'auth_token', 'e270885e33a8fc69afef1de273edc5aa52fbdbe9ca4f354f8953f0ae9c9a6bf7', '[\"*\"]', '2026-01-12 22:02:51', NULL, '2026-01-12 22:02:21', '2026-01-12 22:02:51'),
(203, 'App\\Models\\User', 15, 'auth_token', '5811d2378fde1d5eb05ed18f231186bb16f1f968f23c647713df2f30f8227d74', '[\"*\"]', '2026-01-12 22:03:07', NULL, '2026-01-12 22:03:06', '2026-01-12 22:03:07'),
(204, 'App\\Models\\User', 15, 'auth_token', 'e1e58df36cefc6aceb16030140cc73a48a966ce1a08424b76dc1d1ae6448bb2e', '[\"*\"]', '2026-01-12 22:04:53', NULL, '2026-01-12 22:04:22', '2026-01-12 22:04:53'),
(205, 'App\\Models\\User', 15, 'auth_token', '3269282cacddc2a768f829d484755c69e78160a77cbe1375745145d7fe1b2937', '[\"*\"]', '2026-01-12 22:21:55', NULL, '2026-01-12 22:21:54', '2026-01-12 22:21:55'),
(206, 'App\\Models\\User', 15, 'auth_token', '5282a04a1de23df7883c60c2a37ba048f7c57445fd4990665fe73cb5d068017f', '[\"*\"]', '2026-01-13 14:28:46', NULL, '2026-01-13 14:28:45', '2026-01-13 14:28:46'),
(207, 'App\\Models\\User', 15, 'auth_token', '5a3243166f490d0a988d91a5ff75d9f6091349843d9c3a262484f9dc716bfe0f', '[\"*\"]', '2026-01-13 14:29:27', NULL, '2026-01-13 14:29:26', '2026-01-13 14:29:27'),
(208, 'App\\Models\\User', 15, 'auth_token', 'bda6a4fded1ac9a0b9581b2d934d86e2ca86459163e27fa5c1b429d1c2c2c7d3', '[\"*\"]', '2026-01-13 14:30:15', NULL, '2026-01-13 14:30:14', '2026-01-13 14:30:15'),
(209, 'App\\Models\\User', 15, 'auth_token', '1a14d09a9228d277445a09ab0f2b7ed9325e8f354bd865ed647b817f2ad284cf', '[\"*\"]', '2026-01-13 14:34:17', NULL, '2026-01-13 14:34:16', '2026-01-13 14:34:17'),
(212, 'App\\Models\\User', 15, 'auth_token', 'c5d5061e7a3322d98d68b9025a1430fc2aac8b16e22472646e755f10a5515363', '[\"*\"]', '2026-01-15 16:33:14', NULL, '2026-01-15 16:33:10', '2026-01-15 16:33:14'),
(215, 'App\\Models\\User', 15, 'auth_token', 'bf0beb4fca50737d2ec33c80bcdd36f0f054fcb404224a1b71d0b31c3ee49006', '[\"*\"]', '2026-01-15 17:11:13', NULL, '2026-01-15 17:11:10', '2026-01-15 17:11:13'),
(216, 'App\\Models\\User', 15, 'auth_token', 'eb1aae6a685aa72b12e67ca5513a00fd2b3d529d9ec5edf29733593a5cf25586', '[\"*\"]', '2026-01-15 17:13:38', NULL, '2026-01-15 17:13:37', '2026-01-15 17:13:38'),
(217, 'App\\Models\\User', 15, 'auth_token', 'f4e1b4f52a8ade2b688ae6d6d41c3fe1a89e1c6f2365c87f5b59861da30f26c0', '[\"*\"]', '2026-01-15 17:17:43', NULL, '2026-01-15 17:17:41', '2026-01-15 17:17:43'),
(218, 'App\\Models\\User', 23, 'auth_token', 'c278833a9e1a2520e531d0e2b5bf174269f6b6c11360a051f5f3f61fc82042ea', '[\"*\"]', '2026-01-15 22:16:03', NULL, '2026-01-15 22:14:11', '2026-01-15 22:16:03'),
(219, 'App\\Models\\User', 23, 'auth_token', '25b9a07a731562d7e3cd2c4407759f006246dbf97d18b92a3e3f5dfac6ae0242', '[\"*\"]', '2026-01-15 22:56:51', NULL, '2026-01-15 22:56:50', '2026-01-15 22:56:51'),
(220, 'App\\Models\\User', 17, 'auth_token', '65064cbc9e0bbb3c59a97d5ddf093cb01ac982b78149047b9b947c10e8702f2e', '[\"*\"]', '2026-01-15 23:51:51', NULL, '2026-01-15 23:47:23', '2026-01-15 23:51:51'),
(221, 'App\\Models\\User', 17, 'auth_token', '298a8c0f28b878772b868aa5483ea917f5c14b08584a7fa69a5f8fbf4a1ed838', '[\"*\"]', '2026-01-15 23:53:09', NULL, '2026-01-15 23:53:05', '2026-01-15 23:53:09'),
(222, 'App\\Models\\User', 15, 'auth_token', 'bc4e9ed963e5bb0445ca77d193b773ff0167561da947213fc97196c1f81b6dee', '[\"*\"]', '2026-01-16 07:52:41', NULL, '2026-01-16 07:51:55', '2026-01-16 07:52:41'),
(223, 'App\\Models\\User', 15, 'auth_token', 'cfd270280acc99def65804085c21d2c1e8926717ddd198b440705ea4ce1f39be', '[\"*\"]', '2026-01-16 07:52:51', NULL, '2026-01-16 07:52:50', '2026-01-16 07:52:51'),
(224, 'App\\Models\\User', 15, 'auth_token', '173d65d494a94d452cad3380d097d5b2b9e329a3b634d87695f2a6e850b90358', '[\"*\"]', '2026-01-16 07:54:09', NULL, '2026-01-16 07:53:17', '2026-01-16 07:54:09'),
(225, 'App\\Models\\User', 15, 'auth_token', 'ad5d5e4215cb9365c583cbbaf7125025e5577ca7c2ca1ff7de4a634db4abe66a', '[\"*\"]', '2026-01-16 07:54:36', NULL, '2026-01-16 07:54:19', '2026-01-16 07:54:36'),
(226, 'App\\Models\\User', 15, 'auth_token', 'df4f0c758c47b44511c6b78e3f1c12bec1d3fc908163e8630378814abec8d39e', '[\"*\"]', '2026-01-16 07:55:22', NULL, '2026-01-16 07:55:12', '2026-01-16 07:55:22'),
(227, 'App\\Models\\User', 15, 'auth_token', '466822e97b25c5e42dcabe0367825f27f3249ecab109e09c1ab6c8b52a5923e1', '[\"*\"]', '2026-01-16 19:52:49', NULL, '2026-01-16 11:47:04', '2026-01-16 19:52:49'),
(228, 'App\\Models\\User', 15, 'auth_token', '7d4295a532fc53916ea8601e030396ee376fd1bbb23aff2e39ccf6f597b796e9', '[\"*\"]', '2026-01-16 21:12:49', NULL, '2026-01-16 21:12:26', '2026-01-16 21:12:49'),
(229, 'App\\Models\\User', 15, 'auth_token', 'e03c7f5bd3594bc46cde4cf106529ef92b4c0dad4985a16fd73a49ff6910aeb5', '[\"*\"]', '2026-01-16 21:13:38', NULL, '2026-01-16 21:13:17', '2026-01-16 21:13:38'),
(230, 'App\\Models\\User', 15, 'auth_token', '91a6fae8c2f336c44a6c3f3183c6bf69526856aa0e1da6d0f2c1008bfcf96bfa', '[\"*\"]', '2026-01-16 21:14:05', NULL, '2026-01-16 21:13:48', '2026-01-16 21:14:05'),
(231, 'App\\Models\\User', 15, 'auth_token', '8277b4a5daac08b730b836abf0bf6d13ac872aab2153f237f464e47393805f66', '[\"*\"]', '2026-01-16 21:14:35', NULL, '2026-01-16 21:14:25', '2026-01-16 21:14:35'),
(232, 'App\\Models\\User', 15, 'auth_token', '4f4083ef225e556dd5d2703099991a54d2227f98eb962218e73ec74fc78920d7', '[\"*\"]', '2026-01-16 21:14:50', NULL, '2026-01-16 21:14:41', '2026-01-16 21:14:50'),
(233, 'App\\Models\\User', 15, 'auth_token', 'e4a86e0f6b7ada47cc1d848bc6010965170cd0796dea56af91da8861ef6321a3', '[\"*\"]', '2026-01-16 21:15:07', NULL, '2026-01-16 21:15:06', '2026-01-16 21:15:07'),
(234, 'App\\Models\\User', 15, 'auth_token', '0a8a193746e76a527a68bbb376cff97a20a25708d775814dcb09547993675aec', '[\"*\"]', '2026-01-16 21:16:15', NULL, '2026-01-16 21:15:40', '2026-01-16 21:16:15'),
(235, 'App\\Models\\User', 15, 'auth_token', 'd992e55999929140458490e71e07e3358c17157caf71da07b9bb4e3af4f3d03b', '[\"*\"]', '2026-01-16 21:16:50', NULL, '2026-01-16 21:16:22', '2026-01-16 21:16:50'),
(236, 'App\\Models\\User', 15, 'auth_token', '4133d488eb55f5cee0f50dc36cd5131d2a5a7bf78e12a8550df316f56ed91943', '[\"*\"]', '2026-01-16 21:17:10', NULL, '2026-01-16 21:17:04', '2026-01-16 21:17:10'),
(237, 'App\\Models\\User', 25, 'auth_token', '510628d65f3a5d106daa9d43f47992c1460b3381c4b7823d410585d4b425c3a5', '[\"*\"]', NULL, NULL, '2026-01-17 10:06:51', '2026-01-17 10:06:51'),
(239, 'App\\Models\\User', 15, 'auth_token', '1d1b0eb3877cd9a0c2689ca75273e6c8efec8f0e80644a46f2301f46938a3a5d', '[\"*\"]', '2026-01-17 14:05:11', NULL, '2026-01-17 14:05:09', '2026-01-17 14:05:11'),
(241, 'App\\Models\\User', 15, 'auth_token', '203fe176126594ff9fa485c31f563d9c0f5c873348aa4907bb686b811168ee08', '[\"*\"]', '2026-01-17 15:08:50', NULL, '2026-01-17 14:58:22', '2026-01-17 15:08:50'),
(243, 'App\\Models\\User', 15, 'auth_token', '195de7fdd7b5e102997fa508d6c4c2f9ca3b794b09566dbfe8a5e0e8373ed597', '[\"*\"]', '2026-01-17 15:13:40', NULL, '2026-01-17 15:12:33', '2026-01-17 15:13:40'),
(244, 'App\\Models\\User', 15, 'auth_token', 'c2cfc725baa87cdb5289098fa363cc0f580f46af21a7a7dbebbd4297e2c9f92b', '[\"*\"]', '2026-01-17 18:08:28', NULL, '2026-01-17 17:12:23', '2026-01-17 18:08:28'),
(245, 'App\\Models\\User', 15, 'auth_token', '9b97210e977e88c6bae53ecee10b5f9e59ceea5a123ebfa6d44274ce7a713f78', '[\"*\"]', '2026-01-17 19:28:45', NULL, '2026-01-17 19:24:44', '2026-01-17 19:28:45'),
(246, 'App\\Models\\User', 15, 'auth_token', '205f35b5307b0f01b6630998171b8fc2802a968fee38e408d8d6950ab94d4b2d', '[\"*\"]', '2026-01-17 21:16:46', NULL, '2026-01-17 21:13:57', '2026-01-17 21:16:46'),
(247, 'App\\Models\\User', 15, 'auth_token', 'b0f014a32db996e38ea1b85cab3e7a0ac9eac907d62442ab488ce33cc437f421', '[\"*\"]', '2026-01-17 23:11:08', NULL, '2026-01-17 22:47:37', '2026-01-17 23:11:08'),
(249, 'App\\Models\\User', 15, 'auth_token', '910df27b73e0e0a647c83ef24a01f1101260cf45bda06494eee165ed35369acc', '[\"*\"]', '2026-01-17 22:59:08', NULL, '2026-01-17 22:59:07', '2026-01-17 22:59:08'),
(250, 'App\\Models\\User', 15, 'auth_token', '7ea20f71be2d217fdc7d94b0f50ce413dd16afbc18a2237a11db3011b8678cd0', '[\"*\"]', '2026-01-18 14:13:38', NULL, '2026-01-18 14:12:42', '2026-01-18 14:13:38'),
(251, 'App\\Models\\User', 15, 'auth_token', '2be85ffa821ef85f0dc1422a5e0e87e8d4707a1c821efd62f287d658df104d09', '[\"*\"]', '2026-01-18 14:14:16', NULL, '2026-01-18 14:13:46', '2026-01-18 14:14:16'),
(252, 'App\\Models\\User', 15, 'auth_token', '50688e84f025639c55b963d9f0599b5213c82116e200d343112b3004116dea78', '[\"*\"]', '2026-01-18 14:14:44', NULL, '2026-01-18 14:14:21', '2026-01-18 14:14:44'),
(253, 'App\\Models\\User', 15, 'auth_token', '10602c3811ddcdf37f0ebc409fae9403cc3417ca067aeec110fd266be02ff611', '[\"*\"]', '2026-01-18 14:17:49', NULL, '2026-01-18 14:17:41', '2026-01-18 14:17:49'),
(254, 'App\\Models\\User', 15, 'auth_token', '12e37edc27b1df01b030c8dd0c286482a9b165274cfba999a1b0862885cc0313', '[\"*\"]', '2026-01-18 14:19:28', NULL, '2026-01-18 14:18:04', '2026-01-18 14:19:28'),
(255, 'App\\Models\\User', 15, 'auth_token', '175df4818dfd50f653623e534d4a682933d4009c64720fc30f9a861b540d9721', '[\"*\"]', '2026-01-18 14:20:19', NULL, '2026-01-18 14:19:35', '2026-01-18 14:20:19'),
(256, 'App\\Models\\User', 15, 'auth_token', 'c3701b8b1fb0bfe086c739308aadc761dab2db46dc550468cf5bf7166d0308f8', '[\"*\"]', '2026-01-18 14:21:20', NULL, '2026-01-18 14:20:26', '2026-01-18 14:21:20'),
(257, 'App\\Models\\User', 15, 'auth_token', 'fae1eb0408cb2bd8d37253cb054822a0538976412633cf36b80ca9fff7127c3d', '[\"*\"]', '2026-01-18 14:21:45', NULL, '2026-01-18 14:21:27', '2026-01-18 14:21:45'),
(258, 'App\\Models\\User', 15, 'auth_token', '3504be80257c62818c4d141476f50413fb17ad68c06897e42a449a48f88aecd6', '[\"*\"]', '2026-01-18 14:24:01', NULL, '2026-01-18 14:22:19', '2026-01-18 14:24:01'),
(259, 'App\\Models\\User', 15, 'auth_token', 'af00b18d00da98e857a7dbf033763ab0f0cc1b5f9773e0692239fe28b5715941', '[\"*\"]', '2026-01-18 14:24:21', NULL, '2026-01-18 14:24:20', '2026-01-18 14:24:21'),
(260, 'App\\Models\\User', 15, 'auth_token', '66a58ed014056cdb555c82fe5df6f04e9a6ce423758c4a544c6f5efadaa44672', '[\"*\"]', '2026-01-19 10:59:23', NULL, '2026-01-19 10:59:21', '2026-01-19 10:59:23'),
(261, 'App\\Models\\User', 15, 'auth_token', '6eaeb969b0cca8eaf9bf0adc9b8a6c1feb21158f176020b23d202f9012691946', '[\"*\"]', '2026-01-19 18:20:04', NULL, '2026-01-19 16:01:27', '2026-01-19 18:20:04'),
(262, 'App\\Models\\User', 15, 'auth_token', '29fbd73655ffae28454a09f7acbfbe266c53577abd4ef748f140f4ab5922bb72', '[\"*\"]', '2026-01-19 16:05:19', NULL, '2026-01-19 16:05:07', '2026-01-19 16:05:19'),
(263, 'App\\Models\\User', 15, 'auth_token', '73416c6238aebdfff7c6d182e65c9425ae7c32a09775dc9aca6be57ad8f18e47', '[\"*\"]', '2026-01-19 16:05:39', NULL, '2026-01-19 16:05:38', '2026-01-19 16:05:39'),
(264, 'App\\Models\\User', 15, 'auth_token', '50f7f4909ed4cb22c0053ea81053cc6c7eff732cff99f40d17aa6a445bca2a48', '[\"*\"]', '2026-01-19 16:06:32', NULL, '2026-01-19 16:06:31', '2026-01-19 16:06:32'),
(265, 'App\\Models\\User', 15, 'auth_token', '0415749b5cc6ca3f5d9d7ed39f27178886f06593b84480d92af6d4dcae0f63f1', '[\"*\"]', '2026-01-20 16:57:15', NULL, '2026-01-19 16:07:27', '2026-01-20 16:57:15'),
(266, 'App\\Models\\User', 15, 'auth_token', '48110b3686ba9dbc9f9b175ecf49ec739da02b0d213f59d1baa7a90f3f625019', '[\"*\"]', '2026-01-19 18:20:04', NULL, '2026-01-19 17:56:26', '2026-01-19 18:20:04'),
(267, 'App\\Models\\User', 15, 'auth_token', '992c602f212d26a47a70e82be9289800f301919c9ddac850cdae3041bc79c499', '[\"*\"]', '2026-01-20 17:03:55', NULL, '2026-01-20 17:03:39', '2026-01-20 17:03:55'),
(268, 'App\\Models\\User', 15, 'auth_token', '9e47c2df70a21d628b05b4e4b24e9fc66e9fb8f67cfa3cfa2a2a06f8d6db6de9', '[\"*\"]', '2026-01-20 17:04:17', NULL, '2026-01-20 17:04:10', '2026-01-20 17:04:17'),
(269, 'App\\Models\\User', 15, 'auth_token', '86bc334a93fa09cb259cfe8433c89168516301c5dc7fe5e4b52d9eb690fff4f9', '[\"*\"]', '2026-01-20 17:04:31', NULL, '2026-01-20 17:04:31', '2026-01-20 17:04:31'),
(271, 'App\\Models\\User', 15, 'auth_token', 'eef5b9a1b63e40607f1e5ef874f5d311a5342a1ba4183ad5c4255ddb4d52da7e', '[\"*\"]', '2026-01-20 18:24:07', NULL, '2026-01-20 18:22:33', '2026-01-20 18:24:07'),
(272, 'App\\Models\\User', 15, 'auth_token', 'c0e39567ee08aa2c772cff0cff564c0e762fa864318acf59c0e4eb7fd769320f', '[\"*\"]', '2026-01-21 00:29:25', NULL, '2026-01-20 18:44:59', '2026-01-21 00:29:25'),
(274, 'App\\Models\\User', 15, 'auth_token', '859d71b6e864caba13496a557e3d9e4e99977f3dda54e35be0ceca899c8f8edf', '[\"*\"]', '2026-01-21 22:18:40', NULL, '2026-01-21 21:41:21', '2026-01-21 22:18:40'),
(275, 'App\\Models\\User', 15, 'auth_token', 'af61f7ef304a8888f316e5e4466275fff75be4d690162414c63e0654a7f81675', '[\"*\"]', '2026-01-21 22:42:00', NULL, '2026-01-21 22:29:17', '2026-01-21 22:42:00'),
(276, 'App\\Models\\User', 15, 'auth_token', '9cddb8940e532339997e31efb9cbc6538cc5190a9c397a107c9f3de3a8673324', '[\"*\"]', '2026-01-21 22:40:51', NULL, '2026-01-21 22:40:19', '2026-01-21 22:40:51'),
(277, 'App\\Models\\User', 15, 'auth_token', 'c1a6a10ffed73518ab483160223710078093030bfc2184ecd45204a5f32eb61f', '[\"*\"]', '2026-01-21 22:41:14', NULL, '2026-01-21 22:41:07', '2026-01-21 22:41:14'),
(278, 'App\\Models\\User', 15, 'auth_token', '6dc4bba18823cbce4b1cf3f57122a055f95d86e354fc7417755f7a0915772231', '[\"*\"]', '2026-01-21 22:42:03', NULL, '2026-01-21 22:42:02', '2026-01-21 22:42:03'),
(279, 'App\\Models\\User', 15, 'auth_token', 'bea71cff58c391dc66f6af76b75096f491f8a40e67420531e3ffc82d5d50bec2', '[\"*\"]', '2026-01-21 22:42:34', NULL, '2026-01-21 22:42:29', '2026-01-21 22:42:34'),
(280, 'App\\Models\\User', 15, 'auth_token', '96afb0bf40a16f043fb98336dcf9d5d5d4c1a83fda98eed12cf021e957bbbfe6', '[\"*\"]', '2026-01-21 22:43:49', NULL, '2026-01-21 22:43:47', '2026-01-21 22:43:49'),
(281, 'App\\Models\\User', 15, 'auth_token', '0a2888e9a22a0a6e238d4c1dc342f347886f4a6fb13c852f2ce0d975be8c3446', '[\"*\"]', '2026-01-23 13:26:13', NULL, '2026-01-23 13:25:54', '2026-01-23 13:26:13'),
(282, 'App\\Models\\User', 15, 'auth_token', '6bb8eaa02c4751fc07d21554299fde92927073e6dce093bdd35f48e426312590', '[\"*\"]', '2026-01-24 10:41:59', NULL, '2026-01-24 10:30:06', '2026-01-24 10:41:59'),
(283, 'App\\Models\\User', 15, 'auth_token', 'a81e96155ee2b6bd81c9a2e58ca13725419f2916069e40bf156bd18c71d43a1f', '[\"*\"]', '2026-01-24 20:37:51', NULL, '2026-01-24 20:24:35', '2026-01-24 20:37:51'),
(284, 'App\\Models\\User', 15, 'auth_token', '02ba1b22eb15ff758546b119e8322c9ca4fe4e51c4d76d686d157599d8fa6661', '[\"*\"]', NULL, NULL, '2026-01-27 11:42:08', '2026-01-27 11:42:08'),
(285, 'App\\Models\\User', 15, 'auth_token', 'c3a1c4b4cc15a660ee9ca42c1e2df0167dffc05bbc450be618eee3838422863f', '[\"*\"]', NULL, NULL, '2026-01-27 11:54:05', '2026-01-27 11:54:05'),
(286, 'App\\Models\\User', 15, 'auth_token', '00c3d29530f25bc892f6b1f314db6fa7a688cb41679c9647ab74c8427d8b8b89', '[\"*\"]', '2026-01-27 11:54:42', NULL, '2026-01-27 11:54:26', '2026-01-27 11:54:42'),
(287, 'App\\Models\\User', 15, 'auth_token', 'bee5a5fd636a08c4148d692527fbf72c0734326ab21f04301c614ee2302db6a0', '[\"*\"]', '2026-01-27 14:38:07', NULL, '2026-01-27 14:31:32', '2026-01-27 14:38:07'),
(288, 'App\\Models\\User', 15, 'auth_token', 'c19fded22d60a62d8958557986df12d372a355ea7b9e1be60ba3a072583955d3', '[\"*\"]', '2026-01-27 16:55:38', NULL, '2026-01-27 16:55:36', '2026-01-27 16:55:38'),
(289, 'App\\Models\\User', 15, 'auth_token', 'aa13a0e423d47428b03aff87a776f7979b7c5fd9078a8321978fa1fd474f159f', '[\"*\"]', '2026-01-27 17:06:25', NULL, '2026-01-27 17:06:06', '2026-01-27 17:06:25'),
(290, 'App\\Models\\User', 15, 'auth_token', '23dfd8a059a082a7df0b9a8607ac841962c07e05c1ddfb05f5a67b6e26c7ea3b', '[\"*\"]', '2026-01-27 17:07:36', NULL, '2026-01-27 17:07:07', '2026-01-27 17:07:36'),
(291, 'App\\Models\\User', 15, 'auth_token', '855107a963db42840abb3921739da232cb90fb76f2609e123e2139b1c10b1950', '[\"*\"]', '2026-01-27 17:09:29', NULL, '2026-01-27 17:08:36', '2026-01-27 17:09:29'),
(292, 'App\\Models\\User', 15, 'auth_token', 'ebb09c79207b41640fde780f4159c42a30508c9901ac8a5e226057a99ee7a725', '[\"*\"]', '2026-01-27 17:11:18', NULL, '2026-01-27 17:09:40', '2026-01-27 17:11:18'),
(293, 'App\\Models\\User', 15, 'auth_token', 'd67852d5d38567cf657f85228d3f826c2b9fde4093a51fb21adca3b7366533c8', '[\"*\"]', '2026-01-27 17:12:26', NULL, '2026-01-27 17:12:23', '2026-01-27 17:12:26'),
(294, 'App\\Models\\User', 15, 'auth_token', '4348dbf1b883722969170df00e58b7553d31d068dfe676fc28e8889accd9cb31', '[\"*\"]', '2026-01-27 19:36:20', NULL, '2026-01-27 19:30:40', '2026-01-27 19:36:20'),
(295, 'App\\Models\\User', 15, 'auth_token', 'f773cb941e8b2af2640ff1bb0c92b5189e1f17ade59608578cd80f401e773efd', '[\"*\"]', '2026-01-27 22:48:02', NULL, '2026-01-27 22:26:30', '2026-01-27 22:48:02'),
(296, 'App\\Models\\User', 15, 'auth_token', 'eeb540ea13b76ef982336cb3689b81ba63f0a5a4925fdf5ac4c891567f7d371b', '[\"*\"]', '2026-01-28 11:56:32', NULL, '2026-01-28 09:48:57', '2026-01-28 11:56:32'),
(297, 'App\\Models\\User', 15, 'auth_token', 'b3233a0b69ce17d2255ed13c1b10e56a976b6c70ad35e730352f7ddcb088f440', '[\"*\"]', '2026-01-28 12:50:51', NULL, '2026-01-28 12:50:44', '2026-01-28 12:50:51');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(298, 'App\\Models\\User', 15, 'auth_token', '629e3dcc6e14ae64858af3c904d3b7015885cc6e713f9058ec2ef0cb37b86211', '[\"*\"]', '2026-01-28 13:08:14', NULL, '2026-01-28 13:06:20', '2026-01-28 13:08:14'),
(299, 'App\\Models\\User', 15, 'auth_token', '04a1da4b80ea5555f87e5538f54bc378b1b5feefe0c1aed08cf9606512e1678d', '[\"*\"]', '2026-01-28 14:00:15', NULL, '2026-01-28 13:59:47', '2026-01-28 14:00:15'),
(300, 'App\\Models\\User', 15, 'auth_token', '763fdead14e6d2c1c608a4462569ec9e0255202bf4a19c193d65d691bbc8653d', '[\"*\"]', '2026-01-29 21:28:22', NULL, '2026-01-28 20:02:40', '2026-01-29 21:28:22'),
(301, 'App\\Models\\User', 15, 'auth_token', '4d3a22ef0d9cd7833e041da1fcc8a9d6ca4d1913a54f51305a84edde2e3f3184', '[\"*\"]', '2026-01-29 21:20:02', NULL, '2026-01-29 21:19:37', '2026-01-29 21:20:02'),
(302, 'App\\Models\\User', 15, 'auth_token', '03f412936e2227e6fea730c372ac5e7c50b37f675b80cab85b7fc0ed6126d412', '[\"*\"]', '2026-01-29 21:32:28', NULL, '2026-01-29 21:30:23', '2026-01-29 21:32:28'),
(303, 'App\\Models\\User', 15, 'auth_token', 'a34e535ad8e976b5ec0a88db831210fcd8a6e7604a565ebc24f5ea2ea37e8d7f', '[\"*\"]', '2026-01-30 16:13:57', NULL, '2026-01-30 16:09:14', '2026-01-30 16:13:57');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sms_logs`
--

CREATE TABLE `sms_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `recipient` varchar(255) NOT NULL,
  `receiver` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`response`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sms_logs`
--

INSERT INTO `sms_logs` (`id`, `recipient`, `receiver`, `type`, `message`, `status`, `response`, `created_at`, `updated_at`) VALUES
(1, '255712345678', 'shadrack', 'direct', 'This is a test notification.', 'Sent', '\"1376834024,255712345678,Send Successful\\r\\n\"', '2025-12-03 12:56:07', '2025-12-03 12:56:07'),
(2, '255712345678', 'shadrack', 'direct', 'This is a test notification.', 'Sent', '\"1376837454,255712345678,Send Successful\\r\\n\"', '2025-12-03 12:59:27', '2025-12-03 12:59:27'),
(3, '255767983236', 'shadrack', 'direct', 'This is a test notification.', 'Sent', '\"1376841648,255767983236,Send Successful\\r\\n\"', '2025-12-03 13:03:48', '2025-12-03 13:03:48'),
(4, '255744141430', 'shadrack', 'direct', 'This is a test notification.', 'Sent', '\"1376846139,255744141430,Send Successful\\r\\n\"', '2025-12-03 13:05:26', '2025-12-03 13:05:26'),
(5, '255767983236', 'shadrack', 'direct', 'shadrack anajaribu.', 'Sent', '\"1382576192,255767983236,Send Successful\\r\\n\"', '2025-12-06 12:08:47', '2025-12-06 12:08:47'),
(6, '255767983236', 'shadrack', 'direct', 'This is a test notification.', 'Sent', '\"1382578303,255767983236,Send Successful\\r\\n\"', '2025-12-06 12:10:54', '2025-12-06 12:10:54'),
(7, '255767983236', 'shadrack', 'direct', 'This is a test notification.', 'Sent', '\"1382579753,255767983236,Send Successful\\r\\n\"', '2025-12-06 12:11:52', '2025-12-06 12:11:52'),
(8, '255767983236', 'shadrack', 'direct', 'This is a test notification.', 'Sent', '\"1382580530,255767983236,Send Successful\\r\\n\"', '2025-12-06 12:12:40', '2025-12-06 12:12:40'),
(9, '255767983236', 'shadrack', 'direct', 'This is a test notification.', 'Sent', '\"1382580850,255767983236,Send Successful\\r\\n\"', '2025-12-06 12:13:01', '2025-12-06 12:13:01'),
(10, '255616148236', 'shadrack', 'direct', 'This is a test notification.', 'Sent', '\"1382581184,255616148236,Send Successful\\r\\n\"', '2025-12-06 12:13:23', '2025-12-06 12:13:23'),
(23, '255673216366', 'shadrack', 'direct', 'This is a test message emmaculate.', 'Sent', '\"1382649183,255673216366,Send Successful\\r\\n\"', '2025-12-06 13:21:02', '2025-12-06 13:21:02'),
(24, '255673216366', 'shadrack', 'direct', 'This is a test message emmaculate.', 'Sent', '\"1382649297,255673216366,Send Successful\\r\\n\"', '2025-12-06 13:21:19', '2025-12-06 13:21:19'),
(25, '255710125217', 'shadrack', 'direct', 'This is a test message emmaculate.', 'Sent', '\"1382649516,255710125217,Send Successful\\r\\n\"', '2025-12-06 13:21:51', '2025-12-06 13:21:51'),
(26, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Sent', '\"1382680518,255767983236,Send Successful\\r\\n\"', '2025-12-06 13:54:50', '2025-12-06 13:54:50'),
(27, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Sent', '\"1382820489,255767983236,Send Successful\\r\\n\"', '2025-12-06 16:22:10', '2025-12-06 16:22:10'),
(28, '255767983236', 'SHADRACK LEONARD', 'direct', 'Hello SHADRACK LEONARD, your membership number is 0003', 'Sent', '\"1385385479,255767983236,Send Successful\\r\\n\"', '2025-12-08 17:40:57', '2025-12-08 17:40:57'),
(29, '255679931931', 'PENDO MUNISI', 'direct', 'Hello PENDO MUNISI, your membership number is 0004', 'Sent', '\"1394469668,255679931931,Send Successful\\r\\n\"', '2025-12-13 16:08:31', '2025-12-13 16:08:31'),
(30, '255712104508', 'Tumaini Peter', 'direct', 'Hello Tumaini Peter, your membership number is 0005', 'Sent', '\"1420048255,255712104508,Send Successful\\r\\n\"', '2025-12-30 12:13:35', '2025-12-30 12:13:35'),
(31, '255757579684', 'Dennis Elisha Mhoka', 'direct', 'Hello Dennis Elisha Mhoka, your membership number is 0006', 'Sent', '\"1420058387,255757579684,Send Successful\\r\\n\"', '2025-12-30 12:24:56', '2025-12-30 12:24:56'),
(32, '255784824624', 'Oscar Batista Kindole', 'direct', 'Hello Oscar Batista Kindole, your membership number is 0001', 'Sent', '\"1426759191,255784824624,Send Successful\\r\\n\"', '2026-01-03 03:15:48', '2026-01-03 03:15:48'),
(33, '255787001007', 'Isaya Raphael Mwanyamba', 'direct', 'Hello Isaya Raphael Mwanyamba, your membership number is 0002', 'Sent', '\"1426936083,255787001007,Send Successful\\r\\n\"', '2026-01-03 11:45:12', '2026-01-03 11:45:12'),
(34, '255754544438', 'Reuben Bulugu', 'direct', 'Hello Reuben Bulugu, your membership number is 0003', 'Sent', '\"1428376100,255754544438,Send Successful\\r\\n\"', '2026-01-03 23:01:25', '2026-01-03 23:01:25'),
(35, '255788677472', 'Dr. Suleiman Mathew IKOMBA', 'direct', 'Hello Dr. Suleiman Mathew IKOMBA, your membership number is 0004', 'Sent', '\"1429508139,255788677472,Send Successful\\r\\n\"', '2026-01-04 22:37:55', '2026-01-04 22:37:55'),
(36, '255788677472', 'Dr. Suleiman Mathew IKOMBA', 'direct', 'Hello Dr. Suleiman Mathew IKOMBA, your membership number is 0004', 'Sent', '\"1429508159,255788677472,Send Successful\\r\\n\"', '2026-01-04 22:37:57', '2026-01-04 22:37:57'),
(37, '255758047674', 'DAMIAN GERVAS NDABATINYA', 'direct', 'Bwana Yesu asifiwe DAMIAN GERVAS NDABATINYA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0005', 'Sent', '\"1433747600,255758047674,Send Successful\\r\\n\"', '2026-01-07 14:22:58', '2026-01-07 14:22:58'),
(38, '255719800813', 'Julius Kindole', 'direct', 'Bwana Yesu asifiwe Julius Kindole, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0006', 'Sent', '\"1433747848,255719800813,Send Successful\\r\\n\"', '2026-01-07 14:23:08', '2026-01-07 14:23:08'),
(39, '255768920734', 'Sospeter Bathoha', 'direct', 'Bwana Yesu asifiwe Sospeter Bathoha, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0007', 'Sent', '\"1436691731,255768920734,Send Successful\\r\\n\"', '2026-01-09 10:04:38', '2026-01-09 10:04:38'),
(40, '255758833304', 'NTULI KAPOLOGWE', 'direct', 'Bwana Yesu asifiwe NTULI KAPOLOGWE, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0008', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-01-18 14:14:17', '2026-01-18 14:14:17');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `birth_date` date NOT NULL,
  `birth_place` varchar(255) NOT NULL,
  `birth_district` varchar(255) DEFAULT NULL,
  `marital_status` enum('Ameoa','Ameolewa','Hajaoa','Hajaolewa','Mjane','Mgane') DEFAULT NULL,
  `spouse_name` varchar(255) DEFAULT NULL,
  `children_count` int(11) NOT NULL DEFAULT 0,
  `zone` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `gender`, `birth_date`, `birth_place`, `birth_district`, `marital_status`, `spouse_name`, `children_count`, `zone`, `phone`, `email`, `role_id`, `role`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(15, 'Tumaini  Peter Kaaya', 'M', '2025-12-30', '22 Feb 1991', NULL, 'Ameoa', 'Angela Kalalu', 0, 'Kijichi', '255712104508', 'kaayah9@gmail.com', NULL, 'admin', '$2y$12$UR90qdaHbBu60TBhoyQQV.ggzKoikx2tmP.5w5ZPJAZcVbAgYkAQ.', NULL, '2025-12-31 00:41:05', '2026-01-21 21:39:15'),
(16, 'Oscar Batista Kindole', 'M', '1979-01-04', 'Iringa DC', NULL, 'Ameoa', 'Janet Chisi', 5, 'Kongowe', '255784824624', 'oscarkindole@gmail.com', NULL, 'admin', '$2y$12$ifzkIsJ7oReeG9weoi2RxOKlzidO8taV.uduqAxxQF9sQVy3lYPkK', NULL, '2026-01-02 23:10:00', '2026-01-28 22:19:00'),
(17, 'Isaya Raphael Mwanyamba', 'M', '1979-12-19', 'Handeni TC/Tanga', NULL, 'Ameoa', 'Loveness Mollel', 3, 'Kigamboni', '255787001007', 'kakaisaya@gmail.com', NULL, 'kiongozi', '$2y$12$g3XVw8ZZCb6lTAMjODOwrOHTHjD7DJo7uPup8OacAXW4unFXpa7tS', NULL, '2026-01-03 11:35:08', '2026-01-29 21:25:29'),
(19, 'Reuben Bulugu', 'M', '1963-04-16', 'Bariadi Simiyu', NULL, 'Ameoa', 'Jane Martine', 5, 'Kongowe', '255754544438', 'bulugur@yahoo.com', NULL, 'kiongozi', '$2y$12$Jb2NNbot3gXWIjVGFT8ioODBd7p4/dnwlV8Ol0wqr6kN1JBVS8KIy', NULL, '2026-01-03 22:19:30', '2026-01-29 21:26:02'),
(20, 'Dr. Suleiman Mathew IKOMBA', 'M', '1967-03-05', 'Kigoma Rular KIGOMA', NULL, 'Ameoa', 'Philomena Solomon Muhamila', 3, 'Mgeninani', '255788677472', 'suleimanikomba@gmail.com', NULL, 'mshirika', '$2y$12$QBQiogrZYivmDhlVT98p8u9g1ADrVXytuWHjHhUNGk6wePH2FHWky', NULL, '2026-01-04 11:40:19', '2026-01-16 21:16:12'),
(21, 'Abigail Suleiman Mathew', 'F', '2004-08-12', 'Dar es Salaam, Temeke', NULL, 'Hajaolewa', NULL, 0, 'Mgeninani', '255699650632', 'abigailmathew34@gmail.com', NULL, 'Mwinjilisti', '$2y$12$1ImOI702G9j4HID7eeGXXeeWtqTklsi8rkM6HfXg9593dbRAhFl8G', NULL, '2026-01-05 10:44:00', '2026-01-17 18:08:28'),
(22, 'DAMIAN GERVAS NDABATINYA', 'M', '1972-07-01', 'BUHIGWE KIGOMA', NULL, 'Ameoa', 'GERDA PAULO TEBUYE', 4, 'Tandika', '255758047674', 'kigomawax@gmail.com', NULL, 'Mzee wa Kanisa', '$2y$12$SrY/yQ0J7C1HzZhOEryyr.bPqPK2vEM7AoQqMVcZ3DjMmwWxxK/Om', NULL, '2026-01-07 11:13:50', '2026-01-21 22:17:03'),
(23, 'Julius Kindole', 'M', '1981-06-03', 'Ilala, Dar Es Salaam', NULL, 'Ameoa', 'Emiliana Peter Kaaya', 4, 'Mgeninani', '255719800813', 'kindole72@gmail.com', NULL, 'admin', '$2y$12$rAJU4/3.a0C5f3zfw3uhPuhTf/YMpQ2NbmLrLbjQcToKBJ.flaDOO', NULL, '2026-01-07 14:07:25', '2026-01-28 22:18:28'),
(24, 'Sospeter Bathoha', 'M', '1975-04-06', 'Kigoma', NULL, 'Ameoa', 'Elicia Sekishahu Kisoma', 3, 'Mbande', '255768920734', 'sbathoha@gmail.com', NULL, 'mshirika', '$2y$12$tsbO5WBxhh/b4E8kJeS7..92/e01jhl5fh0xy4waByx54/l9PjMja', NULL, '2026-01-07 15:08:26', '2026-01-09 10:04:32'),
(25, 'NTULI KAPOLOGWE', 'M', '1985-01-27', 'Mbeya', NULL, 'Ameoa', 'Neema Peter Mndeme', 4, 'Mbande', '255758833304', 'wapastantuli@gmail.com', NULL, 'kiongozi', '$2y$12$0xU/aDhm4x7eg/fei2fm4.1StzE9b463gSl8kKKiYuNRRRsBCpr.q', NULL, '2026-01-17 10:06:48', '2026-01-28 22:20:58');

-- --------------------------------------------------------

--
-- Table structure for table `user_settings`
--

CREATE TABLE `user_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_settings`
--

INSERT INTO `user_settings` (`id`, `user_id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 15, 'dashboard_verse', 'Discovering Opportunities to Serve God', '2026-01-06 21:18:56', '2026-01-06 21:19:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `contributions`
--
ALTER TABLE `contributions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contributions_user_id_foreign` (`user_id`);

--
-- Indexes for table `contribution_types`
--
ALTER TABLE `contribution_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `contribution_types_name_unique` (`name`);

--
-- Indexes for table `deleted_members`
--
ALTER TABLE `deleted_members`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `galleries`
--
ALTER TABLE `galleries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `groups_leader_id_foreign` (`leader_id`);

--
-- Indexes for table `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `leaders`
--
ALTER TABLE `leaders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leaders_user_id_foreign` (`user_id`);

--
-- Indexes for table `leadership_roles`
--
ALTER TABLE `leadership_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `leadership_roles_title_unique` (`title`);

--
-- Indexes for table `leader_leadership_role`
--
ALTER TABLE `leader_leadership_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `leader_leadership_role_leader_id_leadership_role_id_unique` (`leader_id`,`leadership_role_id`),
  ADD KEY `leader_leadership_role_leadership_role_id_foreign` (`leadership_role_id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `members_user_id_foreign` (`user_id`);

--
-- Indexes for table `member_group`
--
ALTER TABLE `member_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `member_group_member_id_group_id_unique` (`member_id`,`group_id`),
  ADD KEY `member_group_group_id_foreign` (`group_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `sms_logs`
--
ALTER TABLE `sms_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_phone_unique` (`phone`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- Indexes for table `user_settings`
--
ALTER TABLE `user_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_settings_user_id_key_unique` (`user_id`,`key`),
  ADD KEY `user_settings_user_id_index` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contributions`
--
ALTER TABLE `contributions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `contribution_types`
--
ALTER TABLE `contribution_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `deleted_members`
--
ALTER TABLE `deleted_members`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `galleries`
--
ALTER TABLE `galleries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `guests`
--
ALTER TABLE `guests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leaders`
--
ALTER TABLE `leaders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `leadership_roles`
--
ALTER TABLE `leadership_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `leader_leadership_role`
--
ALTER TABLE `leader_leadership_role`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `member_group`
--
ALTER TABLE `member_group`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=304;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sms_logs`
--
ALTER TABLE `sms_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `user_settings`
--
ALTER TABLE `user_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contributions`
--
ALTER TABLE `contributions`
  ADD CONSTRAINT `contributions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_leader_id_foreign` FOREIGN KEY (`leader_id`) REFERENCES `members` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `leaders`
--
ALTER TABLE `leaders`
  ADD CONSTRAINT `leaders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `leader_leadership_role`
--
ALTER TABLE `leader_leadership_role`
  ADD CONSTRAINT `leader_leadership_role_leader_id_foreign` FOREIGN KEY (`leader_id`) REFERENCES `leaders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `leader_leadership_role_leadership_role_id_foreign` FOREIGN KEY (`leadership_role_id`) REFERENCES `leadership_roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `members`
--
ALTER TABLE `members`
  ADD CONSTRAINT `members_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `member_group`
--
ALTER TABLE `member_group`
  ADD CONSTRAINT `member_group_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `member_group_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `user_settings`
--
ALTER TABLE `user_settings`
  ADD CONSTRAINT `user_settings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
