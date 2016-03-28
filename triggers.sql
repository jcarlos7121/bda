create table department (
  code varchar(3) primary key,
  chair varchar(11),
  name varchar(40) not null
);

create table person(
  pId varchar(11) primary key, 
  dob date not null,
  firstName varchar(20) not null,
  lastName  varchar(20) not null
);
  
create table faculty(
  pId varchar(11) primary key,
  rank	   varchar(10) not null,
  dept	   varchar(3) not null,
  constraint rankValue check (rank in ('Assistant', 'Associate', 'Full', 'Emeritus')),
  constraint facultyPIdFk foreign key (pId) references person (pId),
  constraint facultyDeptFk foreign key (dept) references department (code)
);
alter table department
add constraint departmentChairFk foreign key(chair)
references faculty(pId) on delete set null;

create table student(
  pId varchar(11) primary key,
  status varchar(10)   not null,
  major varchar(3) not null,
  constraint statusValue check (status in ('Freshman', 'Sophomore', 'Junior', 'Senior',  'Graduate')),
  constraint studentPIdFk foreign key (pId) references person(pId),
  constraint studentMajorFk foreign key (major) references department (code)
);

create table campusclub(
  cId	varchar(10) primary key,
  name	varchar(50) not null,
  phone varchar(12),
  location varchar(40),
  advisor varchar(11),
  constraint campusclubAdvisor_Fk foreign key(advisor
) references faculty(pId) on delete set null);

create table clubs(
  pId	varchar(11)  not null,
  cId	varchar(10)  not null,
  constraint clubsPk primary key(pId, cId),
  constraint clubsPIdFk foreign key (pId) references student(pId) on delete cascade,
  constraint clubsCIdFk foreign key (cId) references campusclub(cId) on delete cascade
);

drop trigger afterUpdateRank;

create or replace trigger afterUpdateRank
before update on faculty
for each row
when(old.rank = 'Assistant' and new.rank = 'Associate')
begin
  :new.salary := :old.salary * 1.1;
end;

create or replace trigger afterPersonRenameJuan
after update on person
for each row
when(new.firstname = 'Juan')
begin
  update faculty set salary = salary * 1.1 where pid = :new.pid;
end;

create or replace trigger limitSalaryUpSet
before update on faculty
for each row
when(new.salary > 1000)
begin
  RAISE_APPLICATION_ERROR(-20101, 'Cannot update salary bigger than 1000');
end;

show errors;

Select * from Faculty;
update Faculty set rank = 'Associate' where PID = 1;
update person set firstname = 'Juan' where pid = 1;
update faculty set salary = 1700 where pid = 1;