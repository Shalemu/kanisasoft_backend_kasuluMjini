-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 05, 2026 at 12:15 PM
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
(6, 'Shukurani', '2026-02-25 17:18:18', '2026-02-25 17:18:18'),
(7, 'Mfuko wa Faraja', '2026-02-27 21:24:07', '2026-02-27 21:24:07');

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
(2, 'ZAMU ZA WIKI', '2026-01-07', '18:30:00', NULL, 'Washirika', 'Mwinjilist Erick Andrea\nAtakuwa za wiki hii.', '2026-01-07 20:34:54', '2026-01-07 20:34:54'),
(3, 'IBADA TATU', '2026-03-01', NULL, NULL, 'Washirika', 'Kuanzia tarehe 01/03/2026\nIbada ya kwanza ( Kiingereza tu): saa 1:00-2:30 asubuhi.\nIbada ya Pili(Kiswahili): Saa 3:00-5:15 Asubuhi\nIbada ya Tatu(Kiswahili): Saa 5:30-7:30 Mchana.', '2026-02-26 01:24:01', '2026-02-26 01:24:01');

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
(2, 'MEDIA', 12, '2026-01-03 22:02:39', '2026-02-28 00:12:41'),
(3, 'WANAUME', NULL, '2026-01-03 22:02:55', '2026-01-03 22:02:55'),
(4, 'CYM', NULL, '2026-01-03 22:58:07', '2026-01-12 10:09:14'),
(5, 'UWW', NULL, '2026-01-03 22:58:35', '2026-01-03 22:58:35'),
(7, 'WANAWAKE', NULL, '2026-01-18 14:13:30', '2026-01-18 14:13:30'),
(8, 'WATOTO', NULL, '2026-01-21 22:12:55', '2026-01-21 22:12:55'),
(10, 'WANANDOA', NULL, '2026-02-04 19:24:09', '2026-02-04 19:24:09'),
(11, 'DGC', NULL, '2026-02-04 19:35:25', '2026-02-04 19:35:25'),
(12, 'FGS', NULL, '2026-02-04 19:35:35', '2026-02-04 19:35:35'),
(13, 'HSP', NULL, '2026-02-04 19:35:48', '2026-02-04 19:35:48'),
(14, 'HALMASHAURI YA KANISA', NULL, '2026-02-25 17:20:36', '2026-02-25 17:20:36'),
(15, 'BARAZA LA WAZEE', NULL, '2026-02-25 18:59:22', '2026-02-25 18:59:22'),
(16, 'INJILI NA MISHENI', NULL, '2026-02-25 19:00:34', '2026-02-25 19:00:34');

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
(31, 'LEAD-697a44e4e64b0', 23, 'Julius Kindole', '255719800813', 'kindole72@gmail.com', '2026-01-28 22:18:28', '2026-01-28 22:18:28', 'active'),
(32, 'LEAD-697a450494908', 16, 'Oscar Batista Kindole', '255784824624', 'oscarkindole@gmail.com', '2026-01-28 22:19:00', '2026-01-28 22:19:00', 'active'),
(33, 'LEAD-697a457aa22ca', 25, 'NTULI KAPOLOGWE', '255758833304', 'wapastantuli@gmail.com', '2026-01-28 22:20:58', '2026-01-28 22:20:58', 'active'),
(35, 'LEAD-697b8a1ada794', 19, 'Reuben Bulugu', '255754544438', 'bulugur@yahoo.com', '2026-01-29 21:26:02', '2026-01-29 21:26:02', 'active'),
(37, 'LEAD-6983578421991', 22, 'DAMIAN GERVAS NDABATINYA', '255758047674', 'kigomawax@gmail.com', '2026-02-04 19:28:20', '2026-02-04 19:28:20', 'active'),
(38, 'LEAD-698357c48e0e6', 24, 'Sospeter Bathoha', '255768920734', 'sbathoha@gmail.com', '2026-02-04 19:29:24', '2026-02-04 19:29:24', 'active'),
(39, 'LEAD-698357da069a8', 20, 'Dr. Suleiman Mathew IKOMBA', '255788677472', 'suleimanikomba@gmail.com', '2026-02-04 19:29:46', '2026-02-04 19:29:46', 'active'),
(40, 'LEAD-6983583f58a82', 17, 'Isaya Raphael Mwanyamba', '255787001007', 'kakaisaya@gmail.com', '2026-02-04 19:31:27', '2026-02-04 19:31:27', 'active'),
(41, 'LEAD-698358d3c254e', 19, 'Reuben Bulugu', '255754544438', 'bulugur@yahoo.com', '2026-02-04 19:33:55', '2026-02-04 19:33:55', 'active'),
(44, 'LEAD-6985d5634cd50', 15, 'Tumaini  Peter Kaaya', '255712104508', 'kaayah9@gmail.com', '2026-02-06 16:49:55', '2026-02-06 16:49:55', 'active'),
(45, 'LEAD-69957b90de1b3', 17, 'Isaya Raphael Mwanyamba', '255787001007', 'kakaisaya@gmail.com', '2026-02-18 13:42:56', '2026-02-18 13:42:56', 'active'),
(46, 'LEAD-69a1eaaa4dc58', 61, 'Wenceslaus Benedict Fungamtama', '255754502656', 'fungamtama@yahoo.com', '2026-02-28 00:04:10', '2026-02-28 00:04:10', 'active');

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
(4, 'mtunza hazina', 1, 1, NULL, NULL),
(7, 'Mwinjilisti na Neno', 1, 0, '2026-01-03 21:12:20', '2026-02-28 00:17:14'),
(8, 'Shemasi', 1, 0, '2026-01-03 21:12:31', '2026-01-03 21:12:31'),
(9, 'Mzee wa Kanisa', 1, 0, '2026-01-07 19:48:02', '2026-02-18 13:49:19'),
(10, 'Media Timu', 1, 0, '2026-01-17 22:51:19', '2026-01-17 22:51:19'),
(12, 'Mchungaji  Kiongozi', 1, 0, '2026-01-18 14:19:28', '2026-01-18 14:19:28'),
(13, 'Katibu wa Kanisa', 1, 0, '2026-01-19 18:11:08', '2026-01-19 18:11:08'),
(14, 'Mzee wa Kanisa Kiongozi', 1, 0, '2026-01-19 18:17:44', '2026-01-19 18:17:44'),
(18, 'Kiongozi wa Media', 1, 0, '2026-02-06 12:47:18', '2026-02-06 12:47:18');

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
(7, 35, 9, '2026-01-29 21:26:02', '2026-01-29 21:26:02'),
(9, 37, 9, '2026-02-04 19:28:20', '2026-02-04 19:28:20'),
(10, 38, 9, '2026-02-04 19:29:24', '2026-02-04 19:29:24'),
(11, 39, 9, '2026-02-04 19:29:46', '2026-02-04 19:29:46'),
(12, 40, 9, '2026-02-04 19:31:27', '2026-02-04 19:31:27'),
(13, 41, 14, '2026-02-04 19:33:55', '2026-02-04 19:33:55'),
(16, 44, 18, '2026-02-06 16:49:55', '2026-02-06 16:49:55'),
(17, 45, 7, '2026-02-18 13:42:56', '2026-02-18 13:42:56'),
(18, 46, 13, '2026-02-28 00:04:10', '2026-02-28 00:04:10');

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
(12, 15, 'Tumaini  Peter Kaaya', 'M', '2025-12-30', '22 Feb 1991', NULL, 'Ameoa', 'Angela Kalalu', 0, 'Kijichi', '255712104508', 'Kaayah9@gmail.com', '2006-10-07', 'TAG Ungandi B', '2007-12-30', 'TAG Ilongero', 'Mchungaji Musa', 'Mchungaji', NULL, NULL, NULL, 'Media', NULL, 'Elimu ya chuo kikuu', NULL, 'Nimejiajiri', 'Makumbusho', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0043', NULL, NULL, 'active', NULL, 0, '2025-12-31 00:41:05', '2026-02-26 15:40:22'),
(13, 16, 'Oscar Batista Kindole', 'M', '1979-01-04', 'Iringa DC', NULL, 'Ameoa', 'Janet Chisi', 5, 'Kongowe', '255784824624', 'oscarkindole@gmail.com', '1996-10-18', 'George PHC', '1998-01-25', 'George PHC', 'Cesus Tembo', 'Mchungaji', NULL, NULL, NULL, 'Mchungaji', NULL, 'Elimu ya chuo', NULL, 'Nimeajiriwa', 'FPCT Kurasini', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, 'active', NULL, 0, '2026-01-02 23:10:00', '2026-01-03 03:15:34'),
(14, 17, 'Isaya Raphael Mwanyamba', 'M', '1979-12-19', 'Handeni TC/Tanga', NULL, 'Ameoa', 'Loveness Mollel', 3, 'Kigamboni', '255787001007', 'kakaisaya@gmail.com', '1990-07-01', 'FPCT Handeni', '1995-12-10', 'FPCT Mombo', 'Gabriel Mwampulo', 'Mchungaji', NULL, NULL, NULL, 'Mzee wa Kanisa', NULL, 'Elimu ya chuo kikuu', 'Biashara za Kimataifa', 'Nimeajiriwa', 'Taasisi ya Uhasibu Tanzania', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0002', NULL, NULL, 'active', NULL, 0, '2026-01-03 11:35:08', '2026-02-26 17:17:40'),
(16, 19, 'Reuben Bulugu', 'M', '1963-04-16', 'Bariadi Simiyu', NULL, 'Ameoa', 'Jane Martine', 5, 'Kongowe', '255754544438', 'bulugur@yahoo.com', '1981-06-08', 'PAG', '1982-01-10', 'PAG Igegu Bariadi', 'Pastor Patroba Nyagori', 'Mchungaji', NULL, NULL, NULL, 'Mzee wa Kanisa', NULL, 'Elimu ya chuo kikuu', NULL, 'Nimeajiriwa', 'FPCT-Centre', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0003', NULL, NULL, 'active', NULL, 0, '2026-01-03 22:19:30', '2026-01-03 23:01:17'),
(17, 20, 'Dr. Suleiman Mathew IKOMBA', 'M', '1967-03-05', 'Kigoma Rular KIGOMA', NULL, 'Ameoa', 'Philomena Solomon Muhamila', 3, 'Mgeninani', '255788677472', 'suleimanikomba@gmail.com', '1987-12-06', 'Pentekoste Motomoto', '1987-12-25', 'Bitale Kigoma', 'Askofu Mathayo Suleiman', 'Askofu', NULL, NULL, NULL, 'Mzee wa Kanisa', NULL, 'Elimu ya chuo kikuu', NULL, 'Nimeajiriwa', 'Manispaa ya Temeke', 'Box 46343 Dar es Salaam', 0, NULL, NULL, NULL, NULL, NULL, '0004', NULL, NULL, 'active', NULL, 0, '2026-01-04 11:40:19', '2026-01-04 22:37:49'),
(18, 21, 'Abigail Suleiman Mathew', 'F', '2004-08-12', 'Dar es Salaam, Temeke', NULL, 'Hajaolewa', NULL, 0, 'Mgeninani', '255699650632', 'abigailmathew34@gmail.com', '2022-06-22', 'Mbeya', '2023-06-04', 'FPCT Kurasini', 'Mch. Oscar Kindole', 'Mchungaji Kiongozi', NULL, NULL, NULL, 'Hakuna kwa sasa', NULL, 'Elimu ya chuo kikuu', NULL, 'Mwanafunzi', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'left', 'Amehama', 0, '2026-01-05 10:44:00', '2026-01-16 07:53:45'),
(19, 22, 'DAMIAN GERVAS NDABATINYA', 'M', '1972-07-01', 'BUHIGWE KIGOMA', NULL, 'Ameoa', 'GERDA PAULO TEBUYE', 4, 'Tandika', '255758047674', 'kigomawax@gmail.com', '1992-07-10', 'MBEYA PENTECOST CURCH', '1992-09-01', 'MBEYA PENTECOST CHURCH', 'JACKSON MWALYEGO', 'MCHUNGAJI', NULL, NULL, NULL, 'MZEE WA KANISA', NULL, 'Elimu ya chuo', NULL, 'Nimejiajiri', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0005', NULL, NULL, 'active', NULL, 0, '2026-01-07 11:13:50', '2026-01-07 14:22:51'),
(20, 23, 'Julius Kindole', 'M', '1981-06-03', 'Ilala, Dar Es Salaam', NULL, 'Ameoa', 'Emiliana Peter Kaaya', 4, 'Mgeninani', '255719800813', 'kindole72@gmail.com', '1999-01-10', 'Pentecostal New Hope', '2002-09-21', 'FPCT Kurasini', 'Mch. Daniel Mghenyi', 'Mchungaji kiongozi', NULL, NULL, NULL, 'Mwimbaji', NULL, 'Elimu ya chuo', NULL, 'Nimeajiriwa', 'Printzone Limited', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0006', NULL, NULL, 'active', NULL, 0, '2026-01-07 14:07:25', '2026-01-07 14:23:03'),
(21, 24, 'Sospeter Bathoha', 'M', '1975-04-06', 'Kigoma', NULL, 'Ameoa', 'Elicia Sekishahu Kisoma', 3, 'Mbande', '255768920734', 'sbathoha@gmail.com', '1992-10-20', 'Msimba', '1992-12-19', 'Kamara', 'Pinoni Rilageza', 'Mchungaji', NULL, NULL, NULL, 'Mzee wa Kanisa na Mwimbaji', NULL, 'Elimu ya chuo kikuu', NULL, 'Nimeajiriwa', 'Chuo Kikuu cha Kikatoliki Mwenge', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0007', NULL, NULL, 'active', NULL, 0, '2026-01-07 15:08:26', '2026-01-09 10:04:32'),
(22, 25, 'NTULI KAPOLOGWE', 'M', '1985-01-27', 'Mbeya', NULL, 'Ameoa', 'Neema Peter Mndeme', 4, 'Mbande', '255758833304', 'wapastantuli@gmail.com', '2006-04-09', 'EAGT Soweto Mbeya', '2007-01-14', 'Dar es salaam', 'Mchungaji John', 'Mchungaji', NULL, NULL, NULL, 'Ualimu wa Neno, huduma ya Vijana', NULL, 'Elimu ya chuo kikuu', 'Uhasibu na Usimamizi wa miradi', 'Nimeajiriwa', 'Arusha/Mikoa ya Kusini', '0758833304', 0, NULL, NULL, NULL, NULL, NULL, '0008', NULL, NULL, 'active', NULL, 0, '2026-01-17 10:06:48', '2026-01-18 14:14:13'),
(23, 26, 'Neema Mustapha Kiluwasha', 'F', '1994-01-16', 'Bombo Hospital, Tanga', NULL, 'Hajaolewa', NULL, 0, 'Kinondoni', '255658698146', 'neymarkilu@gmail.com', '2010-02-15', 'UKWATA FELLOWSHIP - JANGWANI SEC SCHOOL', '2014-12-21', 'TAG - MZUMBE, MOROGORO', 'Pastor Paul Ponda', 'Mchungaji', NULL, NULL, NULL, 'Mwalimu wa Watoto na Mhudumu', NULL, 'Elimu ya chuo kikuu', 'Mhasibu', 'Mwanafunzi', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, '0009', NULL, NULL, 'active', NULL, 0, '2026-02-23 10:32:16', '2026-02-23 17:39:06'),
(24, 27, 'Natalia Beza', 'F', '1994-09-11', 'Ilala', NULL, 'Hajaolewa', NULL, 0, 'Keko & Kurasini', '255714991925', 'bezanatalia11@gmail.com', '2019-04-11', 'FPCT KURASINI', '2019-06-01', 'FPCT KURASINI', 'Pastor Jalangila', 'Pastor', NULL, NULL, NULL, 'Shemasi', NULL, 'Elimu ya chuo kikuu', 'Social worker', 'Nimeajiriwa', 'Dart', '0714991925', 0, NULL, NULL, NULL, NULL, NULL, '0010', NULL, NULL, 'active', NULL, 0, '2026-02-23 10:34:16', '2026-02-25 00:16:18'),
(25, 28, 'THEOPHILDA CHRISTOPHER', 'F', '1976-12-26', 'KARAGWE KAGERA', NULL, 'Hajaolewa', NULL, 0, 'Yerusalem', '255655323199', 'theophildachristopher@gmail.com', '1999-09-02', 'TEMEKE EAGT', '1999-10-02', 'TEMEKE EAGT', 'MCHUNGAJI DECHA', 'MCHUNGAJI', NULL, NULL, NULL, 'UIMBAJI PRAISE TEAM', NULL, 'Elimu ya chuo kikuu', 'UTAWALA', 'Nimeajiriwa', 'MANISPAA KIGAMBONI', 'SLP 36009 KIGAMBONI', 0, NULL, NULL, NULL, NULL, NULL, '0015', NULL, NULL, 'active', NULL, 0, '2026-02-23 11:23:11', '2026-02-24 09:16:42'),
(26, 29, 'Jacob Sanke Nyoni', 'M', '1992-06-16', 'Kyela- Mveya', NULL, 'Ameoa', 'Lydia Joshua Mwansasu', 2, 'Mbande', '255716654579', 'Jacobsanke52@gmail.com', '2014-06-16', 'FPCT', '2007-06-01', 'FPCT-LUTUSYO', 'Mch.SANKE STEVEN NYONI', 'MCHUNGAJI', NULL, NULL, NULL, 'MWALIMU', NULL, 'Elimu ya chuo', 'Mwalimu', 'Nimejiajiri', 'Chamazi', '0716654579', 0, NULL, NULL, NULL, NULL, NULL, '0016', NULL, NULL, 'active', NULL, 0, '2026-02-23 12:02:45', '2026-02-27 14:23:11'),
(27, 30, 'HERIEL GABRIEL', 'M', '1990-08-12', 'KOROGWE/TANGA', NULL, 'Ameoa', 'ROSE DAVID KUMENYA', 1, 'Kigamboni', '255712658038', 'herielgabriel61@gmail.com', '2004-09-05', 'FPCT HALE - TANGA', '2004-09-19', 'FPCT HALE - TANGA', 'MCH. GABRIEL MWAMPULO', 'MCHUNGAJI KIONGOZI FPCT HALE', NULL, NULL, NULL, 'UIMBAJI', NULL, 'Elimu ya chuo kikuu', 'UHASIBU', 'Nimeajiriwa', 'TRA', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0014', NULL, NULL, 'active', NULL, 0, '2026-02-23 12:34:49', '2026-02-24 09:16:31'),
(28, 31, 'AHUNGU MODKY', 'M', '1987-10-30', 'SINGIDA', NULL, 'Ameoa', 'Eliza', 2, 'Kijichi', '255737774790', 'modky3@yahoo.com', '2002-06-29', 'FPCT KIBAONI', '2004-04-04', 'SINGIDA', 'SENGE', 'MCH.', NULL, NULL, NULL, '-', NULL, 'Elimu ya chuo kikuu', 'IT (DEGREE)', 'Nimeajiriwa', 'FPCTHQ', '0737774790', 0, NULL, NULL, NULL, NULL, NULL, '0013', NULL, NULL, 'active', NULL, 0, '2026-02-23 13:22:45', '2026-02-24 09:16:12'),
(29, 32, 'Amos Samwel Ntandu', 'M', '1980-08-08', 'Ikungi/Singida', NULL, 'Ameoa', 'Eduna Mathayo Msubi', 3, 'Mbande', '255754897675', 'samwelamo@gmail.com', '1998-02-26', 'Nkhoiree', '1998-02-26', 'Nkhoiree', 'Sephania Mtinangi', 'Mchungaji', NULL, NULL, NULL, 'Uimbaji', NULL, 'Elimu ya chuo', 'Electrician', 'Nimejiajiri', 'Inabadilika', '0754897675', 0, NULL, NULL, NULL, NULL, NULL, '0018', NULL, NULL, 'active', NULL, 0, '2026-02-23 13:29:53', '2026-02-26 16:26:45'),
(30, 33, 'Elicia Sekishaku Kisoma', 'F', '1975-11-30', 'Kakonko/Kigoma', NULL, 'Ameolewa', 'Sospeter Bathoha', 3, 'Mbande', '255754778376', 'kisoma.elicia@gmail.com', '1989-08-20', 'Nyakayenzi', '1989-08-20', 'Nyakayenzi', 'Elia Lusaku', 'Mchungaji', 'Fpct- Kibondo', NULL, NULL, 'Mwimbaji na mwalimu wa watoto', NULL, 'Elimu ya sekondari', NULL, 'Nimejiajiri', NULL, NULL, 0, 'Familia yangu', NULL, NULL, NULL, NULL, '0019', NULL, NULL, 'active', NULL, 0, '2026-02-23 14:36:15', '2026-03-02 14:51:23'),
(31, 34, 'Erick Andrea', 'M', '1981-02-04', 'Nyamagana', NULL, 'Ameoa', 'Tumain Daniel', 2, 'Mbande', '255657300333', 'erickandrea217@gmail.com', '2000-12-31', 'FPCT mjini kati- Mwanza', '2001-03-31', 'FPCT- Kitangiri Mwanza', 'Mch Atanazi Chiruza', 'Mchungaji', NULL, NULL, NULL, 'Mwinjiristi', NULL, 'Elimu ya chuo', 'Mhubiri / Public speaker', 'Nimeajiriwa', 'FPCT - Kurasini', '0657 300333', 0, NULL, NULL, NULL, NULL, NULL, '0011', NULL, NULL, 'active', NULL, 0, '2026-02-23 16:08:59', '2026-02-24 00:52:16'),
(32, 35, 'Hannah Kimicha Rwandalla', 'F', '1966-07-07', 'Dar es salaam', NULL, 'Ameolewa', 'Caleb Joel Rwandalla', 3, 'Kizuiani', '255762748397', 'hannah.rwandala@yahoo.com', '1997-09-25', 'FPCT KURASINI', '2005-08-07', 'Pentecostal Kaloleni Arusha', 'Pastor Kulindwa', 'Mchungaji', NULL, NULL, NULL, 'Kusaidia huduma changa na kutoa katika mambo tofauti kanisani.', NULL, 'Elimu ya chuo kikuu', 'Mwalimu', 'Nimejiajiri', 'Great Vision Nursery and Primary School', '0717552244', 0, NULL, NULL, NULL, NULL, NULL, '0017', NULL, NULL, 'active', NULL, 0, '2026-02-24 02:17:13', '2026-02-24 09:17:16'),
(33, 36, 'Benedicto Mugongo', 'M', '1984-05-01', 'Buhigwe, Kigoma', NULL, 'Ameoa', 'Grace Dalasi', 3, 'Tandika', '255754244794', 'benjos98@yahoo.com', '1999-09-08', 'FPCT Mubanga', '2000-09-06', 'Mubanga', 'Daniford Luhega', 'Mchungaji', NULL, NULL, NULL, 'Kufundisha Sunday school na Ushemasi', NULL, 'Elimu ya chuo kikuu', 'B.Electrical Engineering', 'Nimejiajiri', NULL, '0754244794', 0, NULL, NULL, NULL, NULL, NULL, '0012', NULL, NULL, 'active', NULL, 0, '2026-02-24 09:09:45', '2026-02-24 09:15:07'),
(34, 37, 'Adriano Nashoni Kibhoge', 'M', '1992-10-01', 'Kigoma', NULL, 'Hajaoa', NULL, 0, 'Kigamboni', '255742490455', 'Kibhogeadriano@gmail.com', '2010-01-10', 'FPCT NYAMOLI', '2010-04-15', 'FPCT NYAMOLI', 'Boazi Rubhavye', 'Mzee wa kanisa', NULL, NULL, NULL, 'Mwimbaji', NULL, 'Elimu ya sekondari', NULL, 'Nimejiajiri', 'Kigambon', NULL, 1, NULL, NULL, NULL, NULL, NULL, '0020', NULL, NULL, 'active', NULL, 0, '2026-02-24 10:04:53', '2026-02-24 14:55:47'),
(35, 38, 'Aman Mdewa Nthangu', 'M', '1991-04-06', 'Masasi/Mtwara', NULL, 'Ameoa', 'Beatrice Elia Mhana', 2, 'Kigamboni', '255755146527', 'amanmdewa@gmail.com', '2002-09-19', 'FPCT MBEYA', '2006-03-14', 'FPCT KURASINI', 'Mch PHILEMON MDACHI', 'Mchungaji kiongozi', NULL, NULL, NULL, 'Mwalimu wa neno na muimbaji', NULL, 'Elimu ya chuo kikuu', 'Uchumi na Biashara za kimataifa', 'Nimeajiriwa', 'Chuo kikuu cha Dar es salaam', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0021', NULL, NULL, 'active', NULL, 0, '2026-02-24 13:11:17', '2026-02-24 14:55:56'),
(36, 39, 'Elizabeth Christopher Migeto', 'F', '1992-02-10', 'TABORA', NULL, 'Hajaolewa', NULL, 0, 'Kigamboni', '255677149158', 'migetoelizabeth1991@gmail.com', '2009-11-12', 'Igunga', '2006-04-15', 'FPCT Mbutu- Igunga', 'Mch Samwel Bethuel', 'Mchungaji', NULL, NULL, NULL, 'Muimbaji DGC', NULL, 'Elimu ya chuo', NULL, 'Nimeajiriwa', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, '0023', NULL, NULL, 'active', NULL, 0, '2026-02-24 13:48:07', '2026-02-24 14:58:35'),
(37, 40, 'Neema Kazare', 'F', '1985-02-27', 'Butiama (Mara)', NULL, 'Ameolewa', 'Emmanuel Stephano', 3, 'Yerusalem', '255714842713', 'kazareneema@gmail.com', '1998-06-05', 'Muriaza (Butiama)', '1998-06-27', 'Muriaza (Butiama)', 'Mch. Yohana Muhango', 'Mch. wa Parishi ya Kyabakari', NULL, NULL, NULL, 'Mwalimu wa watoto', NULL, 'Elimu ya chuo', 'Mwalimu', 'Nimeajiriwa', 'S/M Mtoni Sabasaba', 'SLP 46343 DSM', 0, NULL, NULL, NULL, NULL, NULL, '0024', NULL, NULL, 'active', NULL, 0, '2026-02-24 14:26:39', '2026-02-24 14:59:30'),
(38, 41, 'ALFAYO NASHONI KIBOGE', 'M', '1998-04-25', 'KIGOMA', NULL, 'Hajaoa', NULL, 0, 'Mtongani', '255755114343', 'alfayokibhoge@gmail.com', '2018-01-07', 'FPCT KIBAONI', '2014-04-06', 'FPCT NYAMOLI', 'JOELI ELIYA', 'MCHUNGAJI', NULL, NULL, NULL, NULL, NULL, 'Elimu ya sekondari', NULL, 'Nimejiajiri', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, '0022', NULL, NULL, 'active', NULL, 0, '2026-02-24 14:29:17', '2026-02-24 14:57:13'),
(39, 42, 'BEATRICE ELIA MHANA', 'F', '1998-09-07', 'SHINYANGA', NULL, 'Ameolewa', 'AMAN MDEWA NTHANGU', 2, 'Kigamboni', '255764648884', 'mhanabeatrice@gmail.com', '2011-11-06', 'FPCT KATANDALA SUMBAWANGA', '2013-12-21', 'FPCT SINGIDA MJINI KATI', 'MCH BONIPHANCE NTANDU', 'MCHUNGAJI', NULL, NULL, NULL, 'MUIMBAJI', NULL, 'Elimu ya chuo', 'MHASIBU', 'Nimejiajiri', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0028', NULL, NULL, 'active', NULL, 0, '2026-02-24 15:31:13', '2026-02-25 11:29:06'),
(40, 43, 'Meshack clement mihayo', 'M', '1992-06-26', 'Shinyanga', NULL, 'Ameoa', 'Jesca yuvinus', 1, 'Mtongani', '255756673176', 'meshackmihayi01@gmail.com', '2011-07-01', 'FPCT Gongo la mboto', '2005-04-21', 'FPCT USHETU', 'Mch. Daudi Ngusa Daniel', 'Mchungaji wa palish', NULL, NULL, NULL, 'Kiongozi wa zoni', NULL, 'Elimu ya chuo', 'Fundi seremala', 'Nimejiajiri', 'Bokolani kwa kabuma', '0756673176/ 0624450226', 0, NULL, NULL, NULL, NULL, NULL, '0030', NULL, NULL, 'active', NULL, 0, '2026-02-24 21:15:23', '2026-02-25 15:53:21'),
(41, 44, 'PERECY BEZA', 'F', '1960-10-07', 'Ngara', NULL, 'Mjane', NULL, 4, 'Keko & Kurasini', '255716668317', 'bezaperecy@gmail.com', '1998-04-17', 'Lutheran', '1998-05-10', 'Baharini', 'Askofu  gwamanjwa', 'Pastor', NULL, NULL, NULL, 'Shemasi', NULL, 'Elimu ya msingi', 'Fundi nguo', 'Nimejiajiri', 'Nyumbani', '0714991925', 0, NULL, NULL, NULL, NULL, NULL, '0042', NULL, NULL, 'active', NULL, 0, '2026-02-24 22:20:48', '2026-02-26 17:54:03'),
(42, 45, 'Veronica chavala', 'F', '1967-04-13', 'Mufindi/Iringa', NULL, 'Ameolewa', 'Shelf Shaltiel', 4, 'Mtongani', '255758295657', 'veronicachavala47@gmail.com', '1997-08-03', 'BCIC', '1997-12-07', 'BCIC', 'Edward Mbanga', 'Mwinjilisti', NULL, NULL, NULL, 'Mhasibu wa kanisa', NULL, 'Elimu ya chuo', 'Mhasibu', 'Nimeajiriwa', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0025', NULL, NULL, 'active', NULL, 0, '2026-02-24 22:25:28', '2026-02-24 23:45:35'),
(43, 46, 'Denis Cleophace', 'M', '1991-05-23', 'Nyamagana/Mwanza', NULL, 'Ameoa', 'Uyanjo Idabu', 1, 'Mbande', '255759076332', 'denisbube22@gmail.com', '2016-06-19', 'FPCT KURASINI', '2016-08-20', 'FPCT KURASINI', 'MCH. JOHANES MWITA', 'MCHUNGAJI', NULL, NULL, NULL, 'Kiongozi wa Idara vijana na Mjumbe kamati ya maendeleo yakanisa', NULL, 'Elimu ya chuo kikuu', 'BACHELOR IN PROCUREMENT AND SUPPLY MANAGEMENT', 'Nimeajiriwa', 'DAWASA', 'P.O.BOX 1573 DAR ES SALAM', 0, NULL, NULL, NULL, NULL, NULL, '0026', NULL, NULL, 'active', NULL, 0, '2026-02-24 23:46:43', '2026-02-26 14:58:25'),
(44, 47, 'Edith Batenzi', 'F', '1992-02-05', 'Ilala', NULL, 'Ameolewa', 'Samwel Batenzi', 0, 'Kigamboni', '255744932734', 'chitedy@gmail.com', '2019-01-05', 'Kurasini', '2019-06-01', 'Kurasini', 'Jilangila', 'Mchungaji', NULL, NULL, NULL, 'Mwalimu', NULL, 'Elimu ya chuo kikuu', NULL, 'Nimejiajiri', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0027', NULL, NULL, 'active', NULL, 0, '2026-02-25 02:51:21', '2026-02-27 12:28:44'),
(47, 50, 'GLORIA ANDREW MBWAMBO', 'F', '1984-03-30', 'IRINGA MUNICIPAL', NULL, 'Ameolewa', 'WENCESLAUS FUNGAMTAMA', 3, 'Kigamboni', '255762285686', 'gloria.mbwambo@tcbbank.co.tz', '1996-11-24', 'KIHESA  TAG', '2010-06-27', 'JESUS VILLAGE EAGT', 'MCH PRAYGOD MGONJA', 'MCHUNGAJI', NULL, NULL, NULL, 'MAMA MZEE WA KANISA', NULL, 'Elimu ya chuo kikuu', 'ACCOUTANT', 'Nimeajiriwa', 'TCB BANK', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0029', NULL, NULL, 'active', NULL, 0, '2026-02-25 12:30:09', '2026-02-25 12:34:00'),
(48, 51, 'Felix William', 'M', '1994-10-02', 'Korogwe /Tanga', NULL, 'Ameoa', 'Kezia Shertiely', 1, 'Mtongani', '255679320447', 'felixwilliam808@gmail.com', '2013-11-10', 'FPCT MASUGURU', '2014-01-08', 'Korogwe Tanga', 'Mchungaji Mweta', 'Mchungaji', NULL, NULL, NULL, 'Muimbaji kwaya', NULL, 'Elimu ya sekondari', 'Biashara', 'Nimejiajiri', 'Kariakoo', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0035', NULL, NULL, 'active', NULL, 0, '2026-02-25 17:43:48', '2026-02-25 21:29:17'),
(49, 52, 'NOELA MUSSA', 'F', '1990-12-25', 'Mwanza', NULL, 'Hajaolewa', NULL, 0, 'Mgeninani', '255769531914', 'noelamussa@gmail.com', '2003-07-01', 'EAGT MLIMA WA BARAKA', '2007-07-01', 'EAGT MLIMA WA BARAKA', 'Pastor CELCUS BYALUGOLOLA', 'Pastor', NULL, NULL, NULL, 'HSP & MEDIA', NULL, 'Elimu ya chuo kikuu', 'Procurement & supply management', 'Nimejiajiri', 'Kijichi', '0769531914', 1, NULL, NULL, NULL, NULL, NULL, '0031', NULL, NULL, 'active', NULL, 0, '2026-02-25 18:12:55', '2026-02-25 18:37:26'),
(50, 53, 'ANGELA ANTELIMI KALALU', 'F', '1994-11-05', 'Babati Manyara', NULL, 'Ameolewa', 'TUMAINI KAAYA', 0, 'Kijichi', '255787285496', 'angela.kalalu@gmail.com', '2016-06-12', 'TAG', '2018-03-18', 'FPCT KURASINI', 'George Mwita', 'Mchungaji', NULL, NULL, NULL, 'Shemasi', NULL, 'Elimu ya chuo', NULL, 'Nimejiajiri', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0034', NULL, NULL, 'active', NULL, 0, '2026-02-25 18:24:44', '2026-02-25 20:41:28'),
(51, 54, 'Noel Damson Nthangu', 'M', '1986-12-18', 'Newala', NULL, 'Hajaoa', NULL, 0, 'Kinondoni', '255754774918', 'noel.nthangu@udsm.ac.tz', '2002-04-25', 'Fpct', '2002-06-25', 'Fpct Mbeya', 'Mchungaji Philimoni Mdachi', 'Mchungaji kiongozi', NULL, NULL, NULL, 'Ualimu', NULL, 'Elimu ya chuo kikuu', 'Mchumi', 'Nimeajiriwa', 'Chuo kikuu', '0754774918', 1, NULL, NULL, NULL, NULL, NULL, '0032', NULL, NULL, 'left', 'Amehama', 0, '2026-02-25 18:51:46', '2026-02-26 01:06:33'),
(52, 55, 'Sam Batenzi', 'M', '1988-02-05', 'Mwanza', NULL, 'Ameoa', 'Edith Beza', 0, 'Kigamboni', '255747584779', 'sbatenzi@gmail.com', '2004-06-04', 'FPCT Kitangiri', '2008-03-01', 'FPCT Ngaramtoni', 'Mch. Julius Rukyaa', 'Mchungaji', NULL, NULL, NULL, 'Muimbaji', NULL, 'Elimu ya chuo kikuu', 'Media Tech', 'Nimeajiriwa', 'BBC News', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0033', NULL, NULL, 'active', NULL, 0, '2026-02-25 19:06:15', '2026-02-25 20:11:56'),
(53, 56, 'ANOLD GIDION FUMBUKA', 'M', '1998-10-31', 'KINONDONI / DAR ES SALAAM', NULL, 'Hajaoa', NULL, 0, 'Kinondoni', '255686360843', 'fumbukajr97@gmail.com', '2011-12-24', 'FPCT UMOJA SECONDARY', '2013-03-23', 'UMOJA SECONDARY', 'CLEMENT MKENI', 'MZEE WA KANISA', NULL, NULL, NULL, 'UIMBAJI, MUZIKI, MITAMBO', NULL, 'Elimu ya chuo kikuu', 'MHANDISI', 'Nimeajiriwa', 'DAR ES SALAAM', NULL, 1, NULL, NULL, NULL, NULL, NULL, '0036', NULL, NULL, 'active', NULL, 0, '2026-02-25 22:00:08', '2026-02-25 22:45:50'),
(54, 57, 'ESTER MATHAYO CHARLES', 'F', '2002-04-01', 'MAGU / MWANZA', NULL, 'Hajaolewa', NULL, 0, 'Yerusalem', '255612145642', 'estercharles719@gmail.com', '2024-06-21', 'FPCT - KURASINI', '2017-07-11', 'FPCT - NYANGUGE', 'ANDREW CHUMA', 'MCHUNGAJI', NULL, NULL, NULL, 'UIMBAJI', NULL, 'Elimu ya chuo kikuu', 'UALIMU', 'Nimeajiriwa', 'FPCT - MAKAO MAKUU', NULL, 1, NULL, NULL, NULL, NULL, NULL, '0038', NULL, NULL, 'active', NULL, 0, '2026-02-25 22:13:21', '2026-02-26 00:45:04'),
(55, 58, 'Theresia kindole', 'F', '1993-12-12', 'Temeke Dar es Salaam', NULL, 'Ameolewa', 'Elisha Makiya', 0, 'Mgeninani', '255717480049', 'thersiakindole@gmail.com', '2007-02-02', 'FPCT Kurasini', '2008-02-02', 'FPCT Kurasini', 'Josiah Singu', 'Mchungaji', NULL, NULL, NULL, 'Uimbaji', NULL, 'Elimu ya chuo kikuu', 'Muhasibu', 'Nimeajiriwa', 'REDESO', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0037', NULL, NULL, 'active', NULL, 0, '2026-02-26 00:36:02', '2026-02-26 00:39:14'),
(56, 59, 'Jane Martin', 'F', '1972-12-28', 'Busega/Simiyu', NULL, 'Ameolewa', 'Reuben Bulugu', 5, 'Kongowe', '255786504664', 'janemartn2@gmail.com', '1985-06-28', 'SDA', '1987-06-12', 'Mkula', 'Jeremia Bugidili', 'Mchungaji', NULL, NULL, NULL, 'Shemasi/Mwana kwaya', NULL, 'Elimu ya msingi', 'Ujasiliamali', 'Nimejiajiri', 'Mitaani', '0766503004', 0, NULL, NULL, NULL, NULL, NULL, '0039', NULL, NULL, 'active', NULL, 0, '2026-02-26 01:05:41', '2026-02-26 01:28:10'),
(57, 60, 'UYANJO JOHN', 'F', '1996-06-08', 'Temeke/Dar es salaam', NULL, 'Ameolewa', 'DENIS CLEOPHACE', 1, 'Mbande', '255674918283', 'uyanjo96@gmail.com', '2019-05-25', 'FPCT KURASINI', '2019-06-01', 'FPCT KURANSINI', 'MCH.OSCAR KINDOLE', 'MCHUNGAJI', NULL, NULL, NULL, 'MWIMBAJI', NULL, 'Elimu ya chuo', 'PLUMBER', 'Nimeajiriwa', 'DAWASA', 'P.O.BOX 1573 DAR ES SALAAM', 0, NULL, NULL, NULL, NULL, NULL, '0041', NULL, NULL, 'active', NULL, 0, '2026-02-26 02:07:11', '2026-02-26 15:29:58'),
(58, 61, 'Wenceslaus Benedict Fungamtama', 'M', '1978-01-09', 'Musoma, Mara', NULL, 'Ameoa', 'Gloria', 3, 'Kigamboni', '255754502656', 'fungamtama@yahoo.com', '1997-03-12', 'EAGT, Nyamanoro, Mwanza', '1998-05-02', 'EAGT, Frelimo, Iringa', 'Mch. John Kilasi', 'Mchungaji kiongozi', NULL, NULL, NULL, 'Mzee wa Kanisa', NULL, 'Elimu ya chuo kikuu', 'Business Administration', 'Nimeajiriwa', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0040', NULL, NULL, 'active', NULL, 0, '2026-02-26 15:27:13', '2026-02-26 15:29:49'),
(59, 62, 'Alam Alexander', 'M', '1994-04-18', 'Kigoma', NULL, 'Ameoa', 'Rachel Andrew Machupa', 0, 'Yerusalem', '255761360607', 'alamalexander3@gmail.com', '2009-02-22', 'FPCT TITYE', '2009-10-11', 'Kigoma', 'Emmanuel Kikutiko', 'Mzee wa Kanisa', NULL, NULL, NULL, 'Mwalimu wa Neno la Mungu', NULL, 'Elimu ya chuo kikuu', 'Mwalimu', 'Nimejiajiri', 'Ilala Sokoni', '0761360607', 0, NULL, NULL, NULL, NULL, NULL, '0048', NULL, NULL, 'active', NULL, 0, '2026-02-26 16:42:37', '2026-02-27 17:06:12'),
(60, 63, 'AUGUSTINO MADAKI BONIPHACE', 'M', '1984-11-20', 'Nzega, Tabora', NULL, 'Ameoa', 'Emiliana Mwita Nyakaraita', 5, 'Mgeninani', '255757445207', 'tmadaki48@gmail.com', '2006-03-31', 'FPCT', '2008-11-22', 'FPCT KURASINI', 'Josiah Singu', 'Mchungaji', NULL, NULL, NULL, 'Mwinjilisti', NULL, 'Elimu ya chuo kikuu', 'Ualimu', 'Nimeajiriwa', 'FPCT KURASINI', '+255 762 797 806', 0, NULL, NULL, NULL, NULL, NULL, '0044', NULL, NULL, 'active', NULL, 0, '2026-02-27 01:07:31', '2026-02-27 01:18:25'),
(61, 64, 'MAGRETH SYLIVESTER ROBERT', 'F', '1999-03-23', 'NZEGA/TABORA', NULL, 'Hajaolewa', NULL, 0, 'Yerusalem', '255746562364', 'magrethrobert23@gmail.com', '2017-06-04', 'EAGT', '2014-04-20', 'EAGT', 'EMANUEL SHANI', 'MCHUNGAJI', NULL, NULL, NULL, 'Uimbaji', NULL, 'Elimu ya chuo kikuu', 'USIMAMIZI WA BIASHARA', 'Nimeajiriwa', 'FPCT KURASINI', '07284 824624', 0, NULL, NULL, NULL, NULL, NULL, '0045', NULL, NULL, 'active', NULL, 0, '2026-02-27 13:12:03', '2026-02-27 13:35:07'),
(62, 65, 'Kepha Thomas Michael', 'M', '1990-06-26', 'Ikungi', NULL, 'Ameoa', 'Numwagile Ackim Mwakipale', 1, 'Mgeninani', '255713863847', 'kephamichael26@gmail.com', '2011-12-25', 'Fpct -Nkuhi', '2011-12-25', 'Singida', 'Mch.Elia Gwau', 'Mchungaji', NULL, NULL, NULL, 'NIL', NULL, 'Elimu ya chuo kikuu', 'Procurement and logistics management', 'Nimejiajiri', 'National service', 'P.o box 1694 Dsm', 0, NULL, NULL, NULL, NULL, NULL, '0046', NULL, NULL, 'active', NULL, 0, '2026-02-27 13:19:07', '2026-02-27 16:25:48'),
(63, 66, 'JONAS MARCO MPANZO', 'M', '1994-09-10', 'Mwanza', NULL, 'Ameoa', 'Illah', 1, 'Kinondoni', '255767939928', 'mpanzojonas@gmail.com', '2015-08-02', 'EAGT MILE MBILE', '2023-06-03', 'FPCT KURASINI', 'Pastor Oscar Kindole', 'Katibu Mkuu', NULL, NULL, NULL, 'Kuratibu Uchumi CYM FPCT', NULL, 'Elimu ya chuo kikuu', 'Geologist', 'Nimejiajiri', 'JOSTEC', '0767939928', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 0, '2026-02-27 15:59:02', '2026-02-27 15:59:02'),
(64, 67, 'Aloyce Godfrey Beza', 'M', '1988-10-29', 'Ilala', NULL, 'Ameoa', 'Lydia Msabaha', 1, 'Yerusalem', '255713213731', 'bezaaloyce@yahoo.com', '2019-02-14', 'FPCT KURASINI', '2019-03-09', 'FPCT KURASINI', 'Rev. Oscar Kindole', 'Mchngaji Kiongozi', NULL, NULL, NULL, 'Mwimbaji', NULL, 'Elimu ya chuo kikuu', NULL, 'Nimeajiriwa', NULL, '+255 659 070 800', 0, NULL, NULL, NULL, NULL, NULL, '0047', NULL, NULL, 'active', NULL, 0, '2026-02-27 16:13:16', '2026-02-27 16:26:01'),
(65, 68, 'lydia msabaha midello', 'F', '1991-05-19', 'Ilala - Dar es salaam', NULL, 'Ameolewa', 'Aloyce Beza', 1, 'Yerusalem', '255719453147', 'lydiamsabaha@gmail.com', '2004-02-08', 'Fpct Pwani', '2004-04-24', 'Fpct Kurasini', 'Mchungaji Josiah Singu', 'Mchungaji kiongozi', NULL, NULL, NULL, 'Maombi', NULL, 'Elimu ya chuo', 'Afisa manunuzi', 'Sina kazi', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0050', NULL, NULL, 'active', NULL, 0, '2026-02-27 18:32:32', '2026-02-28 17:48:27'),
(66, 69, 'Ebenezer Mathew', 'M', '2001-07-27', 'Dar es Salaam', NULL, 'Hajaoa', NULL, 0, 'Kijichi', '255788359022', 'ebenezer.mathew@icloud.com', '2018-02-27', 'FPCT KURASINI', '2026-03-21', 'FPCT KURASINI', 'MCH. KINDOLE', 'MCHUNGAJI KIONGOZI', NULL, NULL, NULL, NULL, NULL, 'Elimu ya chuo kikuu', 'MCHUMI', 'Nimeajiriwa', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 0, '2026-02-27 20:20:49', '2026-02-27 20:20:49'),
(67, 70, 'Philomena Solomon Muhamila', 'F', '1976-12-13', 'Kigoma, sanze', NULL, 'Ameolewa', 'Suleiman Mathew Ikomba', 3, 'Mgeninani', '255756945201', 'philomenamuhamila77@gmail.com', '1990-05-08', 'Bigabiro mission', '1991-03-19', 'Bigabiro mission', 'Mwinjilisti Francis Funagu', 'Mwinjilisti', NULL, NULL, NULL, 'Mwombaji', NULL, 'Elimu ya chuo kikuu', 'Elimu', 'Nimeajiriwa', 'Temeke Manispaa', 'P.o.box 46343', 0, NULL, NULL, NULL, NULL, NULL, '0051', NULL, NULL, 'active', NULL, 0, '2026-02-27 20:30:36', '2026-02-28 17:48:36'),
(68, 71, 'David Fredrick Mhando', 'M', '1982-12-12', 'Handeni-Tanga', NULL, 'Ameoa', 'Lucy Obadia Ndilaliha', 3, 'Mgeninani', '255755624764', 'david.mhando82@gmail.com', '1995-07-02', 'FPCT Handeni', '1998-10-01', 'FPCT Handeni', 'Mch. Petro Kipojo', 'Mchungaji', NULL, NULL, NULL, 'Mwimbaji na Mpiga Muziki', NULL, 'Elimu ya chuo kikuu', 'Mhandisi', 'Nimeajiriwa', 'TANESCO', '0755624764', 0, NULL, NULL, NULL, NULL, NULL, '0049', NULL, NULL, 'active', NULL, 0, '2026-02-28 01:21:33', '2026-02-28 08:39:21'),
(69, 72, 'Javan Jerome Zablon', 'M', '1988-06-15', 'Kigoma', NULL, 'Hajaoa', NULL, 0, 'Yerusalem', '255713625929', 'javan.jerome@gmail.com', '2006-02-01', 'FPCT Mwanga', '2026-08-13', 'FPCT Mwanga', 'Mch. Jeremia Onesmo', 'Mchungaji', NULL, NULL, NULL, 'Punda wa Yesu', NULL, 'Elimu ya chuo', NULL, 'Nimeajiriwa', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, '0052', NULL, NULL, 'active', NULL, 0, '2026-02-28 18:38:56', '2026-03-01 17:37:49'),
(70, 73, 'FREDRICK JACOB BALIGOMWA', 'M', '1976-04-30', 'KASULU KIGOMA', NULL, 'Ameoa', 'Sorange Mathias Musavi', 4, 'Tandika', '255784681321', 'jacobbali.jb47@gmail.com', '1995-12-25', 'Biharu', '1995-12-25', 'Biharu', 'Timothy Nkundiye', 'Mchungaji', NULL, NULL, NULL, 'M/Mwenyekiti zone', NULL, 'Elimu ya chuo', 'Civil Technician', 'Nimeajiriwa', 'Tata Africa Holdings T. Ltd', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 0, '2026-02-28 23:50:39', '2026-02-28 23:50:39'),
(71, 74, 'Ndungutse Yosia Misigaro', 'M', '1985-08-18', 'Kigoma', NULL, 'Ameoa', 'Fatuma Abubakar Ngarama', 2, 'Kinondoni', '255654999179', 'bitanandungutse@yahoo.com', '1997-10-15', 'FPCT BUBANGO', '1999-12-23', 'FPCT Bubango', 'YOHANA MANILAKIZA', 'Mchungaji', NULL, NULL, NULL, 'Uimbaji', NULL, 'Elimu ya chuo kikuu', 'Mwalimu/ Mtaalamu wa utalii', 'Nimejiajiri', 'Masaki', '+255 654 999 179', 0, NULL, NULL, NULL, NULL, NULL, '0053', NULL, NULL, 'active', NULL, 0, '2026-03-01 00:21:30', '2026-03-01 17:38:08'),
(72, 75, 'Ayoub Isaac Butandu', 'M', '1993-07-04', 'Kibonzo Kigoma', NULL, 'Ameoa', 'Queen Samwel', 1, 'Keko & Kurasini', '255764284549', 'ayoubbutandu@gmail.com', '2007-05-31', 'FPCT KILEMBA', '2008-05-31', 'Kibondo Kigoma', 'Sadock Mbona', 'Shemasi', NULL, NULL, NULL, 'Media', NULL, 'Elimu ya chuo kikuu', 'Mwalimu wa English na Literature (Kiingereza na Fasihi ya Kiingereza', 'Nimejiajiri', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0057', NULL, NULL, 'active', NULL, 0, '2026-03-01 01:24:52', '2026-03-02 15:58:42'),
(73, 76, 'Jacqueline  Maduka', 'F', '1987-11-12', 'Maswa', NULL, 'Ameolewa', 'Peter Maduka', 1, 'Mbande', '255673073841', 'budagajacqueline@gmail.com', '2000-04-15', 'TAG', '2000-06-10', 'Maswa', 'Eliud Mahene', 'Mchungaji', NULL, NULL, NULL, NULL, NULL, 'Elimu ya chuo kikuu', NULL, 'Nimejiajiri', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0054', NULL, NULL, 'active', NULL, 0, '2026-03-01 16:31:52', '2026-03-01 17:38:30'),
(74, 77, 'Patrick Ibrahim Makuhi', 'M', '2001-09-13', 'Ilala', NULL, 'Hajaoa', NULL, 0, 'Mgeninani', '255748589142', 'pmakuhi@gmail.com', '2014-09-10', 'FPCT Buguruni', '2014-03-01', 'Kurasini FPCT', 'Pastor kindole', 'Pastor', NULL, NULL, NULL, NULL, NULL, 'Elimu ya chuo kikuu', NULL, 'Nimejiajiri', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0058', NULL, NULL, 'active', NULL, 0, '2026-03-01 17:02:25', '2026-03-02 15:58:43'),
(75, 78, 'Laurencia  Thomas Mlawa', 'F', '1958-10-10', 'Iringa vijijini', NULL, 'Mjane', NULL, 1, 'Kingugi', '255716572056', 'mlawa1958@gmail.com', '1995-07-01', 'FGBF-MWENGE', '1996-07-01', 'Kawe Baharini', 'Romans Mtasingwa', 'Mchungaji', NULL, NULL, NULL, 'Uinjilisti na Maombi', NULL, 'Elimu ya sekondari', 'Katibu mahsusi', 'Sina kazi', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0055', NULL, NULL, 'active', NULL, 0, '2026-03-01 18:17:27', '2026-03-01 18:20:06'),
(76, 79, 'FATUMA ABUBAKARI NGARAMA', 'F', '1990-06-05', 'KAHAMA', NULL, 'Ameolewa', 'NDUNGUTSE YOSIA MISIGARO', 2, 'Kinondoni', '255658588591', 'fatumangarama@yahoo.com', '2006-06-30', 'KIMAHAMA ARUSHA', '2006-12-10', 'KIMAHAMA ARUSHA', 'AYUBU MUNA', 'MCHUNGAJI', NULL, NULL, NULL, 'MUIMBAJI SIFA NA MAABUDU', NULL, 'Elimu ya chuo kikuu', 'Uhasibu', 'Nimejiajiri', 'Sinza', '0658588591', 0, NULL, NULL, NULL, NULL, NULL, '0056', NULL, NULL, 'active', NULL, 0, '2026-03-02 02:03:31', '2026-03-02 14:07:06'),
(77, 80, 'ROSE DAVID KUMENYA', 'F', '1998-06-21', 'TABORA CBD', NULL, 'Ameolewa', 'HERIEL GABRIEL MWAMPULO', 1, 'Kigamboni', '255758625618', 'rosedavir26@icloud.com', '2011-01-23', 'FPCT UMOJA SEKONDARI', '2011-10-16', 'UMOJA SEKONDARI TABORA', 'PASTOR ABEL', 'MCHUNGAJI', NULL, NULL, NULL, 'MUIMBAJI', NULL, 'Elimu ya chuo kikuu', 'AFISA KODI', 'Nimejiajiri', 'KIGAMBONI', '0758625618', 0, NULL, NULL, NULL, NULL, NULL, '0059', NULL, NULL, 'active', NULL, 0, '2026-03-02 21:47:49', '2026-03-02 22:38:32'),
(78, 81, 'Jumanne John Mbilao', 'M', '1973-08-31', 'Sumbawanga- Rukwa', NULL, 'Ameoa', 'Juliana Mboma', 3, 'Kinondoni', '255767800507', 'mbilaojj@gmail.com', '2002-03-03', 'FPCT FOREST MBEYA', '2002-04-03', 'FPCT FOREST MBEYA', 'TBD', 'Mchungaji', NULL, NULL, NULL, 'MWENEKITI WA ZONE', NULL, 'Elimu ya chuo kikuu', 'Mwalimu Mchumi na Demographer', 'Nimeajiriwa', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0060', NULL, NULL, 'active', NULL, 0, '2026-03-03 12:13:31', '2026-03-03 12:16:25'),
(79, 82, 'Doto Geofrey Chima', 'F', '1991-03-02', 'Masasi Mtwara', NULL, 'Ameolewa', 'Boniphace Eliakim Nicodem', 1, 'Mtongani', '255768549003', 'dotochima287@gmail.com', '2008-06-08', 'FPCT MLOWA ITIGI', '2008-07-08', 'FPCT MLOWA ITIGI', 'Mch. Charles Sungi', 'Mchungaji', NULL, NULL, NULL, 'M/kiti wa zoni', NULL, 'Elimu ya chuo', NULL, 'Sina kazi', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0066', NULL, NULL, 'active', NULL, 0, '2026-03-03 20:58:33', '2026-03-04 14:52:55'),
(80, 83, 'NEZIA SHELF SHERTIELY', 'F', '2021-04-14', 'ILALA / DAR ES SALAAM', NULL, 'Hajaolewa', NULL, 0, 'Mtongani', '255767435625', 'neziashertiely@gmail.com', '2021-04-14', 'FPCT KURASINI', '2012-04-14', 'FPCT KURASINI', 'MCHUNGAJI GEORGE MWITA', 'MCHUNGAJI', NULL, NULL, NULL, 'MWALIMU WA WAONGOFU WAPYA', NULL, 'Elimu ya chuo', 'MTUNZA KUMBUKUMBU', 'Nimeajiriwa', 'FPCT MAKAO MAKUU', NULL, 0, NULL, NULL, NULL, NULL, NULL, '0062', NULL, NULL, 'active', NULL, 0, '2026-03-03 22:08:37', '2026-03-04 01:26:40'),
(81, 84, 'Ernest Gyunda', 'M', '1966-10-21', 'Kiomboi', NULL, 'Mgane', NULL, 4, 'Kinondoni', '255784299942', 'ernestgyunda12@gmail.com', '1979-07-01', 'Kanisa la pentekoste Kiomboi', '1979-12-21', 'Kiomboi', 'Elias  Senge', 'Mchungaji', NULL, NULL, NULL, 'Mwimbaji', NULL, 'Elimu ya chuo', NULL, 'Nimeajiriwa', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0061', NULL, NULL, 'active', NULL, 0, '2026-03-03 22:19:15', '2026-03-04 01:26:25'),
(82, 85, 'Joseph William Makange', 'M', '1998-03-29', 'Shinyanga', NULL, 'Ameoa', 'Angel William', 0, 'Kigamboni', '255626536720', 'josephmakange95@gmail.com', '2025-12-20', 'TAG', '2022-07-10', 'TAG Lango la Uzima', 'Mch. Wilson Mahemba', 'Mchungaji', NULL, NULL, NULL, 'Mpigaji wa chombo', NULL, 'Elimu ya chuo kikuu', 'Uhasibu', 'Nimejiajiri', 'Kigamboni', '0626536720', 0, NULL, NULL, NULL, NULL, NULL, '0064', NULL, NULL, 'active', NULL, 0, '2026-03-03 22:38:38', '2026-03-04 14:52:28'),
(83, 86, 'Faraja Anthony Rutebuka', 'F', '1998-05-05', 'Kigoma', NULL, 'Hajaolewa', NULL, 0, 'Kongowe', '255758159929', 'anthonyfaraja7@gmail.com', '2010-10-02', 'C.A.G', '2010-11-12', 'Kigoma', 'Bishop Leonard Edson', 'Bishop', NULL, NULL, NULL, 'Mwimbaji', NULL, 'Elimu ya chuo', 'Pharmaceutical Technician', 'Nimeajiriwa', 'Charambe', '0713000076', 1, NULL, NULL, NULL, NULL, NULL, '0063', NULL, NULL, 'active', NULL, 0, '2026-03-03 23:34:35', '2026-03-04 11:20:45'),
(84, 87, 'Witness Morice', 'F', '1977-10-20', 'Kigoma', NULL, 'Ameolewa', 'Morice Michael', 3, 'Mgeninani', '255682956632', 'witnessmorice2@gmail.com', '1996-07-21', 'FPCT Mwandiga', '1996-07-21', 'FPCT Mwandiga', 'Josephat Bwayonga', 'Mchungaji', NULL, NULL, NULL, 'Uimbaji', NULL, 'Elimu ya msingi', NULL, 'Nimejiajiri', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '0065', NULL, NULL, 'active', NULL, 0, '2026-03-04 01:04:01', '2026-03-04 14:52:35'),
(85, 88, 'Jane Joseph Elias', 'F', '2001-05-27', 'Katavi', NULL, 'Hajaolewa', NULL, 0, 'Mbande', '255748375141', 'Josephjane@gmail.com', '2020-03-15', 'FPCT KURASINI', '2020-06-13', 'KURASINI', 'Mch. Mwita', 'Katibu wa FPCT', NULL, NULL, NULL, 'Mwimbaji', NULL, 'Elimu ya sekondari', '0', 'Nimeajiriwa', 'Kaliakoo', '0748375141', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 0, '2026-03-04 14:27:16', '2026-03-04 14:27:16'),
(86, 89, 'Angel William Makange', 'F', '2000-05-19', 'Ilemela', NULL, 'Ameolewa', 'Joseph William Makange', 0, 'Kigamboni', '255612639779', 'vijitotours@gmail.com', '2011-06-16', 'EAGT', '2011-06-16', 'EAGT Jiwe la baraka', 'Mch. Sylivester Kilulu', 'Mchungaji', NULL, NULL, NULL, 'Mwinjilisti', NULL, 'Elimu ya chuo kikuu', 'Uhasibu', 'Nimejiajiri', 'Kigamboni', '0612639779', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 0, '2026-03-04 15:40:16', '2026-03-04 15:40:16'),
(87, 90, 'Rachel Gyunda', 'F', '2001-10-15', 'Tabora', NULL, 'Hajaolewa', NULL, 0, 'Kinondoni', '255678121710', 'rachelgyunda868@gmail.com', '2019-03-04', 'Fpct kurasini', '2020-06-13', 'Fpct kurasini', 'Mchungaji George Mwita', 'Mchungaji', NULL, NULL, NULL, 'Mwimbaji', NULL, 'Elimu ya chuo kikuu', NULL, 'Sina kazi', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 0, '2026-03-04 18:00:10', '2026-03-04 18:00:10');

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
('kaayah9@gmail.com', '$2y$12$LQuKNq/pmDbbpHaYl59b/eYtzxj5NOHqYZvtcg16.LSLCDpFQKq9G', '2026-01-21 21:38:35'),
('alfayokibhoge@gmail.com', '$2y$12$K7oLhZVrYp1Nt0OWU.v2ju5L9bA0f/Tp1/EugT6iAZ7ZBujQYPff.', '2026-02-25 18:26:15'),
('sbathoha@gmail.com', '$2y$12$P2KHJrwI4P4PDzao8gUY1ek5sZuaCdI.d9HUMERZ8B5IFQNi60tqS', '2026-02-27 14:15:44'),
('modky3@yahoo.com', '$2y$12$cMi4/.2i1AaIOVU.r25qFecslEuCy5pcWFcs1pf3fKgy.WJVwHwGK', '2026-02-27 15:46:30');

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
(303, 'App\\Models\\User', 15, 'auth_token', 'a34e535ad8e976b5ec0a88db831210fcd8a6e7604a565ebc24f5ea2ea37e8d7f', '[\"*\"]', '2026-01-30 16:13:57', NULL, '2026-01-30 16:09:14', '2026-01-30 16:13:57'),
(304, 'App\\Models\\User', 15, 'auth_token', '084d1ba0fbca26b77b05cbb964fe012379b801009e2fa7bf341fdb43d0991ecb', '[\"*\"]', '2026-01-31 17:31:42', NULL, '2026-01-31 17:31:31', '2026-01-31 17:31:42'),
(305, 'App\\Models\\User', 15, 'auth_token', '95a8280c149ef48acbfaffcffc471fb3ba6bd78ebf9cf2030608f2e9a2d4216e', '[\"*\"]', '2026-01-31 17:32:33', NULL, '2026-01-31 17:31:54', '2026-01-31 17:32:33'),
(306, 'App\\Models\\User', 15, 'auth_token', '858cbb3f5d824a6e41591ec0df9a95d653cb7ea42c1a7be5075e80026b2c1d48', '[\"*\"]', '2026-01-31 23:04:08', NULL, '2026-01-31 17:33:24', '2026-01-31 23:04:08'),
(307, 'App\\Models\\User', 15, 'auth_token', 'cc3b5284db787f2bd4aa5ea286d8a4b48675f0d8f33c2ab9fae35c23140f33f3', '[\"*\"]', '2026-01-31 18:39:57', NULL, '2026-01-31 18:09:44', '2026-01-31 18:39:57'),
(308, 'App\\Models\\User', 17, 'auth_token', '6d79f11d2ac2c46500d0e7872b18d4f12feb6861db84d112250f6ad2df2eb246', '[\"*\"]', NULL, NULL, '2026-01-31 18:33:49', '2026-01-31 18:33:49'),
(309, 'App\\Models\\User', 15, 'auth_token', '6682fe7a8eed2b53d92350edfbe32dd571f3861e7f524dc0afc9211639e82b3d', '[\"*\"]', '2026-02-01 01:02:20', NULL, '2026-02-01 00:58:59', '2026-02-01 01:02:20'),
(310, 'App\\Models\\User', 15, 'auth_token', '8684a36d3d640b7b15141b5d47a88ebc93f442a3f0c931f231258c867082f814', '[\"*\"]', '2026-02-04 19:23:24', NULL, '2026-02-04 17:05:50', '2026-02-04 19:23:24'),
(311, 'App\\Models\\User', 15, 'auth_token', '4e1e13f1b442e43a4b32c0298a7a1368810a2b238d85ce3420dd694e0836c3b2', '[\"*\"]', '2026-02-04 19:28:52', NULL, '2026-02-04 19:23:31', '2026-02-04 19:28:52'),
(312, 'App\\Models\\User', 15, 'auth_token', 'beada562dd914bc77fe96af63be6fc66181a18a9e48ef648ee4ade0218498d45', '[\"*\"]', '2026-02-04 19:31:54', NULL, '2026-02-04 19:29:10', '2026-02-04 19:31:54'),
(314, 'App\\Models\\User', 15, 'auth_token', '7d2e196ac316caef663609ebd99cac1fa28c67abfe8965804a1d2d55e65e1a25', '[\"*\"]', '2026-02-05 06:32:52', NULL, '2026-02-05 06:32:40', '2026-02-05 06:32:52'),
(315, 'App\\Models\\User', 15, 'auth_token', '221e938deaad65ec415348badaa7f06783998fa6cd6e1983b41dad5de29aadc3', '[\"*\"]', '2026-02-05 19:29:52', NULL, '2026-02-05 19:29:49', '2026-02-05 19:29:52'),
(316, 'App\\Models\\User', 15, 'auth_token', 'f514817936749d2b6b4a4196a5ffa748e343a5a82fb66989c83b4becd754902b', '[\"*\"]', '2026-02-06 12:50:31', NULL, '2026-02-06 12:39:48', '2026-02-06 12:50:31'),
(317, 'App\\Models\\User', 15, 'auth_token', 'f81b54a51c47de05e881b1a8ec74a5ff4a963ad046a3b7e6b3e30bc9f7f7b28c', '[\"*\"]', NULL, NULL, '2026-02-06 13:05:00', '2026-02-06 13:05:00'),
(318, 'App\\Models\\User', 15, 'auth_token', 'ff4ab92e46e1a769478861c8e37719c09a33a799df301511f45619587c5c4f15', '[\"*\"]', NULL, NULL, '2026-02-06 13:05:32', '2026-02-06 13:05:32'),
(319, 'App\\Models\\User', 15, 'auth_token', '98e2299990e8c5228a45052eb14d360653cf350b7cce3e52c76106edbd137de4', '[\"*\"]', '2026-02-06 13:11:42', NULL, '2026-02-06 13:06:51', '2026-02-06 13:11:42'),
(320, 'App\\Models\\User', 15, 'auth_token', '93c70c12c2c031707d67f15a75377847a069d78b90d2f7789b30ef5661d86402', '[\"*\"]', '2026-02-06 17:20:59', NULL, '2026-02-06 15:28:43', '2026-02-06 17:20:59'),
(322, 'App\\Models\\User', 15, 'auth_token', '9b0e97f84e91c7a4df259042564361bac150e0788b95250a392f95609678603b', '[\"*\"]', '2026-02-07 12:16:01', NULL, '2026-02-07 12:15:57', '2026-02-07 12:16:01'),
(323, 'App\\Models\\User', 15, 'auth_token', '76fcf9d2d77d121b6b3fa9703d19b42b39acceb9306ee532a93d606f498df8f8', '[\"*\"]', '2026-02-07 12:16:27', NULL, '2026-02-07 12:16:12', '2026-02-07 12:16:27'),
(324, 'App\\Models\\User', 15, 'auth_token', '8c6817aa40148e8c81b3a8f7d93df918d0c32c5be095ef92fe042970722bcf4d', '[\"*\"]', '2026-02-07 12:17:30', NULL, '2026-02-07 12:16:44', '2026-02-07 12:17:30'),
(325, 'App\\Models\\User', 15, 'auth_token', 'dea789bb77ed39f7b20fbc14c896e243c63667c46f29a7b3736a032367578e45', '[\"*\"]', '2026-02-07 12:17:42', NULL, '2026-02-07 12:17:41', '2026-02-07 12:17:42'),
(326, 'App\\Models\\User', 15, 'auth_token', 'dddf6ebd462b6d7a02e106dc7d32ba062245ee37e2f96ce1561d944cdf75fabb', '[\"*\"]', '2026-02-07 12:17:53', NULL, '2026-02-07 12:17:53', '2026-02-07 12:17:53'),
(327, 'App\\Models\\User', 15, 'auth_token', '86ee7939f05edde6ffa8f4ed85948d80dd876b4faca3e7ea7055415263dfd620', '[\"*\"]', '2026-02-07 15:20:20', NULL, '2026-02-07 15:20:19', '2026-02-07 15:20:20'),
(329, 'App\\Models\\User', 15, 'auth_token', '7a07ac5270c0f5944b39078d5741af8af3a92fa94ad8a7b628543a939bb79b94', '[\"*\"]', '2026-02-08 22:13:59', NULL, '2026-02-07 15:36:48', '2026-02-08 22:13:59'),
(330, 'App\\Models\\User', 15, 'auth_token', 'f19e4afb91ab13b2cd6176c49e331db8e90259cafe5b3fdfac7dc984e0ecd771', '[\"*\"]', '2026-02-08 01:29:12', NULL, '2026-02-08 01:28:49', '2026-02-08 01:29:12'),
(331, 'App\\Models\\User', 15, 'auth_token', '49054f8b33798f2ebf2749fe8471c95d81210f70e7ae15861faf999e577365f3', '[\"*\"]', '2026-02-11 13:57:05', NULL, '2026-02-11 13:56:40', '2026-02-11 13:57:05'),
(332, 'App\\Models\\User', 15, 'auth_token', '202b12cf172846aefa5f72d9be575cffac0366c25b608da2c8e290134c5431d4', '[\"*\"]', '2026-02-12 23:02:44', NULL, '2026-02-12 23:02:31', '2026-02-12 23:02:44'),
(333, 'App\\Models\\User', 15, 'auth_token', '698385d9f2f28607de175de60f2ea0e78d2c3365735456e1e613faafc9e1d5d6', '[\"*\"]', '2026-02-16 22:07:44', NULL, '2026-02-13 15:07:02', '2026-02-16 22:07:44'),
(334, 'App\\Models\\User', 15, 'auth_token', 'f16c26636737c4e211f84bea9860befa3fa91fecb1ad194cdf8b43e7ac7102f0', '[\"*\"]', '2026-02-17 18:28:52', NULL, '2026-02-17 18:28:41', '2026-02-17 18:28:52'),
(335, 'App\\Models\\User', 15, 'auth_token', 'dcf43b76b835f45fc8b9c0d63b9a1179a85f3cc8e914cb28244f7d706057d3b7', '[\"*\"]', '2026-02-17 18:29:27', NULL, '2026-02-17 18:28:59', '2026-02-17 18:29:27'),
(336, 'App\\Models\\User', 15, 'auth_token', '1b22dd3fafdfbde930c0f3bfc24162f7cd1131e780d7a83f53559c19f3fe7550', '[\"*\"]', '2026-02-17 18:29:53', NULL, '2026-02-17 18:29:45', '2026-02-17 18:29:53'),
(337, 'App\\Models\\User', 15, 'auth_token', '4125b2c0b02f5525fb45979fb94d5f65d0e128c1d4660ea473934d1577b03bd8', '[\"*\"]', '2026-02-17 18:30:08', NULL, '2026-02-17 18:30:03', '2026-02-17 18:30:08'),
(338, 'App\\Models\\User', 15, 'auth_token', 'abac8cde3cd8792b674d1291a3933564ade68557c0e83bf1d8d159208411f9e1', '[\"*\"]', '2026-02-17 18:30:18', NULL, '2026-02-17 18:30:17', '2026-02-17 18:30:18'),
(339, 'App\\Models\\User', 15, 'auth_token', 'db3cc0c238e817254c69f3b9882d92219c14059a29a6e233d0c46aaf03da724d', '[\"*\"]', '2026-02-17 18:51:48', NULL, '2026-02-17 18:51:48', '2026-02-17 18:51:48'),
(340, 'App\\Models\\User', 15, 'auth_token', '873cdf1b8bb954f4472ea2a73c123c96b2aa6c293fc751ba3c7d68e33fcc7f8e', '[\"*\"]', '2026-02-17 18:53:36', NULL, '2026-02-17 18:53:35', '2026-02-17 18:53:36'),
(341, 'App\\Models\\User', 15, 'auth_token', '494fd87e7b496b162f229df012d492348ef642b0ce17c147ff7c294bc81c9f96', '[\"*\"]', '2026-02-17 18:55:34', NULL, '2026-02-17 18:54:16', '2026-02-17 18:55:34'),
(342, 'App\\Models\\User', 17, 'auth_token', 'dfcf12af7c693a053552f13906d2b8aaf920471ac6c240280fbce8291957ef44', '[\"*\"]', '2026-02-18 11:01:44', NULL, '2026-02-18 10:59:12', '2026-02-18 11:01:44'),
(343, 'App\\Models\\User', 17, 'auth_token', 'c0dade04eb118b160432a99f87f5ce670578d15d6894f4746f145c1525973699', '[\"*\"]', '2026-02-18 11:05:03', NULL, '2026-02-18 11:02:59', '2026-02-18 11:05:03'),
(344, 'App\\Models\\User', 17, 'auth_token', 'a203d9e953c3cf27fb7287fd1fa5dd625f375e1031fca74bd82678ee43931335', '[\"*\"]', '2026-02-18 11:31:03', NULL, '2026-02-18 11:30:36', '2026-02-18 11:31:03'),
(345, 'App\\Models\\User', 17, 'auth_token', 'df0381dd50b10f6eac70cd752abf3f65b211c150cf84e31baec31245c48c40a9', '[\"*\"]', '2026-02-18 11:31:45', NULL, '2026-02-18 11:31:44', '2026-02-18 11:31:45'),
(346, 'App\\Models\\User', 17, 'auth_token', 'b3b518722e5f45a9278ec7e430cbb8283b49704901edac504370d608cc349aa7', '[\"*\"]', '2026-02-18 11:34:50', NULL, '2026-02-18 11:34:49', '2026-02-18 11:34:50'),
(347, 'App\\Models\\User', 15, 'auth_token', '8596200b72de723c2824b41c01ada0377158747ddd9d646984cd66fc9b0ea155', '[\"*\"]', '2026-02-18 11:39:38', NULL, '2026-02-18 11:39:25', '2026-02-18 11:39:38'),
(348, 'App\\Models\\User', 15, 'auth_token', '36d1f47947cd46dd87b25c22998487ba42c530d8fc8240e88aa9e4a637f5ecda', '[\"*\"]', '2026-02-18 11:43:32', NULL, '2026-02-18 11:43:15', '2026-02-18 11:43:32'),
(349, 'App\\Models\\User', 15, 'auth_token', '4cf8f80b1f85b05f971b189ac3fa0a922f0e1c28955e9931ce60fefa0cbc671e', '[\"*\"]', '2026-02-18 11:44:02', NULL, '2026-02-18 11:44:01', '2026-02-18 11:44:02'),
(350, 'App\\Models\\User', 15, 'auth_token', 'f6b534050e12966d90e50b9613a0956afbf7f183e1ad1a967e6b308d43b7091d', '[\"*\"]', '2026-02-18 11:45:23', NULL, '2026-02-18 11:45:22', '2026-02-18 11:45:23'),
(351, 'App\\Models\\User', 15, 'auth_token', '9e8c5d690cb522222c29425d26f478ddcc3962f1c15c74e497df7580bfb7ae90', '[\"*\"]', '2026-02-18 11:45:45', NULL, '2026-02-18 11:45:44', '2026-02-18 11:45:45'),
(352, 'App\\Models\\User', 15, 'auth_token', '40a4660f7f648e691aae932912c24fdf18d61c0e04505a55f379e15a0226efa7', '[\"*\"]', '2026-02-18 11:45:54', NULL, '2026-02-18 11:45:50', '2026-02-18 11:45:54'),
(353, 'App\\Models\\User', 23, 'auth_token', '0bf37ce754a1a3c62fb586c179dbb84559ed6b9dabfed75ae692e772f17fcb67', '[\"*\"]', '2026-03-03 13:51:40', NULL, '2026-02-18 12:07:43', '2026-03-03 13:51:40'),
(354, 'App\\Models\\User', 15, 'auth_token', '222e715bff57cfbe8293679da29c6bf408447f5e4f5f047852b2db0b5422d361', '[\"*\"]', '2026-02-18 12:09:40', NULL, '2026-02-18 12:09:39', '2026-02-18 12:09:40'),
(355, 'App\\Models\\User', 15, 'auth_token', '068c6e8bb7c242aa853ecd81085d14476ce8be6d2a6b4689d08d968a371013e4', '[\"*\"]', '2026-02-18 12:12:01', NULL, '2026-02-18 12:11:56', '2026-02-18 12:12:01'),
(356, 'App\\Models\\User', 15, 'auth_token', '1dbd8ea7a644c9b5f7549bf8f0ee4dddbfe0bc1862688f5adef8f23c25eaa0ea', '[\"*\"]', '2026-02-18 12:12:33', NULL, '2026-02-18 12:12:32', '2026-02-18 12:12:33'),
(357, 'App\\Models\\User', 15, 'auth_token', 'fc08fff6fb44315cd6dd94f164cca04ad009ce204f844c79997c86eac83f2c3a', '[\"*\"]', '2026-02-18 12:13:58', NULL, '2026-02-18 12:13:52', '2026-02-18 12:13:58'),
(358, 'App\\Models\\User', 15, 'auth_token', 'c6862f2e318a6ff409bc83592b877710c7483402b59e41f8379d419842768fd3', '[\"*\"]', '2026-02-18 12:18:04', NULL, '2026-02-18 12:18:03', '2026-02-18 12:18:04'),
(359, 'App\\Models\\User', 15, 'auth_token', 'f9e6474ea75b2a4e7b0bef6e84038e11132de6902fcd8d43efa50623ed4c78fc', '[\"*\"]', '2026-02-18 12:25:55', NULL, '2026-02-18 12:25:39', '2026-02-18 12:25:55'),
(360, 'App\\Models\\User', 15, 'auth_token', 'b59148047b46a0fd83624bfa1f47ecc02dfffeb9695cf85604a6a250812c2edb', '[\"*\"]', '2026-02-18 12:26:21', NULL, '2026-02-18 12:26:20', '2026-02-18 12:26:21'),
(361, 'App\\Models\\User', 15, 'auth_token', '7ed3d4f5d34d7a0ea3673181f76be6b1804e53e1599ad13ada743ce026550318', '[\"*\"]', '2026-02-18 12:27:37', NULL, '2026-02-18 12:27:37', '2026-02-18 12:27:37'),
(362, 'App\\Models\\User', 15, 'auth_token', 'af2062ba0eaf4fa97d8a6889924f623bec620819c139842cabd2b152a2439b9f', '[\"*\"]', '2026-02-18 12:30:04', NULL, '2026-02-18 12:30:03', '2026-02-18 12:30:04'),
(363, 'App\\Models\\User', 15, 'auth_token', '0950e8e6127b5710f86499cd496625366dd1b4e75ea054133b9f6728e919db0c', '[\"*\"]', '2026-02-18 12:31:10', NULL, '2026-02-18 12:31:09', '2026-02-18 12:31:10'),
(364, 'App\\Models\\User', 15, 'auth_token', '45fb59f4eefae6954f0657d34fe502a2a95e0310f04920410cc84544394fc60a', '[\"*\"]', '2026-02-18 13:36:06', NULL, '2026-02-18 12:41:09', '2026-02-18 13:36:06'),
(365, 'App\\Models\\User', 15, 'auth_token', '92341754119012c1525bb789bf0904f3ead6256d702a073731cb61c6d7639300', '[\"*\"]', '2026-02-18 12:44:13', NULL, '2026-02-18 12:44:12', '2026-02-18 12:44:13'),
(366, 'App\\Models\\User', 15, 'auth_token', '676b31a49f39075e120dcad6298397a5547c6da4365d5399156436ec41e7d238', '[\"*\"]', '2026-02-18 12:45:59', NULL, '2026-02-18 12:45:59', '2026-02-18 12:45:59'),
(367, 'App\\Models\\User', 15, 'auth_token', '47ed6ee7d51f6f2c20bb296c00b0a5217e98cbd299acd67ff4aae373712d5df8', '[\"*\"]', '2026-02-18 13:13:59', NULL, '2026-02-18 13:13:58', '2026-02-18 13:13:59'),
(368, 'App\\Models\\User', 15, 'auth_token', '0951b41db33b7bdb7264706c45c44c0e5ed9c88eee93aa3e8dfdd4b4795d2716', '[\"*\"]', '2026-02-18 13:14:19', NULL, '2026-02-18 13:14:18', '2026-02-18 13:14:19'),
(369, 'App\\Models\\User', 15, 'auth_token', '5fdd5ece8f5d0a52bee51d0b568c0f979f53cc2775dd59b341a4e02082621785', '[\"*\"]', '2026-02-18 13:15:40', NULL, '2026-02-18 13:15:36', '2026-02-18 13:15:40'),
(370, 'App\\Models\\User', 15, 'auth_token', 'f52439cf96adf4581eee7603a1bef91e069e702a7150dfe939cdff85c4955c67', '[\"*\"]', '2026-02-18 13:16:17', NULL, '2026-02-18 13:16:16', '2026-02-18 13:16:17'),
(371, 'App\\Models\\User', 15, 'auth_token', '7d3c6e5693694a5514c2c7cbd28ccdf3abbb5392c62d5447ac538d37d01ee010', '[\"*\"]', '2026-02-18 13:16:54', NULL, '2026-02-18 13:16:53', '2026-02-18 13:16:54'),
(372, 'App\\Models\\User', 15, 'auth_token', 'f1fb7f54bcd93e6e603779611fc061f3c809436bd84223b7b3a9c7e5f4a40ae4', '[\"*\"]', NULL, NULL, '2026-02-18 13:26:38', '2026-02-18 13:26:38'),
(373, 'App\\Models\\User', 15, 'auth_token', 'f90795a9791755d880572fd6c9bff09e94681587064a443a88024342769490c4', '[\"*\"]', '2026-02-18 13:36:11', NULL, '2026-02-18 13:36:10', '2026-02-18 13:36:11'),
(375, 'App\\Models\\User', 15, 'auth_token', 'f9e752b4cf7af606ad8febbc625b73250891647b87d8e82a2fd7794282e64f97', '[\"*\"]', '2026-02-19 12:37:59', NULL, '2026-02-18 15:02:39', '2026-02-19 12:37:59'),
(376, 'App\\Models\\User', 15, 'auth_token', '5ad5531cfb5c7e4148e5561f851ed5f9f4d20e71d6dc7d792b1dbfcb67a7ba2e', '[\"*\"]', '2026-02-19 21:33:11', NULL, '2026-02-19 20:36:13', '2026-02-19 21:33:11'),
(377, 'App\\Models\\User', 15, 'auth_token', '99be14ec05ed3196b0d0513112d663242760fd4362f41681c2255bc03ca745d9', '[\"*\"]', '2026-02-19 20:37:15', NULL, '2026-02-19 20:37:12', '2026-02-19 20:37:15'),
(378, 'App\\Models\\User', 15, 'auth_token', '5fca81f085c2e7dd774e54822ebd3f48fe9e3788a879f5b263397e8b2858de9e', '[\"*\"]', '2026-02-19 20:38:07', NULL, '2026-02-19 20:37:47', '2026-02-19 20:38:07'),
(379, 'App\\Models\\User', 15, 'auth_token', '8527ccd9502f1c5e7bd12492d8c227ab0ef56ef80302898195f945a1174a6ac2', '[\"*\"]', '2026-02-19 20:38:42', NULL, '2026-02-19 20:38:15', '2026-02-19 20:38:42'),
(380, 'App\\Models\\User', 15, 'auth_token', 'f7f4546f36d6578683ca980196b23fac7d821bcd205817b29d048fad9ce57434', '[\"*\"]', '2026-02-20 14:11:46', NULL, '2026-02-19 20:59:19', '2026-02-20 14:11:46'),
(381, 'App\\Models\\User', 26, 'auth_token', 'ab13c46c5731f2a8b3138a1005321ff83367ee328a4f6e6b3aaf124a6c2151eb', '[\"*\"]', NULL, NULL, '2026-02-23 10:32:17', '2026-02-23 10:32:17'),
(382, 'App\\Models\\User', 27, 'auth_token', 'fe0498eabdf508567efc8ad586217c3afea744f672c86b9d55b0e275d81ed256', '[\"*\"]', NULL, NULL, '2026-02-23 10:34:16', '2026-02-23 10:34:16'),
(383, 'App\\Models\\User', 28, 'auth_token', '34b2c8bbbc883e828b4b37034de14f0291c2bd76559eda22e7ffcfd19469e839', '[\"*\"]', NULL, NULL, '2026-02-23 11:23:11', '2026-02-23 11:23:11'),
(384, 'App\\Models\\User', 29, 'auth_token', '1800dc4d772cc9807884938ad010fd9e1922742588910b3dee191d130c504c3e', '[\"*\"]', NULL, NULL, '2026-02-23 12:02:45', '2026-02-23 12:02:45'),
(385, 'App\\Models\\User', 30, 'auth_token', '8796fe52af496ae301a3acf74425102f03e0eb14ad58f4f83fdd24e97c24d133', '[\"*\"]', NULL, NULL, '2026-02-23 12:34:49', '2026-02-23 12:34:49'),
(387, 'App\\Models\\User', 15, 'auth_token', '25a26672b5196f1cfc358397ab596fd566246d88bd9d1b244d79828acd1e38ff', '[\"*\"]', '2026-02-23 13:20:28', NULL, '2026-02-23 13:20:21', '2026-02-23 13:20:28'),
(388, 'App\\Models\\User', 31, 'auth_token', 'de51c1c455dad29e734a730d8d2d4c19d82c00c027562a2eac875e74682d9556', '[\"*\"]', NULL, NULL, '2026-02-23 13:22:45', '2026-02-23 13:22:45'),
(389, 'App\\Models\\User', 32, 'auth_token', '47a54a4e15b827cd566c35dc4b7eec7614e7390693075ef8ff499d6117243190', '[\"*\"]', NULL, NULL, '2026-02-23 13:29:54', '2026-02-23 13:29:54'),
(390, 'App\\Models\\User', 15, 'auth_token', '9788f3e654f02036696b46d76b8e7f60f1a6a2de9048cf9aa425c8a955f1ba43', '[\"*\"]', '2026-02-23 13:36:12', NULL, '2026-02-23 13:30:15', '2026-02-23 13:36:12'),
(391, 'App\\Models\\User', 33, 'auth_token', '43d149a444f318d6fd025b4509ee2502528cabe31f9c0b4554f499a513583574', '[\"*\"]', NULL, NULL, '2026-02-23 14:36:16', '2026-02-23 14:36:16'),
(392, 'App\\Models\\User', 34, 'auth_token', '990db23b4367908add045cea1228df8112aa11ec6c3350f067bb76b7e3c18905', '[\"*\"]', NULL, NULL, '2026-02-23 16:08:59', '2026-02-23 16:08:59'),
(393, 'App\\Models\\User', 15, 'auth_token', '4ce745890e2a9b2517142b1ae7633a738c675dcb51feb3cc5b0ef3f3fc567cce', '[\"*\"]', '2026-02-23 17:39:22', NULL, '2026-02-23 17:38:31', '2026-02-23 17:39:22'),
(394, 'App\\Models\\User', 15, 'auth_token', '7aceae243e3247f90be3ef733de08d24216d6c7ba005548e43bdb1a5bea1bacc', '[\"*\"]', '2026-02-23 17:47:39', NULL, '2026-02-23 17:47:34', '2026-02-23 17:47:39'),
(395, 'App\\Models\\User', 15, 'auth_token', '0e83ca0e6018969e3bf32d56af5c3de3eb5ba0414da42881d11ec5074553a7bc', '[\"*\"]', '2026-02-23 17:47:58', NULL, '2026-02-23 17:47:57', '2026-02-23 17:47:58'),
(396, 'App\\Models\\User', 15, 'auth_token', '11a3fa5cbcfae0e57a72e38f4d1de544d16e7bdb4c2f825873eccec5f405928f', '[\"*\"]', '2026-02-23 17:54:27', NULL, '2026-02-23 17:52:24', '2026-02-23 17:54:27'),
(397, 'App\\Models\\User', 26, 'auth_token', '0070fef967f7825369b0396e0456c26f301dafb01504ee654438601db6ec49ee', '[\"*\"]', '2026-02-23 17:53:58', NULL, '2026-02-23 17:53:03', '2026-02-23 17:53:58'),
(398, 'App\\Models\\User', 27, 'auth_token', '57e726b5d5c10f07c4bb1afe2ba9d91a4200a0d6bb01fe04f0d6dec058d83757', '[\"*\"]', '2026-02-24 15:16:57', NULL, '2026-02-23 17:56:07', '2026-02-24 15:16:57'),
(399, 'App\\Models\\User', 17, 'auth_token', '3af201ce0f07ab758c3b874fc1c7b7c9a11ba7c9c39de322ac8d5488b0640732', '[\"*\"]', '2026-02-24 00:55:45', NULL, '2026-02-24 00:51:09', '2026-02-24 00:55:45'),
(400, 'App\\Models\\User', 17, 'auth_token', '2e06a950781b85228c7c48f8e66d5498639cf5e98a4f1bb09107e8f0fd35e803', '[\"*\"]', '2026-02-24 00:56:57', NULL, '2026-02-24 00:56:03', '2026-02-24 00:56:57'),
(401, 'App\\Models\\User', 17, 'auth_token', '52c63b5356e0ae57e6a914f88130cadb2bbad83243b1828ca225dcde199af01d', '[\"*\"]', '2026-02-24 00:57:06', NULL, '2026-02-24 00:57:05', '2026-02-24 00:57:06'),
(402, 'App\\Models\\User', 35, 'auth_token', '9b5d20d1b6927340acc9a45d72cff0f9e92ffae03f25784280ee39b890407207', '[\"*\"]', NULL, NULL, '2026-02-24 02:17:14', '2026-02-24 02:17:14'),
(403, 'App\\Models\\User', 36, 'auth_token', 'ae7b5c9724fd58cb57a81746643cddc0cc92b636cbd96b4c3c6c1ba262512f96', '[\"*\"]', NULL, NULL, '2026-02-24 09:09:46', '2026-02-24 09:09:46'),
(404, 'App\\Models\\User', 17, 'auth_token', '5c42a09d71829ed0970effa690b89ba362c2921c02dd603187b57bb268a51b80', '[\"*\"]', '2026-02-24 09:17:25', NULL, '2026-02-24 09:13:58', '2026-02-24 09:17:25'),
(405, 'App\\Models\\User', 36, 'auth_token', 'de4a306707d391d432fad2aef79788f47b36218f45e1af8a77900638065785ed', '[\"*\"]', '2026-02-24 09:20:46', NULL, '2026-02-24 09:20:20', '2026-02-24 09:20:46'),
(406, 'App\\Models\\User', 26, 'auth_token', 'd5959da028f5fdc2ddc46c33ed65ceb2e4d1a92b90b355ab944fad144bb320af', '[\"*\"]', '2026-02-24 09:21:12', NULL, '2026-02-24 09:20:54', '2026-02-24 09:21:12'),
(407, 'App\\Models\\User', 37, 'auth_token', '2f213816d972dc30d87a234957ca5d8ad2d10bd6cff46f14f2d1f5744242a4e8', '[\"*\"]', NULL, NULL, '2026-02-24 10:04:54', '2026-02-24 10:04:54'),
(408, 'App\\Models\\User', 15, 'auth_token', '72c3eac06a13a1c2ab4d3f04204eaf15e998e515b29e5a1c4878eafb30f806a2', '[\"*\"]', '2026-02-24 16:36:23', NULL, '2026-02-24 10:23:23', '2026-02-24 16:36:23'),
(409, 'App\\Models\\User', 15, 'auth_token', 'fb8ae4a451505a65d5898ec5e0b6a5dd47ee3768335c875d0e7aa1e80c935ef5', '[\"*\"]', NULL, NULL, '2026-02-24 10:24:47', '2026-02-24 10:24:47'),
(410, 'App\\Models\\User', 15, 'auth_token', '53b8e3240a3be259106cf64a09bdc52a15f866aa413b8a52a367b82175df138b', '[\"*\"]', '2026-02-24 10:25:08', NULL, '2026-02-24 10:24:47', '2026-02-24 10:25:08'),
(411, 'App\\Models\\User', 15, 'auth_token', 'e67e0ecae961e4f9b68a15e178e6826b5db443c325d8eb6b41aba721751b9aba', '[\"*\"]', '2026-02-24 10:45:34', NULL, '2026-02-24 10:45:24', '2026-02-24 10:45:34'),
(412, 'App\\Models\\User', 15, 'auth_token', 'f7212566078bfe5ab32827daba9d82dab1cd3c2b2af2d1d03aa774c5c773c58f', '[\"*\"]', '2026-02-24 13:07:45', NULL, '2026-02-24 11:01:54', '2026-02-24 13:07:45'),
(413, 'App\\Models\\User', 38, 'auth_token', '0abc92a68028fc3f5397490607407a2ebe7ebb24f248444c66bd440c00101562', '[\"*\"]', NULL, NULL, '2026-02-24 13:11:17', '2026-02-24 13:11:17'),
(414, 'App\\Models\\User', 15, 'auth_token', '0c131daa73191ff78b610c5fded14621005acb2e5aaa5ad724e0ccb244049332', '[\"*\"]', '2026-02-24 14:02:37', NULL, '2026-02-24 13:18:36', '2026-02-24 14:02:37'),
(415, 'App\\Models\\User', 15, 'auth_token', '18eabe8ce3b4d3c95c979c6bfaae93f54b47f20706a03b1a42f21edb9b4cc895', '[\"*\"]', '2026-02-24 13:21:53', NULL, '2026-02-24 13:21:37', '2026-02-24 13:21:53'),
(416, 'App\\Models\\User', 15, 'auth_token', 'd0803560ea85024bc0263163a0f4db7149bc529e146cbd570c3e1b7123cd50f4', '[\"*\"]', '2026-02-24 15:29:50', NULL, '2026-02-24 13:30:42', '2026-02-24 15:29:50'),
(417, 'App\\Models\\User', 39, 'auth_token', 'f84e3e97a2ade98704d348b87d0c336760da67dbfb3dcb558da69e87b7f71d03', '[\"*\"]', NULL, NULL, '2026-02-24 13:48:08', '2026-02-24 13:48:08'),
(418, 'App\\Models\\User', 15, 'auth_token', '567ead4c9eebaeec4f693154288c31b2ba8f3dea2f2d6916cdd0ebe4ba6b9ca8', '[\"*\"]', '2026-02-25 11:08:32', NULL, '2026-02-24 14:03:24', '2026-02-25 11:08:32'),
(419, 'App\\Models\\User', 40, 'auth_token', 'a1d8d291d884a4e4384f5f52baf1fa03f1f7cefaa7e545742206e2cc891efb18', '[\"*\"]', NULL, NULL, '2026-02-24 14:26:39', '2026-02-24 14:26:39'),
(420, 'App\\Models\\User', 41, 'auth_token', '15539f030c6d9eb5adc6df8c23d88953f0f73af184dc5a12038d7a0255718d91', '[\"*\"]', NULL, NULL, '2026-02-24 14:29:18', '2026-02-24 14:29:18'),
(421, 'App\\Models\\User', 39, 'auth_token', '9157b289b1feac2d8ca38c7bb309fe7a8e4bc3e91c5b5ff70fa0e9a70e527c6d', '[\"*\"]', '2026-02-24 15:22:21', NULL, '2026-02-24 15:20:54', '2026-02-24 15:22:21'),
(422, 'App\\Models\\User', 42, 'auth_token', '26b0c42fa9a9d95b99943ba0a4fa0a063b120f50dc84ba75fda828bfd5a1b920', '[\"*\"]', NULL, NULL, '2026-02-24 15:31:13', '2026-02-24 15:31:13'),
(423, 'App\\Models\\User', 34, 'auth_token', '64123e7bd06481e93e6de2a62c5dc4993078c7692fccf30c8f8e21a564ca3be4', '[\"*\"]', '2026-02-24 19:03:10', NULL, '2026-02-24 18:55:51', '2026-02-24 19:03:10'),
(424, 'App\\Models\\User', 43, 'auth_token', '258aac978c2d365f267e7e47749794b36b4dda663e916494bd3dd00c210571ac', '[\"*\"]', NULL, NULL, '2026-02-24 21:15:24', '2026-02-24 21:15:24'),
(425, 'App\\Models\\User', 44, 'auth_token', '9a13fa5367999f7eb38b86fe0285b4472beaee07a6be0128856e5a532532d266', '[\"*\"]', NULL, NULL, '2026-02-24 22:20:49', '2026-02-24 22:20:49'),
(426, 'App\\Models\\User', 45, 'auth_token', 'afe3579c45d92cac6afeea209016894c1b8dd83edf95907582d6652b49c8410e', '[\"*\"]', NULL, NULL, '2026-02-24 22:25:28', '2026-02-24 22:25:28'),
(427, 'App\\Models\\User', 15, 'auth_token', '25e3aa67f5dee7ce21873618d662474737ed57825e74bf689f57b1858ae29bb4', '[\"*\"]', '2026-02-25 00:41:37', NULL, '2026-02-24 22:36:33', '2026-02-25 00:41:37'),
(428, 'App\\Models\\User', 46, 'auth_token', 'ddc483f4623cba1f8d54b8c54eca2df781bfefea678bc615123ca63901600cd0', '[\"*\"]', NULL, NULL, '2026-02-24 23:46:44', '2026-02-24 23:46:44'),
(429, 'App\\Models\\User', 27, 'auth_token', '074e3c89a5ca3b20d8c2a0bd3d42c2685864f523b17c338ff747530c4062591b', '[\"*\"]', '2026-02-25 20:42:47', NULL, '2026-02-25 00:17:46', '2026-02-25 20:42:47'),
(430, 'App\\Models\\User', 32, 'auth_token', '21cfe662955a6136541072b6fecd9d60b3f24ae79449b146c7ebbe00b0e4196f', '[\"*\"]', '2026-02-25 00:44:50', NULL, '2026-02-25 00:43:50', '2026-02-25 00:44:50'),
(431, 'App\\Models\\User', 15, 'auth_token', 'f15e3c757c4d6ff0aaf06f21b79b80a3d227c2e7edae6cbef3effcac8db02def', '[\"*\"]', '2026-02-25 01:31:21', NULL, '2026-02-25 00:45:46', '2026-02-25 01:31:21'),
(432, 'App\\Models\\User', 32, 'auth_token', '239277351306552b5ab7d252a01bb1ad036d4eef38d3c41b979d8ebfb38f6ce5', '[\"*\"]', '2026-02-25 01:04:00', NULL, '2026-02-25 01:03:56', '2026-02-25 01:04:00'),
(433, 'App\\Models\\User', 47, 'auth_token', '2e02b3d56bad933f5e91ade5c81b593ef3941a460df45bb746de36a2373c5f97', '[\"*\"]', NULL, NULL, '2026-02-25 02:51:21', '2026-02-25 02:51:21'),
(435, 'App\\Models\\User', 48, 'auth_token', '6851b7078701c01933dbd3a94b4ca7f0ba9f60a44fc09462f0698f7087cb6fb1', '[\"*\"]', NULL, NULL, '2026-02-25 11:11:29', '2026-02-25 11:11:29'),
(436, 'App\\Models\\User', 15, 'auth_token', '974e1eb55db227819fe33b9919cd1f0e8150004ee3edcadaf51a0a51caffa218', '[\"*\"]', '2026-02-25 11:21:37', NULL, '2026-02-25 11:11:37', '2026-02-25 11:21:37'),
(437, 'App\\Models\\User', 49, 'auth_token', 'c5f3d4fee80899a71378ee8bc8ee38e21503fee8e8bd8e28fa08143e5ddb3200', '[\"*\"]', NULL, NULL, '2026-02-25 11:16:43', '2026-02-25 11:16:43'),
(438, 'App\\Models\\User', 15, 'auth_token', '06b560afdc121bb7ea8466a27fd83a9b4147fb1c0e61fd27b3dbf6a12f5557aa', '[\"*\"]', '2026-02-25 11:19:29', NULL, '2026-02-25 11:19:26', '2026-02-25 11:19:29'),
(439, 'App\\Models\\User', 15, 'auth_token', '897849bcc953948d562d3d1e0004839a4ee0b107f426466eb07225a6eb3f42c1', '[\"*\"]', '2026-02-25 11:21:40', NULL, '2026-02-25 11:21:21', '2026-02-25 11:21:40'),
(440, 'App\\Models\\User', 15, 'auth_token', '61a1117195a3907ea7c0867e680d80b44f4980427843b2a3be6a4b6b24da2cf9', '[\"*\"]', '2026-02-25 13:20:19', NULL, '2026-02-25 11:26:27', '2026-02-25 13:20:19'),
(441, 'App\\Models\\User', 15, 'auth_token', 'd434edf60f332ce9fbb0ee3bb228c25cf9636082eb575a9e1089ea74dc970911', '[\"*\"]', '2026-02-25 11:29:09', NULL, '2026-02-25 11:28:56', '2026-02-25 11:29:09'),
(442, 'App\\Models\\User', 17, 'auth_token', 'aceda2f261c532c09a27e454c3c0f55cf27c0b8186e8f05dddd76b65555e269d', '[\"*\"]', '2026-02-25 12:13:36', NULL, '2026-02-25 12:08:46', '2026-02-25 12:13:36'),
(443, 'App\\Models\\User', 17, 'auth_token', '2f43bada131d746ed3fa8a824478c292e7408ef81d025d32bd21d0e3f3373acb', '[\"*\"]', '2026-02-25 12:16:27', NULL, '2026-02-25 12:14:20', '2026-02-25 12:16:27'),
(444, 'App\\Models\\User', 17, 'auth_token', '2333a6a6f75725fd0beecc8f8bbf51be09accb4c18e41f60697ac3c041f7d9a4', '[\"*\"]', '2026-02-25 12:25:50', NULL, '2026-02-25 12:23:09', '2026-02-25 12:25:50'),
(445, 'App\\Models\\User', 50, 'auth_token', '5764fa6b3f40a90ebf902fff210695f3edce294091ab8eebc889dd5f659beed1', '[\"*\"]', NULL, NULL, '2026-02-25 12:30:10', '2026-02-25 12:30:10'),
(446, 'App\\Models\\User', 17, 'auth_token', '40d4dfc2713fd65f7ea8b9afa581a0398cb215ff7aa5670ea3c932c42fd43bd7', '[\"*\"]', '2026-02-25 12:34:03', NULL, '2026-02-25 12:32:28', '2026-02-25 12:34:03'),
(448, 'App\\Models\\User', 24, 'auth_token', '4b05f68bc53b453a63414ce57a35c262c088f52a9dac2e6a3737f12605fb75d2', '[\"*\"]', NULL, NULL, '2026-02-25 13:03:53', '2026-02-25 13:03:53'),
(449, 'App\\Models\\User', 24, 'auth_token', 'fa76535125be76eb0d3c93dcc3b82cb6bd60ee7a4899a045588113c648eab58b', '[\"*\"]', NULL, NULL, '2026-02-25 13:04:11', '2026-02-25 13:04:11'),
(450, 'App\\Models\\User', 24, 'auth_token', '7e89642957f74db2d02f7b5730b4e3d87c44ef7836f5de2f1874e577dada35cd', '[\"*\"]', NULL, NULL, '2026-02-25 13:04:33', '2026-02-25 13:04:33'),
(451, 'App\\Models\\User', 24, 'auth_token', 'b171e12a141e022c55bd91db1b3c974beceb9501a2ba97d83e1633fd8c57f5b6', '[\"*\"]', NULL, NULL, '2026-02-25 13:07:29', '2026-02-25 13:07:29'),
(452, 'App\\Models\\User', 15, 'auth_token', 'd57a2f4134df1c844eed244668c5c285d9bc2d10665ab1bed4564d8d265686b3', '[\"*\"]', '2026-02-25 14:31:06', NULL, '2026-02-25 14:28:06', '2026-02-25 14:31:06'),
(453, 'App\\Models\\User', 24, 'auth_token', '42d97ea0c2c3266c81047f617b22ff51cbcd3886fadca71c37f1aa7263ebc4fb', '[\"*\"]', NULL, NULL, '2026-02-25 14:32:44', '2026-02-25 14:32:44'),
(454, 'App\\Models\\User', 17, 'auth_token', 'ac98caf48e40b2bacfdb6ce350c65b69f8d76e12794b19451629335df9ff8c1d', '[\"*\"]', '2026-02-25 14:41:34', NULL, '2026-02-25 14:36:34', '2026-02-25 14:41:34'),
(455, 'App\\Models\\User', 17, 'auth_token', '0249290fcdcec3f51d63ab7a8e33b7b8bb75822436af9fe8d390bf794776a194', '[\"*\"]', '2026-02-27 22:05:45', NULL, '2026-02-25 14:43:37', '2026-02-27 22:05:45'),
(456, 'App\\Models\\User', 15, 'auth_token', '507a28d2543eca55224ef14911807c411ad240830f83221070bccc2ad1f4a507', '[\"*\"]', '2026-02-25 15:01:14', NULL, '2026-02-25 15:00:54', '2026-02-25 15:01:14'),
(457, 'App\\Models\\User', 24, 'auth_token', 'b7e8f3dea813e333c21c471aed40f7c8f5a1bfb014973a41dc83b5a170dd1f35', '[\"*\"]', NULL, NULL, '2026-02-25 15:04:18', '2026-02-25 15:04:18'),
(458, 'App\\Models\\User', 24, 'auth_token', 'facf1167b63064339b786a85c40ec12239eb5f163a0d39942038d1e49cefc2c6', '[\"*\"]', NULL, NULL, '2026-02-25 15:05:42', '2026-02-25 15:05:42'),
(459, 'App\\Models\\User', 24, 'auth_token', '7829a1030ecfad7fee963924d5d3ffb27a18e0e0954e90f1b13171bb2bd23f50', '[\"*\"]', NULL, NULL, '2026-02-25 15:05:44', '2026-02-25 15:05:44'),
(461, 'App\\Models\\User', 15, 'auth_token', 'c589e483d1ceceff9e9787f66af337dd088c8bc46af19fdf75f964362908e7fd', '[\"*\"]', '2026-02-25 15:21:59', NULL, '2026-02-25 15:21:27', '2026-02-25 15:21:59'),
(462, 'App\\Models\\User', 15, 'auth_token', '858b3c49853039aa6b954e6b0cf756b80310529f0eb673e7db5964b168a398fe', '[\"*\"]', '2026-02-25 15:53:24', NULL, '2026-02-25 15:53:05', '2026-02-25 15:53:24'),
(463, 'App\\Models\\User', 51, 'auth_token', '847f8049467c6fc0e0f7fbbdcefca12daf2e891bd5341edda83bc28af443e900', '[\"*\"]', NULL, NULL, '2026-02-25 17:43:49', '2026-02-25 17:43:49'),
(464, 'App\\Models\\User', 46, 'auth_token', '644680d63866b2d7b02d8000303d77797a90c4c5c96369f7acc6c4592cc4a8eb', '[\"*\"]', '2026-02-25 17:45:49', NULL, '2026-02-25 17:44:32', '2026-02-25 17:45:49'),
(465, 'App\\Models\\User', 38, 'auth_token', '7ad22b97b91c051ba9e7164bd33b5a9b6fd629000fc82e0c492f9289d60e03d7', '[\"*\"]', '2026-02-25 17:54:04', NULL, '2026-02-25 17:51:57', '2026-02-25 17:54:04'),
(466, 'App\\Models\\User', 30, 'auth_token', 'd3cd88baedabf660ef16a06ef3f40ecb6bc422a55ee40834882d0bb1cf8f19ea', '[\"*\"]', '2026-02-25 18:07:21', NULL, '2026-02-25 18:06:58', '2026-02-25 18:07:21'),
(467, 'App\\Models\\User', 52, 'auth_token', 'a47d9994cd4d803130cf32abdbc8d10ecf86425c224089f2d260c71763a87a8d', '[\"*\"]', NULL, NULL, '2026-02-25 18:12:55', '2026-02-25 18:12:55'),
(468, 'App\\Models\\User', 37, 'auth_token', 'd2e11e07fc8d8a447f8fcecdfc6b493271528a5ff4eec188805d659c0eae4c60', '[\"*\"]', '2026-02-25 18:20:55', NULL, '2026-02-25 18:14:41', '2026-02-25 18:20:55'),
(469, 'App\\Models\\User', 37, 'auth_token', '678b2678c3396207a39b72788c8cfd4149688d858dcdac9b3fd5e08bb2733087', '[\"*\"]', '2026-02-25 18:22:57', NULL, '2026-02-25 18:22:45', '2026-02-25 18:22:57'),
(470, 'App\\Models\\User', 37, 'auth_token', '1b56679eaeef2e7377c47ca82ccca87b972237c919f39510fdf07286fe348afd', '[\"*\"]', '2026-02-25 18:24:01', NULL, '2026-02-25 18:23:38', '2026-02-25 18:24:01'),
(471, 'App\\Models\\User', 53, 'auth_token', '285119c6797ee198f5d3e5704b73bd0752909540efd8b776d957993f315ae0b4', '[\"*\"]', NULL, NULL, '2026-02-25 18:24:45', '2026-02-25 18:24:45'),
(472, 'App\\Models\\User', 41, 'auth_token', 'd56de279fe5f7e9637b7b446e96bc2c78d9b149c3e96cf905f5c97d63598b7e6', '[\"*\"]', '2026-02-25 18:29:58', NULL, '2026-02-25 18:29:03', '2026-02-25 18:29:58'),
(473, 'App\\Models\\User', 52, 'auth_token', '2af794256aa9f151d64569e28932f333467d04196fcbe3f15163c16cb053fe04', '[\"*\"]', '2026-02-25 18:41:45', NULL, '2026-02-25 18:41:05', '2026-02-25 18:41:45'),
(474, 'App\\Models\\User', 45, 'auth_token', '36650614b757214ba67701e20f93efd713c5c35b483e0b71b8bf90d07a83465a', '[\"*\"]', '2026-02-25 18:41:31', NULL, '2026-02-25 18:41:28', '2026-02-25 18:41:31'),
(475, 'App\\Models\\User', 24, 'auth_token', '429d53ef6c2e1e632dc476bd5e697bd70eec0c22e5713f225bcd1a16ca1be8f3', '[\"*\"]', NULL, NULL, '2026-02-25 18:45:53', '2026-02-25 18:45:53'),
(476, 'App\\Models\\User', 54, 'auth_token', '18efa5bbad1c34ef19b0aa88d4e4ed754cef130ccda8d82433bfedbb52a2f8de', '[\"*\"]', NULL, NULL, '2026-02-25 18:51:46', '2026-02-25 18:51:46'),
(477, 'App\\Models\\User', 55, 'auth_token', '0e2d903b67738ac91cb01e411e6b99cf71e10544ace09811103b766bd5947afa', '[\"*\"]', NULL, NULL, '2026-02-25 19:06:15', '2026-02-25 19:06:15'),
(478, 'App\\Models\\User', 15, 'auth_token', '71294b64524760e0ab21a775540b054c69ace56d113fc11532085e981e19a7b4', '[\"*\"]', '2026-02-25 20:41:41', NULL, '2026-02-25 20:41:06', '2026-02-25 20:41:41'),
(479, 'App\\Models\\User', 53, 'auth_token', 'b836c2667cc37819fe4fd1698a272eeb1ff01c717bd5ba73813a26c8d0972729', '[\"*\"]', '2026-02-25 20:47:07', NULL, '2026-02-25 20:46:05', '2026-02-25 20:47:07'),
(480, 'App\\Models\\User', 15, 'auth_token', 'bc06d0c612ba3ea2e89fb5024334fdb841a11de1b839c5c36426c66a8fe54a9a', '[\"*\"]', '2026-02-26 00:46:00', NULL, '2026-02-25 21:28:04', '2026-02-26 00:46:00'),
(481, 'App\\Models\\User', 56, 'auth_token', '41353012a1d3db73ac7058a10fe7a20e110e38e27f2a27b45214ea598822e9cf', '[\"*\"]', NULL, NULL, '2026-02-25 22:00:08', '2026-02-25 22:00:08'),
(482, 'App\\Models\\User', 57, 'auth_token', '5f69a8eab1fbcb14d84969f89a658955034a4356be5ed3e1e0d0e1647b8aebdc', '[\"*\"]', NULL, NULL, '2026-02-25 22:13:22', '2026-02-25 22:13:22'),
(483, 'App\\Models\\User', 17, 'auth_token', '49119f8bb9ead22ca72bab3cb30a806bdbc274545bbed2fd9d6452766c99fc49', '[\"*\"]', '2026-02-25 22:45:54', NULL, '2026-02-25 22:45:28', '2026-02-25 22:45:54'),
(484, 'App\\Models\\User', 26, 'auth_token', 'c8fadf98e7d59c3fcc6caf4a2fbfd4e9d5af4a1bf55cfeff918b96e80b4f3fa2', '[\"*\"]', '2026-02-25 23:10:34', NULL, '2026-02-25 23:05:53', '2026-02-25 23:10:34'),
(485, 'App\\Models\\User', 15, 'auth_token', 'ff478adb8313ac977522f599a18447ea12164aa36d4f03e807720d4562beb348', '[\"*\"]', NULL, NULL, '2026-02-25 23:53:40', '2026-02-25 23:53:40'),
(486, 'App\\Models\\User', 15, 'auth_token', 'd15e6c6d4fd11889e849c19f53979f6030ca6e3a222b4da2b27f2a50a249208f', '[\"*\"]', '2026-02-25 23:57:48', NULL, '2026-02-25 23:53:44', '2026-02-25 23:57:48'),
(487, 'App\\Models\\User', 17, 'auth_token', '7e00249ec18b2f72244f583a7d4832a669eed20623c9741798ebded9fe483fb6', '[\"*\"]', '2026-02-26 00:27:57', NULL, '2026-02-26 00:27:56', '2026-02-26 00:27:57'),
(488, 'App\\Models\\User', 58, 'auth_token', '7645cd76c5c51d18cadec899edd37a77fa97654a68547ae1b94e58110825f67e', '[\"*\"]', NULL, NULL, '2026-02-26 00:36:02', '2026-02-26 00:36:02'),
(489, 'App\\Models\\User', 17, 'auth_token', '15fa781f94048dd7c96e76a5652bfe22a4f7df3e841f1cb3775f5e074aaaf306', '[\"*\"]', '2026-02-26 01:03:07', NULL, '2026-02-26 00:39:00', '2026-02-26 01:03:07'),
(490, 'App\\Models\\User', 15, 'auth_token', '38a70a35a0b8209ca670d7b9ebd00591bf9a8eb1f45c1c674b6f8bd41402b9f5', '[\"*\"]', '2026-02-26 00:41:54', NULL, '2026-02-26 00:41:44', '2026-02-26 00:41:54'),
(491, 'App\\Models\\User', 24, 'auth_token', 'aa5e50590bbc4e6d2e109fbd08e0b5879aea871fe3e5ce5458a1f35e24365f97', '[\"*\"]', NULL, NULL, '2026-02-26 00:55:54', '2026-02-26 00:55:54'),
(492, 'App\\Models\\User', 24, 'auth_token', '741d1dca6f35eea774d6b42a2fbb251fba42174bb66d2ba2fa3912a65ed6bc78', '[\"*\"]', NULL, NULL, '2026-02-26 00:58:31', '2026-02-26 00:58:31'),
(493, 'App\\Models\\User', 24, 'auth_token', '982c0fb7eec2668d3113ce56a2b71e9afe6600dacc77c1e0559c1b7742d37852', '[\"*\"]', NULL, NULL, '2026-02-26 00:58:45', '2026-02-26 00:58:45'),
(494, 'App\\Models\\User', 17, 'auth_token', '6c851bdb2214bace7e047fe352394b8620182359a763c73255af902d30e88934', '[\"*\"]', '2026-02-26 01:06:33', NULL, '2026-02-26 01:03:40', '2026-02-26 01:06:33'),
(495, 'App\\Models\\User', 59, 'auth_token', 'caf50c860f5d534211e87586beddcd3fb4b18fa3e4a1ea205a1965354cbac12b', '[\"*\"]', NULL, NULL, '2026-02-26 01:05:41', '2026-02-26 01:05:41'),
(496, 'App\\Models\\User', 17, 'auth_token', '35842a4aaa3c2b81e294de26a3212ab7c3ed90a04ef696911584ac1db4d766ce', '[\"*\"]', '2026-02-26 01:08:09', NULL, '2026-02-26 01:07:45', '2026-02-26 01:08:09'),
(497, 'App\\Models\\User', 56, 'auth_token', 'ef7e70a89554a6692129d18da0b83232f9490669e11bb0b3f6a08b3bcf9fa961', '[\"*\"]', '2026-02-26 01:20:48', NULL, '2026-02-26 01:14:51', '2026-02-26 01:20:48'),
(498, 'App\\Models\\User', 17, 'auth_token', 'c856e0fd275c2f8fb35f57750370708b673d008e2e0d99ac620766f3995f599c', '[\"*\"]', '2026-02-26 01:25:20', NULL, '2026-02-26 01:16:32', '2026-02-26 01:25:20'),
(499, 'App\\Models\\User', 17, 'auth_token', '19640e8db6a39b3eac9e463d630de92a45ffadf86d3fe79fa99cfe65dd096367', '[\"*\"]', '2026-02-26 01:25:33', NULL, '2026-02-26 01:25:32', '2026-02-26 01:25:33'),
(500, 'App\\Models\\User', 15, 'auth_token', '1be86832ed8bf526a2d0d5f5ee5474da74db03dd3147cf25f4a14d89d88f50f5', '[\"*\"]', '2026-02-26 01:28:13', NULL, '2026-02-26 01:27:59', '2026-02-26 01:28:13'),
(502, 'App\\Models\\User', 46, 'auth_token', '8c74b57f8af6f88c80298c08ee6ca5706d2bbeecdc4779cc824c5f1aaa3e17de', '[\"*\"]', '2026-02-26 01:52:14', NULL, '2026-02-26 01:52:14', '2026-02-26 01:52:14'),
(503, 'App\\Models\\User', 15, 'auth_token', '9356edb34cf66fb3f78f2a1fdae79d6a6eef55b1809e422152e6a1935ce17488', '[\"*\"]', '2026-02-26 02:03:18', NULL, '2026-02-26 01:55:13', '2026-02-26 02:03:18'),
(504, 'App\\Models\\User', 15, 'auth_token', 'aaead05e222a2cd33e4fedde976329e2dd918fc44bcdb94da762bfd5a2471dfc', '[\"*\"]', '2026-02-27 13:35:16', NULL, '2026-02-26 01:59:50', '2026-02-27 13:35:16'),
(505, 'App\\Models\\User', 60, 'auth_token', '855725cc194ed418e53170746324cdb6b98ccd6dcebd85de0628d87b30b1f6df', '[\"*\"]', NULL, NULL, '2026-02-26 02:07:12', '2026-02-26 02:07:12'),
(506, 'App\\Models\\User', 36, 'auth_token', 'fcbf1327ab1568c5f4cd9e71f55242dbbaf5b9a99b84983347134be7aa2bc8d9', '[\"*\"]', '2026-02-26 09:03:30', NULL, '2026-02-26 09:01:20', '2026-02-26 09:03:30'),
(508, 'App\\Models\\User', 15, 'auth_token', '7e46f542a80d7e41d9242cbd6142519d417b32d3614959cb7e183524b211afc7', '[\"*\"]', '2026-02-26 15:17:35', NULL, '2026-02-26 14:47:24', '2026-02-26 15:17:35'),
(509, 'App\\Models\\User', 15, 'auth_token', '87da26559f19295216f179acef9c60fd05855f793e28335d4ae2f3cf5b12d0d8', '[\"*\"]', '2026-02-26 17:57:25', NULL, '2026-02-26 15:04:49', '2026-02-26 17:57:25'),
(510, 'App\\Models\\User', 61, 'auth_token', 'a6457edeba6ff0af09f80b4f2c907ca1506d03c217bb0a0444b50d272bc7a43f', '[\"*\"]', NULL, NULL, '2026-02-26 15:27:13', '2026-02-26 15:27:13'),
(511, 'App\\Models\\User', 15, 'auth_token', '8aeee35fe455ae3a468583b89fc84dca4a75b1a3638bab9e6abbf900d0c07ddf', '[\"*\"]', '2026-02-27 02:39:01', NULL, '2026-02-26 15:29:40', '2026-02-27 02:39:01'),
(512, 'App\\Models\\User', 15, 'auth_token', '87997dbcfcffb397924e95e4152b86a00585ee6f6cad4e519ac58f4c27afdcd4', '[\"*\"]', '2026-02-26 17:54:03', NULL, '2026-02-26 15:42:56', '2026-02-26 17:54:03'),
(513, 'App\\Models\\User', 32, 'auth_token', 'a17e9461793aa578bb4487dc002abb4a212b8c968d2efd0f2bd8a43919671df8', '[\"*\"]', '2026-02-26 16:08:11', NULL, '2026-02-26 16:08:08', '2026-02-26 16:08:11'),
(514, 'App\\Models\\User', 32, 'auth_token', 'e3b62189f915df4590b113dc6edece386945a1a23fb2bae544026e5874fe888e', '[\"*\"]', '2026-02-26 16:09:42', NULL, '2026-02-26 16:09:24', '2026-02-26 16:09:42'),
(515, 'App\\Models\\User', 32, 'auth_token', '4c5dc41c4fe2f33de01961febcd6b9168b85729159d8f62d453064e8a3cf9de8', '[\"*\"]', '2026-02-26 16:12:53', NULL, '2026-02-26 16:12:52', '2026-02-26 16:12:53'),
(516, 'App\\Models\\User', 62, 'auth_token', '49a764f8434398930e63669bb2dad7d0d16325d99ee9f5ec93f2fbdf5e1032cc', '[\"*\"]', NULL, NULL, '2026-02-26 16:42:37', '2026-02-26 16:42:37'),
(517, 'App\\Models\\User', 24, 'auth_token', '52685ae1ef53b3e41cd078ce8c7f200c4a02ef4bb598a893578a4347352123c0', '[\"*\"]', NULL, NULL, '2026-02-26 16:46:18', '2026-02-26 16:46:18'),
(518, 'App\\Models\\User', 17, 'auth_token', '968a9e3d0cb5057ff5fa79b6bd8ae90cb95b0e637781d63665b647b4941db36e', '[\"*\"]', '2026-02-26 17:17:40', NULL, '2026-02-26 17:14:13', '2026-02-26 17:17:40'),
(519, 'App\\Models\\User', 32, 'auth_token', '863676ceb33edfac030c18e84404dd21714736bd6d92db7426bb123038a92353', '[\"*\"]', '2026-02-26 17:17:32', NULL, '2026-02-26 17:17:30', '2026-02-26 17:17:32'),
(520, 'App\\Models\\User', 17, 'auth_token', '982e200bc8ce1c2ad534ffeb07521ef3416cb7b6b82fe2b61a9f26d91891b6de', '[\"*\"]', '2026-02-26 17:18:59', NULL, '2026-02-26 17:18:25', '2026-02-26 17:18:59'),
(521, 'App\\Models\\User', 32, 'auth_token', '0dc87d0491df557403cab421699f0962653eb438d2d187a9135ab592286df30c', '[\"*\"]', '2026-02-26 17:18:40', NULL, '2026-02-26 17:18:39', '2026-02-26 17:18:40'),
(522, 'App\\Models\\User', 60, 'auth_token', 'a63996fb08c6663609ac3e774407bc01fee2a3a391d09bcd3bdd36fd2a5de228', '[\"*\"]', '2026-02-26 20:21:20', NULL, '2026-02-26 20:20:44', '2026-02-26 20:21:20'),
(523, 'App\\Models\\User', 60, 'auth_token', '5d53d61291b7ca3bd73a7dc679aedef07127224b4a36eed13eae97fe7f9728fd', '[\"*\"]', '2026-02-26 20:24:16', NULL, '2026-02-26 20:21:52', '2026-02-26 20:24:16'),
(524, 'App\\Models\\User', 60, 'auth_token', '4ddf54a10d863a1c5123451709ca2029c53a06335f738ce9745a20262103535a', '[\"*\"]', '2026-02-26 20:27:34', NULL, '2026-02-26 20:27:33', '2026-02-26 20:27:34'),
(525, 'App\\Models\\User', 63, 'auth_token', 'bd70bd9d98d8ba0435c4544326f9e363f3620e925fc65b1fd1a82227590292a6', '[\"*\"]', NULL, NULL, '2026-02-27 01:07:31', '2026-02-27 01:07:31'),
(526, 'App\\Models\\User', 17, 'auth_token', 'b1cc1416d17b5d9952d1a9a50a8df877721e2922b2417d95d0a122684329f14c', '[\"*\"]', '2026-02-27 01:18:28', NULL, '2026-02-27 01:18:06', '2026-02-27 01:18:28'),
(527, 'App\\Models\\User', 15, 'auth_token', '11543822067760021474b33b51ce02a23cd24fd0ceeeeb05cdcf7fbd547e4494', '[\"*\"]', '2026-02-27 02:54:44', NULL, '2026-02-27 02:53:45', '2026-02-27 02:54:44'),
(528, 'App\\Models\\User', 15, 'auth_token', 'b4f32316690eab3a2d5aa6b2dcac1a1f4f297cad93c3a3c5ef04faae35e9c7b1', '[\"*\"]', '2026-02-27 02:55:27', NULL, '2026-02-27 02:55:04', '2026-02-27 02:55:27'),
(529, 'App\\Models\\User', 15, 'auth_token', 'a7c8ab006e62dc252f4f70f5421fc3ef8fde0fe55dbe632b152624a3a5611c76', '[\"*\"]', '2026-02-27 15:25:58', NULL, '2026-02-27 12:26:50', '2026-02-27 15:25:58'),
(530, 'App\\Models\\User', 17, 'auth_token', '8ad324763efd5ae3b874da5d57875de4366173c0a538f7d6da0c2bae27fde0f3', '[\"*\"]', '2026-02-27 12:54:15', NULL, '2026-02-27 12:53:52', '2026-02-27 12:54:15'),
(531, 'App\\Models\\User', 64, 'auth_token', 'a5583ca4305812a309f7273216c994769c75438155f075d888522eb20a77afd8', '[\"*\"]', NULL, NULL, '2026-02-27 13:12:03', '2026-02-27 13:12:03'),
(532, 'App\\Models\\User', 65, 'auth_token', '970c37be07e86227c600b2aeaf36f9dd456ad8e27f93b269cb92ca1b10b4ef72', '[\"*\"]', NULL, NULL, '2026-02-27 13:19:07', '2026-02-27 13:19:07'),
(533, 'App\\Models\\User', 17, 'auth_token', '6587071f55b49ff38df47fb12dfd2474d5f16086b6ca2fde2f05b618a2c70aeb', '[\"*\"]', '2026-02-27 13:52:09', NULL, '2026-02-27 13:51:43', '2026-02-27 13:52:09'),
(534, 'App\\Models\\User', 17, 'auth_token', 'd2258e92c52f3212ff6b6b3ab3e01d063e3c240d9a5fab6e766bfe18e8af76b9', '[\"*\"]', '2026-02-27 13:53:33', NULL, '2026-02-27 13:53:08', '2026-02-27 13:53:33'),
(535, 'App\\Models\\User', 24, 'auth_token', 'b59eaf47c426a0f09ed2774cf6ba0782dad9474292c03919d09284297126d614', '[\"*\"]', NULL, NULL, '2026-02-27 14:16:54', '2026-02-27 14:16:54'),
(536, 'App\\Models\\User', 42, 'auth_token', '37206925264e03f7296cef666c9ee95bae2825b30c766c895ed0f39c9af0635e', '[\"*\"]', '2026-02-27 14:45:57', NULL, '2026-02-27 14:42:20', '2026-02-27 14:45:57'),
(537, 'App\\Models\\User', 15, 'auth_token', 'd1b41e5fcf0fd16aae56abfb9da83ed3d97dcb4d27e9da8263d05169f367ab16', '[\"*\"]', '2026-02-27 15:51:39', NULL, '2026-02-27 15:26:46', '2026-02-27 15:51:39'),
(539, 'App\\Models\\User', 66, 'auth_token', '479fd8a1f270fc169034787ea4605bb3d02740769c6c469de16fa92e63138d94', '[\"*\"]', NULL, NULL, '2026-02-27 15:59:02', '2026-02-27 15:59:02'),
(540, 'App\\Models\\User', 67, 'auth_token', '50bf077f4bd9cb1bb8a8ca61051e51654b17eeae4254fddbf39047e7eb65ca41', '[\"*\"]', NULL, NULL, '2026-02-27 16:13:17', '2026-02-27 16:13:17'),
(541, 'App\\Models\\User', 15, 'auth_token', '3404668302c7313e2f7388bcc4fabcad2c6605669c6207433398abc68a9cf137', '[\"*\"]', '2026-02-27 17:10:56', NULL, '2026-02-27 17:04:20', '2026-02-27 17:10:56'),
(542, 'App\\Models\\User', 64, 'auth_token', '822fc69963a808ed82febc2a3ed14c7c2bf8cd9ea48c7419047690fe258e9dba', '[\"*\"]', '2026-02-27 18:09:12', NULL, '2026-02-27 17:50:44', '2026-02-27 18:09:12'),
(543, 'App\\Models\\User', 64, 'auth_token', 'fcb942b1b2c0392568d287eeab82c774115384411bb1c6c2d9d17f15086ee698', '[\"*\"]', '2026-02-27 18:09:24', NULL, '2026-02-27 18:09:16', '2026-02-27 18:09:24'),
(544, 'App\\Models\\User', 68, 'auth_token', '91a89d0b8c460803faed15e628d9df8ea9ed1d644a48bcae2c648a1b7de97cdc', '[\"*\"]', NULL, NULL, '2026-02-27 18:32:32', '2026-02-27 18:32:32'),
(545, 'App\\Models\\User', 69, 'auth_token', 'b5156ba60227a4be498089357e1361bf335e6ecd05383486932c630bdaf53647', '[\"*\"]', NULL, NULL, '2026-02-27 20:20:50', '2026-02-27 20:20:50'),
(546, 'App\\Models\\User', 70, 'auth_token', '83d8b48016633e3f187d4f8767af5ee5555ccec8bedf63f08c84b1760452fa65', '[\"*\"]', NULL, NULL, '2026-02-27 20:30:37', '2026-02-27 20:30:37'),
(547, 'App\\Models\\User', 21, 'auth_token', 'f889e0f0c8349ea11213e60d59688a80b94c3e5e1fa7cc2cfd2dc0d93d5d42f8', '[\"*\"]', NULL, NULL, '2026-02-27 20:31:21', '2026-02-27 20:31:21'),
(548, 'App\\Models\\User', 17, 'auth_token', '0aadea64d815eba1c89cd59b285c02d28cb1e142e93307cb85b87839899f1a1f', '[\"*\"]', '2026-02-27 21:16:55', NULL, '2026-02-27 21:16:54', '2026-02-27 21:16:55'),
(549, 'App\\Models\\User', 17, 'auth_token', '62213d37ac50976c24fcf83513350f2a3131a06a2ab40be64b0bdba510eab183', '[\"*\"]', '2026-02-27 21:22:49', NULL, '2026-02-27 21:22:32', '2026-02-27 21:22:49'),
(550, 'App\\Models\\User', 39, 'auth_token', '7cc6cb524e3ecb8117890190555415a8414ac451f01c614e73b28a0f9f3bd667', '[\"*\"]', '2026-02-27 22:24:24', NULL, '2026-02-27 22:21:59', '2026-02-27 22:24:24'),
(551, 'App\\Models\\User', 15, 'auth_token', 'd5cd7e6e4fd768fedf3f6f245f8f2235db46374eec3b2b4361d3993c05ee1b91', '[\"*\"]', '2026-03-05 08:46:04', NULL, '2026-02-28 00:03:46', '2026-03-05 08:46:04'),
(552, 'App\\Models\\User', 17, 'auth_token', '69e2fa55fef3b72d14c04c6030397493f85a4c24cfc277c823fd2d8faf9f298f', '[\"*\"]', '2026-02-28 00:35:07', NULL, '2026-02-28 00:29:26', '2026-02-28 00:35:07'),
(553, 'App\\Models\\User', 17, 'auth_token', '5552edcc414d07e719167d7a6f2516fcecebd8baa9b54e5de23b078098b1fd51', '[\"*\"]', '2026-02-28 00:38:11', NULL, '2026-02-28 00:36:17', '2026-02-28 00:38:11'),
(554, 'App\\Models\\User', 17, 'auth_token', '7376af56b5628409f21ca30ad9f9413439a08050866f267b7d07931e8637db24', '[\"*\"]', '2026-02-28 00:38:27', NULL, '2026-02-28 00:38:26', '2026-02-28 00:38:27'),
(555, 'App\\Models\\User', 17, 'auth_token', 'f7e7a6b3860c3612b9a624338aaaf4e10148e7188b0051b44bc8b2b251510c26', '[\"*\"]', '2026-02-28 00:39:21', NULL, '2026-02-28 00:38:54', '2026-02-28 00:39:21'),
(556, 'App\\Models\\User', 17, 'auth_token', '77ef66a866820efa4839438ccbec28ac784d2964b6435b95d1e0b032caff20ba', '[\"*\"]', '2026-02-28 00:39:58', NULL, '2026-02-28 00:39:39', '2026-02-28 00:39:58'),
(557, 'App\\Models\\User', 17, 'auth_token', '68365d481c4e4a12c79b7ada9640eeb35cec7d7d1eacbef247db64b755d8814d', '[\"*\"]', '2026-02-28 00:42:54', NULL, '2026-02-28 00:40:11', '2026-02-28 00:42:54'),
(558, 'App\\Models\\User', 15, 'auth_token', '7ddb2871847ce8263743e5b68e73b64b4002c7151aafd5e498755289f6ea45b6', '[\"*\"]', '2026-02-28 17:52:31', NULL, '2026-02-28 00:42:54', '2026-02-28 17:52:31'),
(559, 'App\\Models\\User', 17, 'auth_token', '7e1d2c52f39f84467067606583b62e345076508efa74649e551fb57185a4ca90', '[\"*\"]', '2026-02-28 00:43:34', NULL, '2026-02-28 00:43:15', '2026-02-28 00:43:34'),
(560, 'App\\Models\\User', 17, 'auth_token', '99aec146f9e1be953837da7b91e007ff25a5cce9dcfda3eeaf4672ec5902f7d0', '[\"*\"]', '2026-02-28 00:43:52', NULL, '2026-02-28 00:43:50', '2026-02-28 00:43:52'),
(561, 'App\\Models\\User', 17, 'auth_token', '6288022af0f7e6bf1cd6e4ccdef025ad1492f190ca8f9c668869706157611103', '[\"*\"]', '2026-02-28 00:47:30', NULL, '2026-02-28 00:47:23', '2026-02-28 00:47:30'),
(562, 'App\\Models\\User', 17, 'auth_token', 'fb904d7d670950af8a77211eb7ab050b2d469cb6d80d9bfb346d4e20d4d69c2a', '[\"*\"]', '2026-02-28 00:49:08', NULL, '2026-02-28 00:49:07', '2026-02-28 00:49:08'),
(563, 'App\\Models\\User', 17, 'auth_token', 'affa237686fc2f98987ae0c81560d3067e39b9027f28b9cea91415ad3407338d', '[\"*\"]', '2026-02-28 00:50:25', NULL, '2026-02-28 00:49:35', '2026-02-28 00:50:25'),
(564, 'App\\Models\\User', 17, 'auth_token', 'cf7339f47d1c5f8e8a0319f7c673315fc6aa1d58a752ba865bd1c14c5deeb29f', '[\"*\"]', '2026-02-28 00:50:32', NULL, '2026-02-28 00:50:30', '2026-02-28 00:50:32'),
(565, 'App\\Models\\User', 17, 'auth_token', 'c73b4164d10f9c8b7126ea67978df5ba61f50782938a0bae950a5347889ec78e', '[\"*\"]', '2026-02-28 08:38:05', NULL, '2026-02-28 00:55:02', '2026-02-28 08:38:05');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(566, 'App\\Models\\User', 71, 'auth_token', 'a89ea0c41e3ad1ddfdcac4721921efd3dc8216d82bc0a431e074f0c7cb4e46b8', '[\"*\"]', NULL, NULL, '2026-02-28 01:21:34', '2026-02-28 01:21:34'),
(567, 'App\\Models\\User', 17, 'auth_token', 'f88cacb7783c2c3e5436fb2e12ee6c7fba6b3a54986cf3191f83ca03091d98e4', '[\"*\"]', '2026-02-28 08:39:24', NULL, '2026-02-28 08:38:22', '2026-02-28 08:39:24'),
(568, 'App\\Models\\User', 17, 'auth_token', '5187a2d15ad341b5aa01831f2c4b6fb1c425624c3c2366f97425167689957f53', '[\"*\"]', '2026-02-28 17:48:40', NULL, '2026-02-28 17:46:46', '2026-02-28 17:48:40'),
(569, 'App\\Models\\User', 17, 'auth_token', '89d6003df95c7b4c75ebae127086ddb36073884a39d7905e8731daf12ce848aa', '[\"*\"]', '2026-02-28 17:57:29', NULL, '2026-02-28 17:57:28', '2026-02-28 17:57:29'),
(570, 'App\\Models\\User', 36, 'auth_token', 'fa48bdc3995de210e2f705c4020031fc0c2524091a4bcb47f7a4cc93ecc2d241', '[\"*\"]', '2026-02-28 18:16:11', NULL, '2026-02-28 18:15:43', '2026-02-28 18:16:11'),
(571, 'App\\Models\\User', 72, 'auth_token', '4cffa9848f86484940345212909cce8841d8bb87e0487c4ec5dc70ef37c59519', '[\"*\"]', NULL, NULL, '2026-02-28 18:38:57', '2026-02-28 18:38:57'),
(572, 'App\\Models\\User', 73, 'auth_token', '35938a1f1f429f9f95ed0b9c1d868297881a1f37015f86b8ae5890c507b82ba5', '[\"*\"]', NULL, NULL, '2026-02-28 23:50:39', '2026-02-28 23:50:39'),
(573, 'App\\Models\\User', 74, 'auth_token', '3b6558066274302804199fbb05b50356037c3bc76d94a2c16ccb4a1ccc57ed14', '[\"*\"]', NULL, NULL, '2026-03-01 00:21:30', '2026-03-01 00:21:30'),
(574, 'App\\Models\\User', 75, 'auth_token', 'b0f401fcbe70ba80fc50b8f0f3cf7efee81d353a55427ab911bdf43ca06bd065', '[\"*\"]', NULL, NULL, '2026-03-01 01:24:52', '2026-03-01 01:24:52'),
(575, 'App\\Models\\User', 76, 'auth_token', 'a30e8c0eaec8a6145e3931b5eb40b276aee37c5ae055a481057ec62ed17d8a37', '[\"*\"]', NULL, NULL, '2026-03-01 16:31:52', '2026-03-01 16:31:52'),
(576, 'App\\Models\\User', 15, 'auth_token', 'ce3f2adb93e41ab4787a5f46835c6aaa3cebcc04a31dcb935893a98b4651e3b1', '[\"*\"]', '2026-03-01 16:34:22', NULL, '2026-03-01 16:33:56', '2026-03-01 16:34:22'),
(577, 'App\\Models\\User', 77, 'auth_token', '160d425aa4cfca587228fdb9ba8e9f24552702b16eb684426abc017b767564d1', '[\"*\"]', NULL, NULL, '2026-03-01 17:02:25', '2026-03-01 17:02:25'),
(578, 'App\\Models\\User', 17, 'auth_token', 'cc7fbdb921632d8a2878021383564cd4680d734f0dc08af9a769d2a704b4b7da', '[\"*\"]', '2026-03-01 17:38:33', NULL, '2026-03-01 17:37:22', '2026-03-01 17:38:33'),
(579, 'App\\Models\\User', 15, 'auth_token', 'dc16cb4520d4cbfca50a4832b6dabf8945a67be6a7711f92ff89055c311fed1d', '[\"*\"]', '2026-03-01 18:04:08', NULL, '2026-03-01 18:02:53', '2026-03-01 18:04:08'),
(580, 'App\\Models\\User', 15, 'auth_token', '73d87efd2461de195ac2977e841ee3f3baa3345f8181240245411fb2eca7b3b9', '[\"*\"]', '2026-03-01 18:18:43', NULL, '2026-03-01 18:04:25', '2026-03-01 18:18:43'),
(581, 'App\\Models\\User', 78, 'auth_token', '5dfd0f90c991787a6ec26a9931dd2aa06666f53a79f96bc7e77c42682846e0a6', '[\"*\"]', NULL, NULL, '2026-03-01 18:17:27', '2026-03-01 18:17:27'),
(582, 'App\\Models\\User', 15, 'auth_token', '9b1b01587c6705eab22e5155ad79b15ae006060882d2399205a2756b67ae2317', '[\"*\"]', NULL, NULL, '2026-03-01 18:19:30', '2026-03-01 18:19:30'),
(583, 'App\\Models\\User', 15, 'auth_token', 'cc252885abedcb92fd697c74a8b82eba876521c8c7231d0fbf5756d8761927d8', '[\"*\"]', NULL, NULL, '2026-03-01 18:19:35', '2026-03-01 18:19:35'),
(584, 'App\\Models\\User', 15, 'auth_token', '58365dce45980296e0c32e87cdead8646dd737ced80682d4cc3b0e980f790afb', '[\"*\"]', '2026-03-01 18:40:04', NULL, '2026-03-01 18:19:35', '2026-03-01 18:40:04'),
(585, 'App\\Models\\User', 78, 'auth_token', 'd1b1b9f17d4e016aeb9808b996313490a0d0612fa5c9c6261094f625179288c1', '[\"*\"]', '2026-03-01 18:23:21', NULL, '2026-03-01 18:23:18', '2026-03-01 18:23:21'),
(586, 'App\\Models\\User', 17, 'auth_token', 'd09d8d530ec67de06eb9eecfa718bc06263b4b5ab7a98102d712cddf57224bb8', '[\"*\"]', '2026-03-01 22:57:25', NULL, '2026-03-01 22:57:24', '2026-03-01 22:57:25'),
(587, 'App\\Models\\User', 79, 'auth_token', 'a5c998618bafc7cf5590afa890c807744c4a88202b65a34b56257b83e25ec72c', '[\"*\"]', NULL, NULL, '2026-03-02 02:03:32', '2026-03-02 02:03:32'),
(588, 'App\\Models\\User', 15, 'auth_token', 'e2edb3f97a93e13b7b34224af23cc3fd14243a25befd7e250c1561ad01fc7f43', '[\"*\"]', '2026-03-02 15:48:10', NULL, '2026-03-02 11:12:33', '2026-03-02 15:48:10'),
(589, 'App\\Models\\User', 15, 'auth_token', '5021bb74488295fe61637780c2df61c491f3f913dc21e02efc61ac597c9e4257', '[\"*\"]', '2026-03-02 12:44:04', NULL, '2026-03-02 12:34:58', '2026-03-02 12:44:04'),
(590, 'App\\Models\\User', 15, 'auth_token', 'ff0403665b406b8c10f9205f463dbee6daa5414ea3bc87f5731c69a44006aa2c', '[\"*\"]', '2026-03-02 15:04:41', NULL, '2026-03-02 13:21:15', '2026-03-02 15:04:41'),
(591, 'App\\Models\\User', 17, 'auth_token', '3191dc583d043ed4929ec308a0d1616683c340357dab361f91310aa7105973c2', '[\"*\"]', '2026-03-02 14:07:09', NULL, '2026-03-02 14:06:29', '2026-03-02 14:07:09'),
(592, 'App\\Models\\User', 33, 'auth_token', '25a13a8b134824657ee2808335169975833a9554aa6976a797517c117a0bc77b', '[\"*\"]', '2026-03-02 14:45:13', NULL, '2026-03-02 14:43:59', '2026-03-02 14:45:13'),
(593, 'App\\Models\\User', 15, 'auth_token', 'b1f3ef6b558c131b5ca9707b831876f3da68e834b9bf14edefcde5e905cf4780', '[\"*\"]', '2026-03-02 15:08:34', NULL, '2026-03-02 15:07:39', '2026-03-02 15:08:34'),
(594, 'App\\Models\\User', 15, 'auth_token', '84cbc6d787ae4a5f97b711c9289fdd28ad86c294cb02b17c34d0f2117c92db65', '[\"*\"]', '2026-03-02 15:18:20', NULL, '2026-03-02 15:18:09', '2026-03-02 15:18:20'),
(595, 'App\\Models\\User', 33, 'auth_token', '3443d9a91bea6d1cb718f21e0c0c4adc67bab7fcae0d079d8a350559eda4d534', '[\"*\"]', '2026-03-02 15:41:43', NULL, '2026-03-02 15:39:10', '2026-03-02 15:41:43'),
(596, 'App\\Models\\User', 33, 'auth_token', 'e5fc109fe12f0bcf6490e373df9650b27e661b3b1814598d7961b76bffced18c', '[\"*\"]', '2026-03-02 15:45:03', NULL, '2026-03-02 15:44:33', '2026-03-02 15:45:03'),
(597, 'App\\Models\\User', 15, 'auth_token', '120c653a95d53efb868abd33971324a56aad1434c84ec73fe46e664c96aacdd8', '[\"*\"]', '2026-03-02 15:56:55', NULL, '2026-03-02 15:45:57', '2026-03-02 15:56:55'),
(598, 'App\\Models\\User', 33, 'auth_token', '53693491c725dd74925b81fb69542503d9bedc20034583e7aae61a25b49c85ea', '[\"*\"]', '2026-03-02 15:52:44', NULL, '2026-03-02 15:52:43', '2026-03-02 15:52:44'),
(599, 'App\\Models\\User', 33, 'auth_token', 'c63d7db250a4c624c9030f2f33771023eced38032f599b2d3df957750eaa032d', '[\"*\"]', '2026-03-02 15:54:16', NULL, '2026-03-02 15:54:15', '2026-03-02 15:54:16'),
(600, 'App\\Models\\User', 15, 'auth_token', '34c2c17440208950fa74784130f160d5d053dbb68eaec4e7b222fcc4915ba9e4', '[\"*\"]', '2026-03-02 19:58:52', NULL, '2026-03-02 15:56:52', '2026-03-02 19:58:52'),
(601, 'App\\Models\\User', 33, 'auth_token', '8e195d9fc7a7693dc7824d27f9e2e9aa63e0917f03938d2d7f9f7ca224fb42e2', '[\"*\"]', '2026-03-02 15:58:23', NULL, '2026-03-02 15:58:22', '2026-03-02 15:58:23'),
(602, 'App\\Models\\User', 15, 'auth_token', 'f4cb4ef2b3e467d3bb337e40532ea8376522c267e2a9e41857b05996db79a266', '[\"*\"]', '2026-03-02 19:58:53', NULL, '2026-03-02 15:58:43', '2026-03-02 19:58:53'),
(603, 'App\\Models\\User', 17, 'auth_token', '454d62393d52704642bf96b3f071603c932b937b2561e79d891af9b5b19b2514', '[\"*\"]', '2026-03-02 16:35:57', NULL, '2026-03-02 16:35:56', '2026-03-02 16:35:57'),
(604, 'App\\Models\\User', 15, 'auth_token', 'ec48499d8b1cb1d727cf63323bd66fc758785e8d81738ba75814ab4a4783e9da', '[\"*\"]', '2026-03-02 19:58:55', NULL, '2026-03-02 19:58:54', '2026-03-02 19:58:55'),
(605, 'App\\Models\\User', 15, 'auth_token', '32db868e5d1dff97b6a9ad45cd9ce55efeb86d7b6a761e13a5b61352398dddad', '[\"*\"]', '2026-03-02 19:59:36', NULL, '2026-03-02 19:59:35', '2026-03-02 19:59:36'),
(606, 'App\\Models\\User', 15, 'auth_token', 'bc6d3555fef94da1f588a3d3b5d4267c967db797ee6b901d5c5751f0d7cb7807', '[\"*\"]', '2026-03-02 20:00:09', NULL, '2026-03-02 19:59:59', '2026-03-02 20:00:09'),
(607, 'App\\Models\\User', 15, 'auth_token', 'ba03a2cd59317b00bedcaa54b2d9f4737302fb5217d96e404ac6a88a3e731d37', '[\"*\"]', '2026-03-02 20:01:05', NULL, '2026-03-02 20:00:32', '2026-03-02 20:01:05'),
(608, 'App\\Models\\User', 15, 'auth_token', '7587812d409f9f905356c93b53ff9ae2fa72f0fe71ef1d5f93eaf40c0de1be4f', '[\"*\"]', '2026-03-03 09:27:49', NULL, '2026-03-02 20:54:39', '2026-03-03 09:27:49'),
(609, 'App\\Models\\User', 80, 'auth_token', '27280e6c85feaf30d9186f2c45a643ada3c13f4a2db52257a6f1fb103312372b', '[\"*\"]', NULL, NULL, '2026-03-02 21:47:49', '2026-03-02 21:47:49'),
(610, 'App\\Models\\User', 17, 'auth_token', 'bd66bb26bb6360c5fb71b58c83860501ccecd51cd3be2ac142e98869cd6d7a93', '[\"*\"]', '2026-03-02 22:38:35', NULL, '2026-03-02 22:37:35', '2026-03-02 22:38:35'),
(611, 'App\\Models\\User', 80, 'auth_token', '94e89692948b0043c3b516ce6456cf3b23f22fb4dca02fcb49f387397db63040', '[\"*\"]', '2026-03-02 22:39:55', NULL, '2026-03-02 22:39:31', '2026-03-02 22:39:55'),
(612, 'App\\Models\\User', 78, 'auth_token', 'e343c8f281a03ab77726d93989ccc1382f12e29e20056b3b38a34ff86f1ad218', '[\"*\"]', '2026-03-03 00:08:08', NULL, '2026-03-03 00:08:05', '2026-03-03 00:08:08'),
(613, 'App\\Models\\User', 53, 'auth_token', '2da800c83a3f89c4e220448c28222a13fa4282d271d18e5d054ee925e04065f8', '[\"*\"]', '2026-03-03 09:36:24', NULL, '2026-03-03 09:36:22', '2026-03-03 09:36:24'),
(614, 'App\\Models\\User', 53, 'auth_token', '52a92809db60762716f240d3940c26a1513358a6c79c9cd5d5a3321cf64b6c1e', '[\"*\"]', '2026-03-03 09:37:14', NULL, '2026-03-03 09:36:43', '2026-03-03 09:37:14'),
(615, 'App\\Models\\User', 15, 'auth_token', '8631182cfebae526f71d3a88f9d3961b81d4bb61e2591b660353e0719a74d284', '[\"*\"]', '2026-03-03 13:48:03', NULL, '2026-03-03 11:23:45', '2026-03-03 13:48:03'),
(616, 'App\\Models\\User', 81, 'auth_token', '485c3a598f0ca684dc8bf7c0893ce2f665515f3e20dab52136de598f6f99d258', '[\"*\"]', NULL, NULL, '2026-03-03 12:13:31', '2026-03-03 12:13:31'),
(617, 'App\\Models\\User', 17, 'auth_token', '935e769352e61bb7a4932f5531aa5dea8a8d6f0e15a57692b9c6f89dfff34bca', '[\"*\"]', '2026-03-03 12:16:28', NULL, '2026-03-03 12:16:14', '2026-03-03 12:16:28'),
(618, 'App\\Models\\User', 81, 'auth_token', '3a838621e36cebf4a14159ead52aa76b64dc883630bbf4ed0b1c68fa92f3b6f7', '[\"*\"]', '2026-03-03 12:24:53', NULL, '2026-03-03 12:20:22', '2026-03-03 12:24:53'),
(619, 'App\\Models\\User', 17, 'auth_token', '6ee84dfa8e4636c1a5cdd20b438bf55d968dd32ad7c24e2391ffab80a22746d7', '[\"*\"]', '2026-03-03 13:39:10', NULL, '2026-03-03 13:39:09', '2026-03-03 13:39:10'),
(620, 'App\\Models\\User', 17, 'auth_token', 'bb8c66d15f048dd752b646a580793a704f7efd9af0c4879e89e40d81f695a2c3', '[\"*\"]', '2026-03-03 13:49:37', NULL, '2026-03-03 13:41:32', '2026-03-03 13:49:37'),
(621, 'App\\Models\\User', 17, 'auth_token', '7dc0ae06c77143d1a274bfca6bffa52a68eb82426673efa864f2720e2f32e85b', '[\"*\"]', '2026-03-03 13:50:23', NULL, '2026-03-03 13:49:41', '2026-03-03 13:50:23'),
(622, 'App\\Models\\User', 15, 'auth_token', '6fee93bf3df7e642c81c3c7029677207246a268baaeec8d1afb4cccaf8c65a0a', '[\"*\"]', '2026-03-04 15:18:56', NULL, '2026-03-03 15:50:18', '2026-03-04 15:18:56'),
(623, 'App\\Models\\User', 82, 'auth_token', 'a3cd3c5fd4eab984a954e03c39dd7fdb78ca2d70c0752572cdcbf74b37e17b4a', '[\"*\"]', NULL, NULL, '2026-03-03 20:58:34', '2026-03-03 20:58:34'),
(624, 'App\\Models\\User', 83, 'auth_token', '7249a2224329327f7063411ce2660a84b4bdd777370b0bcaa68aa376574358df', '[\"*\"]', NULL, NULL, '2026-03-03 22:08:37', '2026-03-03 22:08:37'),
(625, 'App\\Models\\User', 45, 'auth_token', '05c7f81207e12c9f99c80c293d594728f406134df3190a2f339d7b369bf2a33f', '[\"*\"]', '2026-03-03 22:11:36', NULL, '2026-03-03 22:11:32', '2026-03-03 22:11:36'),
(626, 'App\\Models\\User', 45, 'auth_token', '69699732724276ba344934013f75990ae2248c145d32e99f441bccf1473cc966', '[\"*\"]', '2026-03-03 22:12:52', NULL, '2026-03-03 22:12:50', '2026-03-03 22:12:52'),
(627, 'App\\Models\\User', 84, 'auth_token', '92e74d9866925ac5862d338f198349dd4bdf6978c296c1c1417f699eff5b00a7', '[\"*\"]', NULL, NULL, '2026-03-03 22:19:15', '2026-03-03 22:19:15'),
(628, 'App\\Models\\User', 85, 'auth_token', '7ee20efd12f5f9cb5bbe04b7addf1fc4ff5c2827e7b9ff284bf13187ef697005', '[\"*\"]', NULL, NULL, '2026-03-03 22:38:39', '2026-03-03 22:38:39'),
(629, 'App\\Models\\User', 86, 'auth_token', '25171f7030f6292e0bdb00f890450c482937ccf0dbb8953533f1066ec3a68740', '[\"*\"]', NULL, NULL, '2026-03-03 23:34:35', '2026-03-03 23:34:35'),
(630, 'App\\Models\\User', 87, 'auth_token', 'fb3f3067b3b8a90fe2b2d3017693c5ecd9f374061cd3d193dec5b0b86dac8c01', '[\"*\"]', NULL, NULL, '2026-03-04 01:04:02', '2026-03-04 01:04:02'),
(631, 'App\\Models\\User', 17, 'auth_token', '3566789a23866eb05194231ee4f3cd8194cd923c2d242e014db9b2d144570b43', '[\"*\"]', NULL, NULL, '2026-03-04 01:25:14', '2026-03-04 01:25:14'),
(632, 'App\\Models\\User', 17, 'auth_token', 'a27768849a45799638109ff8cb8fafe097ea4490d159503341b6a5fc810bb157', '[\"*\"]', '2026-03-04 01:30:01', NULL, '2026-03-04 01:25:19', '2026-03-04 01:30:01'),
(633, 'App\\Models\\User', 17, 'auth_token', '3691419c28807461dd4fa5d62fde57acf3c1e61cd13cabb191fb9e0d87cdbf74', '[\"*\"]', '2026-03-04 11:20:48', NULL, '2026-03-04 11:20:21', '2026-03-04 11:20:48'),
(634, 'App\\Models\\User', 15, 'auth_token', '511300d3b5213c23e7188c1d651220a77a8a5e470dcb46b4a12f8af943a1a0cc', '[\"*\"]', '2026-03-04 14:12:24', NULL, '2026-03-04 14:12:11', '2026-03-04 14:12:24'),
(635, 'App\\Models\\User', 15, 'auth_token', '5314d6991dcf627918c3b6329d49d2ce57d9e3ae272865ee555d56ca084b9591', '[\"*\"]', '2026-03-04 14:12:49', NULL, '2026-03-04 14:12:22', '2026-03-04 14:12:49'),
(636, 'App\\Models\\User', 15, 'auth_token', '3f1c750d8a31c66e775875814e5e226b330cc89fc846646573e6ce5739c4319a', '[\"*\"]', '2026-03-04 14:13:22', NULL, '2026-03-04 14:13:16', '2026-03-04 14:13:22'),
(637, 'App\\Models\\User', 88, 'auth_token', '699676df605680fe488ee43d931865e399a50121f43e0efc67ffaecec07e892d', '[\"*\"]', NULL, NULL, '2026-03-04 14:27:17', '2026-03-04 14:27:17'),
(638, 'App\\Models\\User', 17, 'auth_token', '29ebdcf1e6459b71dafcf5027cb5133e51cdf8b89814509467407c687fb1849b', '[\"*\"]', '2026-03-04 14:52:58', NULL, '2026-03-04 14:51:14', '2026-03-04 14:52:58'),
(639, 'App\\Models\\User', 17, 'auth_token', 'cc68126f6e5c5712885881a52b006724db63b09b2809b963762cef8152c432b5', '[\"*\"]', '2026-03-04 15:34:03', NULL, '2026-03-04 15:34:02', '2026-03-04 15:34:03'),
(640, 'App\\Models\\User', 89, 'auth_token', '6eff0e59bdb052f04ef523b1a18c848e6ae8d122c13d9b464b997e6b9f8e6df6', '[\"*\"]', NULL, NULL, '2026-03-04 15:40:17', '2026-03-04 15:40:17'),
(642, 'App\\Models\\User', 90, 'auth_token', 'c82c4c2fd278de54b6a455f4ab6b013305b619c24ff268dd91d77d68729b223f', '[\"*\"]', NULL, NULL, '2026-03-04 18:00:11', '2026-03-04 18:00:11'),
(643, 'App\\Models\\User', 15, 'auth_token', 'd62957f35bae2ed1f1c27300f8254f0d4cf62509c5d33c0f32e581eb6ec0f80f', '[\"*\"]', '2026-03-05 10:31:02', NULL, '2026-03-05 10:30:32', '2026-03-05 10:31:02'),
(644, 'App\\Models\\User', 15, 'auth_token', '8182308c33a8e344df0dc204da2609d03cfe05beee2831af80b74ce48822a9c0', '[\"*\"]', '2026-03-05 10:32:03', NULL, '2026-03-05 10:31:32', '2026-03-05 10:32:03');

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
(40, '255758833304', 'NTULI KAPOLOGWE', 'direct', 'Bwana Yesu asifiwe NTULI KAPOLOGWE, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0008', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-01-18 14:14:17', '2026-01-18 14:14:17'),
(41, '255712104508', 'Tumaini  Peter Kaaya', 'individual', 'Yesu asifiwe hii ni majaribio tu ya sms kutoka KanisaSoft, Kama umeipokea tuma kwenye group tuone', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-19 12:17:22', '2026-02-19 12:17:22'),
(42, '255712104508', 'Tumaini  Peter Kaaya', 'individual', 'Hili ni jaribio la pili kutoka KanisaSoft, je umeipata? Tuma kwenye group screenshot', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-19 12:19:30', '2026-02-19 12:19:30'),
(43, '255658698146', 'Neema Mustapha Kiluwasha', 'direct', 'Bwana Yesu asifiwe Neema Mustapha Kiluwasha, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0009', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-23 17:39:10', '2026-02-23 17:39:10'),
(44, '255714991925', 'Natalia Beza', 'direct', 'Bwana Yesu asifiwe Natalia Beza, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0010', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-23 17:39:23', '2026-02-23 17:39:23'),
(45, '255657300333', 'Erick Andrea', 'direct', 'Bwana Yesu asifiwe Erick Andrea, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0011', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 00:52:21', '2026-02-24 00:52:21'),
(46, '255754244794', 'Benedicto Mugongo', 'direct', 'Bwana Yesu asifiwe Benedicto Mugongo, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0012', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 09:15:11', '2026-02-24 09:15:11'),
(47, '255737774790', 'AHUNGU MODKY', 'direct', 'Bwana Yesu asifiwe AHUNGU MODKY, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0013', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 09:16:15', '2026-02-24 09:16:15'),
(48, '255712658038', 'HERIEL GABRIEL', 'direct', 'Bwana Yesu asifiwe HERIEL GABRIEL, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0014', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 09:16:34', '2026-02-24 09:16:34'),
(49, '255655323199', 'THEOPHILDA CHRISTOPHER', 'direct', 'Bwana Yesu asifiwe THEOPHILDA CHRISTOPHER, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0015', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 09:16:45', '2026-02-24 09:16:45'),
(50, '255716654579', 'Jacob Sanke Nyoni', 'direct', 'Bwana Yesu asifiwe Jacob Sanke Nyoni, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0016', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 09:17:07', '2026-02-24 09:17:07'),
(51, '255762748397', 'Hannah Kimicha Rwandalla', 'direct', 'Bwana Yesu asifiwe Hannah Kimicha Rwandalla, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0017', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 09:17:18', '2026-02-24 09:17:18'),
(52, '255754897675', 'Amos Samwel Ntandu', 'direct', 'Bwana Yesu asifiwe Amos Samwel Ntandu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0018', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 09:17:26', '2026-02-24 09:17:26'),
(53, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 11:02:26', '2026-02-24 11:02:26'),
(54, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 11:25:55', '2026-02-24 11:25:55'),
(55, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 12:13:20', '2026-02-24 12:13:20'),
(56, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 12:19:30', '2026-02-24 12:19:30'),
(57, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 12:19:34', '2026-02-24 12:19:34'),
(58, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 12:26:08', '2026-02-24 12:26:08'),
(59, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 12:26:32', '2026-02-24 12:26:32'),
(60, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 12:27:04', '2026-02-24 12:27:04'),
(61, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 13:07:46', '2026-02-24 13:07:46'),
(62, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 13:19:06', '2026-02-24 13:19:06'),
(63, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 13:23:06', '2026-02-24 13:23:06'),
(64, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 13:35:22', '2026-02-24 13:35:22'),
(65, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 13:35:30', '2026-02-24 13:35:30'),
(66, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 14:00:38', '2026-02-24 14:00:38'),
(67, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 14:01:40', '2026-02-24 14:01:40'),
(68, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 14:02:38', '2026-02-24 14:02:38'),
(69, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 14:03:40', '2026-02-24 14:03:40'),
(70, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Failed: Invalid Password.\r\n', '\"Invalid Password.\\r\\n\"', '2026-02-24 14:16:48', '2026-02-24 14:16:48'),
(71, '255767983236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1522188718\\\",\\\"number\\\":\\\"255767983236\\\",\\\"str_response\\\":\\\"1522188718,255767983236,Send Successful\\\"}]\\r\\n\"', '2026-02-24 14:37:03', '2026-02-24 14:37:03'),
(72, '255754778376', 'Elicia Sekishaku Kisoma', 'direct', 'Bwana Yesu asifiwe Elicia Sekishaku Kisoma, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0019', 'Sent', '\"[{\\\"msg_id\\\":\\\"1522199484\\\",\\\"number\\\":\\\"255754778376\\\",\\\"str_response\\\":\\\"1522199484,255754778376,Send Successful\\\"}]\\r\\n\"', '2026-02-24 14:52:48', '2026-02-24 14:52:48'),
(73, '255742490455', 'Adriano Nashoni Kibhoge', 'direct', 'Bwana Yesu asifiwe Adriano Nashoni Kibhoge, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0020', 'Sent', '\"[{\\\"msg_id\\\":\\\"1522204252\\\",\\\"number\\\":\\\"255742490455\\\",\\\"str_response\\\":\\\"1522204252,255742490455,Send Successful\\\"}]\\r\\n\"', '2026-02-24 14:55:50', '2026-02-24 14:55:50'),
(74, '255755146527', 'Aman Mdewa Nthangu', 'direct', 'Bwana Yesu asifiwe Aman Mdewa Nthangu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0021', 'Sent', '\"[{\\\"msg_id\\\":\\\"1522204387\\\",\\\"number\\\":\\\"255755146527\\\",\\\"str_response\\\":\\\"1522204387,255755146527,Send Successful\\\"}]\\r\\n\"', '2026-02-24 14:55:59', '2026-02-24 14:55:59'),
(75, '255755114343', 'ALFAYO NASHONI KIBOGE', 'direct', 'Bwana Yesu asifiwe ALFAYO NASHONI KIBOGE, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0022', 'Sent', '\"[{\\\"msg_id\\\":\\\"1522205174\\\",\\\"number\\\":\\\"255755114343\\\",\\\"str_response\\\":\\\"1522205174,255755114343,Send Successful\\\"}]\\r\\n\"', '2026-02-24 14:57:15', '2026-02-24 14:57:15'),
(76, '255677149158', 'Elizabeth Christopher Migeto', 'direct', 'Bwana Yesu asifiwe Elizabeth Christopher Migeto, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0023', 'Sent', '\"[{\\\"msg_id\\\":\\\"1522206383\\\",\\\"number\\\":\\\"255677149158\\\",\\\"str_response\\\":\\\"1522206383,255677149158,Send Successful\\\"}]\\r\\n\"', '2026-02-24 14:58:38', '2026-02-24 14:58:38'),
(77, '255714842713', 'Neema Kazare', 'direct', 'Bwana Yesu asifiwe Neema Kazare, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0024', 'Sent', '\"[{\\\"msg_id\\\":\\\"1522206964\\\",\\\"number\\\":\\\"255714842713\\\",\\\"str_response\\\":\\\"1522206964,255714842713,Send Successful\\\"}]\\r\\n\"', '2026-02-24 14:59:35', '2026-02-24 14:59:35'),
(78, '255616148236', 'shalemu', 'direct', 'This is a test message shalemu.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1522219569\\\",\\\"number\\\":\\\"255616148236\\\",\\\"str_response\\\":\\\"1522219569,255616148236,Send Successful\\\"}]\\r\\n\"', '2026-02-24 15:08:09', '2026-02-24 15:08:09'),
(79, '255712104508', 'Tumaini  Peter Kaaya', 'individual', 'Hii hapa test kwa Kaaya, Imefika?', 'Sent', '\"[{\\\"msg_id\\\":\\\"1522537452\\\",\\\"number\\\":\\\"255712104508\\\",\\\"str_response\\\":\\\"1522537452,255712104508,Send Successful\\\"}]\\r\\n\"', '2026-02-24 16:12:48', '2026-02-24 16:12:48'),
(80, '255758295657', 'Veronica chavala', 'direct', 'Bwana Yesu asifiwe Veronica chavala, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0025', 'Sent', '\"[{\\\"msg_id\\\":\\\"1523007568\\\",\\\"number\\\":\\\"255758295657\\\",\\\"str_response\\\":\\\"1523007568,255758295657,Send Successful\\\"}]\\r\\n\"', '2026-02-24 23:45:40', '2026-02-24 23:45:40'),
(81, '255758295657', 'Veronica chavala', 'direct', 'Bwana Yesu asifiwe Veronica chavala, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0025', 'Sent', '\"[{\\\"msg_id\\\":\\\"1523007917\\\",\\\"number\\\":\\\"255758295657\\\",\\\"str_response\\\":\\\"1523007917,255758295657,Send Successful\\\"}]\\r\\n\"', '2026-02-24 23:45:41', '2026-02-24 23:45:41'),
(82, '255759076332', 'Denis Cleophace', 'direct', 'Bwana Yesu asifiwe Denis Cleophace, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0026', 'Sent', '\"[{\\\"msg_id\\\":\\\"1523022790\\\",\\\"number\\\":\\\"255759076332\\\",\\\"str_response\\\":\\\"1523022790,255759076332,Send Successful\\\"}]\\r\\n\"', '2026-02-25 00:03:40', '2026-02-25 00:03:40'),
(83, '255616148236', 'shalemu', 'direct', 'This is a test message shalemu 25/02', 'Sent', '\"[{\\\"msg_id\\\":\\\"1523779096\\\",\\\"number\\\":\\\"255616148236\\\",\\\"str_response\\\":\\\"1523779096,255616148236,Send Successful\\\"}]\\r\\n\"', '2026-02-25 11:02:23', '2026-02-25 11:02:23'),
(84, '255616148236', 'shalemu', 'direct', 'This is a test message shalemu 25/02', 'Sent', '\"[{\\\"msg_id\\\":\\\"1523808719\\\",\\\"number\\\":\\\"255616148236\\\",\\\"str_response\\\":\\\"1523808719,255616148236,Send Successful\\\"}]\\r\\n\"', '2026-02-25 11:05:48', '2026-02-25 11:05:48'),
(85, '255744141430', 'shalemu', 'direct', 'This is a test message for kanisasoft', 'Sent', '\"[{\\\"msg_id\\\":\\\"1523836581\\\",\\\"number\\\":\\\"255744141430\\\",\\\"str_response\\\":\\\"1523836581,255744141430,Send Successful\\\"}]\\r\\n\"', '2026-02-25 11:08:32', '2026-02-25 11:08:32'),
(86, '255767983236', 'SHADRACK LEONARD', 'direct', 'Bwana Yesu asifiwe SHADRACK LEONARD, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0027', 'Sent', '\"[{\\\"msg_id\\\":\\\"1523864548\\\",\\\"number\\\":\\\"255767983236\\\",\\\"str_response\\\":\\\"1523864548,255767983236,Send Successful\\\"}]\\r\\n\"', '2026-02-25 11:11:49', '2026-02-25 11:11:49'),
(87, '255690255885', 'LUTUFYO FRANCIS', 'direct', 'Bwana Yesu asifiwe LUTUFYO FRANCIS, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0027', 'Sent', '\"[{\\\"msg_id\\\":\\\"1523868419\\\",\\\"number\\\":\\\"255690255885\\\",\\\"str_response\\\":\\\"1523868419,255690255885,Send Successful\\\"}]\\r\\n\"', '2026-02-25 11:19:08', '2026-02-25 11:19:08'),
(88, '255744932734', 'Edith Beza', 'direct', 'Bwana Yesu asifiwe Edith Beza, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0027', 'Sent', '\"[{\\\"msg_id\\\":\\\"1523872300\\\",\\\"number\\\":\\\"255744932734\\\",\\\"str_response\\\":\\\"1523872300,255744932734,Send Successful\\\"}]\\r\\n\"', '2026-02-25 11:21:41', '2026-02-25 11:21:41'),
(89, '255764648884', 'BEATRICE ELIA MHANA', 'direct', 'Bwana Yesu asifiwe BEATRICE ELIA MHANA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0028', 'Sent', '\"[{\\\"msg_id\\\":\\\"1523876227\\\",\\\"number\\\":\\\"255764648884\\\",\\\"str_response\\\":\\\"1523876227,255764648884,Send Successful\\\"}]\\r\\n\"', '2026-02-25 11:29:10', '2026-02-25 11:29:10'),
(90, '255785480389', 'Perecy beza', 'direct', 'Bwana Yesu asifiwe Perecy beza, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0002', 'Sent', '\"[{\\\"msg_id\\\":\\\"1523905543\\\",\\\"number\\\":\\\"255785480389\\\",\\\"str_response\\\":\\\"1523905543,255785480389,Send Successful\\\"}]\\r\\n\"', '2026-02-25 12:09:34', '2026-02-25 12:09:34'),
(91, '255762285686', 'GLORIA ANDREW MBWAMBO', 'direct', 'Bwana Yesu asifiwe GLORIA ANDREW MBWAMBO, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0029', 'Sent', '\"[{\\\"msg_id\\\":\\\"1523923808\\\",\\\"number\\\":\\\"255762285686\\\",\\\"str_response\\\":\\\"1523923808,255762285686,Send Successful\\\"}]\\r\\n\"', '2026-02-25 12:34:04', '2026-02-25 12:34:04'),
(92, '255712104508', 'Tumaini  Peter Kaaya', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104551\\\",\\\"number\\\":\\\"255712104508\\\",\\\"str_response\\\":\\\"1524104551,255712104508,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:07', '2026-02-25 14:31:07'),
(93, '255784824624', 'Oscar Batista Kindole', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104558\\\",\\\"number\\\":\\\"255784824624\\\",\\\"str_response\\\":\\\"1524104558,255784824624,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:07', '2026-02-25 14:31:07'),
(94, '255787001007', 'Isaya Raphael Mwanyamba', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104565\\\",\\\"number\\\":\\\"255787001007\\\",\\\"str_response\\\":\\\"1524104565,255787001007,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:07', '2026-02-25 14:31:07'),
(95, '255754544438', 'Reuben Bulugu', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104576\\\",\\\"number\\\":\\\"255754544438\\\",\\\"str_response\\\":\\\"1524104576,255754544438,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:08', '2026-02-25 14:31:08'),
(96, '255788677472', 'Dr. Suleiman Mathew IKOMBA', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104583\\\",\\\"number\\\":\\\"255788677472\\\",\\\"str_response\\\":\\\"1524104583,255788677472,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:08', '2026-02-25 14:31:08'),
(97, '255699650632', 'Abigail Suleiman Mathew', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104592\\\",\\\"number\\\":\\\"255699650632\\\",\\\"str_response\\\":\\\"1524104592,255699650632,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:08', '2026-02-25 14:31:08'),
(98, '255758047674', 'DAMIAN GERVAS NDABATINYA', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104600\\\",\\\"number\\\":\\\"255758047674\\\",\\\"str_response\\\":\\\"1524104600,255758047674,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:09', '2026-02-25 14:31:09'),
(99, '255719800813', 'Julius Kindole', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104609\\\",\\\"number\\\":\\\"255719800813\\\",\\\"str_response\\\":\\\"1524104609,255719800813,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:09', '2026-02-25 14:31:09'),
(100, '255768920734', 'Sospeter Bathoha', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104619\\\",\\\"number\\\":\\\"255768920734\\\",\\\"str_response\\\":\\\"1524104619,255768920734,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:09', '2026-02-25 14:31:09'),
(101, '255758833304', 'NTULI KAPOLOGWE', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104631\\\",\\\"number\\\":\\\"255758833304\\\",\\\"str_response\\\":\\\"1524104631,255758833304,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:10', '2026-02-25 14:31:10'),
(102, '255658698146', 'Neema Mustapha Kiluwasha', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104641\\\",\\\"number\\\":\\\"255658698146\\\",\\\"str_response\\\":\\\"1524104641,255658698146,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:10', '2026-02-25 14:31:10'),
(103, '255714991925', 'Natalia Beza', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104646\\\",\\\"number\\\":\\\"255714991925\\\",\\\"str_response\\\":\\\"1524104646,255714991925,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:11', '2026-02-25 14:31:11'),
(104, '255655323199', 'THEOPHILDA CHRISTOPHER', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104650\\\",\\\"number\\\":\\\"255655323199\\\",\\\"str_response\\\":\\\"1524104650,255655323199,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:11', '2026-02-25 14:31:11'),
(105, '255716654579', 'Jacob Sanke Nyoni', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104657\\\",\\\"number\\\":\\\"255716654579\\\",\\\"str_response\\\":\\\"1524104657,255716654579,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:11', '2026-02-25 14:31:11'),
(106, '255712658038', 'HERIEL GABRIEL', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104659\\\",\\\"number\\\":\\\"255712658038\\\",\\\"str_response\\\":\\\"1524104659,255712658038,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:12', '2026-02-25 14:31:12'),
(107, '255737774790', 'AHUNGU MODKY', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104663\\\",\\\"number\\\":\\\"255737774790\\\",\\\"str_response\\\":\\\"1524104663,255737774790,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:12', '2026-02-25 14:31:12'),
(108, '255754897675', 'Amos Samwel Ntandu', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104666\\\",\\\"number\\\":\\\"255754897675\\\",\\\"str_response\\\":\\\"1524104666,255754897675,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:12', '2026-02-25 14:31:12'),
(109, '255754778376', 'Elicia Sekishaku Kisoma', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104670\\\",\\\"number\\\":\\\"255754778376\\\",\\\"str_response\\\":\\\"1524104670,255754778376,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:13', '2026-02-25 14:31:13'),
(110, '255657300333', 'Erick Andrea', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104673\\\",\\\"number\\\":\\\"255657300333\\\",\\\"str_response\\\":\\\"1524104673,255657300333,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:13', '2026-02-25 14:31:13'),
(111, '255762748397', 'Hannah Kimicha Rwandalla', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104676\\\",\\\"number\\\":\\\"255762748397\\\",\\\"str_response\\\":\\\"1524104676,255762748397,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:14', '2026-02-25 14:31:14'),
(112, '255754244794', 'Benedicto Mugongo', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104679\\\",\\\"number\\\":\\\"255754244794\\\",\\\"str_response\\\":\\\"1524104679,255754244794,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:14', '2026-02-25 14:31:14'),
(113, '255742490455', 'Adriano Nashoni Kibhoge', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104680\\\",\\\"number\\\":\\\"255742490455\\\",\\\"str_response\\\":\\\"1524104680,255742490455,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:14', '2026-02-25 14:31:14'),
(114, '255755146527', 'Aman Mdewa Nthangu', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104683\\\",\\\"number\\\":\\\"255755146527\\\",\\\"str_response\\\":\\\"1524104683,255755146527,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:15', '2026-02-25 14:31:15'),
(115, '255677149158', 'Elizabeth Christopher Migeto', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104686\\\",\\\"number\\\":\\\"255677149158\\\",\\\"str_response\\\":\\\"1524104686,255677149158,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:15', '2026-02-25 14:31:15'),
(116, '255714842713', 'Neema Kazare', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104692\\\",\\\"number\\\":\\\"255714842713\\\",\\\"str_response\\\":\\\"1524104692,255714842713,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:15', '2026-02-25 14:31:15'),
(117, '255755114343', 'ALFAYO NASHONI KIBOGE', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104695\\\",\\\"number\\\":\\\"255755114343\\\",\\\"str_response\\\":\\\"1524104695,255755114343,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:16', '2026-02-25 14:31:16'),
(118, '255764648884', 'BEATRICE ELIA MHANA', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104697\\\",\\\"number\\\":\\\"255764648884\\\",\\\"str_response\\\":\\\"1524104697,255764648884,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:16', '2026-02-25 14:31:16'),
(119, '255756673176', 'Meshack clement mihayo', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104703\\\",\\\"number\\\":\\\"255756673176\\\",\\\"str_response\\\":\\\"1524104703,255756673176,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:16', '2026-02-25 14:31:16'),
(120, '255785480389', 'Perecy beza', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104706\\\",\\\"number\\\":\\\"255785480389\\\",\\\"str_response\\\":\\\"1524104706,255785480389,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:17', '2026-02-25 14:31:17'),
(121, '255758295657', 'Veronica chavala', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104708\\\",\\\"number\\\":\\\"255758295657\\\",\\\"str_response\\\":\\\"1524104708,255758295657,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:17', '2026-02-25 14:31:17'),
(122, '255759076332', 'Denis Cleophace', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104711\\\",\\\"number\\\":\\\"255759076332\\\",\\\"str_response\\\":\\\"1524104711,255759076332,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:18', '2026-02-25 14:31:18'),
(123, '255744932734', 'Edith Beza', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104714\\\",\\\"number\\\":\\\"255744932734\\\",\\\"str_response\\\":\\\"1524104714,255744932734,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:18', '2026-02-25 14:31:18'),
(124, '255762285686', 'GLORIA ANDREW MBWAMBO', 'all', 'Shalom,  Hongera  kwa kujisajili kwenye mfumo. \nKaribu FPCT KURASINI.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524104720\\\",\\\"number\\\":\\\"255762285686\\\",\\\"str_response\\\":\\\"1524104720,255762285686,Send Successful\\\"}]\\r\\n\"', '2026-02-25 14:31:18', '2026-02-25 14:31:18'),
(125, '255756673176', 'Meshack clement mihayo', 'direct', 'Bwana Yesu asifiwe Meshack clement mihayo, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0030', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524309846\\\",\\\"number\\\":\\\"255756673176\\\",\\\"str_response\\\":\\\"1524309846,255756673176,Send Successful\\\"}]\\r\\n\"', '2026-02-25 15:53:25', '2026-02-25 15:53:25'),
(126, '255756673176', 'Meshack clement mihayo', 'individual', 'Bwana Yesu asifiwe Meshack clement mihayo, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0030', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524334366\\\",\\\"number\\\":\\\"255756673176\\\",\\\"str_response\\\":\\\"1524334366,255756673176,Send Successful\\\"}]\\r\\n\"', '2026-02-25 16:18:53', '2026-02-25 16:18:53'),
(127, '255655323199', 'THEOPHILDA CHRISTOPHER', 'individual', 'Bwana Yesu asifiwe Theofilda Christopher, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0015', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524502742\\\",\\\"number\\\":\\\"255655323199\\\",\\\"str_response\\\":\\\"1524502742,255655323199,Send Successful\\\"}]\\r\\n\"', '2026-02-25 17:06:08', '2026-02-25 17:06:08'),
(128, '255769531914', 'NOELA MUSSA', 'direct', 'Bwana Yesu asifiwe NOELA MUSSA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0031', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524585135\\\",\\\"number\\\":\\\"255769531914\\\",\\\"str_response\\\":\\\"1524585135,255769531914,Send Successful\\\"}]\\r\\n\"', '2026-02-25 18:37:31', '2026-02-25 18:37:31'),
(129, '255758295657', 'Veronica chavala', 'individual', 'Bwana Yesu asifiwe Veronica Chavala, Sasa wewe ni mshirika rasmi wa FPCT kurasini Namba yako ya ushirika ni: 0025', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524586525\\\",\\\"number\\\":\\\"255758295657\\\",\\\"str_response\\\":\\\"1524586525,255758295657,Send Successful\\\"}]\\r\\n\"', '2026-02-25 18:41:10', '2026-02-25 18:41:10'),
(130, '255754774918', 'Noel Damson Nthangu', 'direct', 'Bwana Yesu asifiwe Noel Damson Nthangu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0032', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524593380\\\",\\\"number\\\":\\\"255754774918\\\",\\\"str_response\\\":\\\"1524593380,255754774918,Send Successful\\\"}]\\r\\n\"', '2026-02-25 18:55:35', '2026-02-25 18:55:35'),
(131, '255747584779', 'Sam Batenzi', 'direct', 'Bwana Yesu asifiwe Sam Batenzi, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0033', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524636703\\\",\\\"number\\\":\\\"255747584779\\\",\\\"str_response\\\":\\\"1524636703,255747584779,Send Successful\\\"}]\\r\\n\"', '2026-02-25 20:12:00', '2026-02-25 20:12:00'),
(132, '255787285496', 'ANGELA ANTELIMI KALALU', 'direct', 'Bwana Yesu asifiwe ANGELA ANTELIMI KALALU, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0034', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524667242\\\",\\\"number\\\":\\\"255787285496\\\",\\\"str_response\\\":\\\"1524667242,255787285496,Send Successful\\\"}]\\r\\n\"', '2026-02-25 20:41:41', '2026-02-25 20:41:41'),
(133, '255679320447', 'Felix William', 'direct', 'Bwana Yesu asifiwe Felix William, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0035', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524685284\\\",\\\"number\\\":\\\"255679320447\\\",\\\"str_response\\\":\\\"1524685284,255679320447,Send Successful\\\"}]\\r\\n\"', '2026-02-25 21:29:21', '2026-02-25 21:29:21'),
(134, '255679320447', 'Felix William', 'direct', 'Bwana Yesu asifiwe Felix William, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0035', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524685295\\\",\\\"number\\\":\\\"255679320447\\\",\\\"str_response\\\":\\\"1524685295,255679320447,Send Successful\\\"}]\\r\\n\"', '2026-02-25 21:29:22', '2026-02-25 21:29:22'),
(135, '255679320447', 'Felix William', 'direct', 'Bwana Yesu asifiwe Felix William, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0035', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524685296\\\",\\\"number\\\":\\\"255679320447\\\",\\\"str_response\\\":\\\"1524685296,255679320447,Send Successful\\\"}]\\r\\n\"', '2026-02-25 21:29:22', '2026-02-25 21:29:22'),
(136, '255686360843', 'ANOLD GIDION FUMBUKA', 'direct', 'Bwana Yesu asifiwe ANOLD GIDION FUMBUKA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0036', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524716308\\\",\\\"number\\\":\\\"255686360843\\\",\\\"str_response\\\":\\\"1524716308,255686360843,Send Successful\\\"}]\\r\\n\"', '2026-02-25 22:45:55', '2026-02-25 22:45:55'),
(137, '255717480049', 'Theresia kindole', 'direct', 'Bwana Yesu asifiwe Theresia kindole, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0037', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524813256\\\",\\\"number\\\":\\\"255717480049\\\",\\\"str_response\\\":\\\"1524813256,255717480049,Send Successful\\\"}]\\r\\n\"', '2026-02-26 00:39:18', '2026-02-26 00:39:18'),
(138, '255612145642', 'ESTER MATHAYO CHARLES', 'direct', 'Bwana Yesu asifiwe ESTER MATHAYO CHARLES, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0038', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524815123\\\",\\\"number\\\":\\\"255612145642\\\",\\\"str_response\\\":\\\"1524815123,255612145642,Send Successful\\\"}]\\r\\n\"', '2026-02-26 00:45:08', '2026-02-26 00:45:08'),
(139, '255786504664', 'Jane Martin', 'direct', 'Bwana Yesu asifiwe Jane Martin, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0039', 'Sent', '\"[{\\\"msg_id\\\":\\\"1524831303\\\",\\\"number\\\":\\\"255786504664\\\",\\\"str_response\\\":\\\"1524831303,255786504664,Send Successful\\\"}]\\r\\n\"', '2026-02-26 01:28:13', '2026-02-26 01:28:13'),
(140, '255714842713', 'Neema Kazare', 'individual', 'Habari NEEMA KAZARE, usajili wako FPCT Kurasini umekamilika. Namba yako ya ushirika ni: 0024. Karibu FPCT Kurasini.', 'Sent', '\"[{\\\"msg_id\\\":\\\"1525930442\\\",\\\"number\\\":\\\"255714842713\\\",\\\"str_response\\\":\\\"1525930442,255714842713,Send Successful\\\"}]\\r\\n\"', '2026-02-26 14:45:26', '2026-02-26 14:45:26'),
(141, '255787285496', 'ANGELA ANTELIMI KALALU', 'individual', 'Hii ni sms ya majaribio kujua kama imekufikia kutoka kanisasoft', 'Sent', '\"[{\\\"msg_id\\\":\\\"1526010609\\\",\\\"number\\\":\\\"255787285496\\\",\\\"str_response\\\":\\\"1526010609,255787285496,Send Successful\\\"}]\\r\\n\"', '2026-02-26 15:12:57', '2026-02-26 15:12:57'),
(142, '255754502656', 'Wenceslaus Benedict Fungamtama', 'direct', 'Bwana Yesu asifiwe Wenceslaus Benedict Fungamtama, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0040', 'Sent', '\"[{\\\"msg_id\\\":\\\"1526082544\\\",\\\"number\\\":\\\"255754502656\\\",\\\"str_response\\\":\\\"1526082544,255754502656,Send Successful\\\"}]\\r\\n\"', '2026-02-26 15:29:52', '2026-02-26 15:29:52'),
(143, '255674918283', 'UYANJO JOHN', 'direct', 'Bwana Yesu asifiwe UYANJO JOHN, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0041', 'Sent', '\"[{\\\"msg_id\\\":\\\"1526082744\\\",\\\"number\\\":\\\"255674918283\\\",\\\"str_response\\\":\\\"1526082744,255674918283,Send Successful\\\"}]\\r\\n\"', '2026-02-26 15:30:01', '2026-02-26 15:30:01'),
(144, '255785480389', 'Perecy beza', 'individual', 'Bwana Yesu asifiwe Perecy beza, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0042', 'Sent', '\"[{\\\"msg_id\\\":\\\"1526116732\\\",\\\"number\\\":\\\"255785480389\\\",\\\"str_response\\\":\\\"1526116732,255785480389,Send Successful\\\"}]\\r\\n\"', '2026-02-26 15:33:06', '2026-02-26 15:33:06'),
(145, '255757445207', 'AUGUSTINO MADAKI BONIPHACE', 'direct', 'Bwana Yesu asifiwe AUGUSTINO MADAKI BONIPHACE, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0044', 'Sent', '\"[{\\\"msg_id\\\":\\\"1528373465\\\",\\\"number\\\":\\\"255757445207\\\",\\\"str_response\\\":\\\"1528373465,255757445207,Send Successful\\\"}]\\r\\n\"', '2026-02-27 01:18:29', '2026-02-27 01:18:29'),
(146, '255746562364', 'MAGRETH SYLIVESTER ROBERT', 'direct', 'Bwana Yesu asifiwe MAGRETH SYLIVESTER ROBERT, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0045', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529292562\\\",\\\"number\\\":\\\"255746562364\\\",\\\"str_response\\\":\\\"1529292562,255746562364,Send Successful\\\"}]\\r\\n\"', '2026-02-27 13:35:16', '2026-02-27 13:35:16'),
(147, '255712104508', 'Tumaini  Peter Kaaya', 'individual', 'Bwana Yesu asifiwe TUMAINI PETER KAAYA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0043', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529369619\\\",\\\"number\\\":\\\"255712104508\\\",\\\"str_response\\\":\\\"1529369619,255712104508,Send Successful\\\"}]\\r\\n\"', '2026-02-27 13:55:09', '2026-02-27 13:55:09'),
(148, '255719800813', 'Julius Kindole', 'individual', 'Bwana Yesu asifiwe JULIUS KINDOLE, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0006', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529396300\\\",\\\"number\\\":\\\"255719800813\\\",\\\"str_response\\\":\\\"1529396300,255719800813,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:03:59', '2026-02-27 14:03:59'),
(149, '255787001007', 'Isaya Raphael Mwanyamba', 'individual', 'Bwana Yesu asifiwe ISAYA RAPHAEL MWANYAMBA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0002', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529397929\\\",\\\"number\\\":\\\"255787001007\\\",\\\"str_response\\\":\\\"1529397929,255787001007,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:06:01', '2026-02-27 14:06:01'),
(150, '255784824624', 'Oscar Batista Kindole', 'individual', 'Bwana Yesu asifiwe OSCAR BATISTA KINDOLE, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0001', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529398958\\\",\\\"number\\\":\\\"255784824624\\\",\\\"str_response\\\":\\\"1529398958,255784824624,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:07:35', '2026-02-27 14:07:35'),
(151, '255754544438', 'Reuben Bulugu', 'individual', 'Bwana Yesu asifiwe REUBEN BULUGU, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0003', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529399428\\\",\\\"number\\\":\\\"255754544438\\\",\\\"str_response\\\":\\\"1529399428,255754544438,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:08:47', '2026-02-27 14:08:47'),
(152, '255788677472', 'Dr. Suleiman Mathew IKOMBA', 'individual', 'Bwana Yesu asifiwe Dr. SULEIMAN MATHEW IKOMBA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0004', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529400535\\\",\\\"number\\\":\\\"255788677472\\\",\\\"str_response\\\":\\\"1529400535,255788677472,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:10:25', '2026-02-27 14:10:25'),
(153, '255758047674', 'DAMIAN GERVAS NDABATINYA', 'individual', 'Bwana Yesu asifiwe DAMIAN GERVAS NDABATINYA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0005', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529401515\\\",\\\"number\\\":\\\"255758047674\\\",\\\"str_response\\\":\\\"1529401515,255758047674,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:11:57', '2026-02-27 14:11:57'),
(154, '255768920734', 'Sospeter Bathoha', 'individual', 'Bwana Yesu asifiwe SOSPETER BATHOHA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0007', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529402163\\\",\\\"number\\\":\\\"255768920734\\\",\\\"str_response\\\":\\\"1529402163,255768920734,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:13:13', '2026-02-27 14:13:13'),
(155, '255758833304', 'NTULI KAPOLOGWE', 'individual', 'Bwana Yesu asifiwe NTULI KAPOLOGWE, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0008', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529402790\\\",\\\"number\\\":\\\"255758833304\\\",\\\"str_response\\\":\\\"1529402790,255758833304,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:14:47', '2026-02-27 14:14:47'),
(156, '255658698146', 'Neema Mustapha Kiluwasha', 'individual', 'Bwana Yesu asifiwe NEEMA MUSTAPHA KILUWASHA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0009', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529403554\\\",\\\"number\\\":\\\"255658698146\\\",\\\"str_response\\\":\\\"1529403554,255658698146,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:16:06', '2026-02-27 14:16:06'),
(157, '255714991925', 'Natalia Beza', 'individual', 'Bwana Yesu asifiwe NATALIA BEZA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0010', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529404050\\\",\\\"number\\\":\\\"255714991925\\\",\\\"str_response\\\":\\\"1529404050,255714991925,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:17:10', '2026-02-27 14:17:10'),
(158, '255655323199', 'THEOPHILDA CHRISTOPHER', 'individual', 'Bwana Yesu asifiwe THEOPHILDA CHRISTOPHER, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0015', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529404977\\\",\\\"number\\\":\\\"255655323199\\\",\\\"str_response\\\":\\\"1529404977,255655323199,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:18:35', '2026-02-27 14:18:35'),
(159, '255716654579', 'Jacob Sanke Nyoni', 'individual', 'Bwana Yesu asifiwe JACOB SANKE NYONI, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0016', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529405377\\\",\\\"number\\\":\\\"255716654579\\\",\\\"str_response\\\":\\\"1529405377,255716654579,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:19:49', '2026-02-27 14:19:49'),
(160, '255712658038', 'HERIEL GABRIEL', 'individual', 'Bwana Yesu asifiwe HERIEL GABRIEL, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0014', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529410076\\\",\\\"number\\\":\\\"255712658038\\\",\\\"str_response\\\":\\\"1529410076,255712658038,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:25:28', '2026-02-27 14:25:28'),
(161, '255737774790', 'AHUNGU MODKY', 'individual', 'Bwana Yesu asifiwe AHUNGU MODKY, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0013', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529410512\\\",\\\"number\\\":\\\"255737774790\\\",\\\"str_response\\\":\\\"1529410512,255737774790,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:26:21', '2026-02-27 14:26:21'),
(162, '255754897675', 'Amos Samwel Ntandu', 'individual', 'Bwana Yesu asifiwe AMOS SAMWEL NTANDU, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0018', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529410999\\\",\\\"number\\\":\\\"255754897675\\\",\\\"str_response\\\":\\\"1529410999,255754897675,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:27:50', '2026-02-27 14:27:50'),
(163, '255754778376', 'Elicia Sekishaku Kisoma', 'individual', 'Bwana Yesu asifiwe ELICIA SEKISHAKU KISOMA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0019', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529411402\\\",\\\"number\\\":\\\"255754778376\\\",\\\"str_response\\\":\\\"1529411402,255754778376,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:29:18', '2026-02-27 14:29:18'),
(164, '255657300333', 'Erick Andrea', 'individual', 'Bwana Yesu asifiwe ERICK ANDREA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0011', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529412174\\\",\\\"number\\\":\\\"255657300333\\\",\\\"str_response\\\":\\\"1529412174,255657300333,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:30:25', '2026-02-27 14:30:25'),
(165, '255762748397', 'Hannah Kimicha Rwandalla', 'individual', 'Bwana Yesu asifiwe HANNAH KIMICHA RWANDALLA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0017', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529414020\\\",\\\"number\\\":\\\"255762748397\\\",\\\"str_response\\\":\\\"1529414020,255762748397,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:31:38', '2026-02-27 14:31:38'),
(166, '255754244794', 'Benedicto Mugongo', 'individual', 'Bwana Yesu asifiwe BENEDICTO MUGONGO, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0012', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529415553\\\",\\\"number\\\":\\\"255754244794\\\",\\\"str_response\\\":\\\"1529415553,255754244794,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:33:12', '2026-02-27 14:33:12'),
(167, '255742490455', 'Adriano Nashoni Kibhoge', 'individual', 'Bwana Yesu asifiwe ADRIANO NASHONI KIBHOGE, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0020', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529416765\\\",\\\"number\\\":\\\"255742490455\\\",\\\"str_response\\\":\\\"1529416765,255742490455,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:34:33', '2026-02-27 14:34:33'),
(168, '255755146527', 'Aman Mdewa Nthangu', 'individual', 'Bwana Yesu asifiwe AMAN MDEWA NTHANGU, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0021', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529418107\\\",\\\"number\\\":\\\"255755146527\\\",\\\"str_response\\\":\\\"1529418107,255755146527,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:35:52', '2026-02-27 14:35:52'),
(169, '255677149158', 'Elizabeth Christopher Migeto', 'individual', 'Bwana Yesu asifiwe ELIZABETH CHRISTOPHER MIGETO, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0023', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529419186\\\",\\\"number\\\":\\\"255677149158\\\",\\\"str_response\\\":\\\"1529419186,255677149158,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:37:23', '2026-02-27 14:37:23'),
(170, '255714842713', 'Neema Kazare', 'individual', 'Bwana Yesu asifiwe NEEMA KAZARE, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0024', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529419825\\\",\\\"number\\\":\\\"255714842713\\\",\\\"str_response\\\":\\\"1529419825,255714842713,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:38:23', '2026-02-27 14:38:23'),
(171, '255755114343', 'ALFAYO NASHONI KIBOGE', 'individual', 'Bwana Yesu asifiwe ALFAYO NASHONI KIBOGE, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0022', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529420388\\\",\\\"number\\\":\\\"255755114343\\\",\\\"str_response\\\":\\\"1529420388,255755114343,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:39:24', '2026-02-27 14:39:24'),
(172, '255764648884', 'BEATRICE ELIA MHANA', 'individual', 'Bwana Yesu asifiwe BEATRICE ELIA MHANA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0028', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529421248\\\",\\\"number\\\":\\\"255764648884\\\",\\\"str_response\\\":\\\"1529421248,255764648884,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:40:35', '2026-02-27 14:40:35'),
(173, '255756673176', 'Meshack clement mihayo', 'individual', 'Bwana Yesu asifiwe MESHACK CLEMENT MIHAYO, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0030', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529422200\\\",\\\"number\\\":\\\"255756673176\\\",\\\"str_response\\\":\\\"1529422200,255756673176,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:41:48', '2026-02-27 14:41:48');
INSERT INTO `sms_logs` (`id`, `recipient`, `receiver`, `type`, `message`, `status`, `response`, `created_at`, `updated_at`) VALUES
(174, '255716668317', 'PERECY BEZA', 'individual', 'Bwana Yesu asifiwe PERECY BEZA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0042', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529422490\\\",\\\"number\\\":\\\"255716668317\\\",\\\"str_response\\\":\\\"1529422490,255716668317,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:42:51', '2026-02-27 14:42:51'),
(175, '255758295657', 'Veronica chavala', 'individual', 'Bwana Yesu asifiwe VERONICA CHAVALA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0025', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529431239\\\",\\\"number\\\":\\\"255758295657\\\",\\\"str_response\\\":\\\"1529431239,255758295657,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:48:59', '2026-02-27 14:48:59'),
(176, '255759076332', 'Denis Cleophace', 'individual', 'Bwana Yesu asifiwe DENIS CLEOPHACE, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0026', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529431622\\\",\\\"number\\\":\\\"255759076332\\\",\\\"str_response\\\":\\\"1529431622,255759076332,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:50:03', '2026-02-27 14:50:03'),
(177, '255744932734', 'Edith Batenzi', 'individual', 'Bwana Yesu asifiwe EDITH BATENZI, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0027', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529432151\\\",\\\"number\\\":\\\"255744932734\\\",\\\"str_response\\\":\\\"1529432151,255744932734,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:50:46', '2026-02-27 14:50:46'),
(178, '255762285686', 'GLORIA ANDREW MBWAMBO', 'individual', 'Bwana Yesu asifiwe GLORIA  ANDREW MBWAMBO, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0029', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529433024\\\",\\\"number\\\":\\\"255762285686\\\",\\\"str_response\\\":\\\"1529433024,255762285686,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:52:18', '2026-02-27 14:52:18'),
(179, '255679320447', 'Felix William', 'individual', 'Bwana Yesu asifiwe FELIX WILLIAM, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0035', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529433340\\\",\\\"number\\\":\\\"255679320447\\\",\\\"str_response\\\":\\\"1529433340,255679320447,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:53:13', '2026-02-27 14:53:13'),
(180, '255769531914', 'NOELA MUSSA', 'individual', 'Bwana Yesu asifiwe NOELA MUSSA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0031', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529433592\\\",\\\"number\\\":\\\"255769531914\\\",\\\"str_response\\\":\\\"1529433592,255769531914,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:53:54', '2026-02-27 14:53:54'),
(181, '255787285496', 'ANGELA ANTELIMI KALALU', 'individual', 'Bwana Yesu asifiwe ANGELA ANTELIMI KALALU, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0034', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529434026\\\",\\\"number\\\":\\\"255787285496\\\",\\\"str_response\\\":\\\"1529434026,255787285496,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:55:07', '2026-02-27 14:55:07'),
(182, '255747584779', 'Sam Batenzi', 'individual', 'Bwana Yesu asifiwe SAM BATENZI, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0033', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529434602\\\",\\\"number\\\":\\\"255747584779\\\",\\\"str_response\\\":\\\"1529434602,255747584779,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:56:08', '2026-02-27 14:56:08'),
(183, '255686360843', 'ANOLD GIDION FUMBUKA', 'individual', 'Bwana Yesu asifiwe ANOLD GIDION FUMBUKA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0036', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529435129\\\",\\\"number\\\":\\\"255686360843\\\",\\\"str_response\\\":\\\"1529435129,255686360843,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:57:11', '2026-02-27 14:57:11'),
(184, '255612145642', 'ESTER MATHAYO CHARLES', 'individual', 'Bwana Yesu asifiwe ESTER MATHAYO CHARLES, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0038', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529435505\\\",\\\"number\\\":\\\"255612145642\\\",\\\"str_response\\\":\\\"1529435505,255612145642,Send Successful\\\"}]\\r\\n\"', '2026-02-27 14:58:18', '2026-02-27 14:58:18'),
(185, '255717480049', 'Theresia kindole', 'individual', 'Bwana Yesu asifiwe THERESIA KINDOLE, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0037', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529440766\\\",\\\"number\\\":\\\"255717480049\\\",\\\"str_response\\\":\\\"1529440766,255717480049,Send Successful\\\"}]\\r\\n\"', '2026-02-27 15:04:55', '2026-02-27 15:04:55'),
(186, '255786504664', 'Jane Martin', 'individual', 'Bwana Yesu asifiwe JANE MARTIN, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0039', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529441470\\\",\\\"number\\\":\\\"255786504664\\\",\\\"str_response\\\":\\\"1529441470,255786504664,Send Successful\\\"}]\\r\\n\"', '2026-02-27 15:05:56', '2026-02-27 15:05:56'),
(187, '255674918283', 'UYANJO JOHN', 'individual', 'Bwana Yesu asifiwe UYANJO JOHN, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0041', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529442073\\\",\\\"number\\\":\\\"255674918283\\\",\\\"str_response\\\":\\\"1529442073,255674918283,Send Successful\\\"}]\\r\\n\"', '2026-02-27 15:07:00', '2026-02-27 15:07:00'),
(188, '255754502656', 'Wenceslaus Benedict Fungamtama', 'individual', 'Bwana Yesu asifiwe WENCESLAUS BENEDICT FUNGAMTAMA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0040', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529442532\\\",\\\"number\\\":\\\"255754502656\\\",\\\"str_response\\\":\\\"1529442532,255754502656,Send Successful\\\"}]\\r\\n\"', '2026-02-27 15:08:16', '2026-02-27 15:08:16'),
(189, '255757445207', 'AUGUSTINO MADAKI BONIPHACE', 'individual', 'Bwana Yesu asifiwe AUGUSTINO MADAKI BONIPHACE, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0044', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529443573\\\",\\\"number\\\":\\\"255757445207\\\",\\\"str_response\\\":\\\"1529443573,255757445207,Send Successful\\\"}]\\r\\n\"', '2026-02-27 15:10:40', '2026-02-27 15:10:40'),
(190, '255746562364', 'MAGRETH SYLIVESTER ROBERT', 'individual', 'Bwana Yesu asifiwe MAGRETH SYLIVESTER ROBERT, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0045', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529444554\\\",\\\"number\\\":\\\"255746562364\\\",\\\"str_response\\\":\\\"1529444554,255746562364,Send Successful\\\"}]\\r\\n\"', '2026-02-27 15:12:02', '2026-02-27 15:12:02'),
(191, '255713863847', 'Kepha Thomas Michael', 'direct', 'Bwana Yesu asifiwe Kepha Thomas Michael, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0046', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529548003\\\",\\\"number\\\":\\\"255713863847\\\",\\\"str_response\\\":\\\"1529548003,255713863847,Send Successful\\\"}]\\r\\n\"', '2026-02-27 16:25:52', '2026-02-27 16:25:52'),
(192, '255713213731', 'Aloyce Godfrey Beza', 'direct', 'Bwana Yesu asifiwe Aloyce Godfrey Beza, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0047', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529548290\\\",\\\"number\\\":\\\"255713213731\\\",\\\"str_response\\\":\\\"1529548290,255713213731,Send Successful\\\"}]\\r\\n\"', '2026-02-27 16:26:04', '2026-02-27 16:26:04'),
(193, '255682690607', 'Alam Alexander', 'direct', 'Bwana Yesu asifiwe Alam Alexander, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0048', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529674700\\\",\\\"number\\\":\\\"255682690607\\\",\\\"str_response\\\":\\\"1529674700,255682690607,Send Successful\\\"}]\\r\\n\"', '2026-02-27 17:05:02', '2026-02-27 17:05:02'),
(194, '255761360607', 'Alam Alexander', 'individual', 'Shalom, Hongera kwa kujisajili  kwenye mfumo,  karibu FPCT Kurasini, Namba yako ya ushirika ni 0048', 'Sent', '\"[{\\\"msg_id\\\":\\\"1529677752\\\",\\\"number\\\":\\\"255761360607\\\",\\\"str_response\\\":\\\"1529677752,255761360607,Send Successful\\\"}]\\r\\n\"', '2026-02-27 17:10:56', '2026-02-27 17:10:56'),
(195, '255755624764', 'David Fredrick Mhando', 'direct', 'Bwana Yesu asifiwe David Fredrick Mhando, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0049', 'Sent', '\"[{\\\"msg_id\\\":\\\"1530729458\\\",\\\"number\\\":\\\"255755624764\\\",\\\"str_response\\\":\\\"1530729458,255755624764,Send Successful\\\"}]\\r\\n\"', '2026-02-28 08:39:24', '2026-02-28 08:39:24'),
(196, '255719453147', 'lydia msabaha midello', 'direct', 'Bwana Yesu asifiwe lydia msabaha midello, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0050', 'Sent', '\"[{\\\"msg_id\\\":\\\"1531536425\\\",\\\"number\\\":\\\"255719453147\\\",\\\"str_response\\\":\\\"1531536425,255719453147,Send Successful\\\"}]\\r\\n\"', '2026-02-28 17:48:31', '2026-02-28 17:48:31'),
(197, '255756945201', 'Philomena Solomon Muhamila', 'direct', 'Bwana Yesu asifiwe Philomena Solomon Muhamila, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0051', 'Sent', '\"[{\\\"msg_id\\\":\\\"1531536507\\\",\\\"number\\\":\\\"255756945201\\\",\\\"str_response\\\":\\\"1531536507,255756945201,Send Successful\\\"}]\\r\\n\"', '2026-02-28 17:48:41', '2026-02-28 17:48:41'),
(198, '255713625929', 'Javan Jerome Zablon', 'direct', 'Bwana Yesu asifiwe Javan Jerome Zablon, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0052', 'Sent', '\"[{\\\"msg_id\\\":\\\"1532915686\\\",\\\"number\\\":\\\"255713625929\\\",\\\"str_response\\\":\\\"1532915686,255713625929,Send Successful\\\"}]\\r\\n\"', '2026-03-01 17:37:55', '2026-03-01 17:37:55'),
(199, '255654999179', 'Ndungutse Yosia Misigaro', 'direct', 'Bwana Yesu asifiwe Ndungutse Yosia Misigaro, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0053', 'Sent', '\"[{\\\"msg_id\\\":\\\"1532915846\\\",\\\"number\\\":\\\"255654999179\\\",\\\"str_response\\\":\\\"1532915846,255654999179,Send Successful\\\"}]\\r\\n\"', '2026-03-01 17:38:11', '2026-03-01 17:38:11'),
(200, '255654999179', 'Ndungutse Yosia Misigaro', 'direct', 'Bwana Yesu asifiwe Ndungutse Yosia Misigaro, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0053', 'Sent', '\"[{\\\"msg_id\\\":\\\"1532915856\\\",\\\"number\\\":\\\"255654999179\\\",\\\"str_response\\\":\\\"1532915856,255654999179,Send Successful\\\"}]\\r\\n\"', '2026-03-01 17:38:12', '2026-03-01 17:38:12'),
(201, '255673073841', 'Jacqueline  Maduka', 'direct', 'Bwana Yesu asifiwe Jacqueline  Maduka, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0054', 'Sent', '\"[{\\\"msg_id\\\":\\\"1532916039\\\",\\\"number\\\":\\\"255673073841\\\",\\\"str_response\\\":\\\"1532916039,255673073841,Send Successful\\\"}]\\r\\n\"', '2026-03-01 17:38:34', '2026-03-01 17:38:34'),
(202, '255716572056', 'Laurencia  Thomas Mlawa', 'direct', 'Bwana Yesu asifiwe Laurencia  Thomas Mlawa, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0055', 'Sent', '\"[{\\\"msg_id\\\":\\\"1532961996\\\",\\\"number\\\":\\\"255716572056\\\",\\\"str_response\\\":\\\"1532961996,255716572056,Send Successful\\\"}]\\r\\n\"', '2026-03-01 18:20:12', '2026-03-01 18:20:12'),
(203, '255754778376', 'Elicia Sekishaku Kisoma', 'individual', 'Bwana Yesu asifiwe Elicia Sekishaku Kisoma, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni: 0019', 'Sent', '\"[{\\\"msg_id\\\":\\\"1534427887\\\",\\\"number\\\":\\\"255754778376\\\",\\\"str_response\\\":\\\"1534427887,255754778376,Send Successful\\\"}]\\r\\n\"', '2026-03-02 13:36:09', '2026-03-02 13:36:09'),
(204, '255658588591', 'FATUMA ABUBAKARI NGARAMA', 'direct', 'Bwana Yesu asifiwe FATUMA ABUBAKARI NGARAMA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0056', 'Sent', '\"[{\\\"msg_id\\\":\\\"1534459105\\\",\\\"number\\\":\\\"255658588591\\\",\\\"str_response\\\":\\\"1534459105,255658588591,Send Successful\\\"}]\\r\\n\"', '2026-03-02 14:07:09', '2026-03-02 14:07:09'),
(205, '255764284549', 'Ayoub Isaac Butandu', 'direct', 'Bwana Yesu asifiwe Ayoub Isaac Butandu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0057', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535310272\\\",\\\"number\\\":\\\"255764284549\\\",\\\"str_response\\\":\\\"1535310272,255764284549,Send Successful\\\"}]\\r\\n\"', '2026-03-02 19:58:52', '2026-03-02 19:58:52'),
(206, '255764284549', 'Ayoub Isaac Butandu', 'direct', 'Bwana Yesu asifiwe Ayoub Isaac Butandu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0057', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535310275\\\",\\\"number\\\":\\\"255764284549\\\",\\\"str_response\\\":\\\"1535310275,255764284549,Send Successful\\\"}]\\r\\n\"', '2026-03-02 19:58:52', '2026-03-02 19:58:52'),
(207, '255764284549', 'Ayoub Isaac Butandu', 'direct', 'Bwana Yesu asifiwe Ayoub Isaac Butandu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0057', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535310277\\\",\\\"number\\\":\\\"255764284549\\\",\\\"str_response\\\":\\\"1535310277,255764284549,Send Successful\\\"}]\\r\\n\"', '2026-03-02 19:58:52', '2026-03-02 19:58:52'),
(208, '255764284549', 'Ayoub Isaac Butandu', 'direct', 'Bwana Yesu asifiwe Ayoub Isaac Butandu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0057', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535310278\\\",\\\"number\\\":\\\"255764284549\\\",\\\"str_response\\\":\\\"1535310278,255764284549,Send Successful\\\"}]\\r\\n\"', '2026-03-02 19:58:52', '2026-03-02 19:58:52'),
(209, '255764284549', 'Ayoub Isaac Butandu', 'direct', 'Bwana Yesu asifiwe Ayoub Isaac Butandu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0057', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535310280\\\",\\\"number\\\":\\\"255764284549\\\",\\\"str_response\\\":\\\"1535310280,255764284549,Send Successful\\\"}]\\r\\n\"', '2026-03-02 19:58:52', '2026-03-02 19:58:52'),
(210, '255764284549', 'Ayoub Isaac Butandu', 'direct', 'Bwana Yesu asifiwe Ayoub Isaac Butandu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0057', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535310293\\\",\\\"number\\\":\\\"255764284549\\\",\\\"str_response\\\":\\\"1535310293,255764284549,Send Successful\\\"}]\\r\\n\"', '2026-03-02 19:58:52', '2026-03-02 19:58:52'),
(211, '255748589142', 'Patrick Ibrahim Makuhi', 'direct', 'Bwana Yesu asifiwe Patrick Ibrahim Makuhi, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0058', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535310296\\\",\\\"number\\\":\\\"255748589142\\\",\\\"str_response\\\":\\\"1535310296,255748589142,Send Successful\\\"}]\\r\\n\"', '2026-03-02 19:58:52', '2026-03-02 19:58:52'),
(212, '255764284549', 'Ayoub Isaac Butandu', 'direct', 'Bwana Yesu asifiwe Ayoub Isaac Butandu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0057', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535310331\\\",\\\"number\\\":\\\"255764284549\\\",\\\"str_response\\\":\\\"1535310331,255764284549,Send Successful\\\"}]\\r\\n\"', '2026-03-02 19:58:53', '2026-03-02 19:58:53'),
(213, '255764284549', 'Ayoub Isaac Butandu', 'direct', 'Bwana Yesu asifiwe Ayoub Isaac Butandu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0057', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535310356\\\",\\\"number\\\":\\\"255764284549\\\",\\\"str_response\\\":\\\"1535310356,255764284549,Send Successful\\\"}]\\r\\n\"', '2026-03-02 19:58:53', '2026-03-02 19:58:53'),
(214, '255748589142', 'Patrick Ibrahim Makuhi', 'direct', 'Bwana Yesu asifiwe Patrick Ibrahim Makuhi, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0058', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535310359\\\",\\\"number\\\":\\\"255748589142\\\",\\\"str_response\\\":\\\"1535310359,255748589142,Send Successful\\\"}]\\r\\n\"', '2026-03-02 19:58:53', '2026-03-02 19:58:53'),
(215, '255764284549', 'Ayoub Isaac Butandu', 'direct', 'Bwana Yesu asifiwe Ayoub Isaac Butandu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0057', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535310362\\\",\\\"number\\\":\\\"255764284549\\\",\\\"str_response\\\":\\\"1535310362,255764284549,Send Successful\\\"}]\\r\\n\"', '2026-03-02 19:58:53', '2026-03-02 19:58:53'),
(216, '255764284549', 'Ayoub Isaac Butandu', 'direct', 'Bwana Yesu asifiwe Ayoub Isaac Butandu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0057', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535310370\\\",\\\"number\\\":\\\"255764284549\\\",\\\"str_response\\\":\\\"1535310370,255764284549,Send Successful\\\"}]\\r\\n\"', '2026-03-02 19:58:53', '2026-03-02 19:58:53'),
(217, '255764284549', 'Ayoub Isaac Butandu', 'direct', 'Bwana Yesu asifiwe Ayoub Isaac Butandu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0057', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535310376\\\",\\\"number\\\":\\\"255764284549\\\",\\\"str_response\\\":\\\"1535310376,255764284549,Send Successful\\\"}]\\r\\n\"', '2026-03-02 19:58:53', '2026-03-02 19:58:53'),
(218, '255764284549', 'Ayoub Isaac Butandu', 'direct', 'Bwana Yesu asifiwe Ayoub Isaac Butandu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0057', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535310396\\\",\\\"number\\\":\\\"255764284549\\\",\\\"str_response\\\":\\\"1535310396,255764284549,Send Successful\\\"}]\\r\\n\"', '2026-03-02 19:58:53', '2026-03-02 19:58:53'),
(219, '255764284549', 'Ayoub Isaac Butandu', 'direct', 'Bwana Yesu asifiwe Ayoub Isaac Butandu, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0057', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535310433\\\",\\\"number\\\":\\\"255764284549\\\",\\\"str_response\\\":\\\"1535310433,255764284549,Send Successful\\\"}]\\r\\n\"', '2026-03-02 19:58:53', '2026-03-02 19:58:53'),
(220, '255758625618', 'ROSE DAVID KUMENYA', 'direct', 'Bwana Yesu asifiwe ROSE DAVID KUMENYA, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0059', 'Sent', '\"[{\\\"msg_id\\\":\\\"1535420662\\\",\\\"number\\\":\\\"255758625618\\\",\\\"str_response\\\":\\\"1535420662,255758625618,Send Successful\\\"}]\\r\\n\"', '2026-03-02 22:38:36', '2026-03-02 22:38:36'),
(221, '255767800507', 'Jumanne John Mbilao', 'direct', 'Bwana Yesu asifiwe Jumanne John Mbilao, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0060', 'Sent', '\"[{\\\"msg_id\\\":\\\"1536196111\\\",\\\"number\\\":\\\"255767800507\\\",\\\"str_response\\\":\\\"1536196111,255767800507,Send Successful\\\"}]\\r\\n\"', '2026-03-03 12:16:29', '2026-03-03 12:16:29'),
(222, '255784299942', 'Ernest Gyunda', 'direct', 'Bwana Yesu asifiwe Ernest Gyunda, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0061', 'Sent', '\"[{\\\"msg_id\\\":\\\"1537355419\\\",\\\"number\\\":\\\"255784299942\\\",\\\"str_response\\\":\\\"1537355419,255784299942,Send Successful\\\"}]\\r\\n\"', '2026-03-04 01:26:30', '2026-03-04 01:26:30'),
(223, '255767435625', 'NEZIA SHELF SHERTIELY', 'direct', 'Bwana Yesu asifiwe NEZIA SHELF SHERTIELY, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0062', 'Sent', '\"[{\\\"msg_id\\\":\\\"1537355499\\\",\\\"number\\\":\\\"255767435625\\\",\\\"str_response\\\":\\\"1537355499,255767435625,Send Successful\\\"}]\\r\\n\"', '2026-03-04 01:26:44', '2026-03-04 01:26:44'),
(224, '255758159929', 'Faraja Anthony Rutebuka', 'direct', 'Bwana Yesu asifiwe Faraja Anthony Rutebuka, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0063', 'Sent', '\"[{\\\"msg_id\\\":\\\"1537515619\\\",\\\"number\\\":\\\"255758159929\\\",\\\"str_response\\\":\\\"1537515619,255758159929,Send Successful\\\"}]\\r\\n\"', '2026-03-04 11:20:48', '2026-03-04 11:20:48'),
(225, '255626536720', 'Joseph William Makange', 'direct', 'Bwana Yesu asifiwe Joseph William Makange, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0064', 'Sent', '\"[{\\\"msg_id\\\":\\\"1537713279\\\",\\\"number\\\":\\\"255626536720\\\",\\\"str_response\\\":\\\"1537713279,255626536720,Send Successful\\\"}]\\r\\n\"', '2026-03-04 14:52:32', '2026-03-04 14:52:32'),
(226, '255682956632', 'Witness Morice', 'direct', 'Bwana Yesu asifiwe Witness Morice, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0065', 'Sent', '\"[{\\\"msg_id\\\":\\\"1537713422\\\",\\\"number\\\":\\\"255682956632\\\",\\\"str_response\\\":\\\"1537713422,255682956632,Send Successful\\\"}]\\r\\n\"', '2026-03-04 14:52:38', '2026-03-04 14:52:38'),
(227, '255768549003', 'Doto Geofrey Chima', 'direct', 'Bwana Yesu asifiwe Doto Geofrey Chima, Sasa wewe ni mshirika rasmi wa fpct kurasini Namba yako ya ushirika ni:  0066', 'Sent', '\"[{\\\"msg_id\\\":\\\"1537713769\\\",\\\"number\\\":\\\"255768549003\\\",\\\"str_response\\\":\\\"1537713769,255768549003,Send Successful\\\"}]\\r\\n\"', '2026-03-04 14:52:58', '2026-03-04 14:52:58');

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
(15, 'Tumaini  Peter Kaaya', 'M', '2025-12-30', '22 Feb 1991', NULL, 'Ameoa', 'Angela Kalalu', 0, 'Kijichi', '255712104508', 'Kaayah9@gmail.com', NULL, 'admin', '$2y$12$UR90qdaHbBu60TBhoyQQV.ggzKoikx2tmP.5w5ZPJAZcVbAgYkAQ.', NULL, '2025-12-31 00:41:05', '2026-02-26 15:40:22'),
(16, 'Oscar Batista Kindole', 'M', '1979-01-04', 'Iringa DC', NULL, 'Ameoa', 'Janet Chisi', 5, 'Kongowe', '255784824624', 'oscarkindole@gmail.com', NULL, 'kiongozi', '$2y$12$ifzkIsJ7oReeG9weoi2RxOKlzidO8taV.uduqAxxQF9sQVy3lYPkK', NULL, '2026-01-02 23:10:00', '2026-01-28 22:19:00'),
(17, 'Isaya Raphael Mwanyamba', 'M', '1979-12-19', 'Handeni TC/Tanga', NULL, 'Ameoa', 'Loveness Mollel', 3, 'Kigamboni', '255787001007', 'kakaisaya@gmail.com', NULL, 'admin', '$2y$12$g3XVw8ZZCb6lTAMjODOwrOHTHjD7DJo7uPup8OacAXW4unFXpa7tS', NULL, '2026-01-03 11:35:08', '2026-02-04 19:31:27'),
(19, 'Reuben Bulugu', 'M', '1963-04-16', 'Bariadi Simiyu', NULL, 'Ameoa', 'Jane Martine', 5, 'Kongowe', '255754544438', 'bulugur@yahoo.com', NULL, 'kiongozi', '$2y$12$Jb2NNbot3gXWIjVGFT8ioODBd7p4/dnwlV8Ol0wqr6kN1JBVS8KIy', NULL, '2026-01-03 22:19:30', '2026-01-29 21:26:02'),
(20, 'Dr. Suleiman Mathew IKOMBA', 'M', '1967-03-05', 'Kigoma Rular KIGOMA', NULL, 'Ameoa', 'Philomena Solomon Muhamila', 3, 'Mgeninani', '255788677472', 'suleimanikomba@gmail.com', NULL, 'kiongozi', '$2y$12$QBQiogrZYivmDhlVT98p8u9g1ADrVXytuWHjHhUNGk6wePH2FHWky', NULL, '2026-01-04 11:40:19', '2026-02-04 19:29:46'),
(21, 'Abigail Suleiman Mathew', 'F', '2004-08-12', 'Dar es Salaam, Temeke', NULL, 'Hajaolewa', NULL, 0, 'Mgeninani', '255699650632', 'abigailmathew34@gmail.com', NULL, 'Mwinjilisti', '$2y$12$1ImOI702G9j4HID7eeGXXeeWtqTklsi8rkM6HfXg9593dbRAhFl8G', NULL, '2026-01-05 10:44:00', '2026-01-17 18:08:28'),
(22, 'DAMIAN GERVAS NDABATINYA', 'M', '1972-07-01', 'BUHIGWE KIGOMA', NULL, 'Ameoa', 'GERDA PAULO TEBUYE', 4, 'Tandika', '255758047674', 'kigomawax@gmail.com', NULL, 'kiongozi', '$2y$12$SrY/yQ0J7C1HzZhOEryyr.bPqPK2vEM7AoQqMVcZ3DjMmwWxxK/Om', NULL, '2026-01-07 11:13:50', '2026-02-04 19:28:20'),
(23, 'Julius Kindole', 'M', '1981-06-03', 'Ilala, Dar Es Salaam', NULL, 'Ameoa', 'Emiliana Peter Kaaya', 4, 'Mgeninani', '255719800813', 'kindole72@gmail.com', NULL, 'admin', '$2y$12$rAJU4/3.a0C5f3zfw3uhPuhTf/YMpQ2NbmLrLbjQcToKBJ.flaDOO', NULL, '2026-01-07 14:07:25', '2026-01-28 22:18:28'),
(24, 'Sospeter Bathoha', 'M', '1975-04-06', 'Kigoma', NULL, 'Ameoa', 'Elicia Sekishahu Kisoma', 3, 'Mbande', '255768920734', 'sbathoha@gmail.com', NULL, 'kiongozi', '$2y$12$2Glk5GwnWBpqYjOBNyZTEeBSNr3tTWsgeII47qtx9p5tT3j5jS/pS', NULL, '2026-01-07 15:08:26', '2026-02-27 14:16:33'),
(25, 'NTULI KAPOLOGWE', 'M', '1985-01-27', 'Mbeya', NULL, 'Ameoa', 'Neema Peter Mndeme', 4, 'Mbande', '255758833304', 'wapastantuli@gmail.com', NULL, 'kiongozi', '$2y$12$0xU/aDhm4x7eg/fei2fm4.1StzE9b463gSl8kKKiYuNRRRsBCpr.q', NULL, '2026-01-17 10:06:48', '2026-01-28 22:20:58'),
(26, 'Neema Mustapha Kiluwasha', 'F', '1994-01-16', 'Bombo Hospital, Tanga', NULL, 'Hajaolewa', NULL, 0, 'Kinondoni', '255658698146', 'neymarkilu@gmail.com', NULL, 'mshirika', '$2y$12$7G2Tscx8n2.93WVzpqKC2OhRiLgbeYF0Q8pliCpJm0Iw09Na6y/VS', NULL, '2026-02-23 10:32:16', '2026-02-23 17:39:06'),
(27, 'Natalia Beza', 'F', '1994-09-11', 'Ilala', NULL, 'Hajaolewa', NULL, 0, 'Keko & Kurasini', '255714991925', 'bezanatalia11@gmail.com', NULL, 'mshirika', '$2y$12$D1V6Od9BDMtE0xZtPeW94.7K0CqtEoLs0tE/JGhTMpfVuITcgzOb.', NULL, '2026-02-23 10:34:16', '2026-02-25 00:16:18'),
(28, 'THEOPHILDA CHRISTOPHER', 'F', '1976-12-26', 'KARAGWE KAGERA', NULL, 'Hajaolewa', NULL, 0, 'Yerusalem', '255655323199', 'theophildachristopher@gmail.com', NULL, 'mshirika', '$2y$12$4P2GqZF9R94.UFZEjOvvFOEzR6fjf7p2SP3tKPJzvfGjlo.dM2OmO', NULL, '2026-02-23 11:23:11', '2026-02-24 09:16:42'),
(29, 'Jacob Sanke Nyoni', 'M', '1992-06-16', 'Kyela- Mveya', NULL, 'Ameoa', 'Lydia Joshua Mwansasu', 2, 'Mbande', '255716654579', 'Jacobsanke52@gmail.com', NULL, 'mshirika', '$2y$12$I9/jF05FR05AJzTBiw1gzeznwtt.SdCIY0s08iAGXHEWLBSOgXndy', NULL, '2026-02-23 12:02:45', '2026-02-27 14:23:11'),
(30, 'HERIEL GABRIEL', 'M', '1990-08-12', 'KOROGWE/TANGA', NULL, 'Ameoa', 'ROSE DAVID KUMENYA', 1, 'Kigamboni', '255712658038', 'herielgabriel61@gmail.com', NULL, 'mshirika', '$2y$12$LKlptvW39mRG129d7RAjlerTTHj7F.gBKUDH6MxHyOHmz5fMvuFqa', NULL, '2026-02-23 12:34:49', '2026-02-24 09:16:31'),
(31, 'AHUNGU MODKY', 'M', '1987-10-30', 'SINGIDA', NULL, 'Ameoa', 'Eliza', 2, 'Kijichi', '255737774790', 'modky3@yahoo.com', NULL, 'mshirika', '$2y$12$PiRNIh9lKOaBQVvdYKkhHeR0ZzZGNcg5fXCosm668yGC7Pt/euV5.', NULL, '2026-02-23 13:22:45', '2026-02-27 15:47:33'),
(32, 'Amos Samwel Ntandu', 'M', '1980-08-08', 'Ikungi/Singida', NULL, 'Ameoa', 'Eduna Mathayo Msubi', 3, 'Mbande', '255754897675', 'samwelamo@gmail.com', NULL, 'mshirika', '$2y$12$gSX2phxQ6l3AkVX/7Tk5Qe3flEruSSmCU57x5tZZqQDH8LQlGSUWu', NULL, '2026-02-23 13:29:53', '2026-02-26 16:26:45'),
(33, 'Elicia Sekishaku Kisoma', 'F', '1975-11-30', 'Kakonko/Kigoma', NULL, 'Ameolewa', 'Sospeter Bathoha', 3, 'Mbande', '255754778376', 'kisoma.elicia@gmail.com', NULL, 'mshirika', '$2y$12$47Urgg9zegD//61n.glGGOXjksja78jpEdq9xYijz7YkytsBGYblG', NULL, '2026-02-23 14:36:15', '2026-03-02 13:33:26'),
(34, 'Erick Andrea', 'M', '1981-02-04', 'Nyamagana', NULL, 'Ameoa', 'Tumain Daniel', 2, 'Mbande', '255657300333', 'erickandrea217@gmail.com', NULL, 'mshirika', '$2y$12$NXQrE2NoMBvz6B7JWabrrOE9F3Ja/9q4SN2oDdXrUyTA4YF82gssu', NULL, '2026-02-23 16:08:59', '2026-02-24 00:52:16'),
(35, 'Hannah Kimicha Rwandalla', 'F', '1966-07-07', 'Dar es salaam', NULL, 'Ameolewa', 'Caleb Joel Rwandalla', 3, 'Kizuiani', '255762748397', 'hannah.rwandala@yahoo.com', NULL, 'mshirika', '$2y$12$Y4shWos9XrnVTnlxyhoLTOp9vkT.Hcw82o9Q01ARoPZBiUehbqX2a', NULL, '2026-02-24 02:17:13', '2026-02-24 09:17:16'),
(36, 'Benedicto Mugongo', 'M', '1984-05-01', 'Buhigwe, Kigoma', NULL, 'Ameoa', 'Grace Dalasi', 3, 'Tandika', '255754244794', 'benjos98@yahoo.com', NULL, 'mshirika', '$2y$12$FN0S.vcxA46TXty2oe72NuLHisP3WpWhYmqzffa1XsN72ef0JM0Oi', NULL, '2026-02-24 09:09:45', '2026-02-24 09:15:07'),
(37, 'Adriano Nashoni Kibhoge', 'M', '1992-10-01', 'Kigoma', NULL, 'Hajaoa', NULL, 0, 'Kigamboni', '255742490455', 'Kibhogeadriano@gmail.com', NULL, 'mshirika', '$2y$12$4VcxPyYa1BszQjWpUpRqsOU8rzx2f0VS1VUOwl2S9fGv2ytqbK4he', NULL, '2026-02-24 10:04:53', '2026-02-24 14:55:47'),
(38, 'Aman Mdewa Nthangu', 'M', '1991-04-06', 'Masasi/Mtwara', NULL, 'Ameoa', 'Beatrice Elia Mhana', 2, 'Kigamboni', '255755146527', 'amanmdewa@gmail.com', NULL, 'mshirika', '$2y$12$iVhWfFlo2p7cE10mcF/7Q.J04QpbY0aCaDoc6J.KZ4Zud4rgdNpku', NULL, '2026-02-24 13:11:17', '2026-02-24 14:55:56'),
(39, 'Elizabeth Christopher Migeto', 'F', '1992-02-10', 'TABORA', NULL, 'Hajaolewa', NULL, 0, 'Kigamboni', '255677149158', 'migetoelizabeth1991@gmail.com', NULL, 'mshirika', '$2y$12$zR4tcq5TL0wOx5KZ546ndu/8qxQpHcdePN1PufAhunKNr8goJxfPS', NULL, '2026-02-24 13:48:07', '2026-02-24 14:58:35'),
(40, 'Neema Kazare', 'F', '1985-02-27', 'Butiama (Mara)', NULL, 'Ameolewa', 'Emmanuel Stephano', 3, 'Yerusalem', '255714842713', 'kazareneema@gmail.com', NULL, 'mshirika', '$2y$12$Nj0E072mfVLRNYAAeEX8DuhPrzLDOsMvJANjvrpzkZtyvwRJ0yxHm', NULL, '2026-02-24 14:26:39', '2026-02-24 14:59:30'),
(41, 'ALFAYO NASHONI KIBOGE', 'M', '1998-04-25', 'KIGOMA', NULL, 'Hajaoa', NULL, 0, 'Mtongani', '255755114343', 'alfayokibhoge@gmail.com', NULL, 'mshirika', '$2y$12$5WPQ61dIXmdjtdhBTAfFDObarDcwBLBNxIrzolrB0PVJ2QJM1qUk2', NULL, '2026-02-24 14:29:17', '2026-02-25 18:28:02'),
(42, 'BEATRICE ELIA MHANA', 'F', '1998-09-07', 'SHINYANGA', NULL, 'Ameolewa', 'AMAN MDEWA NTHANGU', 2, 'Kigamboni', '255764648884', 'mhanabeatrice@gmail.com', NULL, 'mshirika', '$2y$12$qc7DorgBR6pTaNOZZHH8new8Q2IEY6nKF2UbpHYdKyhhOgCFf3S5y', NULL, '2026-02-24 15:31:13', '2026-02-25 11:29:06'),
(43, 'Meshack clement mihayo', 'M', '1992-06-26', 'Shinyanga', NULL, 'Ameoa', 'Jesca yuvinus', 1, 'Mtongani', '255756673176', 'meshackmihayi01@gmail.com', NULL, 'mshirika', '$2y$12$4PsmIgS9gE3aW9seyUVzbOAFr.Q8cFbyNkrEUOPJQ9msLvO1dz2XK', NULL, '2026-02-24 21:15:23', '2026-02-25 15:53:21'),
(44, 'PERECY BEZA', 'F', '1960-10-07', 'Ngara', NULL, 'Mjane', NULL, 4, 'Keko & Kurasini', '255716668317', 'bezaperecy@gmail.com', NULL, 'mshirika', '$2y$12$Zbo5fk0UzXvTOkqrh4kOzeVM8phEYgZXEokSuPgiqehXjSzboP7da', NULL, '2026-02-24 22:20:48', '2026-02-26 17:54:03'),
(45, 'Veronica chavala', 'F', '1967-04-13', 'Mufindi/Iringa', NULL, 'Ameolewa', 'Shelf Shaltiel', 4, 'Mtongani', '255758295657', 'veronicachavala47@gmail.com', NULL, 'mshirika', '$2y$12$2aOI7rmVDjVqXSqeloc2YusIyFPlmQMgAq1Y.bwzCZOV3Kxs0LnDy', NULL, '2026-02-24 22:25:28', '2026-02-24 23:45:35'),
(46, 'Denis Cleophace', 'M', '1991-05-23', 'Nyamagana/Mwanza', NULL, 'Ameoa', 'Uyanjo Idabu', 1, 'Mbande', '255759076332', 'denisbube22@gmail.com', NULL, 'mshirika', '$2y$12$qaGyR5rEYMV6V863ypfeneynNUkCoca93ReUplGtMGUVLU2HCCvCW', NULL, '2026-02-24 23:46:43', '2026-02-25 00:03:36'),
(47, 'Edith Batenzi', 'F', '1992-02-05', 'Ilala', NULL, 'Ameolewa', 'Samwel Batenzi', 0, 'Kigamboni', '255744932734', 'chitedy@gmail.com', NULL, 'mshirika', '$2y$12$bMBk2Rpi0tb94aX1iScaQOlR12WLerAOKZCT5u.u0dpOkX/EtEkRC', NULL, '2026-02-25 02:51:21', '2026-02-27 12:28:44'),
(50, 'GLORIA ANDREW MBWAMBO', 'F', '1984-03-30', 'IRINGA MUNICIPAL', NULL, 'Ameolewa', 'WENCESLAUS FUNGAMTAMA', 3, 'Kigamboni', '255762285686', 'gloria.mbwambo@tcbbank.co.tz', NULL, 'mshirika', '$2y$12$I5BI4JtAr4CPJD7nDW0ZhOmIEqj8xmALROcXJagwyLmy7ju7ay0l2', NULL, '2026-02-25 12:30:09', '2026-02-25 12:34:00'),
(51, 'Felix William', 'M', '1994-10-02', 'Korogwe /Tanga', NULL, 'Ameoa', 'Kezia Shertiely', 1, 'Mtongani', '255679320447', 'felixwilliam808@gmail.com', NULL, 'mshirika', '$2y$12$YUM2kjm./pSH3SIROVINle4MBPwjhr0KuFEo6rCZc0T49BAJTfIk6', NULL, '2026-02-25 17:43:48', '2026-02-25 21:29:17'),
(52, 'NOELA MUSSA', 'F', '1990-12-25', 'Mwanza', NULL, 'Hajaolewa', NULL, 0, 'Mgeninani', '255769531914', 'noelamussa@gmail.com', NULL, 'mshirika', '$2y$12$o3VTwU7QbHSERECLfybmnuyhGwDCyOVIXGiKbSEW5/Zf6HolVl.2e', NULL, '2026-02-25 18:12:55', '2026-02-25 18:37:26'),
(53, 'ANGELA ANTELIMI KALALU', 'F', '1994-11-05', 'Babati Manyara', NULL, 'Ameolewa', 'TUMAINI KAAYA', 0, 'Kijichi', '255787285496', 'angela.kalalu@gmail.com', NULL, 'mshirika', '$2y$12$mwK7IcQs9fQm2.wwfoWhru52cZjNB/JDpImt4H2fZee84fHwVFK5W', NULL, '2026-02-25 18:24:44', '2026-02-25 20:41:28'),
(54, 'Noel Damson Nthangu', 'M', '1986-12-18', 'Newala', NULL, 'Hajaoa', NULL, 0, 'Kinondoni', '255754774918', 'noel.nthangu@udsm.ac.tz', NULL, 'mshirika', '$2y$12$mxaurhgIAbLhw.Ncf5FgVuZQ/37TNxWyntn5wlHQ4vlogILoXi8wm', NULL, '2026-02-25 18:51:46', '2026-02-25 18:55:30'),
(55, 'Sam Batenzi', 'M', '1988-02-05', 'Mwanza', NULL, 'Ameoa', 'Edith Beza', 0, 'Kigamboni', '255747584779', 'sbatenzi@gmail.com', NULL, 'mshirika', '$2y$12$UCKpiu5EOpK6hH5039CBBurVQIzBT0RzbBOGuy7VYhx/IPmPAiys.', NULL, '2026-02-25 19:06:15', '2026-02-25 20:11:56'),
(56, 'ANOLD GIDION FUMBUKA', 'M', '1998-10-31', 'KINONDONI / DAR ES SALAAM', NULL, 'Hajaoa', NULL, 0, 'Kinondoni', '255686360843', 'fumbukajr97@gmail.com', NULL, 'mshirika', '$2y$12$J4CJjFvaE0qhFsTEH/5C4uGZA1yI5LIiMi3kWwRtKm2UIv2cCejWG', NULL, '2026-02-25 22:00:08', '2026-02-25 22:45:50'),
(57, 'ESTER MATHAYO CHARLES', 'F', '2002-04-01', 'MAGU / MWANZA', NULL, 'Hajaolewa', NULL, 0, 'Yerusalem', '255612145642', 'estercharles719@gmail.com', NULL, 'mshirika', '$2y$12$vxMt/wezF6/Jg7n88sLsxuGXD4OKoY.NpBV10ZnIObSqOSISN2SH.', NULL, '2026-02-25 22:13:21', '2026-02-26 00:45:04'),
(58, 'Theresia kindole', 'F', '1993-12-12', 'Temeke Dar es Salaam', NULL, 'Ameolewa', 'Elisha Makiya', 0, 'Mgeninani', '255717480049', 'thersiakindole@gmail.com', NULL, 'mshirika', '$2y$12$Z/OWPpb9SsHAqzbfAW5V1ePnepS4wAodcxXTfIkkCRid5bJeW4Woi', NULL, '2026-02-26 00:36:02', '2026-02-26 00:39:14'),
(59, 'Jane Martin', 'F', '1972-12-28', 'Busega/Simiyu', NULL, 'Ameolewa', 'Reuben Bulugu', 5, 'Kongowe', '255786504664', 'janemartn2@gmail.com', NULL, 'mshirika', '$2y$12$2xLMlzA.zGMIp5wVllL.JuwEs3bpuLtIW/JcZtwyAHEqpdl7j9J/y', NULL, '2026-02-26 01:05:41', '2026-02-26 01:28:10'),
(60, 'UYANJO JOHN', 'F', '1996-06-08', 'Temeke/Dar es salaam', NULL, 'Ameolewa', 'DENIS CLEOPHACE', 1, 'Mbande', '255674918283', 'uyanjo96@gmail.com', NULL, 'mshirika', '$2y$12$0ogK1sdlQMzd206AljMHo.byak92.V8owvTZn7Qr9OzLgnblrolLG', NULL, '2026-02-26 02:07:11', '2026-02-26 15:29:58'),
(61, 'Wenceslaus Benedict Fungamtama', 'M', '1978-01-09', 'Musoma, Mara', NULL, 'Ameoa', 'Gloria', 3, 'Kigamboni', '255754502656', 'fungamtama@yahoo.com', NULL, 'kiongozi', '$2y$12$WDLC7TsAUvTetB5xtXTOpefvOA2K11Gz0jqstQod.RTnTK91BtV/W', NULL, '2026-02-26 15:27:13', '2026-02-28 00:04:10'),
(62, 'Alam Alexander', 'M', '1994-04-18', 'Kigoma', NULL, 'Ameoa', 'Rachel Andrew Machupa', 0, 'Yerusalem', '255761360607', 'alamalexander3@gmail.com', NULL, 'mshirika', '$2y$12$pNds2sehYscBWpG/ka48XeEM./luyJ0dON3qmoNwwuQkjg/shl23.', NULL, '2026-02-26 16:42:37', '2026-02-27 17:06:12'),
(63, 'AUGUSTINO MADAKI BONIPHACE', 'M', '1984-11-20', 'Nzega, Tabora', NULL, 'Ameoa', 'Emiliana Mwita Nyakaraita', 5, 'Mgeninani', '255757445207', 'tmadaki48@gmail.com', NULL, 'mshirika', '$2y$12$4gCrAqJFa2LzMFp2HGVEDO7Ptp588TTxEfMRmmm/TTr9s2ma0Yy7u', NULL, '2026-02-27 01:07:31', '2026-02-27 01:18:25'),
(64, 'MAGRETH SYLIVESTER ROBERT', 'F', '1999-03-23', 'NZEGA/TABORA', NULL, 'Hajaolewa', NULL, 0, 'Yerusalem', '255746562364', 'magrethrobert23@gmail.com', NULL, 'mshirika', '$2y$12$LCNfNqB79BmNtwm.W6zSXOa7Boru1t/WHQ.VUD1MNxbWM59.VcbMe', NULL, '2026-02-27 13:12:03', '2026-02-27 13:35:07'),
(65, 'Kepha Thomas Michael', 'M', '1990-06-26', 'Ikungi', NULL, 'Ameoa', 'Numwagile Ackim Mwakipale', 1, 'Mgeninani', '255713863847', 'kephamichael26@gmail.com', NULL, 'mshirika', '$2y$12$5JNf19nSNw.oM67uhDOD1ufGrcFxqBHwfMWFLUfmvR6iIGgxUJ6Lq', NULL, '2026-02-27 13:19:07', '2026-02-27 16:25:48'),
(66, 'JONAS MARCO MPANZO', 'M', '1994-09-10', 'Mwanza', NULL, 'Ameoa', 'Illah', 1, 'Kinondoni', '255767939928', 'mpanzojonas@gmail.com', NULL, NULL, '$2y$12$WZeDtKKOeyxkjsVBUXDKr.oS2v6utkl8mDs5uT.Zttu.EfZinXbi6', NULL, '2026-02-27 15:59:02', '2026-02-27 15:59:02'),
(67, 'Aloyce Godfrey Beza', 'M', '1988-10-29', 'Ilala', NULL, 'Ameoa', 'Lydia Msabaha', 1, 'Yerusalem', '255713213731', 'bezaaloyce@yahoo.com', NULL, 'mshirika', '$2y$12$osapo0iFHpG/CuJWcjGaZ.Oa2VihzZjay9zrUYyH/RMd7RTpxxu0u', NULL, '2026-02-27 16:13:16', '2026-02-27 16:26:01'),
(68, 'lydia msabaha midello', 'F', '1991-05-19', 'Ilala - Dar es salaam', NULL, 'Ameolewa', 'Aloyce Beza', 1, 'Yerusalem', '255719453147', 'lydiamsabaha@gmail.com', NULL, 'mshirika', '$2y$12$CLQjJ0qC7mjq5mA0lM0Ure2qwh3vwq7dnxR2ua80mI/ppWGO7sU/m', NULL, '2026-02-27 18:32:32', '2026-02-28 17:48:27'),
(69, 'Ebenezer Mathew', 'M', '2001-07-27', 'Dar es Salaam', NULL, 'Hajaoa', NULL, 0, 'Kijichi', '255788359022', 'ebenezer.mathew@icloud.com', NULL, NULL, '$2y$12$bU9uk/aXNsOgbEhFkspny.ep7TLABdQkv4nDySn3bJCCscAbe7RIO', NULL, '2026-02-27 20:20:49', '2026-02-27 20:20:49'),
(70, 'Philomena Solomon Muhamila', 'F', '1976-12-13', 'Kigoma, sanze', NULL, 'Ameolewa', 'Suleiman Mathew Ikomba', 3, 'Mgeninani', '255756945201', 'philomenamuhamila77@gmail.com', NULL, 'mshirika', '$2y$12$fRnh213XmcempP4Ivpz8QuKDHEJhz6nN4PrEZTx.KDDOxa01Iesd6', NULL, '2026-02-27 20:30:36', '2026-02-28 17:48:36'),
(71, 'David Fredrick Mhando', 'M', '1982-12-12', 'Handeni-Tanga', NULL, 'Ameoa', 'Lucy Obadia Ndilaliha', 3, 'Mgeninani', '255755624764', 'david.mhando82@gmail.com', NULL, 'mshirika', '$2y$12$5bkx3SIkQMLuT4wZXBX5HuEFLIVvzWYSoXmzAoheukqtYCe7g2ZwW', NULL, '2026-02-28 01:21:33', '2026-02-28 08:39:21'),
(72, 'Javan Jerome Zablon', 'M', '1988-06-15', 'Kigoma', NULL, 'Hajaoa', NULL, 0, 'Yerusalem', '255713625929', 'javan.jerome@gmail.com', NULL, 'mshirika', '$2y$12$5bFE41r.jAieYJfqIL3AR.B5nhg8prwPAsuSpjKbeupBPwKzW2kVK', NULL, '2026-02-28 18:38:56', '2026-03-01 17:37:49'),
(73, 'FREDRICK JACOB BALIGOMWA', 'M', '1976-04-30', 'KASULU KIGOMA', NULL, 'Ameoa', 'Sorange Mathias Musavi', 4, 'Tandika', '255784681321', 'jacobbali.jb47@gmail.com', NULL, NULL, '$2y$12$PeSOz87QqqF1kg9yooltp.D5ah6Inutq/JPbAuuPvds7m90MeArmW', NULL, '2026-02-28 23:50:39', '2026-02-28 23:50:39'),
(74, 'Ndungutse Yosia Misigaro', 'M', '1985-08-18', 'Kigoma', NULL, 'Ameoa', 'Fatuma Abubakar Ngarama', 2, 'Kinondoni', '255654999179', 'bitanandungutse@yahoo.com', NULL, 'mshirika', '$2y$12$PKSm6A6iZT1IcLTlmCGHye/aJfPgzwhVQMfnbgLzWBkTtpJ8cGjSW', NULL, '2026-03-01 00:21:30', '2026-03-01 17:38:08'),
(75, 'Ayoub Isaac Butandu', 'M', '1993-07-04', 'Kibonzo Kigoma', NULL, 'Ameoa', 'Queen Samwel', 1, 'Keko & Kurasini', '255764284549', 'ayoubbutandu@gmail.com', NULL, 'mshirika', '$2y$12$ElNVZx45p165.oV9zugv1OoeCgY3f5yPhrM.YiebtMKbc/viut/JC', NULL, '2026-03-01 01:24:52', '2026-03-02 15:58:42'),
(76, 'Jacqueline  Maduka', 'F', '1987-11-12', 'Maswa', NULL, 'Ameolewa', 'Peter Maduka', 1, 'Mbande', '255673073841', 'budagajacqueline@gmail.com', NULL, 'mshirika', '$2y$12$iLSNSjvQLuo78UWiCWjoTOgtuMZb2KwLUDynDFgKgHNNUWn78gGpO', NULL, '2026-03-01 16:31:52', '2026-03-01 17:38:30'),
(77, 'Patrick Ibrahim Makuhi', 'M', '2001-09-13', 'Ilala', NULL, 'Hajaoa', NULL, 0, 'Mgeninani', '255748589142', 'pmakuhi@gmail.com', NULL, 'mshirika', '$2y$12$sST6PIKYqz/Achkp5kIDt.3TQNtMaJIXD1A.OmTQuiIpKe4sV7.ai', NULL, '2026-03-01 17:02:25', '2026-03-02 15:58:43'),
(78, 'Laurencia  Thomas Mlawa', 'F', '1958-10-10', 'Iringa vijijini', NULL, 'Mjane', NULL, 1, 'Kingugi', '255716572056', 'mlawa1958@gmail.com', NULL, 'mshirika', '$2y$12$UnJWO4BfrIL9PAnsZL7xo.GMDZTCShGFsFwQF6oxcrtrHkaussvPe', NULL, '2026-03-01 18:17:27', '2026-03-01 18:20:06'),
(79, 'FATUMA ABUBAKARI NGARAMA', 'F', '1990-06-05', 'KAHAMA', NULL, 'Ameolewa', 'NDUNGUTSE YOSIA MISIGARO', 2, 'Kinondoni', '255658588591', 'fatumangarama@yahoo.com', NULL, 'mshirika', '$2y$12$n.tlh/NDtcNqj9z/M.WrbO1G0qJM4lf9nQPZKGAxdpwAKQ31mk39m', NULL, '2026-03-02 02:03:31', '2026-03-02 14:07:06'),
(80, 'ROSE DAVID KUMENYA', 'F', '1998-06-21', 'TABORA CBD', NULL, 'Ameolewa', 'HERIEL GABRIEL MWAMPULO', 1, 'Kigamboni', '255758625618', 'rosedavir26@icloud.com', NULL, 'mshirika', '$2y$12$7o5Deov9ajaKgdxqFpPUu.k2UYyno0SMTht/u9PSu97BA55AwQhYi', NULL, '2026-03-02 21:47:49', '2026-03-02 22:38:32'),
(81, 'Jumanne John Mbilao', 'M', '1973-08-31', 'Sumbawanga- Rukwa', NULL, 'Ameoa', 'Juliana Mboma', 3, 'Kinondoni', '255767800507', 'mbilaojj@gmail.com', NULL, 'mshirika', '$2y$12$pUk5DRZ4c6WuSlp1dTqeCeEaSYgYJ70ZPyqyBufw4tYC0v6UzdWsa', NULL, '2026-03-03 12:13:31', '2026-03-03 12:16:25'),
(82, 'Doto Geofrey Chima', 'F', '1991-03-02', 'Masasi Mtwara', NULL, 'Ameolewa', 'Boniphace Eliakim Nicodem', 1, 'Mtongani', '255768549003', 'dotochima287@gmail.com', NULL, 'mshirika', '$2y$12$UctJIQUMnhQsJ5wTp7vTPe1PWuveEd.aUXjYn7a.GfmyMCJlNPyH2', NULL, '2026-03-03 20:58:33', '2026-03-04 14:52:55'),
(83, 'NEZIA SHELF SHERTIELY', 'F', '2021-04-14', 'ILALA / DAR ES SALAAM', NULL, 'Hajaolewa', NULL, 0, 'Mtongani', '255767435625', 'neziashertiely@gmail.com', NULL, 'mshirika', '$2y$12$jDN0rVwDsVr8aSOyfGJ/vuXjLO3RBzXZW7qTlbuwjE6F7idj/hyv6', NULL, '2026-03-03 22:08:37', '2026-03-04 01:26:40'),
(84, 'Ernest Gyunda', 'M', '1966-10-21', 'Kiomboi', NULL, 'Mgane', NULL, 4, 'Kinondoni', '255784299942', 'ernestgyunda12@gmail.com', NULL, 'mshirika', '$2y$12$LuVV9V0eMLTMwDvIIBiUqOcWtCOZlme4n1F.9mwfONUnx/cbaMURS', NULL, '2026-03-03 22:19:15', '2026-03-04 01:26:25'),
(85, 'Joseph William Makange', 'M', '1998-03-29', 'Shinyanga', NULL, 'Ameoa', 'Angel William', 0, 'Kigamboni', '255626536720', 'josephmakange95@gmail.com', NULL, 'mshirika', '$2y$12$YXxZKuibJO6bzX363M2PDOMtiufCMEhb5.QYQf4HTDRp9NmENEwM.', NULL, '2026-03-03 22:38:38', '2026-03-04 14:52:28'),
(86, 'Faraja Anthony Rutebuka', 'F', '1998-05-05', 'Kigoma', NULL, 'Hajaolewa', NULL, 0, 'Kongowe', '255758159929', 'anthonyfaraja7@gmail.com', NULL, 'mshirika', '$2y$12$a3PoG8h7SXfKC1vMH/DZCuzw6G3TyflNjZrjFUjc6h5G7rlRGfRvy', NULL, '2026-03-03 23:34:35', '2026-03-04 11:20:45'),
(87, 'Witness Morice', 'F', '1977-10-20', 'Kigoma', NULL, 'Ameolewa', 'Morice Michael', 3, 'Mgeninani', '255682956632', 'witnessmorice2@gmail.com', NULL, 'mshirika', '$2y$12$60sWmUogSYhBt9v4b3EF/el0t/L.wEpx7h5yH5qr9MQOxzq8UZ.gW', NULL, '2026-03-04 01:04:01', '2026-03-04 14:52:35'),
(88, 'Jane Joseph Elias', 'F', '2001-05-27', 'Katavi', NULL, 'Hajaolewa', NULL, 0, 'Mbande', '255748375141', 'Josephjane@gmail.com', NULL, NULL, '$2y$12$Wj3hR2rFm3dyvkgkLkh5buWSEO1FcK68OWDZ287dLd5lZbh02qYpq', NULL, '2026-03-04 14:27:16', '2026-03-04 14:27:16'),
(89, 'Angel William Makange', 'F', '2000-05-19', 'Ilemela', NULL, 'Ameolewa', 'Joseph William Makange', 0, 'Kigamboni', '255612639779', 'vijitotours@gmail.com', NULL, NULL, '$2y$12$bJn/qMwdYAmNskh9gmV2JeOfDoewvl8uIADdMRtQeC8KCmguVNu1O', NULL, '2026-03-04 15:40:16', '2026-03-04 15:40:16'),
(90, 'Rachel Gyunda', 'F', '2001-10-15', 'Tabora', NULL, 'Hajaolewa', NULL, 0, 'Kinondoni', '255678121710', 'rachelgyunda868@gmail.com', NULL, NULL, '$2y$12$RObVzhHRCgLjva5B32BcBeVN7kQqgm7KIQ1zwm163mxabwAZ5uTK.', NULL, '2026-03-04 18:00:10', '2026-03-04 18:00:10');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `deleted_members`
--
ALTER TABLE `deleted_members`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `galleries`
--
ALTER TABLE `galleries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `leadership_roles`
--
ALTER TABLE `leadership_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `leader_leadership_role`
--
ALTER TABLE `leader_leadership_role`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=645;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sms_logs`
--
ALTER TABLE `sms_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=228;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

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
