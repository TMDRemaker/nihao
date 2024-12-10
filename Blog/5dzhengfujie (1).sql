-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Nov 22, 2024 alle 13:50
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `5dzhengfujie`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `fauna`
--

CREATE TABLE `fauna` (
  `fau_id` int(11) NOT NULL,
  `fau_dex` varchar(100) NOT NULL,
  `fau_sesso` enum('M','F') NOT NULL,
  `fau_data_nascita` date NOT NULL,
  `fau_stato_salute` enum('S','M','D') NOT NULL,
  `fau_parco_id` int(11) NOT NULL,
  `fau_specie_spf_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `fauna`
--

INSERT INTO `fauna` (`fau_id`, `fau_dex`, `fau_sesso`, `fau_data_nascita`, `fau_stato_salute`, `fau_parco_id`, `fau_specie_spf_id`) VALUES
(2, 'Panthera leo', 'M', '2022-03-23', 'S', 1, 2),
(3, 'Phoenicopterus roseus', 'F', '2017-11-30', 'S', 2, 4),
(10, 'Cyprinus carpio', 'M', '2016-11-06', 'S', 1, 5),
(11, 'Cyprinus carpio', 'F', '2015-11-01', 'M', 1, 5),
(12, 'Macropus rufus', 'M', '2024-11-20', 'S', 1, 3),
(13, 'Panthera leo', 'F', '2018-08-16', 'D', 2, 2),
(14, 'Loxdonta africana', 'F', '2020-09-15', 'M', 3, 1),
(15, 'Panthera leo', 'F', '2016-11-06', 'M', 1, 2),
(16, 'Phoenicopterus roseus	', 'M', '2024-11-04', 'S', 1, 1),
(23, 'Phoenicopterus roseus	', 'M', '2024-10-31', 'S', 1, 4),
(24, 'Macropus rufus', 'M', '2024-11-20', 'D', 1, 1),
(25, 'Macropus rufus', 'M', '2024-10-28', 'S', 1, 3);

-- --------------------------------------------------------

--
-- Struttura della tabella `flora`
--

CREATE TABLE `flora` (
  `flo_id` int(11) NOT NULL,
  `flo_dex` varchar(100) NOT NULL,
  `flo_spl_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `flora`
--

INSERT INTO `flora` (`flo_id`, `flo_dex`, `flo_spl_id`) VALUES
(1, 'Pinus pinea', 1),
(2, 'Olea europaea', 2),
(3, 'Lavandula stoechas', 3);

-- --------------------------------------------------------

--
-- Struttura della tabella `gurdia_parco`
--

CREATE TABLE `gurdia_parco` (
  `gua_id` int(11) NOT NULL,
  `gua_cognome` varchar(30) NOT NULL,
  `gua_nome` varchar(30) NOT NULL,
  `gua_utente` varchar(30) NOT NULL,
  `gua_password` varchar(30) NOT NULL,
  `gua_parco_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `gurdia_parco`
--

INSERT INTO `gurdia_parco` (`gua_id`, `gua_cognome`, `gua_nome`, `gua_utente`, `gua_password`, `gua_parco_id`) VALUES
(1, 'Rossi', 'Luca', 'luca_rossi89', 'Luca2024!', 1),
(2, 'Bianchi', 'Alessandra', 'alessabianchi', 'Ale!Bi2024', 1),
(3, 'zheng', 'fujie', 'zheng', 'fujie', 1),
(4, 'Ferrari', 'Giulia', 'giuliaferrari12', 'Giu#Ferr12', 3);

-- --------------------------------------------------------

--
-- Struttura della tabella `ordine_fauna`
--

CREATE TABLE `ordine_fauna` (
  `ofa_id` int(11) NOT NULL,
  `ofa_dex` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `ordine_fauna`
--

INSERT INTO `ordine_fauna` (`ofa_id`, `ofa_dex`) VALUES
(1, 'Proboscidea'),
(2, 'Primates'),
(3, 'Mammalia'),
(4, 'Aves'),
(5, 'Anfibi'),
(6, 'Pesci');

-- --------------------------------------------------------

--
-- Struttura della tabella `parchi`
--

CREATE TABLE `parchi` (
  `parco_ID` int(11) NOT NULL,
  `parco_dex` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `parchi`
--

INSERT INTO `parchi` (`parco_ID`, `parco_dex`) VALUES
(1, 'Parco Natura Viva'),
(2, 'Safari Park Pombia'),
(3, 'Zoo Safari Ravenna');

-- --------------------------------------------------------

--
-- Struttura della tabella `parchi_flora`
--

CREATE TABLE `parchi_flora` (
  `parchi_flora_id` int(11) NOT NULL,
  `parchi_flora_parco_id` int(11) NOT NULL,
  `parchi_flora_flora_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `parchi_flora`
--

INSERT INTO `parchi_flora` (`parchi_flora_id`, `parchi_flora_parco_id`, `parchi_flora_flora_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3);

-- --------------------------------------------------------

--
-- Struttura della tabella `specie_fauna`
--

CREATE TABLE `specie_fauna` (
  `sfa_id` int(11) NOT NULL,
  `sfa_dex` varchar(30) NOT NULL,
  `sfa_mesi_adulto` int(11) NOT NULL,
  `sfa_rischio_estinzione` enum('si','no') NOT NULL,
  `specie_fauna_ofa_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `specie_fauna`
--

INSERT INTO `specie_fauna` (`sfa_id`, `sfa_dex`, `sfa_mesi_adulto`, `sfa_rischio_estinzione`, `specie_fauna_ofa_id`) VALUES
(1, 'Loxodonta africana', 120, 'si', 1),
(2, 'Panthera leo', 36, 'si', 3),
(3, 'Macropus rufus', 24, 'no', 3),
(4, 'Phoenicopterus roseus', 48, 'no', 4),
(5, 'Cyprinus carpio', 24, 'no', 6);

-- --------------------------------------------------------

--
-- Struttura della tabella `specie_flora`
--

CREATE TABLE `specie_flora` (
  `spl_id` int(11) NOT NULL,
  `spl_dex` varchar(100) NOT NULL,
  `spl_tipo` enum('albero','arbusto','pianta erbacea') NOT NULL,
  `spl_stagione_fioritura` enum('primavera','estate','autunno','inverno') NOT NULL,
  `spl_caratteristiche` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `specie_flora`
--

INSERT INTO `specie_flora` (`spl_id`, `spl_dex`, `spl_tipo`, `spl_stagione_fioritura`, `spl_caratteristiche`) VALUES
(1, 'Pinus pinea', 'albero', 'primavera', 'pinoli commestibili'),
(2, 'Olea europaea', 'albero', 'primavera', 'frutti vengono utilizzati per '),
(3, 'Lavandula stoecha', 'arbusto', 'estate', 'riccamente profumato');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `fauna`
--
ALTER TABLE `fauna`
  ADD PRIMARY KEY (`fau_id`),
  ADD KEY `fau_specie_fauna_fk` (`fau_specie_spf_id`),
  ADD KEY `fau_parco_fk` (`fau_parco_id`);

--
-- Indici per le tabelle `flora`
--
ALTER TABLE `flora`
  ADD PRIMARY KEY (`flo_id`),
  ADD KEY `flo_spl_id` (`flo_spl_id`);

--
-- Indici per le tabelle `gurdia_parco`
--
ALTER TABLE `gurdia_parco`
  ADD PRIMARY KEY (`gua_id`),
  ADD UNIQUE KEY `gua_utente` (`gua_utente`),
  ADD KEY `gua_parco_id` (`gua_parco_id`);

--
-- Indici per le tabelle `ordine_fauna`
--
ALTER TABLE `ordine_fauna`
  ADD PRIMARY KEY (`ofa_id`);

--
-- Indici per le tabelle `parchi`
--
ALTER TABLE `parchi`
  ADD PRIMARY KEY (`parco_ID`);

--
-- Indici per le tabelle `parchi_flora`
--
ALTER TABLE `parchi_flora`
  ADD PRIMARY KEY (`parchi_flora_id`),
  ADD KEY `parchi_flora_flora_id` (`parchi_flora_flora_id`),
  ADD KEY `parchi_flora_parco_id` (`parchi_flora_parco_id`);

--
-- Indici per le tabelle `specie_fauna`
--
ALTER TABLE `specie_fauna`
  ADD PRIMARY KEY (`sfa_id`),
  ADD KEY `specie_fauna_ofa_id` (`specie_fauna_ofa_id`);

--
-- Indici per le tabelle `specie_flora`
--
ALTER TABLE `specie_flora`
  ADD PRIMARY KEY (`spl_id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `fauna`
--
ALTER TABLE `fauna`
  MODIFY `fau_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `fauna`
--
ALTER TABLE `fauna`
  ADD CONSTRAINT `fau_parco_fk` FOREIGN KEY (`fau_parco_id`) REFERENCES `parchi` (`parco_ID`),
  ADD CONSTRAINT `fau_specie_fauna_fk` FOREIGN KEY (`fau_specie_spf_id`) REFERENCES `specie_fauna` (`sfa_id`);

--
-- Limiti per la tabella `flora`
--
ALTER TABLE `flora`
  ADD CONSTRAINT `flora_ibfk_1` FOREIGN KEY (`flo_spl_id`) REFERENCES `specie_flora` (`spl_id`);

--
-- Limiti per la tabella `gurdia_parco`
--
ALTER TABLE `gurdia_parco`
  ADD CONSTRAINT `gurdia_parco_ibfk_1` FOREIGN KEY (`gua_parco_id`) REFERENCES `parchi` (`parco_ID`);

--
-- Limiti per la tabella `parchi_flora`
--
ALTER TABLE `parchi_flora`
  ADD CONSTRAINT `parchi_flora_ibfk_1` FOREIGN KEY (`parchi_flora_flora_id`) REFERENCES `flora` (`flo_id`),
  ADD CONSTRAINT `parchi_flora_ibfk_2` FOREIGN KEY (`parchi_flora_parco_id`) REFERENCES `parchi` (`parco_ID`);

--
-- Limiti per la tabella `specie_fauna`
--
ALTER TABLE `specie_fauna`
  ADD CONSTRAINT `specie_fauna_ibfk_1` FOREIGN KEY (`specie_fauna_ofa_id`) REFERENCES `ordine_fauna` (`ofa_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
