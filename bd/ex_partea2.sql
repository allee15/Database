--13 S? se ob?in? excusiile achizi?ionate de cel pu?in un turist vârsta mai mic? de 30 de ani.
SELECT *
FROM excursie
WHERE id_excursie IN (SELECT achiz.cod_excursie
                    FROM achizitioneaza  achiz JOIN turist tur ON(tur.id_turist=achiz.cod_turist)
                    WHERE sysdate-tur.data_nastere<30*365); 
--data curenta
SELECT to_date((to_char(sysdate, 'dd-mm-yy')),'dd-mmm-yy')
FROM dual;

--14 S?  se  ob?in?  turi?tii  care  nu  au  achizi?ionat  nicio  excursie  oferit?  de  agen?ii  din Bucuresti. 
SELECT achiz.cod_turist
FROM agentie ag JOIN excursie ex ON(ag.id_agentie = ex.cod_agentie)
                JOIN achizitioneaza  achiz  ON(ex.id_excursie=achiz.cod_excursie)
WHERE ag.oras!='Bucuresti' AND achiz.cod_turist NOT IN (SELECT achiz.cod_turist
                                                            FROM agentie ag JOIN excursie ex ON(ag.id_agentie = ex.cod_agentie)
                                                                            JOIN achizitioneaza  achiz  ON(ex.id_excursie=achiz.cod_excursie)
                                                            WHERE ag.oras='Bucuresti' );

--15 S? se ob?in? numele turi?tilor care au achizi?ionat excursii care con?in în denumire “1 mai”  de la o agen?ie din Bucure?ti.          
SELECT tur.* 
FROM turist tur JOIN achizitioneaza  achiz ON (tur.id_turist=achiz.cod_turist)
             JOIN excursie  ex  ON(ex.id_excursie=achiz.cod_excursie)
             JOIN agentie ag ON(ag.id_agentie = ex.cod_agentie)
WHERE ag.oras='Bucuresti' AND (lower(ex.denumire) like ('%1 mai%'));

--16 S?  se ob?ina numele,  prenume turi?tilor ?i excursiile oferite de agen?ia  “Smart Tour” achizi?ionate de c?tre ace?tia. 
SELECT tur.*, ex.* 
FROM turist tur JOIN achizitioneaza  achiz ON (tur.id_turist=achiz.cod_turist)
             JOIN excursie  ex  ON(ex.id_excursie=achiz.cod_excursie)
             JOIN agentie ag ON(ag.id_agentie = ex.cod_agentie)
WHERE lower(ag.denumire)='smart tour' 
ORDER BY tur.id_turist;

--17 S?  se  afi?eze  excursiile  pentru  care  nu  mai  exist?  locuri  pentru  data  de  plecare  14  -aug-2011.
SELECT *
FROM excursie ex JOIN achizitioneaza  achiz  ON(ex.id_excursie=achiz.cod_excursie)
WHERE  to_char(achiz.data_start)='14-AUG-11' and ex.nr_locuri=0;

--18 S? se ob?in? codurile turi?tilor ?i codul ultimei excursii achizi?ionate de c?tre ace?tia. 
SELECT tur.id_turist, ex.id_excursie
FROM excursie ex JOIN achizitioneaza  achiz  ON(ex.id_excursie=achiz.cod_excursie)
                JOIN turist tur ON(tur.id_turist=achiz.cod_turist)
WHERE achiz.data_achizitie=(SELECT max(data_achizitie)
                            FROM achizitioneaza
                                GROUP BY(cod_turist)
                                HAVING cod_turist=tur.id_turist);

--19 Afi?a?i topul celor mai scumpe excursii (primele 5). 
SELECT *
FROM(SELECT  *
    FROM excursie
    ORDER by pret DESC)
WHERE ROWNUM >= 1 AND ROWNUM <=5;

--20 Afi?a?i  numele  turi?tilor  care  au  achizi?ionat  excursii  cu  data  de  plecare  în  aceea?i luna cu luna în care î?i serbeaz? ziua de na?tere. 
SELECT * 
FROM excursie ex JOIN achizitioneaza  achiz  ON(ex.id_excursie=achiz.cod_excursie)
                JOIN turist tur ON(tur.id_turist=achiz.cod_turist)
WHERE to_char(tur.data_nastere, 'Month')=to_char(achiz.data_achizitie, 'Month');

--24 Afi?a?i excursiile care au fost achizi?ionate de to?i turi?tii în vârsta de 24 ani.
SELECT ex.*, tur.*
FROM excursie ex JOIN achizitioneaza  achiz  ON(ex.id_excursie=achiz.cod_excursie)
                JOIN turist tur ON(tur.id_turist=achiz.cod_turist)
WHERE to_char(tur.data_nastere,'yy')='98' AND to_number(to_char(tur.data_nastere,'mm'))>= to_number(to_char(sysdate,'mm')) AND to_number(to_char(tur.data_nastere,'dd'))>= to_number(to_char(sysdate,'dd'));

--26 S?  se  ob?in?  pentru  fiecare  agen?ie  media  pre?urilor  excursiilor  oferite  de  agen?iile concurente (situate în acela?i ora?). 
SELECT ag.oras, ag.denumire, (SELECT avg(ex.pret) 
                                FROM excursie ex  JOIN agentie agg ON(agg.id_agentie=ex.cod_agentie) 
                                WHERE agg.oras=ag.oras AND agg.id_agentie!=ag.id_agentie) AS "avg concurenta"
FROM agentie ag;

