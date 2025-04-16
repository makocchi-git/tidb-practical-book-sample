--
-- Create ttl_table
--
CREATE TABLE ttl_table (
  id int PRIMARY KEY,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) TTL = created_at + INTERVAL 3 DAY;

--
-- Change TTL
--
ALTER TABLE ttl_table TTL = created_at + INTERVAL 7 DAY;

--
-- Remove TTL
--
ALTER TABLE ttl_table REMOVE TTL;

--
-- Change TTL job interval to 24 hours
--
ALTER TABLE ttl_table TTL_JOB_INTERVAL = '24h';

--
-- Set TTL job schedule window
--
SET @@global.tidb_ttl_job_schedule_window_start_time = '01:00 +0900';
SET @@global.tidb_ttl_job_schedule_window_end_time = '03:00 +0900';

--
-- Disable TTL on ttl_table
--
ALTER TABLE ttl_table TTL_ENABLE = 'OFF';

--
-- Disable TTL in TiDB
--
SET @@global.tidb_ttl_job_enable = OFF;

--
-- Set TTL job running tasks
--
SET @@global.tidb_ttl_running_tasks = 10;

--
-- Check TTL job history
--
SELECT * FROM mysql.tidb_ttl_job_history LIMIT 1 \G
