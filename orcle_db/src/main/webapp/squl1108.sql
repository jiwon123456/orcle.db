select * from member;

drop table fboard;

desc member;


select * from member;

select * from member
where id='aaa' and pw='1111'
;

select count(*) as lcheck from member
where id='aaa' and pw='1111'
;

select * from employees;

select * from departments;

select employee_id, emp_name, salary, salary*12+(salary*12*nvl(commission_pct,0)) year_salary, nvl(to_char(a.department_id),'CEO') department_id,
nvl(department_name,'CEO'),hire_date 
from employees a, departments b
where a.department_id = b.department_id(+);

--��ȣ 11-20 ��ȣ,����,�ۼ���,�ۼ���,��ȸ��
select rownum rnum,a.*from board a
where btitle like '%ia%'
order by bgroup desc, bstep asc;

select * from 
(select row_number() over(order by bgroup desc, bstep asc) rnum, bno,btitle,id,bdate,bhit from board 
where btitle like '%ia%')a
where a.rnum>=11 and  a.rnum<=20
;

create table mem (
id varchar2(20) primary key,
pw varchar2(20),
name varchar2(20),
phone varchar2(20),
gender varchar2(6),
hobby varchar2(80)
)
;

insert into mem values(
'aaa','1111','ȫ�浿','010-1111-1111','Male','game,golf,run'
)
;

insert into mem values(
'bbb','1111','������','010-2222-2222','Female','golf,run'
)
;

insert into mem values(
'ccc','1111','�̼���','010-3333-3333','Male','cook,book'
)
;

commit;

select * from mem;

--�÷� �߰�
alter table mem add mdate date;

desc mem;

update mem
set mdate = sysdate;

select * from mem;

commit;