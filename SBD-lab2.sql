-- LABORATOR 1 PL/SQL

   SET SERVEROUTPUT ON
SET VERIFY OFF

VARIABLE g_mesaj VARCHAR2(100)
DEFINE p_nr = 23
UNDEFINE p_nr

declare
   v_nr    number not null := &&p_nr;
   v_mesaj varchar2(50) := '&p_mesaj';
begin
   :g_mesaj := '2024';
   dbms_output.put_line(v_mesaj
                        || ' '
                        || v_nr
                        || ' octombrie '
                        || :g_mesaj
                        || ' e zi insorita!');
--NULL;
end;
/

PRINT g_mesaj

declare
   v_nume employees.last_name%type;
   v_cod  employees.department_id%type := &p_cod;
begin
   select last_name
     into v_nume
     from employees
    where department_id = v_cod;
   dbms_output.put_line('ang cu codul '
                        || v_cod
                        || ' are numele '
                        || v_nume);
exception
   when no_data_found then
      dbms_output.put_line('NU SUNT ang '
                           || sqlcode
                           || ' '
                           || sqlerrm);
   when too_many_rows then
      dbms_output.put_line('sunt mai multi ang');
end;
/

end;
/


--ex 2
/*v_days_to_go:=v_due_date - SYSDATE; --> DATE
v_sender := USER || ': '||TO_CHAR(v_dept_no); -->  CARACTERE
v_sum := 100.000 + 250.000; --> NUMBER
v_flag :=TRUE; --> BOOLEAN
v_n1 := v_n2 > (2 * v_n3); --> NUMBER
v_value :=NULL; --> BOOLEAN
*/

--ex3
declare
   v_cantitate number(3) := 300;
   v_mesaj     varchar2(255) := 'Produs 1';
   v_locatie   varchar2(50) := 'Europa';
begin
   declare
      v_cantitate number(3) := 1;
      v_mesaj     varchar2(255) := 'Produs 2';
      v_locatie   varchar2(50) := 'Europa';
   begin
      v_cantitate := v_cantitate + 1;
      v_locatie := v_locatie || ' de est';
      dbms_output.put_line('v_cantitate in blocul secundar: ' || v_cantitate);
      dbms_output.put_line('v_locatie in blocul secundar: ' || v_locatie);
   end;
   v_cantitate := v_cantitate + 1;
   v_mesaj := v_mesaj || ' se afla in stoc';
   v_locatie := v_locatie || 'de est';
   dbms_output.put_line('v_cantitate in blocul principal: ' || v_cantitate);
   dbms_output.put_line('v_mesaj in blocul principal: ' || v_mesaj);  -- 'Produs 1 se afla in stoc'
   dbms_output.put_line('v_locatie in blocul principal: ' || v_locatie);  -- 'Europa de est'

end;
/

--ex 4
begin
   dbms_output.put_line('Învăț PL/SQL incepand cu 22 octombrie 2024');
end;
/

declare
   v_mesaj      varchar2(100) := 'Învăț PL/SQL';
   v_continuare varchar2(100) := 'incepand cu';
   v_data       date := sysdate;
begin
   dbms_output.put_line(v_mesaj
                        || ' '
                        || v_continuare
                        || ' '
                        || to_char(
      v_data,
      'DD-MON-YYYY'
   ));
end;
/