select sysdate from dual;

select sysdate,sysdate+1,add_months(sysdate,1) from dual;

--�״��� ������ ���ڸ� �˷���
select last_day(sysdate) from dual;

select last_day('2022-01-01') from dual;

--��¥���� �⵵,��,�ϸ� ���
select extract(year from sysdate) from dual;
select extract(month from sysdate) from dual;
select extract(day from sysdate) from dual;

-- ��¥���� ��¥�� ���� �Ⱓ�� ���� �˼� ����.
select bdate,trunc(sysdate-bdate)||'��' from board;

-- ���� �������� ���
select  bdate,trunc(months_between(sysdate,bdate))||'����' from board;

--��¥-->���ڷ� ����ȯ,��¥���� ����
select sysdate from dual;
select to_char(sysdate,'YYYY-MM-DD AM HH:MI:SS') from dual;

select to_char(sysdate,'YYYY"��"MM"��"DD"��"DAY') from dual;

--����->���ڷ� ����ȯ,õ����ǥ��,��ȭ ǥ��
--9�� �ڸ��� ǥ�ø� �ϸ� , �������� �����,0���� �ڸ��� ǥ�ø� �ϸ�, ������ 0���� ��µ�.
select 1234500000 from dual;
select to_char(1234500000,'999,999,999,999')from dual; --�����
select trim(to_char(1234500000,'999,999,999,999'))from dual; --���������
select to_char(1234500000,'000,999,999,999')from dual; --0���� ǥ��
select to_char(1234500000,'L999,999,999,999')from dual;--��ȭǥ�� L, $
select '2023-10-01' from dual;

--1���� �߰��� ��¥ ���
select add_months('2023-10-27',1) from dual;
select sysdate -to_date('2023-10-01','YYYY-MM-DD') from dual;

-- nvl(commision_pct,0)
-- manager_id null���� 'ceo'
select manager_id from employees;

-- manager_id Ÿ�� : number
select nvl(manager_id,0) from employees;

-- ���� -> ���� ����ȯ 'ceo' ���ڸ� �Է�
select nvl(to_char(manager_id), 'ceo') from employees;
select manager_id from employees where manager_id is null; -- ȥ�� �� ��

-- ���� �ѱݾ� - õ����, $
select sum(salary) from employees;
select to_char(sum(salary),'$999,999,999') from employees;

-- ��� ���� - ȯ�� 1342.32 ���ؼ� õ����, \ ǥ��
select avg(salary) from employees;
select to_char(avg(salary)*1342.32,'L999,999,999,999') from employees;

select max(salary),min(salary) from employees;

select department_id from employees;

select emp_name,max(salary) from employees
where department_id =50
group by emp_name;

select emp_name,salary from employees
where salary = (select max(salary) from employees);

select department_id,max(salary),min(salary) from employees
group by department_id;

select emp_name,max(salary) from employees
group by emp_name;

select emp_name,salary from employees;

--count(*)
select count(*) from employees;

--null���� count ���� ����.
select count(manager_id) from employees;

select id from board;

select emp_name from employees;

select emp_name from employees
where emp_name like('%D%') or emp_name like('%d%');

--�ҹ��ڷ� ������ d�� �˻�
select emp_name from employees
where lower(emp_name) like('%d%');

--������� 0����ǥ��
select to_char(12,'000,000')from dual;
select lpad(12,6,'0') from dual;
select rpad(12,6,'0') from dual;

select id from board;
select substr(id,3,3) from board;
select bdate from board;

--20230816
select to_char(bdate,'YYYYMMDD') from board;
select substr(to_char(bdate,'YYYYMMDD'),1,6) from board;

select id from board;
select id,instr(id,'ha') from board
where instr(id,'ha') !=0;

select length(id) from board;

--hire_date employees;
--substr ���� ����Ͻÿ�.
select hire_date from employees;
select substr(hire_date,4,2) from employees;

--�̸����� 3���� 3���� ���� �Բ� ����Ͻÿ�.
-- aaa06
select substr(emp_name,3,3)||substr(hire_date,4,2) from employees;

--������ ��¥ last_day(
select hire_date,last_day(hire_date) from employees;

select * from emp01;

--���̺� �����Ǹ鼭 ��� ������ �߰�
create table fboard as select*from board;

select bhit,bhit+100 from board;

update board
set bhit = bhit+100;

select bno,bhit from board;

rollback;

update board
set bhit = bhit+1
where bno = 31;

update fboard
set bhit =1;

select a.bno,a.bhit,b.bno,b.bhit from fboard a,board b;
commit;

select bno,bhit from board;

update fboard a
set bhit = (select bhit from board b where a.bno=b.bno);

desc fboard;

alter table fboard
add userid varchar2(30)
;

select userid from fboard;

--id 1��°���� 3��, bdate ���� ��ģ ���� userid�� �Է��Ͻÿ�.
select substr(id,1,3)||substr(bdate,4,2) from fboard;

update fboard a
set userid =(
select substr(id,1,3)||substr(bdate,4,2) from fboard b where a.bno=b.bno
)
;

--���̺� ���� �� ������ ����
create table emp2 as select * from employees;


--���̺� �÷� Ÿ�� ����--
alter table fboard
modify uuid varchar(40);

--���̺�� ����
--rename emp2 to emp02;
--���̺� ����
--drop table emp01;
--drop table emp2;

--���̺� �÷� �߰�--
alter table fboard
add u_id varchar2(30);

--���̺� �÷� ����--
alter table fboard
drop column uuid;

desc member 

create table mem(
id varchar2(30)primary key, -- not null, unique
pw varchar2(30) not null, --null�� ���ȵ�
name varchar2(30) not null,
phone varchar2(6),
gender varchar2(1) check(gender in('M','F')),--M,F
hobby varchar2(80),
mlevel number(2) check(mlevel between 1 and 10),--1~10���� ���� ����
mdate date default sysdate-- �Է����� ������ ���� ��¥ ���
);

alter table mem
modify phone varchar2(13);

insert into mem values(
'aaa','1111','ȫ�浿','010-1111-1111','M','game',1,sysdate
);

insert into mem(id,pw,name) values(
'bbb','1111','������'
);

insert into mem(id,pw,name,gender) values(
'ccc','2222','�̼���','M'
);

select * from mem;

commit;

select * from member;

desc member;

--����Ŭ switch if ���ǹ�
--decode ���� ���� ��츸 �� ������.
select * from employees;

select department_id from employees;

select department_id,department_name from departments;

--10 �ѹ���ȹ�� 20 ������ 30 ����/����� 40 �λ�� 50�� �ۺ�
select department_id from employees;

--decode ���ǹ�
select department_id,
decode(department_id,
10,'�ѹ���ȹ��'
,20,'������'
,30,'����/�����',
40,'�λ��',
50,'��ۺ�'
)
from employees;

--���̺� ����
select a.department_id,a.department_name
from departments a, employees b
where a.department_id = b.department_id;

--�л����� ���̺�
create table sscore(
sno number(4)primary key, -- ������ �����Ǵ� ����
sid varchar2(20),
total number(3) default 0
);

commit;

insert into sscore values(
sscore_seq.nextval,'a1',50
);

insert into sscore values(
sscore_seq.nextval,'a2',90
);

insert into sscore values(
sscore_seq.nextval,'a3',80
);

insert into sscore values(
sscore_seq.nextval,'a4',10
);

insert into sscore values(
sscore_seq.nextval,'a5',100
);

insert into sscore values(
sscore_seq.nextval,'a6',70
);

insert into sscore values(
sscore_seq.nextval,'a7',60
);

insert into sscore values(
sscore_seq.nextval,'a8',30
);

insert into sscore values(
sscore_seq.nextval,'a9',20
);

insert into sscore values(
sscore_seq.nextval,'a10',80
);

commit;
select * from sscore;

select sno,sid,total,decode(total,
10,'F',
20,'F',
30,'F',
40,'F',
50,'F',
60,'F',
70,'D',
80,'B',
90,'A',
100,'A'
) as hak from sscore;

select avg from stuscore;

select avg,
case 
when avg>=90 then 'A'
when avg>=80 then 'B'
when avg>=70 then 'C'
when avg>=60 then 'D'
when avg<60 then 'F'
end as hak
from stuscore;

--������ 3000�̸� E��� 4000~5000 D���,6000~8000 C���, 9000~10000 B���,10000�̻� A������� ����Ͻÿ�.
--employees salary
select salary,
case
when salary<3000 then 'E'
when salary>=3000 then 'D'
when salary>=5001 then 'C'
when salary>=8001 then 'B'
when salary>=10000 then 'A'
end rank2
from emp02;

select salary,salary+1000 from emp02;

alter table emp02
add rank varchar2(10);

update emp02 a
set rank = ( 
select 
case
when salary<3000 then 'E'
when salary>=3000 then 'D'
when salary>=5001 then 'C'
when salary>=8001 then 'B'
when salary>=10000 then 'A'
end rank2
from emp02 b where a.employee_id = b.employee_id
);

select salary,rank from emp02;

-- ����߿� ��տ��� ���Ϸ� �޴� ����� ����Ͻÿ�.
select emp_name,salary from employees
where salary <=(select avg(salary) from employees);

select bhit,bhit+100 from fboard;

update fboard
set bhit = bhit+100;

commit;

select bno,bhit from fboard;

select bno,bhit from board;

--��ȹ

drop table fboard;

--���̺� ���� �� ����
create table fboard as select * from board;

select bhit from fboard;
select bhit from board;

select a.bhit,b.bhit from fboard a,board b
where a.bno=b.bno;

select bno,bhit from board;

--�����ڵ�
update fboard a
set bhit =(
select bhit from board b where a.bno = b.bno
);

desc member;

create table nboard(
bno number(4) primary key,
id varchar2(20),
btitle varchar2(1000) not null,
bcontent varchar2(4000),
bdate date,
constraint fk_nboard foreign key(id) references member(id)
--�ܷ�Ű ��� �̸�fk_nboard
);

select * from nboard;

select * from member;

--id:�ܷ�Ű - member primary key -> �ߺ��ȵ�, null ���µ����� �Է��ϰ� �Ǹ� ����
insert into nboard values(
nboard_seq.nextval,'aaa','����8','����8',sysdate
);

commit;

select * from nboard;
select * from member;

delete member
where id ='ddd';

select * from member;

select * from nboard;

--�ܷ�Ű�� ���, primary key ���̺��� �����Ͱ� �����Ǹ� �ܷ�Ű�� �ִ� �����͵� ��� ����ó��
alter table nboard
add constraint fk_nboard foreign key(id) references member(id)
on delete cascade;


-- primary key ���̺��� �����Ͱ� �����Ǹ� �ܷ�Ű�� �ִ� �������� id�� null������ ����
alter table nboard
add constraint fk_nboard_id foreign key(id) references member(id)
on delete set null;

alter table nboard
drop constraint fk_nboard;

delete member
where id='aaa';

select * from nboard;

--null���� ������ row�� �˻��� �� �׷��Լ��� �����ؼ� ���
select department_id,count(commission_pct) 
from employees
where commission_pct is not null
group by department_id 
;


--�׷��Լ����� �׷��Լ��� ���� ������ ó���Ϸ��� having ��ɾ ����ؾ���.
select department_id,count(commission_pct) 
from employees
group by department_id
having count(commission_pct)!=0
;


--1.�μ��� ����� ����Ͻÿ�.
select department_id,round(avg(salary),2) 
from employees
group by department_id
;

--2.��ü ����� ����Ͻÿ�.
select round(avg(salary),2) from employees;

--�μ����� ����� ��ü��� �̻��� ���޸� ����Ͻÿ�.
select a.department_id,b.department_name,round(avg(salary),2) 
from employees a,departments b
where a.department_id = b.department_id
group by a.department_id,b.department_name
having round(avg(salary),2)>(select round(avg(salary),2) from employees);


