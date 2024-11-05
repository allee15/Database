   SET SERVEROUTPUT ON;

declare
   type tab_ind is
      table of number index by pls_integer;
   t  tab_ind;
   type tab_imb is
      table of number;
   t2 tab_imd := tab_imb();
   type vec is
      varray(10) of number;
   t3 vec := vec();
begin
   t(1) := 1;
   dbms_output.put_line(t.count
                        || ' '
                        || t.first
                        || ' '
                        || t.last);

   t2.extend;
   t2(1) := 2;
   dbms_output.put_line(t2.count
                        || ' '
                        || t2.first
                        || ' '
                        || t2.last
                        || ' '
                        || t2(1));

   t3.extend;
   t3(1) := 3;
   dbms_output.put_line(t3.count
                        || ' '
                        || t3.first
                        || ' '
                        || t3.last
                        || ' '
                        || t3(1));
end;
/

declare
   type tab_ind is
      table of employees.employee_id%type index by pls_integer;
   t tab_ind;
begin
   select employee_id
   bulk collect
     into t
     from employees;

   for i in 1..t.count loop
      dbms_output.put_line(t(i));
   end loop;
end;
/

create or replace type tab_imb is
   table of number;
/

create table test (
   a number primary key,
   b tab_imb
)
nested table b store as test_imb_spr;

insert into test values ( 1,
                          tab_imb(2) );

insert into test values ( 2,
                          tab_imb(
                             3,
                             5
                          ) );

insert into test values ( 3,
                          tab_imb(
                             4,
                             7,
                             9
                          ) );

select *
  from test;

select x.a,
       y.*
  from test x,
       table ( x.b ) y;

update table (
   select b
     from test
    where a = 3
) y
   set value ( y ) = 10
 where column_value = 9;