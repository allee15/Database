--6
select title_id, copy_id, status, (select
                                    CASE WHEN count(*) > 0
                                    THEN 'RENTED'
                                    ELSE
                                        'AVAILABLE'
                                    END    
                                    from rental 
                                    where title_id = t.title_id and exp_ret_date > sysdate) 
from title_copy t;

--7a
select count(*)
from rental re, title ti, title_copy tc
where nvl2(re.act_ret_date, 'AVAILABLE', 'RENTED') != tc.status and re.copy_id = tc.copy_id and (ti.title_id = tc.title_id);

--7b
create table title_copy_aa as SELECT * FROM title_copy;
select * from user_constraints where table_name = 'title_copy_aa';
select * from title_copy_aa;
with tabela as(select distinct res.title_id, res.res_date, r.book_date
from reservation res
join rental r on (r.title_id = res.title_id and r.member_id = res.member_id)
where res.res_date = r.book_date)
select count(*)
from tabela;

--8
SELECT m.last_name, m.first_name, t.title as Titlu
FROM member m, title t
JOIN rental r ON (t.title_id = r.title_id)
WHERE  m.member_id = r.member_id;

--9
WITH tabela as (SELECT m.last_name, m.first_name, t.title, m.member_id, t.title_id
                FROM member m, title t
                JOIN rental r ON (t.title_id = r.title_id)
                WHERE  m.member_id = r.member_id)
SELECT DISTINCT CONCAT(CONCAT(ta.last_name,' '), ta.first_name) as Nume, ta.title as Film,  (select count(*)
                                                                                            from rental
                                                                                            where ta.member_id = member_id and ta.title_id = title_id) as Nr_imprumutari
FROM tabela ta
ORDER BY 3 DESC;

--10
WITH tabela as (SELECT m.last_name, m.first_name, t.title, m.member_id, t.title_id, tc.copy_id
                FROM member m, title t
                JOIN rental r ON (t.title_id = r.title_id)
                JOIN title_copy tc ON (tc.title_id = t.title_id )
                WHERE  m.member_id = r.member_id and r.copy_id = tc.copy_id)
SELECT DISTINCT CONCAT(CONCAT(ta.last_name,' '), ta.first_name) as Nume, ta.title as Film, ta.copy_id as Cod,  (SELECT COUNT(*)
                                                                                                                FROM rental
                                                                                                                WHERE ta.member_id = member_id and ta.title_id = title_id and ta.copy_id = copy_id) as Nr_imprumutari
FROM tabela ta
ORDER BY 1,3 DESC;

--11
WITH nr_imp as (SELECT title_id, copy_id, COUNT(*) as numar_imprumuturi
                        FROM rental r
                        GROUP BY title_id, copy_id
                        HAVING COUNT(*) = (SELECT MAX(numar_imprumuturi)
                                            FROM (SELECT title_id, copy_id, COUNT(*) as numar_imprumuturi
                                                    FROM rental
                                                    GROUP BY title_id, copy_id) maxim
                                            WHERE r.title_id = maxim.title_id
                                            GROUP BY r.title_id
                                            )
                        )
SELECT UNIQUE tc.title_id as ID,tc.copy_id, n.numar_imprumuturi as Numar, tc.status as Status
FROM title_copy_aa tc, nr_imp n
WHERE tc.title_id = n.title_id and n.copy_id = tc.copy_id
ORDER BY 1;  

--12a
SELECT to_char(act_ret_date, 'dd') ziua, COUNT(act_ret_date) imprumuturi
FROM rental
WHERE to_char(act_ret_date, 'dd-mm-yyyy') = '01-' || to_char(sysdate, 'mm-yyyy') 
     OR to_char(act_ret_date, 'dd-mm-yyyy') = '02-' || to_char(sysdate, 'mm-yyyy')
GROUP BY act_ret_date;

--b
SELECT to_char(act_ret_date, 'dd') ziua, count(act_ret_date) imprumuturi
FROM rental
WHERE to_char(act_ret_date, 'mm-yyyy') = to_char(sysdate, 'mm-yyyy') 
GROUP BY act_ret_date;


--c
SELECT to_char(zi_luna, 'dd') ziua,(SELECT COUNT(act_ret_date)
                                    FROM rental
                                    WHERE act_ret_date = zi_luna) imprumuturi
FROM (SELECT to_date('01-' || to_char(sysdate, 'mon-yyyy')) + level - 1 zi_luna
      FROM dual
      CONNECT BY LEVEL <= TO_DATE('01-' || TO_CHAR(sysdate + 31, 'mon-yyyy')) - TO_DATE('01-' || to_char(sysdate, 'mon-yyyy'))
     )
group by zi_luna
order by ziua;
