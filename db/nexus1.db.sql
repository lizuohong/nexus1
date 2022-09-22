BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "user" (
	"user_id"	INTEGER NOT NULL,
	"username"	VARCHAR(15) NOT NULL,
	"password"	varchar(100) NOT NULL,
	"created_on"	DATETIME,
	"updated_on"	DATETIME,
	PRIMARY KEY("user_id"),
	UNIQUE("username")
);
CREATE TABLE IF NOT EXISTS "post" (
	"post_id"	INTEGER,
	"user"	INTEGER NOT NULL,
	"date"	DATETIME,
	"title"	TEXT NOT NULL,
	"text"	TEXT NOT NULL,
	PRIMARY KEY("post_id")
);
INSERT INTO "user" ("user_id","username","password","created_on","updated_on") VALUES (1,'sam','pbkdf2:sha256:260000$sGECh2uwvLAIEjKM$9dac310dc7e2d0cf188015929de6ab850734814efdfead61e075cfbbc171c55a',NULL,NULL),
 (2,'sammy','pbkdf2:sha256:260000$daB82ps6CdqmWF7b$9fba95bc5d487a2de27fe833464572bcfd2d59533cc893a39fbb8522a857fea6',NULL,NULL),
 (3,'sonny','pbkdf2:sha256:260000$wKlhhJrkEqRyJogl$866418fe62332e586c9c7dc4dd9c0f6bba91347a9cfb29ff35863375383c98bc',NULL,NULL),
 (4,'john','pbkdf2:sha256:260000$vKqhnYHhIXZP93Xj$97bf964b9c236f195ab4369d1c35001553514815b7e862253299078d6061d7ef',NULL,NULL),
 (5,'zuo','pbkdf2:sha256:260000$hYP8PW91KxZCMFPJ$8a48c8898fd67618c133a51d5b5b15cbba8a09f883c990d450d3f259bbaa9f5f',NULL,NULL),
 (6,'aaa','pbkdf2:sha256:260000$VDuJZvmLY98vflU5$5ed8d0ddbf3526fbfab47320e9ff069d8d614a57a96cccc33dc76a7f6c259eb5',NULL,NULL),
 (7,'frodo','pbkdf2:sha256:260000$9hNhgnOzIaB7WdeB$6ffc5274ae563af08f8365b120e294b29850a88a0739c2d8a6fe78294c2b0ee8',NULL,NULL),
 (8,'smigol','pbkdf2:sha256:260000$vgRAK5DSd060B6sB$4f98a50f167b667699de8f75c61de4b681a0522547b1563f1a28b92eecd4cf4c',NULL,NULL),
 (9,'sauron','pbkdf2:sha256:260000$Cdb1Iqv5sBQjix39$8f143e0089a39a0d62f00bdf3b056d49dd534c54acc81513b4638ddb9b4c7bcf',NULL,NULL),
 (10,'admin','pbkdf2:sha256:260000$0K2YzAzeRVyeFNwU$5fc590d60c5e75164759e0c469adbd341e378513cc10119e7af99593d0dad1c6',NULL,NULL);
INSERT INTO "post" ("post_id","user","date","title","text") VALUES (1,1,'','1','USSR is Hamming distance 1 (not quite) from user.'),
 (2,3,'','2','这才是第一条'),
 (3,1,'','','晕，sqlite对字段类型居然不校验'),
 (4,1,'','','微调重构后的post页面'),
 (5,1,'','左冷禅',''),
 (6,1,'2022-09-02 14:12:03.118810','测试记录时间',''),
 (7,1,'2022-09-02 14:28:47.745511','Tolerably complete!',''),
 (8,1,'2022-09-19 17:10:57.235166','长记平山堂上，欹枕江南烟雨，杳杳没孤鸿','');
COMMIT;
