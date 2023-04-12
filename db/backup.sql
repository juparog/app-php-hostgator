-- Table structure for table `user`

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    cell_phone VARCHAR(15),
    age INT DEFAULT NULL,
    PRIMARY KEY (id)
);
