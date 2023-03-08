
CREATE TABLE samples_tree (
  item_id int NOT NULL ,
  item_nm varchar(200) default '0',
  item_order int default '0',
  item_desc text,
  item_parent_id int default '0',
  [GUID] varchar(50),
  SYS_TS datetime default getdate(),
  PRIMARY KEY  (item_id)
)