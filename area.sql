DECLARE
  pi double precision:= 3.1416;
  radio number:= 5;
BEGIN
  dbms_output.put_line('comida: ' || pi);
END;

CREATE TABLE EMP(
  ID INT NOT NULL,
  NAME VARCHAR(20) NOT NULL,
  AGE INT NOT NULL,
  ADDRESS CHAR(25),
  SALARY DECIMAL(18,2),
  PRIMARY KEY(ID)
)