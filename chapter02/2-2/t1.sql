--
-- Use test database
--
USE test;

--
-- Table structure for table t1
--
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (
  id     BIGINT PRIMARY KEY,
  name   VARCHAR(256),
  age    INT,
  UNIQUE (name),
  INDEX  (age)
);

--
-- Data for t1
--
INSERT INTO t1 VALUES (100, 'Alice', 20), (200, 'Bob', 30), (300, 'Charlie', 40);

--
-- Check data
--
SELECT * FROM t1 ORDER BY id;

--
-- Check Table ID
--
SELECT TIDB_TABLE_ID FROM INFORMATION_SCHEMA.TABLES WHERE table_schema='test' AND table_name='t1';

--
-- Check TIDB_PK_TYPE
--
SELECT TIDB_PK_TYPE FROM INFORMATION_SCHEMA.TABLES WHERE table_schema='test' AND table_name='t1';

--
-- Check Index ID
--
SELECT INDEX_ID, COLUMN_NAME FROM INFORMATION_SCHEMA.TIDB_INDEXES WHERE table_schema='test' AND table_name='t1';
