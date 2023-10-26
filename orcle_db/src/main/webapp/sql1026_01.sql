--����� Ȧ�� �� ����� ����Ͻÿ�.
select employee_id from employees
where mod(employee_id,2) = 1;

--board
select * from board;

desc board;

--���� ��¥ ���
select sysdate from dual;

select * from board
order by bno desc;

insert into board values(
board_seq.nextval,'�Խñ��� ����մϴ�.2','�Խñ� �����Դϴ�.2',sysdate,'ccc',board_seq.currval,0,0,1,'3.jpg'
);

select * from board
order by bno desc;

commit;

select sysdate-1 ����,sysdate ����,sysdate+1 ����
from dual;

select bdate,btitle from board
order by bdate desc;

--���� ��¥ ���� 5�� ������ �Խñ��� ����Ͻÿ�.
--��ȣ,����,�ۼ��ϸ� ���
select sysdate-5 from dual;

select bno,btitle,bdate from board
where bdate>sysdate-7
order by bdate desc;

--employees ���糯¥ ���� �Ի��Ͽ��� ���糯¥���� �Ⱓ�� ����Ͻÿ�.
--�����ȣ,�����,�Ի���,����,�μ���ȣ
--�Ҽ����� ����
select employee_id,emp_name,hire_date,salary,department_id, 
trunc(sysdate-hire_date)
from employees;
 
 --�ٰ��� ������ ���
select next_day(sysdate,'�����') from dual;
select next_day(sysdate,'��') from dual;
select next_day(sysdate,7) from dual;

--�Է��� ���� ������ ���� ���
select last_day(sysdate)from dual;
select last_day('20231101')from dual;
select last_day('20220201') from dual;

--add_months
select add_months(sysdate,-2) from dual;
select add_months(sysdate,+12) from dual;
select add_months('20220101',+6) from dual;

--����޿��� �Ի��� �ޱ����� ������
select round(months_between(sysdate,hire_date))||'����' from employees;

--����������� 6�������� �ۼ��� ���� ����Ͻÿ�. board���
select bno,btitle,bdate
from board
where bdate>add_months(sysdate,-6)
order by bdate desc
;

--��¥ �� �⵵��,�޸�,�ϸ� ���:extract
select extract(year from bdate) from board;
select extract(month from bdate) from board;
select extract(day from bdate) from board;

--3,5,7���� �Է��� �Խñ��� ����Ͻÿ�.
select bno,btitle,bdate from board
where extract(month from bdate)in(3,5,7)
order by bdate asc;

--��¥ round - 15�����ϴ� 1�� ����,16�Ϻ��ʹ� 1�� �߰�, trunc 1�� �������� ������.
select bno,btitle,bdate from board;
select bdate,round(bdate,'month'),trunc(bdate,'month') from board;

--to_date�� ����ȯ �Լ�
select round(to_date('20231015'),'month') from dual;
select round(to_date('20231016'),'month') from dual;

--to_char ��¥->��������ȯ
select bdate from board;
select to_char(bdate,'YYYY-MM-DD DY HH:MI:SS') 
from board
order by bdate desc;

select bno,btitle,bcontent,to_char(bdate,'YYYY"��"MM"��"DD"��')bdate,bgroup,bstep,bindent,bhit,bfile
from board;

--�Ի��� (2023-11-01 ȭ����) ����Ͻÿ�.
select employee_id,emp_name,email,phone_number,to_char(hire_date,'YYYY-MM-DD DAY')hire_date,
salary,manager_id from employees;

select to_char(bdate,'YYYY-MM-DD AM HH:MI:SS') from board
order by bdate desc;

--[������ ��ȯ�Լ�]--
--���ڸ� ���ڷ�
select to_char(1234567890) from dual;
--�޷�ǥ��,,õ����ǥ��,0-���ڸ��� 0���� ǥ�õ�.
select to_char(1234567890,'$0,000,999,999')from dual;
--���� ȭ�����ǥ��
select to_char(1234567890,'L0,000,999,999')from dual;

select to_char(123,'0000000000') from dual;
select to_char(1234567890,'0000000000') from dual;

--trim �յ� ���������Լ�
select trim(to_char(123456,'L999,999,999')) from dual;

--����
--salary �޷�ǥ�ÿ� õ����ǥ��
--salary*1342 ��ȭǥ�ÿ� õ����ǥ��,�Ҽ��� 1�ڸ����� �ݿø�ǥ��
select salary,to_char(salary,'$999,999'), salary*1342.42 ,to_char(round(salary*1342.42,1),'L999,999,999.9')
from employees;

--����
--12345 �� 9�ڸ����� ǥ���ϴµ�, ������� 0���� ä����.
select to_char(12345,'000099999') from dual;

--����2
--12345 �� 9�ڸ� ���� ǥ�� õ����ǥ���ϰ� ������� �����ؼ� ���.
select trim(to_char(12345,'L999,999,999')) from dual;

--����3
--board���̺��� bdate�� ���ؼ� 20231023 ���ڿ� ���� �� �Է��� �Խñ��� ����Ͻÿ�.
select bno,btitle,bdate from board
where bdate = to_date('20231023','YYYYMMDD')
order by bdate desc;

--����4
--���� 20200101 ���� ������� �Ⱓ�� �󸶳� �������� ����Ͻÿ�.
select trunc(sysdate - to_date('20200101','YYYYMMDD')) from dual;

--����5
-- �ڱ� �¾ ���� ��������  �󸶳� �������� ����Ͻÿ�.
select trunc(sysdate - to_date('20001107','YYYYMMDD')) 
from dual;
--������ ���
select trunc(months_between(sysdate,to_date('20001107','YYYYMMDD'))) 
from dual;

--[���ڸ� ���ڷ� ����ȯ�Լ�]--
--���� 20,000 - 10,000�� �������̸� ����Ͻÿ�.
select to_number('20,000','99,999')from dual;
select to_number('10,000','99,999') from dual;

select to_number('20,000','99,999')-to_number('10,000','99,999')
from dual;

select emp_name,to_char(salary,'$999,999') from employees;

--����
--��� + Ŀ�̼�����
--����*12+(����*12*Ŀ�̼�)������� �ؼ� ����Ͻÿ�.
--�����ȣ,�����,����,����*12,���
select employee_id,emp_name,salary,nvl(commission_pct,0),salary*12,
(salary*12)+salary*12*nvl(commission_pct,0) ���
from employees;

select manager_id from employees
where manager_id is null;

select manager_id from employees;

--null 0����ǥ��
select nvl(manager_id,0) from employees
;

--ceo��� ���ڷ� ǥ���ؼ� ����Ͻÿ�.
select nvl(to_char(manager_id),'CEO') from employees;

--�׷��Լ�--
--�Խñ� ��ȸ�� ������ ���
--õ���� ǥ��
SELECT TRIM(TO_CHAR(SUM(BHIT),'999,999,999'))FROM BOARD;

--��� ǥ��
SELECT TRIM(TO_CHAR(AVG(BHIT),'999,999,999'))FROM BOARD;

--������ ��� ���
SELECT ROUND(AVG(SALARY),2)FROM EMPLOYEES;

--EMP_NAME �����Լ��� �׷��Լ��� �Բ� ��� ����.
SELECT EMP_NAME,AVG(SALARY)FROM EMPLOYEES;

--MIN �ּҰ�, MAX�ִ밪, AVG���, COUNT ����, SUM�հ�
SELECT MIN(SALARY),MAX(SALARY),ROUND(AVG(SALARY),2),COUNT(*)FROM EMPLOYEES;

--�μ���ȣ�� 50�� ������� SALARY�հ�,����� ����Ͻÿ�.
SELECT SUM(SALARY),ROUND(AVG(SALARY),2) 
FROM EMPLOYEES 
WHERE DEPARTMENT_ID =50;

--GROUP BY�� �̿��� �׷��Լ��� �����Լ� ��밡��
SELECT DEPARTMENT_ID,SUM(SALARY),ROUND(AVG(SALARY),2),COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID ASC;

--����
--��¥ �Խñ� ������ ����Ͻÿ�.
SELECT BDATE,COUNT(*)
FROM BOARD
GROUP BY BDATE
ORDER BY BDATE ASC;

--�⵵�� ���� ������ ����Ͻÿ�.
SELECT TO_CHAR(BDATE,'YYYYMM')���,COUNT(TO_CHAR(BDATE,'YYYYMM'))���������
FROM BOARD
GROUP BY TO_CHAR(BDATE,'YYYYMM')
ORDER BY TO_CHAR(BDATE, 'YYYYMM');

SELECT ADD_MONTHS(BDATE,1)
FROM BOARD;

--�⵵�� ���
SELECT EXTRACT(YEAR FROM BDATE)FROM BOARD;

--���� ���
SELECT EXTRACT(MONTH FROM BDATE) FROM BOARD;

--�ϸ� ���
SELECT EXTRACT(DAY FROM BDATE) FROM BOARD;

--�⵵�� ������� ���� �Խñۼ� ���
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

--��ȸ���� ���� ���� ����,������ ����Ͻÿ�
SELECT MIN(BHIT) FROM BOARD;
SELECT BNO,BTITLE,MIN(BHIT) FROM BOARD
GROUP BY BNO,BTITLE,BCONTENT
;
SELECT*FROM BOARD
WHERE BHIT =(SELECT MIN(BHIT) FROM BOARD)
;

--��ȸ���� ���� ���� �Խñ��� ����ϼ���
SELECT *FROM  BOARD
WHERE BHIT=(SELECT MAX(BHIT) FROM BOARD);

--[�����Լ�]--
SELECT EMP_NAME FROM EMPLOYEES;

--��ҹ��� ���� ���� si,Si �� ���Ե� �̸��� ��� ����Ͻÿ�.
--SI, Si sI,si
SELECT EMP_NAME
FROM EMPLOYEES
WHERE EMP_NAME LIKE('%SI%') OR EMP_NAME LIKE('%Si%') OR EMP_NAME LIKE('%sI%') OR EMP_NAME LIKE('%si%')
;

SELECT EMP_NAME FROM EMPLOYEES
WHERE EMP_NAME LIKE ('%DA%') OR EMP_NAME LIKE('%Da%') OR EMP_NAME LIKE ('%dA%') OR  EMP_NAME LIKE ('%da%')
;


--�ҹ��� ��ȯ �Լ�
SELECT EMP_NAME
FROM EMPLOYEES
WHERE LOWER(EMP_NAME)LIKE('%da%')
;

--�빮�� ��ȯ�Լ�
SELECT EMP_NAME
FROM EMPLOYEES
WHERE UPPER(EMP_NAME)LIKE('%DA%')
;

--EMPLOYEES���� �̸��� �빮�ڷ� ����Ͻÿ�.
SELECT UPPER(EMP_NAME) FROM EMPLOYEES;

--�ڸ����� ���� ������ ���ڸ� ä�� ���
SELECT LPAD(12345,10,'0')FROM DUAL;
SELECT RPAD(12345,10,'#')FROM DUAL;

--12345 10�ڸ��� õ����ǥ�ÿ� ��ȭǥ�ø� �߰��ؼ� ����Ͻÿ�.
--������� 0����ǥ��
SELECT TO_CHAR(12345,'L0,000,000,000') FROM DUAL;

--LTRIM -���� ���� ����, RTRIM- ������ ���� ����, TRIM-����������
--' ABC DEF C '
SELECT TRIM(' ABC DEF C  ')FROM DUAL;

SELECT * FROM EMPLOYEES;

--JOB_ID ASST --> SS --> I ASST-->AIT
SELECT JOB_ID,REPLACE(JOB_ID,'SS','1')FROM EMPLOYEES;

--JOB_ID �ȿ� �ִ� ���� ����
SELECT EMP_NAME, REPLACE(EMP_NAME,'','')FROM EMPLOYEES;
SELECT '    ABC    DEF   C  ',REPLACE('    ABC    DEF   C  ',' ','')FROM DUAL;

SELECT JOB_ID FROM EMP2;
--SH_CLERK -> CLERK �����ؼ� �����ϱ�
UPDATE EMP2
SET JOB_ID = 'CLERK'
WHERE JOB_ID = 'SH_CLERK'
;

--SH_CLERK�� CLERK���� ������Ʈ

SELECT REPLACE(JOB_ID,'SH_CLERK','CL')j_id FROM EMP2;
SELECT REPLACE(JOB_ID,'SH_CLERK','CLERK')FROM EMP2;

ROLLBACK;
--SUBSTR(�ش��÷�,3,2)�ش��÷����� 3��° ���ں��� 2���� �߶�� ���
-- 4��°���� �̸� 3���� ������.
SELECT EMP_NAME,SUBSTR(EMP_NAME,1,5)FROM EMPLOYEES;

SELECT HIRE_DATE FROM EMPLOYEES;

--�̸� 5���� �Ի�⵵ ��� 
--Donal(1955)
SELECT SUBSTR(EMP_NAME,1,5),TO_CHAR(HIRE_DATE,'YYYY') FROM EMPLOYEES;

SELECT SUBSTR(EMP_NAME,1,5)||'('||EXTRACT(YEAR FROM HIRE_DATE)||')'
FROM EMPLOYEES;

--
SELECT * FROM EMPLOYEES;

--�Ի����� 06���� ����߿� �̸��� d�� �� �ִ� ����� ����Ͻÿ�.
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

--�Խñ��� ��¥�� 1�� �����ؼ� update�Ͻÿ�.
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
--length���
select avg(length(emp_name))from employees;

--�̸��� ������� ���̸�ŭ�� ����Ͻÿ�.


--employees ����ȣ�� �ִ� 5��° 3���� �̸� 1��° 5��°���� 2���� �Բ� ����Ͻÿ�.
select * from employees;
select substr(phone_number,5,3), substr(emp_name,1,5) from employees;

--instr ã���� �ϴ� ��ġ ���� ���
select instr(emp_name,'o') from employees
where employee_id=198
;

select emp_name, instr(emp_name,' '),instr(emp_name,'')+1 from employees;

--1��° �������ĺ��� �̸���������.
select substr(emp_name,instr(emp_name,' ')+1) from employees;

--�ֹι�ȣ �տ� �ڸ� ��������
select substr('880101-1101111',1,instr('880101-1101111','-')-1) from dual;


--�ֹι�ȣ �ڿ� �ڸ� ��������
select substr('880101-1101111',instr('880101-1101111','-')+1) from dual;

--employees�� phone_number ù��° �� �������� �պκа� �޺κ� ����Ͻÿ�.
select phone_number from employees;
select substr(phone_number,1,instr(phone_number,'.')-1) from employees;

select instr('123.456.789','.')from dual; --���� �ִ� ��ġ��

select instr('123.456.789.000','.',1,3)from dual;-- ù��° ����-������ġ, �ι�° ���� ���� �ι�° ��ġ��

select instr('123.456.789.000','.',-1,1)from dual;-- ù��° ����-������ġ, �ι�° ���� ���� �ι�° ��ġ��

select * from member;

--��ȭ��ȣ - ù��° �� ���, �ι�°, ����° ���� ����Ͻÿ�.
--010
--1111
--1111

select substr(phone,1,instr(phone,'-')-1)from member;--1��°

select substr(phone,instr(phone,'-')+1,4)from member;--2��°

select substr(phone,instr(phone,'-',1,2)+1,4)from member;--3��°


select phone_number from employees;
-- ����ȣ���� 123���ԵǾ� �ִ� ����ȣ�� ����Ͻÿ�.
select phone_number from employees
where phone_number like('%123%') ;


--�μ��� �ִ������ ����Ͻÿ�.
select department_id,count(*),max(salary), min(salary)
from employees
group by department_id
order by department_id
;

--�̸�
select emp_name,hire_date,to_char(hire_date,'YYYY"��"MM"��"DD"��"DAY')
from employees;

commit;