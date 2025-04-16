--
-- Check GC life time
--
SELECT @@tidb_gc_life_time;

--
-- Change GC life time to 1 hour
--
SET GLOBAL tidb_gc_life_time = 1h;

--
-- Check GC run interval
--
SELECT @@tidb_gc_run_interval;

--
-- Change GC run interval to 1 hour
--
SET GLOBAL tidb_gc_run_interval = 1h;

--
-- Stop GC (Not recommended)
--
SET GLOBAL tidb_gc_enable = OFF;
