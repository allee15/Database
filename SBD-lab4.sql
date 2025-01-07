-- Laboratorul 4 PL/SQL
-- Aldea Alexia, grupa 406 

--4.
declare
   cursor salariati_cursor is
   select first_name,
          last_name,
          salary
     from employees
    where salary < 7000;

   v_nume    employees.last_name%type;
   v_prenume employees.first_name%type;
   v_salariu employees.salary%type;
begin
   open salariati_cursor;
   loop
      fetch salariati_cursor into
         v_nume,
         v_prenume,
         v_salariu;
      exit when salariati_cursor%notfound;
      dbms_output.put_line('Salariatul '
                           || v_prenume
                           || ' '
                           || v_nume
                           || ' câștigă '
                           || v_salariu
                           || '$');
   end loop;

   close salariati_cursor;
end;
/

-- Laboratorul 4 PL/SQL
-- Aldea Alexia, grupa 406 

-- adaptare ex 14: Sa se afiseze folosind expresie cursor, apoi cu 2 cursoare (unul dependent de 
--celalalt) pentru fiecare job angajatii care lucreaza pe acel job. Tratati cazurile in care pe un job
-- nu lucreaza nimeni si cazul in care un angajat nu are job.
   SET SERVEROUTPUT ON;

--varianta 1: expresie cursor
begin
   for c_job_emp in (
      select j.job_id,
             j.job_title,
             e.first_name,
             e.last_name
        from jobs j
        left join employees e
      on j.job_id = e.job_id
      union
      select null,
             null,
             e.first_name,
             e.last_name
        from employees e
       where e.job_id is null
   ) loop
      if c_job_emp.job_id is null then
         dbms_output.put_line('Angajat fără job: '
                              || c_job_emp.first_name
                              || ' '
                              || c_job_emp.last_name);
      else
         dbms_output.put_line('Job: '
                              || c_job_emp.job_title
                              || ' ('
                              || c_job_emp.job_id
                              || ')');
         if c_job_emp.first_name is not null then
            dbms_output.put_line(chr(9)
                                 || 'Angajat: '
                                 || c_job_emp.first_name
                                 || ' '
                                 || c_job_emp.last_name);
         else
            dbms_output.put_line(chr(9)
                                 || 'Niciun angajat nu lucrează pe acest job.');
         end if;
      end if;
   end loop;
end;
/

--varianta 2
declare
    -- Cursor principal pentru job-uri
   cursor job_cursor is
   select job_id,
          job_title
     from jobs;

    -- Cursor dependent pentru angajați
   cursor employee_cursor (
      p_job_id jobs.job_id%type
   ) is
   select first_name,
          last_name
     from employees
    where job_id = p_job_id;

   v_job_id     jobs.job_id%type;
   v_job_title  jobs.job_title%type;
   v_first_name employees.first_name%type;
   v_last_name  employees.last_name%type;
   no_employees boolean;
begin
   open job_cursor;
   loop
      fetch job_cursor into
         v_job_id,
         v_job_title;
      exit when job_cursor%notfound;
      dbms_output.put_line('Job: '
                           || v_job_title
                           || ' ('
                           || v_job_id
                           || ')');

      no_employees := true;
      open employee_cursor(v_job_id);
      loop
         fetch employee_cursor into
            v_first_name,
            v_last_name;
         exit when employee_cursor%notfound;
         dbms_output.put_line(chr(9)
                              || 'Angajat: '
                              || v_first_name
                              || ' '
                              || v_last_name);
         no_employees := false;
      end loop;
      close employee_cursor;
      if no_employees then
         dbms_output.put_line(chr(9)
                              || 'Niciun angajat nu lucrează pe acest job.');
      end if;
   end loop;
   close job_cursor;
   dbms_output.put_line(chr(10)
                        || 'Angajați fără job asignat:');
   for c_no_job in (
      select first_name,
             last_name
        from employees
       where job_id is null
   ) loop
      dbms_output.put_line(chr(9)
                           || 'Angajat: '
                           || c_no_job.first_name
                           || ' '
                           || c_no_job.last_name);
   end loop;
end;
/