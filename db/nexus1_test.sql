BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "post" (
	"post_id"	INTEGER,
	"user"	INTEGER NOT NULL,
	"date"	DATETIME,
	"title"	TEXT NOT NULL,
	"text"	TEXT NOT NULL,
	PRIMARY KEY("post_id")
);
CREATE TABLE IF NOT EXISTS "user" (
	"user_id"	INTEGER NOT NULL,
	"username"	VARCHAR(15) NOT NULL,
	"password"	varchar(100) NOT NULL,
	"created_on"	DATETIME,
	"updated_on"	DATETIME,
	"active"	boolean,
	PRIMARY KEY("user_id"),
	UNIQUE("username")
);
INSERT INTO "post" ("post_id","user","date","title","text") VALUES (1,1,'','1','USSR is Hamming distance 1 (not quite) from user.'),
 (2,3,'','2','这才是第一条'),
 (3,1,'','','晕，sqlite对字段类型居然不校验'),
 (4,1,'','','微调重构后的post页面'),
 (6,1,'2022-09-02 14:12:03.118810','测试记录时间',''),
 (7,1,'2022-09-02 14:28:47.745511','Tolerably complete!',''),
 (8,15,'2022-09-23 14:52:13.173152','1212',''),
 (9,15,'2022-09-23 14:52:16.999371','1212',''),
 (10,15,'2022-09-23 14:52:20.295560','2212',''),
 (11,15,'2022-09-23 14:52:24.222784','1112',''),
 (12,15,'2022-09-23 14:52:27.616978','131212',''),
 (13,15,'2022-09-23 14:52:33.661324','11122',''),
 (14,15,'2022-09-23 14:52:46.016031','adfadfa',''),
 (15,15,'2022-09-23 14:52:49.737244','wadfgadf',''),
 (16,15,'2022-09-23 14:52:52.733415','asdf',''),
 (17,15,'2022-09-23 14:52:56.421626','12133','1'),
 (18,15,'2022-09-26 19:48:59.498853','walawalawuwalawa','');
INSERT INTO "user" ("user_id","username","password","created_on","updated_on","active") VALUES (1,'sam','pbkdf2:sha256:260000$sGECh2uwvLAIEjKM$9dac310dc7e2d0cf188015929de6ab850734814efdfead61e075cfbbc171c55a',NULL,NULL,1),
 (2,'sammy','pbkdf2:sha256:260000$daB82ps6CdqmWF7b$9fba95bc5d487a2de27fe833464572bcfd2d59533cc893a39fbb8522a857fea6',NULL,NULL,1),
 (3,'sonny','pbkdf2:sha256:260000$wKlhhJrkEqRyJogl$866418fe62332e586c9c7dc4dd9c0f6bba91347a9cfb29ff35863375383c98bc',NULL,NULL,1),
 (4,'john','pbkdf2:sha256:260000$pYsKRj42vWBOmFL8$64535e75ce400aa1a87be45b321c8af240aa6dd56b5e1935728ad9f0e9c14d06',NULL,'2022-09-21 17:42:26.427719',1),
 (5,'zuo','pbkdf2:sha256:260000$QPGf3Q0JwTcJyK62$8ec8dfbeaec48b7aeb5410dac13ea3e941cf62b97aeb41016d8bd7b58d67b186',NULL,'2022-09-22 16:11:13.673347',1),
 (6,'aaa','pbkdf2:sha256:260000$VDuJZvmLY98vflU5$5ed8d0ddbf3526fbfab47320e9ff069d8d614a57a96cccc33dc76a7f6c259eb5',NULL,NULL,1),
 (7,'frodo','pbkdf2:sha256:260000$9hNhgnOzIaB7WdeB$6ffc5274ae563af08f8365b120e294b29850a88a0739c2d8a6fe78294c2b0ee8',NULL,NULL,1),
 (8,'smigol','pbkdf2:sha256:260000$vgRAK5DSd060B6sB$4f98a50f167b667699de8f75c61de4b681a0522547b1563f1a28b92eecd4cf4c',NULL,NULL,1),
 (9,'sauron','pbkdf2:sha256:260000$Cdb1Iqv5sBQjix39$8f143e0089a39a0d62f00bdf3b056d49dd534c54acc81513b4638ddb9b4c7bcf',NULL,NULL,1),
 (10,'admin','pbkdf2:sha256:260000$0K2YzAzeRVyeFNwU$5fc590d60c5e75164759e0c469adbd341e378513cc10119e7af99593d0dad1c6',NULL,NULL,1),
 (11,'lizh','pbkdf2:sha256:260000$EG0c7jXsWZhWNFPq$a9b378aa2f21353dce60b09eb43df0e9cc599102cb1c695a7529e4cf44ae458c',NULL,'2022-09-22 16:10:29.055222',0),
 (12,'zumba','pbkdf2:sha256:260000$kR8ByQl1zpQETySe$60e9dc5b9f02d545efc5c9a762d0b9518df9e7f37a863298b6bee8ee1d009219','2022-09-22 08:53:28.955598',NULL,1),
 (13,'zelenski','pbkdf2:sha256:260000$1WGYGhh8NTBEZeT8$dde3c3ddd07c40ff1510b54ec190c1c2bef702c2e116b620874f3dd9c0df6224','2022-09-22 14:15:00.350749','2022-09-22 14:25:41.837299',0),
 (14,'biden','pbkdf2:sha256:260000$sQV7HRK0pKFX8xGd$a2c33e70ebd860e62c3ab6cf97eee4797a302827e859ca34e168b9bb7c08ef45','2022-09-22 14:22:40.452090',NULL,0),
 (15,'anthony','pbkdf2:sha256:260000$Z4btjykWqhHXKApk$b521176d93f9b80a7202ea3fca3bc68ff531dfd8450ae8b1b73cd95876e6510a','2022-09-22 16:09:59.290180',NULL,1);
COMMIT;
