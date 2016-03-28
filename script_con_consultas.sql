CREATE TABLE proyectos (
  CodP varchar(255) NOT NULL PRIMARY KEY,
  descripcion varchar(255),
  localidad varchar(255),
  cliente varchar(255),
  telefono varchar(255)
);

CREATE TABLE conductores (
  CodC varchar(255) NOT NULL PRIMARY KEY,
  nombre varchar(255),
  localidad varchar(255),
  categ varchar(255)
);

CREATE TABLE maquinas (
  CodM varchar(255) NOT NULL PRIMARY KEY,
  nombre varchar(255),
  preciohora int
);

CREATE TABLE trabajos (
  CodP varchar(255),
  CodC varchar(255),
  CodM varchar(255),
  fecha DATE,
  tiempo int,
  CONSTRAINT fk_CodP FOREIGN KEY (CodP) REFERENCES proyectos(CodP),
  CONSTRAINT fk_CodC FOREIGN KEY (CodC) REFERENCES conductores(CodC),
  CONSTRAINT fk_CodM FOREIGN KEY (CodM) REFERENCES maquinas(CodM)
);

INSERT INTO proyectos(CodP, descripcion, localidad, cliente, telefono) VALUES ('P01','Garaje','Lerdo','Felipe Sol', 7134589);
INSERT INTO proyectos(CodP, descripcion, localidad, cliente, telefono) VALUES ('P02','Solado','Matamoros','Jose Perez', 7141598);
INSERT INTO proyectos(CodP, descripcion, localidad, cliente, telefono) VALUES ('P03','Garaje','Lerdo','Rosa Lopez', 7195874);
INSERT INTO proyectos(CodP, descripcion, localidad, cliente, telefono) VALUES ('P04','Techado','Torreon','Jose Perez', 7144236);
INSERT INTO proyectos(CodP, descripcion, localidad, cliente, telefono) VALUES ('P05','Buhardilla','Matamoros','Ana Botijo', NULL);

INSERT INTO conductores(CodC, nombre, localidad, categ) VALUES ('C01','Jose Sanchez','Lerdo',18);
INSERT INTO conductores(CodC, nombre, localidad, categ) VALUES ('C02','Manuel Diaz','Lerdo',15);
INSERT INTO conductores(CodC, nombre, localidad, categ) VALUES ('C03','Juan Perez','Matamoros',20);
INSERT INTO conductores(CodC, nombre, localidad, categ) VALUES ('C04','Luis Ortiz','Lerdo',18);
INSERT INTO conductores(CodC, nombre, localidad, categ) VALUES ('C05','Javier Martin','Torreon',12);
INSERT INTO conductores(CodC, nombre, localidad, categ) VALUES ('C06','Carmen Perez','Matamoros',15);

INSERT INTO maquinas(CodM, nombre, preciohora) VALUES ('M01','Excavadora',15000);
INSERT INTO maquinas(CodM, nombre, preciohora) VALUES ('M02','Hormigonera',10000);
INSERT INTO maquinas(CodM, nombre, preciohora) VALUES ('M03','Volquete',11000);
INSERT INTO maquinas(CodM, nombre, preciohora) VALUES ('M04','Apisonadora',18000);

INSERT INTO trabajos(CodC,CodM,CodP, fecha, tiempo) VALUES ('C02', 'M03', 'P01', '10/09/2004', 100);
INSERT INTO trabajos(CodC,CodM,CodP, fecha, tiempo) VALUES ('C03', 'M01', 'P02', '10/09/2004', 200);
INSERT INTO trabajos(CodC,CodM,CodP, fecha, tiempo) VALUES ('C05', 'M03', 'P02', '10/09/2004', 150);
INSERT INTO trabajos(CodC,CodM,CodP, fecha, tiempo) VALUES ('C04', 'M03', 'P02', '10/09/2004', 90);
INSERT INTO trabajos(CodC,CodM,CodP, fecha, tiempo) VALUES ('C01', 'M02', 'P02', '12/09/2004', 120);
INSERT INTO trabajos(CodC,CodM,CodP, fecha, tiempo) VALUES ('C02', 'M03', 'P03', '13/09/2004', 30);
INSERT INTO trabajos(CodC,CodM,CodP, fecha, tiempo) VALUES ('C03', 'M01', 'P04', '15/09/2004', 300);
INSERT INTO trabajos(CodC,CodM,CodP, fecha, tiempo) VALUES ('C02', 'M03', 'P02', '15/09/2004', NULL);
INSERT INTO trabajos(CodC,CodM,CodP, fecha, tiempo) VALUES ('C01', 'M03', 'P04', '15/09/2004', 180);
INSERT INTO trabajos(CodC,CodM,CodP, fecha, tiempo) VALUES ('C05', 'M03', 'P04', '15/09/2004', 90);
INSERT INTO trabajos(CodC,CodM,CodP, fecha, tiempo) VALUES ('C01', 'M02', 'P04', '17/09/2004', NULL);
INSERT INTO trabajos(CodC,CodM,CodP, fecha, tiempo) VALUES ('C02', 'M03', 'P01', '18/09/2004', NULL);

SELECT nombre from conductores where CodC IN (SELECT CodC FROM trabajos where CodP IN (select CodP from proyectos where localidad = 'Lerdo') AND CodM IN (select CodM from maquinas where nombre = 'Hormigonera'));
SELECT conductores.nombre from trabajos inner join conductores on (trabajos.CodC = conductores.CodC) inner join proyectos on (proyectos.CodP = trabajos.CodP) inner join maquinas on (maquinas.CODM = trabajos.CODM) where maquinas.nombre = 'Hormigonera' and proyectos.localidad = 'Lerdo';
SELECT * from conductores join trabajos using(CodC) join maquinas using (CodM) join proyectos using(CodP) where maquinas.nombre = 'Hormigonera' and proyectos.localidad = 'Lerdo';

/* 12 Ejercicios */

SELECT DISTINCT(conductores.nombre), conductores.localidad from conductores natural join trabajos join proyectos using(CodP) where proyectos.cliente != 'Jose Perez';
SELECT * from conductores natural join trabajos join proyectos using(CodP) where proyectos.localidad = 'Matamoros' and proyectos.cliente = 'Jose Perez';
SELECT * from conductores natural join trabajos where trabajos.tiempo IS null;
SELECT conductores.nombre, conductores.localidad from conductores natural join trabajos join proyectos using(CodP) where trabajos.fecha = '15/09/2004';
SELECT DISTINCT(conductores.nombre) from conductores natural join trabajos join proyectos using(CodP) where conductores.nombre like '%Perez' and conductores.localidad != proyectos.localidad;
SELECT conductores.nombre, proyectos.localidad, proyectos.cliente from conductores natural join trabajos join proyectos using(CodP) join maquinas using (CodM) where maquinas.preciohora in (SELECT max(preciohora) from maquinas);
SELECT sum(tiempo), proyectos.cliente from proyectos natural join trabajos group by proyectos.cliente;
CREATE VIEW mayor_proyecto AS
  SELECT proyectos.descripcion, proyectos.cliente, totalapagar, (totalapagar * 0.12) as totalconimpuestos from (
    SELECT totalapagar, CodP FROM (
      SELECT sum(tiempo * preciohora) as totalapagar, 
      trabajos.CodP 
      from trabajos natural join maquinas group by trabajos.CodP ORDER BY totalapagar DESC
    ) where rownum <= 1
  ) natural join proyectos;
SELECT max(trabajos.tiempo), trabajos.CodP FROM trabajos group by CodP having COUNT(CodC) > 2;
SELECT localidad from conductores natural join trabajos group by localidad having COUNT(CodP) > 2;
CREATE view conductores_media AS
  SELECT conductores.nombre, 
    proyectos.descripcion, 
    avg(trabajos.tiempo) as media 
  from conductores natural join trabajos natural join proyectos group by conductores.nombre, proyectos.DESCRIPCION;
CREATE VIEW trabajos_despues_de_15 AS
  SELECT * FROM trabajos where fecha > '15/09/2015';