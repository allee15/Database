--11.S? se afi?eze cel mai mare salariu, cel mai mic salariu, suma ?i media salariilor tuturor angaja?ilor. 
--Eticheta?i coloanele   Maxim, Minim,   Suma,   respectiv  Media.  S?  se rotunjeasc?rezultatele. 
SELECT MIN(salary) minim, MAX(salary) maxim, SUM(salary) suma, ROUND(AVG(salary)) 
FROM employees;

--12.S? se afi?ezeminimul, maximul, suma ?i media salariilor pentru fiecare job.
SELECT MIN(salary) min, MAX(salary) max, SUM(salary) suma, ROUND(AVG(salary)) media
FROM employees
WHERE job_id IS NOT NULL;

--13.S? se afi?eze num?rul de angaja?i pentru fiecare job
SELECT job_id, COUNT(employee_id) 
FROM employees
GROUP BY job_id;

--14.S? se determine num?rul de angaja?i care sunt ?efi. Eticheta?i coloana “Nr. manageri”.
SELECT job_id, COUNT(employee_id) "Nr. manageri"
FROM employees
WHERE manager_id IS NULL
GROUP BY job_id;

--16.Scrie?i  o cerere  pentru  a  se  afi?a  numele  departamentului,  loca?ia,  num?rul  de angaja?i ?i salariul mediu pentru 
--angaja?ii din acel departament. Coloanele vor fi etichetate corespunz?tor.
SELECT department_name "Departament”
        (SELECT COUNT(employee_id)
        FROM employees
        WHERE department_id = d.department_id ) "Nr. angajati"
        (SELECT AVG(salary)
        FROM employees
        WHERE department_id = d.department_id) "Salariu mediu”)
FROM departments d;

--18.Pentru fiecare ?ef, s? se afi?eze codul s?u ?i salariul celui mai pu?inplatit subordonatal s?u.  Se  vor  exclude  cei  pentru  care  codul  managerului  nu 
--este  cunoscut.  De asemenea,  se  vor  exclude  grupurile  în  care  salariul  minim  este  mai  mic  de 1000$. Sorta?i rezultatul în ordine descresc?toare a salariilor.
SELECT manager_id, MIN(salary) 
FROM employees 
WHERE manager_id IS NOT Null 
GROUP BY manager_id 
HAVING MIN(salary) > 1000 
ORDER BY 2 DESC; 

--19.Pentru departamentele in care salariul maxim dep??e?te 3000$, s? se ob?in? codul, numele acestor departamente ?i salariul maxim pe departament.
SELECT department_id, MAX(salary), employee_id, last_name
FROM employees
GROUP BY department_id
HAVING MIN(salary)>5000;

--21.S? se afi?eze codul, numele departamentului ?i suma salariilor pe departamente.
SELECT d.department_id, department_name,a.suma
FROM departments d, (SELECT department_id ,SUM(salary) suma
FROM employees
GROUP BY department_id) a
WHERE d.department_id =a.department_id;

--22.S? se afi?eze maximul salariilor medii pe departamente.
SELECT MAX(AVG(salary))
FROM employees
GROUP BY department_id;

--23.S? se ob?in?codul, titlul ?i salariul mediu al job-ului  pentru  care  salariul  mediu  este minim. 
SELECT job_id, job_title
FROM jobs
GROUP BY job_id
HAVING AVG(salary) = (SELECT MIN(AVG(salary))
FROM employees
GROUP BY job_id);
