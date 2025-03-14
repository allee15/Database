SET SERVEROUTPUT ON;

DECLARE
TYPE tab_ind IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
t tab_ind;
TYPE tab_imb is TABLE OF NUMBER;
t2 tab_imd:=Tab_imb();
TYPE vec IS VARRAY(10) OF NUMBER;
t3 vec:=vec();
BEGIN t(1):=1;
DBMS_OUTPUT.PUT_LINE(t.COUNT||' '||t.FIRST||' '||t.LAST);

t2.EXTEND;
t2(1):=2;
DBMS_OUTPUT.PUT_LINE(t2.COUNT||' '||t2.FIRST||' '||t2.LAST||' '||t2(1));

t3.EXTEND;
t3(1):=3;
DBMS_OUTPUT.PUT_LINE(t3.COUNT||' '||t3.FIRST||' '||t3.LAST||' '||t3(1));
END;
/

DECLARE
TYPE tab_ind IS TABLE OF employees.employee_id%TYPE INDEX BY PLS_INTEGER;
t tab_ind;
BEGIN
    SELECT employee_id 
    BULK COLLECT INTO t
    FROM employees;

    FOR i IN 1..t.COUNT LOOP 
        DBMS_OUTPUT.PUT_LINE(t(i));
    END LOOP;
END;
/

CREATE OR REPLACE TYPE tab_imb Is TABLE OF NUMBER;
/

CREATE TABLE test (a NUMBER PRIMARY KEY, b tab_imb)
NESTED TABLE b STORE AS test_imb_spr;

INSERT INTO test VALUES (1,tab_imb(2));

INSERT INTO test VALUES (2, tab_imb(3,5));

INSERT INTO test VALUES (3, tab_imb(4,7,9));

SELECt *
FROM test;

SELECT x.a, y.*
FROM test x, TABLE(x.b) y;

UPDATE TABLE(SELECT b FROM test WHERE a = 3) y 
SET VALUE(y) = 10
WHERE COLUMN_VALUE = 9;


--LABORATOR 3 PL/SQL
--grupa 406, Aldea Alexia
--Sa se salveze intr-o colectie codurile celor 7 angajati cel mai bine platiti, apoi sa se actualize 
--salariul acestora cu 20%. Sa se afiseze valoare veche, resp. noua a salariilor.

CREATE TABLE employees_backup AS
SELECT *
FROM employees;


DECLARE
    TYPE emp_code_table IS TABLE OF employees_backup.employee_id%TYPE;
    TYPE salary_table IS TABLE OF employees_backup.salary%TYPE;

    top_employee_ids emp_code_table;
    old_salaries salary_table;
    new_salaries salary_table;

BEGIN
    SELECT employee_id, salary
    BULK COLLECT INTO top_employee_ids, old_salaries
    FROM employees_backup
    ORDER BY salary DESC
    FETCH FIRST 7 ROWS ONLY;

    new_salaries := salary_table();
    new_salaries.EXTEND(top_employee_ids.COUNT);

    FOR i IN 1 .. top_employee_ids.COUNT LOOP
        new_salaries(i) := old_salaries(i) * 1.2; 
        
        DBMS_OUTPUT.PUT_LINE('Angajat ID: ' || top_employee_ids(i) || ' | Salariu vechi: ' || old_salaries(i) || ' | Salariu nou: ' || new_salaries(i));
    END LOOP;

    FORALL i IN INDICES OF top_employee_ids
        UPDATE employees_backup
        SET salary = new_salaries(i)
        WHERE employee_id = top_employee_ids(i);
END;
/


--ex 15
CREATE OR REPLACE TYPE rec_info_aa
IS OBJECT (cod_ang NUMBER(6),
job VARCHAR2(35));
/

CREATE OR REPLACE TYPE dept_info_aa
IS TABLE OF rec_info_aa;
/

ALTER TABLE dept_aa
ADD (info dept_info_aa)
    NESTED TABLE info STORE AS info_tab;
DESC dept_aa

UPDATE dept_aa
SET info = dept_info_aa()
WHERE department_id = 90;

INSERT INTO TABLE (SELECT info
                    FROM dept_aa
                    WHERE department_id = 90)

VALUES (100, 'MyEmp');

SELECT d.department_id, t.*
FROM dept_aa d, TABLE (d.info) t;

DECLARE
    TYPE tip_tablou_index IS TABLE OF
    departments.department_id%type INDEX BY PLS_INTEGER;
    v_tabindex_deps tip_tablou_index;
    v_tabnest dept_info_aa;
BEGIN
    v_tabnest:=dept_info_aa();
    SELECT department_id
    BULK COLLECT INTO v_tabindex_deps
    FROM dept_pnu;

    FOR i IN v_tabindex_deps.FIRST..v_tabindex_deps.LAST LOOP
        IF v_tabindex_deps.EXISTS(i) THEN
            DBMS_OUTPUT.PUT_LINE('Prelucram departamentul'||v_tabindex_deps(i));

            SELECT rec_info_pnu(e.employee_id,j.job_title)
            BULK COLLECT INTO v_tabnest
            FROM employees e, jobs j
            WHERE e.department_id = v_tabindex_deps(i)
            AND e.job_id = j.job_id;

            UPDATE dept_pnu
            SET info = v_tabnest
            WHERE department_id = v_tabindex_deps(i);
        END IF;
    END LOOP;
END;
/

SELECT d.department_id, t.*
FROM dept_aa d, TABLE (d.info) t;