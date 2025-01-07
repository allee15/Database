create procedure first_pnu_alexia is
   azi  date := sysdate;
   ieri azi%type;
begin
   dbms_output.put_line('Programare PL/SQL');
   dbms_output.put_line(to_char(
      azi,
      'dd-month-yyyy hh24:mi:ss'
   ));
   ieri := azi - 1;
   dbms_output.put_line(to_char(
      ieri,
      'dd-mon-yyyy'
   ));
end;
/
EXECUTE first_pnu_alexia; --apelare procedura

/*Laborator 5 PL/SQL 3.12.2024
Aldea Alexia, 406, IS
ex 4-7 din Lab4
*/
--4 Să se șteargă procedura precedentă și să se re-creeze, astfel încât să accepte un parametru IN
--de tip VARCHAR2, numit p_nume. Mesajul afișat de procedură va avea forma « <p_nume> învață
--PL/SQL». Invocați procedura cu numele utilizatorului curent furnizat ca parametru.
drop procedure first_pnu_alexia;

create or replace procedure first_pnu_alexia (
   p_nume in varchar2
) is
begin
   dbms_output.put_line(p_nume || ' învață PL/SQL');
end;
/

   SET SERVEROUTPUT ON;

begin
   first_pnu_alexia(user);
end;
/

--5
--a)Creați o copie JOBS_pnu a tabelului JOBS. Implementați constrângerea de cheie primară
--asupra lui JOBS_pnu.
create table jobs_pnu_alexia
   as
      select *
        from jobs;
alter table jobs_pnu_alexia add constraint pk_jobs_pnu_alexia primary key ( job_id );

--b)Creați o procedură ADD_JOB_pnu care inserează un nou job în tabelul JOBS_pnu. Procedura
--va avea 2 parametri IN p_id și p_title corespunzători codului și denumirii noului job.
create or replace procedure add_job_pnu_alexia (
   p_id    in varchar2,
   p_title in varchar2
) is
begin
   insert into jobs_pnu_alexia (
      job_id,
      job_title
   ) values ( p_id,
              p_title );

   dbms_output.put_line('Job cu ID-ul '
                        || p_id
                        || ' și titlul "'
                        || p_title
                        || '" a fost adăugat cu succes.');
end;
/

--c)Testați procedura, invocând-o astfel:
EXECUTE add_job_pnu_alexia('IT_DBA', 'Database Administrator');
select *
  from jobs_pnu_alexia;

EXECUTE add_job_pnu_alexia('ST_MAN', 'Stock Manager');
select *
  from jobs_pnu_alexia;

--6
--a)Creați o procedură stocată numită UPD_JOB_pnu pentru modificarea unui job existent în
--tabelul JOBS_pnu. Procedura va avea ca parametri codul job-ului și noua sa denumire (parametri
--IN). Se va trata cazul în care nu are loc nici o actualizare.
create or replace procedure upd_job_pnu_alexia (
   p_id    in varchar2,
   p_title in varchar2
) is
begin
   update jobs_pnu_alexia
      set
      job_title = p_title
    where job_id = p_id;

   if sql%rowcount = 0 then
      dbms_output.put_line('Nu s-a găsit niciun job cu ID-ul '
                           || p_id
                           || ' pentru a fi actualizat.');
   else
      dbms_output.put_line('Job cu ID-ul '
                           || p_id
                           || ' a fost actualizat cu succes la denumirea "'
                           || p_title
                           || '".');
   end if;
end;
/

--b) Testați procedura, invocând-o astfel:
EXECUTE UPD_JOB_pnu_alexia('IT_DBA', 'Data Administrator');
select *
  from jobs_pnu_alexia
 where upper(job_id) = 'IT_DBA';
EXECUTE UPD_JOB_pnu_alexia('IT_WEB', 'Web master');

--7
--a) Creați o procedură stocată numit DEL_JOB_pnu care șterge un job din tabelul JOBS_pnu.
--Procedura va avea ca parametru (IN) codul job-ului. Includeți o excepție corespunzatoare situației
--în care nici un job nu este șters.
create or replace procedure del_job_pnu_alexia (
   p_id in varchar2
) is
begin
   delete from jobs_pnu_alexia
    where job_id = p_id;

   if sql%rowcount = 0 then
      raise_application_error(
         -20001,
         'Nu s-a găsit niciun job cu ID-ul '
         || p_id
         || ' pentru a fi șters.'
      );
   else
      dbms_output.put_line('Job cu ID-ul '
                           || p_id
                           || ' a fost șters cu succes.');
   end if;
end;
/

--b)Testați procedura, invocând-o astfel:
EXECUTE DEL_JOB_pnu_alexia('IT_DBA');
EXECUTE DEL_JOB_pnu_alexia('IT_WEB');

--optional:
--Implementati 2 functii, prima returneaza o colectie cu codurile angajatilor, 
--a doua un cursor cu codurile angajatilor si apelati.
create or replace type emp_id_table as
   table of varchar2(10);
/

create or replace function functia1 return emp_id_table is
   emp_ids emp_id_table := emp_id_table();
begin
   for rec in (
      select employee_id
        from employees
   ) loop
      emp_ids.extend;
      emp_ids(emp_ids.last) := rec.employee_id;
   end loop;

   return emp_ids;
end;
/

--apelare
declare
   emp_ids emp_id_table;
begin
   emp_ids := functia1;
   for i in 1..emp_ids.count loop
      dbms_output.put_line('Cod angajat: ' || emp_ids(i));
   end loop;
end;
/


create or replace type emp_id_table as
   table of number;
/

create or replace function functia2 return emp_id_table is
   emp_ids emp_id_table := emp_id_table();
begin
   for rec in (
      select employee_id
        from employees
   ) loop
      emp_ids.extend;
      emp_ids(emp_ids.last) := rec.employee_id;
   end loop;

   return emp_ids;
end;
/

--apelare
declare
   emp_ids emp_id_table;
begin
   emp_ids := functia2;
   for i in 1..emp_ids.count loop
      dbms_output.put_line('Cod angajat: ' || emp_ids(i));
   end loop;

end;
/