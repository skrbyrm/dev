-- MySQL dump 10.13  Distrib 8.0.33, for Linux (aarch64)
--
-- Host: instance-2    Database: cons
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `Sessions`
--

DROP TABLE IF EXISTS `Sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sessions` (
  `sid` varchar(36) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `data` text,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `consumptions`
--

DROP TABLE IF EXISTS `consumptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consumptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `active` double DEFAULT NULL,
  `inductive` double DEFAULT NULL,
  `capacitive` double DEFAULT NULL,
  `hno` bigint DEFAULT NULL,
  `ssno` bigint DEFAULT NULL,
  `facility_id` int DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`facility_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125052 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `created_at` BEFORE INSERT ON `consumptions` FOR EACH ROW SET NEW.createdAt = NOW() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `data_by_dates`
--

DROP TABLE IF EXISTS `data_by_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_by_dates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `facility` text,
  `district` text,
  `date` datetime DEFAULT NULL,
  `active` double DEFAULT NULL,
  `capacitive` double DEFAULT NULL,
  `inductive` double DEFAULT NULL,
  `ssno` bigint DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `active_cons` double DEFAULT NULL,
  `inductive_cons` double DEFAULT NULL,
  `capacitive_cons` double DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `data_by_dates_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1706 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `createdAt_dates` BEFORE INSERT ON `data_by_dates` FOR EACH ROW BEGIN
    SET NEW.createdAt = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `data_by_hours`
--

DROP TABLE IF EXISTS `data_by_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_by_hours` (
  `id` int NOT NULL AUTO_INCREMENT,
  `facility` text,
  `district` text,
  `date` datetime DEFAULT NULL,
  `active` double DEFAULT NULL,
  `capacitive` double DEFAULT NULL,
  `inductive` double DEFAULT NULL,
  `ssno` bigint DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `active_cons` double DEFAULT NULL,
  `inductive_cons` double DEFAULT NULL,
  `capacitive_cons` double DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `data_by_hours_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1706 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `createdAt_hours` BEFORE INSERT ON `data_by_hours` FOR EACH ROW BEGIN
    SET NEW.createdAt = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `data_by_months`
--

DROP TABLE IF EXISTS `data_by_months`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_by_months` (
  `id` int NOT NULL AUTO_INCREMENT,
  `facility` text,
  `district` text,
  `date` datetime DEFAULT NULL,
  `active` double DEFAULT NULL,
  `capacitive` double DEFAULT NULL,
  `inductive` double DEFAULT NULL,
  `ssno` bigint DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `active_cons` double DEFAULT NULL,
  `inductive_cons` double DEFAULT NULL,
  `capacitive_cons` double DEFAULT NULL,
  `inductive_ratio` double DEFAULT NULL,
  `capacitive_ratio` double DEFAULT NULL,
  `penalized` tinyint(1) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `data_by_months_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `createdAt_months` BEFORE INSERT ON `data_by_months` FOR EACH ROW BEGIN
    SET NEW.createdAt = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `data_by_weeks`
--

DROP TABLE IF EXISTS `data_by_weeks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_by_weeks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `facility` text,
  `district` text,
  `date` datetime DEFAULT NULL,
  `active` double DEFAULT NULL,
  `capacitive` double DEFAULT NULL,
  `inductive` double DEFAULT NULL,
  `ssno` bigint DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `active_cons` double DEFAULT NULL,
  `inductive_cons` double DEFAULT NULL,
  `capacitive_cons` double DEFAULT NULL,
  `inductive_ratio` double DEFAULT NULL,
  `capacitive_ratio` double DEFAULT NULL,
  `penalized` tinyint(1) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `data_by_weeks_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=954 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `createdAt_weeks` BEFORE INSERT ON `data_by_weeks` FOR EACH ROW BEGIN
    SET NEW.createdAt = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `firm_list`
--

DROP TABLE IF EXISTS `firm_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `firm_list` (
  `service_point_number` bigint DEFAULT NULL,
  `ssno` bigint DEFAULT NULL,
  `city` text,
  `district` text,
  `facility` text,
  `meter_id` bigint DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `facility_id` bigint DEFAULT NULL,
  `adress_id` bigint DEFAULT NULL,
  `os_username` bigint DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `createdAt_firm` BEFORE INSERT ON `firm_list` FOR EACH ROW BEGIN
    SET NEW.createdAt = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'cons'
--
/*!50003 DROP PROCEDURE IF EXISTS `daily_by_ssno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `daily_by_ssno`(
meterid int
)
BEGIN
DROP TEMPORARY TABLE IF EXISTS temp_day;
CREATE TEMPORARY TABLE temp_day AS
SELECT *
FROM (
	SELECT *
FROM (
	SELECT 
	firm_list.facility, firm_list.district, q.date, q.active, q.capacitive, q.inductive, q.ssno, q.userId
	,ROUND(q.active - coalesce(lag(q.active) over (partition by  q.ssno order by q.date asc), 0),2) AS active_cons
	,ROUND(q.inductive - coalesce(lag(q.inductive) over (partition by  q.ssno order by q.date asc), 0),2) AS inductive_cons
	,ROUND(q.capacitive - coalesce(lag(q.capacitive) over (partition by  q.ssno order by q.date asc), 0),2) AS capacitive_cons
	FROM (
	SELECT 
		firm_list.userId userId,
		firm_list.ssno ssno
		,MAX(c.date) date
		,MAX(c.active) active
		,MAX(c.inductive) inductive
		,MAX(c.capacitive) capacitive

	FROM            
		consumptions c
	INNER JOIN
		firm_list ON c.ssno = firm_list.ssno
	GROUP BY firm_list.ssno, firm_list.userId, day(`date`)
	) AS q

	INNER JOIN
			firm_list ON q.ssno = firm_list.ssno
	WHERE firm_list.ssno = meterid
    order by date ASC
    LIMIT 1000 OFFSET 1
) AS tab
) AS result
order by result.date DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `data_by_dates` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `data_by_dates`(
)
BEGIN
	DECLARE num INT DEFAULT 0;
    TRUNCATE TABLE data_by_dates;
	DROP TEMPORARY TABLE IF EXISTS temp_t;
	CREATE TEMPORARY TABLE temp_t
	SELECT ssno,userId FROM firm_list;
	SET @counter = (select count(ssno) from temp_t);
    
	WHILE num <= @counter DO
		set @assno = (select ssno from temp_t LIMIT 1);
		CALL daily_by_ssno(@assno);
		DELETE FROM temp_t WHERE temp_t.ssno = @assno;
		INSERT INTO data_by_dates (facility, district, date, active, capacitive, 
        inductive, ssno, userId, active_cons, inductive_cons, capacitive_cons)  SELECT *FROM temp_day;
		SET num = num + 1;
	END WHILE;
DROP TEMPORARY TABLE IF EXISTS temp_t;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `data_by_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `data_by_hours`(
)
BEGIN
	DECLARE num INT DEFAULT 0;
    TRUNCATE TABLE data_by_hours;
	DROP TEMPORARY TABLE IF EXISTS temp_t;
	CREATE TEMPORARY TABLE temp_t
	SELECT ssno,userId FROM firm_list;
	SET @counter = (select count(ssno) from temp_t);
    
	WHILE num <= @counter DO
		set @assno = (select ssno from temp_t LIMIT 1);
		CALL hourly_by_ssno(@assno);
		DELETE FROM temp_t WHERE temp_t.ssno = @assno;
		INSERT INTO data_by_hours (facility, district, date, active, capacitive, 
        inductive, ssno, userId, active_cons, inductive_cons, capacitive_cons) SELECT *FROM temp_hour;
		SET num = num + 1;
	END WHILE;
DROP TEMPORARY TABLE IF EXISTS temp_t;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `data_by_months` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `data_by_months`(
)
BEGIN
	DECLARE num INT DEFAULT 0;
    TRUNCATE TABLE data_by_months;
	DROP TEMPORARY TABLE IF EXISTS temp_t;
	CREATE TEMPORARY TABLE temp_t
	SELECT ssno,userId FROM firm_list;
	SET @counter = (select count(ssno) from temp_t);

	WHILE num <= @counter DO
		set @assno = (select ssno from temp_t LIMIT 1);
		CALL monthly_current_by_ssno(@assno);
		DELETE FROM temp_t WHERE temp_t.ssno = @assno;
		INSERT INTO data_by_months (facility, district, date, active, capacitive, 
        inductive, ssno, userId, active_cons, inductive_cons, capacitive_cons, 
        inductive_ratio, capacitive_ratio, penalized) SELECT * FROM temp_month;
		SET num = num + 1;
	END WHILE;
DROP TEMPORARY TABLE IF EXISTS temp_t;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `data_by_weeks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `data_by_weeks`(
)
BEGIN
	DECLARE num INT DEFAULT 0;
    TRUNCATE TABLE data_by_weeks;
	DROP TEMPORARY TABLE IF EXISTS temp_t;
	CREATE TEMPORARY TABLE temp_t
	SELECT ssno,userId FROM firm_list;
	SET @counter = (select count(ssno) from temp_t);

	WHILE num <= @counter DO
		set @assno = (select ssno from temp_t LIMIT 1);
		CALL weekly(@assno);
		DELETE FROM temp_t WHERE temp_t.ssno = @assno;
		INSERT INTO data_by_weeks (facility, district, date, active, capacitive, 
        inductive, ssno, userId, active_cons, inductive_cons, capacitive_cons, 
        inductive_ratio, capacitive_ratio, penalized) SELECT *FROM temp_week;
		SET num = num + 1;
	END WHILE;
DROP TEMPORARY TABLE IF EXISTS temp_t;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `hourly_by_ssno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `hourly_by_ssno`(
meterid int
)
BEGIN
DROP TEMPORARY TABLE IF EXISTS temp_hour;
CREATE TEMPORARY TABLE temp_hour AS
SELECT *
FROM (
	SELECT *
FROM (
	SELECT 
	firm_list.facility, firm_list.district, q.date, q.active, q.capacitive, q.inductive, q.ssno, q.userId
	,ROUND(q.active - coalesce(lag(q.active) over (partition by  q.ssno order by q.date asc), 0),2) AS active_cons
	,ROUND(q.inductive - coalesce(lag(q.inductive) over (partition by  q.ssno order by q.date asc), 0),2) AS inductive_cons
	,ROUND(q.capacitive - coalesce(lag(q.capacitive) over (partition by  q.ssno order by q.date asc), 0),2) AS capacitive_cons
	FROM (
	SELECT 
		firm_list.userId userId,
		firm_list.ssno ssno
		,MAX(c.date) date
		,MAX(c.active) active
		,MAX(c.inductive) inductive
		,MAX(c.capacitive) capacitive

	FROM            
		consumptions c
	INNER JOIN
		firm_list ON c.ssno = firm_list.ssno
	GROUP BY firm_list.ssno, firm_list.userId, hour(`date`)
	) AS q

	INNER JOIN
			firm_list ON q.ssno = firm_list.ssno
	WHERE firm_list.ssno = meterid
    order by date ASC
    LIMIT 100 OFFSET 1
) AS tab
) AS result
order by result.date DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `monthly_current_by_ssno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `monthly_current_by_ssno`(
meterid int
)
BEGIN
DROP TEMPORARY TABLE IF EXISTS temp_month;
CREATE TEMPORARY TABLE temp_month AS
SELECT *
FROM (
	SELECT *, (tab.inductive_ratio >= 20 or tab.capacitive_ratio >= 15 ) penalized
FROM (
	SELECT 
	firm_list.facility, firm_list.district, q.date, q.active, q.capacitive, q.inductive, q.ssno, q.userId
	,ROUND(q.active - coalesce(lag(q.active) over (partition by  q.ssno order by q.date asc), 0),2) AS active_cons
	,ROUND(q.inductive - coalesce(lag(q.inductive) over (partition by  q.ssno order by q.date asc), 0),2) AS inductive_cons
	,ROUND(q.capacitive - coalesce(lag(q.capacitive) over (partition by  q.ssno order by q.date asc), 0),2) AS capacitive_cons
	,CASE 
	  WHEN q.active - coalesce(lag(q.active) over (partition by  q.ssno order by q.date asc), 0) = 0 THEN 0 
	  ELSE ROUND(((q.inductive - coalesce(lag(q.inductive) over (partition by  q.ssno order by q.date asc), 0)) / (q.active - coalesce(lag(q.active) over (partition by  q.ssno order by q.date asc)))) * 100,4) 
	END AS inductive_ratio
	,CASE 
	  WHEN q.active - coalesce(lag(q.active) over (partition by  q.ssno order by q.date asc), 0) = 0 THEN 0 
	  ELSE ROUND(((q.capacitive - coalesce(lag(q.capacitive) over (partition by  q.ssno order by q.date asc), 0)) / (q.active - coalesce(lag(q.active) over (partition by  q.ssno order by q.date asc)))) * 100,4) 
	END AS capacitive_ratio

	FROM (
	SELECT 
		firm_list.userId userId,
		firm_list.ssno ssno
		,MAX(c.date) date
		,MAX(c.active) active
		,MAX(c.inductive) inductive
		,MAX(c.capacitive) capacitive

	FROM            
		consumptions c
	INNER JOIN
		firm_list ON c.ssno = firm_list.ssno
	GROUP BY firm_list.ssno, firm_list.userId, month(`date`)
	) AS q

	INNER JOIN
			firm_list ON q.ssno = firm_list.ssno
	WHERE firm_list.ssno = meterid
		order by date desc
		limit 1
) AS tab
) AS result
order by result.date DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_all` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_all`()
BEGIN
SET FOREIGN_KEY_CHECKS = 0;
   CALL data_by_months;
SET FOREIGN_KEY_CHECKS = 1;
   
SET FOREIGN_KEY_CHECKS = 0;
   CALL data_by_weeks;
SET FOREIGN_KEY_CHECKS = 1;
   
SET FOREIGN_KEY_CHECKS = 0;
   CALL data_by_dates;
SET FOREIGN_KEY_CHECKS = 1;   
   
SET FOREIGN_KEY_CHECKS = 0;   
   CALL data_by_hours;
SET FOREIGN_KEY_CHECKS = 1;   
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `weekly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `weekly`(
meterid int
)
BEGIN

DROP TEMPORARY TABLE IF EXISTS temp_week;
CREATE TEMPORARY TABLE temp_week AS
SELECT *
FROM (
	SELECT *, (tab.inductive_ratio >= 20 or tab.capacitive_ratio >= 15 ) penalized
FROM (
	SELECT 
	firm_list.facility, firm_list.district, q.date, q.active, q.capacitive, q.inductive, q.ssno, q.userId
	,ROUND(q.active - coalesce(lag(q.active) over (partition by  q.ssno order by q.date asc), 0),2) AS active_cons
	,ROUND(q.inductive - coalesce(lag(q.inductive) over (partition by  q.ssno order by q.date asc), 0),2) AS inductive_cons
	,ROUND(q.capacitive - coalesce(lag(q.capacitive) over (partition by  q.ssno order by q.date asc), 0),2) AS capacitive_cons
    ,CASE 
	  WHEN q.active - coalesce(lag(q.active) over (partition by  q.ssno order by q.date asc), 0) = 0 THEN 1 
	  ELSE ROUND(((q.inductive - coalesce(lag(q.inductive) over (partition by  q.ssno order by q.date asc), 0)) / (q.active - coalesce(lag(q.active) over (partition by  q.ssno order by q.date asc)))) * 100,4) 
	END AS inductive_ratio
	,CASE 
	  WHEN q.active - coalesce(lag(q.active) over (partition by  q.ssno order by q.date asc), 0) = 0 THEN 1 
	  ELSE ROUND(((q.capacitive - coalesce(lag(q.capacitive) over (partition by  q.ssno order by q.date asc), 0)) / (q.active - coalesce(lag(q.active) over (partition by  q.ssno order by q.date asc)))) * 100,4) 
	END AS capacitive_ratio

	FROM (
	SELECT 
		firm_list.userId userId,
		firm_list.ssno ssno
		,MAX(c.date) date
		,MAX(c.active) active
		,MAX(c.inductive) inductive
		,MAX(c.capacitive) capacitive

	FROM            
		consumptions c
	INNER JOIN
		firm_list ON c.ssno = firm_list.ssno
	GROUP BY firm_list.ssno, firm_list.userId, week(`date`)
	) AS q

	INNER JOIN
			firm_list ON q.ssno = firm_list.ssno
	WHERE firm_list.ssno = meterid
    order by date ASC
    LIMIT 100 OFFSET 1
) AS tab
) AS result
order by result.date DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `weekly_by_ssno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `weekly_by_ssno`(
meterid int
)
BEGIN

DROP TEMPORARY TABLE IF EXISTS temp_week;
CREATE TEMPORARY TABLE temp_week AS
SELECT *
FROM (
	SELECT *, (tab.inductive_ratio >= 20 or tab.capacitive_ratio >= 15 ) penalized
FROM (
	SELECT 
	firm_list.facility, firm_list.district, q.date, q.active, q.capacitive, q.inductive, q.ssno, q.userId
	,ROUND(q.active - coalesce(lag(q.active) over (partition by  q.ssno order by q.date asc), 0),2) AS active_cons
	,ROUND(q.inductive - coalesce(lag(q.inductive) over (partition by  q.ssno order by q.date asc), 0),2) AS inductive_cons
	,ROUND(q.capacitive - coalesce(lag(q.capacitive) over (partition by  q.ssno order by q.date asc), 0),2) AS capacitive_cons
	,ROUND(((q.inductive - coalesce(lag(q.inductive) over (partition by  q.ssno order by q.date asc), 0)) / (q.active - coalesce(lag(q.active) over (partition by  q.ssno order by q.date asc)))) * 100,4) AS inductive_ratio
	,ROUND(((q.capacitive - coalesce(lag(q.capacitive) over (partition by  q.ssno order by q.date asc), 0)) / (q.active - coalesce(lag(q.active) over (partition by  q.ssno order by q.date asc)))) * 100,4) AS capacitive_ratio

	FROM (
	SELECT 
		firm_list.userId userId,
		firm_list.ssno ssno
		,MAX(c.date) date
		,MAX(c.active) active
		,MAX(c.inductive) inductive
		,MAX(c.capacitive) capacitive

	FROM            
		consumptions c
	INNER JOIN
		firm_list ON c.ssno = firm_list.ssno
	GROUP BY firm_list.ssno, firm_list.userId, week(`date`)
	) AS q

	INNER JOIN
			firm_list ON q.ssno = firm_list.ssno
	WHERE firm_list.ssno = meterid
    order by date ASC
    LIMIT 100 OFFSET 1
) AS tab
) AS result
order by result.date DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-18 15:23:21
