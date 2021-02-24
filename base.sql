-- MySQL dump 10.13  Distrib 8.0.23, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: DB_project
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idQuestionnaire` int NOT NULL,
  `idQuestion` int NOT NULL,
  `text` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_answer_1_idx` (`idQuestion`),
  KEY `fk_answer_2_idx` (`idQuestionnaire`),
  CONSTRAINT `fk_answer_1` FOREIGN KEY (`idQuestion`) REFERENCES `question` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_answer_2` FOREIGN KEY (`idQuestionnaire`) REFERENCES `questionnaire` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (1,1,1,'DAVVERO BUONO'),(2,1,3,'Lo lascerei esattamente cosÃ¬'),(3,1,2,'ASSOLUTAMENTE');
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `bannedWord` BEFORE INSERT ON `answer` FOR EACH ROW BEGIN
	IF ((SELECT count(*)
			FROM blacklist_word
			WHERE new.text LIKE CONCAT('%', word, '%')) > 0)
	THEN
		DELETE FROM questionnaire WHERE new.idQuestionnaire = id;
        SIGNAL sqlstate '45001' set message_text = "User used a banned word!";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `point1` AFTER INSERT ON `answer` FOR EACH ROW BEGIN
	DECLARE my_idUser INT;

	SELECT idUser INTO my_idUser
	FROM questionnaire 
	WHERE new.idQuestionnaire = id AND isSubmitted = 1;

	UPDATE user
	SET score = score + 1 
	WHERE id = my_idUser;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `blacklist_word`
--

DROP TABLE IF EXISTS `blacklist_word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blacklist_word` (
  `word` varchar(45) NOT NULL,
  PRIMARY KEY (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blacklist_word`
--

LOCK TABLES `blacklist_word` WRITE;
/*!40000 ALTER TABLE `blacklist_word` DISABLE KEYS */;
INSERT INTO `blacklist_word` VALUES ('bianco'),('nero');
/*!40000 ALTER TABLE `blacklist_word` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `time` bigint NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_log_1_idx` (`idUser`),
  CONSTRAINT `fk_log_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,1,1614209090901,'2021-02-25'),(3,1,1614209138184,'2021-02-25'),(4,1,1614209170095,'2021-02-25'),(10,1,1614209308242,'2021-02-25'),(12,2,1614209935730,'2021-02-25'),(13,3,1614209941709,'2021-02-25'),(14,4,1614209947634,'2021-02-25'),(15,5,1614209965689,'2021-02-25'),(16,6,1614209971929,'2021-02-25'),(17,2,1614210115131,'2021-02-25'),(18,2,1614210229675,'2021-02-25'),(19,2,1614210312735,'2021-02-25');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `imageFile` blob NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Nasello',_binary 'RIFF@\ò\0\0WEBPVP8L3\ò\0\0/1Á2MP’$9$µ!ˆp\0\ñÿs\éu\æ\Ñÿ	à¿³şˆ*\Şı0ü­ª¾\ÆK\á³\ç´G»G\ÕH·pa\ãªzø\n\×x»†kü\Ñİ’l×\Ç7\ë\Z\Ü#z-I<\ä”	T\÷ÓŠ<^k\Î/P”{ª×ª^\ò S\\_\n¼»\ÔÍ«\Ä}ÀÛ¶!UuBš\nÀÍ—\0»­1\Æh@w€9O¾•[’‰8™™}‹˜k\í\ñfÀmd&)	ˆ\Ø\Êy\ô\r 9wKŠˆ=3\ç\ñ\ÏH¦35\÷\ê\Ø{+sú›@G€¤­¥Tl‰Lı\Ä=¥s°\r™\Â@v†Ä³\Ï\á\ónF=\Ì\Ç\âsPOÿg’UÛ–ke\ò\ÊB\Ø\\\Â\ÅZ?Àÿÿ[\ÛúU\ê±\n‡\ÍbY{b›ºj\ëMm!™\Ş2½\×û¿’ù\ÕûWDD‚	\"/!H ®j›\"Iz‚ Ÿ\õŸ}{ÿ¸»\ÛC£\ÉGI\ôÀ¿¸ p—.:\'ü\0¯˜5 \ñˆ_\Ø\Ş\à\Şü\èN\'„?®¶?®\Èş\Çh‹(\nŠ ¸#\Å0\\Ğ‰\Ñ\Ø\Øü„ª¢Z\é/\ğB\õ¾\×?š&rü1¸§w&¾ù¸wšgw%Z{\Çûİ»o—\Ö\ÏGl\Äˆ$$aXo´\ÃL&“\òûu“1¸_ú\İ\ŞMüĞª{\íû¥\÷\Ú\İ{??2 $,5¼ø/ø\îx\Æ\r7<CÁI#ŠW<t\÷KG?ºû\r¡£[—?v€°–!\ï°a a\0\0	\ğ†L\ö\Ú\Ñq\îx…n\î\İ\í#BœpB0<\á	(¼b’g&“`!\Ô\Ù\ñ¢ü°Ü¾1C0¨³\ã7À?;‘D-=%’@#llL%2¢Jw\á\Â/„t\áD8|\ñ\î\Ìx\\=›7qO\å.ª¨£‚Á3¹-V \ï„vBŠpâŸ°ø\ÊÊ«\ç«g%c¾yr\è.úq/\Ä=q\ÏM\ßB€\Ğ\ğÁˆg%\Êu¯˜œ!¤8‘\æ^\ì”g7W\ß\áCoV\ê:˜q¯D¤X\Ò~\ï\æ¾yµŠW2\Ù\Ùooƒ}µ³ÛºV½–RJ?\àHs‹Š|\Ü>n\Û\Ç\í½pÍ®ÕµºBl\â\Ş%\î	R.\ö–vJ(¡\r}+upd\õRJ)]+¥”R`\÷\Ã\ñEuüª\óºNkA8?Š\á|dŸD˜k\Ì\Õ1¯{\ÈMF3\Ô\Z¹\r6ÿq\ÓRJ)¥:UK¡üWJ¡r\í­~;P dx\"D¬o¦5bŒ0WssQ(\òŒ2\ÂTk>\ÚÀ\îu®‚ Z\nPı“²\ê¤\ò¶\×\Ú9³\â\öb\Ì\í\Ø\Ã\"¼A,\×gÄ¹¾:\Öy,\Û¸\'\ïÉ!\Õ7iƒwş\Éd2Y¦\ZZK¿T\0\0(c67±‰\ÉGG\ó \Ã®£\ë\è<\Z¨m\éL¦’IúS´ÿ\÷@\0\0(„±8\Ï\äÁ<a„<š³\\d¸\Âù\Ì<É©\ğ@gş\éL¦€IN(\áüÀec¬Œ\àcs’\Î	3B\ÎXœa„¼¹º\Öy†	ÈH\ğ\èEz“\é{¡´\çR{©\\«T~TF˜`¥°À\È\äœ%\å¢\\Ì‹ù<™Ï“a.r‘D¨´ø\0‰/N\0\0H&‰\Ú\ò¾Ô–\ÖK‰:ŠJ\Õ\Ú›–\Æ\ÔK\ÓV™+sej¤\æ­1ÁTY+,0µƒ+ø\î€/H^‘(\×\í\Ä	`Yı,µo»V¹\ö½(oÚš–¦Üªl|jüj\Z‹¶Æ¶‘ªŒTz\0ş{\Õ!\Ém#A’dùÿ¯ˆªš™\İ{DL\0ÿ\â,Y![V$g\óØ¶Us’*³\ÎÚ¶W›\Ä\ì¨y^\Î\æ$Á/²Ò°e\ã\ê\ÊY€„¨Ö½­\Ïj\"Õš\Ù 5;]½Y\Ó\ö›ìœ¦•=+I@p’YPy|¹‘	*øE¦d\"€<¾:3\Ñ¼|CPfe\õp\ğ\É	$	Ã[Ÿ½\ä\\j\r\ßüqş‡œ(€_.I–\òûış\ßwoD¤”¶\÷s×\Ü\İ]–\î\î;Ùº»»»3n\Ïİ»\ë•wjÄ½\ß\÷ÿıp¹K\ô¸[\à<]R\çT.q	œ‹8\Üm-¿\rœ\ã0zH\×91>Õ‹±Ào//Ï‡_\nw\É\îš\ÛÀ	œÀ\É\Æ/N,p\'pw($ù\ğDŠs\'j8‰“oyqw‹E³›\Ù&N\â\Ò\çt\àD//^‰Ssvqw\Ë\î±Iœ\Âcƒt\àş\át\á.¸Ë¸\Ô9\õ\ğDI¼k8K\n¿8\Ôr|&\ØøL.\ê\á9\Ë\Ü<\É\Âk\ğ»}»\\œ\êe-\ÆrÃ³\\$N±¼8\ã\ã3w›[½¶m«¶$8c\Ìuî‹ˆ¤bff´Ë¬ú™úfW	byjúY²È”%¹²˜±˜91\"Ş½{MÍ±m«¶m;µµ\Ö\ç\Úûœ\ó™)\Çü- $I\Î(”ı”\Ë\åe€,\Ì\ÌÒ¡½\×½QªmÛµ­\ô9\÷ı‰¨ˆ2¨¢&\Ç\"¨¡\"© a\0™»\ç\ğ\â\0\à¼%[\Î\÷}-c¯m{\ïª\ÚetuU£\Úİ§\İ}Ğ§q\ì{\îÁ=¶Ï™cŸ\Ó\Ç>·mûtWu]®Ú»j×¶\×\Ú\Ë\ë¿şøbT\ç—\ç/tœ\ñÌ‰7Û¶³\ò¶‚ÑÛ¶\Íût¿ŠÍ\÷yº\ÙqÎ~\ÏÄ¶\Í\ñÌSq*Î¹\ñS±\Õ±­A\İ\Ø\è8û>Vœ­\ÛÉ¨c?\å—\ñL\ÇÆ‰“\î¸^±¹c\ÛÄ¶“\Ç3\İc¯89O1;¶1\ã\ä\ÆV\ÅéÛ¶±\ãd<\Ó\'6*Î­\Ø\èØ¶m\Û\ì8\ã\é8©<voøÿ’lm\Û\ï\÷ÿGDfº{<k\ï½\Ö^k{Ÿ¶oÛ¶mÛ¾_]¯nÛ¶}_¶}m/\Í\ZÏ´ª*\ñÿ\ñ\0I‘dI’ˆ¨š¹GdVV=œ~oº\÷ ñ˜™™\ñŸ™yy†™ùë¾˜™™†™§¹{\æ\õ«z¯\"\Ü\İL\ÅnmkË¶U\ózpwI=\"rw\éÀ!ƒ\Z \Z\ài@cªp	Iı¸Ÿ\çZ U\Û×–m\å\ßZŸ³\Ö:+ŸC29n!),ÁeÄ»8Š\ì‚\Ì\à“Ÿ\ó\Îi­Uc\ô\ö\÷\ë\nşv^\Ã$\Ã\rÄ“,\Èi»l–nld¨ 9#s[’Ã}\ËfO“\Ûv½/€´®¢\ì8²\Ûak\Ën\Ç5r¸„XG’N˜v,9\ÈL2K\Ò\í’`\Ër9”\ä5\ÈÌ’CV\Ùm\Û-`³Ì©lÉ²5Ÿ5e³§$\öŒ[ glNE\Æ\ñt\ä\äš\İG’¡\È`‹œsU\Ûì·0jKr\Æ\Æu<G2[\Îc»]Ö$I®mÛ¶e\æ\Ñ\ÆXƒŠ,q\Ñh—co~\í:nzW`oj\â\Ù{†ûd[µmÛ¶\"Rim2®%\ßc‰Œ_Œ£\÷ZN$I’$\Ï\åbµÈŠ\á¤\ã\ğ_\Ç`Í¶İ¶5)c\ì\âŒ:Cşùªkˆ¿\È\á±\ÄPQ ;‡²C~z¦\ğYb\è(°ùc·\\\ö\ÓKbWœ\ò˜\Èi·m;l§\Ğ;NE\nmw\Ëmw#(¶dıœYv\Ê\îFJœ¡R¨>¨-?K[×²´E„\È\Ûv\Øn‰ıs\Û¹\õŒAb$IŠ$yÔƒş²2wBh$É‘”Y\÷–€\å\ó¯Ó‰$Û®\Ò?º\ï¿Fc³\ÇQ\È\ö¿‰w\Ï\0Ä¼şT%^x\á…\æ\'z\à?ş…iÿ\óŠ?¼ÿ\0>‚S—N\Æû™úW\Ä\Üş¿!¦şI\äS\ò@\æ\\\í¿ş·<Ğ«Ÿ\Ê\Õø¯\Ü_ş¹\è/‰\Ñoˆ\á·\ÄıLŒ‘gü0\àÿ\âû\Å\ğƒÀgCŒ<\Z3›/|ú)u‡\Ã\ß\à\È\×\Èy»\ët\Ëy@«#»§™\ô)ú3eon`¥\ç\é\Ë1|\ñ=X0±>ù\êD<üı”™¿9\àz\îk\ïJF;\n\ì\ßı\æ¡}\÷}}\0v\Şlš\Ú\Çü\äkÀ\ãOLÄ‚q,§ yXJ\'\\ş\æ€Ï½˜(\İ%ù2º…‡\í\ô0\à\æ\å€Ï½q¤w\ãº\õQ¹\Ş´1\ò˜À4\ò /À\ÈP£¸†t\n¿.U1’‡é„ªsÀFƒx\î\Û	|\Ã!m\Õú\Èş\ÛP‡†\ÊQ\áC9q¸P©1\êÜ}º¶p<;gT¯C\×	\á<œ	lC\İÀ\Í\ğl\án€C…~EiˆªX9\é\ĞĞ§\ã {šÃ¶e\à\àT£V\n‰\ã]“N1\Ò\ËFÕ»–\ğ\Ç~8ºu0ŠŒ¤Áu\õ\å\æf\è#¼\Î®=\êû ı2†µ\â\ë\àY.\Ï5„C\î0\Ğ\ç\á¡\Æ\òV\ãh8dÇˆg\Z¾\ë#Oœb\"¿4†\Ídÿ¸M~9qi^‚™­\ÎD-‘¥œ&—7/`ƒkc‡±e8gŠ\ëƒ\ç\ßÆ›\òŸ\áI1e¸\ñ\à\\.}±ÿgBv+§\0p\î\Û\0pD½û¿H¼.p\÷@€ -T@\"´@u!d¿¨\n\n–\0\n¸(\ö_ˆD%‚\Ø–¨l\İ\õp—}¦~\'<\Ü~Š£!\Îü\ZqH\Â@\Äü\Î?¿6ŒlEÃˆ\àhzm\Zppd`Ho5•Nª£±9Y\çCA\ë3\æ\äQµ¦c,0h\Z¼…\Ò\ów&·Œ¢‡\í\ÃDŒ!ˆGŒ¥ŒQ¯1a\ô²8Gl¿\Ì>\Æ~·Hƒı\Æ>´0$@+	”?­ˆ¯\ÂpP¼$\0(¸\÷=\Í\ó\r\é¸1)‡\0c\Ê)\ã—@‰§REZ¤°B ¯Ò¬\Z³\Ö§ ZM#\Ò[1Óƒ´0$€‹Ã³—¡¶E\ãW\Ô\ëE»’CÀRùù-f$\ç0U\ãt\î\ïù\äH\à†Ádlgnw?<{™\à^Á‘¨\Û®ª,\ì\n\":0 P”|r\Ë[N’l˜,\'V.ˆ$ ”1~ª7-œdı}°ù»	À_\Ô\ç\õ6\0~\İwE\ßşş7‰¹½L©\ŞÁ\ÒPº\Ü\ê‰\ß$¾fB©o\"ÄMü„4lpŒ¿¾®…`£&?!„øœf´M\é\å\ĞÕ…ŠÀY\02\Ècµ@Y™¬fS”Ò•¨8”¤]¤º ¦oit*‰A\Â@nF…D\Ù\ÙRA£X¢¼*¦\é‚ú&±\Øa\n\ët\ZÜ´xb˜ˆƒ\Ò!¶.¬2™\n±Û \í€Á)\Ó¯y\ó†o\é\Åwn~­9C\É\ÜT\Ê1\')=\r1‰gI\Í\Ø\ÎZ¹oÏ‡µ\Ïn\'¢d©2W¨#\ÖxÕ…s\'\0C#™(t\0•M\Ò(…\"…²	ƒ]N:šB\Ä8\Ñ	\Ôû\Â\ZI7Aˆ\Â\ôWW•§RºL\æ~S’JA†‚s)\É`¾›œ\ä\îI( n	\Ãi’€[\Ğ\×\ZNu°5š\æ´iW_‰¿Œß±\êßœø_O\Ú\ï@|,W¸5t@‚&H‚`\á|_¢Ÿ\à\í˜\ö·}´Ÿ}À\ï\Ï\Úüy7?¾šd¾_]\ñ;8¬\öU?ıû{ƒ¡WQ\ó+ºŠ\ö*$ \Í	bBSM!¾\0\ñ\×\ßeº;‘#oh!„øIm°a>\Õ6c‡¸\Í&\İÁ°–$•\ÉxAt”¨Df€9À+J\ÈÁ.KmCQ7uÕ°lQM-I\Ûİ¤r†\ó\å)\İŞ­tÏ”E¹}›Q”‰¼\ìdM\ñ v}\"0\Å\ñl\Ïh\ÔXRP¢wnA_\î#¬¥iE\í¦\ô\Öø\ğˆ\×_¹\ë\õ[ \Z\Å\Ù-Mn\nd·“\õL»\n)X\å\à=\ZšjML1R\Å^\á{=\Ò\Ø4“t\äJ+A†Ã–¤\ô`l!\Ò%\ÜÉ”\Ì\à \ï(L“f:\n8€\õ\n\nNPÕ†Ü¾L>·\Ò3(»[*ï…‚b|1\÷¶\ÃAÀ¤˜®À\n u`\Ş\ìŞ€\ãX´\İS\ËÇ ¯p`yq‚\òB*ÒŠ\'©qÑ¾ß¥ÿ\İS\îÿ>Eıš\Ğv\÷ü\Â	·6\Ì\n\ò-\á±\à`…~Yÿ‡{>Å¯‘™.C9\ähÿÛ§@ Ì¿n\ÓüSü°\Ñy½|\ğ€\ì{\ö\Ç\×.\à›\Î;Š¸\ÈfÓÃ¤\æ¬¯kš\Ö„RK…‚\äh?0€A\Ø\åDr©i\õù}Ar\Ì\á¾†:\õP¶^´DQh\r)0h}Iw\n\×:=.<v\"“\Ô\ÜT\ñ–n+#\î	 n![¨\Z)ù’CÁšN2RB±É™“\n“Á6º\òLÕ²	\óg»WRW*[Fn„|$¯ub;\Ñyˆİ–\\\îŠmq\ÓsB«‹\Ô\÷`‘n>°S$\òV=«´PJ™«V);\ã¢A§g4\õ\\’-Ë‘&\Z«\"*J6ø\"GN*\ÎC‘\è\Îf\Òn\Ê\Ş@\Z<ùPm‡)G˜\ØS\õn*}\\²\Ï\éˆHNºM*A\Úë†–Lr(­w\ìœ6Ÿ`©$\Ú0\Öa\Ü\Óu·M‡CY=¦\Í.(o–\õf¨\ğ\Ã@5«J\ó°\á\ã3lF_NÃ\Å¶gy\"m¤\İp§3mûÿû*\ôßµ\ÅxG¾wF]%T…\êA¸%]\ğŸb­®|{Ÿ\à{\Ì!‡¼}o\ß!\"H	Á¦\ß7“~\ÏMqŸ¼\âYB\ö­\Ã\Ïşø»„ú\Ç\Ç5\öX¦·şˆxÀa”\ïf|#/Å“ÁcFW”Œ$8PMj ¸&!\âm E?/\ò\ô¤	bšxe®,‰]	a\Ïv¬~•(t¦m\"7p\0PSzPQ\ä\0—L\è\×À\Õ\È\İ[\ä\\b6\Ã\"\ÇÎŸe3{Ò¯Eh\âÊ¤€)qøBšF\ìbV\'®…\×\Ö]Dw¢ŠT\è>°\ã 6ûN?O ™Hx˜m\Ô \õ(À`ü#`‚²‡¡Wªˆ-\öÉY8<“Œ„4ç‰1•‡xhb­ˆ\"U¡´\ë\õŠ\Å5U^\è9\íz†¢\äh@\"¶€o\ô²De_L+S¶]ù;V\ò¥©\ì‡`\ò\Óy\îO\Ö})\ZB\ÕÛ®\×\ó\İ~l,ûı«\ÍNÖ—\Ê}³ù\åa­RB\ÎV<·¶´¶\çv«´o†K¤°d\Ø<b#\ö4a±ueU\nNC\ï,®-m´F”q½9\çv—\ğÖ’\ñşd2\Ïdû”\óÿT8\Û9­\ó\ïş9_\î87UFR%\ò,\î3œ\n<‘ø\r\ä*\òä™¤&’D½ˆg\Â_o}6ş‘‡¼\Ã@_‚U Ø—ü”¯\õ~xK=^aœ¯\æ\\¿}h”Ev/\ó\â\ËdP\ã€\Õ.Qd›\õ‘\ÂBV	ù\í$V\0Ó¡¨B”[q=!\è\ÒU\ÎDŒ6Ñ­\İB\é\â&j\ëE\ï’v\Ã3\ÃRh;¨gZX\ÔF”xlZÉŒ#\İj~m[-\Öu[5²¬\Ó^Æ³ËM‡tf­i\ôJ^;t\æEn5J`\\-«kn¾¦^\Õ2<]+L±${G,¡¡kºµU¬*j9}*¼\à-µ	:}\Ùm\İ\È*z4U>¬\ëNİµÚ£¥˜º\æ\ÅVmŠ‹\İ\Òù\Æ\í\"?·’}[’µ9{¹S\â°ÁÎ™ˆ­„	\0tL²?2\'2ù\"´\÷\Í\Z¦uc\ÜB\Ø+‘’˜\æ\ĞX’4EFË¬wœ“/t\ÙSs˜\ÈptA!P\ô%\ğ	loŠ\è·\ğy\ï\íª¾9ÿrp~\r\Ê$y\îœ+Wp-`¼\éVk½–ˆ{iØšTW¥\Ã=\Ú*Û¸k8›•ª%\ØF[\æn¡v´\Ù:X½‰Ø—HY—tOm\ç¥xVE\ÚAš®–\Øt\÷|.ıUº‚{\Z\'\ã½\Å\í\Ñİ®^\ÒUx—`:‹M®RÄ‹ıŠß¤^VR²–Gz˜s.\Ğ\èÂ\è>%¯\"O\"ŸD\ZE³0û‰ÿ¸ÉŒ³X¼\Ö`\ä‡fn_‘”\îî•°¾t\Ü\öš‘\"Pœ\å\Ğ-Sg’!\ßv }”\ËE\"7vs\r6BC¸\ì’*P„-ÀF`, \á×©Aım#´\í­D`gC3 .¸¶\ÉL›…d%&\")\Í6mj\İY‘úû\Å.‘@;+ª\àÀ£]\ó\áS¦Tş\ï\nX!$™\é•\Ü0\Ò\îl\ßuOe\ñ {c}\Å‰\Ú\äF©2\È\ô&<¦¢ı\â\Ó;®n:¤\'İ­Lir8\æ0¹M¬Q²Ù­]9\ã†\'š‚¶[u Å†\×i« \ó\áŒ´B	\0¤6¬ªg¸›€0]@¥T§\0G£C.ÕŠ\özo²Ñ˜\ä½S\ç\Ëm\Ş3ÁW|.\á&z{s¨ \0n\0Q\à*\ğY©\Âa\Ø[¬?>˜ÿ\Ì\àù±\ä\İ•\÷! z`ˆÈ…Ã’¤.„‡S~H\ÍT\Â\à\Ôİ¬İ««µH\Út-\Ã(\á Gi\Ì( Do@¯;gi\"\ÚÁ\ôzZkœŠ6Sn“\Ø\ÜHŠ¹¤l`KJ‘\ï2mŠZRüA\Â_\é)\ñ³:œ©Yt\æ\\\é3Á>/y±,ƒ\Íú.­\ã\Z\èg¼\ò\ä\nªŠ­¸\ÍÿÜ¸BeÁF€Bü‰„™¨\ó´/H\Ç;I¦·e\ğuD\Ü\Ê\×Âš»,Ÿ\ñd8Ç¹\à8Vq\"e¢$\\¤ÜP€\Ù%1½\ñJ’J‡\n¦\nY{–*Á¯\Ê c\âÂ¼F‹°]~f\ñ\õ›,Ö½Á\è´¿.):{‹\ÙTa5B\ÒONGZÙº\rb\ZTƒ=V%˜Rd+\õO3¡\n´\'‚*R‚J!»Z±\Öq\ìN]\Ê+\ÖÏ¯v‹Ä\â <Äˆ:P†\Ù!½u\n\Êq–Qq\Ãb§s²7›\n!$!D\Ú; Í›\î\ÜE°Kp\È\Úx*¹\êtS£\0\Ô@Á\Ñ\r\óU\Ä%#3ºhvf\õ4P@ù\ği\é\ÊĞ–\İ\â\Æ\óš¦1T\×F#~\ğ£ø\Î8bVgş\Ú\nZaş\Ú\Ø1/\ìÀ\\\Ñ\Û#¼\ğ~\ñ&\Ò\n\Ê\èb\ö\ó]¿?¬¿DK>Y„\İ>)ø\à–ù(O&¥\Æq\Ö4ùkDš\Õ\ÄL©†Ø\Ê\ì†\r@„<‰\ë!\\C±\É\ÍDC€g@€¢ A0\ÂZ&N -‹CxLË¤\å\Ì$ÓŸ(\å\ê\òL¢>\îùŠy“§\ö\ñ=\×5xI”œ¼r\Ä\'@<™tB	¸@\Õ\à€-X\ğ@\Ğ\0} +\\\ÒQ6\ÙúOûE–À%À\÷\á9\ÜJ‡?z\âC¦6\0\\®\ŞY\ß\ğ.%<ƒL\×b|\å\ğ_9ˆ~\Æ(µ\Ï2º\ÊyQ@Œšh7Š’A07\Ü<\ZJV\êZ\Ä\Z°h*‹t›jQAmFU\n«É­\"„ùa\ï\ÚÑ­tM0u²\Ä\îª¬¼\rl´A\İ\àj\åW¹º\à\òi$x³%†YQƒLL:@®Bi\n\ÖˆK¹q\"\äC\Ôx¶x.¥&\"^¡g\ÖÃ‚Ã¡_úXE{£S;\äc·wP®I\÷\ÖU·do¤\î\îu5J\"\ÇAÁ F\Ó\ÆM\Ïr\Ã8\ÅU\É\è+\ë\Ê\ÅÅ†\Ó4²\éO“Ra3	»Ë‰p@R\é?©ÿ;!€K\Ü2\Ò3”‚’=\÷/v!’	LT\÷\Ïw\ßbÁ\\ıWş\õ½ƒ\Öx£™Š¸16uqˆ£\ñzÜ«½ˆ[\ñ\ğË«uSû¥\ä\Å=j\â\Z<\ÙNcø{?£Ï¿TY\È\èo\Ù\Õl\È;£¿G\àL6³ƒ@¥\ÑUØ\Ü¯+O`^X…ƒ\n6A \0KA\Ô|w	†a±g„\Zh\Zh5\é¦Â¢œ\Z\ía=ü\ÌDu\õv\nF‘\Z’+\É\Ò<Q wØ¿\ÂO\Z¶\ã©[\ñ\r\ßg\ZXÓ¸\áb\rÇº\Ê\Ç5vq\Ô_\á\ñ§¿\î®\ñO¿f8·3şco~\ö\ÌT\õ²|;\ï\ö\ÌG\ÇİŸ/\ê\ó4•”ÿS¾ÿ_4¢wıúş\Ç\òÅ­\ç+¼Â“¶À\ìƒ6\ì·6ä¾¨Àz\ë\Ù\Ïú\nn4Q\Öd\rM‰£b\Ôs¾¦O™Œó‚Š¨z¸0­MDÜ”zı‚³ŸF\Şû-L%B\ÂøBú\ë·\r\Ö\ÏVµ|8\İ%ø˜H{W\Şjlü¢\ô\ôi\ã\÷\ô­ÿc\á£Ô‹J|\à¡sM.¹\êŸ\Ú\ÕG»\Ç·úwš«şQ„Ÿ½\ë}»Ô¼>®\ö‡?\"\ò\â8\æ\ëş¿¹Ÿ¾ªy\ó\Éü\÷¿²\Ş:fL}²n^4ªÂ®\Ó\ô}J¸\ÇV¥T\É976\ò!ì±»\à›)Z6W\Ñ\Í\ñ&Àd³d\Ç\0(‘I\ÂO‚+F¯\ì%L»\ì@	\ZA†Èh Á\Ä W½V:BÙ‹J\Ô\İû?ÀbmÑ¿A…´‚\ğ/¥\êT“3Ğ€wX8 ¡E\òq\Æk;¯¸~\è¼\Ü\ô|Z\ê®lO#C\ô?¨,#\ô‘Vq¸\"\"|‡_G\éÏ––Œ6\Ò\ê\çw\Ò>Ÿu\ñCvw<šw\Çÿ\Z¦N‘bb\èü¬›7/Á\å\ö\\l×˜\á¡A‚Hù;¹À\ö¥3\Åk•d\àx©\ê•\é?ı\äG+\æ\î>U\ô_GZ\ë\ñ\èºi.8ı£›bEg$\èœ$A\0.…%(\öŸÁ “³€\ÖECA2n5+2(ÀÈˆa€7\rÄ°˜\Â\'\'9‘s˜t¾b6@‚\ò^\Å„¬~m)š·L€˜·‚\Â\Í\Ú:z4R¹À\ßb¥\Ù+H\ÇI\á\÷\å]”n“Ë¨j4\ÛR¨…ı5²\Í\áN\ÄL2g(\0\ç\î*’˜\î\ÆF\ğ9;5\ÛûºZƒ\\k]0U…Á\\Úš§¤Û@½#«²\'!—0ƒŒ¬³j©GrP\è$­‰rM®b	«l d\ß%s­\rQ.”:¦tvo\Ö\Êv¶\n¥G\óMUš†AZšC|?\Ş\'}®ı+—\Ô+\ã9yY88JOMU\ô)¯\Õc\Õp\Z®*ÁM`p\å\Ítq\íS˜„\İ\ÓgI¬=\r~!g1¸3\ñ¡L\ÈD\\	8pgÀeh‘\àt†E‘\àNtˆ„\r\Òq³\"&\Ó}°.L*\ÓÉ‹\'\ÓPa‘¥\Ğ\Ô\Ö\rsÑº\è\Z\r	Ud´p.|h³‚\Ê\éI\Ô,I4±\'\ÌŒ<F<@ 	™>77 z7\ZEø.¤Ipg\"i-’Ë¬q\Ù&ED©¢\Èq.GaÀ\ä)É”: $%¦\ğ–8R\Û%o\÷¶eEI\ò2K\"©*]\Õ•t½:Q\"\n’2Gû¼H\Õtj\Z=\ì9\Î\ã\Ô/6\É>1\äÔ‘66iÁgµ#y¨¹f\ïFv50\'/™Úº¹È¡±êš®\Ô>D¾€§‰¡\ÈT}\íE?;°&o*OÀKº\á‚\ßXû“\å\ñ¼,\Ãù\İ~ÿV…\ÜQ\ğ\ä&{¨@\"\Ğ@šWP\ì;v”,„O\ô\ó‘ƒ\Ô	Eš¡rúø^Y\ğ\ãQ	\î\ò\âÕ½\È\åmœH~\æ@Y=I\n45&~:)\'\Ö;\à”tFT\ÑT2>$ƒP‚Ã@|€{59\ÛÄ¾’S\ävâ½¼wo‰]\ö2ez\ñş=ªNá…+Pû®R«\íªÔœA¦³\ã\"\í¦2\İÄŒ%Rsi©MMÙªt©F{\Ëıù#—Ğ\ÓdN\ìQ¡R]M\Èj\òDD:s\òt\çtI#\È\ĞÜ™½g¬™\ëy0\õı\ê¥\Ã\ãO°¦F\n\ä<·±	’P‰\0\Ì\Ô\åş\ék\á3\ñ\ßN°™„\ß\ÂG„xˆŸ\ó¹\Â¢pz£!(‚\ê~kĞ¬*\ì 0imiE¤o\ö‹Ìºq¢\0GcA\'Ba¿s£\Â\è>\Z¿¿ A3\ÊF $ \à€^\è\Ê\î™²nÅª¨k„\ì\Õ._N¥\ë¡\×i!	•>ú_*¸fpy‚ƒ\ôx^\õ/\×\Ù\Ìi Á\0\áª\0\Ì)/ù\Ø#=TœŒ‡euJŸ”óƒ…«ìª«\ä´\î\éLR‘.\ã@6CËŠ”K¨Q\"\Ée\Í(\Êjštª†´“‘\í\'D\ä\ÑE“‘mŒÉœ1Ù\ØX«\nEC\ç$\Ç\Õ\÷¡¹|\âZ‡º`‚‡Ø‚\Ù\Ö\ñ¬Dd\Â\ö€½9•\Ñ\Æu‹MUN_4Ü­¿\É\÷R…¬©a×¾[\Ïeo€=\èQŸ,\İ\ğ°øno­¥\0L#\å\ğD^ Ik¤\Í8´`6“\á\Ğ\rb\Ø¯™\ñ2P™|/\ò¼À<’J\÷¾C\\¬¡«h\ÄRF«\Ğ\Ş‡\Ğ7\åÅ}\İ=¿<¦I\r\î¯H°\ÍÀ„R±Gş\èm —Ç‹[\æ\íh†|Lb#o*\ò*\â:\á3.Áh\ÅPI+@»\î<\êÀN§XØ®¤\\:š§TC\á¬t”¸Db\æc\ç\Éjx\ä}’\ÔiL\Ò\ëWI¨«L&\ä‰H:\èœ8}\\\"·5IŒ§E\Éı’³£\Ä…¤3Áü\à l•\Ñ\ó\Ñ\ğƒ\Ï^&\ì®`œb\ÈÕ€_‰ \ÒÖ‚*\È0$GIMU®C5~Î¤,’]™r¯HCŠoFüm°w\ğ5½ÿ\ôRv?\ô$¥è–¯Œ)\Äu\Æt€:8¢@ƒ/âŸ¦h\ĞÁ\õ\ßH’|k°~\ö³oü\ñ\È\Ëp\ÔQ\ÓC©\Ö\ö]](üA\Å\â\ÆÖ¥\ã\éx\Ştw\ìtŠDŠ•\éL\Ï^l\öMz\Z¸ ^˜›\à€¸Í¾\\›‘\àIÆ«|\ï¨i¶#`g\0r¤_I47e\ÑVCU™•[uZUµ­\ã;&\Ø\ê\Åy\Ñ4B4jƒ$Wk\"¥^ 4{\Òéƒ‹±Å‚²qÁ\ÕØ™\Ş$\÷\ó\Ñ\Ø\Ôv½\ç\ñ8g´\ñŸxvµ\Ú1\'oŒŠšvXB\é†tN\\€¯Dˆ²“@G@šDú\èÁş™©Š\Ø>Š\×\ä{\Æ+¼c¬ \"!\"V]æŸ€¿ƒ¡O\÷\ÓE‘?¨ Ñ‰\à\Z0- ´\Êk;\÷™A©˜:›~•\ßeúdh#J  Q.\÷‡ÌO4\È4 \r\Ô>B6\î¶V>±p«ºeIg\'kÃ©\Ä@aÏš\ï«\ÜQN\"\n<„ÿ\ó·¶\à$9\Ü\ÅÌ‹8e\î`²‡‚2A1@\"\È^ CÁ±\"q}‡Ù‚­¶\nePE	\Ü}\Ã/»\İ\ôûø\×xB\ô*;¿?„y¾K‡\Õ#ŠÛnº.Q¤\Ó|\õ\ËYjtÀ«û\Ä3w\Î\ãy™SÈ¥’JŸyT\Ì+o\îš<_Á\ÚWV\Ï\ñI„pz\Ôs\İ\å§\ç{\ë8ä†TO”\æ–?~L\ó	^9\Ú?\È\Ê}\É1ÑŠ´-3´š.½ZJw\Ï\çmš;Hh@”Ïµ\à5²Ÿˆ\Í R³Î„rl&\Ê\êÀ\í½©\n\áDCy	\Æ0Š\Z\à\'d<38,»\0s@…~{\Ğ•\×@IQ-A‘ºtw\á9O„\ŞÀ ±\Õ=n@7\ÌÛ­\Çoıg&z„\Ô\ğ¶„B…\İJn¤\ÜL\ò½¿Ò‡ynƒû(\î\ò»\íP\ìHª\"7\Ò^\öBPfÀA:\nN?\'y‘¡I\ğ~Â¨\\dˆØ„ŸEu\Õ=^º+H$§\0Œ@l\"Q>\Ë\Ò\ã®èˆº\ê@$›x€›\Ì\ã@€t~½;A\å®WF\ôz>^¯ëƒ¿\ê\Èf¬Jtl†\èË¹\â<\õØ–Å‡b\Ş\Ğb\Ã\áºş›R‡Á6!P°?AAÁ6\\h§+j²\å`+	‰Ü”¤V\í\Ï\\$\ÕPF<$CGW\è^[/CuO™™V\ê@J\á.=“\àT\İ\î\Öø-\ë¤Á\ÒC\ó1\ÖT\Ö(\å\æüÀ©{ú\í\Å(>r€6šH\à?º@¿»ˆ\r\îş\ÖZL\Ù¨`k\ñ ÁfÉ– ¦o[\Ê&\õµ\Í@†Y\îv¬yw\ßj8\İ\ä”C\\\×\æf x\Åc„<A–\Õ8Œ8\ŞGLib…{y‹F(\èB\Çx|%\è\Ì\Ğ>À!€,œ‚v$¦’³LE\ïCŞZù5•\ïå‘•\Ü#\ÇF¼Y\îAVF¿\èÆƒW\òL¯\ä\å\è\ÖŠ&’ÕŸ\ÄV2H=©\î…\Ğ\÷7»44|Yx‘şvf\ïŠ4Ác:\Z„\îAZ\0š\Ğ[\"\ÂH-\÷!\ÕDu†œ\è\ÆAÀEZ	\Z½+>ß»\ò\ë,‡P˜u\Âí‹\ğ\ç®4?q*\áJ\÷}0pŠ4xÀY/\Î.´R~O4aŠ\n‡¦\Òş\Ò\ö]€Bc\0¦w\ê‰~z;ıpvĞ¹ü][\âbû\åÉ’	nn\ß\Ó>\áüX]¯¸\Ó\Å^­£!-\ï<	û¤_j\Z¤\Ù:H°\ÃE¸¹\ÆÚŒg\'g\à4ıÁ\êP½=[\Í·Œ\×Âº\Û\Ê4L©™\Ùü–OH¥\rË©\Ì\\åµµ‹\ÜúiÜ–&kƒ½\ËP.bUz$†yœ\Ş\Æ\ÕS8½†lAE\ê>ƒ]0^\ô\å`\å\ÚÁ¢’¢q83\'¾\ÈGÿû\ëŸ5\Õ\n\ò\0búš‚€\ò\é,@Y\ö+ 6aK\ó¡A8ı\óùš‡NÀtSX\å(L\Üx3‹Ç|ûOB\ÔZÇ¸l\ZÍ§\ÄTRNv‹”f¥p¯jş£\ëZfƒ6¡$ª9©\Ó\Â\ñ®Lüe\Zø\'€\ëW\Z\×û¦¾ §—q2\ï \ĞÔ’KÀ\ë\Âä‚¹€Ù‰>PAgb@s_©{\è0I\Â\åIª\İJ\ÓmD\Ø\'p‘„5	\ì@\"\\dÁ¼¯‰ü$?„´\Èa\Ğ7ú\ñ~™úZ¹\Ò\ÛøÍ½\à¾\ã_&*Š\Ï²§nş \ä5\ÉüK¿N84B£\×\Ñ\á\Ém4ÿ]\á«\ÄU\Öà £”º\ß\÷G\ÎP\Ğ)0\'	Ñs<f¿a‡Tja\á-\åH›E·±(M\éŠø\ó\Æs\Ü|\æ\Îú©¼ÀQ†N\å(¹l¸’\Ò\Õ\Z°\í\ó\Ù$v Ok\àÑªx\Ä26k¶&¥Ë‰ª…ù\'µJ KqE´\ZJ\Â\ìl{\Óm\ÂN·ø\Å8€Y\Ú\ÙmII€vj\ìC\0±\Å\ÊÂš]$vnoy\È\ÈA\ÛK	\È4%6‘=\rn4\Ñ\r\\2sk\ì‚gÿÀ=ıF’1\"ªLv\õI¼I~ı*\Ï\ÚfE\rB$©BjšSé…‹À`sp\çCf2U\ÙTyJ\õ²Ñœpbd€$\ê¨\ëw½)½²<A €j\İOk7•\Ìşâ³˜Š\Ò$Ö–&\Í\ì´ŠJi\ô\à¯SƒTJ?Fş²ÿ\Ô>\É,\ó\ë)É¦ø&S)\\/F	\Ê\Ø`K­şº“’°GD\Ç–\æ\Ê,	ø\Ø\æ\Å\õ¬SI>Q»¼H9\İH?\ÜIOMSt	ŠMs\ğœ@56\É H+h\0H\ÄZ[\r|­¯C®l\Ü@;{Ù¢„¼~Ï†sÿ–we¼xƒ\ã1\ÉS@¢\Æû\'D#<ˆ.œ‰›\Ü\ò»	0—kjr\Ö\Ù\Ô9Lz’\æuq \àA\÷LÅ°\ÛÆ¤BsJ<·¸D\ÈVC\Zg·W—v+t¢l‹\ë\ê\Í\é`9$ˆŒ\0]\Ø2\05‡%VÑ¤\ô—\0DÓ¾Bg7\Üc.\ÜmV&%2\ñšfkZ³4š§‹e~\É%\Ä`\\¥’Em\ò-‰\r›¥Q\06`(—,\Ú—(»¢\Ù²X¬Î“.úBb5\õf\ê\ï\à\Í$ŠÀa\ÍnØ°ûPX¿‘‡\ÍÅ»+Xkiz1]\ĞW·†9E\ğfY?®\ët#¬\Ê\ÎF0\\|¶$\Ê%û\']‡¯\ß,V.*\Ë\Ôƒp\ß4 D\î\òD¸]‡rbL]E¼4\ÔcRT,\ä\Ä“¼ˆ=•J5-€h#©«‘” ß©\à\'v\Ûş\İÿ1\ë_–¾(\ËM\àË¶’¡ l_ ­h?	\Ô5C\ÔQ…2š)~H›\é\ó}2\èµÀ><‚\Ğ@µ6‘+…5‰&y)É¢¸]\Í&TI•\nD‘P¸\0\Û\î&’¤0§Q%§\â°)¢\ñ a\r\ÆTfQ¤°V›\äÅ”(~¯Qı\ñ\'Š-hP00¸°\Ğ$€©½\Ñ\Ô9œ+p\é\Ä\É%aRæ®š»\ä)D)cÒº…\ÃE(¬“\Ë\Í\ÚlWiH«d»x\Õ\Ó+N’\":v\ÚYi~p„\ÛjÑ‹4\0…A3I%’\ïaë ‚\î–\ÄÃš46\Ù!…Y†°Z²‹\Â.¨w\íKAù€m¼GQ\ÖÉ‰$\0ø”€l4;Gx_‚¦\ßh\ò¢!2ƒl¹<?-¸f¼²\ñ*·\ğW\ÇsımÓ³Z\å¬XlÀ)2Â·H¼Vr°[ZfLR\â¯9B\Ö3\Û0‡®„­™\ö\ÔGÖµ“E‘®`‡\ídB\Øfú\È\èNOºN@¿»e;Ğ‚\Ä\ÅKru)¥<r¸À%¤^Bpü|4¸K­\õS5Pƒ\ë +\ï\Ñã—¢2\àÿ‹)#J‘hDÁ\Ô0%\ä\0\0	Ø¿x\Øú\ì\Æü¥pª\rœ\ñ\0¹\İ\\¶G\ê<œ€İ¢™šışÆ™Á\Ú:— \Ğ\Ş2²7/x	œ\Ğ\â\ÔŒ0\ï‰\î\È#8!©]@-\\¢*\Ø~:-€¥(DªV82\ò‹.N¦Wé¥¶*¼] €0&)¤&‹‹–9H‹?·Ì\åº\ÏOÀR¾\ÊK\ÈSFg\ì!EG\\‹*2\ÂCºŠ•\0\Î\Ì7½s}\ê8dYJ’°Ù/uGwN»³\nS@1@23¸(\Î\"Bˆn\ni˜$‹6\ÉvJm¹\Û-ˆ\ñF\É$\òH(Ì\Æ’EP\â“%À†UF0¼1EX|™\Ï/€¸EVB\ZH\n„\ÒY).†HšEIDDm\ô89›±¢,.h£\Øb!·°‡2\0i§%l\È\\pba\É\ğ\ö—ˆv†0.\0ºg uª\ÍúU .®\Ä{;saÕ½º#p³%\Åûú.oˆhtj[?ùk\Õ\İ\ñ\"X\Â\Èw²\0\Ô!Y\ÔP‡Pw4\õ\Ş/¦\ZMV5\Ó˜E‘§6\à¯i6ÿ\ÇR\ï¯ÿ‚\Ë\áOæš†K}üW\Ûİ‹\Â\Ä\ëo\0:Ÿ?@ü’0¨µ£@$\ÚRQ_\ë\'rBK†ø„²Ÿ\n‡N:$L ÀF-r\Ó\Ü JJµ‘›\ô3‹¢\Çş9„\ë\ÅM üV\í­I\é\é^MJgı¸Ü¸“+VœN`˜&€‚Cp\àD;}\r•\Èb\Ò\è)\'`K_‹ùu\ÎÁ€T\Zr.ÀŠ\æ)‘	dˆ\rÛ¶\'—\æÅƒ:\î\0\ñû[²vÉ‘\"51–¢\ë\É¦Ó†%\ğ\Ğ=&@5\"­y6d˜\õeÌ>ÀËŸU‚•B%f=\0465C`6’¶0s¦e\07.É’~\õ3U\é@\ÛD$\ÒÛ¡V‰).\Ñ\Ø\Ùi\â#)\Ú-\É`ƒ€·\ÜfYTd\ã \Ó5’Àoú*\êbS€|\ï4XˆÜ­W\ß@a5j|©²‡‘d\îVl\'ÀvmUl&6v\ÌJ ¤)\öBxl\ç¦¸A È·uŸÔ‘\È\\\ğ?‚\Ì-_\åP*jeÿ£˜r!\÷\0rkL­Ğ¬E’\ß\İ\Üş_’­ÿ­G—\îÿ<\'_¾\êZ7Œk8¨mNs\ò¬\Â^˜­…ø~ ­ª\ÜÓ•‚,\õ„\ÔBZ\ó<r¼j!PG^§\'Bk`I\÷•„	ˆB\Ğ[0‘\"Eˆ\åÁh@\nf\â).\Â{`§X “98\ôkta‡%\Ú>#\Ók¸\Ù\÷S\è\\\İQh\ä\ò˜\êe\Éâ•½\r­3‹:\ÅTŠ`\ô‘ \òAÑ–\Ë‘	\ä¨x‘\nºµ(\Ã\Ù+IZ\ä?‘ h!€«\ô\"\Ï\'\Å!ƒ„\Ëa¬‡WÌ,\èb\ã\'\Ä?­BhÁı\õ¨\ó“\0\ñ?ùÆ©)…­¦N\åhAsE€\à(`¡?d{\ÂV\ñyRÔ†Á\0A\È@².ä²‚D„øI+yÕh\ğ\nT²{\òt“`‡\ğe*1ú\Ë/œ6Û²{ˆ\\t^\Ş>R#Q\0RC21\å\r\ğ²\ë´rw	F/\ÌŸĞ¡@S\ğşŠ)4\ä$É”$u„L¯#¤!™ß£œŸ„¨l+Bm+3\ÑJ[û\ËÉ†Å«H\0tt°®\0°%\ß\ô:¶0-PW ş@&\Èü\é5‚LRùªYcMskpº©ùù€v\Óf<Ì¦j‘al\rOÃ˜;ùMY+,\ÍøĞµµy+\ë~`\Ú\ğR\Öz†}ù†>Ç¢\0ƒT2r¾„9Ü´a.»\õ\ö¥® -“”	\"¥·\æPª\Ô\ğF’šw<À†OBC^Hr4\0‘À7rv»3É¨\Z€º¡˜!«Ib~R\Ò\0(8¬:{|€¤¢Á\ÔQ7 †Ú¦š¹ˆ\à±R¬\Æd¥`bXd B\ZÍ“İ†r>TN¿w\Ê\öB¡™d«7nn ¡½6™°m£\Ô\Öú_H€\ôªJ\0f¿\'J‚šZ¾û\Ø\ÙYb®¢bœq\Ø]¹\Ñ*q\Ø\Ø\õÒ¡q\ë\ö‘2M7\àtj.\öno`\Ö0¹|\Ã\\·\"NM¡\är¶0,ªİ¥¸\nX\óD€\òı†U€\Ï\0\Ü\ÂT%(\ÔÓ‹E		ø\ëü!fydüc‰›$¼R6J‘,„Swv„<4N†§z \ß\n*İ‘\Ú\Ô+\Z\ÊoÀf\ØB\0\ê|ş\0¦œP¬›\Ö:M&I:,\Ğ^Rt’\ílwNhÂ¼ !\ó°¨\æeÀ$„2—¯\êxc\õø\ÙJY\Ûÿg:À˜)z-?dz\Ğ\r\Û=y\ÏE*\'\Ø\ìE0}2u¨«!ÿ¥q\ÕÜ—«²ƒO\ÈŸ\ÊqÎº*\ZQ¼d;Á’û\Öú¨R²\Ä\"µ\é\È(ç²’)\İ\æÓƒ¡\ì\n\àªŠd¸Rp!\ï\àA”ç·œyNm\ğ\ç\æc\İ\ó.“S’ 6jÛ0ŠBXµÁ@¶\ã\0\ôP¼¶\Úv³Uz4\È7cş`‰\ğ\Ì0%ûc^DŠNÜ£­¶\ñ×Šš€\"2U\àÁf€Uü\à‘ss±_\å\ÅbWšD\Û\æœp`¸{\ì\0O\î‹Ja°\ëá»»8\ÓE(\è¢\ëëƒu—-Š\İi\Z\í¬iamXo¬.m§h\İ6<l\ÏpAg­6µG\ë\êdøú‚~…š\Å\\Rc‚zœ;W®]9\Ü\õ\'‚,„‘>H\0©úÆŠ`Mn\ëü\é¿!†¼\ñcş\ó\ìJ\ì\nœ¥\ñFV„P˜\Ã3“A\0XÈ5£ø\ç¢\Ãv\õF\Z\á\ôv\è·\Âf¾\Âİ†F .X;“LŸ­\ä\01®z\ÄÅ†t£^]ª\òN=}„øI\ëG\Å@cÅ¡¿Ì¦l\ë†\Ó\ìz\äe\à‘(Â¶x¦\×!¤^ÀEv®\ä”¨\ò¹·T\ìv\è\0\ğtÀ¬ÁK\ô\"\Ôú\×p²\Ñ\Ç\"\óqÂªRQŸ)\å(¯‹\à(\r%™«7Œ^\ë\ò–\Èi‘,\ÎJ[’P·°\ß@\Ñbu«5X6\Ş\æ\Ó\õ\ğ¡\Ëû‡\ŞVi\ïµ\ã@»sºOú²L¶‹\Õt\ç\"v\ãü~kkl’qKD\é3¾€v	\ÆS\ç\í]%}\è\Ò\İG†·© ‚C[=wN¦{\éha\Ğ|\ÂD08­ˆ\'\Ë\ÛEjœŒÁ\êV<\Ë6[LgKùn2\àd¶¹V4*\ìnd/]‘\Î\Ş\í<vG³“S\Ğ&JÁ¤úBèš®Ó¿\ô,0\Ìe]\Å.6@*!<\Ô¥\Ä6¹_)f:oœ1§\áA}®‹Û°™Ì²œ&µ¥\Õ\Ú]x8=Ú©\Ñ\Â^†\"\Üz~Á´vûû\Ñü¸tC\"ZQ\ÔÜ­\Û>08R¹^¥±=¬Z`SY‚Ib\É\Üû\ğd„ÿmüŸ·ü¨‰¡8üo”\nEM³\ëĞƒ«[½ÿy\Ü\íi\Ùì´»ÑŸü@Â¼»\Â3(ú\à\Ëf!­>RG\êı\Ä8\á\ëëŒ¢C CT\íBg\ò\Õü\Ø\Ä\çŸ~R3…©\â\Ò-SS®r\ÈL@\ó-ø…*\Ğ\Øcq[¾T|¤\ÍŞ€\ñ\Ó\Òc\îvş—|\âL°Kİ€ƒMZ¹„­\"vX\"®º©Y\Ê@u¿¯ \"_\æ»ÁH©xrC\ß\Ş\ô«™qgp\é„µ¸‡\ôI2€\Ï\Æ\Ì\'0?¢ceœo˜O7˜tX4Ã¿º\Ï,ª±\óº¬7R\ï2Œ¯M\É\Ú,»V\Z½R¤O²mP½¥Y›Æ†\ï—oz\ß\"\åPRWù\íS&q:¹N#l“\\o(šm®\ZƒTK¥s\Ïw\è*U­»•B	\è\×L7¬˜N[¿_¯49\"ŸNş\ì\Øt\Åç«OX\ÎT¸\Ú\\®>\ó\ó¡\åŒ;\İÁe\ê\ã\÷J\ÚÙ¸˜tA-·†¬\'½\õB:ÀeCş|¦Aı\rDrs*ˆ}\ê,\Ù\Â|\×!•B\É\ÄE\ô­™;‹¨e%w\õíœƒ-,\î“ZTy@\Ñ¶‹ D\ò˜ë´·0U¹¤K$‚<!\0Á\0=RÉŸZnø_„Swÿ\ò`k TyH{\óI”!9\Û\ë•Qe\àÌª\'5•\Å~G\Ç6!Ÿ\Õ¡º\à%\Üu6‘M\r\'\ÔM¯¶d#š!\ãl\á¨eH¥>P¿#b9\ğs\É6gS\ñ¬\0Y ®”´\İtcµŸ9\ñL©€[Z\åÿ?ù\ËT±\ÛO\Zo3}‰µeŠ\Ä\Çt—Gwƒ¸p¸1©›)›™\àK¶‚†`w\âiY©%g\à·qû\äP\ÃH¢š\åN<p’§)ZJª\0\ÖI`·- ˆ–ø Ä´•$²\å¡?h/šº.&\"\ÉfLi\ÌG\Èfgt\ãÁx\Üb‰„»12l\ò\ì‡\ëV½¢\r\âm\õ‰M´3‘\ö“\ÉU%\n\ä\Ñb;5{r¡Y\Ã3	¨^±\ÂYi‚n&\àO\Ğl[Ã±bA9z†\Ğ(Ğš\ë\÷‰;\\\ÈtŞ€\Ì F\ÄÀ\ó$ $*‘b™¨\0\Ù\0(!\Üt\ñÑ—«um~bÀ_\Ö\ã.\î\0Z\n$\ÚP‚‰\Ø\÷4U¹²ƒb¶£\Â\ô€Œ\ğ\ñ¹\È\Öÿ_¨\Ã\ã_µGÿ‡Jah\õB8Œ¦¥\06·\×RH„\Ü\æ\É\á²o:\ğ>€ \0ü®•W‡[üA2>%\çŞ˜\ß}<]e  \ß\ëk@˜AûsH¥\î(\é\ŞA\0	THƒ\×ø\ïm\â˜C.A’ıJ@	\Ğ\è|C0‡£[G®=s\ävuoY&H@€\æ¨\Ì&\êD§\æ†_¹7ü\õ4şmHz\ò\ÜÿØ ;š\Ø`\ãj\åh$¥\Ä\ÆE\Ô^$8±I\ÅPoc\Ô(\Z\õw\Ë\ÜC’K\à\õ\ZşQ‘d&h$5>	b\Ù\Ü@Ö§‚A\Ò\Ğ\î\É-ÿ–\õ\éY½\ßŒ|s‚\r\rG“¬O¥…4\ÖZ\Z‚>!şú–\éş\Æ\âoh	¶û¬»kH\İ \"\ó\ö“@Ö§6w&”\0Y}£Ÿ´ú^\Ü@°kùl\Ì\çÁ\Ó\n\"ı\á\ë\Ú/\İ\Ò[yÇ½²\æo6\òx\'ˆtT\0=Dı[S•@T{\â~\å\è\é4‚rWnù\ç\Ï<aŸVŠ\Şx›:¢Dy0ŒA,\á\ÚüXº%2m\íÿù\0¾\ÔoxÓ‰|s\Ñ\î\Åa2\ZggÔ—\Äû\ê¬×§›S9”®\ìMŸL+Wc›‘vÙœP\İ*Š¨·iZ¢£Y7q·’\í\ÓÚ–_ƒM\ÓU\nÊ‚\â°n\\,)s°\\^7Š)µ{°ÇËŸŸ{{süj^\Ş\Õ†´6?”û\á\Æ%>2r2\Ğû³\â\öÂ€?¯T† wq\ÅßŠ{l(ı[\Ü,°\Ô\âju>w9(q\àxf¼\÷Áü2\ôFY8\Ëx¼\Öÿ \ôf\á\î\\K\ÔûZ\É\\Ÿ\Ì\ğB\Z\ê[¦s	\ñù°\ÓK\ß\ê}ş—[h\rÖ¶33\Ôúkü\ó‰/\è›>&\ÌZkn=\Ş\ÃZ[|À(0‚0\à\Ø`m\ó\ôÀ¬z\í	-	T\ón\ó?v5\ñz„¹o.\äN1“\îºF\ñf*/-\òD¬kR.B{P,¨”@¾š©\êaƒ¹\ß,O–Ø®¿\êI¿¿w\Øø\ôG[n\÷‹:}úuf¤¨a\n\ö\ÑQ.øÑŸ*Bª¦2\ìF@iy\å3iÁV»Æ—Ÿ	[ş~ø­¯\ñS·\0VU\ë\Ô?¦•ú!\Î(§üm\Óvo€®‹X\\ùƒ²®…PrUT\ô{!ùGË\Ü\ËMß»R*\ä^Ò· è‡¡[²_4™|y\èú[ú¦\İ\ì\Ë\å\àƒo/Ox\÷»\×rş—;ù\ö›\ñù\èú\éVÖ‡\'\ëú\õ\Ûk\à†²~[Pş\ê“~ÿ\ô•\ò9XŸ&\Ül\ğŒŠkêŠGÔˆu‰›\ö\"\ÉæN\Îy\ñI`•!ø\É\ÂK\Û\Ûwÿ‘\Şø7‚\ãe+‚u\õÁ#\ë§û‚-„\Ô\Ë0$‚\Ão\ØPC\çı\r3	&4\0™v|\Ë?ª?@\êIƒ_‚@\Òlhªo ­>?!`SK«Ÿ´úH H!G}\Ø\ä¾\æ\Ïm\ğ>2½†it„Ÿh~kcAª–z•\ë€Ok[\rH\"9ı\0:0D¦j YW%Rûp•*­\ìZº,şc\ñ\õœh{#İ‡»W4ÿ\Õ\Ï\Ö`¤|ã€·\óû\"¿\Â*\ï\Û\Ù\ïº3h—rh\\6¿e*OC\è,\ê˜ü¦>$\×p£\ß7M¼*D\Ãi\0\àÅ ù\í\òhhv†ıŸ4ÿ&¬úN\Í$»Ÿ¤[5eŞ¬\È\0\\Bû\Å\0\Ù\ëH\àCº\ÒÏ–CÆŸ¦\öÿ\á´øÿ20:´ùV¨x\Z¤,ƒ¨ (¹¢m7\Ğ°²S\ÄÜ‡ÿƒ5\öŸ–\÷|\ò|×¤·\à9>O\ÔEhø},ø‹¾†\óV\Ü^T\õ¸ƒD#\"llœ\\Â‘\ë›P±À!\ãÈ•¡˜\n\Ö\Z\'\Â\æ$è«œXE\Ç\×û‚¾\"[¢£¸\öAŒ§`\ëLS\ámhF\"[†´+É´@\n\ì\ïk8>pb3„‚\Ç\ÏjiDnO¼‹~Ùµ\Ş_ÿ´\Æ\Öi\ÕÙ”M˜–d\Âa>L™^\ï®\Éİ¤\Ù\ãPc‚}\ÏN[¶0]+‹\Ò\ë\Ø\÷+sE•¬_O\Òù·\ÌG5GV\ÌA\ê€w‡#\\Àûˆ)FµºH¥TˆÀ>\înùÿ»üŸÿ…¼½œ<ı\áU•¿t~7Ÿ¢Œ	N¼}Cg@\Â6D#,ú\ë&\î+ğ·“‚\ÉşÓ…\æIjr\âˆ\Ó2ÿ\í\ár7…-\Ã7y©ÿujn¾\è?}\0ÿ€?gş†f’+\0d´B\Èø0p\àH\Ë@\È\èj\ÊË²\ô‘\Íÿr\ğV:\Ë\ÓEÿO\È@\\E\"‰‘Á\ÅF‡\Ã\ÜJ!†¡\ËüNV*\ï\Óÿ©Ÿ`şcn\É\ß\Ï,b&\Ï\É\Ø39·şW\á<$\ò%~.\çÙ¤\ç“Kkr®Ó§\Ïûı>¢\åV¡úAû¥\ïü\Îj\'!‘\í\n„“E€ Á\Z•/5†q\"Ş„oœº§E’m\×œ\Ïn\İ$hT»š·ƒ\Ó[ú\è.Ÿ,üt£Æ‰‰(”?\â\ÅH R8Ş…CGK<G\ñp]=­„\Òt™*B5JE-\á-I\Zş>\n°~úªm\Û5\Ñ/\Éd+Y‹4Ê¥\Îè‚’\İ\á<¬¡ù\r0™Z-\àt[)½\äF\æ*ù‰;/,\äjb\ç\Õ\Å7\Õ\0ú?’˜b\Úh¬A°\èªşh»\Ö\ÛÿR\Ç\÷…gÍ•8¬ùƒ\á\Â\öm\ï©\ïû]‰‘;3\ZIÿg‡\Í>\"j,a\Äk\Û\Z\Í\Z\Ë dü	À[É‚Èˆ«©ø‘€_\îq d\òX\"Qr.¬¹0†\È\ã\0ş\ğx\Ş\\\÷C3‡ro\í¦@_\åŞe›\nD\÷gšb|2$\èÿ×\Û\õª\Îo\Ù‘LD’L\ã\Ñ\È\î !K†<\ö\ç¨\ó\ße\óUÈ§\Åe=%q¯‘øbªù¶Š¾\ç^úQ‘\×B˜.\Ğ\Ú_€¾\rU“\Í\Ä~K\ï\çK:‹Ø²…OO\×N¢–_o0§Å \ê@“‚f™I\Ó\åsc\'&³¡„³¨9¯Â¦Aš,\ÚtH\Ç0€O®‰G1˜²±Ë™Î¼¢\Îı&¿-\ÌsĞ€^®*…¨tR·\rŒ«+\\A\×Ô‚mƒ.\íÌ˜* c\ëbı \Å0aZ\è3h“µM0‡\Òf\Üš0\á¤&L²t˜Ã„¯wPL¦L¢$c¸)NŸ\'C½\ÆOˆlİ¸»b>ugT}q\Í\Ö\ëD-·\ßz‰&¶VSQš-z\óWşO˜gY\à5\ÙC\ï;›²X¹D¶\òwD²ÁGpS¾¯H.¬\İ\ïB&\Ì\0® cB&O\0\Î(´\çDÈ\Ò\Ï@\"4o\ğ?\0ø\ì\ği³\Ë\ãC³\Ğ\ÊX¸…¤ˆG–›\ô !\\	`¨^ÿ\ğpı\ë\á\"%\èÌ„\ÜJW½s«ør\ñ?Y‘\äe0X\É\ä²\ô$q+ÿ!\Ëw(¯@H=ƒ§Š3%aro\"\õFj¾‹ßŠ¶$§R\Ëj\ë\òs l}ÎŸ#Ÿi\å˜\ò\Ô0S\í,–B\æ]\õ8¾0¨›Œ‰CA–^®—>Ğ°¾¿r–xÓ•øJ,\à\ê\èÎ„ƒ\Î\ä\Ú\r’8˜\"¤\ğlq„£œ\ÅS\Éúºr²Y\é\Òxr¡’R\ÜVÄŠ\Î\Ã\Å\Ús\Ë\ÊU\Â5\í7-L\à.\Ï,f´ºu—J\ÃM5Ü„O~\ì­lq\î\Üjnc˜†k\ÛGÂ‚.¥³®¤\å˜D„\îİ®\',Á‚§³Y ¨©~Y¦rƒ—“©ÀF®E¿›\ĞE]–½z.)]©^g\ë8p]\ä(pÇ­7y•»\Ç\n‹\ÎZSš­VK\"Á˜ˆDšs7\åıŒ…ŒSO¥	°\\Ò›\æO:\Ø\'c’„µk\"\ÄWú\n1_¼\ó…\åùA\Ê8’¸†¶7…È²qG¹7 \Ô\Æ\n‘\ÃÆd<—\æ\æ›aşO\0\ÏO4ßƒœ}i®h–› ¶X\ôj¤¢Nc»™¤l\ÄRÁ1\Ø\ßv4›¿\Ú\í|5`Ùª[\Êÿ‘…\ñwMD$5&iŒ(!j\Çc*{w²Ä¯5\ÊW\òv£Dü%¹\ï©\Ô\ÉûÀ\Ô\ß\Ã\Ô \"\ãr_9\ß5¡¯üÒ“_z¯O‚\Ô\\yÿ^¹y³7\áH-©%v[\Ø\" 4ŠrkÁ®*K\Ù\â´,\İ\"m…\Å>yx\Ô¡\'C†\è|ƒ‹P\Ø\ÍÑ€\õĞ…È¶Àaq3˜ºÁa²5	¤Í’\ö®\à\ÚA«cŠe e\ëS6Á\Õ6‚\Åhm)1UµƒS\Í\Ò6¼\÷µI\åª7\é¤—AÊŒ`+\ò³\ï\ÕB9Ú¡º®‘hR\':\Ò;š‚©/Š\'0\ôr\ğq°\0ƒ®ûV®£~\Õ7Q¾¥û«L9jªYL1\î\"k$\İ_ ‰,U\ïª¿4¥®ca\Ø\ã=?\äü!ûN€7r°vm/\Ä6–)\ë¤\ñ\â-h-\á&\0¿–lŸ\è7S\â¥\0\ëbùı•F\ÒS\"•£•L \ô¥¹¹?&\î\ğ}X\î7–ÿ·¹LV¼¡\Ğ\Æ\ÕÈ¼+š\Õú\È$\n™4ºŒ—RJ\Ù\ôB¿‰¶Ÿ\n\İÑ¦üBû»O,“½™$dÃ¢\Ì\â\Zı¯%?\Z\Äqr¼\Å\0%.\Ü\Ü7É›E ¸\ï${d„­V)BfÉƒ-\"pú·¼rz\Ö“ x$± œ\n\"Ø¡·o^Û¿ıÿ\Ç!\ÊV\Zt—’\ğ’[Z°B(ˆ]aúb\ÌP»+\æ_\æ†}ü\Ç‘ \Â9AU„§©”±\ìúj:h\çİŸ\Ä3¼BV@\í³¶!x ´¤\n2Z«”•Dg\á\ÊC@\n›\Ğ\\6Ñ³\æU\Ì\\8CvÅƒ5\í†WB5\nÀ\Zgp\àrp<\'º\n¤\ÉCÆ³ƒÇ©•kÃ‘‹ª˜Æ°–Ä¢)#²Ç|q\×T\î¡u<xL­_¼\Î:‚\Ş\ÎÄ´vZšœz\õ2AbY,\à¾d®F^“©7\îü”\ëù\Ñ\\ŸŠÿ\Ô\íc·‡‘‚“•£\ázQæ¸Š°!„¿r)®œRn\ËkM4\ĞA*†(¤l2‹\Ã`ƒI»	šw>›n\ò\å¡|Sš›‹«ıû\æ\Õ$®K\Ûş%aŸ.‡2úHº·e“Š8•\öiû{Plf\ZÂ™»T\ö\ŞF3H.A\"„‰|–/@\é\ëN\\¦·¯\á.\ó™½\Ô\ó\ñ\îI.\ÔÁZ”¢S;Iƒ€%[[ƒCtŸYz\Úe¹L\ØZ\Òno„O,~?\Õ\îû\ï\ÊÒ€•¬Ìƒ \'\ê[%N\ö\Ì5„kj“\Ä&Ë¨ƒ‚$\Ú\ÔÔ–İ¼j3D»•ıšBt\ãT\âE2\Éffa”\Ç4\â†§hY\èº\ì(£S\Ø\"\ã.\Û¨\ğ\àl\é”\îH‘h‚fH*“\Ød!&‚EI0R\Ô\0É¥*Ì¯kC ™\Ğü|˜b4_\ô¢qi>KO\æÅw´\ç·V—NfC\Å)’	\óŠ\ÇO½L\Èı+‰0Rƒ4Æ–@£‘E4\Öa’D9Xß¥Ÿ<&\äµı^yUÀ¾?m—\Ù\Ü\ê#W%œS lëŠÃ€\ÎT\ß0´\ã\×$®\ÃH\rŸW7oa…q<”z\0¥³€:‰\ë”}=9K¨\Â\nÿ\×n‚\í\î\Ü\\}šÖ¯‡)˜¤6¼ûŠ4\å\õ\á*{³¶B2¤\çvù\ï\çø2„…ı\ñK†ü‘Ne\é\Ì!D‹ls\ìu²_\Ñ[A<”ÿJÂÉ• \ìw5\ö\'$g“*I)ˆ\æ³yo\È}!rF\Ø\"\"„\èˆK1\è\Ø\Â]¶\ÎKp˜jN€ç˜‰j j:³\ÊU%¤\ã\ñı\Ñ\ë°D/T¢z\ÆB$†-\0\Ù5­\à¥d=)e·9ºµ?C~”«Ê¼\õ\Îm·šn\Üd‡+¯`²d•@F\İha\å\Üd“B–]8¬ş™…¶F\Úe	\ÉI\Î\êp\ÓXj\ÓMØ¡µ‹E\İRx\ç•B\rvjt\ÖL¬¹\Ùz«W–\ÏPOÊ)\Ã(§6úI°‰¯@	\êÀ)¨q´\ìd\×4Ø¨&F-€Â¨nu\î£\îP+Z*\Ã^6\ä0\Ìk\İ[\ñtE\Í^-¦\\\èNN‚Š©W¡–\×\í¿}GüKo\ò»\ßSƒO¢a\ÇnU\îS;\Åÿ°»Z\\\èoƒQ¦Q~6zs\ò\ö\à\à>~\í\Í¼7®\ñS/\î\î±\ô\ï\ã\Ş~\í\İ\õ¾ú»\ë\Z\Ï\ß\İ\í¯†ú£\÷_¹\ï5ù\îp?»\Ö/?=ÿ	½–\'øT\÷ş\í\òXÁ5~©\'ú#—?\ò‘~ı\Õ\ãú/\ë\î~+,Ş¬\Äş\0zİµ+±4\ô \Ñl¦E\ßH\éÜ¿ú=·¸Ù¹\ÏA”xZ\È+Hı¢\ğc\ä¸ÿU\óş\ä\\AHqzCh$Q d>$À\ÚB`s¸£˜J\\:ø¦\ô~7\ïC\ğE\ï{I§\ñc¿s\÷\àq\êù\î\ÓNw\áù\ßüƒ7—\ë\r\î\ñjn?y¬›|9\ö¨>®\ß\Ä\Ü\ÈÛ£ú\á\æN\Ë\Ü,>@\ÛO·\ôL\ë¦ú\Ğ%\ÑyÂ‹/ /¯\äƒc\÷“\çÿ\ß¼\ÍWŸ^ÿ\ó*n¿u§9\Ì‘_»\ÙyB¯;\ĞÑ\ÉJCU<º\Ù\ã1<\ÜÚ·;ƒ•>\Ú\æ/?·Oo\ŞyY\Æ\ÕN[¢Bbß\Ñû\Ğp\Ø\ÆVÚ„\Æ_\ö™o\ö\nNÿ #up•º;«t`)‡\×\Ş`\ê±Qšb\ğ(ÿ\âz¼Xü_1%\Ü]w\"\0¯\Ú´¼\îø\á;ø\Ï‘OœL.…)KùCWe?Š\Ç`\0Q’ü|o¾€»À\íEøƒ‡È½\à\õgp¼xz)BŒÀ›\ï~J¸=„_ko\ğù\ğF\à\å«\Ğû#z\à\õ\rŒ\Ğ\Ó+ˆ\ñÀ½Ÿİ’ê½\à6ˆ§˜\ğ¤:	ï‘†~}\Åş\Ğ	ue\ã‰/”\Å\ğÀ€¾}/‹Å¬ù(\Çÿ\'Ñ¿)\ÒD\Ò\Ğ\ÖÀ\0¬$5º\î†\òÌ¸q\ãh#2Iß„°–\í}\è3ıJY¦DÅ¡´;\ñb¢\Òb´/I…\Ä)\ÃzMv¬\ähG\0½³úˆaû6|’Qm\ÇùœW0/Ğ‹!^-Í¾\éª=nü§[\Z¶ª[\ãMQ\İ\r\r0ı-Ïœ3\àz\É}\ßRx3\ÒA\ô\Ùl¬£\Ş\êÄµÀQ•«Sorµ\0»¶ˆ\î\Î\Ä4@«\Ô$\Í\éır¦[\\·ıøy\ĞÀ^hø¾¡\Z	§&lšÁ$ÿ<?¦±€µ\éø#§p0m`\å¬L\rÎºíªŒt\'oÚ¤‘•[\rM\ÃH\n8$\0\Ü \Ù\'h\îÁ\Ê[N\Ì\Ñ0  (QŸ^ø`DÅŠ>0\ïss@7™\ô,\éÀ\Î@ˆ8vkèŸ€ŠT\äø…\÷Æ”y|©|h(@Tc\÷‡m¶‚\à:)ı$æ¯­\Z!œ\ê4Õ¼L« +\×3\ÚeNf\\\İu\Ô\Ü0Y#E$‰”$RP8—t¼”m\Ó\åq³¡iš¿g0¾>¾Fÿû\áw=Ë€3RŸ\ï+½ÙŠ6\ÃM¸l¾N²a\åN[wU\Ür‡Á›Ìµ®¾¡ºBË¬\ÕbJpZ•Ú¢c\Õ\ëÃ†Š¹$\óÀ\È\ÉTb”A	ƒ”\á„m¬\Ğ\05„´L&\ç—\n¦\"˜g|SI¦ƒd*‘,z\ÙDL–Œ!ş–Æ–\àI‡\êz\âH\0DQrH%[—Eı}\Ğw\Ó,\ò$\\\ğ¿a*¨^	œŒºCT\"p1‘\àiû‚n˜I5s–e\÷XE!Û‚‘¿\\g‹…\n¦\ê\æ6ª´Le:JS¹EO\ÌPAiaH*³mIf&!êŒNR\nƒ’’’ 3\rZ-w_»{mEÕ³\Ï\Í1{\Ğe\ĞY§½Û•ƒ\Ñ$W£\ï=üY\İ\ó¤w€\Ü7rû\à^‹\î.‹C…](5\ÓÄ‰¬\Ø\ë¾jª\ÂwK™p4û=€Ÿ4c6)/S{Y\Â\ĞüŒhÀ _]\İ\ôœ	²… Œ\çO&M±sj;’\Ùt\çcŒ_1…`C°¶¹Afu”–T‰R\ÚË­`ŸO’\â\÷\émjR\Ø7´\ÏA\ê‘ ¤,G¡2Q;³ü}j¿–®¨©HY\ßUM©+\ãü˜¦§™`\Â$\Ìfe.®^:4dÁDA¦\nD\ÒHR\Ò%•*,iE”Ri—„Lè¡­Ë–´Ÿ\Édi\Èl…S\ÆtG­½\é½;\æ4Î»\İ\Ü<;ù\Ò\å€ù™›\ñ¤_—1XÖ£\î\Ü-\ò®T4x\áªE[´ZL=?¬µ„”£ \Æ\\ù\ë%\Z\õL”¿/å¯²\ËÎŒF¸\\\ğV©¥º@=\ñü¡\áR”x¼\è%‹)cDdƒ‚\çWr¾g|/›6$XK¨\È\êE·EQ\òYv½›\ä‘L¿Î”\ßM\"¦øûš\Ìl¬ÿŒ—Hd£útK\Ô(#ykj\ê0‡;¶,½Ë›…\nA-\Ë^9\Ù:‚/—¹½µ®“\öºc4ŠÔY#%%¦\Ş?A)utš,±#\ÉW\ßAU¾r\Úh“ù„´7G=#\Ó\ë\ãœ\Ù\Å\Î\Åqj,5t\Ö\ÍG Tœ;\ß\÷u\ã;\áP\\Mÿ\Ï<‡\êÊ!W£\õ·\Üÿ\âÎŠÅ²·=¦€“\ì\0=	O\äœ\'\"†fJ2E¦¡×¤ÿ\ÕÀÿ`\Úa#Kp\Ø\òS1T’^±I½\ïTLÎŒ\Åı\Ï7\ï¿R0x\ÉÀ\ïL{$øº@\\„“\Ö\î¦>›°\ÍE2ˆ\ê\÷H\Äÿ	Š§\ğ\é\0fšˆ\"š\Ê\×b5È¶h\r\Ö\×À#Q.h t\"@ª\Ù\Ì\áh…\évc¸7r\ç\ò\î2k\Î)n”\Í\å>\÷y;ø<—\ë\Ô\ñŒX¬r®$¥RI9«\ÓL»=MDFR¦\çˆ\Z’¤\\&•$J¼¤\Ä\Ôú\Î\nR\Z6e\í\ö\ğ\ÜoÊ”¶È©²\ñ\Ü\n\ã‘.I²Z£\ñ¦\÷1š¼y\Ô5Zw\êÁK\î€z9¸<^€uÎ¬¯ı¿‹)—i\İA„\ö\â—$±N¢H¤\ëf´¿\Øÿ{µ\ÌÇ«M>€KŒp\Ó:,|¸\ë›¿\ÏJŒ)L{qr…‰=¿’Ë¦gŠq¯:^LM\Ç\äi\â\Ø\Å`·D]\Ê\Ù\ÚF4\ï¡„ÿª„şjRŠ8\0…tˆ\Ì\àGˆ‡/\Ô\"s‰\ÌN\ÉB0-POM„\\h\Ñq«\"‡«&Ÿ´š•›U©Ì˜\Z\ä\Ø\È\Êb«qMPÖµt3½O&s\â½\î~ü\Úaß¸ùn·ø?„`Ÿ5\ó„’9‘Daµ¥‚T¥ªre\å5QšI\Ú/TÒ—Yú\Â\ÈG\ã(\ñÀ\ÃbF5f™E\è\ß\õ¡X›\'¡zf\ôE]\ß6¶x3*o\ë] \r\â:µk\"ù×ƒ\ö†<>º}\î‹S\0G©\ÚLvPN\æ¶Ç››{ªÛ¿ıw“\õLù\â\ï7_\Ô&O\Ñm²¶P¥ \Ğd.~Ô¹µ_\Ä\ôƒ©¤\ÒVL°ª`Œ\×\åŒ1~Q!BW=»+\ånu»l×»M\ğww\É\ßs\×ıgP¿d\Ñ%\öS\Ôø\Â\ÎPH™99M6.7! P±\Ù%\öR‡¼ø\Ï\\q\ÜQ‚£™6ªTfY×Š†T†nŸQ\á\í–\",82j\ÃÁH¡¦@\ÜFº¥Yyû¾\Ëıú¿^³·Y`”\ÒW\Ô\Ô{\ÔQP\\\Ğ\ÒBA@H\ã‚\Í€h-‰\Äx%@\ZHK°“:§}\\¤ıT”d\Îc\0Z\r\èÁˆ1~g\ÑT	 (N]\å\ÍÕ)qƒ\éRb\è<	\Ş$¿\Û?a–(Ğ›%Á€İ…@v+\İeu#\â \ÙT\ô¼¼<YC©š\ò\Øt\Zj‰†ş–@ı\İR\ÑÁ¸w\0¿û\"\ã†\"5\á\öEı\ãx-.0™\Ş\òeP\ö\\¯R_1RL¬J‡_H\r—&\ZUı.\ì\Î\Å`\r\Û~r¢ø_ \îŸyW\ÏÁügü\ÏW\è=«#ByP\Â\Æ\nPQ(\ì\ß\îW(ª\Ùt\åuø\0\Ô\Çn´\Ö:r¸Cª,`\êÀÆ‡[Ï§£­\àš\ò\0H‘0\"€	R\Ó\÷EI¬\Ù2/\å4úWpƒÿá¯—\Ş\Z)\0!Í¦\Ö@\à¨\Ğ\à¨@\óŒ\÷S°A\ë~\ä2\Îa²6ûÁkƒş\Ú Á¤#1C_€ƒ,Ğœ,o\ÂW•œ¸üĞ‰:\å„|615X+œ\ÓÏšŞŸ)üı/½\ë°\Ş,wÁ;”Hº°(‚I)19\×\Í\'±§`rˆ\ÈT\í¢\Ç{Ÿ•@¦\Í\ÔPQ«¸e\0§96\Ê4	¥†ù\ë…ı«’ı\Æ\íH\áÅ—\ğg?ÀQÂ”ø×€M\Ó\ë\0\ÈuJ««¢i› ^Ä®qsKx)\ğy%\ô\éj\ìo~ú?K\ô\÷°+ş\Ü+\ëÿ0\óac6\òB3z¦&§W™\â^¹<Á²‚\È\ØjŒ\ó\ØEŸ1\Ş\÷+r¡\éO§±n½Ù¦¥uA\ï(Y¢r\Ú_$@\nB€ÿ\İË…¢y\ô	Ş·\éGÄ¶\r¿ş–\Ñ:o:ÁPƒ¨\è \ÃQ£H\ä.n†VÁ\ÈFI\Ê\Ä\ZÉFHP-\Ú,•CÁRGjj=…\õşS\õV½v\è\õtg}q\ç©k‰«#v\×Á57\ò@È½.\îc\íş]G\ñ@üßµkŸQ¦!…\Â7Å \Ûv\ó\å›Ahş¿\÷‡›m(¯·Œ	¾^†5¶Xe\Ë\0¡H:\÷\òI“L\Ö·\à$‹Œ›ªN©|\Şh¼‚\édU“_Œ#´ÿË€aL†¡¿#pfÀUc~y–\Ï^\éù¿D\Ş\Ø\ŞH\ĞÊz\ö\òR «§\Ë;‡Gø&øTki\ë¶ø)¬_>\ìÿZ\ö¿\éi¢_ü“\Ä\ó§o\Ä\ß=PR\ØD\0±	VÒ»}\â³oUA@\Âpe˜³J\ôa\æ³F&R\Ğ„\ó?º›^ˆ\éR#Ş–¦Q¼\ÉsıQ.BÖ\è\ò\Ê\'¡-¸Œ\0¢@„?øO<¿±şq¶¿§ÿ\"’\÷C9ı‡³2»\Z¤¡i=\nJ°C\àø;M\ïBúûh„U3,C\ñJGeR°4˜\×\ó\ÈeQB€(XD\"Y\ô\çG Ç¡\ë\Ì\Ó\Ë\Âxœ\ÔusÔœ\ò\è5x.\rÁ½W\î©xÓ”\'\ä\å\ïˆ s;\Êı}¾@\ĞÍ¸ÙŠÑ»c¥»N-—„ˆ´\Î\Î&,A\n‘«·¶@\×û\Æp[\0M.ûLMU\nzEJ4UtÁš¨.	\È#3“¡\Ë «9p®¨A)ş*cÿ\ô\Äü‰‰şCD?!ú²À\'\à{À7\ö­,\õx—ÁG\á3\ğuY_@}.\ê·L~§\à—\Íú_ ÿ)\ôû‚Ÿ\n!\à\'\'ø\ñÁO!!„Ù­¯Å“@‚\\Ú±\ì@Weıc\ï\"G8¶\Õ\Î%”\äQ~-‡¼¬ \Ğy?\í\Z\ãiIª\Ù$¼s_”Eˆt\0&@ƒ\'«X@§}\Ò\è°Pª~P‰ÿ €)ˆ‚*\"¡‹/¡¯ ¤4w\Ü-t!d\"o•\ÖF™\×\Z„’`\İÃ¥A‹\Ö]¡WzOC\ÎLn\Ú(H\áî’\Æa$x´X\êıM\õ”à©¾v£k\Ïz\â¥^ú=nÏ˜µ\ßE•†,1\ìsÉ³0T³±+±G\ZO<\òFw¼‰»\÷Vß¢\nVR\Æ\äü\ë¤\Òú\èn\ãÍ±\ã\çJ¯!_i7Hª„\ìÌ“«\ÍoH¹¤Ò€\r(U\öÎ»¦ªo¹\n/IÔ \Ôbµ\n)Rj\é?RıÜš\ZH\îe.„ş\ö@ı¹ş…@ÿrb~>Á\ç\ï^\ğ\æ\Å>H\ë=¡\èD}Y\ğ…ı¢ôŒ¯²\æOe\îF\èsYü§±\ãüşA\ÄE-äµ P$\ØvhBcLšŒI\0²\Ì\Ù>,×‹8’‹–\ây1M¬\Ôr\Í\æC\Ë<¸šanCº§\Ç\ô«\È/I%\î\ÉABb9-£\ß.¿ûaË—ll†—¯\ğ\"\Ñ^aÂ²’7¿ú8„~¼…‚F)Ÿ†}\Ø,–\Î^»\0€`\ZO\ğ\Z´()²&h¼>u\Ê%-o\Ê2•\Â\"Dùîœ½º\ï!‘{OøX©5u\Ë\÷V\ç\Å\Ë\îlŸ\ó\ô´\"h$¤O5˜\éy7\\ŞFk\Ä@n6‚ıÀ\Ük\ğJ¦®6\Ç<­5“\Æ<¥!\á?@\Æ\ár‰üyV{\ï¼[ú%ØúÕ<¦\ó®\ïP	\â’\Å\ô&P ¼Lû^S•@\ôŒ@…f”ú×¬_\Ú@Ãše‚\ßßŠ(³‰}x\êfP#U‚¥&U™Bª‘\Ù\ÄÁ\Ø\äG7Ÿ\"\äI(‰<a“(\ö4eX]\óD³\ÑF\Z‚Í•ª¨d¢a\Éa\ÂQªûŒAg\Ô\Æ\à°iÁ„ @›L½\Z*³Dú¬!\\%\"\ç\É\Ã\ÈA\nV\0Éº\ôÿ 0û’ªv#~N\Ùı—¹± A\ê\Ëûwu\Ë‹\r\ê_$®»\öO\È8R\Å,K\ßÀ\rÿ¿¦k<0„ \Ñ\Âa1Y$ü\Ù\ò3`¶Eş¯Ïš“\Ü™\nÕ“\à\ÇCˆ:£<›/ˆ\ÎKqZ‹ê©Z\Íw.\ç†0­w#(R\ÃG*­\Ö|\"´‡µ—ªkùB\Õ\ÜÕWºv]Ë\ïj ø‚¤ \Å\Ë\Îe„\Ó¾N{_G\Ô\İ\ñ¼\ë\ÛJnšĞ˜\\°”…$øø1&²©Ê~Z>ë”§%\0\Ğª\ÑqF’a\Ú~ûc@K\0R¦¢IQ”N`H‚+&\ÕTV€\ÈxY“=„\Ë\á\\*Çù,¦°¬ÉŠ€f†Q\0¦\ÆC\ævùİ®\ĞH\n&Öƒªˆ¡6\×úWbNÅ•\Ü*0\'[^\à	Š\ÂN‰ƒŠ\ëB(ª¥’©H\éZ^»‚²ü—\'*yn\äş\Ë*ë™Œ´Âƒ\ôH—Äº	\Û&>^8\Ïv£\Ş¾JU=l\ËWb±\ÒÙ¢\ö\ï3\ä´F@$ş\í\ïı&\Í–¤\é\Ï6\ò7ş\r\ßú«Át:0\É r\"\äTd¯\Î/zuH\Ã/|›Ÿÿ•A–_¬j¯mb\Ø\ñ>\ñ\î²	V\ÖY<GQ­±%‰œ\õr`¡Si\êP\Ç\ô”Z\Â\r:¡Iyw¦|»\×RùÎ­P…\á)\ÄKy\Z-4eh4Õ•ª	^\"A+ER²\\\Ï\í<İˆ[§\ß\ğ\'\ãÿ\ô¡Xˆ«­©Jp’¬º\Ş\"D¡\ğª.mi	\Ö\õ\å\ö½\ä\é*V>\Ô+ª;ç½—$­¾<R\éˆYe^\à\ğv3økiK°\ó‚ˆs@.5y_\Ä ˜Ø¸r\Ø6€„†Ş¶Ğ¿µ}š¢™“úX PÁBX1Æ•Œ«ÂªE\Ï\ã”@b(±‘{,\òZ\ô<|;ø\ï\à2d&&¥¨ {n—³\äEÿ`ùn£\Ù>£üC«¸\ï&\õ\"\Öª\óH\èÌ¥!r².G[ı\åWxÓ—n™p>\ñy£\n±È„:™x±\Ï7i(#b‡U{Jµau\È\Ëù#q\İo¹\Íya7\çH¯/*b¥»1¥´\í\Ü\êE£bq¨¦\óş¹^Áº”*\è…5Î¸\ïO\ã5ü…_\ğFş\×:üe(]±E\"P·š¯1†q¥+i§\ítÃ¸£a‡\æ\Ê$\Ö&³q\ÉTœF¥\Ö5	H4\ï	@\êZW\Öƒ1½2¥~¸“Û—šš†´\\A/\×\æ\ñIo`\"@3i\Û\ÌPEb6U7æ…¡Á\0D\äp§-ZªÖ±\Ìf\à o\'\"ü5\à€#f,\ó\Ø@&~c¢S\ç6™cI+)$i±D\ãûG …‰Z„®°V*‡\êW¿vü‡t\Ó\æS2\Ä\Î\ìÿ8“ªİ¹\å\Ïm\Ä\Şt\'‚›“›Î“§\è7«M;~\÷†qX\ğ\óP„)bü™_;c\0R£8‡5+­FÒ¸0F-)/iŠX1ˆ\ñ4­‡\×ë´´S\Ñ‘}\Ò5\ÔÆ‹¥5û/\É‡¤ª%\ñÀ,;–/±Xf–“\ÒHb—ù\ê\Â\0·¼\ö?B\ó\ğºü{¼–ÿ\ö\ÍK–¤©,[\âJ\÷x\Z	\ÂÁ4–\r„=°ªU.\ñ\öS¨[\áš	¢”-$fcj•\õ«MU‚’DED‘\"¨´\öR“S\×&óº˜ši\å¾V]AFKi#Dw\ó\é\ÛÔ¥%eQa\ó…\åh¢È—®t®a\ÖÌ”,\n¦6f-SŒ’\Ê\"\ÇC®A\áø+\ÌQÁ\Ï|\ßZAzwU5”m.DLP5&\ğ¶¼\êúü\ÛQ¸²\"‰!\é\ö’ûø’¦,4°‹^&oş%²x#\É0Y\ôşŠ½\í\õ-qcqÓ\ô‡ÿq\×\\\åº:\á^H\ë„i\äÜ–¶Nßˆ©\ô\é\'¹\ä²8u1h ˆB\çaL€\à·³¼X“œš\áT˜\"e|šœH\ÊÅƒ0ˆnt…\ÌhlŠS,¡GˆYjŒ\0*\Û\Ä\Õ]Ş©4¿•¦@\ÉÆ‡®	K‘ †x3~\Ín\ÉÁ*dJ3¶\ñ\ğ@\ñ0—®º^ÔŠ…\ÊO\Òi€ ,\Ş_6\Èd \nP¸ü¯ü‰MU\0@€$j¢\rh\"§\õ$HÅ¤©­$† «\Ùt›31i\ñø	/\ğ£	P•§\"c¢JÙ°Éœ“GˆØ´\Å1f\ÕB\ÑQ$ıX	Fv9º†Š…U!%.Ô•Ÿğ’‡¹Nı)ˆ]\ò\êvz(\rJ!\×8$\'»OŠ\àIe¿S¸¾\Ã,2/\â²¦\n;vc\ŞU¼§ıˆû§°\ówd|r§\÷³ƒ\â\ì‰g¼CdLb½¥¿pè‹¯¸\ÚŸ/m*6{\ìJÕ‹;\åo\Z«JeYQs§@\ái5&€\nÆ¤\ò$”C‚>.kƒ•µ\óy>,\Ê\çP{±«6\n\ÚÌ&Lp\à\ö¸4M.\'25\èŒ\r¹\"jùl°·n-Ò¨ùli#\ÜrµÜ¤»\õ(sæƒ•\ê	;‡˜\n}Â¨u\å`ji\á^^JÇB@Î€9~\n\à\Ø!V‰SSC\Ş{O\"Qh`@©°(T©Ij­\"·T¤-\èR›\ğjQ0\ny´HŒ¦GµÀBƒ\Â\"sÊ’©´_2/‡NË¼ÀÍŒ·\Õ\ZŠ&@²\Ö@€,9&];ÿ\ö«\ìp\ØFEŒ´1¹ºıO´\æ\Ì\öFr™Kr\İs1\í\Ë@œ\\¶\È/ÿ\Z`gaÖ…U“şÎ…[¶\÷-h±\ß\Î8?\è´/_›¤\ÆIĞ‚x†\êÁ*w?\0fSØ³ş°[\Ò\âl³‚\Ê)\ã	!\rzs\á¢\è\\ş\Ö\æ‚W™\'¢Å]·W x…+\í`Œw> |w²N`=ŠWÍ²©€1,$Š€«C7v0\è\Ø\\,±\Ã\õ˜l«4\Òi«‚¦”\å˜øn{3Ÿ45*\0\Ş2x\ô\ÏS\ä\'2X-ı\ÍèŠ¹\Ï:DEK0p\Ô\ZD:N\ğZ\0(\rîšª˜\Íé¾™\ò®j	R¡\Ê\Ú^·º®•¦\öZZ]P±´=Œ€<ú\å\×UQ!c+Š\ÅÎ‹\ğÀ2\Ç3f±‘\Æ\â.\õY¹j€\Ñ\ë®\Î`$Q@\'RkUQ„\õ»ÌL\Ûzùİvÿ\ÉX^¥)Gªih,‡#‚A\ä|\â\ì:\Ñ	`B˜D\ï\nº´\ñ\÷œª›¨7\ÅÔ¯”ú~\nLªşª¸ß…¯»\Ìü>}¹CE°4‚\ÙĞ£–y\è8\İQ\Ék³\Â\âw\Ê\Øız\ä\öÕ¨{iû\0\Ê\Ó!q5B ze\õ\Ü]\Æ+\Ë\ñ\ò.®\r\"y$À	°‘]`’=\Ñ^\Ò<\îš>\Õj\ØDûv+8\İÒ\Û.\n(¦mqdQ\Ê\áÌµ„tŒ±‡$2N0#X# m·\é¼\ğ?\÷¦%\0D\Z\Ò\Å}0Â¡«‹\Ö\×\Ğ\0K5)€¢R\'=j(€¨\r\Ç\÷5UM­ˆ´j¨U Ê“U¤.­\òR©IÖ¶`(ÜŠ$E‘\ï»ní¬$’×‰£rWE;\æ\ôŠ°\'¿[:‹c]\Ë\ßw\ÑÿL­]ù\'/i¸‰\É\'H\õCmu²m¾:_°\Ås@d\åPb—p\à\ô#\áÕ¡_ÿ\ï´+ß¢*\÷ì›•ekU\ÃNŒ¯k{ú\ëD\ô4K\Ç\â^WŒ\Õ\ãÆ’v\Ñ¢µT0[¯{7z=xß„\ËG\ã\Æ\'8=Qà¥œÓ›’ÿ\à·Q—ß¦¬X#ıˆ%\Şÿ“\ôzü‡\Ş~G\Ù\ôU—¯\Ş<Ê˜Ë¹o\Ï\"jg\Åd_X—W>®—q\êW^®Ú\È|usN@L\ZJ\òO€^.$˜_ş\ÏV\nznv5lQ8)Æ–;\ÄF• \ïº\Ö\Ü,\í\á*n\êF\Û\ñ?£\íÈˆZH¡\æc%c4\Ç@k>\ÜtÿÚ›\ò\í-Ÿ¯\ÜQ]I®`k6z‡¿‡Ñ½›0Q\r\"5“†_Am\ô>i\0n\Û\öKMU\ŞKµ[{Y HÅš µ‚$¹•uu1k°P‘º´†.¦11ú>:fHZ[QFM\'ŒQ—¯eL`\äU\ÃtˆJ“1	—\\&=Y\rf-\ñ\ÃG[œ|È„º›6-*\öq3\ßh\ó\ö$\æŸ|_@/\åA\ïJ\Í~\ç\ÍA_\\ûGa¿ú\ê\î~\ğŸxœ?o¿ø%·¿\ÙbüºU\İY\ã\İ/X©~;) r‚Ò©„n€\ÎWU\ÓF•Wú«;\Êm£\Í\ß3\ì\ÍK\ĞO ˆ\ã=\å´\Ê|\ğG3\İù´ş)_w¦ÿ›œÿƒ_sÊ¯ı}:?ş\Ëd½ÿ\ç\ê\ò\ÃŸ%~\ä\ï°\ğÿy\Â}V\á2-şüÑ²/\'\ï%\Üy\Ï\é~\ô\Ï\õJRw\ï \r\'o¾¬:\ò\ÇbM_„HFo8\éG*2amQ†n1K)V¤™\rA\ö\ÛH\ï\Ã\çÏ Qa6\öÿD\ç\ö¤\Ù\0•p\Æ\ÜX\ç	\à`\àvM=\È a\×o^½7p\ğ|UB\ã\áı\÷û6b\Ã4¶H\ånF`A\0 &¼ºD*\Â\É\Ô\Í(\÷\ÒHFª`4C…V$Á+*5\ÉZ[t´	BMN©B-hFªh“¯?E#’\ë\î\ì–wl£R¥Õ²\âGù¶\ÕU\nª\â\ßJu4&3µ–sp\ğ¯`†/c>™ı\ãB\ó  q#Xhs\Ä\Ò`>ª\nO!\Ì†í“¨T8^i¸½<¹¨\ëb\Ô\ô£\ò\æŸe²\÷\å­`¨¯\ÈW\÷¸\İ\'´\İı\ÑwomµùOD|zV²}Am8\\9\ÊsE\Ë\÷Qù½,ı¢J{_U½•ÿÚ„ø\ó7/,\ñJÖ–\Ô\ç·›.°Î“Yt}}zŒq;ü}ù\éÿ±\à\Ó\Ï\æ\ë¹\î·ü\'·ÿ\â?¸ú{C\Ã‘ş…^	ª{\×\Ñ\à\"±&€X¿P·nvgTJ¼`ÖŸ¢#Õ( ˆ`\rb²g§|†!ƒk\ìa\ó‚]]„¦Yˆu\Õ0?‰™-zM\ó˜Ä±\ôJ+h\0ø‰\Z /y\Êk(Š”%¢½Z\ä~‹ûWj1=\ÙkùOd1Åf*‹&°Vx\÷f$i‹\Ö\òr[“³4š;‘*\õ¥+C’H\Î^\òû*Gš	HÀ\'§;{\İ(\ÆÂ¹8S}lR1I\r\n®„\Ø*\Ö\Ó\ÙQ8C ¨\0\Ñ\æ¹)n4V4V4ˆ¾kªG\÷bJR~¼‰\è>Ó¿¦\ro\é\ã9>e\ömLJhj¬›{l$\å\íªli†\ğ—\ô\õú\é?X–\"\ô‹„D\Ô\õıÊ­¾\ç\Â\Ş\0¿¾Ae\ï ¤rş~[qş›\Â\Êw©\ò»V8ÿª˜\ó?P¨V \0|«9¦0¡\ÚLu\\GzB³¬\Û=\õ\Íb\ëWrwhLM=Š#@0\0\Ã\Û@(n‚€€\Ş\İ\á\à+\Ş\ÙfQS_l\ß;E¿\åh…\åqS¬1e)dhKB«\õ$ppK!v[\ß7“ƒ\Î1¦£\ñ\ZH^:ywj\ö4+¼’D˜2©D’„¸\×EVi®|ºso`„v\ç\Ç@²s‚y)­¼\ìL„`4µ¶´Šµ\ÚD\Ú\Ö*\ò\ŞK…UêŠ­Õ¦¨(\Ó3Á\Õ\ö&+­!N\Õû\õÎ‰\Ùø\Ú?™®r|\Ç6S ¨œd«“\\\r\×e\ñ\0U9\çØŸ\Ì?\ğ£r\à]<:EºP¼wùMIø\Æ2rˆÿÆ…\îKIµ\í(mø\á‰+±\ZÀ\ä\Ùp%sb[\Ók\Ş$ºTk\É\Çk¯¿-Œ\ÉqzCNı@Ñ…Ä¼\İ9ÀŞ‘\İÿøi\ò—¡û·È´>Š\Â\Ø6\í\Ğ\ØÀ2º·\Ì\ÅÇ’\ï0v\ÆA\Ğ$‰¦#È×©4teYc±AG.\ñ0¥X6R‰e¨sp‡46)B\×@CÒ¾c§\Ø[#¬Jf\ëË†šBj°Š\îA$¼\êO¨,ª}Ã§\õŸB¶±7¬\Ü.\÷q´\èÈ‡+\ôzš§_&\É\á3D„\Úa]-V\Æ\ğ\n;ˆˆ¨Œ*W\Å\æ\é71=S%QšYJ- \ÊZu©\ÚX¤®µÊº¡\ÉK¥\nDª*%m\õ’\ëq\ò\nB€¡•N\'À\ñ\î,Å„1?ºúœ3\ä\â\ä¤@°€¬¶\ç\ë r\Î @@&\İ\Ñ\ãgıe?a™¿ş·\ôú\óv¡_ \Åî¸ùY2\Z7¤\ÚyÆ{œ@kd/ršd\ÛAt{\"\ÚKrœ©\Ò\Î2>±?\æâˆ\î\"­\Üú\ô·Å \'O\â[ø‚8\ì¢m\Øú\çNFü\Ğ\Ô\æ\é.ı\ÍExı¶!\éûE\İá¬$:x»+¾\Z\Ğ)Àˆ¨§O!ÁTš‰+”e!O\óüqEœ\î\ÎB\×Oøş³µ,maZC+;9=$\r\Í\ğ»\Ô\à\ó\ï)\"vk1\ãAœ«>q\ãQ¹5{(W˜‡~l¤[s\åFŒI±^„„Mn\Ö\ï_\Èü ¾\Ş<^1v&Ô\\\ÃÁ~\òJ&KK\0\ÒK`J&H:D\ác\×/NUt¼˜ş\".´P°\\‘\î˜\Â}‚XKR­µ\ÊzJN[\å$He\re²<Y\æ”-\ò\ï\÷Â¢¾.‰R ™Ÿ\ÓÁkª\ÖZ\Ú†E,¸‰J™\á\"H\ç\"èŸ”ˆ\ò\âµH0»½e\ìK2¿ù\Çsıê¿\âüúuB\Û<­\Ù2& ²9IJ†q\ñÛ¸~ \ÓŞ§Á\ßy…;¼’W>Á8„\Õ>\ò*»?¡\Ñ×…_!z³\ã\÷7´\ï\ÈL)À;\Ä*]\ŞùM˜>E\÷ú3z\îi…\Ç;…&Œ¢¼¸À@‰\îN\Ó0ƒIŒ[\Z+¡ˆVú\\E	¢\Ò\Ñ9 ¥j¨hPb\ï:h\Ò\Ó.Z	k TÿwlZQ\Ã\çavG*\\œˆX1üJh$_h\â³zDq{\é\Ï\0¦\íJ‹ \í!\ZaTÕ¦\Ü}5hDµ\0D\ÃM\Ò<e\"PÇ™œ£rÏª\Ä\é\àıi¡z\0‹¥×‚¿\Â4IT¢I`Z›\ÑU£Š°\"\"É¹]w°Vi/Püü\å\ë:Œd«U¾dÛ‘…Ršº§¶\Î\÷Y5\ÚB1$É¯\Ûc^\ævV!\Ç9„Š4]6\ğ\êi\óy†7ÿ?\éÅ§\Ği ¼ƒ\å$\Ü\Ã\ób\0\'L\0>\0^\ô4]\Ø\Ü\0\\1\Ã+¶ÿÎ›’o¿…MI\ìO:|Ll\Ç[w¸¾bOo²´U\éş7û¥³\'d¾wĞ‘ß•ù\Ş\Ô}¸\Óvy`“}\Û,-p\è#D¼\rIF(`ûœ\"\ÄR®8\×X]\î˜p¨g\ÍV(\Ù`?ÛŒ\Ö0H—NrLw(c3*‚	¸9jÙ&\æ°_a>R\ãºŸ¦YA¤€B&ˆ\Z¯2\Ğ\ØL®h&:µM¹µ\Ñ4*ª‡)+)I\Ò\Ü=;Ù¹K‚k0z\ÙÁ\ÂÑC\Æ\ë\Ê\Ä\ò›\Í–iK€“X+ÀÚ¤œ¤\Ñ\Ö\äœ\Ö\Ó\óiÿm›\Úe\ï\ç|\Ñ\r\ê\Íf2o¡³\÷y\çŒ7ÁJn±dF@uy”6\"J\r\ó¼\í‹\Şşn3$ÿ–\ç\Â¹pjdB\Ì90Xü\é\ß*3ÿ»½µ7Q)¡²“\Òÿ+¸%\Ç_\ò\'’\r\"\Z\ë5Q¯°›\ÍO\İÿ\ãOb\ç+\Ít\Ïv;´ù\Ú*\ò\İ\"WŸ²xı\Ç\È~\ó\çÚ¥ûq\ìL\ÇO\ËıúU\õ·\ô¼ˆ\ÊD\ßüOd\æ½Ğ’:\0\Ü~C\Ô2\")¢p\çH¾\ÑVA‘3¨‰AJ\ÄQ½´—	Œ%ªA–\Ä\ÓB1æ»„\ËQ´k\ï?!Z\ñû¹ë…¦·\î\'c©\÷BŸ\ëR6d±\ìId\õ˜J\Õ[L1a\Ï\İ\ë\âHtSÓ®Ü‹±\Æ\ÆCP\É8\ÙR@r8e\Ö9o­}‰Î³kj\÷\å:*k:ZL-\äÿ‡Q¿M\Ùk\Ê\é\ôÈ J•ZË©R_N\Éù\r‘\ğiønü é“º\ÏI~ƒyŒ —\Ô\ë\ßWz0n\Ù_r\áªD±d\ÄS\ö`\ÈG¥&\ä¢Y‹©¦‡aV\Ô!r\ßLƒC\Ø~\÷·‹¼ü\Û?ÿŠbı31.\È;°û)²ı,¹¾°\0‚mÀ\èD/^“ø1*O\ñbOŞ”T \Í\î[_B,˜n_S^\\\È]\âÔ®˜\å/\Ä\èÏ¡\ZG\ì\í{Xkx7\Õ’P\0„xi\Ø\'Œ€\0ªHª£L„‚i_oın\×\ê!%\ìúÇy²+3¹¦lúQkw§+\Ä\Â\Â\Â!\ö±¥0[K9\nJ\\>€\å³\İV\Ë(	%P\Í‹qvûD¦\ôÌµrv»\0Qrr_a¶~x\Ğ‘u·kµ«\İZ¨\ì™\ÍA \ì–0„@\n\áad™²\ç’\n).µ_á¶u\ã»#\î#³Ö®œ¢*1U\ÏÉ‹ıkdq\ì¾k¼‚\ëÂ„bŞ’\öŠd\'l@fù±\Ùq¶;@9pa\à\0şù²¹Î€\ï1+HnŸ=\ß\Û\\\Í\rı!uPR}fL#6u€[h*\Ï\"ˆ¦\r#l€“9,\î;K`\0®\\±\ãË© U„ª1U\èD`=6<\ó±\ÂJ°¾¾~5&\ëWl%Š\â›y_ş0şû\é°\ï\0u\óÔºÁ­@+\Ğ>r7\\&€I6\É\ÖaNŸ+\àkÀ5w£_d× Ì«C\Ü2\Ü]„\\…B¥°İ‡¢\ïn\ğş®\òú¯»úû?\Ï~\ñ\ôI£7w\á®$…UA…­\r{·¬’cSfV2\Ìc¤–&\n+*\ÆÊ½Ø‹]»¤gP@\Óp\Şk\Ìû\êÆP\Ô“Sš\îr¸œj¬V\rÂ©\"\çL™|\É-4¥¬*•A\í¤\\\ÉD¬\Å(®\ßAÆ‰j\Öa/\ê\ñ~&¯¿jŸ\ö\ÅwÓ¹\àI\ÔlÙˆ\0V(\Æø	\0AX\ë´ lFZ\Ä,K\Èh#Á^bmQS™\â\ñb\ênø?)s\æR,\ï\ñ›pº_ø¡•;­\ã´\ì¦[ŸC\ä\'\"fCAo;“”Àv\Ç7R\'r6\â\n>¡ˆ\òd\Å\ï\É2ci\×•¡\ğ\0.’!\ÛĞ…\n¼e7wQ É¹V‚¸‹(¶k¢:\ÕH(T\Æ`2.Ø³qDe\â\éû\Ş\Ë«/<\Û\éM‚(†r1‘aªn©wÁ2ÿ$Ê´\Ã<Ÿ®gr¥³\Ğ\ãÿ\÷?V\óOş\Ïqc\÷VÈ©‘\òF,8]`¼&\Û-\É\0AÊ¯ nh/c¯^š\ğZ\ÔS©N\æIµX©º}\áÑ¢ı§ \ç9o:¤\ß\é}ú\ÈÄ±†„\êÅª1v\ó! ¥c\áÔ‹\ØSs=\İ\éûƒ\ä\è\'\ó\Ó5jÂ¶fvO\ê@Ÿ\ì_OĞ‰ƒû\Øu\Ö\"l‘81\ì\ni;e…\ÏÈ€qjh\Ö\Û;V\Ü˜°fX1u)¤{\\4±\ÖA-1 `Ùª“\Ö@\Û\åÌ‚¬5\ö±\Çwÿ\è\ñ9\ò\Øı\\/\Z”\ß\æ´\ã\õz9#u\Ì\İÕŒXZ\0i¨oª!\Ä_\Å$5¬$V«p9ø•Ô½mí…˜Z\0Ñ¤\Ôü·º\0•X\æ/$ê®¹@57*-Co£u\0\æ+‰2(OmVÕ‚2Y\å\ÖV^Èµ\Ê\æKq\íl\ÙDolÀ*mw -d\ÏtK†Ó¢\Ğ\É\ò–\ìy’	g@/\ğjË›²rÃ¶™¡\í@8¤%\Ş\ÉyÑ‚§ \åiŠYú\Î>\Ì>\ãú\Õ\ËN’\à*\"T\åÛ†\æq®Yˆ A’\ëv¶.S\Ùt )\Å\ÓÂ¯~\Ä\õş\ì?\ÓL\r\Ğ»I\é ú$ù\Û\ê¡\î\05“1\Ğé‘E¼\ÚT#\Èeƒ\å\ô]\Î2üUÿM\Üq¯ÿMû\Ô\n\ìH¨¢½@—[q´¤„+„Ta«Txq4\r=\ÖK\ìtpIP„)\Ë%Y7=…[Ksù¬f¿|ÿ\îu«W±Pc#©\Z0\é¬\r0#\Ò\Õd#–­ø¤I\ê°4Lü”C°·•E×Š\ç‰Ÿ&–\æ(ıß·>+\ÔU·&¼šS.¦>\âniªeÁ\Ê}\ä\ò\æù\ğf¼Å½‚\è³Ôš]\Ô \Ö\ÜTh\õ¤¡	\æt4pIb*r\÷/e\Ö\È_Nµ7¦\ê!@)Ç«\ÏA\õÅ¼ot†\á¿\ËBhŸ§\ã´Kc†\ñU\Ù}“Œ(\öŒ\í’J:,0kĞ¥ƒ\ël\Ê\õ\ŞûQ \Ş$½B6\È\n)]k·¾ûÌ²I´\ÌJÙ­¡\Ën…B\ÙJ\\%{Ø„1=E6€’¥ap\èH\Ã3$’6Wh-P0\Ù4¦\Ë ­\'dZ‘p/­cÄ™\Ï)\0\Æ\ñhFk“\Ü*\àBp`%§²B™L\Æ\ö‹\ëÿŸ_”U\é\'`i`\İÁ\ôw‡\Ú3\Ö	Ÿ¾ƒBG§\å‡Cÿo{\å»I=}Õ«\ô\ó?\Ó\âW+SüÁxM\ö{a‡—­%\æ caÁ\ZjKs‡eÁVÿZâŒT„\âd\Ñ\ò\ÒJ~m	é¼…±g\î%\ö_v¥˜®H¯0m\×b\ìsb&F¦oC-ieL\÷\É5¼µº\ÅEI!1©G® \Ñ?•\Ğ\Ş˜¸«‚˜$t\×‹o\Úu˜(W‡µBØ ¨Aa×€³P¼Ù½<\Ş#Od.\÷\ô\ÕZ°0,¤¤5\íw\â|R_	>\èA0›¨‹´\rÃ‡Á¿\á&@b\Ê0@û\è‚.ÿ¯ü\ï\Úş4\rù\r¦ )	\'š@7z\ç\Â{•Æ¸%‘RNa2L!\Èš\Üß“‚0i¥†û\ñŞ±\õmP\İ\Ìe´O¡\'\Ù\ä?\Ê\n\èŠ\Ù\ôezƒ&T+1*ùE&24S\'%S‚f\Ï#¤Ÿ9\ØJo<`–dXÃ”:@”\ã‚\ã k…H ®X\÷oG\â\n.\ò²b­Dp©D\Ä*½¶Ot.Q\ö\n·vM„r\ìÀÜ ²Á\İwPvÅ £\Ûb\ò\õ‚ù|\à\õ\ë«²–?^ÿ(\í\õ§¡Ö…#½(…fƒ-•3şŸ\ÚYvAJGQS0\Å\ÑÌ¼sY\ì!ˆ\'k\ïd.)…*’µvÀ$¤¶·?b®°™\ê\Ä\Ñ\İ\"JP!A|£bPÇ¥\'P¨´¶\å€tE…\'-Á«#^FV\Ä\Ğp[¯)\è‘!xqzsc§üoD­\Õ\Õ\Ë\n3\ç­(\ãa\â²û`i´\ß\ğ½w¼\î¼\Øv‘\ÊE´´\rh€\ä\ğD\r¶Ò€]î«€\ãO+¡8\ëYLEø…@(m/\á*»ş\×Vú×€°\ÚC\áÌ”GØ•SÙ«…­Á+Zøl\àS„e·0³C~X\îD£f\Ó]Áb=H™<=Œ¤`\Ò\İ+&I\ßO\Ş8\Ñ\É&-’”\á\Í,®\Ğ\è\Äd\Ê&ty‹•Rªù¿Qs“\öv\Ó4šƒH³\ã\n•\ÒdÒ‡Jsu¯WM[$Bt\Ë\Õ\×q\é\×\ÛiEr¶;o²„L2 Ÿ¼ı\êÒ„\Ù=\Å$\ô+ 4h\0zı<¹ûR{[\ÛÇ H\à\Õ_…¹ü\ó\ô}(N}\äe #1-PÑµZºÒ¨Y\"T8]\nûÏ …\nŒ	(h m…bYcfe\ákØ•³\\PK@\á\Ùİ¹)N\öEU1¸šÁAî¢¾ë¬°\ñ\íoTk\ËW¹\Ö}Qn†ŒH”A\É\Ü\"\Zsk—yP@q\ßº\Ğ3¢X„oº\0¹4\ì\ñll¥\æ!\È%§)O:J£9©\í°W²¨…c,e5[¢É»%1$¤gp\0Qµ’›i\\h\0K\ò€M·F—S\'»„…Mú¶\ín–L\é  \ÅTv‹¢<\Õ\à:>0‹`3r\ï(HJ@W8\èfu\â&2¾\ÛÍŸ\Å\÷ °ÿ”]É¾‡¦†\÷ù?}¢²Ã³(dşA\ßy\Óq\ïsøYÔ“am¸\÷ŠMY}\Z’}M\õ¾fI_=D\ÂFcq¾\àŒ¦\Z®`±‚\ì%º<ÿ	4\çL¯/5i\Ğ\èmj0\ÙWL?x\ó¢b³“Y\èF4¤B<\ñ\ìÿ\'\æo12\î\æ/Å´\ÏAvOŒ‹ùš©\ÊùDtc%¯\\~UD\æQTcL‰!/ox#a˜A\'b\êÓƒ\õ—œ»\É/+D)[T„„\Ä\Ú=\óÀ\rƒ¿¦„\Ø\Ü\ÈS\Åo\ğprH\×\î|¤\0‚7(‡P\é\\?bAÃ®pb{<\È\ß<Á¬,bG×™\Ş\ğ\nPtj\Ï¿˜}-\Û–Zˆ\Ü*ü0\ôAZ\ì¡!„CÕ´@\õ‚;úuĞû9Ÿlh€Ñ–\ëb‡HDT;ˆ\Z\Í6²\ÚÌ²ª„c›À.¦~2L\n\öS´„\Ù0\ç\01ƒæ¦œ\Ìt—AûCÈ´ ™	úK˜!–\â\óÍ—œm8<\è;	†aÀÁ™p*€vR\ãşc§[\rû„\å4uSqn+6H˜\ÑfÆ¬Â 3µ\Ä\Ñ6\Å\âU9\Ø\õ\âB+\É‘@yfŠi™¬\'¬\Ï\æ\Û\İ\÷\ğ>/ºF`7”M\ä,T]\06U\ĞÕŸ†á‚²\rONjøƒ\é\á!\Û\÷\îê‘‚\"ƒq+\È=J8„\År‚\ÊN\"…\åŠisµ%fk )Š0L,Q©Ş“™\Ó\ÄzI¿\ä\ÚÀ\ÅGf#\ß1y×¬«6º+KLËŒ­#\'œ\ç\n²¨\"\Z[\n\"Á]\\I\ëŸ\âE\åp­Gv\n‡Z\èŸ­ùv\Â,.\r¬Å‹b\í¤7k­@5D±jX¥\î‘Ñ±Á—À\ç\r¾\n¨\Z ,23D¯%–PÏ‘\êV\ì\ô,¦\\6\ÌIş (\'šVS<¦¦\Î7ŸƒGƒùˆŸ\ÜmV\È}b· o\î\áG	Œ\ê!\ì\ğÀÁH\0( \å®X@\î~\÷ YúI™9 \é\Ø4w¬C	U‚2©˜+\ç\ÑÒi‰\"C©#(\0‡\Ï\Åº\ì\â8:5Iı\ê|\é*T\İøİ¯Q>ü\rš\ñ=\ÌxG{\Øy5›\Ã\'\Ğ!yJ\\Išm\éDÄ’›PXpRFh\Å#_\å\ê/ò”¡t]µ\Ë\Ëtc€1\Ì\0!l\õ6—½\Ô`Í²kø\\\Ô\ÚzP9)/Ö˜`9\î±]ˆP\áF€C*°\éon-—)%Ri™IWÖ‰8³Ğ“\ä\Ú{\Ê…0\ö!M«Ç¬}€\Æ:$,\Ìn€…c\ë\Û(D\ÎCk¹k´‘\È[	e˜jVQ\ê_	ù^\Ï\Ç\ï²\ôr\Äşo§˜\È\Ú@M\Ñ\'¹j\ğ±M%^L]…	9¡Bj\ä\ÈŞ¬\ç„L\à\n¶=‰‚A‚¢\Ñ\Ã\Ô‰­\ä\à;\'\êı§<± f(h\"(`>`	øYp\Ì]A\"\Ç@BOº£\Ü28…\ğ	¼Tˆ\çœDn  \ö#A@°p½r\0Ñ¤á«‹2\Ô]G¤©wR\ô\n{]\×…\Ã\ÄNYtšh>¤Àf\Ø\Ã\İ1ƒ¸ƒ\ó<¢O¥•´¾X\ÒbG½/6~ø\â/‹œ\Ş3\÷ş\ÉU®OÂ˜VØ¢µ7ˆİ°¾\ö´md}û§¡ùŸı\Ø+\Í>ª\ØK¦\ÜK\äSk\çS<X\ï\ÎD¹ˆ›¾º¡’-\ó\É\\À¬		TlÚŸ¬¬\0­°:×ƒ\n	til8„Å®$Ú‘*²‚ \Ë\í¨6E©	hÌµ%\æcq\ËA\ÊzWk/Q‰1\ç\\j\Zum!Œ´T«\Ãh*ÀT¡±\óİ¼AÆ€!\"šˆ\ìŒ\âb4+\Üx#Ï¯rnƒ¯ù¯}Ã·¡$\ì~±£O¡–\âx1\å |\óÿ\İh\Ø@\Ìd¼§ú\n€\ÇRYi™³²Â®l=¥x³\Ò\0i§7’\ó€º4\İ(—Q“UI=I\òİ1\Zù\\0û(F\òlŒ\í¤—û_y\ö\'I	#tµ…Ï¤}\Û\îL{;y\Â\Î\rQU,\÷¬«Yr¦İ¦ub±=†\×UÈ²&°* ¤P)[\'\Ö:G\ï\ÍPAl®X\Ø¯t\nq©mbBl‡ƒ§}A\Ìr\ß\î>\õÙ•>ºúaB¼qƒ˜>½ø5+\Ã\î¸?\ÉE\Üb;`c$zøˆ\Û\Å>±J‹X6	\ïµ€\å\Èÿ;^8Ç¦\È‚üœ#»92L0\Är	¾ÌˆÒ”e!\Å\ÏVæ€¨\ô\æÀ\Û2\Ùg‰\ÍXs[²5Y\É<Í²n\re\Êş³\é„ÈŠ\0\ö¢˜ˆ\ö\õ™FJR‘Œ-cœ\ËjÆ´ˆ°\"F\ÆuPdù µx7\Û\Ävµ‘µ?¥-¥¸šv„„B\Ì°\Ü@ŒtFZ\ë]‚+u<\ëß‘PK\É	„#X„DŠCP%8.¸=k\ÖYI\Ú.¦\\¸P\"%\òb:Z\ìk®\ò\ÕWZRk2İ‚¶\nd*Â¹e©G/\Üv„\n„\È	–\ì\Öir\ô–i\Ñ^†\Ñ\ÚCŠ\È\Ïe\É(#Á\èazE[8n‚/¢—ÿ¾}¶ªNºÒª2%œ”\à\äa¼N§$HA\â`\æ\Ä	\r\ÅÈ§X`‡®\ç¹E˜º`ºq<…OZŒe\Ì®À™lmB¤OŸbJj’Á\ÃX4K\ö¦†U6+\èE!{\á,\Û\ÚjÃ†&N¸`€#—±} œ0º€†qÁ…h\Æ\Ğ¦–\È×† `€£1±@\"\Ñ&@G0…˜ ¥O\\\ó(Í—¸:K!ˆäˆ‹\É]X_Oiy£0s\ê¹P\ÙNED\ÔS#LH\n¹¬9Tndu5ˆzµ®|®‘\ÒvY–\î\å\÷U Q­^ZœÁX°¦§´¤, Gy\éV\ó”H7wx5ÅšÓL¤«\ğ59H\Õ	Fw©,{²\Â.¦O²È™4‰’j`=\ã\r¹;H|\\N\ÑM9KJ\rxux+q¤\Öi\ğ’^<:ÁD?¬^›¾U›©—H\Ş\0\ŞÀ\ò!•U\Är\ğ$\ò^’\×\ÅC\rÁ´7“M\ËDX\öúO@§ø”Ò›\às[©\ÛoJœSd1\Õl]–\İ7\îJW¿\÷dÂˆ:l\Õ#bgM\Ù\Î!WHŸB\'/®D\â\àQÕ B‚š\à0\óŠ\Ú\ÑY\Ü6¹<ƒ«š\ÍHÜ’.›5\àH²R]\ä‹\ğ\n\Ç°Š½™5E$6V\é_\ã¾\0Iƒ\"Éœ“ÆƒÇ’†D\Ø\ê\"×”[hd§v©ˆ\Ä|Ï²”N\å\ğn½¨e3n\×Á4+\èB¬\Õ\Å)#\Æ\ÅX\é<33|ººŠ/«`o\Ï?İ¸;z\Ç\â]¶biT ¬Ğ±/$œz?—hJ\Å4J@G¦¼wN{Û„ƒbP°¾„µ\r\Ó	Ø’Ó¼\İ\\\ò[¡\ë,€‘\r\Ê(G?°”HdbJ\á}°$0N\Ã\Òdpm€%¹N\ó\È»!,šÑ•4f Par€u}Orš4,—n\ëøı]\Ä3@&QP£<7—”B$¿ƒ4L\áL>9MP3)\"\Ã`±J\õo¹£%w”Qe< REU\r¡!²\Ã\á\÷5+˜\0U0•±ÀO˜	dXA\àŠD0 TX²§\Ó9\îk‹Š3.\Å‰f[7`?\É.W\í~\î†ü%ˆ1\é\r,0SXûK ¢\":²€KG¤O«œ–BZ¨µ­Ù¾>‹\"\êW\Úq`Mt€Ì®\çz0¢X£Tš€\Ğc\ç\ì\ñKCÚƒ·Bšs\Õx\Õx¦Ê»\ÊÁ:aÉ‚µª¯2Å‘\ô°†Fz¦Ñ˜\Ù\Í®ˆZDhŸ\êZyi4\"B\ZC(k¿NE´DV	\Ä\\¤\Ë\ã§\í)‘—2qCÓ§HÑ¹\Ñ>:•\Ëè’’®“¯1iB\Ş\òˆhœp·$‹)\í\Z<Om•ÿ(“\Ğd\ß\ZL¤t²u°üq\ÚQ\ô-¨ÿ;\Û$\Ø5 -\èeˆD£½&J\ïÀ\ìÄŒdŸlP\ØHÚºgƒ\Ä%„eVECsİ„‚C\ài¯­Ú¥\ä%j\ß\È\Ûu]º¹T\Z~Cº\Ú\Ğ\0\\\áw®MŒ?1J 1ˆu\ĞIØ¢$D‰\Êc$\éb\èU4´,} x,\ÇãµY. \ÍV\Îe\ÒSS\Åj¤=˜z\Ø\å !`•é\"n\ò3Ï“]-d\ÜvR€-œ¸@ –\ñ`9O©„±\Ç\ëj\Æ2\ÌD^¢‘EŒ¬?\õ\'„…¹¹ ’\ÔJ’*T(‡[ûT$ø›Û´\á‘c\î*Ü…~`üg\"\Z\íÔªrNclMˆ\Å\â\'”‚#cU\÷‚¢¨;\àú®.˜\Ìi„\Z/]°(P\êI`­E)\Ë7L»\n;º³ƒ\Õ5{´–T)Ñ„h\éU6\à(#5´¢)3=)œ\Ñ3’7‰\îƒ\'\Óp½â¨®\Z v1\åş‰‡0«ht\ÓW\Ğ\÷@Š‰üw\Ò4˜c3²ÜwI{¤ûÿ¿³a(³4	T\'ro(}%M5\ïúûp3\ß\Åf°‡¹·\ğ¢¼\ÏB)i×‚Í®Ø\ê$\ïRNƒ\ñ¤E …\ëNd8P\ß\rqM¤DŸ¿\ì\ñ¼ŠQ\é\ğ\Ì\È$ø\÷ú\Ì\ç¡ \'‡Yp½gşŒ6A 5 \\U\é¥n\'\İ\ë˜\ğ\ö\Ñkù6¯\ã\÷¯Ü™\ã\÷)ıœtX\àj\é\'\å\Îf\Í\Ğÿ¶³´”MJ6D;\01¼d\04¬Mœ\å\ò‰ı„½R”ÿ3\ò’`(¨Œw0ƒªzy&?\"šj‘K\ì\å4‹˜\Ò\ê\ç­\ÚK\Ô&Ÿ\Ä\Z1”¦@Ş´AŠ91a\÷¶c%ƒ•«Q\ÃK\r\õ\äK£7–F?SŒ¦)dSÿ\ï+\Öm´6\ğ$\ÆØ±\Ü>ø«8´+Ê°]s\"_·\rœ\Zr±‰n§È†”\÷\ó\ó¯D[e\ËH\ö\è\Èn	œA\nºn)	\ô¡\Ù\ÉSAŒNµ—²D´ÀW4Œ	“H“D“…i	[p\Ù\ç­‰ˆh1\Å_C$D!\ñ¯\äwEªUdd\0G\ëœ\Èu\Õ#\Ä\ÓL;)a\Zm¤+$¸ù· x§,‰`:\Âf»ª\é|’=¨h¡”;f?‘:‹ûlwf5Õ¥l¸\0ûº\Ó\ìh\Ò\õd\Üt\ë\íˆ3¹ø‹?†|{\è\ŞKÙ±˜¶\äZE\ãbşv\'s\ò\r@¥9$«0H@€=s@U\ò¹’Œ39¶\Ä\r\â)$‘Ô§ I©\0T\r—$\÷\r5NPAüR{\n\í7\İ\å\ßù1\ìaq\Ù\á\Ú\ï\Îø\êm·y\ğ\Ê\à€\n\ÙbZ\Ä/RA\ãMn°ÀGRZl\ä(Ac\äĞ¬ \åş\ğ\Ú\÷`ŒL\rD\àa!±\è8Œ9¸Ìˆ9e¡RA-H•1ƒ­\Ô&ş\÷úG\Ãhe\ô\éšhµ62œ\Ş6¬,n\'ES¦—ˆŠ·€\Ä`\×RG‘B\0³Da@G\Ğ2U…\ôP„ƒZƒ|l”R–m=‡\ÚX\rkµ\Ê\ÍBV²2³\Şr\àh\ä²R\"\\Ck»›\ÒiL\í·{g7PD&T\Å\éÀX L1z‹h’=\äøXo\ÕN\Û\Å\ğ\Ã`š3€X\ô ;cY\å(s·¾ûÿû\Ì\ÎZÿp7\òŸ¥\ï-\'ˆ1Š\r²‘8@´`Ÿİƒ\ò!Ct²\áÿk€\èf\n\Õ·»\÷£#üÎºF–F¸Œ¬Bºşd;vt[º%«\Ë\ò+¬İ‡/EÁ,‹vvŸı©\ò\ŞN\Ê(\Çú1†J5‚Ä\Ú\à\Ü R\Õ=‰\Úk’{\ß\Útr.\ŞIëš²¼³Ï® dBAşªŠpµ\ØÍ¨ _\ï©\â±\\\êpv¡i\Ñ²\Ê*=¶p\ñ\ÏŞ¶DŸ2)\Å>\ö	\÷¡\n[ƒL \æ¨¨$c@\è\ÔSß²&+@\Ê|I\×\Ì\Z, ¹dNŠ\ñ|B†Wª\í…N€²=-\Ö\ÅO\ÖMp=œ<\ÜgiWU”#\í «\ç\r¬`\nb‰q\â`\äÜ¶(\Çf…ik\n‘ÃµŒŸ( \Æ\ZS#\Ü:[\ï…{@/\ó·!¢=~JNd¾X{OºMv¹Š“\áº@¹D)n\ëD4€E–¥eA[‚…\ß!]¥\òz\ìj9Z\\|\Ù:\å\Æhq\Ç?lJ\å«u@â‚¾”b\'‘0«r‡—,¹\èb\n>…\Ôp[t†e€db¢HR±…‘ ıu\Zd0SO›‡\æv„y¥¥R$:À*:\ï\Î$³Ù†Zy`—½øqÛ‡E¨ù\Ü=… J“\Ó4 \Ãj&\Ú{ù(\Æ\ne\ÍÂœn\÷F–*eØš¤	=¬\ÄV)øÅº¦ L\àwp¦M:\İí…-\äÓ…‡\Ğ\É)l\ÅYp\nª‘\æÚ·\÷\Ş*¡…¨[zÃ‡‡ø–\ìEtF«\Ï4\Ş\Ä[\É\õ\Æl‡{€>\Êx\Õ˜\åd\ì\ë“]fùœIPE0\ÆÔ®s\Úo\'k\Ä\0\rµv\Ò\Ö\r\'O;‚ûå†ºùP(&\Ö\Övø#d\âbE-\õ\\\Ú0‘\ÑMJpEPË¥İ\Õ\ôBÀ‰¬lx=VŠ˜\ó¾b\ß:1@\Å\Â\"µ\Û(\Å\Ø»´!‰v¡‰\ÃÁ\Èe-Pt\Ö\Õş\ğ—ÿ>\'2X\\;\Z,Ê…\Ä\ï`†™\ÚMÊ˜\Â,‡/®w]¬ º»:b\â\ÕSKo\ò—	«eO\Â\"¶‹\è…Z\Ôc\Ê\æ¢	Ê…ŒTVfa\Üd0d\ÑHj¤‚°\îdlQ\ôerc\Êy¿\ÅÓ¢¢¾„\è<0µb†‚\n\åº‘˜K8\0†Ø›¤YÉ±°\ÇL\í«n\ÊNf5|sZ²l¨\'\Ê0Y¿R\è2\÷\Ê\Øf5sH·\Üa6\ì»”M@ 5›\Øl\åN#«y\ZŒ¥,\ÒÁK]‡E+A\á\'}C5I\Ô\è¾g8¹Æ£\'.a­~Pm7c\Ê\Åm\Ûn\×7»TH\õE\ér~«\Ë\òL—«Cu¹\n\ã™s\ÆS\nß€“%‹JFr\Ëys271¦¡û¦°¯Î–ü”¢ˆ)\É\0k\ë\ÅR\ZB\\$šf¥I\ÑTƒH\Z+ƒ\rŒ\0¤j+\í\Æ® \Å@)V˜9š©©Z\nP³JªF\0ƒ¹UùWCsYJGa8,W9:ÀX\×E\r¦©‹YnCk¿˜ZbsK[L1\ã“\ÖcºË›f,\íF\Ü\Ê\÷º¸ei5=¬Š+\\„GF	Sae‹ „‰\ä\ÅA¿§KP0Ë—l¸‘\Ûr­ «°\â/\ä¡Ø˜U{\æ:7\è;U\Å2wr7‘£\à…FQ]ø¹\\‚·À\Ë\Ò\ĞŞ˜š\Å\÷ˆ*)¹¤_.\Ï(«U_\ÃÅüQ\ä	\ÑV\×³üÊªœ¸:E±“\õ\å{±\Ğ%I\ÕFø\ÉjQ/`,r\öœÀ*ül\Çı\ì \Ò,\ß³#şrB—¹5	¤y=½)—z\ò‡rœŒY	w \ÍÁ\óRp\Z¤aš/ub“	yQP\\\Öi¾ \Ï\\¢h¡rCmw¶\ğ°±\Ñ\Ìc·Ó”.?†C\â.I{0Á¾7\Ö\Ó\ê 0_U–)\"¯ø™l(\óP8Ÿ¼XI4J‘D°\Ê\"€T\éc§{\çAü\Ö$I¶@°\ÂVAX.`J¨\â£|2JùqB\Ê\" s\nF0,Q\óK©Gø\ns]QL1\ÎŸdû\à…J!‡26ÀByAºZJE¢>^\äÁB\Î Bäª\Î\npù\ñM\'\È\ß\"H\ß\â‚*\Z:\ÑQ­qm!x‡\Øjd-sü³&!‹•O•ÁøV\Ì?G\Ôr9\Z|¨‹%­eY\n` ^A„…U \ËÂ¨\İ\Z^¿=s°/[e]º_#l°U\õ1œ¤EO?º\áš${‚\è^@O5U\"\à0·X€<p\êÂ²˜\Ò‘:C\à	E¿\ó\0¯6+’¯¶`B€\×N\à>\Ò¦Â±‚\Ğ(:1\0\n\à&P J\öpz\áhQ“\ÇIÕ \Ñq\ZP\Ğ\÷\'™T…«6Nf»ª\Ù4lhÀ!,TÎ„«ø\èe«u¡«kR£*\õ7g%±š¸.¢Ö°Î®¬ZÊ¯‘CQŸD}‚h\ëŒ°{¾ÿ\Ó\â—d¡{ÊŸ¥D!ª/C\ÂnÒ ¡\Ã¶\Ö\ÍdW“Ş¾æ•ˆ°š\ß\Z\×\Ä\Å\Êÿlª\ë\Ü\ËP\ĞR;\Ã\ÎØ„‚\'ªF\È@”c3C…©\Ä~\ÂÀ\\(<8‹¿*¨…\\\ïfƒ\ÅÁ\îÍ»GE\ôN\Ï<\ó¨\"\Z\î™¸ú\ÇU\ä\Å2£QªX\ğ7ş>\é\æp´-D3°\ë\0MÕ‚\î\Ò\ærfd—n‹\Î¢nxø¾Ò¼\Ò-¨j\ñ\Ş1	´e,Í\àˆ\"ˆ`j´R!\ğt;n®´¡Ò“¥\à\Ér\ÄÌŒ 8m\ä7\äv–@a+\ÄRBXÅ¢ H\è£(\Âp\Ø\ÈÑ˜È»3‹)·”“€z•A\ç¤I ;ˆ3\"\Ó€ 7“EŒQ\İ|r\è\İPP`r\è<J\î\Öti\Ä$`¤\äT§\n „Œ”+\ÈfR¦»“†\Ä˜’)…\è‡\\ÿ^w\ô“r1u+9„ŸM\ô¢¿~†M\Î\Â\È<\åbĞ•]¸\Ò`@\õ­|*\æ{=Om.CÁ-¼+cV+š‹\ÑRh½\Û›\ô\æ\ì–o^0°¹üWÿ3²\nPxœ±œ^w€\ß\Ï,( \ö \ïĞˆ¦\\\ñPUVú-\Å\ÍZ±8Xä¨„)‡•”Q\çz\ì<\È\"@…Œ]‚^T\î	\ñ)†Õ’\Z\å\Òw\ö§ë® \âOr‡eª\ÅU\Ï\Í3„5\æ\ÖV\ç&D\ì\ÍR‰Œ—š\éM,uû\äZ°\Ã\0·½‡Ë•‡•©Cú\Â\êC\Ø‹Ó™\Ò]+,Œ2Z\÷U\å\÷šri4¦µ€\é©hFÍ›ojtbPQ´\Ër>0ÀµzÑÁh!2\ÓCş.]‚•G>¿6Gù\ÎG\Ô\öÆ”\Ù\Ì:–1ú+>\ö\îxGl€\İÀzF!7\ò\ÇK~ÿ\á$\0°QCm\Ã\×\ä( Ÿà¥•±‹~şV\ÈÁi ›\ép  ­\Ç7µ\Ô‚P-r¢Z,\ò\ô‘\Ã1XĞ“,x-\ó—\á—.¯ÜŸ\Ã×¯\ëd¼Ù¶\í	™n’\ÏÉŸ¾Í“©r\\yû\\¿\ô¨’\ĞgzŞ‡\Ó\ÒB\'z<ıÓ¸S¨¨ıĞ¨4aš15“v›º\åQ‰ƒ…w;/\ÙB\í\Ì\ã\Éa¿\ÂR8’\å–)vR¥§\é\\\'`k´şz\ã\ä\r\÷\rL@‚…\0F¨¸/±^jû–JtHr1¼\Ñcu\âü¸cš‹.Nw<<j\è\Ë4fx\æC&‘gk–\êr;Ü rvšY¨\0–g\á\èq²n¹y’­\İ:\Û\ó0/\ò·øQ`j¨E‰DH¤Ÿkz¤	k\ÖDºJ<\İ!G@\áy\å\Ğ®\È\Ù\ÛVµÀ600@°+G.dP\Ö\ÄvA@ŒFª$p\n\Ò7§\Ê!“\á~®i\n4€Å”û\ÎVG\Î&´  ,°oS\ï=e_“y±\Ø\r\õ9»½š\òj\Ñ,‰\' \Ğ|?h\0)\ZÀ½ºa\\\ÔQ\êY3ş¸‰\ë\ÑY&-0?:Ó°+Ğº=¢1o®\0!„\Èz2C% \ÓAµª€\÷\ë\äo´\ê^¹ø£°\Ğ\Ø\íF\ç\á\Êa\İ@\ô}\\¨;\ã¯Kb¶Z_›\ŞFq±ü›1i€Lª<i-l2\n7\ËB\'ºMB„\É\'\n=ƒfy=¬ùNH\Ş²‚°¢¼\ã\Ê‹³V\õÁùİ—Ÿ!¸\â‘-µ\í¢1Ö„X4\ö\ÓYˆt*£]4&€\â³h!–«h\Ç[Rû›)u“	;; .\ÚSMÁ&\ìX…b7#­—”³¢©[‡GÀ\ÅJ¼C„¬¦…hå¢\\#ƒ^#`Š\"w@\r)\Ø„S{ —\Ú^¾›po/\ÒrÀ³¬Á§«b”²³Š{`ŠZT\ä\ÍŞ B¶RM?‰g\íf\ó\éB\à_Sœº6F\n‚/\ïAø#Ku8\Ä>C­›””d¢†\Ğ|Ğ˜€»>u` \ÖWS\ÂkxˆœH&Z‹\öp\Î\ì\å²O\'Ãµ\ÎF4·k6‚W\î·gº]Àpn?\ñƒv‚lR¹\Ïh\ò‹›Õ¬»–\İ;\×zg—”j§\İ(Ì\É\n³\"C‹ü¨5\ÇX0}0@/ZÑ¨-ˆt\'A\ñNÄŒ6ş=¸§M8ºe\Ç YA-Tßœ\Å\\Ÿ¤%©†\å¹\Ã\æj…Sw\Ñ\Ê\âÀ°Â«F9“r_*\ö98i}z 2(5…V\É\ï\Ê\rµ‹†,ùŞ°\çv:#L“ä€ÿSjš„FtF¶ÿh–#³\å\æ\å\ØÛ»§0A˜$˜*:û*¨®I5‘»Hb[\÷‹C\\ˆ\ÑZ\Ú+=°\Ù{\Î\Ï}‡w{K\ô‰}W\Êº.uj/\ÄPECEnEQ¶±•r0*Ì¾[\èHkÁã€…\ãÈ€A\Z®CS2\ï~€/d°6˜=¦S³jº:\Ğ,JY©\ÓĞ–jDs‚\è€\Úp\à\×ÂŒR\ò£p]\İ\Ó]—®O(-=M¬\Æ\í\Âbl\Í=\Â,•U´.\ìl2\í·’\ÌF.\'\çf\õ+µ	V$,¦˜¡@p\è!“/l\ñ\Ï\Ó\Ù\ê\ï‡]Á™e•³\Ò>Á\æÍ®Ÿ~\Î\ö‚d”2IA¤\î^\òh±A§[ÿ`m4]®ÿ%ûh‘‡2„\ÆYJm\Ó?\ÆÒ¹:‰M2)\È\Ûs´GF|ˆ\\\0\äj\Ì\á ’\äznkP5P€\òe\İg;\Şı\ô™\÷6\×Ø½T¼…³n W¢“Y|\îv\Ü\r‹X\Ó\ñ\íX“*Zş6\ëR×¶\ó7\â¦\Ò\ëx!\Ò¼C+\ñ´\ğMj·sŠrzjB,:	‰¶t\Ø{z	ic\Ã\áŠ=PH\ÎX\õˆƒh0øÿ„°m\ß1‰\Z^)VÁ­9·\ërg\n{\0­L µ—»6j,‘N¦\rF¬¸-Rg)S\ñ\Ó»ü“†)\Ô]\æ\\\Ôü§?YX<şM;¹Ø¤[ƒ•DB]iW«cı×‘˜	§\î2>;±!^-´ƒ®p\ğ\È$\Ú615-\ĞÃ¯z ¡\Ö8b‹%$ºšˆÁI\r\Â–˜­q¹Ä•P\Ø0F\ì\ë°QJ‚€\ì@%(B\"$Š\êO\é‹¨\0S\òfƒK¡\èI†^\Ø5\ğ\âœ.H\Î\ã\"D\ä!\ô>zI\çª\Ã8†$\Ì*\å\êªD\İ\Ü\Ò$k\Õ\Ï\é*:_\ÙxÕ\óG*® \Å\ÑJJ,&¤d‚—vH\èu¼\Ú	$LÀ°\n\×gÁ}‚˜\Äú	ª\ô€B­d\'%ŞMûŸDİ®¼YÀÍ´…_\í>\Ãn‹l—¦f7œ¯\à›Ÿ²\ìv‚%<\Í\Ğ½\ñdº\Êû\ï\ë“\ï]ı\'şw\Õnj\ĞX›tp„\÷\à/\àt\Ã*\÷\Ò\0°\è ·`H•\çú<ƒuú\"ª3³”p\Â\ÒPl\ìÊ\Ä\Âj€\Ä|±¤p1Áb±X|\Öf[ø™^‘D¼W]3}\ál?¼\öspa8#TvPBaîŠ¢Hsµÿ¬\â*¹‹\r\n\ÜÖŠ\ñ\õ	\'fS<2\Ì \İ\"j\õ‘úaVm\ÂDmj¶\Ç\ğ\'m¹~±\Ë-„Á&¨C1ZšP*´\İ\ğ¹Fr\ì®2¹|<\ë¥m\÷¼,a\'€¨\n\Õ\á7…2U‰Bq\ZbM&§ø¯\ÆI‘%×‰\ë\è\"Å¢P‹)yÕˆ\ê~À¡ia\Â\ÖÍ†$4H\"˜3]\ğ<u\ô²‡,2\n¢\ät5\Ô\ò)œoù´SN\İM{®¡-ŸÂ‘\ô²H©¤³\Ë@€’\ô\õSØ¬\Ó|>‹\n\ğ\Z\Ìa\âL:K\"­˜&G’§U\ï‚2Û¸4Iù‘\Øk\Ê\Ê[d\Ôj\É\ÓR\è\äeEz! \Ó»\Ü\×ÿ3\Ú\r|\ÜHRE\Z†CO,¨–„t€¥¼~\öºˆ,@ˆ\Ô(À`„Á\ö\î~\å†`d\\@t¼‹\ò0\Ø3	aıTµ‘\å·°\î$ˆ‘4(Ô‡\ZÆ¯%Z]$›Ì˜\ñ\õ›\ÙZ†a\âe\'E$E\Ù©(%™\Î6\ç\Ü:H\rµc8=À\Ö\Ô\ğDaN%@sB¨kV\åQÁeCd…g}´u]uk+ù\Æ\â*eÀÒƒ\Ä\êO§Jv¡#\å³\ÍÁp\ì\Ú\÷oa”\0S©\ônÓ†ŠY@´O·ÿœ\Ì\æ-AÓ”\ñGx\n92¦Zz%g¦\ÙÅ®0\Ğ1ÚŠ©0DJš¿~\æ\ÚN>T-\öH‰\ì\÷\ßGu4e)QIœ«	 …Ë…}¯ú/‰2iXf\Ğ%y\è(OÀ+¦q\ñŠ>Ç—‚€Õ‚„‡#\ÎUISH%^\óıxoPud\ôÿ«*©\Z°!*#u¥£ÁN\î‹¥\ì0NV	x€U*\ê¿—6Ê­\ç\Ğ.Nú\rÖ…‡¤\n@\İMlØ«C\ö—”Zp\Ç\'\ÛT-\ä¼ŠAf¬«v¦ŠP£e¸³2…2­\Ø#¼¥R¨\ô$K­+ĞµgƒˆEú·l\Èo\ö¹Õ³\ã_-…W&¯€\ÃÁº°Xˆ\Ã\Ã\0±½\Î\"{“\çY-\ÄMµ°\Â\ä8\èá”¬´°5\Å+’CRz\Ç\ÈŞ›\Öz\Ô`Jƒ\Ú\Ì¥¢\ÉÔµÈ¥\Å^€T71À\Ş\Ò9E\è1¸¡[qlÛ‰r\ÙVp\Z\Z\'v`\Ö&Ÿb\ëA-¥”M;]UÊ²•r\àC^%H²€¢Ö 7\Èı»\õ#\õ—X@\ğ©\Åo^%us\ÂsbP2Š€Ã¿\à©›¸¸fG\×	$(˜ß¤<\Ü\Ç\ó §\éW¸D\î\\$j\Ş\ï\×iÂ„cÉœ	GJ;Ê¯“VN\Ìÿ]\èg;ø[d˜³\0\Õa\nq&W†¢3`6pSûkV I\"¥@\à\"Hš€	µ;\Ú\èš7:mP\÷ cB@3l\à;®‡	X° 	‚ş\ÉÎ¼]E‹r\Å\Ê~\æ˜l¶\'Gd¬]\Í:–<‹ Á\Ù\Ì:0E,.¦\ê\í²‘d¸–(\É\Ôı\\	\óa\×ÀD±¨\æJ\ÙK\'“\ç=\ÏI­\rX]\Z[#K\÷\à©sz2eM¤\öi«W6/\Ì\Ñy\nÍ²)\ni\àÁ1j&(2BD\Ç!®Hn\ê\Â\òp@[i\éÁ-rŒ\ï‡Á–Z­\Õ~\Û^·¡\n\âv–/^ ‹°\ì$ˆNv\0+\í£+q\Ún\å2?I²œ½¼ÿ.(¯\Ô#”‹\ğ&¯’;\İ6\"‚/Sü\ò<™V/2ÿLº\÷z)‡5N\Ãfùü\0\â\Ã4(jÜ¿»@\0&@\ò5Ìœ\Æ\0|Ç“9Á±SúT\ô\Ô\ÍúA\å¿Š;øE„¾A\à_C	Án³4D)i@sº¤5[w\ïN6.\öù\è\Z¾‰šZÊ ¤\ãLYCH;\î`O ˜Á©	\"a\Ñ\ÄPûCO—Œ\äw¦ (2F¸\ôf[eeS\á\Ò\Ú\æpbQk›fxù‚\Éwl\ö¼bEˆ´ihD*gD±ú\Ö\rv\á@}\åu•t:`¨^{×¤RI4<QzC¢\Ã\Ò\Ö5\"f^¨ÉƒX6ÁÖºr¹‘\ÃaJÿbC¾€\ë‹ø\òl\"z«¡+²\ñüsù\ÆNYÁ¶\ã\ò&¡#\ZhW‘\n–ƒ„Ÿi\êƒ\Ü\ğT¥šB~\Âmı\Å\êQ RÇ¥µ¿‡0\n H\÷d}GA\Í\×\ï\å\Çs2\Ì/\Éc\ğ\ğü€Zˆ€\íb\n\Øpš\İ\å|§&]\È\ZJ\î|oa\Ê\ép·zFúœS˜IT7o~ \Õ\"PU\"n1}e°¨­\\\ö\ğ-™\÷\Üp\\T–-\åÛ\È	u“d%¹\n¤å“›?üI+&\Ñ0X5$\0œ”ûI$»‘`\ğşÁ\ëG\å§\Ã\ãø\Îÿ\ä\ğ¯û\ßF\Ü#d¬\Î\Ådm›²\"\Í+Æµ\Æ6¥º8Qn\Ö6\Ãü\êÉ‰miT¦\İ\ØC\\	+}J FE2û<-\ì\ê´›xˆcr4¨\ÍQ“²ú\à*Ó•2Äº{§Gu±´c’Œ”(9\Ëe\ö~~r\Ğú\ÄZ©m¼E\ç.İœâ»\ä)¹2\ÜW¡½œ·\õ’ª5Uú•F®:W\Û\ï‰ıÀ%\"‚°±* @0•€\Ä\ØhÆd[BÚ”2\ÚØ²*µy\İl\"\Å\r,Å•\rU¦¿=m\Õ\ìC\örû&\Â	¿\ÂGoŠ1L?\çû©G\ô\0uv1es—Kv”¬yd\Ï	\Ø\Â>!ù’K\"‘<]\ÜÉ:\ßl€P…I*\á—ï–Š¬Pp\Ö^Î½?¬~’)c‘2”\î¯­¼\í®¿ù–«\÷\ß\ÃnºLš\Ş:oD~¶6f\ÈT¸Z¸‘«…=O¢ \ñ\ê$—½QLIš!ü\Şg\Ê5] L¤’ıè®„Î¶$“\":\èŠ´\ì8\Í\Ñt‰bR”@¤×Œ\î*fPKˆ\0‡J¨H{¿\Âve\ö¡\æŒ+ú$!\Öï ³˜!Z²rD¬ÁHaHÍ¸H‚OL\Ö:,³#š·š!ƒ‰<ŠS\×\õHq1hQ–\æÉ!\ÖK­0…)­¥\æ¦,n\ÆRÜ‡\õ\ö±V:Y6‚†B\\eŒ<\Ø*S\n«¢J”\÷ÈŒY©‹şªƒ5 \è¢´F5p\ÔJF\ä/;g	rxˆ]\"4·K\æ¿1X“’…Q\0›‰U%\ñy[d<¾\åÆ”\É%Y\ç	\Â\Ò\Ã`=J*³Bv\ßOÁ\Ù×¼Z\æù \Äg\'¬úuY\ÖN¦<[\éş\Õ\í7t\á\å3BOp³›½…\Ê\ë0`\ï\ÃÀ3(¸\'«¿S6°¯Y}¦\ô¿\î’fasc,¤\ë²‰T\Ó\ÆAŒ\nj—¶€5\é¬a‚D3C1½@‚Yÿ\ê\æ<‚\Õ5\ÇFi“ˆ<\ö\ÆFR\ç_¾&fz\ãı\Ö\nb\ñA\Â‘€4…M³\ÈtU5\åq«WeTQ(Y\Ì\ê\Ã7\rrÁ‘02¹u\"F¹\å]‡­HŒ{4[y\Ø\ğ?çŒ©¤|\ì\n•R–|´6\öm\íV1›­1Mu„wØŒP\n¬ˆP”‹……kd\Z¬(µ)a[1°\ÄFWI+¤¼\Z¬Ip)\Ì+²kO›¯51‹”»\Ó_ı¹˜›\å\Öz¥Ty\ã!ø\ålEj	WÈ°x±4*B3\ä.Et‚$T£¢\rSQPıg\Ó2z\Æw{Á%,IÒ°À@v\æ\ZÁÏ\Ù\öç‹‡½ ùB\æS%°}ıO¿\ÌüŠlg‡+^\Èf#…O\öú\÷\Ä4p\õ!\å@§z-[/\Ãª\î¯B\ÑDÎ”{3i`ß„©\ĞN7‹}\"\ådš\ÔO^úHJ‡‡‚pÀ\ò–/œ\Ô\n6´Ë H]3\ë\ĞC\ğP	q³,.ú\æ\ÔB  °\"–\Ñm?.®\îÁ`ik#\ã²!0\Ó/Šu™]¬Ğ‘\êßƒ\È\\k¯b„½\Õt°†\\xÿ\ÓM-b½rl\ÖJ\×i\\P\Ìd\'‘ƒ3\å€baŸ£\Ú\Ó{–\"8±˜›³\ë!,#³b°Fë¢•pn\é^\ñ½€\æz\êC\Ì\ÒH k\Óä“°Ij¢·Õ‘¨V³@\Û\ÉN„§˜x\èEg-$“\óbAu\ì7£/‘aÇƒ\Ö\"¹\õ\óJW\ÃÁœ›a·*\Ğ}\äJ\ôºI<\î¬\è¶\"·7¦„G@%@šBXZ~“\å\Ñ#¬9$!P\ö´Oƒˆ®–ÀšB\î¨*’ù\Æ^‚•\å\Æ7dX€U\÷²\Ö\ÍÉºUn´|U\Â7\Ì_\ÓıqÇ¡\ğ´‰&íœŠfÉ©¢\ïlÀ\ë³Á´?/‹\r=g\é\ŞD©\nSE#6¦g$—I\ì\0@ •\âc6+øâŠ“?£Z\è©J€\ğ9…\ä(ı\İayM»19r’4[d9Z\ã+Š®«ø\Ó€™4ƒ\Í-\n”\Ñb§>Æ‘\î\Â\ò\'{–³\rkp~-\ÑüO!\Å&\Õ\à}‘’3qF!iºL#[\Ò+Ü€»Y\ój´@wA \Å?Et/¨ø«†=H #\Zûë•µ¼©¼|‡b€°ÀPl184°RÃˆ€\\;\\Ñ¦­<-CXP5\â\Ñ1q\áRDP„X+9\ä\Æ\éX\ğV\\\"Djş\ÊY\nEV:\Â:\î:\Ò«S\Òº9W—0UIdË™œ\ìU\àšƒxœpÑœ\Äy^-A€\ß\Ğ\"S#°\Z4§´§3F¸\n¿\Ê\ët\Ç\ê¾{º\ÈÚ»Mbr§½K\é=©@„N“é¼˜º!+C\É?û\ï‘\\\\\rDÙ»Àn’®ø/7G²Š\äf\Å}µ%A.e¤x‡1³[·\ç\ã \ã$!\à=‚\ğqş\Ş\õr·Q)ßi\ÖÆŸ\Í\'±\é’\0\å®0‘.8Jƒa9jb?=\òn\ğº’¬ü\Z³„Ë°\ÓP+‹|j8!„cù.¦°`c¥b@V «®qb\æ\',¸ˆ³\Í\á&.\Ó\Â°˜‰hNKf\Ä{û\Î\Ëø‘.{#:+Ì¡<Èµÿ³\æ&±\Ú\ÒUš\nÇ”!B­´A-\Ò,¥h#§/\Ó\ÔVŒ•M\è\n#\ä\àdzÔs!”\"2C…Î¥\æYF\÷\n)H\ät1’‚^¬\Ç[{Š[\ÒgLEhµ$Aå¹†©\äe\Í#…,(,\ÔM\Ò\ÒE¥g;#Õ€šü˜\ò°A3\nO—b’°ı\Ô\÷\æLA\Òt%—Á4j\r(K…+üX\î\ÂFL¶ŒÁ¦i‡\à?‘ì‹‘G3™„” \Ü\õ¿L†2ª}\Ò.\Âúˆ#Á¢* ‰XUÀ\ì\õ_„5K^\ñ\Ìj^\"¸·­¦œ\ã\ãmŞ£‹‚AG®Ûª4rs‰š,œC]\ïRh¥ªK…\ÅIED<I9¸\05UKı\õ6¨!\â†\Û\ê±)\ÆnCJ\Î\'h\Î3‰&v®\ö¢\Öz³]{f¾b\Â\Z5Á•>pX-4Ò›.ˆ¦ >ˆ›Ö³k1\Û;:L\ŞÁ\Ô4)dYØ„\Ë\"\Ú\Å\Ú\Í^h·\ã_aŒy˜\è\nHDÁAX\ğ\æ­:\rD\íœA+Ú§?9¬,|.û~‰ üù2çˆŸ\ë9\Z\î˜=\å\õJ|c\Êz:š\ğ&û^§½\ïùJ5XQc%’4“&X%\Ä!-AJ¢®t—\İ\îOß¢¹w\å\ÌI*¿mn\ô\òMû\à–É‹Wf¯\Æ7P\'Ñ’¾\×r­&ß$d£!¡û·/¯-–\İ]vø2Nü2´HQ‘\0¶3@\Ğ\Ë½\÷\\Z\õ \çø\'\Ğk\"r‰>Zù7Aş\Ï\n\ós@YFEŒb\n«\áÁB²cE¡\ÑI«Cm~ş‘Bu\ÌB\êXµ,+ÒzqN[¾Bg²[¥Â‚X—„ov\æ®9…}E\"‚\ÈZ“q0´Gbr…§˜Z”\ã\İ	T\á¹n\ÕXFZÛ¤«”‹p=\ÔF\Ä7\ö\rHM/ŠQzšH\ì4yK ¢\ì‰%\ÊIU,×˜\\l)ş%¥¿\òŒtL,\È\rƒ<\éÆ¡«Á.$€ú\Â\ñCm\ï’-}¯G<„ÁL>1A’“\Ş\Ã¨Y\åøS6\rZŠ%\è\×9†³\\SEİˆ„C\ÙË—L©‚ZgEª˜3Y“M \É\ÃW=\Å\õ\ğ·\ò˜\â\÷°\Ô~Š±Úˆ³\ğ…f\Â\î¥Â“\ávXtŒ\Í»\éO9\ÍTYÿ\ÓM¦&\âA\Ùk\\”\Ó!Šzx›8‚k1C¯8\×Fm\é<\Ø\çÁBÌ¸]S[?a¨7<¥&\Ø8	_:l¥YŠµ?®Û¨Û…\"\á9\Ú\Â\Ø)¨!\ö<E(\ÌÂ–/\÷˜r\ç\æxÛ§“.¯ºœY@#½\Õ\Û4°Æš—D·dH\ÆNq\ö\ö}œ mz\ÒZI\ë\"\Æ:È˜\\8\È!²\Ï-®€a\à¿?1Q ]\è`˜pG¬]q”(-\Zd@\Ó]\è\È\æ\0œJm\õ\\K\õlŒ^œK\r\ñ\â\0E\Ø\ÒÓ— ®¡P¡L\á7|\ì.\Ñ\r5*\'\É\Ê\Â…\ìÀ\ÓSQ®Št=…R¨\Èá¢’		›\Æ!„4H‰f<ƒ²Q¬™\"!¼\õÀŠß›)\ém\Óû\Zº>²P\0m‹Šº9À\Ö\È&K\Â#(Œ€‰—ÁEÀ(Œb¡§‰À½-b@[œè„‘U·cŠp@‚MNUu\ğp\êzU%f¬W‹\ó\Âk\0ú …q\á:,`Yƒ´6P‡Ø„.L/jCL K[M„Ho\ïKXyO·=”±\nÇ–pE\Å6²q½wK\è-\êÍµ<7\Ğ\Äù.—5a\r`‚ƒ>Éµm[™]©Û€&\Ö\"X]lµ[Ÿ˜h%•\n\ç\È\rÛ†kD	…	‚1K±¥\õÀG¹“r0E\õ@\\-+®YÁhû\Ô3(\Ş\çşd™#×“\â,À2¨X)…ˆ5y\ãZ\èH\n	…BšûIÿ\n/V\ñR\Ô$½H“˜Dx¢Õ„\Ø\ì.£X&\îj\ìšHƒÀ\äS\ÒVŠİ’œcfd¼\æÈyU¯mHË B\n\ó+~¶PZ· xuşÉ‰©´Kü™¥\á‰j¾\Ğûª¨Ô¥)A\Òk±ûmB´QTaN\æØ™}£¸hps‚’¼W\0+3hu|\Ùù\É\ÉK!SÅ•X\èU\íûdPu\âA\ìlš\ÇÆ°…8j³[…+˜…H\Ï\Ó9­’©vwÙˆ\â²&¬€V·xzÿC+\ØÚ³µ\Ë\îÀ\È\Û[\â\Ô:Q˜š¹j¨­6D\ZjNd€\\\Ë\ØA–RjÅ¼\Ø\ñ\ç¨\Õ\ærÁ\Zv,ù\Èl@\Ê\æRKú\é(£°±\Ñà¢ƒ³»\ì‰\åH¸˜B\ÜO–û‰,Š\ô\Z\õ£ˆÁ2‰¡\ëwPB\ÖW>b	‡5fa\éMV\\€‘P6°È¥°B·\Ë_\÷	:ì‡±\Ã*’DY@\Ò\0\ô”).‰1³@\Å*!<\ò@\Üÿ¿\ËbJ\î\ï\å&I\ÃG|\ôQ2 ÁÈ¬\İ|\rrLç½—\â“Z2¨\Æû\éz%\ô\é\õü\åÿ\"\ë\ïÿ—œb…¤i£\È)kMŠ”\Ô*‡k§–”0M¿·@‰\è\ÄhtPYIeiRŒU+RLœw\Õxâ•”@\öS\Ûe‡¶\ö\ğVN\ÄpoÂ•Bj\'¦š©`!\ËÇ§°–š@„´¨\ñŒ2¾h,\ÆY\ÑbY’8˜\È9\Å\àı?aO\á\âcÛ®¼L§\ö‘±\'n)ì¾¨¦Å•,6Ø\å£}\Ç\Ør‹³(Yq}\äx‹µ}Cw#¦\é‡\È\\\êı«\ç42\æjWD\\¤SJÕ²#Ê¹¾vv\õÿ\Í\Zsx/\çC1\æ(\åŸntƒgJb\âj²\0!ıKQºÒ»8R¶;ˆĞ±³\0	’° –B[0©cA#‰H\Ñ\0E£„Vn Â—\ô±º1%W\Ê\Ğz\Î%>\È\×EjI2§\×z\É*ÿ¥„´wÿj%Y\ò°8F¼ÿû?xy¿\ÉT•B4µ­©{,(o\Ì0G…­\ã08\Î|K]›ı\éQ5•«¹[?1´•‹\Û\ßú\ñj\ì\ğy2\Ú\å8+;¸\Ç\Ã\Ä\á[¹ah$š1\óÌ®H|–\ÈnB\×1H·~Â\Í}Š\ê]\ãV&\Æ@;K²À´prq¸¤\÷#Á`„”6\ËK8fSŠ0½…K‹\ïfÿ.â‚‰-MB…J¡WNV¢T& \Å-\ìM\õH\×\ób\ŞA4eGn\Ğ\Û?yu.¼!˜\İe­ r\à\äJ}Rûnn\êy¡‰Ü¶ı¤P`F\ò§S‚•bˆQ\İ\ZFŒ)‹\Õ0¢´S4`\ğBY£¢D®‚\ÎMGR–«mGy°64Ç©n4\åøVE3™‰q6—O¨ŠdV\Èø ¼3AJ\ğ\ç¿F\ì\íFZL½¯Ÿ\Ü\"4Ÿ+V}®HH/)\0Ó\äh\È\ãŒ/)\Í\ôl%@L\\\ßûª\â:\Õ\Æ\Ùœ\ZY&ŠT\å\Çi\ÉJrrY\Ñ\ç`\Ñu(^ÀI *%\Â\Ş\Ûyù$-/v¨¸M=·»EŞ¢M´C:s¨–m\ôÇ—\ö!-\äu¦À A Š£O\ÕZ\ã©,‘m¥™Æª°\Ò`\í\êB\ë0–`\Ê§a¤¦6›ª™¡®hÛ`­DHO—•aFJC\àŠgª3\î–`bÄ»\0¨¬o\Ë\Æ:¥Œ\ç\ğ·ÌºYx_h‘\Æ\n\óQsS¢ —_\ä\n i/§9†\Âj•u˜!š\é0U\Û}€‰]\Æ\Ô\ÍJ\æG\ÑTs\È2­nŠEH´	5z†\Äò˜ƒ¼%<#³¡\"Ê°U+\Ú+½Ş†£=,¼]\"kş•FŸ:” š‰\ÍE˜€\È\É\ï\'°‹)mM\Ã\ó[h;ˆ¡Y \ÉM\Ş\ä\ìQ›²\õ\ğ\à0»\âŸ°„)Å‹¼q\ä\í\Ã?\ów\è\ózºŸzs55l\Ò\è\å\Ê\æ4‚Ä´¢ªaÌ¾A]‹{^µ“\\Û¤fi¿@¥‡3ùY\ïvÇ\Ãf\İ\õ\×a\Ñ;\ßÔ¼|R\Ö2¹¿R+\ÂrPÓ©H`Ÿ‹\è…>Ö¾\\ˆ½\ĞÌ°£…yj\"@\ÓRœ\ÊpŒ‹\ätj\ë.BM³\â*¤ `#,¾Ohq$\Ú\Õ\ğÀ/\Õ\ò¥¡\åR	>p\Ä\ZK«”4K°ÿûyø¡­J‰RµD\r¤u‡µ~},t\ÅnÀh\Â\Ê:\0\Ò\Ò+\n\ó\Ë~K\÷\í4\Ã\éb¢,\á,¼­?\Ên\é\Äy\Øq’™\ñb™!³ÁŠ\0B·”™Œ\"O54µ\Æ+u\02O@®ş3³q°¨\ò¼\ì\Úb\äM\ärg\Ô5À L¦´”\"xdFĞ¡ùR¸\Õ9HLtŠvbHo_ N\ÈnV\Ş\ë˜úY\ò6\'8’‚U5\Âd5\à\ìQ@\áÎ¨`Uú¦;Í´adşÖ¹!\ádST\ÔF—\Z•IÚ\â:R£l\åni£”si*G\× \Ë\à\\§\ÂFC—¡OŸL\÷VUa\õT\Ô;Ÿ\İ\Ós-|/\í×¾9\ô\Õrû<À‰\Æ:,\â\Ó\"Q¶½`‚G›O\\X\àJ‰IB‚”±\Ø<\Ğ\ËX¯`R\r2\Zû\ÎgW\Ü\íq…¦h–=‚bšk\r\Öâ©\õ\Å<,\ê\Å\ô\Ú(1ª°p¦\ÄJnµ”GÖ‘\Ólch€b\Ç~ˆ¼\öjˆ\ÂTäƒ‰‡.	[Á¬)ªT0J\è‹ù\Ô\ò†z\ËQÃš1ƒO\0Ÿ\ÈP‰}\"úc\èX…y\Äth¥À\ê&œ\Ğ5¨9)JYw‰\0\ÌP±™\æs\ËZ³w¨š ­³[oq¬Û§²-”L²R&\ìû‹\ŞÁø›’‹\î\ä@9@@h\"­!X0r\æSr\ç°t\äq¤’r\';HHiq\ã\à9t¦&\áPÓ*–\ê¸D\éXü¼µf\È\è†I\í\0kP§\Ö\0`tal’\òb¡N\Úh‹ÁLyi!$\ÊZ4%ksE¯%;\Zc\ÃJ:N\"±(û«¢šøº2r\Ø\ös¯uÄ´9Cm2…˜‘xL\Ê8HI¸°·\áN„ª\Æx’±ƒ$=\ğO\Ò+:¥•©\Ì\Î\\£/\ØÎ‚+\Ï\î\Í?­ŒÈ°\ôB\ÒBˆ;¶‡FJ8RŒœ¨†\ÆD@dg}\Äe5=WMµs\Äş>¦£ŠR\ğ1”X®	=}Š¸\Zk\÷a\ğ\ãı¤\ç¹\Ê]jŠ&\ö¶\×jPE+û#-¹\ó1¡YHX\Ø\ñ½)$l¬V®Dk2\Í\"±ú\Ù\ô”\Z\ÆU\æ\Ñ_‚¤\r~\ô™¦\ã9”\ëwî°‚\åek\ÎÍ“@{haµ¶<®#/Ò²Vi\Õ0+\n±µ$5\â˜F\ìŒ\á3B+¶Ñ›rFf‹º»\ÔŞ‹)™Ú¤E\äÜ–rLRf*€\ôL\ö˜\Ê~-£^ªˆ8zŒ_H\ß\Ów!\ï‚f¤z\È5\Ú-YZ\÷\"/²Q6¨d\Úccºº & xpt-I\èR3…X’(\à\Ì`Y²%¡LJ4\ÊJµAÛ‡%¬†\ÜDLY%\ìbYD£0¡\Z±F^?\ÜM¶PQ}!¶®\Ğ.­}Ù‰“{¡!\ÄÎ•²q[Í¡kıŒÂ€\éBWï§º<š\ã\ã…hlm«\ëV\n#gD*\Û\Úü5&8\Ã8À96\Øc„?)£[\ä\ÛúP\Ì]µ\Çà£¨¡\æœ[q\èKU\È){a@­Œš\Ú=.V4^yt\ß\÷ ‡\í\rS\':À \àV3Wz(\"m\È\ÌH‘eNgpµ\ìFL´\Õ\ğ\Íu•RÀ	¶T‘\0\n\nT>\ğ³¨P-¬¼©[\ó‚{\î:B™]ˆ)‚dÈ„!€vl•Áµ³\æt7\Ù!E­µ\ĞZ3M‹\Æ\Ğe¢˜˜†G—ÏŸ;¾œ)\ïK(š€}”=JG	§ğ¿¯™R—8\Îd\Æ\0GR=Ä’˜G4\ğ~*º\Âg’*uq\Ñ0(r\Z`“Éµ%\'\è\É):¦¯TQW±¦¦¢³Jˆ§N\ã\î\Ù\é/\éM)uX\Ü´‡<z´k\Ø\ËC·\ô\Èh©¤_˜\Î\Z•T\Ø6\à\Ëq`Hk\ÌA%\áº\Öp[Ÿ[\ä”$V\à†\ì„=8c¯v­“5³±G––•ˆ3e¯À1ÁB=Qm\çIS‹<\Î:?*X‹\Ğ^QKH¾‰x»6—•fi´¢¸\á\Çf\ç\ö´†‰\Ñc)aPLÁÂ£ˆ`½9x€	‹\Å\Å\ó»\æR\ã­\êz\Æ\óT$.\õ~°V˜	C˜C/Ñ£\Â¬é¯¢e¨9·\Õÿ¶\ÂÀQ\ÆCF:j)\ì¡\â\ÂÄ­+¾”9ù}BJ<\É’@>Ù0\ÛBù\'¸\ã|…\ãÔ·\î35t¤\ßÿ¯}°,¦¸<\09‡^À3– ŸSüÁu‰Á\í\ôH\n9¿Q†Š!7;Ÿw!\Ã\Ó`;Á‚{)t\è\İıTXP8\éŒX†¡\ã0$ˆJÂ´\ÑBl-\Ñ\à;Rœƒ\î`…*\Å\Í\öø‘et•‡r\ö4…6SQ\ZoR;+€%\Ü\å\"+şv*q\Ó=²	JÍ*\Zv&¡lD\"0X\áÎ5n\è;\İÀ%\Ş\ß’­¼\ìebD¸\ì,\0±²a„)ú\È\ìGb9%\È%«¦\ç	£<^Š®F¬\Ô\n›]\ãbJ X”G‡úü¸ §|©‰«6µ„¥røĞµu­œ‡˜\ô(\ôü¶€ú‡\Î\×X\ÔK­q¨‹‚ex\ÜÅšƒ\É\Ì\Ú\×@#p($WD¡#u¿:\ÒSq±„\n\Üo…¹œKH¶’L£–=ÎŠÖ®¦\è\âš`AW6\İxš³C¢X)\ßB\÷¸\ZR\ëS\Ø3+vG\Æ2N\äP;i»˜‚q%4…PÂƒ\ó\îa TS©n\Ù\Ã\ä!)\î-¦4\ÈFzZ`‘\Z9\Ó$q#¥t¡\Û\Ò\ãz\ê¾Bş\ír\â_§\ğL:JşBy«¼)Ì­\æg ‚\Z\â5ª²f\ãw„\ŞÁBomf Å¤ %£ª0¢2Es²dSÑ A‚\ñ&mU\ô&}%\ë&X<\Ó\ğq·UTJ\\\0•\á\È\Ùb×¬>…R¹X\õ\â\îŠf9Á!\'\ØzªĞØ³eV#\ñPş?Œ†¢ş#‘\Ô\ÎXrƒ\ÖQ\Êü‘h¬g\Û\æp\×6A\r­?B&¢Šd‡…o_\ò\è\ÌV±‘§¢\ìm2ïˆ¡_‘°,X#\nR½•Ó®‰\óûÿœ%š_Ğ˜‰ \äpVHL\â\ÔJ\áÀ\á\à\\\èM°4p–\Ö02À±GÁY\ËzPq£J…Š$\Ö\Õ 6Ci!Q\Í(¸4§Ãµ{-\Ş\Ö\ò´\ïRy‚\â^X¥€r†&P\ö¢TœŒ\Ğ\Æ\è\ÎRw\à\õ\Ñ#ºK)F‚?ı³´–Å”Ğ³‚08\ïA³c\áÁ=£QEcYQÂ¢¥\Ò.-M|$;¬£C;;„•’\Ùu·Ãuqe@Q6ˆPb\\û¢@+»u\É\Òr )CšU1­\÷²¸\Z\ëa!^0®’İƒ\Æ	:Œ¶2¦§™‡7·\\•\ä9hš‚.É¦\Şøù§arŞ±+0…úm-\êL4›F\Û\Õçª¼h±T_]qEj\Ñ\r\Z«o¹1°£\É)ˆÁ]¿çº4\æ\ä2,¨	5›U,h½\Ë\Úagb›\ÛZn)®‹×¤%\ÎÖ©Ä°\0‹c\î#\ö½§˜x“\ØyQjkhş¦\àci|6\ã+)°\0\Å\ÚR=|\Ä\ÖE\÷(Í·N˜ŒV~\Ó&\èq uQZ²`J]“\ÆuQA\å\ÊXìˆŒEf&\íå³—¿e=*…fÔ¶*\Z#­I±„ˆ\"w£,n½¼\Ê3z\Ş\ñÀBú\Ø8GÀ2- +L#{%^ø5\õÊ½*Q\ñY\ÜÛ‚ŸÃ¹\Õ)¥–=7KJ\Â\Ò\í\ìv%;Ö±_†)Î\ôhD©Š\Ğ;yø\Ğ\Ùl\İù \Z\ñ’xÊ\é0F\é¼\Ì\Ù\æ–p\÷¶\n¤\ïºu‡6}³QÕ‚·	’\å\"hZaxˆ“(w\Û\Ù!\Ô$C¾\Ëp_\õÖ¦£›À“NŒ\ò\à…l[\é\õ^J—\äm4º%)\é’ú\Ç¿ú\Ìq\rp\Ş	\ÅCC\Å=\éX¾(·Â°\ö²/’{·ù \İ\îlß™ƒs[Œ{-\ğ¼L‚\"n\í­_1/\0˜¥©‘uZa\ã\É\ñB\ÅC±h¦\ĞrW8 + @¸‰59€?†lBaÀ°‘}qˆU#bœ²ùqˆ° \Ëv \"ƒKS§\r\÷\é@x³W\İ\ßÁa=J\0¡“<PÙº\Ö-\ö\àÈ¦if\õeYS\å\İ\Ûl²\0~©7ƒšWDMQÉ’,u£¼ÿ\n Š¼€øfµe°k\Õ\ÊY\÷€G\éš\õ*7¦jp\ÃI#\ö¨\àw)x\ÃdŒ¡\æ\óP=\Ôı(c«\Ò,wdº¿\í\ØL®M\Ç=M\é)¤ü^‡¶\İ6ûC\ç™Öˆ&¾%\èÍœ¿\ë\Ç\Ë@\n“a»‘dH\å7¡\å0…\ìQ\n\\\Ä\"¡šx•\Éi‘¯I\'ƒQaC\Ø-;{J{68®l¾¸s>šİ±X¶¾\æ\\\éÈ¿\ò·\Ü\Ë\ßü+sş\Öe\î\Í\î\á\r ß©Y²\Ãm4p²æ¹¾¬_JqÁù\ÂÚt¥\èP4GC\×ıa_\Û=Y‹r\ßw®R\Ô\"\É`\êÀ\â\n\óp~j®ˆj½\ÌJŒ„\nf\÷j7=?\à\Öw]\"\ÖÚ³eWTÜ\å\Ù\ØD˜Ø¦±IA°¶~lC³Rl\Íò°­š#Ğ¢¬0\Æ´Cl0‡\Ì\íL£3¤\\\\\ÇW\'L@şÀµ0ƒ*1\Ë&€\ò)1<•‘,pyŞ¥]­®\ÂA«E]yS¨©„-¾µ¿¶?JG\È\"aB\0´€Â\ê1-\'x¡ x’(up_³,Dın\Ä\Ğş8\Ó\å<\Â\Ë\åc	ƒ š—\ã¬\0s\ßwrŸk$\"¤\ÓUBcÖU/£\Ş;1¯û\ë\ïœÁC¶M0R\Äv‚9èš¤6tv9Ñ™^=\×S\r\í%g;…;)L¨\Zü\Ê*¶t\ÓZ\ğ\ÉhJ\Ø\ñ\n`ˆ:‹[\":\Ødº.”\î(¦¥Xvw\âı\Ä¹5\é\Õ\Øe±H\nR<‚°GC~·ST’¦€²,\Â~Š€Ûœ…Y£\å\ÂaR˜V›˜§ao„\Ì\ìnN^4MDN\á\Íş™œrRú54<hIh!T“Œ•€pMX6OÃ›A¢q‘\Ä0ˆ.$À\Ç[s\"­\Â*Ì–$\0d’!ˆA”a•‰œ¬‚V\ôxº¡Ä®ox\Ã~!l-\ô·…ùKv\ÄÏˆM-\ÅM\Í@t†¼\r¹š’úA».”X0,\\3\n\òOS^¾™\÷xA(”Y°\r\0\Ñ³\ÂL\ĞHÚ„h(’ P±Ï“‰“˜#\Æd ›™t}ÿ8 \ÔcC7Xº€sOAU”U!I\ãCP¬`+\Ì\0Qry\Ä\ê\î;~P‹\Ó=\ÊE‡\Åúg/a‡5uBÊ	‚iT\ò1/º\åE.qN›¨Ú ä‹”U°x\'\ä\õü#gpaûÁ.²\ÕRø&l\ó\İ\Å~I¶L›³\ÚûŠ¼™È´ı\Ùa\Ç,a\×+Ëšj\åf‚dTŸnB—\ç`ê’¦ˆ\Ç\Ä\ì$Ö©]\ÊQ¦G%\Ñx³u\r¦Uh&`a`\ê,aEYª²¤{’Š	a–\"™z«\ÉZC,\â-Xe†*j@ŠwT²;”*°Û3ışËŠMŠÏƒq4]\Å\0T€Œ\àV]6Q\õdHo¹\"‡-\Änˆ¨$½º=OÒ…9S§Á°mN¿=§\æAI:P\0	kBA\ê\0\ÊHV\0*4\ZF\â¥aA³Œ²€(<N+UX{\æ£YZ`\n?6;E9¤tl¸´R³øt0‹L‚´\"Š\ÂEP\áŒi\å\ïTp`,Œ ClP!%‰;¤)+Á	\Ç`Gi”‡X‡**KŸ\Í\Ä\ÃÈ–N9Dv(}»–\08‚)P\ÌC¹\Â3³¨†\Ú!\âÀ&˜–o2\í0go¢X•af”#tm‡\õvR¨ˆ*\ä<O†fK%.]\Õ\î8Œ\Ód\à>\÷3W\É9Ş«ªCI\Ö<\ò–\×ù…®ø\İYq‹&‡¨N¶úCv\ÙG\×Y\ÚK\Ï\ô\Ô\î‚ù\Â35\ç+\õ¡¨Met!™F\Øz¤n ]fS\ñ&™¸†‚Õ†»DyQ\"»¤\íCUX\÷•\"@j“°E(«X2\Ñz¸\Ä/ g£x\ÂÂ½	cbAV4\åZ,\Ã\éq¸UŒ\É\Ö9’\íhm±\çv¢m\Ó!wÊ¡‘¬8Ñ…\ô;:X\ò\ÚY*EÏ’r*W\Ú,tk‰‰6\ã\ôJ±‹\Ñ\Ã0tQ\ê\â\îqp\Øk™§o\Ì\Ã1\Í<±N	ƒ~\ë/@\Ñ`¶\×&\Ùı\Ö_›Œ\"Á` …XJ)(¦\Zf3\â\à\ÍY\Ór¹‘\ßAa_^\Ïg¹Ñœ\ğ\âz\îøj\ïs¸ü\Ä4\Ê[Í°S\ÆÀ¢a\ÛÄªa”¨\0Š\rF‘¼\0MH…²*y˜‚ \nÑ€Wı€ÿ™-‰\nkq[nJj½, ƒ\óˆq1\ÆQ\é\"h\íVˆH\êı¿Se\â\neÀ\Ê`¥|¬Á\ÍÂ‹uh„fœ£‚\î\ÑDT%L.\ôN\ã€\ój\Æ<k\å HIb\ãûÃ¯©=6#	^\Ôw\ß\ç†¿¸!~\Ë\ÒN*Á\è7E¨_Ê†—›K~ùs@]œ\ëM¸|ûÀ\Ğ7/\Ä\êÀ¸™\ëw2\Zv …+´Û’p^A˜\Ñ<#q\Ú\Îvù½†\ï\ì:	¶\èEa”\áan€°\õc!Y\ê-úEEE\nC¦\ôR´mJ¢\nH[3)v¡\èÎ›(Ê\õª \à£¬v\\\ÅÁ²+”6Ûi»f±\é^5Œ>J!…J›sÖ´\Ø\Ë2\Æ(mt•\n;*ï‹·\Ø 4ú›z\Ã?c\ê\Ú&\ÏVXR\ØYZ£¿\â6À»¹Là«‘8‚·NŒ€B\ğ8Hœ\î˜Î¼¾Ò©Q!ˆ°­1B¸!®	t°&Şœ\n)±§³:´\â\ô(ˆÀ\á¯\ñ\Z¹J\Ò4e>\éÁJ\ç\ğÁ(¢(R©»-ùW€D¡h¿Ó‚(\ñ˜\Éfh\îS !O\ğ’>\Û\\\ãlNŒL\ëÉº_\"$x\0{\ì(g*~ºB,¶<o\\\ãŠE$iùPšÍ¹©¦¸\'¦\öA\È\04\Å>¾yÿ\îQ\ZN<$D³™¥AÅ¡–\\‹\ä·Hi\ğ\r+Š”<eúw\Şú‹. j©\à\'‡¬‹]{O¡\÷\Ë;\ĞS.½\Î\íÑ3½¡\Ï\æ‘jH‘.\İ7P\Î\æ‚ş–6’eI\íPL\Ñ2-\í\Ö{\Ø\å\ÎJ¾ª6\æ\íF#\Ø/µ\ïºzp²\ğ{/¤İ¬š˜\Ãú»\Õ\ãt\İû\'\Ç\ôVhgivn\×hDHC\ênB\Û\ÌH5\ò€&ªa\ßb\ò²)J\êH\\+¢Cˆ\è\ÎÉœ©ƒ‚3e4\èAQ%[¡+¦\Ø,\èH8Œ“…\0\Êûfb’Œuê‚©\ìL\Âv \ï \Â,b\ìUù2£\ÎJJ\Ë!Sü~Šrl}»n\ÒcqË¤\Äz6B°\Â\Ç `m¸Zøm\ÃY”J\Ú\Æ:×¢•³¤y­˜Syı­)i	\÷Û¤\òN[\Ë\×J\å@“À#{‹\0ŒnÁ“‚O\ô¼A–	EPÈ˜FNk¼6—\İ\Çc;Gt„ESt<j´…\rf\õb\Ï\è@\0HZ„\İ&`\Ğ\nÊˆ[\ğgG\Ãjx\Ñ…•V\õ\ØWRD^\ö\à\á~°G^\÷(\Â\'@\Ó\ë\Ã\÷øİ¾\ïH\ÙwH¾WK\î{\'\×mËŒ\Ş\ç`P0\Çq;	¹A\Z˜6ñ¥¡›©2¦\İN´&\ÇpµAsy¦J‡.›GF\Ğj\Û\â@sùù…\è·i\á6$\ì\ÍJ©¬fv\é\ìM‚…Š°Å®i\ÉSzn\ñ…•)dio€WÛ…\ô©\÷®6\ìF–sœ<c_›µ\Zi\Æ#P]`I‹n\Ú-=_Œ‰08$&—bP\á\n\÷F)Dj³\Z“G p˜\Ûƒ‡2»M†¡3 X~Pp\Ñ:p&+5‰\äd–\Ù\ë—8”y0®ƒ£‡\ÌI¤\Ú\ö\ò­\İÄƒÁJ\ÚB\æ‘\n=t\é&\ã;F\r\"@$\Ú\0’ZSÃ”\ã\Ê9t©˜B+—\ïÕ„T˜`–K„#O„rƒX£\İ\õ¼\êLn\nJ\ä š»¢.\è\éB³£”P1\Ù\ïGE`\×A¡\ÖEaÀJN]LGø`˜œ4bÚ„j]i‰ZnY\ïF.Çˆ5xª\Î>\ì\Åƒ{aqÕ´ š\ÊyXŒ/\ê€ \Ğ W\0\'8V\Ò\ÏW´µ2“N>\Øk\0\ï\÷(+\Ã~_Í‘‚(\à\\\ïQœ8\Ç\Å\É(’¤’µ66\â<{18\ÒşQºv–\öj+%¡S9´\íd\çŠº·\Ò1\Â\óp›Í­)H\í«´c7´”{>ßœ\ë2,A‰M)\Í\ã“l\ĞY\è<D0hS–Rr\é%M,©\ó>M¡\ô‹˜µ\'Š…	\Ó\Ó8ue”¦\ò\Zœa‘¬«PƒDME\"%¦\ÊfjR5\Ó]\Å:\'$2‰ ™\ì13\Å@@\ã Za\å½œm\ØBa™JQ\\8±–ºE©Y6=½¥.\ò}ƒ)­\\\Åı´\Ë?—tÿBx\Å>X¯w\'½›º‘¨G\n»\Ò\Ø„\Ë>\Ç`W4GTh^\àX\Ù*Ôµú.y`J+DYÀjÁ\ßy°\Ékÿ\äj?\ô\í\n[.h—¾\ÇÁ²5\Ó\İ\Ğ{9¬T)~c\î\Z¨{1\ßB\Î,ús£6d\ï‰ZJ\ÙÀ~ Œ^9¶•“ ú\ö¤­†\Æ\Şg“\Z=FŸ —Q\\\ØqÔ¢\ÎR\n\ZR“\0µ	2s*ƒcƒ\ËKa\Ğôˆ £i™,\Ğdˆ\äX,\ÑHA4Š\éo¯İ£Ÿ`\ïÄ€($ÀPBAR8\Ï\Ì)e^\rI¶\ëCz¾¢\Ñˆf\Õ“†Ö‡©JvÅ–øG>¼a…4\ítq5\î_\Îg¦}lq•û\Ã\Ú6˜dEÑ ¥—Cd\n·\ß\\]iWr8Œ$Ò»Á\'±]M-ùû`¹\Ä†t._¬ä²©r›\òú¦\óh%§iHJ\é >”\\P¶/XJ{¥\Ë\Õ\'0!º6(=·´\ë­\É*•µ9™wÏ•\ß\Ş[	HB¹Y|&†¤!,\ßÛˆ%\äE01NjgUqh‡\r´Tv8<,WÔµ\ËW\Ëo¤\ïØˆQŠ0Œ^R—d\İm®]˜\Ó\ÆûOMŠ\è\òK*ú‘\Âÿ\Ú/š\÷—ş!\çı™…·\Ô\íÁ\ÙK\ØÒ¹üšF\Ô7Ñ•ˆ’\Í8‚ˆ^Ÿ4Q`ß*‚ıüQş\ËE\ô\Ë;ÀB\Èz«\ëU“¼ï–´a\àT,kX|#¢•\Ô\"<:S±·q\ÄkPoB\ÄÆŠO†j36\'O+e\Ó\â:ü¤v›PY/„DÇŸšÕ‹şİŸsƒ\ßû&Z\ÃB\'>\ì‘\ğBb‘\ó*\ÔÛ¬\ğ\0;Z£½Ì¨JtM9tQN/\\KyYŠZe1\è\0\Ò–\ÉKHş!	T\ó´Øº`Û¹ˆ41„r}\ëŸş\î\í%\ô\áù\04`Š¯L€a\'\Í\"¾`2\ğ\â1\ÆQ¢2\êiÉ½\÷\Í{<t7(u*•\å\äQO\Ô%\ï\Äoz\ö\òQ¤%\\±-Æ¦—=\Â\ÛH\Ó\õ\ß~\Ìu¸\Å\ãÀ\îdH†=µ§É¹¾!\ö\Z,¼wº\Ë<ıš\Î>”\Åb“gŠ“i#\Êl}\îXuN›]\ÓgIqmŸe/»\ğ\ãJ™°;™Ø¬\Ó[“w\ér}\Ó\î† 3”CIU\Ò#\Ã	\ç©gJ{®\Ó–06%Œ)bd‚\Ã›r“\Ä(„*kı,0\01\0O}w«\Î\Ó·åš˜´ˆFU\è*‚Š\ô ZP‘dO\öV\ö\Ø4¼K\Åú¿ÿ³ÿ;û\ßı?(úş\'q?ù?Q\Æÿ*‚\Ò\ó™\Ü\â!Y/(¾ˆ@>oÈ‰3\òjR\×3eK\ØDaB°•ƒ‰,ƒ$U±¢£¸@\Ô\Ã\Ğïµ©tK}¶…Ü°\ËÄ¥°§¨3M\î\nTX/\Â†’”¸y˜¢\ÆIJµD)\r1\èl2´Ñ\Ñ\éú•³b\×\É\Öuš\İ\Æz“v\n\Úg0\ò\Ê\ï\ìbĞ”¿\ÜF*úK3}\'¸¿1\Å\ê\0t\âTq?\n-y!TKx ”‘x“9ş¯4I¦\ìˆ\0\Ì>\r`w@¡l]HM\Ùv~Jùµü²@Ka\÷\Şú\õŒ\0Û¢E\0;ºÁ\ïk%¾YA\núA_`\â\Æ+¶©t8¨k\æ\ß\Ş|O8\ä\ŞûC\í_S \ĞD$¤<¬\×\r1\Óâœ.šš\Ø\ÛUIM\âpX\í\Ñ\Ûx†<¸pZMº\n/\ãÍŠ\'\ç\éV\×?{e\È\è2;:\Ë\ÍdŠN“º#^a\à\õ•{j\nï¤\ô´\Ê\\FNwşq\ÕV{j…-Ñ»®!b‘]S\ß°•\ä\ÜR\ÖaºH4\É9\rˆ\Ã.aa&‹™UŒfI\'\é\ÙhT‚h@\Ş>\Ó\0§\"ˆ5\Ò~%\ÖıÁº0>wa)$6\ÚbXTGI[‡7¿À¤Ò #’%\'\ö])\Ú#\ì³]İ¡\ï\à<›¬4É²‡°\Ğ1Ø•¬\n¥ER+”Z9Õ¥\Ü&Sş\ÛC\õvRÍ¡Ó•8[*K\Æ\Ş’6\öI?¥D]»\ê®WIsÀ\Íh/ri*_\÷³¦P\Ã\àwÃ’/ Ë‚\ä‚\õcCÃ¢cŠ%Å‰°>J\\Øˆ³³\Ïg~/ƒT\n\Ê1\ò2FA\Ó€N@‹®ÿ\Î–x\õÀ³¤û^6\å¢0\Âig!+\Ïl@\÷†\Ø74ş!\ñ\ï\\A+\Z…HH\ômcnD•I[Î“!	;\Zƒ`LH<)Ze(J[P*H+À\ö,\'\è	rK^¤œ[\òxÁqJ\Z\Ãé±ŸTú‰q\èy˜\æY>l§‘\Ú\à\ôi-Á\0\é2^a•Dü\öišN»$Ó´8p\÷\ë]\à¤\nD\Ğq’‚\Íw?Ì€¹\ë–\Ê´r7¹¡\Ò(,\ÔÕœıP\ôQVü\ô9ım§\Ù\íú\Ü}²\Ñù“«6Š=kÁ–‚\Í%C\Ã\ò[\òT‹qJ\òá¶‡\Î\\\Òúo~Y›L7A:\Ëş3.ù«–YÀ\Ñ\'ı²1–tû®\Ùùej‡°\Â\İa£\Ó\Ğ7wI·\ÂTl\Ò\ò\Ü\è\ê$0G\Ñ\ÙJg‹dƒ‚ƒl›I¢t±\Îi(E„•‚\ÒXR!\É0 2¤;¡ ‹\ÌVÉ‰±À03ì¼ƒ\ÅN“š©\Â;“ >_\Ò\Ğ\Ød‡„y\å$’!jh†…\"\õB#S¢D…‚H2 [†ùT}Z\Ä¤úD}û\ÍUxw•%[.OTg€)¯\í\Ì6…\Õ\à\ñ\Âm\×\n\ÒU0¾-\Z3‰M8D§¢0x/8B¾w\å5	m:\èIˆ©2\ì•\Ú\Í\Zc›\Ò\Üh§T@©\Êw•MÑ’\â£ \ÖD`A\å\ŞL‰ba\0\ã£\ÉfX\Ö6N¯e¢A#%\ÑbI]\Z\ï\åva)xT+)8\ÍgNë“¢„¸<\'%¹†GTÈª\ÃW#u\Ç\Ë\Ò0Á/\ä¤8HAmÌ‘EÈ l2ŠR¾œl/*\ö@‰¢\ğ+ŸO¿\Å\Zd+¬–V‚)0J\à`Y\Ğ	G´P2L\ğCA\ÚÇ®\0jØ–µ\ç\ìV\â8“\àm\r¥Ê”Py”«»©C[29]=f\Ô:CÀ\ÌC\Ë;\ê\ÂaË—´ıÀ\Ã\ÔY¾{W_,N\" dG°vİšµ\ès\ØÒ‡\n\ÜZ»K\ívw\È\é:\\Ø¢¹\\û\Ës°\Õ\ÔwM›\Ş;\á®e7 \Ü\Zg­\å\æZ&¥hJ\î\ÂI¾6-\İ)|\Ó\Ó`+KYuŠnFy3\Ô\Ä£[q’$B$“×ˆqQŒ$½(&\ô+\ÇD\ØÅµ\ô«©„h>©LÚ‹	µ \ö¤©6e{g«Ï½G{¤Š|Æ²d\Í2¢†²$3\Ìd\õPŒ\Âz\óú9EVY\æ´U¨ª€É“yQ6H–?v{\î¡\í¡„j\Úg» ¯\ç.´¿µø\Z*\òd7X\nM\ÊT\é\ä&‘\ô03dŒK)“\ÅdS“L³†u%\Ä*D¡Fe\0\Ze”’j’‚\Æh\Ï\nUKa’ˆ¤®¹ì¹–Is‰¤¤\r\Â2CJi#—!Cb\÷K\ĞB6Üˆ>v«!…‘\\T‚\Òİ¶\ä\ävpƒA\ò•\êZXº\É{\Ğ6Dax(\ö&R€\Æ\áø\ÊÙ¢»¤†!Sı¶r¯4	…I®¨\ÓOL¬K\İÍµA\0²™©Cš\Ü^\0DÁm@Q´¤„\É \â\Ï`%¢¹¾{;\çSºƒÔÄƒ®M¶	i•–h#q•d\È[whC½/øe|‹u€`„a‘\è¶\Òv·‚I\éQ\öN\÷¼\Ó3Ù2mt@M¼ ±£‹¨{¢k\í`\çSqN% ¿\\¹Lg™S\ÊD¹\Ó²O\æœ·¶ú®\Ğ\n\ËN•\Zœƒ(ûÖ´&;ùB\åe­\ØÀ6V\è‘a\á°)Y~`!T›o–\Éd\é7ûw”gKˆ,\Ö&Š\İMÎ©X\ÑJgI›m§\ñ€—!>…;¬\0E\ß,b=D\á(j€S“\Â)–tH¼…$OnPeLw¶\é:N%\ìf\ÓnJ›f\\‚\ì>lø˜.\ô!,«½6a»€EšDKRİªŒ†4\Ós—\áM\nEM¥\Í<‰Vø£H,\Ë«¤½H…L\n^–8	bE¸\ÄÀFYC¸AN€Ö’Å‚Š2¡Á\÷,<SŸ­|P{\ß\Ğj\çC6 ³\Ér¥Ø©Á\Â\"Š…\ØG\ö@\Û\î,\Ù\Zk-ºM^É¤*#yC©š\èR:2¢°F2E\Ãø+\nb\òˆ\Ü•«¸B\ã\Ô\ğ¢\Ö7bÖ‡&\æ!¬a\'¯Î^¢³\\Á\r’ŒºZL\çµ\ÔÅ¦\óµEY½\Ñ\è\ò`|NDù\Ù+z½‰øAˆ§7}\ñ$.\ò\õ¨“\öo*\ñ„×«„\Û\Â2s\\¦¥/\è«Yà«¯#A\ß~‡6[\0»P\Ø\Ø\Û\'#lw\Ê\İû¨zƒ%›Qüu\Ó\æ™t¿Sœ\çr\óLl5/E€xKsµø5\Ùµ…³}aj(\Ì\âŒat&Ë°\ÂI] —Y‡T´Imk\ñ€V\ímLJ\×;»u\å»\Ï ˆ…,„JJ%Á\Ô\ìQE\Ò\Ã7\Ä\éIkDa\"	Ö”\n5P¡h*R\òÔ«\ß#™¤#y5-»n¨\ò\öwºW¶Š\Ê\r”l”‰4 Ñ‚\à’\Ùe\ñ!‹.¦FS@“-t·¦X6Ä£8R\è\Ô\Ò\Ü6hBº±w\\¼.‚3lbwC\ÉMs¦\Ä(´Ì±io€;†˜i\â:*Îfš\ÆùÊ½MŒ]\Ú¿˜1M‹D) \Â\Z §F¯C\ÚI\ì%(\Z°‚\Ê¹Ğ\ë©]\'\è<©/‡\â\è\"J±Ì…\Í\Äm;«Òˆ!\ô¾º2µR\åP\İ\ì\Û\n=§\Ğ 0Á\÷\â!\Èj7\'H“¤z\ô³¢s¨2*}oŸ{!m¢4Ø´AŒ€G\Ùû–\ìkD›cD˜€ ’\áK\å\ô\ôA\ì\ÔL›ç ¤úK\×0:vg…\âŠAW‰!BÁÌƒ\İy%Q\êN\ç\Óo\Âù\è“\í\æ‹_\éu\Û\ñÒ¥^¯\"ÿr¸aM(t ¶¾m§i„†:\Ş\ö.{•I©ü˜\â¯km$€6˜¾€È€¿ ._m4O\æØ¬v\ç}{,!Á‘l©º~Ò˜KJL“\Ó5’E¤\È$A\"#Ü®ûš\Î\r0/\Ú\Å\×İ\ğ\n,+xK\Ê:Êš²>w\Ì\Ó5c¯\ZRH”ofFÀûf¡\ÛM—\Óna‡Fƒ%f\'mqşŒJ¦\ì:\Ûş„sQBh‚“\Ä2h\Å;È¡iÃ¿;tù\\U4‰@QHK£Q\ë!\åK× ,Ê¢’gé©eÎ”ª!\ZR9H\Ñ$V\ÅL²ªd\"(c\Æb\r2T4©)S¹5C/JL\Ğß¦\ÑT´¹eŸm\ÎÎ>’©]uj>²¶œ\ö:\êBF\İ¾I¡ur:\íu\"|Ä¡Òº€\â^\Ù\ö£\r\ÚS;Æ‹ @§ƒ2Œ	–¼É”U£qh’F\rƒ\å\n_Œ£‰²(!q\Õ>#‘E$ù’¡\Z(s\óZĞ£(\Í\n”ÀX\Ú‘š0SY\ÅÁI%r\Ó\Üz5?•»’4˜¥¦Q6üONù>\0~=“ª\Ç¿¸ˆH§´\à4:\ÜoŠS9?¹Q\ë »Š=9¹¦‹Û¢6‡d¼\"2|\ßù\ß^ûÚ½ƒCW§O¯>s\ç\Í‚„-\nÎ€\Î\æ®*\éK«ı>l¬­úZ›f.˜lD\"7LŸ\à*B#5+i\ç\Ûo\è\îR<\Ø\Ùv°û\ñ2H³\Ñ)Ì§$\ò\\B†\Õ)N0|%K˜{…í„­~ºqn,\n\ò+©\òA\éâº™\Ş\ç\Ó6\Ğ\İl\èû\'}¶\È\Ë]!\Él2vffØª\æ-:\ÙÕ–w\è}JO\Ò/d2\ä‹y<?‘M4\ÌLQÍ–l¤‚\Ö\ØÖ°\Î\âh“ÒqU¨d\İ*Ÿ!D…\êO\ìC—“\ÂS]@a¤\nQ5K‚J\Ã\îEB,?\r“\Ñ\r\á\"´]„wd¨\r&¦”\nk\â-$vt«©­O©fJwşB\İpxq\ÔSSµY\'1 \Ê\àç›”‚\Ø@AK­\ÃÈ³;¡m\ç^DÏ¢\æ0…«\ô\ØQ£}:\ÈhÌ¢\ã¼\r\Ä\Ü% `7\óD¯œ.L0\ñ\Z„)¬D…\ñ&3²U¢T,nK •PÀûn$\ö”·‚	\0 Æ‘LÙ„\Z\nN\Ôq_*W°[€aa™x’~)	‰$ Z@:h^\0À\0û\0M$~\Â9·\Ï^?¿©\Ù\Û\õ\"GyyÎ‘Œ´\nm‡ Á,\çfZGİ­n\ÂG/†U[\Ü7G€ù\÷\ÕU{E}\ñ¶\ï8\\p…T”„¢q\âT%6²0§€˜¸z2š°r%Q¥T\ò\×ÏŒ”OdZÁ\í{E\ì\ñx>œ)\İ;/E¸v¤\Ü1-‹·¡†\Ò\ÂÁ\Â/d\Ş[<\ìœX\İKQ0KE¡\Å;8\ãNBR¢q3l3<z\âÉ…™w½ª¼K\öu2Fº\È\å!ªÙ¦(\É)\ğû.§Aü8(3\İ2CE·Z\ìeè´»\ëyQCSR\è¬É©\öÀ²º•ûP†\ÕÃŸ\ñ§mÃV\ğk\Ğ`v\03tÈ¦¯6\ÉÁ¹m¢GZ1@DP,\éş¾aJ\'CD—Ó¨l±Ó \0\í\á”\ç¡\÷Z*\Õª’\Z\ä¤f\åVâªT~³Pvı´»w\Ì°°+Â}J£‰Á\Ñİ°O\èB	FŠ–\á!ˆNzY‘Ë<|{cQ•)º¹Úƒ\\ºN\nL@Y¿X\ê\Æ~µ—\Şc\è\÷\Ğ@SÈ \Éİ‹FV‘A;R\áVÄ\ğE4:”#\è\äl\ä\å;ƒ!ŠV21™YÁ\ÃÉ„®z9Ó´!#¹Vø~>Ğ¦ø“Y”©\é\Å*3™\ÂI\ãnA\æø‘]\öÉ¾Cr\"„\"\ë®\òÿ½\nJˆ\Ë\à\ñZ`¥l®\Î\É[I\Z®Ê°AÛœ\ÖV§f\"c\ß\ó\êwù\â:¾£Œ7qû‹\÷kŞ’ıŸÒ…jª\"\ô}J³¥Ô¹W\îBBˆ´RSú¬X\"§;\Î4´¼W:š”&(3YL\Ù\n³¨q”€a$Ht)”YWJ\×C“Yx\"ˆ>y¶Àw°^I+O©b,A“PY“U\âvs\Z*²^\á¶œy–¤H\n\Ğ\È\È`‘ps­†5E‚R,\Ü`¦-°\ŞB!¤\É\Í8Pv¥IB¦\É\ê\Ö\r‹ˆ\ÕJQ\öºXµ­¶è±¼œÁ&00\0š}ıI¥a\ZĞ«”g6¥2¨+RÃ“*\ë¨b\Û\ÄNz\"C‚h’g™&Y\è\ÌD	ŠHÍ›À\ä &MÒ%pEI$A†\íS\è\n{\÷uiU)•.“\ÇH‹I5œmR—\ò(]·ş¤\Ã\éP\Øv\òpcø\Ù\â\ãûª\è\ò\Ï\Å\áW\ÚU\ĞRn&PÃ¸\rAsRV\È\İLˆ\à\È\Ô\î\r\Ş\ŞPúA…¦\ÊĞNÉ\'(Ba”´-`\×~…,¦À`Š\Ş\ÍJbd“$Y\Ó\Ôc.`1IF\\¤jû\Â\Ô\ß€}#°Iˆ••\Æ\Â|v51—qŸ•—;oŠ†‰:¡$Ñ¶0\ñ\éj-\Ú\Ë\ÍR¼³\ö“7~\Èuı\ênr9\ÆW\÷°\ñ¤ı\nW¤\å.z[µ°RÀ3s\na\òB\"Ò”\ÚQ\á%«¤”©Nœ\n’d’(zQ)AM\ÈP	ª>t¤Ï™M€„€•¼f’\Ã\È\Ğ\Øx‘¨œØ›pW«Al01ˆQ\é{1\ñ¬;\Ç\î\å:U»µ\÷N\åe—!\\3_¤»]\åıÿÎˆ(,(‰rÛ­\å‘NùF:)Eø€w½·\ØaH½_‘)J\á>-}5©4YX*´\ÅĞš\êM\êl R<¤\Ò\à\éIF°Ü°Je°Tšç‰5\ËL¢kTH\óN ı\ò6üas\Æ\ï?XùÅ…Ô§\0HÁ\\AEÒ‚\Æp\ÙlC\ÇN“	†	ıú“ˆéª§Í‚\Z!\Ûf¹\Z\ßl­bril 1¬´Ó°\á\ÌU‡M\îtş^†…\íF\ß\ãA§ˆ’\ÌCc\rûkS\')-™‰·Ca@U‘\âBš›!¿^1ee9u‘w&}W6…\Z¸’\ÍD½\r±;2m‰[ACª0bšHd\0_IlT<\ÓO™g 0\Zú²1)t\İ\Æu\Õ\ç\Ë²¯d\Ô¸`# ¬¡²³Y0\ï \Z­‚“lE£\İb^N£\òz!Ÿ\Ìo8g/‹,Á\Äz‘«ÌšV\Õ‘ [\Õ\÷« Z‹\ğ…Q¹ƒ\\B\ÖQ†\çRI%˜\ÙVE\ãl\0¤`4!)\Ù\ê3“*\Ñ¯Á¢T‡ 4\\š\ô\ËFr68]É¾ƒ	eJ\ÈV¤I6ùJ7««iu\ô(-¬’\Z¹v7¸>Iş\Ö\r\î\á½%~\ä#Q°b/}7¦ø=ÁpÖ­\ñ\Î‹Uq£Á\Õ\Ì#Tı~²½_~±À\éXÆn‹M\ÑqÑ¸\è\ô¤\Òu…o„R*^§*š\Ğ\nj\rJ4Æ›A}úIqH\Ö\É]PT†´û½“{xyaq)YK©%Í½…0N\Ôq\òZZ´\ĞNF\ñ\ë!À\å`S1³$+pH¯œ’\ö\éD\×İ½¥\Ì%N\Ö{¹\'¯Wƒü\îFL\Ú\r\ğ\Ä0-§²Ñ°\àL)\å§!³Qic\"–0y…ˆL\éf%N\Æ+\í\Zrí‡T˜8Q\ä$Š\Û•\Ê\ä\ìk\ÈX€±\"‹\ôP”J†2Jûú¥‡\â®Tu¤\ô “\ÈŒ“+\ÈY!¬C\ñ–Eb™PW\×ú\ÎIŸD¤T\Çı›\ìw¾ıù¾\Ã\ÄÁ2\Æ`%\İWl„-\ÌA7A\äT°ü +>$°å§‰£„´\ìºP\ñ¹™V½*‡§4\Ä šIU=r\Î\ZO\Ón0/C½	Cu˜\ÒøE\Z§»²„¬\í4\"±K\ó™JF¾ NIJ¯N\ä5û\é\"‡?{X\Ï]`—r3ÀrH\Şù\ğ:Ex\Ê]R±`Ğ£N\\,\÷J\èc/\ö–47+}	Õ6\í\ß\ß4“\è\îA\ö¯œ\Ùz	Kpº\é\ĞWRüzra­/§O7º¢]Ï›k\ØU\æ1u\r\Ú\ßhw\Øh\'£\×I¼“fi‡\âwZ\ØÊ1\Ô\İil\ê¿$Ë¦\ô‰\ÂY¢a\ZKJ\ĞN\çÁ–rc–\îÁ\ğÏ”38D@3—‘—–›‚G\ÓKX•„\rIV\âœI\Zl@Õ°Q@bOi‘¶\ëU6hS“Y91t`‡À¦ÀR„Š\õç–½½WˆJU„&\'–\ò\ãbH¤\ì=B\Z\Ø\Ê[$\÷Q‘|\ò45”D–‡ˆ\Õ\Ü(\Ìh\×V7\"k#smq\ä*c°P\r®,3£D\ãª\r\á†-›–ue\nc¬\0{\Ò#@\ŞV«\äü¿Uy*\r[r\Ğ9üÉ±·¸\ÃÏœ5\Ï/\0`ß‰\ğD’%\ée¾Vf˜V`ùÎ³$0€\\\ÜI	ˆ”­¼Lb\"‰ ¢*dx*\÷.`\0\õ›¿\Éo~©E$1	“\î}û,`\ç[#9\É¨=\æ‘B˜’U©\Z¨\nShÕ”T[`‡\İ\n?Y›\ñ‹w\Óê¬‰\ä\ÚG\ì\è\ô£*\Z³›\è­*Ø¹oûv9¹œ˜\àŠ\İrXvÃªÔ·ZnBÊ©­|†z¼\í ›,\÷6şûw\â>\Z›\ô+J\ó\Å\Ó\îq\Ó\è\Ú*<\êŸ}\ê\×\Ø…u\Ûy\Êse^bG\İz#\öq\æ\ê4•Zk,ÿ\ß\ì\â¦\Ó_\Ó\ÚF\0¨DgNh\òE[û®Û¥{^\÷?Ú«ÿ\ä/%\æ\Î1\Ï\ÔE[	V\ÄÆ¤\åŒN\Çtœ7\í\â\\C*$¼š¾\ñ€\ÌUj‰•Xå…¶¡±\èZ\ë\Ì+¬\Zl“™,v\Õ«¦–)§\ÔK¹\ëu‹cTœ°y¶ºÂ¾\'¶m—§/[\÷*ûg[¶½/…ToD;2\Ö3\÷\ğ\ê\ì¶YN(œ¢…\÷w{»\ÃC{¯%¶œ2-Gi{HDÃ¿x\İ\Ã¥&A\Ì\â<\\t[L\îV\Z\"/À6Nl`M\÷\ß\Ü\ñ¯_\Õ\é\Ş\Ûn¾+\ï\îûU~ú›\å\ßııwY}µ{Ÿ/\ß[r\ég\ïú»~A\É;ˆ\ë.ÿW=\ñS\0&|„\"\ŞÿL+\àW#o	½uûO\"²/ø]º?	ú\ó“\ôz.–\ËÉ“–\' K\'0.Á\ó…ı6Q`E]\Ø^—\Õ}…\ó%\'£\İXú¦x,‡\ïú¦\"ø\ÍoW¿»\nj³}\öÿ\Ú;\Ì~k§\ö§1ë¯¾ş\ç[1\òY«\ß\õ-&¸ÿpv`\èWµ\ï\ï\Ãü<\ß;0ÿù\Í\ß\çWø,Ÿ\å\ŞU?´ø>\öHp\ó¬\Şÿ”\\\æcá‚¸Y+\ì±\äQ\Õ<3|¡5€Z5\ğ}^\÷Ÿ ‰Áa\Ï3 \"\Õ.½>³Eş\ÙT¼\îÎŸ¡›¼ÿK´·;\éë§¬\õ4š©Iø=)ş¿\é|\Â+o\ß\Ûw½Ï«s<­†\í/u9œûb\Ğ_\ôùÀK,øuü3\è‹!Ï§|Qş\Í\÷\ß\Å°Ì¼şıÿ\Ö@\0','2021-02-25');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `noMoreThanTwo` BEFORE INSERT ON `product` FOR EACH ROW BEGIN
	IF (SELECT count(*) 
			FROM product
			WHERE new.date = date)
	THEN
		SIGNAL sqlstate '45001' set message_text = "There can be only one product for a day!";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `removeQuestionnaireProduct` BEFORE DELETE ON `product` FOR EACH ROW BEGIN
	DELETE FROM questionnaire WHERE idProduct = old.id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idProduct` int NOT NULL,
  `text` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_question_1_idx` (`idProduct`),
  CONSTRAINT `fk_question_1` FOREIGN KEY (`idProduct`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,1,'Ti piace questo prodotto?'),(2,1,'Lo consiglieresti ad amici?'),(3,1,'Cosa miglioreresti di questo prodotto?');
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire`
--

DROP TABLE IF EXISTS `questionnaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idProduct` int NOT NULL,
  `idUser` int NOT NULL,
  `sex` tinyint DEFAULT '0',
  `age` int DEFAULT '0',
  `expertise_level` int DEFAULT '0',
  `isSubmitted` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_questionnaire_1_idx` (`idUser`),
  KEY `fk_questionnaire_2_idx` (`idProduct`),
  CONSTRAINT `fk_questionnaire_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_questionnaire_2` FOREIGN KEY (`idProduct`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire`
--

LOCK TABLES `questionnaire` WRITE;
/*!40000 ALTER TABLE `questionnaire` DISABLE KEYS */;
INSERT INTO `questionnaire` VALUES (1,1,2,2,25,2,1);
/*!40000 ALTER TABLE `questionnaire` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `point2` AFTER UPDATE ON `questionnaire` FOR EACH ROW BEGIN
	IF (new.sex > 0 AND new.isSubmitted = 1) THEN
		UPDATE user
		SET score = score + 2
		WHERE id = new.idUser;
	END IF;
	IF (new.age > 0 AND new.isSubmitted = 1) THEN
		UPDATE user
		SET score = score + 2
		WHERE id = new.idUser;
	END IF;
	IF (new.expertise_level > 0 AND new.isSubmitted = 1) THEN
		UPDATE user
		SET score = score + 2
		WHERE id = new.idUser;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `removePoints` BEFORE DELETE ON `questionnaire` FOR EACH ROW BEGIN
    DECLARE my_score INT;
    
    SELECT count(*) INTO my_score FROM answer WHERE idQuestionnaire = old.id;
    
    IF (old.sex > 0 AND old.isSubmitted = 1) THEN
        /* UPDATE user
        SET score = score - 2
        WHERE id = old.idUser; */
        
        SELECT my_score + 2 INTO my_score;
    END IF;
    IF (old.age > 0 AND old.isSubmitted = 1) THEN
        /* UPDATE user
        SET score = score - 2
        WHERE id = old.idUser; */
        
        SELECT my_score + 2 INTO my_score;
    END IF;
    IF (old.expertise_level > 0 AND old.isSubmitted = 1) THEN
        /*UPDATE user
        SET score = score - 2
        WHERE id = old.idUser; */
        
        SELECT my_score + 2 INTO my_score;
    END IF;
    
    UPDATE user SET score = score - my_score WHERE id = old.idUser;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idProduct` int NOT NULL,
  `idUser` int NOT NULL,
  `text` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_review_1_idx` (`idProduct`),
  KEY `fk_review_2_idx` (`idUser`),
  CONSTRAINT `fk_review_1` FOREIGN KEY (`idProduct`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_review_2` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,1,2,'Davvero buono!!!'),(2,1,3,'Da ricomprare...'),(3,1,5,'Non amo molto il pesce');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(64) NOT NULL,
  `email` varchar(100) NOT NULL,
  `score` int NOT NULL DEFAULT '0',
  `isBanned` tinyint NOT NULL DEFAULT '0',
  `isAdmin` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918','admin@user.it',0,0,1),(2,'alice','d74ff0ee8da3b9806b18c877dbf29bbde50b5bd8e4dad7a3a725000feb82e8f1','alice@user.it',9,0,0),(3,'bob','d74ff0ee8da3b9806b18c877dbf29bbde50b5bd8e4dad7a3a725000feb82e8f1','bob@user.it',0,0,0),(4,'carlo','d74ff0ee8da3b9806b18c877dbf29bbde50b5bd8e4dad7a3a725000feb82e8f1','carlo@user.it',0,0,0),(5,'dario','d74ff0ee8da3b9806b18c877dbf29bbde50b5bd8e4dad7a3a725000feb82e8f1','dario@user.it',0,0,0),(6,'ercole','d74ff0ee8da3b9806b18c877dbf29bbde50b5bd8e4dad7a3a725000feb82e8f1','ercole@user.it',0,0,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-25  0:57:48
