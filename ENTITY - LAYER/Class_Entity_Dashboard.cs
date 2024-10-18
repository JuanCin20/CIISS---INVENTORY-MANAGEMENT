namespace ENTITY___LAYER
{
    public class Class_Entity_Dashboard
    {
        public int ID_Movimiento_Inventario { get; set; }
        public string Tipo_Movimiento_Inventario { get; set; }
        public string Nombre_Insumo { get; set; }
        public int Cantidad_Movimiento_Inventario { get; set; }
        public decimal Precio_Insumo { get; set; }
        public decimal Total_Transaction { get; set; }
        public string Fecha_Movimiento_Inventario { get; set; }
        public string Usuario_Transaction { get; set; }

        /**/

        public int Tabla_Movimiento_Inventario { get; set; }
        public int Tabla_Categoria_Insumo { get; set; }
        public int Tabla_Proveedor_Insumo { get; set; }
        public int Tabla_Insumo { get; set; }
    }
}