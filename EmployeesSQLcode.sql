
drop table dept_manager;
drop table salaries;
drop table titles;
drop table dept_emp;
drop table employees;
drop table departments;

CREATE TABLE departments (
    varchar varchar primary key NOT NULL,
    dept_name varchar NOT NULL 
);

CREATE TABLE dept_emp (
    emp_no int primary key NOT NULL,
    dept_no varchar   NOT NULL,
	foreign key (dept_no) references departments(varchar) 
);

CREATE TABLE title (
    title_id varchar primary key  NOT NULL,
    title varchar   NOT NULL
);

CREATE TABLE dept_manager (
    dept_no varchar NOT NULL,
    emp_no int primary key  NOT NULL,
	foreign key (emp_no) references dept_emp(emp_no) 
);

CREATE TABLE employees (
    emp_no int primary key NOT NULL,
    emp_title varchar   NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar   NOT NULL,
    last_name varchar   NOT NULL,
    sex varchar   NOT NULL,
    hire_date date   NOT NULL,
	foreign key (emp_no) references dept_emp(emp_no),
	foreign key (emp_title) references title(title_id)
);

CREATE TABLE salaries (
    emp_no int primary key  NOT NULL,
    salary int  NOT NULL,
	foreign key (emp_no) references employees(emp_no)
);

select * from departments;
select * from dept_manager;
select * from dept_emp;
select * from employees;
select * from salaries;
select * from titles;

select employees.emp_no, employees.last_name, 
	employees.first_name, employees.sex, salaries.salary
from employees
left join salaries
on salaries.emp_no = employees.emp_no;

select employees.first_name, employees.last_name, 
	employees.hire_date
from employees
where extract(year from "hire_date") = 1986;

select departments.varchar,departments.dept_name,
	dept_manager.emp_no, employees.last_name, 
	employees.first_name
from departments
right outer join dept_manager
	on dept_manager.dept_no = departments.varchar
inner join employees
	on dept_manager.emp_no = employees.emp_no;
	
select employees.emp_no, employees.last_name, 
	employees.first_name, departments.dept_name
from employees
join dept_emp
on dept_emp.emp_no = employees.emp_no
right outer join departments
on dept_emp.dept_no = departments.varchar;
	
select first_name, last_name, sex 
from employees
where employees.first_name = 'Hercules' 
AND employees.last_name like 'B%';
	
select employees.emp_no, employees.last_name,
	employees.first_name, departments.dept_name
from employees
join dept_emp
on employees.emp_no = dept_emp.emp_no
left outer join departments
on dept_emp.dept_no = departments.varchar
where departments.dept_name = 'Sales';


	
	
	
	
	
	
	
	
	
	
	
