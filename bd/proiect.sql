--10. Crearea tabelelor în SQL ?i inserarea de date coerente în fiecare dintre acestea (minimum
--5 înregistr?ri în fiecare tabel neasociativ; minimum 10 înregistr?ri în tabelele asociative).

--USERNAME
CREATE TABLE USERNAME (id_USERNAME NUMBER(5) CONSTRAINT PK_USERNAME PRIMARY KEY,
                         nume VARCHAR(100) CONSTRAINT nume_USERNAME NOT NULL,
                         prenume VARCHAR(100) CONSTRAINT prenume_USERNAME NOT NULL,
                         email VARCHAR(100) CONSTRAINT email_USERNAME NOT NULL,
                         telefon VARCHAR(20) CONSTRAINT telefon_USERNAME NOT NULL
                        );
                        
SELECT *
FROM USERNAME;

INSERT INTO USERNAME
VALUES(1,'Dragomirescu','Claudia', 'claudia@gmail.com','+4021–314.28.63');

INSERT INTO USERNAME
VALUES(2,'Ardeleanu','Mircea', 'mircea@gmail.com','+4021-312.49.48');

INSERT INTO USERNAME
VALUES(3,'Baraboi','Adrian', 'adrian@gmail.com','+0421-305.38.10');

INSERT INTO USERNAME
VALUES(4,'Chiuta','Ion', 'ion@yahoo.com','+4021-314.35.89');

INSERT INTO USERNAME
VALUES(5,'Coca','Eugen', 'eugen.coca@gmail.com','+4021–313.43.36');

COMMIT;


--CUSTOMER
CREATE TABLE CUSTOMER(id_CUSTOMER NUMBER(5) CONSTRAINT PK_CUSTOMER PRIMARY KEY,
                         adresa VARCHAR(100) CONSTRAINT adresa_CUSTOMER NOT NULL,
                         USERNAME VARCHAR(100) CONSTRAINT USERNAME_CUSTOMER NOT NULL,
                    id_USERNAME NUMBER(5),
                    CONSTRAINT fk_CUSTOMER FOREIGN KEY(id_USERNAME) REFERENCES USERNAME(id_USERNAME)
                        );
                    
Select *
from CUSTOMER;

INSERT INTO CUSTOMER
VALUES(10,'Bd. M. Kog?lniceanu, nr. 36–46','micky', 1);    

INSERT INTO CUSTOMER
VALUES(11,'Bd. Nicolae B?lcescu Nr. 1','gigi', 2); 

INSERT INTO CUSTOMER
VALUES(12,'Bd. Regina Elisabeta nr. 4-12','coca', 3);

INSERT INTO CUSTOMER
VALUES(13,'Str. Edgar Quinet, nr. 5-7','mumu', 4); 

INSERT INTO CUSTOMER
VALUES(14,'Str. Academiei nr. 14','musca123', 5);  

COMMIT;



--DEALER
CREATE TABLE DEALER(id_DEALER NUMBER(5) CONSTRAINT PK_DEALER PRIMARY KEY,
                         numar_masini NUMBER(5) CONSTRAINT  numar_masini_CUSTOMER NOT NULL,
                         prezentare_brand VARCHAR(100) CONSTRAINT prezentare_brand__DEALER NOT NULL,
                    id_USERNAME NUMBER(5),
                    CONSTRAINT fk_DEALER FOREIGN KEY(id_USERNAME) REFERENCES USERNAME(id_USERNAME)
                        );
                        
Select *
from DEALER;

INSERT INTO DEALER
VALUES(10,4,'DEALER cu o vasta experienta', 1);    

INSERT INTO DEALER
VALUES(11,70,'Pasionat de masini clasice', 2); 

INSERT INTO DEALER
VALUES(12,20,'DEALER nou', 3);

INSERT INTO DEALER
VALUES(13,40,'DEALER popular', 4); 

INSERT INTO DEALER
VALUES(14, 25,'DEALER apreciat la noi pe site', 5);  

COMMIT;

      
--COMANDA_MASINA        
CREATE TABLE COMANDA_MASINA(id_COMANDA_MASINA NUMBER(5) CONSTRAINT PK_COMANDA_MASINA_nn PRIMARY KEY,
                     data DATE CONSTRAINT data_plasarii_nn NOT NULL,
                     pret NUMBER(5) CONSTRAINT pret_COMANDA_MASINA_nn NOT NULL,
                     id_CUSTOMER NUMBER(5),
                    CONSTRAINT fk_CUSTOMER_nn FOREIGN KEY(id_CUSTOMER) REFERENCES CUSTOMER(id_CUSTOMER)
                       
                    );

Select *
from COMANDA_MASINA;

INSERT INTO COMANDA_MASINA
VALUES(20,TO_DATE('12-04-2019','DD-MM-YYYY'),100,10);

INSERT INTO COMANDA_MASINA
VALUES(21,TO_DATE('17-06-2021','DD-MM-YYYY'),500,14);

INSERT INTO COMANDA_MASINA
VALUES(22,TO_DATE('02-08-2020','DD-MM-YYYY'),2345,13);

INSERT INTO COMANDA_MASINA
VALUES(23,TO_DATE('18-05-2022','DD-MM-YYYY'),124,12);

INSERT INTO COMANDA_MASINA
VALUES (24,TO_DATE('14-07-2018','DD-MM-YYYY'),6435,11);

INSERT INTO COMANDA_MASINA
VALUES (25,TO_DATE('14-05-2021','DD-MM-YYYY'),634,10);

COMMIT;

--SUBSCRIPTION

CREATE TABLE SUBSCRIPTION(id_SUBSCRIPTION NUMBER(5) CONSTRAINT PK_SUBSCRIPTION_nn PRIMARY KEY,
                      tip VARCHAR(100) CONSTRAINT tip_SUBSCRIPTION_nn NOT NULL,
                      durata VARCHAR(100) CONSTRAINT durata_SUBSCRIPTION_nn NOT NULL,
                    id_USERNAME NUMBER(5),
                    CONSTRAINT fk_ab_nn FOREIGN KEY(id_USERNAME) REFERENCES USERNAME(id_USERNAME)

                    );
                    
Select *
from SUBSCRIPTION;

INSERT INTO SUBSCRIPTION
VALUES(30,'Anual','5 ani', 1);

INSERT INTO SUBSCRIPTION
VALUES(31,'Lunar','5 luni', 2);

INSERT INTO SUBSCRIPTION
VALUES(32,'Anual','7 ani', 3);

INSERT INTO SUBSCRIPTION
VALUES(33,'Anual','1 an', 4);

INSERT INTO SUBSCRIPTION
VALUES (34,'Lunar','10 luni', 5);

COMMIT;

--INVITATII


CREATE TABLE INVITATII(id_invitatie NUMBER(5) CONSTRAINT PK_invitatii PRIMARY KEY,
                    data DATE CONSTRAINT data_emiterii NOT NULL,
                    nume VARCHAR(100) CONSTRAINT nume_destinatar NOT NULL,
                    id_USERNAMEname NUMBER(5),
                    CONSTRAINT fk_invitatii FOREIGN KEY( id_USERNAMEname) REFERENCES USERNAMEname(id_USERNAMEname)

                    );
                    
select *
from invitatii;

INSERT INTO INVITATII
VALUES(40,TO_DATE('20-05-2022','DD-MM-YYYY'),'Ionel', 3);

INSERT INTO INVITATII
VALUES(41,TO_DATE('18-04-2021','DD-MM-YYYY'),'Mircea', 2);

INSERT INTO INVITATII
VALUES(42,TO_DATE('3-10-2020','DD-MM-YYYY'),'Marcel', 5);

INSERT INTO INVITATII
VALUES(43,TO_DATE('01-01-2019','DD-MM-YYYY'),'Cristea', 4);

INSERT INTO INVITATII
VALUES(44,TO_DATE('25-12-2018','DD-MM-YYYY'), 'Cornel',1);

INSERT INTO INVITATII
VALUES(45,TO_DATE('16-02-2022','DD-MM-YYYY'), 'Ion', 2);

INSERT INTO INVITATII
VALUES(46,TO_DATE('18-06-2021','DD-MM-YYYY'),'Mirela', 1);

INSERT INTO INVITATII
VALUES(47,TO_DATE('2-11-2020','DD-MM-YYYY'),'Mateiu', 2);

INSERT INTO INVITATII
VALUES(48,TO_DATE('14-08-2019','DD-MM-YYYY'),'Manolache', 5);

INSERT INTO INVITATII
VALUES(49,TO_DATE('22-06-2021','DD-MM-YYYY'),'Manea', 5);

COMMIT;
                    
--REVIEW_DEALER

CREATE TABLE REVIEW_DEALER(
                         id_REVIEW_DEALER NUMBER(5) CONSTRAINT PK_REVIEW_DEALER_nn PRIMARY KEY,
                         data DATE CONSTRAINT data_scrierii_nn NOT NULL,
                         nume VARCHAR(100) CONSTRAINT nume_autor_nn NOT NULL,
                         id_CUSTOMER NUMBER(5),
                          CONSTRAINT fk_REVIEW_DEALER FOREIGN KEY( id_CUSTOMER) REFERENCES CUSTOMER(id_CUSTOMER),
                          id_DEALER NUMBER(5),
                          CONSTRAINT fk_REVIEW_DEALER2 FOREIGN KEY( id_DEALER) REFERENCES DEALER(id_DEALER)
                        );                    
                    
Select *
from REVIEW_DEALER;

INSERT INTO REVIEW_DEALER 
VALUES(51,TO_DATE('12-04-2020','dd-mm-yyyy'),'Nimara', 11, 10);

INSERT INTO REVIEW_DEALER 
VALUES(52,TO_DATE('26-01-2021','dd-mm-yyyy'),'Dima',12, 14);

INSERT INTO REVIEW_DEALER 
VALUES(53,TO_DATE('14-01-2022','dd-mm-yyyy'),'Miu',  13, 11);

INSERT INTO REVIEW_DEALER 
VALUES(54,TO_DATE('27-09-2019','dd-mm-yyyy'),'Gherghescu', 14, 10);

INSERT INTO REVIEW_DEALER 
VALUES(55,TO_DATE('15-08-2021','dd-mm-yyyy'),'Pascu',  12, 11);

INSERT INTO REVIEW_DEALER 
VALUES(56,TO_DATE('24-06-2021','dd-mm-yyyy'),'Baciu',,14, 10);

INSERT INTO REVIEW_DEALER 
VALUES(57, TO_DATE('17-07-2020','dd-mm-yyyy'),'Guleama',13, 11);

INSERT INTO REVIEW_DEALER 
VALUES(58,TO_DATE('15-02-2021','dd-mm-yyyy'),'Marton', 14, 12);

INSERT INTO REVIEW_DEALER 
VALUES(59,TO_DATE('10-12-2020','dd-mm-yyyy'),'Vultur', 10, 14);

INSERT INTO REVIEW_DEALER 
VALUES(60,TO_DATE('11-10-2018','dd-mm-yyyy'),'Fritz',  12, 10);

COMMIT;

--REDUCERE

CREATE TABLE REDUCERE(id_reducere NUMBER(5)  CONSTRAINT pk_reducere PRIMARY KEY,
                    procent NUMBER(5)CONSTRAINT procent_reducere NOT NULL,
                    id_USERNAMEname NUMBER(5),
                    CONSTRAINT fk_reducere FOREIGN KEY( id_USERNAMEname) REFERENCES USERNAMEname(id_USERNAMEname),
                    id_invitatie NUMBER(5),
                    CONSTRAINT fk_reducere2 FOREIGN KEY( id_invitatie) REFERENCES INVITATII(id_invitatie)
                    );
                    
select *
from reducere;

INSERT INTO REDUCERE
VALUES(61,  45, 1, 40);

INSERT INTO REDUCERE
VALUES(62,  34,5, 41);

INSERT INTO REDUCERE
VALUES(63,  23,2, 49);

INSERT INTO REDUCERE
VALUES(64,  13, 3,43);

INSERT INTO REDUCERE
VALUES(65,  43, 4,45);

INSERT INTO REDUCERE
VALUES(66,  25,2, 44);

INSERT INTO REDUCERE
VALUES(67,  16,1, 47);

INSERT INTO REDUCERE
VALUES(68, 34, 3, 48);

INSERT INTO REDUCERE
VALUES(69,  56, 5,45);

INSERT INTO REDUCERE
VALUES(70,  68,4, 45);

COMMIT;

--PRODUCATORI FAVORITI


CREATE TABLE PROD_FAV(
                         id_prodfav NUMBER(5) CONSTRAINT PK_prodfav PRIMARY KEY,
                         nume VARCHAR(100) CONSTRAINT nume_producator NOT NULL,
                    id_USERNAME NUMBER(5),
                    CONSTRAINT fk_prodfav FOREIGN KEY( id_USERNAME) REFERENCES USERNAME(id_USERNAME) 
                         
                        ); 
select *
from prod_fav;

INSERT INTO PROD_FAV
VALUES(100,  'Popescu', 1);

INSERT INTO PROD_FAV
VALUES(101,  'Ionescu', 5);

INSERT INTO PROD_FAV
VALUES(102,  'Avram',4);

INSERT INTO PROD_FAV
VALUES(103,  'Branescu', 2);

INSERT INTO PROD_FAV
VALUES(104,  'Enache', 1);

INSERT INTO PROD_FAV
VALUES(105,  'Boboc', 3);

COMMIT;

--COMENZI_MASINA ANTERIOARE

CREATE TABLE COM_ANT_MASINI(id_comant NUMBER(5) CONSTRAINT pk_comant_nn PRIMARY KEY,
                    data DATE CONSTRAINT data_comant_nn NOT NULL,
                    rating NUMBER CONSTRAINT rating_comant_nn NOT NULL,
                    id_USERNAME NUMBER(5),
                    CONSTRAINT fk_comant__NN FOREIGN KEY( id_USERNAME) REFERENCES USERNAME(id_USERNAME) 
                        
                    );
                    
Select *
from COM_ANT_MASINI;

INSERT INTO COM_ANT_MASINI
VALUES(106, TO_DATE('01-08-2018','dd-mm-yyyy'), 10, 5);


INSERT INTO COM_ANT_MASINI
VALUES(107,TO_DATE('01-07-2018','dd-mm-yyyy'), 5, 3);

INSERT INTO COM_ANT_MASINI
VALUES(108, TO_DATE('01-06-2017','dd-mm-yyyy'), 9, 5);

INSERT INTO COM_ANT_MASINI
VALUES(109,TO_DATE('01-06-2017','dd-mm-yyyy'), 8, 4);

INSERT INTO COM_ANT_MASINI
VALUES (110, TO_DATE('01-06-2017','dd-mm-yyyy'), 5, 3);

INSERT INTO COM_ANT_MASINI
VALUES (111,TO_DATE('01-06-2017','dd-mm-yyyy'), 3, 2);

INSERT INTO COM_ANT_MASINI
VALUES (112,TO_DATE('01-06-2019','dd-mm-yyyy'), 4, 1);

--MASINA

CREATE TABLE MASINA(id_masina NUMBER(5) CONSTRAINT PK_masina PRIMARY KEY,
                    denumire VARCHAR(30) CONSTRAINT denumire_masina NOT NULL,
                     pret NUMBER CONSTRAINT pret_masina NOT NULL,
                     motorizare NUMBER CONSTRAINT motorizare_masina NOT NULL,
                    combustibil VARCHAR(50) CONSTRAINT combustibil_masina NOT NULL,
                    informatii_extra VARCHAR(50) CONSTRAINT informatii_extra_masina NOT NULL
                    
                    );

select *
from masina;

INSERT INTO MASINA
VALUES (200,'Volkswagen',5000,2000, 'motorina','Masina noua' );

INSERT INTO MASINA
VALUES (201,'Audi',45000, 1600,'benzina', 'Masina la mana a doua');

INSERT INTO MASINA
VALUES (202,'BMW', 2340,3000, 'motorina', 'Masina in stare impecabila');

INSERT INTO MASINA
VALUES (203,'Mercedes-Benz', 45000,3500, 'motorina', 'Masina ce prezinta mici zgarieturi');

INSERT INTO MASINA
VALUES (204,'Volvo',3500, 3000, 'benzina', 'Masina care se vinde rapid');

INSERT INTO MASINA
VALUES (205,'TOyota',5340, 1600, 'benzina', 'Masina populara');

INSERT INTO MASINA
VALUES (206,'Bentley', 12000, 3000, 'motorina', 'Masina foarte scumpa');

--STATUS COMANDA_MASINA

CREATE TABLE STAT_COM_MASINA(id_statcom NUMBER(5) CONSTRAINT PK_statcom_nn PRIMARY KEY,
                    primire NUMBER(5) CONSTRAINT primire_com_nn NOT NULL,
                    pregatire VARCHAR(50) CONSTRAINT pregatire_com_nn NOT NULL,
                    trimitere VARCHAR(50) CONSTRAINT trimitere_com_nn NOT NULL,
                    data_sosirii DATE CONSTRAINT data_com_nn NOT NULL,
                    id_USERNAME NUMBER(5),
                    CONSTRAINT fk_statcom_nn FOREIGN KEY( id_USERNAME) REFERENCES USERNAME(id_USERNAME), 
                     id_masina NUMBER(5),
                    CONSTRAINT fk_statcom2_nn FOREIGN KEY( id_masina) REFERENCES MASINA(id_masina) 
                           
                    );

select *
from STAT_COM_MASINA;

INSERT INTO STAT_COM_MASINA
VALUES (300, 1,'in curs','in 2 luni',TO_DATE('01-07-2022','dd-mm-yyyy'),5,203);

INSERT INTO STAT_COM_MASINA
VALUES (301,1, 'pe drum', '5 zile',TO_DATE('09-06-2022','dd-mm-yyyy'),4, 202);

INSERT INTO STAT_COM_MASINA
VALUES (302, 0,'procesare', 'nu se stie', TO_DATE('01-07-2023','dd-mm-yyyy'), 3, 206);

INSERT INTO STAT_COM_MASINA
VALUES (303, 1,'in curs','o saptamana', TO_DATE('11-06-2022','dd-mm-yyyy'),1,204);

INSERT INTO STAT_COM_MASINA
VALUES (304,0, 'plata neacceptata','nu se stie',TO_DATE('01-07-2023','dd-mm-yyyy'),5,201);

INSERT INTO STAT_COM_MASINA
VALUES (305, 0,'procesare','nu se stie',TO_DATE('01-07-2023','dd-mm-yyyy'), 3, 205);

INSERT INTO STAT_COM_MASINA
VALUES (306, 1,'pe drum', '1 luna',TO_DATE('04-07-2022','dd-mm-yyyy'),2,206);

INSERT INTO STAT_COM_MASINA
VALUES (307,1,'in curs', '2 saptamani', TO_DATE('21-06-2022','dd-mm-yyyy'),5, 203);

--CUMPARARE/VANZARE
CREATE TABLE CUMP_VIND_MASINA(id_USERNAME NUMBER(5) CONSTRAINT pk_cvu_nn REFERENCES USERNAME(id_USERNAME),
                    id_masina NUMBER(5)CONSTRAINT pk_cvt_nn REFERENCES MASINA(id_masina) ,
                    CONSTRAINT pk_CUMP_VIND_MASINA_nn primary key(id_USERNAME,id_masina)
                    );
select *
from CUMP_VIND_MASINA;


INSERT INTO CUMP_VIND_MASINA
VALUES (1, 202);

INSERT INTO CUMP_VIND_MASINA
VALUES (2,201);

INSERT INTO CUMP_VIND_MASINA
VALUES (4,206);

INSERT INTO CUMP_VIND_MASINA
VALUES (5,200);

INSERT INTO CUMP_VIND_MASINA
VALUES (2,205);

INSERT INTO CUMP_VIND_MASINA
VALUES (3,204);

INSERT INTO CUMP_VIND_MASINA
VALUES (1,205);

INSERT INTO CUMP_VIND_MASINA
VALUES (4,200);

INSERT INTO CUMP_VIND_MASINA
VALUES (3,206);

INSERT INTO CUMP_VIND_MASINA
VALUES (1,203);




--11. Formula?i în limbaj natural ?i implementa?i 5 cereri SQL complexe ce vor utiliza, în 
--ansamblul lor, urm?toarele elemente: 
--opera?ie join pe cel pu?in 4 tabele
--filtrare la nivel de linii
-- subcereri sincronizate în care intervin cel pu?in 3 tabele
-- subcereri nesincronizate în care intervin cel pu?in 3 tabele
-- grup?ri de date, func?ii grup, filtrare la nivel de grupuri
--ordonari
--utilizarea a cel pu?in 2 func?ii pe ?iruri de caractere, 2 func?ii pe date calendaristice, a 
--func?iilor NVL ?i DECODE, a cel pu?in unei expresii CASE
-- utilizarea a cel pu?in 1 bloc de cerere (clauza WITH)

--afisati numele, prenumele si emailul USERNAMEnameilor care sunt DEALERi si care au REVIEW_DEALER-uri postate inainte de
-- data 15-04-2022
SELECT CONCAT(CONCAT(p.nume,' '),p.prenume) AS "USERNAME", p.email AS "Email"
FROM USERNAME p
WHERE p.id_USERNAME in (SELECT id_USERNAME
                            FROM DEALER
                            WHERE id_DEALER IN (SELECT id_REVIEW_DEALER
                                                FROM REVIEW_DEALER
                                                WHERE data <TO_DATE('15-04-2022','dd-mm-yyyy')
                                                )
                            );

--afisati marcile masinilor si preturile acestora care merg pe benzina
SELECT UNIQUE CONCAT(CONCAT('Marca este ', f.denumire), CONCAT(' si costa ',f.pret)) AS "Rezultat"
FROM masina f
WHERE UPPER(f.combustibil) LIKE LOWER('benzina');

--afisati REVIEW_DEALER-urile anterioare datei de 15-04-2022 si care contin litera a in nume
SELECT nume AS "Numele autorului" 
FROM REVIEW_DEALER
WHERE data< TO_DATE('15-04-2022','dd-mm-yyyy') AND nume LIKE '%a%';

--pentru fiecare masina sa se afiseze ce pret are fiecare cu codurile de la 1 pana la 5 
--si pretul total al unei masini 
SELECT id_masina, denumire, SUM(DECODE(id_masina, 1, pret)) Masina1,
                            SUM(DECODE(id_masina, 2, pret)) Masina2,
                            SUM(DECODE(id_masina, 3, pret)) Masina3,
                            SUM(DECODE(id_masina, 4, pret)) Masina4,
                            SUM(DECODE(id_masina, 5, pret)) Masina5,
                            SUM(DECODE(id_masina, 6, pret)) Masina6,
                            SUM(DECODE(id_masina, 7, pret)) Masina7,
                            SUM(pret) as Total
FROM masina
GROUP BY id_masina,denumire;

--afisati denumirea si pretul unei masini care trebuie sa ajunga in urmatoarele 15 luni si daca va veni curand
SELECT s.denumire AS Denumire, s.pret AS Pret, i.data_sosirii AS Data, NVL(to_char(s.id_masina),'nu vine curand') AS Vine
FROM masina s, STAT_COM_MASINA i
WHERE MONTHS_BETWEEN(sysdate,i.data_sosirii)<15
ORDER BY s.denumire;

--afisati pt fiecare masina denumirea, motorizarea, data la care se va livra, ratingul producatorului si pretul
--acestuia sub forma unui mesaj orientativ
SELECT s.denumire, s.motorizare, e.data_sosirii, c.rating,
CASE
    WHEN s.pret >=100 and s.pret<200 THEN 'Pretul este peste 1000 de lei'
    WHEN s.pret >=200 and s.pret<300 THEN 'Pretul este peste 2000 de lei'
    WHEN s.pret >=300 and s.pret<400 THEN 'Pretul este peste 3000 de lei'
    WHEN s.pret >=400 and s.pret<500 THEN 'Pretul este peste 4000 de lei'
    WHEN s.pret >=500 THEN 'Masina scumpa, peste 5000 de lei'
    ELSE 'Ai noroc, e prea stricata si se da gratis'
END AS Preturi
FROM masina s, STAT_COM_MASINA e, COM_ANT_MASINI c
WHERE s.id_masina=e.id_masina AND e.id_USERNAME=c.id_USERNAME
ORDER BY s.denumire, s.motorizare, e.data_sosirii, c.rating;

--afisam pt fiecare masina care are pretul mai mare decat cel average, denumirea sa
WITH prett (denumire,total) AS (SELECT denumire, sum(pret) 
                                FROM masina
                                GROUP BY denumire),
              pretavg (avgp) as (SELECT avg(pret)
                                FROM masina)
    SELECT denumire as "Denumire masina"
    FROM prett , pretavg 
    WHERE prett.total> pretavg.avgp
    ORDER BY denumire;

--sa se afiseze informatiile despre masinile ale caror rating in alte COMANDA_MASINA anterioare depaseste average-ul
--si nr de COMANDA_MASINA anterioare
SELECT *
FROM masina;

SELECT p.denumire, p.motorizare,p.pret, p.combustibil, p.informatii_extra, c.rating, ( select avg(rating)
                                                                                FROM COM_ANT_MASINI
                                                                                Where id_USERNAME=c.id_USERNAME) as "Rating mediu",
                                                                                (select count(*)
                                                                                from COM_ANT_MASINI
                                                                                where f.id_USERNAME= id_USERNAME) as "Numar COMANDA_MASINA"
                                                                                
FROM masina p, COM_ANT_MASINI c, USERNAME f
where f.id_USERNAME=c.id_USERNAME and c.rating> (select avg(rating)
                                                  from COM_ANT_MASINI
                                                  where id_USERNAME=c.id_USERNAME);
                                                                        
--vrem sa afisam pt fiecare USERNAMEname numele, prenumele si data sosirii masinii cumparate
SELECT USERNAME.nume,USERNAME.prenume, masina.denumire,  STAT_COM_MASINA.data_sosirii
FROM masina
INNER JOIN STAT_COM_MASINA ON STAT_COM_MASINA.id_masina= masina.id_masina
INNER JOIN USERNAME ON STAT_COM_MASINA.id_USERNAME=USERNAME.id_USERNAME
INNER JOIN CUMP_VIND_MASINA ON USERNAME.id_USERNAME= CUMP_VIND_MASINA.id_USERNAME
ORDER BY USERNAME.nume, USERNAME.prenume, masina.denumire, STAT_COM_MASINA.data_sosirii;






--12.Implementarea a 3 opera?ii de actualizare sau suprimare a datelor utilizând subcereri.
--1. Sa se mareasca pretul masinilor cu 10% pentru masinile cu motorina si care au motorizarea >2000
UPDATE MASINA
SET pret = pret + 0.1*pret
WHERE combustibil LIKE 'motorina' AND motorizare>2000;

SELECT pret
FROM masina;

--2. Sa se mareasca ratingul USERNAME-ilor al caror nume incepe cu litera C.
UPDATE COM_ANT_MASINI
SET rating= rating+ 1
WHERE id_USERNAME IN (SELECT id_USERNAME
                        FROM USERNAME
                        WHERE nume LIKE 'C%');

--3. Sa se micsoreze procentul de reducere al invitatiilor a caror data e in anul 2019
UPDATE REDUCERE
SET procent= procent- 25
WHERE id_invitatie IN (SELECT id_invitatie
                        FROM invitatii
                        WHERE to_char(data,'yyyy')='2019');






--13. Crearea unei secven?e ce va fi utilizat? în inserarea înregistr?rilor în tabele (punctul 10).
CREATE SEQUENCE SEQ_STATCOMMASINI
INCREMENT by 10
START WITH 300
MAXVALUE 10000
NOCYCLE;

INSERT INTO STAT_COM_MASINA
VALUES (SEQ_STATCOMMASINI.NEXTVAL, 1,'in curs','in 2 luni',TO_DATE('01-07-2022','dd-mm-yyyy'),5,203);

INSERT INTO STAT_COM_MASINA
VALUES (SEQ_STATCOMMASINI.NEXTVAL,1, 'pe drum', '5 zile',TO_DATE('09-06-2022','dd-mm-yyyy'),4, 202);

INSERT INTO STAT_COM_MASINA
VALUES (SEQ_STATCOMMASINI.NEXTVAL, 0,'procesare', 'nu se stie', TO_DATE('01-07-2023','dd-mm-yyyy'), 3, 206);

INSERT INTO STAT_COM_MASINA
VALUES (SEQ_STATCOMMASINI.NEXTVAL, 1,'in curs','o saptamana', TO_DATE('11-06-2022','dd-mm-yyyy'),1,204);

INSERT INTO STAT_COM_MASINA
VALUES (SEQ_STATCOMMASINI.NEXTVAL,0, 'plata neacceptata','nu se stie',TO_DATE('01-07-2023','dd-mm-yyyy'),5,201);

INSERT INTO STAT_COM_MASINA
VALUES (SEQ_STATCOMMASINI.NEXTVAL, 0,'procesare','nu se stie',TO_DATE('01-07-2023','dd-mm-yyyy'), 3, 205);

INSERT INTO STAT_COM_MASINA
VALUES (SEQ_STATCOMMASINI.NEXTVAL, 1,'pe drum', '1 luna',TO_DATE('04-07-2022','dd-mm-yyyy'),2,206);

INSERT INTO STAT_COM_MASINA
VALUES (SEQ_STATCOMMASINI.NEXTVAL,1,'in curs', '2 saptamani', TO_DATE('21-06-2022','dd-mm-yyyy'),5, 203);

select *
from STAT_COM_MASINA;






--14. Crearea unei vizualiz?ri compuse. Da?i un exemplu de opera?ie LMD permis? pe 
--vizualizarea respectiv? ?i un exemplu de opera?ie LMD nepermis?.
CREATE VIEW masini_prea_scumpe AS SELECT t.denumire, t.pret, s.pregatire, s.data_sosirii
FROM masina t JOIN STAT_COM_MASINA s ON t.id_masina=s.id_masina
WHERE t.pret>(SELECT avg(t.pret) FROM masina); --operatie LMD permisa

--operatie LMD nepermisa
INSERT INTO masini_prea_scumpe VALUES('Dacia',3460,'in curs', TO_DATE('15-08-2022','dd-mm-yyyy'));






--15. Crearea unui index care s? optimizeze o cerere de tip c?utare cu 2 criterii. Specifica?i cererea
CREATE INDEX idx ON masina ( denumire, pret, motorizare,combustibil)
WHERE pret>3000 AND combustibil LIKE 'motorina';




--16. Formula?i în limbaj natural ?i implementa?i în SQL: o cerere ce utilizeaz? opera?ia outerjoin pe minimum 4 tabele ?i dou? cereri ce utilizeaz? opera?ia division.
--returnati pentru fiecare CUSTOMER  adresa, numele si prenumele prducatorilor favoriti si ratingul comenzilor anterioare
--outerjoin
SELECT s.adresa AS CUSTOMER, e.nume AS Producatori_favoriti, c.rating AS COMANDA_MASINA_anterioara
FROM CUSTOMER s right outer join USERNAME p on (p.id_USERNAME = s.id_CUSTOMER) left outer join prod_fav e 
on (p.id_USERNAME = e.id_prodfav) full outer join COM_ANT_MASINI c on (c.id_comant = p.id_USERNAME)
ORDER by s.adresa;

--division
--Sa se obtina USERNAMeii care au trimis invitatii ce contin reduceri cu procentul de 25%.
SELECT *
FROM USERNAME  p
where not exists (
	select id_invitatie
    from invitatii 
    where p.id_USERNAME=id_USERNAME
	minus
	select id_invitatie 
    from reducere
    where procent like '25%' );
 
--returneaza toti USERNAMEii care au Comandat masina cu numarul 205
select s.*
from USERNAME s
where not exists (
	(select id_statcom 
    from STAT_COM_MASINA
    where s.id_USERNAME=id_USERNAME)
	minus
	(select id_masina 
    from masina
    where id_masina= 205) );

