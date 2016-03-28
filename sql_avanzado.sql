/* Count of projects per city */
SELECT COUNT(CodP), localidad from Proyectos group by localidad;

/* Conductores with more than one project per city */
SELECT COUNT(DISTINCT(CodC)), localidad from Conductores natural join trabajos group by localidad having count(DISTINCT(CodP)) > 1;

/* Conductor project count for C02 */
SELECT COUNT(DISTINCT(CodP)) from trabajos where CodC = 'C02';

/* Machine data */
SELECT CodM, sum(tiempo) from trabajos natural join maquinas group by CodM;

/* Conductores Lerdo */
SELECT CodC, count(DISTINCT(CodP)) from conductores inner join trabajos using(CodC) group by CodC having COUNT(DISTINCT(CodP)) > 2;