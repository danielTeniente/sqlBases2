use master
go
create database UniversidadDB
go
use [UniversidadDB]
go
--drop database UniversidadDB
CREATE TABLE [AVANCE]
( 
	[ID_AVANCE]          varchar(18) primary key NOT NULL ,
	[DOCUMENTOS]         varchar(100)  NULL ,
	[FECHA]              datetime  NULL ,
	[ID_TRABAJO]         varchar(18)  NULL 
)
go

CREATE TABLE [CARRERA]
( 
	[ID_CARRERA]         varchar(18) primary key  NOT NULL ,
	[NOMBRE]             varchar(25)  NULL ,
	[DESCRIPCION]        varchar(100)  NULL ,
	[NUM_SEMESTRES]      int  NULL ,
	[ID_FACULTAD]        varchar(18)  NOT NULL 
)
go


CREATE TABLE [COMENTARIOS]
( 
	[ID_COMENTARIOS]     varchar(18) primary key NOT NULL ,
	[CONTENIDO]          varchar(100)  NULL ,
	[FECHA_CREACION]     datetime  NULL ,
	[ID_AVANCE]          varchar(18)  NULL 
)
go

CREATE TABLE [DIRECTOR]
( 
	[ID_DIRECTOR]        varchar(18) primary key NOT NULL ,
	[NOMBRE]             varchar(50)  NULL ,
	[CORREO]             varchar(25)  NULL ,
	[TELEFONO]           int  NULL ,
	[CEDULA]             int  NULL ,
	[TITULO]             varchar(50)  NULL ,
	[ID_CARRERA]         varchar(18)  NOT NULL 
)
go

CREATE TABLE [ESTUDIANTE]
( 
	[ID_ESTUDIANTE]      varchar(18) primary key NOT NULL ,
	[NOMBRE]             varchar(50)  NULL ,
	[CEDULA]             int  NULL ,
	[CORREO]             varchar(50)  NULL ,
	[TELEF]              int  NULL ,
	[DIRECCION]          varchar(50)  NULL ,
	[ID_CARRERA]         varchar(18)  NOT NULL ,
	[ID_TRABAJO]         varchar(18)  NULL 
)
go

CREATE TABLE [FACULTAD]
( 
	[ID_FACULTAD]        varchar(18) primary key NOT NULL ,
	[NOMBRE]             varchar(50)  NULL ,
	[UBICACION]          varchar(50)  NULL ,
	[ID_UNIVERSIDAD]     varchar(18)  NOT NULL 
)
go

CREATE TABLE [PROFESOR]
( 
	[ID_PROFESOR]        varchar(18) primary key NOT NULL ,
	[NOMBRE]             varchar(50)  NULL ,
	[CORREO]             varchar(50)  NULL ,
	[NUM_TELF]           int  NULL 
)
go

CREATE TABLE [TRABAJO_TITULACION]
( 
	[ID_TRABAJO]         varchar(18) primary key NOT NULL ,
	[DESCRIPCION]        varchar(100)  NULL ,
	[TEMA]               varchar(50)  NULL ,
	[ESTADO]             varchar(25)  NULL ,
	[ID_PROFESOR]        varchar(18)  NULL 
)
go

CREATE TABLE [Universidad]
( 
	[ID_UNIVERSIDAD]     varchar(18) primary key NOT NULL ,
	[NOMBRE_UNIVERSIDAD] varchar(50)  NULL ,
	[NUMERO_ESTUDIANTES] int  NULL ,
	[CATEGORIA]          varchar(18)  NULL ,
	[NUM_CAMPUS]         int  NULL 
)
go

CREATE TABLE [UNIVERSIDAD_PROFESOR]
( 
	[DESCRIPCION]        varchar(50)  NULL ,
	[ID_UNIVERSIDAD]     varchar(18)  NOT NULL ,
	[ID_PROFESOR]        varchar(18)  NOT NULL 
)
go

ALTER TABLE [UNIVERSIDAD_PROFESOR]
	ADD CONSTRAINT [XPKUNIVERSIDAD_PROFESOR] PRIMARY KEY  CLUSTERED ([ID_UNIVERSIDAD] ASC,[ID_PROFESOR] ASC)
go


ALTER TABLE [AVANCE]
	ADD CONSTRAINT [R_12] FOREIGN KEY ([ID_TRABAJO]) REFERENCES [TRABAJO_TITULACION]([ID_TRABAJO])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [CARRERA]
	ADD CONSTRAINT [R_2] FOREIGN KEY ([ID_FACULTAD]) REFERENCES [FACULTAD]([ID_FACULTAD])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [COMENTARIOS]
	ADD CONSTRAINT [R_13] FOREIGN KEY ([ID_AVANCE]) REFERENCES [AVANCE]([ID_AVANCE])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [DIRECTOR]
	ADD CONSTRAINT [R_3] FOREIGN KEY ([ID_CARRERA]) REFERENCES [CARRERA]([ID_CARRERA])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [ESTUDIANTE]
	ADD CONSTRAINT [R_4] FOREIGN KEY ([ID_CARRERA]) REFERENCES [CARRERA]([ID_CARRERA])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ESTUDIANTE]
	ADD CONSTRAINT [R_10] FOREIGN KEY ([ID_TRABAJO]) REFERENCES [TRABAJO_TITULACION]([ID_TRABAJO])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [FACULTAD]
	ADD CONSTRAINT [R_1] FOREIGN KEY ([ID_UNIVERSIDAD]) REFERENCES [Universidad]([ID_UNIVERSIDAD])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [TRABAJO_TITULACION]
	ADD CONSTRAINT [R_11] FOREIGN KEY ([ID_PROFESOR]) REFERENCES [PROFESOR]([ID_PROFESOR])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [UNIVERSIDAD_PROFESOR]
	ADD CONSTRAINT [R_7] FOREIGN KEY ([ID_UNIVERSIDAD]) REFERENCES [Universidad]([ID_UNIVERSIDAD])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [UNIVERSIDAD_PROFESOR]
	ADD CONSTRAINT [R_9] FOREIGN KEY ([ID_PROFESOR]) REFERENCES [PROFESOR]([ID_PROFESOR])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

--índices para estudiantes alfabéticamente
select * from ESTUDIANTE;
select nombre from ESTUDIANTE
create nonclustered index idx_NOMBRE_ESTUDIANTE
ON estudiante(NOMBRE)
--indice para comentarios por fecha
create nonclustered index idx_FECHA_COMENTARIO
ON COMENTARIOS(FECHA_CREACION)
SELECT * FROM COMENTARIOS;
SELECT FECHA_CREACION FROM COMENTARIOS;


----INSERTS--------------

INSERT INTO Universidad VALUES ('UDLA', 'Universidad de las Americas', '8000', 'B', '4' );
INSERT INTO Universidad VALUES ('PUCE', 'Pontificia Universidad Catolica del Ecuador', '9000', 'B', '1' );
INSERT INTO Universidad VALUES ('ESPE', 'Universidad de las Fuerzas Armadas', '6000', 'A', '1' );
INSERT INTO Universidad VALUES ('UCE', 'Universidad Central del Ecuador', '7000', 'B', '1' );
INSERT INTO Universidad VALUES ('USFQ', 'Universidad San Francisco de Quito', '8000', 'A', '1' );

select * from Universidad;

INSERT INTO FACULTAD VALUES ('AD', 'Arq y diseño', 'UdlaQueri', 'UDLA' );
INSERT INTO FACULTAD VALUES ('CEA', 'Ciencias econ y adm', 'UdlaGranados', 'UDLA' );
INSERT INTO FACULTAD VALUES ('CAA', 'Com y artes audiov', 'UdlaPark', 'UDLA' );
INSERT INTO FACULTAD VALUES ('S', 'Salud', 'UdlaPark', 'UDLA' );
INSERT INTO FACULTAD VALUES ('INGCA', 'Ing y ciencias aplicadas', 'UdlaQueri', 'UDLA' );

select * from FACULTAD;

INSERT INTO CARRERA VALUES ('501', 'Arquitectura Interior', 'Estetica de un lugar y mas', '8', 'AD' );
INSERT INTO CARRERA VALUES ('471', 'Marketing', 'Conocer el mercado para identificar y satisfaces sus necesidades', '9', 'CEA' );
INSERT INTO CARRERA VALUES ('451', 'Periodismo', 'Transmitir información y despertar al mundo a través de una noticia', '8', 'CAA' );
INSERT INTO CARRERA VALUES ('721', 'Fisioterapia', 'Curar lesiones y articular movimientos', '8', 'S' );
INSERT INTO CARRERA VALUES ('511', 'Sistemas', 'Creación de software y mas mediante tecnologías', '10', 'INGCA' );

select * from CARRERA;

INSERT INTO DIRECTOR VALUES ('D501', 'Luiz Benz', 'luis.benz@udla.edu.ec', '0992873519', '1716295746','Arq de interriores','501' );
INSERT INTO DIRECTOR VALUES ('D471', 'Juan Perez', 'juan.perez@udla.edu.ec', '0997399550', '1798756437','Ing en marketing','471' );
INSERT INTO DIRECTOR VALUES ('D451', 'Pepe Lopez', 'pepe.lopeza@udla.edu.ec', '098163647', '1709877873','Lic en periodismo','451' );
INSERT INTO DIRECTOR VALUES ('D721', 'Andres Cano', 'andres.cano@udla.edu.ec', '0990984765', '0801783279','Lic en fisioterapia','721' );
INSERT INTO DIRECTOR VALUES ('D511', 'Marco Galarza', 'marco.galarza@udla.edu.ec', '0983081112', '0801190983','Ing en sistemas','511' );

select * from DIRECTOR;

INSERT INTO PROFESOR VALUES ('P001', 'Carlos Haro', 'carlos.haro@udla.edu.ec', '099311234' );
INSERT INTO PROFESOR VALUES ('P002', 'Maria Pozo', 'maria.pozo@udla.edu.ec', '0993988848' );
INSERT INTO PROFESOR VALUES ('P003', 'Andre Perez', 'andre.perez@udla.edu.ec', '0983328884' );
INSERT INTO PROFESOR VALUES ('P004', 'Pepe Ramirez', 'pepe.ramirez@udla.edu.ec', '0998988321' );
INSERT INTO PROFESOR VALUES ('P005', 'Juan Calles', 'juan.calles@udla.edu.ec', '0988821124' );

select * from PROFESOR;

INSERT INTO UNIVERSIDAD_PROFESOR VALUES ('Profesor', 'UDLA', 'P001' );
INSERT INTO UNIVERSIDAD_PROFESOR VALUES ('Profesor', 'UDLA', 'P002' );
INSERT INTO UNIVERSIDAD_PROFESOR VALUES ('Profesor', 'UDLA', 'P003' );
INSERT INTO UNIVERSIDAD_PROFESOR VALUES ('Profesor', 'UDLA', 'P004' );
INSERT INTO UNIVERSIDAD_PROFESOR VALUES ('Profesor', 'UDLA', 'P005' );

--select * from UNIVERSIDAD_PROFESOR;

INSERT INTO TRABAJO_TITULACION VALUES ('T001', 'Trabajo de titulacion uno', 'Tema de titulacion uno', 'Pendiente', 'P001' );
INSERT INTO TRABAJO_TITULACION VALUES ('T002', 'Trabajo de titulacion dos', 'Tema de titulacion dos', 'Pendiente', 'P002' );
INSERT INTO TRABAJO_TITULACION VALUES ('T003', 'Trabajo de titulacion tres', 'Tema de titulacion tres', 'Pendiente', 'P003' );
INSERT INTO TRABAJO_TITULACION VALUES ('T004', 'Trabajo de titulacion cuatro', 'Tema de titulacion cuatro', 'Pendiente', 'P004' );
INSERT INTO TRABAJO_TITULACION VALUES ('T005', 'Trabajo de titulacion cinco', 'Tema de titulacion cinco', 'Pendiente', 'P005' );

--select * from TRABAJO_TITULACION;

INSERT INTO AVANCE VALUES ('A001', 'Avance uno', '10/10/2018', 'T001' );
INSERT INTO AVANCE VALUES ('A002', 'Avance dos', '12/12/2018', 'T002' );
INSERT INTO AVANCE VALUES ('A003', 'Avance uno', '11/11/2018', 'T003' );
INSERT INTO AVANCE VALUES ('A004', 'Avance dos', '10/12/2018', 'T004' );
INSERT INTO AVANCE VALUES ('A005', 'Avance dos', '12/11/2018', 'T005' );

--select * from AVANCE;

INSERT INTO COMENTARIOS VALUES ('C001', 'Faltan objetivos especificos', '10/10/2018', 'A001' );
INSERT INTO COMENTARIOS VALUES ('C002', 'Faltan conclusiones', '12/12/2018', 'A002' );
INSERT INTO COMENTARIOS VALUES ('C003', 'Faltan anexos', '11/11/2018', 'A003' );
INSERT INTO COMENTARIOS VALUES ('C004', 'Faltan normas APA', '10/12/2018', 'A004' );
INSERT INTO COMENTARIOS VALUES ('C005', 'Tiene muchas faltas ortograficas', '10/12/2018', 'A005' );

--select * from COMENTARIOS;

INSERT INTO ESTUDIANTE VALUES ('710971', 'Eric Noel', '1716486574', 'enoelromo@gmail.com', '0993077150','Esmeraldas','511','T001' );
INSERT INTO ESTUDIANTE VALUES ('710111', 'Daniel Diaz', '1716400001', 'ddiazbedoya@gmail.com', '0993000001','Quito','511','T002' );
INSERT INTO ESTUDIANTE VALUES ('710222', 'Edwin Sanabria', '1716400002', 'esanabria@gmail.com', '0993000002','Quito','511','T003' );
INSERT INTO ESTUDIANTE VALUES ('710444', 'Jaime Flores', '1716400003', 'jflores@gmail.com', '0993000003','Quito','511','T004' );
INSERT INTO ESTUDIANTE VALUES ('710333', 'Francisco Saenz', '1716400004', 'enoelromo@gmail.com', '0993000004','Guayaquil','721','T005' );

--select * from ESTUDIANTE;

