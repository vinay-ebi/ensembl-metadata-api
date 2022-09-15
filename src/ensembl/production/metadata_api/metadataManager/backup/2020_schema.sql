-- MySQL dump 10.13  Distrib 5.7.39, for Linux (x86_64)
--
-- Host: mysql-ens-sta-6    Database: ensembl_metadata_2020
-- ------------------------------------------------------
-- Server version	5.6.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assembly`
--

DROP TABLE IF EXISTS `assembly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assembly` (
  `assembly_id` int(11) NOT NULL AUTO_INCREMENT,
  `ucsc_name` varchar(16) DEFAULT NULL,
  `accession` varchar(16) NOT NULL,
  `level` varchar(32) NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`assembly_id`),
  UNIQUE KEY `accession` (`accession`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assembly_sequence`
--

DROP TABLE IF EXISTS `assembly_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assembly_sequence` (
  `assembly_sequence_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `assembly_id` int(11) NOT NULL,
  `accession` varchar(32) NOT NULL,
  `chromosomal` tinyint(1) NOT NULL,
  `length` int(11) NOT NULL,
  `sequence_location` varchar(10) DEFAULT NULL,
  `sequence_checksum` varchar(32) DEFAULT NULL,
  `ga4gh_identifier` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`assembly_sequence_id`),
  UNIQUE KEY `assembly_sequence_assembly_id_accession_5f3e5119_uniq` (`assembly_id`,`accession`),
  KEY `assembly_sequence_assembly_id_2a84ddcb` (`assembly_id`),
  CONSTRAINT `assembly_sequence_assembly_id_2a84ddcb_fk_assembly_assembly_id` FOREIGN KEY (`assembly_id`) REFERENCES `assembly` (`assembly_id`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attribute`
--

DROP TABLE IF EXISTS `attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attribute` (
  `attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `label` varchar(128) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`attribute_id`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataset`
--

DROP TABLE IF EXISTS `dataset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset` (
  `dataset_id` int(11) NOT NULL AUTO_INCREMENT,
  `dataset_uuid` varchar(128) NOT NULL,
  `dataset_type_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `version` varchar(128) DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `dataset_source_id` int(11) NOT NULL,
  `label` varchar(128) NOT NULL,
  PRIMARY KEY (`dataset_id`),
  UNIQUE KEY `dataset_uuid` (`dataset_uuid`),
  KEY `dataset_dataset_source_id_fd96f115_fk_dataset_s` (`dataset_source_id`),
  KEY `dataset_type_id_eb55ae9a` (`dataset_type_id`),
  CONSTRAINT `dataset_dataset_source_id_fd96f115_fk_dataset_s` FOREIGN KEY (`dataset_source_id`) REFERENCES `dataset_source` (`dataset_source_id`),
  CONSTRAINT `dataset_dataset_type_id_47284562_fk_dataset_type_dataset_type_id` FOREIGN KEY (`dataset_type_id`) REFERENCES `dataset_type` (`dataset_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=671 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataset_attribute`
--

DROP TABLE IF EXISTS `dataset_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset_attribute` (
  `dataset_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `value` varchar(128) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  `dataset_id` int(11) NOT NULL,
  PRIMARY KEY (`dataset_attribute_id`),
  UNIQUE KEY `dataset_attribute_dataset_id_attribute_id__d3b34d8c_uniq` (`dataset_id`,`attribute_id`,`type`,`value`),
  KEY `dataset_attribute_attribute_id_55c51407_fk_attribute` (`attribute_id`),
  KEY `dataset_attribute_dataset_id_2e2afe19` (`dataset_id`),
  CONSTRAINT `dataset_attribute_attribute_id_55c51407_fk_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `attribute` (`attribute_id`),
  CONSTRAINT `dataset_attribute_dataset_id_2e2afe19_fk_dataset_dataset_id` FOREIGN KEY (`dataset_id`) REFERENCES `dataset` (`dataset_id`)
) ENGINE=InnoDB AUTO_INCREMENT=586 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataset_source`
--

DROP TABLE IF EXISTS `dataset_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset_source` (
  `dataset_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`dataset_source_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataset_type`
--

DROP TABLE IF EXISTS `dataset_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset_type` (
  `dataset_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `label` varchar(128) NOT NULL,
  `topic` varchar(32) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `details_uri` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`dataset_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ensembl_release`
--

DROP TABLE IF EXISTS `ensembl_release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ensembl_release` (
  `release_id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `release_date` date NOT NULL,
  `label` varchar(64) DEFAULT NULL,
  `is_current` tinyint(1) NOT NULL,
  `site_id` int(11) DEFAULT NULL,
  `release_type` varchar(16) NOT NULL,
  PRIMARY KEY (`release_id`),
  UNIQUE KEY `ensembl_release_version_site_id_b743399a_uniq` (`version`,`site_id`),
  KEY `ensembl_release_site_id_7c2f537a_fk_ensembl_site_site_id` (`site_id`),
  CONSTRAINT `ensembl_release_site_id_7c2f537a_fk_ensembl_site_site_id` FOREIGN KEY (`site_id`) REFERENCES `ensembl_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ensembl_site`
--

DROP TABLE IF EXISTS `ensembl_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ensembl_site` (
  `site_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `label` varchar(64) NOT NULL,
  `uri` varchar(64) NOT NULL,
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `genome`
--

DROP TABLE IF EXISTS `genome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genome` (
  `genome_id` int(11) NOT NULL AUTO_INCREMENT,
  `genome_uuid` varchar(128) NOT NULL,
  `assembly_id` int(11) NOT NULL,
  `organism_id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  PRIMARY KEY (`genome_id`),
  UNIQUE KEY `genome_uuid` (`genome_uuid`),
  KEY `genome_assembly_id_0a748388_fk_assembly_assembly_id` (`assembly_id`),
  KEY `genome_organism_id_99ad7f35_fk_organism_organism_id` (`organism_id`),
  CONSTRAINT `genome_assembly_id_0a748388_fk_assembly_assembly_id` FOREIGN KEY (`assembly_id`) REFERENCES `assembly` (`assembly_id`),
  CONSTRAINT `genome_organism_id_99ad7f35_fk_organism_organism_id` FOREIGN KEY (`organism_id`) REFERENCES `organism` (`organism_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `genome_dataset`
--

DROP TABLE IF EXISTS `genome_dataset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genome_dataset` (
  `genome_dataset_id` int(11) NOT NULL AUTO_INCREMENT,
  `dataset_id` int(11) NOT NULL,
  `genome_id` int(11) NOT NULL,
  `release_id` int(11) NOT NULL,
  `is_current` tinyint(1) NOT NULL,
  PRIMARY KEY (`genome_dataset_id`),
  KEY `ensembl_metadata_gen_dataset_id_26d7bac7_fk_dataset_d` (`dataset_id`),
  KEY `ensembl_metadata_gen_genome_id_7670a2c5_fk_genome_ge` (`genome_id`),
  KEY `ensembl_metadata_gen_release_id_c5440b9a_fk_ensembl_r` (`release_id`),
  CONSTRAINT `ensembl_metadata_gen_dataset_id_26d7bac7_fk_dataset_d` FOREIGN KEY (`dataset_id`) REFERENCES `dataset` (`dataset_id`),
  CONSTRAINT `ensembl_metadata_gen_genome_id_7670a2c5_fk_genome_ge` FOREIGN KEY (`genome_id`) REFERENCES `genome` (`genome_id`),
  CONSTRAINT `ensembl_metadata_gen_release_id_c5440b9a_fk_ensembl_r` FOREIGN KEY (`release_id`) REFERENCES `ensembl_release` (`release_id`)
) ENGINE=InnoDB AUTO_INCREMENT=928 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `genome_release`
--

DROP TABLE IF EXISTS `genome_release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genome_release` (
  `genome_release_id` int(11) NOT NULL AUTO_INCREMENT,
  `genome_id` int(11) NOT NULL,
  `release_id` int(11) NOT NULL,
  `is_current` tinyint(1) NOT NULL,
  PRIMARY KEY (`genome_release_id`),
  KEY `genome_release_genome_id_3e45dc04_fk` (`genome_id`),
  KEY `genome_release_release_id_bca7e1e5_fk_ensembl_release_release_id` (`release_id`),
  CONSTRAINT `genome_release_genome_id_3e45dc04_fk` FOREIGN KEY (`genome_id`) REFERENCES `genome` (`genome_id`),
  CONSTRAINT `genome_release_release_id_bca7e1e5_fk_ensembl_release_release_id` FOREIGN KEY (`release_id`) REFERENCES `ensembl_release` (`release_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organism`
--

DROP TABLE IF EXISTS `organism`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organism` (
  `organism_id` int(11) NOT NULL AUTO_INCREMENT,
  `taxonomy_id` int(11) NOT NULL,
  `species_taxonomy_id` int(11) DEFAULT NULL,
  `display_name` varchar(128) NOT NULL,
  `strain` varchar(128) DEFAULT NULL,
  `scientific_name` varchar(128) DEFAULT NULL,
  `url_name` varchar(128) NOT NULL,
  `ensembl_name` varchar(128) NOT NULL,
  PRIMARY KEY (`organism_id`),
  UNIQUE KEY `ensembl_name` (`ensembl_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organism_group`
--

DROP TABLE IF EXISTS `organism_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organism_group` (
  `organism_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(48) DEFAULT NULL,
  PRIMARY KEY (`organism_group_id`),
  UNIQUE KEY `group_type_name_63c2f6ac_uniq` (`type`,`name`),
  UNIQUE KEY `organism_group_code_uindex` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organism_group_member`
--

DROP TABLE IF EXISTS `organism_group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organism_group_member` (
  `organism_group_member_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_reference` tinyint(1) NOT NULL,
  `organism_id` int(11) NOT NULL,
  `organism_group_id` int(11) NOT NULL,
  PRIMARY KEY (`organism_group_member_id`),
  UNIQUE KEY `organism_group_member_organism_id_organism_gro_fe8f49ac_uniq` (`organism_id`,`organism_group_id`),
  KEY `organism_group_membe_organism_group_id_533ca128_fk_organism_` (`organism_group_id`),
  CONSTRAINT `organism_group_membe_organism_group_id_533ca128_fk_organism_` FOREIGN KEY (`organism_group_id`) REFERENCES `organism_group` (`organism_group_id`),
  CONSTRAINT `organism_group_membe_organism_id_2808252e_fk_organism_` FOREIGN KEY (`organism_id`) REFERENCES `organism` (`organism_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-15 16:27:18
