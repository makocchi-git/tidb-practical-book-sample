--
-- Enable TiFlash for the test database
--
ALTER DATABASE test SET tiflash replica 1;

--
-- Check progress of TiFlash data sync
--
SELECT TABLE_SCHEMA, TABLE_NAME, AVAILABLE, PROGRESS FROM INFORMATION_SCHEMA.TIFLASH_REPLICA WHERE TABLE_SCHEMA = 'test';