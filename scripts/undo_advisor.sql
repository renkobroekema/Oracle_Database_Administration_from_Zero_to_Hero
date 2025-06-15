/* Undo Advisor
Can be used to estimate the undo tablespace size
=> it assumes that the required retention period is correctly set (it relies on the AWR statistics) 

To know the period covered by which AWR snapshot ID:
*/
select snap_id, begin_interval_time, end_interval_time
from dba_hist_snapshot
order by snap_id desc;

-- To use the advisor, create a task for it, execute the task, then check it findings and recommendations;