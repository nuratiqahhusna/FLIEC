-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 25, 2024 at 12:21 AM
-- Server version: 10.5.20-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id22257398_fliec_flood`
--

-- --------------------------------------------------------

--
-- Table structure for table `disease_detail`
--

CREATE TABLE `disease_detail` (
  `disease_id` int(4) NOT NULL,
  `disease_categ` varchar(20) NOT NULL,
  `disease_name` varchar(100) NOT NULL,
  `victim_ic_no` varchar(15) NOT NULL,
  `pps_id` int(4) NOT NULL,
  `note` varchar(100) NOT NULL,
  `after_checkup` varchar(100) DEFAULT NULL,
  `victim_covid_check` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `disease_detail`
--

INSERT INTO `disease_detail` (`disease_id`, `disease_categ`, `disease_name`, `victim_ic_no`, `pps_id`, `note`, `after_checkup`, `victim_covid_check`) VALUES
(3, 'INFECTIOUS', 'AGE', '041109-08-0632', 1, 'DEMAM PANAS', 'ARI/URTI, TIFOID, LEPTOSPIROSIS, MELIOIDOSIS', 'NO'),
(4, 'NONE', 'TIADA', '000893-02-0345', 2, '', NULL, 'YES'),
(5, 'INFECTIOUS', 'PENYAKIT KULIT', '457688-01-0898', 2, 'SUHU TINGGI', 'KOLERA, DEMAM (TIADA GEJALA LAIN)', 'NO'),
(6, 'INFECTIOUS', 'PENYAKIT KULIT', '903401-01-2234', 2, '', 'AGE, PENYAKIT KULIT, KOLERA', 'YES'),
(7, 'NON-INFECTIOUS', 'HYPERTENSION', '681070-10-0090', 1, 'SAKIT KEPALA', 'DENGGI, TIFOID, HYPERTENSION', 'YES'),
(8, 'BOTH', 'DEMAM (TIADA GEJALA LAIN)', '041007-01-0772', 1, '', 'CHICKEN POX, DEMAM (TIADA GEJALA LAIN)', 'NO'),
(9, 'NONE', 'TIADA', '021007-01-0776', 1, '', NULL, 'NO'),
(10, 'NONE', 'TIADA', '778899-90-9000', 26, '', NULL, 'NO'),
(11, 'NONE', 'TIADA', '898988-98-9899', 26, '', NULL, 'NO'),
(12, 'NONE', 'TIADA', '681007-01-0000', 2, '', NULL, 'NO'),
(13, 'NONE', 'TIADA', '998277-76-8884', 13, '', NULL, 'NO'),
(14, 'NONE', 'TIADA', '078849-99-4790', 13, '', NULL, 'YES'),
(15, 'NONE', 'TIADA', '229994-00-0588', 13, '', NULL, 'NO'),
(16, 'BOTH', 'DIABETES MELITUS', '658883-77-7488', 2, '', NULL, 'NO'),
(17, 'NONE', 'TIADA', '087772-88-8399', 2, '', NULL, 'YES'),
(18, 'NONE', 'TIADA', '229993-88-8490', 2, '', NULL, 'NO'),
(19, 'NONE', 'TIADA', '788889-29-9790', 7, '', NULL, 'NO'),
(20, 'NONE', 'TIADA', '066777-38-8378', 7, '', NULL, 'NO'),
(21, 'NONE', 'TIADA', '038849-99-2002', 7, '', NULL, 'YES'),
(22, 'NONE', 'TIADA', '042792-72-9279', 2, '', NULL, 'NO'),
(23, 'NONE', 'TIADA', '010928-83-0048', 2, '', NULL, 'NO'),
(24, 'BOTH', 'AGE, DIABETES MELITUS', '681070-10-0054', 1, '', NULL, 'NO'),
(25, 'NONE', 'TIADA', '069135-06-0876', 5, '', NULL, 'NO'),
(26, 'NONE', 'TIADA', '891026-01-0992', 20, '', NULL, 'NO'),
(27, 'NONE', 'TIADA', '739202-82-0220', 2, '', NULL, 'NO'),
(28, 'NONE', 'TIADA', '678839-99-3000', 3, '', NULL, 'NO'),
(29, 'NONE', 'TIADA', '899930-02-8900', 1, '', NULL, 'NO'),
(30, 'NONE', 'TIADA', '056638-81-9993', 1, '', NULL, 'YES'),
(32, 'NONE', 'TIADA', '578394-89-0294', 2, '', NULL, 'NO'),
(33, 'INFECTIOUS', 'MELIOIDOSIS', '679374-982-7297', 2, '', NULL, 'NO'),
(34, 'NONE', 'TIADA', '802838-83-8288', 2, '', NULL, 'NO'),
(35, 'BOTH', 'AGE, ARI/URTI, TIFOID, HEPATITIS A', '031118-11-0355', 25, '', NULL, 'NO'),
(36, 'NONE', 'TIADA', '700805-01-0123', 19, '', NULL, 'NO'),
(37, 'NONE', 'TIADA', '091008-01-0993', 32, '', NULL, 'NO'),
(38, 'NONE', 'TIADA', '090203-00-7333', 7, '', NULL, 'NO');

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
('Tikar', 1, 0, 1, 0, 0),
('Selimut', 2, 0, 1, 0, 0),
('Kain Pelikat', 3, 0, 1, 0, 0),
('Kain Batik', 4, 0, 1, 0, 0),
('Tuala', 5, 0, 1, 0, 0),
('Comforter', 6, 0, 1, 0, 0),
('Hygiene Kit', 7, 0, 1, 0, 0),
('Refreshment', 8, 0, 1, 0, 0),
('Beras', 11, 0, 1, 1, 0),
('Gula Pasir', 12, 100, 1, 1, 0),
('Minyak Masak', 13, 100, 1, 1, 0),
('Ikan Kering/Bilis', 14, 100, 1, 1, 0),
('Telur', 15, 100, 1, 1, 0),
('Kopi/Teh', 16, 100, 1, 1, 0),
('Garam', 17, 100, 1, 1, 0),
('Makanan Dalam Tin', 18, 70, 1, 1, 0),
('Tepung', 19, 10, 1, 1, 0),
('Air Mineral', 20, 0, 1, 1, 0),
('Bihun/Mee', 21, 100, 1, 1, 0),
('Biskut', 22, 100, 1, 1, 0),
('Susu Pekat', 23, 100, 1, 1, 0),
('Sardin', 24, 100, 1, 1, 0),
('Foam Mat', 25, 100, 1, 2, 0),
('Kerusi Roda', 26, 99, 1, 2, 0),
('Alat Sokongan', 27, 99, 1, 2, 0),
('T-Shirt', 28, 100, 1, 2, 0),
('Track Bottom', 29, 100, 1, 2, 0),
('Lampin Pakai Buang', 30, 100, 1, 2, 0),
('Tuala Wanita', 31, 100, 1, 2, 0),
('Pakaian Dalam ', 32, 100, 1, 2, 0),
('Bantal ', 33, 100, 1, 2, 0),
('Lilin', 34, 100, 1, 2, 0),
('Susu Tepung', 35, 100, 1, 2, 0),
('Tilam', 36, 50, 1, 2, 0),
('Tikar', 37, 50, 2, 0, 0),
('Selimut', 38, 100, 2, 0, 0),
('Kain Pelikat', 40, 100, 2, 0, 0),
('Kain Batik', 41, 100, 2, 0, 0),
('Tuala', 42, 100, 2, 0, 0),
('Comforter', 43, 100, 2, 0, 0),
('Hygiene Kit', 44, 100, 2, 0, 0),
('Refresment', 45, 100, 2, 0, 0),
('Beras', 46, 50, 2, 1, 0),
('Gula Pasir', 47, 100, 2, 1, 0),
('Minyak Masak', 48, 100, 2, 1, 0),
('Ikan Kering/Bilis', 49, 100, 2, 1, 0),
('Telur', 50, 100, 2, 1, 0),
('Kopi/Teh', 51, 100, 2, 1, 0),
('Garam', 52, 100, 2, 1, 0),
('Makanan Dalam Tin', 53, 100, 2, 1, 0),
('Tepung', 54, 100, 2, 1, 0),
('Air Mineral', 55, 100, 2, 1, 0),
('Bihun/ Mee', 56, 100, 2, 1, 0),
('Biskut', 57, 100, 2, 1, 0),
('Susu Pekat', 58, 100, 2, 1, 0),
('Sardin ', 59, 100, 2, 1, 0),
('Foam Mat', 60, 100, 2, 2, 0),
('Kerusi Roda', 61, 99, 2, 2, 0),
('Alat Sokongan ', 62, 100, 2, 2, 0),
('T-Shirt', 63, 100, 2, 2, 0),
('Track Bottom ', 64, 100, 2, 2, 0),
('Lampin Pakai Buang', 65, 99, 2, 2, 0),
('Tuala Wanita', 66, 100, 2, 2, 0),
('Pakaian Dalam', 67, 100, 2, 2, 0),
('Bantal ', 68, 100, 2, 2, 0),
('Lilin', 69, 100, 2, 2, 0),
('Susu Tepung', 70, 100, 2, 2, 0),
('Tilam', 71, 100, 2, 2, 0),
('Tikar', 72, 100, 3, 0, 0),
('Selimut', 73, 100, 3, 0, 0),
('Kain Pelikat', 74, 100, 3, 0, 0),
('Kain Batik', 75, 100, 3, 0, 0),
('Tuala', 76, 100, 3, 0, 0),
('Comforter', 77, 100, 3, 0, 0),
('Hygiene Kit', 78, 100, 3, 0, 0),
('Refreshment', 79, 100, 3, 0, 0),
('Beras', 80, 100, 3, 1, 0),
('Gula Pasir', 82, 100, 3, 1, 0),
('Minyak Masak', 83, 100, 3, 1, 0),
('Ikan Bilis/Kering', 84, 100, 3, 1, 0),
('Telur', 85, 100, 3, 1, 0),
('Kopi/Teh', 86, 100, 3, 1, 0),
('Garam', 87, 100, 3, 1, 0),
('Makanan Dalam Tin ', 88, 100, 3, 1, 0),
('Tepung ', 89, 100, 3, 1, 0),
('Air Mineral', 90, 100, 3, 1, 0),
('Bihun/Mee', 91, 100, 3, 1, 0),
('Biskut', 93, 100, 3, 1, 0),
('Susu Pekat', 94, 100, 3, 1, 0),
('Sardin', 95, 100, 3, 1, 0),
('Foam mat', 96, 100, 3, 2, 0),
('Kerusi Roda', 97, 100, 3, 2, 0),
('Alat Sokongan ', 98, 100, 3, 2, 0),
('T-Shirt', 99, 100, 3, 2, 0),
('Track Bottom', 100, 100, 3, 2, 0),
('Lampin Pakai Buang', 101, 100, 3, 2, 0),
('Track Bottom', 102, 100, 3, 2, 0),
('Lampin Pakai Buang', 103, 100, 3, 2, 0),
('Tuala Wanita', 104, 100, 3, 2, 0),
('Pakaian Dalam', 105, 100, 3, 2, 0),
('Bantal', 106, 100, 3, 2, 0),
('Lilin', 107, 100, 3, 2, 0),
('Susu Tepung', 108, 100, 3, 2, 0),
('Tilam', 109, 100, 3, 2, 0),
('Tikar', 110, 101, 5, 0, 0),
('Selimut', 111, 100, 5, 0, 0),
('Kain Pelikat', 112, 100, 5, 0, 0),
('Kain Batik', 113, 100, 5, 0, 0),
('Tuala', 114, 100, 5, 0, 0),
('Comforter', 115, 100, 5, 0, 0),
('Hygiene Kit', 116, 100, 5, 0, 0),
('Refresment', 117, 100, 5, 0, 0),
('Beras', 118, 100, 5, 1, 0),
('Gula Pasir', 119, 100, 5, 1, 0),
('Minyak Masak', 120, 100, 5, 1, 0),
('Ikan Kering/Bilis', 121, 100, 5, 1, 0),
('Telur', 122, 100, 5, 1, 0),
('Kopi / Teh', 123, 100, 5, 1, 0),
('Garam', 124, 100, 5, 1, 0),
('Makanan Dalam Tin', 125, 100, 5, 1, 0),
('Tepung', 126, 100, 5, 1, 0),
('Air Mineral', 127, 100, 5, 1, 0),
('Bihun/ Mee', 128, 100, 5, 1, 0),
('Biskut', 129, 100, 5, 1, 0),
('Susu Pekat', 130, 100, 5, 1, 0),
('Sardin', 131, 100, 5, 1, 0),
('Foam Mat', 132, 100, 5, 2, 0),
('Kerusi Roda', 133, 100, 5, 2, 0),
('Alat Sokongan ', 134, 100, 5, 2, 0),
('T-Shirt', 135, 100, 5, 2, 0),
('Track Bottom', 136, 100, 5, 2, 0),
('Lampin Pakai Buang', 137, 100, 5, 2, 0),
('Tuala Wanita', 138, 100, 5, 2, 0),
('Pakaian Dalam', 139, 100, 5, 2, 0),
('Bantal', 140, 100, 5, 2, 0),
('Lilin', 141, 100, 5, 2, 0),
('Susu Tepung', 142, 100, 5, 2, 0),
('Tilam', 143, 100, 5, 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `pps_detail`
--

CREATE TABLE `pps_detail` (
  `pps_id` int(4) NOT NULL,
  `pps_name` varchar(50) NOT NULL,
  `pps_status` varchar(20) DEFAULT NULL,
  `pps_open_date` date DEFAULT NULL,
  `pps_close_date` date DEFAULT NULL,
  `pps_capacity` int(4) NOT NULL,
  `pps_district` int(4) NOT NULL,
  `pps_occupancy` int(4) NOT NULL DEFAULT 0,
  `pps_categ` int(4) NOT NULL,
  `pps_address` varchar(100) NOT NULL,
  `pps_latitude` varchar(14) NOT NULL,
  `pps_longitude` varchar(14) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pps_detail`
--

INSERT INTO `pps_detail` (`pps_id`, `pps_name`, `pps_status`, `pps_open_date`, `pps_close_date`, `pps_capacity`, `pps_district`, `pps_occupancy`, `pps_categ`, `pps_address`, `pps_latitude`, `pps_longitude`) VALUES
(1, 'SK SEPAKAT JAYA', 'TIDAK AKTIF', '2024-06-13', '2024-06-03', 500, 1, 9, 1, 'JALAN AHMAD, KG SEPAKAT JAYA, CHAAH BAHRU, BATU PAHAT', '2.15990', '103.04169'),
(2, 'SJKC LAM LEE', 'TIDAK AKTIF', '2024-06-17', '0000-00-00', 500, 1, 14, 1, 'JALAN 96, LAM LEE', '2.09464', '103.04744'),
(3, 'SJKC CHONG HWA', 'AKTIF', '2024-06-21', '2024-06-26', 500, 2, 1, 1, '9387, JALAN CHONG HWA', '1.85776', '103.03092'),
(4, 'SEKOLAH AGAMA KG BAHRU', '', '0000-00-00', '0000-00-00', 400, 2, 0, 1, '', '', ''),
(5, 'SK BINDU', '', '0000-00-00', '0000-00-00', 500, 3, 0, 1, '', '', ''),
(6, 'SK AGAMA SERI TELOK', '', '0000-00-00', '0000-00-00', 500, 3, 0, 1, '', '', ''),
(7, 'SK SERI BINJAI ', '', '0000-00-00', '0000-00-00', 500, 3, 0, 1, '', '', ''),
(8, 'SK SERI TELOK', '', '0000-00-00', '0000-00-00', 500, 3, 0, 1, '', '', ''),
(9, 'SK BUKIT RAHMAT', '', '0000-00-00', '0000-00-00', 400, 3, 0, 1, '', '', ''),
(10, 'SMK SERI BENGKEL', '', '0000-00-00', '0000-00-00', 700, 3, 0, 1, '', '', ''),
(11, 'SMK TUNKU PUTRA', '', '0000-00-00', '0000-00-00', 600, 3, 0, 1, '', '', ''),
(12, 'SEKOLAH AGAMA SRI BENGKAL', '', '0000-00-00', '0000-00-00', 500, 3, 0, 1, '', '', ''),
(13, 'SEKOLAH AGAMA BUKIT RAHMAT', '', '0000-00-00', '0000-00-00', 600, 3, 0, 1, '', '', ''),
(14, 'SEKOLAH AGAMA SERI BINJAI', '', '0000-00-00', '0000-00-00', 600, 3, 0, 1, '', '', ''),
(15, 'SJKC TONGKANG', '', '0000-00-00', '0000-00-00', 500, 3, 0, 1, '', '', ''),
(16, 'SJKC LI CHUN', '', '0000-00-00', '0000-00-00', 500, 3, 0, 1, '', '', ''),
(17, 'DEWAN ORANG RAMAI SERI MEDAN', '', '0000-00-00', '0000-00-00', 500, 3, 0, 2, '', '', ''),
(18, 'DEWAN ORANG RAMAI PARIT YAANI', '', '0000-00-00', '0000-00-00', 600, 3, 0, 2, '', '', ''),
(19, 'SEKOLAH SERI JAYA SEPAKAT', '', '0000-00-00', '0000-00-00', 500, 3, 0, 1, '', '', ''),
(20, 'SK KOTA DALAM ', '', '0000-00-00', '0000-00-00', 700, 4, 0, 1, '', '', ''),
(21, 'SK BUKIT KUARI', '', '0000-00-00', '0000-00-00', 500, 4, 0, 1, '', '', ''),
(22, 'SK PINTAS PUDING', '', '0000-00-00', '0000-00-00', 600, 4, 0, 1, '', '', ''),
(23, 'SK SERI AMAN', '', '0000-00-00', '0000-00-00', 700, 4, 0, 1, '', '', ''),
(24, 'SK AIR HITAM', '', '0000-00-00', '0000-00-00', 500, 4, 0, 1, '', '', ''),
(25, 'MASJID KG PARIT PUASA', '', '0000-00-00', '0000-00-00', 500, 4, 0, 3, '', '', ''),
(26, 'SK SERI UTAMA', '', '0000-00-00', '0000-00-00', 300, 5, 0, 1, '', '', ''),
(27, 'SK SRI BEROLEH', '', '0000-00-00', '0000-00-00', 500, 6, 0, 1, '', '', ''),
(28, 'SK SRI GADING', '', '0000-00-00', '0000-00-00', 700, 6, 0, 1, '', '', ''),
(29, 'SK PARIT BILAL', '', '0000-00-00', '0000-00-00', 600, 6, 0, 1, '', '', ''),
(30, 'SEKOLAH AGAMA AIR PUTIH', '', '0000-00-00', '0000-00-00', 300, 6, 0, 1, '', '', ''),
(31, 'SEKOLAH AGAMA BINDU', '', '0000-00-00', '0000-00-00', 500, 6, 0, 1, '', '', ''),
(32, 'DEWAN SERBAGUNA SERI BANI', '', '0000-00-00', '0000-00-00', 700, 6, 0, 2, '', '', ''),
(34, 'SK SERI TANJUNG', '', '0000-00-00', '0000-00-00', 500, 7, 0, 1, '', '', ''),
(35, 'SK SERI MAIMON', '', '0000-00-00', '0000-00-00', 500, 7, 0, 1, '', '', ''),
(36, 'SK SRI PADANG SARI', '', '0000-00-00', '0000-00-00', 500, 7, 0, 1, '', '', ''),
(37, 'SK SRI TANJUNG', '', '0000-00-00', '0000-00-00', 600, 7, 0, 1, '', '', ''),
(38, 'SMK DATO SULAIMAN', '', '0000-00-00', '0000-00-00', 600, 7, 0, 1, '', '', ''),
(39, 'SMK PENGHULU SAAD', '', '0000-00-00', '0000-00-00', 700, 7, 0, 1, '', '', ''),
(40, 'SEKOLAH SERI CHANTEK', '', '0000-00-00', '0000-00-00', 800, 7, 0, 1, '', '', ''),
(41, 'SEKOLAH AGAMA SRI MAIMON', '', '0000-00-00', '0000-00-00', 400, 7, 0, 1, '', '', ''),
(42, 'SK SERI TIGA SERANGKAI', '', '0000-00-00', '0000-00-00', 500, 8, 0, 1, '', '', ''),
(43, 'SK SERI LAKSANA, PARIT SULONG', '', '0000-00-00', '0000-00-00', 500, 8, 0, 1, '', '', ''),
(44, 'SK SEJANGONG, SERI MEDAN', '', '0000-00-00', '0000-00-00', 700, 8, 0, 1, '', '', ''),
(45, 'SK SERI PEMATANG RENGAS ', '', '0000-00-00', '0000-00-00', 600, 8, 0, 1, '', '', ''),
(46, 'SK TENAGA SETIA ', '', '0000-00-00', '0000-00-00', 500, 8, 0, 1, '', '', ''),
(47, 'SK SERI MEDAN', '', '0000-00-00', '0000-00-00', 500, 8, 0, 1, '', '', ''),
(48, 'SEKOLAH AGAMA PARIT SULONG', '', '0000-00-00', '0000-00-00', 500, 8, 0, 1, '', '', ''),
(49, 'SEKOLAH AGAMA KANGKAR MERLIMAU', '', '0000-00-00', '0000-00-00', 300, 8, 0, 1, '', '', ''),
(50, 'SEKOLAH AGAMA TENAGA SETIA', '', '0000-00-00', '0000-00-00', 300, 8, 0, 1, '', '', ''),
(51, 'SEKOLAH AGAMA SERI MEDAN', '', '0000-00-00', '0000-00-00', 500, 8, 0, 1, '', '', ''),
(52, 'SJKC 1 YONG PENG ', '', '0000-00-00', '0000-00-00', 500, 8, 0, 1, '', '', ''),
(53, 'SJKC PT YAANI', '', '0000-00-00', '0000-00-00', 600, 8, 0, 1, '', '', ''),
(54, 'SMK SERI MEDAN', '', '0000-00-00', '0000-00-00', 600, 8, 0, 1, '', '', ''),
(55, 'DEWAN ORANG RAMAI PARIT SULONG', '', '0000-00-00', '0000-00-00', 600, 8, 0, 2, '', '', ''),
(56, 'PPK SERI MEDAN', '', '0000-00-00', '0000-00-00', 500, 8, 0, 2, '', '', ''),
(57, 'SK SERI PASIR PUTEH', '', '0000-00-00', '0000-00-00', 500, 9, 0, 1, '', '', ''),
(58, 'SK TAMAN SERI KOTA', '', '0000-00-00', '0000-00-00', 600, 9, 0, 1, '', '', ''),
(59, 'SK SRI BANDAN', '', '0000-00-00', '0000-00-00', 500, 9, 0, 1, '', '', ''),
(60, 'SK SERI MANGGIS', '', '0000-00-00', '0000-00-00', 500, 9, 0, 1, '', '', ''),
(61, 'SK SERI BERTAM', '', '0000-00-00', '0000-00-00', 700, 9, 0, 1, '', '', ''),
(62, 'SK AGAMA TAMAN SERI KOTA', '', '0000-00-00', '0000-00-00', 500, 9, 0, 1, '', '', ''),
(63, 'SK SERI BULAN', '', '0000-00-00', '0000-00-00', 600, 9, 0, 1, '', '', ''),
(64, 'SK SERI BENUT PT RAJA', '', '0000-00-00', '0000-00-00', 600, 9, 0, 1, '', '', ''),
(65, 'SK AGAMA SERI IDAMAN TANJONG SEMBRONG ', '', '0000-00-00', '0000-00-00', 500, 9, 0, 1, '', '', ''),
(66, 'SEKOLAH AGAMA SERI BERTAM', '', '0000-00-00', '0000-00-00', 600, 9, 0, 1, '', '', ''),
(67, 'SEKOLAH AGAMA SRI TANJUNG', '', '0000-00-00', '0000-00-00', 500, 9, 0, 1, '', '', ''),
(68, 'SEKOLAH AGAMA SRI BULAN', '', '0000-00-00', '0000-00-00', 600, 9, 0, 1, '', '', ''),
(69, 'SMK DATO SETH', '', '0000-00-00', '0000-00-00', 600, 9, 0, 1, '', '', ''),
(70, 'SMK YONG PENG', '', '0000-00-00', '0000-00-00', 500, 9, 0, 1, '', '', ''),
(71, 'YONG PENG HIGHSCHOOL', '', '0000-00-00', '0000-00-00', 700, 9, 0, 1, '', '', ''),
(72, 'DEWAN GELANGGANG BOLA KERANJANG TAMAN DESA PUTIH', '', '0000-00-00', '0000-00-00', 300, 9, 0, 2, '', '', ''),
(73, 'DEWAN ORANG RAMAI YONG PENG', '', '0000-00-00', '0000-00-00', 300, 9, 0, 2, '', '', ''),
(85, 'SK PT JAWA', 'TIDAK AKTIF', '2024-06-20', '0000-00-00', 150, 1, 0, 1, '', '', ''),
(91, 'SEKOLAH CANTIK', 'AKTIF', '2024-06-16', '2024-06-26', 250, 1, 0, 1, 'TAMAN CANTIK, CHAAH BAHRU', '3984002.1', '39793820.4');

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
  `staff_date` date NOT NULL,
  `staff_shift_start` time NOT NULL,
  `staff_shift_end` time NOT NULL,
  `pps_id` int(4) NOT NULL,
  `staff_agency` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff_info`
--

INSERT INTO `staff_info` (`staff_id`, `staff_name`, `staff_phone_no`, `staff_position`, `staff_tasks`, `staff_date`, `staff_shift_start`, `staff_shift_end`, `pps_id`, `staff_agency`) VALUES
(1, 'AHMAD AMIRUL BIN MOHD AMIRUDDIN', '+60 18-768 1207', 'PEMBANTU JKM', 'MENJALANKAN PENDAFTARAN MANGSA', '2024-06-01', '08:00:00', '20:00:00', 1, 'JKM'),
(2, 'NUR ATIQA NAJWA BINTI LUKMAN', '+60 11-1583 4691', 'PASUKAN PERUBATAN', 'PEMERIKSAAN KESIHATAN', '2024-06-25', '12:48:00', '00:48:00', 1, 'KKM'),
(3, 'AHMAD IRFAN BIN ALI', '+60 19-222 7476', 'PENOLONG PEGAWAI', 'MENYEDIAKAN KEPERLUAN ASAS MANGSA', '2024-06-18', '05:55:00', '06:06:00', 38, 'JKM'),
(4, 'HUSNA SARAH', '+60 19-222 7476', 'PASUKAN PERUBATAN', 'PEMERIKSAAN PERSEKITARAN', '2024-06-10', '09:09:00', '00:00:00', 39, 'KKM'),
(5, 'AIN MAISARAH', '+60 13-485 3080', 'PENOLONG PEGAWAI JKM', 'MENGURUS DAN MENYELENGGARA PPS', '2024-06-18', '06:06:00', '09:09:00', 37, 'JKM'),
(6, 'SITI NUR ADILA', '+60 19-293 4648', 'PEMBANTU JKM', 'MENYELARASKAN MAKANAN DAN MINUMAN MANGSA', '2024-06-25', '08:30:00', '21:00:00', 3, 'JKM'),
(7, 'AININA NAJWA', '+60 13-485 3080', 'PASUKAN PERUBATAN', 'PEMERIKSAAN PERSEKITARAN', '2024-06-20', '14:50:00', '01:50:00', 3, 'KKM'),
(8, 'ZULAIKHA FARISAH', '+60 19-222 7476', 'PEMBANTU JKM', 'MENYELARASKAN MAKANAN DAN MINUMAN MANGSA', '2024-06-11', '20:33:00', '08:33:00', 38, 'JKM');

-- --------------------------------------------------------

--
-- Table structure for table `victim_contact`
--

CREATE TABLE `victim_contact` (
  `family_id` varchar(15) NOT NULL,
  `victim_status` varchar(30) NOT NULL,
  `victim_phone_no` varchar(20) NOT NULL,
  `victim_address` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `victim_contact`
--

INSERT INTO `victim_contact` (`family_id`, `victim_status`, `victim_phone_no`, `victim_address`) VALUES
('000893-02-0345', 'FAMILY', '+60 19-798 2700', 'JALAN KERAMAT BATU PAHAT'),
('010928-83-0048', 'FAMILY', '+60 16-654 5554', '90, JALAN WARISAN PERMAI 9/3 BATU PAHAT'),
('031118-11-0355', 'FAMILY', '+60 11-622 3464', 'JALAN'),
('041007-01-0772', 'FAMILY', '0137161499', 'PARIT SULONG BATU PAHAT'),
('042792-72-9279', 'FAMILY', '+60 18-379 3799', '90, KAMPUNG LAM LEE'),
('069135-06-0876', 'FAMILY', '+60 21-267 894', 'BATU PAHAT'),
('090203-00-7333', 'FAMILY', '+60 17-882 6456', 'CEMARA , JALAN JALIL'),
('091008-01-0993', 'FAMILY', '+60 15-678 9234', 'PARIT ABDUL HADI'),
('578394-89-0294', 'FAMILY', '+60 23-874 7829', '78 JALAN PANJANG BATU PAHAT'),
('658883-77-7488', 'FAMILY', '+60 18-282 8882', '79 KAMPUNG PISANG BELAH KANAN BATU PAHAT'),
('678839-99-3000', 'FAMILY', '+60 90-189 1080', 'JALAN ANGIN TIUP'),
('679374-982-7297', 'FAMILY', '+60 37-827', '80 JALAN '),
('681007-01-0000', 'FAMILY', '0137161499', 'PARIT SULONG'),
('681070-10-0054', 'SINGLE', '+60 11-583 4691', 'BATU PAHAT'),
('681070-10-0090', 'FAMILY', '0137161499', 'JALAN KAMPUNG BARU BATU PAHAT'),
('700805-01-0123', 'FAMILY', '+60 14-435 7718', '13 JALAN TUANKU AMAN 83000 BATU PAHAT JOHOR'),
('739202-82-0220', 'FAMILY', '+60 12-122 3232', '33333333223'),
('740127-02-5509', '1', '+60 13-485 3080', 'LOT 9382, DESA SERI WANGI CHAAH BAHRU'),
('778899-90-9000', 'FAMILY', '0134853080', '67 ABC 873000 MUAR'),
('788889-29-9790', 'FAMILY', '+60 98-989 8098', 'JALAN SIMPANG DEPAN BATU PAHAT'),
('837497-90-9732', '1', '+60 11-3672 1208', 'KFNRFNRPOFME'),
('891026-01-0992', 'SINGLE', '+60 15-678 922', 'PARIT RAJA'),
('899930-02-8900', 'FAMILY', '+60 00-824 0293', 'JALAN PARIT KANAN'),
('939737-39-2201', '1', '+60 10-370 2289', 'EKNFEPFNOFF'),
('998277-76-8884', 'FAMILY', '+60 82-198 2918', 'JALAN KERAMAT DALAM BATU PAHAT');

-- --------------------------------------------------------

--
-- Table structure for table `victim_pps`
--

CREATE TABLE `victim_pps` (
  `pps_id` int(4) NOT NULL,
  `pps_date` date NOT NULL,
  `victim_ic_no` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `victim_pps`
--

INSERT INTO `victim_pps` (`pps_id`, `pps_date`, `victim_ic_no`) VALUES
(2, '2024-06-12', '000893-02-0345'),
(2, '2024-06-24', '010928-83-0048'),
(1, '2024-06-03', '020503-08-0253'),
(1, '2024-06-13', '021007-01-0776'),
(25, '2024-06-24', '031118-11-0355'),
(7, '2024-06-17', '038849-99-2002'),
(1, '2024-06-13', '041007-01-0772'),
(1, '2024-06-04', '041109-08-0632'),
(2, '2024-06-18', '042792-72-9279'),
(1, '2024-06-24', '056638-81-9993'),
(7, '2024-06-17', '066777-38-8378'),
(5, '2024-06-24', '069135-06-0876'),
(13, '2024-06-17', '078849-99-4790'),
(2, '2024-06-17', '087772-88-8399'),
(7, '2024-07-05', '090203-00-7333'),
(32, '2024-07-01', '091008-01-0993'),
(2, '2024-06-17', '229993-88-8490'),
(13, '2024-06-17', '229994-00-0588'),
(2, '2024-06-12', '457688-01-0898'),
(2, '2024-06-24', '578394-89-0294'),
(2, '2024-06-17', '658883-77-7488'),
(3, '2024-06-24', '678839-99-3000'),
(2, '2024-06-24', '679374-982-7297'),
(2, '2024-06-14', '681007-01-0000'),
(1, '2024-06-24', '681070-10-0054'),
(1, '2024-06-13', '681070-10-0090'),
(19, '2024-06-26', '700805-01-0123'),
(2, '2024-06-26', '739202-82-0220'),
(1, '2024-05-29', '740127-02-5509'),
(26, '2024-06-13', '778899-90-9000'),
(7, '2024-06-17', '788889-29-9790'),
(2, '2024-06-24', '802838-83-8288'),
(2, '2024-05-30', '837497-90-9732'),
(20, '2024-06-01', '891026-01-0992'),
(26, '2024-06-13', '898988-98-9899'),
(1, '2024-06-24', '899930-02-8900'),
(2, '2024-06-13', '903401-01-2234'),
(1, '2024-06-01', '939737-39-2201'),
(13, '2024-06-17', '998277-76-8884');

-- --------------------------------------------------------

--
-- Table structure for table `victim_profile`
--

CREATE TABLE `victim_profile` (
  `victim_ic_no` varchar(15) NOT NULL,
  `family_id` varchar(15) NOT NULL,
  `victim_name` varchar(50) NOT NULL,
  `victim_age` int(3) NOT NULL,
  `victim_gender` varchar(1) NOT NULL,
  `victim_age_categ` varchar(50) NOT NULL,
  `victim_special_categ` varchar(50) NOT NULL DEFAULT 'TIADA',
  `victim_relation` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `victim_profile`
--

INSERT INTO `victim_profile` (`victim_ic_no`, `family_id`, `victim_name`, `victim_age`, `victim_gender`, `victim_age_categ`, `victim_special_categ`, `victim_relation`) VALUES
('000893-02-0345', '000893-02-0345', 'AMINAH AISYAH BINTI ABU', 24, 'P', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('010928-83-0048', '010928-83-0048', 'ADAM FAIZAL BIN MOHD AMIRUL', 23, 'L', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('020503-08-0253', '740127-02-5509', 'MUHAMMAD TAUFIQ RAHIMI BIN MHD TARMIZI', 22, 'L', 'DEWASA', 'OKU', 'ANAK'),
('021007-01-0776', '041007-01-0772', 'ATIQA NAJWA', 24, 'L', 'DEWASA', 'TIADA', 'ANAK'),
('031118-11-0355', '031118-11-0355', 'QAIREL QAYYUM', 21, 'L', 'DEWASA', 'OKU', 'WAKIL KELUARGA'),
('038849-99-2002', '788889-29-9790', 'ADAM AZMI BIN SUHAILAM', 21, 'L', 'DEWASA', 'TIADA', 'ANAK'),
('041007-01-0772', '041007-01-0772', 'LUKMAN BIN MOHD SALLEH', 20, 'L', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('041109-08-0632', '740127-02-5509', 'NURATIQAH HUSNA BINTI MHD TARMIZI', 20, 'P', 'DEWASA', 'TIADA', 'ANAK'),
('042792-72-9279', '042792-72-9279', 'AINUL HAFIZAH BINTI HAIZAN', 20, 'L', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('056638-81-9993', '899930-02-8900', 'QAYUM BIN ABD RAZAK', 19, 'L', 'DEWASA', 'OKU', 'ADIK-BERADIK'),
('066777-38-8378', '788889-29-9790', 'HAFIZAH AISYAH BINTI OMARO', 18, 'P', 'DEWASA', 'TIADA', 'ANAK'),
('069135-06-0876', '069135-06-0876', 'NURIN SHAHIDA', 18, 'L', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('078849-99-4790', '998277-76-8884', 'QASRIAN AZIAH BINTI KAMARUL', 17, 'P', 'WARGA EMAS', 'TIADA', 'ANAK'),
('087772-88-8399', '658883-77-7488', 'TAUFIQ RIZUAN BIN KHAIRUL RAZI', 16, 'L', 'KANAK-KANAK', 'TIADA', 'ANAK'),
('090203-00-7333', '090203-00-7333', 'SHAMILA', 15, 'P', 'KANAK-KANAK', '', 'WAKIL KELUARGA'),
('091008-01-0993', '091008-01-0993', 'AMIRAH', 15, 'P', 'KANAK-KANAK', '', 'WAKIL KELUARGA'),
('229993-88-8490', '658883-77-7488', 'SITI SALEHA BINTI KHAIRUL RAZI ', 2, 'P', 'BAYI', 'TIADA', 'ANAK'),
('229994-00-0588', '998277-76-8884', 'AMAR NIZAM BIN KAMARUL', 2, 'L', 'BAYI', 'TIADA', 'ANAK'),
('457688-01-0898', '000893-02-0345', 'SITI MAIMUNAH BINTI KAMIL', 89, 'P', 'WARGA EMAS', 'TIADA', 'NENEK'),
('578394-89-0294', '578394-89-0294', 'ABDUL GHANI BIN AHMAD ', 67, 'L', 'WARGA EMAS', '', 'WAKIL KELUARGA'),
('658883-77-7488', '658883-77-7488', 'FAKHRUL RAZI BIN MUHD ZIMZIM', 59, 'L', 'DEWASA', '', 'WAKIL KELUARGA'),
('678839-99-3000', '678839-99-3000', 'ALIAH MAISARAH BINTI GANDHI', 57, 'P', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('679374-982-7297', '679374-982-7297', 'MOHD JAZULI BIN AHMAD', 57, 'L', 'DEWASA', '', 'WAKIL KELUARGA'),
('681007-01-0000', '681007-01-0000', 'MUHAMMAD KAMIL', 55, 'L', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('681070-10-0054', '681070-10-0054', 'MUHAMMAD KAMIL', 56, 'L', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('681070-10-0090', '681070-10-0090', 'LUKMAN BIN MOHD SALLEH', 50, 'L', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('700805-01-0123', '700805-01-0123', 'SAMAD BIN ALI', 54, 'L', 'DEWASA', 'MELAKUKAN PEMBEDAHAN', 'WAKIL KELUARGA'),
('739202-82-0220', '739202-82-0220', 'NURALIA FARHANI', 51, 'P', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('740127-02-5509', '740127-02-5509', 'MHD TARMIZI BIN MUSA', 50, 'L', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('778899-90-9000', '778899-90-9000', 'AZLI ABU HASSAN', 78, 'L', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('788889-29-9790', '788889-29-9790', 'OMARO BIN ABU', 46, 'L', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('802838-83-8288', '679374-982-7297', 'FARAH', 44, 'P', 'DEWASA', '', 'ANAK'),
('837497-90-9732', '837497-90-9732', 'ABD RAHMAN', 54, 'L', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('891026-01-0992', '891026-01-0992', 'AMALINA NURIN', 35, 'P', 'DEWASA', 'TIADA', 'WAKIL KELUARGA'),
('898988-98-9899', '778899-90-9000', 'anas', 45, 'L', 'DEWASA', 'TIADA', 'ANAK'),
('899930-02-8900', '899930-02-8900', 'SITI KHADIJAH BINTI ABD RAZAK', 35, 'P', 'DEWASA', 'MENGANDUNG', 'WAKIL KELUARGA'),
('903401-01-2234', '000893-02-0345', 'ADAM AZMI BIN SUHAILAM', 34, 'L', 'DEWASA', 'TIADA', 'ANAK'),
('937290-37-2918', '837497-90-9732', 'ADANIE FATINIE BINTI ABD RAHMAN', 27, 'P', 'DEWASA', 'MENGANDUNG', 'ANAK'),
('998277-76-8884', '998277-76-8884', 'WARDAH BINTI ABU', 25, 'P', 'DEWASA', 'MENGANDUNG', 'WAKIL KELUARGA');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `disease_detail`
--
ALTER TABLE `disease_detail`
  ADD PRIMARY KEY (`disease_id`),
  ADD KEY `ic_no` (`victim_ic_no`),
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
  ADD PRIMARY KEY (`staff_id`),
  ADD KEY `pps_id` (`pps_id`);

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
  MODIFY `disease_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `flood_supply`
--
ALTER TABLE `flood_supply`
  MODIFY `supply_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=892;

--
-- AUTO_INCREMENT for table `pps_detail`
--
ALTER TABLE `pps_detail`
  MODIFY `pps_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `staff_info`
--
ALTER TABLE `staff_info`
  MODIFY `staff_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `disease_detail`
--
ALTER TABLE `disease_detail`
  ADD CONSTRAINT `disease_detail_ibfk_1` FOREIGN KEY (`pps_id`) REFERENCES `pps_detail` (`pps_id`),
  ADD CONSTRAINT `ic_no` FOREIGN KEY (`victim_ic_no`) REFERENCES `victim_profile` (`victim_ic_no`);

--
-- Constraints for table `victim_pps`
--
ALTER TABLE `victim_pps`
  ADD CONSTRAINT `pps_id` FOREIGN KEY (`pps_id`) REFERENCES `pps_detail` (`pps_id`);

--
-- Constraints for table `victim_profile`
--
ALTER TABLE `victim_profile`
  ADD CONSTRAINT `family_id` FOREIGN KEY (`family_id`) REFERENCES `victim_contact` (`family_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
