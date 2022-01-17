-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT emp_no, first_name, last_name
FROM employees

-- Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT titles, from_date, to_date
FROM titles

-- Create a new table using the INTO clause and join both tables on the primary key.
SELECT emp.emp_no, emp.first_name, emp.last_name, t.title, t.from_date, t.to_date 
INTO retirement_titles
FROM employees as emp
INNER JOIN titles as t
ON emp.emp_no = t.emp_no
WHERE(birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

SELECT * FROM retirement_titles;

-- Use Dictinct with Order by to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE to_date=('9999-01-01')
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles

-- Retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT DESC;

SELECT * FROM retiring_titles

-- Deliverable 2
-- Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
SELECT DISTINCT ON (emp.emp_no) emp.emp_no, emp.first_name, emp.last_name, emp.birth_date, depemp.from_date, depemp.to_date, t.title 
INTO mentorship_eligibility
FROM employees as emp
LEFT JOIN dept_emp as depemp
ON (emp.emp_no = depemp.emp_no)
LEFT JOIN titles as t
ON (emp.emp_no=t.emp_no)
WHERE(emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (depemp.to_date = '9999-01-01')
ORDER BY emp_no

SELECT * FROM mentorship_eligibility
