--- Exercise 1 ---
SELECT department_id FROM employees WHERE last_name = 'Zlotkey'
SELECT last_name, hire_date FROM employees WHERE department_id IN (SELECT department_id FROM employees WHERE last_name = 'Zlotkey') AND last_name <> 'Zlotkey'

--- Exercise 2 ---
select employee_id, last_name, salary from employees where salary > (select AVG(salary) from employees) order by salary ASC

--- Exercise 3 ---
select department_id from employees where last_name like'%u%'
select employee_id, last_name from employees where department_id in (select department_id from employees where last_name like'%u%')

--- Exercise 4 ---
--- Cách 1 ---
select department_id from departments where location_id = 1700
select last_name, department_id, job_id from employees where department_id in (select department_id from departments where location_id = 1700)
--- Cách 2 ---
select e.last_name, e.department_id, e.job_id from employees e INNER JOIN departments d on e.department_id = d.department_id
where d.location_id = 1700

--- Exercise 5 ---
select e.last_name, e.salary from employees e
inner join employees manager on e.manager_id = manager.employee_id
where manager.last_name = 'King'

--- Exercise 6 ---
select * from departments
select e.department_id, e.last_name, e.job_id from employees e
inner join departments d on e.department_id = d.department_id
where department_name = 'Executive'

--- Exercise 7 ---
select employee_id, last_name, salary
from employees where salary > (select AVG(salary) from employees)
and department_id in (select department_id from employees where last_name like'%u%')

--- Exercise 8 ---
select round(MAX(salary),0) 'Maximum',
round(MIN(salary),0) 'Minimum',
round(SUM(salary),0) 'Sum',
round(AVG(salary),0) 'Average'
from employees

select cast(sum(salary) as numeric (10,0)) as Sum from employees

--- Exercise 9 ---
select upper(left(last_name,1)) + lower(substring(last_name,2, len(last_name))) 'Name', len(last_name) 'Length of Name'
from employees
where last_name like 'J%' or last_name like 'A%' or last_name like 'M%'
order by last_name

--- Exercise 10 ---
select employee_id, last_name, salary, salary+(salary*15.5/100) 'New Salary'
from employees

select employee_id, last_name, salary, cast((salary*1.155) as numeric (10,0)) 'New Salary'
from employees

--- Exercise 11 ---
select e.last_name, e.department_id, d.department_id, d.department_name from employees e
full join departments d on e.department_id = d.department_id

select last_name, department_id, null as department_name from employees
union all
select null as last_name, department_id, department_name from departments


--- Exercise 12 ---
select e.employee_id, e.hire_date, e.last_name from employees e
inner join employees manager on e.manager_id = manager.employee_id
where manager.hire_date < e.hire_date
and e.department_id in (select department_id from departments where location_id in (select location_id from locations where city = 'Toronto'))

select e.employee_id from employees e
inner join employees manager on e.manager_id = manager.employee_id
where manager.hire_date < e.hire_date
union
select e.employee_id from employees e
inner join departments d on e.department_id = d.department_id
inner join locations l on d.location_id = l.location_id
where l.city = 'Toronto'
