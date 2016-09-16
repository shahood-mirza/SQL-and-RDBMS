--    PROGRAM     login.sql
--    DATE        May 06, 2012 
-- ======================================================================
-- DESCRIPTION : 
--  SQL*Plus user login startup file.
--  This script is automatically run after glogin.sql
--  To change the SQL*Plus prompt to display the current user,
--  connection identifier and current time.
--  First set the database date format to show the time.
-- ======================================================================*/
--ALTER SESSION SET nls_date_format = 'HH:MI:SS';

-- SET the SQLPROMPT to include the _USER, _CONNECT_IDENTIFIER
-- and _DATE variables.
SET TERMOUT OFF
SET FEEDBACK OFF
DEFINE gname=idle
COLUMN global_name new_value gname
SELECT lower(user) || '@' || substr( global_name, 1, decode( dot, 0, length(global_name), dot-1) ) global_name
  FROM (
   SELECT global_name, instr(global_name,'.') dot 
      FROM global_name );
SET SQLPROMPT '&gname> '

-- To set the number of lines to display in a report page to 24.
SET PAGESIZE 24

-- To set the number of characters to display on each report line to 78.
SET LINESIZE 130
SET PAUSE ON
SET PAUSE 'more...'

-- To set the number format used in a report to $99,999.
--SET NUMFORMAT $99,999
SET FEEDBACK ON
SET TERMOUT ON