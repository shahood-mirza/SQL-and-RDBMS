-- Main Menu
-- Shahood Mirza
-- menu.sql

PROMPT
PROMPT   Welcome To Specialty Imports     Database v3.45r40
PROMPT   Press Ctrl-C to Quit at Any Time
PROMPT   ----------------------------------------------------;
PROMPT   
PROMPT   1.  Create a Sales Invoice
PROMPT   2.  Inquire a Sales Invoice
PROMPT   3.  Create a Vehicle Inventory Record
PROMPT   4.  Inquire a Vehicle Inventory Record
PROMPT   5.  Create an Accounting Sales Supplement
PROMPT   6.  Inquire an Accounting Sales Supplement
PROMPT   7.  Create a Service Work Order
PROMPT   8.  Inquire a Service Work Order
PROMPT   9.  Create a Customer Entry
PROMPT   10. Inquire a Customer
PROMPT   11. Create a Prospect Entry
PROMPT   12. Delete a Prospect Entry
PROMPT   13. Generate a Prospect List
PROMPT
ACCEPT p_choice PROMPT 'Enter Choice #: '

@&p_choice
