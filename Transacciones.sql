use UniversidadDB

-------------------------------BLOQUEOS---------------------------------------

--Transaccion 1:
--La universidad como parte del plan de correcciones de trabajos de titulaci�n, 
--realiza un aumento del comentario en el avance 1 "A001" (del trabajo de titulaci�n 1 "T001" con el del profesor 1 "P001")
begin tran modificarcomentario
	update COMENTARIOS
    set CONTENIDO= CONTENIDO + ' y generales'
    where ID_AVANCE='A001'
    save tran p1
    rollback tran p1
commit tran modificarcomentario
	
SELECT * FROM COMENTARIOS

--Transaccion 2:
--Se realiza un cambio de comentarios entre el avance 1 y 2, ya que hubo una confusi�n al revisar.
begin tran cambiarcomentarios
    update COMENTARIOS set CONTENIDO='Faltan conclusiones y recomendaciones' where ID_AVANCE='A001'
	update COMENTARIOS set CONTENIDO='Faltan todos los objetivos' where ID_AVANCE='A002'
    save tran p2
    rollback tran p2
commit tran  cambiarcomentarios

SELECT * FROM COMENTARIOS

--tipos de bloqueo
--Estos cambios, demuestran la forma en que se presentan los bloqueos que se pueden generar al ejecutar dichas transacciones (tipos de bloqueo).
sp_lock

--------------------------------------------------------------------------------------

-------------------------------RECUPERABILIDAD---------------------------------------



/*
Transacci�n de concurrencia, actualizaci�n de comentarios
evitando errores de concurrencia y garantizando la consistencia de informaci�n durante la transacci�n sin bloquear los recursos.
*/


USE UniversidadDB


ALTER DATABASE UniversidadDB SET ALLOW_SNAPSHOT_ISOLATION ON
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
BEGIN TRAN

BEGIN TRY
	UPDATE COMENTARIOS SET CONTENIDO = 'bien' WHERE ID_COMENTARIOS = 'C001' 
	UPDATE COMENTARIOS SET CONTENIDO = CONTENIDO + 'y recomendaciones' WHERE ID_COMENTARIOS = 'C002'
	COMMIT TRAN
END TRY

BEGIN CATCH
	PRINT('ERROR EN LA TRANSACCION')
	ROLLBACK TRAN
END CATCH


SELECT * FROM COMENTARIOS
