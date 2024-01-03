--17.  Genera?i automat un script SQL care s? con?in? comenzi de ?tergere a tuturor 
--tabelelor personale create 
select *
from user_tables
where table_name like ('%aa');

SPOOL ON;

SPOOL d:\a.sql;
select 'DROP TABLE' || TABLE_NAME || ':'
from user_tables
where table_name like ('%aa');

--20. Verifica?i ce efect are utilizarea comenzii SET FEEDBACK OFF.
set feedback off;

--21. Asigura?i-v? c? antetul tabelului rezultat nu se multiplic?.                        
set pagesize 0;

--22.  F?r? s? rula?i scriptul creat da?i exemplu de un caz în care execu?ia acestui 
--script va determina erori. Indica?i o metod? de rezolvare a acestui caz
--atunci cand file name-ul este invalid. rezolvare--> cream fisierul cu numele corespunzator

--23. Folosind tabelul departments genera?i automat script-ul SQL de inserare a
--înregistr?rilor în acest tabel.
set feedback off;
SPOOL inserare.sql;
select 'insert into departments (department_id, department_name, location_id)
values ('|| department_id || ', '|| department_name ||', '||location_id ||');'
from departments;
SPOOL OFF;
set feedback on;
