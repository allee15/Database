--10.. Crearea tabelelor în SQL ?i inserarea de date coerente în fiecare dintre acestea (minimum
--5 înregistr?ri în fiecare tabel neasociativ; minimum 10 înregistr?ri în tabelele asociative).

 ----------------------------------------------Utilizator-------------------------------------------
CREATE TABLE UTILIZATOR
                        (id_utilizator NUMBER(5) CONSTRAINT PK_utilizator PRIMARY KEY,
                         nume VARCHAR(100) CONSTRAINT nume_utilizator NOT NULL,
                         prenume VARCHAR(100) CONSTRAINT prenume_utilizator NOT NULL,
                         telefon VARCHAR(20) CONSTRAINT telefon_utilizator NOT NULL,
                         parola VARCHAR(50) UNIQUE
                        );
                        
SELECT *
FROM utilizator;

INSERT INTO UTILIZATOR
VALUES(1,'Dragomirescu','Claudia', '+4021–314.28.63','010014');

INSERT INTO UTILIZATOR
VALUES(2,'Ardeleanu','Mircea', '+4021-312.49.48', '050107');

INSERT INTO UTILIZATOR
VALUES(3,'Baraboi','Adrian', '+0421-305.38.10', '010041');

INSERT INTO UTILIZATOR
VALUES(4,'Chiuta','Ion', '+4021-314.35.89', '030018');

INSERT INTO UTILIZATOR
VALUES(5,'Coca','Eugen', '+4021–313.43.36', '010017');

COMMIT;

--------------------------------------------------------------CLIENT------------------------------------


CREATE TABLE CLIENT(id_client NUMBER(5) CONSTRAINT PK_client PRIMARY KEY,
                         adresa VARCHAR(100) CONSTRAINT adresa_client NOT NULL,
                    id_utilizator NUMBER(5),
                    CONSTRAINT fk_client FOREIGN KEY(id_utilizator) REFERENCES UTILIZATOR(id_utilizator)
                        );
                    
Select *
from client;

INSERT INTO CLIENT
VALUES(10,'Bd. M. Kog?lniceanu, nr. 36–46', 1);    

INSERT INTO CLIENT
VALUES(11,'Bd. Nicolae B?lcescu Nr. 1', 2); 

INSERT INTO CLIENT
VALUES(12,'Bd. Regina Elisabeta nr. 4-12', 3);

INSERT INTO CLIENT
VALUES(13,'Str. Edgar Quinet, nr. 5-7', 4); 

INSERT INTO CLIENT
VALUES(14,'Str. Academiei nr. 14', 5);  

COMMIT;


--------------------------------------------------------------VANZATOR------------------------------------


CREATE TABLE VANZATOR(id_vanzator NUMBER(5) CONSTRAINT PK_vanzator PRIMARY KEY,
                         prezentare VARCHAR(100) CONSTRAINT prezentare_client NOT NULL,
                         varsta NUMBER(5) CONSTRAINT varsta_vanzator NOT NULL,
                    id_utilizator NUMBER(5),
                    CONSTRAINT fk_vanzator FOREIGN KEY(id_utilizator) REFERENCES UTILIZATOR(id_utilizator)
                        );
                        
Select *
from vanzator;

INSERT INTO VANZATOR
VALUES(10,'Artist cu o vasta experienta',45, 1);    

INSERT INTO VANZATOR
VALUES(11,'Pictor de natura moarta',70, 2); 

INSERT INTO VANZATOR
VALUES(12,'Artist nou',20, 3);

INSERT INTO VANZATOR
VALUES(13,'Artist de talie mondiala',40, 4); 

INSERT INTO VANZATOR
VALUES(14,'Artist apreciat la noi pe site',50, 5);  

COMMIT;

      
------------------------------------COMANDA-----------------------------          
CREATE TABLE COMANDA(id_comanda NUMBER(5) CONSTRAINT PK_comanda PRIMARY KEY,
                     data DATE CONSTRAINT data_plasarii NOT NULL,
                     pret NUMBER(5) CONSTRAINT pret_comanda NOT NULL,
                     id_client NUMBER(5),
                    CONSTRAINT fk_client FOREIGN KEY(id_client) REFERENCES CLIENT(id_client)
                       
                    );
drop table comanda;
Select *
from comanda;

INSERT INTO COMANDA
VALUES(20,TO_DATE('12-04-2019','DD-MM-YYYY'),100);

INSERT INTO COMANDA
VALUES(21,TO_DATE('17-06-2021','DD-MM-YYYY'),500);

INSERT INTO COMANDA
VALUES(22,TO_DATE('02-08-2020','DD-MM-YYYY'),2345);

INSERT INTO COMANDA
VALUES(23,TO_DATE('18-05-2022','DD-MM-YYYY'),124);

INSERT INTO COMANDA
VALUES (24,TO_DATE('14-07-2018','DD-MM-YYYY'),6435);

INSERT INTO COMANDA
VALUES (25,TO_DATE('14-05-2021','DD-MM-YYYY'),634);

COMMIT;

------------------------------------------------ABONAMENT-------------------------

CREATE TABLE ABONAMENT(id_abonament NUMBER(5) CONSTRAINT PK_abonament PRIMARY KEY,
                      tip VARCHAR(100) CONSTRAINT tip_abonament NOT NULL,
                      durata VARCHAR(100) CONSTRAINT durata_abonament NOT NULL,
                      pret NUMBER(5) CONSTRAINT pret_abonament NOT NULL,
                    id_utilizator NUMBER(5),
                    CONSTRAINT fk_ab FOREIGN KEY(id_utilizator) REFERENCES UTILIZATOR(id_utilizator)

                    );
                    
Select *
from abonament;

INSERT INTO ABONAMENT
VALUES(30,'Anual','1 an',100, 1);

INSERT INTO ABONAMENT
VALUES(31,'Lunar','2 luni',100, 2);

INSERT INTO ABONAMENT
VALUES(32,'Anual','3 ani',300, 3);

INSERT INTO ABONAMENT
VALUES(33,'Anual','1 an',100, 4);

INSERT INTO ABONAMENT
VALUES (34,'Lunar','6 luni', 300, 5);

COMMIT;

-------------------------------------------------INVITATII----------------------------------------------


CREATE TABLE INVITATII(id_invitatie NUMBER(5) CONSTRAINT PK_invitatii PRIMARY KEY,
                    data DATE CONSTRAINT data_emiterii NOT NULL,
                    nume VARCHAR(100) CONSTRAINT nume_destinatar NOT NULL,
                    prenume VARCHAR(100) CONSTRAINT prenume_destinatar NOT NULL,
                    id_utilizator NUMBER(5),
                    CONSTRAINT fk_invitatii FOREIGN KEY( id_utilizator) REFERENCES UTILIZATOR(id_utilizator)

                    );
                    
select *
from invitatii;

INSERT INTO INVITATII
VALUES(40,TO_DATE('20-05-2022','DD-MM-YYYY'),'Ionel', 'Costel', 3);

INSERT INTO INVITATII
VALUES(41,TO_DATE('18-04-2021','DD-MM-YYYY'),'Mircea', 'Laura', 2);

INSERT INTO INVITATII
VALUES(42,TO_DATE('3-10-2020','DD-MM-YYYY'),'Marcel', 'Ion', 5);

INSERT INTO INVITATII
VALUES(43,TO_DATE('01-01-2019','DD-MM-YYYY'),'Cristea','Veronica', 4);

INSERT INTO INVITATII
VALUES(44,TO_DATE('25-12-2018','DD-MM-YYYY'), 'Cornel', 'Verde',1);

INSERT INTO INVITATII
VALUES(45,TO_DATE('16-02-2022','DD-MM-YYYY'), 'Ion', 'Filip', 2);

INSERT INTO INVITATII
VALUES(46,TO_DATE('18-06-2021','DD-MM-YYYY'),'Mirela', 'Roxana', 1);

INSERT INTO INVITATII
VALUES(47,TO_DATE('2-11-2020','DD-MM-YYYY'),'Mateiu', 'Carcela', 2);

INSERT INTO INVITATII
VALUES(48,TO_DATE('14-08-2019','DD-MM-YYYY'),'Manolache', 'Andreea', 5);

INSERT INTO INVITATII
VALUES(49,TO_DATE('22-06-2021','DD-MM-YYYY'),'Manea', 'Alexandru', 5);

COMMIT;
                    
-------------------------------------REVIEW---------------------------------

CREATE TABLE REVIEW(
                         id_review NUMBER(5) CONSTRAINT PK_review PRIMARY KEY,
                         data DATE CONSTRAINT data_scrierii NOT NULL,
                         nume VARCHAR(100) CONSTRAINT nume_autor NOT NULL,
                         prenume VARCHAR(100) CONSTRAINT prenume_autor NOT NULL,
                         id_client NUMBER(5),
                          CONSTRAINT fk_review FOREIGN KEY( id_client) REFERENCES CLIENT(id_client),
                          id_vanzator NUMBER(5),
                          CONSTRAINT fk_review2 FOREIGN KEY( id_vanzator) REFERENCES VANZATOR(id_vanzator)
                        );                    
                    
Select *
from review;

INSERT INTO REVIEW 
VALUES(51,TO_DATE('12-04-2020','dd-mm-yyyy'),'Nimara', 'Dan', 11, 10);

INSERT INTO REVIEW 
VALUES(52,TO_DATE('26-01-2021','dd-mm-yyyy'),'Dima', 'Oana',12, 14);

INSERT INTO REVIEW 
VALUES(53,TO_DATE('14-01-2022','dd-mm-yyyy'),'Miu', 'Adania', 13, 11);

INSERT INTO REVIEW 
VALUES(54,TO_DATE('27-09-2019','dd-mm-yyyy'),'Gherghescu', 'Andreea',14, 10);

INSERT INTO REVIEW 
VALUES(55,TO_DATE('15-08-2021','dd-mm-yyyy'),'Pascu', 'Adrian', 12, 11);

INSERT INTO REVIEW 
VALUES(56,TO_DATE('24-06-2021','dd-mm-yyyy'),'Baciu', 'Daniel',14, 10);

INSERT INTO REVIEW 
VALUES(57, TO_DATE('17-07-2020','dd-mm-yyyy'),'Guleama', 'Dan',13, 11);

INSERT INTO REVIEW 
VALUES(58,TO_DATE('15-02-2021','dd-mm-yyyy'),'Marton', 'Sergiu',14, 12);

INSERT INTO REVIEW 
VALUES(59,TO_DATE('10-12-2020','dd-mm-yyyy'),'Vultur', 'Sofia',10, 14);

INSERT INTO REVIEW 
VALUES(60,TO_DATE('11-10-2018','dd-mm-yyyy'),'Fritz', 'Raluca', 12, 10);

COMMIT;

----------------------------------------------REDUCERE------------------------------------------------

CREATE TABLE REDUCERE(id_reducere NUMBER(5)  CONSTRAINT pk_reducere PRIMARY KEY,
                    procent NUMBER(5)CONSTRAINT procent_reducere NOT NULL,
                    id_utilizator NUMBER(5),
                    CONSTRAINT fk_reducere FOREIGN KEY( id_utilizator) REFERENCES UTILIZATOR(id_utilizator),
                    id_invitatie NUMBER(5),
                    CONSTRAINT fk_reducere2 FOREIGN KEY( id_invitatie) REFERENCES INVITATII(id_invitatie)
                    );
                    
select *
from reducere;

INSERT INTO REDUCERE
VALUES(61,  30, 1, 40);

INSERT INTO REDUCERE
VALUES(62,  25,5, 41);

INSERT INTO REDUCERE
VALUES(63,  10,2, 49);

INSERT INTO REDUCERE
VALUES(64,  50, 3,43);

INSERT INTO REDUCERE
VALUES(65,  45, 4,45);

INSERT INTO REDUCERE
VALUES(66,  15,2, 44);

INSERT INTO REDUCERE
VALUES(67,  5,1, 47);

INSERT INTO REDUCERE
VALUES(68, 0,3, 48);

INSERT INTO REDUCERE
VALUES(69,  5, 5,45);

INSERT INTO REDUCERE
VALUES(70,  60,4, 45);

COMMIT;

---------------------------------------------------ARTISTI FAVORITI--------------------------------------------------


CREATE TABLE ART_FAV(
                         id_artfav NUMBER(5) CONSTRAINT PK_artfav PRIMARY KEY,
                         nume VARCHAR(100) CONSTRAINT nume_artist NOT NULL,
                         prenume VARCHAR(100) CONSTRAINT prenume_artist NOT NULL,
                    id_utilizator NUMBER(5),
                    CONSTRAINT fk_artfav FOREIGN KEY( id_utilizator) REFERENCES UTILIZATOR(id_utilizator) 
                         
                        ); 
select *
from art_fav;

INSERT INTO ART_FAV
VALUES(100,  'Popescu','Ion', 1);

INSERT INTO ART_FAV
VALUES(101,  'Ionescu','Irina', 5);

INSERT INTO ART_FAV
VALUES(102,  'Avram','Bianca',4);

INSERT INTO ART_FAV
VALUES(103,  'Branescu','Robert', 2);

INSERT INTO ART_FAV
VALUES(104,  'Enache','Teodora', 1);

INSERT INTO ART_FAV
VALUES(105,  'Boboc','Stefania', 3);

COMMIT;

----------------------------------------------------------------COMENZI ANTERIOARE------------------------------

CREATE TABLE COM_ANT(id_comant NUMBER(5) CONSTRAINT pk_comant PRIMARY KEY,
                    pret NUMBER CONSTRAINT pret_comant NOT NULL,
                    data DATE CONSTRAINT data_comant NOT NULL,
                    rating NUMBER CONSTRAINT rating_comant NOT NULL,
                    id_utilizator NUMBER(5),
                    CONSTRAINT fk_comant FOREIGN KEY( id_utilizator) REFERENCES UTILIZATOR(id_utilizator) 
                        
                    );
                    
Select *
from com_ant;

INSERT INTO COM_ANT
VALUES(106,500, TO_DATE('01-08-2018','dd-mm-yyyy'), 10, 5);


INSERT INTO COM_ANT
VALUES(107, 450,TO_DATE('01-07-2018','dd-mm-yyyy'), 5, 3);

INSERT INTO COM_ANT
VALUES(108,243, TO_DATE('01-06-2017','dd-mm-yyyy'), 9, 5);

INSERT INTO COM_ANT
VALUES(109, 645,TO_DATE('01-06-2017','dd-mm-yyyy'), 8, 4);

INSERT INTO COM_ANT
VALUES (110,867, TO_DATE('01-06-2017','dd-mm-yyyy'), 5, 3);

INSERT INTO COM_ANT
VALUES (111,635,TO_DATE('01-06-2017','dd-mm-yyyy'), 3, 2);

INSERT INTO COM_ANT
VALUES (112,835,TO_DATE('01-06-2019','dd-mm-yyyy'), 4, 1);

--------------------------------------------------------TABLOU----------------------------------------------------

CREATE TABLE TABLOU(id_tablou NUMBER(5) CONSTRAINT PK_tablou PRIMARY KEY,
                    denumire VARCHAR(30) CONSTRAINT denumire_tablou NOT NULL,
                     pret NUMBER CONSTRAINT pret_tablou NOT NULL,
                    dimensiuni VARCHAR(50) CONSTRAINT dimensiuni_tablou NOT NULL,
                    tip_pictura VARCHAR(50) CONSTRAINT tip_tablou NOT NULL,
                    culori VARCHAR(50) CONSTRAINT culori_tablou NOT NULL,
                    tip_culori VARCHAR(50) CONSTRAINT tip_culori_tablou NOT NULL,
                    rama VARCHAR(50) CONSTRAINT rama_tablou NOT NULL
                    
                    );

select *
from tablou;

INSERT INTO TABLOU
VALUES (200,'Iarna',500,'50x40x30','pastel','rosu,verde','acrilice','nu' );

INSERT INTO TABLOU
VALUES (201,'Copac magic',250, '100x20x50','natura','roz,mov.verde.albastru','ulei','da');

INSERT INTO TABLOU
VALUES (202,'Flori pe camp', 150,'30x20x10', 'natura', 'rosu,galben,portocaliu,verde,albastru','tempera','da');

INSERT INTO TABLOU
VALUES (203,'Usa florala', 450,'35x30x20','decoratiuni stradale','roz,maro,alb,albastru,auriu','acrilice','nu');

INSERT INTO TABLOU
VALUES (204,'Marea',300, '20x10x25','peisaj','galben,albastru,verde,maro','ulei','da');

INSERT INTO TABLOU
VALUES (205,'Foc de tabara',534, '35x30x35', 'peisaj','rosu,galben,portocaliu,maro','ulei','nu');

INSERT INTO TABLOU
VALUES (206,'Leu', 250, '30x35x20','animale', 'rosu, auriu, maro,galben,portocaliu', 'acrilice', 'da');

--------------------------------------------------------STATUS COMANDA---------------------------------------------

CREATE TABLE STAT_COM(id_statcom NUMBER(5) CONSTRAINT PK_statcom PRIMARY KEY,
                    primire NUMBER(5) CONSTRAINT primire_com NOT NULL,
                    pregatire VARCHAR(50) CONSTRAINT pregatire_com NOT NULL,
                    trimitere VARCHAR(50) CONSTRAINT trimitere_com NOT NULL,
                    data_sosire DATE CONSTRAINT data_com NOT NULL,
                    id_utilizator NUMBER(5),
                    CONSTRAINT fk_statcom FOREIGN KEY( id_utilizator) REFERENCES UTILIZATOR(id_utilizator), 
                     id_tablou NUMBER(5),
                    CONSTRAINT fk_statcom2 FOREIGN KEY( id_tablou) REFERENCES TABLOU(id_tablou) 
                           
                    );

select *
from stat_com;

INSERT INTO STAT_COM
VALUES (300, 1,'in curs','in 2 luni',TO_DATE('01-07-2022','dd-mm-yyyy'),5,203);

INSERT INTO STAT_COM
VALUES (301,1, 'pe drum', '5 zile',TO_DATE('09-06-2022','dd-mm-yyyy'),4, 202);

INSERT INTO STAT_COM
VALUES (302, 0,'procesare', 'nu se stie', TO_DATE('01-07-2023','dd-mm-yyyy'), 3, 206);

INSERT INTO STAT_COM
VALUES (303, 1,'in curs','o saptamana', TO_DATE('11-06-2022','dd-mm-yyyy'),1,204);

INSERT INTO STAT_COM
VALUES (304,0, 'plata neacceptata','nu se stie',TO_DATE('01-07-2023','dd-mm-yyyy'),5,201);

INSERT INTO STAT_COM
VALUES (305, 0,'procesare','nu se stie',TO_DATE('01-07-2023','dd-mm-yyyy'), 3, 205);

INSERT INTO STAT_COM
VALUES (306, 1,'pe drum', '1 luna',TO_DATE('04-07-2022','dd-mm-yyyy'),2,206);

INSERT INTO STAT_COM
VALUES (307,1,'in curs', '2 saptamani', TO_DATE('21-06-2022','dd-mm-yyyy'),5, 203);

-------------------------------------------------------CUMPARARE/VINDERE----------------------------------------------
CREATE TABLE CUMP_VIND(id_utilizator NUMBER(5) CONSTRAINT pk_cvu REFERENCES UTILIZATOR(id_utilizator),
                    id_tablou NUMBER(5)CONSTRAINT pk_cvt REFERENCES TABLOU(id_tablou) ,
                    CONSTRAINT pk_cump_vind primary key(id_utilizator,id_tablou)
                    );
select *
from cump_vind;


INSERT INTO cump_vind
VALUES (1, 202);

INSERT INTO cump_vind
VALUES (2,201);

INSERT INTO cump_vind
VALUES (4,206);

INSERT INTO cump_vind
VALUES (5,200);

INSERT INTO cump_vind
VALUES (2,205);

INSERT INTO cump_vind
VALUES (3,204);

INSERT INTO cump_vind
VALUES (1,205);

INSERT INTO cump_vind
VALUES (4,200);

INSERT INTO cump_vind
VALUES (3,206);

INSERT INTO cump_vind
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

--afisati numele, prenumele si parola utilizatorilor care sunt vanzatori si care au review-uri postate inainte de
-- data 01-01-2022
SELECT CONCAT(CONCAT(p.nume,' '),p.prenume) AS "Utilizator", p.parola AS "Parola"
FROM utilizator p
WHERE p.id_utilizator in (SELECT id_utilizator
                            FROM vanzator
                            WHERE id_vanzator IN (SELECT id_review
                                                FROM review
                                                WHERE data <TO_DATE('01-01-2022','dd-mm-yyyy')
                                                )
                            );

--afisati titlurile tablourilor si preturile acestora care au rama
SELECT UNIQUE CONCAT(CONCAT('Titlul este ', f.denumire), CONCAT(' si costa ',f.pret)) AS "Rezultat"
FROM tablou f
WHERE UPPER(f.rama) LIKE UPPER('Da');

--afisati review-urile anterioare datei de 01-01-2022 si care contin litera i in nume
SELECT nume AS "Numele autorului", prenume AS "Prenumele autorului" 
FROM review
WHERE data< TO_DATE('01-01-2022','dd-mm-yyyy') AND nume LIKE '%i%';

--pentru fiecare tablou sa se afiseze ce pret are fiecare cu codurile de la 1 pana la 5 
--si pretul total al unui tablou 
SELECT id_tablou, denumire, SUM(DECODE(id_tablou, 1, pret)) Tablou1,
                            SUM(DECODE(id_tablou, 2, pret)) Tablou2,
                            SUM(DECODE(id_tablou, 3, pret)) Tablou3,
                            SUM(DECODE(id_tablou, 4, pret)) Tablou4,
                            SUM(DECODE(id_tablou, 5, pret)) Tablou5,
                            SUM(DECODE(id_tablou, 6, pret)) Tablou6,
                            SUM(DECODE(id_tablou, 7, pret)) Tablou7,
                            SUM(pret) as Total
FROM tablou
GROUP BY id_tablou,denumire;

--afisati denumirea si pretul unui tablou care trebuie sa ajunga in urmatoarele 15 luni si daca va veni curand
SELECT s.denumire AS Denumire, s.pret AS Pret, i.data_sosire AS Data, NVL(to_char(s.id_tablou),'nu vine curand') AS Vine
FROM tablou s, stat_com i
WHERE MONTHS_BETWEEN(sysdate,i.data_sosire)<15
ORDER BY s.denumire;

--afisati pt fiecare tablou titlul, tipul acestuia, data la care se va livraa, ratingul artistului si pretul
--acestuia sub forma unui mesaj orientativ
SELECT s.denumire, s.tip_pictura, e.data_sosire, c.rating,
CASE
    WHEN s.pret >=100 and s.pret<200 THEN 'Pretul este peste 100 de lei'
    WHEN s.pret >=200 and s.pret<300 THEN 'Pretul este peste 200 de lei'
    WHEN s.pret >=300 and s.pret<400 THEN 'Pretul este peste 300 de lei'
    WHEN s.pret >=400 and s.pret<500 THEN 'Pretul este peste 400 de lei'
    WHEN s.pret >=500 THEN 'Bafta, este cam scump peste 500 de lei'
    ELSE 'Ai noroc, e moca'
END AS Preturi
FROM tablou s, stat_com e, com_ant c
WHERE s.id_tablou=e.id_tablou AND e.id_utilizator=c.id_utilizator
ORDER BY s.denumire, s.tip_pictura, e.data_sosire, c.rating;

--afisam pt fiecare tablou care are pretul mai mare decat cel average, denumirea sa
WITH prett (denumire,total) AS (SELECT denumire, sum(pret) 
                                FROM tablou
                                GROUP BY denumire),
              pretavg (avgp) as (SELECT avg(pret)
                                FROM tablou)
    SELECT denumire as "Denumire tablou"
    FROM prett , pretavg 
    WHERE prett.total> pretavg.avgp
    ORDER BY denumire;

--sa se afiseze informatiile despre tablourile ale caror pret in alte comenzi anterioare depaseste average-ul
--si nr de comenzi anterioare
SELECT *
FROM tablou;

SELECT p.denumire, p.tip_pictura, p.culori, p.dimensiuni, p.tip_culori, c.pret, ( select avg(pret)
                                                                                FROM com_ant
                                                                                Where id_utilizator=c.id_utilizator) as "Pret mediu",
                                                                                (select count(*)
                                                                                from com_ant
                                                                                where f.id_utilizator= id_utilizator) as "Numar comenzi"
FROM tablou p, com_ant c, utilizator f
where f.id_utilizator=c.id_utilizator and c.pret> (select avg(pret)
                                                  from com_ant
                                                  where id_utilizator=c.id_utilizator);
                                                                        
--vrem sa afisam pt fiecare utilizator numele, prenumele si data sosirii tabloului cumparat 
SELECT utilizator.nume,utilizator.prenume, tablou.denumire,  stat_com.data_sosire
FROM tablou
INNER JOIN stat_com ON stat_com.id_tablou= tablou.id_tablou
INNER JOIN utilizator ON stat_com.id_utilizator=utilizator.id_utilizator
INNER JOIN cump_vind ON utilizator.id_utilizator= cump_vind.id_utilizator
ORDER BY utilizator.nume, utilizator.prenume, tablou.denumire, stat_com.data_sosire;






--12.Implementarea a 3 opera?ii de actualizare sau suprimare a datelor utilizând subcereri.
--1. Sa se mareasca pretul abonamentului anual cu 10% pentru utilizatorii al caror nr de telefon incepe cu 074
UPDATE ABONAMENT
SET pret = pret + 0.1*pret
WHERE tip LIKE 'Anual' AND id_utilizator IN (SELECT id_utilizator
                                            FROM utilizator
                                            WHERE telefon LIKE '074%');

--2. Sa se mareasca ratingul utilizatorilor al caror nume incepe cu litera A.
UPDATE COM_ANT
SET rating= rating+ 1
WHERE id_utilizator IN (SELECT id_utilizator
                        FROM utilizator
                        WHERE nume LIKE 'A%');

--3. Sa se micsoreze procentul de reducere al invitatiilor a caror data e in anul 2021
UPDATE REDUCERE
SET procent= procent- 10
WHERE id_invitatie IN (SELECT id_invitatie
                        FROM invitatii
                        WHERE to_char(data,'yyyy')='2021');






--13. Crearea unei secven?e ce va fi utilizat? în inserarea înregistr?rilor în tabele (punctul 10).
CREATE SEQUENCE SEQ_STATCOM
INCREMENT by 10
START WITH 300
MAXVALUE 10000
NOCYCLE;

INSERT INTO STAT_COM
VALUES (SEQ_STATCOM.NEXTVAL, 1,'in curs','in 2 luni',TO_DATE('01-07-2022','dd-mm-yyyy'),5,203);

INSERT INTO STAT_COM
VALUES (SEQ_STATCOM.NEXTVAL,1, 'pe drum', '5 zile',TO_DATE('09-06-2022','dd-mm-yyyy'),4, 202);

INSERT INTO STAT_COM
VALUES (SEQ_STATCOM.NEXTVAL, 0,'procesare', 'nu se stie', TO_DATE('01-07-2023','dd-mm-yyyy'), 3, 206);

INSERT INTO STAT_COM
VALUES (SEQ_STATCOM.NEXTVAL, 1,'in curs','o saptamana', TO_DATE('11-06-2022','dd-mm-yyyy'),1,204);

INSERT INTO STAT_COM
VALUES (SEQ_STATCOM.NEXTVAL,0, 'plata neacceptata','nu se stie',TO_DATE('01-07-2023','dd-mm-yyyy'),5,201);

INSERT INTO STAT_COM
VALUES (SEQ_STATCOM.NEXTVAL, 0,'procesare','nu se stie',TO_DATE('01-07-2023','dd-mm-yyyy'), 3, 205);

INSERT INTO STAT_COM
VALUES (SEQ_STATCOM.NEXTVAL, 1,'pe drum', '1 luna',TO_DATE('04-07-2022','dd-mm-yyyy'),2,206);

INSERT INTO STAT_COM
VALUES (SEQ_STATCOM.NEXTVAL,1,'in curs', '2 saptamani', TO_DATE('21-06-2022','dd-mm-yyyy'),5, 203);

select *
from stat_com;






--14. Crearea unei vizualiz?ri compuse. Da?i un exemplu de opera?ie LMD permis? pe 
--vizualizarea respectiv? ?i un exemplu de opera?ie LMD nepermis?.
CREATE VIEW tablouri_cu_pret_peste_average AS SELECT t.denumire, t.pret, s.pregatire, s.data_sosire
FROM tablou t JOIN stat_com s ON t.id_tablou=s.id_tablou
WHERE t.pret>(SELECT avg(t.pret) FROM tablou); --operatie lmd permisa

--operatie lmd nepermisa
INSERT INTO tablouri_cu_pret_peste_average VALUES('Iarna la munte',400,'in curs', TO_DATE('01-07-2022','dd-mm-yyyy'));






--15. Crearea unui index care s? optimizeze o cerere de tip c?utare cu 2 criterii. Specifica?i cererea
CREATE INDEX idx ON tablou ( denumire, pret, dimensiuni, rama)
WHERE pret>200 AND rama LIKE 'da';




--16. Formula?i în limbaj natural ?i implementa?i în SQL: o cerere ce utilizeaz? opera?ia outerjoin pe minimum 4 tabele ?i dou? cereri ce utilizeaz? opera?ia division.
--returnati pentru fiecare client  adresa, numele si prenumele artistilor favoriti si ratingul comenzilor anterioare
--outerjoin
SELECT s.adresa AS Client, e.nume||' '||e.prenume AS Artisti_favoriti, c.rating AS Comenzi_anterioare
FROM client s right outer join utilizator p on (p.id_utilizator = s.id_client) left outer join art_fav e 
on (p.id_utilizator = e.id_artfav) full outer join com_ant c on (c.id_comant = p.id_utilizator)
order by s.adresa;

--division
--Sa se obtina utilizatorii care au trimis invitatii ce contin reduceri cu procentul de 10%.
SELECT *
FROM utilizator  p
where not exists (
	select id_invitatie
    from invitatii 
    where p.id_utilizator=id_utilizator
	minus
	select id_invitatie 
    from reducere
    where procent like '10%' );
 
--returneaza toti utilizatorii care au comandat tabloul cu numarul 203
select *s
from utilizator s
where not exists (
	(select id_statcom 
    from stat_com
    where s.id_utilizator=id_utilizator)
	minus
	(select id_tablou 
    from tablou 
    where id_tablou= 203) );


