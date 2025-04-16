--
-- Use test database
--
USE test;

--
-- Table structure for table t2
--
DROP TABLE IF EXISTS t2;

CREATE TABLE t2 (
  id     BIGINT PRIMARY KEY NONCLUSTERED,
  name   VARCHAR(256),
  age    INT,
  UNIQUE (name),
  INDEX  (age)
);

--
-- Data for t2
--
INSERT INTO t2 VALUES (100, 'Alice', 20), (200, 'Bob', 30), (300, 'Charlie', 40);

--
-- Check data
--
SELECT * FROM t2 ORDER BY id;

--
-- Check rowID
--
SELECT _tidb_rowid, id, name, age FROM t2 ORDER BY id;

--
-- Check Table ID
--
SELECT TIDB_TABLE_ID FROM INFORMATION_SCHEMA.TABLES WHERE table_schema='test' AND table_name='t2';

--
-- Check TIDB_PK_TYPE
--
SELECT TIDB_PK_TYPE FROM INFORMATION_SCHEMA.TABLES WHERE table_schema='test' AND table_name='t2';

--
-- Check Index ID
--
SELECT INDEX_ID, COLUMN_NAME FROM INFORMATION_SCHEMA.TIDB_INDEXES WHERE table_schema='test' AND table_name='t2';
