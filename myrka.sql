-- Database: MYL

--DROP DATABASE "MYL";

--CREATE DATABASE "MYL"
  --  WITH 
  --  OWNER = postgres
  --  ENCODING = 'UTF8'
  --  LC_COLLATE = 'Spanish_Mexico.1252'
  --  LC_CTYPE = 'Spanish_Mexico.1252'
  --  TABLESPACE = pg_default
  --  CONNECTION LIMIT = -1;
	
DROP TABLE IF EXISTS areas_horarios;
DROP TABLE IF EXISTS areas_servicios;
DROP TABLE IF EXISTS horarios;
DROP TABLE IF EXISTS horarios_disponibles;
DROP TABLE IF EXISTS tareas_materiales;
DROP TABLE IF EXISTS supervisiones;
DROP TABLE IF EXISTS ordenes_servicios_contratistas;
DROP TABLE IF EXISTS ordenes_servicios_personas;
DROP TABLE IF EXISTS ordenes_servicio;
DROP TABLE IF EXISTS tareas;
DROP TABLE IF EXISTS servicios_materiales;
DROP TABLE IF EXISTS servicios;
DROP TABLE IF EXISTS areas;
DROP TABLE IF EXISTS tipos_areas;
DROP TABLE IF EXISTS contratistas;
DROP TABLE IF EXISTS secciones_bodega;
DROP TABLE IF EXISTS incidentes;
DROP TABLE IF EXISTS tipos_incidentes;
DROP TABLE IF EXISTS ordenes_despacho_material;
DROP TABLE IF EXISTS ordenes_despacho;
DROP TABLE IF EXISTS solicitudes_compra_material;
DROP TABLE IF EXISTS solicitudes_compra;
DROP TABLE IF EXISTS materiales_proveedores;
DROP TABLE IF EXISTS recursos_materiales;
DROP TABLE IF EXISTS categorias_materiales;
DROP TABLE IF EXISTS tipos_materiales;
DROP TABLE IF EXISTS proveedores;
DROP TABLE IF EXISTS personas;
DROP TABLE IF EXISTS puestos;


CREATE TABLE tipos_areas (
 id SERIAL PRIMARY KEY,
 nombre VARCHAR
);

CREATE TABLE areas (
 id SERIAL PRIMARY KEY,
 tamaño int,
 nombre VARCHAR,
 piso int,
 tipo_area INTEGER REFERENCES tipos_areas(id)
);

CREATE TABLE horarios_disponibles (
 id SERIAL PRIMARY KEY,
 hora_inicio time,
 hora_fin time,
 dia VARCHAR
);

CREATE TABLE areas_horarios (
 id SERIAL PRIMARY KEY,
 horario_disp INTEGER REFERENCES horarios_disponibles(id),
 area INTEGER REFERENCES areas(id)
);

CREATE TABLE servicios (
 id SERIAL PRIMARY KEY,
 nombre VARCHAR,
 duracion int,
 tipo_servicio int
);

CREATE TABLE areas_servicios (
 id SERIAL PRIMARY KEY,
 periodicidad int,
 servicio INTEGER REFERENCES servicios(id),
 tipo_area INTEGER REFERENCES tipos_areas(id)
);

CREATE TABLE puestos (
 id SERIAL PRIMARY KEY,
 nombre VARCHAR
);

CREATE TABLE personas (
 id SERIAL PRIMARY KEY,
 nombre VARCHAR,
 CURP VARCHAR,
 estatus int,
 puesto INTEGER REFERENCES puestos(id)
);

CREATE TABLE tareas (
 id SERIAL PRIMARY KEY,
 duracion int,
 supervisor INTEGER REFERENCES personas(id),
 servicio INTEGER REFERENCES servicios(id),
 area INTEGER REFERENCES areas(id)
);

CREATE TABLE horarios (
 id SERIAL PRIMARY KEY,
 hora_inicio time,
 hora_fin time,
 fecha_inicio date,
 fecha_fin date,
 persona INTEGER REFERENCES personas(id),
 tarea INTEGER REFERENCES tareas(id)
);

CREATE TABLE supervisiones (
 id SERIAL PRIMARY KEY,
 valoracion int,
 persona INTEGER REFERENCES personas(id),
 tarea INTEGER REFERENCES tareas(id)
);

CREATE TABLE proveedores (
 id SERIAL PRIMARY KEY,
 nombre varchar,
 RFC varchar,
 telefono varchar,
 direccion varchar
);

CREATE TABLE solicitudes_compra (
 id SERIAL PRIMARY KEY,
 cantidad_total int,
 fecha_emision date,
 fecha_entrega_prometida date,
 tipo_pago int,
 costo_total numeric,
 clave_factura varchar,
 clave_cheque varchar,
 proveedor INTEGER REFERENCES proveedores(id),
 persona INTEGER REFERENCES personas(id)
);

CREATE TABLE categorias_materiales (
 id SERIAL PRIMARY KEY,
 nombre VARCHAR(200)
);

CREATE TABLE tipos_materiales (
 id SERIAL PRIMARY KEY,
 nombre VARCHAR
);

CREATE TABLE recursos_materiales (
 id SERIAL PRIMARY KEY,
 nombre varchar,
 categoria INTEGER REFERENCES categorias_materiales(id),
 tipo INTEGER REFERENCES tipos_materiales(id)
);

CREATE TABLE solicitudes_compra_material (
 id SERIAL PRIMARY KEY,
 cantidad int,
 costo_individual numeric,
 costo_total numeric,
 solicitud_compra INTEGER REFERENCES solicitudes_compra(id),
 recurso_material INTEGER REFERENCES recursos_materiales(id)
);

CREATE TABLE servicios_materiales (
 id SERIAL PRIMARY KEY,
 cantidad int,
 tipo_area INTEGER REFERENCES tipos_areas(id),
 servicio INTEGER REFERENCES servicios(id),
 recurso_material INTEGER REFERENCES recursos_materiales(id)
);

CREATE TABLE materiales_proveedores (
 id SERIAL PRIMARY KEY,
 costo numeric,
 minimo int,
 proveedor INTEGER REFERENCES proveedores(id),
 recurso_material INTEGER REFERENCES recursos_materiales(id)
);

CREATE TABLE ordenes_despacho (
 id SERIAL PRIMARY KEY,
 fecha_entrega timestamp,
 solicitud_compra INTEGER REFERENCES solicitudes_compra(id)
);

CREATE TABLE ordenes_despacho_material (
 id SERIAL PRIMARY KEY,
 fecha_caducidad date,
 cantidad_recibida int,
 orden_despacho INTEGER REFERENCES ordenes_despacho(id),
 recurso_material INTEGER REFERENCES recursos_materiales(id)
);

CREATE TABLE tipos_incidentes (
 id SERIAL PRIMARY KEY,
 nombre varchar,
 descripcion varchar
);

CREATE TABLE incidentes (
 id SERIAL PRIMARY KEY,
 fecha timestamp,
 clave_nota_credito varchar,
 clave_nota_debito varchar,
 tipo_incidente INTEGER REFERENCES tipos_incidentes(id),
 persona INTEGER REFERENCES personas(id),
 recurso_material INTEGER REFERENCES recursos_materiales(id)
);

CREATE TABLE secciones_bodega (
 id SERIAL PRIMARY KEY,
 nombre varchar,
 tamaño int,
 estante int,
 numero int,
 recurso_material INTEGER REFERENCES recursos_materiales(id)
);

CREATE TABLE tareas_materiales (
 id SERIAL PRIMARY KEY,
 cantidad_entregada int,
 recurso_material INTEGER REFERENCES recursos_materiales(id),
 tarea INTEGER REFERENCES tareas(id),
 persona INTEGER REFERENCES personas(id)
);

CREATE TABLE ordenes_servicio (
 id SERIAL PRIMARY KEY,
 fecha date,
 prioridad int,
 tarea INTEGER REFERENCES tareas(id),
 persona INTEGER REFERENCES personas(id)
);

CREATE TABLE ordenes_servicios_personas (
 id SERIAL PRIMARY KEY,
 orden_servicio INTEGER REFERENCES ordenes_servicio(id),
 persona INTEGER REFERENCES personas(id)
);

CREATE TABLE contratistas (
 id SERIAL PRIMARY KEY,
 nombre varchar,
 direccion varchar,
 numero varchar
);

CREATE TABLE ordenes_servicios_contratistas (
 id SERIAL PRIMARY KEY,
 costo numeric,
 tiempo int,
 orden_servicio INTEGER REFERENCES ordenes_servicio(id),
 contratista INTEGER REFERENCES contratistas(id)
);




---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--TIPOS DE AREAS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO tipos_areas (nombre) VALUES ('Entrada');
INSERT INTO tipos_areas (nombre) VALUES ('Pasillo');
INSERT INTO tipos_areas (nombre) VALUES ('Local');
INSERT INTO tipos_areas (nombre) VALUES ('Baño interno');
INSERT INTO tipos_areas (nombre) VALUES ('Baño externo');
INSERT INTO tipos_areas (nombre) VALUES ('Jardín');
INSERT INTO tipos_areas (nombre) VALUES ('Estacionamiento');

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--AREAS DE LA PLAZA
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (14, 'PBE01', 1, 1);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (14, 'PBE02', 1, 1);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (500, 'PBPP', 1, 2);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (15, 'PAL21', 2, 3);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (15, 'PAL20', 2, 3);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (17, 'PAL19', 2, 3);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (16, 'PBL11', 1, 3);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (20, 'PBL10', 1, 3);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (22, 'PBL09', 1, 3);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (25, 'PBL10', 1, 3);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (2, 'PBBI05', 1, 4);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (2, 'PBBI06', 1, 4);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (2, 'PBBI07', 1, 4);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (2, 'PBBI08', 1, 4);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (2, 'PABI05', 2, 4);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (2, 'PABI06', 2, 4);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (2, 'PABI07', 2, 4);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (2, 'PABI08', 2, 4);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (50, 'PBBE01', 1, 5);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (50, 'PBBE02', 1, 5);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (50, 'PABE01', 2, 5);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (50, 'PABE02', 2, 5);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (30, 'PBJ01', 1, 6);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (35, 'PBJ02', 1, 6);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (28, 'PBJ03', 1, 6);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (40, 'PBJ04', 1, 6);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (660, 'PBE01', 1, 7);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (660, 'PBE02', 1, 7);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (660, 'PBE03', 1, 7);
INSERT INTO areas (tamaño, nombre, piso, tipo_area) VALUES (660, 'PBE04', 1, 7);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--CATALOGO DE HORARIOS DISPONIBLES
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('08:00:00', '09:00:00', 'L');  --1
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('08:00:00', '09:00:00', 'MA'); --2
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('08:00:00', '09:00:00', 'M');  --3
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('08:00:00', '09:00:00', 'J');  --4
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('08:00:00', '09:00:00', 'V');  --5
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('08:00:00', '09:00:00', 'S');  --6
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('08:00:00', '09:00:00', 'D');  --7
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('08:00:00', '08:30:00', 'L');  --8
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('08:00:00', '08:30:00', 'MA'); --9
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('08:00:00', '08:30:00', 'M');  --10
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('08:00:00', '08:30:00', 'J');  --11
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('08:00:00', '08:30:00', 'V');  --12
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('08:00:00', '08:30:00', 'S');  --13
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('08:00:00', '08:30:00', 'D');  --14
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('15:30:00', '16:00:00', 'L');  --15
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('15:30:00', '16:00:00', 'MA'); --16
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('15:30:00', '16:00:00', 'M');  --17
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('15:30:00', '16:00:00', 'J');  --18
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('15:30:00', '16:00:00', 'V');  --19
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('15:30:00', '16:00:00', 'S');  --20
INSERT INTO horarios_disponibles (hora_inicio, hora_fin, dia) VALUES ('15:30:00', '16:00:00', 'D');  --21


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--HORARIOS DISPONIBLES PARA REALIZAR LIMPIEZA EN CADA AREA DE LA PLAZA
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO areas_horarios (area, horario_disp) VALUES (1, 8);
INSERT INTO areas_horarios (area, horario_disp) VALUES (1, 9);
INSERT INTO areas_horarios (area, horario_disp) VALUES (1, 10);
INSERT INTO areas_horarios (area, horario_disp) VALUES (1, 11);
INSERT INTO areas_horarios (area, horario_disp) VALUES (1, 12);
INSERT INTO areas_horarios (area, horario_disp) VALUES (1, 13);
INSERT INTO areas_horarios (area, horario_disp) VALUES (1, 14);

INSERT INTO areas_horarios (area, horario_disp) VALUES (2, 8);
INSERT INTO areas_horarios (area, horario_disp) VALUES (2, 9);
INSERT INTO areas_horarios (area, horario_disp) VALUES (2, 10);
INSERT INTO areas_horarios (area, horario_disp) VALUES (2, 11);
INSERT INTO areas_horarios (area, horario_disp) VALUES (2, 12);
INSERT INTO areas_horarios (area, horario_disp) VALUES (2, 13);
INSERT INTO areas_horarios (area, horario_disp) VALUES (2, 14);

INSERT INTO areas_horarios (area, horario_disp) VALUES (3, 8);
INSERT INTO areas_horarios (area, horario_disp) VALUES (3, 9);
INSERT INTO areas_horarios (area, horario_disp) VALUES (3, 10);
INSERT INTO areas_horarios (area, horario_disp) VALUES (3, 11);
INSERT INTO areas_horarios (area, horario_disp) VALUES (3, 12);
INSERT INTO areas_horarios (area, horario_disp) VALUES (3, 13);
INSERT INTO areas_horarios (area, horario_disp) VALUES (3, 14);

INSERT INTO areas_horarios (area, horario_disp) VALUES (4, 8);
INSERT INTO areas_horarios (area, horario_disp) VALUES (4, 9);
INSERT INTO areas_horarios (area, horario_disp) VALUES (4, 10);
INSERT INTO areas_horarios (area, horario_disp) VALUES (4, 11);
INSERT INTO areas_horarios (area, horario_disp) VALUES (4, 12);
INSERT INTO areas_horarios (area, horario_disp) VALUES (4, 13);
INSERT INTO areas_horarios (area, horario_disp) VALUES (4, 14);

INSERT INTO areas_horarios (area, horario_disp) VALUES (5, 8);
INSERT INTO areas_horarios (area, horario_disp) VALUES (5, 9);
INSERT INTO areas_horarios (area, horario_disp) VALUES (5, 10);
INSERT INTO areas_horarios (area, horario_disp) VALUES (5, 11);
INSERT INTO areas_horarios (area, horario_disp) VALUES (5, 12);
INSERT INTO areas_horarios (area, horario_disp) VALUES (5, 13);
INSERT INTO areas_horarios (area, horario_disp) VALUES (5, 14);

INSERT INTO areas_horarios (area, horario_disp) VALUES (6, 8);
INSERT INTO areas_horarios (area, horario_disp) VALUES (6, 9);
INSERT INTO areas_horarios (area, horario_disp) VALUES (6, 10);
INSERT INTO areas_horarios (area, horario_disp) VALUES (6, 11);
INSERT INTO areas_horarios (area, horario_disp) VALUES (6, 12);
INSERT INTO areas_horarios (area, horario_disp) VALUES (6, 13);
INSERT INTO areas_horarios (area, horario_disp) VALUES (6, 14);

INSERT INTO areas_horarios (area, horario_disp) VALUES (7, 1);
INSERT INTO areas_horarios (area, horario_disp) VALUES (7, 2);
INSERT INTO areas_horarios (area, horario_disp) VALUES (7, 3);
INSERT INTO areas_horarios (area, horario_disp) VALUES (7, 4);
INSERT INTO areas_horarios (area, horario_disp) VALUES (7, 5);
INSERT INTO areas_horarios (area, horario_disp) VALUES (7, 6);
INSERT INTO areas_horarios (area, horario_disp) VALUES (7, 7);

INSERT INTO areas_horarios (area, horario_disp) VALUES (8, 15);
INSERT INTO areas_horarios (area, horario_disp) VALUES (8, 16);
INSERT INTO areas_horarios (area, horario_disp) VALUES (8, 17);
INSERT INTO areas_horarios (area, horario_disp) VALUES (8, 18);
INSERT INTO areas_horarios (area, horario_disp) VALUES (8, 19);
INSERT INTO areas_horarios (area, horario_disp) VALUES (8, 20);
INSERT INTO areas_horarios (area, horario_disp) VALUES (8, 21);


INSERT INTO areas_horarios (area, horario_disp) VALUES (9, 15);
INSERT INTO areas_horarios (area, horario_disp) VALUES (9, 16);
INSERT INTO areas_horarios (area, horario_disp) VALUES (9, 17);
INSERT INTO areas_horarios (area, horario_disp) VALUES (9, 18);
INSERT INTO areas_horarios (area, horario_disp) VALUES (9, 19);
INSERT INTO areas_horarios (area, horario_disp) VALUES (9, 20);
INSERT INTO areas_horarios (area, horario_disp) VALUES (9, 21);


INSERT INTO areas_horarios (area, horario_disp) VALUES (10, 8);
INSERT INTO areas_horarios (area, horario_disp) VALUES (10, 9);
INSERT INTO areas_horarios (area, horario_disp) VALUES (10, 10);
INSERT INTO areas_horarios (area, horario_disp) VALUES (10, 11);
INSERT INTO areas_horarios (area, horario_disp) VALUES (10, 12);
INSERT INTO areas_horarios (area, horario_disp) VALUES (10, 13);
INSERT INTO areas_horarios (area, horario_disp) VALUES (10, 14);

INSERT INTO areas_horarios (area, horario_disp) VALUES (11, 1);
INSERT INTO areas_horarios (area, horario_disp) VALUES (11, 2);
INSERT INTO areas_horarios (area, horario_disp) VALUES (11, 3);
INSERT INTO areas_horarios (area, horario_disp) VALUES (11, 4);
INSERT INTO areas_horarios (area, horario_disp) VALUES (11, 5);
INSERT INTO areas_horarios (area, horario_disp) VALUES (11, 6);
INSERT INTO areas_horarios (area, horario_disp) VALUES (11, 7);

INSERT INTO areas_horarios (area, horario_disp) VALUES (12, 1);
INSERT INTO areas_horarios (area, horario_disp) VALUES (12, 2);
INSERT INTO areas_horarios (area, horario_disp) VALUES (12, 3);
INSERT INTO areas_horarios (area, horario_disp) VALUES (12, 4);
INSERT INTO areas_horarios (area, horario_disp) VALUES (12, 5);
INSERT INTO areas_horarios (area, horario_disp) VALUES (12, 6);
INSERT INTO areas_horarios (area, horario_disp) VALUES (12, 7);

INSERT INTO areas_horarios (area, horario_disp) VALUES (13, 1);
INSERT INTO areas_horarios (area, horario_disp) VALUES (13, 2);
INSERT INTO areas_horarios (area, horario_disp) VALUES (13, 3);
INSERT INTO areas_horarios (area, horario_disp) VALUES (13, 4);
INSERT INTO areas_horarios (area, horario_disp) VALUES (13, 5);
INSERT INTO areas_horarios (area, horario_disp) VALUES (13, 6);
INSERT INTO areas_horarios (area, horario_disp) VALUES (13, 7);

INSERT INTO areas_horarios (area, horario_disp) VALUES (27, 1);
INSERT INTO areas_horarios (area, horario_disp) VALUES (27, 2);
INSERT INTO areas_horarios (area, horario_disp) VALUES (27, 3);
INSERT INTO areas_horarios (area, horario_disp) VALUES (27, 4);
INSERT INTO areas_horarios (area, horario_disp) VALUES (27, 5);
INSERT INTO areas_horarios (area, horario_disp) VALUES (27, 6);
INSERT INTO areas_horarios (area, horario_disp) VALUES (27, 7);

INSERT INTO areas_horarios (area, horario_disp) VALUES (28, 1);
INSERT INTO areas_horarios (area, horario_disp) VALUES (28, 2);
INSERT INTO areas_horarios (area, horario_disp) VALUES (28, 3);
INSERT INTO areas_horarios (area, horario_disp) VALUES (28, 4);
INSERT INTO areas_horarios (area, horario_disp) VALUES (28, 5);
INSERT INTO areas_horarios (area, horario_disp) VALUES (28, 6);
INSERT INTO areas_horarios (area, horario_disp) VALUES (28, 7);

INSERT INTO areas_horarios (area, horario_disp) VALUES (29, 1);
INSERT INTO areas_horarios (area, horario_disp) VALUES (29, 2);
INSERT INTO areas_horarios (area, horario_disp) VALUES (29, 3);
INSERT INTO areas_horarios (area, horario_disp) VALUES (29, 4);
INSERT INTO areas_horarios (area, horario_disp) VALUES (29, 5);
INSERT INTO areas_horarios (area, horario_disp) VALUES (29, 6);
INSERT INTO areas_horarios (area, horario_disp) VALUES (29, 7);

INSERT INTO areas_horarios (area, horario_disp) VALUES (30, 1);
INSERT INTO areas_horarios (area, horario_disp) VALUES (30, 2);
INSERT INTO areas_horarios (area, horario_disp) VALUES (30, 3);
INSERT INTO areas_horarios (area, horario_disp) VALUES (30, 4);
INSERT INTO areas_horarios (area, horario_disp) VALUES (30, 5);
INSERT INTO areas_horarios (area, horario_disp) VALUES (30, 6);
INSERT INTO areas_horarios (area, horario_disp) VALUES (30, 7);


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SERVICIOS QUE SE LLEVAN A CABO DENTRO DE LA PLAZA
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Tipo de servicio: 1 -> preventivo | 2 -> correctivo
--La duración son los segundos por cada m2/unidad
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Barrer', 20, 1);                             --1
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Trapear', 30, 1);                            --2
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Sacudir', 15, 1);                            --3
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Limpiar fuente', 300, 1);                    --4
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Abastecer suministros de baño', 500, 1);     --5
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Corte de pasto', 60, 1);                     --6
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Podado de árboles', 7200, 1);                --7
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Lavado de taza de baño', 600, 1);            --8
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Limpieza de ventana', 300, 1);               --9
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Pintado', 300, 1);                           --10
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Reparación de aire acondicionado', null, 2); --11
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Arreglo de tuberías', null, 2);              --12
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Arreglo de pisos', null, 2);                 --13
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Arreglo de baches', 900, 2);                 --14
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Lubricación de herramientas', 300, 1);       --15
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Regar pasto', 10, 1);                        --16
INSERT INTO servicios (nombre, duracion, tipo_servicio) VALUES ('Regar plantas', 20, 1);                      --17


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SERVICIOS QUE SE LLEVAN A CABO EN CADA AREA
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Periodicidad: veces x semana

INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (1, 6, 6);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (1, 7, 6);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (1, 16, 6);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (1, 17, 6);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (7, 1, 3);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (7, 2, 3);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (7, 3, 3);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (7, 1, 4);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (7, 2, 4);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (7, 3, 4);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (7, 9, 4);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (14, 1, 5);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (14, 2, 5);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (14, 3, 5);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (14, 1, 5);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (14, 2, 5);
INSERT INTO areas_servicios (periodicidad, servicio, tipo_area) VALUES (7, 9, 1);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--PROVEEDORES
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--XXXX NUMERO
INSERT INTO proveedores (nombre, RFC, telefono, direccion) VALUES ('Bio Clean', 'BCC831118J92', '15213123125346', 'Camino Real de Colima 93, Jardines de las Lomas, 28014 Colima, Col.');
INSERT INTO proveedores (nombre, RFC, telefono, direccion) VALUES ('GLOBAL CLEAN', 'GCP971008J92', '5213121592120', '1 de Mayo # 615-C, Infonavit, 28040 Colima, Col.');
INSERT INTO proveedores (nombre, RFC, telefono, direccion) VALUES ('Comercializadora Guro 3H', 'CGH960712F7S', '5213123137676', 'osé Antonio Torres 229, Centro, 28000 Colima, Col.');
--XXXX RFC
INSERT INTO proveedores (nombre, RFC, telefono, direccion) VALUES ('Gaudi Muebles', 'GMC90DDD1209M2S', '5213123149911', 'Av. Constitución 1599, Jardines Vista Hermosa IV, 28017 Colima, Col.');
INSERT INTO proveedores (nombre, RFC, telefono, direccion) VALUES ('Muebles Dico', 'MDI910419NP3', '5213123237768', 'Esq. Ignacio Sandoval Local 159 Col, Valle Dorado, 28018 Col.');
--XXXX RFC
INSERT INTO proveedores (nombre, RFC, telefono, direccion) VALUES ('ULINE', 'ULC080SSS729YH0', '5218002955510', 'Carr. Miguel Alemán KM 21, #6, Prologis Park Apodaca, Apodaca, N.L. C.P. 66627');


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--PUESTOS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--XXXX NOMBRE
INSERT INTO puestos (nombre) VALUES ('Jefe de área de limpieza y mant3nimiento');
INSERT INTO puestos (nombre) VALUES ('Supervisor de limpieza y mantenimiento');
INSERT INTO puestos (nombre) VALUES ('Jardinero');
--XXXX NOMBRE
INSERT INTO puestos (nombre) VALUES ('Emplead0 de limpieza');
INSERT INTO puestos (nombre) VALUES ('Multitareas');


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--PERSONAS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from personas;
--Estatus: 1 -> Activo | 2 -> Inactivo

--XXXX CURP
INSERT INTO personas (nombre, CURP, estatus, puesto) VALUES ('Manuel López Sánchez', 'MALS070990MKEGSO12AA', 1, 1);
INSERT INTO personas (nombre, CURP, estatus, puesto) VALUES ('Luis Miguel Fausto Bustillos', 'MLFB031185JSLEODY6', 1, 2);
--XXXX NOMBRE
INSERT INTO personas (nombre, CURP, estatus, puesto) VALUES ('Héctor L4rios Arana', 'MLFB031185JSLEODY7', 1, 4);
INSERT INTO personas (nombre, CURP, estatus, puesto) VALUES ('Ramón Gudiño Levy', 'RGLE031185JSLEODY7', 1, 4);
INSERT INTO personas (nombre, CURP, estatus, puesto) VALUES ('Cinthya Flores Ramírez', 'CFRA031185JSLEODY7', 1, 4);
--XXXX NOMBRE
INSERT INTO personas (nombre, CURP, estatus, puesto) VALUES ('Sagrari6o Durán Espinoza', 'SADG031185JSLEODY7', 1, 4);
INSERT INTO personas (nombre, CURP, estatus, puesto) VALUES ('José Medrano Arán', 'JMEA031185JSLEODY7', 1, 4);
INSERT INTO personas (nombre, CURP, estatus, puesto) VALUES ('Francisco Chávez Padilla', 'FACP031185JSLEODY7', 1, 2);
--XXXX NOMBRE
INSERT INTO personas (nombre, CURP, estatus, puesto) VALUES ('Miguel Guzmán Urbina0', 'MGUR031185JSLEODY7', 1, 5);


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--CATEGORIAS DE MATERIALES
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO categorias_materiales (nombre) VALUES ('Trapeadores'); --1
INSERT INTO categorias_materiales (nombre) VALUES ('Letreros'); --2
INSERT INTO categorias_materiales (nombre) VALUES ('Cubetas'); --3
INSERT INTO categorias_materiales (nombre) VALUES ('Accesorios'); --4
INSERT INTO categorias_materiales (nombre) VALUES ('Jaladores'); --5
INSERT INTO categorias_materiales (nombre) VALUES ('Escobas'); --6
INSERT INTO categorias_materiales (nombre) VALUES ('Cepillos'); --7
INSERT INTO categorias_materiales (nombre) VALUES ('Recogedores'); --8
INSERT INTO categorias_materiales (nombre) VALUES ('Barredoras'); --9
INSERT INTO categorias_materiales (nombre) VALUES ('Botes basura'); --10
INSERT INTO categorias_materiales (nombre) VALUES ('Aspiradoras'); --11
INSERT INTO categorias_materiales (nombre) VALUES ('Bolsas basura'); --12
INSERT INTO categorias_materiales (nombre) VALUES ('Limpiadores multiusos'); --13
INSERT INTO categorias_materiales (nombre) VALUES ('Desinfectantes'); --14
INSERT INTO categorias_materiales (nombre) VALUES ('Limpiadores de vidrio'); --15
INSERT INTO categorias_materiales (nombre) VALUES ('Limpiadores para baños'); --16


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TIPOS DE MATERIALES
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO tipos_materiales (nombre) VALUES ('Consumibles');  --1
INSERT INTO tipos_materiales (nombre) VALUES ('Herramientas'); --2
--XXXX NOMBRE
INSERT INTO tipos_materiales (nombre) VALUES ('Equip0'); 	   --3
INSERT INTO tipos_materiales (nombre) VALUES ('Maquinaria');   --4
--XXXX NOMBRE
INSERT INTO tipos_materiales (nombre) VALUES ('Mobiliari0');   --5

select * from tipos_materiales;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--RECURSOS MATERIALES
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Simple green original 5 galones', 13, 1); --1
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Clorox 121 oz', 14, 1); --2
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Lysol 19 oz', 14, 1); --3
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Limpiador para vidrio aerosol 32 oz', 15, 1); --4
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Repuesto para impiador para vidrio 1 galón', 15, 1); --5
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Drano Max Gel 80 oz', 16, 1); --6
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Trapeador de microfibra uso pesado', 1, 2); --7
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Trapeador para acabado uso pesado', 1, 2); --8
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Trapeador de esponja', 1, 2); --9
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Sistema de trapeador de microfibra uso pesado 18'' ', 1, 2); --10
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Trapeador de microfibra para polvo', 1, 2); --11
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Letreros de piso mojado multilingüe plegable 21x30'' ', 2, 3); --12
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Cubeta exprimidor con palanca superior', 3, 2); --13
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Cubeta utilitaria 10 galones', 3, 2); --14
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Soporte para trapeadora/escoba acero inoxidable', 4, 5); --15
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Limpiador de microfibra', 5, 2); --16
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Organizador para productos de limpieza', 4, 5); --17
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Escoba para cocheras', 6, 2); --18
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Escoba para calles', 6, 2); --19
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Escoba angular', 6, 2); --20
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Recogedor con mango largo Rubbermaid Maximizer', 6, 2); --21
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Fuller Barredora', 9, 4); --22
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Rubbermaid Barredora', 9, 4); --23
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Bissell Barredora', 9, 4); --24
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Brute bote de basura 55 galones', 10, 3); --25
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Brute bote de basura 44 galones', 10, 3); --26
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Brute tapa plana bote de basura 55 galones', 10, 3); --27
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Brute tapa plana bote de basura 44 galones', 10, 3); --28
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Brute tapa plástico tipo domo bote de basura 55 galones', 10, 3); --29
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Brute tapa plástico tipo domo bote de basura 44 galones', 10, 3); --30
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Brute plataforma silenciosa con ruedas', 10, 3); --31
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Landmark series bote de basura para exteriores tapa tipo domo', 10, 3); --32
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Aspiradora industrial Sanitaire', 11, 4); --33
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Bolsa para reciclaje con jareta', 12, 1); --34
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Rgas bolsa económica para basura 44-55 galones mediana', 12, 1); --35
INSERT INTO recursos_materiales (nombre, categoria, tipo) VALUES ('Gabinete de suministros', 4, 5); --36


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--RECURSOS MATERIALES
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Tamaño: metros cuadrados

INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A1', 10, 1, 1);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A1', 10, 1, 2);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A1', 10, 1, 3);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A1', 10, 1, 4);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A1', 10, 1, 5);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A1', 10, 1, 6);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A2', 30, 5, 1);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A2', 30, 5, 2);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A2', 30, 5, 3);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A2', 30, 6, 1);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A2', 30, 6, 2);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A2', 30, 6, 3);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A3', 30, 7, 18);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A3', 30, 7, 19);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A3', 30, 7, 20);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A3', 30, 8, 12);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A3', 30, 8, 13);
INSERT INTO secciones_bodega (nombre, tamaño, estante, numero) VALUES ('A3', 30, 8, 14);


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MATERIALES QUE SE USAN EN LOS SERVICIOS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Cantidad: Unidad | ml

INSERT INTO servicios_materiales (cantidad, tipo_area, servicio, recurso_material) VALUES (1, 3, 1, 20);
INSERT INTO servicios_materiales (cantidad, tipo_area, servicio, recurso_material) VALUES (1, 3, 1, 21);
INSERT INTO servicios_materiales (cantidad, tipo_area, servicio, recurso_material) VALUES (300, 3, 2, 1);
INSERT INTO servicios_materiales (cantidad, tipo_area, servicio, recurso_material) VALUES (10, 3, 2, 2);
INSERT INTO servicios_materiales (cantidad, tipo_area, servicio, recurso_material) VALUES (1, 3, 2, 7);
INSERT INTO servicios_materiales (cantidad, tipo_area, servicio, recurso_material) VALUES (1, 3, 3, 11);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--MATERIALES DE CADA PROVEEDOR
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1700, 1, 1, 1
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1680, 6, 1, 1
);
--XXXX CANTIDAD
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	-165, 1, 1, 2
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	240, 1, 1, 3
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	125, 1, 1, 4
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	100, 12, 1, 4
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1200, 1, 1, 5
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1100, 6, 1, 5
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	970, 12, 1, 5
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	300, 1, 1, 6
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	270, 6, 1, 6
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	250, 12, 1, 6
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	352, 1, 6, 7
);
--XXXX CANTIDAD
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	-330, 12, 6, 7
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	308, 24, 6, 7
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	280, 6, 6, 8
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	260, 12, 6, 8
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	240, 24, 6, 8
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	740, 1, 6, 9
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	720, 3, 6, 9
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	660, 1, 6, 10
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	620, 3, 6, 10
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	580, 6, 6, 10
);
--XXXX CANTIDAD
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	-840, 1, 6, 11
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	800, 3, 6, 11
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	760, 6, 6, 11
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	580, 1, 6, 12
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	500, 3, 6, 12
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	3080, 1, 6, 13
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	2940, 3, 6, 13
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	340, 1, 6, 14
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	300, 3, 6, 14
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1320, 1, 2, 15
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1280, 3, 2, 15
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1240, 6, 2, 15
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	580, 1, 6, 16
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	360, 1, 2, 17
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	340, 3, 2, 17
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	460, 1, 3, 18
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	400, 6, 3, 18
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	260, 1, 3, 19
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	220, 12, 3, 19
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	460, 12, 3, 20
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1040, 1, 6, 21
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	940, 2, 6, 21
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1600, 1, 6, 22
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1520, 2, 6, 22
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1440, 1, 6, 23
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1340, 2, 6, 23
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1120, 1, 6, 24
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1080, 3, 6, 24
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1660, 1, 6, 25
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1040, 1, 6, 26
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	620, 1, 6, 27
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	600, 3, 6, 27
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	540, 6, 6, 27
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	420, 1, 6, 28
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	400, 3, 6, 28
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	380, 6, 6, 28
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	2720, 1, 6, 29
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	2600, 3, 6, 29
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	2550, 6, 6, 29
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1900, 1, 6, 30
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1820, 3, 6, 30
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1750, 6, 6, 30
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1880, 1, 6, 31
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1830, 3, 6, 31
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1750, 5, 6, 31
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	14300, 1, 6, 32
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	13500, 2, 6, 32
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	6800, 1, 6, 33
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	6590, 2, 6, 33
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	860, 1, 1, 34
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	820, 4, 1, 34
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1340, 1, 1, 35
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	1100, 8, 1, 35
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	7700, 1, 5, 36
);
INSERT INTO materiales_proveedores (costo, minimo, proveedor, recurso_material) VALUES (
	7320, 2, 5, 36
);

select * from materiales_proveedores;



---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SOLICITUDES DE COMPRA
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from solicitudes_compra;

-- Tipo pago: 1 -> Efectivo | 2 -> Tarjeta

--1
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	53, '2016-09-09', '2016-09-12', 1, 16575, 'FPML-00001', 'CPML-00001', 1, 1
);
--2
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	40, '2016-09-12', '2016-09-13', 1, 16050, 'FPML-00002', 'CPML-00002', 6, 1
);
--3
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	35, '2016-09-12', '2016-09-13', 1, 22100, 'FPML-00003', 'CPML-00003', 6, 1
);
--4
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	45, '2016-09-13', '2016-09-14', 1, 53500, 'FPML-00004', 'CPML-00004', 6, 1
);
--5
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	35, '2016-12-01', '2016-12-04', 2, 17500, 'FPML-00005', null, 6, 2
);
--6
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	45, '2016-09-17', '2016-09-19', 2, 33300, 'FPML-00006', null, 2, 1
);
--7
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	50, '2016-09-17', '2016-09-19', 2, 18800, 'FPML-00007', null, 3, 1
);
--8
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	80, '2016-09-17', '2016-09-19', 2, 72400, 'FPML-00008', null, 6, 1
);

--9
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	40, '2016-09-17', '2016-09-19', 2, 86000, 'FPML-00009', null, 6, 1
);

--10
--XXXX CANTIDAD
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	4, '2016-09-18', '2016-09-19', 2, -4400, 'FPML-00010', null, 6, 1
);

--11
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	10, '2017-06-05', '2016-06-19', 2, 135000, 'FPML-00011', null, 6, 1
);

--12
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	10, '2016-09-26', '2016-09-30', 2, 70000, 'FPML-00012', null, 6, 2
);

--13
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	5, '2016-09-27', '2016-10-02', 2, 36600, 'FPML-00013', null, 5, 1
);

--20
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	2, '2016-09-29', '2016-10-1', 1, 3400, 'FPML-00020', 'CPML-00011', 1, 2
);

--14
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	10, '2016-10-02', '2016-10-03', 1, 2400, 'FPML-00014', 'CPML-00005', 1, 2
);

--15
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	2, '2016-10-03', '2016-10-03', 1, 3400, 'FPML-00015', 'CPML-00006', 1, 2
);

--16
--XXXX CANTIDAD
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	2, '2016-10-05', '2016-10-06', 1, -1940, 'FPML-00016', 'CPML-00007', 1, 2
);

--17
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	3, '2016-10-10', '2016-10-16', 1, 3240, 'FPML-00017', 'CPML-00008', 1, 2
);

--18
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	10, '2016-10-12', '2016-10-16', 1, 3400, 'FPML-00018', 'CPML-00009', 1, 2
);

--19
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	2, '2016-10-12', '2016-10-16', 1, 3400, 'FPML-00019', 'CPML-00010', 1, 2
);

--21
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	20, '2016-10-15', '2016-10-16', 1, 3300, 'FPML-00021', 'CPML-00012', 1, 2
);

--22
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	2, '2016-10-16', '2016-10-17', 1, 1940, 'FPML-00022', 'CPML-00013', 1, 1
);

--23
--XXXX FECHA
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	15, '2013-10-18', '2016-10-19', 1, 3750, 'FPML-00023', 'CPML-00014', 1, 1
);

--24
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	10, '2016-10-19', '2016-10-19', 1, 2400, 'FPML-00024', 'CPML-00015', 1, 1
);

--25
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	37, '2016-10-28', '2016-10-29', 1, 10450, 'FPML-00025', 'CPML-00016', 1, 2
);

--26
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	12, '2016-10-29', '2016-10-30', 1, 4340, 'FPML-00026', 'CPML-00017', 1, 1
);

--27
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	37, '2016-11-12', '2016-11-14', 1, 10450, 'FPML-00027', 'CPML-00018', 1, 2
);

--28
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	12, '2016-10-15', '2016-11-16', 1, 4340, 'FPML-00028', 'CPML-00019', 2, 1
);

--29
--XXXX CANTIDAD
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	37, '2016-11-28', '2016-11-29', 1, -10450, 'FPML-00029', 'CPML-00020', 2, 2
);

--30
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	12, '2016-11-29', '2016-11-29', 1, 4340, 'FPML-00030', 'CPML-00021', 1, 1
);

--31
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2016-12-13', '2016-11-15', 1, 14790, 'FPML-00031', 'CPML-00022', 2, 2
);

--32
--XXXX FECHA
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2011-12-28', '2016-11-30', 1, 14790, 'FPML-00032', 'CPML-00023', 2, 2
);

--33
--XXXX CANTIDAD
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2017-01-12', '2017-01-15', 1, -14790, 'FPML-00033', 'CPML-00024', 2, 2
);

--34
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2017-02-12', '2017-02-15', 1, 14790, 'FPML-00034', 'CPML-00025', 2, 2
);

--35
--XXXX FECHA
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2017-03-12', '2027-03-15', 1, 14790, 'FPML-00035', 'CPML-00026', 2, 2
);

--36
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2017-04-12', '2017-04-15', 1, 14790, 'FPML-00036', 'CPML-00027', 2, 2
);

--37
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2017-05-12', '2017-05-15', 1, 14790, 'FPML-00037', 'CPML-00028', 2, 2
);

--38
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2017-06-12', '2017-06-15', 1, 14790, 'FPML-00038', 'CPML-00029', 2, 2
);

--39
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2017-07-12', '2017-07-15', 1, 14790, 'FPML-00039', 'CPML-00030', 2, 2
);

--40
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2017-08-12', '2017-08-15', 1, 14790, 'FPML-00040', 'CPML-00031', 2, 2
);

--41
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2017-09-12', '2017-09-15', 1, 14790, 'FPML-00041', 'CPML-00032', 2, 2
);

--42
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2017-10-12', '2017-10-15', 1, 14790, 'FPML-00042', 'CPML-00033', 2, 2
);

--43
--XXXX CANTIDAD
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2017-11-12', '2017-11-15', 1, -14790, 'FPML-00043', 'CPML-00034', 2, 2
);

--44
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2017-11-12', '2017-12-15', 1, 14790, 'FPML-00044', 'CPML-00035', 2, 2
);

--45
--XXXX CANTIDAD
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2018-01-12', '2018-01-15', 1, -14790, 'FPML-00045', 'CPML-00036', 2, 2
);

--46
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2018-02-12', '2018-02-15', 1, 14790, 'FPML-00046', 'CPML-00037', 2, 2
);

--47
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2018-03-12', '2018-03-15', 1, 14790, 'FPML-00047', 'CPML-00038', 2, 2
);

--48
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2018-04-12', '2018-04-15', 1, 14790, 'FPML-00048', 'CPML-00039', 2, 2
);

--49
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2018-05-12', '2018-05-15', 1, 14790, 'FPML-00049', 'CPML-00040', 2, 2
);

--50
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2018-06-12', '2018-06-15', 1, 14790, 'FPML-00050', 'CPML-00051', 2, 2
);

--51
--XXXX FECHA
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2018-07-12', '2028-07-15', 1, 14790, 'FPML-00051', 'CPML-00052', 2, 2
);

--52
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2018-08-12', '2018-08-15', 1, 14790, 'FPML-00052', 'CPML-00053', 2, 2
);

--53
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2018-09-12', '2018-09-15', 1, 14790, 'FPML-00053', 'CPML-00054', 2, 2
);

--54
--XXXX FECHA
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2011-10-12', '2018-10-15', 1, 14790, 'FPML-00054', 'CPML-00055', 2, 2
);

--54
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2018-11-12', '2018-11-15', 1, 14790, 'FPML-00055', 'CPML-00056', 2, 2
);

--55
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2018-12-12', '2018-12-15', 1, 14790, 'FPML-00055', 'CPML-00056', 2, 2
);

--56
--XXXX FECHA
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2019-01-12', '2019-11-15', 1, 14790, 'FPML-00056', 'CPML-00057', 2, 2
);

--57
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2019-02-12', '2019-02-15', 1, 14790, 'FPML-00057', 'CPML-00058', 2, 2
);

--58
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2019-03-12', '2019-03-15', 1, 14790, 'FPML-00058', 'CPML-00059', 2, 2
);

--59
--XXXX CANTIDAD
INSERT INTO solicitudes_compra (cantidad_total, fecha_emision, fecha_entrega_prometida, tipo_pago, costo_total, clave_factura, clave_cheque, proveedor, persona) VALUES (
	49, '2019-04-12', '2019-04-15', 1, -14790, 'FPML-00059', 'CPML-0060', 2, 2
);


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--MATERIALES EN LAS SOLICITUDES DE COMPRA
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from solicitudes_compra_material  ;
select * from recursos_materiales;
select * from materiales_proveedores as mp join recursos_materiales as m on mp.recurso_material = m.id;

INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	6, 1680, 8400, 1, 1 
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	15, 165, 2475, 1, 2 
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	5, 240, 1200, 1, 3 
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	15, 100, 1500, 1, 4 
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	12, 250, 3000, 1, 6
);

--XXXX CANTIDAD
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	15, 330, -4950, 2, 7
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	15, 260, 3900, 2, 8
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	10, 720, 7200, 2, 9
);

--XXXX COSTO
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	25, 580, -14500, 3, 10
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	10, 760, 7600, 3, 11
);

INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	15, 2940, 44100, 4, 13
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 300, 9000, 4, 14
);

INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	35, 500, 17500, 5, 12
);

--XXXX CANTIDAD
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	-20, 1240, 24800, 6, 15
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	25, 340, 8500, 6, 17
);


INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	25, 460, 11500, 7, 20
);

--XXXX COSTO
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	15, -220, 3300, 7, 19
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	10, 400, 4000, 7, 18
);

--XXXX CANTIDAD
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	-20, 1660, 33200, 8, 25
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 1040, 20800, 8, 26
);
--XXXX CANTIDAD
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 540, -10800, 8, 27
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 380, 7600, 8, 28
);


INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 2550, 51000, 9, 29
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 1750, 35000, 9, 30
);


INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 1340, 2680, 10, 35
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 860, 1720, 10, 34
);


INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	10, 13500, 135000, 11, 32
);


INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 1750, 70000, 12, 32
);

--XXXX COSTO
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	5, 7320, -36600, 13, 36
);

--Lysol
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	10, 240, 2400, 14, 3
);

INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 1700, 3400, 15, 1
);

INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 970, 1940, 16, 5
);


INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	3, 1080, 3240, 17, 24
);

INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	10, 340, 3400, 18, 17
);

--Limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 1700, 3400, 19, 1
);

--XXXX CANTIDAD
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 1700, -3400, 20, 1
);

--Cloro
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 165, 3300, 21, 2
);

--Repuesto de limpiador de vidrio
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 970, 1940, 22, 5
);

--Drano
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	15, 250, 3750, 23, 6
);

--Lysol
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	10, 240, 2400, 24, 3
);

--Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 165, 3300, 25, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 1700, 3400, 25, 1
);
--XXXX CANTIDAD
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	-15, 250, 3750, 25, 6
);

--Lysol, repuesto
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	10, 240, 2400, 26, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 970, 1940, 26, 5
);

--Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 165, 3300, 27, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 1700, 3400, 27, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	15, 250, 3750, 27, 6
);

--Lysol, repuesto
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	10, 240, 2400, 28, 3
);
--XXXX CANTIDAD
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 970, -1940, 28, 5
);

--Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 165, 3300, 29, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 1700, 3400, 29, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	15, 250, 3750, 29, 6
);

--Lysol, repuesto
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	10, 240, 2400, 30, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 970, 1940, 30, 5
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	10, 240, 2400, 31, 3
);
--XXXX CANTIDAD
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	-2, 970, 1940, 31, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 165, 3300, 31, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 1700, 3400, 31, 1
);
--XXXX CANTIDAD
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	0, 250, 3750, 31, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	10, 240, 2400, 32, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 970, 1940, 32, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 165, 3300, 32, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 1700, 3400, 32, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	15, 250, 3750, 32, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	10, 240, 2400, 32, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 970, 1940, 32, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 165, 3300, 32, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	2, 1700, 3400, 32, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	15, 250, 3750, 32, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 33, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 33, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 33, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 33, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 33, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 34, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 34, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 34, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 34, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 34, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 35, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 35, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 35, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 35, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 35, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 36, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 36, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 36, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 36, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 36, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 37, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 37, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 37, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 37, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 37, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 38, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 38, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 38, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 38, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 38, 6
);


--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 39, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 39, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 39, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 39, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 39, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 40, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 40, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 40, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 40, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 40, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 41, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 41, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 41, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 41, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 41, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 42, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 42, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 42, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 42, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 42, 6
);


--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 43, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 43, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 43, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 43, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 43, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 44, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 44, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 44, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 44, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 44, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 45, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 45, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 45, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 45, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 45, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 46, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 46, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 46, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 46, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 46, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 47, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 47, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 47, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 47, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 47, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 48, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 48, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 48, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 48, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 48, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 49, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 49, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 49, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 49, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 49, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 50, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 50, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 50, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 50, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 50, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 51, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 51, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 51, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 51, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 51, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 52, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 52, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 52, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 52, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 52, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 53, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 53, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 53, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 53, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 53, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 54, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 54, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 54, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 54, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 54, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 55, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 55, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 55, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 55, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 55, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 56, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 56, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 56, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 56, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 56, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 57, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 57, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 57, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 57, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 57, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 58, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 58, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 58, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 58, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 58, 6
);

--Lysol, repuesto, Cloro, drano, limpiador
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	20, 240, 4800, 59, 3
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 970, 3880, 59, 5
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	40, 165, 6600, 59, 2
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	4, 1700, 6800, 59, 1
);
INSERT INTO solicitudes_compra_material (cantidad, costo_individual, costo_total, solicitud_compra, recurso_material) VALUES (
	30, 250, 7500, 59, 6
);


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TAREAS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Duración: min

select * from tareas;
--Barrer locales

INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (5, 1, 4, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (5, 1, 5, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (6, 1, 6, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (6, 1, 7, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (8, 1, 8, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (9, 1, 9, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (9, 1, 10, 2);

--Trapear locales

INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (6, 2, 4, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (6, 2, 5, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (7, 2, 6, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (7, 2, 7, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (9, 2, 8, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (10, 2, 9, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (10, 2, 10, 2);


--Barrer pasillos

INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (170, 1, 3, 2);


--Trapear pasillos

INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (250, 2, 3, 2);

--Correctivos
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (null, 10, 7, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (null, 11, 11, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (null, 11, 19, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (null, 12, 3, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (null, 12, 10, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (null, 13, 29, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (null, 13, 27, 2);
INSERT INTO tareas (duracion, servicio, area, supervisor) VALUES (null, 13, 30, 2);


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MATERIALES EN CADA TAREA
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HORARIOS DE PERSONAS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--1
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:00:00', '08:10:00', '2016-09-13', '2016-09-13', 5, 1
);

--2
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:10:00', '08:20:00', '2016-09-13', '2016-09-13', 5, 2
);

--3
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:20:00', '08:35:00', '2016-09-13', '2016-09-13', 5, 3
);

--4
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:35:00', '08:50:00', '2016-09-13', '2016-09-13', 5, 4
);

--5
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:50:00', '09:10:00', '2016-09-13', '2016-09-13', 5, 5
);

--6
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:10:00', '09:30:00', '2016-09-13', '2016-09-13', 5, 6
);

--7
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:30:00', '09:50:00', '2016-09-13', '2016-09-13', 5, 7
);

--8
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:50:00', '10:05:00', '2016-09-13', '2016-09-13', 5, 8
);

--9
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:05:00', '10:20:00', '2016-09-13', '2016-09-13', 5, 9
);

--10
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:20:00', '10:35:00', '2016-09-13', '2016-09-13', 5, 10
);

--11
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:35:00', '10:50:00', '2016-09-13', '2016-09-13', 5, 11
);

--12
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:50:00', '11:10:00', '2016-09-13', '2016-09-13', 5, 12
);

--13
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:10:00', '11:30:00', '2016-09-13', '2016-09-13', 5, 13
);

--14
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:30:00', '11:50:00', '2016-09-13', '2016-09-13', 5, 14
);

--15
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'12:30:00', '14:30:00', '2016-09-13', '2016-09-13', 5, 15
);

--16
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'8:30:00', '11:30:00', '2016-09-13', '2016-09-13', 6, 16
);

--17
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'16:30:00', '19:30:00', '2016-09-13', '2016-09-13', 6, 16
);

--18
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:00:00', '08:10:00', '2016-09-14', '2016-09-14', 5, 1
);

--19
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:10:00', '08:20:00', '2016-09-14', '2016-09-14', 5, 2
);

--20
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:20:00', '08:35:00', '2016-09-14', '2016-09-14', 5, 3
);

--21
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:35:00', '08:50:00', '2016-09-14', '2016-09-14', 5, 4
);

--22
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:50:00', '09:10:00', '2016-09-14', '2016-09-14', 5, 5
);

--23
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:10:00', '09:30:00', '2016-09-14', '2016-09-14', 5, 6
);

--24
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:30:00', '09:50:00', '2016-09-14', '2016-09-14', 5, 7
);

--25
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:50:00', '10:05:00', '2016-09-14', '2016-09-14', 5, 8
);

--26
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:05:00', '10:20:00', '2016-09-14', '2016-09-14', 5, 9
);

--27
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:20:00', '10:35:00', '2016-09-14', '2016-09-14', 5, 10
);

--28
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:35:00', '10:50:00', '2016-09-14', '2016-09-14', 5, 11
);

--29
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:50:00', '11:10:00', '2016-09-14', '2016-09-14', 5, 12
);

--30
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:10:00', '11:30:00', '2016-09-14', '2016-09-14', 5, 13
);

--31
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:30:00', '11:50:00', '2016-09-14', '2016-09-14', 5, 14
);

--32
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'12:30:00', '14:30:00', '2016-09-14', '2016-09-14', 5, 15
);

--33
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'8:30:00', '11:30:00', '2016-09-14', '2016-09-14', 6, 16
);

--34
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'16:30:00', '19:30:00', '2016-09-14', '2016-09-14', 6, 16
);

--35
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:00:00', '08:10:00', '2016-09-15', '2016-09-15', 5, 1
);

--36
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:10:00', '08:20:00', '2016-09-15', '2016-09-15', 5, 2
);

--37
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:20:00', '08:35:00', '2016-09-15', '2016-09-15', 5, 3
);

--38
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:35:00', '08:50:00', '2016-09-15', '2016-09-15', 5, 4
);

--39
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:50:00', '09:10:00', '2016-09-15', '2016-09-15', 5, 5
);

--40
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:10:00', '09:30:00', '2016-09-15', '2016-09-15', 5, 6
);

--41
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:30:00', '09:50:00', '2016-09-15', '2016-09-15', 5, 7
);

--42
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:50:00', '10:05:00', '2016-09-15', '2016-09-15', 5, 8
);

--43
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:05:00', '10:20:00', '2016-09-15', '2016-09-15', 5, 9
);

--44
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:20:00', '10:35:00', '2016-09-15', '2016-09-15', 5, 10
);

--45
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:35:00', '10:50:00', '2016-09-15', '2016-09-15', 5, 11
);

--46
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:50:00', '11:10:00', '2016-09-15', '2016-09-15', 5, 12
);

--47
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:10:00', '11:30:00', '2016-09-15', '2016-09-15', 5, 13
);

--48
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:30:00', '11:50:00', '2016-09-15', '2016-09-15', 5, 14
);

--49
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'12:30:00', '14:30:00', '2016-09-15', '2016-09-15', 5, 15
);

--50
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'8:30:00', '11:30:00', '2016-09-15', '2016-09-15', 6, 16
);

--51
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'16:30:00', '19:30:00', '2016-09-15', '2016-09-15', 6, 16
);

--52
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:00:00', '08:10:00', '2016-09-16', '2016-09-16', 5, 1
);

--53
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:10:00', '08:20:00', '2016-09-16', '2016-09-16', 5, 2
);

--54
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:20:00', '08:35:00', '2016-09-16', '2016-09-16', 5, 3
);

--55
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:35:00', '08:50:00', '2016-09-16', '2016-09-16', 5, 4
);

--56
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:50:00', '09:10:00', '2016-09-16', '2016-09-16', 5, 5
);

--57
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:10:00', '09:30:00', '2016-09-16', '2016-09-16', 5, 6
);

--58
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:30:00', '09:50:00', '2016-09-16', '2016-09-16', 5, 7
);

--59
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:50:00', '10:05:00', '2016-09-16', '2016-09-16', 5, 8
);

--60
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:05:00', '10:20:00', '2016-09-16', '2016-09-16', 5, 9
);

--61
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:20:00', '10:35:00', '2016-09-16', '2016-09-16', 5, 10
);

--62
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:35:00', '10:50:00', '2016-09-16', '2016-09-16', 5, 11
);

--63
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:50:00', '11:10:00', '2016-09-16', '2016-09-16', 5, 12
);

--64
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:10:00', '11:30:00', '2016-09-16', '2016-09-16', 5, 13
);

--65
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:30:00', '11:50:00', '2016-09-16', '2016-09-16', 5, 14
);

--66
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'12:30:00', '14:30:00', '2016-09-16', '2016-09-16', 5, 15
);

--67
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'8:30:00', '11:30:00', '2016-09-16', '2016-09-16', 6, 16
);

--68
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'16:30:00', '19:30:00', '2016-09-16', '2016-09-16', 6, 16
);
--69
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:00:00', '08:10:00', '2016-09-17', '2016-09-17', 5, 1
);

--70
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:10:00', '08:20:00', '2016-09-17', '2016-09-17', 5, 2
);

--71
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:20:00', '08:35:00', '2016-09-17', '2016-09-17', 5, 3
);

--72
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:35:00', '08:50:00', '2016-09-17', '2016-09-17', 5, 4
);

--73
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:50:00', '09:10:00', '2016-09-17', '2016-09-17', 5, 5
);

--74
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:10:00', '09:30:00', '2016-09-17', '2016-09-17', 5, 6
);

--75
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:30:00', '09:50:00', '2016-09-17', '2016-09-17', 5, 7
);

--76
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:50:00', '10:05:00', '2016-09-17', '2016-09-17', 5, 8
);

--77
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:05:00', '10:20:00', '2016-09-17', '2016-09-17', 5, 9
);

--78
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:20:00', '10:35:00', '2016-09-17', '2016-09-17', 5, 10
);

--79
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:35:00', '10:50:00', '2016-09-17', '2016-09-17', 5, 11
);

--80
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:50:00', '11:10:00', '2016-09-17', '2016-09-17', 5, 12
);

--81
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:10:00', '11:30:00', '2016-09-17', '2016-09-17', 5, 13
);

--82
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:30:00', '11:50:00', '2016-09-17', '2016-09-17', 5, 14
);

--83
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'12:30:00', '14:30:00', '2016-09-17', '2016-09-17', 5, 15
);

--84
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'8:30:00', '11:30:00', '2016-09-17', '2016-09-17', 6, 16
);

--85
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'16:30:00', '19:30:00', '2016-09-17', '2016-09-17', 6, 16
);

--XXXX FECHA
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:00:00', '08:10:00', '2001-09-18', '2016-09-18', 5, 1
);


INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:10:00', '08:20:00', '2016-09-18', '2016-09-18', 5, 2
);


INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:20:00', '08:35:00', '2016-09-18', '2016-09-18', 5, 3
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:35:00', '08:50:00', '2016-09-18', '2016-09-18', 5, 4
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:50:00', '09:10:00', '2016-09-18', '2016-09-18', 5, 5
);


INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:10:00', '09:30:00', '2016-09-18', '2016-09-18', 5, 6
);


INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:30:00', '09:50:00', '2016-09-18', '2016-09-18', 5, 7
);


INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:50:00', '10:05:00', '2016-09-18', '2016-09-18', 5, 8
);


INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:05:00', '10:20:00', '2016-09-18', '2016-09-18', 5, 9
);


INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:20:00', '10:35:00', '2016-09-18', '2016-09-18', 5, 10
);

--XXXX FECHA
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:35:00', '10:50:00', '2016-09-18', '2015-09-18', 5, 11
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:50:00', '11:10:00', '2016-09-18', '2016-09-18', 5, 12
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:10:00', '11:30:00', '2016-09-18', '2016-09-18', 5, 13
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:30:00', '11:50:00', '2016-09-18', '2016-09-18', 5, 14
);

--100
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'12:30:00', '14:30:00', '2016-09-18', '2016-09-18', 5, 15
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'8:30:00', '11:30:00', '2016-09-18', '2016-09-18', 6, 16
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'16:30:00', '19:30:00', '2016-09-18', '2016-09-18', 6, 16
);

--102
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:00:00', '08:10:00', '2016-09-19', '2016-09-19', 5, 1
);

--XXXX FECHA
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:10:00', '08:20:00', '2017-09-19', '2016-09-19', 5, 2
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:20:00', '08:35:00', '2016-09-19', '2016-09-19', 5, 3
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:35:00', '08:50:00', '2016-09-19', '2016-09-19', 5, 4
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:50:00', '09:10:00', '2016-09-19', '2016-09-19', 5, 5
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:10:00', '09:30:00', '2016-09-19', '2016-09-19', 5, 6
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:30:00', '09:50:00', '2016-09-19', '2016-09-19', 5, 7
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:50:00', '10:05:00', '2016-09-19', '2016-09-19', 5, 8
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:05:00', '10:20:00', '2016-09-19', '2016-09-19', 5, 9
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:20:00', '10:35:00', '2016-09-19', '2016-09-19', 5, 10
);

--XXXX FECHA
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:35:00', '10:50:00', '2010-09-19', '2016-09-19', 5, 11
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:50:00', '11:10:00', '2016-09-19', '2016-09-19', 5, 12
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:10:00', '11:30:00', '2016-09-19', '2016-09-19', 5, 13
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:30:00', '11:50:00', '2016-09-19', '2016-09-19', 5, 14
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'12:30:00', '14:30:00', '2016-09-19', '2016-09-19', 5, 15
);

--XXXX FECHA
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'8:30:00', '11:30:00', '2011-09-19', '2016-09-19', 6, 16
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'16:30:00', '19:30:00', '2016-09-19', '2016-09-19', 6, 16
);

--121
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:00:00', '08:10:00', '2016-09-20', '2016-09-20', 5, 1
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:10:00', '08:20:00', '2016-09-20', '2016-09-20', 5, 2
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:20:00', '08:35:00', '2016-09-20', '2016-09-20', 5, 3
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:35:00', '08:50:00', '2016-09-20', '2016-09-20', 5, 4
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:50:00', '09:10:00', '2016-09-20', '2016-09-20', 5, 5
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:10:00', '09:30:00', '2016-09-20', '2016-09-20', 5, 6
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:30:00', '09:50:00', '2016-09-20', '2016-09-20', 5, 7
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:50:00', '10:05:00', '2016-09-20', '2016-09-20', 5, 8
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:05:00', '10:20:00', '2016-09-20', '2016-09-20', 5, 9
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:20:00', '10:35:00', '2016-09-20', '2016-09-20', 5, 10
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:35:00', '10:50:00', '2016-09-20', '2016-09-20', 5, 11
);

--XXXX FECHA
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:50:00', '11:10:00', '20116-09-20', '2016-09-20', 5, 12
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:10:00', '11:30:00', '2016-09-20', '2016-09-20', 5, 13
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:30:00', '11:50:00', '2016-09-20', '2016-09-20', 5, 14
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'12:30:00', '14:30:00', '2016-09-20', '2016-09-20', 5, 15
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'8:30:00', '11:30:00', '2016-09-20', '2016-09-20', 6, 16
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'16:30:00', '19:30:00', '2016-09-20', '2016-09-20', 6, 16
);

--138

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:00:00', '08:10:00', '2016-09-21', '2016-09-21', 5, 1
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:10:00', '08:20:00', '2016-09-21', '2016-09-21', 5, 2
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:20:00', '08:35:00', '2016-09-21', '2016-09-21', 5, 3
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:35:00', '08:50:00', '2016-09-21', '2016-09-21', 5, 4
);

--XXXX FECHA
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:50:00', '09:10:00', '2016-09-21', '2116-09-21', 5, 5
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:10:00', '09:30:00', '2016-09-21', '2016-09-21', 5, 6
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:30:00', '09:50:00', '2016-09-21', '2016-09-21', 5, 7
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:50:00', '10:05:00', '2016-09-21', '2016-09-21', 5, 8
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:05:00', '10:20:00', '2016-09-21', '2016-09-21', 5, 9
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:20:00', '10:35:00', '2016-09-21', '2016-09-21', 5, 10
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:35:00', '10:50:00', '2016-09-21', '2016-09-21', 5, 11
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:50:00', '11:10:00', '2016-09-21', '2016-09-21', 5, 12
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:10:00', '11:30:00', '2016-09-21', '2016-09-21', 5, 13
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:30:00', '11:50:00', '2016-09-21', '2016-09-21', 5, 14
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'12:30:00', '14:30:00', '2016-09-21', '2016-09-21', 5, 15
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'8:30:00', '11:30:00', '2016-09-21', '2016-09-21', 6, 16
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'16:30:00', '19:30:00', '2016-09-21', '2016-09-21', 6, 16
);

--155


INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:00:00', '08:10:00', '2016-09-22', '2016-09-22', 6, 1
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:10:00', '08:20:00', '2016-09-22', '2016-09-22', 6, 2
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:20:00', '08:35:00', '2016-09-22', '2016-09-22', 6, 3
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:35:00', '08:50:00', '2016-09-22', '2016-09-22', 6, 4
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:50:00', '09:10:00', '2016-09-22', '2016-09-22', 6, 5
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:10:00', '09:30:00', '2016-09-22', '2016-09-22', 6, 6
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:30:00', '09:50:00', '2016-09-22', '2016-09-22', 6, 7
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:50:00', '10:05:00', '2016-09-22', '2016-09-22', 6, 8
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:05:00', '10:20:00', '2016-09-22', '2016-09-22', 6, 9
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:20:00', '10:35:00', '2016-09-22', '2016-09-22', 6, 10
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:35:00', '10:50:00', '2016-09-22', '2016-09-22', 6, 11
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:50:00', '11:10:00', '2016-09-22', '2016-09-22', 6, 12
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:10:00', '11:30:00', '2016-09-22', '2016-09-22', 6, 13
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:30:00', '11:50:00', '2016-09-22', '2016-09-22', 6, 14
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'12:30:00', '14:30:00', '2016-09-22', '2016-09-22', 6, 15
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'8:30:00', '11:30:00', '2016-09-22', '2016-09-22', 5, 16
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'16:30:00', '19:30:00', '2016-09-22', '2016-09-22', 5, 16
);

--172


INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:00:00', '08:10:00', '2016-09-23', '2016-09-23', 6, 1
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:10:00', '08:20:00', '2016-09-23', '2016-09-23', 6, 2
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:20:00', '08:35:00', '2016-09-23', '2016-09-23', 6, 3
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:35:00', '08:50:00', '2016-09-23', '2016-09-23', 6, 4
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:50:00', '09:10:00', '2016-09-23', '2016-09-23', 6, 5
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:10:00', '09:30:00', '2016-09-23', '2016-09-23', 6, 6
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:30:00', '09:50:00', '2016-09-23', '2016-09-23', 6, 7
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:50:00', '10:05:00', '2016-09-23', '2016-09-23', 6, 8
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:05:00', '10:20:00', '2016-09-23', '2016-09-23', 6, 9
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:20:00', '10:35:00', '2016-09-23', '2016-09-23', 6, 10
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:35:00', '10:50:00', '2016-09-23', '2016-09-23', 6, 11
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:50:00', '11:10:00', '2016-09-23', '2016-09-23', 6, 12
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:10:00', '11:30:00', '2016-09-23', '2016-09-23', 6, 13
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:30:00', '11:50:00', '2016-09-23', '2016-09-23', 6, 14
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'12:30:00', '14:30:00', '2016-09-23', '2016-09-23', 6, 15
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'8:30:00', '11:30:00', '2016-09-23', '2016-09-23', 5, 16
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'16:30:00', '19:30:00', '2016-09-23', '2016-09-23', 5, 16
);

--199

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:00:00', '08:10:00', '2016-09-24', '2016-09-24', 6, 1
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:10:00', '08:20:00', '2016-09-24', '2016-09-24', 6, 2
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:20:00', '08:35:00', '2016-09-24', '2016-09-24', 6, 3
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:35:00', '08:50:00', '2016-09-24', '2016-09-24', 6, 4
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:50:00', '09:10:00', '2016-09-24', '2016-09-24', 6, 5
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:10:00', '09:30:00', '2016-09-24', '2016-09-24', 6, 6
);

--XXXX FECHA
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:30:00', '09:50:00', '2016-09-24', '2026-09-24', 6, 7
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:50:00', '10:05:00', '2016-09-24', '2016-09-24', 6, 8
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:05:00', '10:20:00', '2016-09-24', '2016-09-24', 6, 9
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:20:00', '10:35:00', '2016-09-24', '2016-09-24', 6, 10
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:35:00', '10:50:00', '2016-09-24', '2016-09-24', 6, 11
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:50:00', '11:10:00', '2016-09-24', '2016-09-24', 6, 12
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:10:00', '11:30:00', '2016-09-24', '2016-09-24', 6, 13
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:30:00', '11:50:00', '2016-09-24', '2016-09-24', 6, 14
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'12:30:00', '14:30:00', '2016-09-24', '2016-09-24', 6, 15
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'8:30:00', '11:30:00', '2016-09-24', '2016-09-24', 5, 16
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'16:30:00', '19:30:00', '2016-09-24', '2016-09-24', 5, 16
);

--216

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:00:00', '08:10:00', '2016-09-25', '2016-09-25', 6, 1
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:10:00', '08:20:00', '2016-09-25', '2016-09-25', 6, 2
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:20:00', '08:35:00', '2016-09-25', '2016-09-25', 6, 3
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:35:00', '08:50:00', '2016-09-25', '2016-09-25', 6, 4
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'08:50:00', '09:10:00', '2016-09-25', '2016-09-25', 6, 5
);

--XXXX HORA
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:10:00', '23:30:00', '2016-09-25', '2016-09-25', 6, 6
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:30:00', '09:50:00', '2016-09-25', '2016-09-25', 6, 7
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'09:50:00', '10:05:00', '2016-09-25', '2016-09-25', 6, 8
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:05:00', '10:20:00', '2016-09-25', '2016-09-25', 6, 9
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:20:00', '10:35:00', '2016-09-25', '2016-09-25', 6, 10
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:35:00', '10:50:00', '2016-09-25', '2016-09-25', 6, 11
);

--XXXX FECHA
INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'10:50:00', '11:10:00', '2026-09-25', '2016-09-25', 6, 12
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:10:00', '11:30:00', '2016-09-25', '2016-09-25', 6, 13
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'11:30:00', '11:50:00', '2016-09-25', '2016-09-25', 6, 14
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'12:30:00', '14:30:00', '2016-09-25', '2016-09-25', 6, 15
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'8:30:00', '11:30:00', '2016-09-25', '2016-09-25', 5, 16
);

INSERT INTO horarios (hora_inicio, hora_fin, fecha_inicio, fecha_fin, persona, tarea) VALUES (
	'16:30:00', '19:30:00', '2016-09-25', '2016-09-25', 5, 16
);

--233




---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONTRATISTAS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO contratistas (nombre, direccion, numero) VALUES ('CEAL COLIMA', 'Benito Juárez 985, Manuel M. Diéguez, 28984 Villa de Álvarez, Col.', '5213123086400');
INSERT INTO contratistas (nombre, direccion, numero) VALUES ('Cursa Construcciones', 'Sauz 866, Prados del Sur, 28078 Colima, Col.', '5213123082468');
INSERT INTO contratistas (nombre, direccion, numero) VALUES ('Grupo Elecon', 'Juan de La Cabada 750, José María Morelos, 28030 Colima, Col.', '521312876033');


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ORDEN DE SERVICIO
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Prioridad: 3 -> Alta | 2 -> Media | 1 -> Baja
INSERT INTO ordenes_servicio (fecha, prioridad, tarea, persona) VALUES ('2017-10-08', 3, 17, 8);
INSERT INTO ordenes_servicio (fecha, prioridad, tarea, persona) VALUES ('2017-12-18', 2, 18, 8);
INSERT INTO ordenes_servicio (fecha, prioridad, tarea, persona) VALUES ('2017-01-04', 2, 24, 8);
INSERT INTO ordenes_servicio (fecha, prioridad, tarea, persona) VALUES ('2017-04-09', 1, 17, 8);
INSERT INTO ordenes_servicio (fecha, prioridad, tarea, persona) VALUES ('2017-07-12', 3, 21, 8);
INSERT INTO ordenes_servicio (fecha, prioridad, tarea, persona) VALUES ('2017-07-18', 3, 20, 8);
INSERT INTO ordenes_servicio (fecha, prioridad, tarea, persona) VALUES ('2017-10-04', 1, 19, 8);
INSERT INTO ordenes_servicio (fecha, prioridad, tarea, persona) VALUES ('2017-12-14', 2, 22, 8);
INSERT INTO ordenes_servicio (fecha, prioridad, tarea, persona) VALUES ('2017-12-24', 1, 23, 8);



---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ORDEN DE SERVICIO Y CONTRATISTAS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Tiempo: horas
--Precio: Pesos

INSERT INTO ordenes_servicios_contratistas (costo, tiempo, orden_servicio, contratista) VALUES (2000, 20, 1, 1);
INSERT INTO ordenes_servicios_contratistas (costo, tiempo, orden_servicio, contratista) VALUES (2300, 18, 2, 3);
--XXXX COSTO
INSERT INTO ordenes_servicios_contratistas (costo, tiempo, orden_servicio, contratista) VALUES (-1800, 20, 1, 3);
INSERT INTO ordenes_servicios_contratistas (costo, tiempo, orden_servicio, contratista) VALUES (4543, 20, 4, 1);
INSERT INTO ordenes_servicios_contratistas (costo, tiempo, orden_servicio, contratista) VALUES (5300, 20, 1, 3);
INSERT INTO ordenes_servicios_contratistas (costo, tiempo, orden_servicio, contratista) VALUES (2300, 20, 1, 2);
INSERT INTO ordenes_servicios_contratistas (costo, tiempo, orden_servicio, contratista) VALUES (8700, 20, 1, 1);
INSERT INTO ordenes_servicios_contratistas (costo, tiempo, orden_servicio, contratista) VALUES (3400, 20, 1, 3);
INSERT INTO ordenes_servicios_contratistas (costo, tiempo, orden_servicio, contratista) VALUES (5200, 20, 1, 3);


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ORDEN DE SERVICIO - PERSONAS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO ordenes_servicios_personas (orden_servicio, persona) VALUES (3, 9);
INSERT INTO ordenes_servicios_personas (orden_servicio, persona) VALUES (3, 9);


select * from ordenes_servicios_contratistas;
select * from contratistas;
select * from horarios;
select * from tipos_areas;
select * from tareas;
select * from solicitudes_compra_material;
select * from solicitudes_compra;
select * from servicios_materiales;
select * from secciones_bodega;
select * from recursos_materiales;
select * from categorias_materiales;
select * from personas;
select * from puestos;
select * from proveedores;
select * from areas_servicios;
select * from servicios;
select * from areas_horarios;
select * from horarios_disponibles;
select * from areas;
select * from ordenes_servicio;


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TIPOS DE INCIDENTES
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO tipos_incidentes (nombre, descripcion) VALUES ('Fallo de fábrica', 'El material llegó defectuoso');
INSERT INTO tipos_incidentes (nombre, descripcion) VALUES ('Destrucción', 'El material se rompió');
INSERT INTO tipos_incidentes (nombre, descripcion) VALUES ('Derrame', 'El material líquido se derramó');
INSERT INTO tipos_incidentes (nombre, descripcion) VALUES ('Caducado', 'La fecha de caducidad ya pasó');



---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- INCIDENTES
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO incidente (fecha, clave_nota_credito, clave_nota_debito, tipo_incidente, persona, recurso_material) VALUES (
	'2017-10-08', null, null, 1, 2, 12);
--XXXX FECHA
INSERT INTO incidente (fecha, clave_nota_credito, clave_nota_debito, tipo_incidente, persona, recurso_material) VALUES (
	'2020-11-21', null, null, 4, 2, 11);
INSERT INTO incidente (fecha, clave_nota_credito, clave_nota_debito, tipo_incidente, persona, recurso_material) VALUES (
	'2017-11-22', null, null, 4, 2, 19);
INSERT INTO incidente (fecha, clave_nota_credito, clave_nota_debito, tipo_incidente, persona, recurso_material) VALUES (
	'2017-21-20', null, null, 4, 2, 26);
INSERT INTO incidente (fecha, clave_nota_credito, clave_nota_debito, tipo_incidente, persona, recurso_material) VALUES (
	'2019-01-14', null, null, 4, 2, 33);


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODAS LAS TABLAS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM areas_horarios;
SELECT * FROM areas_servicios;
SELECT * FROM horarios;
SELECT * FROM horarios_disponibles;
SELECT * FROM tareas_materiales;
SELECT * FROM supervisiones;
SELECT * FROM ordenes_servicios_contratistas;
SELECT * FROM ordenes_servicios_personas;
SELECT * FROM ordenes_servicio;
SELECT * FROM tareas;
SELECT * FROM servicios_materiales;
SELECT * FROM servicios;
SELECT * FROM areas;
SELECT * FROM tipos_areas;
SELECT * FROM contratistas;
SELECT * FROM secciones_bodega;
SELECT * FROM incidentes;
SELECT * FROM tipos_incidentes;
SELECT * FROM ordenes_despacho_material;
SELECT * FROM ordenes_despacho;
SELECT * FROM solicitudes_compra_material;
SELECT * FROM solicitudes_compra;
SELECT * FROM materiales_proveedores;
SELECT * FROM recursos_materiales;
SELECT * FROM categorias_materiales;
SELECT * FROM tipos_materiales;
SELECT * FROM proveedores;
SELECT * FROM personas;
SELECT * FROM puestos;


