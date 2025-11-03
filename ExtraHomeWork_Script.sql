CREATE TABLE IF NOT EXISTS Employee(
	id SERIAL PRIMARY KEY,
	name VARCHAR(60),
	department VARCHAR(60)
);

CREATE TABLE IF NOT EXISTS Employer(
	id SERIAL PRIMARY KEY,
	name VARCHAR(60)
);

CREATE TABLE IF NOT EXISTS EmployeeList(
	employee_id INTEGER REFERENCES Employee(id),
	employer_id INTEGER REFERENCES Employer(id),
	CONSTRAINT pp PRIMARY KEY (employee_id, employer_id)
);

