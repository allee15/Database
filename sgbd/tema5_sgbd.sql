-- 1
-- a
DECLARE 
    CURSOR cursorr (job jobs.job_id%TYPE) IS 
        SELECT e.last_name, e.first_name, e.salary
        FROM employees e, jobs j
        WHERE j.job_id = e.job_id and j.job_id = job; 
    nr_jobs NUMBER;
    titlu_job jobs.job_title%TYPE;
    nume employees.first_name%TYPE;
    prenume employees.last_name%TYPE;
    salariu employees.salary%TYPE;
    TYPE id_job IS TABLE OF jobs.job_id%TYPE;
    joburi id_job := id_job();
    contor NUMBER(5);
BEGIN
    select count(*) into nr_jobs from jobs;
    joburi.EXTEND(nr_jobs);
    select j.job_id bulk collect into joburi from jobs j; 
    FOR i IN joburi.FIRST..joburi.LAST LOOP   
        SELECT job_title
        INTO titlu_job
        FROM jobs j
        WHERE j.job_id = joburi(i);
        DBMS_OUTPUT.put_line(titlu_job);
        contor := 0;
        OPEN cursorr(joburi(i));
        LOOP
            FETCH cursorr INTO nume, prenume, salariu;
            EXIT WHEN cursorr%NOTFOUND;
            DBMS_OUTPUT.put_line(nume || ' ' || prenume || ' ' || salariu);
            contor := contor + 1;
        END LOOP;
        CLOSE cursorr;
        IF contor = 0 THEN 
            DBMS_OUTPUT.put_line('Nu exista niciun angajat.');
        END IF;
        DBMS_OUTPUT.new_line();
    END LOOP;
END;
/
    
-- b
DECLARE 
    TYPE id_job IS TABLE OF jobs.job_id%TYPE;
    CURSOR cursorr (job jobs.job_id%TYPE)IS 
        SELECT e.last_name l_name, e.first_name f_name, e.salary salary
        FROM employees e, jobs j
        WHERE j.job_id = e.job_id and j.job_id = job;
    nr_jobs NUMBER;
    titlu_job jobs.job_title%TYPE;
    nume employees.first_name%TYPE;
    prenume employees.last_name%TYPE;
    salariu employees.salary%TYPE;
    joburi id_job := id_job();
    contor NUMBER(5);
BEGIN
    select count(*) 
    into nr_jobs 
    from jobs;
    joburi.EXTEND(nr_jobs);
    SELECT j.job_id BULK COLLECT INTO joburi FROM jobs j;
    FOR i IN joburi.FIRST..joburi.LAST LOOP   
        SELECT job_title
        INTO titlu_job
        FROM jobs j
        WHERE j.job_id = joburi(i);
        DBMS_OUTPUT.put_line(titlu_job);
        contor := 0;
        
        FOR j IN cursorr(joburi(i)) LOOP
            EXIT WHEN cursorr%NOTFOUND;
            contor := contor + 1;
            DBMS_OUTPUT.put_line(j.f_name || ' ' || j.l_name || ' ' || j.salary);
            
        END LOOP;
        IF contor = 0 THEN 
            DBMS_OUTPUT.put_line('Nu exista niciun angajat.');
        END IF;
        DBMS_OUTPUT.new_line();
    END LOOP;
END;
/
    
-- c 
DECLARE 
    TYPE id_job IS TABLE OF jobs.job_id%TYPE;
    CURSOR cursorr (job jobs.job_id%TYPE)IS 
        SELECT e.last_name l_name, e.first_name f_name, e.salary salary
        FROM employees e, jobs j
        WHERE j.job_id = e.job_id and j.job_id = job;
    nr_jobs NUMBER;
    titlu_job jobs.job_title%TYPE;
    nume employees.first_name%TYPE;
    prenume employees.last_name%TYPE;
    salariu employees.salary%TYPE;
    joburi id_job := id_job();
    contor NUMBER(5);
BEGIN
    select count(*) into nr_jobs from jobs;
    joburi.EXTEND(nr_jobs);
    select j.job_id bulk collect into joburi from jobs j;
    
    FOR i IN joburi.FIRST..joburi.LAST LOOP   
    
        SELECT job_title
        INTO titlu_job
        FROM jobs j
        WHERE j.job_id = joburi(i);
        DBMS_OUTPUT.put_line(titlu_job);
        contor := 0;
        
        FOR j IN (SELECT e.last_name l_name, e.first_name f_name, e.salary salary
                  FROM employees e, jobs j
                  WHERE j.job_id = e.job_id and j.job_id = joburi(i)) 
        LOOP
            DBMS_OUTPUT.put_line(j.f_name || ' ' || j.l_name || ' ' || j.salary);
            contor := contor + 1;
        END LOOP;
        IF contor = 0 THEN 
            DBMS_OUTPUT.put_line('Nu exista angajati.');
        END IF;
        DBMS_OUTPUT.new_line();
    END LOOP;
END;
/


-- d
DECLARE 
    TYPE cursorref IS REF CURSOR;
    CURSOR cursorr IS 
        SELECT j2.job_title, CURSOR
            (SELECT e.last_name, e.first_name, e.salary
            FROM employees e, jobs j
            WHERE j.job_id = e.job_id and j.job_id = j2.job_id)
        FROM jobs j2;
    titlu_job jobs.job_title%TYPE;
    nume employees.first_name%TYPE;
    prenume employees.last_name%TYPE;
    salariu employees.salary%TYPE;
    referinta_cursor cursorref;
    contor NUMBER(5);
BEGIN
    OPEN cursorr;
    LOOP
        FETCH cursorr INTO titlu_job, referinta_cursor;
        EXIT WHEN cursorr%NOTFOUND;
        DBMS_OUTPUT.put_line(titlu_job);
        LOOP 
            FETCH referinta_cursor INTO nume, prenume, salariu;
            EXIT WHEN referinta_cursor%NOTFOUND;
            DBMS_OUTPUT.put_line(nume || ' ' || prenume || ' ' || salariu);
        END LOOP;
        DBMS_OUTPUT.new_line();
    END LOOP;
    
END;
/


--2
DECLARE 
    TYPE job IS TABLE OF jobs.job_id%TYPE;
    CURSOR cursorr (job jobs.job_id%TYPE)IS 
        SELECT e.last_name, e.first_name, e.salary
        FROM employees e, jobs j
        WHERE j.job_id = e.job_id and j.job_id = job;
    nr_jobs NUMBER;
    titlu_job jobs.job_title%TYPE;
    nume employees.first_name%TYPE;
    prenume employees.last_name%TYPE;
    salariu employees.salary%TYPE;
    joburi job := job();
    nr_angajati NUMBER(5);
    contor NUMBER(5);
    stotaljob NUMBER(8,2);
    smediujob NUMBER(8,2);
    stotal NUMBER(10,2) := 0;
    smediu NUMBER(10,2) := 0;
    contort NUMBER(5) := 0;
BEGIN
    select count(*) into nr_jobs from jobs;
    joburi.EXTEND(nr_jobs);
    select j.job_id bulk collect into joburi from jobs j;
    
    FOR i IN joburi.FIRST..joburi.LAST LOOP   
    
        SELECT job_title
        INTO titlu_job
        FROM jobs j
        WHERE j.job_id = joburi(i);     
        contor := 0;
        stotaljob := 0;
        SELECT count(*)
        INTO nr_angajati
        FROM employees e, jobs j
        WHERE e.job_id = j.job_id and j.job_id = joburi(i);
        
        IF nr_angajati = 0 THEN
            DBMS_OUTPUT.put_line('Nu exista angajati pe postul de: ' || titlu_job);
        ELSIF nr_angajati = 1 THEN
            DBMS_OUTPUT.put_line('Singurul angajat care lucreaza ca: ' || titlu_job);
        ELSIF nr_angajati < 20 THEN
            DBMS_OUTPUT.put_line(nr_angajati || ' angajati lucreaza ca ' || titlu_job);
        ELSE
            DBMS_OUTPUT.put_line(nr_angajati || ' angajati lucreaza ca ' || titlu_job);
        END IF;
        
        OPEN cursorr(joburi(i));
        LOOP
            FETCH cursorr INTO nume, prenume, salariu;
            EXIT WHEN cursorr%NOTFOUND;
            contor := contor + 1;
            DBMS_OUTPUT.put_line(contor + 1 || ' ' || nume || ' ' || prenume || ' ' || salariu);
            stotaljob:= stotaljob + salariu;
            contort := contort + 1;
        END LOOP;
        CLOSE cursorr;
        
        stotal := stotal + stotaljob;
        IF contor = 0 THEN 
            DBMS_OUTPUT.put_line('Nu avem angajati.');
        ELSE
            smediujob := stotaljob / contor;
            DBMS_OUTPUT.put_line('Salariul total: ' || stotaljob || '.Salariul mediu: ' || smediujob);
        END IF;
        DBMS_OUTPUT.new_line();
    END LOOP;
    smediu := stotal / contort;
    DBMS_OUTPUT.put_line('Salariul total: ' || stotal || ' .Salariul mediu: ' || smediu);
END;
/
    
    
--3
DECLARE 
    TYPE job IS TABLE OF jobs.job_id%TYPE;
    CURSOR cursorr (job_curent jobs.job_id%TYPE)IS 
        SELECT e.last_name, e.first_name, e.salary, e.commission_pct
        FROM employees e, jobs j
        WHERE j.job_id = e.job_id and j.job_id = job_curent;
    nr_jobs NUMBER;
    titlu_job jobs.job_title%TYPE;
    nume employees.first_name%TYPE;
    prenume employees.last_name%TYPE;
    salariu employees.salary%TYPE;
    joburi job := job();
    nr_ang NUMBER(5);
    contor NUMBER(5);
    stotaljob NUMBER(8,2);
    smediujob NUMBER(8,2);
    stotal NUMBER(10,2) := 0;
    smediu NUMBER(10,2) := 0;
    contort NUMBER(5) := 0;
    comision NUMBER(5) := 0;
    totalcomision NUMBER(10,2) := 0;
BEGIN
    select count(*) into nr_jobs from jobs;
    joburi.EXTEND(nr_jobs);
    select j.job_id bulk collect into joburi from jobs j;
    
    FOR i IN joburi.FIRST..joburi.LAST LOOP   
        SELECT job_title
        INTO titlu_job
        FROM jobs j
        WHERE j.job_id = joburi(i);      
        stotaljob := 0;
        contor := 0;
        SELECT count(*)
        INTO nr_ang
        FROM employees e, jobs j
        WHERE e.job_id = j.job_id and j.job_id = joburi(i); 
        SELECT SUM(salary) + SUM(salary*commission_pct)
        INTO totalcomision
        FROM EMPLOYEES;
        
        IF nr_ang = 0 THEN
            DBMS_OUTPUT.put_line('Nu exista angajati pe postul ' || titlu_job);
        ELSIF nr_ang = 1 THEN
            DBMS_OUTPUT.put_line('Singurul angajat care lucreaza ca ' || titlu_job);
        ELSIF nr_ang < 20 THEN
            DBMS_OUTPUT.put_line(nr_ang || ' angajati lucreaza ca ' || titlu_job);
        ELSE
            DBMS_OUTPUT.put_line(nr_ang || ' angajati lucreaza ca ' || titlu_job);
        END IF;
        
        OPEN cursorr(joburi(i));
        LOOP
            FETCH cursorr INTO nume, prenume, salariu, comision;
            EXIT WHEN cursorr%NOTFOUND;
            DBMS_OUTPUT.put_line(contor + 1 || ' ' || nume|| ' ' || prenume || ' ' || salariu || ' ' || TO_CHAR(((salariu + (salariu * nvl(comision, 0))) * 100 / totalcomision), '0.00'));
            contor := contor + 1;
            stotaljob := stotaljob + salariu;
            contort := contort + 1;
        END LOOP;
        CLOSE cursorr;
        stotal := stotal + stotaljob;
        IF contor = 0 THEN 
            DBMS_OUTPUT.put_line('Nu avem angajati.');
        ELSE
            smediujob := stotaljob / contor;
            DBMS_OUTPUT.put_line('Salariul total: '  || stotaljob || '. Salariul mediu: ' || smediujob);
        END IF;
        DBMS_OUTPUT.new_line();
    END LOOP;
    smediu := stotal / contort;
    DBMS_OUTPUT.put_line('Salariul total al angajatilor: ' || stotal || ' .Salariul mediu al angajatilor: ' || smediu);
END;
/
    

--4
DECLARE 
    TYPE job IS TABLE OF jobs.job_id%TYPE;
    CURSOR cursorr (job_curent jobs.job_id%TYPE)IS 
        SELECT e.last_name, e.first_name, e.salary, e.commission_pct
        FROM employees e, jobs j
        WHERE j.job_id = e.job_id and j.job_id = job_curent
        ORDER BY e.salary DESC; 
    nr_jobs NUMBER;
    titlu_job jobs.job_title%TYPE;
    nume employees.first_name%TYPE;
    prenume employees.last_name%TYPE;
    salariu employees.salary%TYPE;
    joburi job := job();
    nr_ang NUMBER(5);
    contor NUMBER(5);
    stotaljob NUMBER(8,2);
    smediujob NUMBER(8,2);
    stotal NUMBER(10,2) := 0;
    smediu NUMBER(10,2) := 0;
    contort NUMBER(5) := 0;
    comision NUMBER(5) := 0;
    totalcomision NUMBER(10,2) := 0;
BEGIN  
    SELECT COUNT(*) 
    INTO nr_jobs 
    FROM jobs;
    joburi.EXTEND(nr_jobs);
    SELECT j.job_id BULK COLLECT INTO joburi 
    FROM jobs j;
    
    FOR i IN joburi.FIRST..joburi.LAST LOOP   
        contor := 0;
        SELECT job_title
        INTO titlu_job
        FROM jobs j
        WHERE j.job_id = joburi(i); 
        SELECT COUNT(*)
        INTO nr_ang
        FROM employees e, jobs j
        WHERE e.job_id = j.job_id and j.job_id = joburi(i);

        IF nr_ang < 5 THEN
            DBMS_OUTPUT.put_line('mai putin de 5 angajati:  ' || titlu_job);
        ELSE
            DBMS_OUTPUT.put_line(titlu_job);
        END IF;
        
        OPEN cursorr(joburi(i));
        LOOP
            FETCH cursorr INTO nume, prenume, salariu, comision;
            EXIT WHEN cursorr%NOTFOUND or cursorr%ROWCOUNT > 5;
            DBMS_OUTPUT.put_line(contor + 1 || ' ' || nume || ' ' || prenume || ' ' || salariu);
            contor := contor + 1;
        END LOOP;
        CLOSE cursorr; 
        DBMS_OUTPUT.new_line();
    END LOOP;
END;
/


--5
DECLARE 
    TYPE id_job IS TABLE OF jobs.job_id%TYPE;
    CURSOR cursorr (job jobs.job_id%TYPE)IS 
        SELECT e.last_name, e.first_name, e.salary, e.commission_pct
        FROM employees e, jobs j
        WHERE j.job_id = e.job_id and j.job_id = job
        ORDER BY e.salary DESC; 
    nr_jobs NUMBER;
    titlu_job jobs.job_title%TYPE;
    nume employees.first_name%TYPE;
    prenume employees.last_name%TYPE;
    salariu employees.salary%TYPE;
    joburi id_job := id_job();
    nr_ang NUMBER(5);
    contor NUMBER(5);
    stotajob NUMBER(8,2);
    smediujob NUMBER(8,2);
    stotal NUMBER(10,2) := 0;
    smediu NUMBER(10,2) := 0;
    contort NUMBER(5) := 0;
    comision NUMBER(5) := 0;
    totalcomision NUMBER(10,2) := 0;
    sang employees.salary%TYPE;
BEGIN  
    SELECT COUNT(*)
    INTO nr_jobs 
    FROM jobs;
    joburi.EXTEND(nr_jobs);
    SELECT j.job_id BULK COLLECT INTO joburi 
    FROM jobs j;
    
    FOR i IN joburi.FIRST..joburi.LAST LOOP   
        sang := 0;
        contor := 0;
        SELECT job_title
        INTO titlu_job
        FROM jobs j
        WHERE j.job_id = joburi(i); 
        SELECT count(*)
        INTO nr_ang
        FROM employees e, jobs j
        WHERE e.job_id = j.job_id and
            j.job_id = joburi(i);

        IF nr_ang < 5 THEN
            DBMS_OUTPUT.put_line('Exista mai putin de 5 angajati:  ' || titlu_job);
        ELSE
            DBMS_OUTPUT.put_line(titlu_job);
        END IF;
        
        OPEN cursorr(joburi(i));
        LOOP
            FETCH cursorr INTO nume, prenume, salariu,comision;
            EXIT WHEN cursorr%NOTFOUND or cursorr%ROWCOUNT > 5;
            IF sang = 0 or salariu <> sang THEN
                sang := salariu;
                contor := contor + 1;
            END IF;
            DBMS_OUTPUT.put_line(contor || ' ' || nume || ' ' || prenume || ' ' || salariu);
        END LOOP;
        CLOSE cursorr;
        DBMS_OUTPUT.new_line();
    END LOOP;
END;
/
