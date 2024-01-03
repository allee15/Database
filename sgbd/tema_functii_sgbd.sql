--1
CREATE TABLE info_aae (
    id number(10,2) PRIMARY KEY,
    utilizator VARCHAR2(20),
    data DATE,
    comanda VARCHAR(100),
    nr_linii NUMBER(5),
    eroare VARCHAR(100) );
    
--2
CREATE OR REPLACE FUNCTION functieex2_aae(v_nume employees.last_name%TYPE DEFAULT 'Bell')
RETURN NUMBER IS
    v_utilizator info_aae.utilizator%TYPE;
    salariu employees.salary%TYPE;
    v_nr_linii info_aae.nr_linii%TYPE;
    v_eroare VARCHAR(100);
    
BEGIN
    SELECT user
    INTO v_utilizator
    FROM DUAL;
    
    SELECT salary
    INTO salariu
    FROM employees
    WHERE last_name=v_nume;
    
    v_nr_linii:=SQL%ROWCOUNT;
    INSERT INTO info_aae
    VALUES((SELECT NVL(MAX(id), 0) + 1 FROM info_aae), v_utilizator, sysdate, NULL, v_nr_linii, NULL);
 
    RETURN salariu;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            v_nr_linii:=SQL%ROWCOUNT;
            v_eroare:=SQLERRM;
        INSERT INTO info_aae
        VALUES((SELECT NVL(MAX(id), 0) + 1 FROM info_aae), v_utilizator, sysdate, NULL, v_nr_linii, NULL);
        
        RAISE_APPLICATION_ERROR(-20000, v_eroare);
        WHEN TOO_MANY_ROWS THEN 
            v_nr_linii:=SQL%ROWCOUNT;
            v_eroare:=SQLERRM;
        INSERT INTO info_aae
        VALUES((SELECT NVL(MAX(id), 0) + 1 FROM info_aae), v_utilizator, sysdate, NULL, v_nr_linii, NULL);
        
        RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi angajati cu acest nume');
        WHEN OTHERS THEN 
            v_nr_linii:=SQL%ROWCOUNT;
            v_eroare:=SQLERRM;
        INSERT INTO info_aae
        VALUES((SELECT NVL(MAX(id), 0) + 1 FROM info_aae), v_utilizator, sysdate, NULL, v_nr_linii, NULL);
        
        RAISE_APPLICATION_ERROR(-20002, 'Alt tip de eroare!');

END functieex2_aae;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(functieex2_aae('Hunold'));
END;
/

--3
CREATE OR REPLACE FUNCTION functieex3_aae (oras locations.city%TYPE)
RETURN NUMBER IS
    v_utilizator info_aae.utilizator%TYPE;
    v_ans NUMBER(5);
    v_eroare VARCHAR(100);
BEGIN
    SELECT user 
    INTO v_utilizator 
    FROM DUAL;
    
    IF oras IS NULL 
    THEN INSERT INTO info_aae VALUES((SELECT NVL(MAX(id),0)+1 FROM info_aae),v_utilizator,sysdate,NULL,0,'Orasul dat nu exista');
    RETURN 0;
    END IF;
    
    SELECT COUNT(*)
    INTO v_ans
    FROM employees e JOIN departments d ON(e.department_id= d.department_id)
        JOIN locations l ON (l.location_id=d.location_id)
    WHERE (SELECT COUNT(*)
           FROM job_history
           WHERE employee_id=e.employee_id) >=1;
        
    IF v_ans = 0 
    THEN v_eroare:='Nu a fost gasit angajatul';
    END IF;
    
    INSERT INTO info_aae
    VALUES((SELECT NVL(MAX(id),0)+1 FROM info_aae), v_utilizator,sysdate, NULL,0, v_eroare);
    RETURN v_ans;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(functieex3_aae('Roma'));
END;
/

--4.
CREATE OR REPLACE PROCEDURE functieex4_aae(mngr employees.employee_id%TYPE)
IS
    v_utilizator info_aae.utilizator%TYPE;
    v_ans NUMBER;
    v_eroare VARCHAR2(100);
    v_nr_linii NUMBER;
BEGIN
    SELECT user 
    INTO v_utilizator
    FROM DUAL;
    
    UPDATE employees
    SET salary=salary*110/100
    WHERE employee_id=mngr;
    
    v_nr_linii:=SQL%ROWCOUNT;
    
    IF v_nr_linii = 0 
    THEN INSERT INTO info_aae
         VALUES ((SELECT NVL(MAX(id),0)+1 FROM info_aae), v_utilizator,sysdate,NULL,0, 'Nu s-a putut gasi managerul');
         RETURN;
    END IF;
    
    INSERT INTO info_aae
    VALUES ((SELECT NVL(MAX(id),0)+1 FROM info_aae),v_utilizator,sysdate,NULL,0,v_eroare);
END;
/

BEGIN
    FOR i IN (SELECT employee_id FROM employees WHERE manager_id=103) LOOP
        functieex4_aae(i.employee_id);
    END LOOP;
END;
/
    
--5.
CREATE OR REPLACE PROCEDURE functieex5_aae
IS
    v_utilizator info_aae.utilizator%TYPE;
    v_ans NUMBER;
    v_eroare VARCHAR2(100);
    v_nr_linii NUMBER;
    v_zi NUMBER;
BEGIN
    SELECT user
    INTO v_utilizator
    FROM DUAL;
    
    FOR d IN(SELECT* FROM departments) LOOP
        DBMS_OUTPUT.PUT_LINE('Departamentul ' || d.department_name);
        
        SELECT COUNT(*)
        INTO v_nr_linii
        FROM employees
        WHERE department_id= d.department_id;
    
        IF v_nr_linii = 0
        THEN DBMS_OUTPUT.PUT_LINE('Nu exista angajati');
        CONTINUE;
        END IF;
    
        SELECT zi
        INTO v_zi
        FROM(SELECT EXTRACT(DAY FROM hire_date) zi, COUNT(*)
            FROM employees e
            WHERE e.department_id = d.department_id
            GROUP BY EXTRACT (DAY FROM hire_date)
            ORDER BY COUNT(*) DESC)
        WHERE rownum=1;
    
        DBMS_OUTPUT.PUT_LINE('Zi maxima: ' || v_zi);
    
        FOR e IN (SELECT* FROM employees WHERE department_id = d.department_id) LOOP
            DBMS_OUTPUT.PUT_LINE('Nume:' || e.first_name  || ', salariu: ' || e.salary);
        END LOOP;
    END LOOP;
END;
/
    
    