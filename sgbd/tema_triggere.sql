CREATE TABLE info_dept_aae (department_id NUMBER(5) PRIMARY KEY,
                            department_name VARCHAR2(30) NOT NULL,
                            plati NUMBER(5) NOT NULL);
                            
--1
/
CREATE OR REPLACE TRIGGER ex1 
   BEFORE DELETE ON dept_aae 
BEGIN
    IF ( USER NOT LIKE 'SCOTT') THEN
         RAISE_APPLICATION_ERROR(-20000, 'Utilizatorul nu poate sterge date');
     END IF; 
END;
/

DELETE FROM dept_aae
WHERE department_id=10;

--2
/
CREATE OR REPLACE TRIGGER ex2 
    BEFORE UPDATE OF commission_pct ON EMPLOYEES
    FOR EACH ROW
BEGIN
    IF(:NEW.commission_pct >= 0.5 )
        THEN RAISE_APPLICATION_ERROR(-20006, 'Pretul nu poate creste cu mai mult de 0.5');
    END IF;
END;
/
UPDATE EMPLOYEES
SET commission_pct = commission_pct + 0.1
WHERE employee_id=145;


--3a
ALTER TABLE info_dept_aae
ADD numar NUMBER(4);

UPDATE info_dept_aae a
SET numar = (SELECT COUNT(*)
            FROM info_dept_aae e
            WHERE a.department_id = e.department_id);
COMMIT;
--3b
/
CREATE OR REPLACE TRIGGER ex3b
    AFTER INSERT OR DELETE OR UPDATE ON info_emp_aae
BEGIN
    UPDATE info_dept_aae a
    SET numar = (SELECT COUNT(*)
                FROM info_emp_aae e
                WHERE a.department_id = e.dep_id);
END;
/

SELECT * FROM info_dept_aae;
SELECT* FROM info_emp_aae;

INSERT INTO info_emp_aae
VALUES (206, 'Popescu', 'Ion', 1000, 100);

--4
CREATE OR REPLACE TRIGGER ex4_aae
    BEFORE INSERT ON employees
    FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    select COUNT(*) 
    into v_count 
    from employees
    where department_id = :NEW.department_id;
    
    DBMS_OUTPUT.put_line(v_count);
    
    IF v_count >= 45 then
        RAISE_APPLICATION_ERROR(-20006, 'Prea multi angajati in acest departament');
    END IF;
END;
/

insert into employees
values (44567, 'Aldea', 'Alexia', 'alexia@email.com', '515.565.123', '18-DEC-20', 'IT_PROG', 1050, 0, 100, 50);

delete from employees 
where employee_id = 44567;

--5a
CREATE TABLE emp_test_aae ( employee_id NUMBER(5) PRIMARY KEY,
                            last_name VARCHAR2(30) NOT NULL,
                            first_name VARCHAR2(30) NOT NULL,
                            department_id NUMBER(4) NOT NULL,
                            FOREIGN KEY (department_id) REFERENCES dept_test_aae (department_id));

CREATE TABLE dept_test_aae ( department_id NUMBER(5) PRIMARY KEY,
                            department_name VARCHAR2(30) NOT NULL);
                            
--b
CREATE OR REPLACE TRIGGER ex5b
    AFTER DELETE ON dept_test_aae
    FOR EACH ROW
BEGIN
    DELETE FROM emp_test_aae
    WHERE department_id = :OLD.department_id;
END;
/

CREATE OR REPLACE TRIGGER ex5b2
    AFTER UPDATE ON dept_test_aae
    FOR EACH ROW
BEGIN
    UPDATE emp_test_aae
    SET department_id = :NEW.department_id
    WHERE department_id = :OLD.department_id;
END;
/

--linia 1 -> pt cand cheia nu este definita
CREATE OR REPLACE TRIGGER linia1
AFTER DELETE ON departments
FOR EACH ROW
BEGIN
  DELETE FROM emp_test_aae
  WHERE department_id IN (SELECT department_id FROM dept_test_aae WHERE department_id = :OLD.department_id);
END;
/

--linia2
CREATE OR REPLACE TRIGGER linia2
    AFTER UPDATE ON dept_test_aae
    FOR EACH ROW
BEGIN
    UPDATE emp_test_aae
    SET department_id = :NEW.department_id
    WHERE department_id IN (SELECT department_id FROM dept_test_aae WHERE department_id = :OLD.department_id);
END;
/
--liniile 3,4 sunt asemanatoare cu linia2

--6a
--am inlocuit datele din cerinta cu tipurile specifice, deoarece altfel nu puteam crea 
--tabelul
CREATE TABLE error_ex6_aae (user_id SYS.LOGIN_USER%TYPE,
                            nume_bd VARCHAR2(50),
                            erori VARCHAR2(4000),
                            data DATE);
                            drop table error_ex6_aae;
                            
--6b
CREATE OR REPLACE TRIGGER log_errors
AFTER SERVERERROR
ON DATABASE
DECLARE
  v_eroare VARCHAR2(4000);
  v_user VARCHAR2(30);
  v_database_name VARCHAR2(50);
  v_date DATE;
BEGIN
    v_user := SYS.LOGIN_USER;
    v_database_name := SYS.DATABASE_NAME;
    v_date := SYSDATE;
  v_eroare := DBMS_UTILITY.format_error_stack;
  INSERT INTO error_ex6_aae (user_id, nume_bd, erori, data)
  VALUES (v_user, v_database_name, v_eroare, v_date);
END;
/