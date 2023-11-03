select rownum,bno,btitle,bcontent,bdate
from board
order by bno
;

select * from(select ROW_NUMBER() OVER (ORDER BY bno desc)as rnum,bno,btitle,bcontent,bdate
from board where bcontent like '%sum%')a
where a.rnum>=11 and a.rnum<=20
;

select *from(select ROW_NUMBER() OVER (ORDER BY bno desc)as rnum,bno,btitle,bcontent,bdate from board where bcontent like '%sum%')a 
where a.rnum>=31 and a.rnum<=40;


select * from board
where bno=1;


select *from(select ROW_NUMBER() OVER (ORDER BY bno desc)as rnum,bno,btitle,bcontent,bdate 
from board)a where a.rnum>=81 and a.rnum<=90;