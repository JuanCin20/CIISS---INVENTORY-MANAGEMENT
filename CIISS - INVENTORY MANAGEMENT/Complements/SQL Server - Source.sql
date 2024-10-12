----ELIMINACI�N DE LA BASE DE DATOS
USE MASTER;

GO
	ALTER DATABASE DataBase_Inventory_Management
SET
	SINGLE_USER WITH ROLLBACK IMMEDIATE;

GO
	/**/
	DROP DATABASE DataBase_Inventory_Management;

GO
	----CREACI�N DE LA BASE DE DATOS
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
	----CREACI�N DE LAS TABLAS
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
		Imagen_Usuario VARCHAR (255) NOT NULL
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
		Precio_Insumo DECIMAL (10, 2) DEFAULT 0.0 NOT NULL,
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
	Tabla_Categoria_Insumo (
		Nombre_Categoria_Insumo,
		Descripcion_Categoria_Insumo,
		Estado_Categoria_Insumo
	)
VALUES
	('L�cteos', 'Productos Derivados de la Leche.', 1),
	('Carnes', 'Insumos C�rnicos para Pizzas.', 1),
	('Vegetales', 'Insumos Vegetales y Verduras.', 1),
	(
		'Salsas',
		'Salsas para la Preparaci�n de las Pizzas.',
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
		'Distribuidora L�ctea',
		963358452,
		'contacto@lacteos.com',
		'Centro de Lima',
		1
	),
	(
		'Carnes Premium',
		907896723,
		'ventas@carnespremium.com',
		'San Mart�n de Porres',
		1
	),
	(
		'Verduras Frescas',
		940743649,
		'soporte@verdurasfrescas.com',
		'El Agustino',
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
		Fecha_Vencimiento_Insumo
	)
VALUES
	(
		1,
		1,
		'Queso Mozzarella',
		'Queso fresco para derretir.',
		'Kg.',
		20.00,
		30,
		1,
		'2024-12-24'
	),
	(
		1,
		1,
		'Leche de Cabra',
		'Mezcla en equilibrio de prote�nas, grasas, carbohidratos, sales y otros componentes.',
		'Lt.',
		20.00,
		30,
		1,
		'2024-12-24'
	),
	(
		2,
		2,
		'Pepperoni',
		'Caracter�sticamente suave, ligeramente ahumado y de color rojo brillante.',
		'Kg.',
		20.00,
		30,
		1,
		'2024-12-24'
	),
	(
		2,
		2,
		'Jam�n Serrano',
		'Obtenido a partir de la salaz�n y secado al aire de las patas traseras del cerdo.',
		'Kg.',
		20.00,
		30,
		1,
		'2024-12-24'
	),
	(
		3,
		3,
		'Aceitunas Negras',
		'Contiene importantes cantidades de vitaminas A y E, que son altamente recomendables para el sistema inmunol�gico.',
		'Kg.',
		20.00,
		30,
		1,
		'2024-12-24'
	),
	(
		3,
		3,
		'Cebolla Caramelizada',
		'Oxidaci�n del az�car de la cebolla por medios culinarios.',
		'Kg.',
		20.00,
		30,
		1,
		'2024-12-24'
	),
	(
		4,
		2,
		'Salsa de Tomate',
		'Salsa para pizza.',
		'Lt.',
		20.00,
		30,
		1,
		'2024-12-24'
	),
	(
		4,
		2,
		'Salsa de Ajo',
		'Salsa picante, cuya intensidad de sabor a ajo depende de la cantidad de ajo utilizado.',
		'Lt.',
		20.00,
		30,
		1,
		'2024-12-24'
	);

GO