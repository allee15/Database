--1.S? se afi?eze denumirea primei excursii achizitionate.  
SELECT e.denumire
FROM excursie e 
WHERE e.id_excursie =(SELECT cod_excursie 
                        FROM achizitioneaza
                        WHERE data_achizitie=(SELECT MIN(data_achizitie) FROM achizitioneaza));
                        
--2.Afi?a?i de câte ori a fost achizi?ionat? fiecare excursie.                       
SELECT  e.denumire, e.id_excursie ,(SELECT count(a.cod_excursie) 
                                    FROM achizitioneaza a 
                                    WHERE a.cod_excursie=e.id_excursie ) AS"numar achizitii"
FROM excursie e ;


--3.S?  se  afi?eze  pentru  fiecare  agen?ie,  denumirea,  ora?ul,  num?rul  de  excursii  oferite, media pre?urilor excursiilor oferite. 
SELECT ag.denumire, ag.oras, (SELECT count(e.cod_agentie) 
                              FROM excursie e
                              WHERE e.cod_agentie=ag.id_agentie) AS "numar excursii"
FROM agentie ag;

--4a S? se ob?in? numele ?i prenumele turi?tilor care au achizi?ionat cel pu?in 2 excursii.
SELECT nume,prenume
FROM turist t 
WHERE (SELECT count(cod_turist)
        FROM achizitioneaza
        WHERE(cod_turist=t.id_turist))>=2;

--b S? se ob?in? num?rul turi?tilor care au achizi?ionat cel putin 2 excursii. 
SELECT count(*)
FROM turist t 
WHERE (SELECT count(cod_turist)
        FROM achizitioneaza
        WHERE(cod_turist=t.id_turist))>=2;

--5 Afi?a?i informa?ii despre turi?tii care nu au achizi?ionat excursii cu destina?ia Paris. 
SELECT *
FROM turist t 
WHERE 'paris' IN ( SELECT lower(destinatie)
                    FROM excursie e  
                        JOIN achizitioneaza a ON (a.cod_excursie= e.id_excursie)
                    WHERE a.cod_turist=t.id_turist);

--6 Afi?a?i  codul ?i  numele  turi?tilor  care  au  achizi?ionat  excursii  spre  cel  pu?in  dou?destina?ii diferite.
SELECT *
FROM turist t 
WHERE  ( SELECT count(distinct e.destinatie)
                    FROM excursie e   
                        JOIN achizitioneaza a ON (a.cod_excursie= e.id_excursie)
                    WHERE a.cod_turist=t.id_turist)>=2;

--7 S? se afi?eze pentru fiecare agen?ie, denumirea ?i profitul ob?inut. (Profitul ob?inut din vânzarea  unei  excursii  este pret  –  pret  *  discount Dac?  discountul  este  necunoscut profitul este pre?ul excursiei). 
SELECT sum(ex.pret - ex.pret*NVL(achiz.discount,0)) AS "profit", (SELECT denumire FROM agentie WHERE id_agentie=ex.cod_agentie)
FROM agentie ag JOIN excursie ex ON(ag.id_agentie = ex.cod_agentie)
                JOIN achizitioneaza  achiz  ON(ex.id_excursie=achiz.cod_excursie)
GROUP BY(ex.cod_agentie);

--8 S? se afi?eze denumirea ?i ora?ul pentru agen?iile care au cel pu?in 3 excusii oferite la un pre? mai mic dec?t 2000 euro. 
SELECT ag.oras
FROM agentie ag
WHERE (SELECT count(ex.cod_agentie)
        FROM excursie ex 
        WHERE ex.cod_agentie=ag.id_agentie AND ex.pret<2000)>=3;

--9 S? se afi?eze excursiile care nu au fost achizi?ionate de c?tre nici un turist.
SELECT * 
FROM excursie
WHERE id_excursie NOT IN(SELECT achizitioneaza.cod_excursie
                            FROM achizitioneaza);

--10 Afi?a?i  informa?ii  despre  excursii,  inclusiv  denumirea  agen?iei.  Pentru  excursiile pentru care nu este cunoscut? agen?ia se va afi?a textul “agentie necunoscuta”. 
SELECT denumire,destinatie,durata,nr_locuri,pret, decode(ex.cod_agentie ,NULL,'nu se cunoaste', (SELECT denumire 
                                                                                                    FROM agentie 
                                                                                                    WHERE id_agentie= cod_agentie)) AS "Agentie"
FROM excursie ex;

--11 S?  se  afi?eze  informa?ii  despre  excursiile  care  au  pre?ul  mai  mare  dec?t  excursia  cu denumirea “Orasul luminilor” existent? în oferta agen?iei cu codul 10. 
SELECT * 
FROM excursie
WHERE pret > (SELECT pret
                FROM excursie
                WHERE cod_agentie=10 AND denumire='Orasul luminilor');

--12 S?  se  ob?in?  lista  turi?tilor  care  au  achizi?ionat  excursii  cu  o  durata  mai  mare  de  10 zile. (se va lua în considerare data_start ?i data_end)
SELECT *
FROM turist
WHERE id_turist IN (SELECT cod_turist 
                    FROM achizitioneaza
                    WHERE (data_end-data_start)>=10);


