--2 a)
DECLARE 
    TYPE emp_record IS RECORD
        (emp_cod employees.employee_id%TYPE,
        emp_salariu employees.salary%TYPE,
        emp_job employees.job_id%TYPE);
        
x emp.record; 
BEGIN
x.emp_cod :=100;
x.emp_salariu:=2000;
x.emp_job:='SA_MAN';
DBMS_OUTPUT.PUT_LINE(x.emp_id);
END;
/