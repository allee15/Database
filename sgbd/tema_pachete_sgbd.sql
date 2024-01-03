--a
CREATE OR REPLACE PACKAGE pacheta_aae AS
    function salariu_minim(cod_departament employees_copy_aae.department_id%TYPE) return NUMBER;
	function get_manager_id(f_name employees_copy_aae.first_name%TYPE, l_name employees_copy_aae.last_name%TYPE) return NUMBER;
	function get_department_id (name_d departments_copy_aae.department_name%TYPE) return NUMBER;
	function get_job_id (name_j jobs_copy_aae.job_title%TYPE) return VARCHAR2;
	PROCEDURE post_employee(f_name employees_copy_aae.first_name%TYPE, l_name employees_copy_aae.last_name%TYPE, phone employees_copy_aae.phone_number%TYPE, email employees_copy_aae.email%TYPE);
END pacheta_aae;
/

CREATE OR REPLACE PACKAGE BODY pacheta_aae IS
	function salariu_minim(cod_departament employees_copy_aae.department_id%TYPE)
	return NUMBER is minim NUMBER;
	begin
		select min(salary) 
        into minim 
        from employees_copy_aae 
        where department_id = cod_departament;
		return minim;
	end salariu_minim;
    
    function get_manager_id(f_name employees_copy_aae.first_name%TYPE, l_name employees_copy_aae.last_name%TYPE) 
	return NUMBER is cod NUMBER;
	begin
		select employee_id 
        into cod 
        from employees_copy_aae 
        where first_name = f_name and last_name = l_name and employee_id is not null;
		return cod;
	end get_manager_id;
    
    function get_department_id(name_d departments_copy_aae.department_name%TYPE)
	return NUMBER is depart_id NUMBER;
	begin
		select department_id 
        into depart_id 
        from departments_copy_aae
        where department_name = name_d;
		return depart_id;
	end get_department_id;
    
    function get_job_id(name_j jobs_copy_aae.job_title%TYPE)
	return VARCHAR2 is j_id VARCHAR2(10);
	begin
		select job_id 
        into j_id 
        from jobs 
        where job_title = name_j;
		return j_id;
	end get_job_id;
    
    PROCEDURE post_employee(f_name employees_copy_aae.first_name%TYPE, l_name employees_copy_aae.last_name%TYPE, phone employees_copy_aae.phone_number%TYPE, email employees_copy_aae.email%TYPE) IS
	h_date employees_copy_aae.hire_date%TYPE;
	sal employees_copy_aae.salary%TYPE;
	manager_code employees_copy_aae.employee_id%TYPE;
	department_code employees_copy_aae.department_id%TYPE;
	job_code VARCHAR2(10);
	
	BEGIN
        department_code := get_department_id('IT');
		sal := salariu_minim(department_code);
		manager_code := get_manager_id('Alexander', 'Hunold');
		job_code := get_job_id('Programmer');
		select CURRENT_DATE
        into h_date
        from dual;
		insert into employees_copy_aae (first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
		values (f_name, l_name, email, phone, h_date, job_code, sal, 0, manager_code, department_code);
	END post_employee;
END pacheta_aae;
/

begin
    pacheta_aae.post_employee('Mr. Alex', 'III', '0732545454', 'gmaiol@gofod.com');
end;
/

select * from employees_copy_aae;

--b
CREATE or REPLACE PACKAGE pachetb_aae AS
	function salariu_minim(cod_departament employees_copy_aae.department_id%TYPE) return NUMBER;
	function comision_minim(cod_departament employees_copy_aae.department_id%TYPE, cod_job jobs_copy_aae.job_id%TYPE) return NUMBER;
	function get_manager_id(f_name employees_copy_aae.first_name%TYPE, l_name employees_copy_aae.last_name%TYPE) return NUMBER;
	function get_department_id (name_d departments_copy_aae.department_name%TYPE) return NUMBER;
	function get_job_id (name_j jobs_copy_aae.job_title%TYPE) return VARCHAR2;
	PROCEDURE switch_department(f_name employees_copy_aae.first_name%TYPE, l_name employees_copy_aae.last_name%TYPE, depart_name departments_copy_aae.department_name%TYPE, job_name jobs_copy_aae.job_title%TYPE);
END pachetb_aae;
/

CREATE or REPLACE PACKAGE BODY pachetb_aae IS
	function salariu_minim(cod_departament employees_copy_aae.department_id%TYPE)
	return NUMBER is minim NUMBER;
	begin
		select min(salary) 
        into minim
        from employees_copy_aae 
        where department_id = cod_departament;
		return minim;
	end salariu_minim;
	
    
	function get_manager_id(f_name employees_copy_aae.first_name%TYPE, l_name employees_copy_aae.last_name%TYPE) 
	return NUMBER is cod NUMBER;
	begin
		select employee_id 
        into cod from employees_copy_aae 
        where first_name = f_name and last_name = l_name and employee_id is not null;
		return cod;
	end get_manager_id;
	
    
	function get_department_id(name_d departments_copy_aae.department_name%TYPE)
	return NUMBER is depart_id NUMBER;
	begin
		select department_id 
        into depart_id 
        from departments_copy_aae
        where department_name = name_d;
		return depart_id;
	end get_department_id;
	

	function get_job_id(name_j jobs_copy_aae.job_title%TYPE)
	return VARCHAR2 is j_id VARCHAR2(10);
	begin
		select job_id 
        into j_id
        from jobs_copy_aae 
        where job_title = name_j;
		return j_id;
	end get_job_id;
	

	function comision_minim(cod_departament employees_copy_aae.department_id%TYPE, cod_job jobs_copy_aae.job_id%TYPE)
	return NUMBER is min_comis NUMBER;
	begin
		select min(COMMISSION_PCT) 
        into min_comis 
        from employees_copy_aae 
        where department_id = cod_departament and job_id = cod_job;
		return min_comis;
	end comision_minim;


	PROCEDURE switch_department(f_name employees_copy_aae.first_name%TYPE, l_name employees_copy_aae.last_name%TYPE, depart_name departments_copy_aae.department_name%TYPE, job_name jobs_copy_aae.job_title%TYPE) IS
	h_date employees_copy_aae.hire_date%TYPE;
	commis employees_copy_aae.commission_pct%TYPE;
	sal employees_copy_aae.salary%TYPE;
	manager_code employees_copy_aae.employee_id%TYPE;
	department_code employees_copy_aae.department_id%TYPE;
	job_code jobs_copy_aae.job_title%TYPE;
	BEGIN
		manager_code := get_manager_id(f_name, l_name);
		department_code := get_department_id(depart_name);
        job_code := get_job_id(job_name);
        commis := comision_minim(department_code, job_code);
        sal := salariu_minim(department_code);
		select CURRENT_DATE into h_date from dual;
		DELETE from employees_copy_aae where first_name = f_name and last_name = l_name and manager_id = manager_code;
		insert into employees_copy_aae (first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
		values (f_name, l_name, 'test@gmail.com', '123123123', h_date, job_code, sal, commis, manager_code, department_code);
	END switch_department;
END pachetb_aae;
/

begin
    pachetb_aae.switch_department('Alexander', 'Hunold', 'Sales', 'Sales Representative');
end;
/

select * from employees_copy_aae;



--- d.)
CREATE or REPLACE PACKAGE pachetd_aae AS
	PROCEDURE promote_emp(emp_id employees_copy_aae.employee_id%TYPE, new_salary employees_copy_aae.salary%TYPE);
END pachet4_aae;
/

CREATE or REPLACE PACKAGE BODY pachet4_aae IS
	PROCEDURE promote_emp(emp_id employees_copy_aae.employee_id%TYPE, new_salary employees_copy_aae.salary%TYPE) IS 
	id_manager employees_copy_aae.manager_id%TYPE;
	id_manager_manager employees_copy_aae.manager_id%TYPE;
	BEGIN
		select manager_id 
        into id_manager
        from employees_copy_aae 
        where employee_id = emp_id;
		
		select manager_id 
        into id_manager_manager 
        from employees_copy_aae 
        where employee_id = id_manager;
		
		UPDATE employees_copy_aae
		SET manager_id = id_manager_manager, salary = new_salary
		WHERE employee_id = emp_id;
	END promote_emp;
END pachetb_aae;
/

begin
    pachetb_aae.promote_emp(119, 3000);
end;
/

select * from employees_copy_aae;



---- e.)
CREATE or REPLACE PACKAGE pachete_aae IS
	CURSOR emps(name_e employees_copy_aae.first_name%TYPE) RETURN employees_copy_aae%ROWTYPE;
	PROCEDURE update_salary(emp_name employees_copy_aae.first_name%TYPE, new_salary employees_copy_aae.salary%TYPE);
END pachete_aae;
/

CREATE or REPLACE PACKAGE BODY pachet5_aae IS
	CURSOR emps(name_e employees_copy_aae.first_name%TYPE) RETURN employees_copy_aae%ROWTYPE IS
		select * 
        from employees_copy_aae 
        where first_name = name_e;
	PROCEDURE update_salary(emp_name employees_copy_aae.first_name%TYPE, new_salary employees_copy_aae.salary%TYPE)
    IS
		count_emp NUMBER;
		emp_list emps%ROWTYPE;
        
	BEGIN
		select count(*) 
        into count_emp 
        from employees_copy_aae 
        where first_name = emp_name;
		delete from employees_copy_aae where first_name = emp_name;
        DBMS_OUTPUT.PUT_LINE(count_emp);
		if count_emp > 1 then
			DBMS_OUTPUT.PUT_LINE('Exista mai multi angajati cu acest nume');
			open emps(emp_name);
			loop
				fetch emps into emp_list;
				exit when emps%NOTFOUND;
                insert into employees_copy_aae (first_name, last_name, hire_date, job_id, salary, commission_pct, manager_id, department_id)
                values (emp_name, emp_list.last_name, emp_list.hire_date, emp_list.job_id, new_salary, emp_list.commission_pct, emp_list.manager_id, emp_list.department_id);
				DBMS_OUTPUT.PUT_LINE(emp_list.first_name || ' ' || emp_list.last_name || ' ' || emp_list.employee_id);
			end loop;
			close emps;
		elsif count_emp = 1 then
			open emps(emp_name);
			loop
				fetch emps into emp_list;
				exit when emps%NOTFOUND;
				insert into employees_copy_aae (first_name, last_name, hire_date, job_id, salary, commission_pct, manager_id, department_id)
                values (emp_name, emp_list.last_name, emp_list.hire_date, emp_list.job_id, new_salary, emp_list.commission_pct, emp_list.manager_id, emp_list.department_id);				
                DBMS_OUTPUT.PUT_LINE(emp_list.first_name || ' ' || emp_list.last_name || ' ' || emp_list.employee_id);
			end loop;
			close emps;
		else
			DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu numele ' || emp_name);
        end if;
	END update_salary;
END pachete_aae;
/

begin
    pachete_aae.update_salary('Shelley', 5000);
end;
/

select * from employees_copy_aae;
			



---- f.)
CREATE or REPLACE PACKAGE pachetf_aae AS
	CURSOR emp_list(job_code jobs_copy_aae.job_id%TYPE)  RETURN employees_copy_aae%ROWTYPE;
    PROCEDURE show_emps_by_job(code jobs_copy_aae.job_id%TYPE);
END pachetf_aae;
/

CREATE or REPLACE PACKAGE BODY pachet6_aae IS
	CURSOR emp_list(job_code jobs_copy_aae.job_id%TYPE) RETURN employees_copy_aae%ROWTYPE is
		select * 
        from employees_copy_aae 
        where job_id = job_code;

    PROCEDURE show_emps_by_job(code jobs_copy_aae.job_id%TYPE) IS
		emp emp_list%ROWTYPE;
	begin
		OPEN emp_list(code);
		loop
			fetch emp_list into emp;
			EXIT WHEN emp_list%NOTFOUND;
			DBMS_OUTPUT.put_line(emp.first_name || ' ' || emp.last_name || ' ' || emp.employee_id);
		end loop;
		close emp_list;
    end show_emps_by_job;
END pachetf_aae;
/

begin
    pachete_aae.show_emps_by_job('IT_PROG');
end;
/

			
			
---- g.)
CREATE or REPLACE PACKAGE pachetf_aae AS
	CURSOR jobs_list RETURN jobs%ROWTYPE;
    PROCEDURE show_all_jobs;
END pachetf_aae;
/

CREATE or REPLACE PACKAGE BODY pachetf_aae IS
	CURSOR jobs_list RETURN jobs%ROWTYPE is
		select * from jobs;
    
    PROCEDURE show_all_jobs is
		job jobs%ROWTYPE;
	begin
		OPEN jobs_list;
		loop
			fetch jobs_list into job;
			EXIT WHEN jobs_list%NOTFOUND;
			DBMS_OUTPUT.put_line(job.job_title);
		end loop;
		close jobs_list;
    end show_all_jobs;
END pachetf_aae;
/

begin
    pachetf_aae.show_all_jobs();
end;
/


---- h.)
CREATE or REPLACE PACKAGE pacheth_aae AS
	CURSOR jobs_list RETURN jobs_copy_aae%ROWTYPE;
	CURSOR emps_list RETURN employees_copy_aae%ROWTYPE;
    PROCEDURE show_lists;
END pacheth_aae;
/

CREATE or REPLACE PACKAGE BODY pacheth_aae AS
	CURSOR jobs_list RETURN jobs_copy_aae%ROWTYPE IS
		select * 
        from jobs_copy_aae;
	CURSOR emps_list 
    RETURN employees_copy_aae%ROWTYPE IS
		select * 
        from employees_copy_aae;
	
    PROCEDURE show_lists IS
		job_ jobs_list%ROWTYPE;
		emp emps_list%ROWTYPE;
	BEGIN
		OPEN jobs_list;
		LOOP
			FETCH jobs_list into job_;
            exit when jobs_list%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE(job_.job_title || ':');
			OPEN emps_list;
			LOOP
				FETCH emps_list into emp;
                exit when emps_list%NOTFOUND;
				IF emp.job_id = job_.job_id then
					DBMS_OUTPUT.PUT_LINE(emp.employee_id || ' ' || emp.first_name || ' ' || emp.last_name);
                end IF;
			END LOOP;
			CLOSE emps_list;
            DBMS_OUTPUT.PUT_LINE('');
		END LOOP;
		CLOSE jobs_list;
    end show_lists;
END pacheth_aae;
/

begin
    pacheth_aae.show_lists();
end;
/