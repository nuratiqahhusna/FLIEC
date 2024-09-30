-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 25, 2024 at 08:59 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flood`
--

-- --------------------------------------------------------

--
-- Table structure for table `disease_detail`
--

CREATE TABLE `disease_detail` (
  `disease_id` int(4) NOT NULL,
  `disease_categ` varchar(20) NOT NULL,
  `disease_name` varchar(100) NOT NULL,
  `victim_ic_no` varchar(14) NOT NULL,
  `pps_id` int(4) NOT NULL,
  `note` varchar(50) NOT NULL,
  `after_checkup` varchar(100) NOT NULL,
  `victim_covid_check` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `disease_detail`
--

INSERT INTO `disease_detail` (`disease_id`, `disease_categ`, `disease_name`, `victim_ic_no`, `pps_id`, `note`, `after_checkup`, `victim_covid_check`) VALUES
(3, 'INFECTIOUS', 'HEPATITIS A', '041109-08-0632', 1, 'SAKIT KEPALA ', 'KONJUNKTIVITIS, PENYAKIT KULIT, HEPATITIS A, KOLERA, MELIOIDOSIS', 'YES'),
(4, 'NON-INFECTIOUS', 'HYPERTENSION, AGE', '937290-37-2918', 2, 'SAKIT PERUT', 'AGE, PENYAKIT KULIT, HYPERTENSION', 'NO'),
(5, 'BOTH', 'AGE, HEPATITIS A, HYPERTENSION', '712750-25-5076', 1, 'SAKIT PERUT', 'AGE, ARI / URTI, HEPATITIS A, HYPERTENSION', 'NO'),
(6, 'BOTH', 'ARI/URTI, CHICKEN POX, HYPERTENSION', '038038-39-3292', 1, '', 'ARI/URTI, MELIOIDOSIS', 'NO'),
(7, 'BOTH', 'ARI/URTI, CHICKEN POX, HYPERTENSION', '038038-39-3276', 1, '', 'ARI/URTI, MELIOIDOSIS', 'NO'),
(8, 'BOTH', 'ARI/URTI, DEMAM, TIFOID, DIABETES MELLITUS', '308408-40-3840', 1, '', '', 'NO'),
(9, 'BOTH', 'AGE, ARI/URTI', '348048-33-8384', 1, 'SAKIT PERUT', '', 'NO'),
(10, 'BOTH', 'DEMAM, DIABETES MELLITUS', '947937-30-4734', 1, '', '', 'NO'),
(11, 'INFECTIOUS', 'KONJUNKTIVITIS', '347304-74-7340', 1, '', '', 'NO');

--
-- Triggers `disease_detail`
--
DELIMITER $$
CREATE TRIGGER `set_disease_cetagory_before_insert` BEFORE INSERT ON `disease_detail` FOR EACH ROW BEGIN
    SET NEW.disease_categ = 
    CASE 
        WHEN NEW.disease_name IN ('AGE', 'ARI/URTI', 'KONJUNKTIVITIS', 'PENYAKIT KULIT', 'DEMAM', 'TIFOID', 'HEPATITIS A', 'KOLERA', 'CHICKEN POX', 'LEPTOSPIROSIS', 'MELIOIDOSIS', 'DENGGI') THEN 'INFECTIOUS'
        WHEN NEW.disease_name IN ('DIABETES MELLITUS', 'HYPERTENSION') THEN 'NON-INFECTIOUS'
        WHEN NEW.disease_name = 'TIADA' THEN 'NONE'
        ELSE 'BOTH'
    END;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `flood_supply`
--

CREATE TABLE `flood_supply` (
  `supply_name` varchar(50) NOT NULL,
  `supply_id` int(4) NOT NULL,
  `stock` int(4) NOT NULL,
  `pps_id` int(4) NOT NULL,
  `supply_type` int(4) NOT NULL,
  `status` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `flood_supply`
--

INSERT INTO `flood_supply` (`supply_name`, `supply_id`, `stock`, `pps_id`, `supply_type`, `status`) VALUES
('Tikar', 1, 38, 1, 0, 0),
('Selimut', 2, 96, 1, 0, 0),
('Kain Pelikat', 3, 2, 1, 0, 0),
('Kain Batik', 4, 0, 1, 0, 0),
('Tuala', 5, 0, 1, 0, 0),
('Comforter', 6, 0, 1, 0, 0),
('Hygiene Kit', 7, 0, 1, 0, 0),
('Refreshment', 8, 0, 1, 0, 0),
('Beras', 11, 0, 1, 1, 0),
('Gula Pasir', 12, 0, 1, 1, 0),
('Minyak Masak', 13, 0, 1, 1, 0),
('Ikan Kering/Bilis', 14, 0, 1, 1, 0),
('Telur', 15, 0, 1, 1, 0),
('Kopi/Teh', 16, 0, 1, 1, 0),
('Garam', 17, 0, 1, 1, 0),
('Makanan Dalam Tin', 18, 0, 1, 1, 0),
('Tepung', 19, 0, 1, 1, 0),
('Air Mineral', 20, 0, 1, 1, 0),
('Bihun/Mee', 21, 0, 1, 1, 0),
('Biskut', 22, 0, 1, 1, 0),
('Susu Pekat', 23, 0, 1, 1, 0),
('Sardin', 24, 0, 1, 1, 0),
('Foam Mat', 25, 90, 1, 2, 0),
('Kerusi Roda', 26, 97, 1, 2, 0),
('Alat Sokongan', 27, 97, 1, 2, 0),
('T-Shirt', 28, 0, 1, 2, 0),
('Track Bottom', 29, 0, 1, 2, 0),
('Lampin Pakai Buang', 30, 0, 1, 2, 0),
('Tuala Wanita', 31, 0, 1, 2, 0),
('Pakaian Dalam ', 32, 0, 1, 2, 0),
('Bantal ', 33, 0, 1, 2, 0),
('Lilin', 34, 0, 1, 2, 0),
('Susu Tepung', 35, 0, 1, 2, 0),
('Tilam', 36, 0, 1, 2, 0),
('Tikar', 37, 0, 2, 0, 0),
('Selimut', 38, 0, 2, 0, 0),
('Kain Pelikat', 40, 0, 2, 0, 0),
('Kain Batik', 41, 0, 2, 0, 0),
('Tuala', 42, 0, 2, 0, 0),
('Comforter', 43, 0, 2, 0, 0),
('Hygiene Kit', 44, 0, 2, 0, 0),
('Refresment', 45, 0, 2, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `pps_detail`
--

CREATE TABLE `pps_detail` (
  `pps_id` int(4) NOT NULL,
  `pps_name` varchar(50) NOT NULL,
  `pps_status` varchar(20) NOT NULL,
  `pps_open_date` date DEFAULT NULL,
  `pps_close_date` date DEFAULT NULL,
  `pps_capacity` int(4) NOT NULL,
  `pps_district` int(4) NOT NULL,
  `pps_occupancy` int(4) NOT NULL,
  `pps_categ` int(4) NOT NULL,
  `pps_address` varchar(100) NOT NULL,
  `pps_latitude` varchar(13) NOT NULL,
  `pps_longitude` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pps_detail`
--

INSERT INTO `pps_detail` (`pps_id`, `pps_name`, `pps_status`, `pps_open_date`, `pps_close_date`, `pps_capacity`, `pps_district`, `pps_occupancy`, `pps_categ`, `pps_address`, `pps_latitude`, `pps_longitude`) VALUES
(1, 'SK SEPAKAT JAYA', 'TIDAK AKTIF', '2024-06-02', '2024-06-11', 500, 1, 0, 1, 'JALAN YONG PENG, KAMPUNG SERI SEPAKAT, 83700, YONG PENG, JOHOR', '0', '0'),
(2, 'SJKC LAM LEE', 'AKTIF', '2024-07-02', '2024-08-01', 500, 1, 0, 1, 'KG LAM LEE, 83720, YONG PENG, JOHOR ', '0', '0'),
(3, 'SJKC CHONG HWA', '', NULL, NULL, 500, 2, 0, 1, '', '0', '0'),
(4, 'SEKOLAH AGAMA KG BAHRU', 'AKTIF', '2024-06-11', '2024-06-24', 400, 2, 0, 1, '', '0', '0'),
(5, 'SK BINDU', '', NULL, NULL, 500, 3, 0, 1, '', '0', '0'),
(6, 'SK AGAMA SERI TELOK', '', NULL, NULL, 500, 3, 0, 1, '', '0', '0'),
(7, 'SK SERI BINJAI ', '', NULL, NULL, 500, 3, 0, 1, '', '0', '0'),
(8, 'SK SERI TELOK', '', NULL, NULL, 500, 3, 0, 1, '', '0', '0'),
(9, 'SK BUKIT RAHMAT', '', NULL, NULL, 400, 3, 0, 1, '', '0', '0'),
(10, 'SMK SERI BENGKEL', '', NULL, NULL, 700, 3, 0, 1, '', '0', '0'),
(11, 'SMK TUNKU PUTRA', '', NULL, NULL, 600, 3, 0, 1, '', '0', '0'),
(12, 'SEKOLAH AGAMA SRI BENGKAL', '', NULL, NULL, 500, 3, 0, 1, '', '0', '0'),
(13, 'SEKOLAH AGAMA BUKIT RAHMAT', '', NULL, NULL, 600, 3, 0, 1, '', '0', '0'),
(14, 'SEKOLAH AGAMA SERI BINJAI', '', NULL, NULL, 600, 3, 0, 1, '', '0', '0'),
(15, 'SJKC TONGKANG', '', NULL, NULL, 500, 3, 0, 1, '', '0', '0'),
(16, 'SJKC LI CHUN', '', NULL, NULL, 500, 3, 0, 1, '', '0', '0'),
(17, 'DEWAN ORANG RAMAI SERI MEDAN', '', NULL, NULL, 500, 3, 0, 2, '', '0', '0'),
(18, 'DEWAN ORANG RAMAI PARIT YAANI', '', NULL, NULL, 600, 3, 0, 2, '', '0', '0'),
(19, 'SEKOLAH SERI JAYA SEPAKAT', 'AKTIF', '2024-06-18', NULL, 500, 3, 0, 1, '', '0', '0'),
(20, 'SK KOTA DALAM ', '', NULL, NULL, 700, 4, 0, 1, '', '0', '0'),
(21, 'SK BUKIT KUARI', '', NULL, NULL, 500, 4, 0, 1, '', '0', '0'),
(22, 'SK PINTAS PUDING', '', NULL, NULL, 600, 4, 0, 1, '', '0', '0'),
(23, 'SK SERI AMAN', '', NULL, NULL, 700, 4, 0, 1, '', '0', '0'),
(24, 'SK AIR HITAM', '', NULL, NULL, 500, 4, 0, 1, '', '0', '0'),
(25, 'MASJID KG PARIT PUASA', '', NULL, NULL, 500, 4, 0, 3, '', '0', '0'),
(26, 'SK SERI UTAMA', '', NULL, NULL, 300, 5, 0, 1, '', '0', '0'),
(27, 'SK SRI BEROLEH', '', NULL, NULL, 500, 6, 0, 1, '', '0', '0'),
(28, 'SK SRI GADING', '', NULL, NULL, 700, 6, 0, 1, '', '0', '0'),
(29, 'SK PARIT BILAL', '', NULL, NULL, 600, 6, 0, 1, '', '0', '0'),
(30, 'SEKOLAH AGAMA AIR PUTIH', '', NULL, NULL, 300, 6, 0, 1, '', '0', '0'),
(31, 'SEKOLAH AGAMA BINDU', '', NULL, NULL, 500, 6, 0, 1, '', '0', '0'),
(32, 'DEWAN SERBAGUNA SERI BANI', '', NULL, NULL, 700, 6, 0, 2, '', '0', '0'),
(34, 'SK SERI TANJUNG', '', NULL, NULL, 500, 7, 0, 1, '', '0', '0'),
(35, 'SK SERI MAIMON', '', NULL, NULL, 500, 7, 0, 1, '', '0', '0'),
(36, 'SK SRI PADANG SARI', '', NULL, NULL, 500, 7, 0, 1, '', '0', '0'),
(37, 'SK SRI TANJUNG', '', NULL, NULL, 600, 7, 0, 1, '', '0', '0'),
(38, 'SMK DATO SULAIMAN', '', NULL, NULL, 600, 7, 0, 1, '', '0', '0'),
(39, 'SMK PENGHULU SAAD', '', NULL, NULL, 700, 7, 0, 1, '', '0', '0'),
(40, 'SEKOLAH SERI CHANTEK', '', NULL, NULL, 800, 7, 0, 1, '', '0', '0'),
(41, 'SEKOLAH AGAMA SRI MAIMON', '', NULL, NULL, 400, 7, 0, 1, '', '0', '0'),
(42, 'SK SERI TIGA SERANGKAI', '', NULL, NULL, 500, 8, 0, 1, '', '0', '0'),
(43, 'SK SERI LAKSANA, PARIT SULONG', '', NULL, NULL, 500, 8, 0, 1, '', '0', '0'),
(44, 'SK SEJANGONG, SERI MEDAN', '', NULL, NULL, 700, 8, 0, 1, '', '0', '0'),
(45, 'SK SERI PEMATANG RENGAS ', '', NULL, NULL, 600, 8, 0, 1, '', '0', '0'),
(46, 'SK TENAGA SETIA ', '', NULL, NULL, 500, 8, 0, 1, '', '0', '0'),
(47, 'SK SERI MEDAN', '', NULL, NULL, 500, 8, 0, 1, '', '0', '0'),
(48, 'SEKOLAH AGAMA PARIT SULONG', '', NULL, NULL, 500, 8, 0, 1, '', '0', '0'),
(49, 'SEKOLAH AGAMA KANGKAR MERLIMAU', '', NULL, NULL, 300, 8, 0, 1, '', '0', '0'),
(50, 'SEKOLAH AGAMA TENAGA SETIA', '', NULL, NULL, 300, 8, 0, 1, '', '0', '0'),
(51, 'SEKOLAH AGAMA SERI MEDAN', '', NULL, NULL, 500, 8, 0, 1, '', '0', '0'),
(52, 'SJKC 1 YONG PENG ', '', NULL, NULL, 500, 8, 0, 1, '', '0', '0'),
(53, 'SJKC PT YAANI', '', NULL, NULL, 600, 8, 0, 1, '', '0', '0'),
(54, 'SMK SERI MEDAN', '', NULL, NULL, 600, 8, 0, 1, '', '0', '0'),
(55, 'DEWAN ORANG RAMAI PARIT SULONG', '', NULL, NULL, 600, 8, 0, 2, '', '0', '0'),
(56, 'PPK SERI MEDAN', '', NULL, NULL, 500, 8, 0, 2, '', '0', '0'),
(57, 'SK SERI PASIR PUTEH', '', NULL, NULL, 500, 9, 0, 1, '', '0', '0'),
(58, 'SK TAMAN SERI KOTA', '', NULL, NULL, 600, 9, 0, 1, '', '0', '0'),
(59, 'SK SRI BANDAN', '', NULL, NULL, 500, 9, 0, 1, '', '0', '0'),
(60, 'SK SERI MANGGIS', '', NULL, NULL, 500, 9, 0, 1, '', '0', '0'),
(61, 'SK SERI BERTAM', '', NULL, NULL, 700, 9, 0, 1, '', '0', '0'),
(62, 'SK AGAMA TAMAN SERI KOTA', '', NULL, NULL, 500, 9, 0, 1, '', '0', '0'),
(63, 'SK SERI BULAN', '', NULL, NULL, 600, 9, 0, 1, '', '0', '0'),
(64, 'SK SERI BENUT PT RAJA', '', NULL, NULL, 600, 9, 0, 1, '', '0', '0'),
(65, 'SK AGAMA SERI IDAMAN TANJONG SEMBRONG ', '', NULL, NULL, 500, 9, 0, 1, '', '0', '0'),
(66, 'SEKOLAH AGAMA SERI BERTAM', '', NULL, NULL, 600, 9, 0, 1, '', '0', '0'),
(67, 'SEKOLAH AGAMA SRI TANJUNG', '', NULL, NULL, 500, 9, 0, 1, '', '0', '0'),
(68, 'SEKOLAH AGAMA SRI BULAN', '', NULL, NULL, 600, 9, 0, 1, '', '0', '0'),
(69, 'SMK DATO SETH', '', NULL, NULL, 600, 9, 0, 1, '', '0', '0'),
(70, 'SMK YONG PENG', '', NULL, NULL, 500, 9, 0, 1, '', '0', '0'),
(71, 'YONG PENG HIGHSCHOOL', '', NULL, NULL, 700, 9, 0, 1, '', '0', '0'),
(72, 'DEWAN GELANGGANG BOLA KERANJANG TAMAN DESA PUTIH', '', NULL, NULL, 300, 9, 0, 2, '', '0', '0'),
(73, 'DEWAN ORANG RAMAI YONG PENG', '', '2024-06-19', NULL, 300, 9, 0, 2, '', '0', '0'),
(96, 'SMK CHAAH', 'TIDAK AKTIF', NULL, NULL, 200, 1, 0, 1, 'JALAN KG. JAWA BARU, KAMPUNG JAWA BARU, 85400 CHAAH, JOHOR', '2435553', '2424434'),
(97, 'SEKOLAH LELAKI', 'TIDAK AKTIF', '0000-00-00', '0000-00-00', 70, 1, 0, 1, 'HUHIBUBIB', '90979', '90979');

-- --------------------------------------------------------

--
-- Table structure for table `staff_info`
--

CREATE TABLE `staff_info` (
  `staff_id` int(4) NOT NULL,
  `staff_name` varchar(50) NOT NULL,
  `staff_phone_no` varchar(16) NOT NULL,
  `staff_position` varchar(30) NOT NULL,
  `staff_tasks` varchar(100) NOT NULL,
  `staff_date` date DEFAULT NULL,
  `staff_shift_start` time NOT NULL,
  `staff_shift_end` time NOT NULL,
  `staff_agency` varchar(3) NOT NULL,
  `pps_id` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff_info`
--

INSERT INTO `staff_info` (`staff_id`, `staff_name`, `staff_phone_no`, `staff_position`, `staff_tasks`, `staff_date`, `staff_shift_start`, `staff_shift_end`, `staff_agency`, `pps_id`) VALUES
(8, 'AHMAD IRFAN BIN ALI', '+60 11-1583 4691', 'PASUKAN PERUBATAN', 'PEMERIKSAAN KESIHATAN', '2024-06-24', '04:44:00', '16:44:00', 'KKM', 26),
(9, 'HUSNA SARAH', '+60 11-1583 4691', 'PASUKAN KESIHATAN', 'PEMERIKSAAN PERSEKITARAN', NULL, '00:00:00', '00:00:00', 'KKM', 14),
(12, 'AIN AINA', '+60 11-1583 4691', 'PASUKAN PERUBATAN', 'PEMERIKSAAN PERSEKITARAN', '2024-06-19', '22:22:00', '22:22:00', 'KKM', 30),
(13, 'AININA NAJWA', '345454', 'PASUKAN PERUBATAN', 'PEMERIKSAAN PERSEKITARAN', '2024-06-11', '05:55:00', '05:55:00', 'KKM', 39),
(14, 'AMIRAHTUL NINA', '+60 19-222 7476', 'BHG. BANTUAN', 'BANTUAN BEKALAN', '2024-06-04', '04:44:00', '16:56:00', 'JKM', 1),
(17, 'FARAH ADILA', '373907409', 'PEMBANTU JKM', 'MENJALANKAN PENDAFTARAN MANGSA', '2024-06-26', '04:44:00', '07:07:00', 'JKM', 26);

-- --------------------------------------------------------

--
-- Table structure for table `victim_contact`
--

CREATE TABLE `victim_contact` (
  `family_id` varchar(14) NOT NULL,
  `victim_status` varchar(20) NOT NULL,
  `victim_phone_no` varchar(20) NOT NULL,
  `victim_address` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `victim_contact`
--

INSERT INTO `victim_contact` (`family_id`, `victim_status`, `victim_phone_no`, `victim_address`) VALUES
('038038-39-3276', 'FAMILY', '+60 19-798 2700', 'JDBOJDNDJD'),
('038038-39-3292', 'FAMILY', '+60 11-6138 3801', 'JDBOJDNDJD'),
('111111-111-111', 'FAMILY', '+60 11-111 1111', '1111111111111111'),
('232323-23-2323', 'FAMILY', '+60 13-232 3232', 'ER34R43R4R'),
('308408-40-3840', 'FAMILY', '+60 18-664 2094', 'ervvrvrv'),
('712750-25-5076', 'FAMILY', '+60 13-885 3100', '32WEWRFREGVRFGRG'),
('734343-43-4434', 'FAMILY', '+60 23-232 3232', 'SDFS'),
('740127-02-5509', '1', '+60 13-485 3080', 'Lot 9382, Desa Seri Wangi, Simpang Lawin'),
('740209-20-2029', 'FAMILY', '+60 13-232 3232', 'ER34R43R4R'),
('837497-90-9732', '1', '+60 11-3672 1208', 'jbfcosjdeiojeijfr'),
('868368-36-8386', 'FAMILY', '+60 33-333 3333', '3333333'),
('939737-39-2201', '1', '+60 10-370 2289', 'shdpjdpl'),
('947937-30-4734', 'FAMILY', '+60 11-5506 3578', 'RIU4OIREKFNE');

-- --------------------------------------------------------

--
-- Table structure for table `victim_pps`
--

CREATE TABLE `victim_pps` (
  `pps_id` int(4) NOT NULL,
  `pps_date` date NOT NULL,
  `victim_ic_no` varchar(14) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `victim_pps`
--

INSERT INTO `victim_pps` (`pps_id`, `pps_date`, `victim_ic_no`) VALUES
(1, '2024-06-03', '020503-08-0253'),
(1, '2024-06-20', '038038-39-3276'),
(1, '2024-06-20', '038038-39-3292'),
(1, '2024-06-04', '041109-08-0632'),
(1, '2024-06-05', '220390-39-3003'),
(1, '2024-06-13', '308408-40-3840'),
(1, '2024-06-20', '347304-74-7340'),
(1, '2024-06-13', '348048-33-8384'),
(1, '2024-06-20', '712750-25-5076'),
(1, '2024-06-27', '734343-43-4434'),
(1, '2024-05-29', '740127-02-5509'),
(2, '2024-05-30', '837497-90-9732'),
(1, '2024-06-25', '868368-36-8386'),
(2, '2024-06-02', '937290-37-2918'),
(1, '2024-06-20', '947937-30-4734');

-- --------------------------------------------------------

--
-- Table structure for table `victim_profile`
--

CREATE TABLE `victim_profile` (
  `victim_ic_no` varchar(14) NOT NULL,
  `family_id` varchar(14) NOT NULL,
  `victim_name` varchar(50) NOT NULL,
  `victim_age` int(2) NOT NULL,
  `victim_gender` varchar(1) NOT NULL,
  `victim_age_categ` varchar(50) NOT NULL,
  `victim_special_categ` varchar(50) NOT NULL,
  `victim_relation` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `victim_profile`
--

INSERT INTO `victim_profile` (`victim_ic_no`, `family_id`, `victim_name`, `victim_age`, `victim_gender`, `victim_age_categ`, `victim_special_categ`, `victim_relation`) VALUES
('020503-08-0253', '740127-02-5509', 'MUHAMMAD TAUFIQ RAHIMI BIN MHD TARMIZI', 22, 'L', 'DEWASA', 'TIADA', 'ANAK'),
('038038-39-3276', '038038-39-3276', 'IZZAT NAUFAL BIN HAFIZ', 20, 'L', 'DEWASA', 'PEMBEDAHAN', 'WAKIL KELUARGA'),
('038038-39-3292', '038038-39-3292', 'IZZAT DARWISH BIN TAN', 20, 'L', 'DEWASA', 'PEMBEDAHAN', 'WAKIL KELUARGA'),
('041109-08-0632', '740127-02-5509', 'NURATIQAH HUSNA BINTI MHD TARMIZI', 20, 'P', 'DEWASA', 'TIADA', 'ANAK'),
('308408-40-3840', '308408-40-3840', 'SARAH MAISARAH', 30, 'P', 'DEWASA', 'PEMBEDAHAN', 'WAKIL KELUARGA'),
('347304-74-7340', '947937-30-4734', 'HAKIM REZA', 10, 'L', 'KANAK-KANAK', 'OKU', 'ANAK'),
('348048-33-8384', '308408-40-3840', 'AINUL UMAIRAH', 20, 'P', 'KANAK-KANAK', 'OKU', 'ANAK'),
('712750-25-5076', '712750-25-5076', 'ALI BIN ABU', 45, 'L', 'DEWASA', 'OKU', 'WAKIL KELUARGA'),
('740127-02-5509', '740127-02-5509', 'MHD TARMIZI BIN MUSA', 50, 'L', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('837497-90-9732', '837497-90-9732', 'ABD RAHMAN', 54, 'L', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('937290-37-2918', '837497-90-9732', 'ADANIE FATINIE BINTI ABD RAHMAN', 20, 'P', 'DEWASA', 'MENGANDUNG', 'ANAK'),
('947937-30-4734', '947937-30-4734', 'AIMAN HAKIM', 43, 'L', 'DEWASA', 'PEMBEDAHAN', 'WAKIL KELUARGA');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `disease_detail`
--
ALTER TABLE `disease_detail`
  ADD PRIMARY KEY (`disease_id`),
  ADD KEY `victim_ic_no` (`victim_ic_no`),
  ADD KEY `pps_id` (`pps_id`);

--
-- Indexes for table `flood_supply`
--
ALTER TABLE `flood_supply`
  ADD PRIMARY KEY (`supply_id`),
  ADD KEY `pps_id` (`pps_id`);

--
-- Indexes for table `pps_detail`
--
ALTER TABLE `pps_detail`
  ADD PRIMARY KEY (`pps_id`);

--
-- Indexes for table `staff_info`
--
ALTER TABLE `staff_info`
  ADD PRIMARY KEY (`staff_id`);

--
-- Indexes for table `victim_contact`
--
ALTER TABLE `victim_contact`
  ADD PRIMARY KEY (`family_id`);

--
-- Indexes for table `victim_pps`
--
ALTER TABLE `victim_pps`
  ADD PRIMARY KEY (`victim_ic_no`),
  ADD KEY `pps_id` (`pps_id`);

--
-- Indexes for table `victim_profile`
--
ALTER TABLE `victim_profile`
  ADD PRIMARY KEY (`victim_ic_no`),
  ADD KEY `family_id` (`family_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `disease_detail`
--
ALTER TABLE `disease_detail`
  MODIFY `disease_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `flood_supply`
--
ALTER TABLE `flood_supply`
  MODIFY `supply_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `pps_detail`
--
ALTER TABLE `pps_detail`
  MODIFY `pps_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `staff_info`
--
ALTER TABLE `staff_info`
  MODIFY `staff_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `disease_detail`
--
ALTER TABLE `disease_detail`
  ADD CONSTRAINT `disease_detail_ibfk_1` FOREIGN KEY (`pps_id`) REFERENCES `pps_detail` (`pps_id`),
  ADD CONSTRAINT `victim_ic_no` FOREIGN KEY (`victim_ic_no`) REFERENCES `victim_profile` (`victim_ic_no`) ON UPDATE CASCADE;

--
-- Constraints for table `victim_pps`
--
ALTER TABLE `victim_pps`
  ADD CONSTRAINT `pps_id` FOREIGN KEY (`pps_id`) REFERENCES `pps_detail` (`pps_id`);

--
-- Constraints for table `victim_profile`
--
ALTER TABLE `victim_profile`
  ADD CONSTRAINT `family_id` FOREIGN KEY (`family_id`) REFERENCES `victim_contact` (`family_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
