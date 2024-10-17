----ELIMINACIÓN DE LA BASE DE DATOS
USE MASTER;

GO
	ALTER DATABASE DataBase_Inventory_Management
SET
	SINGLE_USER WITH ROLLBACK IMMEDIATE;

GO
	/**/
	DROP DATABASE DataBase_Inventory_Management;

GO
	----CREACIÓN DE LA BASE DE DATOS
SET
	DATEFORMAT DMY;

USE MASTER;

CREATE DATABASE DataBase_Inventory_Management;

GO
	----COMPROBAR LOS DEVICES CREADOS
	SP_HELPDB DataBase_Inventory_Management;

USE DataBase_Inventory_Management;

ALTER DATABASE SCOPED CONFIGURATION
SET
	IDENTITY_CACHE = OFF;

GO
	----CREACIÓN DE LAS TABLAS
	CREATE TABLE Tabla_Tipo_Usuario (
		ID_Tipo_Usuario INT IDENTITY (1, 1) PRIMARY KEY,
		Nombre_Tipo_Usuario VARCHAR (50) CHECK (
			Nombre_Tipo_Usuario IN ('Administrador', 'Empleado')
		) NOT NULL
	);

GO
	CREATE TABLE Tabla_Usuario (
		ID_Usuario INT IDENTITY (1, 1) PRIMARY KEY,
		ID_Tipo_Usuario INT FOREIGN KEY REFERENCES Tabla_Tipo_Usuario (ID_Tipo_Usuario) NOT NULL,
		Nombre_Usuario VARCHAR (50) NOT NULL,
		Apellido_Usuario VARCHAR (50) NOT NULL,
		E_Mail_Usuario VARCHAR (30) NOT NULL,
		Password_Usuario VARCHAR (150) NOT NULL,
		Reestablecer_Password_Usuario BIT DEFAULT 1 NOT NULL,
		Fecha_Registro_Usuario DATETIME DEFAULT GETDATE() NOT NULL,
		Ruta_Imagen_Usuario VARCHAR (255) NULL,
		Nombre_Imagen_Usuario VARCHAR (255) DEFAULT 'Image_Error.jpg' NULL
	);

GO
	CREATE TABLE Tabla_Categoria_Insumo (
		ID_Categoria_Insumo INT IDENTITY (1, 1) PRIMARY KEY,
		Nombre_Categoria_Insumo VARCHAR (50) NOT NULL,
		Descripcion_Categoria_Insumo TEXT NOT NULL,
		Estado_Categoria_Insumo BIT NOT NULL,
		Fecha_Registro_Categoria_Insumo DATETIME DEFAULT GETDATE() NOT NULL
	);

GO
	CREATE TABLE Tabla_Proveedor_Insumo (
		ID_Proveedor_Insumo INT IDENTITY (1, 1) PRIMARY KEY,
		Nombre_Proveedor_Insumo VARCHAR (50) NOT NULL,
		Telefono_Proveedor_Insumo INT NOT NULL,
		E_Mail_Proveedor_Insumo VARCHAR (30),
		Direccion_Proveedor_Insumo VARCHAR (50) NOT NULL,
		Estado_Proveedor_Insumo BIT NOT NULL,
		Fecha_Registro_Proveedor_Insumo DATETIME DEFAULT GETDATE() NOT NULL
	);

GO
	CREATE TABLE Tabla_Insumo (
		ID_Insumo INT IDENTITY (1, 1) PRIMARY KEY,
		ID_Categoria_Insumo INT FOREIGN KEY REFERENCES Tabla_Categoria_Insumo (ID_Categoria_Insumo) NOT NULL,
		ID_Proveedor_Insumo INT FOREIGN KEY REFERENCES Tabla_Proveedor_Insumo (ID_Proveedor_Insumo) NOT NULL,
		Nombre_Insumo VARCHAR (50) NOT NULL,
		Descripcion_Insumo TEXT NOT NULL,
		Unidad_Medida_Insumo VARCHAR (50) NOT NULL,
		--Por Ejemplo: Kilogramos, Litros, Unidades
		Precio_Insumo DECIMAL (10, 2) NOT NULL,
		--Precio por Unidad de Medida
		Stock_Insumo INT NOT NULL,
		Estado_Insumo BIT NOT NULL,
		Fecha_Ingreso_Insumo DATETIME DEFAULT GETDATE() NOT NULL,
		Fecha_Vencimiento_Insumo DATE NOT NULL,
		Ruta_Imagen_Insumo VARCHAR (255) NULL,
		Nombre_Imagen_Insumo VARCHAR (255) NULL
	);

GO
	CREATE TABLE Tabla_Movimiento_Inventario (
		ID_Movimiento_Inventario INT IDENTITY (1, 1) PRIMARY KEY,
		ID_Insumo INT FOREIGN KEY REFERENCES Tabla_Insumo (ID_Insumo) NOT NULL,
		Tipo_Movimiento_Inventario VARCHAR (50) CHECK (
			Tipo_Movimiento_Inventario IN ('Entrada', 'Salida')
		) NOT NULL,
		Cantidad_Movimiento_Inventario INT NOT NULL,
		Fecha_Movimiento_Inventario DATETIME DEFAULT GETDATE() NOT NULL,
		ID_Usuario INT FOREIGN KEY REFERENCES Tabla_Usuario (ID_Usuario) NOT NULL
	);

--Usuario que Registra el Movimiento
GO
	----MOSTRAR TABLAS
SELECT
	*
FROM
	Tabla_Tipo_Usuario;

GO
SELECT
	*
FROM
	Tabla_Usuario;

GO
SELECT
	*
FROM
	Tabla_Categoria_Insumo;

GO
SELECT
	*
FROM
	Tabla_Proveedor_Insumo;

GO
SELECT
	*
FROM
	Tabla_Insumo;

GO
SELECT
	*
FROM
	Tabla_Movimiento_Inventario;

GO
	----INSERTAR VALORES
INSERT INTO
	Tabla_Tipo_Usuario (Nombre_Tipo_Usuario)
VALUES
	('Administrador'),
	('Empleado');

GO
INSERT INTO
	Tabla_Usuario (
		ID_Tipo_Usuario,
		Nombre_Usuario,
		Apellido_Usuario,
		E_Mail_Usuario,
		Password_Usuario,
		Ruta_Imagen_Usuario,
		Nombre_Imagen_Usuario
	)
VALUES
	(
		'1',
		'Juan Carlos',
		'Aronés Peña',
		'U22208295@utp.edu.pe',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'1.jpeg'
	),
	(
		'2',
		'Piero Reyder',
		'Aronés Peña',
		'pieritazo1211@gmail.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'2.jpeg'
	),
	(
		'2',
		'Feliciano',
		'Aronés Castro',
		'facarones@yahoo.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'3.jpeg'
	),
	(
		'2',
		'Lourdes Edith',
		'Peña Suarez',
		'mapesu89@gmail.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'4.jpeg'
	),
	(
		'2',
		'Lola Hernández',
		'Maria Cervera',
		'anderson@alexchange.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Rita Coca',
		'Tatiana Salguero',
		'merikejenk@somebodyswrong.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Vidal Pavon',
		'Josue Pedrosa',
		'kiera1@lasersimage.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Roberto Carlos',
		'Karim Quero',
		'legerald@rippleofvie.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Maria Encarnacion',
		'Almudena de La Rosa',
		'nozhenkoolga@ticemail.xyz',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Fernando Nuñez',
		'de las Heras',
		'liptonicetea@solaravenue.org',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Rebeca Pinto',
		'Melania Moreira',
		'jojisuzuki@solarino.pl',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Paul Vidal',
		'Javier Huertas',
		'smooth@gmail.xyz',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Maria Estrella',
		'June Fraga',
		'lenacher41@xaudep.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Ezequiel Barcelo',
		'Antonio Cuesta',
		'olegfisun@upscalebp.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Maria Pilar Lloret',
		'Carla Moyano',
		'y2annd@comfortstride.sCIdio',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Pedro Javier',
		'Jamal Soria',
		'vspyrh2010@gmail.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Irati Santiago',
		'Mohammed Carrion',
		'ginanm@s-hope.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Bienvenido del Castillo',
		'Luis Enrique',
		'lia1991ufa@gmail.eu',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Maria Prado',
		'Angelica Bravo',
		'chaameleon@haqoci.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Melchor Zafra',
		'Angel Carpio',
		'soyelrobert1@gmail.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Desamparados Lillo',
		'Zakaria Sempere',
		'cryjsn@friendsack.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Juan David',
		'Youssef Capdevila',
		'shadowgeek@besttimenews.xyz',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Maria Olga',
		'Mariona Padron',
		'chay398@marmaryta.email',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Saturnino Roldan',
		'Samir Arnau',
		'ajarik88@kimfetme.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Virginia Torrejon',
		'Martina Valero',
		'eropkazzz1@getfollowers24.biz',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Camilo Morera',
		'Asier Arranz',
		'ksyunechkadanchenko@gmail.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Matilde Carreras',
		'Patrocinio Vilar',
		'termovihr@tldemail.top',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Mauro Mateos',
		'Fernando del Campo',
		'newsacCI@hdstream247.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Marcelina Mariño',
		'Alfonsa Sabater',
		'lisnyiivan@newdestinyhomes.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Modesto Rosa',
		'Yassine Martínez',
		'displeasures@hnoodt.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Alba Serrano',
		'Natividad Orellana',
		'logustlt@visblackbox.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Emilia Guisado',
		'Natividad Pozo',
		'ashfaquesindhi47@beanlignt.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Florentino Montoya',
		'Narciso Echeverria',
		'bordy12@sikatan.co',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Jose Joaquin',
		'Miguel Rovira',
		'gnsvladimir@loCIzvending.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Manel Melero',
		'Jacobo Rodenas',
		'giese@CIku26012023.xyz',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Purificacion Carrasco',
		'Marcelino Prados',
		'pifagorstar@gmail.me',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Jonathan Teruel',
		'Ramon Ferrando',
		'prostotina@ltlseguridad.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Berta Moreira',
		'Antia Esteban',
		'msdubin@rotecproperty.xyz',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Wonder Piqueras',
		'Jesus Duarte',
		'nikkrasnovfiftik@gpbemail.top',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Aida Sanchis',
		'Arantxa Meseguer',
		'ricardo@gmail.me',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Simon Cuevas',
		'Ferran Prieto',
		'novelkkh@gpaemail.in',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Rufina Romo',
		'Cristina Acuña',
		'doperion@eliwakhaliljb.site',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Emiliana Guerra',
		'Virginia Montiel',
		'alenaaam@xtsimilar.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Ildefonso Zafra',
		'Gregorio Cañete',
		'joesinglerdish@entobio.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Agustina Verdugo',
		'Ane Lima',
		'xavkitsune@gmail.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Pedro Antonio',
		'Biel Frutos',
		'dim0173@byui.me',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Matias Alcaide',
		'Francisco Prieto',
		'nurlanaliyev85@badutquinza.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Naia Calderon',
		'Azucena Ortiz',
		'wolfcoollya@baubionest.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Rafael Davila',
		'Aurelio Holgado',
		'hifvbgwsv2@newbreedapps.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Chloe Palm',
		'Paloma Gallego',
		'nighttrain@cuanmarket.xyz',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Idoia Martorell',
		'Pino Uriarte',
		'egafal12@coolmailcool.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Ignacio Nicolas',
		'Domingo Cardenas',
		'tatianabreus@maghyg.xyz',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	),
	(
		'2',
		'Juan Andres',
		'Alvaro Estevez',
		'novik3055@gmail.com',
		'4f0a58250fcc6e16e71c42988710d8278b9e98fd3b4ac56073d0a01bd49699ed',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\User_Images',
		'Image_Error.jpg'
	);

GO
INSERT INTO
	Tabla_Categoria_Insumo (
		Nombre_Categoria_Insumo,
		Descripcion_Categoria_Insumo,
		Estado_Categoria_Insumo
	)
VALUES
	(
		'Ingredientes para la Masa',
		'Mezcla de harina, agua, levadura y sal.',
		1
	),
	(
		'Salsas',
		'Salsas para la Preparación de las Pizzas.',
		1
	),
	(
		'Quesos',
		'Derivado lácteo que se obtiene por maduración de la cuajada de la leche una vez eliminado el suero.',
		1
	),
	('Carnes', 'Insumos Córnicos para Pizzas.', 1),
	(
		'Vegetales y Hierbas Frescas',
		'Insumos Vegetales y Verduras.',
		1
	),
	(
		'Mariscos',
		'Animales marinos invertebrados comestibles​.',
		1
	),
	(
		'Especias y Condimentos',
		'Agentes antimicrobianos y conservan los alimentos.',
		1
	),
	(
		'Aceites y Vinagres',
		'Pequeñas botellitas que parecen contener todo el sabor del mundo.',
		1
	),
	(
		'Bebidas',
		'Bebidas rehidratantes y gaseosas hasta exquisitos vinos y pisco.',
		1
	),
	(
		'Materiales de Empaque y transporte',
		'Utilizados para la envoltura que se encuentra fuera del empaque principal.',
		1
	),
	(
		'Postres y adicionales',
		'Preparación dulce, bien sean cremas, tartas, pasteles, helados, bombones, etc.',
		1
	),
	(
		'Materiales de Limpieza y Mantenimiento',
		'Productos y herramientas que se utilizan para realizar tareas de limpieza y mantenimiento.',
		1
	);

GO
INSERT INTO
	Tabla_Proveedor_Insumo (
		Nombre_Proveedor_Insumo,
		Telefono_Proveedor_Insumo,
		E_Mail_Proveedor_Insumo,
		Direccion_Proveedor_Insumo,
		Estado_Proveedor_Insumo
	)
VALUES
	(
		'MasaCorp',
		'956745667',
		'kiera1@lasersimage.com',
		'Santiago de Surco 33',
		1
	),
	(
		'AlaCena',
		'956974566',
		'legerald@rippleofvie.com',
		'Tomas Ramsey 904',
		1
	),
	(
		'Distribuidora Láctea',
		'912345567',
		'novik3055@haddenelectrical.com',
		'Calle 27 de Noviembre 169/189 Miraflores',
		1
	),
	(
		'Carnes Premium',
		'965845403',
		'anderson@alexchange.com',
		'Chancay 894',
		1
	),
	(
		'Verduras Frescas',
		'956745696',
		'merikejenk@somebodyswrong.com',
		'Merida 216',
		1
	),
	(
		'Campomar',
		'956754566',
		'nozhenkoolga@ticemail.xyz',
		'Av República de Panamá 6355',
		1
	),
	(
		'Sibarilla',
		'956781356',
		'liptonicetea@solaravenue.org',
		'Av José Pardo 1453',
		1
	),
	(
		'Primor',
		'978945268',
		'jojisuzuki@solarino.pl',
		'Calle Los Libertadores 302',
		1
	),
	(
		'Lindley',
		'978940733',
		'smooth@gmail.xyz',
		'Ferreyros 376',
		1
	),
	(
		'Aro',
		'978940734',
		'lenacher41@xaudep.com',
		'Victor A Belaunde 161',
		1
	),
	(
		'D´Onofrio',
		'978685704',
		'olegfisun@upscalebp.com',
		'Av. Túpac Amaru 310',
		1
	),
	(
		'Rey',
		'956574566',
		'y2annd@comfortstride.studio',
		'Ate Vitarte 856',
		1
	);

GO
INSERT INTO
	Tabla_Insumo (
		ID_Categoria_Insumo,
		ID_Proveedor_Insumo,
		Nombre_Insumo,
		Descripcion_Insumo,
		Unidad_Medida_Insumo,
		Precio_Insumo,
		Stock_Insumo,
		Estado_Insumo,
		Fecha_Vencimiento_Insumo,
		Ruta_Imagen_Insumo,
		Nombre_Imagen_Insumo
	)
VALUES
	(
		1,
		1,
		'Harina',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		1,
		1,
		'Levadura',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		1,
		1,
		'Agua',
		'Lorem Ipsum',
		'Lt.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		1,
		1,
		'Sal',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		1,
		1,
		'Aceite de oliva o vegetal',
		'Lorem Ipsum',
		'Lt.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		2,
		2,
		'Salsa de tomate',
		'Lorem Ipsum',
		'Lt.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		2,
		2,
		'Salsa blanca (como Alfredo)',
		'Lorem Ipsum',
		'Lt.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		2,
		2,
		'Pesto',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		3,
		3,
		'Mozzarella',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		3,
		3,
		'Parmesano',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		3,
		3,
		'Cheddar',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		3,
		3,
		'Provolone',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		3,
		3,
		'Queso azul',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		3,
		3,
		'Ricotta',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		4,
		4,
		'Pepperoni',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		4,
		4,
		'Salami',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		4,
		4,
		'Jamón',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		4,
		4,
		'Pollo',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		4,
		4,
		'Carne molida',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		4,
		4,
		'Tocino',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		5,
		5,
		'Champiñones',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		5,
		5,
		'Cebolla',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		5,
		5,
		'Pimientos (verdes, rojos, amarillos)',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		5,
		5,
		'Tomates frescos',
		'Lorem Ipsum',
		'Lt.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		5,
		5,
		'Albahaca',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		5,
		5,
		'Espinaca',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		5,
		5,
		'Aceitunas (negras y verdes)',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		6,
		6,
		'Anchoas',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		6,
		6,
		'Camarones',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		7,
		7,
		'Orégano',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		7,
		7,
		'Ajo en polvo',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		7,
		7,
		'Chile seco o en hojuelas',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		7,
		7,
		'Pimienta',
		'Lorem Ipsum',
		'Kg.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		7,
		7,
		'Sal de ajo',
		'Lorem Ipsum',
		'Lt.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		8,
		8,
		'Aceite de oliva',
		'Lorem Ipsum',
		'Lt.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		8,
		8,
		'Vinagre balsámico',
		'Lorem Ipsum',
		'Lt.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		9,
		9,
		'Refrescos',
		'Lorem Ipsum',
		'Lt.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		9,
		9,
		'Agua embotellada',
		'Lorem Ipsum',
		'Lt.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		9,
		9,
		'Cerveza y vino (si se vende)',
		'Lorem Ipsum',
		'Lt.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		10,
		10,
		'Cajas para pizza',
		'Lorem Ipsum',
		'Paq.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		10,
		10,
		'Servilletas',
		'Lorem Ipsum',
		'Paq.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		10,
		10,
		'Bolsas para llevar',
		'Lorem Ipsum',
		'Paq.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		10,
		10,
		'Envases para salsas',
		'Lorem Ipsum',
		'Paq.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		11,
		11,
		'Helados',
		'Lorem Ipsum',
		'Lt.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		11,
		11,
		'Galletas',
		'Lorem Ipsum',
		'Paq.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		11,
		11,
		'Cannoli',
		'Lorem Ipsum',
		'Paq.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		11,
		11,
		'Chocolate',
		'Lorem Ipsum',
		'Paq.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		12,
		12,
		'Detergentes',
		'Lorem Ipsum',
		'Paq.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		12,
		12,
		'Paños',
		'Lorem Ipsum',
		'Paq.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		12,
		12,
		'Toallas de papel',
		'Lorem Ipsum',
		'Paq.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	),
	(
		12,
		12,
		'Productos desinfectantes',
		'Lorem Ipsum',
		'Paq.',
		20.00,
		100,
		1,
		'2025-08-06',
		'C:\Users\HP\Documentos\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\CIISS - INVENTORY MANAGEMENT\wwwroot\Supply_Images',
		'Image_Error.jpg'
	);

GO