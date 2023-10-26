--사번이 홀수 인 사원을 출력하시오.
select employee_id from employees
where mod(employee_id,2) = 1;

--board
select * from board;

desc board;

--현재 날짜 출력
select sysdate from dual;

select * from board
order by bno desc;

insert into board values(
board_seq.nextval,'게시글을 등록합니다.2','게시글 내용입니다.2',sysdate,'ccc',board_seq.currval,0,0,1,'3.jpg'
);

select * from board
order by bno desc;

commit;

select sysdate-1 어제,sysdate 오늘,sysdate+1 내일
from dual;

select bdate,btitle from board
order by bdate desc;

--현재 날짜 기준 5일 이전에 게시글을 출력하시오.
--번호,제목,작성일만 출력
select sysdate-5 from dual;

select bno,btitle,bdate from board
where bdate>sysdate-7
order by bdate desc;

--employees 현재날짜 기준 입사일에서 현재날짜까지 기간을 출력하시오.
--사원번호,사원명,입사일,월급,부서번호
--소수점은 절사
select employee_id,emp_name,hire_date,salary,department_id, 
trunc(sysdate-hire_date)
from employees;
 
 --다가올 요일을 출력
select next_day(sysdate,'목요일') from dual;
select next_day(sysdate,'목') from dual;
select next_day(sysdate,7) from dual;

--입력한 날의 마지막 일을 출력
select last_day(sysdate)from dual;
select last_day('20231101')from dual;
select last_day('20220201') from dual;

--add_months
select add_months(sysdate,-2) from dual;
select add_months(sysdate,+12) from dual;
select add_months('20220101',+6) from dual;

--현재달에서 입사한 달까지의 개월수
select round(months_between(sysdate,hire_date))||'개월' from employees;

--현재기준으로 6개월동안 작성된 글을 출력하시오. board사용
select bno,btitle,bdate
from board
where bdate>add_months(sysdate,-6)
order by bdate desc
;

--날짜 중 년도만,달만,일만 출력:extract
select extract(year from bdate) from board;
select extract(month from bdate) from board;
select extract(day from bdate) from board;

--3,5,7월에 입력한 게시글을 출력하시오.
select bno,btitle,bdate from board
where extract(month from bdate)in(3,5,7)
order by bdate asc;

--날짜 round - 15일이하는 1일 세팅,16일부터는 1달 추가, trunc 1일 기준으로 변경함.
select bno,btitle,bdate from board;
select bdate,round(bdate,'month'),trunc(bdate,'month') from board;

--to_date는 형번환 함수
select round(to_date('20231015'),'month') from dual;
select round(to_date('20231016'),'month') from dual;

--to_char 날짜->문자형변환
select bdate from board;
select to_char(bdate,'YYYY-MM-DD DY HH:MI:SS') 
from board
order by bdate desc;

select bno,btitle,bcontent,to_char(bdate,'YYYY"년"MM"월"DD"일')bdate,bgroup,bstep,bindent,bhit,bfile
from board;

--입사일 (2023-11-01 화요일) 출력하시오.
select employee_id,emp_name,email,phone_number,to_char(hire_date,'YYYY-MM-DD DAY')hire_date,
salary,manager_id from employees;

select to_char(bdate,'YYYY-MM-DD AM HH:MI:SS') from board
order by bdate desc;

--[문자형 변환함수]--
--숫자를 문자로
select to_char(1234567890) from dual;
--달러표시,,천단위표시,0-빈자리가 0으로 표시됨.
select to_char(1234567890,'$0,000,999,999')from dual;
--나라별 화폐단위표시
select to_char(1234567890,'L0,000,999,999')from dual;

select to_char(123,'0000000000') from dual;
select to_char(1234567890,'0000000000') from dual;

--trim 앞뒤 공백제거함수
select trim(to_char(123456,'L999,999,999')) from dual;

--퀴즈
--salary 달러표시와 천단위표시
--salary*1342 원화표시와 천단위표시,소수점 1자리까지 반올림표시
select salary,to_char(salary,'$999,999'), salary*1342.42 ,to_char(round(salary*1342.42,1),'L999,999,999.9')
from employees;

--퀴즈
--12345 총 9자리까지 표시하는데, 빈공백은 0으로 채워줌.
select to_char(12345,'000099999') from dual;

--퀴즈2
--12345 총 9자리 까지 표시 천단위표시하고 빈공백은 제거해서 출력.
select trim(to_char(12345,'L999,999,999')) from dual;

--퀴즈3
--board테이블에서 bdate와 비교해서 20231023 숫자와 같은 날 입력한 게시글을 출력하시오.
select bno,btitle,bdate from board
where bdate = to_date('20231023','YYYYMMDD')
order by bdate desc;

--퀴즈4
--숫자 20200101 부터 현재까지 기간이 얼마나 지났는지 출력하시오.
select trunc(sysdate - to_date('20200101','YYYYMMDD')) from dual;

--퀴즈5
-- 자기 태어난 날을 기준으로  얼마나 지났는지 출력하시오.
select trunc(sysdate - to_date('20001107','YYYYMMDD')) 
from dual;
--개월수 출력
select trunc(months_between(sysdate,to_date('20001107','YYYYMMDD'))) 
from dual;

--[문자를 숫자로 형변환함수]--
--문자 20,000 - 10,000의 숫자차이를 출력하시오.
select to_number('20,000','99,999')from dual;
select to_number('10,000','99,999') from dual;

select to_number('20,000','99,999')-to_number('10,000','99,999')
from dual;

select emp_name,to_char(salary,'$999,999') from employees;

--퀴즈
--년봉 + 커미션포함
--월급*12+(월급*12*커미션)년봉으로 해서 출력하시오.
--사원번호,사원명,월급,월급*12,년봉
select employee_id,emp_name,salary,nvl(commission_pct,0),salary*12,
(salary*12)+salary*12*nvl(commission_pct,0) 년봉
from employees;

select manager_id from employees
where manager_id is null;

select manager_id from employees;

--null 0으로표시
select nvl(manager_id,0) from employees
;

--ceo라는 글자로 표시해서 출력하시오.
select nvl(to_char(manager_id),'CEO') from employees;

--그룹함수--
--게시글 조회수 총합을 출력
--천단위 표시
SELECT TRIM(TO_CHAR(SUM(BHIT),'999,999,999'))FROM BOARD;

--평균 표시
SELECT TRIM(TO_CHAR(AVG(BHIT),'999,999,999'))FROM BOARD;

--월급의 평균 출력
SELECT ROUND(AVG(SALARY),2)FROM EMPLOYEES;

--EMP_NAME 단일함수를 그룹함수와 함께 출력 못함.
SELECT EMP_NAME,AVG(SALARY)FROM EMPLOYEES;

--MIN 최소값, MAX최대값, AVG평균, COUNT 개수, SUM합계
SELECT MIN(SALARY),MAX(SALARY),ROUND(AVG(SALARY),2),COUNT(*)FROM EMPLOYEES;

--부서번호가 50인 사원들의 SALARY합계,평균을 출력하시오.
SELECT SUM(SALARY),ROUND(AVG(SALARY),2) 
FROM EMPLOYEES 
WHERE DEPARTMENT_ID =50;

--GROUP BY를 이용해 그룹함수와 단일함수 사용가능
SELECT DEPARTMENT_ID,SUM(SALARY),ROUND(AVG(SALARY),2),COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID ASC;

--퀴즈
--날짜 게시글 개수를 출력하시오.
SELECT BDATE,COUNT(*)
FROM BOARD
GROUP BY BDATE
ORDER BY BDATE ASC;

--년도의 월별 개수를 출력하시오.
SELECT TO_CHAR(BDATE,'YYYYMM')년월,COUNT(TO_CHAR(BDATE,'YYYYMM'))년월별개수
FROM BOARD
GROUP BY TO_CHAR(BDATE,'YYYYMM')
ORDER BY TO_CHAR(BDATE, 'YYYYMM');

SELECT ADD_MONTHS(BDATE,1)
FROM BOARD;

--년도만 출력
SELECT EXTRACT(YEAR FROM BDATE)FROM BOARD;

--월만 출력
SELECT EXTRACT(MONTH FROM BDATE) FROM BOARD;

--일만 출력
SELECT EXTRACT(DAY FROM BDATE) FROM BOARD;

--년도와 상관없이 월별 게시글수 출력
SELECT EXTRACT(MONTH FROM BDATE),COUNT(EXTRACT(MONTH FROM BDATE))
FROM BOARD
GROUP BY EXTRACT(MONTH FROM BDATE)
ORDER BY EXTRACT(MONTH FROM BDATE);
SELECT DEPARTMENT_ID,COUNT(*) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID
;

SELECT COUNT(EMPLOYEE_ID)FROM EMPLOYEES;--107

SELECT COUNT(MANAGER_ID)FROM EMPLOYEES;--106: NULL

--조회수가 가장 낮은 제목,내용을 출력하시오
SELECT MIN(BHIT) FROM BOARD;
SELECT BNO,BTITLE,MIN(BHIT) FROM BOARD
GROUP BY BNO,BTITLE,BCONTENT
;
SELECT*FROM BOARD
WHERE BHIT =(SELECT MIN(BHIT) FROM BOARD)
;

--조회수가 가장 높은 게시글을 출력하세요
SELECT *FROM  BOARD
WHERE BHIT=(SELECT MAX(BHIT) FROM BOARD);

--[문자함수]--
SELECT EMP_NAME FROM EMPLOYEES;

--대소문자 구분 없이 si,Si 가 포함된 이름을 모두 출력하시오.
--SI, Si sI,si
SELECT EMP_NAME
FROM EMPLOYEES
WHERE EMP_NAME LIKE('%SI%') OR EMP_NAME LIKE('%Si%') OR EMP_NAME LIKE('%sI%') OR EMP_NAME LIKE('%si%')
;

SELECT EMP_NAME FROM EMPLOYEES
WHERE EMP_NAME LIKE ('%DA%') OR EMP_NAME LIKE('%Da%') OR EMP_NAME LIKE ('%dA%') OR  EMP_NAME LIKE ('%da%')
;


--소문자 변환 함수
SELECT EMP_NAME
FROM EMPLOYEES
WHERE LOWER(EMP_NAME)LIKE('%da%')
;

--대문자 변환함수
SELECT EMP_NAME
FROM EMPLOYEES
WHERE UPPER(EMP_NAME)LIKE('%DA%')
;

--EMPLOYEES에서 이름을 대문자로 출력하시오.
SELECT UPPER(EMP_NAME) FROM EMPLOYEES;

--자리수를 만들어서 지정한 문자를 채워 출력
SELECT LPAD(12345,10,'0')FROM DUAL;
SELECT RPAD(12345,10,'#')FROM DUAL;

--12345 10자리로 천단위표시와 원화표시를 추가해서 출력하시오.
--빈공백은 0으로표시
SELECT TO_CHAR(12345,'L0,000,000,000') FROM DUAL;

--LTRIM -왼쪽 공백 제거, RTRIM- 오른쪽 공백 제거, TRIM-모든공백제거
--' ABC DEF C '
SELECT TRIM(' ABC DEF C  ')FROM DUAL;

SELECT * FROM EMPLOYEES;

--JOB_ID ASST --> SS --> I ASST-->AIT
SELECT JOB_ID,REPLACE(JOB_ID,'SS','1')FROM EMPLOYEES;

--JOB_ID 안에 있는 공백 제거
SELECT EMP_NAME, REPLACE(EMP_NAME,'','')FROM EMPLOYEES;
SELECT '    ABC    DEF   C  ',REPLACE('    ABC    DEF   C  ',' ','')FROM DUAL;

SELECT JOB_ID FROM EMP2;
--SH_CLERK -> CLERK 변경해서 저장하기
UPDATE EMP2
SET JOB_ID = 'CLERK'
WHERE JOB_ID = 'SH_CLERK'
;

--SH_CLERK을 CLERK으로 업데이트

SELECT REPLACE(JOB_ID,'SH_CLERK','CL')j_id FROM EMP2;
SELECT REPLACE(JOB_ID,'SH_CLERK','CLERK')FROM EMP2;

ROLLBACK;
--SUBSTR(해당컬럼,3,2)해당컬럼에서 3번째 글자부터 2개를 잘라와 출력
-- 4번째부터 이름 3개를 가져옴.
SELECT EMP_NAME,SUBSTR(EMP_NAME,1,5)FROM EMPLOYEES;

SELECT HIRE_DATE FROM EMPLOYEES;

--이름 5개와 입사년도 출력 
--Donal(1955)
SELECT SUBSTR(EMP_NAME,1,5),TO_CHAR(HIRE_DATE,'YYYY') FROM EMPLOYEES;

SELECT SUBSTR(EMP_NAME,1,5)||'('||EXTRACT(YEAR FROM HIRE_DATE)||')'
FROM EMPLOYEES;

--
SELECT * FROM EMPLOYEES;

--입사일이 06월인 사원중에 이름이 d가 들어가 있는 사원을 출력하시오.
SELECT * FROM EMPLOYEES
WHERE EXTRACT(MONTH FROM HIRE_DATE) = 6
AND EMP_NAME LIKE('%d%')
;
rollback;
--
update board
set bhit=1
;
select bhit from board;

select bno,bhit,bhit+100 from board;

update emp2 a
set job_id=(select replace(job_id ,'SH_CLERK','CLERK') from emp2 b where a.employee_id = b.employee_id)
;

commit;

select job_id from emp2;

update board a
set bhit=(select bhit+100 from board b where a.bno = b.bno)
;

select bhit from board;

select * from board;

--게시글의 날짜를 1씩 증가해서 update하시오.
--bdate
update board a
set bdate=(select bdate+1 from board b where a.bno = b.bno)
;

commit;

select * from stuscore;

select b_num,b_rank from
(select stunum,total,rank()over(order by total desc) from stuscore);

update stuscore a
set rank=(select b_rank from
(select stunum b_num,rank() over(order by total desc) b_rank from stuscore b) 
where a.stunum = b_num);

select length(emp_name),emp_name from employees;
--length평균
select avg(length(emp_name))from employees;

--이름을 평균절사 길이만큼만 출력하시오.


--employees 폰번호에 있는 5번째 3개와 이름 1번째 5번째까지 2개를 함꼐 출력하시오.
select * from employees;
select substr(phone_number,5,3), substr(emp_name,1,5) from employees;

--instr 찾고자 하는 위치 숫자 출력
select instr(emp_name,'o') from employees
where employee_id=198
;

select emp_name, instr(emp_name,' '),instr(emp_name,'')+1 from employees;

--1번째 공백이후부터 이름가져오기.
select substr(emp_name,instr(emp_name,' ')+1) from employees;

--주민번호 앞에 자리 가져오기
select substr('880101-1101111',1,instr('880101-1101111','-')-1) from dual;


--주민번호 뒤에 자리 가져오기
select substr('880101-1101111',instr('880101-1101111','-')+1) from dual;

--employees의 phone_number 첫번째 점 기준으로 앞부분과 뒷부분 출력하시오.
select phone_number from employees;
select substr(phone_number,1,instr(phone_number,'.')-1) from employees;

select instr('123.456.789','.')from dual; --점이 있는 위치값

select instr('123.456.789.000','.',1,3)from dual;-- 첫번째 숫자-시작위치, 두번째 숫자 점의 두번째 위치값

select instr('123.456.789.000','.',-1,1)from dual;-- 첫번째 숫자-시작위치, 두번째 숫자 점의 두번째 위치값

select * from member;

--전화번호 - 첫번째 값 출력, 두번째, 세번째 값을 출력하시오.
--010
--1111
--1111

select substr(phone,1,instr(phone,'-')-1)from member;--1번째

select substr(phone,instr(phone,'-')+1,4)from member;--2번째

select substr(phone,instr(phone,'-',1,2)+1,4)from member;--3번째


select phone_number from employees;
-- 폰번호에서 123포함되어 있는 폰번호를 출력하시오.
select phone_number from employees
where phone_number like('%123%') ;


--부서별 최대월급을 출력하시오.
select department_id,count(*),max(salary), min(salary)
from employees
group by department_id
order by department_id
;

--이름
select emp_name,hire_date,to_char(hire_date,'YYYY"년"MM"월"DD"일"DAY')
from employees;

commit;