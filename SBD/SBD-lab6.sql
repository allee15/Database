--Laboratorul 6 PL/SQL
--Aldea Alexia grupa 406

--1 2 triggeri, unul comanda si altul linie pe tabelul dept_pnu care sa verifice:
-- **comanda: daca ziua saptamanii nu este l-v sa nu fie permisa modificarea datelor
-- ** linie:  daca noul manager nu este in baza de date, sa nu se permita inserarea in tabel
-- ***optional: sa se verifice daca nr de joburi ale unui angajat in trecut este 2 si, in caz afirmativ,
-- sa nu se permita avansarea pe o alta pozitie

--comanda:
create or replace trigger trigger_comanda before
   insert or update or delete on dept_aa
begin
   if ( to_char(
      sysdate,
      'dy'
   ) in ( 'sat',
          'sun' ) ) then
      raise_application_error(
         -20500,
         'Nu se pot face modificari inafara zilelor de lucru.'
      );
   end if;
end;
/

insert into dept_aa values ( 1,
                             'da',
                             'info',
                             2,
                             3 );

--linie
create or replace trigger trigger_linie before
   insert on dept_aa
   for each row
declare
   v_count number;
begin
   select count(*)
     into v_count
     from dept_aa
    where manager_id = :new.manager_id;

   if v_count = 0 then
      raise_application_error(
         -20002,
         'Managerul nu exista in baza de date.'
      );
   end if;
end;
/

insert into dept_aa values ( 2,
                             'nu',
                             'info',
                             2,
                             100 );

--optional
create or replace trigger trigger_optional before
   insert or update on job_history
   for each row
declare
   v_job_count number;
begin
   select count(*)
     into v_job_count
     from job_history
    where employee_id = :new.employee_id
      and end_date is not null
      and end_date < sysdate;

   if v_job_count >= 2 then
      raise_application_error(
         -20003,
         'Angajatul nu poate avansa, deja a avut 2 joburi anterioare.'
      );
   end if;
end;
/

insert into job_history values ( 101,
                                 to_date('2023-01-01','YYYY-MM-DD'),
                                 to_date('2025-01-01','YYYY-MM-DD'),
                                 'MK_REP',
                                 20 );



create table dept_aa (
   department_id   number(5)
      constraint pk_department primary key,
   department_name varchar(20)
      constraint department_name not null,
   info            varchar(15)
      constraint info not null,
   location_id     number(5)
      constraint location_id not null,
   manager_id      number(5)
      constraint manager_id not null
);

insert into dept_aa values ( 1,
                             'da',
                             'info',
                             2,
                             3 );

select *
  from dept_aa;