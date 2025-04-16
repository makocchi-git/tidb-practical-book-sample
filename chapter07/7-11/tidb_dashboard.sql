--
-- Create user for TiDB Dashboard
--
CREATE USER 'dashboard'@'%' IDENTIFIED BY '<password>';
GRANT PROCESS, CONFIG, SHOW DATABASES, DASHBOARD_CLIENT ON *.* TO 'dashboard'@'%';

--
-- Create dashboard_viewer role
--
CREATE ROLE 'dashboard_viewer';
CREATE USER 'dashboard'@'%' IDENTIFIED BY '<password>';
GRANT PROCESS, CONFIG, SHOW DATABASES, DASHBOARD_CLIENT ON *.* TO 'dashboard_viewer'@'%';
GRANT 'dashboard_viewer' TO 'dashboard'@'%';
SET DEFAULT ROLE 'dashboard_viewer' to 'dashboard'@'%';

--
-- Enable Top SQL
--
SET GLOBAL tidb_enable_top_sql = true;

--
-- Disable Top SQL
--
SET GLOBAL tidb_enable_top_sql = false;

--
-- Change statement summary refresh interval (default 1800)
--
SET GLOBAL tidb_stmt_summary_refresh_interval = 3600;

--
-- Check whether statement summary is enabled
--
SHOW GLOBAL VARIABLES LIKE 'tidb_stmt_summary_enable_persistent';

