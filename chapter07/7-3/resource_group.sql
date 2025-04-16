--
-- Check Resource Group
--
SELECT * FROM INFORMATION_SCHEMA.RESOURCE_GROUPS;

--
-- Check Request Unit by Resource Group
--
SELECT * FROM mysql.request_unit_by_group;

--
-- Create Resource Group
--
CREATE RESOURCE GROUP my_rg RU_PER_SEC = 500;
CREATE RESOURCE GROUP my_burst_rg RU_PER_SEC = 100 BURSTABLE = true;
CREATE RESOURCE GROUP my_high_rg RU_PER_SEC = 1000 PRIORITY = HIGH;

--
-- Modify Resource Group
--
ALTER RESOURCE GROUP my_rg BURSTABLE = true;

--
-- Delete Resource Group
--
DROP RESOURCE GROUP my_rg;

--
-- Create Resource Group with QUERY_LIMIT
--
CREATE RESOURCE GROUP my_rw_rg RU_PER_SEC = 1000 QUERY_LIMIT = (PROCESSED_KEYS=1000, ACTION=KILL);

--
-- Check Runaway Query
--
SELECT /*+ RESOURCE_GROUP(my_rw_rg) */ * FROM bookshop.books WHERE id > 10000000;
SELECT * FROM mysql.tidb_runaway_queries ORDER BY start_time DESC LIMIT 1 \G

--
-- Check Runaway Query by WATCH
--
CREATE RESOURCE GROUP my_rw_rg QUERY_LIMIT = (PROCESSED_KEYS=1000, ACTION=KILL, WATCH=SIMILAR DURATION='1h');
SELECT /*+ RESOURCE_GROUP(my_rw_rg) */ * FROM bookshop.books WHERE id > 10000000;
SELECT * FROM INFORMATION_SCHEMA.runaway_watches \G

--
-- Remove QUERY_LIMIT
--
ALTER RESOURCE GROUP my_rw_rg QUERY_LIMIT = NULL;

--
-- Limit CPU utilization for TiDB Lightning and BR tasks
--
ALTER RESOURCE GROUP default BACKGROUND=(TASK_TYPES='lightning,br', UTILIZATION_LIMIT=20);

--
-- Execute SQL as a background type
--
SET @@tidb_request_source_type="background";
-- BACKUP DATABASE bookshop TO ...

--
-- Bind Resource Group to user
--
CREATE USER 'my_user'@'%' IDENTIFIED BY 'my_password' RESOURCE GROUP my_rg;
-- ALTER USER 'my_user'@'%' RESOURCE GROUP my_rg;

--
-- Check Resource Group bound to user
--
SELECT USER, JSON_EXTRACT(User_attributes, "$.resource_group") AS resource_group FROM mysql.user WHERE user = "my_user";

--
-- Unbind Resource Group
--
ALTER USER 'my_user'@'%' RESOURCE GROUP 'default';

--
-- Bind Resource Group in current session
--
SET RESOURCE GROUP my_rg;

--
-- Check Resource Group in current session
--
SELECT CURRENT_RESOURCE_GROUP();

--
-- Bind Resource Group to query
--
SELECT /*+ RESOURCE_GROUP(my_rg) */ * FROM bookshop.books;

--
-- Check Request Unit
--
EXPLAIN ANALYZE SELECT * FROM bookshop.books;
EXPLAIN ANALYZE SELECT * FROM bookshop.books LIMIT 100;

--
-- Disable Resource Group in TiDB
--
SET GLOBAL tidb_enable_resource_control = 'OFF';

