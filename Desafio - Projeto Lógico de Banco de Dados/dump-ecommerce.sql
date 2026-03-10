CREATE DATABASE  IF NOT EXISTS `ecommerce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ecommerce`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `idClient` int NOT NULL AUTO_INCREMENT,
  `Fname` varchar(15) DEFAULT NULL,
  `Minit` varchar(3) DEFAULT NULL,
  `Lname` varchar(20) DEFAULT NULL,
  `CPF` char(11) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idClient`),
  UNIQUE KEY `unique_cpf_client` (`CPF`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Carlos','A','Oliveira','11122233344','Rua das Flores 123, Curitiba - PR'),(2,'Ana','L','Macedo','55566677788','Av. Paulista 1500, São Paulo - SP'),(3,'Bruno','R','Souza','99988877766','Rua da Bahia 45, Belo Horizonte - MG'),(4,'Fernanda','K','Lima','44433322211','Rua dos Coqueiros 78, Salvador - BA'),(5,'Tiago','P','Santos','22233344455','Av. Beira Mar 900, Fortaleza - CE'),(6,'Mariana','C','Rocha','88877766655','Rua General Osório 12, Porto Alegre - RS');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `idOrder` int NOT NULL AUTO_INCREMENT,
  `idOrderClient` int DEFAULT NULL,
  `OrderStatus` enum('Cancelado','Confirmado','Em Processamento') DEFAULT 'Em Processamento',
  `OrderDescription` varchar(255) DEFAULT NULL,
  `ShippingCost` float DEFAULT '10',
  PRIMARY KEY (`idOrder`),
  KEY `fk_orders_client` (`idOrderClient`),
  CONSTRAINT `fk_orders_client` FOREIGN KEY (`idOrderClient`) REFERENCES `clients` (`idClient`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (5,1,'Em Processamento','compra confirmada via app',15.5),(6,2,'Em Processamento','pedido em separacao',25),(7,3,'Confirmado','entrega agendada',NULL),(8,5,'Confirmado','compra site desktop',10);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `idProduct` int NOT NULL AUTO_INCREMENT,
  `Pname` varchar(15) NOT NULL,
  `Classification_kids` tinyint(1) DEFAULT '0',
  `Category` enum('Eletronico','Vestimenta','Brinquedos','Esportes','Alimentos','Veiculos') NOT NULL,
  `Feedback` float DEFAULT '0',
  `Size` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idProduct`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (8,'Teclado RGB',0,'Eletronico',5,NULL),(9,'Lego SW',1,'Brinquedos',5,NULL),(10,'Camiseta G',0,'Vestimenta',4,'G'),(11,'Monitor 24',0,'Eletronico',4,NULL),(12,'Urso Pelucia',1,'Brinquedos',3,'30x20'),(13,'Cafe 500g',0,'Alimentos',5,NULL),(14,'Fone BT',0,'Eletronico',4,NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productorder`
--

DROP TABLE IF EXISTS `productorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productorder` (
  `idPOproduct` int NOT NULL,
  `idPOorder` int NOT NULL,
  `PoQuantity` int DEFAULT '1',
  `poStatus` enum('Disponivel','Sem Estoque') DEFAULT 'Disponivel',
  PRIMARY KEY (`idPOproduct`,`idPOorder`),
  KEY `fk_productOrder_product` (`idPOorder`),
  CONSTRAINT `fk_productOrder_product` FOREIGN KEY (`idPOorder`) REFERENCES `orders` (`idOrder`),
  CONSTRAINT `fk_productOrder_seller` FOREIGN KEY (`idPOproduct`) REFERENCES `product` (`idProduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productorder`
--

LOCK TABLES `productorder` WRITE;
/*!40000 ALTER TABLE `productorder` DISABLE KEYS */;
INSERT INTO `productorder` VALUES (8,5,1,NULL),(11,6,2,NULL),(13,7,5,NULL);
/*!40000 ALTER TABLE `productorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productseller`
--

DROP TABLE IF EXISTS `productseller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productseller` (
  `idPseller` int NOT NULL,
  `idPproduct` int NOT NULL,
  `ProdQuantity` int DEFAULT '1',
  PRIMARY KEY (`idPseller`,`idPproduct`),
  KEY `fk_product_product` (`idPproduct`),
  CONSTRAINT `fk_product_product` FOREIGN KEY (`idPproduct`) REFERENCES `product` (`idProduct`),
  CONSTRAINT `fk_product_seller` FOREIGN KEY (`idPseller`) REFERENCES `seller` (`idSeller`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productseller`
--

LOCK TABLES `productseller` WRITE;
/*!40000 ALTER TABLE `productseller` DISABLE KEYS */;
INSERT INTO `productseller` VALUES (7,11,50),(8,10,30),(9,9,100);
/*!40000 ALTER TABLE `productseller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productstorage`
--

DROP TABLE IF EXISTS `productstorage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productstorage` (
  `idProdStorage` int NOT NULL AUTO_INCREMENT,
  `StorageLocation` varchar(255) DEFAULT NULL,
  `Quantity` int DEFAULT '0',
  PRIMARY KEY (`idProdStorage`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productstorage`
--

LOCK TABLES `productstorage` WRITE;
/*!40000 ALTER TABLE `productstorage` DISABLE KEYS */;
INSERT INTO `productstorage` VALUES (1,'Curitiba',200),(2,'São Paulo',1500),(3,'Belo Horizonte',300),(4,'Fortaleza',450),(5,'Salvador',120),(6,'Recife',90);
/*!40000 ALTER TABLE `productstorage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productsupplier`
--

DROP TABLE IF EXISTS `productsupplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productsupplier` (
  `idPsSupplier` int NOT NULL,
  `idPsProduct` int NOT NULL,
  `Quantity` int NOT NULL,
  PRIMARY KEY (`idPsSupplier`,`idPsProduct`),
  KEY `fk_product_supplier_product` (`idPsProduct`),
  CONSTRAINT `fk_product_supplier_product` FOREIGN KEY (`idPsProduct`) REFERENCES `product` (`idProduct`),
  CONSTRAINT `fk_product_supplier_supplier` FOREIGN KEY (`idPsSupplier`) REFERENCES `supplier` (`idSupplier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productsupplier`
--

LOCK TABLES `productsupplier` WRITE;
/*!40000 ALTER TABLE `productsupplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `productsupplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller` (
  `idSeller` int NOT NULL AUTO_INCREMENT,
  `SocialName` varchar(255) NOT NULL,
  `AbstName` varchar(255) DEFAULT NULL,
  `CNPJ` char(15) DEFAULT NULL,
  `CPF` char(9) DEFAULT NULL,
  `Location` varchar(255) DEFAULT NULL,
  `Contact` char(11) NOT NULL,
  PRIMARY KEY (`idSeller`),
  UNIQUE KEY `unique_CNPJ_seller` (`CNPJ`),
  UNIQUE KEY `unique_CPF_seller` (`CPF`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller`
--

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` VALUES (7,'Global Store','Global','102030400',NULL,'São Paulo','119554433'),(8,'Moda Express','Moda',NULL,'55544433','Rio de Janeiro','219443322'),(9,'Cantinho Kids','Kids','90807060',NULL,'Curitiba','419332211');
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storeagelocation`
--

DROP TABLE IF EXISTS `storeagelocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storeagelocation` (
  `idLproduct` int NOT NULL,
  `idLstorage` int NOT NULL,
  `location` varchar(255) NOT NULL,
  PRIMARY KEY (`idLproduct`,`idLstorage`),
  KEY `fk_storage_location_storage` (`idLstorage`),
  CONSTRAINT `fk_storage_location_product` FOREIGN KEY (`idLproduct`) REFERENCES `product` (`idProduct`),
  CONSTRAINT `fk_storage_location_storage` FOREIGN KEY (`idLstorage`) REFERENCES `productstorage` (`idProdStorage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storeagelocation`
--

LOCK TABLES `storeagelocation` WRITE;
/*!40000 ALTER TABLE `storeagelocation` DISABLE KEYS */;
INSERT INTO `storeagelocation` VALUES (8,2,'SP'),(10,1,'PR');
/*!40000 ALTER TABLE `storeagelocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `idSupplier` int NOT NULL AUTO_INCREMENT,
  `SocialName` varchar(255) NOT NULL,
  `CNPJ` char(15) NOT NULL,
  `Contact` char(11) NOT NULL,
  PRIMARY KEY (`idSupplier`),
  UNIQUE KEY `unique_supplier` (`CNPJ`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Tech Import LTDA','11222333000199','1199887766'),(2,'Brinquedos Alegria','44555666000188','2197766554'),(3,'Grãos do Brasil','77888999000177','3196655443'),(7,'Logistica Express','99888777000166','11911112222'),(8,'Importadora Global','55444333000122','21933334444'),(9,'Distribuidora Sul','22333444000155','51955556666');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-10 18:47:42
