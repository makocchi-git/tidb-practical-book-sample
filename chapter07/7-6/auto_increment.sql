--
-- Create auto_incr_test table
--
USE test;
CREATE TABLE auto_incr_test (
  id INT PRIMARY KEY AUTO_INCREMENT,
  c INT
);

--
-- Insert data into auto_incr_test table
--
INSERT INTO auto_incr_test (c) VALUES (1), (2), (3);

--
-- Check data in auto_incr_test table
--
SELECT * FROM auto_incr_test;

--
-- Insert data into auto_incr_test table (via another TiDB instance)
--
-- mysql --comments --host 127.0.0.1 --port 4001 -u root
USE test;
INSERT INTO auto_incr_test (c) VALUES (4), (5), (6);

--
-- Check data in auto_incr_test table
--
SELECT * FROM auto_incr_test ORDER BY id;

--
-- Check the next AUTO_INCREMENT value for the table
--
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 'auto_incr_test';

--
-- Create auto_incr_test2 table with AUTO_ID_CACHE
--
USE test;
CREATE TABLE auto_incr_test2 (
  id INT PRIMARY KEY AUTO_INCREMENT,
  c INT
) AUTO_ID_CACHE 1;

--
-- Insert data into auto_incr_test2 table
--
INSERT INTO auto_incr_test2 (c) VALUES (1), (2), (3);

--
-- Insert data into auto_incr_test2 table (via another TiDB instance)
--
-- mysql --comments --host 127.0.0.1 --port 4001 -u root
USE test;
INSERT INTO auto_incr_test2 (c) VALUES (4), (5), (6);

--
-- Check data in auto_incr_test2 table
--
SELECT * FROM auto_incr_test2 ORDER BY id;

--
-- Create auto_rand_test table
--
USE test;
CREATE TABLE auto_rand_test (
  id BIGINT PRIMARY KEY AUTO_RANDOM,
  c int
);

--
-- Insert data into auto_rand_test table
--
INSERT INTO auto_rand_test (c) VALUES (1);
INSERT INTO auto_rand_test (c) VALUES (2);
INSERT INTO auto_rand_test (c) VALUES (3);

-- mysql --comments --host 127.0.0.1 --port 4001 -u root
INSERT INTO auto_rand_test (c) VALUES (4);
INSERT INTO auto_rand_test (c) VALUES (5);
INSERT INTO auto_rand_test (c) VALUES (6);

--
-- Check data in auto_rand_test table
--
SELECT * FROM auto_rand_test ORDER BY c;

--
-- Check RAND_BIT representation of IDs
--
SELECT LPAD(BIN(id),64,0) as RAND_BIT FROM auto_rand_test ORDER BY c;

--
-- Check incremented bit
--
SELECT c, CONV(RIGHT(LPAD(BIN(id),64,0), 58), 2, 10) as RAND_BIT FROM auto_rand_test ORDER BY c;

--
-- Create table shard_row_id_test with SHARD_ROW_ID_BITS
--
USE test;
CREATE TABLE shard_row_id_test (c int) SHARD_ROW_ID_BITS = 4;

--
-- Insert data into shard_row_id_test table
--
INSERT INTO shard_row_id_test (c) VALUES (1);
INSERT INTO shard_row_id_test (c) VALUES (2);
INSERT INTO shard_row_id_test (c) VALUES (3);

--
-- Check _tidb_rowid in shard_row_id_test table
--
SELECT _tidb_rowid, c FROM shard_row_id_test ORDER BY c;

--
-- Check shard bit
--
SELECT LPAD(BIN(_tidb_rowid),64,0) as RowID_BIT FROM shard_row_id_test ORDER BY c;
