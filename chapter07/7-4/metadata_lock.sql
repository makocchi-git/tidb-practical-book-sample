--
-- Check metadata lock
--
SELECT * FROM mysql.tidb_mdl_view \G

--
-- Disable metadata lock
--
SET GLOBAL tidb_enable_metadata_lock = OFF;
