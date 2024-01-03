--3
DECLARE
    nr_filme number(5);
    nume member.last_name%TYPE :='&nume';
BEGIN 
    SELECT COUNT(distinct r.title_id)
    INTO nr_filme
    FROM rental r
    JOIN member m on member_id= r.member_id
    WHERE m.last_name = nume;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Membru inexistent');
        WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('Mai multi membri cu acelasi nume');
END;
/

--4
DECLARE
    nr_filme number(5);
    nume member.last_name%TYPE :='&nume';
    total_filme number(5);
BEGIN 
    SELECT COUNT(distinct r.title_id)
    INTO nr_filme
    FROM rental r
    JOIN member m on member_id= r.member_id
    WHERE m.last_name = nume;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Membru inexistent');
        WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('Mai multi membri cu acelasi nume');
        
    SELECT COUNT(title_id)
    INTO total_filme
    FROM title;
    IF nr_filme >= 0.75 * total_filme
        THEN DBMS_OUTPUT.PUT_LINE('Categoria 1');
    ELSIF nr_filme BETWEEN 0.5 * total_filme AND 0.75* total_filme
        THEN DBMS_OUTPUT.PUT_LINE('Categoria 2');
    ELSIF nr_filme BETWEEN 0.25 * total_filme AND 0.5* total_filme
        THEN DBMS_OUTPUT.PUT_LINE('Categoria 3');
    ELSE DBMS_OUTPUT.PUT_LINE('Categoria 4');
    END IF;
END;
/

--5
CREATE TABLE member_aa as SELECT* FROM member;
select*
from member_aa;

ALTER TABLE member_aa
ADD discount NUMBER(6,2);

DECLARE
    nr_filme number(5);
    nume member_aa.last_name%TYPE :=&id;
    total_filme number(5);
BEGIN 
    SELECT COUNT(distinct r.title_id)
    INTO nr_filme
    FROM rental r
    JOIN member_aa m on member_id= r.member_id
    WHERE m.last_name = nume;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Membru inexistent');
        WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('Mai multi membri cu acelasi nume');
        
    SELECT COUNT(title_id)
    INTO total_filme
    FROM title;
    
    UPDATE member_aa
    SET discount = 
        CASE
            WHEN nr_filme >= 0.75 * total_filme THEN  0.1
            WHEN nr_filme BETWEEN 0.5 * total_filme AND 0.75* total_filme THEN 0.05
            WHEN nr_filme BETWEEN 0.25 * total_filme AND 0.5* total_filme THEN 0.03
            ELSE 0
        END
    WHERE member_id = membru;
    
END;
/