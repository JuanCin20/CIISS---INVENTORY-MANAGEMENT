using System.Collections.Generic;
using DATA___LAYER;
using ENTITY___LAYER;

namespace BUSINESS___LAYER
{
    public class Class_Business_Dashboard
    {
        private Class_Data_Dashboard Obj_Class_Data_Dashboard = new Class_Data_Dashboard();

        public List<Class_Entity_Dashboard> Class_Business_Dashboard_Listar(string Initial_Fecha_Movimiento_Inventario, string Final_Fecha_Movimiento_Inventario, string ID_Movimiento_Inventario)
        {
            return Obj_Class_Data_Dashboard.Class_Data_Dashboard_Listar(Initial_Fecha_Movimiento_Inventario, Final_Fecha_Movimiento_Inventario, ID_Movimiento_Inventario);
        }

        public Class_Entity_Dashboard Class_Business_Dashboard_Card()
        {
            return Obj_Class_Data_Dashboard.Class_Data_Dashboard_Card();
        }
    }
}