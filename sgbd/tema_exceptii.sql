
create table error_aae (cod NUMBER not null,
                        mesaj VARCHAR2(200) not null);
                        
--1
DECLARE
    input_num NUMBER := &input_num;
BEGIN
    IF input_num < 0 THEN
    
INSERT INTO error_aae (cod, mesaj)
VALUES (-20001, 'Cannot calculate square of a negative number');
    RAISE_APPLICATION_ERROR(-20001, 'Cannot calculate square of a negative number');
    ELSE
     dbms_output.put_line('SQRT: ' || SQRT(input_num));
  END IF;
END;
/
--2
DECLARE
    salariu NUMBER := &salariu;
    emp emp_aae%ROWTYPE;
BEGIN
    select *
    into emp
    from emp_aae
    where salariu = salary;
    
    DBMS_OUTPUT.PUT_LINE( emp.last_name ||' ' || emp.first_name);
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('nu exista salariati care sa castige acest salariu');
    RAISE_APPLICATION_ERROR(-20002, 'nu exista salariati care sa castige acest salariu');
    
    WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE(' exista mai multi salariati care castiga acest salariu');
    RAISE_APPLICATION_ERROR(-20003, 'exista mai multi salariati care castiga acest salariu');
    
    
END;
/

select *
from emp_aae;

--3
DECLARE
    dep_id dept_aae.department_id%TYPE := &dep_id;
    error exception;
    pragma exception_init (error, -02292);
    emp emp_aae%ROWTYPE;
BEGIN
    select *
    into emp
    from emp_aae
    where department_id = dep_id;
    
    update dept_aae
    set department_id = dep_id *100
    where department_id = dep_id; 
    
    exception 
    
    when no_data_found then
    update dept_aae
    set department_id = dep_id *100
    where department_id = dep_id; 
    
    when TOO_MANY_ROWS then
    dbms_output.put_line('nu se poate modifica codul departamentului');
    raise_application_error(-20999, 'nu se poate modifica codul departamentului');
end;
/
select* from dept_aae; 
select* from emp_aae;

--4
DECLARE
    x NUMBER := &x;
    y NUMBER := &y;
    emp_count NUMBER;
    dept_name VARCHAR2(50);
BEGIN
    SELECT d.department_name ,count(*)
    INTO dept_name, emp_count
    FROM emp_aae e
    JOIN dept_aae d ON e.department_id = d.department_id
    WHERE d.department_id = 10
    GROUP BY d.department_name;

    IF emp_count BETWEEN x AND y THEN
        DBMS_OUTPUT.PUT_LINE('Departamentul 10 ' || dept_name || ' are ' || emp_count || ' angajati.');
    END IF;
    
EXCEPTION
    
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista angajati in acest apartament.');
        RAISE_APPLICATION_ERROR(-20005, 'Nu exista angajati in acest apartament.');

END;
/


--5
DECLARE
    dep_id NUMBER := &dep_id;
    new_name VARCHAR2(50) := &new_name;
begin
    update dept_aae
    set department_name = new_name
    where department_id = dep_id;
    if sql%rowcount = 0 then
       dbms_output.put_line('Departamentul cu idul ' || dep_id || ' nu exista');
    end if;
    
exception
    when OTHERS THEN
    dbms_output.put_line('O eroare: '|| sqlerrm);
    
end;
/

select * from dept_aae;

--6
DECLARE
    loc_id NUMBER := &loc_id;
    dep_id NUMBER := &dep_id;
    dep_name1 VARCHAR2(50);
    dep_name2 varchar2(50);
    er1 number;
    er2 number;
begin
    select department_name 
    into dep_name1
    from dept_aae
    where location_id = loc_id;
    if dep_name1 is null then
        er1:=1;
    end if;
    
    dbms_output.put_line('numele departamentului din locatia data este ' || dep_name1);
    
    select department_name
    into dep_name2
    from dept_aae
    where department_id = dep_id;
    if dep_name2 is null then 
        er2:=1;
    end if;
    
    dbms_output.put_line('numele departamentului cu idul dat este ' ||dep_name2);
    
    exception
    when no_data_found then
        if er1 = 1 then 
          dbms_output.put_line('nu exista departament in locatia data');
        elsif er2 = 1 then
            dbms_output.put_line('nu exista departament cu idul dat');
        end if;
end;
/
select* from dept_aae;


    
    
    
    

   
    