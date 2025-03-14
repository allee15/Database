/*ex 9*/
select first_name,
       last_name
  from employees
 where last_name like '__a%';

select *
  from employees;

 /*ex 10*/
select first_name,
       last_name
  from employees
 where first_name like '%l%l%'
   and ( department_id = 30
    or manager_id = 102 );

 /*ex 11*/
select first_name,
       last_name,
       salary
  from employees e
  join jobs j
on e.job_id = j.job_id
 where ( j.job_title like '%CLERK'
    or j.job_title like '%REP' )
   and e.salary not in ( 1000,
                         2000,
                         3000 );

/*ex 12*/
select e.first_name,
       d.department_name
  from employees e
  left join departments d
on e.department_id = d.department_id;

/*ex 13*/
select d.department_name,
       e.first_name
  from departments d
  left join employees e
on d.department_id = e.department_id;

/*ex 14*/
select e.employee_id,
       e.first_name,
       m.manager_id
  from employees e
  left join employees m
on e.employee_id = m.manager_id;

/*ex 15*/
select e.employee_id,
       e.first_name,
       m.manager_id
  from employees e
  left join employees m
on e.employee_id = m.manager_id;

/*ex 16*/
select department_name
  from departments d,
       employees e
 where e.department_id != d.department_id;

/*ex 17*/
select round(
	max(salary)
) as maxim,
       round(
	       min(salary)
       ) as minim,
       round(
	       sum(salary)
       ) as suma,
       round(
	       avg(salary)
       ) as media
  from employees;

/*ex 18*/
select job,
       round(
	       min(salariu)
       ) as minim,
       round(
	       max(salariu)
       ) as maxim,
       round(
	       sum(salariu)
       ) as suma,
       round(
	       avg(salariu)
       ) as media
  from employees
 group by job;