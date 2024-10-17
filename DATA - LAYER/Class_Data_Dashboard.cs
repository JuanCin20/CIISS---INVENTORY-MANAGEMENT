using System.Data.SqlClient;
using System.Data;
using System;
using ENTITY___LAYER;

namespace DATA___LAYER
{
    public class Class_Data_Dashboard
    {
        public Class_Entity_Dashboard Class_Data_See_Dashboard()
        {
            Class_Entity_Dashboard Obj_Class_Entity_Dashboard = new Class_Entity_Dashboard();
            try
            {
                using (SqlConnection Obj_SqlConnection = new SqlConnection(Class_Data_Connection.Connection_String))
                {
                    SqlCommand Obj_SqlCommand = new SqlCommand("SP_DASHBOARD_REPORT", Obj_SqlConnection);
                    Obj_SqlCommand.CommandType = CommandType.StoredProcedure;

                    Obj_SqlConnection.Open();

                    using (SqlDataReader Obj_SqlDataReader = Obj_SqlCommand.ExecuteReader())
                    {
                        while (Obj_SqlDataReader.Read())
                        {
                            Obj_Class_Entity_Dashboard = new Class_Entity_Dashboard()
                            {
                                Cantidad_Movimiento_Inventario = Convert.ToInt32(Obj_SqlDataReader["Cantidad_Movimiento_Inventario"]),
                                Tabla_Categoria_Insumo = Convert.ToInt32(Obj_SqlDataReader["Tabla_Categoria_Insumo"]),
                                Tabla_Proveedor_Insumo = Convert.ToInt32(Obj_SqlDataReader["Tabla_Proveedor_Insumo"]),
                                Tabla_Insumo = Convert.ToInt32(Obj_SqlDataReader["Tabla_Insumo"])
                            };
                        }
                    }
                }
            }
            catch (Exception Error)
            {
                Console.WriteLine(Error.Message);
                Obj_Class_Entity_Dashboard = new Class_Entity_Dashboard();
            }
            return Obj_Class_Entity_Dashboard;
        }
    }
}