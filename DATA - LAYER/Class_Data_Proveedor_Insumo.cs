using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System;
using ENTITY___LAYER;

namespace DATA___LAYER
{
    public class Class_Data_Proveedor_Insumo
    {
        public List<Class_Entity_Proveedor_Insumo> Class_Data_Proveedor_Insumo_Listar()
        {
            List<Class_Entity_Proveedor_Insumo> Obj_List = new List<Class_Entity_Proveedor_Insumo>();
            try
            {
                using (SqlConnection Obj_SqlConnection = new SqlConnection(Class_Data_Connection.Connection_String))
                {
                    string SQL_Server_Query_String = "SELECT ID_Proveedor_Insumo, Nombre_Proveedor_Insumo, Telefono_Proveedor_Insumo, E_Mail_Proveedor_Insumo, Direccion_Proveedor_Insumo, Estado_Proveedor_Insumo FROM Tabla_Proveedor_Insumo;";

                    SqlCommand Obj_SqlCommand = new SqlCommand(SQL_Server_Query_String, Obj_SqlConnection);
                    Obj_SqlCommand.CommandType = CommandType.Text;

                    Obj_SqlConnection.Open();

                    using (SqlDataReader Obj_SqlDataReader = Obj_SqlCommand.ExecuteReader())
                    {
                        while (Obj_SqlDataReader.Read())
                        {
                            Obj_List.Add(new Class_Entity_Proveedor_Insumo()
                            {
                                ID_Proveedor_Insumo = Convert.ToInt32(Obj_SqlDataReader["ID_Proveedor_Insumo"]),
                                Nombre_Proveedor_Insumo = Obj_SqlDataReader["Nombre_Proveedor_Insumo"].ToString(),
                                Telefono_Proveedor_Insumo = Convert.ToInt32(Obj_SqlDataReader["Telefono_Proveedor_Insumo"]),
                                E_Mail_Proveedor_Insumo = Obj_SqlDataReader["E_Mail_Proveedor_Insumo"].ToString(),
                                Direccion_Proveedor_Insumo = Obj_SqlDataReader["Direccion_Proveedor_Insumo"].ToString(),
                                Estado_Proveedor_Insumo = Convert.ToBoolean(Obj_SqlDataReader["Estado_Proveedor_Insumo"])
                            });
                        }
                    }
                }
            }
            catch (Exception Error)
            {
                Obj_List = new List<Class_Entity_Proveedor_Insumo>();
                Console.WriteLine(Error.Message);
            }
            return Obj_List;
        }

        public int Class_Data_Proveedor_Insumo_Registrar(Class_Entity_Proveedor_Insumo Obj_Class_Entity_Proveedor_Insumo, out string Message)
        {
            int ID_Auto_Generated = 0;
            Message = string.Empty;
            try
            {
                using (SqlConnection Obj_SqlConnection = new SqlConnection(Class_Data_Connection.Connection_String))
                {
                    SqlCommand Obj_SqlCommand = new SqlCommand("SP_SUPPLIER_CREATE", Obj_SqlConnection);
                    Obj_SqlCommand.Parameters.AddWithValue("Nombre_Proveedor_Insumo", Obj_Class_Entity_Proveedor_Insumo.Nombre_Proveedor_Insumo);
                    Obj_SqlCommand.Parameters.AddWithValue("Telefono_Proveedor_Insumo", Obj_Class_Entity_Proveedor_Insumo.Telefono_Proveedor_Insumo);
                    Obj_SqlCommand.Parameters.AddWithValue("E_Mail_Proveedor_Insumo", Obj_Class_Entity_Proveedor_Insumo.E_Mail_Proveedor_Insumo);
                    Obj_SqlCommand.Parameters.AddWithValue("Direccion_Proveedor_Insumo", Obj_Class_Entity_Proveedor_Insumo.Direccion_Proveedor_Insumo);
                    Obj_SqlCommand.Parameters.AddWithValue("Estado_Proveedor_Insumo", Obj_Class_Entity_Proveedor_Insumo.Estado_Proveedor_Insumo);
                    Obj_SqlCommand.Parameters.Add("Message", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    Obj_SqlCommand.Parameters.Add("Result", SqlDbType.Int).Direction = ParameterDirection.Output;
                    Obj_SqlCommand.CommandType = CommandType.StoredProcedure;

                    Obj_SqlConnection.Open();

                    Obj_SqlCommand.ExecuteNonQuery();

                    Message = Obj_SqlCommand.Parameters["Message"].Value.ToString();
                    ID_Auto_Generated = Convert.ToInt32(Obj_SqlCommand.Parameters["Result"].Value);
                }
            }
            catch (Exception Error)
            {
                Console.WriteLine(Error.Message);
                Message = Error.Message;
                ID_Auto_Generated = 0;
            }
            return ID_Auto_Generated;
        }

        public bool Class_Data_Proveedor_Insumo_Editar(Class_Entity_Proveedor_Insumo Obj_Class_Entity_Proveedor_Insumo, out string Message)
        {
            bool Result = false;
            Message = string.Empty;
            try
            {
                using (SqlConnection Obj_SqlConnection = new SqlConnection(Class_Data_Connection.Connection_String))
                {
                    SqlCommand Obj_SqlCommand = new SqlCommand("SP_SUPPLIER_UPDATE", Obj_SqlConnection);
                    Obj_SqlCommand.Parameters.AddWithValue("ID_Proveedor_Insumo", Obj_Class_Entity_Proveedor_Insumo.ID_Proveedor_Insumo);
                    Obj_SqlCommand.Parameters.AddWithValue("Nombre_Proveedor_Insumo", Obj_Class_Entity_Proveedor_Insumo.Nombre_Proveedor_Insumo);
                    Obj_SqlCommand.Parameters.AddWithValue("Telefono_Proveedor_Insumo", Obj_Class_Entity_Proveedor_Insumo.Telefono_Proveedor_Insumo);
                    Obj_SqlCommand.Parameters.AddWithValue("E_Mail_Proveedor_Insumo", Obj_Class_Entity_Proveedor_Insumo.E_Mail_Proveedor_Insumo);
                    Obj_SqlCommand.Parameters.AddWithValue("Direccion_Proveedor_Insumo", Obj_Class_Entity_Proveedor_Insumo.Direccion_Proveedor_Insumo);
                    Obj_SqlCommand.Parameters.AddWithValue("Estado_Proveedor_Insumo", Obj_Class_Entity_Proveedor_Insumo.Estado_Proveedor_Insumo);
                    Obj_SqlCommand.Parameters.Add("Message", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    Obj_SqlCommand.Parameters.Add("Result", SqlDbType.Int).Direction = ParameterDirection.Output;
                    Obj_SqlCommand.CommandType = CommandType.StoredProcedure;

                    Obj_SqlConnection.Open();

                    Obj_SqlCommand.ExecuteNonQuery();

                    Message = Obj_SqlCommand.Parameters["Message"].Value.ToString();
                    Result = Convert.ToBoolean(Obj_SqlCommand.Parameters["Result"].Value);
                }
            }
            catch (Exception Error)
            {
                Console.WriteLine(Error.Message);
                Message = Error.Message;
                Result = false;
            }
            return Result;
        }

        public bool Class_Data_Proveedor_Insumo_Eliminar(int ID_Proveedor_Insumo, out string Message)
        {
            bool Result = false;
            Message = string.Empty;
            try
            {
                using (SqlConnection Obj_SqlConnection = new SqlConnection(Class_Data_Connection.Connection_String))
                {
                    SqlCommand Obj_SqlCommand = new SqlCommand("SP_SUPPLIER_DELETE", Obj_SqlConnection);
                    Obj_SqlCommand.Parameters.AddWithValue("ID_Proveedor_Insumo", ID_Proveedor_Insumo);
                    Obj_SqlCommand.Parameters.Add("Message", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    Obj_SqlCommand.Parameters.Add("Result", SqlDbType.Int).Direction = ParameterDirection.Output;
                    Obj_SqlCommand.CommandType = CommandType.StoredProcedure;

                    Obj_SqlConnection.Open();

                    Obj_SqlCommand.ExecuteNonQuery();

                    Message = Obj_SqlCommand.Parameters["Message"].Value.ToString();
                    Result = Convert.ToBoolean(Obj_SqlCommand.Parameters["Result"].Value);
                }
            }
            catch (Exception Error)
            {
                Console.WriteLine(Error.Message);
                Message = Error.Message;
                Result = false;
            }
            return Result;
        }
    }
}