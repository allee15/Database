--1. 
declare
    type salaries is table of NUMBER;
    
    t salaries := salaries();

begin

    for i in 1..5 loop
        t.extend;
        select salary into t(i) from (select salary from (select salary from employees where employees.commission_pct is null order by salary) where rownum <= i order by salary DESC) where rownum = 1;
    end loop;
    
    for i in t.first..t.last loop
        dbms_output.put_line('Salariul vechi: ' || t(i));
        dbms_output.put_line('Salariu nou: ' || t(i)*105/100);
    end loop;
end;

--2.
CREATE or replace TYPE tip_orase_aae IS TABLE OF VARCHAR(200);

CREATE TABLE excursie_aae( cod_excursie NUMBER(4) CONSTRAINT PK_EXCURSIE PRIMARY KEY,
                          denumire VARCHAR(20),
                          orase tip_orase_aae,
                          status VARCHAR(20) CONSTRAINT check_status CHECK(status in ('UNAVAILABLE', 'AVAILABLE'))
                          )
NESTED TABLE orase STORE AS tabel_orase_aae;

SELECT *
FROM excursie_aae;

--a.
INSERT INTO excursie_aae
VALUES(1, 'Turcia', tip_orase_aae('Istanbul', 'Antalya', 'Midiat', 'Bodrum'), 'AVAILABLE');
INSERT INTO excursie_aae
VALUES(2, 'Grecia', tip_orase_aae('Thassos', 'Atena', 'Chania', 'Rodos'), 'AVAILABLE');
INSERT INTO excursie_aae
VALUES(3, 'SUA', tip_orase_aae('New York', 'Los Angeles', 'Las Vegas', 'Miami'), 'UNAVAILABLE');
INSERT INTO excursie_aae
VALUES(4, 'Spania', tip_orase_aae('Madrid', 'Palma', 'Baarcelona', 'Sevilla'), 'UNAVAILABLE');
INSERT INTO excursie_aae
VALUES(5, 'Franta', tip_orase_aae('Paris', 'Marseille', 'Nice', 'Tours'), 'AVAILABLE');

--b1
DECLARE
    id number(4):= &id;
    oras VARCHAR(200) :='&oras';
BEGIN
    INSERT INTO TABLE(SELECT orase FROM excursie_aae WHERE cod_excursie = id) VALUES (oras);
    DBMS_OUTPUT.PUT_LINE('Insert succeeded');
END;
/
ROLLBACK;

--b2
DECLARE
    tabel tip_orase_aae := tip_orase_aae();
    aux tip_orase_aae := tip_orase_aae();
    id NUMBER(4) := &id;
    oras VARCHAR(200):='&oras';
BEGIN
    SELECT orase 
    INTO tabel
    FROM excursie_aae
    WHERE cod_excursie=id;
    
    FOR i in 1..tabel.count LOOP
        aux.extend;
        IF i = 1
            then aux(i) := tabel(i);
        END IF;
        IF i =2
            THEN aux(i) :=oras;
            aux.extend;
            aux(i+1) := tabel(i);
        END IF;
        IF i>2
            THEN aux(i+1):= tabel(i);
        END IF;
    END LOOP;
    
    UPDATE excursie_aae
    SET orase=aux
    WHERE cod_excursie=id;
END;
/
ROLLBACK;

--b3
DECLARE
    tabel tip_orase_aae:= tip_orase_aae();
    id number(4) := &id;
    xo varchar(200) :='&xo';
    yo varchar(200):='&yo';
BEGIN
    SELECT orase
    INTO tabel
    FROM excursie_aae
    WHERE cod_excursie=id;
    
    for i in 1..tabel.count loop
        if tabel(i)= xo
            then tabel(i):=yo;
        else 
            if tabel(i)=yo
                then tabel(i):=xo;
            end if;
        end if;
    end loop;
    
    update excursie_aae
    set orase =tabel
    where cod_excursie=id;
end;
/
rollback;

--b4
DECLARE
    tabel tip_orase_aae:= tip_orase_aae();
    aux tip_orase_aae:=tip_orase_aae();
    id number(4) := &id;
    oras varchar(200) :='&oras';
    ind number(6):=1;
BEGIN
    SELECT orase
    INTO tabel
    FROM excursie_aae
    WHERE cod_excursie=id;
    
    for i in 1..tabel.count loop
        if tabel(i)!=oras
            then aux.extend;
                 aux(ind) :=tabel(i);
                 ind:=ind+1;
        end if;
    end loop;
    
    update excursie_aae
    set orase =aux
    where cod_excursie=id;
end;
/
rollback;

--c
declare
    tabel tip_orase_aae:= tip_orase_aae();
    id number(4):=&id;
    
begin
    select orase
    into tabel 
    from excursie_aae
    where cod_excursie=id;
    DBMS_OUTPUT.PUT_LINE(tabel.count);
    
    for i in 1..tabel.count loop
        DBMS_OUTPUT.PUT_LINE(tabel(i));
    end loop;
end;
/

--d
set serveroutput on;

declare
    tabel tip_orase_aae := tip_orase_aae();
    type tip_coduri is varray(5) of number(6);
    coduri tip_coduri;
    id number(6);
begin
    SELECT cod_excursie bulk collect
    into coduri
    from excursie_aae;
    
    for i in coduri.first..coduri.last loop
        id:=coduri(i);
        select orase
        into tabel
        from excursie_aae
        where cod_excursie=id;
        DBMS_OUTPUT.PUT_LINE('Cod excursie: ' || id );
        for i in 1..tabel.count loop
            DBMS_OUTPUT.PUT_LINE(tabel(i));
        end loop;
    end loop;
end;
/

--e
declare
    tabel tip_orase_aae :=tip_orase_aae();
    type tip_coduri is varray(5) of number(6);
    coduri tip_coduri;
    id number(6);
    minim number(6);
    numar number(6);
begin
    select cod_excursie bulk collect
    into coduri
    from excursie_aae;
    
    id:= coduri(1);
    select orase
    into tabel 
    from excursie_aae
    where cod_excursie=id;
    
    minim:= tabel.count;
    
    for i in 2..coduri.last loop
        id:=coduri(i);
        select orase
        into tabel
        from excursie_aae
        where cod_excursie=id;
        if tabel.count <minim
            then minim:=tabel.count;
        end if;
    end loop;
    
    DBMS_OUTPUT.PUT_LINE(minim);
    
    for i in coduri.first..coduri.last loop
        id:= coduri(i);
        select orase
        into tabel
        from excursie_aae
        where cod_excursie=id;
        if tabel.count = minim
            then update excursie_aae
            set status='UNAVAILABLE'
            where cod_excursie=id;
        end if;
    end loop;
end;
/
rollback;

select*
from excursie_aae;

--3
CREATE or replace TYPE tip_orase_aae IS varray(200) OF VARCHAR(200);

CREATE TABLE excursie_aae( cod_excursie NUMBER(4) CONSTRAINT PK_EXCURSIE PRIMARY KEY,
                          denumire VARCHAR(20),
                          orase tip_orase_aae,
                          status VARCHAR(20) CONSTRAINT check_status CHECK(status in ('UNAVAILABLE', 'AVAILABLE'))
                          )

--a.
INSERT INTO excursie_aae
VALUES(1, 'Turcia', tip_orase_aae('Istanbul', 'Antalya', 'Midiat', 'Bodrum'), 'AVAILABLE');
INSERT INTO excursie_aae
VALUES(2, 'Grecia', tip_orase_aae('Thassos', 'Atena', 'Chania', 'Rodos'), 'AVAILABLE');
INSERT INTO excursie_aae
VALUES(3, 'SUA', tip_orase_aae('New York', 'Los Angeles', 'Las Vegas', 'Miami'), 'UNAVAILABLE');
INSERT INTO excursie_aae
VALUES(4, 'Spania', tip_orase_aae('Madrid', 'Palma', 'Baarcelona', 'Sevilla'), 'UNAVAILABLE');
INSERT INTO excursie_aae
VALUES(5, 'Franta', tip_orase_aae('Paris', 'Marseille', 'Nice', 'Tours'), 'AVAILABLE');

--b1
DECLARE
    id number(4):= &id;
    oras VARCHAR(200) :='&oras';
    tabel tip_orase_aae:=tip_orase_aae();
BEGIN
    select orase
    into tabel
    from excursie_aae
    where cod_excursie=id;
    
    tabel.extend;
    tabel(tabel.count):=oras;
    
    update excursie_aae
    set orase=tabel
    where cod_excursie=id;
END;
/
ROLLBACK;

--b2
DECLARE
    tabel tip_orase_aae := tip_orase_aae();
    aux tip_orase_aae := tip_orase_aae();
    id NUMBER(4) := &id;
    oras VARCHAR(200):='&oras';
BEGIN
    SELECT orase 
    INTO tabel
    FROM excursie_aae
    WHERE cod_excursie=id;
    
    FOR i in 1..tabel.count LOOP
        aux.extend;
        IF i = 1
            then aux(i) := tabel(i);
        END IF;
        IF i =2
            THEN aux(i) :=oras;
            aux.extend;
            aux(i+1) := tabel(i);
        END IF;
        IF i>2
            THEN aux(i+1):= tabel(i);
        END IF;
    END LOOP;
    
    UPDATE excursie_aae
    SET orase=aux
    WHERE cod_excursie=id;
END;
/
ROLLBACK;

--b3
DECLARE
    tabel tip_orase_aae:= tip_orase_aae();
    id number(4) := &id;
    xo varchar(200) :='&xo';
    yo varchar(200):='&yo';
BEGIN
    SELECT orase
    INTO tabel
    FROM excursie_aae
    WHERE cod_excursie=id;
    
    for i in 1..tabel.count loop
        if tabel(i)= xo
            then tabel(i):=yo;
        else 
            if tabel(i)=yo
                then tabel(i):=xo;
            end if;
        end if;
    end loop;
    
    update excursie_aae
    set orase =tabel
    where cod_excursie=id;
end;
/
rollback;

--b4
DECLARE
    tabel tip_orase_aae:= tip_orase_aae();
    aux tip_orase_aae:=tip_orase_aae();
    id number(4) := &id;
    oras varchar(200) :='&oras';
    ind number(6):=1;
BEGIN
    SELECT orase
    INTO tabel
    FROM excursie_aae
    WHERE cod_excursie=id;
    
    for i in 1..tabel.count loop
        if tabel(i)!=oras
            then aux.extend;
                 aux(ind) :=tabel(i);
                 ind:=ind+1;
        end if;
    end loop;
    
    update excursie_aae
    set orase =aux
    where cod_excursie=id;
end;
/
rollback;

--c
set serveroutput on;
declare
    tabel tip_orase_aae:= tip_orase_aae();
    id number(4):=&id;
    
begin
    select orase
    into tabel 
    from excursie_aae
    where cod_excursie=id;
    DBMS_OUTPUT.PUT_LINE(tabel.count);
    
    for i in 1..tabel.count loop
        DBMS_OUTPUT.PUT_LINE(tabel(i));
    end loop;
end;
/

--d
set serveroutput on;

declare
    tabel tip_orase_aae := tip_orase_aae();
    type tip_coduri is varray(5) of number(6);
    coduri tip_coduri;
    id number(6);
begin
    SELECT cod_excursie bulk collect
    into coduri
    from excursie_aae;
    
    for i in coduri.first..coduri.last loop
        id:=coduri(i);
        select orase
        into tabel
        from excursie_aae
        where cod_excursie=id;
        DBMS_OUTPUT.PUT_LINE('Cod excursie: ' || id );
        for i in 1..tabel.count loop
            DBMS_OUTPUT.PUT_LINE(tabel(i));
        end loop;
    end loop;
end;
/

--e
declare
    tabel tip_orase_aae :=tip_orase_aae();
    type tip_coduri is varray(5) of number(6);
    coduri tip_coduri;
    id number(6);
    minim number(6);
    numar number(6);
begin
    select cod_excursie bulk collect
    into coduri
    from excursie_aae;
    
    id:= coduri(1);
    select orase
    into tabel 
    from excursie_aae
    where cod_excursie=id;
    
    minim:= tabel.count;
    
    for i in 2..coduri.last loop
        id:=coduri(i);
        select orase
        into tabel
        from excursie_aae
        where cod_excursie=id;
        if tabel.count <minim
            then minim:=tabel.count;
        end if;
    end loop;
    
    DBMS_OUTPUT.PUT_LINE(minim);
    
    for i in coduri.first..coduri.last loop
        id:= coduri(i);
        select orase
        into tabel
        from excursie_aae
        where cod_excursie=id;
        if tabel.count = minim
            then update excursie_aae
            set status='UNAVAILABLE'
            where cod_excursie=id;
        end if;
    end loop;
end;
/
rollback;

select*
from excursie_aae;    
