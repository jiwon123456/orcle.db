select * from member;

select * from member
where id='bbb' and pw='1111'
;

select * from board;

--board

select * from board;

--sum ���ڸ� ����Ͻÿ�.bcontent
select rownum ,a.* 
from(select * from board where bcontent like '%sum%' order by bno)a
where rownum>=11 and rownum<=20
;

select * from 
(
select row_number()over(order by bno)rnum,a.*
from board a
where bcontent like '%sum%'
)b
where b.rnum>=11 and b.rnum<=20
;

select * from board
where bcontent like '%sum%'
order by bno
;
