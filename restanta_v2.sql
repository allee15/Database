CREATE TABLE PRODUCATOR (id_producator NUMBER(5) CONSTRAINT pk_producator PRIMARY KEY,
                        nume VARCHAR(20) CONSTRAINT nume_producator NOT NULL,
                        telefon VARCHAR(15) CONSTRAINT telefon_producator NOT NULL,
                        email VARCHAR(20) CONSTRAINT email_producator NOT NULL);
                        
insert into producator
values (1, 'BrandMarck' , '0345678322', 'contact@gmail.com');

insert into producator
values (2, 'ClothesForEveryone', '0789345655', 'clothes_1@gmail.com');

insert into producator
values (3, 'MadeInMorocco', '0345687732', 'callus@yahoo.com');

insert into producator
values (4, 'HommyTilfinger', '034544377', 'hommy_t@gmail.com');

insert into producator 
values (5, 'BugoHoss', '0456788124', 'bugo12@gmail.com');

commit;
select* from producator;




CREATE TABLE MARFA (id_marfa NUMBER(5) CONSTRAINT pk_marfa PRIMARY KEY,
                    data_livrare DATE CONSTRAINT data_marfa NOT NULL);
                    
insert into marfa
values (6, TO_DATE('15-03-2023','dd-mm-yyyy'));

insert into marfa 
values (7, TO_DATE('1-03-2023', 'dd-mm-yyyy'));

insert into marfa
values (8, TO_DATE('15-04-2023', 'dd-mm-yyyy'));

insert into marfa
values (9, TO_DATE('1-04-2023', 'dd-mm-yyyy'));

insert into marfa
values (10, TO_DATE('1-05-2023','dd-mm-yyyy'));

commit;
select* from marfa;



CREATE TABLE PRODUSE_DEFECTE(id_defect NUMBER(5) CONSTRAINT pk_prod_defect PRIMARY KEY,
                             data_inregistrare DATE CONSTRAINT data_prod_defect NOT NULL,
                             cod_produs NUMBER(15) CONSTRAINT cod_prod_defect NOT NULL,
                             id_producator NUMBER(5),
                             CONSTRAINT fk_prod_def FOREIGN KEY (id_producator) REFERENCES PRODUCATOR (id_producator),
                             id_marfa NUMBER(5),
                             CONSTRAINT fk_prod_deff FOREIGN KEY(id_marfa) REFERENCES MARFA(id_marfa));

insert into produse_defecte
values(11, TO_DATE('15-01-2023','dd-mm-yyyy'), 1234670800, 1,7);

insert into produse_defecte
values (12, TO_DATE('03-04-2022','dd-mm-yyyy'), 2345674456, 4, 10);

insert into produse_defecte
values (13, TO_DATE('16-02-2023','dd-mm-yyyy'), 1456239485, 5, 8);

insert into produse_defecte
values (14, TO_DATE('17-12-2022','dd-mm-yyyy'), 3456233466, 3, 9);

insert into produse_defecte
values (15, TO_DATE('18-01-2023','dd-mm-yyyy'), 4332456800, 2, 6);

insert into produse_defecte
values (16, TO_DATE('20-01-2023','dd-mm-yyyy'), 2331441500, 2, 7);

insert into produse_defecte
values (17, TO_DATE('14-12-2022','dd-mm-yyyy'), 2230450678, 3, 10);

insert into produse_defecte
values (18, TO_DATE('01-02-2023','dd-mm-yyyy'), 4523900800, 5, 9);

insert into produse_defecte
values (19, TO_DATE('22-11-2022','dd-mm-yyyy'), 4567890957, 1, 8);

insert into produse_defecte
values (20, TO_DATE('13-01-2023','dd-mm-yyyy'), 3453230567, 3,9);

commit;
select* from produse_defecte;



CREATE TABLE OYSHO (id_oysho NUMBER(5) CONSTRAINT pk_oysho PRIMARY KEY,
                    tara VARCHAR(20) CONSTRAINT tara_oysho NOT NULL,
                    oras VARCHAR(20) CONSTRAINT oras_oysho NOT NULL,
                    id_producator NUMBER(5),
                    CONSTRAINT fk_oysho FOREIGN KEY (id_producator) REFERENCES PRODUCATOR(id_producator));
                    
insert into oysho
values (21, 'Romania', 'Bucuresti', 1);

insert into oysho
values (22, 'Spania', 'Madrid', 4);

insert into oysho
values (23, 'Italia', 'Roma', 5);

insert into oysho
values (24, 'Franta', 'Paris', 2);

insert into oysho
values (25, 'Portugalia', 'Lisabona', 3);

commit;
select* from oysho;




CREATE TABLE ANGAJATI(id_angajat NUMBER(5) CONSTRAINT pk_angajat PRIMARY KEY,
                      nume_angajat VARCHAR(50) CONSTRAINT nume_angajat NOT NULL,
                      prenume_angajat VARCHAR(50) CONSTRAINT prenume_angajat NOT NULL,
                      telefon_angajat VARCHAR(50) CONSTRAINT telefon_angajat NOT NULL,
                      email_angajat VARCHAR(50) CONSTRAINT email_angajat NOT NULL,
                      adresa_angajat VARCHAR(50) CONSTRAINT adresa_angajat NOT NULL);
                      
insert into angajati
values (26, 'Florea', 'Catalin', '0756345786', 'florea@gmail.com', 'Florilor 6');

insert into angajati
values (27, 'Adam', 'Antonio', '0746330454', 'andy_ad@gmail.com', 'Tepes Voda 25');

insert into angajati
values(28, 'Vulcanescu', 'Mircea', '0745555676', 'mirciulica123@gmail.com', 'Rezervelor 4');

insert into angajati
values (29, 'Ceausu', 'Radu', '0789888543', 'radulish@yahoo.com', 'Anton Pann 32');

insert into angajati 
values (30, 'Craciun', 'Alexandru', '0734565723', 'christmas_alex@gmail.com', 'Mircea Voievod 67');

insert into angajati
values (36, 'Aldea', 'Alexia', '0756888187', 'alexia@gmail.com', 'Constructorilor 29');

insert into angajati
values (37, 'Rosu', 'Cristina', '0731456777', 'cris_rosu@gmail.com', 'Teiul Doamnnei 12');

insert into angajati
values (38, 'Luta', 'Alexandra', '0733454558', 'kiwi@gmail.com', 'Grozavesti 34');

insert into angajati 
values (39, 'Pentu', 'Miruna', '0735464889', 'mirus.spirus@gmail.com', 'Bucurestii Noi 1');

insert into angajati
values (40, 'Bozeanu', 'Mirela', '0763888176', 'miree_boze@gmail.com', 'Morarilor 90');

commit;
select* from angajati;



CREATE TABLE LOCATIE (id_magazin NUMBER(5) CONSTRAINT pk_locatie PRIMARY KEY,
                      nume_magazin VARCHAR(20) CONSTRAINT nume_locatie NOT NULL,
                      telefon VARCHAR(20) CONSTRAINT telefon_magazin NOT NULL,
                      email VARCHAR(50) CONSTRAINT email_magazin NOT NULL,
                      adresa VARCHAR(100) CONSTRAINT adresa_magazin NOT NULL,
                      id_oysho NUMBER(5),
                      CONSTRAINT fk_magazin FOREIGN KEY (id_oysho) REFERENCES OYSHO (id_oysho),
                      id_manager NUMBER(5),
                      CONSTRAINT fk_magg FOREIGN KEY (id_manager) REFERENCES ANGAJATI(id_angajat));
                    
insert into locatie
values (31, 'Oysho Promenada', '031455678', 'oysho_prome@gmail.com', 'Barbu Vacarescu 8', 21, 30);

insert into locatie
values (32, 'Oysho SunPLaza', '0314567890', 'oysho_sunplaza@gmail.com', 'Vacaresti 32', 22, 26);

insert into locatie
values(33, 'Oysho Cotroceni', '031400500', 'oysho_afi@gmail.com', 'Cotroceni 35', 23, 29);

insert into locatie
values (34, 'Oyhso Baneasa', '031444556', 'oysho_baneasa@gmail.com', 'Bucuresti-Ploiesti 14', 24, 28);

insert into locatie
values (35, 'Oysho ParkLake', '031446673', 'oysho_parklake@gmail.com', 'Liviu Rebreanu 5', 25, 27);

commit;
select* from locatie;
                      
                      
                      

CREATE TABLE CONTRACT (id_contract NUMBER(5) CONSTRAINT pk_contr PRIMARY KEY,
                       data_semnarii DATE CONSTRAINT data_contract NOT NULL,
                       tip_contract VARCHAR(20) CONSTRAINT tip_contract NOT NULL,
                       id_oysho NUMBER(5),
                       CONSTRAINT fk_contr_oysho FOREIGN KEY (id_oysho) REFERENCES OYSHO(id_oysho),
                       id_angajat NUMBER(5),
                       CONSTRAINT fk_contr_angajat FOREIGN KEY(id_angajat) REFERENCES ANGAJATI(id_angajat));
                       
insert into contract
values (41, TO_DATE('15-02-2010','dd-mm-yyyy'), 'manager', 21, 27);

insert into contract
values (42, TO_DATE('6-04-2013','dd-mm-yyyy'), 'manager', 22, 28);

insert into contract
values (43, TO_DATE('23-11-2015','dd-mm-yyyy'), 'manager', 23, 29);

insert into contract
values (44, TO_DATE('25-12-2012', 'dd-mm-yyyy'), 'manager', 24, 30);

insert into contract
values (45, TO_DATE('17-05-2017','dd-mm-yyyy'), 'manager', 25, 26);

insert into contract
values (46, TO_DATE('24-11-2021','dd-mm-yyyy'), 'angajat', 22, 39);

insert into contract
values (47, TO_DATE('31-01-2020','dd-mm-yyyy'), 'angajat', 25, 40);

insert into contract
values (48, TO_DATE('16-10-2021','dd-mm-yyyy'), 'angajat', 24, 36);

insert into contract
values (49, TO_DATE('25-09-2021','dd-mm-yyyy'), 'angajat', 21, 37);

insert into contract
values (50, TO_DATE('19-07-2022','dd-mm-yyyy'), 'angajat', 23, 38);

commit;
select* from contract;





CREATE TABLE CONTOR_MARFA(id_contor NUMBER(5) CONSTRAINT pk_contor PRIMARY KEY,
                          nr_cutii NUMBER(5) CONSTRAINT cutii_contor NOT NULL,
                          id_marfa NUMBER(5),
                          CONSTRAINT fk_contor FOREIGN KEY (id_marfa) REFERENCES MARFA (id_marfa),
                          id_magazin NUMBER(5),
                          CONSTRAINT fk_contorr FOREIGN KEY (id_magazin) REFERENCES LOCATIE(id_magazin));

insert into contor_marfa
values (51, 156, 6, 34);

insert into contor_marfa
values (52, 144, 8, 33);

insert into contor_marfa
values (53, 200, 9, 35);

insert into contor_marfa
values (54, 45, 10, 31);

insert into contor_marfa
values (55, 57, 8, 32);

insert into contor_marfa
values (56, 230, 7, 35);

insert into contor_marfa
values (57, 400, 6, 33);

insert into contor_marfa
values (58, 245, 9, 32);

insert into contor_marfa
values (59, 120, 7, 35);

insert into contor_marfa
values (60, 89, 9, 34);

commit;
select* from contor_marfa;



CREATE TABLE CLIENT(id_client NUMBER(5) CONSTRAINT pk_client PRIMARY KEY,
                    nume_client VARCHAR(20) CONSTRAINT nume_client NOT NULL,
                    prenume_client VARCHAR(20) CONSTRAINT prenume_client NOT NULL,
                    email_client VARCHAR(50) CONSTRAINT email_client NOT NULL,
                    telefon_client VARCHAR(20) CONSTRAINT telefon_client NOT NULL);
                    
insert into client
values (61, 'Pirinei', 'Ionut', 'ionut@gmail.com', '0756789900');

insert into client
values (62, 'Predeanu', 'Mariana', 'mary12@gmail.com', '0745677899');

insert into client
values (63, 'Ciocos', 'Bianca', 'bye_eu@gmail.com', '0765444143');

insert into client
values (64, 'Teodoroiu', 'Cristina', 'cris_teo@gmail.com', '0746767888');

insert into client
values (65, 'Mircea', 'Carina', 'cary_cary@gmail.com', '0745883464');

commit;
select* from client;
                    



CREATE TABLE COMENZI_ONLINE(id_comanda NUMBER(5) CONSTRAINT pk_comanda PRIMARY KEY,
                            data_plasare DATE CONSTRAINT data_comanda NOT NULL,
                            data_sosire DATE CONSTRAINT data_sosire NOT NULL,
                            adresa_livrare VARCHAR(100) CONSTRAINT adresa_comanda NOT NULL,
                            id_magazin NUMBER(5),
                            CONSTRAINT fk_com FOREIGN KEY (id_magazin) REFERENCES LOCATIE(id_magazin),
                            id_client NUMBER(5),
                            CONSTRAINT fk_comm FOREIGN KEY (id_client) REFERENCES CLIENT (id_client));
            

insert into comenzi_online
values (66, TO_DATE('16-01-2023','dd-mm-yyyy'), TO_DATE('24-02-2023','dd-mm-yyyy'), 'Barbu Vacarescu 70', 31, 64); 

insert into comenzi_online
values (67, TO_DATE('31-01-2023','dd-mm-yyyy'), TO_DATE('14-02-2023','dd-mm-yyyy'), 'Liviu Rebreanu 13',33,61);

insert into comenzi_online
values (68, TO_DATE('14-02-2023','dd-mm-yyyy'), TO_DATE('15-03-2023','dd-mm-yyyy'), 'Magheru 13',32, 65);

insert into comenzi_online
values (69, TO_DATE('22-02-2023','dd-mm-yyyy'), TO_DATE('18-03-2023','dd-mm-yyyy'), 'Nicolae Grigorescu 17', 34, 64);

insert into comenzi_online
values (70, TO_DATE('29-03-2023','dd-mm-yyyy'), TO_DATE('14-04-2023','dd-mm-yyyy'), 'Vlad Tepes 13', 35, 63);

insert into comenzi_online
values (71, TO_DATE('15-04-2023', 'dd-mm-yyyy'), TO_DATE('16-05-2023','dd-mm-yyyy'), 'Crizantemelor 50', 33, 65);

insert into comenzi_online
values (72, TO_DATE('20-03-2023','dd-mm-yyyy'), TO_DATE('17-04-2023','dd-mm-yyyy'), 'Decebal 20', 31, 61);

insert into comenzi_online
values (73, TO_DATE('14-02-2023','dd-mm-yyyy'), TO_DATE('18-04-2023','dd-mm-yyyy'), 'Lascar Catargiu 12',32, 65);

insert into comenzi_online
values (74, TO_DATE('15-01-2023','dd-mm-yyyy'), TO_DATE('13-02-2023','dd-mm-yyyy'), 'Regina Elisabeta 3',34,65);

insert into comenzi_online
values (75, TO_DATE('22-03-2023','dd-mm-yyyy'), TO_DATE('14-04-2023','dd-mm-yyyy'), 'Sfanta Vineri 34',32,62);

commit;
select* from comenzi_online;



CREATE TABLE RATING(id_rating NUMBER(5) CONSTRAINT pk_rating PRIMARY KEY,
                    nota_acordata NUMBER(5) CONSTRAINT nota_rating NOT NULL,
                    id_angajat NUMBER(5),
                    CONSTRAINT fk_rat FOREIGN KEY(id_angajat) REFERENCES ANGAJATI(id_angajat),
                    id_client NUMBER(5),
                    CONSTRAINT fk_ratt FOREIGN KEY(id_client) REFERENCES CLIENT(id_client));
                    
insert into rating
values (76, 8, 26, 65);

insert into rating
values (77, 10, 27, 61);

insert into rating
values (78, 5, 37, 64);

insert into rating
values (79, 7, 30, 61);

insert into rating 
values (80, 9, 38, 65);

commit;
select* from rating;


CREATE TABLE REVIEW(id_review NUMBER(5) CONSTRAINT pk_review PRIMARY KEY,
                    descriere VARCHAR(100) CONSTRAINT descriere_review NOT NULL,
                    id_magazin NUMBER(5),
                    CONSTRAINT fk_rev FOREIGN KEY(id_magazin) REFERENCES LOCATIE(id_magazin),
                    id_client NUMBER(5),
                    CONSTRAINT fk_revv FOREIGN KEY(id_client) REFERENCES CLIENT(id_client));


insert into review
values (81, 'angajati foarte prietenosi', 33, 64);

insert into review
values (82, 'haine calitative', 31, 65);

insert into review
values (83, 'personal priceput', 32, 63);

insert into review
values (84, 'ador acest brand', 34, 61);

insert into review
values(85, 'mai revin aici',35, 62);

commit;
select* from review;


CREATE TABLE REDUCERE(id_reducere NUMBER(5) CONSTRAINT pk_reducere PRIMARY KEY,
                      procent NUMBER(5) CONSTRAINT procent_reducere NOT NULL,
                      perioada_valabilitate NUMBER(5) CONSTRAINT perioada_reducere NOT NULL,
                      data_inceput DATE CONSTRAINT data_reducere NOT NULL,
                      id_client NUMBER(5),
                      CONSTRAINT fk_red FOREIGN KEY(id_client) REFERENCES CLIENT(id_client));


insert into reducere
values (86, 10, 3, TO_DATE('01-01-2023','dd-mm-yyyy'), 61);

insert into reducere
values (87, 25, 5, TO_DATE('23-07-2022','dd-mm-yyyy'), 63);

insert into reducere
values (88, 40, 7, TO_DATE('24-11-2021','dd-mm-yyyy'), 65);

insert into reducere
values (89, 35, 2, TO_DATE('01-02-2023','dd-mm-yyyy'), 62);

insert into reducere
values (90, 25, 1, TO_DATE('15-01-2023','dd-mm-yyyy'), 64);

commit;
select* from reducere;


SET SERVEROUTPUT ON;

--6. Pentru marfa, le luam pe cele care au data de livrare in ultima luna. Apoi, pentru 
--fiecare locatie, calculam cate cutii a primit la marfa.
CREATE OR REPLACE PROCEDURE proceduraex6 IS
    TYPE cutii_comanda IS TABLE OF contor_marfa.nr_cutii%TYPE;
    TYPE id_magazin IS TABLE OF contor_marfa.id_magazin%TYPE INDEX BY PLS_INTEGER;
    v_cutii cutii_comanda;
    v_locatie_id id_magazin;
  
    CURSOR c_marfa_ianuarie IS
    SELECT id_marfa, data_livrare
    FROM marfa
    WHERE EXTRACT(MONTH FROM data_livrare) = 3;
BEGIN
    FOR m IN c_marfa_ianuarie LOOP
        SELECT contor_marfa.nr_cutii, contor_marfa.id_magazin
        BULK COLLECT INTO v_cutii, v_locatie_id
        FROM contor_marfa
        WHERE contor_marfa.id_marfa = m.id_marfa;
    
    FOR i IN 1..v_locatie_id.COUNT LOOP
      -- calculam totalul cutiilor pentru fiecare locatie
        DBMS_OUTPUT.PUT_LINE('Magazinul ' || v_locatie_id(i) || ' a primit ' || v_cutii(i) || ' cutii de marfa. ');
        
    END LOOP;
    END LOOP;
    
END proceduraex6;
/

EXECUTE proceduraex6;
/
--?n acest exemplu, se declar? dou? tipuri diferite de colec?ii: "cutii_comanda" ?i "id_locatie". "cutii_comanda" este o 
--colec?ie de tip tabel ?i va fi utilizat? pentru a stoca valorile coloanei "cutii" din tabela "contor_marfa", iar 
--"id_locatie" este o colec?ie de tip index-by (asociativ?) ?i va fi utilizat? pentru a stoca valorile coloanei
--"locatie_id" din tabela "contor_marfa". Cursorul "c_marfa_ianuarie" selecteaz? toate ?nregistr?rile din tabela "marfa" 
--cu data de livrare ?n ianuarie. Apoi, ?n bucla FOR LOOP, se selecteaz? toate ?nregistr?rile din tabela "contor_marfa" 
--care au "marfa_id" egal cu id-ul ?nregistr?rii curente din cursorul "c_marfa_ianuarie". Valorile coloanei "cutii" ?i 
--"locatie_id" sunt stoacate ?n colec?iile "v_cutii" ?i "v_locatie_id", respectiv, folosind clauza "BULK COLLECT INTO".
--?n bucla FOR LOOP imbricat?, se itereaz? prin fiecare element din colec?ia "v_locatie_id" ?i se afi?eaz? num?rul de 
--cutii de marf? pentru fiecare loca?ie.




--7. Afisam pentru fiecare angajat, media ratingurilor primite. (2 cursoare)
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE proceduraex7 IS
  -- Cursor simplu pentru a itera prin fiecare angajat
  CURSOR c_angajati IS
    SELECT id_angajat, nume_angajat, prenume_angajat
    FROM angajati;
  
  -- Cursor parametrizat pentru a calcula media notelor primite de fiecare angajat
  CURSOR c_rating (p_id_angajat NUMBER) IS
    SELECT AVG(nota_acordata) AS media
    FROM rating
    WHERE id_angajat = p_id_angajat;

  -- Variabile pentru a stoca media notelor primite de fiecare angajat
  v_id_angajat angajati.id_angajat%TYPE;
  v_nume angajati.nume_angajat%TYPE;
  v_prenume angajati.prenume_angajat%TYPE;
  v_media_rating rating.nota_acordata%TYPE;
BEGIN
  -- Iteram prin fiecare angajat
  FOR r_angajati IN c_angajati LOOP
    v_id_angajat := r_angajati.id_angajat;
    v_nume := r_angajati.nume_angajat;
    v_prenume := r_angajati.prenume_angajat;

    -- Calculam media notelor primite de fiecare angajat
    OPEN c_rating(v_id_angajat);
    FETCH c_rating INTO v_media_rating;
    CLOSE c_rating;

    -- Afisam media notelor primite de fiecare angajat
    DBMS_OUTPUT.PUT_LINE('Angajatul ' || v_nume || ' ' ||  v_prenume || ' are media notelor primite: ' || v_media_rating);
  END LOOP;
END;
/

EXECUTE proceduraex7;
/


--In acest exemplu, am definit doua cursore: unul parametrizat ("c_angajati") si unul simplu ("c_rating"). Cursorul parametrizat itereaza prin 
--fiecare angajat din tabelul "angajati", in timp ce cursorul simplu calculeaza media notelor primite de fiecare angajat din tabelul "rating", 
--folosindu-se de parametrul "p_id_angajat" pentru a filtra datele. In interiorul buclei FOR, am declarat variabilele "v_id_angajat", "v_nume" 
--si "v_media_rating", pentru a stoca id-ul si numele angajatului si media notelor primite, respectiv. Am atribuit valorile corespunzatoare din 
--cursorul parametrizat "c_angajati" la aceste variabile, dupa care am deschis cursorul simplu "c_rating" si l-am folosit pentru a calcula media
--notelor primite de angajatul curent. Am extras apoi valoarea mediei notelor primite in variabila "v_media_rating", si am inchis cursorul simplu 
--"c_rating". Am afisat apoi media notelor primite de angajatul curent folosind functia DBMS_OUTPUT.PUT_LINE.
--Nota: Pentru a vedea output-ul in SQL*Plus sau alte aplicatii Oracle, trebuie sa activati output-ul folosind comanda "SET SERVEROUTPUT ON;".



--8. Toate comenzile online care se incadreaza in perioada de valabilitate a reducerii (data_plasare > data_inceput reducere). 
--Exceptii: pt un client nu gaseste nicio comanda plasata sau nicio reducere valabila.
CREATE OR REPLACE FUNCTION functieex8(
    p_id_client IN client.id_client%TYPE 
) RETURN comenzi_online.id_comanda%TYPE
IS
    v_data_sfarsit DATE;
    v_rezultat NUMBER;
    exceptie1 EXCEPTION;
    PRAGMA EXCEPTION_INIT(exceptie1,-20001); 
    exceptie2 EXCEPTION;
    PRAGMA EXCEPTION_INIT(exceptie2,-20002); 
    exceptie3 EXCEPTION;
    PRAGMA EXCEPTION_INIT(exceptie3,-20003); 
BEGIN
    -- Check if the client ID exists in the CLIENT table
    SELECT COUNT(*)
    INTO v_rezultat
    FROM CLIENT
    WHERE id_client = p_id_client;
    
    IF v_rezultat = 0 THEN
        -- raise exception when no record is found for given client ID
        RAISE exceptie3;
    ELSIF v_rezultat >1 THEN
        -- raise exception when more than one record is found for given client ID
        RAISE exceptie2;
    END IF;

    -- calculate the end date of the discount period
    SELECT ADD_MONTHS(data_inceput, perioada_valabilitate * 12) INTO v_data_sfarsit
    FROM reducere
    WHERE id_client = p_id_client;
        
    -- if no discount record is found for the given client ID, raise an exception
    IF v_data_sfarsit IS NULL THEN
        RAISE exceptie1;
    END IF;
    
    -- Extract the online orders of the client that fall within the discount period
    SELECT COUNT(co.id_comanda)
    INTO v_rezultat
    FROM client c
    LEFT JOIN reducere r ON c.id_client = r.id_client 
    LEFT JOIN comenzi_online co ON c.id_client = co.id_client
    WHERE c.id_client = p_id_client AND co.data_plasare BETWEEN r.data_inceput AND v_data_sfarsit;
    
    IF v_rezultat = 0 THEN
        -- If no online orders are found for the given client, raise an exception
        RAISE exceptie1;
    END IF;
    
    RETURN v_rezultat;
    
EXCEPTION
    WHEN exceptie1 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista nicio comanda plasata pentru clientul dat');
        RETURN 0;
    WHEN exceptie2 THEN
        DBMS_OUTPUT.PUT_LINE('Exista mai multi clienti cu acelasi id in baza de date');
        RETURN 0;
    WHEN exceptie3 THEN
        DBMS_OUTPUT.PUT_LINE('Clientul dat nu exista in baza de date');
        RETURN 0;
    -- Other exceptions
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('A aparut o eroare: ' || SQLERRM);
        RETURN 0;
END functieex8;
/ 


select* from client;
select functieex8(61) from dual;
select functieex8(1) from dual;
select functieex8(63) from dual;
select functieex8('40') from dual;

SET SERVEROUTPUT ON;





--9. Fie dat numele unui angajat. Sa se afiseze toate contractele pe care le are,  ratingul si oysho ul la care lucreaza 
--(tara oras + nume magazin).  Vom folosi tabelele locatie,rating, oysho, contract,angajati. Exceptii: sa nu existe numele angajatului 
--dat, sa nu aiba rating, mai multi angajati cu acelasi nume
CREATE OR REPLACE PROCEDURE proceduraex9(p_nume_angajat angajati.nume_angajat%TYPE)
IS
    v_id_contract CONTRACT.id_contract%TYPE;
    v_tara OYSHO.tara%TYPE;
    v_oras OYSHO.oras%TYPE;
    v_nota RATING.nota_acordata%TYPE;
    v_nume_magazin LOCATIE.nume_magazin%TYPE;
    v_rezultat NUMBER;
    v_id NUMBER;
    v_rez NUMBER;
    exceptie1 EXCEPTION;
    PRAGMA EXCEPTION_INIT(exceptie1,-20001);

BEGIN

    SELECT id_angajat
    INTO v_id
    FROM ANGAJATI
    WHERE p_nume_angajat = nume_angajat;
    
    SELECT COUNT(*)
    INTO v_rezultat
    FROM ANGAJATI
    WHERE id_angajat = v_id;
    
    SELECT COUNT(*)
    INTO v_rez
    FROM RATING
    WHERE id_angajat = v_id;
    
    IF v_rezultat = 0 THEN
        RAISE NO_DATA_FOUND;
    ELSIF v_rezultat >1 THEN
        RAISE TOO_MANY_ROWS;
    ELSIF v_rez = 0 THEN
        RAISE exceptie1;
    END IF;
    
    SELECT a.id_angajat , c.id_contract , r.nota_acordata , o.tara , o.oras , l.nume_magazin 
    INTO v_id, v_id_contract, v_nota, v_tara, v_oras, v_nume_magazin
    FROM ANGAJATI a
    LEFT JOIN RATING r ON a.id_angajat = r.id_angajat
    LEFT JOIN CONTRACT c ON c.id_angajat = a.id_angajat
    RIGHT JOIN OYSHO o ON o.id_oysho = c.id_oysho
    LEFT JOIN LOCATIE l ON o.id_oysho = l.id_oysho
    WHERE a.nume_angajat = p_nume_angajat;
    
    DBMS_OUTPUT.PUT_LINE('Angajatul cu numele ' || p_nume_angajat || ' are contractul ' || v_id_contract || ', rating-ul ' || v_nota || ' si lucreaza in magazinul ' ||  v_nume_magazin || ', din tara ' || v_tara || ', orasul ' || v_oras);
EXCEPTION
  
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE( 'Nu exista inregistrari pentru angajatul dat');
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Exista mai multi angajati cu acelasi nume');
  WHEN exceptie1 THEN
    DBMS_OUTPUT.PUT_LINE('Angajatul dat nu a primit niciun rating');
 
END proceduraex9;
/

EXECUTE proceduraex9('Florea');
EXECUTE proceduraex9('Grigore');
EXECUTE proceduraex9('Ceausu');

select* from rating;
select* from angajati;




--10. Un trigger care sa permita lucrul asupra tabelului CONTRACT doar in intervalul 8-18, 
--de luni pana sambata.
CREATE OR REPLACE TRIGGER triggerex10
    BEFORE INSERT OR UPDATE OR DELETE ON CONTRACT 
BEGIN
    IF (TO_CHAR(SYSDATE, 'D') = 1) OR (TO_CHAR(SYSDATE,'HH24') NOT BETWEEN 8 AND 18)
    THEN
    RAISE_APPLICATION_ERROR(-20001, 'Tabelul nu poate fi actualizat in afara orelor de lucru!');
    END IF;
END;
/


UPDATE CONTRACT
SET tip_contract = 'angajat';



--11. Un trigger care sa nu permita ca reducerea unui client sa depaseasca 50%
CREATE OR REPLACE TRIGGER triggerex11
    BEFORE UPDATE OF procent ON REDUCERE
    FOR EACH ROW
    WHEN ( NEW.procent >50 )
BEGIN
    RAISE_APPLICATION_ERROR(-20002, 'Procentul de reducere nu poate depasi 50%!');
END;
/
UPDATE REDUCERE
SET procent = procent + 50;




--12. Trigger dintr-o comanda LDD 
CREATE TABLE erori (nume_bd VARCHAR2(50),
                    user_logat VARCHAR2(30),
                    data TIMESTAMP(3),
                    eroare VARCHAR2(2000));
                    
CREATE OR REPLACE TRIGGER triggerex12
    AFTER SERVERERROR ON SCHEMA
BEGIN
    INSERT INTO ERORI
    VALUES (SYS.DATABASE_NAME, SYS.LOGIN_USER, SYSTIMESTAMP, DBMS_UTILITY.FORMAT_ERROR_STACK);
END;
/

CREATE TABLE a (ID NUMBER (2));
INSERT INTO a VALUES (123);
ALTER TABLE a DROP (b);

SELECT* FROM erori;
                    
