# SQL Homework

#### Data Modelling
https://gyazo.com/4620077c03c71b3a0dc8e844bf162547

#### Data Engineering

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

#### Table Schema
https://gyazo.com/ffdad25f5371208a279264029880e630

#### Data Analysis

1. List the following details of each employee: employee number, last name, 
first name, sex, and salary

select employees.emp_no, employees.last_name, 
	employees.first_name, employees.sex, salaries.salary
from employees
left join salaries
on salaries.emp_no = employees.emp_no;

https://gyazo.com/982a6852596f3d56cd1becd682b2d498

2. List first name, last name, and hire date for employees who were hired in 1986.

select employees.first_name, employees.last_name, 
	employees.hire_date
from employees
where extract(year from "hire_date") = 1986;

https://gyazo.com/99fc6fd6321e8046624e520d03715f80

3. List the manager of each department with the following information: 
department number, department name, the manager's employee number, last name, first name.

select departments.varchar,departments.dept_name,
	dept_manager.emp_no, employees.last_name, 
	employees.first_name
from departments
right outer join dept_manager
	on dept_manager.dept_no = departments.varchar
inner join employees
	on dept_manager.emp_no = employees.emp_no;
    
https://gyazo.com/cfa60ab75a7cb332e59e76d07688352e

4. List the department of each employee with the following information: 
employee number, last name, first name, and department name.

select employees.emp_no, employees.last_name, 
	employees.first_name, departments.dept_name
from employees
join dept_emp
on dept_emp.emp_no = employees.emp_no
right outer join departments
on dept_emp.dept_no = departments.varchar;

https://gyazo.com/5825a40f58eb0ceda7268f4b6d53a220

5. List first name, last name, and sex for employees whose first name is "Hercules" 
and last names begin with "B."

select first_name, last_name, sex 
from employees
where employees.first_name = 'Hercules' 
AND employees.last_name like 'B%';

https://gyazo.com/a60d91ff566d0401eeea980361bc7643

6. List all employees in the Sales department, including their employee number, 
last name, first name, and department name.

select employees.emp_no, employees.last_name,
	employees.first_name, departments.dept_name
from employees
join dept_emp
on employees.emp_no = dept_emp.emp_no
left outer join departments
on dept_emp.dept_no = departments.varchar
where departments.dept_name = 'Sales';

https://gyazo.com/9ab8f6701d91a7c151fa86431c898942

7. List all employees in the Sales and Development departments, 
including their employee number, last name, first name, and department name

select employees.emp_no, employees.last_name,
	employees.first_name, departments.dept_name
from employees
join dept_emp
on employees.emp_no = dept_emp.emp_no
left outer join departments
on dept_emp.dept_no = departments.varchar
where departments.dept_name = 'Sales' or 
departments.dept_name = 'Development';

https://gyazo.com/9b4a2b7803dffec6faca64d41418d129

8. In descending order, list the frequency count of employee last names, i.e., 
how many employees share each last name.

select last_name, count(last_name) as "Last_name_count"
from employees
group by last_name
order by last_name;

https://gyazo.com/ce810effd0c10a414d770a42170da29f


# Bonus

1. Import the SQL database

I used psycopg2 to make a connection to my database in my computer. 
connection = ps.connect(user="yyy",
                password="xxx",
                host="127.0.0.1",
                port="5432",
                database="stores")

I copied the tables to dataframes. I used pandas.

2. Create a histogram to visualize the most common salary ranges for employees.

https://gyazo.com/198d6a63560ae56f3c97303c24cb3222

This histogram shows that there is a very reasonable distribution of salaries. More employees have lower salaries and there are very few with large salaries. This all looks normal but perhaps too nice, perhaps generated by a mathematical function for this exercise

maximum salary= 129492 -- minimum salary= 40000  

###### employee no with maximum salary = 499942 (which is the number on the badge)

3. Create a bar chart of average salary by title.

https://gyazo.com/6254fd4aa1d8bf122ab46cdb56d245c7

Conclusion: This is a fake dataset, Technique leader has no salary,
the other titles are not very different from each other (in average)
and there is no information about manager's salary




