--4.Implementa?i ?n Oracle diagrama conceptual? realizat?: defini?i toate tabelele,  
--implement?nd toate constr?ngerile de integritate necesare (chei primare, cheile externe etc).

---------------------------------ADMIN---------------------------
CREATE TABLE ADMIN( id_admin NUMBER(5) CONSTRAINT pk_admin PRIMARY KEY,
                    denumire_site VARCHAR(100) CONSTRAINT denumire_site_admin NOT NULL,
                    nr_utilizatori NUMBER(5) CONSTRAINT nr_utilizatori_admin NOT NULL,
                    nr_tablouri NUMBER(5) CONSTRAINT nr_tablouri_admin NOT NULL,
                    rating NUMBER(5) CONSTRAINT rating_admin NOT NULL);
                    
                   
insert into admin
values(1, 'ProfiArt', 5000, 1243, 8);

insert into admin
values(2,'ArtaInPapuci', 234, 200, 6);

insert into admin
values(3, 'SHL', 2323, 6463, 10);

insert into admin
values(4, 'PicteazaCuNoi', 543, 234,6);

insert into admin
values(5, 'FloriVesele', 5426, 23556,8);

commit;
select *
from admin;
-------------------------------ARTIST------------------------------
CREATE TABLE ARTIST(id_artist NUMBER(5) CONSTRAINT pk_artist PRIMARY KEY,
                        nr_tablouri NUMBER(5) CONSTRAINT nr_tablouri_artist NOT NULL,
                        varsta NUMBER(5) CONSTRAINT varsta_artist NOT NULL,
                        nume VARCHAR(100) CONSTRAINT nume_artist NOT NULL);
                        
insert into artist
values(6, 300,45,'Popescu Valentin');

insert into artist
values(7, 23, 19, 'Mirciulescu Cristina');

insert into artist
values(8, 345, 65, 'Floarea Andrei');

insert into artist
values(9, 543, 63, 'Dumitrescu Florin');

insert into artist
values(10, 36, 25, 'Popa Alexandru');

commit;
select *
from artist;
    
    
-----------------------------CONTRACT------------------------
CREATE TABLE CONTRACT(id_contract NUMBER(5) CONSTRAINT pk_contract PRIMARY KEY,
                        data_semnare DATE CONSTRAINT data_semnare_contract NOT NULL,
                        durata VARCHAR(100) CONSTRAINT durata_contract NOT NULL,
                        id_admin NUMBER(5),
                        CONSTRAINT fk_contr FOREIGN KEY(id_admin) REFERENCES  ADMIN(id_admin),
                        id_artist NUMBER(5),
                        CONSTRAINT fk_cont FOREIGN KEY(id_artist) REFERENCES ARTIST(id_artist)
                        );
                        
insert into contract
values(11, TO_DATE('26-01-2020','dd-mm-yyyy'), '3 ani',1,7);

insert into contract
values(12, TO_DATE('14-01-2020','dd-mm-yyyy'), '5 ani', 2, 6);

insert into contract
values(13, TO_DATE('27-09-2019','dd-mm-yyyy'), '6 ani', 3, 10);

insert into contract
values(14, TO_DATE('12-06-2022', 'dd-mm-yyyy'), '6 luni', 4, 8);

insert into contract
values(15, TO_DATE('15-08-2022', 'dd-mm-yyyy'), '1 an', 5, 9);

insert into contract
values(16, TO_DATE('24-06-2022', 'dd-mm-yyyy'), '10 ani', 3, 7);

insert into contract
values(17, TO_DATE('17-07-2021', 'dd-mm-yyyy'), '4 ani', 1, 6);

insert into contract
values(18, TO_DATE('15-02-2021', 'dd-mm-yyyy'), '2 ani', 5, 8);

insert into contract
values(19, TO_DATE('10-12-2020', 'dd-mm-yyyy'), '2 ani', 4,10);

insert into contract
values(20, TO_DATE('11-10-2022', 'dd-mm-yyyy'), '3 luni', 3, 9);

commit;
select *
from contract;

---------------------------------CLIENT---------------------------
CREATE TABLE CLIENT(id_client NUMBER(5) CONSTRAINT pk_client primary key,
                        nume VARCHAR(100) CONSTRAINT nume_client NOT NULL,
                        telefon VARCHAR(100) CONSTRAINT telefon_client NOT NULL,
                        email VARCHAR(100) CONSTRAINT email_client NOT NULL);
                        
insert into client
values(21, 'Dinculescu Cosmina', '0756234543', 'cosmina123@gmail.com');

insert into client
values(22, 'Georgescu Diana', '0745387163', 'didi@gmail.com');

insert into client
values(23, 'Anghelescu Radu', '0788576209', 'rodede@gmail.com');

insert into client
values(24, 'Pentu Maria', '0746012463', 'mery34@gmai.com');

insert into client
values(25, 'Florescu Marina', '0789076713', 'flory_marinush@gmail.com');

select*
from client;

commit;
                        
----------------------------SPONSOR-----------------------------
CREATE TABLE SPONSOR(id_sponsor NUMBER(5) CONSTRAINT pk_sponsor primary key,
                        nume VARCHAR(100) CONSTRAINT nume_sponsor not null,
                        suma_sponsorizare NUMBER(5) CONSTRAINT suma_spons_sponsor not null);
             
insert into sponsor
values(26, 'TotalSoft', 34000);

insert into sponsor
values(27, 'RedBull', 24000);

insert into sponsor
values(28, 'HatzSRL', 4500);

insert into sponsor
values(29, 'MaryandAlex', 7000);

insert into sponsor
values(30, 'Ikea', 20000);

commit;
select*
from sponsor;
                        
                        
-------------------------TARG/EXPOZITIE--------------------------
CREATE TABLE TARG(id_targ NUMBER(5) CONSTRAINT pk_targ primary key,
                    data_eveniment DATE CONSTRAINT data_ev_targ not null,
                    nr_locuri NUMBER(5) CONSTRAINT nr_loc_targ not null,
                    locatie VARCHAR(100) CONSTRAINT locatie_targ not null,
                    id_admin NUMBER(5),
                    CONSTRAINT fk_tr FOREIGN KEY (id_admin) REFERENCES ADMIN(id_admin),
                    id_sponsor NUMBER(5),
                    CONSTRAINT fk_tg FOREIGN KEY (id_sponsor) REFERENCES SPONSOR(id_sponsor) );
                    
insert into targ
values(31, TO_DATE('01-11-2022', 'dd-mm-yyyy'),400, 'Str Kogalniceanu 9', 1, 27);

insert into targ
values(32, TO_DATE('1-12-2022', 'dd-mm-yyyy'), 2000,'Sala Palatului', 4, 30);

insert into targ
values(33, TO_DATE('02-12-2022', 'dd-mm-yyyy'), 30000, 'Palatul Parlamentului', 2, 26);

insert into targ
values(34, TO_DATE('15-01-2023', 'dd-mm-yyyy'), 2400, 'Sala Palatului', 3, 28);

insert into targ
values(35, TO_DATE('01-02-2023', 'dd-mm-yyyy'), 450, 'Str Kogalniceanu 9', 5, 29);

commit;
select*
from targ;
                    
----------------------TABLOU------------------------
CREATE TABLE TABLOU(id_tablou NUMBER(5) CONSTRAINT pk_tablou primary key,
                        denumire VARCHAR(100) CONSTRAINT denumire_tablou not null,
                        an_creare NUMBER(5) CONSTRAINT an_cr_tablou not null,
                        tip_tablou VARCHAR(100) CONSTRAINT tip_tabl_tablou not null,
                        tip_materiale VARCHAR(100) CONSTRAINT tip_mat_tablou not null,
                        pret NUMBER(5) CONSTRAINT pret_tablou not null,
                        id_admin NUMBER(5),
                        CONSTRAINT fk_ta FOREIGN KEY (id_admin) REFERENCES ADMIN(id_admin),
                        id_artist NUMBER(5),
                        CONSTRAINT fk_tb FOREIGN KEY (id_artist) REFERENCES ARTIST(id_artist),
                        id_targ NUMBER(5),
                        CONSTRAINT fk_tl FOREIGN KEY (id_targ) REFERENCES TARG(id_targ) );
                        
insert into tablou
values(36, 'Iarna', 2021, 'pictura', 'acrilice', 340, 1, 8 ,34);

insert into tablou
values(37, 'Iarna la schi', 2022, 'desen', 'creion', 200, 4, 9, 31);

insert into tablou
values(38, 'Flori de camp', 2020, 'pictura', 'ulei', 500, 2, 6, 35);

insert into tablou
values(39, 'Nuante de gri', 2021, 'desen', 'creion', 250, 3,7, 32);

insert into tablou
values(40, 'Foc de tabara', 2020, 'pictura', 'acrilice', 700, 5,10, 33);

commit;
select*
from tablou;
                        
------------------------------RATING----------------------------
CREATE TABLE RATING(id_rating NUMBER(5) CONSTRAINT pk_rating primary key,
                        data_scrierii DATE CONSTRAINT data_scr_rating not null,
                        nota_acordata NUMBER(5) CONSTRAINT nota_ac_rating not null,
                        detalii VARCHAR(100) CONSTRAINT detalii_rating not null,
                        id_client NUMBER(5),
                        CONSTRAINT fk_ra FOREIGN KEY (id_client) REFERENCES CLIENT(id_client),
                        id_tablou NUMBER(5),
                        CONSTRAINT fk_rt FOREIGN KEY (id_tablou) REFERENCES TABLOU(id_tablou) );
                        
insert into rating
values(41, TO_DATE('01-02-2022','dd-mm-yyyy'), 7, 'foarte frumos', 25, 36);

insert into rating
values(42, TO_DATE('01-10-2022','dd-mm-yyyy'), 10, 'impresionant', 22, 37);

insert into rating
values(43, TO_DATE('13-04-2021','dd-mm-yyyy'), 8, 'o adevarata capodopera', 24, 38);

insert into rating
values(44, TO_DATE('23-05-2022','dd-mm-yyyy'), 5, 'satisfacator', 21, 39);

insert into rating
values(45, TO_DATE('01-12-2021','dd-mm-yyyy'), 10, 'sunt mare fan',23,40);

commit;
select*
from rating;
                        
--------------------------------COMANDA------------------------------------
CREATE TABLE COMANDA(id_comanda NUMBER(5) CONSTRAINT pk_comanda primary key,
                        data_plasare DATE CONSTRAINT data_plas_comanda not null,
                        data_sosire DATE CONSTRAINT data_sos_comanda not null,
                        pret NUMBER(5) CONSTRAINT pret_comanda not null,
                        greutate NUMBER(5) CONSTRAINT greutate_comanda not null,
                        id_client NUMBER(5),
                        CONSTRAINT fk_com FOREIGN KEY (id_client) REFERENCES CLIENT(id_client),
                        id_tablou NUMBER(5),
                        CONSTRAINT fk_co FOREIGN KEY (id_tablou) REFERENCES TABLOU(id_tablou) );
                        
insert into comanda
values(46, TO_DATE('24-08-2022','dd-mm-yyyy'), TO_DATE('01-12-2022', 'dd-mm-yyyy'), 400, 5, 21, 37);

insert into comanda
values(47, TO_DATE('25-10-2022','dd-mm-yyyy'), TO_DATE('05-12-2022','dd-mm-yyyy'), 625, 3, 24, 36);

insert into comanda
values(48, TO_DATE('13-10-2022','dd-mm-yyyy'), TO_DATE('23-11-2022', 'dd-mm-yyyy'), 1000, 7, 22, 40);

insert into comanda
values(49, TO_DATE('25-09-2022','dd-mm-yyyy'), TO_DATE('31-10-2022','dd-mm-yyyy'), 450, 2, 23,38);

insert into comanda
values(50, TO_DATE('17-07-2022','dd-mm-yyyy'), TO_DATE('31-10-2022','dd-mm-yyyy'), 500, 3, 25, 39);

select*
from comanda;
commit;
                        
-----------------------------BILET-----------------------
CREATE TABLE BILET (id_bilet NUMBER(5) CONSTRAINT pk_bilet primary key,
                        pret NUMBER(5) CONSTRAINT pret_bilet not null,
                        data_achizitionare DATE CONSTRAINT data_achiz_bilet not null,
                        id_client NUMBER(5),
                        CONSTRAINT fk_bil FOREIGN KEY (id_client) REFERENCES CLIENT(id_client),
                        id_targ NUMBER(5),
                        CONSTRAINT fk_blt FOREIGN KEY (id_targ) REFERENCES TARG(id_targ) );
                        
insert into bilet
values(51, 50, TO_DATE('31-07-2022','dd-mm-yyyy'), 22, 31);

insert into bilet
values(52, 100, TO_DATE('01-10-2022','dd-mm-yyyy'), 21, 35);

insert into bilet
values(53, 50, TO_DATE('23-06-2022', 'dd-mm-yyyy'), 24,33);

insert into bilet
values(54, 150, TO_DATE('12-10-2022','dd-mm-yyyy'), 22, 34);

insert into bilet
values(55, 65, TO_DATE('31-05-2022','dd-mm-yyyy'), 23, 32);

insert into bilet
values(56, 50, TO_DATE('23-06-2022','dd-mm-yyyy'), 25, 34);

insert into bilet
values(57, 100, TO_DATE('14-07-2022','dd-mm-yyyy'), 23, 31);

insert into bilet
values(58, 55, TO_DATE('15-09-2022', 'dd-mm-yyyy'), 21, 35);

insert into bilet
values(59, 150, TO_DATE('25-09-2022','dd-mm-yyyy'), 25, 33);

insert into bilet
values(60, 50, TO_DATE('03-03-2022','dd-mm-yyyy'), 24, 31);

select*
from bilet;
commit;

--6. Pentru fiecare tablou sa se afiseze data targului la care va fi expus si pretul mediu 
--al tablourilor pt acel targ

CREATE OR REPLACE PROCEDURE proceduraex6 IS
-- vom crea un tip de date de inregistrare pt a pastra data targului si locatia
    TYPE record1 IS RECORD
    (data_ev TARG.data_eveniment%TYPE,
    locatie TARG.locatie%TYPE,
    pret_mediu TABLOU.pret%TYPE);
    
--toate datele despre targuri vor fi retinute intr-un tablou imbricat
    TYPE tabel_imbricat IS TABLE OF record1;
    
--vom folosi un vector pentru a retine datele pentru fiecare targ
    TYPE vector IS VARRAY(8) OF TARG.data_eveniment%TYPE;
    
--cu ajutorul unui cursor vom parcurge toate targurile
    CURSOR c IS
        SELECT id_targ, data_eveniment, locatie
        FROM TARG;

    t tabel_imbricat := tabel_imbricat();
    r record1;
    v vector := vector();
    
BEGIN
    FOR i in c LOOP
    --vom salva datele pentru pretul mediu al tablourilor pt targul respectiv
        SELECT AVG(pret)
        INTO r.pret_mediu
        FROM TABLOU 
        WHERE id_targ = i.id_targ;
        
        v.EXTEND;
        
        SELECT data_eveniment 
        INTO v(v.LAST)
        FROM TARG
        WHERE id_targ=i.id_targ;
        
        r.data_ev := i.data_eveniment;
        r.locatie := i.locatie;
        
        --adaugsm variabila in tabloul imbricat 
        t.EXTEND;
        t(t.LAST) := r;
        
        DBMS_OUTPUT.PUT_LINE('La targul din data ' || t(t.LAST).data_ev || ' din locatia ' || t(t.LAST).locatie || ' pretul mediu al tablourilor este ' || t(t.LAST).pret_mediu);
        
    END LOOP;
    
END proceduraex6;
/

EXECUTE proceduraex6;
/

--7. Sa se mareasca pretul tablourilor care au rating >=8 si artistii lor
--au varsta >=50. 

CREATE OR REPLACE PROCEDURE proceduraex7 IS

    CURSOR tb IS 
        SELECT id_tablou
        FROM TABLOU;
    
    CURSOR p (id_tablou TABLOU.id_tablou%TYPE) IS 
        SELECT * 
        FROM ARTIST a 
        RIGHT JOIN TABLOU t ON t.id_artist= a.id_artist
        LEFT JOIN RATING ra ON t.id_tablou=ra.id_tablou
        WHERE t.id_tablou = 36 and ra.nota_acordata>=4 and a.varsta>=50
        FOR UPDATE OF t.pret NOWAIT;

BEGIN

    FOR r in tb LOOP
        FOR i in p(r.id_tablou) LOOP
            UPDATE TABLOU 
            SET pret = pret + ((pret * 25)/100)
            WHERE CURRENT OF p;
        END LOOP;
    END LOOP;

END proceduraex7;
/
EXECUTE proceduraex7; 
SELECT * FROM TABLOU;



--8. Se citeste numele unui client de la tastatura. Sa se returneze pretul total al comenzii facute de 
--acesta (pretul comenzii + pretul tabloului comandat). In cazul in care un client
--are mai multe comenzi, se va returna suma tuturor preturilor totale. Se vor arunca erori in cazul in
--care: exista mai multi clienti cu numele dat, nu exista un client cu numele dat sau nu exista comenzi
--facute de acest client.
--ne vom folosi de tabelele comanda, tablou si client in aceasta functie
CREATE OR REPLACE FUNCTION functieex8(v_nume CLIENT.nume%TYPE)
RETURN COMANDA.pret%TYPE IS
    pret_total COMANDA.pret%TYPE;
    contor NUMBER;
BEGIN
    --tratam intai exceptiile
    --numaram cati clienti exista cu numele dat in input
    SELECT COUNT (*) INTO contor
    FROM CLIENT WHERE INITCAP(v_nume) = INITCAP(nume);
    
    --tratam cazul in care nu exista niciun client si cazul in care esita mai multi clienti cu acelasi nume
    IF contor =  0
    THEN RAISE_APPLICATION_ERROR(-20000, 'Nu exista un client cu acest nume');
    ELSIF contor>1
    THEN RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi clienti cu acest nume');
    END IF;
    
    --folosim aceeasi variabila pentru a numara cate comenzi exista pentru clientul dat, iar daca nu 
    --exsita niciuna, vom arunca o eroare
    SELECT COUNT(*) INTO contor
    FROM CLIENT RIGHT OUTER JOIN COMANDA USING (id_client)
    WHERE INITCAP(v_nume) = INITCAP(nume);
    
    IF contor = 0
    THEN RAISE_APPLICATION_ERROR(-20002, 'Nu exista comenzi pe acest nume');
    END IF;
    
    --functia de SUM va trata atat cazul in care exista o singura comanda, cat si cazul in care exista
    --mai multe
    SELECT SUM(c.pret+ t.pret)
    INTO pret_total
    FROM COMANDA c JOIN TABLOU t USING(id_tablou) JOIN CLIENT USING (id_client)
    WHERE INITCAP(v_nume) = INITCAP(CLIENT.nume);
    RETURN pret_total;
    
END functieex8;
/

select* 
from client;

SELECT functieex8('Dinculescu Cosmina') FROM DUAL;

SELECT functieex8('Popescu Carmen') FROM DUAL;

--9. Se da numele unui artist ca parametru. Sa se afiseze numele tabloului oferit spre cumparare, 
--ratingul acestuia, idul contractului si numele site-ului unde isi vinde tabloul.
CREATE OR REPLACE PROCEDURE proceduraex9 (nume_artist ARTIST.nume%TYPE) IS 
--vom declara variabilele in care vom salva datele care trebuiesc selectate si afisate
    nume_tablou TABLOU.denumire%TYPE;
    rating_tablou RATING.nota_acordata%TYPE;
    id_contr CONTRACT.id_contract%TYPE;
    nume_site ADMIN.denumire_site%TYPE;
    
BEGIN
--vom folosi join pentru a accesa si selecta ce ne intereseaza
    SELECT t.denumire, r.nota_acordata, c.id_contract, a.denumire_site
    INTO nume_tablou, rating_tablou, id_contr, nume_site
    FROM ARTIST ar RIGHT JOIN TABLOU t ON (ar.id_artist = t.id_artist)
    JOIN RATING r ON (t.id_tablou = r.id_tablou) JOIN CONTRACT c ON (ar.id_artist = c.id_artist)
    JOIN ADMIN a ON (c.id_admin= a.id_admin)
    WHERE INITCAP(nume_artist) = INITCAP(ar.nume)
    GROUP BY  t.denumire, r.nota_acordata, c.id_contract, a.denumire_site;

--afisam in consola datele selectate mai sus
    DBMS_OUTPUT.PUT_LINE('Numele artistului este: ' || INITCAP(nume_artist));
    DBMS_OUTPUT.PUT_LINE('Denumirea tabloului oferit spre vanzare este: ' || nume_tablou);
    DBMS_OUTPUT.PUT_LINE('Ratingul acestui tablou este: ' || rating_tablou);
    DBMS_OUTPUT.PUT_LINE('Numarul contractului este: ' || id_contr);
    DBMS_OUTPUT.PUT_LINE('Denumirea site-ului unde este publicat tabloul este: ' || nume_site);
    
EXCEPTION
    
    WHEN TOO_MANY_ROWS
    THEN RAISE_APPLICATION_ERROR(-20003, 'Exista mai multi artisti cu acest nume');
    WHEN NO_DATA_FOUND
    THEN RAISE_APPLICATION_ERROR(-20004, 'Nu exista artisti cu acest nume');
    
END proceduraex9;
/

select* from artist; 
EXECUTE proceduraex9('Popescu Valentin');
EXECUTE proceduraex9('Aldea Alexia');

--10. Trigger care interzice stergerea datelor din tabelul targ
/
CREATE OR REPLACE TRIGGER triggerex10
    BEFORE DELETE ON TARG
BEGIN
    RAISE_APPLICATION_ERROR(-20005, 'Nu se pot sterge date din tabelul TARG');
END;
/

DELETE FROM TARG
WHERE id_targ= 31;

--11. Trigger care interzice cresterea pretului unui bilet cu mai mult de 100 
/
CREATE OR REPLACE TRIGGER triggerex11
    BEFORE UPDATE ON BILET
    FOR EACH ROW
BEGIN
    IF(:NEW.pret - :OLD.pret >100)
    THEN RAISE_APPLICATION_ERROR(-20006, 'Pretul nu poate creste cu mai mult de 100');
    END IF;
END;
/

UPDATE BILET
SET pret = pret+ 101
WHERE id_bilet = 57;

--12. Triger care afiseaza un mesaj de fiecare data cand este rulata o comanda ldd
/
CREATE OR REPLACE TRIGGER triggerex12
    AFTER CREATE OR ALTER OR DROP ON SCHEMA
BEGIN
    DBMS_OUTPUT.PUT_LINE('A fost efectuata o comanda ldd');
END;
/

ALTER TABLE CLIENT
ADD varsta NUMBER(5);

ALTER TABLE CLIENT
DROP COLUMN varsta;


--13. Pachet cu obiectele din proiect
/
CREATE OR REPLACE PACKAGE pachetex13 AS
    FUNCTION functieex8 (v_nume CLIENT.nume%TYPE) RETURN COMANDA.pret%TYPE;
    PROCEDURE proceduraex6;
    PROCEDURE proceduraex7;
    PROCEDURE proceduraex9(nume_artist ARTIST.nume%TYPE);
END pachetex13;
/
CREATE OR REPLACE PACKAGE BODY pachetex13 AS
--pretul total pentru comenzile facute de un client
    FUNCTION functieex8(v_nume CLIENT.nume%TYPE)
    RETURN COMANDA.pret%TYPE IS
        pret_total COMANDA.pret%TYPE;
        contor NUMBER;
    BEGIN
        SELECT COUNT(*) INTO contor
        FROM CLIENT WHERE INITCAP(v_nume) = INITCAP(nume);
        
        IF contor = 0
        THEN RAISE_APPLICATION_ERROR(-20000, 'Nu exista un client cu acest nume');
        ELSIF contor > 1
        THEN RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi clienti cu acest nume');
        END IF;
        
         SELECT COUNT(*) INTO contor
        FROM CLIENT RIGHT OUTER JOIN COMANDA USING (id_client)
        WHERE INITCAP(v_nume) = INITCAP(nume);
    
        IF contor = 0
        THEN RAISE_APPLICATION_ERROR(-20002, 'Nu exista comenzi pe acest nume');
        END IF;
    
        SELECT SUM(c.pret+ t.pret)
        INTO pret_total
        FROM COMANDA c JOIN TABLOU t USING(id_tablou) JOIN CLIENT USING (id_client)
        WHERE INITCAP(v_nume) = INITCAP(CLIENT.nume);
        RETURN pret_total;
    
    END functieex8;
    
    --pretul mediu al unui tablou 
    PROCEDURE proceduraex6 IS
        TYPE record1 IS RECORD
        (data_ev TARG.data_eveniment%TYPE,
        locatie TARG.locatie%TYPE,
        pret_mediu TABLOU.pret%TYPE);
    
        TYPE tabel_imbricat IS TABLE OF record1;
    
        TYPE vector IS VARRAY(8) OF TARG.data_eveniment%TYPE;
    
        CURSOR c IS
            SELECT id_targ, data_eveniment, locatie
            FROM TARG;

        t tabel_imbricat := tabel_imbricat();
        r record1;
        v vector := vector();
    
    BEGIN
        FOR i in c LOOP
            SELECT AVG(pret)
            INTO r.pret_mediu
            FROM TABLOU 
            WHERE id_targ = i.id_targ;
        
            v.EXTEND;
        
            SELECT data_eveniment 
            INTO v(v.LAST)
            FROM TARG
            WHERE id_targ=i.id_targ;
        
            r.data_ev := i.data_eveniment;
            r.locatie := i.locatie;
        
            t.EXTEND;
            t(t.LAST) := r;
        
            DBMS_OUTPUT.PUT_LINE('La targul din data ' || t(t.LAST).data_ev || ' din locatia ' || t(t.LAST).locatie || ' pretul mediu al tablourilor este ' || t(t.LAST).pret_mediu);
        
        END LOOP;
    
    END proceduraex6;
    
    --proceduraex7
    PROCEDURE proceduraex7 IS

        CURSOR tb IS 
            SELECT id_tablou
            FROM TABLOU;
    
        CURSOR p (id_tablou TABLOU.id_tablou%TYPE) IS 
            SELECT * 
            FROM ARTIST a 
            RIGHT JOIN TABLOU t ON t.id_artist= a.id_artist
            LEFT JOIN RATING ra ON t.id_tablou=ra.id_tablou
            WHERE t.id_tablou = 36 and ra.nota_acordata>=4 and a.varsta>=50
            FOR UPDATE OF t.pret NOWAIT;

    BEGIN

        FOR r in tb LOOP
            FOR i in p(r.id_tablou) LOOP
                UPDATE TABLOU 
                SET pret = pret + ((pret * 25)/100)
                WHERE CURRENT OF p;
            END LOOP;
        END LOOP;

    END proceduraex7;

    --date despre un artist dat ca parametru
    PROCEDURE proceduraex9(nume_artist ARTIST.nume%TYPE) IS
        nume_tablou TABLOU.denumire%TYPE;
        rating_tablou RATING.nota_acordata%TYPE;
        id_contr CONTRACT.id_contract%TYPE;
        nume_site ADMIN.denumire_site%TYPE;
    
    BEGIN
        SELECT t.denumire, r.nota_acordata, c.id_contract, a.denumire_site
        INTO nume_tablou, rating_tablou, id_contr, nume_site
        FROM ARTIST ar RIGHT JOIN TABLOU t ON (ar.id_artist = t.id_artist)
        JOIN RATING r ON (t.id_tablou = r.id_tablou) JOIN CONTRACT c ON (ar.id_artist = c.id_artist)
        JOIN ADMIN a ON (c.id_admin= a.id_admin)
        WHERE INITCAP(nume_artist) = INITCAP(ar.nume)
        GROUP BY  t.denumire, r.nota_acordata, c.id_contract, a.denumire_site;

        DBMS_OUTPUT.PUT_LINE('Numele artistului este: ' || INITCAP(nume_artist));
        DBMS_OUTPUT.PUT_LINE('Denumirea tabloului oferit spre vanzare este: ' || nume_tablou);
        DBMS_OUTPUT.PUT_LINE('Ratingul acestui tablou este: ' || rating_tablou);
        DBMS_OUTPUT.PUT_LINE('Numarul contractului este: ' || id_contr);
        DBMS_OUTPUT.PUT_LINE('Denumirea site-ului unde este publicat tabloul este: ' || nume_site);
    
    EXCEPTION
    
        WHEN TOO_MANY_ROWS
        THEN RAISE_APPLICATION_ERROR(-20003, 'Exista mai multi artisti cu acest nume');
        WHEN NO_DATA_FOUND
        THEN RAISE_APPLICATION_ERROR(-20004, 'Nu exista artisti cu acest nume');
    
    END proceduraex9;
    
END pachetex13;
/

SELECT pachetex13.functieex8('Dinculescu Cosmina') FROM DUAL;
EXECUTE pachetex13.proceduraex6;
EXECUTE pachetex13.proceduraex7;
EXECUTE pachetex13.proceduraex9('Aldea Alexia');  
    
    
    
    
    
    
    
    
    
    
    
    
    
    