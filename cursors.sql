DECLARE
  m_precioHora Maquinas.precioHora%type;
  m_nombre maquinas.Nombre%type;
  m_CodM maquinas.CodM%type;
  CURSOR datosMaquina is
    SELECT precioHora, nombre, codM FROM maquinas WHERE precioHora >= 11000;
BEGIN
	OPEN datosMaquina;
	LOOP
		FETCH datosMaquina INTO m_precioHora, m_nombre, m_CodM;
		EXIT WHEN datosMaquina%notfound;
		DBMS_OUTPUT.put_line('Codigo de la maquina: ' || m_CodM || 'Nombre de la maquina: ' || m_nombre || 'Precio Hora: ' || m_precioHora);
	END LOOP;
	CLOSE datosMaquina;
END;

DECLARE
  m_precioHora Maquinas.precioHora%type;
  m_nombre maquinas.Nombre%type;
  m_CodM maquinas.CodM%type;
  CURSOR datosMaquina is
    SELECT precioHora, nombre, codM FROM maquinas WHERE precioHora >= &preciohora;
BEGIN
	OPEN datosMaquina;
	LOOP
		FETCH datosMaquina INTO m_precioHora, m_nombre, m_CodM;
		EXIT WHEN datosMaquina%notfound;
		DBMS_OUTPUT.put_line('Codigo de la maquina: ' || m_CodM || 'Nombre de la maquina: ' || m_nombre || 'Precio Hora: ' || m_precioHora);
	END LOOP;
	CLOSE datosMaquina;
END;

CREATE OR REPLACE PROCEDURE por_precio_hora(precio_hora_filtro IN INTEGER) 
AS 
  m_precioHora Maquinas.precioHora%type;
  m_nombre maquinas.Nombre%type;
  m_CodM maquinas.CodM%type;
  CURSOR datosMaquina is
    SELECT precioHora, nombre, codM FROM maquinas WHERE precioHora >= precio_hora_filtro;
BEGIN 
OPEN datosMaquina;
	LOOP
		FETCH datosMaquina INTO m_precioHora, m_nombre, m_CodM;
		EXIT WHEN datosMaquina%notfound;
		DBMS_OUTPUT.put_line('Codigo de la maquina: ' || m_CodM || 'Nombre de la maquina: ' || m_nombre || 'Precio Hora: ' || m_precioHora);
	END LOOP;
	CLOSE datosMaquina;
END; 

exec por_precio_hora(15000);



CREATE OR REPLACE PROCEDURE promedio_uso_maquina(codigo_maquina IN VARCHAR2) 
AS 
  m_promedio Trabajos.tiempo%type;
  m_CodM maquinas.CodM%type;
  CURSOR datosMaquina is
    SELECT avg(tiempo), codC FROM Trabajos  where CodC = codigo_maquina group by CODC;
BEGIN 
OPEN datosMaquina;
	LOOP
		FETCH datosMaquina INTO m_promedio, m_CodM;
    EXIT WHEN datosMaquina%notfound;
		DBMS_OUTPUT.put_line('Codigo de la maquina: ' || m_CodM || 'Promedio de la maquina: ' || m_promedio);
	END LOOP;
	CLOSE datosMaquina;
END; 

exec promedio_uso_maquina('C01');



CREATE OR REPLACE PROCEDURE promedio_maquinas
AS 
  m_promedio Trabajos.tiempo%type;
  m_CodM maquinas.CodM%type;
  CURSOR datosMaquina is
    SELECT avg(tiempo) as promedio, codM FROM Trabajos group by CODM having avg(tiempo) >= 110;
BEGIN 
  for maquina in datosMaquina
	LOOP
    EXIT WHEN datosMaquina%notfound;
		DBMS_OUTPUT.put_line('Codigo de la maquina: ' || maquina.codM || 'Promedio de la maquina: ' || maquina.promedio);
	END LOOP;
END; 

exec promedio_maquinas;

show errors;