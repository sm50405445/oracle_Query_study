select a.employee_id, a.emp_name, a.department_id, b.department_name from employees a,departments b
where a.department_id=b.department_id;

/*exists*/
select department_id, department_name from departments a where exists(select * from employees b where a.department_id=b.department_id
and b.salary>3000) order by a.department_name;
/*in*/
select department_id, department_name from departments a where a.department_id in (select b.department_id from employees b
where b.salary>3000) order by department_name;

select a.department_id, a.department_name from departments a, employees b where a.department_id = b.department_id
and b.salary>3000 order by a.department_name;

/*��Ƽ ����*/
select a.employee_id,a.emp_name,a.department_id,b.department_name from employees a , departments b where a.department_id=b.department_id
and a.department_id not in(select department_id from departments where manager_id is null);

select count(*) from employees a where not exists(select 1 from departments c where a.department_id=c.department_id and manager_id is null);

/*���� ����*/
select a.employee_id, a.emp_name, b.employee_id, b.emp_name, a.department_id from employees a, employees b where a.employee_id<b.employee_id 
and a.department_id=b.department_id and a.department_id = 20;

/*�ܺ� ����*/
select a.department_id, a.department_name, b.job_id, b.department_id from departments a, job_history b where a.department_id = b.department_id;

/*�ܺ����� + �������ǿ��� �����Ͱ� ���� ���̺� ����*/
select a.employee_id, a.emp_name, b.job_id, b.department_id from employees a, job_history b where a.employee_id = b.employee_id(+);

/*�ܺ����� + �������ǿ��� �����Ͱ� ���� ���̺� ���� where ���Ͽ� ��� + �ٿ�����*/
select a.employee_id, a.emp_name, b.job_id, b.department_id from employees a, job_history b where a.employee_id = b.employee_id(+)
and a.department_id = b.department_id(+);

select * from job_history;

/*ansi ���� ����*/
select a.employee_id, a.emp_name, b.department_id, b.department_name from employees a inner join departments b
on (a.department_id = b.department_id) where a.hire_date>=to_date('2003-01-01','yyyy-mm-dd');
/*ansi�� ��*/
select a.employee_id, a.emp_name, b.department_id, b.department_name from employees a,departments b where a.department_id = b.department_id
and a.hire_date>=to_date('2003-01-01','yyyy-mm-dd');

select a.employee_id, a.emp_name, b.department_name from employees a inner join departments b
using(department_id) where a.hire_date>=to_date('2001-01-01','yyyy-mm-dd');

/*ansi �ܺ�����*/
select a.employee_id, a.emp_name, b.job_id, b.department_id from employees a
left outer join job_history b
on (a.employee_id = b.employee_id and a.department_id = b.department_id);

/*cross ���� �ƹ� ���ǵ� �Ⱥ��� ansi���*/
select a.employee_id, a.emp_name, b.department_id, b.department_name from employees a
cross join departments b;