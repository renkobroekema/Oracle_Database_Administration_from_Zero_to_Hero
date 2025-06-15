/* Undo Advisor
Can be used to estimate the undo tablespace size
=> it assumes that the required retention period is correctly set (it relies on the AWR statistics) 

To know the period covered by which AWR snapshot ID:
*/
select snap_id, begin_interval_time, end_interval_time
from dba_hist_snapshot
order by snap_id desc;

-- To use the advisor, create a task for it, execute the task, then check it findings and recommendations;


/* 1. To create an Undo Advisor to evaluate the undo tablespace */
DECLARE
    tid NUMBER;
    tname VARCHAR2(30);
    oid NUMBER;
BEGIN
    DBMS_ADVISOR.CREATE_TASK('Undo Advisor', tid, tname, 'Undo Advisor Task');
    DBMS_ADVISOR.CREATE_OBJECT(tname, 'UNDO_TBS', null, null, null,'null', null, oid);
    DBMS_ADVISOR.SET_TASK_PARAMETER(tname, 'TARGET_OBJECTS', oid);
    DBMS_ADVISOR.SET_TASK_PARAMETER(tname, 'START_SNAPSHOT', 1);
    DBMS_ADVISOR.SET_TASK_PARAMETER(tname, 'END_SNAPSHOT', 2);
    DBMS_ADVISOR.SET_TASK_PARAMETER(tname, 'INSTANCE', 1);
    DBMS_ADVISOR.EXECUTE_TASK(tname);
END;

/* 2. Query the advisor framework views:
DBA_ADVISOR_TASKS, 
DBA_ADVISOR_OBJECTS,
DBA_ADVISOR_FINDINGS, 
DBA_ADVISOR_RECOMMENDATIONS
*/