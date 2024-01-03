--Scrie?i o cerere care are urm?torul rezultat pentru fiecare angajat:
--<prenume angajat> <nume angajat> castiga <salariu> lunar dar doreste <salariu de 3 ori mai mare>. 
-- Etichetati coloana “Salariu ideal”. Pentru concatenare, utiliza?i atât func?ia CONCAT cât ?i operatorul “||”.
SELECT CONCAT(CONCAT(first_name, ' '), last_name) || ' castiga ' || salary || ' dar doreste ' || salary*3 AS "Salariu ideal"
FROM employees;

-- Scrie?i o cerere prin care s? se afi?eze prenumele salariatului cu prima litera majuscul? ?i toate celelalte litere minuscule, 
-- numele acestuia cu majuscule ?i lungimea numelui, pentru angaja?ii al c?ror nume începe cu J sau M sau care au a treia 
-- liter? din nume A. Rezultatul va fi ordonat descresc?tor dup? lungimea numelui. Se vor eticheta coloanele corespunz?tor. 
-- Se cer 2 solu?ii (cu operatorul LIKE ?i func?ia SUBSTR).
-- Varianta 1 LIKE
SELECT INITCAP(first_name) AS "Prenume", UPPER(last_name) AS "Nume", LENGTH(last_name) AS "Lungime"
FROM employees
WHERE UPPER(last_name) LIKE 'J%' OR UPPER(last_name) LIKE 'M%' OR LOWER(last_name) LIKE '__a%'
ORDER BY LENGTH(last_name) DESC;

-- Varianta 2 SUBSTR
SELECT INITCAP(first_name) AS "Prenume", UPPER(last_name) AS "Nume", LENGTH(last_name) AS "Lungime"
FROM employees
WHERE SUBSTR(last_name,1,1) = 'J' OR SUBSTR(last_name,1,1) = 'M' OR SUBSTR(last_name,3,1) = 'a'
ORDER BY LENGTH(last_name) DESC;

-- 3. S? se afi?eze, pentru angaja?ii cu prenumele „Steven”, codul ?i numele acestora, precum ?i codul departamentului în 
-- care lucreaz?. C?utarea trebuie s? nu fie case- sensitive, iar eventualele blank-uri care preced sau urmeaz? numelui 
-- trebuie ignorate.

SELECT last_name, TRIM(BOTH FROM first_name), employee_id, department_id
FROM employees
WHERE UPPER(first_name) LIKE 'STEVEN';

-- 4. S? se afi?eze pentru to?i angaja?ii al c?ror nume se termin? cu litera 'e', codul, numele, lungimea numelui ?i 
-- pozi?ia din nume în care apare prima data litera 'a'. Utiliza?i alias- uri corespunz?toare pentru coloane.
SELECT last_name, employee_id, LENGTH(last_name), INSTR(UPPER(last_name),'A',1,1) AS "Aparitia lui A"
FROM employees
WHERE last_name LIKE '%e';

--S? se afi?eze detalii despre salaria?ii care au lucrat un num?r întreg de s?pt?mâni
--pân? la data curent?.
--Obs: Solu?ia necesit? rotunjirea diferen?ei celor dou? date calendaristice. De ce este necesar acest lucru?
SELECT last_name, first_name, hire_date, mod(ROUND(sysdate-hire_date),7)
FROM employees
WHERE mod(ROUND(sysdate-hire_date),7) = 0;

-- S? se afi?eze codul salariatului, numele, salariul, salariul m?rit cu 15%, exprimat cu dou? zecimale ?i num?rul de sute 
-- al salariului nou rotunjit la 2 zecimale. Eticheta?i ultimele dou? coloane “Salariu nou”, respectiv “Numar sute”. 
-- Se vor lua în considerare salaria?ii al c?ror salariu nu este divizibil cu 1000.
SELECT employee_id, last_name, salary, round(salary*1.15, 2) AS "Salariu nou", round(salary*1.15/100,2) AS "Numar sute"
FROM employees
WHERE mod(salary,1000) != 0;

-- S? se listeze numele ?i data angaj?rii salaria?ilor care câ?tig? comision. S? se eticheteze coloanele „Nume angajat”, 
--„Data angajarii”. Utiliza?i func?ia RPAD pentru a determina ca data angaj?rii s? aib? lungimea de 20 de caractere.
SELECT last_name AS "Nume angajat", RPAD(to_char(hire_date),20, ' ') AS "Data angajarii", commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

-- 8. S? se afi?eze data (numele lunii, ziua, anul, ora, minutul si secunda) de peste 30 zile.
SELECT TO_CHAR(sysdate + 30, 'dd/month/yyyy HH24:MI:SS')
FROM dual;

-- 9. S? se afi?eze num?rul de zile r?mase pân? la sfâr?itul anului.
SELECT ROUND(TO_DATE('31-DEC-2022')-SYSDATE) AS "Zile ramase"
FROM dual;

-- 10 a) S? se afi?eze data de peste 12 ore.
SELECT TO_CHAR(SYSDATE+12/24, 'dd/month/yyyy HH24:MI:SS')
FROM dual;

-- b) S? se afi?eze data de peste 5 minute
SELECT TO_CHAR(SYSDATE+1/288, 'dd/month/yyyy HH24:MI:SS')
FROM dual;

--11. S? se afi?eze numele ?i prenumele angajatului (într-o singur? coloan?), data angaj?rii 
--?i data negocierii salariului, care este prima zi de Luni dup? 6 luni de serviciu. 
--Eticheta?i aceast? coloan? “Negociere”.
SELECT last_name || ' ' || first_name AS "Nume si prenume",hire_date, ADD_MONTHS(hire_date,6) AS "Negociere"
FROM employees;

--12. Pentru fiecare angajat s? se afi?eze numele ?i num?rul de luni de la data angaj?rii. 
--Eticheta?i coloana “Luni lucrate”. S? se ordoneze rezultatul dup? num?rul de luni 
--lucrate. Se va rotunji num?rul de luni la cel mai apropiat num?r întreg.
SELECT last_name, ROUND(MONTHS_BETWEEN(SYSDATE,hire_date)) AS "Luni lucrate"
FROM employees
ORDER BY ROUND(MONTHS_BETWEEN(SYSDATE,hire_date)) DESC;

--13. S? se afi?eze numele, data angaj?rii ?i ziua s?pt?mânii în care a început lucrul fiecare 
--salariat. Eticheta?i coloana “Zi”. Ordona?i rezultatul dup? ziua s?pt?mânii, începând cu 
--Luni.
SELECT last_name, hire_date, TO_CHAR(hire_date,'day') AS "Zi"
FROM employees
ORDER BY TO_CHAR(hire_date-1,'d');

--14. S? se afi?eze numele angaja?ilor ?i comisionul. Dac? un angajat nu câ?tig? comision, 
--s? se scrie “Fara comision”. Eticheta?i coloana “Comision”.
SELECT last_name, NVL(to_char(commission_pct), 'Fara comision') AS "Comision"
FROM employees;

--15. S? se listeze numele, salariul ?i comisionul tuturor angaja?ilor al c?ror venit lunar 
--(salariu + valoare comision) dep??e?te 10000.
SELECT last_name, salary, commission_pct
FROM employees
WHERE salary+(NVL(commission_pct, 0) * salary) > 10000;

--16. S? se afi?eze numele, codul job-ului, salariul ?i o coloan? care s? arate salariul dup? 
--m?rire. Se presupune c? pentru IT_PROG are loc o m?rire de 20%, pentru SA_REP 
--cre?terea este de 25%, iar pentru SA_MAN are loc o m?rire de 35%. Pentru ceilal?i 
--angaja?i nu se acord? m?rire. S? se denumeasc? coloana "Salariu renegociat". 
SELECT last_name, job_id, salary, CASE job_id WHEN 'IT_PROG' THEN salary* 1.2
                                              WHEN 'SA_REP' THEN salary* 1.25
                                              WHEN 'SA_MAN' THEN salary* 1.35
                                              ELSE salary
                                  END AS "Salariu negociat"
FROM employees;

--17. S? se afi?eze numele salariatului, codul ?i numele departamentului pentru to?i 
--angaja?ii.
SELECT last_name, employees.department_id, department_name
FROM employees, departments
WHERE employees.department_id=departments.department_id;

--18. S? se listeze codurile ?i denumirile job-urilor care exist? în departamentul 30.
SELECT job_id, job_title
FROM jobs JOIN employees USING (job_id)
WHERE department_id=30;

--19. S? se afi?eze numele angajatului, numele departamentului ?i ora?ul pentru to?i 
--angaja?ii care câ?tig? comision.
SELECT last_name,first_name, department_name, city
FROM employees JOIN departments USING (department_id)
               JOIN locations USING (location_id)
WHERE commission_pct IS NOT NULL;

--20. S? se afi?eze numele salariatului ?i numele departamentului pentru to?i salaria?ii care 
--au litera A inclus? în nume.
SELECT last_name, department_name
FROM employees JOIN departments USING (department_id)
WHERE UPPER(last_name) LIKE '%A%';

--21. S? se afi?eze numele, titlul job-ului ?i denumirea departamentului pentru to?i angaja?ii 
--care lucreaz? în Oxford
SELECT last_name, job_title, department_name
FROM employees JOIN departments USING (department_id)
               JOIN jobs USING (job_id)
               JOIN locations USING (location_id)
WHERE lower(city)=’oxford’;

--22. S? se afi?eze codul angajatului ?i numele acestuia, împreun? cu numele ?i codul 
--?efului s?u direct. Se vor eticheta coloanele Ang#, Angajat, Mgr#, Manager
SELECT e.employee_id AS "Ang#", e.last_name AS "Angajat", e.manager_id AS "Mgr#", m.last_name AS "Manager"
FROM employees e, employees m
WHERE e.manager_id = m.employee_id;

--23. S? se modifice cererea anterioar? pentru a afi?a to?i salaria?ii, inclusiv cei care nu au 
--?ef
SELECT e.employee_id AS "Ang#", e.last_name AS "Angajat", e.manager_id AS "Mgr#", m.last_name AS "Manager"
FROM employees e, employees m
WHERE e.manager_id = m.employee_id(+); 

--24. Scrie?i o cerere care afi?eaz? numele angajatului, codul departamentului în care 
--acesta lucreaz? ?i numele colegilor s?i de departament. Se vor eticheta coloanele 
--corespunz?tor.
SELECT e.last_name AS "Angajat", e.department_id AS "Departament", c.last_name AS "Colegi"
FROM employees e, employees c
WHERE e.department_id= c.department_id AND e.employee_id != c.employee_id;

--25. Crea?i o cerere prin care s? se afi?eze numele, codul job-ului, titlul job-ului, numele 
--departamentului ?i salariul angaja?ilor. Se vor include ?i angaja?ii al c?ror departament 
--nu este cunoscut.
SELECT e.last_name, j.job_id, j.job_title, d.department_name, e.salary
FROM employees e, jobs j, departments d
WHERE (e.department_id= d.department_id (+));

--26. S? se afi?eze numele ?i data angaj?rii pentru salaria?ii care au fost angaja?i dup? 
--Gates.
SELECT e.last_name, e.hire_date
FROM employees e, employees g
WHERE UPPER(g.last_name)='GATES' AND e.hire_date>g.hire_date;

--27. S? se afi?eze numele salariatului ?i data angaj?rii împreun? cu numele ?i data 
--angaj?rii ?efului direct pentru salaria?ii care au fost angaja?i înaintea ?efilor lor. Se vor 
--eticheta coloanele Angajat, Data_ang, Manager si Data_mgr
SELECT e.last_name AS "Angajat", e.hire_date AS "Data_ang",m.last_name AS "Manager", m.hire_date AS "Data_mgr"
FROM employees e, employees m
WHERE e.hire_date<m.hire_date AND e.manager_id=m.employee_id;
