select count(*) from employees where salary>=(select avg(salary) from employees);

select count(*) from employees where department_id in (select department_id from departments where parent_id is null);

select a.department_id, a.department_name from departments a where exists(select 1 from job_history b where a.department_id=b.department_id);

select a.employee_id, (select b.emp_name from employees b where a.employee_id = b.employee_id) as emp_name,
a.department_id, (select b.department_name from departments b where a.department_id = b.department_id) as dep_name from job_history a;

select a.department_id, a.department_name from departments a where exists (select 1 from employees b where a.department_id = b.department_id
and b.salary>(select avg(salary) from employees));

/*inline view*/
select a.employee_id, a.emp_name, b.department_id, b.department_name from employees a, departments b,
(select avg(c.salary) as avg_salary from departments b, employees c where b.parent_id = 90 and b.department_id = c.department_id) d
where a.department_id = b.department_id and a.salary>d.avg_salary;

select a.* from (select a.sales_month, round(avg(a.amount_sold)) as month_avg from sales a, customers b, countries c
where a.sales_month between '200001' and '200012' and a.cust_id = b.cust_id
and b.country_id = c.country_id and c.country_name = 'Italy' group by a.sales_month)a,
(select round(avg(a.amount_sold)) as year_avg from sales a, customers b, countries c
where a.sales_month between '200001' and '200012' and a.cust_id = b.cust_id and b.country_id = c.country_id and c.country_name='Italy')b
where a.month_avg>b.year_avg;

select substr(a.sales_month, 1, 4) as years, a.employee_id, sum(a.amount_sold) as amount_sold
from sales a, customers b, countries c where a.cust_id =b.cust_id and b.country_id = c.country_id
and c.country_name = 'Italy' group by substr(a.sales_month,1,4), a.employee_id;

select years, max(amount_sold) as max_sold from (select substr(a.sales_month,1,4) as years,
a.employee_id, sum(a.amount_sold) as amount_sold from sales a, customers b, countries c
where a.cust_id = b.cust_id
and b.country_id = c.country_id
and c.country_name = 'Italy'
group by substr(sales_month,1,4),a.employee_id)k group by years order by years;

select emp.years, emp.employee_id, emp.amount_sold from (select substr(a.sales_month,1,4) as years,
a.employee_id, sum(a.amount_sold)as amount_sold
from sales a,
customers b,
countries c
where a.cust_id = b.cust_id
and b.country_id = c.country_id
and c.country_name = 'Italy'
group by substr(a.sales_month,1,4), a.employee_id)emp,(select years, max(amount_sold)as max_sold
from (select substr(a.sales_month,1,4) as years, a.employee_id, sum(a.amount_sold)as amount_sold
from sales a,
customers b,
countries c where a.cust_id = b.cust_id and b.country_id = c.country_id and c.country_name='Italy'
group by substr(a.sales_month,1,4), a.employee_id)k
group by years) sale
where emp.years = sale.years
and emp.amount_sold = sale.max_sold
order by years;

