/* Formula:
tbs size = Required Retention period * undo block per second * block size

Undo block per second can be obtained by:
*/
select max(undoblks/((end_time - begin_time) * 3600*24)) as undo_block_per_second
from v$undostat;