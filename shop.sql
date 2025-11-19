/*
 Navicat Premium Dump SQL

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : shop

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 19/11/2025 17:30:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accounts_profile
-- ----------------------------
DROP TABLE IF EXISTS `accounts_profile`;
CREATE TABLE `accounts_profile`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `phone_number` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `accounts_profile_user_id_49a85d32_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accounts_profile
-- ----------------------------
INSERT INTO `accounts_profile` VALUES (13, 'سجاد', 'محمدی نژاد', '09173758588', 'profile/linux-hacker-wallpaper-001.jpg', '2025-09-14 21:18:56.806161', '2025-11-05 21:23:29.698570', 13);
INSERT INTO `accounts_profile` VALUES (14, 'میلاد', 'رنجبر', '09999356730', 'profile/1Programming.jpg', '2025-09-19 11:15:08.838103', '2025-11-17 18:20:15.299684', 14);

-- ----------------------------
-- Table structure for accounts_user
-- ----------------------------
DROP TABLE IF EXISTS `accounts_user`;
CREATE TABLE `accounts_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `type` int NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accounts_user
-- ----------------------------
INSERT INTO `accounts_user` VALUES (13, 'pbkdf2_sha256$1000000$OWOGnPdhkCruKVYxjOVYzK$ie4eyTXlTZQ/x4boWQGdHVYSdDjEvxk016vckRK3ITs=', '2025-11-16 23:42:45.710235', 0, 'ghloo1996@gmail.com', 0, 1, 1, 1, '2025-09-14 21:18:56.797591', '2025-11-17 16:36:51.686663');
INSERT INTO `accounts_user` VALUES (14, 'pbkdf2_sha256$1000000$qlovb8HGtITy7wEqgXZHik$rI0SI5wHPLgNdYEP1XYS1t26AiVKUXk6gB4MTNgbVzw=', '2025-11-12 20:35:53.477844', 1, 'admin@admin.com', 1, 1, 1, 3, '2025-09-19 11:15:08.829905', '2025-10-12 18:50:20.640426');

-- ----------------------------
-- Table structure for accounts_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `accounts_user_groups`;
CREATE TABLE `accounts_user_groups`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `accounts_user_groups_user_id_group_id_59c0b32f_uniq`(`user_id` ASC, `group_id` ASC) USING BTREE,
  INDEX `accounts_user_groups_group_id_bd11a704_fk_auth_group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `accounts_user_groups_group_id_bd11a704_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `accounts_user_groups_user_id_52b62117_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accounts_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for accounts_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `accounts_user_user_permissions`;
CREATE TABLE `accounts_user_user_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq`(`user_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `accounts_user_user_p_permission_id_113bb443_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `accounts_user_user_p_permission_id_113bb443_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `accounts_user_user_p_user_id_e4f0a161_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accounts_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id` ASC, `codename` ASC) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add user', 6, 'add_user');
INSERT INTO `auth_permission` VALUES (22, 'Can change user', 6, 'change_user');
INSERT INTO `auth_permission` VALUES (23, 'Can delete user', 6, 'delete_user');
INSERT INTO `auth_permission` VALUES (24, 'Can view user', 6, 'view_user');
INSERT INTO `auth_permission` VALUES (25, 'Can add profile', 7, 'add_profile');
INSERT INTO `auth_permission` VALUES (26, 'Can change profile', 7, 'change_profile');
INSERT INTO `auth_permission` VALUES (27, 'Can delete profile', 7, 'delete_profile');
INSERT INTO `auth_permission` VALUES (28, 'Can view profile', 7, 'view_profile');
INSERT INTO `auth_permission` VALUES (29, 'Can add category', 8, 'add_category');
INSERT INTO `auth_permission` VALUES (30, 'Can change category', 8, 'change_category');
INSERT INTO `auth_permission` VALUES (31, 'Can delete category', 8, 'delete_category');
INSERT INTO `auth_permission` VALUES (32, 'Can view category', 8, 'view_category');
INSERT INTO `auth_permission` VALUES (33, 'Can add product', 9, 'add_product');
INSERT INTO `auth_permission` VALUES (34, 'Can change product', 9, 'change_product');
INSERT INTO `auth_permission` VALUES (35, 'Can delete product', 9, 'delete_product');
INSERT INTO `auth_permission` VALUES (36, 'Can view product', 9, 'view_product');
INSERT INTO `auth_permission` VALUES (37, 'Can add image', 10, 'add_image');
INSERT INTO `auth_permission` VALUES (38, 'Can change image', 10, 'change_image');
INSERT INTO `auth_permission` VALUES (39, 'Can delete image', 10, 'delete_image');
INSERT INTO `auth_permission` VALUES (40, 'Can view image', 10, 'view_image');
INSERT INTO `auth_permission` VALUES (41, 'Can add wishlist', 11, 'add_wishlist');
INSERT INTO `auth_permission` VALUES (42, 'Can change wishlist', 11, 'change_wishlist');
INSERT INTO `auth_permission` VALUES (43, 'Can delete wishlist', 11, 'delete_wishlist');
INSERT INTO `auth_permission` VALUES (44, 'Can view wishlist', 11, 'view_wishlist');
INSERT INTO `auth_permission` VALUES (45, 'Can add cart', 12, 'add_cart');
INSERT INTO `auth_permission` VALUES (46, 'Can change cart', 12, 'change_cart');
INSERT INTO `auth_permission` VALUES (47, 'Can delete cart', 12, 'delete_cart');
INSERT INTO `auth_permission` VALUES (48, 'Can view cart', 12, 'view_cart');
INSERT INTO `auth_permission` VALUES (49, 'Can add cart item', 13, 'add_cartitem');
INSERT INTO `auth_permission` VALUES (50, 'Can change cart item', 13, 'change_cartitem');
INSERT INTO `auth_permission` VALUES (51, 'Can delete cart item', 13, 'delete_cartitem');
INSERT INTO `auth_permission` VALUES (52, 'Can view cart item', 13, 'view_cartitem');
INSERT INTO `auth_permission` VALUES (53, 'Can add user address', 14, 'add_useraddress');
INSERT INTO `auth_permission` VALUES (54, 'Can change user address', 14, 'change_useraddress');
INSERT INTO `auth_permission` VALUES (55, 'Can delete user address', 14, 'delete_useraddress');
INSERT INTO `auth_permission` VALUES (56, 'Can view user address', 14, 'view_useraddress');
INSERT INTO `auth_permission` VALUES (57, 'Can add coupon', 15, 'add_coupon');
INSERT INTO `auth_permission` VALUES (58, 'Can change coupon', 15, 'change_coupon');
INSERT INTO `auth_permission` VALUES (59, 'Can delete coupon', 15, 'delete_coupon');
INSERT INTO `auth_permission` VALUES (60, 'Can view coupon', 15, 'view_coupon');
INSERT INTO `auth_permission` VALUES (61, 'Can add order item', 16, 'add_orderitem');
INSERT INTO `auth_permission` VALUES (62, 'Can change order item', 16, 'change_orderitem');
INSERT INTO `auth_permission` VALUES (63, 'Can delete order item', 16, 'delete_orderitem');
INSERT INTO `auth_permission` VALUES (64, 'Can view order item', 16, 'view_orderitem');
INSERT INTO `auth_permission` VALUES (65, 'Can add order', 17, 'add_order');
INSERT INTO `auth_permission` VALUES (66, 'Can change order', 17, 'change_order');
INSERT INTO `auth_permission` VALUES (67, 'Can delete order', 17, 'delete_order');
INSERT INTO `auth_permission` VALUES (68, 'Can view order', 17, 'view_order');
INSERT INTO `auth_permission` VALUES (69, 'Can add payment', 18, 'add_payment');
INSERT INTO `auth_permission` VALUES (70, 'Can change payment', 18, 'change_payment');
INSERT INTO `auth_permission` VALUES (71, 'Can delete payment', 18, 'delete_payment');
INSERT INTO `auth_permission` VALUES (72, 'Can view payment', 18, 'view_payment');
INSERT INTO `auth_permission` VALUES (73, 'Can add review', 19, 'add_review');
INSERT INTO `auth_permission` VALUES (74, 'Can change review', 19, 'change_review');
INSERT INTO `auth_permission` VALUES (75, 'Can delete review', 19, 'delete_review');
INSERT INTO `auth_permission` VALUES (76, 'Can view review', 19, 'view_review');
INSERT INTO `auth_permission` VALUES (77, 'Can add footer_text', 20, 'add_footer_text');
INSERT INTO `auth_permission` VALUES (78, 'Can change footer_text', 20, 'change_footer_text');
INSERT INTO `auth_permission` VALUES (79, 'Can delete footer_text', 20, 'delete_footer_text');
INSERT INTO `auth_permission` VALUES (80, 'Can view footer_text', 20, 'view_footer_text');
INSERT INTO `auth_permission` VALUES (81, 'Can add social media', 21, 'add_socialmedia');
INSERT INTO `auth_permission` VALUES (82, 'Can change social media', 21, 'change_socialmedia');
INSERT INTO `auth_permission` VALUES (83, 'Can delete social media', 21, 'delete_socialmedia');
INSERT INTO `auth_permission` VALUES (84, 'Can view social media', 21, 'view_socialmedia');

-- ----------------------------
-- Table structure for cart_cart
-- ----------------------------
DROP TABLE IF EXISTS `cart_cart`;
CREATE TABLE `cart_cart`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cart_cart_user_id_9b4220b9_fk_accounts_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `cart_cart_user_id_9b4220b9_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart_cart
-- ----------------------------
INSERT INTO `cart_cart` VALUES (1, '2025-10-30 19:32:51.172723', '2025-10-30 19:32:51.172723', 14);
INSERT INTO `cart_cart` VALUES (2, '2025-10-31 08:29:46.546813', '2025-10-31 08:29:46.546813', 13);

-- ----------------------------
-- Table structure for cart_cartitem
-- ----------------------------
DROP TABLE IF EXISTS `cart_cartitem`;
CREATE TABLE `cart_cartitem`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int UNSIGNED NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `cart_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cart_cartitem_cart_id_370ad265_fk_cart_cart_id`(`cart_id` ASC) USING BTREE,
  INDEX `cart_cartitem_product_id_b24e265a_fk_shop_product_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `cart_cartitem_cart_id_370ad265_fk_cart_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart_cart` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cart_cartitem_product_id_b24e265a_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cart_cartitem_chk_1` CHECK (`quantity` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart_cartitem
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `content_type_id` int NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id` ASC) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_accounts_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_chk_1` CHECK (`action_flag` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 169 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (11, '2025-09-22 17:19:41.968124', '1', 'لباس', 1, '[{\"added\": {}}]', 8, 14);
INSERT INTO `django_admin_log` VALUES (12, '2025-09-22 17:19:56.554655', '2', 'لب تاپ', 1, '[{\"added\": {}}]', 8, 14);
INSERT INTO `django_admin_log` VALUES (13, '2025-09-22 17:29:31.622899', '1', 'لب تاپ ایسوس تاف گیمینگ', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (14, '2025-09-22 17:31:39.874034', '2', 'لباس برنامه نویسی', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (15, '2025-09-22 17:31:51.287468', '1', 'Image object (1)', 1, '[{\"added\": {}}]', 10, 14);
INSERT INTO `django_admin_log` VALUES (16, '2025-09-22 17:31:57.111043', '2', 'Image object (2)', 1, '[{\"added\": {}}]', 10, 14);
INSERT INTO `django_admin_log` VALUES (17, '2025-09-22 17:43:49.928614', '1', 'لب تاپ ایسوس تاف گیمینگ', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (18, '2025-09-22 17:45:27.090708', '1', 'لب تاپ ایسوس تاف گیمینگ', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (19, '2025-09-22 17:45:37.776514', '1', 'لب تاپ ایسوس تاف گیمینگ', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (20, '2025-09-22 17:57:53.539231', '3', 'لباس برنامه نویسی', 1, '[{\"added\": {}}]', 8, 14);
INSERT INTO `django_admin_log` VALUES (21, '2025-09-22 17:58:03.441014', '2', 'لباس برنامه نویسی', 2, '[{\"changed\": {\"fields\": [\"Category\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (22, '2025-09-22 18:02:34.327881', '2', 'لباس برنامه نویسی', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (23, '2025-09-22 18:04:00.117955', '2', 'لباس برنامه نویسی', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (24, '2025-09-22 18:04:08.800785', '2', 'لباس برنامه نویسی', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (25, '2025-09-22 18:04:16.506281', '2', 'لباس برنامه نویسی', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (26, '2025-09-22 18:04:25.129926', '2', 'لباس برنامه نویسی', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (27, '2025-09-22 18:04:33.489696', '2', 'لباس برنامه نویسی', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (28, '2025-09-22 18:04:52.102821', '2', 'لباس برنامه نویسی', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (29, '2025-09-22 18:05:00.036008', '2', 'لباس برنامه نویسی', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (30, '2025-09-24 19:32:26.456937', '4', 'موبایل', 1, '[{\"added\": {}}]', 8, 14);
INSERT INTO `django_admin_log` VALUES (31, '2025-09-24 19:34:49.126280', '3', 'galaxy s25', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (32, '2025-09-24 19:35:03.847522', '3', 'galaxy s25', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (33, '2025-09-24 19:36:43.540484', '4', 'Galaxy S25 FE', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (34, '2025-09-24 19:39:21.929450', '5', 'اپل iPhone 17', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (35, '2025-09-24 19:40:40.869120', '5', 'اپل iPhone 17', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (36, '2025-09-24 19:46:31.699582', '3', 'Galaxy s25', 2, '[{\"changed\": {\"fields\": [\"Title\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (37, '2025-09-24 21:16:13.551416', '5', 'اپل iPhone 17', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (38, '2025-09-24 21:17:33.760594', '5', 'اپل iPhone 17', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (39, '2025-09-24 21:17:46.666808', '5', 'اپل iPhone 17', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (40, '2025-09-24 21:46:36.090112', '5', 'اپل iPhone 17', 2, '[{\"changed\": {\"fields\": [\"Description\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (41, '2025-09-25 11:06:50.468489', '6', 'لپ تاپ 15.6 اینچی ام اس آی', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (42, '2025-09-25 11:07:12.299508', '6', 'لپ تاپ 15.6 اینچی ام اس آی', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (43, '2025-09-25 11:07:24.492362', '6', 'لپ تاپ 15.6 اینچی ام اس آی', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (44, '2025-09-25 11:07:35.901744', '6', 'لپ تاپ 15.6 اینچی ام اس آی', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (45, '2025-09-25 12:15:47.640863', '1', 'لپ تاپ ایسوس تاف گیمینگ', 2, '[{\"changed\": {\"fields\": [\"Title\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (46, '2025-09-25 12:15:56.523035', '6', 'لپ تاپ 15.6 اینچی ام اس آی', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (47, '2025-09-25 16:28:25.991879', '7', 'Galaxy A56', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (48, '2025-09-25 16:28:31.557838', '7', 'Galaxy A56', 2, '[{\"changed\": {\"fields\": [\"Avg rate\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (49, '2025-09-25 16:28:39.899341', '7', 'Galaxy A56', 2, '[{\"changed\": {\"fields\": [\"Avg rate\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (50, '2025-09-25 16:28:45.957639', '7', 'Galaxy A56', 2, '[{\"changed\": {\"fields\": [\"Avg rate\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (51, '2025-09-25 16:28:51.641163', '7', 'Galaxy A56', 2, '[{\"changed\": {\"fields\": [\"Avg rate\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (52, '2025-09-25 16:32:00.403989', '8', 'Galaxy A26', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (53, '2025-09-25 16:33:00.095656', '2', 'لپ تاپ', 2, '[{\"changed\": {\"fields\": [\"Title\"]}}]', 8, 14);
INSERT INTO `django_admin_log` VALUES (54, '2025-09-25 16:34:35.177299', '9', 'ROG Strix G16', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (55, '2025-09-25 16:36:01.795196', '9', 'لپ تاپ ROG Strix G16', 2, '[{\"changed\": {\"fields\": [\"Title\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (56, '2025-10-10 13:38:23.383951', '14', 'Profile object (14)', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Phone number\"]}}]', 7, 14);
INSERT INTO `django_admin_log` VALUES (57, '2025-10-11 12:53:37.858754', '9', 'لپ تاپ ROG Strix G16', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (58, '2025-10-11 12:54:08.331626', '9', 'لپ تاپ ROG Strix G16', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (59, '2025-10-12 20:03:25.733389', '8', 'Galaxy A26', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (60, '2025-10-12 20:05:28.295647', '3', 'لباس برنامه نویسی', 3, '', 8, 14);
INSERT INTO `django_admin_log` VALUES (61, '2025-10-29 12:20:16.858092', '5', 'مجلسی', 1, '[{\"added\": {}}]', 8, 14);
INSERT INTO `django_admin_log` VALUES (62, '2025-10-29 12:20:20.330744', '2', 'لباس برنامه نویسی', 2, '[{\"changed\": {\"fields\": [\"Category\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (63, '2025-10-29 13:27:28.683699', '9', 'laptop rog 16', 2, '[{\"changed\": {\"fields\": [\"Title\", \"Slug\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (64, '2025-10-29 14:35:25.632585', '6', 'لپ تاپ 15.6 اینچی ام اس آی', 2, '[{\"changed\": {\"fields\": [\"Slug\"]}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (65, '2025-10-29 14:52:13.834913', '10', 'a', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (66, '2025-10-29 14:53:06.847407', '11', 'w', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (67, '2025-10-29 14:53:18.427904', '12', 'z', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (68, '2025-10-29 14:53:33.266511', '13', 'r', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (69, '2025-10-29 15:10:01.388241', '14', 'ش', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (70, '2025-10-29 15:10:10.839527', '15', 'd', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (71, '2025-10-29 15:10:21.232396', '16', 'h', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (72, '2025-10-29 15:55:58.540269', '17', 'aaa', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (73, '2025-10-29 15:56:07.919065', '18', 'z', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (74, '2025-10-29 15:56:14.441788', '19', 'c', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (75, '2025-10-29 15:58:21.741028', '20', 'a', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (76, '2025-10-29 15:58:29.994325', '21', 'vv', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (77, '2025-10-29 16:02:28.694333', '22', '1', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (78, '2025-10-29 16:02:36.689647', '23', '2', 1, '[{\"added\": {}}]', 9, 14);
INSERT INTO `django_admin_log` VALUES (79, '2025-10-30 21:53:54.134971', '1', 'milad', 1, '[{\"added\": {}}]', 15, 14);
INSERT INTO `django_admin_log` VALUES (80, '2025-11-01 22:06:41.271115', '1', 'milad', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 15, 14);
INSERT INTO `django_admin_log` VALUES (81, '2025-11-01 22:06:48.062979', '1', 'milad', 2, '[]', 15, 14);
INSERT INTO `django_admin_log` VALUES (82, '2025-11-01 22:07:07.452636', '2', 'ghloo1996@gmail.com - 2', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (83, '2025-11-01 22:07:13.431735', '1', 'milad', 3, '', 15, 14);
INSERT INTO `django_admin_log` VALUES (84, '2025-11-01 22:07:29.293177', '2', 'test', 1, '[{\"added\": {}}]', 15, 14);
INSERT INTO `django_admin_log` VALUES (85, '2025-11-01 22:08:02.495794', '2', 'test', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 15, 14);
INSERT INTO `django_admin_log` VALUES (86, '2025-11-01 22:08:40.872494', '2', 'test', 2, '[{\"changed\": {\"fields\": [\"Discount percent\"]}}]', 15, 14);
INSERT INTO `django_admin_log` VALUES (87, '2025-11-01 22:08:58.232918', '2', 'test', 2, '[{\"changed\": {\"fields\": [\"Used by\"]}}]', 15, 14);
INSERT INTO `django_admin_log` VALUES (88, '2025-11-05 19:37:05.620808', '2', 'test', 2, '[{\"changed\": {\"fields\": [\"Max limit usage\"]}}]', 15, 14);
INSERT INTO `django_admin_log` VALUES (89, '2025-11-05 19:37:45.230449', '2', 'test', 2, '[{\"changed\": {\"fields\": [\"Used by\"]}}]', 15, 14);
INSERT INTO `django_admin_log` VALUES (90, '2025-11-05 20:30:35.473215', '2', 'test', 2, '[{\"changed\": {\"fields\": [\"Used by\"]}}]', 15, 14);
INSERT INTO `django_admin_log` VALUES (91, '2025-11-05 20:33:01.816039', '30', 'ghloo1996@gmail.com - 30', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (92, '2025-11-05 20:33:01.817040', '29', 'ghloo1996@gmail.com - 29', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (93, '2025-11-05 20:33:01.817040', '28', 'ghloo1996@gmail.com - 28', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (94, '2025-11-05 20:33:01.817040', '27', 'ghloo1996@gmail.com - 27', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (95, '2025-11-05 20:33:01.817040', '26', 'ghloo1996@gmail.com - 26', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (96, '2025-11-05 20:33:01.817040', '25', 'ghloo1996@gmail.com - 25', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (97, '2025-11-05 20:33:01.817040', '24', 'ghloo1996@gmail.com - 24', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (98, '2025-11-05 20:33:01.817040', '23', 'ghloo1996@gmail.com - 23', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (99, '2025-11-05 20:33:01.817040', '22', 'ghloo1996@gmail.com - 22', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (100, '2025-11-05 20:33:01.817040', '21', 'ghloo1996@gmail.com - 21', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (101, '2025-11-05 20:33:01.817040', '20', 'ghloo1996@gmail.com - 20', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (102, '2025-11-05 20:33:01.817040', '19', 'ghloo1996@gmail.com - 19', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (103, '2025-11-05 20:33:01.817040', '18', 'ghloo1996@gmail.com - 18', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (104, '2025-11-05 20:33:01.817040', '17', 'ghloo1996@gmail.com - 17', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (105, '2025-11-05 20:33:01.817040', '16', 'ghloo1996@gmail.com - 16', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (106, '2025-11-05 20:33:01.817040', '15', 'ghloo1996@gmail.com - 15', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (107, '2025-11-05 20:33:01.817040', '14', 'ghloo1996@gmail.com - 14', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (108, '2025-11-05 20:33:01.817040', '13', 'ghloo1996@gmail.com - 13', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (109, '2025-11-05 20:33:01.817040', '12', 'ghloo1996@gmail.com - 12', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (110, '2025-11-05 20:33:01.817040', '11', 'ghloo1996@gmail.com - 11', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (111, '2025-11-05 20:33:01.817040', '10', 'ghloo1996@gmail.com - 10', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (112, '2025-11-05 20:33:01.817040', '9', 'ghloo1996@gmail.com - 9', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (113, '2025-11-05 20:33:01.817040', '8', 'ghloo1996@gmail.com - 8', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (114, '2025-11-05 20:33:01.817040', '7', 'ghloo1996@gmail.com - 7', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (115, '2025-11-05 20:33:01.817040', '6', 'ghloo1996@gmail.com - 6', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (116, '2025-11-05 20:33:01.817040', '5', 'ghloo1996@gmail.com - 5', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (117, '2025-11-05 20:33:01.817040', '4', 'ghloo1996@gmail.com - 4', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (118, '2025-11-05 20:33:01.817040', '3', 'ghloo1996@gmail.com - 3', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (119, '2025-11-05 20:33:01.817040', '1', 'ghloo1996@gmail.com - 1', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (120, '2025-11-05 20:33:26.116443', '2', 'test', 2, '[{\"changed\": {\"fields\": [\"Used by\"]}}]', 15, 14);
INSERT INTO `django_admin_log` VALUES (121, '2025-11-05 20:38:25.651047', '2', 'test', 2, '[{\"changed\": {\"fields\": [\"Used by\"]}}]', 15, 14);
INSERT INTO `django_admin_log` VALUES (122, '2025-11-05 20:39:10.762787', '2', 'test', 2, '[{\"changed\": {\"fields\": [\"Used by\"]}}]', 15, 14);
INSERT INTO `django_admin_log` VALUES (123, '2025-11-05 20:39:19.311755', '33', 'ghloo1996@gmail.com - 33', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (124, '2025-11-05 20:39:19.311755', '32', 'ghloo1996@gmail.com - 32', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (125, '2025-11-05 20:39:19.312759', '31', 'ghloo1996@gmail.com - 31', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (126, '2025-11-06 19:25:07.382890', '1', 'laptop rog 16', 1, '[{\"added\": {}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (127, '2025-11-06 19:25:12.594963', '1', 'laptop rog 16', 2, '[{\"changed\": {\"fields\": [\"User\"]}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (128, '2025-11-06 19:32:38.706512', '2', 'Galaxy A56', 1, '[{\"added\": {}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (129, '2025-11-06 19:34:00.310223', '3', 'لباس برنامه نویسی', 1, '[{\"added\": {}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (130, '2025-11-06 19:37:34.672817', '3', 'لباس برنامه نویسی', 3, '', 11, 14);
INSERT INTO `django_admin_log` VALUES (131, '2025-11-06 19:37:34.672817', '2', 'Galaxy A56', 3, '', 11, 14);
INSERT INTO `django_admin_log` VALUES (132, '2025-11-06 19:37:34.672817', '1', 'laptop rog 16', 3, '', 11, 14);
INSERT INTO `django_admin_log` VALUES (133, '2025-11-06 19:42:26.420085', '41', 'ghloo1996@gmail.com - 41', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (134, '2025-11-06 19:42:26.420085', '40', 'ghloo1996@gmail.com - 40', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (135, '2025-11-06 19:42:26.420085', '39', 'ghloo1996@gmail.com - 39', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (136, '2025-11-06 19:42:26.420085', '38', 'ghloo1996@gmail.com - 38', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (137, '2025-11-06 19:42:26.420085', '37', 'ghloo1996@gmail.com - 37', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (138, '2025-11-06 19:42:26.420085', '36', 'ghloo1996@gmail.com - 36', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (139, '2025-11-06 19:42:26.420085', '35', 'ghloo1996@gmail.com - 35', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (140, '2025-11-06 19:42:26.420085', '34', 'ghloo1996@gmail.com - 34', 3, '', 17, 14);
INSERT INTO `django_admin_log` VALUES (141, '2025-11-06 19:48:02.213878', '2', 'test', 2, '[{\"changed\": {\"fields\": [\"Used by\"]}}]', 15, 14);
INSERT INTO `django_admin_log` VALUES (142, '2025-11-06 19:50:27.707281', '4', 'لپ تاپ ایسوس تاف گیمینگ', 1, '[{\"added\": {}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (143, '2025-11-06 19:50:34.068438', '5', 'Galaxy A56', 1, '[{\"added\": {}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (144, '2025-11-06 19:56:54.543588', '6', 'laptop rog 16', 1, '[{\"added\": {}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (145, '2025-11-06 19:56:59.769458', '7', 'لپ تاپ 15.6 اینچی ام اس آی', 1, '[{\"added\": {}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (146, '2025-11-06 19:57:06.369909', '8', 'Galaxy s25', 1, '[{\"added\": {}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (147, '2025-11-06 19:57:12.993417', '9', 'اپل iPhone 17', 1, '[{\"added\": {}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (148, '2025-11-06 20:25:39.243759', '10', 'aaa', 1, '[{\"added\": {}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (149, '2025-11-06 20:47:54.860211', '11', 'aaa', 1, '[{\"added\": {}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (150, '2025-11-06 20:48:00.443730', '12', 'laptop rog 16', 1, '[{\"added\": {}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (151, '2025-11-06 20:48:17.724686', '11', 'aaa', 3, '', 11, 14);
INSERT INTO `django_admin_log` VALUES (152, '2025-11-06 20:48:27.846566', '13', 'ddd', 1, '[{\"added\": {}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (153, '2025-11-06 22:37:33.429779', '14', 'لپ تاپ 15.6 اینچی ام اس آی', 1, '[{\"added\": {}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (154, '2025-11-06 22:49:52.436229', '15', 'لپ تاپ ایسوس تاف گیمینگ', 1, '[{\"added\": {}}]', 11, 14);
INSERT INTO `django_admin_log` VALUES (155, '2025-11-10 19:39:30.207333', '1', 'admin@admin.com - 39', 3, '', 19, 14);
INSERT INTO `django_admin_log` VALUES (156, '2025-11-10 19:39:35.128447', '2', 'admin@admin.com - 9', 2, '[{\"changed\": {\"fields\": [\"Description\", \"Status\"]}}]', 19, 14);
INSERT INTO `django_admin_log` VALUES (157, '2025-11-10 20:03:25.746788', '3', 'admin@admin.com - 7', 2, '[{\"changed\": {\"fields\": [\"Description\", \"Status\"]}}]', 19, 14);
INSERT INTO `django_admin_log` VALUES (158, '2025-11-10 20:05:49.572208', '4', 'admin@admin.com - 7', 2, '[{\"changed\": {\"fields\": [\"Description\", \"Status\"]}}]', 19, 14);
INSERT INTO `django_admin_log` VALUES (159, '2025-11-10 20:26:25.867789', '5', 'admin@admin.com - 9', 2, '[{\"changed\": {\"fields\": [\"Description\", \"Status\"]}}]', 19, 14);
INSERT INTO `django_admin_log` VALUES (160, '2025-11-10 20:32:14.234979', '6', 'admin@admin.com - 9', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 19, 14);
INSERT INTO `django_admin_log` VALUES (161, '2025-11-16 21:44:25.863292', '10', 'admin@admin.com - 9', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 19, 14);
INSERT INTO `django_admin_log` VALUES (162, '2025-11-16 21:44:39.048518', '7', 'admin@admin.com - 9', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 19, 14);
INSERT INTO `django_admin_log` VALUES (163, '2025-11-16 21:44:42.546454', '11', 'admin@admin.com - 9', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 19, 14);
INSERT INTO `django_admin_log` VALUES (164, '2025-11-16 21:44:48.871795', '9', 'admin@admin.com - 9', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 19, 14);
INSERT INTO `django_admin_log` VALUES (165, '2025-11-16 23:21:36.920623', '2', 'test', 2, '[{\"changed\": {\"fields\": [\"Expiration date\"]}}]', 15, 14);
INSERT INTO `django_admin_log` VALUES (166, '2025-11-17 17:21:31.030544', '1', 'Footer_text object (1)', 1, '[{\"added\": {}}]', 20, 14);
INSERT INTO `django_admin_log` VALUES (167, '2025-11-17 17:25:07.965843', '1', 'شبکه های اجتماعی', 1, '[{\"added\": {}}]', 21, 14);
INSERT INTO `django_admin_log` VALUES (168, '2025-11-17 17:48:46.965497', '2', 'SocialMedia object (2)', 3, '', 21, 14);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label` ASC, `model` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (7, 'accounts', 'profile');
INSERT INTO `django_content_type` VALUES (6, 'accounts', 'user');
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (12, 'cart', 'cart');
INSERT INTO `django_content_type` VALUES (13, 'cart', 'cartitem');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (20, 'footer', 'footer_text');
INSERT INTO `django_content_type` VALUES (21, 'footer', 'socialmedia');
INSERT INTO `django_content_type` VALUES (15, 'order', 'coupon');
INSERT INTO `django_content_type` VALUES (17, 'order', 'order');
INSERT INTO `django_content_type` VALUES (16, 'order', 'orderitem');
INSERT INTO `django_content_type` VALUES (14, 'order', 'useraddress');
INSERT INTO `django_content_type` VALUES (18, 'payment', 'payment');
INSERT INTO `django_content_type` VALUES (19, 'review', 'review');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (8, 'shop', 'category');
INSERT INTO `django_content_type` VALUES (10, 'shop', 'image');
INSERT INTO `django_content_type` VALUES (9, 'shop', 'product');
INSERT INTO `django_content_type` VALUES (11, 'shop', 'wishlist');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2025-09-03 22:58:56.275996');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2025-09-03 22:58:56.390504');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2025-09-03 22:58:56.654525');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2025-09-03 22:58:56.723828');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2025-09-03 22:58:56.734171');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2025-09-03 22:58:56.755528');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2025-09-03 22:58:56.764120');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2025-09-03 22:58:56.768302');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2025-09-03 22:58:56.776423');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2025-09-03 22:58:56.784721');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2025-09-03 22:58:56.792214');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0010_alter_group_name_max_length', '2025-09-03 22:58:56.809083');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0011_update_proxy_permissions', '2025-09-03 22:58:56.816593');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0012_alter_user_first_name_max_length', '2025-09-03 22:58:56.824100');
INSERT INTO `django_migrations` VALUES (15, 'accounts', '0001_initial', '2025-09-03 22:58:57.371981');
INSERT INTO `django_migrations` VALUES (16, 'admin', '0001_initial', '2025-09-03 22:58:57.560691');
INSERT INTO `django_migrations` VALUES (17, 'admin', '0002_logentry_remove_auto_add', '2025-09-03 22:58:57.575280');
INSERT INTO `django_migrations` VALUES (18, 'admin', '0003_logentry_add_action_flag_choices', '2025-09-03 22:58:57.586981');
INSERT INTO `django_migrations` VALUES (19, 'sessions', '0001_initial', '2025-09-03 22:58:57.636412');
INSERT INTO `django_migrations` VALUES (20, 'accounts', '0002_alter_user_is_active', '2025-09-20 19:46:59.657199');
INSERT INTO `django_migrations` VALUES (21, 'shop', '0001_initial', '2025-09-20 19:47:00.500334');
INSERT INTO `django_migrations` VALUES (22, 'cart', '0001_initial', '2025-09-25 19:24:55.821884');
INSERT INTO `django_migrations` VALUES (23, 'order', '0001_initial', '2025-10-30 21:38:46.037998');
INSERT INTO `django_migrations` VALUES (24, 'payment', '0001_initial', '2025-11-03 19:48:29.498126');
INSERT INTO `django_migrations` VALUES (25, 'order', '0002_order_payment', '2025-11-03 19:48:29.591183');
INSERT INTO `django_migrations` VALUES (26, 'review', '0001_initial', '2025-11-07 16:57:58.832437');
INSERT INTO `django_migrations` VALUES (27, 'footer', '0001_initial', '2025-11-17 17:18:40.244964');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('0a58dlvmbgmy2xoks0n5xsk2e6cggatd', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1vH9UR:J6aP685cMupeZs-cM7aDxS87SqXpBM-LhDBiM9YPmMs', '2025-11-20 23:34:03.364824');
INSERT INTO `django_session` VALUES ('0h30rn0yodyx57ivyo810svznw586og3', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1vH6U3:IDitH6bkNp0MNz-8aSZT5IzFVMsl5wXlM9u-CqaEC_Y', '2025-11-20 20:21:27.814716');
INSERT INTO `django_session` VALUES ('15igtxr348r9ymm5uqrqj28q8i99njmk', '.eJxVizsOAiEQQO9CbTZ8h8XSxCvYkhkYAlHXZFkq493VZAtt3-cpIo6txtF5jS2Lo_Di8MsI05WXr8CUHmPZ-rSjPl14baVxPt-x3U57-HdX7PWzUg5opGTrEWS2aIBnhbaYBM6AnD3NJdtAGpCLVk6BlkhOMwdIgax4vQE9ITbh:1uuI5d:wGxW-rnZ4oBc88bYgTYUCGgG4LYmy6WslaLD76IdyvE', '2025-09-18 22:05:57.293820');
INSERT INTO `django_session` VALUES ('23bu1n51icu8ra2mwkjz4rpngxm3q13u', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1vKmVB:iXzvGBHqjCW_KEgBZlnZ6V_5IY8DWEdLJK9MEKfiQqk', '2025-11-30 23:49:49.437778');
INSERT INTO `django_session` VALUES ('4rg3ls2bjg0kwr2shnz9czf76y41lipk', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1vH9Yy:OCQ_kmWz4vg-A90sIaPofGUibHfDk3RLM5O8mq4V7ew', '2025-11-20 23:38:44.101124');
INSERT INTO `django_session` VALUES ('5t6j19c1y0jdvtxyjjzm2uolixfs4utx', '.eJxVi8sKgzAQRf9l1iIaTUazLPQXuilFJpOIoT5KElfiv9eCXbi8556zAVNIoDfwyU0R9POVQVoSjd0neHagi_8-hWLPoKM1Dd0aXei8BQ1lBRdoiN9u_j3EvKxzivmJYv5wwffe2ftEfryd4qUeKA5HqtjYRqIqZVWzVI6sU4JQcitEgUYJ26AhREJV1y1VJQohD5utEX1LAvYvw-lIIA:1v6vwD:2WuXSal7MET34hJ9eOLHsHA0YmpTfZbs64Bk-Jcrvw0', '2025-10-23 19:04:29.469717');
INSERT INTO `django_session` VALUES ('7nmotocy3ibk943ag59vt6bsnu4puis9', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1vE69N:vdO7ikdztLkuzgkdzJ7Zk441qaPI-c-Mvqb-cd2vmAU', '2025-11-12 13:23:41.648571');
INSERT INTO `django_session` VALUES ('7xz2g0kz0930sk73o3p30iyz7iye0j39', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1vEmMM:6P-MB9Oa2Qb0om9Fa2qs8yRj3EdCtxNhUkaWOGeS5Q8', '2025-11-14 10:27:54.818630');
INSERT INTO `django_session` VALUES ('bm22yyr7xuen3v5ikkirbwtxps9fudax', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1vH6R6:6vrPgFHCLzBGLD0j1nMyYXFPvTAfln1b0cBwGWU9Gng', '2025-11-20 20:18:24.848691');
INSERT INTO `django_session` VALUES ('c53hgnu1ym48p0wiapno0q55h21pll21', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1vKmeO:VdYRjtKN9-zekB4J4jM6jmWClV4uyZDms3M7OF83WH4', '2025-11-30 23:59:20.967958');
INSERT INTO `django_session` VALUES ('dy8krrt1lkdqb48e8xekh98chzms58rs', '.eJxVi8sKgzAQRf9l1iLxEU1cFvoL3ZQik8kEQ32UJK7Ef68Fu5C7uveeswFhSNBt4BNPEbrnK4O0JBz7T_DE0Il_PwGxZ9DjmoZ-jRx6b6GDoobLaJDePP8eJFrWOcX8nGL-4OCdZ3uf0I-3E7zYA8bhUBl1W7sasSVNRGgly7rRpmkrIa3QUmhVHZFMyrFFVRAXyhpTOlEoUcL-Be6NSRo:1vHA27:HQ-JJ6f6U_eDR9vXmLuxJdZZI1gzJtZrjO5RSQ0eddQ', '2025-11-21 00:08:51.523320');
INSERT INTO `django_session` VALUES ('fjt1zy5q84sxfzpfnhwnt8uyicqyzkxk', '.eJxVi0sKwjAQQO-StZRM85mpS8EruA2TZEKDWqFpVuLdVehCt-_zVIH7NofeZA01q6MCdfhlkdNVlq_glB592dqwozZcZK2lSj7fud5Oe_h3z9zmz4rOGsOOLDnDEScSYTQ6JgKbI5RcOAniqMkhTRrEigdgHb3PmUZUrzcrSTaO:1uw35P:xI8BTrnI-TipqopRm6tdGl6kuPdEuf-F63iEV0MR4vY', '2025-09-23 18:28:59.308500');
INSERT INTO `django_session` VALUES ('ilovef70cqkf5sxe6d5wrtgnvzky90lm', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1vGgTf:IDzBAKUMFM5c09CO1CgCvvRb6xQnvEbrogCVJq9FVhw', '2025-11-19 16:35:19.659730');
INSERT INTO `django_session` VALUES ('ltg1bzunbys4wfs4q5mdjg0tmm3e12wh', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1vGupU:RITFyNWv220cBeMY7emi9ZLD1qrhymNylTQsX5MLMj0', '2025-11-20 07:54:48.120577');
INSERT INTO `django_session` VALUES ('plts5xoqsgcbonlsebb5qd5q2l94w9dk', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1v7Z7J:Ob2Q8zLqk5PQpk6-9L-8idkX0sp5ivNmmKYc4lsGJtQ', '2025-10-25 12:54:33.243155');
INSERT INTO `django_session` VALUES ('r5ew7f7bdss6py0x93qdkw7a73jgubhk', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1vFJWZ:nUTIg3Fxw9agEVg1u4zb_jnF_AqpuzHeczUO-6qgals', '2025-11-15 21:52:39.717177');
INSERT INTO `django_session` VALUES ('re6vpbc6e9wq8n0kcobd8s424195k74v', '.eJxVi80KAiEQgN_FcyzqjOV0DHqFrqKjg1JtsK6n6N0r2ENdv5-nCnGsNYxeltCyOiqDavcLU-Rrmb8mMj_GvPZpQ326lKVJK_l8j-122sK_u8ZeP6sl1hmsJ7CAGjN44yg67QVBRCw6NpzdgQStN3qPaAiEhVJOBdCp1xstYDYz:1uzZ5N:dgLG10DU08eZl-Qb7y2XHbFvKzBMT-cSHG7hzMfYL5E', '2025-10-03 11:15:29.955684');
INSERT INTO `django_session` VALUES ('sna3mnrdpow40j1n02jyoc5weg6rpxvv', '.eJxVizsOAiEQQO9CbTZ8h8XSxCvYkhkYAlHXZFkq493VZAtt3-cpIo6txtF5jS2Lo_Di8MsI05WXr8CUHmPZ-rSjPl14baVxPt-x3U57-HdX7PWzUg5opGTrEWS2aIBnhbaYBM6AnD3NJdtAGpCLVk6BlkhOMwdIgax4vQE9ITbh:1uuI9q:Squci4ySOiSfQK-QqRVes9EJPz_CVXHo-7Tv2M0HfI0', '2025-09-18 22:10:18.329289');
INSERT INTO `django_session` VALUES ('v17jjttq5icne67wy6a47xnfb4ynnpeg', '.eJxVizsOAiEQQO9CbTZ8h8XSxCvYkhkYAlHXZFkq493VZAtt3-cpIo6txtF5jS2Lo_Di8MsI05WXr8CUHmPZ-rSjPl14baVxPt-x3U57-HdX7PWzUg5opGTrEWS2aIBnhbaYBM6AnD3NJdtAGpCLVk6BlkhOMwdIgax4vQE9ITbh:1uuHxA:w0BUtl_C5wB_Yh-I6C8Sq29Wf6gz3xtrknN4dl4oKDc', '2025-09-18 21:57:12.225014');
INSERT INTO `django_session` VALUES ('vaillsuq5nivahjb84drwfnpoeeeuo3f', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1v81iB:pYG_Gfz67Tw-gyXsf5fkIsjJdeSOcc0PO9hqTfjuvHE', '2025-10-26 19:26:31.446562');
INSERT INTO `django_session` VALUES ('veld9z5wx48tjj2evyyfy9ps835j69u6', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1v7AlJ:rXvZ3_P1U7ErE9jS1cBmMw3i7cxutUqoOb8a5LjqfVY', '2025-10-24 10:54:13.232643');
INSERT INTO `django_session` VALUES ('vpo7bcjcjsv12bylioa9ab0mvbaa0rdo', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1vLTkm:fwS5WyW7ynzDRc04RvVZN1aJEOC8QUF8FrlWfq7LPpU', '2025-12-02 22:00:48.171139');
INSERT INTO `django_session` VALUES ('y2jbtr865gqc8m0ow5f2ix3xnqj24f41', '.eJxVi8EOgyAQBf9lz8YAIiLHJv2FXpqGLLBGUqsN4Mn4720Te_D45s1s4DEVMBvEQq8M5v6ooCwFJ_tO0RMY9t-HwPYKLK5ltGumZGMAA7yBE3TonzT_HvR-WeeS6wPl-kYpDpHC9YVxuhziqR4xj9-UCdm0quWtFloL37uOGj4E5XrOG4WSIzrRyZ60J6WQ8V52fBi8FhRIEoP9A6GDSB0:1vFYva:fBrcc9V9Qxd7OD2IhJPD-jM0HvRR24Od6RlK1N1dGao', '2025-11-16 14:19:30.328410');
INSERT INTO `django_session` VALUES ('y4jiivx3vk18j1bzh7ma9zopko05hh15', '.eJxVi8EOgyAQBf9lz8YAIiLHJv2FXpqGLLBGUqsN4Mn4720Te_D45s1s4DEVMBvEQq8M5v6ooCwFJ_tO0RMY9t-HwPYKLK5ltGumZGMAA7yBE3TonzT_HvR-WeeS6wPl-kYpDpHC9YVxuhziqR4xj9-UCdm0quWtFloL37uOGj4E5XrOG4WSIzrRyZ60J6WQ8V52fBi8FhRIEoP9A6GDSB0:1vKmOw:iK6XcD2qNmPjCBIIAH-Wr8nAZLO6p2UlWArJqmM9Qso', '2025-11-30 23:43:22.792271');
INSERT INTO `django_session` VALUES ('y4lzth8pyp67dhmsob1doypzqoiuqoat', '.eJxVi8sKgzAQRf9l1iLxEU1cFvoL3ZQik8kEQ32UJK7Ef68Fu5C7uveeswFhSNBt4BNPEbrnK4O0JBz7T_DE0Il_PwGxZ9DjmoZ-jRx6b6GDoobLaJDePP8eJFrWOcX8nGL-4OCdZ3uf0I-3E7zYA8bhUBl1W7sasSVNRGgly7rRpmkrIa3QUmhVHZFMyrFFVRAXyhpTOlEoUcL-Be6NSRo:1vHiE7:mjPFb4wiNf7Z_f03fDyAWVWaoJyypXs1AivC-IUbxdE', '2025-11-22 12:39:31.726473');
INSERT INTO `django_session` VALUES ('z05gmm7m6hxgto5ilifoenfixjmkvta7', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1vGuHf:eXM1t7PZu_1FLfcVtPzBwOP7pdydhF0SyPBEdj1p4h0', '2025-11-20 07:19:51.485230');
INSERT INTO `django_session` VALUES ('z06ey8w8l7usic4ahavu1swgnacf88ga', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1vFJDG:TaMniPR1MPOF_CGO-DSye8Xk7DzGnrWzY43NF0TsXkQ', '2025-11-15 21:32:42.164111');
INSERT INTO `django_session` VALUES ('z7dxv6pjowgqnnz9u56o1n5sj7qznlja', '.eJxVi0EOwiAQRe_C2jQFZACXJl7BLZkZhkDUmpR2Zby7NelCl__9914q4brUtHaZU8vqpLQ6_DJCvsn0PZD5uU5LH3bUh6vMrTTJlwe2-3kX_-qKvW5pJIIcSnaIxVjKkb0HdsRFa3TFgA-CzuAIZjQIchQCu40QrXWio3p_AGLmNxQ:1uw5n7:1wsHg0aGTJ7etlHh0A5X_Rb4EZ37LEPomjWP1SmLQDw', '2025-09-23 21:22:17.308211');
INSERT INTO `django_session` VALUES ('zfaqfor9wjdt7jppy54l038alv37w7rz', '.eJyrVkpOLCpRsqpWyixJzS1WsoqO1VEqyS9JzIkvKMpMTlWyMoDxoQoMamsB6twSYA:1vL27V:TzQx1jOrTP2EwZe_kVnuzeUyepymAz3ZYxlwH-fCYY8', '2025-12-01 16:30:25.446937');

-- ----------------------------
-- Table structure for footer_footer_text
-- ----------------------------
DROP TABLE IF EXISTS `footer_footer_text`;
CREATE TABLE `footer_footer_text`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NULL DEFAULT NULL,
  `phone_number` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NULL DEFAULT NULL,
  `text_footer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of footer_footer_text
-- ----------------------------
INSERT INTO `footer_footer_text` VALUES (1, 'ایران، بوشهر', '09999356730', 'این وب‌ سایت با عشق توسط میلاد رنجبر طراحی شده است.');

-- ----------------------------
-- Table structure for footer_socialmedia
-- ----------------------------
DROP TABLE IF EXISTS `footer_socialmedia`;
CREATE TABLE `footer_socialmedia`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `telegram` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NULL DEFAULT NULL,
  `youtube` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NULL DEFAULT NULL,
  `instagram` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NULL DEFAULT NULL,
  `github` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NULL DEFAULT NULL,
  `linkden` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of footer_socialmedia
-- ----------------------------
INSERT INTO `footer_socialmedia` VALUES (1, 'https://t.me/cymilad', 'https://www.youtube.com/@cyberamooz', 'https://www.instagram.com/cyberamooz', 'https://github.com/cymilad', 'https://www.linkedin.com/in/cyberamooz');

-- ----------------------------
-- Table structure for order_coupon
-- ----------------------------
DROP TABLE IF EXISTS `order_coupon`;
CREATE TABLE `order_coupon`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `discount_percent` int NOT NULL,
  `max_limit_usage` int UNSIGNED NOT NULL,
  `expiration_date` datetime(6) NULL DEFAULT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `order_coupon_chk_1` CHECK (`max_limit_usage` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_coupon
-- ----------------------------
INSERT INTO `order_coupon` VALUES (2, 'test', 50, 10, '2025-11-17 01:40:00.000000', '2025-11-01 22:07:29.288943', '2025-11-17 00:00:50.753916');
INSERT INTO `order_coupon` VALUES (3, 'eeee', 30, 60, '2025-11-17 23:30:00.000000', '2025-11-16 23:41:59.021408', '2025-11-16 23:43:22.250549');

-- ----------------------------
-- Table structure for order_coupon_used_by
-- ----------------------------
DROP TABLE IF EXISTS `order_coupon_used_by`;
CREATE TABLE `order_coupon_used_by`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `coupon_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_coupon_used_by_coupon_id_user_id_4641ad53_uniq`(`coupon_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `order_coupon_used_by_user_id_98ab20d1_fk_accounts_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `order_coupon_used_by_coupon_id_aa821297_fk_order_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `order_coupon` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_coupon_used_by_user_id_98ab20d1_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_coupon_used_by
-- ----------------------------
INSERT INTO `order_coupon_used_by` VALUES (11, 2, 13);
INSERT INTO `order_coupon_used_by` VALUES (3, 2, 14);
INSERT INTO `order_coupon_used_by` VALUES (12, 3, 13);

-- ----------------------------
-- Table structure for order_order
-- ----------------------------
DROP TABLE IF EXISTS `order_order`;
CREATE TABLE `order_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `zip_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `total_price` decimal(10, 0) NOT NULL,
  `status` int NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `coupon_id` bigint NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `payment_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_order_coupon_id_dc594905_fk_order_coupon_id`(`coupon_id` ASC) USING BTREE,
  INDEX `order_order_user_id_7cf9bc2b_fk_accounts_user_id`(`user_id` ASC) USING BTREE,
  INDEX `order_order_payment_id_d8fb3a38_fk_payment_payment_id`(`payment_id` ASC) USING BTREE,
  CONSTRAINT `order_order_coupon_id_dc594905_fk_order_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `order_coupon` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_order_payment_id_d8fb3a38_fk_payment_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `payment_payment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_order_user_id_7cf9bc2b_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_order
-- ----------------------------
INSERT INTO `order_order` VALUES (42, 'برج میلاد', 'بوشهر', 'برازجان', '123456789', 135000000, 2, '2025-11-06 19:47:27.479117', '2025-11-06 19:47:30.565469', NULL, 13, 25);
INSERT INTO `order_order` VALUES (43, 'برج میلاد', 'بوشهر', 'برازجان', '123456789', 3000000, 2, '2025-11-06 19:48:44.022966', '2025-11-06 19:48:46.802490', 2, 13, 26);
INSERT INTO `order_order` VALUES (44, 'برج میلاد', 'بوشهر', 'برازجان', '123456789', 1345500, 3, '2025-11-06 19:49:03.162955', '2025-11-06 19:49:06.287096', NULL, 13, 27);
INSERT INTO `order_order` VALUES (45, 'برج میلاد', 'بوشهر', 'برازجان', '123456789', 135000000, 3, '2025-11-07 00:04:13.723261', '2025-11-07 00:04:19.170923', NULL, 13, 28);
INSERT INTO `order_order` VALUES (46, 'برج میلاد', 'بوشهر', 'برازجان', '123456789', 208525000, 1, '2025-11-16 23:42:54.707292', '2025-11-16 23:42:55.436475', NULL, 13, 29);
INSERT INTO `order_order` VALUES (47, 'برج میلاد', 'بوشهر', 'برازجان', '123456789', 208525000, 2, '2025-11-16 23:43:22.218294', '2025-11-16 23:43:24.749664', 3, 13, 30);

-- ----------------------------
-- Table structure for order_orderitem
-- ----------------------------
DROP TABLE IF EXISTS `order_orderitem`;
CREATE TABLE `order_orderitem`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int UNSIGNED NOT NULL,
  `price` decimal(10, 0) NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_orderitem_order_id_aba34f44_fk_order_order_id`(`order_id` ASC) USING BTREE,
  INDEX `order_orderitem_product_id_c5c6b07a_fk_shop_product_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `order_orderitem_order_id_aba34f44_fk_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_orderitem_product_id_c5c6b07a_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_orderitem_chk_1` CHECK (`quantity` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_orderitem
-- ----------------------------
INSERT INTO `order_orderitem` VALUES (47, 1, 135000000, '2025-11-06 19:47:27.490117', '2025-11-06 19:47:27.490117', 42, 9);
INSERT INTO `order_orderitem` VALUES (48, 3, 1000000, '2025-11-06 19:48:44.033182', '2025-11-06 19:48:44.033182', 43, 1);
INSERT INTO `order_orderitem` VALUES (49, 3, 448500, '2025-11-06 19:49:03.172133', '2025-11-06 19:49:03.172133', 44, 2);
INSERT INTO `order_orderitem` VALUES (50, 1, 135000000, '2025-11-07 00:04:13.907642', '2025-11-07 00:04:13.907642', 45, 9);
INSERT INTO `order_orderitem` VALUES (51, 1, 208525000, '2025-11-16 23:42:54.728201', '2025-11-16 23:42:54.728201', 46, 6);
INSERT INTO `order_orderitem` VALUES (52, 1, 208525000, '2025-11-16 23:43:22.222596', '2025-11-16 23:43:22.222596', 47, 6);

-- ----------------------------
-- Table structure for order_useraddress
-- ----------------------------
DROP TABLE IF EXISTS `order_useraddress`;
CREATE TABLE `order_useraddress`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `zip_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_useraddress_user_id_aef34b61_fk_accounts_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `order_useraddress_user_id_aef34b61_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_useraddress
-- ----------------------------
INSERT INTO `order_useraddress` VALUES (8, 'برج میلاد', 'بوشهر', 'برازجان', '123456789', '2025-11-06 19:38:59.263912', '2025-11-06 19:38:59.263912', 13);

-- ----------------------------
-- Table structure for payment_payment
-- ----------------------------
DROP TABLE IF EXISTS `payment_payment`;
CREATE TABLE `payment_payment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `authority_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `ref_id` bigint NULL DEFAULT NULL,
  `amount` decimal(10, 0) NOT NULL,
  `response_json` json NOT NULL,
  `response_code` int NULL DEFAULT NULL,
  `status` int NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payment_payment
-- ----------------------------
INSERT INTO `payment_payment` VALUES (1, '4328794429', NULL, 1000000, '{}', NULL, 1, '2025-11-03 20:18:42.167031', '2025-11-03 20:18:42.167031');
INSERT INTO `payment_payment` VALUES (2, '4328801479', NULL, 1000000, '{}', NULL, 1, '2025-11-03 20:24:08.679114', '2025-11-03 20:24:08.679114');
INSERT INTO `payment_payment` VALUES (3, '4328805859', NULL, 448500, '{}', NULL, 1, '2025-11-03 20:27:33.443298', '2025-11-03 20:27:33.443298');
INSERT INTO `payment_payment` VALUES (4, '4328806511', NULL, 1000000, '{}', NULL, 1, '2025-11-03 20:28:07.237104', '2025-11-03 20:28:07.237104');
INSERT INTO `payment_payment` VALUES (5, '4328807587', NULL, 1000000, '{}', NULL, 1, '2025-11-03 20:28:58.070128', '2025-11-03 20:28:58.070128');
INSERT INTO `payment_payment` VALUES (6, '4328825505', NULL, 1000000, '{}', NULL, 3, '2025-11-03 20:43:23.987901', '2025-11-03 20:43:34.635483');
INSERT INTO `payment_payment` VALUES (7, '4328833098', NULL, 1000000, '{\"amount\": 1000000, \"paidAt\": \"2025-11-04T00:21:00.518000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 3, '2025-11-03 20:50:56.362725', '2025-11-03 20:51:05.133685');
INSERT INTO `payment_payment` VALUES (8, '4328834422', NULL, 107000000, '{\"amount\": 107000000, \"paidAt\": \"2025-11-04T00:22:15.306000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-03 20:52:13.335787', '2025-11-03 20:52:15.838661');
INSERT INTO `payment_payment` VALUES (9, '4331465552', NULL, 134100000, '{\"amount\": 134100000, \"paidAt\": \"2025-11-05T20:16:22.252000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-05 16:46:17.531194', '2025-11-05 16:46:21.765853');
INSERT INTO `payment_payment` VALUES (10, '4331467150', NULL, 44000000, '{\"amount\": 44000000, \"paidAt\": \"2025-11-05T20:17:29.318000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-05 16:47:24.202084', '2025-11-05 16:47:28.845934');
INSERT INTO `payment_payment` VALUES (11, '4331490462', NULL, 421100000, '{\"amount\": 421100000, \"paidAt\": \"2025-11-05T20:34:06.104000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-05 17:04:03.526842', '2025-11-05 17:04:06.187205');
INSERT INTO `payment_payment` VALUES (12, '4331606801', NULL, 107448500, '{\"amount\": 107448500, \"paidAt\": \"2025-11-05T21:54:39.023000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-05 18:24:36.146908', '2025-11-05 18:24:39.298143');
INSERT INTO `payment_payment` VALUES (13, '4331708611', NULL, 67500000, '{\"amount\": 67500000, \"paidAt\": \"2025-11-05T23:07:54.086000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-05 19:37:51.630201', '2025-11-05 19:37:53.519218');
INSERT INTO `payment_payment` VALUES (14, '4331781102', NULL, 11000000, '{\"amount\": 11000000, \"paidAt\": \"2025-11-06T00:00:50.030000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-05 20:30:47.543346', '2025-11-05 20:30:49.482492');
INSERT INTO `payment_payment` VALUES (15, '4331786176', NULL, 11000000, '{\"amount\": 11000000, \"paidAt\": \"2025-11-06T00:03:38.777000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-05 20:33:36.348482', '2025-11-05 20:33:38.209073');
INSERT INTO `payment_payment` VALUES (16, '4331792689', NULL, 1000000, '{\"amount\": 1000000, \"paidAt\": \"2025-11-06T00:08:10.502000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-05 20:38:07.598278', '2025-11-05 20:38:09.985917');
INSERT INTO `payment_payment` VALUES (17, '4331793501', NULL, 500000, '{\"amount\": 500000, \"paidAt\": \"2025-11-06T00:08:41.587000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-05 20:38:38.955654', '2025-11-05 20:38:41.840181');
INSERT INTO `payment_payment` VALUES (18, '4331795536', NULL, 135448500, '{}', NULL, 1, '2025-11-05 20:40:05.249729', '2025-11-05 20:40:05.249729');
INSERT INTO `payment_payment` VALUES (19, '4331796137', NULL, 89500000, '{\"amount\": 89500000, \"paidAt\": \"2025-11-06T00:10:34.286000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-05 20:40:31.718487', '2025-11-05 20:40:34.985556');
INSERT INTO `payment_payment` VALUES (20, '4331846337', NULL, 44000000, '{}', NULL, 3, '2025-11-05 21:23:47.215650', '2025-11-05 21:23:48.521647');
INSERT INTO `payment_payment` VALUES (21, '4331849161', NULL, 44000000, '{\"amount\": 44000000, \"paidAt\": \"2025-11-06T00:56:42.632000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-05 21:26:39.028474', '2025-11-05 21:26:42.845483');
INSERT INTO `payment_payment` VALUES (22, '4331849376', NULL, 108448500, '{}', NULL, 3, '2025-11-05 21:26:55.330626', '2025-11-05 21:26:58.281862');
INSERT INTO `payment_payment` VALUES (23, '4331849536', NULL, 134100000, '{\"amount\": 134100000, \"paidAt\": \"2025-11-06T00:57:09.952000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-05 21:27:06.949169', '2025-11-05 21:27:09.340966');
INSERT INTO `payment_payment` VALUES (24, '4331861125', NULL, 44000000, '{\"amount\": 44000000, \"paidAt\": \"2025-11-06T01:10:39.337000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-05 21:40:29.875479', '2025-11-05 21:40:38.819287');
INSERT INTO `payment_payment` VALUES (25, '4333048425', NULL, 135000000, '{\"amount\": 135000000, \"paidAt\": \"2025-11-06T23:17:30.019000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-06 19:47:28.366003', '2025-11-06 19:47:30.555990');
INSERT INTO `payment_payment` VALUES (26, '4333050374', NULL, 1500000, '{\"amount\": 1500000, \"paidAt\": \"2025-11-06T23:18:46.247000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-06 19:48:44.822809', '2025-11-06 19:48:46.795489');
INSERT INTO `payment_payment` VALUES (27, '4333050695', NULL, 1345500, '{}', NULL, 3, '2025-11-06 19:49:03.862760', '2025-11-06 19:49:06.281098');
INSERT INTO `payment_payment` VALUES (28, '4333274060', NULL, 135000000, '{}', NULL, 3, '2025-11-07 00:04:15.676901', '2025-11-07 00:04:19.165927');
INSERT INTO `payment_payment` VALUES (29, '4347191384', NULL, 208525000, '{}', NULL, 1, '2025-11-16 23:42:55.413656', '2025-11-16 23:42:55.413656');
INSERT INTO `payment_payment` VALUES (30, '4347191605', NULL, 145967500, '{\"amount\": 145967500, \"paidAt\": \"2025-11-17T03:13:26.288000\", \"result\": 100, \"status\": 1, \"message\": \"success\", \"orderId\": \"\", \"refNumber\": null, \"cardNumber\": null, \"description\": \"پرداخت کاربر\", \"multiplexingInfos\": []}', NULL, 2, '2025-11-16 23:43:22.779859', '2025-11-16 23:43:24.729523');

-- ----------------------------
-- Table structure for review_review
-- ----------------------------
DROP TABLE IF EXISTS `review_review`;
CREATE TABLE `review_review`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `rate` int NOT NULL,
  `status` int NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `review_review_product_id_bee66c28_fk_shop_product_id`(`product_id` ASC) USING BTREE,
  INDEX `review_review_user_id_ff798828_fk_accounts_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `review_review_product_id_bee66c28_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `review_review_user_id_ff798828_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of review_review
-- ----------------------------
INSERT INTO `review_review` VALUES (2, 'wdsdasdsa', 5, 2, '2025-11-10 19:39:06.373195', '2025-11-10 19:39:35.128447', 9, 14);
INSERT INTO `review_review` VALUES (3, 'خیلی عالی', 5, 2, '2025-11-10 19:39:57.545934', '2025-11-10 20:03:25.738669', 7, 14);
INSERT INTO `review_review` VALUES (4, 'wwww', 2, 2, '2025-11-10 20:05:39.091108', '2025-11-10 20:05:49.560262', 7, 14);
INSERT INTO `review_review` VALUES (5, 'wwww', 4, 2, '2025-11-10 20:26:14.416791', '2025-11-10 20:26:25.861600', 9, 14);
INSERT INTO `review_review` VALUES (6, 'خوب نیست', 1, 2, '2025-11-10 20:32:05.074152', '2025-11-10 20:32:14.230106', 9, 14);
INSERT INTO `review_review` VALUES (7, 'wwwwwww', 2, 2, '2025-11-16 21:13:06.585266', '2025-11-16 21:44:39.044504', 9, 14);
INSERT INTO `review_review` VALUES (8, 'wwww', 4, 1, '2025-11-16 21:14:38.754842', '2025-11-16 21:14:38.754842', 9, 14);
INSERT INTO `review_review` VALUES (9, 'www', 5, 3, '2025-11-16 21:15:08.111253', '2025-11-16 21:44:48.871795', 9, 14);
INSERT INTO `review_review` VALUES (10, 'حله داداش 👍', 5, 2, '2025-11-16 21:15:25.894066', '2025-11-16 22:14:07.627137', 9, 14);
INSERT INTO `review_review` VALUES (11, 'eeee', 3, 2, '2025-11-16 21:15:45.410074', '2025-11-16 21:44:42.546454', 9, 14);

-- ----------------------------
-- Table structure for shop_category
-- ----------------------------
DROP TABLE IF EXISTS `shop_category`;
CREATE TABLE `shop_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `slug` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `slug`(`slug` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_category
-- ----------------------------
INSERT INTO `shop_category` VALUES (1, 'لباس', 'labas', '2025-09-22 17:19:41.953646', '2025-09-22 17:19:41.953646');
INSERT INTO `shop_category` VALUES (2, 'لپ تاپ', 'labtop', '2025-09-22 17:19:56.541640', '2025-09-25 16:33:00.093657');
INSERT INTO `shop_category` VALUES (4, 'موبایل', 'mobile', '2025-09-24 19:32:26.455928', '2025-09-24 19:32:26.455928');
INSERT INTO `shop_category` VALUES (5, 'مجلسی', 'مجلسی', '2025-10-29 12:20:16.855092', '2025-10-29 12:20:16.855092');
INSERT INTO `shop_category` VALUES (8, 'تست', 'تست', '2025-11-17 01:50:12.885259', '2025-11-17 01:50:12.885259');

-- ----------------------------
-- Table structure for shop_image
-- ----------------------------
DROP TABLE IF EXISTS `shop_image`;
CREATE TABLE `shop_image`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shop_image_product_id_1cb0873d_fk_shop_product_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `shop_image_product_id_1cb0873d_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_image
-- ----------------------------
INSERT INTO `shop_image` VALUES (1, 'product/extra-img/مشکی-زندگی-برنامه-نویس.jpg', '2025-09-22 17:31:51.285319', '2025-09-22 17:31:51.285319', 2);
INSERT INTO `shop_image` VALUES (2, 'product/extra-img/23514469-3-1541-3.jpg', '2025-09-22 17:31:57.110043', '2025-09-22 17:31:57.110043', 1);

-- ----------------------------
-- Table structure for shop_product
-- ----------------------------
DROP TABLE IF EXISTS `shop_product`;
CREATE TABLE `shop_product`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `slug` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NOT NULL,
  `brief_description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci NULL,
  `stock` int UNSIGNED NOT NULL,
  `status` int NOT NULL,
  `price` decimal(10, 0) NOT NULL,
  `discount_percent` int NOT NULL,
  `avg_rate` double NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `slug`(`slug` ASC) USING BTREE,
  INDEX `shop_product_user_id_37a7f6d6_fk_accounts_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `shop_product_user_id_37a7f6d6_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shop_product_chk_1` CHECK (`stock` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_product
-- ----------------------------
INSERT INTO `shop_product` VALUES (1, 'لپ تاپ ایسوس تاف گیمینگ', 'tuf-gaming-f15', 'product/img/23514469-3-1541-3.jpg', 'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.', 'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است.', 3, 1, 1000000, 0, 0, '2025-09-22 17:29:31.615785', '2025-09-25 12:15:47.623662', 14);
INSERT INTO `shop_product` VALUES (2, 'لباس برنامه نویسی', 'لباس-برنامه-نویسی', 'product/img/مشکی-زندگی-برنامه-نویس.jpg', 'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.', 'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است', 10, 1, 690000, 35, 0, '2025-09-22 17:31:39.868937', '2025-10-29 14:47:20.877181', 14);
INSERT INTO `shop_product` VALUES (3, 'Galaxy s25', 'galaxy-s25', 'product/img/Galaxy_S25.jpg', 'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.', 'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است', 5, 1, 107000000, 0, 3, '2025-09-24 19:34:49.115587', '2025-09-24 19:46:31.699582', 14);
INSERT INTO `shop_product` VALUES (5, 'اپل iPhone 17', 'اپل-iphone-17', 'product/img/40933-iPhone_17_01_610_710.jpg', 'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.\r\n\r\nلورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.\r\n\r\nلورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.', 'که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.', 1, 2, 149000000, 0, 4, '2025-09-24 19:39:21.921305', '2025-11-07 00:15:53.454379', 14);
INSERT INTO `shop_product` VALUES (6, 'لپ تاپ 15.6 اینچی ام اس آی', 'لپ-تاپ-15-6-اینچی-ام-اس-آی', 'product/img/02d399ba0789ba39797083d64b1f2078f0059426_1756111783.webp', 'سری ROG ایسوس یکی از محبوب‌ترین‌ برندها در بازار لپ‌تاپ‌های مخصوص بازی به شمار می‌آید و همواره گزینه‌هایی پیشرو و با کیفیت در اختیار کاربران قرار می‌دهد. لپ‌تاپ ROG Strix G16 G614JVR به عنوان یکی از گزینه‌های قدرتمند این سری شناخته می‌شود که از توان پردازشی بسیار بالایی برخوردار است. در نگاه اول، طراحی ویژه و نوارهای RGB که در بخش‌های مختلف بدنه به کار برده شده‌اند، کاربران را به این لپ‌تاپ جذب می‌کنند. در مرحله‌ی بعدی، پردازنده Core i9 نسل 14 خودنمایی می‌کند که از 24 هسته و 32 رشته‌ی پردازشی خود با فرکانس نهایی 5.8 گیگاهرتز استفاده می‌کند تا کاربر هیچ نقص و کاستی حتی در پردازش‌های سنگین‌ احساس نکند. مکمل این قطعه، پردازنده گرافیکی Geforce RTX 4060 خواهد بود که به 8 گیگابایت حافظه اختصاصی مجهز شده و با استفاده از فناوری‌هایی مانند G-Sync و DLSS 3 تجربه‌ای نرم و روان با نرخ فریم بالا به همراه دارد. استفاده از حافظه رم DDR5 با فرکانس 5600 مگاهرتز در کنار پردازنده مرکزی، امکان اجرای سنگین‌ترین برنامه‌ها و باز نگه داشتن تعداد زیادی برنامه و جابجایی سریع بین آن‌ها را فراهم می‌کند. حافظه SSD پرسرعت نسل 4 هم زمان روشن شدن سیستم، انتقال فایل‌ها و بارگذاری برنامه‌ها و بازی‌ها را به حداقل می‌رساند. در کنار همه‌ی این قطعات، صفحه‌نمایش 16 اینچی با رزولوشن WUXGA یا 1920 در 1200 در نظر گرفته شده که به لطف استفاده از پنل IPS با کیفیت، دقت رنگ و وضوح بالایی دارد. نرخ به‌روز رسانی 165 هرتزی در کنار فناوری‌هایی نظیر G-Sync و DLSS 3 و البته قدرت بالای سخت‌افزار این لپ‌تاپ، تجربه‌ی کم نظیری در هنگام اجرای بازی‌های مختلف ارائه می‌کنند. طراحی چشمگیر با نورپردازی RGB بدنه، درگاه‌های متنوع و کامل، باتری چهار سلولی با ظرفیت 90 وات ساعت و نورپردازی RGB کیبورد از سایر ویژگی‌های ROG Strix G16 G614JVR به شمار می‌آیند.', 'سری ROG ایسوس یکی از محبوب‌ترین‌ برندها در بازار لپ‌تاپ‌های مخصوص بازی به شمار می‌آید و همواره گزینه‌هایی پیشرو و با کیفیت در اختیار کاربران قرار می‌دهد. لپ‌تاپ ROG Strix G16 G614JVR به عنوان یکی از گزینه‌های قدرتمند این سری شناخته می‌شود که از توان پردازشی بسیار بالایی برخوردار است.', 4, 1, 219500000, 5, 0, '2025-09-25 11:06:50.455125', '2025-11-06 20:00:04.272753', 14);
INSERT INTO `shop_product` VALUES (7, 'Galaxy A56', 'galaxy-a56', 'product/img/40710-Galaxy_A56_14_610_710.jpg', 'شرکت سامسونگ در دومین روز ماه مارچ 2025 (12 اسفند 1403) از دو میان‌رده استراتژیک Galaxy A36 و Galaxy A56 رونمایی کرده است. این دو گوشی در مقایسه با همتایان پیشین خود با تغییرات ظاهری مشخصی روبرو شده که در رأس آن‌ها باید طراحی مجموعه دوربین‌ها در بخش پشتی اشاره کرد. Galaxy A56 همچنان از پوشش شیشه‌ای در پشت و رو و شاسی فلزی بهره می‌برد و توان شارژر آن بالاخره به 45 وات ارتقاء پیدا کرده است. دوربین اصلی Galaxy A56 مشابه دو نسل قبلی‌ست و دوربین‌های اولتراواید و ماکروی آن نیز از سال 2020 تا به امروز ثابت مانده‌اند. پردازنده گوشی از نوع جدید Exynos 1580 بوده و همچنان با 8 یا 12 گیگابایت رم و 128 یا 256 گیگابایت حافظه ارائه می‌شود.\r\n\r\nاولین تغییر در طراحی Galaxy A56 که حتی قبل از رنگ‌های جدید آن جلب نظر می‌کند به شکل لنزهای دوربین‌های بخش پشتی آن تعلق دارد که بعد از دو سال از فرم مستقل و مجزا فاصله گرفته و حالا هر سه لنز درون یک محوطه بیضی‌شکل برجسته قرار دارند. این گوشی در چهار رنگ خاکستری روشن، خاکستری گرافیتی، سبز زیتونی و صورتی ارائه می‌شود که همگی یک پیشوند Awesome را در کنار نام خود می‌بینند.', 'اولین تغییر در طراحی Galaxy A56 که حتی قبل از رنگ‌های جدید آن جلب نظر می‌کند به شکل لنزهای دوربین‌های بخش پشتی آن تعلق دارد که بعد از دو سال از فرم مستقل و مجزا فاصله گرفته و حالا هر سه لنز درون یک محوطه بیضی‌شکل برجسته قرار دارند. این گوشی در چهار رنگ خاکستری روشن، خاکستری گرافیتی، سبز زیتونی و صورتی ارائه می‌شود که همگی یک پیشوند Awesome را در کنار نام خود می‌بینند.', 9, 1, 44000000, 0, 3.5, '2025-09-25 16:28:25.983215', '2025-11-10 20:05:49.570647', 14);
INSERT INTO `shop_product` VALUES (9, 'laptop rog 16', 'laptop-rog-16', 'product/img/0489d53dc0cd02a66f6858dd7f7b84314f465c91_1753630282.webp', 'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.\r\n\r\nدر این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.', 'در دنیای لپ‌تاپ‌های گیمینگ، مدل ROG Strix G16 G614JI-N3263 از برند معتبر ایسوس، همانند یک سلاح قدرتمند برای گیمرها و کاربران حرفه‌ای قد علم کرده است.', 1, 1, 180000000, 25, 3, '2025-09-25 16:34:35.170413', '2025-11-16 21:44:42.546454', 14);

-- ----------------------------
-- Table structure for shop_product_category
-- ----------------------------
DROP TABLE IF EXISTS `shop_product_category`;
CREATE TABLE `shop_product_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `shop_product_category_product_id_category_id_d7d3b465_uniq`(`product_id` ASC, `category_id` ASC) USING BTREE,
  INDEX `shop_product_category_category_id_9635f39e_fk_shop_category_id`(`category_id` ASC) USING BTREE,
  CONSTRAINT `shop_product_category_category_id_9635f39e_fk_shop_category_id` FOREIGN KEY (`category_id`) REFERENCES `shop_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shop_product_category_product_id_deb8d294_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_product_category
-- ----------------------------
INSERT INTO `shop_product_category` VALUES (1, 1, 2);
INSERT INTO `shop_product_category` VALUES (2, 2, 1);
INSERT INTO `shop_product_category` VALUES (11, 2, 5);
INSERT INTO `shop_product_category` VALUES (4, 3, 4);
INSERT INTO `shop_product_category` VALUES (6, 5, 4);
INSERT INTO `shop_product_category` VALUES (7, 6, 2);
INSERT INTO `shop_product_category` VALUES (8, 7, 4);
INSERT INTO `shop_product_category` VALUES (10, 9, 2);

-- ----------------------------
-- Table structure for shop_wishlist
-- ----------------------------
DROP TABLE IF EXISTS `shop_wishlist`;
CREATE TABLE `shop_wishlist`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shop_wishlist_product_id_0fc70568_fk_shop_product_id`(`product_id` ASC) USING BTREE,
  INDEX `shop_wishlist_user_id_131c4a81_fk_accounts_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `shop_wishlist_product_id_0fc70568_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shop_wishlist_user_id_131c4a81_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_persian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_wishlist
-- ----------------------------
INSERT INTO `shop_wishlist` VALUES (33, 1, 13);
INSERT INTO `shop_wishlist` VALUES (34, 9, 13);

SET FOREIGN_KEY_CHECKS = 1;
