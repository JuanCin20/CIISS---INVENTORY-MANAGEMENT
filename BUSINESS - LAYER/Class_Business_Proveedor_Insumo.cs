using System.Collections.Generic;
using DATA___LAYER;
using ENTITY___LAYER;

namespace BUSINESS___LAYER
{
    public class Class_Business_Proveedor_Insumo
    {
        private Class_Data_Proveedor_Insumo Obj_Class_Data_Proveedor_Insumo = new Class_Data_Proveedor_Insumo();

        public List<Class_Entity_Proveedor_Insumo> Class_Business_Proveedor_Insumo_Listar()
        {
            return Obj_Class_Data_Proveedor_Insumo.Class_Data_Proveedor_Insumo_Listar();
        }

        public int Class_Business_Proveedor_Insumo_Registrar(Class_Entity_Proveedor_Insumo Obj_Class_Entity_Proveedor_Insumo, out string Message)
        {
            Message = string.Empty;
            if (string.IsNullOrEmpty(Obj_Class_Entity_Proveedor_Insumo.Nombre_Proveedor_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Proveedor_Insumo.Nombre_Proveedor_Insumo))
            {
                Message = "Error: Nombre_Proveedor_Insumo";
            }
            else
            {
                if (string.IsNullOrEmpty(Obj_Class_Entity_Proveedor_Insumo.E_Mail_Proveedor_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Proveedor_Insumo.E_Mail_Proveedor_Insumo))
                {
                    Message = "Error: Nombre_Proveedor_Insumo";
                }
                else
                {
                    if (string.IsNullOrEmpty(Obj_Class_Entity_Proveedor_Insumo.Direccion_Proveedor_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Proveedor_Insumo.Direccion_Proveedor_Insumo))
                    {
                        Message = "Error: Nombre_Proveedor_Insumo";
                    }
                }
            }

            if (string.IsNullOrEmpty(Message))
            {
                return Obj_Class_Data_Proveedor_Insumo.Class_Data_Proveedor_Insumo_Registrar(Obj_Class_Entity_Proveedor_Insumo, out Message);
            }
            else
            {
                return 0;
            }
        }

        public bool Class_Business_Proveedor_Insumo_Editar(Class_Entity_Proveedor_Insumo Obj_Class_Entity_Proveedor_Insumo, out string Message)
        {
            Message = string.Empty;
            if (string.IsNullOrEmpty(Obj_Class_Entity_Proveedor_Insumo.Nombre_Proveedor_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Proveedor_Insumo.Nombre_Proveedor_Insumo))
            {
                Message = "Error: Nombre_Proveedor_Insumo";
            }
            else
            {
                if (string.IsNullOrEmpty(Obj_Class_Entity_Proveedor_Insumo.E_Mail_Proveedor_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Proveedor_Insumo.E_Mail_Proveedor_Insumo))
                {
                    Message = "Error: E_Mail_Proveedor_Insumo";
                }
                else
                {
                    if (string.IsNullOrEmpty(Obj_Class_Entity_Proveedor_Insumo.Direccion_Proveedor_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Proveedor_Insumo.Direccion_Proveedor_Insumo))
                    {
                        Message = "Error: Direccion_Proveedor_Insumo";
                    }
                }
            }

            if (string.IsNullOrEmpty(Message))
            {
                return Obj_Class_Data_Proveedor_Insumo.Class_Data_Proveedor_Insumo_Editar(Obj_Class_Entity_Proveedor_Insumo, out Message);
            }
            else
            {
                return false;
            }
        }

        public bool Class_Business_Proveedor_Insumo_Eliminar(int ID_Proveedor_Insumo, out string Message)
        {
            return Obj_Class_Data_Proveedor_Insumo.Class_Data_Proveedor_Insumo_Eliminar(ID_Proveedor_Insumo, out Message);
        }
    }
}