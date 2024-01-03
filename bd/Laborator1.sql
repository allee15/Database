-- S? se listeze structura tabelelor din schema HR (EMPLOYEES, DEPARTMENTS, JOBS, JOB_HISTORY, LOCATIONS, COUNTRIES, REGIONS), observând tipurile de date ale coloanelor.
DESC employees;
DESC departments;
DESC jobs;
DESC job_history;
DESC locations;
DESC countries;
DESC regions;

-- S? se listeze con?inutul tabelelor din schema considerat?, afi?ând valorile tuturor câmpurilor.
SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM job_grades;
SELECT * FROM job_history;
SELECT * FROM jobs;
SELECT * FROM locations;
SELECT * FROM regions;

-- S? se afi?eze codul angajatului, numele, codul job-ului, data angajarii.
SELECT employee_id, last_name, first_name, job_id, hire_date
FROM employees;
    
-- Modifica?i cererea anterioar? astfel încât, la rulare, capetele coloanelor s? aib? numele cod, nume, cod job, data angajarii.
SELECT employee_id AS "Cod", last_name || ' ' || first_name AS "Nume", job_id AS "Cod job", hire_date AS "Data angajarii"
FROM employees;

-- S? se listeze, cu ?i f?r? duplicate, codurile job-urilor din tabelul EMPLOYEES.
SELECT job_id 
FROM employees;

SELECT distinct job_id
FROM employees;

-- S? se afi?eze numele concatenat cu job_id-ul, separate prin virgula ?i spatiu. Eticheta?i coloana “Angajat si titlu”.
SELECT last_name || ' , ' || job_id AS "Angajat si titlu"
FROM employees;

-- Crea?i o cerere prin care s? se afi?eze toate datele din tabelul EMPLOYEES pe o singur? coloan?.
-- Separa?i fiecare coloan? printr-o virgul?. Etichetati coloana ”Informatii complete”.
SELECT employee_id || ' , ' || first_name || ' , ' || last_name || ' , ' || email || ' , ' || phone_number AS "Informatii complete"
FROM employees;

-- S? se listeze numele si salariul angaja?ilor care câ?tig? mai mult de 2850.
SELECT last_name, first_name, salary
FROM employees 
WHERE salary > 2850;

-- S? se creeze o cerere pentru a afi?a numele angajatului ?i codul departamentului pentru angajatul având codul 104.
SELECT last_name, first_name, department_id
FROM employees
WHERE employee_id=104;


-- S? se afi?eze numele ?i salariul angaja?ilor al c?ror salariu nu se afl? în intervalul [1500, 2850].
SELECT last_name, first_name, salary
FROM employees
WHERE salary NOT BETWEEN 1500 AND 2850;

-- S? se afi?eze numele, job-ul ?i data la care au început lucrul salaria?ii angaja?i între 20 Februarie 1987 ?i 1 Mai 1989. 
-- Rezultatul va fi ordonat cresc?tor dup? data de început.
SELECT last_name, first_name, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN '20-FEB-1987' AND '1-MAY-1989'
ORDER BY hire_date;

-- S? se afi?eze numele salaria?ilor ?i codul departamentelor pentru toti angaja?ii din departamentele 10, 30 ?i 50 în ordine 
-- alfabetic? a numelor.
SELECT last_name, first_name, department_id
FROM employees
WHERE department_id IN (10,30,50) 
ORDER BY last_name;

--S? se listeze numele ?i salariile angaja?ilor care câ?tig? mai mult decât 1500 ?i lucreaz? în departamentul 10, 30 sau 50. 
-- Se vor eticheta coloanele drept Angajat si Salariu lunar.
SELECT last_name || ' , ' || first_name AS "Angajat", salary AS "Salariu lunar"
FROM employees
WHERE salary > 1500 AND department_id IN (10,30,50);

-- Care este data curent?? Afi?a?i diferite formate ale acesteia.
SELECT TO_CHAR(sysdate, 'dd/YYYY') FROM dual;

--S? se afi?eze numele ?i data angaj?rii pentru fiecare salariat care a fost angajat în 1987. 
--Se cer 2 solu?ii: una în care se lucreaz? cu formatul implicit al datei ?i alta prin care se formateaz? data.
--Varianta 1
SELECT last_name, first_name, hire_date
FROM employees
WHERE hire_date LIKE ('%87%');

--Varianta 2
SELECT last_name, first_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY') = 1987;

-- S? se afi?eze numele, prenumele ?i data angaj?rii persoanelor care au început activitatea într-o zi a lunii egal? cu cea a 
-- datei curente.
SELECT last_name, first_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date,'DD') = TO_CHAR(sysdate,'DD');

-- S? se afi?eze numele ?i job-ul pentru to?i angaja?ii care nu au manager.
SELECT last_name, job_id
FROM employees
WHERE manager_id IS NULL;

-- S? se afi?eze numele, salariul ?i comisionul pentru toti salaria?ii care câ?tig? comision (se presupune c? aceasta înseamn? 
-- prezen?a unei valori nenule în coloana respectiv?). 
-- S? se sorteze datele în ordine descresc?toare a salariilor ?i comisioanelor.
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL 
ORDER BY salary DESC, commission_pct DESC;

--Elimina?i clauza WHEREdin cererea anterioar?. Unde sunt plasate valorile NULL
--în ordinea descresc?toare?
SELECT last_name, salary, commission_pct
FROM employees
ORDER BY salary DESC, commission_pct DESC;

--S? se listeze numele tuturor angaja?ilor care au a treia liter? din nume ‘A’.
SELECT last_name 
FROM employees
WHERE last_name LIKE '__a%';

--S?  se  listeze  numele  tuturor  angajatilor  care  au  2  litere  ‘L’  in 
--nume  ?i  lucreaz? în departamentul 30 sau managerul lor este 102.
SELECT last_name, manager_id, department_id
FROM employees
WHERE (UPPER(last_name) LIKE ('%L%L%') AND department_id = 30) OR manager_id = 102;

--S? se afiseze numele, job-ul si salariul pentru toti salariatii al caror job con?ine
--?irul “CLERK” sau “REP” ?i salariul nu este egal cu 1000, 2000 sau 3000. (operatorul NOT IN)
SELECT last_name, job_id, salary
FROM employees
WHERE (job_id LIKE '%CLERK%' OR job_id LIKE '%REP%') AND salary NOT IN (1000,2000,3000);

--S? se afi?eze numele departamentelor care nu au manager.
SELECT department_name 
FROM departments
WHERE manager_id IS NULL;






































