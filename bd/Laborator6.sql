--1a)
select last_name,salary, department_id
from employees e
where salary> (select avg(salary)
                from employees
                where department_id = e.department_id);
                
--b)
select lsat_name, salary, department_id, department_name, med_sal, numar
from employees e join departments d on (e.department_id = d.department_id)
                join (select department_id, avg(salary) med_sal, count(*) numar
                    from employees
                    group by department_id) s on (e.department_id = s.department_id)
where salary> (select avg(salary)
                from employees
                where department_id=e.department_id);