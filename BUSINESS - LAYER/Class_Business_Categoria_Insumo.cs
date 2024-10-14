using System.Collections.Generic;
using DATA___LAYER;
using ENTITY___LAYER;

namespace BUSINESS___LAYER
{
    public class Class_Business_Categoria_Insumo
    {
        private Class_Data_Categoria_Insumo Obj_Class_Data_Categoria_Insumo = new Class_Data_Categoria_Insumo();

        public List<Class_Entity_Categoria_Insumo> Class_Business_Categoria_Insumo_Listar()
        {
            return Obj_Class_Data_Categoria_Insumo.Class_Data_Categoria_Insumo_Listar();
        }

        public int Class_Business_Categoria_Insumo_Registrar(Class_Entity_Categoria_Insumo Obj_Class_Entity_Categoria_Insumo, out string Message)
        {
            Message = string.Empty;
            if (string.IsNullOrEmpty(Obj_Class_Entity_Categoria_Insumo.Nombre_Categoria_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Categoria_Insumo.Nombre_Categoria_Insumo))
            {
                Message = "Error: Nombre_Categoria_Insumo";
            }
            else
            {
                if (string.IsNullOrEmpty(Obj_Class_Entity_Categoria_Insumo.Descripcion_Categoria_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Categoria_Insumo.Descripcion_Categoria_Insumo))
                {
                    Message = "Error: Descripcion_Categoria_Insumo";
                }
            }

            if (string.IsNullOrEmpty(Message))
            {
                return Obj_Class_Data_Categoria_Insumo.Class_Data_Categoria_Insumo_Registrar(Obj_Class_Entity_Categoria_Insumo, out Message);
            }
            else
            {
                return 0;
            }
        }

        public bool Class_Business_Categoria_Insumo_Editar(Class_Entity_Categoria_Insumo Obj_Class_Entity_Categoria_Insumo, out string Message)
        {
            Message = string.Empty;
            if (string.IsNullOrEmpty(Obj_Class_Entity_Categoria_Insumo.Nombre_Categoria_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Categoria_Insumo.Nombre_Categoria_Insumo))
            {
                Message = "Error: Nombre_Categoria_Insumo";
            }
            else
            {
                if (string.IsNullOrEmpty(Obj_Class_Entity_Categoria_Insumo.Descripcion_Categoria_Insumo) || string.IsNullOrWhiteSpace(Obj_Class_Entity_Categoria_Insumo.Descripcion_Categoria_Insumo))
                {
                    Message = "Error: Descripcion_Categoria_Insumo";
                }
            }

            if (string.IsNullOrEmpty(Message))
            {
                return Obj_Class_Data_Categoria_Insumo.Class_Data_Categoria_Insumo_Editar(Obj_Class_Entity_Categoria_Insumo, out Message);
            }
            else
            {
                return false;
            }
        }

        public bool Class_Business_Categoria_Insumo_Eliminar(int ID_Categoria_Insumo, out string Message)
        {
            return Obj_Class_Data_Categoria_Insumo.Class_Data_Categoria_Insumo_Eliminar(ID_Categoria_Insumo, out Message);
        }
    }
}