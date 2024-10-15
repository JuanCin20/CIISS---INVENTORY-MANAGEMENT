--EJERCICIOS
----CONSULTA EMPLEANDO MÁS DE UNA TABLA
SELECT
	TU.ID_Usuario,
	TTU.ID_Tipo_Usuario,
	TTU.Nombre_Tipo_Usuario,
	TU.Nombre_Usuario,
	TU.Apellido_Usuario,
	TU.E_Mail_Usuario,
	TU.Password_Usuario,
	TU.Reestablecer_Password_Usuario,
	TU.Ruta_Imagen_Usuario,
	TU.Nombre_Imagen_Usuario
FROM
	Tabla_Usuario TU
	INNER JOIN Tabla_Tipo_Usuario TTU ON TU.ID_Tipo_Usuario = TTU.ID_Tipo_Usuario;

SELECT
	TI.ID_Insumo,
	TCI.ID_Categoria_Insumo,
	TCI.Nombre_Categoria_Insumo,
	TPI.ID_Proveedor_Insumo,
	TPI.Nombre_Proveedor_Insumo,
	TI.Nombre_Insumo,
	TI.Descripcion_Insumo,
	TI.Unidad_Medida_Insumo,
	TI.Precio_Insumo,
	TI.Stock_Insumo,
	TI.Estado_Insumo,
	TI.Fecha_Vencimiento_Insumo,
	TI.Ruta_Imagen_Insumo,
	TI.Nombre_Imagen_Insumo
FROM
	Tabla_Insumo TI
	INNER JOIN Tabla_Categoria_Insumo TCI ON TI.ID_Categoria_Insumo = TCI.ID_Categoria_Insumo
	INNER JOIN Tabla_Proveedor_Insumo TPI ON TI.ID_Proveedor_Insumo = TPI.ID_Proveedor_Insumo;

----PROCEDIMIENTOS ALMACENADOS
GO
	CREATE
	OR ALTER PROCEDURE SP_USER_CREATE (
		@ID_Tipo_Usuario INT,
		@Nombre_Usuario VARCHAR (50),
		@Apellido_Usuario VARCHAR (50),
		@E_Mail_Usuario VARCHAR (30),
		@Password_Usuario VARCHAR (150),
		@Message VARCHAR (500) OUTPUT,
		@Result INT OUTPUT
	) AS BEGIN
SET
	@Result = 0 IF NOT EXISTS (
		SELECT
			*
		FROM
			Tabla_Usuario
		WHERE
			E_Mail_Usuario = @E_Mail_Usuario
	) BEGIN
INSERT INTO
	Tabla_Usuario (
		ID_Tipo_Usuario,
		Nombre_Usuario,
		Apellido_Usuario,
		E_Mail_Usuario,
		Password_Usuario
	)
VALUES
	(
		@ID_Tipo_Usuario,
		@Nombre_Usuario,
		@Apellido_Usuario,
		@E_Mail_Usuario,
		@Password_Usuario
	)
SET
	@Result = SCOPE_IDENTITY()
END;

ELSE
SET
	@Message = 'El Correo Electrónico del Usuario ya se Encuentra Registrado'
END;

GO
	CREATE
	OR ALTER PROCEDURE SP_USER_UPDATE (
		@ID_Usuario INT,
		@ID_Tipo_Usuario INT,
		@Nombre_Usuario VARCHAR (50),
		@Apellido_Usuario VARCHAR (50),
		@E_Mail_Usuario VARCHAR (30),
		@Message VARCHAR (500) OUTPUT,
		@Result INT OUTPUT
	) AS BEGIN
SET
	@Result = 0 IF NOT EXISTS (
		SELECT
			*
		FROM
			Tabla_Usuario
		WHERE
			E_Mail_Usuario = @E_Mail_Usuario
			AND ID_Usuario != @ID_Usuario
	) BEGIN
UPDATE
	TOP (1) Tabla_Usuario
SET
	ID_Tipo_Usuario = @ID_Tipo_Usuario,
	Nombre_Usuario = @Nombre_Usuario,
	Apellido_Usuario = @Apellido_Usuario,
	E_Mail_Usuario = @E_Mail_Usuario
WHERE
	ID_Usuario = @ID_Usuario
SET
	@Result = 1
END;

ELSE
SET
	@Message = 'El Correo Electrónico del Usuario ya se Encuentra Registrado'
END;

GO
	CREATE
	OR ALTER PROCEDURE SP_USER_DELETE (
		@ID_Usuario INT,
		@Message VARCHAR (500) OUTPUT,
		@Result INT OUTPUT
	) AS BEGIN
SET
	@Result = 0 IF NOT EXISTS (
		SELECT
			*
		FROM
			Tabla_Movimiento_Inventario TMI
			INNER JOIN Tabla_Usuario TU ON TMI.ID_Usuario = TU.ID_Usuario
		WHERE
			TMI.ID_Usuario = @ID_Usuario
	) BEGIN DELETE TOP (1)
FROM
	Tabla_Usuario
WHERE
	ID_Usuario = @ID_Usuario
SET
	@Result = 1
END;

ELSE
SET
	@Message = 'El ID del Usuario se Encuentra Relacionado a un Movimiento dentro del Inventario'
END;

----UPDATE Tabla_Usuario SET Ruta_Imagen_Usuario = @Ruta_Imagen_Usuario, Nombre_Imagen_Usuario = @Nombre_Imagen_Usuario WHERE ID_Usuario = @ID_Usuario;
GO
	CREATE
	OR ALTER PROCEDURE SP_CATEGORY_CREATE (
		@Nombre_Categoria_Insumo VARCHAR (50),
		@Descripcion_Categoria_Insumo TEXT,
		@Estado_Categoria_Insumo BIT,
		@Message VARCHAR (500) OUTPUT,
		@Result INT OUTPUT
	) AS BEGIN
SET
	@Result = 0 IF NOT EXISTS (
		SELECT
			*
		FROM
			Tabla_Categoria_Insumo
		WHERE
			Nombre_Categoria_Insumo = @Nombre_Categoria_Insumo
	) BEGIN
INSERT INTO
	Tabla_Categoria_Insumo (
		Nombre_Categoria_Insumo,
		Descripcion_Categoria_Insumo,
		Estado_Categoria_Insumo
	)
VALUES
	(
		@Nombre_Categoria_Insumo,
		@Descripcion_Categoria_Insumo,
		@Estado_Categoria_Insumo
	)
SET
	@Result = SCOPE_IDENTITY()
END;

ELSE
SET
	@Message = 'El Nombre de la Categoría del Insumo ya se Encuentra Registrado'
END;

GO
	CREATE
	OR ALTER PROCEDURE SP_CATEGORY_UPDATE (
		@ID_Categoria_Insumo INT,
		@Nombre_Categoria_Insumo VARCHAR (50),
		@Descripcion_Categoria_Insumo TEXT,
		@Estado_Categoria_Insumo BIT,
		@Message VARCHAR (500) OUTPUT,
		@Result INT OUTPUT
	) AS BEGIN
SET
	@Result = 0 IF NOT EXISTS (
		SELECT
			*
		FROM
			Tabla_Categoria_Insumo
		WHERE
			Nombre_Categoria_Insumo = @Nombre_Categoria_Insumo
			AND ID_Categoria_Insumo != @ID_Categoria_Insumo
	) BEGIN
UPDATE
	TOP (1) Tabla_Categoria_Insumo
SET
	Nombre_Categoria_Insumo = @Nombre_Categoria_Insumo,
	Descripcion_Categoria_Insumo = @Descripcion_Categoria_Insumo,
	Estado_Categoria_Insumo = @Estado_Categoria_Insumo
WHERE
	ID_Categoria_Insumo = @ID_Categoria_Insumo
SET
	@Result = 1
END;

ELSE
SET
	@Message = 'El Nombre de la Categoría del Insumo ya se Encuentra Registrado'
END;

GO
	CREATE
	OR ALTER PROCEDURE SP_CATEGORY_DELETE (
		@ID_Categoria_Insumo INT,
		@Message VARCHAR (500) OUTPUT,
		@Result INT OUTPUT
	) AS BEGIN
SET
	@Result = 0 IF NOT EXISTS (
		SELECT
			*
		FROM
			Tabla_Insumo TI
			INNER JOIN Tabla_Categoria_Insumo TCI ON TI.ID_Categoria_Insumo = TCI.ID_Categoria_Insumo
		WHERE
			TI.ID_Categoria_Insumo = @ID_Categoria_Insumo
	) BEGIN DELETE TOP (1)
FROM
	Tabla_Categoria_Insumo
WHERE
	ID_Categoria_Insumo = @ID_Categoria_Insumo
SET
	@Result = 1
END;

ELSE
SET
	@Message = 'El Nombre de la Categoría del Insumo se Encuentra Relacionado a un Insumo'
END;

GO
	CREATE
	OR ALTER PROCEDURE SP_SUPPLIER_CREATE (
		@Nombre_Proveedor_Insumo VARCHAR (50),
		@Telefono_Proveedor_Insumo INT,
		@E_Mail_Proveedor_Insumo VARCHAR (30),
		@Direccion_Proveedor_Insumo VARCHAR (50),
		@Estado_Proveedor_Insumo BIT,
		@Message VARCHAR (500) OUTPUT,
		@Result INT OUTPUT
	) AS BEGIN
SET
	@Result = 0 IF NOT EXISTS (
		SELECT
			*
		FROM
			Tabla_Proveedor_Insumo
		WHERE
			Nombre_Proveedor_Insumo = @Nombre_Proveedor_Insumo
	) BEGIN
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
		@Nombre_Proveedor_Insumo,
		@Telefono_Proveedor_Insumo,
		@E_Mail_Proveedor_Insumo,
		@Direccion_Proveedor_Insumo,
		@Estado_Proveedor_Insumo
	)
SET
	@Result = SCOPE_IDENTITY()
END;

ELSE
SET
	@Message = 'El Nombre del Proveedor del Insumo ya se Encuentra Registrado'
END;

GO
	CREATE
	OR ALTER PROCEDURE SP_SUPPLIER_UPDATE (
		@ID_Proveedor_Insumo INT,
		@Nombre_Proveedor_Insumo VARCHAR (50),
		@Telefono_Proveedor_Insumo INT,
		@E_Mail_Proveedor_Insumo VARCHAR (30),
		@Direccion_Proveedor_Insumo VARCHAR (50),
		@Estado_Proveedor_Insumo BIT,
		@Message VARCHAR (500) OUTPUT,
		@Result INT OUTPUT
	) AS BEGIN
SET
	@Result = 0 IF NOT EXISTS (
		SELECT
			*
		FROM
			Tabla_Proveedor_Insumo
		WHERE
			Nombre_Proveedor_Insumo = @Nombre_Proveedor_Insumo
			AND ID_Proveedor_Insumo != @ID_Proveedor_Insumo
	) BEGIN
UPDATE
	TOP (1) Tabla_Proveedor_Insumo
SET
	Nombre_Proveedor_Insumo = @Nombre_Proveedor_Insumo,
	Telefono_Proveedor_Insumo = @Telefono_Proveedor_Insumo,
	E_Mail_Proveedor_Insumo = @E_Mail_Proveedor_Insumo,
	Direccion_Proveedor_Insumo = @Direccion_Proveedor_Insumo,
	Estado_Proveedor_Insumo = @Estado_Proveedor_Insumo
WHERE
	ID_Proveedor_Insumo = @ID_Proveedor_Insumo
SET
	@Result = 1
END;

ELSE
SET
	@Message = 'El Nombre del Proveedor del Insumo ya se Encuentra Registrado'
END;

GO
	CREATE
	OR ALTER PROCEDURE SP_SUPPLIER_DELETE (
		@ID_Proveedor_Insumo INT,
		@Message VARCHAR (500) OUTPUT,
		@Result INT OUTPUT
	) AS BEGIN
SET
	@Result = 0 IF NOT EXISTS (
		SELECT
			*
		FROM
			Tabla_Insumo TI
			INNER JOIN Tabla_Proveedor_Insumo TPI ON TI.ID_Proveedor_Insumo = TPI.ID_Proveedor_Insumo
		WHERE
			TI.ID_Proveedor_Insumo = @ID_Proveedor_Insumo
	) BEGIN DELETE TOP (1)
FROM
	Tabla_Proveedor_Insumo
WHERE
	ID_Proveedor_Insumo = @ID_Proveedor_Insumo
SET
	@Result = 1
END;

ELSE
SET
	@Message = 'El Nombre del Proveedor del Insumo se Encuentra Relacionado a un Insumo'
END;

GO
	CREATE
	OR ALTER PROCEDURE SP_SUPPLY_CREATE (
		@ID_Categoria_Insumo INT,
		@ID_Proveedor_Insumo INT,
		@Nombre_Insumo VARCHAR (50),
		@Descripcion_Insumo TEXT,
		@Unidad_Medida_Insumo VARCHAR (50),
		@Precio_Insumo DECIMAL (10, 2),
		@Stock_Insumo INT,
		@Estado_Insumo BIT,
		@Fecha_Vencimiento_Insumo DATE,
		@Message VARCHAR (500) OUTPUT,
		@Result INT OUTPUT
	) AS BEGIN
SET
	@Result = 0 IF NOT EXISTS (
		SELECT
			*
		FROM
			Tabla_Insumo
		WHERE
			Nombre_Insumo = @Nombre_Insumo
	) BEGIN
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
		@ID_Categoria_Insumo,
		@ID_Proveedor_Insumo,
		@Nombre_Insumo,
		@Descripcion_Insumo,
		@Unidad_Medida_Insumo,
		@Precio_Insumo,
		@Stock_Insumo,
		@Estado_Insumo,
		@Fecha_Vencimiento_Insumo
	)
SET
	@Result = SCOPE_IDENTITY()
END;

ELSE
SET
	@Message = 'El Nombre del Insumo ya se Encuentra Registrado'
END;

GO
	CREATE
	OR ALTER PROCEDURE SP_SUPPLY_UPDATE (
		@ID_Insumo INT,
		@ID_Categoria_Insumo INT,
		@ID_Proveedor_Insumo INT,
		@Nombre_Insumo VARCHAR (50),
		@Descripcion_Insumo TEXT,
		@Unidad_Medida_Insumo VARCHAR (50),
		@Precio_Insumo DECIMAL (10, 2),
		@Stock_Insumo INT,
		@Estado_Insumo BIT,
		@Fecha_Vencimiento_Insumo DATE,
		@Message VARCHAR (500) OUTPUT,
		@Result INT OUTPUT
	) AS BEGIN
SET
	@Result = 0 IF NOT EXISTS (
		SELECT
			*
		FROM
			Tabla_Insumo
		WHERE
			Nombre_Insumo = @Nombre_Insumo
			AND ID_Insumo != @ID_Insumo
	) BEGIN
UPDATE
	TOP (1) Tabla_Insumo
SET
	ID_Categoria_Insumo = @ID_Categoria_Insumo,
	ID_Proveedor_Insumo = @ID_Proveedor_Insumo,
	Nombre_Insumo = @Nombre_Insumo,
	Descripcion_Insumo = @Descripcion_Insumo,
	Unidad_Medida_Insumo = @Unidad_Medida_Insumo,
	Precio_Insumo = @Precio_Insumo,
	Stock_Insumo = @Stock_Insumo,
	Estado_Insumo = @Estado_Insumo,
	Fecha_Vencimiento_Insumo = @Fecha_Vencimiento_Insumo
WHERE
	ID_Insumo = @ID_Insumo
SET
	@Result = 1
END;

ELSE
SET
	@Message = 'El Nombre del Insumo ya se Encuentra Registrado'
END;

GO
	CREATE
	OR ALTER PROCEDURE SP_SUPPLY_DELETE (
		@ID_Insumo INT,
		@Message VARCHAR (500) OUTPUT,
		@Result INT OUTPUT
	) AS BEGIN
SET
	@Result = 0 IF NOT EXISTS (
		SELECT
			*
		FROM
			Tabla_Movimiento_Inventario TMI
			INNER JOIN Tabla_Insumo TI ON TMI.ID_Insumo = TI.ID_Insumo
		WHERE
			TMI.ID_Insumo = @ID_Insumo
	) BEGIN DELETE TOP (1)
FROM
	Tabla_Insumo
WHERE
	ID_Insumo = @ID_Insumo
SET
	@Result = 1
END;

ELSE
SET
	@Message = 'El ID del Insumo se Encuentra Relacionado a un Movimiento dentro del Inventario'
END;

GO
	----UPDATE Tabla_Insumo SET Ruta_Imagen_Insumo = @Ruta_Imagen_Insumo, Nombre_Imagen_Insumo = @Nombre_Imagen_Insumo WHERE ID_Insumo = @ID_Insumo;