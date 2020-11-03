-- MySQL dump 10.13  Distrib 8.0.20, for Linux (x86_64)
--
-- Host: localhost    Database: flow
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `wf_ac_group_hierarchy`
--

DROP TABLE IF EXISTS `wf_ac_group_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_ac_group_hierarchy` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ac_id` int NOT NULL,
  `group_id` int NOT NULL,
  `reports_to` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ac_id` (`ac_id`,`group_id`),
  KEY `group_id` (`group_id`),
  KEY `reports_to` (`reports_to`),
  CONSTRAINT `wf_ac_group_hierarchy_ibfk_1` FOREIGN KEY (`ac_id`) REFERENCES `wf_access_contexts` (`id`),
  CONSTRAINT `wf_ac_group_hierarchy_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `wf_groups_master` (`id`),
  CONSTRAINT `wf_ac_group_hierarchy_ibfk_3` FOREIGN KEY (`reports_to`) REFERENCES `wf_groups_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_ac_group_hierarchy`
--

LOCK TABLES `wf_ac_group_hierarchy` WRITE;
/*!40000 ALTER TABLE `wf_ac_group_hierarchy` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_ac_group_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_ac_group_roles`
--

DROP TABLE IF EXISTS `wf_ac_group_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_ac_group_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ac_id` int NOT NULL,
  `group_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ac_id` (`ac_id`),
  KEY `group_id` (`group_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `wf_ac_group_roles_ibfk_1` FOREIGN KEY (`ac_id`) REFERENCES `wf_access_contexts` (`id`),
  CONSTRAINT `wf_ac_group_roles_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `wf_groups_master` (`id`),
  CONSTRAINT `wf_ac_group_roles_ibfk_3` FOREIGN KEY (`role_id`) REFERENCES `wf_roles_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_ac_group_roles`
--

LOCK TABLES `wf_ac_group_roles` WRITE;
/*!40000 ALTER TABLE `wf_ac_group_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_ac_group_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `wf_ac_perms_v`
--

DROP TABLE IF EXISTS `wf_ac_perms_v`;
/*!50001 DROP VIEW IF EXISTS `wf_ac_perms_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `wf_ac_perms_v` AS SELECT 
 1 AS `ac_id`,
 1 AS `group_id`,
 1 AS `user_id`,
 1 AS `role_id`,
 1 AS `doctype_id`,
 1 AS `docaction_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `wf_access_contexts`
--

DROP TABLE IF EXISTS `wf_access_contexts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_access_contexts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_access_contexts`
--

LOCK TABLES `wf_access_contexts` WRITE;
/*!40000 ALTER TABLE `wf_access_contexts` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_access_contexts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_docactions_master`
--

DROP TABLE IF EXISTS `wf_docactions_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_docactions_master` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reconfirm` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_docactions_master`
--

LOCK TABLES `wf_docactions_master` WRITE;
/*!40000 ALTER TABLE `wf_docactions_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_docactions_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_docevent_application`
--

DROP TABLE IF EXISTS `wf_docevent_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_docevent_application` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doctype_id` int NOT NULL,
  `doc_id` int NOT NULL,
  `from_state_id` int NOT NULL,
  `docevent_id` int NOT NULL,
  `to_state_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctype_id` (`doctype_id`),
  KEY `from_state_id` (`from_state_id`),
  KEY `docevent_id` (`docevent_id`),
  KEY `to_state_id` (`to_state_id`),
  CONSTRAINT `wf_docevent_application_ibfk_1` FOREIGN KEY (`doctype_id`) REFERENCES `wf_doctypes_master` (`id`),
  CONSTRAINT `wf_docevent_application_ibfk_2` FOREIGN KEY (`from_state_id`) REFERENCES `wf_docstates_master` (`id`),
  CONSTRAINT `wf_docevent_application_ibfk_3` FOREIGN KEY (`docevent_id`) REFERENCES `wf_docevents` (`id`),
  CONSTRAINT `wf_docevent_application_ibfk_4` FOREIGN KEY (`to_state_id`) REFERENCES `wf_docstates_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_docevent_application`
--

LOCK TABLES `wf_docevent_application` WRITE;
/*!40000 ALTER TABLE `wf_docevent_application` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_docevent_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_docevents`
--

DROP TABLE IF EXISTS `wf_docevents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_docevents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doctype_id` int NOT NULL,
  `doc_id` int NOT NULL,
  `docstate_id` int NOT NULL,
  `docaction_id` int NOT NULL,
  `group_id` int NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci,
  `ctime` timestamp NOT NULL,
  `status` enum('A','P') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctype_id` (`doctype_id`),
  KEY `docstate_id` (`docstate_id`),
  KEY `docaction_id` (`docaction_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `wf_docevents_ibfk_1` FOREIGN KEY (`doctype_id`) REFERENCES `wf_doctypes_master` (`id`),
  CONSTRAINT `wf_docevents_ibfk_2` FOREIGN KEY (`docstate_id`) REFERENCES `wf_docstates_master` (`id`),
  CONSTRAINT `wf_docevents_ibfk_3` FOREIGN KEY (`docaction_id`) REFERENCES `wf_docactions_master` (`id`),
  CONSTRAINT `wf_docevents_ibfk_4` FOREIGN KEY (`group_id`) REFERENCES `wf_groups_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_docevents`
--

LOCK TABLES `wf_docevents` WRITE;
/*!40000 ALTER TABLE `wf_docevents` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_docevents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_docstate_transitions`
--

DROP TABLE IF EXISTS `wf_docstate_transitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_docstate_transitions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doctype_id` int NOT NULL,
  `from_state_id` int NOT NULL,
  `docaction_id` int NOT NULL,
  `to_state_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `doctype_id` (`doctype_id`,`from_state_id`,`docaction_id`,`to_state_id`),
  KEY `from_state_id` (`from_state_id`),
  KEY `docaction_id` (`docaction_id`),
  KEY `to_state_id` (`to_state_id`),
  CONSTRAINT `wf_docstate_transitions_ibfk_1` FOREIGN KEY (`doctype_id`) REFERENCES `wf_doctypes_master` (`id`),
  CONSTRAINT `wf_docstate_transitions_ibfk_2` FOREIGN KEY (`from_state_id`) REFERENCES `wf_docstates_master` (`id`),
  CONSTRAINT `wf_docstate_transitions_ibfk_3` FOREIGN KEY (`docaction_id`) REFERENCES `wf_docactions_master` (`id`),
  CONSTRAINT `wf_docstate_transitions_ibfk_4` FOREIGN KEY (`to_state_id`) REFERENCES `wf_docstates_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_docstate_transitions`
--

LOCK TABLES `wf_docstate_transitions` WRITE;
/*!40000 ALTER TABLE `wf_docstate_transitions` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_docstate_transitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_docstates_master`
--

DROP TABLE IF EXISTS `wf_docstates_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_docstates_master` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_docstates_master`
--

LOCK TABLES `wf_docstates_master` WRITE;
/*!40000 ALTER TABLE `wf_docstates_master` DISABLE KEYS */;
INSERT INTO `wf_docstates_master` VALUES (1,'__RESERVED_CHILD_STATE__');
/*!40000 ALTER TABLE `wf_docstates_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_doctypes_master`
--

DROP TABLE IF EXISTS `wf_doctypes_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_doctypes_master` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_doctypes_master`
--

LOCK TABLES `wf_doctypes_master` WRITE;
/*!40000 ALTER TABLE `wf_doctypes_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_doctypes_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_document_blobs`
--

DROP TABLE IF EXISTS `wf_document_blobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_document_blobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doctype_id` int NOT NULL,
  `doc_id` int NOT NULL,
  `sha1sum` char(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `doctype_id` (`doctype_id`,`doc_id`,`sha1sum`),
  CONSTRAINT `wf_document_blobs_ibfk_1` FOREIGN KEY (`doctype_id`) REFERENCES `wf_doctypes_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_document_blobs`
--

LOCK TABLES `wf_document_blobs` WRITE;
/*!40000 ALTER TABLE `wf_document_blobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_document_blobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_document_children`
--

DROP TABLE IF EXISTS `wf_document_children`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_document_children` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_doctype_id` int NOT NULL,
  `parent_id` int NOT NULL,
  `child_doctype_id` int NOT NULL,
  `child_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parent_doctype_id` (`parent_doctype_id`,`parent_id`,`child_doctype_id`,`child_id`),
  KEY `child_doctype_id` (`child_doctype_id`),
  CONSTRAINT `wf_document_children_ibfk_1` FOREIGN KEY (`parent_doctype_id`) REFERENCES `wf_doctypes_master` (`id`),
  CONSTRAINT `wf_document_children_ibfk_2` FOREIGN KEY (`child_doctype_id`) REFERENCES `wf_doctypes_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_document_children`
--

LOCK TABLES `wf_document_children` WRITE;
/*!40000 ALTER TABLE `wf_document_children` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_document_children` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_document_tags`
--

DROP TABLE IF EXISTS `wf_document_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_document_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doctype_id` int NOT NULL,
  `doc_id` int NOT NULL,
  `tag` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `doctype_id` (`doctype_id`,`doc_id`,`tag`),
  CONSTRAINT `wf_document_tags_ibfk_1` FOREIGN KEY (`doctype_id`) REFERENCES `wf_doctypes_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_document_tags`
--

LOCK TABLES `wf_document_tags` WRITE;
/*!40000 ALTER TABLE `wf_document_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_document_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_group_users`
--

DROP TABLE IF EXISTS `wf_group_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_group_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`user_id`),
  CONSTRAINT `wf_group_users_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `wf_groups_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_group_users`
--

LOCK TABLES `wf_group_users` WRITE;
/*!40000 ALTER TABLE `wf_group_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_group_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_groups_master`
--

DROP TABLE IF EXISTS `wf_groups_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_groups_master` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group_type` enum('G','S') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_groups_master`
--

LOCK TABLES `wf_groups_master` WRITE;
/*!40000 ALTER TABLE `wf_groups_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_groups_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_mailboxes`
--

DROP TABLE IF EXISTS `wf_mailboxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_mailboxes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `message_id` int NOT NULL,
  `unread` tinyint(1) NOT NULL,
  `ctime` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`message_id`),
  KEY `message_id` (`message_id`),
  CONSTRAINT `wf_mailboxes_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `wf_groups_master` (`id`),
  CONSTRAINT `wf_mailboxes_ibfk_2` FOREIGN KEY (`message_id`) REFERENCES `wf_messages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_mailboxes`
--

LOCK TABLES `wf_mailboxes` WRITE;
/*!40000 ALTER TABLE `wf_mailboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_mailboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_messages`
--

DROP TABLE IF EXISTS `wf_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doctype_id` int NOT NULL,
  `doc_id` int NOT NULL,
  `docevent_id` int NOT NULL,
  `title` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `doctype_id` (`doctype_id`,`doc_id`,`docevent_id`),
  KEY `docevent_id` (`docevent_id`),
  CONSTRAINT `wf_messages_ibfk_1` FOREIGN KEY (`doctype_id`) REFERENCES `wf_doctypes_master` (`id`),
  CONSTRAINT `wf_messages_ibfk_2` FOREIGN KEY (`docevent_id`) REFERENCES `wf_docevents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_messages`
--

LOCK TABLES `wf_messages` WRITE;
/*!40000 ALTER TABLE `wf_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_role_docactions`
--

DROP TABLE IF EXISTS `wf_role_docactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_role_docactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `doctype_id` int NOT NULL,
  `docaction_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id` (`role_id`,`doctype_id`,`docaction_id`),
  KEY `doctype_id` (`doctype_id`),
  KEY `docaction_id` (`docaction_id`),
  CONSTRAINT `wf_role_docactions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `wf_roles_master` (`id`),
  CONSTRAINT `wf_role_docactions_ibfk_2` FOREIGN KEY (`doctype_id`) REFERENCES `wf_doctypes_master` (`id`),
  CONSTRAINT `wf_role_docactions_ibfk_3` FOREIGN KEY (`docaction_id`) REFERENCES `wf_docactions_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_role_docactions`
--

LOCK TABLES `wf_role_docactions` WRITE;
/*!40000 ALTER TABLE `wf_role_docactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_role_docactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_roles_master`
--

DROP TABLE IF EXISTS `wf_roles_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_roles_master` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_roles_master`
--

LOCK TABLES `wf_roles_master` WRITE;
/*!40000 ALTER TABLE `wf_roles_master` DISABLE KEYS */;
INSERT INTO `wf_roles_master` VALUES (2,'ADMIN'),(1,'SUPER_ADMIN');
/*!40000 ALTER TABLE `wf_roles_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_workflow_nodes`
--

DROP TABLE IF EXISTS `wf_workflow_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_workflow_nodes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doctype_id` int NOT NULL,
  `docstate_id` int NOT NULL,
  `ac_id` int DEFAULT NULL,
  `workflow_id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('begin','end','linear','branch','joinany','joinall') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `doctype_id` (`doctype_id`,`docstate_id`),
  UNIQUE KEY `workflow_id` (`workflow_id`,`name`),
  KEY `docstate_id` (`docstate_id`),
  KEY `ac_id` (`ac_id`),
  CONSTRAINT `wf_workflow_nodes_ibfk_1` FOREIGN KEY (`doctype_id`) REFERENCES `wf_doctypes_master` (`id`),
  CONSTRAINT `wf_workflow_nodes_ibfk_2` FOREIGN KEY (`docstate_id`) REFERENCES `wf_docstates_master` (`id`),
  CONSTRAINT `wf_workflow_nodes_ibfk_3` FOREIGN KEY (`ac_id`) REFERENCES `wf_access_contexts` (`id`),
  CONSTRAINT `wf_workflow_nodes_ibfk_4` FOREIGN KEY (`workflow_id`) REFERENCES `wf_workflows` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_workflow_nodes`
--

LOCK TABLES `wf_workflow_nodes` WRITE;
/*!40000 ALTER TABLE `wf_workflow_nodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_workflow_nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wf_workflows`
--

DROP TABLE IF EXISTS `wf_workflows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wf_workflows` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `doctype_id` int NOT NULL,
  `docstate_id` int NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `doctype_id` (`doctype_id`),
  KEY `docstate_id` (`docstate_id`),
  CONSTRAINT `wf_workflows_ibfk_1` FOREIGN KEY (`doctype_id`) REFERENCES `wf_doctypes_master` (`id`),
  CONSTRAINT `wf_workflows_ibfk_2` FOREIGN KEY (`docstate_id`) REFERENCES `wf_docstates_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wf_workflows`
--

LOCK TABLES `wf_workflows` WRITE;
/*!40000 ALTER TABLE `wf_workflows` DISABLE KEYS */;
/*!40000 ALTER TABLE `wf_workflows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `wf_ac_perms_v`
--

/*!50001 DROP VIEW IF EXISTS `wf_ac_perms_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `wf_ac_perms_v` AS select `ac_grs`.`ac_id` AS `ac_id`,`ac_grs`.`group_id` AS `group_id`,`gu`.`user_id` AS `user_id`,`ac_grs`.`role_id` AS `role_id`,`rdas`.`doctype_id` AS `doctype_id`,`rdas`.`docaction_id` AS `docaction_id` from ((`wf_ac_group_roles` `ac_grs` join `wf_group_users` `gu` on((`ac_grs`.`group_id` = `gu`.`group_id`))) join `wf_role_docactions` `rdas` on((`ac_grs`.`role_id` = `rdas`.`role_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-03  8:19:50
