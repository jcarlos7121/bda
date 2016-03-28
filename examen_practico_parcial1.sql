SELECT DISTINCT(conductores.nombre), conductores.localidad 
  from conductores where CodC not in (
    SELECT DISTINCT(trabajos.CodC) from proyectos natural join trabajos where proyectos.localidad = 'Torreon'  
  );
  
CREATE VIEW tiempo_maquinas AS
  SELECT sum(trabajos.tiempo) as maquina_tiempo, trabajos.CodM from trabajos 
  group by trabajos.CODM HAVING COUNT(CodP) > 1;
  

  SELECT sum(trabajos.tiempo) as maquina_tiempo, trabajos.CodM 
    from trabajos group by trabajos.CODM HAVING COUNT(DISTINCT(CodP)) > 1;


SELECT CODM from tiempo_maquinas where maquina_tiempo in (SELECT max(maquina_tiempo) FROM tiempo_maquinas);
SELECT CODM, max(maquina_tiempo) from tiempo_maquinas group by CODM;
SELECT * FROM maquinas where CodM in (SELECT CodM from tiempo_maquinas where rownum <= 1);