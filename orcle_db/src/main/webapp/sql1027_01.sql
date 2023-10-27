select sysdate from dual;

select sysdate,sysdate+1,add_months(sysdate,1) from dual;

--그달의 마지막 일자를 알려줌
select last_day(sysdate) from dual;

select last_day('2022-01-01') from dual;

--날짜에서 년도,월,일만 출력
select extract(year from sysdate) from dual;
select extract(month from sysdate) from dual;
select extract(day from sysdate) from dual;

-- 날짜에서 날짜를 빼면 기간의 일을 알수 있음.
select bdate,trunc(sysdate-bdate)||'일' from board;

-- 지난 개월수를 출력
select  bdate,trunc(months_between(sysdate,bdate))||'개월' from board;

--날짜-->문자로 형변환,날짜포맷 변경
select sysdate from dual;
select to_char(sysdate,'YYYY-MM-DD AM HH:MI:SS') from dual;

select to_char(sysdate,'YYYY"년"MM"월"DD"일"DAY') from dual;

--숫자->문자로 형변환,천단위표시,원화 표시
--9로 자리수 표시를 하면 , 없을때는 빈공백,0으로 자리수 표시를 하면, 없을때 0으로 출력됨.
select 1234500000 from dual;
select to_char(1234500000,'999,999,999,999')from dual; --빈공백
select trim(to_char(1234500000,'999,999,999,999'))from dual; --빈공백제거
select to_char(1234500000,'000,999,999,999')from dual; --0으로 표시
select to_char(1234500000,'L999,999,999,999')from dual;--원화표시 L, $
select '2023-10-01' from dual;

--1달을 추가한 날짜 출력
select add_months('2023-10-27',1) from dual;
select sysdate -to_date('2023-10-01','YYYY-MM-DD') from dual;

-- nvl(commision_pct,0)
-- manager_id null값에 'ceo'
select manager_id from employees;

-- manager_id 타입 : number
select nvl(manager_id,0) from employees;

-- 숫자 -> 문자 형변환 'ceo' 글자를 입력
select nvl(to_char(manager_id), 'ceo') from employees;
select manager_id from employees where manager_id is null; -- 혼자 한 것

-- 월급 총금액 - 천단위, $
select sum(salary) from employees;
select to_char(sum(salary),'$999,999,999') from employees;

-- 평균 월급 - 환율 1342.32 곱해서 천단위, \ 표시
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

--null값은 count 되지 않음.
select count(manager_id) from employees;

select id from board;

select emp_name from employees;

select emp_name from employees
where emp_name like('%D%') or emp_name like('%d%');

--소문자로 변경후 d를 검색
select emp_name from employees
where lower(emp_name) like('%d%');

--빈공백을 0으로표시
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
--substr 월을 출력하시오.
select hire_date from employees;
select substr(hire_date,4,2) from employees;

--이름에서 3부터 3개와 월을 함꼐 출력하시오.
-- aaa06
select substr(emp_name,3,3)||substr(hire_date,4,2) from employees;

--마지막 날짜 last_day(
select hire_date,last_day(hire_date) from employees;

select * from emp01;

--테이블 생성되면서 모든 데이터 추가
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

--id 1번째부터 3개, bdate 월을 합친 값을 userid에 입력하시오.
select substr(id,1,3)||substr(bdate,4,2) from fboard;

update fboard a
set userid =(
select substr(id,1,3)||substr(bdate,4,2) from fboard b where a.bno=b.bno
)
;

--테이블 생성 및 데이터 복사
create table emp2 as select * from employees;


--테이블 컬럼 타입 변경--
alter table fboard
modify uuid varchar(40);

--테이블명 변경
--rename emp2 to emp02;
--테이블 삭제
--drop table emp01;
--drop table emp2;

--테이블 컬럼 추가--
alter table fboard
add u_id varchar2(30);

--테이블 컬럼 삭제--
alter table fboard
drop column uuid;

desc member 

create table mem(
id varchar2(30)primary key, -- not null, unique
pw varchar2(30) not null, --null값 허용안됨
name varchar2(30) not null,
phone varchar2(6),
gender varchar2(1) check(gender in('M','F')),--M,F
hobby varchar2(80),
mlevel number(2) check(mlevel between 1 and 10),--1~10사이 값만 가능
mdate date default sysdate-- 입력하지 않으면 현재 날짜 등록
);

alter table mem
modify phone varchar2(13);

insert into mem values(
'aaa','1111','홍길동','010-1111-1111','M','game',1,sysdate
);

insert into mem(id,pw,name) values(
'bbb','1111','유관순'
);

insert into mem(id,pw,name,gender) values(
'ccc','2222','이순신','M'
);

select * from mem;

commit;

select * from member;

desc member;

--오라클 switch if 조건물
--decode 같은 값인 경우만 비교 가능함.
select * from employees;

select department_id from employees;

select department_id,department_name from departments;

--10 총무기획부 20 마케팅 30 구매/생산부 40 인사부 50배 송부
select department_id from employees;

--decode 조건문
select department_id,
decode(department_id,
10,'총무기획부'
,20,'마켓팅'
,30,'구매/생산부',
40,'인사부',
50,'배송부'
)
from employees;

--테이블 조인
select a.department_id,a.department_name
from departments a, employees b
where a.department_id = b.department_id;

--학생성적 테이블
create table sscore(
sno number(4)primary key, -- 점수에 보여되는 순번
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

--월급이 3000미만 E등급 4000~5000 D등급,6000~8000 C등급, 9000~10000 B등급,10000이상 A등급으로 출력하시오.
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

-- 사원중에 평균월급 이하로 받는 사원을 출력하시오.
select emp_name,salary from employees
where salary <=(select avg(salary) from employees);

select bhit,bhit+100 from fboard;

update fboard
set bhit = bhit+100;

commit;

select bno,bhit from fboard;

select bno,bhit from board;

--계획

drop table fboard;

--테이블 생성 및 복사
create table fboard as select * from board;

select bhit from fboard;
select bhit from board;

select a.bhit,b.bhit from fboard a,board b
where a.bno=b.bno;

select bno,bhit from board;

--수정코드
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
--외래키 등록 이름fk_nboard
);

select * from nboard;

select * from member;

--id:외래키 - member primary key -> 중복안됨, null 없는데이터 입력하게 되면 에러
insert into nboard values(
nboard_seq.nextval,'aaa','제목8','내용8',sysdate
);

commit;

select * from nboard;
select * from member;

delete member
where id ='ddd';

select * from member;

select * from nboard;

--외래키로 등록, primary key 테이블의 데이터가 삭제되면 외래키에 있는 데이터도 모두 삭제처리
alter table nboard
add constraint fk_nboard foreign key(id) references member(id)
on delete cascade;


-- primary key 테이블의 데이터가 삭제되면 외래키에 있는 데이터의 id만 null값으로 변경
alter table nboard
add constraint fk_nboard_id foreign key(id) references member(id)
on delete set null;

alter table nboard
drop constraint fk_nboard;

delete member
where id='aaa';

select * from nboard;

--null값을 제외한 row를 검색한 후 그룹함수를 적용해서 출력
select department_id,count(commission_pct) 
from employees
where commission_pct is not null
group by department_id 
;


--그룹함수에서 그룹함수의 값의 조건을 처리하려면 having 명령어를 사용해야함.
select department_id,count(commission_pct) 
from employees
group by department_id
having count(commission_pct)!=0
;


--1.부서별 평균을 출력하시오.
select department_id,round(avg(salary),2) 
from employees
group by department_id
;

--2.전체 평균을 출력하시오.
select round(avg(salary),2) from employees;

--부서별로 평균이 전체평균 이상인 월급만 출력하시오.
select a.department_id,b.department_name,round(avg(salary),2) 
from employees a,departments b
where a.department_id = b.department_id
group by a.department_id,b.department_name
having round(avg(salary),2)>(select round(avg(salary),2) from employees);


