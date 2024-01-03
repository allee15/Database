--1.Scrie?i o cerere pentru a se afisa numele, luna (în litere) ?i anul angaj?rii
--pentru to?i salaria?ii  din  acelasi  departament  cu  Gates,  al  c?ror  nume  
--con?ine  litera  “a”. Se  va exclude Gates. Se vor da 2 solu?ii pentru determinarea 
--apari?iei literei “A” în nume. De asemenea, pentru una din metode se va da ?i varianta join-ului  conform  standardului SQL3.
SELECT e.last_name, to_char(e.hire_date, 'month yyyy')
FROM employees e JOIN employees coleg USING (department_id)
WHERE lower(e.last_name) LIKE '%a%' AND e.employee_id != 190 AND coleg.employee_id = 190;

SELECT last_name, employee_id
FROM employees
WHERE Initcap(last_name) = 'Gates';

--2.S? se afi?eze codul ?i numele angaja?ilor care lucreaz? în acela?i departament cu cel pu?in un angajat al c?rui nume 
-- con?ine litera “t”. 
-- Se vor afi?a, de asemenea, codul ?i numele departamentului respectiv. Rezultatul va fi ordonat alfabetic dup? nume.
SELECT distinct e.employee_id, e.last_name, e.first_name, d.department_id, d.department_name
FROM employees e JOIN departments d ON (e.department_id = d.department_id)
               JOIN employees coleg ON (e.department_id = coleg.department_id)
WHERE lower(coleg.last_name) LIKE '%t%' AND coleg.department_id = e.department_id AND coleg.employee_id != e.employee_id
ORDER BY e.last_name;

-- 3. S? se afi?eze numele, salariul, titlul job-ului, ora?ul ?i ?ara în care lucreaz? angaja?ii condu?i direct de King.
SELECT e.last_name, e.salary, j.job_title, l.city, c.country_name
FROM employees e JOIN employees mgr ON (e.manager_id = mgr.employee_id)
                 JOIN jobs j ON (e.job_id = j.job_id)
                 JOIN departments d ON (e.department_id = d.department_id)
                 JOIN locations l ON (d.location_id = l.location_id)
                 JOIN countries c ON (l.country_id = c.country_id)
WHERE lower(mgr.last_name) = 'king';

-- 4. S? se afi?eze codul departamentului, numele departamentului, numele ?i job-ul tuturor angaja?ilor din departamentele al 
-- c?ror nume con?ine  ?irul ‘ti’. De asemenea, se va lista salariul angaja?ilor, în formatul “$99,999.00”. Rezultatul se va
-- ordona alfabetic dup? numele departamentului, ?i în cadrul acestuia, dup? numele angaja?ilor.
SELECT department_id, department_name, last_name, job_id, job_title, to_char(salary, '$99,999.00')
FROM departments JOIN employees USING (department_id)
                JOIN jobs USING (job_id)
WHERE lower(department_name) LIKE '%ti%' 
ORDER BY department_name, last_name;

-- 5. S? se afi?eze numele angaja?ilor, num?rul departamentului, numele departamentului, ora?ul ?i job-ul tuturor salaria?ilor al 
-- c?ror departament este localizat în Oxford.
SELECT last_name, department_id, department_name, job_title, city
FROM employees  JOIN departments  USING (department_id)
                 JOIN jobs  USING (job_id)
                 JOIN locations  USING (location_id)
WHERE UPPER(city) = 'OXFORD';

-- 6. S? se modifice cererea de la problema 2 astfel încât s? afi?eze codul, numele ?i salariul tuturor angaja?ilor care ca?tig? 
-- mai mult decât salariul mediu pentru job-ul corespunz?tor ?i lucreaz? într-un departament cu cel pu?in unul dintre angaja?ii
-- al c?ror nume con?ine litera “t”.
SELECT distinct e.employee_id, e.last_name, e.first_name, e.salary, d.department_id, d.department_name
FROM employees e JOIN departments d ON (e.department_id = d.department_id)
WHERE salary > (SELECT (min_salary + max_salary)/2
                FROM jobs
                WHERE e.job_id = job_id)
    AND exists (SELECT 1
                FROM employees
                WHERE e.department_id = department_id AND lower(last_name) LIKE '%t%')
ORDER BY e.last_name;

-- 7 .S? se afi?eze numele salaria?ilor ?i numele departamentelor în care lucreaz?. Se vor afi?a ?i salaria?ii care nu au 
-- asociat un departament. 
SELECT last_name, department_name
FROM employees LEFT JOIN departments USING (department_id);

-- 9. S? se afi?eze numele departamentelor ?i numele salaria?ilor care lucreaz? în ele. Se vor afi?a ?i departamentele care 
-- nu au salaria?i.
SELECT department_name, last_name
FROM employees RIGHT JOIN departments USING (department_id);

-- 11. Se cer codurile departamentelor al c?ror nume con?ine ?irul “re” sau în care lucreaz? angaja?i având codul job-ului “SA_REP”.
SELECT department_id
FROM departments
WHERE lower(department_name) LIKE '%re%' 
UNION 
SELECT department_id
FROM employees
WHERE upper(job_id) LIKE 'SA_REP';

-- 13. S? se ob?in? codurile departamentelor în care nu lucreaza nimeni (nu este introdus nici un salariat în tabelul employees). 
-- Se cer dou? solu?ii (MINUS, NOT IN).
SELECT department_id
FROM departments
MINUS
SELECT department_id
FROM employees;

SELECT department_id
FROM departments 
WHERE department_id NOT IN (SELECT nvl(department_id,0) FROM employees);

-- 14. Se cer codurile departamentelor al c?ror nume con?ine ?irul “re” ?i în care lucreaz? angaja?i având codul job-ului “HR_REP”.
SELECT department_id
FROM departments
WHERE lower(department_name) LIKE '%re%'
INTERSECT
SELECT department_id
FROM employees
WHERE job_id = 'HR_REP';

-- 15. S? se determine codul angaja?ilor, codul job-urilor ?i numele celor al c?ror salariu este mai mare decât 3000 sau 
-- este egal cu media dintre salariul minim ?i cel maxim pentru job-ul respectiv.
SELECT employee_id, job_id, last_name
FROM employees
WHERE salary> 3000
UNION
SELECT employee_id, job_id, last_name
FROM employees JOIN jobs USING (job_id)
WHERE salary > (min_salary + max_salary)/2;

-- 16.  Folosind subcereri, s? se afi?eze numele ?i data angaj?rii pentru salaria?ii care au fost angaja?i dup? Gates.
SELECT last_name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date 
                    FROM employees
                    WHERE INITCAP(last_name)='Gates');

-- 17. Folosind subcereri, scrie?i o cerere pentru a afi?a numele ?i salariul pentru to?i colegii (din acela?i departament) 
-- lui Gates. Se va exclude Gates.
SELECT last_name, salary
FROM employees
WHERE department_id IN (SELECT department_id
                        FROM employees
                        WHERE lower(last_name) = 'gates')
    AND lower(last_name) <> 'gates';
    
-- 18. Folosind subcereri, s? se afi?eze numele ?i salariul angaja?ilor condu?i direct de
--pre?edintele companiei (acesta este considerat angajatul care nu are manager).
SELECT last_name, salary
FROM employees
WHERE manager_id IN (SELECT employee_id
                     FROM employees
                     WHERE manager_id IS NULL);
                     
-- 19. Scrie?i o cerere pentru a afi?a numele, codul departamentului ?i salariul angaja?ilor al c?ror cod de departament ?i 
-- salariu coincid cu codul departamentului ?i salariul unui angajat care câ?tig? comision.
SELECT last_name, department_id, salary
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, salary
                                  FROM employees
                                  WHERE commission_pct IS NOT NULL);
                                
-- 21. Scrieti o cerere pentru a afi?a angaja?ii care câ?tig? mai mult decât oricare func?ionar (job-ul con?ine ?irul “CLERK”). 
-- Sorta?i rezultatele dupa salariu, în ordine descresc?toare.
SELECT last_name
FROM employees
WHERE salary > ANY (SELECT salary
                    FROM employees
                    WHERE upper(job_id) LIKE '%CLERK%')
ORDER BY salary DESC;

-- 22. Scrie?i o cerere pentru a afi?a numele, numele departamentului ?i salariul angaja?ilor care nu câ?tig? comision, 
-- dar al c?ror ?ef direct câ?tig? comision.
SELECT last_name, department_name, salary
FROM employees e JOIN departments USING (department_id)
WHERE commission_pct IS NULL AND e.manager_id IN (SELECT e.manager_id
                                                  FROM employees e JOIN employees mgr ON (e.manager_id = mgr.employee_id)
                                                  WHERE e.commission_pct IS NOT NULL);


-- 23. S? se afi?eze numele, departamentul, salariul ?i job-ul tuturor angaja?ilor al c?ror salariu ?i comision coincid cu salariul 
-- ?i comisionul unui angajat din Oxford.
SELECT last_name, department_id, salary, job_id
FROM employees
WHERE (salary, nvl(commission_pct, 0)) IN (SELECT salary, nvl(commission_pct, 0)
                                           FROM employees JOIN departments USING (department_id)
                                                          JOIN locations USING (location_id)
                                           WHERE city = 'Oxford');
                                           
-- 24. S? se afi?eze numele angaja?ilor, codul departamentului ?i codul job-ului salaria?ilor al c?ror departament se afl? în Toronto.
SELECT last_name, department_id, job_id
FROM employees
WHERE department_id IN (SELECT department_id 
                        FROM departments JOIN locations USING (location_id)
                        WHERE city = 'Toronto');