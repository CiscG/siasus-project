-- MySQL dump 10.13  Distrib 8.4.6, for Linux (x86_64)
--
-- Host: localhost    Database: francisco_siasus
-- ------------------------------------------------------
-- Server version	8.4.6-0ubuntu3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cadgerrs`
--

DROP TABLE IF EXISTS `cadgerrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cadgerrs` (
  `id_cadgerr` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `descricao` text COLLATE latin1_general_ci,
  PRIMARY KEY (`id_cadgerr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cbo`
--

DROP TABLE IF EXISTS `cbo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cbo` (
  `pa_cbocod` char(6) COLLATE latin1_general_ci NOT NULL,
  `descricao` varchar(150) COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`pa_cbocod`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cid10`
--

DROP TABLE IF EXISTS `cid10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cid10` (
  `pa_cidpri` char(4) COLLATE latin1_general_ci NOT NULL,
  `descricao` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`pa_cidpri`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `micro`
--

DROP TABLE IF EXISTS `micro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `micro` (
  `id_micro` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_micro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `municipio`
--

DROP TABLE IF EXISTS `municipio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `municipio` (
  `cod_municipio` char(6) COLLATE latin1_general_ci NOT NULL,
  `nome` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `uf` char(2) COLLATE latin1_general_ci NOT NULL,
  `id_rl` int DEFAULT NULL,
  PRIMARY KEY (`cod_municipio`),
  KEY `id_rl` (`id_rl`),
  CONSTRAINT `municipio_ibfk_1` FOREIGN KEY (`id_rl`) REFERENCES `rl` (`id_rl`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pars`
--

DROP TABLE IF EXISTS `pars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pars` (
  `id_par` int NOT NULL AUTO_INCREMENT,
  `pa_coduni` char(7) COLLATE latin1_general_ci NOT NULL,
  `pa_ufmun` char(6) COLLATE latin1_general_ci NOT NULL,
  `pa_proc_id` char(10) COLLATE latin1_general_ci NOT NULL,
  `pa_cbocod` char(6) COLLATE latin1_general_ci NOT NULL,
  `pa_cidpri` char(4) COLLATE latin1_general_ci NOT NULL,
  `pa_docorig` char(1) COLLATE latin1_general_ci DEFAULT NULL,
  `pa_tippre` char(2) COLLATE latin1_general_ci DEFAULT NULL,
  `pa_tpups` char(2) COLLATE latin1_general_ci DEFAULT NULL,
  `pa_qtdpro` int DEFAULT NULL,
  `pa_qtdapr` int DEFAULT NULL,
  `pa_valpro` decimal(20,2) DEFAULT NULL,
  `pa_valapr` decimal(20,2) DEFAULT NULL,
  `id_cadgerr` int DEFAULT NULL,
  PRIMARY KEY (`id_par`),
  KEY `pa_cidpri` (`pa_cidpri`),
  KEY `id_cadgerr` (`id_cadgerr`),
  KEY `idx_proc` (`pa_proc_id`),
  KEY `idx_municipio` (`pa_ufmun`),
  KEY `idx_cbo` (`pa_cbocod`),
  CONSTRAINT `pars_ibfk_1` FOREIGN KEY (`pa_ufmun`) REFERENCES `municipio` (`cod_municipio`),
  CONSTRAINT `pars_ibfk_2` FOREIGN KEY (`pa_proc_id`) REFERENCES `procedimento` (`pa_proc_id`),
  CONSTRAINT `pars_ibfk_3` FOREIGN KEY (`pa_cbocod`) REFERENCES `cbo` (`pa_cbocod`),
  CONSTRAINT `pars_ibfk_4` FOREIGN KEY (`pa_cidpri`) REFERENCES `cid10` (`pa_cidpri`),
  CONSTRAINT `pars_ibfk_5` FOREIGN KEY (`id_cadgerr`) REFERENCES `cadgerrs` (`id_cadgerr`)
) ENGINE=InnoDB AUTO_INCREMENT=7864208 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procedimento`
--

DROP TABLE IF EXISTS `procedimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedimento` (
  `pa_proc_id` char(10) COLLATE latin1_general_ci NOT NULL,
  `descricao` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  `nivel_complexidade` char(1) COLLATE latin1_general_ci DEFAULT NULL,
  `tipo_financiamento` char(2) COLLATE latin1_general_ci DEFAULT NULL,
  `subtipo_financiamento` char(4) COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`pa_proc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rl`
--

DROP TABLE IF EXISTS `rl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rl` (
  `id_rl` int NOT NULL AUTO_INCREMENT,
  `cod_municipio` char(6) COLLATE latin1_general_ci DEFAULT NULL,
  `id_micro` int DEFAULT NULL,
  PRIMARY KEY (`id_rl`),
  KEY `cod_municipio` (`cod_municipio`),
  KEY `id_micro` (`id_micro`),
  CONSTRAINT `rl_ibfk_1` FOREIGN KEY (`cod_municipio`) REFERENCES `municipio` (`cod_municipio`),
  CONSTRAINT `rl_ibfk_2` FOREIGN KEY (`id_micro`) REFERENCES `micro` (`id_micro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-07 12:43:27
