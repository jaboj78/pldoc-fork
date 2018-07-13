create table employees (
  id pls_integer not null,
  name VARCHAR2(255),
  rank NUMBER NULL,
  max_salary NUMBER
)
/
comment on table employees is 'The table of employees';

comment on column employees.id is 'The employee ID';
comment on column employees.name is 'The employee name';
