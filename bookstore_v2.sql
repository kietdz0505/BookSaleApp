-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: saledb
-- ------------------------------------------------------
-- Server version	8.4.2

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
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `first_name` varchar(15) COLLATE utf8mb4_vi_0900_as_cs NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_vi_0900_as_cs NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_as_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES ('Fujiko','Fujio',1),('Paulo','Coelho',2),('Mộc','Trầm',3),('Andrea','Hirata',4),('Satoshi','Yamamoto',5),('Nhiều ','Tác Giả',6),('Liberty ','Vittert',7),('Dale ','Carnegie',8);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `name` varchar(50) COLLATE utf8mb4_vi_0900_as_cs DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_as_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES ('Giáo dục',2),('Sách Khoa Học',4),('Tâm lý',6),('Tiểu thuyết',3),('Truyện tranh',1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `content` varchar(255) COLLATE utf8mb4_vi_0900_as_cs NOT NULL,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_as_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES ('Hay nên đọc qua',5,5,'2024-12-07 15:02:18',18),('Hình ảnh đẹp nên mua!!!',5,5,'2024-12-07 15:23:59',19),('Xuất sắc',5,5,'2024-12-07 15:26:19',20),('cốt truyện rất hay !!!',5,5,'2024-12-07 15:40:57',21),('Quá đỉnh!!!',5,5,'2024-12-07 15:40:57',22),('Siêu hay',5,5,'2024-12-07 15:40:57',23),('cũng tạm',5,5,'2024-12-07 15:40:57',24),('Rất hay',2,6,'2024-12-07 16:20:14',25),('Tốt\n',5,6,'2024-12-07 17:07:01',26),('Hay quá!!!',6,5,'2024-12-09 17:12:09',27),('hay!!!',14,5,'2024-12-23 15:01:14',28),('tốt!',15,5,'2024-12-23 15:01:14',29),('Quá hay',21,8,'2024-12-23 16:28:42',31),('good job!!! :)',17,8,'2024-12-23 16:28:42',32),('hay quá',21,12,'2024-12-25 12:51:28',33),('quá hay!!!',11,8,'2024-12-25 12:51:28',34),('hay waaa',7,8,'2024-12-30 07:24:35',35),('',14,8,'2025-03-13 14:46:03',36);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `name` text COLLATE utf8mb4_vi_0900_as_cs,
  `description` text COLLATE utf8mb4_vi_0900_as_cs,
  `price` float DEFAULT NULL,
  `image` text COLLATE utf8mb4_vi_0900_as_cs,
  `active` tinyint(1) DEFAULT NULL,
  `category_id` int NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `publisher_id` int DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `fk_publisher` (`publisher_id`),
  KEY `fk_author` (`author_id`),
  CONSTRAINT `fk_author` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_publisher` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `product_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_as_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('Doraemon - Tranh Truyện Màu - Đội Quân Doraemon - Đại Chiến Thuật Côn Trùng (Tái Bản 2024)','Doraemon - Tranh Truyện Màu - Đội Quân Doraemon - Đại Chiến Thuật Côn Trùng\r\n\r\nCâu chuyện kể về chuyến dã ngoại lí thú trước khi tốt nghiệp Trường đào tạo robot của nhóm bạn Doraemon. Thử thách trong ngày cuối cùng của chuyến đi cũng chính là bài thi tốt nghiệp. Mỗi học sinh phải tự chọn lấy một con robot côn trùng làm bạn đồng hành và tìm đường trở về trước hoàng hôn. Ai về trễ, người đó sẽ bị trượt tốt nghiệp! Liệu nhóm Doraemon có thể vượt qua thử thách này không, chúng ta cùng theo dõi nhé! Đây là phiên bản tranh truyện màu được vẽ lại từ tập phim hoạt hình cùng tên của tác giả Fujiko F Fujio.',23400,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733214147/doraemon-tranh-truyen-mau_doi-quan-doraemon_dai-chien-thuat-con-trung_tb-2024_mxmhc3.jpg',1,1,'2024-11-29 17:17:04',1,1,1,514),('Doraemon - Tranh Truyện Màu - Đội Quân Doraemon - Chuyến Tàu Lửa Tốc Hành (Tái Bản 2023)','Doraemon Tranh Truyện Màu - Đội Quân Doraemon - Chuyến Tàu Lửa Tốc Hành\r\n\r\nViên nhộng năng lượng đột nhiên bị đánh cắp khỏi Trung tâm năng lượng khiến mọi hoạt động của thành phố tương lai đều bị ngưng trệ. Đội quân Doraemon nhận nhiệm vụ áp tải viên nhộng dự bị đến Trung tâm năng lượng trên một chiếc tàu hỏa cổ lỗ có tên là \"Roko\". Suốt cuộc hành trình, nhà khoa học xấu xa Achimov đã dùng mọi thủ đoạn phá hoại... Liệu Đội quân Doraemon có hoàn thành nhiệm vụ hay không, chúng ta hãy cùng theo dõi nhé! Đây là phiên bản tranh truyện màu được vẽ lại từ tập phim hoạt hình cùng tên của tác giả Fujiko.F.Fujio.',23400,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733216178/doraemon-tranh-truyen-mau_doi-quan-doraemon_chuyen-tau-lua-toc-hanh-_tb-2023_r79apz.webp',1,1,'2024-11-29 17:17:04',2,1,1,231),('Doraemon - Tranh Truyện Màu - Năm 2112 Doraemon - Ra Đời (Tái Bản 2023)','Doraemon Tranh Truyện Màu - Năm 2112 Doraemon Ra Đời\r\n\r\nBan đầu cơ thể Doraemon màu vàng? Ban đầu Doraemon có tai?...\r\n\r\nTác phẩm này bật mí rất nhiều những bí mật về Doraemon lúc mèo ú chưa đến với Nobita.\r\n\r\nCâu chuyện kể về quãng thời gian khi mèo máy Doraemon học cùng các thành viên Đội quân Doraemon tại Trường đào tạo Robot, về tình bạn thân thiết giưã Doraeom và Sewashi – chắt của Nobita với những tiếng cười, những giọt nước mắt đầy cảm động…\r\n\r\nĐây là phiên bản truyện tranh màu được vẽ lại từ tập phim hoạt hình cùng tên của tác giả FUJIKO FUJIO.\r\n\r\nTÁC GIẢ - HỌA SĨ FUJIKO F FUJIO\r\n\r\nTên thật là Fujimoto Hiroshi. Ông sinh ngày 1 tháng 12 năm 1933 tại tỉnh Toyama, Nhật Bản. Năm 1951 ông cho ra đời tác phẩm đầu tay “Thiên thần Tama” (đăng dài kì trên báo học sinh tiểu học hằng ngày).\r\n\r\nSau đó, ông công bố các tác phẩm sáng tác cùng Abiko Motoo với bút danh “Fujiko Fujio”.\r\n\r\nNăm 1987, ông ngừng hợp tác với Abiko, lấy bút danh là FUJIKO F FUJIO và bắt đầu chuyển sang sáng tác truyện tranh hướng tới đối tượng nhi đồng.\r\n\r\nNhững tác phẩm tiêu biểu nhất có thể kể đến là “Doraemon”, “Con ma Q-taro (chung bút danh)”, “Perman-Cậu bé siêu nhân”, “Cuốn từ điển kì bí”, “Siêu nhân Mami”…',23400,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733216334/doraemon-tranh-truyen-mau_nam-2112-doraemon-ra-doi---tb-2023_pqwwuh.webp',1,1,'2024-11-29 17:17:04',3,1,1,224),('Doraemon - Movie Story Màu - Nobita Và Hòn Đảo Diệu Kì - Cuộc Phiêu Lưu Của Loài Thú','Doraemon - Movie Story Màu - Nobita Và Hòn Đảo Diệu Kì - Cuộc Phiêu Lưu Của Loài Thú\r\n\r\nNhóm Nobita đến thăm hòn đảo bí ẩn, nơi bảo vệ các loài động vật bị tuyệt chủng. Hòn đảo đó được bảo vệ bởi sức mạnh của con bọ hung sừng chữ Y hoàng kim có tên gọi “Golden Hercules”. Trên hòn đảo, nhóm bạn gặp Dakke, một cậu bé bí ẩn trông giống hệt Nobita. Nhưng một thương nhân xấu xa tên Sharman muốn cướp con bọ hung hoàng kim xuất hiện, gây ra cuộc đại chiến. Các cậu, chúng ta hãy dốc hết sức bảo vệ hòn đảo của ước mơ và hi vọng!',32550,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733216511/doraemon-movie-story-mau_nobita-va-hon-dao-dieu-ki_cuoc-phieu-luu-cua-loai-thu_eunpvb.webp',1,1,'2024-11-29 17:17:04',4,1,1,788),('Doraemon - Movie Story Màu - Nobita Và Cuộc Đại Thủy Chiến Ở Xứ Sở Người Cá','Doraemon - Movie Story Màu - Nobita Và Cuộc Đại Thủy Chiến Ở Xứ Sở Người Cá\r\n\r\nDoraemon đã dùng bảo bối “máy bơm mô phỏng mặt nước giả tưởng” để biến cả thành phố nơi Nobita đang sống chìm xuống đáy biển. Sau khi phải rời khỏi hành tinh Aqua, cư dân tộc người cá đã đáp xuống Trái Đất và âm thầm sống dưới đáy biển. Một ngày, công chúa Sophia đã vô tình bơi lạc vào vùng biển giả tưởng của Nobita…\r\n\r\nPhát hiện ra nơi ẩn náu của tộc người cá, Buikin và bè lũ quái vật người cá xuất hiện tấn công họ. Và cuộc đại thủy chiến liên quan đến thanh gươm truyền thuyết của tộc người cá bùng nổ!!!',30800,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733216699/doraemon-movie-story-mau_nobita-va-cuoc-dai-thuy-chien-o-xu-so-nguoi-ca_bia_zbdkeu.webp',1,1,'2024-11-29 17:17:04',5,1,1,653),('Doraemon - Movie Story Màu - Tân Nobita Và Lịch Sử Khai Phá Vũ Trụ','Doraemon - Movie Story Màu - Tân Nobita Và Lịch Sử Khai Phá Vũ Trụ\r\n\r\nNgày nọ, Nobita và Doraemon tình cờ tìm thấy và giải cứu 2 người cư dân của hành tinh Koyakoya là Roppuru và Chamy đang bị nạn thông qua cửa không gian dưới nền nhà căn phòng của Nobita do thời-không gian bị bóp méo. Do sân bóng của nhóm bạn Nobita bị các anh lớp lớn tranh mất nên cậu đã nảy ra ý tưởng rủ các bạn đi qua cánh cửa không gian đến hành tinh Koyakoya để thỏa thích chơi đùa. Tại đây, họ được biết hành tinh Koyakoya đang bị bọn cai mỏ Galtite lộng hành phá phách. Nobita và nhóm bạn sẽ làm thế nào để giải cứu hành tinh Koyakoya...!',32550,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733216792/doraemon-movie-story-mau_tan-nobita-v_-lich-su-khai-pha-vu-tru_bia_wakuhm.webp',1,1,'2024-11-29 17:17:04',6,1,1,344),('Doraemon - Movie Story Màu - Nobita Và Bản Giao Hưởng Địa Cầu','Doraemon - Tiểu Thuyết - Nobita Và Bản Giao Hưởng Địa Cầu\r\n\r\nNobita đang tập sáo để chuẩn bị cho buổi hòa nhạc ở trường thì bất ngờ gặp cô bé Micca bí ẩn có giọng hát tuyệt vời. Micca rất thích nốt No nhẹ nhõm vô ưu Nobita thổi, bèn mời nhóm bạn đến Cung Điện Farre kì lạ, nơi sử dụng âm nhạc làm năng lượng. Cung Điện “ngủ đông” vì cạn nhiên liệu, và Micca đang tìm kiếm bậc thầy âm nhạc để cùng trình diễn nhằm hồi sinh nó. Doraemon và nhóm bạn địa cầu dùng bảo bối chứng chỉ chuyên viên âm nhạc để chọn nhạc cụ diễn tấu với Micca. Cung Điện Farre vừa dần phục hồi thì...\r\n\r\n---\r\n\r\nTác giả FUJIKO F FUJIO tên thật là Hiroshi Fujimoto. Ông sinh ngày 1 tháng 12 năm 1933 tại thành phố Takaoka, tỉnh Toyama, Nhật Bản. Năm 1951, ông ra mắt sự nghiệp họa sĩ truyện tranh với tác phẩm “Thiên thần Tama”. Khi lấy bút danh Fujiko F Fujio, ông liên tục sáng tác xoay quanh nhân vật “Doraemon”, kiến tạo nên một kỉ nguyên mới của truyện tranh thiếu nhi. Những tác phẩm tiêu biểu của ông bao gồm: “Doraemon”, “Con ma Q-Taro (đồng tác giả)”, “Perman - Cậu bé siêu nhân”, “Cuốn từ điển kì bí”, “Siêu nhân Mami” và “Tuyển tập truyện ngắn khoa học viễn tưởng”. Tháng 9 năm 2011, “FUJIKO·F·FUJIO MUSEUM” đã được khai trương ở thành phố Kawasaki. Đây là bảo tàng nghệ thuật tôn vinh Fujiko F Fujio, trưng bày những bức tranh gốc do chính ông từng chấp bút.\r\n\r\nTERUKO UTSUMI sinh ngày 6 tháng 12, quê Kyoto, là đồng đại diện của hãng phim hoạt hình Lapin Track, biên soạn và viết kịch bản cho các bộ phim hoạt hình chiếu trên truyền hình Nhật như Sarazanmai và RymansClub',34298,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733217031/doraemon-movie-story-mau_nobita-va-ban-giao-huong-dia-cau_bia_lqtzjf.webp',1,1,'2024-11-29 17:17:04',7,1,1,339),('Doraemon - Movie Story Màu - Tân Nobita Và Nước Nhật Thời Nguyên Thủy','Doraemon - Movie Story Màu - Tân Nobita Và Nước Nhật Thời Nguyên Thủy\r\n\r\nNobita học hành bết bát nên luôn bị mẹ mắng. Vì kết quả kiểm tra quá tệ, cậu bị cấm đọc truyện, xem phim và không được đi đâu chơi! Trùng hợp thay, cả nhóm đồng lòng bỏ nhà đến Nhật Bản 70.000 năm trước đi bụi! Chuyến phiêu lưu li kì nào đang chờ họ ở đó…!?',32550,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733217124/doraemon-movie-story-mau_tan-nobita-va-nuoc-nhat-thoi-nguyen-thuy_bia_x2ftxs.webp',1,1,'2024-11-29 17:17:04',8,1,1,531),('Pokémon Đặc Biệt - Tập 62','Pokémon Đặc Biệt - Tập 62\r\n\r\nKịch bản cực kì ấn tượng “Episode Δ” trong “ΩRuby αSapphire” sẽ được chuyển thể thành truyện tranh với tên gọi Pokémon Đặc biệt chương 13!! “Khủng hoảng ngôi sao” mà 3 chủ nhân Từ điển Pokémon vùng Hoenn phải đối mặt là gì!? Đồng hồ đếm ngược bắt đầu chạy! Chỉ còn 10 ngày nữa thôi…!!!',23250,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733217539/pokemon-dac-biet_bia_tap-62_iwzcm1.webp',1,1,'2024-11-29 17:17:04',9,1,5,157),('ポケットモンスタースペシャル 64 - Pokémon Special 64','ポケットモンスタースペシャル 64 - Pokémon Special 64\r\n\r\n竜神降臨!星を守るのは伝承か?科学か?\r\n\r\n巨大隕石衝突まで…あと4日! ゲンシカイキしたグラードン、カイオーガの力によって隕石に対抗しようとするマツブサ、アオギリの策に対し、ルビーは“竜神様”レックウザの捜索へ! 迫るタイムリミット! 最後の決断は…!?',198000,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733217627/9784091435859_b79dxa.webp',1,1,'2024-11-29 17:17:04',10,1,5,323),('Nhà Giả Kim (Tái Bản 2020)','Tất cả những trải nghiệm trong chuyến phiêu du theo đuổi vận mệnh của mình đã giúp Santiago thấu hiểu được ý nghĩa sâu xa nhất của hạnh phúc, hòa hợp với vũ trụ và con người. \r\n\r\nTiểu thuyết Nhà giả kim của Paulo Coelho như một câu chuyện cổ tích giản dị, nhân ái, giàu chất thơ, thấm đẫm những minh triết huyền bí của phương Đông. Trong lần xuất bản đầu tiên tại Brazil vào năm 1988, sách chỉ bán được 900 bản. Nhưng, với số phận đặc biệt của cuốn sách dành cho toàn nhân loại, vượt ra ngoài biên giới quốc gia, Nhà giả kim đã làm rung động hàng triệu tâm hồn, trở thành một trong những cuốn sách bán chạy nhất mọi thời đại, và có thể làm thay đổi cuộc đời người đọc.\r\n\r\n“Nhưng nhà luyện kim đan không quan tâm mấy đến những điều ấy. Ông đã từng thấy nhiều người đến rồi đi, trong khi ốc đảo và sa mạc vẫn là ốc đảo và sa mạc. Ông đã thấy vua chúa và kẻ ăn xin đi qua biển cát này, cái biển cát thường xuyên thay hình đổi dạng vì gió thổi nhưng vẫn mãi mãi là biển cát mà ông đã biết từ thuở nhỏ. Tuy vậy, tự đáy lòng mình, ông không thể không cảm thấy vui trước hạnh phúc của mỗi người lữ khách, sau bao ngày chỉ có cát vàng với trời xanh nay được thấy chà là xanh tươi hiện ra trước mắt. ‘Có thể Thượng đế tạo ra sa mạc chỉ để cho con người biết quý trọng cây chà là,’ ông nghĩ.”\r\n\r\n- Trích Nhà giả kim',59249,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733217795/image_195509_1_36793_x9j8a6.webp',1,3,'2024-11-29 17:17:04',11,4,2,169),('Lén Nhặt Chuyện Đời','Lén Nhặt Chuyện Đời\r\n\r\nTại vùng ngoại ô xứ Đan Mạch xưa, người thợ kim hoàn Per Enevoldsen đã cho ra mắt một món đồ trang sức lấy ý tưởng từ Pandora - người phụ nữ đầu tiên của nhân loại mang vẻ đẹp như một ngọc nữ phù dung, kiêu sa và bí ẩn trong Thần thoại Hy Lạp. Vòng Pandora được kết hợp từ một sợi dây bằng vàng, bạc hoặc bằng da cùng với những viên charm được chế tác đa dạng, tỉ mỉ. Ý tưởng của ông, mỗi viên charm như một câu chuyện, một kỷ niệm đáng nhớ của người sở hữu chiếc vòng. Khi một viên charm được thêm vào sợi Pandora là cuộc đời lại có thêm một ký ức cần lưu lại để nhớ, để thương, để trân trọng. Lén nhặt chuyện đời ra mắt trong khoảng thời gian chông chênh nhất của bản thân, hay nói cách khác là một cậu bé mới lớn, vừa bước ra khỏi cái vỏ bọc vốn an toàn của mình. Những câu chuyện trong Lén nhặt chuyện đời là những câu chuyện tôi được nghe kể lại, hoặc vô tình bắt gặp, hoặc nhặt nhạnh ở đâu đó trong miền ký ức rời rạc của quá khứ, không theo một trình tự hay một thời gian nào nhất định.\r\n\r\nMỗi một câu chuyện là một viên charm lấp lánh, kiêu kỳ, có sức hút mạnh mẽ đối với một người trẻ như tôi luôn tò mò với những điều dung dị trong cuộc sống. Tôi âm thầm nhặt những viên charm ấy về, kết thành sợi Pandora cho chính mình. Lén ở đây không phải là một cái gì đó vụng trộm, âm thầm sợ người khác phát hiện. Mà nó là lặng lẽ. Tôi lặng lẽ nghe, lặng lẽ quan sát, lặng lẽ đi tìm và lặng lẽ viết nên quyển sách này. Tôi vẫn thích dùng từ Lén hơn, vì đơn giản, tôi thấy bản thân mình trong đó. Lén nhặt chuyện đời được chia thành năm chương: chương thứ nhất nói về tình yêu của cả giới trẻ và người tu sĩ; chương thứ hai viết về gia đình; chương thứ ba dành cho những người trẻ; chương thứ tư là những câu chuyện bên đời, những bài tâm sự của người tu sĩ; chương năm là thơ và chương cuối cùng là tâm sự của bản thân khi tôi đã về già. Nếu ai nghĩ Lén nhặt chuyện đời sẽ giảng thuyết về chân lý, định hướng cho người trẻ hay chữa lành những vết thương… thì đã tìm sai chỗ, bản thân chưa bao giờ nghĩ quyển sách này sẽ làm được điều đó.\r\n\r\nĐây chỉ là những câu chuyện, những suy nghĩ về cuộc đời của một người trẻ đang chông chênh. Đôi khi, tôi hóa thành một ông già của năm chục năm sau kể về những ký ức thời vụng dại. Chỉ mong sao, đọc Lén nhặt chuyện đời, người ta có thể tìm được đâu đó những viên charm phù hợp với bản thân mình. Quyển sách này sẽ là dấu ấn lớn nhất đối với cuộc đời của bản thân. Mỗi bài viết là một viên charm của Pandora Lén nhặt chuyện đời và Lén nhặt chuyện đời cũng sẽ là một viên charm lấp lánh trong sợi Pandora của cuộc đời tôi. Quyển sách này, xin được nhớ về những người Thầy của tôi, về Từ Quang, về gia đình, và tất cả những ai đã hiện diện trong thời thanh xuân của tôi. Để nhắc rằng, tôi đã từng có mặt trong cuộc đời của họ, và họ có mặt trong quyển sách này của tôi.\r\n\r\nCảm ơn đã tìm đến sợi Pandora Lén nhặt chuyện đời, và nào, hãy cùng tôi bắt đầu đi tìm những viên charm, nhặt lên và xâu vào sợi Pandora của mình thôi!',42498,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733217868/9786043651591_1_a6otob.webp',1,3,'2024-11-29 17:17:04',12,2,3,244),('Bài Tập Khoa Học Tự Nhiên 6 (Chân Trời Sáng Tạo) (Chuẩn)','Bài Tập Khoa Học Tự Nhiên 6 (Chân Trời Sáng Tạo) (Chuẩn)',19995,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733218031/9786040287748_1_lmltve.webp',1,2,'2024-11-29 17:17:04',14,3,6,280),('Tiếng Anh 12 Friends Global - Workbook','Tiếng Anh 12 Friends Global - Workbook\r\n\r\nSách bài tập - Tiếng Anh lớp 12 Friends Global do Nhà xuất bản Giáo dục Việt Nam tổ chức biên soạn theo Chương trình Giáo dục phổ thông môn Tiếng Anh cấp Trung học cơ sở.\r\n\r\nVới phương châm “Developing a global outlook – Vươn tầm thế giới”, Sách giáo khoa Tiếng Anh 12 Friends Global góp phần nâng cao chất lượng hoạt động giáo dục toàn diện về năng lực, phẩm chất, kĩ năng giúp các em phát triển và hội nhập trong thời đại mới. Nội dung các bài nghe, bài đọc hấp dẫn, phù hợp đặc điểm học sinh lớp 12 với mục tiêu phát triển năng lực ngôn ngữ và năng lực giao tiếp.\r\n\r\nCập nhật các thành tựu khoa học mới liên quan đến Chương trình tiếng Anh lớp 12, đáp ứng yêu cầu hội nhập quốc tế và phù hợp với mục tiêu của Chương trình môn học, hoạt động giáo dục.',79000,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733218107/9786040403261_rlv8ye.webp',1,2,'2024-11-29 17:17:04',15,3,6,212),('Toán 6 - Tập 1 (Chân Trời Sáng Tạo) (Chuẩn)','Toán 6 - Tập 1 (Chân Trời Sáng Tạo) (Chuẩn)',16999,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733218231/9786040288332_1_km8hw9.webp',1,2,'2024-11-29 17:17:04',16,3,6,550),('Chiến Binh Cầu Vồng (Tái Bản 2020)','Một tác phẩm có tầm ảnh hưởng sâu rộng nhất Indonesia\r\n\r\n“Thầy Harfan và cô Mus nghèo khổ đã mang đến cho tôi tuổi thơ đẹp nhất, tình bạn đẹp nhất, và tâm hồn phong phú, một thứ gì đó vô giá, thậm chí còn có giá trị hơn những khao khát mơ ước. Có thể tôi lầm, nhưng theo ý tôi, đây thật sự là hơi thở của giáo dục và linh hồn của một chốn được gọi là trường học.” - (Trích tác phẩm)\r\n\r\n***\r\n\r\nTrong ngày khai giảng, nhờ sự xuất hiện vào phút chót của cậu bé thiểu năng trí tuệ Harun, trường Muhammadiyah may mắn thoát khỏi nguy cơ đóng cửa. Nhưng ước mơ dạy và học trong ngôi trường Hồi giáo ấy liệu sẽ đi về đâu, khi ngôi trường xập xệ dường như sẵn sàng sụp xuống bất cứ lúc nào, khi lời đe dọa đóng cửa từ viên thanh tra giáo dục luôn lơ lửng trên đầu, khi những cỗ máy xúc hung dữ đang chực chờ xới tung ngôi trường để dò mạch thiếc…? Và liệu niềm đam mê học tập của những Chiến binh Cầu vồng đó có đủ sức chinh phục quãng đường ngày ngày đạp xe bốn mươi cây số, rồi đầm cá sấu lúc nhúc bọn ăn thịt người, chưa kể sự mê hoặc từ những chuyến phiêu lưu chết người theo tiếng gọi của ngài pháp sư bí ẩn trên đảo Hải Tặc, cùng sức cám dỗ khôn cưỡng từ những đồng tiền còm kiếm được nhờ công việc cu li toàn thời gian ...?\r\n\r\nChiến binh Cầu vồng có cả tình yêu trong sáng tuổi học trò lẫn những trò đùa tinh quái, cả nước mắt lẫn tiếng cười – một bức tranh chân thực về hố sâu ngăn cách giàu nghèo, một tác phẩm văn học cảm động truyền tải sâu sắc nhất ý nghĩa đích thực của việc làm thầy, việc làm trò và việc học.\r\n\r\nTác phẩm đã bán được trên năm triệu bản, được dịch ra 26 thứ tiếng, là một trong những đại diện xuất sắc nhất của  văn học Indonesia hiện đại.',89380,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1733218317/image_195509_1_36366_xxcxee.webp',1,3,'2024-12-02 14:42:48',17,4,4,427),('Tiếng Việt 1 - Tập 2 (Kết Nối Tri Thức) (Chuẩn)','Tiếng Việt 1 - Tập 2 (Kết Nối Tri Thức) (Chuẩn)',25000,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1734943054/9786040287298_1_ibqiiw.webp',1,2,'2024-12-23 15:26:10',20,3,6,140),('30 Giây Khoa Học - 30 Giây Khoa Học Dữ Liệu','30 Giây Khoa Học - 30 Giây Khoa Học Dữ Liệu\r\n\r\nKhoa học dữ liệu (Data science) là một hệ sinh thái nhân tạo mới trong kỉ nguyên thông tin hiện đại, bao gồm từ việc tìm ra tội phạm đến dự đoán dịch bệnh. Nhưng bạn có biết rằng nó không phải chỉ là lượng thông tin khổng lồ được thu thập bởi máy tính, điện thoại thông minh và thẻ tín dụng?\r\n\r\n30 Giây Khoa học dữ liệu bao gồm các nguyên tắc thống kê cơ bản thúc đẩy các thuật toán và cách thức dữ liệu ảnh hưởng đến chúng ta trong mọi lĩnh vực khoa học, xã hội, kinh doanh, giải trí - cùng với các vấn đề đạo đức và lời hứa về một thế giới tốt đẹp hơn trong tương lai. Mỗi đoạn văn 30 giây trình bày chi tiết một khía cạnh của khoa học dữ liệu chỉ trong khoảng 300 từ và một hình minh họa, miêu tả làm thế nào để thu thập các loại dữ liệu khác nhau và sử dụng các chương trình máy tính để tìm ra các qui luật mà mắt người không thể phát hiện ra, góp phần làm thay đổi thế giới. Tìm hiểu những ý tưởng và tiểu sử của những vĩ nhân đằng sau chúng, 30 giây Khoa học dữ liệu là cách nhanh nhất để khám phá cách dữ liệu ảnh hưởng mạnh mẽ đến các vấn đề lớn như biến đổi khí hậu, chăm sóc sức khỏe và cả những chi tiết nhỏ trong cuộc sống hàng ngày của chúng ta.\r\n\r\nLiberty Vittert là Giáo sư Khoa học Dữ liệu tại Trường Olin Business thuộc Đại học Washington, St Louis. Với tư cách là đại sứ của Hiệp hội Thống kê Hoàng gia, nữ chuyên gia của BBC và là thành viên được bầu chọn của Viện Thống kê Quốc tế, Liberty làm việc hết mình để phổ cập Khoa học thống kê và dữ liệu đến cho công chúng. Cô cũng là Phó biên tập cho Tạp chí Harvard Data Science Review và là thành viên Hoa Kì trong Hội đồng quản trị của Tổ chức Người tị nạn Liên hợp quốc (UNHCR).',139500,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1734943338/30-giay-khoa-hoc_khoa-hoc-du-lieu_dnj1ta.webp',1,4,'2024-12-23 15:26:10',21,1,7,94),('Thao Túng Tâm Lý Đám Đông','THAO TÚNG TÂM LÝ ĐÁM ĐÔNG - NGHỆ THUẬT LÀM CHỦ MỌI CUỘC DIỄN THUYẾT VÀ TRỞ THÀNH NGƯỜI CẦM TRỊCH TRONG MỌI CUỘC GIAO TIẾP.\r\n\r\n“Thao túng tâm lý đám đông” - Một cuốn sách xuất sắc trong sự nghiệp của Bậc thầy giao tiếp Dale Carnegie, là cuốn sách bổ trợ quan trọng cho những ai đã, đang và sẽ đọc “Đắc nhân tâm”.\r\n\r\nCuốn sách chỉ cho chúng ta rằng, nghệ thuật giao tiếp không phải bạn nói được bao nhiêu mỹ từ, vẽ ra được bao nhiêu viễn cảnh, mà quan trọng là nếu bạn muốn lấy được nước mắt của người nghe thì bạn phải cho họ thấy được sự đau khổ chân thực, nếu bạn muốn thuyết phục ai đó tin vào luận điểm của bạn thì bạn phải sử dụng hệ thống dữ kiện thực tế và gần gũi với những người nghe ấy.\r\n\r\nVà một sai lầm đáng lưu ý mà nhiều người mắc phải là bỏ qua việc chuẩn bị trước. Làm sao người ta có thể hy vọng kiềm chế nỗi sợ hãi của những người lính phải ra trận mà không được trang bị vũ khí? Tương tự như vậy, không có gì ngạc nhiên khi diễn giả không thực sự thoải mái trước khán giả do không có sự chuẩn bị. Lincoln từng nói tại Nhà Trắng: “Tôi tin rằng tôi sẽ không bao giờ đủ tự tin để nói trước công chúng mà không có sự chuẩn bị nào cả. Tôi sẽ cảm thấy xấu hổ đến chết đi được”.\r\n\r\nViệc chuẩn bị thực sự cho một bài phát biểu có nghĩa là bạn cần tập hợp những điều được viết ra và ghi nhớ? Không, nó có nghĩa là sự tập hợp những suy nghĩ của bạn, những ý tưởng của bạn, niềm tin của bạn, những thôi thúc trong tim bạn. Với những suy nghĩ như vậy, mỗi ngày bạn nuôi dưỡng nó, ăn ngủ cùng nó, thậm chí đi cả vào giấc mơ. Trong bạn tràn ngập cảm xúc và trải nghiệm. Điều này nằm sâu trong tiềm thức của bạn như những viên sỏi trên bờ biển. Đó chính là sự chuẩn bị thực sự có ý nghĩa - là suy nghĩ, nghiền ngẫm, nhớ lại, chọn lọc những điều hấp dẫn, sau đó mài giũa chúng, biến chúng thành một bức tranh lung linh của riêng bạn.\r\n\r\nĐừng chỉ phát biểu cho qua chuyện, cho hết giờ. Một bài phát biểu cần được phát triển dựa trên lựa chọn chủ đề từ đầu tuần, và suy nghĩ về nó trong suốt những ngày còn lại của tuần đó. Nghiền ngẫm về nó, ăn ngủ và thậm chí mơ về nó. Thảo luận về nó với bạn bè. Hãy biến nó thành một chủ đề trò chuyện. Hãy tự hỏi mình tất cả các câu hỏi liên quan. Bạn cần sống cùng với câu chuyện của mình, giải pháp nó trong cuộc sống hằng ngày, như thế, bạn mới có thể thực sự làm chủ đám đông sẽ lắng nghe phía dưới.',59000,'https://res.cloudinary.com/dfgnoyf71/image/upload/v1734945740/9786044777962_dnk8bc.webp',1,6,'2024-12-23 16:28:42',22,6,8,147);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher` (
  `name` varchar(50) COLLATE utf8mb4_vi_0900_as_cs NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_as_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES ('CÔNG TY CỔ PHẦN SBOOKS',6),('Kim Đồng',1),('NXB Bộ Giáo Dục và đào tạo',3),('NXB Hội Nhà Văn',4),('Thế Giới',2);
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt`
--

DROP TABLE IF EXISTS `receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt` (
  `created_date` datetime DEFAULT NULL,
  `user_id` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `receipt_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_as_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt`
--

LOCK TABLES `receipt` WRITE;
/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
INSERT INTO `receipt` VALUES ('2024-01-07 08:35:29',8,12),('2024-02-09 17:12:09',5,13),('2024-03-20 17:13:22',5,14),('2024-04-22 16:26:35',5,15),('2024-05-22 16:29:58',5,16),('2024-06-22 16:29:58',5,17),('2024-07-23 16:28:42',8,18),('2024-08-24 14:00:07',6,19),('2024-09-24 15:08:54',8,20),('2024-10-24 15:29:17',8,21),('2024-11-24 15:44:45',8,22),('2024-12-24 15:44:45',8,23),('2024-12-25 12:51:28',12,24),('2024-12-25 12:51:28',12,25),('2024-12-29 14:56:33',5,31),('2024-12-29 14:56:33',5,32),('2024-12-29 14:56:33',5,36),('2024-12-29 14:59:51',5,37);
/*!40000 ALTER TABLE `receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt_detail`
--

DROP TABLE IF EXISTS `receipt_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt_detail` (
  `receipt_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` float DEFAULT NULL,
  PRIMARY KEY (`receipt_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `receipt_detail_ibfk_1` FOREIGN KEY (`receipt_id`) REFERENCES `receipt` (`id`),
  CONSTRAINT `receipt_detail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_as_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt_detail`
--

LOCK TABLES `receipt_detail` WRITE;
/*!40000 ALTER TABLE `receipt_detail` DISABLE KEYS */;
INSERT INTO `receipt_detail` VALUES (12,1,1,23400),(12,2,1,23400),(12,3,1,23400),(12,4,1,32550),(12,5,1,30800),(12,6,1,32550),(12,7,1,34298),(12,8,1,32550),(12,9,1,23250),(12,10,1,198000),(12,11,1,59249),(12,12,1,42498),(12,14,1,19997),(12,15,1,79000),(12,16,1,17000),(12,17,1,89380),(13,1,4,23400),(13,2,3,23400),(13,3,2,23400),(13,4,1,32550),(13,5,2,30800),(13,6,1,32550),(13,7,1,34298),(14,3,16,23400),(15,2,2,23400),(16,15,4,79000),(17,1,4,23400),(18,1,1,23400),(18,2,1,23400),(18,3,1,23400),(18,4,1,32550),(18,5,1,30800),(18,6,1,32550),(18,7,1,34298),(18,8,1,32550),(18,11,1,59249),(18,12,1,42498),(18,14,10,19997),(18,15,13,79000),(18,16,11,17000),(18,17,1,89380),(18,20,5,25000),(18,21,3,139500),(18,22,3,59000),(19,21,7,139500),(20,14,5,19997),(20,17,4,89380),(20,21,6,139500),(21,21,5,139500),(22,9,1,23250),(22,10,1,198000),(23,14,10,19997),(23,15,5,79000),(23,16,5,17000),(23,20,5,25000),(24,21,10,139500),(25,14,11,19997),(31,21,10,139500),(32,14,5,19995),(36,21,9,139500),(37,21,6,139500);
/*!40000 ALTER TABLE `receipt_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `name` varchar(50) COLLATE utf8mb4_vi_0900_as_cs NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_vi_0900_as_cs NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_vi_0900_as_cs NOT NULL,
  `avatar` varchar(100) COLLATE utf8mb4_vi_0900_as_cs DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_vi_0900_as_cs DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `joined_date` datetime DEFAULT NULL,
  `user_role` enum('ADMIN','USER','NHAN_VIEN') COLLATE utf8mb4_vi_0900_as_cs DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_as_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('Nguyễn Hữu Khang','huukhang','e10adc3949ba59abbe56e057f20f883e','https://res.cloudinary.com/dfgnoyf71/image/upload/v1732781817/u71j7y3aaouxutmql9nm.png','tgkiet03@gmail.com',1,'2024-11-28 15:10:42','USER',5),('Thạch Gia Kiệt','itiskiet0505','202cb962ac59075b964b07152d234b70','https://res.cloudinary.com/dfgnoyf71/image/upload/v1732781891/bnrke5cexmkd9htaejxk.jpg','tgkiet04@gmail.com',1,'2024-11-28 15:10:42','USER',6),('Administrator','admin','21232f297a57a5a743894a0e4a801fc3','https://res.cloudinary.com/dfgnoyf71/image/upload/v1734948047/default-avatar-user_i1rld9.jpg','tgkiet03@gmail.com',1,'2024-12-02 13:38:20','ADMIN',8),('Nguyễn Tấn Lộc','tanloc','e10adc3949ba59abbe56e057f20f883e','https://res.cloudinary.com/dfgnoyf71/image/upload/v1734948435/kf0bmbuvm3e0buotdigl.jpg','tanloc123@gmail.com',1,'2024-12-23 16:28:42','USER',9),('Dương Hữu Thành','dhthanh','202cb962ac59075b964b07152d234b70','https://res.cloudinary.com/dfgnoyf71/image/upload/v1735106016/no2o1d4wkuws5imohov9.jpg','abc@gmail.com',1,'2024-12-25 12:51:28','USER',12),('aaa','abc','202cb962ac59075b964b07152d234b70','https://res.cloudinary.com/dfgnoyf71/image/upload/v1735377340/zxmmybt4ajb5llrnufbn.jpg','abc@gmail.com',1,'2024-12-28 14:18:17','USER',13),('Thach Gia Kiet','tgkiet04@gmail.com','202cb962ac59075b964b07152d234b70','https://res.cloudinary.com/dfgnoyf71/image/upload/v1735460248/ieuezfvmxg5m6mce5ruc.jpg','tgkiet04@gmail.com',1,'2024-12-29 15:16:47','USER',14);
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

-- Dump completed on 2025-03-13 16:20:57
