select * from employees;

-- sysdate ���糯¥ ���,round �ݿø�
select hire_date,sysdate,round(sysdate-hire_date)from employees;

--distinct �ߺ�����, roder by asc ��������(����)
select distinct department_id from employees order by department_id asc;  

select * from departments;

desc stuscore;

select emp_name from employees;

--����,���̺��,�÷����� ��ҹ��� ��������. �����Ͱ��� ��ҹ��� ������.
select emp_name from employees where emp_name='Donald OConnell';

