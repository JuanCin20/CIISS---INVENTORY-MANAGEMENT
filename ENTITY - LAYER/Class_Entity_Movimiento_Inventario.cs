namespace ENTITY___LAYER
{
    public class Class_Entity_Movimiento_Inventario
    {
        public int ID_Movimiento_Inventario { get; set; }
        public Class_Entity_Insumo Object_ID_Insumo { get; set; }
        public string Tipo_Movimiento_Inventario { get; set; }
        public int Cantidad_Movimiento_Inventario { get; set; }
        public Class_Entity_Usuario Object_ID_Usuario { get; set; }
    }
}