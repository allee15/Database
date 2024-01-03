--1.S? se afi?eze codurile  departamentelor,  codurile  job-urilor ?i o coloan? reprezentând suma salariilor pe departamente ?i, în cadrul acestora, pe job-uri.
select department_id, job_id, sum(salary)
from employees
group by department_id, job_id;

--2.Modifica?i cererea     anterioar?astfel     încât rezultatul  s?  includ? numele departamentelor ?i titlurilejob-urilor.
select department_id, department_name, job_id, job_title, sum(salary)
from employees join departments
group by department_id, job_id;

--3.S? se afi?eze numele departamentului ?i cel mai mic salariu din departamentul având cel mai mare salariu mediu.
select department_name, min(salary)
from employees join departments using (department_id)
group by department_name
having avg(salary) IN (select max(avg(salary))
                        from employees
                        group by department_id);
                    
--4.S? se afi?ezecodul, numele departamentului ?i num?rul de angaja?i care lucreaz? în acel departament pentru:
--a)departamentele în care lucreaz? mai pu?in de 4 angaja?i;   
select department_id, department_name, count(*)
from employees join departments using (department_id)
group by department_id, department_name
having count(*)<4;

--b)departamentul care are num?rul maxim de angaja?i.
select department_id, department_name, count(*)
from employees join departments using (department_id)
group by department_id, department_name
having count(*) IN (select max(count(*))
                    from employees join departments using (department_id)
                    group by department_id, department_name);
                    
--5.S? se afi?eze salaria?ii care au fost angaja?i în aceea?izi  a  lunii (ca num?r al zilei în lun?) în care cei mai mul?i dintre salaria?i au fost angaja?i.
select last_name, hire_date
from employees
where to_char(hire_date, 'DD')= (select to_char(hire_date, 'DD')
                                from employees
                                group by to_char(hire_date, 'DD')
                                having count(*) IN (select max(count(*))
                                                    from employees
                                                    group by to_char(hire_date, 'DD')));
                                                    
--6.S? se ob?in? num?rul departamentelor care au cel pu?in 15 angaja?i.
select count(*) 
from departments 
where department_id in (select department_id 
                        from employees  
                        group by department_id 
                        having count(*) >= 15); 

--7.S? se ob?in? codul departamentelor ?i suma salariilor angaja?ilor care lucreaz? în acestea,  
--în  ordine cresc?toare. Se consider? departamentele care aumai  mult  de  10 angaja?i ?i al c?ror cod este diferit de 30.
select department_id, sum(salary)
from employees 
group by department_id
having department_id in (select department_id 
                        from employees 
                        group by department_id 
                        having count(*) >= 10 and department_id != 30)
order by 2; 

--8.S? se afi?eze codul, numele departamentului, num?rul de angaja?i ?i salariul mediu din departamentul respectiv,
--împreun? cu numele, salariul ?i jobul angaja?ilor  din  aceldepartament. Se vor afi?a ?i departamentele f?r? angaja?i.
select department_id, department_name, avg(e.salary), c.last_name, c.first_name, c.salary
from employees e join employees c using (department_id)
                right join departments using (department_id)
group by department_id, department_name, c.last_name, c.first_name, c.salary;

--9.S? se ob?in?, pentru departamentele având codul > 80, salariul total pentru fiecare job din  cadrul 
--departamentului. Se vor afi?a ora?ul,numele  departamentului, jobul ?i suma salariilor. Se vor eticheta coloanele corespunz?tor
select city, department_name, job_id, sum(salary)
from departments join locations using (location_id)
                join employees using (department_id)
group by department_id, department_name, job_id, city
having department_id>80;

--10.Care sunt angaja?ii (cod, nume) care au mai avut cel pu?in dou?joburi?
select * from job_history;
desc job_history;

select employee_id, last_name
from employees join job_history using (employee_id)
group by employee_id, last_name
having count(*) >1;

--11.S? se calculeze comisionul mediu din firm?, luând în considerare toate liniile din tabel.
select avg(nvl(commission_pct, 0))
from employees;

--12.S?  se  afi?ezedenumirea job-ului,  salariul  total  pentru  job-ul  respectiv în  toate departamentele?i    
--salariul    total    pentru    job-ul    respectiv în    fiecare    dintre departamentele 30, 50, 80. Se vor eticheta 
--coloanele corespunz?tor. Rezultatul va ap?rea sub forma de mai jos
select job_id, (select sum(salary) from employees where department_id = 30 and job_id= e, job_id) "Dep30",
               (select sum(salary) from employees where department_id = 50 and job_id= e, job_id) "Dep50",
               (select sum(salary) from employees where department_id = 80 and job_id= e, job_id) "Dep80",
                sum(salary)
from employees
group by job_id;

--13.S? se afi?eze num?rul total de angaja?i ?i, din acest total, num?rul  celor  care  au  fost angaja?i  
--în  1997,  1998,  1999  ?i  2000.  Denumi?i  capetele  de  tabel  în  mod corespunz?tor.
select count(*) "Total", count(decode(to_char(hire_date, 'YYYY'), '1997')) "Anul 1997",
                        count(decode(to_char(hire_date, 'YYYY'), '1998')) "Anul 1998",
                        count(decode(to_char(hire_date, 'YYYY'), '1999')) "Anul 1999",
                        count(decode(to_char(hire_date, 'YYYY'), '2000')) "Anul 2000"
from employees;

--14.S? se afi?eze codul, numele departamentului ?i suma salariilor pe departamente.
select d.department_id, department_name, a.suma
from departments d, (select department_id, sum(salary) suma
                    from employees
                    group by department_id) a
where d.department_id = a.department_id;

--15.Utilizând   subcereri,   s? se  afi?eze titlul   job-ului,salariulmediucorespunz?tor?idiferen?a dintre media limitelor (min_salary, max_salary)?i media real?.
select job_title, (max_salary+min_salary)/2, max_salary-min.salary, a.medie
from jobs join (select job_id, avg(salary) medie
                from employees
                group by job_id) a using (job_id);

--16.Modifica?i cererea anterioar?, pentru a determina ?i listarea num?rului de angaja?i corespunz?torifiec?ruijob
select job_title, (max_salary+min_salary)/2, max_salary-min.salary, a.medie, a.numar
from jobs join (select job_id, avg(salary) medie, count(*) numar
                from employees
                group by job_id) a using (job_id);

--17.Pentru fiecare departament, s? se afi?eze denumireaacestuia, precum ?inumele ?i salariul celor mai slabpl?ti?i angaja?i din cadrul s?u.
select department_name, last_name, salary
from departments join (select e.department_id, e.last_name, e.salary
                        from employees e join departments d on (e.department_id=d.department_id)
                        where salary= ALL (select salary
                                            from employees
                                            where department_id= d.department_id)) using (department_id);

