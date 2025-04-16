--
-- Use test database
--
USE test;

--
-- Table structure for sample
--
DROP TABLE IF EXISTS sample;

CREATE TABLE sample (
  id     BIGINT PRIMARY KEY,
  name   VARCHAR(256)
);

--
-- Enable TiFlash
--
ALTER TABLE sample SET TIFLASH REPLICA 1;
-- ALTER DATABASE test SET TIFLASH REPLICA 1;

--
-- Check TiFlash data sync
--
SELECT TABLE_SCHEMA, TABLE_NAME, AVAILABLE, PROGRESS FROM INFORMATION_SCHEMA.TIFLASH_REPLICA
WHERE TABLE_SCHEMA = 'test' and TABLE_NAME = 'sample';

--
-- Disable TiFlash
--
ALTER TABLE sample SET TIFLASH REPLICA 0;
-- ALTER DATABASE test SET TIFLASH REPLICA 0;

